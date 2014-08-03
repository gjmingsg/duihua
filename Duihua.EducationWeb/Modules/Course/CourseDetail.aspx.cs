using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Duihua.Lib.Services.Education;

namespace Duihua.EducationWeb.Modules.Course
{
    public partial class CourseDetail : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) {
                SecurityBind();
            }
        }
      

        private void SecurityBind()
        {
            btnSubmitNotice.Visible = HttpContext.Current.User.IsInRole("教师");
           
        }
    }
}