using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.Common;
using Duihua.Lib.Services.Education;
using Duihua.Lib.Common;

namespace Duihua.EducationWeb.Modules.KPI
{
    public partial class FillKPI : System.Web.UI.Page
    {
        private readonly KPIService kpi = new KPIService();
        protected void Page_Load(object sender, EventArgs e)
        {
            rptKPIFill.ItemDataBound += new RepeaterItemEventHandler(rptKPIFill_ItemDataBound);
            if (!IsPostBack) {
                
            }
        }

        void rptKPIFill_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.AlternatingItem || e.Item.ItemType == ListItemType.Item) {
                var b = e.Item.FindControl("Score") as RadioButtonList;
                var score = int.Parse(b.Attributes["_val"]);
                
                for (int i = 1; i <= score; i++) {
                    b.Items.Add(new ListItem() { Text = i.ToString() +"分", Value = i.ToString() });
                }
                int _sel = 0;
                if (int.TryParse(b.Attributes["_sel"], out _sel))
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
            WebHelper.Fill(panelbody, kpi.GetKPITeacher(new Dictionary<string, object>() { { "KPITeacherId", KPITeacherId.Value } }));
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