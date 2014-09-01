using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Duihua.Lib.Common;

namespace Duihua.Lib.Services.Education
{
    public class UserService
    {
        private readonly DBHelper _dao = new DBHelper();
        public Dictionary<String, Object> GetUser(string ID) {
            var l = _dao.QueryListData(new Dictionary<string, object>() { { "UserId", ID } }, 
@"SELECT au.UserId,au.UserName,au.MobileAlias Phone
,am.Email
,am.CreateDate
,am.Comment Intro
 FROM aspnet_Users au INNER JOIN aspnet_Membership am ON am.UserId = au.UserId
where  am.userid = @UserId");
            if (l.Count == 0)
                return null;
            else
            {
                if (!l[0].ContainsKey("PicUrl"))
                    l[0].Add("PicUrl", "~/images/noimage.jpg");
                return l[0];
            }
        }
    }
}
