using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.SessionState;
using log4net.Config;
using log4net;

using Duihua.Lib.Services;

namespace Duihua.WebApp
{
    public class Global : System.Web.HttpApplication
    {
        private readonly static ConfigService db = new ConfigService();
        /// <summary>
        /// 获取配置信息
        /// </summary>
        public static List<Dictionary<string, object>> Config(string key)
        { 
            var result = HttpRuntime.Cache.Get("Config");
            if (result == null)
            {
                result = db.GetConfigList();
                HttpRuntime.Cache.Insert("Config", result, null, DateTime.Now.AddHours(12), TimeSpan.Zero);
            }
            var temp = result as List<Dictionary<string, object>>;
            return temp.FindAll(t => key.Equals(t["ConfigName"]));
        }
        private readonly ILog log = LogManager.GetLogger(typeof(Global));
        void Application_Start(object sender, EventArgs e)
        {
            DOMConfigurator.ConfigureAndWatch(new System.IO.FileInfo(AppDomain.CurrentDomain.BaseDirectory + @"\Log4net.config"));
            // 在应用程序启动时运行的代码
            log.Debug("Web application starting");
        }

        void Application_End(object sender, EventArgs e)
        {
            //  在应用程序关闭时运行的代码

        }

        void Application_Error(object sender, EventArgs e)
        {
            log.Error(Server.GetLastError());
          //  Response.Redirect("~/Error/503.htm");
        }

        void Session_Start(object sender, EventArgs e)
        {
            // 在新会话启动时运行的代码

        }

        void Session_End(object sender, EventArgs e)
        {
            // 在会话结束时运行的代码。 
            // 注意: 只有在 Web.config 文件中的 sessionstate 模式设置为
            // InProc 时，才会引发 Session_End 事件。如果会话模式设置为 StateServer 
            // 或 SQLServer，则不会引发该事件。

        }

    }
}
