using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Duihua.Lib.Services.Education;
using System.Text;

namespace Duihua.EducationWeb.Modules.KPI
{
    public partial class KPIResultDetail : System.Web.UI.Page
    {
        public string CourseID { get { return Request.QueryString["CourseID"]; } }
        public string KPIReleaseId { get { return Request.QueryString["KPIReleaseId"]; } }
        private readonly KPIService kpi = new KPIService();
        private readonly Dictionary<string, string> Color = new Dictionary<string, string> (){
        { "#F7464A", "#FF5A5E" }, { "#46BFBD", "#5AD3D1" }, { "#FDB45C", "#FFC870" }, { "#949FB1", "#A8B3C5" },
        { "#4D5360", "#616774" }, {"#0066CC", "#0066FF"}, {"#00CC00","#00FF00"},{"#660066","#660099"},
        {"#6600CC","#6633CC"},{"#990000","#993300"},{"#993399","#996699"},{"#CC3300","#CC3333"},{"#CCFF00","#CCFF33"},
        {"#FF3300","#FF3333"},{"#FF33CC","#FF33FF"},{"#FF9900","#FF9933"},{"#FFCC00","#FFCC33"},{"#FFFF00","#FFFF33"},
        {"#CC99CC","#CC99FF"},{"#99FF99","#99FFCC"},{"#996699","#9966FF"},{"#66FFCC","#66FFFF"} };
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                commentDiv.Visible = User.IsInRole("教务") || User.IsInRole("管理员");
            }
        }

        public string KPIResultDetailData { get {
            string template = @"
					value: {0},
					color: '{1}',
					highlight: '{2}',
					label: '{3}'";
            StringBuilder sb = new StringBuilder();
            if (string.IsNullOrEmpty(CourseID) || string.IsNullOrEmpty(KPIReleaseId))
                return "";
            var list = kpi.GetKPICourseResultDetail(new Dictionary<string, object>() { { "KPIReleaseId", KPIReleaseId }, { "CourseID", CourseID } });
             
            int i = 0;
            foreach (var item in list) {
                sb.Append("{").Append(string.Format(template, item["sumscore"], Color.Keys.ElementAt(i), Color[Color.Keys.ElementAt(i)], item["KPIName"])).Append("},");
                i = (++i) % Color.Keys.Count;
            }
            return sb.ToString().TrimEnd(',');
        } }
    }
}