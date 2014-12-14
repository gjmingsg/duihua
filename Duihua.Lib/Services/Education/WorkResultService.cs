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
        public List<Dictionary<string, object>> GetWorkResultScore(string CourseID, string UserId)
        {
            var l = _dao.QueryListData(new Dictionary<string, object>() { { "UserId", UserId }, { "CourseID", CourseID } },
                @"SELECT hw.WorkID,isnull(wr.Score,0) Score
  FROM HomeWork hw LEFT JOIN WorkResult wr ON wr.WorkID = hw.WorkID and wr.UserId =@UserId
WHERE hw.CourseID = @CourseID
ORDER BY hw.BeginTime ASC");
            return l;
        }

        public List<Dictionary<string, object>> GetWorkResultOverallScore(string UserId)
        {
            var l = _dao.QueryListData(new Dictionary<string, object>() { { "UserId", UserId }},
                @"SELECT x.CourseID,x.CourseName,SUM(ISNULL(wr.Score,0))Score FROM (
SELECT c.CourseID,hw.WorkID,c.CourseName
  FROM Course c LEFT JOIN HomeWork hw ON hw.CourseID = c.CourseID
INNER JOIN JoinCourse jc ON jc.CourseID = c.CourseID AND jc.UserId =@UserId
) x LEFT JOIN  WorkResult wr ON wr.WorkID = x.WorkID AND wr.UserId=@UserId
GROUP BY x.CourseID,x.CourseName");
            return l;
        }

        public List<Dictionary<string, object>> GetAvgScoreOrder(string UserId)
        {
            var l = _dao.QueryListData(new Dictionary<string, object>() { { "UserId", UserId } },
                @"SELECT jc.UserId,avg(isnull(wr.Score,0)) Score
                        FROM JoinClass jc 
                        INNER JOIN WorkResult wr ON wr.UserId = jc.UserId
                        WHERE jc.ClassID IN(
	                        SELECT jc.ClassID
                          FROM JoinClass jc 
	                        WHERE jc.UserId =@UserId)
                        GROUP BY jc.UserId");
            return l;
        }
    }
}
