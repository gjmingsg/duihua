using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Duihua.Lib.Services.Education;
using Duihua.Lib.Common;
using System.Web.Security;
using System.Configuration;

namespace Duihua.EducationWeb.Modules.Account
{
    public partial class TeacherList : System.Web.UI.Page
    {
        private readonly TeacherService cg = new TeacherService();
        private string RoleName {
            get {
                if ("A".Equals(Request.QueryString["Role"]))
                    return "教务";
                else
                    return "教师"; 
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            AspNetPager1.RecordCount = cg.GetTeacherCount(sTeachName.Text, RoleName);
            lblCount.Text = AspNetPager1.RecordCount.ToString();
            if (!Page.IsPostBack)
            {
                hdbegin.Value = ((AspNetPager1.CurrentPageIndex - 1) * AspNetPager1.PageSize + 1).ToString();
                hdend.Value = ((AspNetPager1.CurrentPageIndex) * AspNetPager1.PageSize).ToString();
                SqlDataSource1.SelectParameters["RoleName"].DefaultValue = RoleName;
                
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

        protected void lbOperator_Click(object sender, EventArgs e)
        {

            LinkButton b = sender as LinkButton;
            var id = (b.Attributes["_Id"] + "").ToString();
            if ("Edit".Equals(b.CommandName))
            {
                list.Visible = false;
                detail.Visible = true;
                var c = cg.GetTeacher(id);
                WebHelper.Fill(detail, c);
            }
            else if ("View".Equals(b.CommandName))
            {
                list.Visible = false;
                view.Visible = true;
                var c = cg.GetTeacher(id);

                WebHelper.Fill(view, c);
            }
            else if ("Delete".Equals(b.CommandName))
            {
                SqlDataSource1.DeleteParameters["UserId"].DefaultValue = id;
                SqlDataSource1.Delete();
                AspNetPager1.RecordCount = cg.GetTeacherCount(sTeachName.Text,RoleName) - 1;
                lblCount.Text = AspNetPager1.RecordCount.ToString();

            }
        }

        protected void SqlDataSource1_Inserting(object sender, SqlDataSourceCommandEventArgs e)
        {
            //Random t = new Random(DateTime.Now.Second);
            Membership.CreateUser(eTeachName.Text, "123456");
            var id = Membership.GetUser(eTeachName.Text).ProviderUserKey.ToString();
            Roles.AddUsersToRole(new string[] { eTeachName.Text },RoleName);
           
            e.Command.Parameters["@UserId"].Value = id;
        }

        protected void SqlDataSource1_Deleting(object sender, SqlDataSourceCommandEventArgs e)
        {
            var id = e.Command.Parameters["@UserId"].Value;
            var stu = cg.GetTeacher(id.ToString());
            Membership.DeleteUser(stu["TeachName"].ToString(), true);
        }

        protected void SqlDataSource1_Updating(object sender, SqlDataSourceCommandEventArgs e)
        {

        }
        private readonly ImageHelper h = new ImageHelper();
        protected void btnUpload_Click(object sender, EventArgs e)
        {
            int size = 2;           //文件大小限制,单位MB                             //文件大小限制，单位MB
            string[] filetype = { ".gif", ".png", ".jpg", ".jpeg", ".bmp" };         //文件允许格式
            if (!fPicUrl.HasFile)
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
            var fileName = Guid.NewGuid().ToString() + "_" + fPicUrl.FileName;
            var path = ConfigurationManager.AppSettings["Attachment"] + "/img/";

            fPicUrl.SaveAs(Server.MapPath(path) + fileName);
            string targetFileName = h.ThumbPic(Server.MapPath(path), fileName, 250, 150, true);
            ePicUrl.Text = path + targetFileName;
            ImgPicUrl.ImageUrl = ePicUrl.Text;
            ImgPicUrl.Visible = true;

        }

        private bool checkType(string[] filetype)
        {
            string[] temp = fPicUrl.FileName.Split('.');
            var currentType = "." + temp[temp.Length - 1].ToLower();
            return Array.IndexOf(filetype, currentType) == -1;
        }

        private bool checkSize(int size)
        {
            return fPicUrl.PostedFile.ContentLength >= (size * 1024 * 1024);
        }

    }
}