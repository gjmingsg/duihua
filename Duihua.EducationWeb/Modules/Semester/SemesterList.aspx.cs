using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Duihua.Lib.Services.Education;
using Duihua.Lib.Common;

namespace Duihua.EducationWeb.Modules.Semester
{
    public partial class SemesterList : System.Web.UI.Page
    {
        private readonly SemesterService s = new SemesterService();
        protected void Page_Load(object sender, EventArgs e)
        {
            AspNetPager1.RecordCount = s.GetSemesterCount();
            lblCount.Text = AspNetPager1.RecordCount.ToString();
            if (!Page.IsPostBack)
            {
                hdbegin.Value = ((AspNetPager1.CurrentPageIndex - 1) * AspNetPager1.PageSize + 1).ToString();
                hdend.Value = ((AspNetPager1.CurrentPageIndex) * AspNetPager1.PageSize).ToString();
            }
            btnCreate.Click += new EventHandler(btnCreate_Click);
        }
        protected void AspNetPager1_PageChanging(object src, Wuqi.Webdiyer.PageChangingEventArgs e)
        {
            AspNetPager1.CurrentPageIndex = e.NewPageIndex;
            hdbegin.Value = ((AspNetPager1.CurrentPageIndex - 1) * AspNetPager1.PageSize + 1).ToString();
            hdend.Value = ((AspNetPager1.CurrentPageIndex) * AspNetPager1.PageSize).ToString();
        }
        public string GetStatus(object obj)
        {
            string v = obj.ToString();
            string color = string.Empty;
            switch (v)
            {
                case "未结束":
                    color = "active";
                    break;
                case "已结束":
                    color = "danger";
                    break;
            }
            return color;
        }
        protected void btnBackList_Click(object sender, EventArgs e)
        {
            Response.Redirect(Request.RawUrl);
        }
        protected void btnCreate_Click(object sender, EventArgs e)
        {
            list.Visible = false;
            detail.Visible = true;
        }
        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(SemesterID.Text))
            {
                SemesterID.Text = Guid.NewGuid().ToString();
                SqlDataSource1.Insert();
            }
            else {
                SqlDataSource1.Update();
            }
            Response.Redirect(Request.RawUrl);
        }
        protected void lbOperator_Click(object sender, EventArgs e)
        {
            list.Visible = false;
            LinkButton b = sender as LinkButton;
            var id = b.Attributes["_Id"];
            switch (b.Text) {
                case "结束学年":
                    s.UpdateFinish(id);
                    Response.Redirect(Request.RawUrl);
                    break;
                case "删除":
                    SqlDataSource1.DeleteParameters["SemesterID"].DefaultValue = id;
                    SqlDataSource1.Delete();
                    AspNetPager1.RecordCount =s.GetSemesterCount() - 1;
                    lblCount.Text = AspNetPager1.RecordCount.ToString();
                    Response.Redirect(Request.RawUrl);
                    break;
                case "修改":
                    WebHelper.Fill(detail, s.GetSemester(id));
                    detail.Visible = true;
                    break;
                case "查看":
                    WebHelper.Fill(view, s.GetSemester(id));
                    view.Visible = true;
                    break;
            }
        }



    }
}