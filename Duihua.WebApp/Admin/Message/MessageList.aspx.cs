using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Duihua.Lib.Services;
using Duihua.Lib.Common;

namespace Duihua.WebApp.Admin.Message
{
    public partial class MessageList : System.Web.UI.Page
    {
        private readonly MessageService msg = new MessageService();
        protected void Page_Load(object sender, EventArgs e)
        {
            AspNetPager1.RecordCount = msg.GetMessageCount(tbUserName.Text, tbContactWay.Text, tbMessage.Text);
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


        protected void LinkButton2_Click(object sender, EventArgs e)
        {
            listTemplate.Visible = false;
            detailTemplate.Visible = true;
            LinkButton b = sender as LinkButton;
            var id = b.Attributes["_Id"].ToString();
            WebHelper.Fill(detailTemplate, msg.GetMessage(id));
        }

        protected void Button4_Click(object sender, EventArgs e)
        {
            listTemplate.Visible = true;
            detailTemplate.Visible = false;
        }
 
        
    }
}