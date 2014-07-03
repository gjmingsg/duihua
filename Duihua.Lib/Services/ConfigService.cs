using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Duihua.Lib.Common;

namespace Duihua.Lib.Services
{

    public class ConfigService
    {
        private readonly DBHelper _dao = new DBHelper();
        public List<Dictionary<String,object>> GetConfigList(){
            return _dao.QueryListData(new Dictionary<string, object>(), @"SELECT * FROM Config c");
        }
    }
}
