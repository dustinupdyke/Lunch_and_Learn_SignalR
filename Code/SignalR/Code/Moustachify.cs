using System;
using System.Collections.Generic;
using System.Net;
using System.Web.Script.Serialization;

namespace SignalR.Code
{
    public static class Moustachify
    {
        public static string Me(string who)
        {
            var url = "https://ajax.googleapis.com/ajax/services/search/images?v=1.0&imgsz=medium&q=" + who;
            var items = new List<string>();

            using (var client = new WebClient())
            {
                var results = client.DownloadString(url);

                var jss = new JavaScriptSerializer();

                var data = jss.Deserialize<dynamic>(results);

                foreach (var item in data["responseData"]["results"])
                    items.Add("<img src='http://mustachify.me/?src=" + item["url"].ToString() + "' />");
            }

            var rnd = new Random();
            var r = rnd.Next(items.Count);
            return items[r];
        }
    }
}