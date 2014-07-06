using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Duihua.Lib.Services;
using log4net;

namespace Duihua.WebApp
{
    public partial class Item : System.Web.UI.Page
    {
        private readonly ILog log = LogManager.GetLogger(typeof(Item));
        public string aID { get { return Request.QueryString["ID"]; } }
        private readonly ArticleService a = new ArticleService();
        public string Content { get {
            var item = a.GetArticle(aID);
            if (item.ContainsKey("Content"))
                return item["Content"].ToString();
            return "不存在该文章";
        } }
        protected void Page_Load(object sender, EventArgs e)
        {
            log.Info("来自IP:" + Request.UserHostAddress + "的访问");
        }
    }
}