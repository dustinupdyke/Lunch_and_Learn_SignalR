using System;
using Microsoft.AspNet.SignalR;

namespace SignalR.Hubs
{
    public class Whattime : Hub
    {
        public void Isit(string x = null)
        {
            // Call the broadcastMessage method to update clients.
            Clients.All.isit(DateTime.Now.ToLongTimeString());
        }
    }
}