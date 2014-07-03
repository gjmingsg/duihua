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
    public partial class Detail : System.Web.UI.Page
    {
        private readonly DetailService s = new DetailService();
        private readonly ILog log = LogManager.GetLogger(typeof(Detail));
        protected void Page_Load(object sender, EventArgs e)
        {
            log.Info("来自IP:" + Request.UserHostAddress + "的访问");
        }

        public List<Dictionary<String, Object>> Menu
        {
            get
            {
                 
                return s.LoadMenu(Id);
            }
        }
        public List<Dictionary<String, Object>> ArticleList
        {
            get
            {
                 
                return s.GetArticleList(Id);
            }
        }


        public string Id
        {
            get
            {
                return Request.QueryString["ID"].ToUpper();
            }
        }
    }
}