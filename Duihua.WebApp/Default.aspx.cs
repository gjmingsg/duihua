using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Duihua.Lib.Services;
using Duihua.Lib.Common;

namespace Duihua.WebApp
{
    public partial class _Default : System.Web.UI.Page
    {
        private readonly DefaultService s = new DefaultService();
        private readonly MessageService m = new MessageService();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack) {
                if ("Message".Equals(Request.QueryString["Submit"]))
                {
                    var form = WebHelper.GetForm(Request);
                    if (form.ContainsKey("UserName") && form.ContainsKey("ContactWay") && form.ContainsKey("ContactWay"))
                    {
                        m.InsertMessage(form);
                        
                    }
                    else { 
                        
                    }
                }
            }
        }

        public Dictionary<String, Object> About { 
            get {
                return s.GetAbout();
            } 
        }

        public Dictionary<String, Object> Work {
            get {
                return s.GetWork();
            }
        }

        public Dictionary<String,Object> Team {
            get {
                return s.GetTEAM();
            }
        }

        public Dictionary<String, Object> Viewpoint
        {
            get
            {
                return s.GetViewpoint();
            }
        }
        public Dictionary<String, Object> Publish
        {
            get
            {
                return s.GetPublish();
            }
        }

        public Dictionary<string,Object> Contact {
            get {
                return s.GetContact();
            }
        }
        public Dictionary<string, Object> Information
        {
            get
            {
                return s.GetInformation();
            }
        }
    }
}
