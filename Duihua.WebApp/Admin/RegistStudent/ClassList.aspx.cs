using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Duihua.Lib.Services;
using Duihua.Lib.Common;

namespace Duihua.WebApp.Admin.RegistStudent
{
    public partial class ClassList : System.Web.UI.Page
    {
        private readonly ClassService cl = new ClassService();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                tbYear.Text = DateTime.Now.Year.ToString();
                hdbegin.Value = "1";
                hdend.Value = AspNetPager1.PageSize.ToString();  
            }
            AspNetPager1.RecordCount = cl.GetClassCount(tbClassName.Text, tbYear.Text, ddIsFinish.SelectedValue);
            lblCount.Text = AspNetPager1.RecordCount.ToString();
        }
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            AspNetPager1.CurrentPageIndex = 1;
        }
        protected void btnNew_Click(object sender, EventArgs e)
        {
            editTemplate.Visible = true;
            listTemplate.Visible = false;
            tbYear.Text = DateTime.Now.Year.ToString();
        }
        
        protected void AspNetPager1_PageChanging(object src, Wuqi.Webdiyer.PageChangingEventArgs e)
        {
            AspNetPager1.CurrentPageIndex = e.NewPageIndex;
            hdbegin.Value = ((AspNetPager1.CurrentPageIndex - 1) * AspNetPager1.PageSize + 1).ToString();
            hdend.Value = ((AspNetPager1.CurrentPageIndex) * AspNetPager1.PageSize).ToString();
        }
        protected void lbOperator_Click(object sender, EventArgs e)
        {
            LinkButton b = sender as LinkButton;
            var id = (b.Attributes["_Id"] + "").ToString();
            if ("EditClass".Equals(b.CommandName))
            {
                listTemplate.Visible = false;
                editTemplate.Visible = true;
                var c = cl.GetClass(id);
                eIntro.InnerText = c["Intro"].ToString();
                WebHelper.Fill(editTemplate, c);
                eStartTime.Text = string.Format("{0:yyyy-MM-dd}",c["StartTime"]);
                eEndTime.Text = string.Format("{0:yyyy-MM-dd}", c["EndTime"]);
            }
            else if ("View".Equals(b.CommandName))
            {
                listTemplate.Visible = false;
                detailTemplate.Visible = true;
                var c = cl.GetClass(id);
                eIntro.InnerText = c["Intro"].ToString();
                WebHelper.Fill(detailTemplate, c);
                eStartTime.Text = string.Format("{0:yyyy-MM-dd}", c["StartTime"]);
                eEndTime.Text = string.Format("{0:yyyy-MM-dd}", c["EndTime"]);
            }
            else if ("Delete".Equals(b.CommandName))
            {
                ClassDataSource.DeleteParameters.Add("@ID", id);
                ClassDataSource.Delete();
                AspNetPager1.RecordCount = cl.GetClassCount(tbClassName.Text, tbYear.Text, ddIsFinish.SelectedValue)-1;
                lblCount.Text = AspNetPager1.RecordCount.ToString();

            }
          
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(eID.Text))
            {
                ClassDataSource.Insert();
            }
            else
            {
                ClassDataSource.Update();
            }

            Response.Redirect(Request.RawUrl);
        }
        protected void btnBackList_Click(object sender, EventArgs e)
        {
            Response.Redirect(Request.RawUrl);
        }

        protected string GetFullContextPath { get { return WebHelper.GetContextPath(Request); } }
    }
}