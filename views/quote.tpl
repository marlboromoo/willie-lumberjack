% nick = row['nick'] if row else 's0me0ne'
% msg = row['msg'] if row else '...'

        <h2>#{{channel}} <small>{{date}}</small></h2>
        % if row:
        <div class="well break">
          <p class="lead"><b>{{row['nick']}} &gt;</b> <span class="glyphicon glyphicon-comment pull-right"></span></p>
          <blockquote>
            <p>{{row['msg']}}</p>
            <p class="pull-right">at {{row['time']}}</p>
          </blockquote>
        </div>
        % else:
        <div class="well">
          <p class="lead"><b>{{nick}} &gt;</b> <span class="glyphicon glyphicon-comment pull-right"></span></p>
          <blockquote>
            <p>{{msg}}</p>
            <p class="pull-right">at void</p>
          </blockquote>
        </div>
        %end

% preview = "%s ..." % msg[0:19] if len(msg) >=20 else msg
% rebase layout title=None, extra_title="| %s > %s" % (nick, preview), channel=channel, channels=channels, date=date
