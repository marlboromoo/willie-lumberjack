
        <h2>Theme</h2>
        <br/>
        <div class="row">
        % for theme in themes:
          <div class="col-lg-4 col-sm-6">
            <div class="thumbnail">
              <div class="image">
                <img src="../_static/bootswatch/{{theme}}/thumbnail.png" class="img-responsive" alt="{{theme.capitalize()}}">
              </div>
              <div class="caption">
                <h3>{{theme.capitalize()}}</h3>
                <p>{{themes[theme]}}</p>
                <div class="btn-group"><a class="btn btn-info" href="/themes/{{theme}}">Got it</a></div>
              </div>
            </div>
          </div>
        % end
        </div>

% rebase layout title='Options', extra_title=None, project=project, channels=channels, socketio=None