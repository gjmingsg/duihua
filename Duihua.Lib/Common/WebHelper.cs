using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web.UI.WebControls;
using System.Web.UI;
using System.Web;
using System.Web.UI.HtmlControls;
namespace Duihua.Lib.Common
{
    public class WebHelper
    {
        public static string GetContextPath(UserControl u)
        {
            var Request = u.Request;
            return Request.Url.Scheme + "://" + Request.Url.Host + ":" + Request.Url.Port + ("/".Equals(Request.ApplicationPath) ? "" : Request.ApplicationPath);
        }
        public static string GetContextPath(HttpRequest u)
        {
            var Request = u;
            return Request.Url.Scheme + "://" + Request.Url.Host + ":" + Request.Url.Port + ("/".Equals(Request.ApplicationPath) ? "" : Request.ApplicationPath);
        }

        public static void Fill(Control container, Dictionary<String, Object> dic)
        {
            foreach (var key in dic.Keys)
            {
                foreach (Control item in container.Controls){
                    if(item.Controls.Count==0)
                        SetControlValue(item, dic,key);
                    else
                        Fill(item, dic);
                }
            }  
        }

        private static void SetControlValue(Control item, Dictionary<String, Object> dic,string key)
        {
            if (item is Label)
            {
                var t = item as Label;
                if (key.Equals(t.Attributes["name"]))
                    t.Text = dic[key].ToString();
            }
            else if (item is TextBox) {
                var t = item as TextBox;
                if (key.Equals(t.Attributes["name"]))
                    t.Text = dic[key].ToString();
            }
            else if (item is ListControl)
            {
                var t = item as ListControl;
                if (key.Equals(t.Attributes["name"]))
                    t.SelectedValue = dic[key].ToString();
            }
            else if (item is HtmlTextArea) {
                var t = item as HtmlTextArea;
                if (key.Equals(t.Attributes["name"]))
                    t.InnerText = dic[key].ToString();
            }
        }

        private static void GetControlValue(Control item, Dictionary<String, Object> dic)
        {
            string key = string.Empty;
            if (item is TextBox)
            {
                var t = item as TextBox;
                if (!string.IsNullOrEmpty(t.Attributes["name"]))
                    dic.Add(t.Attributes["name"], t.Text);
            }
            else if (item is ListControl)
            {
                var t = item as ListControl;
                if (!string.IsNullOrEmpty(t.Attributes["name"]))
                    dic.Add(t.Attributes["name"], t.SelectedValue);
            }
            else if (item is HtmlTextArea)
            {
                var t = item as HtmlTextArea;
                if (!string.IsNullOrEmpty(t.Attributes["name"]))
                    dic.Add(t.Attributes["name"], t.InnerText);
            }
        }
        public static Dictionary<String, Object> GetForm(HttpRequest request) {
            var item = new Dictionary<String, Object> ();
            foreach (var key in request.Form.AllKeys) {
                if (string.IsNullOrEmpty(request.Form[key]) == false)
                    item[key] = request.Form[key];
            }
            return item;
        }

        public static Dictionary<String, Object> GetForm(Control form)
        {
            var item = new Dictionary<String, Object>();
            foreach (Control key in form.Controls)
            {
                if (key.Controls.Count == 0)
                {
                    GetControlValue(key, item);
                }
                else {
                    item = GetForm(key);
                }
            }
            return item;
        }
    }
}
