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
    public partial class Topic : System.Web.UI.Page
    {
        private readonly TopicTypeService t = new TopicTypeService();
        private readonly TopicService s = new TopicService();
        public string TypeId { get { return Request.QueryString["TypeId"]; } }
        public string TopicId { get { return Request.QueryString["TopicId"]; } }
        public Dictionary<string, object> TopicType { get { return t.GetTopicType(TypeId); } }
        protected string GetFullContextPath { get { return WebHelper.GetContextPath(Request); } }
        protected void Page_Load(object sender, EventArgs e)
        {
            var dic = s.GetTopic(TopicId);
            WebHelper.Fill(topicDiv, dic);
            lreplyCount.Text = dic["replyCount"].ToString();
            picUrl.ImageUrl = dic["PicUrl"].ToString();
            rptReply.ItemDataBound += new RepeaterItemEventHandler(rptReply_ItemDataBound);
        }

        void rptReply_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType== ListItemType.AlternatingItem) {
                var t = e.Item.FindControl("ReplyId") as TextBox;
                t.Text = t.Attributes["_id"];
                var rptRefReply = e.Item.FindControl("rptRefReply") as Repeater;
                var sqldas = e.Item.FindControl("SqlDataSource2") as SqlDataSource;
                rptRefReply.DataSource = sqldas;
                rptRefReply.DataBind();
            }
        }
        protected void btnSave_Click(object sender, EventArgs e)
        {
             eReplyId.Text = Guid.NewGuid().ToString();
             SqlDataSource1.Insert();
             detail.Visible = false;
             Response.Redirect(string.IsNullOrEmpty(Request.QueryString["ReturnUrl"]) ? Request.RawUrl : Request.QueryString["ReturnUrl"]);
        }
        protected void btnReplyPost_Click(object sender, EventArgs e)
        {
            var b = sender as Button;
            eReplyId.Text = Guid.NewGuid().ToString();
            eRefReplyId.Text = b.Attributes["_RefReplyId"];
            eContent.InnerText = "";
            //SqlDataSource1.Insert(); 
            detail.Visible = true;
        }
    }
}