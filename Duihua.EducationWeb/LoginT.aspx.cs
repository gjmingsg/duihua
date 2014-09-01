using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using Duihua.Lib.Common;
using System.Net;

namespace Duihua.EducationWeb
{
    public partial class LoginT : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            LoginUser.LoggedIn += new EventHandler(LoginUser_LoggedIn);
        }

        void LoginUser_LoggedIn(object sender, EventArgs e)
        {
            var username = WebHelper.FindControl(LoginUser, "UserName") as TextBox;
            var o = Membership.GetUser(username.Text);

            Session.Add("UserId", o.ProviderUserKey); 
        }
        protected void CustomValidator1_ServerValidate(object source, ServerValidateEventArgs args)
        {
            TextBox tbValidateCode = WebHelper.FindControl(LoginUser, "tbValidateCode") as TextBox;
            CustomValidator cvValidateCode = WebHelper.FindControl(LoginUser, "cvValidateCode") as CustomValidator;
            string validateCode = string.Empty;
            if (Session["CheckStr"] == null)
            {
                args.IsValid = false;
                cvValidateCode.ErrorMessage = "验证码过期";
                return;
            }
            validateCode = Session["CheckStr"].ToString().ToLower();
            if (tbValidateCode.Text.ToLower().Equals(validateCode))
                args.IsValid = true;
            else
                args.IsValid = false;
        }

      
    }
}