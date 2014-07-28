using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Duihua.Lib.Services.Education;

namespace Duihua.EducationWeb.Modules.Common
{
    /// <summary>
    /// DownloadHandler 的摘要说明
    /// </summary>
    public class DownloadHandler : IHttpHandler
    {
        private readonly AttachmentService a = new AttachmentService();
        public void ProcessRequest(HttpContext context)
        {
            string id = context.Request.QueryString["ID"];
            var dic = a.GetAttachment(id);
            string path = dic["Path"].ToString();
            context.Response.ContentType = "application/octet-stream";
            context.Response.AddHeader("Content-Disposition", "attachment; filename=" + System.Web.HttpUtility.UrlEncode(System.Text.Encoding.GetEncoding(65001).GetBytes(dic["filename"].ToString())) + "");
            context.Response.WriteFile(context.Server.MapPath(path) + "\\" + dic["AttachmentName"].ToString());
            a.IncDownloadCount(id);
            context.Response.Flush();
            context.Response.End();
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