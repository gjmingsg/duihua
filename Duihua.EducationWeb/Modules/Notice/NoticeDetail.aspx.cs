using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Duihua.Lib.Services.Education;
using Duihua.Lib.Common;

namespace Duihua.EducationWeb.Modules.Notice
{
    public partial class NoticeDetail : System.Web.UI.Page
    {
        private readonly NoticeService s = new NoticeService();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) {
                var notice = s.GetNotice(Request.QueryString["NoticeID"]);
                WebHelper.Fill(noticeDiv, notice);
            }
        }
    }
}