<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="shortcut icon" href="/_static/bootstrap/assets/ico/favicon.png">

    % if title:
    <title>{{project}} | {{title}}</title>
    % else:
    <title>{{project}} | #{{channel}} {{extra_title}}</title>
    % end
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- Bootstrap core CSS -->
    <!--
    <link href="/_static/bootstrap/dist/css/bootstrap.css" rel="stylesheet">
    -->
    <link href="/_static/bootswatch/flatly/bootstrap.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="/_static/bootstrap/examples/sticky-footer-navbar/sticky-footer-navbar.css" rel="stylesheet">

    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="../../assets/js/html5shiv.js"></script>
      <script src="../../assets/js/respond.min.js"></script>
    <![endif]-->
  </head>

  <body>

    <!-- Wrap all page content here -->
    <div id="wrap">

      <!-- Fixed navbar -->
      <div class="navbar navbar-default navbar-fixed-top">
        <div class="container">
          <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="/channels/">{{project}}</a>
          </div>
          <div class="collapse navbar-collapse">
            <ul class="nav navbar-nav">
              <li class="dropdown">
                <a href="/Channels/" class="dropdown-toggle" data-toggle="dropdown">Channels<b class="caret"></b></a>
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
              % if channel:
              <li><a href="/channel/{{channel}}/today/">Today</a></li>
              <li><a href="/channel/{{channel}}/yesterday/">Yesterday</a></li>
              % end
            </ul>

            <ul class="nav navbar-nav navbar-right">
              <li><a href="/archive/">Archive</a></li>
            </ul>

          </div><!--/.nav-collapse -->
        </div>
      </div>


      <div class="container">
        %include
      </div>
    <!-- /.container -->
    </div>

    <div id="footer">
      <div class="container">
        <p class="text-muted credit pull-right">{{project}} 2013.</p>
      </div>
    </div>

    <!-- Load JS here for greater good =============================-->
    <script src="/_static/bootstrap/assets/js/jquery.js"></script>
    <script src="/_static/bootstrap/dist/js/bootstrap.min.js"></script>
  </body>
</html>
