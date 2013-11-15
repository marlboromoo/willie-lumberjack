% setdefault('widget', False)
% setdefault('striped', '')
% setdefault('condensed', '')
% if widget:
%   striped, condensed = 'table-striped', 'table-condensed'
% end

        <div class="hidden" id="chkey">#{{channel}}:{{date}}</div>
        <div class="hidden" id="chname">{{channel}}</div>
        <div class="hidden" id="line">{{len(rows)}}</div>
        <div class="hidden" id="socketio">{{socketio}}</div>
        <div class="hidden" id="autolinks">{{autolinks}}</div>
        <div class="hidden" id="reverse">{{reverse}}</div>

        <div class="row">
          <div class="col-xs-12 col-sm-9">
            % if not widget:
            <h2>#{{channel}} <small id="date">{{date}}</small></h2>
            % end
            <table class="table {{striped}} {{condensed}} break">
              <tbody id="viewer">
              % i, lines= 0, len(rows)
              % for row in rows:
                % i += 1
              <tr>
                <td>
                  <div class="row">
                    <div class="col-xs-12 col-sm-6 col-md-4">
                      % if reverse:
                      %   line = lines - i + 1
                      % else:
                      %   line = i
                      % end
                      <p class="text-warning">[{{row['time']}}] <a href="/channel/{{channel}}/{{date}}/{{line}}" class="pull-right" target="_blank">{{row['nick']}}</a></p>
                    </div>
                    <div class="col-xs-12 col-sm-6 col-md-8 msg">
                      <p>{{row['msg']}}</p>
                    </div>
                  </div>
                </td>
              </tr>
              % end
              % if len(rows) < 1:
              <tr id="trash">
                <td><p>Nothing here. Try <a href="/archives/{{channel}}/{{date}}.txt">Archive</a>.</p></td>
              </tr>
              % end
              </tbody>
            </table>
            <div id="down"></div>
          </div>

          % if not widget:
          <div class="hidden-xs col-sm-3">
            <br/>
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
              <label> Archive</label>
              <a href="/archives/{{channel}}/{{date}}.txt" class="list-group-item" target="_blank"><span class="glyphicon glyphicon-download-alt"></span> Download</a>
              <br/>
              <span class="glyphicon glyphicon-pushpin"></span>
              <label> Widget</label>
              <a href="#" class="list-group-item" data-toggle="modal" data-target="#widgetModal"><span class="glyphicon glyphicon-download-alt"></span> Get It</a>
              </div>
            </form>
          </div>
        </div>
        % end

        <!-- Widget Modal -->
        <div class="modal fade" id="widgetModal" tabindex="-1" role="dialog" aria-labelledby="widgetModelLabel" aria-hidden="true">
          <div class="modal-dialog">
            <div class="modal-content">
              <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="widgetModelLabel">Get widget for #{{channel}}</h4>
              </div>
              <div class="modal-body">
                <p>Insert the following html code on your web page ;)</p>
                <pre>&lt;iframe height="480" frameborder="0" src="http://{{server}}/widget/{{channel}}/"&gt;&lt;/iframe&gt;</pre>
              </div>
              <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
              </div>
            </div>
          </div>
        </div>

%rebase layout title=None, extra_title='', channel=channel, channels=channels, date=date, socketio=socketio, widget=widget
