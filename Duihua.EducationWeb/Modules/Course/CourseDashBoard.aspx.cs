using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Duihua.EducationWeb.Modules.Course
{
    public partial class CourseDashBoard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) {
                BindCourse();
            }
        }
        private void BindCourse() {
            SqlDataSource1.SelectParameters["userName"].DefaultValue = HttpContext.Current.User.Identity.Name;
            Repeater1.DataSource = SqlDataSource1;
            Repeater1.DataBind();
        }
        protected string GetStatus(object all, object part)
        {
            switch (GetProgress(all, part)) { 
                case 0:
                    return "未开始";
                case 100:
                    return "已结束";
                default:
                    return "进行中";
            }
        }
        protected long GetProgress(object all,object part) {
            long a = long.Parse(all.ToString());
            long b = long.Parse(part.ToString());
            if (b < 0)
                return 0;
            if (b > a)
                return 100;
            else
                return b*100 / a;
        }
        protected void btnGotoCourse_Click(object sender, EventArgs e)
        {
            Button b = sender as Button;
            
            Response.Redirect("CourseDetail.aspx?CourseID=" + b.Attributes["_id"]);
        }

        protected void btnSendMessage_Click(object sender, EventArgs e)
        {
            Button b = sender as Button;
            Response.Redirect("../Message/MessageAdd.aspx?Receivor=" + b.Attributes["_id"] +"&ReturnUrl="+Request.RawUrl);
        }
    }
}