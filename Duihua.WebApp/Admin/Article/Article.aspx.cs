using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using Duihua.Lib.Services;
using Duihua.Lib.Common;
namespace Duihua.WebApp.Admin.Article
{
    public partial class Article : System.Web.UI.Page
    {
        private readonly ArticleService art = new ArticleService();
        protected void Page_Load(object sender, EventArgs e)
        {
            AspNetPager1.RecordCount = art.GetArticleCount(tbTitle.Text, tbContent.Text, null, null, Request.QueryString["ID"]);
            lblCount.Text = AspNetPager1.RecordCount.ToString();
            if (!Page.IsPostBack)
            {
               // AspNetPager1.RecordCount = art.GetArticleCount(tbTitle.Text,tbContent.Text,ddTypeId.SelectedValue,ddStatus.SelectedValue,Request.QueryString["ID"]);                
                hdbegin.Value = ((AspNetPager1.CurrentPageIndex - 1) * AspNetPager1.PageSize + 1).ToString();
                hdend.Value = ((AspNetPager1.CurrentPageIndex) * AspNetPager1.PageSize).ToString();
               
            }
            
        }
        protected void AspNetPager1_PageChanging(object src, Wuqi.Webdiyer.PageChangingEventArgs e)
        {
            AspNetPager1.CurrentPageIndex = e.NewPageIndex;
            hdbegin.Value = ((AspNetPager1.CurrentPageIndex - 1) * AspNetPager1.PageSize + 1).ToString();
            hdend.Value = ((AspNetPager1.CurrentPageIndex) * AspNetPager1.PageSize).ToString();
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            AspNetPager1.CurrentPageIndex = 1;
        }
        protected void btnNew_Click(object sender, EventArgs e)
        {
            editTemplate.Visible = true;
            listTemplate.Visible = false;
        }
        
        protected void lbOperator_Click(object sender, EventArgs e)
        {
            eTypeId.DataBind();
            LinkButton b = sender as LinkButton;
            var id = (b.Attributes["_Id"]+"").ToString();
            if ("EditArt".Equals(b.CommandName))
            {
                listTemplate.Visible = false;
                editTemplate.Visible = true;
                var c = art.GetArticle(id);
                eContent.InnerText = c["Content"].ToString();
                WebHelper.Fill(editTemplate,c );
            }
            else if("View".Equals(b.CommandName)){
                listTemplate.Visible = false;
                detailTemplate.Visible = true;
                var c = art.GetArticle(id);
                eContent.InnerText = c["Content"].ToString();
                WebHelper.Fill(detailTemplate, c);
            }
            else if ("Delete".Equals(b.CommandName))
            {
                Artsource.DeleteParameters.Add("@ID", id);
                Artsource.Delete();
                AspNetPager1.RecordCount = art.GetArticleCount(tbTitle.Text, tbContent.Text, null, null, Request.QueryString["ID"]) - 1;
                lblCount.Text = AspNetPager1.RecordCount.ToString();

            }
            else if ("Publish".Equals(b.CommandName)) {
                art.PubishArt(id);
                Response.Redirect(Request.RawUrl);
            }
        }

         
        protected void btnBackList_Click(object sender, EventArgs e)
        {
            Response.Redirect(Request.RawUrl);
        }
        protected void btnSave_Click(object sender, EventArgs e) {
            if (string.IsNullOrEmpty(eID.Text))
            {
                eCreator.Text = HttpContext.Current.User.Identity.Name;
                eUpdateUser.Text = HttpContext.Current.User.Identity.Name;
                Artsource.Insert();
            }
            else {
                eUpdateUser.Text = HttpContext.Current.User.Identity.Name;
                Artsource.Update();
            }
            
            Response.Redirect(Request.RawUrl);
        }
        public string FontBaseUrl { get { return ConfigurationManager.AppSettings["FontBaseUrl"]; } }
        protected string GetFullContextPath { get { return WebHelper.GetContextPath(Request); } }
    }
}