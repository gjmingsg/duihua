using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Duihua.Lib.Services.Education;

namespace Duihua.EducationWeb.Layout
{
    public partial class Course : System.Web.UI.MasterPage
    {
        
        protected string Url { get { return Request.RawUrl; } }
        private readonly CourseService c = new CourseService();
        private readonly HomeWorkService h = new HomeWorkService();
        public string CourseID { get { return Request.QueryString["CourseID"]; } }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ImgShowImg.ImageUrl = CourseInfo["Cover"].ToString();
            }
        }

        public Dictionary<string, object> CourseInfo
        {
            get
            {
                var result = HttpRuntime.Cache.Get("Course" + CourseID);
                if (result == null)
                {
                    result = c.GetCourse(CourseID);
                    HttpRuntime.Cache.Insert("Course" + CourseID, result, null, DateTime.Now.AddHours(1), TimeSpan.Zero);
                }
                return result as Dictionary<String, Object>;
            }
        }

        public List<Dictionary<string, object>> HomeWork {
            get {
                var result = HttpRuntime.Cache.Get("HomeworkByCourseID" + CourseID);
                if (result == null)
                {
                    result = h.GetHomeworkByCourseID(CourseID);
                    HttpRuntime.Cache.Insert("HomeworkByCourseID" + CourseID, result, null, DateTime.Now.AddHours(1), TimeSpan.Zero);
                }
                return result as List<Dictionary<string, object>>;
            }
        }
    }
}