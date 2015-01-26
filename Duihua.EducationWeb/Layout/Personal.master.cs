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
        public bool IsLogin { 
            get {
                return (!string.IsNullOrEmpty(Session["UserId"] + "") && string.IsNullOrEmpty(Request.QueryString["UserId"])) || 
                    (!string.IsNullOrEmpty(Request.QueryString["UserId"]) && Request.QueryString["UserId"].Equals(Session["UserId"] + "")); 
            }
        }
        public string ClassID{
            get {
                if (string.IsNullOrEmpty(hdClassID.Value))
                {
                   
                    var s = Session["Student"] as Dictionary<String, Object>;
                    if (s == null || s.ContainsKey("ClassID")==false)
                        //Response.Redirect("~/Login.aspx");
                        return Guid.Empty.ToString();
                    hdClassID.Value = s["ClassID"].ToString() ;
                }
                return hdClassID.Value;
            }
        }
        
    }
}