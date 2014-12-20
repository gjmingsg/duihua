using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Duihua.Lib.Services.Education;
using Duihua.Lib.Common;

namespace Duihua.EducationWeb.Modules.Common
{
    public partial class MessageEdit : System.Web.UI.UserControl
    {
        public string EditTitle { get { return ToolTips.Text; } set { ToolTips.Text = value; } }
        public string Receivor { get { return Receive.Text; } set { Receive.Text = value; } }
        public string RefId { get { return RefMessageId.Text; } set { RefMessageId.Text = value; } }
        public string MessageTitle { get { return Title.Text; } set { Title.Text = value; } }
        public string MessageContent { get { return Content.InnerText; } set { Content.InnerText = value; } }
        private readonly ComMessageService s = new ComMessageService();
        public bool IsShowTitle { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                titlegroup.Visible = IsShowTitle;
            }
        }
        public void Bind(string id)
        {
            var item = s.GetMessage(id);
            WebHelper.Fill(panelbody, item);
            Content.InnerText = item["Content"] + "";
        }
        public void Save()
        {
            if (string.IsNullOrEmpty(MessageId.Text))
            {
                MessageId.Text = Guid.NewGuid().ToString();
                s.InsertMessage(MessageId.Text, Content.InnerText, Title.Text, Session["UserId"] + "", Receivor, RefId);
            }
            else
            {
                s.UpdateMessage(Title.Text, Content.InnerText, MessageId.Text);
            }

            Response.Redirect(string.IsNullOrEmpty(Request.QueryString["ReturnUrl"]) ? Request.RawUrl : Request.QueryString["ReturnUrl"]);
        }
        
        protected string GetFullContextPath { get { return WebHelper.GetContextPath(Request); } }

        protected void btnBackList_Click(object sender, EventArgs e)
        {
            Response.Redirect(string.IsNullOrEmpty(Request.QueryString["ReturnUrl"]) ? Request.RawUrl : Request.QueryString["ReturnUrl"]);
        }
        protected void btnSave_Click(object sender, EventArgs e)
        {
            Save();
        }
    }
}