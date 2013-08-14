using System;
using System.Collections.Generic;
using System.Net;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using System.Web.Script.Serialization;
using Microsoft.AspNet.SignalR;
using SignalR.Code;

namespace SignalR.Hubs
{
    public class Chat : Hub
    {
        private readonly static ConnectionMapping<string> _connections = new ConnectionMapping<string>();

        public void Send(string message)
        {
            var name = Context.QueryString["name"];

            Clients.All.send(name + ": " + message);
        }

        public void Send(string who, string message)
        {
            var id = Context.QueryString["id"];

            message = CommandHandler.Parse(message);

            foreach (var connectionId in _connections.GetConnections(id))
            {
                Clients.Client(connectionId).send(who + ": " + message);
            }
        }

        public override Task OnConnected()
        {
            var id = Context.QueryString["id"];

            _connections.Add(id, Context.ConnectionId);

            return base.OnConnected();
        }

        public override Task OnDisconnected()
        {
            var id = Context.QueryString["id"];

            _connections.Remove(id, Context.ConnectionId);

            return base.OnDisconnected();
        }
    }
}