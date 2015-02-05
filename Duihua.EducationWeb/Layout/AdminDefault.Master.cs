using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using System.Text;
using Duihua.Lib.Common;
using log4net;

namespace Duihua.WebApp.Admin
{
    public partial class AdminDefault : System.Web.UI.MasterPage
    {
        private readonly ILog log = LogManager.GetLogger(typeof(AdminDefault));
        protected void Page_Load(object sender, EventArgs e)
        {
            
            if (string.IsNullOrEmpty(Page.User.Identity.Name))
            {
                log.Info("通过PC访问，来自IP:" + Request.UserHostAddress + "的访问【" + Request.RawUrl + "】");
                Response.Redirect("~/Logout.aspx");
                return;
            }
            log.Info(Page.User.Identity.Name+"通过PC访问，来自IP:" + Request.UserHostAddress + "的访问【" + Request.RawUrl + "】");
            if (!Page.IsPostBack)
            {
                //ltuserName.Text = Page.User.Identity.Name;
                
            }

           
        }

        public  String GetFullContextPath
        {
            get
            {
                return WebHelper.GetContextPath(this);
            }
        }
        protected void lbLogout_Click(object sender, EventArgs e)
        {
            FormsAuthentication.SignOut();
            Request.Cookies.Remove(FormsAuthentication.FormsCookieName);
            FormsAuthentication.RedirectToLoginPage();
        }


        
    }
}
