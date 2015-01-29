using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Duihua.Lib.Services.Education;

namespace Duihua.EducationWeb.Modules.Notice
{
    public partial class CourseNotice : System.Web.UI.Page
    {
        private readonly NoticeService s = new NoticeService();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                SecurityBind();
            }
            btnSubmitNotice.Click += new EventHandler(btnSubmitNotice_Click);
            Repeater1.ItemDataBound += new RepeaterItemEventHandler(Repeater1_ItemDataBound);
            
        }

        void Repeater1_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem) {
                e.Item.FindControl("btnModifyNotice").Visible = HttpContext.Current.User.IsInRole("教师");
                e.Item.FindControl("btnDeleteNotice").Visible = HttpContext.Current.User.IsInRole("教师");
            }
            
        }

        void btnSubmitNotice_Click(object sender, EventArgs e)
        {
            list.Visible = false;
            detail.Visible = true;
            btnSubmitNotice.Visible = false;
            noticeedit.EditTitle = "发布课程公告";
            noticeedit.ModuleId = Master.CourseID;
            noticeedit.ModuleName = "Course";
        }


        private void SecurityBind()
        {
            btnSubmitNotice.Visible = HttpContext.Current.User.IsInRole("教师");
            
        }
        protected void btnDeleteNotice_Click(object sender, EventArgs e) {
            var b = sender as Button;
            var _NoticeID = b.Attributes["_NoticeID"];
            s.DeleteNotice(_NoticeID);
            Repeater1.DataBind();
        }
        protected void btnModifyNotice_Click(object sender, EventArgs e){
            var b = sender as Button;
            var _NoticeID = b.Attributes["_NoticeID"];
            noticeedit.BindNotice(_NoticeID);
            noticeedit.EditTitle = "修改课程公告";
            noticeedit.ModuleId = Master.CourseID;
            noticeedit.ModuleName = "Course";
            list.Visible = false;
            detail.Visible = true;
            btnSubmitNotice.Visible = false;
        }
    }
}