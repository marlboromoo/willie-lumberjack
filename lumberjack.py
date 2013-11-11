#!/usr/bin/env python
# encoding: utf-8

"""
lumberjack.py - A logging module for willie.
Copyright 2013, Timothy Lee <marlboromoo@gmail.com>
Licensed under the MIT License.
"""

import time
import os
import json
import codecs
import willie
import redis
import arrow

###############################################################################
# Setup the module
###############################################################################

MODULE = 'lumberjack'
CHANNELS = 'log:channels'
db = None
logging = True
log_path = None

def configure(config):
    """

    | [lumberjack] | example | purpose |
    | ------------ | ------- | ------- |
    | redis_host | localhost | Redis host |
    | redis_port | 6379 | Redis port |
    | redis_dbid | 0 | Redis dbid |
    | channels | #foo,#bar | IRC channels |
    | log_path | /tmp/lumberjack/ | Log path |

    """
    if config.option('Configure lumberjack', False):
        config.interactive_add('lumberjack', 'redis_host',
                               'Redis host', 'localhost')
        config.interactive_add('lumberjack', 'redis_port', 'Redis port', 6379)
        config.interactive_add('lumberjack', 'redis_dbid', 'Redis dbid', 0)
        config.interactive_add('lumberjack', 'channels', '#foo,bar')
        config.interactive_add('lumberjack', 'log_path', '/tmp/%s/' % MODULE)


def setup(bot):
    """Setup the database.

    :bot: willie.bot.Willie

    """
    global db
    #. get settings
    host, port, dbid, channels = None, None, None, None
    try:
        config = getattr(bot.config, MODULE)
        host = config.redis_host
        port = int(config.redis_port)
        dbid = int(config.redis_dbid)
        channels = config.channels.split(',')
        logpath = config.log_path
        global log_path
        log_path = logpath
    except Exception, e:
        print "%s: Configure the module first!" % (MODULE)
        raise e
    #. init the DB
    if all([host, port, str(dbid), channels]):
        pool = redis.ConnectionPool(host=host, port=port, db=dbid)
        db = redis.Redis(connection_pool=pool)
        try:
            #. check status
            db.info()
            #. init channels
            db.delete(CHANNELS)
            for c in channels:
                db.rpush(CHANNELS, c)
        except Exception, e:
            print "%s: DB init fail - %s" % (MODULE, e)
            raise e
    #. ensure the log path is writeable
    try:
        if not os.path.exists(logpath):
            os.mkdir(logpath)
        path = os.path.join(logpath, 'foo')
        with open(path, 'w') as f:
            f.write('bar')
        os.unlink(path)
    except Exception, e:
        print "%s: Log path error - %s" % (MODULE, e)
        raise e

###############################################################################
# Helper function
###############################################################################

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
            date = arrow.get(string).format(format_)
        except Exception:
            date = None
    return date

def _log(channel, time, nick, msg):
    """@todo: Docstring for _log.

    :time: @todo
    :channel: @todo
    :nick: @todo
    :msg: @todo
    :returns: @todo

    """
    try:
        date = arrow.now().format("YYYY-MM-DD")
        key = channel_ = "%s:%s" % (channel, date)
        db.rpush(key, json.dumps(
            dict(time=time, nick=nick, msg=msg)))
        db.publish(channel_, True)
    except Exception, e:
        print "%s: logging fail - %s " % (MODULE, e)

def log2txt(channel, time, nick, msg):
    """@todo: Docstring for log2txt.

    :channel: @todo
    :time: @todo
    :nick: @todo
    :msg: @todo
    :returns: @todo

    """
    try:
        dir_ = os.path.join(log_path, channel)
        if not os.path.exists(dir_):
            os.mkdir(dir_)
        txt = codecs.open(
            os.path.join(log_path, channel, "%s.txt" % (str_date(time))),
            'a', 'utf-8'
        )
        txt.write("[%s] <%s> %s\r\n" % (str_time(time), nick , msg))
        txt.close()
    except Exception, e:
        print "%s: Log to text error - %s" % (MODULE, e)

###############################################################################
# event & command
###############################################################################

@willie.module.rule('(.*)')
def log(bot, trigger):
    """Log the message to the database.

    :bot: willie.bot.Willie
    :trigger: willie.bot.Willie.Trigger

    """
    #. only log message in the channel not from other IRC users
    if logging and db and trigger.sender.startswith('#'):
        _log(trigger.sender, int(time.time()), trigger.nick, trigger.bytes)
        log2txt(trigger.sender, int(time.time()), trigger.nick, trigger.bytes)
        print trigger.sender, int(time.time()), trigger.nick, trigger.bytes

@willie.module.commands('startlog')
def startlog(bot, trigger):
    """Toggle the log module on."""
    #. Can only be done in privmsg by an admin
    if trigger.sender.startswith('#'):
        return

    if trigger.admin or trigger.owner:
        global logging
        logging = True
        bot.reply('Okay.')

@willie.module.commands('stoplog')
def stoplog(bot, trigger):
    """Toggle the log module off."""
    #. Can only be done in privmsg by an admin
    if trigger.sender.startswith('#'):
        return

    if trigger.admin or trigger.owner:
        global logging
        logging = False
        bot.reply('As you wish.')

