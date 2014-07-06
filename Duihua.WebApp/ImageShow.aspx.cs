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
    public partial class ImageShow : System.Web.UI.Page
    {

        private readonly ILog log = LogManager.GetLogger(typeof(ImageShow));
        public string aID { get { return Request.QueryString["ID"]; } }
        private readonly ArticleService a = new ArticleService();
        private Dictionary<String, Object> Article
        {
            get
            {
                var result = a.GetArticle(aID);
                return result as Dictionary<String, Object>;
            }
        }
        public string ArticleContent
        {
            get
            {
                if (Article.ContainsKey("Content"))
                    return Article["Content"].ToString();
                return "不存在该文章";
            }
        }
        public string ArticleTitle
        {
            get
            {
                if (Article.ContainsKey("Title"))
                    return Article["Title"].ToString();
                return "不存在该文章";
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {

        }
    }
}