#!/usr/bin/env python
# encoding: utf-8

"""
Config for Willie-Lumberjack web server.
"""

PROJECT = 'Willie-Lumberjack'
APPNAME = PROJECT

#. bottle
BIND_HOST = '127.0.1.1'
BIND_PORT = 8080
LOGFILE = '/tmp/web.log'
PIDFILE = '/tmp/web.pid'

#. redis
REDIS_HOST = '10.10.5.32'
REDIS_PORT = 6379
REDIS_DBID = 0

