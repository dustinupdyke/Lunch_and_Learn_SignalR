<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Time.aspx.cs" Inherits="SignalR.Default" %>

<!DOCTYPE html>
<html>
<head>
    <title>What time is it?</title>
    <link href="Content/site.css" rel="stylesheet" />
</head>
<body>
    
    <div class="container">
        <ul id="output"></ul>
    </div>

    <script src="/Scripts/jquery-1.6.4.min.js"></script>
    <script src="Scripts/jquery.signalR-2.0.0-beta2.min.js"></script>
    <script src="/signalr/hubs"></script>
    
    <script type="text/javascript">
        var s;
        $(function () {
            // Declare a proxy to reference the hub. 
            s = $.connection.whattime;
            // Create a function that the hub can call to broadcast messages.
            s.client.isit = function (data) {
                // Html encode display name and message. 
                var encodedMsg = $('<div />').text(data).html();
                // Add the message to the page. 
                $('#output').append('<li>' + encodedMsg + '</li>');
            };
            
            // Start the connection.
            $.connection.hub.start().done(function () {
                setInterval("x()", 1000);
            });
        });
        
        function x() {
            s.server.isit(null);
        }
    </script>

</body>
</html>