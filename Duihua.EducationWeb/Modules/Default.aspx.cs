using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Duihua.Lib.Services.Education;
using System.Collections;

namespace Duihua.EducationWeb.Modules
{
    public partial class Default : System.Web.UI.Page
    {
        private readonly ComMessageService message = new ComMessageService();
        private readonly NoticeService notice = new NoticeService();
        protected void Page_Load(object sender, EventArgs e)
        {
            var userid = Session["UserId"]+"";

            if (!IsPostBack) {
                var mcount = message.GetUnReadMessage(userid);
                var ncount = notice.GetUnReadNotice(userid);
                if(mcount>0)
                    lmessage.Text = string.Format("有<strong><span class='label label-danger'><a href='Message/PersonMessage.aspx'>{0}</a></span></strong>条未读消息。", mcount);
                if(ncount>0)
                    lmessage.Text = string.Format("有<strong><span class='label label-danger'><a href='Notice/PersonNotice.aspx'>{0}</a></span></strong>条未读通知。", ncount);
            }
        }
        public bool IsInRole(IList roles) {
           
            foreach (var r in roles) {
                if (User.IsInRole(r.ToString()))
                    return true;
            }
            return false;
            
        }
      
    }
}