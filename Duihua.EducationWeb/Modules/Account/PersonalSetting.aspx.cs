using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Duihua.Lib.Services.Education;
using Duihua.Lib.Common;
using System.Web.Security;

namespace Duihua.EducationWeb.Modules.Account
{
    public partial class PersonalSetting : System.Web.UI.Page
    {
        private readonly StudentService s = new StudentService();
        private readonly TeacherService t = new TeacherService();
        private readonly CooperatorService c = new CooperatorService();
        private readonly UserService u = new UserService();
        public string UserId { get { return Request.QueryString["UserId"]+""; } }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) {
                if (Person != null && Person.ContainsKey("PicUrl"))
                    imgPicUrl.ImageUrl = Person["PicUrl"].ToString();
                WebHelper.Fill(baseInfo, Person);

                ///如果是同一个人，或者是直接登录后查看个人信息的，可以进行修改
                if (string.IsNullOrEmpty(UserId) || UserId.Equals(Session["UserId"]))
                    btnModify.Visible = true;
                else
                    btnModify.Visible = false;
            }
        }
        public SystemUserRole Role { get { return GetUserRole(); } }

        public Dictionary<string, object> Person { get {
            if (Session["UserId"] == null)
                Response.Redirect("~/loginT.aspx");
            SystemUserRole temp = GetUserRole();
            Dictionary<string, object> dic = null;
            switch (temp)
            {
                case SystemUserRole.Student:
                    dic = s.GetStudent(Session["UserId"].ToString());
                    break;
                case SystemUserRole.Cooperator:
                    dic = c.GetCooperator(Session["UserId"].ToString());
                    break;
                case SystemUserRole.Teacher:
                case SystemUserRole.SuperTeacher:
                    dic = t.GetTeacher(Session["UserId"].ToString());
                    break;
                default:
                    dic = u.GetUser(Session["UserId"].ToString());
                   
                    break;
            }
            if (!dic.ContainsKey("Intro"))
                dic.Add("Intro", "暂无说明.");
            return dic;
              
        } }
        /// <summary>
        /// 获取当前人所具有的角色
        /// </summary>
        /// <returns></returns>
        private SystemUserRole GetUserRole()
        {
            var list = Enum.GetValues(typeof(SystemUserRole));
            foreach (var item in list)
            {
                var e = (SystemUserRole)item.ChangeType(typeof(SystemUserRole));
                var t = e.ToDisplayArray()[(int)e];
                if (HttpContext.Current.User.IsInRole(e.GetDescription()))
                    return e;
            }
            return SystemUserRole.Student;
        }

        protected void btnModify_Click(object sender, EventArgs e)
        {
            view.Visible = false;
            edit.Visible = true;
            WebHelper.Fill(edit, Person);
        }
        protected void btnBackList_Click(object sender, EventArgs e){
            view.Visible = true;
            edit.Visible = false;
        }
        protected void btnSave_Click(object sender, EventArgs e) { 
            
        }
        protected void btnUpload_Click(object sender, EventArgs e)
        { }

        protected void sdStudent_Updating(object sender, SqlDataSourceCommandEventArgs e)
        {
            var id = e.Command.Parameters["@UserId"].Value;
            var stu = s.GetStudent(id.ToString());
            var u = Membership.GetUser(stu["StudentName"].ToString());
            u.Email = eEmail.Text;

            Membership.UpdateUser(u);
        }
        protected void sdTeacher_Updating(object sender, SqlDataSourceCommandEventArgs e)
        { }
        protected void sdCooperator_Updating(object sender, SqlDataSourceCommandEventArgs e)
        { }
    }
}