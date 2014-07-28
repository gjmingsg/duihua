using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Duihua.Lib.Common;
using Duihua.Lib.Services.Education;

namespace Duihua.EducationWeb.Modules.Class
{
    public partial class ClassList : System.Web.UI.Page
    {
        private readonly ClassGradeService cg = new ClassGradeService();
        protected void Page_Load(object sender, EventArgs e)
        {
            AspNetPager1.RecordCount = cg.GetClassGradeCount(tbClassName.Text,ddSemester.SelectedValue);
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


       

        protected void btnNew_Click(object sender, EventArgs e)
        {
           detail.Visible = true;
           list.Visible = false;
        }
        protected void btnBackList_Click(object sender, EventArgs e)
        {
            
            Response.Redirect(Request.RawUrl);
        }
        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(eID.Text))
            {

                SqlDataSource1.Insert();
            }
            else
            {

                SqlDataSource1.Update();
            }

            Response.Redirect(Request.RawUrl);
        }

        protected void lbOperator_Click(object sender, EventArgs e)
        {
            
            LinkButton b = sender as LinkButton;
            var id = (b.Attributes["_Id"] + "").ToString();
            if ("Edit".Equals(b.CommandName))
            {
                list.Visible = false;
                detail.Visible = true;
                var c = cg.GetClassGrade(id);
                WebHelper.Fill(detail, c);
            }
            else if ("View".Equals(b.CommandName))
            {
                list.Visible = false;
                view.Visible = true;
                var c = cg.GetClassGrade(id);
                WebHelper.Fill(view, c);
            }
            else if ("Delete".Equals(b.CommandName))
            {
                SqlDataSource1.DeleteParameters["ClassID"].DefaultValue=id;
                SqlDataSource1.Delete();
                AspNetPager1.RecordCount = cg.GetClassGradeCount(tbClassName.Text, ddSemester.SelectedValue) -1;
                lblCount.Text = AspNetPager1.RecordCount.ToString();

            }
            //Response.Redirect(Request.RawUrl);
        }
    }
}