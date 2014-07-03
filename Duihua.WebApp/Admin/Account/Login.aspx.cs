using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Duihua.Lib.Common;

namespace Duihua.WebApp.Admin.Account
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            RegisterHyperLink.NavigateUrl = "Register.aspx?ReturnUrl=" + HttpUtility.UrlEncode(Request.QueryString["ReturnUrl"]);
            if (!string.IsNullOrEmpty(Page.User.Identity.Name)) {
                Response.Redirect("~/Admin/Default.aspx");
            }
        }
        protected void CustomValidator1_ServerValidate(object source, ServerValidateEventArgs args)
        {
            TextBox tbValidateCode = WebHelper.FindControl(LoginUser, "tbValidateCode") as TextBox;
            CustomValidator cvValidateCode = WebHelper.FindControl(LoginUser, "cvValidateCode") as CustomValidator;
            string validateCode = string.Empty;
            if(Session["CheckStr"]==null){
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
