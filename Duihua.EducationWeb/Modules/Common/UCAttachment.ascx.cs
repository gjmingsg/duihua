using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using Duihua.Lib.Services.Education;
using System.IO;

namespace Duihua.EducationWeb.Modules.Common
{
    public partial class UCAttachment : System.Web.UI.UserControl
    {
        private readonly AttachmentService a = new AttachmentService();
        public string ModuleName { get { return hdModuleName.Value; } set { hdModuleName.Value = value; } }
        public string ModuleId { get{return hdModuleId.Value;} set{hdModuleId.Value = value;} }
        public string Text { get { return lbControlName.Text; } set { lbControlName.Text = value; } }
        public bool EditMode { get { return bool.Parse( hdEditMode.Value); } set { hdEditMode.Value = value.ToString(); } }
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        public void Bind()
        {
            SqlDataSource2.SelectParameters["ModuleId"].DefaultValue = ModuleId;
            SqlDataSource2.SelectParameters["ModuleName"].DefaultValue = ModuleName;
            Repeater2.DataSource = SqlDataSource2;
            Repeater2.DataBind();
        }
        protected void lbOperator_Click(object sender, EventArgs e)
        { 
            LinkButton b = sender as LinkButton;
            var id = (b.Attributes["_Id"] + "").ToString();
            if ("Delete".Equals(b.CommandName))
            {
                var dic = a.GetAttachment(id);
                SqlDataSource2.DeleteParameters["ID"].DefaultValue = id;
                SqlDataSource2.Delete();
                var filePath = Server.MapPath(dic["Path"].ToString()) + "\\" + dic["AttachmentName"].ToString();
                File.Delete(filePath);
            }
            Bind();
        }
        protected void btnUpload_Click(object sender, EventArgs e)
        {
            int size = int.Parse(ConfigurationManager.AppSettings["AttachmentSize"]);           //文件大小限制,单位MB                             //文件大小限制，单位MB
            string[] filetype = ConfigurationManager.AppSettings["AttachmentType"].Split(new char[] { ',' });        //文件允许格式
            if (!eCover.HasFile)
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
            var fileName = Guid.NewGuid().ToString() + "@" + eCover.FileName;
            var path = ConfigurationManager.AppSettings["Attachment"] + "/file/";

            eCover.SaveAs(Server.MapPath(path) + fileName);

            a.SaveAttachment(fileName, eCover.FileContent.Length.ToString(), path, ModuleName, ModuleId);

            Bind();
        }
        private bool checkType(string[] filetype)
        {
            string[] temp = eCover.FileName.Split('.');
            var currentType = "." + temp[temp.Length - 1].ToLower();
            return Array.IndexOf(filetype, currentType) == -1;
        }

        private bool checkSize(int size)
        {
            return eCover.PostedFile.ContentLength >= (size * 1024 * 1024);
        }
    }
}