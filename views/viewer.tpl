
      <p/>
      <div class="hidden" id="chkey">#{{channel}}:{{date}}</div>
      <div class="hidden" id="chname">{{channel}}</div>
      <div class="hidden" id="line">{{len(rows)}}</div>

      <div class="row">
        <div class="col-xs-12 col-sm-9">
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
            <tr id="trash">
              <td>Nothing here. Try <a href="/archives/{{channel}}/{{date}}.txt" target="_blank">Archive</a>.</td>
            </tr>
            % end
            </tbody>
          </table>
          <div id="down"></div>
        </div>

        <div class="col-xs-6 col-sm-3">
          <form class="form affix" role="form" method="post" action="/go2date">
            <div class="form-group">
            <span class="glyphicon glyphicon-calendar"></span>
            <label> View By Date</label>
            <input type="text" class="form-control" placeholder="YYYY-MM-DD" name="date" data-toggle="tooltip" title="Enter the date to go!">
            <input type="hidden" name="channel" value="{{channel}}">
            <a href="/channel/{{channel}}/today/" class="list-group-item"><span class="glyphicon glyphicon-star"></span> Today</a>
            <a href="/channel/{{channel}}/yesterday/" class="list-group-item"><span class="glyphicon glyphicon-star"></span> Yesterday</a>
            <br/>
            <span class="glyphicon glyphicon-flash"></span>
            <label> Shortcut</label>
            <a href="#" class="list-group-item"><span class="glyphicon glyphicon-chevron-up"></span> Top</a>
            <a href="#down" class="list-group-item"><span class="glyphicon glyphicon-chevron-down"></span> Down</a>
            <br/>
            <span class="glyphicon glyphicon-hdd"></span>
            <label> Archives</label>
            <a href="/archives/{{channel}}/{{date}}.txt" class="list-group-item" target="_blank"><span class="glyphicon glyphicon-download-alt"></span> Download</a>
            </div>
          </form>
        </div>
      </div>

%rebase layout title=None, extra_title='', project=project, channel=channel, channels=channels, date=date
