using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Duihua.Lib.Services.Education;
using System.Web.SessionState;

namespace Duihua.EducationWeb.Modules
{
    /// <summary>
    /// ReadHandler 的摘要说明
    /// </summary>
    public class ReadHandler : IHttpHandler, IReadOnlySessionState
    {
        private readonly NoticeMessageStatusService s = new NoticeMessageStatusService();
        public void ProcessRequest(HttpContext context)
        {
            var id = context.Request.QueryString["id"];
            var type = context.Request.QueryString["ItemName"];
            s.SetStatus(id, context.Session["UserId"] + "", type, "R");
            if ("Notice".Equals(type))
                context.Response.Redirect("~/Modules/Notice/NoticeDetail.aspx?NoticeID=" + id);
            else
                context.Response.Redirect("~/Modules/Message/MessageDetail.aspx?MessageId=" + id);
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}