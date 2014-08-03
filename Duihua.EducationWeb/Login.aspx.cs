using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Duihua.Lib.Common;
using Duihua.Lib.Services.Education;
using System.Web.Security;

namespace Duihua.EducationWeb
{
    public partial class Login : System.Web.UI.Page
    {
        private readonly StudentService s = new StudentService();
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }
        protected void CustomValidator1_ServerValidate(object source, ServerValidateEventArgs args)
        {
          
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

        protected void LoginButton_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(tbStudentID.Text) || string.IsNullOrEmpty(tbPersonalID.Text))
            {
                FailureText.Text = "登录失败，学号或者身份证号不能为空。";
            }
            else {
                var student = s.GetStudent(tbPersonalID.Text, tbStudentID.Text);
                if (student!=null)
                {
                    FormsAuthentication.SetAuthCookie(student["StudentName"].ToString(), false);
                    //Session["UserId"] = student["UserId"];
                    Session.Add("UserId", student["UserId"]);
                    Response.Redirect("~/Modules/Default.aspx");
                }
                else {
                    FailureText.Text = "登录失败，学号或者身份证号错误。";
                }
            }
        }
    }
}
