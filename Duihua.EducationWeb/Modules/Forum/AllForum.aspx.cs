using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Duihua.EducationWeb.Modules.Forum
{
    public partial class AllForum : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) {
                btnCreateTopicType.Visible = HttpContext.Current.User.IsInRole("管理员");
            }
            btnSave.Click += new EventHandler(btnSave_Click);
            Repeater1.ItemDataBound += new RepeaterItemEventHandler(Repeater1_ItemDataBound);
            Repeater3.ItemDataBound += new RepeaterItemEventHandler(Repeater3_ItemDataBound);
        }

        void Repeater3_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem) {
                var b = e.Item.FindControl("btnDel") as Button;
                var count = int.Parse(b.Attributes["_count"]);
                b.Visible = count == 0 && HttpContext.Current.User.IsInRole("管理员");
              
            }
        }

        void Repeater1_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                var b = e.Item.FindControl("btnDel") as Button;
                var count = int.Parse(b.Attributes["_count"]);
                b.Visible = count == 0 && HttpContext.Current.User.IsInRole("管理员");
              
            }
        }
        protected void btnDel_Click(object sender, EventArgs e)
        {
            var b = sender as Button;
            SqlDataSource1.DeleteParameters["TypeId"].DefaultValue = b.Attributes["_id"];
            SqlDataSource1.Delete();

            Repeater1.DataBind();
            Repeater2.DataBind();
            Repeater3.DataBind();
        }
        void btnSave_Click(object sender, EventArgs e)
        {
            SqlDataSource1.Insert();
            Repeater1.DataBind();
            Repeater2.DataBind();
            Repeater3.DataBind();
        }

    }
}