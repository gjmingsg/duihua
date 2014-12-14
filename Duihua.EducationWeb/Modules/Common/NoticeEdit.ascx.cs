using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Duihua.Lib.Common;
using Duihua.Lib.Services.Education;

namespace Duihua.EducationWeb.Modules.Common
{
    public partial class NoticeEdit : System.Web.UI.UserControl
    {
        private readonly NoticeService s = new NoticeService();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) {
                if (string.IsNullOrEmpty(NoticeID.Text))
                    NoticeID.Text = Guid.NewGuid().ToString();
            }
        }
        public void BindNotice(string id) {
            var notice = s.GetNotice(id);
            WebHelper.Fill(panelbody, notice);
            Content.InnerText = notice["Content"] + "";
            
        }
        public void SaveNotice() {
            var notice = new Dictionary<string, object>() { { "Title", Title.Text }
                , { "Content", Content.InnerText }
                , { "NoticeID", NoticeID.Text } 
                ,{"ModuleName",ModuleName}
                ,{"ModuleId",ModuleId}
                ,{"creator",Session["UserId"]}};
            s.SaveNotice(notice);
            Response.Redirect(Request.RawUrl);
        }
        public string EditTitle { get { return NoticeToolTips.Text; } set { NoticeToolTips.Text = value; } }
        public string ModuleId { get { return hdModuleId.Value; } set { hdModuleId.Value = value; } }
        public string ModuleName { get { return hdModuleName.Value; } set { hdModuleName.Value = value; } }
        protected string GetFullContextPath { get { return WebHelper.GetContextPath(Request); } }

        protected void btnBackList_Click(object sender, EventArgs e)
        {
            Response.Redirect(Request.RawUrl);
        }
        protected void btnSave_Click(object sender, EventArgs e)
        {
            SaveNotice();
        }
    }
}