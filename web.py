#!/usr/bin/env python
# encoding: utf-8

"""
web.py - Web viewr for willie-lumberjack module.
Copyright 2013, Timothy Lee <marlboromoo@gmail.com>
Licensed under the MIT License.
"""

import sys
import json
import urllib
import logging
import re
import os
import bottle
from bottle.ext import redis
from redis import Redis
from socketio import socketio_manage
from socketio.namespace import BaseNamespace
from gevent import monkey
import yapdi

from lumberjack import str_time, str_date, CHANNELS
import config

###############################################################################
# Setup the APP
###############################################################################

logging.basicConfig(
            filename=config.LOGFILE,
            format='%(asctime)s - %(levelname)s - %(message)s',
            #datefmt='%Y-%M-%d %H:%M:%S',
            level=logging.DEBUG,
)

app = bottle.Bottle()
plugin = redis.RedisPlugin(
    host = config.REDIS_HOST,
    port = int(config.REDIS_PORT),
    database = int(config.REDIS_DBID),
)
app.install(plugin)

###############################################################################
# Helper function
###############################################################################

def get_redis_from_app(app):
    attr = 'redisdb'
    for p in app.plugins:
        if hasattr(p, attr):
            return Redis(connection_pool=getattr(p, attr))
    return None

def channel_name(channel):
    """Get IRC channel name.

    :channel: channel name without #
    :returns: channel name with #

    """
    return "#%s" % channel if not channel.startswith('#') else channel

def get_logs(rdb, channel, date):
    """Get logs with  specify date.

    :rdb: redis db instance
    :channel: IRC channel name without #
    :date: string represend the date
    :returns: list(logs)

    """
    channel, date = channel_name(channel), str_date(date)
    date = str_date(date)
    key = "%s:%s" % (channel, date)
    return rdb.lrange(key, 0, -1)

def get_channels(rdb):
    """get IRC channel names without #

    :rdb: redis db instance
    :returns: list(channels)

    """
    return [ c.lstrip('#') for c in rdb.lrange(CHANNELS, 0, -1)]

def irc_row(str_json):
    """Convert IRC log from JSON to dict.

    :str_json: JSON data
    :returns: dict(data)

    """
    data = json.loads(str_json)
    return dict(
        time=str_time(data['time']), nick=data['nick'], msg=data['msg'])

def run(dev=False):
    """Start the Bottle server.

    :dev: True if development else False

    """
    debug, reloader = False, False
    if dev:
        debug, reloader = True, True
    monkey.patch_all()
    bottle.run(
        app=app, host=config.BIND_HOST, port=config.BIND_PORT,
        server='geventSocketIO',
        debug=debug, reloader=reloader)

def is_strdate(string):
    """Check the date format.

    :string: string represend the date.
    :returns: True or False

    """
    p = re.compile('[0-9]{4}-[0-9]{2}-[0-9]{2}')
    return True if p.search(string) else False

def set_theme(name):
    """Set the name of theme in cookie.

    :name: theme's name

    """
    bottle.response.set_cookie("theme", name, path='/')

def get_theme():
    """Get the name of theme in cookie.

    :name: theme's name

    """
    return bottle.request.get_cookie('theme')

###############################################################################
# Helper class
###############################################################################

class LogNameSpace(BaseNamespace):
    """NameSpace for socketio. """
    def on_join(self, msg):
        redis = get_redis_from_app(app)
        key = channel = msg
        sub = redis.pubsub()
        sub.subscribe(channel)
        for i in sub.listen():
            if i['type'] == 'message':
                self.emit('recive', redis.lrange(key, -1, -1)[0])
        sub.unsubscribe()

###############################################################################
# View
###############################################################################

@app.get('/_static/<filepath:path>')
def get_static(filepath):
    """Return static file.
    """
    return bottle.static_file(filepath, root='./static/')

@app.get('/')
def root(rdb):
    """Root view.

    :rdb: redis DB instance

    """
    bottle.redirect('/channels')

@app.get('/channels<slash:re:/*>')
def channels(rdb, slash):
    """Channels view.

    :rdb: redis DB instance
    :slash: / or None

    """
    status, channels = [], get_channels(rdb)
    for c in channels:
        status.append(dict(name=c, length=len(get_logs(rdb, c, 'today'))))
    return bottle.template('channels',
                           project=config.PROJECT,
                           channels=channels,
                           status=status)

@app.get('/channel/<channel><slash:re:/*>')
def channel(rdb, channel, slash):
    """Alias for channel view.

    :rdb: redis DB instance
    :channel: IRC channel name without #
    :slash: / or None

    """
    bottle.redirect("/channel/%s/today/" % (urllib.quote_plus(channel)))

@app.get('/channel/<channel>/<date><slash:re:/*>')
def viewer(rdb, channel, date, slash):
    """Channel view.

    :rdb: redis DB instance
    :channel: IRC channel name without #
    :date: string represend the date

    """
    socketio = True if date == 'today' else False
    date = str_date(date)
    if date:
        rows = []
        for i in get_logs(rdb, channel, date):
            rows.append(irc_row(i))
        return bottle.template('viewer',
                               project=config.PROJECT,
                               channel=channel,
                               date=date,
                               channels=get_channels(rdb),
                               rows=rows,
                               socketio=socketio)
    else:
        bottle.redirect('/channel/%s/today/' % (channel))

@app.get('/channel/<channel>/<date>/<line:int>')
def show_quote(rdb, channel, date, line):
    """Show the quote.

    :rdb: redis DB instance
    :channel: IRC channel name without #
    :date: string represend the date
    :line: line number of logs in channel view

    """
    date = str_date(date)
    if date:
        try:
            logs = get_logs(rdb, channel , date)
            row = irc_row(logs[line - 1])
        except Exception:
            row = None
        return bottle.template('quote',
                               project=config.PROJECT,
                               channel=channel,
                               date=date,
                               channels=get_channels(rdb),
                               row=row)
    else:
        bottle.redirect('/channel/%s/today/' % (channel))

@app.get('/options<slash:re:/*>')
def options(rdb, slash):
    """Options view.

    :rdb: redis DB instance
    :slash: / or None

    """
    return bottle.template('options',
                           project=config.PROJECT,
                           channel=channel,
                           channels=get_channels(rdb),
                           themes = config.BOOTSWATCH_THEMES,
                          )

@app.get('/archives/<channel>/<log>')
def get_archive(rdb, channel, log):
    """Return plain text log file.

    :channel: IRC channel name without #
    :log: log name

    """
    return bottle.static_file(
        os.path.join("#%s" % channel, log),
        root=config.LOG_PATH)

@app.get('/themes/<theme>')
def themes(rdb, theme):
    """API to set the theme.

    :rdb: redis DB instance
    :theme: theme's name

    """
    set_theme(theme)
    bottle.redirect('/options')

@app.post('/go2date')
def go2date(rdb):
    """API to get the log view.

    :rdb: redis DB instance

    """
    #. regx for date
    channel = bottle.request.forms.channel
    date = str_date(bottle.request.forms.date) \
            if is_strdate(bottle.request.forms.date) else None
    date = date if date else 'today'
    bottle.redirect("/channel/%s/%s/" % (
        urllib.quote_plus(channel), date))

@app.error(404)
def _error404(error):
    """404 error handler.
    """
    #return "404"
    bottle.response.status = 303
    bottle.response.headers['Location'] = '/404'

@app.error(500)
def _error500(error):
    """500 error handler.
    """
    bottle.response.status = 303
    bottle.response.headers['Location'] = '/500'

@app.get('/404')
def error404(rdb):
    """Error 404 view.
    """
    return bottle.template('error404',
                           project=config.PROJECT,
                           channels=get_channels(rdb))

@app.get('/500')
def error500(rdb):
    """Error 500 view.
    """
    return bottle.template('error500',
                           project=config.PROJECT,
                           channels=get_channels(rdb))

@app.get('/socket.io/<path:path>')
def socketio_service(path):
    """socket.io connect path.
    """
    socketio_manage(bottle.request.environ,
                    {'/log': LogNameSpace}, bottle.request)

###############################################################################
# Main
###############################################################################

if __name__ == '__main__':
    ctrls = ['start', 'stop', 'status', 'dev']
    daemon = yapdi.Daemon(pidfile=config.PIDFILE, stderr=config.LOGFILE)
    if len(sys.argv) == 2 and sys.argv[1] in ctrls:
        arg = sys.argv[1]
        if arg == 'start':
            if daemon.status():
                print "Pidfile exist: %s, %s(%s) is running already!" % (
                    config.PIDFILE, config.APPNAME, daemon.status())
                exit()
            retcode = daemon.daemonize()
            if retcode == yapdi.OPERATION_SUCCESSFUL:
                try:
                    run(dev=False)
                except KeyboardInterrupt:
                    exit()
        if arg == 'stop':
            if not daemon.status():
                print "%s is not running!" % (config.APPNAME)
                exit()
            retcode = daemon.kill()
            if retcode == yapdi.OPERATION_FAILED:
                print "Error during %s stop!" % (config.APPNAME)
                exit(1)
            else:
                print "%s was stopped." % (config.APPNAME)
        if arg == 'status':
            if not daemon.status():
                print "%s is not running!" % (config.APPNAME)
            else:
                print "%s(%s) is running." % (config.APPNAME, daemon.status())
        if arg == 'dev':
                run(dev=True)
    else:
        print 'Usage: web.py <%s>' % '|'.join(ctrls)
else:
    application = app

