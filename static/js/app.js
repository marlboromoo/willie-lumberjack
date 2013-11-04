$(function () {
    var WEB_SOCKET_SWF_LOCATION = '/_static/js/socketio/WebSocketMain.swf';
    var socket = io.connect('/log');
    socket.on('connect', function (data) {
        socket.emit('join', $('#chkey').text());
    });
    socket.on('recive', function (data) {
        console.log(data);

        //. Show the row
        var row = jQuery.parseJSON(data);
        $("#trash").remove();

        var str = '<tr id="new"><td width="10%">[{time}]</td>' + 
        '<td width="15%"><a href="/channel/{channel}/{date}/{line}">{nick}</a></td>' +
        '<td width="75%">{msg}</td></tr>';

        var line = Number($('#line').text()) + 1;
        $("#line").text(line);

        var epoch = row["time"] * 1000;
        str = str.assign({
            time:       Date.create(epoch).format('{hh}:{mm}:{ss}'),
            channel:    $('#chname').text(),
            date:       Date.create(epoch).format('{yyyy}-{MM}-{dd}'),
            line:       line,
            nick:       row["nick"],
            msg:        row["msg"],
        });
        $('#viewer').append(str);

        //. Notice on navbar
        //if ($("#notice").length == 0) {
        //    $('#message').append('<span class="badge" id="notice">New</span>');
        //}
        //
        //

        $("#notice").text(Number($('#notice').text()) + 1);
        $("#message").click(function () {
            $("#notice").empty();
        })
    });
});
