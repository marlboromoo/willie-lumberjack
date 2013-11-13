
        <h2>Readability</h2>
        <br/>
        <div class="row">
          <div class="col-lg-4 col-sm-6">
            <div class="thumbnail">
              <br/>
              <div class="image text-center">
                <i class="glyphicon glyphicon-link" style='font-size: 100px'></i>
              </div>
              <div class="caption text-center">
                <h3>Autolinks</h3>
                <p>Make URL clickable in IRC logs.<p>
                <div class="btn-group btn-group">
                  % if autolinks_true_active:
                    <a href="#" class="btn btn-info {{autolinks_true_active}}">On</a>
                    <a href="/options/autolinks/False" class="btn btn-info {{autolinks_false_active}}">Off</a>
                  % else:
                    <a href="/options/autolinks/True" class="btn btn-info {{autolinks_true_active}}">On</a>
                    <a href="#" class="btn btn-info {{autolinks_false_active}}">Off</a>
                  % end
                </div>
              </div>
            </div>
          </div>
        </div>

        <h2>
          Theme <small>
            from Bootswatch 
            <a href="http://bootswatch.com/" target="_blank">
              <span class="glyphicon glyphicon-share-alt"></span>
            </a>
          </small>
        </h2>
        <br/>
        <div class="row">
        % for theme in themes:
          <div class="col-lg-4 col-sm-6">
            <div class="thumbnail">
              <div class="image">
                <img src="../_static/bootswatch/{{theme}}/thumbnail.png" class="img-responsive" alt="{{theme.capitalize()}}">
              </div>
              <div class="caption text-center">
                <h3>{{theme.capitalize()}}</h3>
                <p>{{themes[theme]}}</p>
                <div class="btn-group"><a class="btn btn-info" href="/themes/{{theme}}">Got it</a></div>
              </div>
            </div>
          </div>
        % end
        </div>

% rebase layout title='Options', channels=channels
