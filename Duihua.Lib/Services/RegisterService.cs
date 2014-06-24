using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Duihua.Lib.Common;

namespace Duihua.Lib.Services
{
    public class RegisterService
    {
        private readonly DBHelper _dao = new DBHelper();
        public int GetRegisterCount(string registerName,string registerNo,string classId) {
            var dic = new Dictionary<string, object>() { { "registerName", registerName }, { "registerNo", registerNo }};
            if (string.IsNullOrEmpty(classId))
                dic.Add("ClassID", DBNull.Value);
            else
                dic.Add("ClassID", classId);
            var ret = _dao.QueryScalar(dic,
                @"SELECT COUNT(1) FROM RegisterInfo  WHERE RegistName like '%'+@registerName+'%'
                    and registerNo like '%'+ @registerNo +'%'
                    and (@ClassID is null or ClassID = @ClassID)");
            return int.Parse(ret.ToString());
        }
        public Dictionary<String, Object> GetRegister(String registerNo)
        {
            return _dao.QueryListData(new Dictionary<string, object>() { { "registerNo", registerNo } },
                            @"SELECT ri.[ID]
      ,ri.[RegistName]
      ,ri.[QQ]
      ,ri.[Email]
      ,ri.[Phone]
      ,ri.[Intro]
      ,ri.[ClassID]
      ,ri.[RegisterNo]
      ,ri.[CreateTime]
      ,ri.[Address],case  ri.[Status] when 1 then '通过报名' when 2 then  '不接受报名' when 0 then '注册报名中' end [Status],ci.ClassName FROM RegisterInfo ri
                            INNER JOIN ClassInfo ci ON ci.ID = ri.ClassID WHERE ri.registerNo = @registerNo")[0];
        }
    }

    public enum RegistStatus{
        
        Apply=0,
        Accept=1,
        Reject=2
    }
}
