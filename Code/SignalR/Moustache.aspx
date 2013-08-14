<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Moustache.aspx.cs" Inherits="SignalR.Moustache" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>:})</title>
</head>
<body>
    <div class="container">
        <input type="text" id="who" />
        <ul id="output"></ul>
    </div>
    <script src="/Scripts/jquery-1.6.4.min.js"></script>
    <script src="Scripts/jquery.signalR-2.0.0-beta2.min.js"></script>
    <script src="/signalr/hubs"></script>

    <script>
        $(function () {
            $(function () {
                var s = $.connection.moustachify;

                $('#who').focus();

                s.client.moustache = function (message) {
                    $('#output').prepend('<li>' + htmlEncode(message) + '</li>');
                };

                // Set the name
                $.connection.hub.qs = "who=" + $('#who').val();

                $.connection.hub.start().done(function () {
                    $(document).keypress(function (e) {
                        if (e.which == 13) {
                            // Call the Send method on the hub. 
                            s.server.moustache($('#who').val());
                            // Clear text box and reset focus for next comment. 
                            $('#who').val('');
                            $('#who').focus();
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
