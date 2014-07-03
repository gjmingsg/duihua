using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using Duihua.Lib.Common;
namespace Duihua.WebApp.Admin
{
    public partial class SiteMaster : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {

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
