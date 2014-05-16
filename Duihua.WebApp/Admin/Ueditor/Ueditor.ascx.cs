using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Duihua.Lib.Common;

namespace Duihua.WebApp.Admin.Ueditor
{
    public partial class Ueditor : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }
        public String Value { get { return editor.InnerText; } set { editor.InnerText = value; } }
        public String name { get { return editor.Attributes["name"]; } set { editor.Attributes["name"]=value; } }
       // public override String ID { get { return editor.ID; } set { editor.ID = value; } }
        protected String GetFullContextPath
        {
            get
            {
                return WebHelper.GetContextPath(this);
            }
        }
    }
}