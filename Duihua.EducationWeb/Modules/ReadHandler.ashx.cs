using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Duihua.EducationWeb.Modules
{
    /// <summary>
    /// ReadHandler 的摘要说明
    /// </summary>
    public class ReadHandler : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            context.Response.Write("Hello World");
            var id = context.Request.QueryString["id"];
            var type = context.Request.QueryString["ItemName"];
            if ("Notice".Equals(type))
                context.Response.Redirect("~/Notice/NoticeDetail.aspx?CourseID="+id);
            else
                context.Response.Redirect("~/Message/MessageDetail.aspx?messageId="+id);
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