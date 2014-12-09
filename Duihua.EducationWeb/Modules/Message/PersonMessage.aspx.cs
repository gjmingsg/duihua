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
            AspNetPager1.RecordCount = message.GetMessageCount(Session["UserId"]+"");
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
        public string GetStatus(object obj) {
            string v = obj.ToString();
            string color = string.Empty;
            switch (v)
            {
                case "I":
                    color = "active";
                    break;
                case "R":
                    color = "danger";
                    break;
            }
            return color;
        }
    }
}