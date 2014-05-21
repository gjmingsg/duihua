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
        public int GetRegisterCount(string registerName,string registerNo,string status) {
            var ret = _dao.QueryScalar(new Dictionary<string, object>() { { "registerName", registerName }, { "registerNo", registerNo }, { "status", status } },
                @"SELECT COUNT(1) FROM RegisterInfo ri WHERE RegistName like '%'+@registerName+'%'
                    and registerNo = @registerNo
                    and status = @status");
            return int.Parse(ret.ToString());
        }
        public Dictionary<String, Object> GetRegister(String registerNo)
        {
            return _dao.QueryListData(new Dictionary<string, object>() { { "registerNo", registerNo } },
                            @"SELECT ri.*,ci.ClassName FROM RegisterInfo ri
                            INNER JOIN ClassInfo ci ON ci.ID = ri.ClassID WHERE ri.registerNo = @registerNo")[0];
        }
    }

    public enum RegistStatus{
        
        Apply=0,
        Accept=1,
        Reject=2
    }
}
