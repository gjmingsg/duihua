using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Duihua.EducationWeb.Modules.Homework
{
    public partial class StudentRange : System.Web.UI.Page
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
                var s2 = e.Item.FindControl("SqlDataSource3") as SqlDataSource;
                var id = e.Item.FindControl("tbHideData") as TextBox;

                s.SelectParameters["CourseID"].DefaultValue = id.Attributes["_CourseID"];
                s.SelectParameters["WorkID"].DefaultValue = id.Attributes["_WorkID"];

                s2.SelectParameters["CourseID"].DefaultValue = id.Attributes["_CourseID"];
                s2.SelectParameters["WorkID"].DefaultValue = id.Attributes["_WorkID"];
            }
        }
    }
}