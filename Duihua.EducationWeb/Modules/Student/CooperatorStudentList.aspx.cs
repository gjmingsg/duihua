using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using Duihua.Lib.Common;
using Duihua.Lib.Services.Education;
using System.Web.Security;
using System.IO;
using NPOI.HSSF.UserModel;
using NPOI.SS.UserModel;
using System.Text;


namespace Duihua.EducationWeb.Modules.Student
{
    public partial class CooperatorStudentList : System.Web.UI.Page
    {
        private readonly StudentService s = new StudentService();
        private readonly UserService u = new UserService();
        protected void Page_Load(object sender, EventArgs e)
        {
            AspNetPager1.RecordCount = s.GetStudentCount(sIDCard.Text, sStudentName.Text, sStatus.SelectedValue,Session["UserId"]+"");
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
        
        protected void lbOperator_Click(object sender, EventArgs e)
        {

            LinkButton b = sender as LinkButton;
            var id = (b.Attributes["_Id"] + "").ToString();

             if ("View".Equals(b.CommandName))
            {
                list.Visible = false;
                view.Visible = true;
                var c = s.GetStudent(id);
                WebHelper.Fill(view, c);
                BindImage();
            }
            
        }
        private void BindImage() {
            if (!string.IsNullOrEmpty(tbShowImg.Text)) {
                ImgShowImg.ImageUrl = tbShowImg.Text;
                ImgShowImg.Visible = true;
            }
           
        }
        protected void btnBackList_Click(object sender, EventArgs e)
        {
            Response.Redirect(Request.RawUrl);
        }
        
        

        
    }
}