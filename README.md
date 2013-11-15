# Willie-Lumberjack
A logging module for [Willie] [] IRC bot with real-time log viewer.

```
Willie-
 __                          __                                          __
/\ \                        /\ \                     __                 /\ \
\ \ \      __  __    ___ ___\ \ \____     __   _ __ /\_\     __      ___\ \ \/'\
 \ \ \  __/\ \/\ \ /' __` __`\ \ '__`\  /'__`\/\`'__\/\ \  /'__`\   /'___\ \ , <
  \ \ \L\ \ \ \_\ \/\ \/\ \/\ \ \ \L\ \/\  __/\ \ \/ \ \ \/\ \L\.\_/\ \__/\ \ \\`\
   \ \____/\ \____/\ \_\ \_\ \_\ \_,__/\ \____\\ \_\ _\ \ \ \__/.\_\ \____\\ \_\ \_\
    \/___/  \/___/  \/_/\/_/\/_/\/___/  \/____/ \/_//\ \_\ \/__/\/_/\/____/ \/_/\/_/
                                                    \ \____/
                                                     \/___/

                                      Lumberjack will chopping the log for you.
```

## Features
 * Real-time log viewer
 * Themes ([Bootswatch] [])
 * Widget

## Requirments 
 - Python
 - [Redis] []
 - [Willie] []
 - [redis-py] []
 - [bottle.py] []
 - [bottle-redis] []
 - [gevent-socketio] []
 - [arrow] []
 - [YapDi] []

## Install

### Dependency
```sh
sudo apt-get install python python-dev python-pip redis-server \
build-essential libevent-dev
```
### Wilie-Lumberjack
```sh
cd ~
git clone https://github.com/marlboromoo/willie-lumberjack.git
cd willie-lumberjack
git submodule init
git submodule update
sudo pip install requirements.txt
cd ~/.willie/
ln -s ~/willie_lumberjack/lumberjack.py ./modules/
cp ~/willie_lumberjack/config/logbot.cfg ./default.cfg
#. start the ircbot
willie -d
#. start the web server
cd ~/willie-lumberjack 
python web.py start
```

##  Update
 1. Stop the ircbot & web server.

```sh
#. stop the web server
cd ~/.willie-lumberjack
python web.py stop
#. stop the ircbot
willie -q
```

 2. Update.

```sh
cd ~/willie-lumberjack
git pull
git submodule update
```

 3. Start the ircbot & web server.

```sh
#. start the web server
cd ~/.willie-lumberjack
python web.py start
#. start the ircbot
willie -d
```

## Configuration

### Module
Full example can find in the [/doc] [] folder.

| [lumberjack] | example | purpose |
| ------------ | ------- | ------- |
| redis_host | localhost | Redis host |
| redis_port | 6379 | Redis port |
| redis_dbid | 0 | Redis dbid |
| channels | #foo,#bar | IRC channels |
| log_path | /tmp/lumberjack/ | Log path |

### Web Server
Check the [config.py] [] to see the full example.

#### Bottle
 - `BIND_HOST`: IP Address  to listen.
 - `BIND_PORT`: TCP port to listen.
 - `LOGFILE`: Log path
 - `PIDFILE`: PID file path.

#### Redis
 - `REDIS_HOST`: Redis server address.
 - `REDIS_PORT`: Redis server port.
 - `REDIS_DBID`: Redis DB id.

#### Log
 - `LOG_PATH`: Path to the plain text log.

#### Theme
 - `BOOTSWATCH_THEMES`: Themes to enable.

## Usage
TODO.

## TODO
 * You tell me

## Status
[![Travis CI Build Status] []] [Travis CI]

## Author
Timothy.Lee a.k.a MarlboroMoo.

## License
Released under the [MIT License].

  [MIT License]: http://opensource.org/licenses/MIT "MIT License"
  [Travis CI Build Status]: https://api.travis-ci.org/marlboromoo/willie-lumberjack.png 
  [Travis CI]: https://travis-ci.org/marlboromoo/willie-lumberjack
  [Redis]: http://redis.io/ "Advanced key-value store"
  [Willie]: http://willie.dftba.net/ "Willie"
  [redis-py]: https://github.com/andymccurdy/redis-py "Python client for Redis key-value store"
  [bottle.py]: https://github.com/defnull/bottle "Python Web Framework"
  [bottle-redis]: https://github.com/bottlepy/bottle-extras/tree/master/redis "Redis integration for Bottle."
  [gevent-socketio]: https://github.com/abourget/gevent-socketio "Python implementation of the Socket.IO protocol"
  [arrow]: https://github.com/crsmithdev/arrow "Better dates & times for Python"
  [YapDi]: https://github.com/kasun/YapDi "Yet another python Daemon implementation"
  [Bootswatch]: http://bootswatch.com/ "Free themes for Bootstrap"
  [/doc]: https://github.com/marlboromoo/willie-lumberjack/tree/master/doc
  [config.py]: https://github.com/marlboromoo/willie-lumberjack/blob/master/config.py 


