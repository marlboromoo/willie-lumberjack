
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
              <td>Nothing here.</td>
            </tr>
            % end
            </tbody>
          </table>
        </div>

        <div class="col-xs-6 col-sm-3">

<!--
          <ul id="sidebar" class="nav nav-pills nav-stacked affix">
            <li><a href="#">Today</a></li>
            <li><a href="#">Yesterday</a></li>
          </ul>
-->

<!--
          <div class="list-group affix">
            <a href="#" class="list-group-item">&gt; Today</a>
            <a href="#" class="list-group-item">&gt; Yesterday</a>
          </div>
-->

          <form class="form-horizontal affix" role="form" method="post" action="/go2date">
            <div class="form-group">
            <span class="glyphicon glyphicon-calendar"></span>
            <label for="exampleInputEmail2"> View By Date</label>
            <input type="text" class="form-control" placeholder="YYYY-MM-DD" name="date" data-toggle="tooltip" title="Enter the date to go!">
            <input type="hidden" name="channel" value="{{channel}}">
            <a href="/channel/{{channel}}/today/" class="list-group-item"><span class="glyphicon glyphicon-star"></span> Today</a>
            <a href="/channel/{{channel}}/yesterday/" class="list-group-item"><span class="glyphicon glyphicon-star"></span> Yesterday</a>
            </div>
          </form>
        </div>
      </div>

%rebase layout title=None, extra_title='', project=project, channel=channel, channels=channels, date=date
