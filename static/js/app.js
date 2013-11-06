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

        var line = Number($('#line').text()) + 1;
        $("#line").text(line);

        var str = '<tr id="new{line}"><td width="10%">[{time}]</td>' + 
        '<td width="15%"><a href="/channel/{channel}/{date}/{line}">{nick}</a></td>' +
        '<td width="75%">{msg}</td></tr>';

        var epoch = row["time"] * 1000;
        str = str.assign({
            time: Date.create(epoch).format('{hh}:{mm}:{ss}'),
            channel: $('#chname').text(),
            date: Date.create(epoch).format('{yyyy}-{MM}-{dd}'),
            line: line,
            nick: row["nick"],
            msg: row["msg"],
        });
        $('#viewer').append(str);

        //. Notice on navbar
        if (Number($("#notice").text()) == 0) {
            $("#message").attr('href', '#new{line}'.assign({line: line}))
        }
        $("#notice").text(Number($('#notice').text()) + 1);
        $("#message").click(function () {
            setTimeout( function () {$("#notice").text(0)}, 500);
        })
    });
});
