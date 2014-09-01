using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Duihua.Lib.Common;

namespace Duihua.Lib.Services.Education
{
    public class CooperatorService
    {
        private readonly DBHelper _dao = new DBHelper();
        public int GetCooperatorCount(string CooperatorName)
        {
            return int.Parse(_dao.QueryScalar(
                new Dictionary<string, object>() { { "CooperatorName", CooperatorName } },
                        @"SELECT COUNT(1)
                          FROM [dbo].[Cooperator]
                        WHERE CooperatorName LIKE '%'+@CooperatorName+'%'").ToString());
        }
        public Dictionary<String, object> GetCooperator(string id) {
            var l = _dao.QueryListData(new Dictionary<string, object>() { { "Id", id } },
            @"SELECT [CooperatorId]
      ,[CooperatorName]
       ,[CooperatorName] userName
      ,[Address]
      ,[Intro]
      ,[CreateTime]
      ,[Creator]
      ,[UpdateTime]
      ,[UpdateUser]
        ,Email
      ,Phone
      ,(SELECT COUNT(1) FROM Student s WHERE s.CooperatorId = [dbo].[Cooperator].CooperatorId) studentcount
  FROM [dbo].[Cooperator]
WHERE  [CooperatorId] = @Id
");
            if (l.Count == 0)
                return null;
            else
                return l[0];
        }
    }
}
