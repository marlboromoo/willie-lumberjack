<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    % if title:
    <title>{{project}} | {{title}}</title>
    % else:
    <title>{{project}} | #{{channel}} {{extra_title}}</title>
    % end
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- Loading Bootstrap -->
    <link href="/_static/flat-ui/bootstrap/css/bootstrap.css" rel="stylesheet">
    <link href="/_static/flat-ui/bootstrap/css/sticky-footer.css" rel="stylesheet">

    <!-- Loading Flat UI -->
    <link href="/_static/flat-ui/css/flat-ui.css" rel="stylesheet">

    <link rel="shortcut icon" href="/_static/flat-ui/images/favicon.ico">

    <!-- HTML5 shim, for IE6-8 support of HTML5 elements. All other JS at the end of file. -->
    <!--[if lt IE 9]>
      <script src="js/html5shiv.js"></script>
    <![endif]-->
  </head>
  <body>

    <div class="navbar navbar-inverse">
      <div class="navbar-header">
          <button type="button" class="btn btn-navbar" data-toggle="collapse" data-target=".navbar-collapse-01"></button>
      </div>
      <div class="navbar-collapse collapse navbar-collapse-01">
        <ul class="nav navbar-nav navbar-left">
          <li>
            <a href="#">
              {{project}}
            </a>
          </li>
          <li class="active">
            <a href="/channels/">
              Channels
              <span class="navbar-unread">1</span>
            </a>
            <ul>
              % for c in channels:
              <li>
                <a href="/channel/{{c}}/">{{c}}</a>
                <ul>
                  <li><a href="/channel/{{c}}/today/">today</a></li>
                  <li><a href="/channel/{{c}}/yesterday/">yesterday</a></li>
                </ul> <!-- /Sub menu -->
              </li>
              % end
            </ul> <!-- /Sub menu -->
          </li>
          <li>
            <a href="/archive">
              Archive
            </a>
          </li>
        </ul>
        <ul class="nav navbar-nav navbar-right">
          <li>
            <a href="#">
              Messages
              <span class="navbar-unread">1</span>
            </a>
          </li>
        </ul>
      </div><!--/.nav -->
    </div>

    <div id="wrap" class="container">
      %include
    </div>
    <!-- /.container -->

    <div id="footer">
      <div class="container">
        <p class="text-muted credit pull-right">{{project}} 2013.</p>
      </div>
    </div>

    <!-- Load JS here for greater good =============================-->
    <script src="/_static/flat-ui/js/jquery-1.8.3.min.js"></script>
    <script src="/_static/flat-ui/js/jquery-ui-1.10.3.custom.min.js"></script>
    <script src="/_static/flat-ui/js/jquery.ui.touch-punch.min.js"></script>
    <script src="/_static/flat-ui/js/bootstrap.min.js"></script>
    <script src="/_static/flat-ui/js/bootstrap-select.js"></script>
    <script src="/_static/flat-ui/js/bootstrap-switch.js"></script>
    <script src="/_static/flat-ui/js/flatui-checkbox.js"></script>
    <script src="/_static/flat-ui/js/flatui-radio.js"></script>
    <script src="/_static/flat-ui/js/jquery.tagsinput.js"></script>
    <script src="/_static/flat-ui/js/jquery.placeholder.js"></script>
    <script src="/_static/flat-ui/bootstrap/js/holder.js"></script>
  </body>
</html>
