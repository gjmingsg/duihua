using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Duihua.Lib.Common;

namespace Duihua.EducationWeb.Modules.KPI
{
    public partial class KPIList : System.Web.UI.Page
    {
        private readonly DBHelper db = new DBHelper();
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btnNew_Click(object sender, EventArgs e) {
            Response.Redirect("KPIItemDetail.aspx");
        }
        protected void btnSaveKPIRelease_Click(object sender, EventArgs e)
        {
            //TODO 下发填报指标
            db.ExecuteNonQuery(new Dictionary<string, object>() { { "KPITypeId", KPITypeId.Text }, { "Memo", Memo.Text }, { "Creator", Session["UserId"] + "" }, { "CreateTime",DateTime.Now } }, "EXEC [dbo].[edu_ReleaseKPI] @KPITypeId,@CreateTime,@Creator,@Memo");
        }
        protected void lbOperator_Click(object sender, EventArgs e)
        {

            LinkButton b = sender as LinkButton;
            var id = (b.Attributes["_Id"] + "").ToString();
           
            if ("Edit".Equals(b.CommandName))
            {
                Response.Redirect("KPIItemDetail.aspx?KPITypeId="+id);
            }
             
            else if ("Delete".Equals(b.CommandName))
            {
                SqlDataSource1.DeleteParameters["KPITypeId"].DefaultValue = id;
                SqlDataSource1.Delete();
                Repeater1.DataBind();
            }
        }
    }
}