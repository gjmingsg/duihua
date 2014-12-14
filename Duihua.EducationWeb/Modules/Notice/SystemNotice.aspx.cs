using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Duihua.Lib.Services.Education;

namespace Duihua.EducationWeb.Modules.Notice
{
    public partial class SystemNotice : System.Web.UI.Page
    {
        private readonly NoticeService s = new NoticeService();

        protected void Page_Load(object sender, EventArgs e)
        {
            AspNetPager1.RecordCount = s.GetSystemNoticeCount();
            lblCount.Text = AspNetPager1.RecordCount.ToString();
            if (!Page.IsPostBack)
            {

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
        protected void btnNew_Click(object sender, EventArgs e)
        {
            list.Visible = false;
            deteil.Visible = true;
            noticeeditor.ModuleName = "System";
            noticeeditor.EditTitle = "新增公告";
            noticeeditor.ModuleId = Session["UserId"] + "";
        }
        protected void lbOperator_Click(object sender, EventArgs e)
        {

            LinkButton b = sender as LinkButton;
            var id = (b.Attributes["_Id"] + "").ToString();
            
            if ("Edit".Equals(b.CommandName))
            {
                list.Visible = false;
                deteil.Visible = true;
                noticeeditor.ModuleName = "System";
                noticeeditor.EditTitle = "修改公告";
                noticeeditor.ModuleId = Session["UserId"]+"";
                noticeeditor.BindNotice(id);
            }
            else if ("View".Equals(b.CommandName))
            {
               
            }
            else if ("Delete".Equals(b.CommandName))
            {
                SqlDataSource1.DeleteParameters["NoticeID"].DefaultValue = id;
                SqlDataSource1.Delete();
                AspNetPager1.RecordCount = s.GetSystemNoticeCount() - 1;
                lblCount.Text = AspNetPager1.RecordCount.ToString();

            }
            
        }
    }
}