using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Duihua.EducationWeb.Modules.Class
{
    public partial class JoinClassList : System.Web.UI.Page
    {
        public string ClassID { get { return Request.QueryString["ClassID"] + ""; } }

        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btnSave_Click(object sender, EventArgs e)
        {
            var userlist = hhSelected.Value;
            var list = userlist.Split(new char[] { ';' }, StringSplitOptions.RemoveEmptyEntries);
            
            SqlDataSource3.Delete();
            foreach (var item in list)
            {
                SqlDataSource3.InsertParameters["UserId"].DefaultValue = item;
                SqlDataSource3.Insert();
            }
            lbLeft.DataBind();
            lbRight.DataBind();
        }
        protected void btnBackList_Click(object sender, EventArgs e)
        {
            Response.Redirect(Request.QueryString["ReturnUrl"]);
        }
        protected void btnSearch_Click(object sender, EventArgs e)
        {
           
        }
    }
}