using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using log4net;
using Duihua.Lib.Services;

namespace Duihua.WebApp
{
    public partial class ImageList : System.Web.UI.Page
    {
        private readonly ILog log = LogManager.GetLogger(typeof(ImageList));
        public string aID { get { return Request.QueryString["ID"]; } }
        private readonly ArticleService a = new ArticleService();
        public List<Dictionary<String, Object>> ArticleList {
            get {
                //var result = HttpRuntime.Cache.Get(aID);
                //if (result == null)
                //{
                //    result = a.GetArticle(aID);
                //    HttpRuntime.Cache.Insert(aID, result, null, DateTime.Now.AddHours(1), TimeSpan.Zero);
                //}
                //return result as Dictionary<String, Object>;
                return a.GetArticleList(aID);
            }
        }
        //public string Content
        //{
        //    get
        //    {
        //        var item = Article;
        //        if (item.ContainsKey("Content"))
        //            return item["Content"].ToString();
        //        return "不存在该文章";
        //    }
        //}
        //public string ArticleTitle
        //{
        //    get
        //    {
        //        var item = Article;
        //        if (item.ContainsKey("Title"))
        //            return item["Title"].ToString();
        //        return "不存在该文章";
        //    }
        //}
        protected void Page_Load(object sender, EventArgs e)
        {
            log.Info("来自IP:" + Request.UserHostAddress + "的访问");
        }
    }
}