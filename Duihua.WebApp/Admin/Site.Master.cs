using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using Duihua.Lib.Common;
using log4net;
namespace Duihua.WebApp.Admin
{
    public partial class SiteMaster : System.Web.UI.MasterPage
    {
        private readonly ILog log = LogManager.GetLogger(typeof(SiteMaster));
        protected void Page_Load(object sender, EventArgs e)
        {
            log.Info("通过PC访问，来自IP:" + Request.UserHostAddress + "的访问【" + Request.RawUrl + "】");
        }
        public String GetFullContextPath
        {
            get
            {
                return WebHelper.GetContextPath(this);
            }
        }
      
    }
}
