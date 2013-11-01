
      <div class="hidden" id="chkey">#{{channel}}:{{date}}</div>
      <div class="hidden" id="chname">{{channel}}</div>

      <h2>#{{channel}} <small id="date">{{date}}</small></h2>
      <table class="table table-hover">
        <tbody id="viewer">
        % i = 0
        % for row in rows:
          % i += 1
        <tr>
          <td width="10%">[{{row['time']}}]</td>
          <td width="15%"><a href="/channel/{{channel}}/{{date}}/{{i}}">{{row['nick']}}</a></td>
          <td width="75%">{{row['msg']}}</td>
        </tr>
        % end
        % if len(rows) < 1:
        <tr>
          <td>Nothing here.</td>
        </tr>
        % end
        </tbody>
      </table>


%rebase layout title=None, extra_title='', project=project, channel=channel, channels=channels, date=date
