using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Duihua.Lib.Common;
using System.Data.Common;

namespace Duihua.EducationWeb.Modules.KPI
{
    public partial class KPIItemDetail : System.Web.UI.Page
    {
        protected string GetFullContextPath { get { return WebHelper.GetContextPath(Request); } }
        private string KPITypeIdParam{get {return Request.QueryString["KPITypeId"]+"";}}

        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack){
                ErrorPlan.Visible = false;
                if (string.IsNullOrEmpty(KPITypeIdParam))
                    FormView1.DefaultMode = FormViewMode.Insert;
                else
                    FormView1.DefaultMode = FormViewMode.Edit;
            }
            btnCreateKPI.Visible = !string.IsNullOrEmpty(KPITypeIdParam);
        }
        protected void btnSave_Click(object sender, EventArgs e) {
            var id = WebHelper.FindControl(FormView1, "KPITypeId") as TextBox;
            id.Text = (string.IsNullOrEmpty(KPITypeIdParam) ? Guid.NewGuid().ToString() : KPITypeIdParam);

            if (FormView1.DefaultMode == FormViewMode.Edit)
            {
                SqlDataSource2.UpdateParameters["Memo"].DefaultValue = (WebHelper.FindControl(FormView1, "Memo") as TextBox).Text;
                SqlDataSource2.UpdateParameters["KPITypeName"].DefaultValue = (WebHelper.FindControl(FormView1, "KPITypeName") as TextBox).Text;
                SqlDataSource2.Update();
            }
            else
            {
                SqlDataSource2.InsertParameters["KPITypeId"].DefaultValue = id.Text;
                SqlDataSource2.InsertParameters["Memo"].DefaultValue = (WebHelper.FindControl(FormView1, "Memo") as TextBox).Text;
                SqlDataSource2.InsertParameters["KPITypeName"].DefaultValue = (WebHelper.FindControl(FormView1, "KPITypeName") as TextBox).Text;
                SqlDataSource2.Insert();
                Response.Redirect("KPIItemDetail.aspx?KPITypeId=" + id.Text);
            }
        }
        protected void btnSaveKPI_Click(object sender, EventArgs e)
        {
            KPIId.Text = Guid.NewGuid().ToString();
            SqlDataSource1.Insert();
            KPIName.Text = "";
            KPIId.Text = "";
            Score.SelectedIndex = -1;
        }
        protected void btnBackList_Click(object sender, EventArgs e) {
            Response.Redirect("KPIList.aspx");
        }

        protected void SqlDataSource1_Updating(object sender, SqlDataSourceCommandEventArgs e)
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
             
            if (t > 10)
            {
                ErrorPlan.Visible = true;
                lbError.Text = "填写的分数格式不能大于10分";
                e.Cancel = true;
            }

        }
    }

}