using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Duihua.Lib.Services.Education;
using Duihua.Lib.Common;

namespace Duihua.EducationWeb.Modules.Message
{
    public partial class MessageDetail : System.Web.UI.Page
    {
        public string MessageId { get { return Request.QueryString["MessageId"]; } }
        private readonly ComMessageService message = new ComMessageService();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) {
                var item = message.GetMessage(MessageId);
                WebHelper.Fill(msgDiv, item);
                msg.MessageTitle = "【回复】:" + item["Title"].ToString();
                
            }
        }

        protected void btnReply_Click(object sender, EventArgs e)
        {
            var b = sender as Button;
            msg.Visible = true;
            msg.Receivor = b.Attributes["_id"];
            msg.IsShowTitle = false;
            msg.RefId = MessageId;
        }
    }
}