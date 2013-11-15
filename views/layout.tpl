% from web import get_theme
% import config
% setdefault('theme', config.DEFAULT_THEME)
% setdefault('socketio', False)
% setdefault('channel', None)
% setdefault('widget', False)
% theme = config.WIDGET_THEME if widget else get_theme()
% theme = theme if theme else config.DEFAULT_THEME
% project = config.PROJECT

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="shortcut icon" href="/_static/ico/favicon.ico">

    % if title:
    <title>{{project}} | {{title}}</title>
    % else:
    <title>{{project}} | #{{channel}} {{extra_title}}</title>
    % end
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- Bootstrap core CSS -->
    <link href="/_static/bootswatch/{{theme}}/bootstrap.min.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    % if widget:
      <link href="/_static/css/widget.css" rel="stylesheet">
    %  else:
      <link href="/_static/css/app.css" rel="stylesheet">
    % end

    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="/_static/bootstrap/assets/js/html5shiv.js"></script>
      <script src="/_static/bootstrap/assets/js/respond.min.js"></script>
    <![endif]-->
  </head>

  <body>

    <!-- Wrap all page content here -->
    <div id="wrap">

      <!-- Fixed navbar -->
      % if not widget:
      <div class="navbar navbar-default navbar-fixed-top">
        <div class="container">
          <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="/">{{project}}</a>
          </div>

          <div class="collapse navbar-collapse">
            <ul class="nav navbar-nav">
              <li class="dropdown">
                <a href="/channels/" class="dropdown-toggle" data-toggle="dropdown"><span class="glyphicon glyphicon-bullhorn"></span> Channels<b class="caret"></b></a>
                <ul class="dropdown-menu">
                  % for c in channels:
                  <li><a href="/channel/{{c}}/">{{c}}</a></li>
                  % end
                  <!--
                  <li class="divider"></li>
                  <li class="dropdown-header">Nav header</li>
                  -->
                </ul>
              </li>
            </ul>

            <ul class="nav navbar-nav navbar-right">
              <li><a href="/options/"><span class="glyphicon glyphicon-wrench"></span> Options</a></li>
              % if all([channel, socketio]):
              <li>
                <a href="#new" id="message">
                  <span class="glyphicon glyphicon-bell"></span> Message <span class="badge" id="notice">0</span>
                </a>
              </li>
              % end
            </ul>

          </div><!--/.nav-collapse -->
        </div>
      </div>
      % end


      <div class="container">
        %include
      </div>
    <!-- /.container -->
    </div>

    % if not widget:
    <div id="footer">
      <div class="container">
        <p class="text-muted credit pull-right">
          {{project}} 2013 / <a href="https://github.com/marlboromoo/willie-lumberjack" target="_blank">GitHub</a> / Build with <span class="glyphicon glyphicon-heart"></p>
      </div>
    </div>
    % end

    <!-- Load JS here for greater good =============================-->
    <script src="https://code.jquery.com/jquery-1.10.2.min.js"></script>
    <script src="/_static/bootstrap/dist/js/bootstrap.min.js"></script>
    <script src="/_static/js/socketio/socket.io.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="/_static/js/sugar.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="/_static/js/app.js" type="text/javascript" charset="utf-8"></script>

  </body>
</html>
