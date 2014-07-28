using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Duihua.Lib.Services.Education;
using Duihua.Lib.Common;

namespace Duihua.EducationWeb.Modules.Homework
{
    public partial class HomeworkList : System.Web.UI.Page
    {
        private readonly HomeWorkService cg = new HomeWorkService();
        protected void Page_Load(object sender, EventArgs e)
        {
            AspNetPager1.RecordCount = cg.GetHomeWorkCount(tbGradeName.Text, tbCourseName.Text, tbTitle.Text, Request.QueryString["CourseID"]);
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
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            AspNetPager1.CurrentPageIndex = 1;

        }

        public string GetStatus(object obj) {
            string v = obj.ToString();
            string color = string.Empty;
            switch (v) {
                case "未开始":
                    color = "active";
                    break;
                case "进行中":
                    color = "success";
                    break;
                case "已结束":
                    color = "danger";
                    break;
                default:
                    color = "warning";
                    break;
            }
            return color;
        }


        protected void btnBackClassList_Click(object sender, EventArgs e)
        {
            Response.Redirect(Request.QueryString["ReturnUrl"]);
        }
        protected void btnNew_Click(object sender, EventArgs e)
        {
            detail.Visible = true;
            list.Visible = false;
            hdMode.Value = "New";
            eID.Text = Guid.NewGuid().ToString();
            Attachment1.ModuleId = eID.Text;
            Attachment1.ModuleName = "HomeWork";
            Attachment1.Bind();
          
        }
        protected void btnBackList_Click(object sender, EventArgs e)
        {

            Response.Redirect(Request.RawUrl);
        }
        protected void btnSave_Click(object sender, EventArgs e)
        {
            if ("New".Equals(hdMode.Value))
                SqlDataSource1.Insert();
            else
                SqlDataSource1.Update();        
            Response.Redirect(Request.RawUrl);
        }

        protected void lbOperator_Click(object sender, EventArgs e)
        {

            LinkButton b = sender as LinkButton;
            var id = (b.Attributes["_Id"] + "").ToString();
            hdMode.Value = b.CommandName;
            if ("Edit".Equals(b.CommandName))
            {
                list.Visible = false;
                detail.Visible = true;
                var c = cg.GetHomeWork(id);
                WebHelper.Fill(detail, c);
                Attachment1.ModuleId = eID.Text;
                Attachment1.ModuleName = "HomeWork";
                Attachment1.Bind();
            }
            else if ("View".Equals(b.CommandName))
            {
                list.Visible = false;
                view.Visible = true;
                var c = cg.GetHomeWork(id);
                WebHelper.Fill(view, c);
                
                Attachment.ModuleId = tbWorkID.Text;
                Attachment.ModuleName = "HomeWork";
                Attachment.Bind();
            }
            else if ("Delete".Equals(b.CommandName))
            {
                SqlDataSource1.DeleteParameters["WorkID"].DefaultValue = id;
                SqlDataSource1.Delete();
                AspNetPager1.RecordCount = cg.GetHomeWorkCount(tbGradeName.Text, tbCourseName.Text, tbTitle.Text, Request.QueryString["CourseID"]) - 1;
                lblCount.Text = AspNetPager1.RecordCount.ToString();

            }
            //Response.Redirect(Request.RawUrl);
        }
    }
}