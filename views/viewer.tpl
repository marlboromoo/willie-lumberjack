<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>{{project}}</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- Loading Bootstrap -->
    <link href="/_static/flat-ui/bootstrap/css/bootstrap.css" rel="stylesheet">

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
            <a href="#">
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

    <div class="container">
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
    </div>
    <!-- /.container -->

    <footer>
      <div class="container">
        <div class="row">
          <div class="col-md-7">
            <h3 class="footer-title">{{project}}</h3>
            <p>Is a module for Willie IRC bot.</p>
          </div> <!-- /col-md-7 -->

          <div class="col-md-5">
            <div class="footer-banner">
              <h3 class="footer-title">Like willie-log ?</h3>
              <ul>
                <li>Star it.</li>
                <li>Fork it.</li>
                <li>Make a pull request.</li>
                <li>Donate ?</li>
              </ul>
              Follow on <a href="#" target="_blank">GitHub</a>
            </div>
          </div>
        </div>
      </div>
    </footer>

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
  </body>
</html>
