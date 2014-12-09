using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Duihua.Lib.Services.Education;

namespace Duihua.EducationWeb.Modules.Student
{
    public partial class StudentSummary : System.Web.UI.Page
    {
        private readonly HomeWorkService hws = new HomeWorkService();
        private readonly WorkResultService wrs = new WorkResultService();
        public string UserId { get { return Session["UserId"] + ""; } }
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        public string GetScoreBarData(object CourseID)
        {
           
            var hwl = hws.GetHomeworkByCourseID(CourseID.ToString());
            string labels = string.Empty;
            hwl.Select(p => p["Title"]).ToList().ForEach(p => { labels += "'"+p+"',"; });
            
            var wrsl = wrs.GetWorkResultScore(CourseID.ToString(), UserId);
            string data = string.Empty;
            wrsl.Select(p => p["Score"]).ToList().ForEach(p => { data += p + ","; });

            return @"{labels: ["+labels.TrimEnd(new char[] { ',' })+@"],
                        datasets: [
		                {
		                    fillColor: 'rgba(220,220,220,0.5)',
		                    strokeColor: 'rgba(220,220,220,1)',
		                    data: [" + data.TrimEnd(new char[] { ',' }) + @"]}]}";
        }

    }
}