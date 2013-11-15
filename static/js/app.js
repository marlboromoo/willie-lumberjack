$(function () {
    //. auto links
    var url_patten = new RegExp('((ftp|http|https)://[\\w-]+(\\.[\\w-]+)+([\\w-.,@?^=%&:/~+#-]*[\\w@?^=%&;/~+#-])*)', 'g');
    if ($("#autolinks").text() == 'True') {
        var url_template = '<a href="$1" target="_blank" class="text-muted">$1</a>'
        $(".msg").each(function (i) {
            var row = $(this).text().replace(url_patten, url_template);
            $(this).text('')
            $(this).append(row);
        });
    }

    //. socket.io
    if ($("#socketio").text() == 'True') {
        var WEB_SOCKET_SWF_LOCATION = '/_static/js/socketio/WebSocketMain.swf';
        var socket = io.connect('/log');
        socket.on('connect', function (data) {
            socket.emit('join', $('#chkey').text());
        });
        socket.on('recive', function (data) {
            //. Show the row
            var row = jQuery.parseJSON(data);
            $("#trash").remove();

            var line = Number($('#line').text()) + 1;
            $("#line").text(line);

            var str = '<tr id="new{line}"><td><div class="row">' +
            '<div class="col-xs-12 col-sm-6 col-md-4">[{time}] <a href="/channel/{channel}/{date}/{line}" class="pull-right" target="blnak">{nick}</a></div>' +
            '<div class="col-xs-12 col-sm-6 col-md-8 msg">{msg}</div>' +
            '</div></td></tr>';

            if ($("#autolinks").text() == 'True') {
                var msg = row["msg"].replace(url_patten, url_template);
            }
            else {
                var msg = row["msg"];
            }

            var epoch = row["time"] * 1000;
            str = str.assign({
                time: Date.create(epoch).format('{HH}:{mm}:{ss}'),
                channel: $('#chname').text(),
                date: Date.create(epoch).format('{yyyy}-{MM}-{dd}'),
                line: line,
                nick: row["nick"],
                msg: msg,
            });

            if ($("#reverse").text() == 'True') {
                $('#viewer').prepend(str);
            }
            else {
                $('#viewer').append(str);
            }

            //. Notice on navbar
            if (Number($("#notice").text()) == 0) {
                $("#message").attr('href', '#new{line}'.assign({line: line}))
            }
            $("#notice").text(Number($('#notice').text()) + 1);
            $("#message").click(function () {
                setTimeout( function () {$("#notice").text(0)}, 500);
            })
        });
    }
});
