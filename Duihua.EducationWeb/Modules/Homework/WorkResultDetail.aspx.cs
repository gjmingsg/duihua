using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Duihua.Lib.Services.Education;
using Duihua.Lib.Common;
using System.Data.Common;

namespace Duihua.EducationWeb.Modules.Homework
{
    public partial class WorkResultDetail : System.Web.UI.Page
    {
        private readonly HomeWorkService h = new HomeWorkService();
        private readonly WorkResultService w = new WorkResultService();
        protected void Page_Load(object sender, EventArgs e)
        {
            ErrorPlan.Visible = false;
            if (!IsPostBack) {
                Attachment.ModuleName = "HomeWork";
                Attachment.ModuleId = WorkID;
                Attachment.Bind();
                BindSaveButton();
                SecurityBind();
            }
        }

        public string WorkID { get { return Request.QueryString["WorkID"] + ""; } }
        /// <summary>
        /// 设置学生查看评分结果按钮
        /// </summary>
        private void BindViewScore() {
            if (string.IsNullOrEmpty(lbScore.Text))
                btnViewScore.Visible = false;
            else
                btnViewScore.Visible = true;
        }
        private void BindSaveButton()
        {
            if (IsDeadline) {
                btnSave.Enabled = false;
                btnSave.Text = "已过期";
                WorkTips.Visible = false;
                Attachment1.EditMode = false;
            }
            if (!IsBeginTime) {
                btnSave.Enabled = false;
                btnSave.Text = "尚未开始";
            }
        }
        /// <summary>
        /// 是否已经过期了，true则不允许提交作业了
        /// </summary>
        private bool IsDeadline
        { 
            get{

                if ((DateTime.Parse(HomeWork["DeadLine"].ToString()).Ticks - DateTime.Now.Ticks) < 0)
                    return true;
                return false;
            }
        }
        /// <summary>
        /// 是否可以提交作业，true则可以提交作业
        /// </summary>
        private bool IsBeginTime
        {
            get
            {
                if ((DateTime.Parse(HomeWork["BeginTime"].ToString()).Ticks - DateTime.Now.Ticks) < 0)
                    return true;
                return false;
            }
        }
        public Dictionary<string, object> HomeWork
        {
            get
            {
                  return h.GetHomeWork(WorkID);
            }
        }

        protected void btnSubmitWork_Click(object sender, EventArgs e)
        {
            SubmitHomework.Visible = true;
            HomeworkInfo.Visible = false;
            WebHelper.Fill(SubmitHomework, w.GetWorkResult(WorkID, Session["UserId"] + ""));
            if (string.IsNullOrEmpty(tbWorkResultID.Text))
                tbWorkResultID.Text = Guid.NewGuid().ToString();
            Attachment1.ModuleId = tbWorkResultID.Text;
            Attachment1.ModuleName = "WorkResult";
            Attachment1.Bind();
            BindViewScore();
        }
        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(tbWorkID.Text))
                SqlDataSource1.Insert();
            else
                SqlDataSource1.Update();
            Response.Redirect(Request.RawUrl);
        }
        protected void btnEvaluate_Click(object sender, EventArgs e)
        {
            EvaluateWork.Visible = true;
            HomeworkInfo.Visible = false;
        }
        
        private void SecurityBind() {
            btnEvaluate.Visible = HttpContext.Current.User.IsInRole("教师") || HttpContext.Current.User.IsInRole("教务");
            btnSubmitWork.Visible = HttpContext.Current.User.IsInRole("学生");
        }

       

        protected void SqlDataSource2_Updating(object sender, SqlDataSourceCommandEventArgs e)
        {
            
            DbCommand command = e.Command;
            var Score = command.Parameters["@Score"].Value.ToString();
            float t = 0;
            ///填写的内容为数值类型
            if (!float.TryParse(Score, out t))
            {
                ErrorPlan.Visible = true;
                lbError.Text = "填写的分数格式不正确";
                e.Cancel = true;
            }
            ///不能大于总分
            float t2 = float.Parse(HomeWork["Score"].ToString());
            if (t > t2)
            {
                ErrorPlan.Visible = true;
                lbError.Text = "填写的分数格式不能大于作业总分";
                e.Cancel = true;
            }

        }

        
        protected void btnSaveEvaluate_Click(object sender, EventArgs e)
        {
            SqlDataSource2.UpdateParameters["UserId"].DefaultValue = tbUserId.Text;
            SqlDataSource2.UpdateParameters["WorkId"].DefaultValue = eWorkID.Text;
            SqlDataSource2.UpdateParameters["Score"].DefaultValue = eScore.Text;
            SqlDataSource2.UpdateParameters["Evaluate"].DefaultValue = eEvaluate.Text;
            SqlDataSource2.Update();
            list.Visible = true;
            detail.Visible = false;
        }
        protected void lbView_Click(object sender, EventArgs e)
        {
            list.Visible = false;
            detail.Visible = true;
            var b = sender as LinkButton;
            var WorkID = b.Attributes["_WorkID"];
            var UserId = b.Attributes["_UserId"];
            WebHelper.Fill(detail, w.GetWorkResult(WorkID, UserId));
            if (string.IsNullOrEmpty(eWorkResultID.Text))
                eWorkResultID.Text = Guid.NewGuid().ToString();
            Attachment2.ModuleId = eWorkResultID.Text;
            Attachment2.ModuleName = "WorkResult";
            Attachment2.Bind();
            
        }
    }
}