#!/usr/bin/env python
# encoding: utf-8

"""
web.py - Web viewr for willie log module.
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
    date = string
    if date == 'today':
        date = arrow.now().format("YYYY-MM-DD")
    if date =='yesterday':
        date = arrow.now().replace(days=-1).format("YYYY-MM-DD")
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
    channels = rdb.lrange(CHANNELS, 0, -1)
    return channels

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
    rows = []
    for i in get_logs(rdb, channel, date):
        rows.append(irc_row(i))
    print get_channels(rdb)
    return bottle.template('viewer', 
                           project=config.PROJECT,
                           channel=channel,
                           date=str_date(date),
                           channels=get_channels(rdb),
                           rows=rows)

@app.get('/channel/<channel>/<date>/<line:int>')
def quotes(rdb, channel, date, line):
    """Show the quotes.
    """
    logs = get_logs(rdb, channel , date)
    try:
        return simple_view(json.loads(logs[line - 1]))
    except Exception:
        return str(None)

if __name__ == '__main__':
    bottle.run(
        app=app, host=config.BIND_HOST, port=config.BIND_PORT,
        debug=True, reloader=True)
else:
    application = app
