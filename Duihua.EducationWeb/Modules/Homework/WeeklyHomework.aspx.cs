using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Duihua.Lib.Services.Education;

namespace Duihua.EducationWeb.Modules.Homework
{
    public partial class WeeklyHomework : System.Web.UI.Page
    {
        private readonly HomeWorkService h = new HomeWorkService();
        private readonly CourseService c = new CourseService();
        protected void Page_Load(object sender, EventArgs e)
        {
            lbEmptyText.Visible = Repeater1.Items.Count == 0;
            Repeater1.ItemDataBound += new RepeaterItemEventHandler(Repeater1_ItemDataBound);
        }

        void Repeater1_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            lbEmptyText.Visible = !(e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem);
        }

        public List<Dictionary<string,object>> MyCourse { 
            get{
                var result = HttpRuntime.Cache.Get("MyCourse");
                if (result == null)
                {
                    result = c.GetMyCourse(HttpContext.Current.User.Identity.Name);
                    HttpRuntime.Cache.Insert("MyCourse", result, null, DateTime.Now.AddHours(2), TimeSpan.Zero);
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
                    HttpRuntime.Cache.Insert("MyHomeWork", result, null, DateTime.Now.AddMinutes(2), TimeSpan.Zero);
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

        protected void btnSubmitWork_Click(object sender, EventArgs e)
        {
            Button b = sender as Button;
            var _WorkID = b.Attributes["_WorkID"];
            var _CourseID = b.Attributes["_CourseID"];
            Response.Redirect(string.Format("~/Modules/Homework/WorkResultDetail.aspx?WorkID={0}&CourseID={1}",_WorkID,_CourseID));
        }
    }
}