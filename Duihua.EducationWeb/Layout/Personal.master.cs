using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Duihua.Lib.Common;

namespace Duihua.EducationWeb.Layout
{
    public partial class Personal : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        public string ClassID{
            get {
                if (string.IsNullOrEmpty(hdClassID.Value))
                {
                    var s = Session["Student"] as Dictionary<String, Object>;
                    if (s == null)
                        Response.Redirect("~/Login.aspx");
                    hdClassID.Value = s["ClassID"].ToString() ;
                }
                return hdClassID.Value;
            }
        }
        
    }
}