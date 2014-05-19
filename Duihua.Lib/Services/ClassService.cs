using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Duihua.Lib.Common;

namespace Duihua.Lib.Services
{
    public class ClassService
    {
        private readonly DBHelper _dao = new DBHelper();

        public int GetClassCount(string className, string year, string isFinish)
        {
            var i = _dao.QueryScalar(new Dictionary<String, Object>() { { "className", className }, { "year", year }, { "IsFinish" ,isFinish} }, @"select count(1) from ClassInfo where className like '%'+@className+'%' and year = @year and IsFinish = @IsFinish");
           return int.Parse(i.ToString());
        }

        public Dictionary<String, Object> GetClass(String id)
        {
            var list = _dao.QueryListData(new Dictionary<string, object>() { { "Id", id } },
                            @"SELECT * FROM ClassInfo ci WHERE id = @Id");
            if (list.Count == 0)
                return null;
            return list[0];
        }

    }
}
