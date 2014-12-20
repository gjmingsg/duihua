using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Duihua.Lib.Services.Education;
using Duihua.Lib.Common;

namespace Duihua.EducationWeb.Modules.Forum
{
    public partial class TopicTypeSub : System.Web.UI.Page
    {
        private readonly TopicTypeService t = new TopicTypeService();
        public string TypeId { get { return Request.QueryString["TypeId"]; } }
        public Dictionary<string, object> TopicType { get { return t.GetTopicType(TypeId); } }
        protected string GetFullContextPath { get { return WebHelper.GetContextPath(Request); } }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) {
            }
        }

        protected void btnCreatePost_Click(object sender, EventArgs e)
        {
            rptTopicList.Visible = false;
            detail.Visible = true;
        }
        protected void btnReplyPost_Click(object sender, EventArgs e)
        {
            var b = sender as Button;
            Response.Redirect("Topic.aspx?TopicId=" + b.Attributes["_id"] + "&TypeId=" + TypeId + "#eContent");
        }
        
        protected void btnSave_Click(object sender, EventArgs e)
        {

            if (string.IsNullOrEmpty(eTopicId.Text))
            {
                eTopicId.Text = Guid.NewGuid().ToString();
                SqlDataSource1.Insert();
            }
            else
                SqlDataSource1.Update();  
            
            Response.Redirect(string.IsNullOrEmpty(Request.QueryString["ReturnUrl"]) ? Request.RawUrl : Request.QueryString["ReturnUrl"]);
        }
        protected void btnBackList_Click(object sender, EventArgs e)
        {
            Response.Redirect(string.IsNullOrEmpty(Request.QueryString["ReturnUrl"]) ? Request.RawUrl : Request.QueryString["ReturnUrl"]);
        }
    }
}