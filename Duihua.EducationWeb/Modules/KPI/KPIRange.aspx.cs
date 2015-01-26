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
    public partial class KPIRange : System.Web.UI.Page
    {
        public List<string> Color = new List<string>() { 
        "220,220,220", "204,0,0", "0,51,204", "0,204,0", "51,0,0", "51,204,51", "102,0,204","153,0,0",
        "153,0,204","153,51,51","153,51,255","153,102,0","153,102,153","153,204,0","153,204,204",
        "204,0,0","204,0,153","204,0,255","204,102,0","204,153,204","204,204,204","255,0,204","255,255,204",
        "255,255,0","255,102,255","255,102,51","255,51,255","204,255,255","204,255,0","204,102,102","153,204,255"};
        private string GetColorStr(string str) {
            return @" fillColor: 'rgba(" + str + @",0.5)',
			    strokeColor: 'rgba(" + str + @",0.8)',
			    highlightFill: 'rgba(" + str + @",0.75)',
			    highlightStroke: 'rgba(" + str + @",1)',";
        }

        private readonly KPIService kpi = new KPIService();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) { 
                SemesterID.DataBind();
            }
            BindData();
        }
        private void BindData() {
            StringBuilder hs = new StringBuilder();
            StringBuilder sb = new StringBuilder();
            var kl = kpi.GetKPIReleaseIdList(SemesterID.SelectedValue);
            int i = 0;
            foreach (var id in kl)
            {
                var kid = id["KPIReleaseId"] + "";
                var sl = kpi.GetKPICourseOrder(kid, SemesterID.SelectedValue);
                sb.Append("{").Append(GetColorStr(Color[(i++) % Color.Count])).Append("data: [");
                foreach (var item in sl) {
                    if(i==1){
                        var text = "'"+item["CourseName"] + "【" + item["TeachName"] + "】'";
                        hs.Append(text).Append(",");
                    }
                    sb.Append(item["sumscore"]).Append(",");
                }
                if(sl.Count>0)
                    sb.Remove(sb.Length - 1, 1);
                sb.Append("]},");
            }

            Score = sb.ToString().TrimEnd(',');
            KPIName = hs.ToString().TrimEnd(',');
        }
        private string _kpiName;
        public string KPIName
        {
            get { return _kpiName; }
            set { _kpiName = value; }
        }
        private string _score;
        public string Score
        {
            get
            {
                return _score;
            }
            set
            {
                _score = value;
            }
        }
    }
}