using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Duihua.Lib.Services;

namespace Duihua.WebApp
{
    public partial class Detail : System.Web.UI.Page
    {
        private readonly DetailService s = new DetailService();
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public List<Dictionary<String, Object>> Menu
        {
            get
            {
                string id = Request.QueryString["ID"];
                return s.LoadMenu(id);
            }
        }
        public List<Dictionary<String, Object>> ArticleList
        {
            get
            {
                string id = Request.QueryString["ID"];
                return s.GetArticleList(id);
            }
        }


        public string Id
        {
            get
            {
                return Request.QueryString["ID"];
            }
        }
    }
}