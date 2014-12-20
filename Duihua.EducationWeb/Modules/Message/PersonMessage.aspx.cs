using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Duihua.Lib.Services.Education;

namespace Duihua.EducationWeb.Modules.Message
{
    public partial class PersonMessage : System.Web.UI.Page
    {
        private readonly ComMessageService message = new ComMessageService();
        protected void Page_Load(object sender, EventArgs e)
        {
            AspNetPager1.RecordCount = message.GetSendToOtherMessageCount(Session["UserId"] + "");
            Label1.Text = AspNetPager1.RecordCount.ToString();

            AspNetPager2.RecordCount = message.GetSendToMeMessageCount(Session["UserId"] + "");
            lblCount.Text = AspNetPager2.RecordCount.ToString();
            if (!Page.IsPostBack)
            {

                hdbegin.Value = ((AspNetPager1.CurrentPageIndex - 1) * AspNetPager1.PageSize + 1).ToString();
                hdend.Value = ((AspNetPager1.CurrentPageIndex) * AspNetPager1.PageSize).ToString();

                HiddenField1.Value = ((AspNetPager2.CurrentPageIndex - 1) * AspNetPager2.PageSize + 1).ToString();
                HiddenField2.Value = ((AspNetPager2.CurrentPageIndex) * AspNetPager2.PageSize).ToString();
            }

            Repeater1.ItemDataBound += new RepeaterItemEventHandler(Repeater1_ItemDataBound);
        }

        void Repeater1_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item) {
                var edit = e.Item.FindControl("btnEdit") as Button;
                var del = e.Item.FindControl("btnDel") as Button;
                var hdStatus = e.Item.FindControl("hdItemStatus") as TextBox;
                del.Visible = edit.Visible = "未读".Equals(hdStatus.Attributes["_status"]);
            }
        }

        protected void btnEdit_Click(object sender, EventArgs e)
        {
            var b = sender as Button;
            list.Visible = false;
            msg.Visible = true;
            msg.Bind(b.Attributes["_id"]);
        }
        protected void btnDel_Click(object sender, EventArgs e)
        {
            var b = sender as Button;
            message.DeleteMessage(b.Attributes["_id"]);
            Repeater1.DataBind();
        }
        protected void AspNetPager2_PageChanging(object src, Wuqi.Webdiyer.PageChangingEventArgs e)
        {
            AspNetPager2.CurrentPageIndex = e.NewPageIndex;
            HiddenField1.Value = ((AspNetPager2.CurrentPageIndex - 1) * AspNetPager2.PageSize + 1).ToString();
            HiddenField2.Value = ((AspNetPager2.CurrentPageIndex) * AspNetPager2.PageSize).ToString();

        }
        protected void AspNetPager1_PageChanging(object src, Wuqi.Webdiyer.PageChangingEventArgs e)
        {
            AspNetPager1.CurrentPageIndex = e.NewPageIndex;
            hdbegin.Value = ((AspNetPager1.CurrentPageIndex - 1) * AspNetPager1.PageSize + 1).ToString();
            hdend.Value = ((AspNetPager1.CurrentPageIndex) * AspNetPager1.PageSize).ToString();
        }

        public string GetStatus(object obj) {
            string v = obj.ToString();
            string color = string.Empty;
            switch (v)
            {
                case "未读":
                    color = "active";
                    break;
                case "已读":
                    color = "danger";
                    break;
            }
            return color;
        }
    }
}