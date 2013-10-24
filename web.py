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

def time2str(epoch):
    """@todo: Docstring for time.

    :epoch: @todo
    :returns: @todo

    """
    return arrow.get(epoch).format("HH:mm:ss")

def date2str(string):
    """@todo: Docstring for date.

    :string: @todo
    :returns: @todo

    """
    date = string
    if date == 'today':
        date = arrow.now().format("YYYY-MM-DD")
    if date =='yesterday':
        date = arrow.now().replace(days=-1)
    return date

def channel_name(channel):
    """@todo: Docstring for channel_name.

    :channel: @todo
    :returns: @todo

    """
    return "#%s" % channel if not channel.startswith('#') else channel

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

def getlog(rdb, channel, date):
    """@todo: Docstring for getlog.

    :rdb: @todo
    :channel: @todo
    :date: @todo
    :returns: @todo

    """
    channel, date = channel_name(channel), date2str(date)
    date = date2str(date)
    key = "%s:%s" % (channel, date)
    return rdb.lrange(key, 0, -1)

def simple_view(data):
    """@todo: Docstring for simple_view.

    :data: @todo
    :returns: @todo

    """
    return "%s | %s | %s <br/>" % \
            (time2str(data['time']) ,data['nick'], data['msg'])

@app.get('/channel/<channel>/<date><slash:re:/*>')
def showlog(rdb, channel, date, slash):
    """@todo: Docstring for showlog.

    :rdb: @todo
    :channel: @todo
    :date: @todo
    :returns: @todo

    """
    logs = getlog(rdb, channel, date)
    view = ''
    for i in logs:
        view += simple_view(json.loads(i))
    return view

@app.get('/channel/<channel>/<date>/<line:int>')
def quotes(rdb, channel, date, line):
    """Show the quotes.
    """
    logs = getlog(rdb, channel , date)
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

