using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Duihua.Lib.Services;

namespace Duihua.WebApp
{
    public partial class Register : System.Web.UI.Page
    {
        private readonly RegisterService r = new RegisterService();
        private readonly ClassService c = new ClassService();
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void ddClassID_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(ddClassID.SelectedValue) == false)
            {
                var item = c.GetClass(ddClassID.SelectedValue);
                if (item == null)
                    return;
                lbClassInfo.Text = item["Intro"].ToString();
            }
            else {
                lbClassInfo.Text = "";
            }
        }
    }
}