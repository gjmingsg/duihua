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
    public partial class CooperatorList : System.Web.UI.Page
    {
        private readonly CooperatorService cg = new CooperatorService();
        protected void Page_Load(object sender, EventArgs e)
        {
            AspNetPager1.RecordCount = cg.GetCooperatorCount(sCooperatorName.Text);
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
        protected void btnBackList_Click(object sender, EventArgs e)
        {

            Response.Redirect(Request.RawUrl);
        }
        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(eCooperatorId.Text))
            {
                SqlDataSource1.InsertParameters["Creator"].DefaultValue = Session["UserId"].ToString();
                SqlDataSource1.Insert();
            }
            else
            {
                SqlDataSource1.UpdateParameters["UpdateUser"].DefaultValue = Session["UserId"].ToString();
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
                var c = cg.GetCooperator(id);
                WebHelper.Fill(detail, c);
            }
            else if ("View".Equals(b.CommandName))
            {
                list.Visible = false;
                view.Visible = true;
                var c = cg.GetCooperator(id);

                WebHelper.Fill(view, c);
            }
            else if ("Delete".Equals(b.CommandName))
            {
                SqlDataSource1.DeleteParameters["CooperatorId"].DefaultValue = id;
                SqlDataSource1.Delete();
                AspNetPager1.RecordCount = cg.GetCooperatorCount(sCooperatorName.Text) - 1;
                lblCount.Text = AspNetPager1.RecordCount.ToString();

            }
        }

        protected void SqlDataSource1_Inserting(object sender, SqlDataSourceCommandEventArgs e)
        {
            //Random t = new Random(DateTime.Now.Second);
            Membership.CreateUser(eCooperatorName.Text, "123456");
            var id = Membership.GetUser(eCooperatorName.Text).ProviderUserKey.ToString();
            Roles.AddUsersToRole(new string[]{eCooperatorName.Text},"合作单位");
            e.Command.Parameters["@CooperatorId"].Value = id;
        }

        protected void SqlDataSource1_Deleting(object sender, SqlDataSourceCommandEventArgs e)
        {
            var id = e.Command.Parameters["@CooperatorId"].Value;
            var stu = cg.GetCooperator(id.ToString());
            Membership.DeleteUser(stu["CooperatorName"].ToString(), true);
        }

        protected void SqlDataSource1_Updating(object sender, SqlDataSourceCommandEventArgs e)
        {

        }
    }
}