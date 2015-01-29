using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Duihua.Lib.Services.Education;
using Duihua.Lib.Common;

namespace Duihua.EducationWeb.Modules.Homework
{
    public partial class WorkResultView : System.Web.UI.Page
    {
        public string WorkResultId { get { return Request.QueryString["WorkResultID"] + ""; } }
        private readonly WorkResultService s = new WorkResultService();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) {
                if (string.IsNullOrEmpty(WorkResultId))
                    return;
                Attachment1.ModuleId = WorkResultId;
                Attachment1.ModuleName = "WorkResult";
                Attachment1.Bind();
                WebHelper.Fill(view, s.GetWorkResult(WorkResultId));
            }
        }
    }
}