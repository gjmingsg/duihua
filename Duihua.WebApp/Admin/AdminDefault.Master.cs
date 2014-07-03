using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using System.Text;
using Duihua.Lib.Common;
using log4net;

namespace Duihua.WebApp.Admin
{
    public partial class AdminDefault : System.Web.UI.MasterPage
    {
        private readonly ILog log = LogManager.GetLogger(typeof(AdminDefault));

        protected void Page_Load(object sender, EventArgs e)
        {
            log.Info("来自IP:" + Request.UserHostAddress + "的访问。访问者：" + Page.User.Identity.Name);
            if (string.IsNullOrEmpty(Page.User.Identity.Name))
            {
                Response.Redirect("~/Admin/Account/Login.aspx");
                return;
            }
            if (!Page.IsPostBack)
            {
                ltuserName.Text = Page.User.Identity.Name;
                
            }

            BuildMenu(); 
        }

        public  String GetFullContextPath
        {
            get
            {
                return WebHelper.GetContextPath(this);
            }
        }
        protected void lbLogout_Click(object sender, EventArgs e)
        {
            FormsAuthentication.SignOut();
            Request.Cookies.Remove(FormsAuthentication.FormsCookieName);
            FormsAuthentication.RedirectToLoginPage();
        }


        private void BuildMenu() 
        {
            string topTitle = string.Empty;
            string secondTitle = string.Empty;

            StringBuilder top = new StringBuilder("<ul class='tabList'>");
            StringBuilder second = new StringBuilder("<ul id='menu_level2_list'>");
            SiteMapNodeCollection list = SiteMap.RootNode.ChildNodes;
            SiteMapNode tempNode = SiteMap.CurrentNode;
            if (tempNode != null)
            {
                string curTitle =  tempNode.Title;
                if (tempNode.HasChildNodes)
                {
                    ///点击一级菜单时
                    topTitle = curTitle;
                    secondTitle = tempNode.ChildNodes[0].Title;
                }
                else
                {
                    ////点击二级菜单时
                    topTitle = tempNode.ParentNode.Title;
                    secondTitle = curTitle;
                }
            }
            if (list == null)
                return;
            foreach (SiteMapNode temp in list) 
            {
                if (topTitle.Equals(temp.Title))
                {
                    top.Append("<li><a href='").
                        Append(temp.ChildNodes[0].Url).
                        Append("' class='current' >").
                        Append(temp.Title).
                        Append("</a></li>");
                    foreach (SiteMapNode tempSec in temp.ChildNodes) 
                    {
                        if (secondTitle.Equals(tempSec.Title))
                        {
                            second.Append("<li><a class='current' href='").
                                Append(tempSec.Url).
                                Append("'>").
                                Append(tempSec.Title).
                                Append("</a></li>");
                        }
                        else 
                        {
                            second.Append("<li><a  href='").
                               Append(tempSec.Url).
                               Append("'>").
                               Append(tempSec.Title).
                               Append("</a></li>");
                        }
                    }
                    
                }
                else
                {
                    if (temp.HasChildNodes)
                    top.Append("<li><a href='").
                        Append(temp.ChildNodes[0].Url).
                        Append("' >").
                        Append(temp.Title).
                        Append("</a></li>");
                }
            }
            top.Append("</ul>");
            second.Append("</ul>");
            ltTopMenu.Text = top.ToString();
            ltSecondMenu.Text = second.ToString();

        }
    }
}
