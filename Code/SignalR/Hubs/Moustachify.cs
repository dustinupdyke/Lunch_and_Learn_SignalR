using Microsoft.AspNet.SignalR;

namespace SignalR.Hubs
{
    public class Moustachify : Hub
    {
        public void Moustache(string who)
        {
            Clients.All.moustache(Code.Moustachify.Me(who));
        }
    }
}