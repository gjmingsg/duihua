using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Duihua.Lib.Common;

namespace Duihua.Lib.Services.Education
{
    public class WorkResultService
    {
        private readonly DBHelper _dao = new DBHelper();
        public Dictionary<string, object> GetWorkResult(string WorkID, string UserId)
        {
            var l = _dao.QueryListData(new Dictionary<string, object>() { { "UserId", UserId }, { "WorkID", WorkID } },
                @"SELECT top 1
                        [WorkID]
                        ,[UserId]
                        ,[Evaluate]
                        ,[SubmitTime]
                        ,[GradeTime]
                        ,[ModifyCount]
                        ,[CreateTime]
                        ,[Score]
                        ,[SubmitText]
                        ,[WorkResultID]
                    FROM  [dbo].[WorkResult]
                WHERE WorkID = @WorkID
                AND UserId = @UserId");
            if (l.Count == 0)
                return null;
            return l[0];
        }
        
    }
}
