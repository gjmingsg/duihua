using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using log4net;

namespace Duihua.EducationWeb
{
    public partial class SiteMaster : System.Web.UI.MasterPage
    {
        private readonly ILog log = LogManager.GetLogger(typeof(SiteMaster));
        protected void Page_Load(object sender, EventArgs e)
        {
            log.Info("通过PC访问，来自IP:" + Request.UserHostAddress + "的访问【" + Request.RawUrl + "】");
        }
    }
}
