using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;

namespace Duihua.EducationWeb
{
    public partial class logout : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            FormsAuthentication.SignOut();
            Session.Abandon();
            Request.Cookies.Remove(FormsAuthentication.FormsCookieName);
            Response.Redirect("~/Default.aspx");
            //FormsAuthentication.RedirectToLoginPage();

        }
    }
}