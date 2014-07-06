using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Duihua.Lib.Services;
using Duihua.Lib.Common;
using System.Text.RegularExpressions;
using log4net;

namespace Duihua.WebApp
{
    public partial class _Default : System.Web.UI.Page
    {
        private readonly DefaultService s = new DefaultService();
        private readonly MessageService m = new MessageService();
        private readonly ILog log = LogManager.GetLogger(typeof(_Default));

        protected void Page_Load(object sender, EventArgs e)
        {
            log.Info("来自IP:"+Request.UserHostAddress+"的访问");

            //send_btn.ServerClick += new EventHandler(send_btn_ServerClick);
            if (!Page.IsPostBack)
            {
                if ("Message".Equals(Request.QueryString["Submit"]))
                {
                    var form = WebHelper.GetForm(Request);
                    if (Validate(form))
                    {
                        m.InsertMessage(form);
                    }
                    else
                    {
                        Alert("留言提交成功");
                    }
                }
            }
        }

       protected void btnSubmit_Click(object sender, EventArgs e)
        {
        
            var form = WebHelper.GetForm(Request);
            if (Validate(form))
            {
                m.InsertMessage(form);
                Alert("留言提交成功");
            }
            else
            {
                Alert("留言提交失败");
            }
            
        }

        private bool Validate(Dictionary<String, Object> form)
        {
            Regex r = new Regex("^\\s*([A-Za-z0-9_-]+(\\.\\w+)*@(\\w+\\.)+\\w{2,5})\\s*$");
            bool result = true;
            if(form.ContainsKey("UserName")==false){
                result = false;
                //Alert("姓名不能为空");
            }
            if (result && form.ContainsKey("ContactWay") == false)
            {
                result = false;
                //Alert("邮箱地址不能为空");
            }
            else if (result && r.IsMatch(form["ContactWay"].ToString()) == false)
            {
                result = false;
                //Alert("邮箱地址格式不正确");
            }

            if (result && form.ContainsKey("Message") == false)
            {
                result = false;
                //Alert("内容不能为空");
            }
            return result;
        }
        private void Alert(string msg) {
            ClientScript.RegisterStartupScript(ClientScript.GetType(), "msg", "<script type='text/javascript'>alert('" + msg + "');</script>");
        }
        
        public Dictionary<String, Object> About { 
            get {

                var result = HttpRuntime.Cache.Get("About");
                if (result == null)
                {
                    result = s.GetAbout();
                    HttpRuntime.Cache.Insert("About", result, null, DateTime.Now.AddHours(1), TimeSpan.Zero);
                }
                return result as Dictionary<String, Object>;
            } 
        }

        public Dictionary<String, Object> Work {
            get {
                var result = HttpRuntime.Cache.Get("Work");
                if (result == null)
                {
                    result = s.GetWork();
                    HttpRuntime.Cache.Insert("Work", result, null, DateTime.Now.AddHours(1), TimeSpan.Zero);
                }
                return result as Dictionary<String, Object>;
                
            }
        }

        public Dictionary<String,Object> Team {
            get {
                var result = HttpRuntime.Cache.Get("Team");
                if (result == null)
                {
                    result = s.GetTEAM();
                    HttpRuntime.Cache.Insert("Team", result, null, DateTime.Now.AddHours(1), TimeSpan.Zero);
                }
                return result as Dictionary<String, Object>;
            }
        }

        public Dictionary<String, Object> Viewpoint
        {
            get
            {
                var result = HttpRuntime.Cache.Get("Viewpoint");
                if (result == null)
                {
                    result = s.GetViewpoint();
                    HttpRuntime.Cache.Insert("Viewpoint", result, null, DateTime.Now.AddHours(1), TimeSpan.Zero);
                }
                return result as Dictionary<String, Object>;
            }
        }
        public Dictionary<String, Object> Publish
        {
            get
            {
                var result = HttpRuntime.Cache.Get("Publish");
                if (result == null)
                {
                    result = s.GetPublish();
                    HttpRuntime.Cache.Insert("Publish", result, null, DateTime.Now.AddHours(1), TimeSpan.Zero);
                }
                return result as Dictionary<String, Object>;
                
            }
        }

        public Dictionary<string,Object> Contact {
            get {
                var result = HttpRuntime.Cache.Get("Contact");
                if (result == null)
                {
                    result = s.GetContact();
                    HttpRuntime.Cache.Insert("Contact", result, null, DateTime.Now.AddHours(1), TimeSpan.Zero);
                }
                return result as Dictionary<String, Object>;
            }
        }
        public Dictionary<string, Object> Information
        {
            get
            {
                var result = HttpRuntime.Cache.Get("Information");
                if (result == null)
                {
                    result = s.GetInformation();
                    HttpRuntime.Cache.Insert("Information", result, null, DateTime.Now.AddHours(1), TimeSpan.Zero);
                }
                return result as Dictionary<String, Object>;
               
            }
        }

        public Dictionary<string, Object> Result
        {
            get
            {
                var result = HttpRuntime.Cache.Get("Result");
                if (result == null)
                {
                    result = s.GetResult();
                    HttpRuntime.Cache.Insert("Result", result, null, DateTime.Now.AddHours(1), TimeSpan.Zero);
                }
                return result as Dictionary<String, Object>;

            }
        }
    }
}
