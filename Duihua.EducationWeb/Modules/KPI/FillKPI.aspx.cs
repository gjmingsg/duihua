using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.Common;
using Duihua.Lib.Services.Education;

namespace Duihua.EducationWeb.Modules.KPI
{
    public partial class FillKPI : System.Web.UI.Page
    {
        private readonly KPIService kpi = new KPIService();
        protected void Page_Load(object sender, EventArgs e)
        {
            rptKPIFill.ItemDataBound += new RepeaterItemEventHandler(rptKPIFill_ItemDataBound);
        }

        void rptKPIFill_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.AlternatingItem || e.Item.ItemType == ListItemType.Item) {
                var b = e.Item.FindControl("Score") as RadioButtonList;
                var score = int.Parse(b.Attributes["_val"]);
                var _sel = int.Parse(b.Attributes["_sel"]);
                for (int i = 1; i <= score; i++) {
                    b.Items.Add(new ListItem() { Text = i.ToString() +"分", Value = i.ToString() });
                }
                b.SelectedIndex = _sel - 1;
            }
        }
        protected void btnViewDetail_Click(object sender, EventArgs e)
        {
            var b = sender as Button;
            paneltext.Visible = false;
            panelbody.Visible = true;
            panelfoot.Visible = true;
            SqlDataSource1.SelectParameters["KPIReleaseId"].DefaultValue = b.Attributes["_KPIReleaseId"];
            KPITeacherId.Value = b.Attributes["_KPITeacherId"];
        }
        protected void btnBack_Click(object sender, EventArgs e)
        {
            paneltext.Visible = true;
            panelbody.Visible = false;
            panelfoot.Visible = false;
        }
        protected void btnSave_Click(object sender, EventArgs e)
        {
            var count = rptKPIFill.Items.Count;
            var list = new List<Dictionary<string,object>>();
            for (var i = 0; i < count;i++ )
            {
               if (rptKPIFill.Items[i].ItemType == ListItemType.AlternatingItem || rptKPIFill.Items[i].ItemType == ListItemType.Item) {
                   var r = rptKPIFill.Items[i].FindControl("Score") as RadioButtonList;
                   var _ScoreId = r.Attributes["_ScoreId"];
                   var score = r.SelectedValue;

                   if (string.IsNullOrEmpty(score))
                   {
                       lbError.Visible = true;
                       ErrorPlan.Visible = true;
                       lbError.Text="存在尚未填写的指标";
                       r.Attributes["class"]="has-error";
                       return ;
                   }    
                   list.Add(new Dictionary<string,object>(){{"ScoreId",_ScoreId},{"Score",score}});
               }
            }
            var tk = new Dictionary<string, object>() { { "Memo", Memo.Text }, { "KPITeacherId", KPITeacherId.Value } };
            kpi.FillScore(list,tk);
            Response.Redirect(Request.RawUrl);
        }
        
    }
}