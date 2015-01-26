using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

namespace Duihua.EducationWeb.Modules.KPI
{
    public partial class KPIResultList : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Repeater1.ItemDataBound += new RepeaterItemEventHandler(Repeater1_ItemDataBound);
            
        }
        void Repeater1_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.AlternatingItem || e.Item.ItemType == ListItemType.Item)
            {
                
                var s = e.Item.FindControl("SqlDataSource2") as SqlDataSource;
                var id = e.Item.FindControl("KPIReleaseId") as TextBox;
                
                s.SelectParameters["KPIReleaseId"].DefaultValue = id.Attributes["_KPIReleaseId"];
            }
        }
 
    }
}