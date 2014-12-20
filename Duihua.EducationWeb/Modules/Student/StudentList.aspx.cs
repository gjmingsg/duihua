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

namespace Duihua.EducationWeb.Modules.Student
{
    public partial class StudentList : System.Web.UI.Page
    {
        private readonly StudentService s = new StudentService();
        protected void Page_Load(object sender, EventArgs e)
        {
            AspNetPager1.RecordCount = s.GetStudentCount(sIDCard.Text, sStudentName.Text, sStatus.SelectedValue,sCooperatorId.SelectedValue);
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
        protected void lbOperator_Click(object sender, EventArgs e)
        {

            LinkButton b = sender as LinkButton;
            var id = (b.Attributes["_Id"] + "").ToString();

            if ("Edit".Equals(b.CommandName))
            {
                list.Visible = false;
                detail.Visible = true;
                var c = s.GetStudent(id);
                WebHelper.Fill(detail, c);
                BindImage();
            }
            else if ("View".Equals(b.CommandName))
            {
                list.Visible = false;
                view.Visible = true;
                var c = s.GetStudent(id);
                WebHelper.Fill(view, c);
                BindImage();
            }
            else if ("Delete".Equals(b.CommandName))
            {
                SqlDataSource1.DeleteParameters["UserId"].DefaultValue = id;
                SqlDataSource1.Delete();
                AspNetPager1.RecordCount = s.GetStudentCount(sIDCard.Text, sStudentName.Text, sStatus.SelectedValue, sCooperatorId.SelectedValue) -1;
                lblCount.Text = AspNetPager1.RecordCount.ToString();
            }
        }
        private void BindImage() {
            if (!string.IsNullOrEmpty(tbShowImg.Text)) {
                ImgShowImg.ImageUrl = tbShowImg.Text;
                ImgShowImg.Visible = true;
            }
            if (!string.IsNullOrEmpty(tbPicUrl.Text))
            {
                ImgPicUrl.ImageUrl = tbPicUrl.Text;
                ImgPicUrl.Visible = true;
            }
        }
        protected void btnBackList_Click(object sender, EventArgs e)
        {
            Response.Redirect(Request.RawUrl);
        }
        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(eUserId.Text))
            {

                SqlDataSource1.Insert();
            }
            else
            {

                SqlDataSource1.Update();
            }

            Response.Redirect(Request.RawUrl);
        }
        private readonly ImageHelper h = new ImageHelper();
        protected void btnUpload_Click(object sender, EventArgs e)
        {
            int size = 2;           //文件大小限制,单位MB                             //文件大小限制，单位MB
            string[] filetype = { ".gif", ".png", ".jpg", ".jpeg", ".bmp" };         //文件允许格式
            if (!ePicUrl.HasFile)
            {
                return;
            }
            if (checkType(filetype))
            {
                return;
            }
            if (checkSize(size))
            {
                return;
            }
            var fileName = Guid.NewGuid().ToString() + "_" + ePicUrl.FileName;
            var path = ConfigurationManager.AppSettings["Attachment"] + "/img/";

            ePicUrl.SaveAs(Server.MapPath(path) + fileName);
            string targetFileName = h.ThumbPic(Server.MapPath(path), fileName, 95, 85, true);
            tbPicUrl.Text = path + targetFileName;
            ImgPicUrl.ImageUrl = tbPicUrl.Text;
            ImgPicUrl.Visible = true;

        }

        private bool checkType(string[] filetype)
        {
            string[] temp = ePicUrl.FileName.Split('.');
            var currentType = "." + temp[temp.Length - 1].ToLower();
            return Array.IndexOf(filetype, currentType) == -1;
        }

        private bool checkSize(int size)
        {
            return ePicUrl.PostedFile.ContentLength >= (size * 1024 * 1024);
        }

        protected void SqlDataSource1_Inserting(object sender, SqlDataSourceCommandEventArgs e)
        {
            //Random t = new Random(DateTime.Now.Second);
            ///密码为身份证号
            Membership.CreateUser(eStudentName.Text,"123456",eEmail.Text);
            
            eUserId.Text = Membership.GetUser(eStudentName.Text).ProviderUserKey.ToString();
            e.Command.Parameters["@UserId"].Value = eUserId.Text;
            Roles.AddUsersToRole(new string[] { eStudentName.Text }, "学生");
            eStuNumber.Text = string.Format("{0:yyyyMMdd}", DateTime.Now) + string.Format("{0:00000}", lblCount.Text);
            e.Command.Parameters["@StuNumber"].Value = eStuNumber.Text;
        }

        protected void SqlDataSource1_Deleting(object sender, SqlDataSourceCommandEventArgs e)
        {
            var id =  e.Command.Parameters["@UserId"].Value;
            var stu = s.GetStudent(id.ToString());
            Membership.DeleteUser(stu["StudentName"].ToString(), true);
        }

        protected void SqlDataSource1_Updating(object sender, SqlDataSourceCommandEventArgs e)
        {
            var id = e.Command.Parameters["@UserId"].Value;
            var stu = s.GetStudent(id.ToString());
            var u = Membership.GetUser(stu["StudentName"].ToString());
            u.Email = eEmail.Text;
            
            Membership.UpdateUser(u);
        }

    }
}