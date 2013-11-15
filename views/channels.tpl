% least = 6

        <br/>
        <br/>
        <div class="jumbotron">
          <h1>{{project}}</h1>
          <p>A logging module for Willie IRC bot with real-time log viewer.</p>
            <a class="btn btn-primary pull-right" href="http://marlboromoo.github.io/willie-lumberjack/">Read more &raquo;</a>
          </p>
          <br/>
        </div>
        <div class="row">
          % i = 0
          % for s in status:
          <a href="/channel/{{s['name']}}/">
          <div class="col-sm-6 col-md-4">
            <div class="panel panel-default">
              <div class="panel-heading">
                <h3 class="panel-title">#{{s['name']}}</h3>
              </div>
              <div class="panel-body">
                <p>{{s['length']}} messages.</p>
              </div>
            </div>
          </div>
          </a>
            % i += 1
          % end
          % if len(channels) < least:
              % for x in xrange(least - len(channels)):
          <div class="col-sm-6 col-md-4">
            <div class="panel panel-default">
              <div class="panel-heading">
                <h3 class="panel-title">None</h3>
              </div>
              <div class="panel-body">
                <p>...</p>
              </div>
            </div>
          </div>
                % i += 1
              % end
          % end
        </div>

% rebase layout title='channels', channels=channels
