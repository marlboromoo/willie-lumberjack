#!/usr/bin/env python
# encoding: utf-8

"""
web.py - Web viewr for willie-lumberjack module.
Copyright 2013, Timothy Lee <marlboromoo@gmail.com>
Licensed under the MIT License.
"""

import json
import urllib
import bottle
from bottle.ext import redis
import arrow

import config

CHANNELS = 'log:channels'
#. init the DB
app = bottle.Bottle()
plugin = redis.RedisPlugin(
    host = config.REDIS_HOST,
    port = int(config.REDIS_PORT),
    database = int(config.REDIS_DBID),
)
app.install(plugin)

def str_time(epoch):
    """@todo: Docstring for time.

    :epoch: @todo
    :returns: @todo

    """
    return arrow.get(epoch).to('local').format("HH:mm:ss")

def str_date(string):
    """@todo: Docstring for date.

    :string: @todo
    :returns: @todo

    """
    format_ = 'YYYY-MM-DD'
    if string == 'today':
        date = arrow.now().format(format_)
    elif string =='yesterday':
        date = arrow.now().replace(days=-1).format(format_)
    else:
        try:
            date = arrow.get(string, format_)
            date = date.format(format_)
        except Exception:
            date = None
    return date

def channel_name(channel):
    """@todo: Docstring for channel_name.

    :channel: @todo
    :returns: @todo

    """
    return "#%s" % channel if not channel.startswith('#') else channel

@app.get('/_static/<filepath:path>')
def get_static(filepath):
    """Return static file.
    """
    return bottle.static_file(filepath, root='./static/')

@app.get('/')
def root(rdb):
    """Root view.
    """
    bottle.redirect('/channels')

@app.get('/channels<slash:re:/*>')
def channels(rdb, slash):
    """Channels view.
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
    """@todo: Docstring for channel.

    :rdb: @todo
    :returns: @todo

    """
    bottle.redirect("/channel/%s/today/" % (urllib.quote_plus(channel)))

def get_logs(rdb, channel, date):
    """@todo: Docstring for get_logs.

    :rdb: @todo
    :channel: @todo
    :date: @todo
    :returns: @todo

    """
    channel, date = channel_name(channel), str_date(date)
    date = str_date(date)
    key = "%s:%s" % (channel, date)
    return rdb.lrange(key, 0, -1)

def get_channels(rdb):
    """@todo: Docstring for get_channels.

    :arg1: @todo
    :returns: @todo

    """
    return [ c.lstrip('#') for c in rdb.lrange(CHANNELS, 0, -1)]

def simple_view(data):
    """@todo: Docstring for simple_view.

    :data: @todo
    :returns: @todo

    """
    return "%s | %s | %s <br/>" % \
            (str_time(data['time']) ,data['nick'], data['msg'])

def irc_row(str_json):
    """@todo: Docstring for irc_row.

    :str_json: @todo
    :returns: @todo

    """
    data = json.loads(str_json)
    return dict(
        time=str_time(data['time']), nick=data['nick'], msg=data['msg'])

@app.get('/channel/<channel>/<date><slash:re:/*>')
def show_log(rdb, channel, date, slash):
    """@todo: Docstring for show_log.

    :rdb: @todo
    :channel: @todo
    :date: @todo
    :returns: @todo

    """
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
                               rows=rows)
    else:
        bottle.redirect('/channel/%s/today/' % (channel))

@app.get('/channel/<channel>/<date>/<line:int>')
def show_quote(rdb, channel, date, line):
    """Show the quote.
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


@app.post('/go2date')
def go2date(rdb):
    """@todo: Docstring for go2date.

    :rdb: @todo
    :returns: @todo

    """
    channel = bottle.request.forms.channel
    date = str_date(bottle.request.forms.date)
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

if __name__ == '__main__':
    bottle.run(
        app=app, host=config.BIND_HOST, port=config.BIND_PORT,
        debug=True, reloader=True)
else:
    application = app

