using System.Web;

namespace SignalR.Code
{
    public class CommandHandler
    {
        public static string Parse(string message)
        {
            if (string.IsNullOrEmpty(message))
                return string.Empty;

            if (message.StartsWith("! "))
            {
                //parse command
                if (message.StartsWith("! ip"))
                    message = HttpContext.Current.Request.UserHostAddress;

                if (message.StartsWith("! moustache"))
                    message = Moustachify.Me(message.Replace("! moustache ", ""));
            }
            return message;
        }
    }
}