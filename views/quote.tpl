% nick = row['nick'] if row else 's0me0ne'
% msg = row['msg'] if row else '...'

      <h2>#{{channel}} <small>{{date}}</small></h3>
      % if row:
      <div class="well">
        <p class="lead"><b>{{row['nick']}} &gt</b></p>
        <blockquote>
          <p>{{row['msg']}}</p>
          <p class="pull-right">at {{row['time']}}</p>
        </blockquote>
      </div>
      % else:
      <div class="well">
        <p class="lead"><b>{{nick}} &gt</b></p>
        <blockquote>
          <p>{{msg}}</p>
          <p class="pull-right">at void</p>
        </blockquote>
      </div>
      %end

% rebase layout title=None, extra_title="| %s > %s" % (nick, msg), project=project, channel=channel, channels=channels, date=date
