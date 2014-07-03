using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;

namespace Duihua.WebApp.Admin.Account
{
    public partial class UserList : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void lbOperator_Click(object sender, EventArgs e)
        {
            LinkButton b = sender as LinkButton;
            var username = (b.Attributes["_username"] + "").ToString();
            Membership.DeleteUser(username);
            Response.Redirect(Request.RawUrl);
        }
    }
}