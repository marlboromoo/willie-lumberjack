      <h2>#{{channel}} <small>{{date}}</small></h3>
      <table class="table table-hover">
        % i = 0
        % for row in rows:
          % i += 1
        <tr>
          <td width="10%">[{{row['time']}}]</td>
          <td width="15%"><a href="/channel/{{channel}}/{{date}}/{{i}}">{{row['nick']}}</a></td>
          <td width="75%">{{row['msg']}}</td>
        </tr>
        % end
      </table>

%rebase layout title=None, extra_title='', project=project, channel=channel, channels=channels, date=date
