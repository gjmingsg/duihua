using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Duihua.Lib.Services.Education;
using Duihua.Lib.Common;
using System.Collections;
using System.Configuration;

namespace Duihua.EducationWeb.Modules.Course
{
    public partial class CourseList : System.Web.UI.Page
    {
        public string ClassID { get { return Request.QueryString["ClassID"] + ""; } }
        private readonly CourseService cg = new CourseService();
        private readonly ImageHelper h = new ImageHelper();
        protected void Page_Load(object sender, EventArgs e)
        {
            AspNetPager1.RecordCount = cg.GetCourseCount(tbCourseName.Text, tbTeachName.Text, tbClassName.Text,
                ddSemester.SelectedValue, ClassID);
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

        private void BindSemester(string SemesterID)
        {
            eSemesterID.DataSource = SqlDataSource2;
            eSemesterID.DataBind();
            eClassID.DataSource = SqlDataSource4;
            eClassID.DataBind();
            if (string.IsNullOrEmpty(SemesterID))
                return;
            eSemesterID.Items.FindByValue(SemesterID).Selected = true;
        }

        private void BindImage() {
            if (string.IsNullOrEmpty(tbCover.Text) == false)
            {
                ImgCover.ImageUrl = tbCover.Text;
                ImgCover.Visible = true;
            }
            if (string.IsNullOrEmpty(tbShowImg.Text) == false) {
                ImgShowImg.Visible = true;
                ImgShowImg.ImageUrl = tbShowImg.Text;
            }
        }

        protected void btnNew_Click(object sender, EventArgs e)
        {
            detail.Visible = true;
            list.Visible = false;

            eSemesterID.DataSource = SqlDataSource2;
            eSemesterID.DataBind();
            eClassID.DataSource = SqlDataSource4;
            eClassID.DataBind();
        }

        protected void btnBackList_Click(object sender, EventArgs e)
        {
            Response.Redirect(Request.RawUrl);
        }
       
        protected void btnBackClassList_Click(object sender, EventArgs e)
        {
            Response.Redirect(Request.QueryString["ReturnUrl"]);
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
                var c = cg.GetCourse(id);
                if (c.Keys.Contains("SemesterID"))
                    BindSemester((c["SemesterID"] + "").ToString());
                else
                    BindSemester("");
                WebHelper.Fill(detail, c);
               
                BindImage();
            }
            else if ("View".Equals(b.CommandName))
            {
                list.Visible = false;
                view.Visible = true;
                var c = cg.GetCourse(id);
                WebHelper.Fill(view, c);
                BindImage();
            }
            else if ("Delete".Equals(b.CommandName))
            {
                SqlDataSource1.DeleteParameters["CourseID"].DefaultValue = id;
                SqlDataSource1.Delete();
                AspNetPager1.RecordCount = cg.GetCourseCount(tbCourseName.Text, tbTeachName.Text, tbClassName.Text,
                ddSemester.SelectedValue, ClassID) - 1;
                lblCount.Text = AspNetPager1.RecordCount.ToString();
            }
            //Response.Redirect(Request.RawUrl);
        }

        protected void btnUpload_Click(object sender, EventArgs e)
        {
            int size = 10;           //文件大小限制,单位MB                             //文件大小限制，单位MB
            string[] filetype = { ".gif", ".png", ".jpg", ".jpeg", ".bmp" };         //文件允许格式
            if (!eCover.HasFile){
                return;
            }
            if(checkType(filetype)){
                return;
            }
            if (checkSize(size)) {
                return;
            }
            var fileName =  Guid.NewGuid().ToString() + "_" + eCover.FileName;
            var path = ConfigurationManager.AppSettings["Attachment"] + "/img/";

            eCover.SaveAs(Server.MapPath( path) + fileName);
            string targetFileName = h.ThumbPic(Server.MapPath(path), fileName, 250, 150, true);
            tbCover.Text = path + targetFileName;
            ImgCover.ImageUrl = tbCover.Text;
            ImgCover.Visible = true;

        }
       
        private bool checkType(string[] filetype)
        {
            string[] temp = eCover.FileName.Split('.');
            var currentType =  "." + temp[temp.Length - 1].ToLower();
            return Array.IndexOf(filetype, currentType) == -1;
        }
       
        private bool checkSize(int size)
        {
            return eCover.PostedFile.ContentLength >= (size * 1024 * 1024);
        }

        protected void eSemesterID_SelectedIndexChanged(object sender, EventArgs e)
        {
            eClassID.DataSource = SqlDataSource4;
            eClassID.DataBind();
        }
    }
}