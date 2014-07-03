using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Duihua.EducationWeb.Modules
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        private void BindMenu() {
            var menu = SiteMap.RootNode;
            foreach (SiteMapNode item in menu.ChildNodes)
            {
                var title = item.Title;
                
            }
        }
    }
}