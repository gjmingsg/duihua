using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Duihua.Lib.Services.Education;

namespace Duihua.EducationWeb.Modules.Homework
{
    public partial class HomeworkResult : System.Web.UI.Page
    {
        private readonly HomeWorkService h = new HomeWorkService();
        private readonly CourseService c = new CourseService();
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        public List<Dictionary<string,object>> MyCourse { 
            get{
                var result = HttpRuntime.Cache.Get("MyCourse");
                if (result == null)
                {
                    result = c.GetMyCourse(HttpContext.Current.User.Identity.Name);
                    HttpRuntime.Cache.Insert("MyCourse", result, null, DateTime.Now.AddHours(1), TimeSpan.Zero);
                }
                return result as List<Dictionary<String, Object>>;
            }
        }
        public List<Dictionary<string, object>> MyHomeWork
        {
            get
            {
                var result = HttpRuntime.Cache.Get("MyHomeWork");
                if (result == null)
                {
                    result = h.GetMyHomeWork(HttpContext.Current.User.Identity.Name);
                    HttpRuntime.Cache.Insert("MyHomeWork", result, null, DateTime.Now.AddHours(1), TimeSpan.Zero);
                }
                return result as List<Dictionary<String, Object>>;
            }
        }
        public List<Dictionary<string, object>> GetHomeWorkByCourseID(string CourseID)
        { 
            var rs = from c in MyHomeWork 
                where c["CourseID"].Equals(CourseID)
                         select c;
            return rs.ToList();
        }
    }
}