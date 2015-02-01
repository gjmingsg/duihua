using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Duihua.Lib.Services.Education;

namespace Duihua.EducationWeb.Modules.Student
{
    public partial class MyCoursemate : System.Web.UI.Page
    {
        private readonly TeacherService t = new TeacherService();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) {
                if (TeacherInfo.Keys.Contains("PicUrl"))
                    ImgTeacher.ImageUrl = TeacherInfo["PicUrl"].ToString().Replace("_small", "");
                if (TeacherInfo.Keys.Contains("TeachName"))
                    ImgTeacher.AlternateText = TeacherInfo["TeachName"].ToString();
           
            }
        }
        /// <summary>
        /// 获取班主任信息
        /// </summary>
        public Dictionary<string, object> TeacherInfo {
            get
            {
                return t.GetTeacherByCourseID(Request.QueryString["CourseID"]);
            }
        }
    }
}