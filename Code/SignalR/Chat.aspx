<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Chat.aspx.cs" Inherits="SignalR.Chat" %>

<!DOCTYPE html>
<html>
<head>
    <title>Chat</title>
    <link href="Content/site.css" rel="stylesheet" />
</head>
<body>
    <div class="container">
        <input type="text" id="message" />
        <input type="hidden" id="displayname" />
        <ul id="output"></ul>
    </div>
    
    <script src="/Scripts/jquery-1.6.4.min.js"></script>
    <script src="Scripts/jquery.signalR-2.0.0-beta2.min.js"></script>
    <script src="/signalr/hubs"></script>

    <script>
        $(function () {
            $(function () {
                var chat = $.connection.chat,
                    name = null;

                $('#message').focus();

                chat.client.send = function (message) {
                    $('#output').prepend('<li>' + htmlEncode(message) + '</li>');
                };

                $('#displayname').val(prompt('Enter your name:', ''));

                // Set the name
                $.connection.hub.qs = "name=" + $('#displayname').val() + "&id=@Model.Id";

                $.connection.hub.start().done(function () {
                    $(document).keypress(function (e) {
                        if (e.which == 13) {
                            // Call the Send method on the hub. 
                            chat.server.send($('#displayname').val(), $('#message').val());
                            // Clear text box and reset focus for next comment. 
                            $('#message').val('');
                            $('#message').focus();
                        }
                    });
                });
            });

            function htmlEncode(value) {
                var encodedValue = $('<div />').html(value).html();
                return encodedValue;
            }
        });
    </script>
</body>
</html>
