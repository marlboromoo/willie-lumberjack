$(function () {
    var WEB_SOCKET_SWF_LOCATION = '/_static/js/socketio/WebSocketMain.swf';
    var socket = io.connect('/log');
    socket.on('connect', function (data) {
        socket.emit('join', $('#chkey').text());
    });
    socket.on('recive', function (data) {
        console.log(data);
        var row = jQuery.parseJSON(data)
        $('#viewer').append(
            '<tr><td width="10%">' + row["time"] + '</td>' +
            '<td width="15%"><a href="/channel/' + $('#chname').text() + '/' + $('#date').text() + '/' + '??' + '">' + row["nick"] + '</a></td>' +
            '<td width="75%">' + row["msg"] + '</td></tr>'
            );
    });
});
