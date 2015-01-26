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
    public partial class StudentList : System.Web.UI.Page
    {
        private readonly StudentService s = new StudentService();
        private readonly UserService u = new UserService();
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


        protected void btnImportExcel_Click(object sender, EventArgs e)
        {
            
            string[] filetype = { ".xls"};         //文件允许格式
            if (!fuExcelFile.HasFile)
            {
                return;
            }
            string[] temp = fuExcelFile.FileName.Split('.');
            var currentType = "." + temp[temp.Length - 1].ToLower();
            if (Array.IndexOf(filetype, currentType) == -1)
            {
                return;
            }
           
            var fileName = Guid.NewGuid().ToString() + "@" + fuExcelFile.FileName;
            var path = ConfigurationManager.AppSettings["Attachment"] + "/file/";
            fuExcelFile.SaveAs(Server.MapPath(path) + fileName);

            ImportData(Server.MapPath(path) + fileName);
        }
        private readonly Dictionary<string, string> Column = new Dictionary<string, string>() { 
         {"序号","RowNum"}
        ,{"学号", "StuNumber" }
        ,{"姓名", "StudentName" } 
        ,{"性别","Sex"}
        ,{"班别","ClassName"}
        ,{"宿舍号","RoomId"}
        ,{"身份证","IDCard"}
        ,{"家庭住址","Address"}
        ,{"原所在学校","CooperatorName"}
        ,{"本人电话","Phone"}
        ,{"家长姓名","ParentName"}
        ,{"家长电话","ParentPhone"}
        ,{"入学时间","RegisterTime"}};
        private void ImportData(string strFileName)
        {
            Dictionary<string, object> dic = new Dictionary<string, object>();
            try
            {
                HSSFWorkbook hssfworkbook;
                using (FileStream file = new FileStream(strFileName, FileMode.Open, FileAccess.Read))
                {
                    hssfworkbook = new HSSFWorkbook(file);
                }
                ISheet sheet = hssfworkbook.GetSheetAt(0);
                System.Collections.IEnumerator rows = sheet.GetRowEnumerator();
                IRow headerRow = sheet.GetRow(0);
                int cellCount = headerRow.LastCellNum;
                var keys = Column.Keys.ToList();
                List<string> ulist = new List<string>();
                StringBuilder sb = new StringBuilder();
                for (int i = (sheet.FirstRowNum + 2); i <= sheet.LastRowNum; i++)
                {
                    IRow row = sheet.GetRow(i);
                    dic = new Dictionary<string, object>();
                    for (int j = row.FirstCellNum; j < cellCount; j++)
                    {
                        if (row.GetCell(j)==null)
                            dic.Add(Column[keys[j]],DBNull.Value);
                        else
                            dic.Add(Column[keys[j]], row.GetCell(j).ToString()+"");
                    }
                    dic.Add("SemesterID", SemesterID.SelectedValue);
                    string rs = u.InsertStudent(dic);
                    if(string.IsNullOrEmpty(rs))
                        ulist.Add(dic["StudentName"] + "");
                    else
                        sb.Append(rs);
                }
                if(ulist.Count>0)
                    Roles.AddUsersToRole(ulist.ToArray(), "学生");
                msg.Text = sb.ToString();
            }
            catch (Exception e) {
                msg.Text = e.Message ;
            }
        }
    }
}