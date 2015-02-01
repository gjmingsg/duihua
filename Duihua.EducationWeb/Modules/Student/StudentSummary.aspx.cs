using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Duihua.Lib.Services.Education;
using System.Text;

namespace Duihua.EducationWeb.Modules.Student
{
    public partial class StudentSummary : System.Web.UI.Page
    {
        private readonly HomeWorkService hws = new HomeWorkService();
        private readonly WorkResultService wrs = new WorkResultService();
        private readonly ClassGradeService cgs = new ClassGradeService();
        private readonly Dictionary<string, string> Color = new Dictionary<string, string>(){
        { "#F7464A", "#FF5A5E" }, { "#46BFBD", "#5AD3D1" }, { "#FDB45C", "#FFC870" }, { "#949FB1", "#A8B3C5" },
        { "#4D5360", "#616774" }, {"#0066CC", "#0066FF"}, {"#00CC00","#00FF00"},{"#660066","#660099"},
        {"#6600CC","#6633CC"},{"#990000","#993300"},{"#993399","#996699"},{"#CC3300","#CC3333"},{"#CCFF00","#CCFF33"},
        {"#FF3300","#FF3333"},{"#FF33CC","#FF33FF"},{"#FF9900","#FF9933"},{"#FFCC00","#FFCC33"},{"#FFFF00","#FFFF33"},
        {"#CC99CC","#CC99FF"},{"#99FF99","#99FFCC"},{"#996699","#9966FF"},{"#66FFCC","#66FFFF"} };
        public string UserId { get { return Session["UserId"] + ""; } }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) {
                BindCouserName();
                BindClassName();
            }
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
		                    fillColor: 'rgba(100,120,220,0.5)',
		                    strokeColor: 'rgba(220,120,120,1)',
		                    data: [" + data.TrimEnd(new char[] { ',' }) + @"]}]}";
        }
        private void BindCouserName() {
            var l = wrs.GetWorkResultOverallScore(UserId);
            string showLabels = string.Empty;
            var rs = from p in l select new { id = p["CourseID"], name = p["CourseName"] };
            rs.ToList().ForEach(p => { showLabels += "<span class='label label-info'><a href='#hot_"+p.id+"'>" + p.name + "</a></span>&nbsp;&nbsp;"; });
            loverallCourse.Text = showLabels;
        }
        private void BindClassName() {
            var item = cgs.GetMyClassGrade(UserId);
            string className = string.Empty;
            if(item==null)
                className = "目前你还没有加入任何班级";
            else
                className = item["GradeName"].ToString();
            lClassName.Text = "<span class='label label-primary'>"+className+"</span>";
        }
        public string GetOverallScore(){
            var l = wrs.GetWorkResultOverallScore(UserId);
            //string labels = string.Empty;
            StringBuilder data =new StringBuilder();
            int i=0;
            var labels = l.Select(p => p["CourseName"]).ToList();//.ForEach(p => { labels += "'" + p + "',"; });
            l.Select(p => p["Score"]).ToList().ForEach(p => { data.Append("{").AppendFormat("value:{0},color:'{1}',highlight:'{2}',label:'{3}'", p, Color.Keys.ElementAt(i), Color[Color.Keys.ElementAt(i)],labels[i]).Append("},");i++ ; });
            return data.ToString().TrimEnd(new char[] { ',' });
//            return @" {labels : [" + labels.TrimEnd(new char[] { ',' }) + @"],
//	            datasets : [{
//			            fillColor : 'rgba(220,220,220,0.5)',
//			            strokeColor : 'rgba(220,220,220,1)',
//			            pointColor : 'rgba(220,220,220,1)',
//			            pointStrokeColor : '#fff',
//			            data : [" + data.TrimEnd(new char[] { ',' }) + @"]
//		        }]}";
        }

        public string GetAvgScoreOrder() {
            var l = wrs.GetAvgScoreOrder(UserId);
            string labels = string.Empty;
            string data = string.Empty;

            l.Select(p => p["UserId"]).ToList().ForEach(p => { if (UserId.Equals(p.ToString())) labels += "'我',"; else  labels += "'',"; });
            l.Select(p => p["Score"]).ToList().ForEach(p => { data += p + ","; });
            return @" {labels : [" + labels.TrimEnd(new char[] { ',' }) + @"],
	            datasets : [{
			            fillColor : 'rgba(151,187,205,0.5)',
			            strokeColor : 'rgba(151,187,205,1)',
			            pointColor : 'rgba(151,187,205,1)',
			            pointStrokeColor : '#fff',
			            data : [" + data.TrimEnd(new char[] { ',' }) + @"]
		        }]}";
        }
    }
}