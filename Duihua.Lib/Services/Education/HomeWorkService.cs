using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Duihua.Lib.Common;

namespace Duihua.Lib.Services.Education
{
    public class HomeWorkService
    {
        private readonly DBHelper _dao = new DBHelper();
        public Dictionary<string, object> GetHomeWork(string id)
        {
            var s = _dao.QueryListData(new Dictionary<String, Object>() { { "WorkID", id }},
                           @"SELECT hw.WorkID
                                     ,hw.CourseID
                                     ,hw.Title
                                     ,hw.[Content]
                                     , CONVERT(NVARCHAR(19),hw.DeadLine,121)DeadLine
                                     ,hw.Score
                                     ,hw.CreateTime
                                     , CONVERT(NVARCHAR(19),hw.BeginTime,121)BeginTime
                                     ,c.CourseName
                                    ,(SELECT COUNT(1) FROM WorkResult wr WHERE hw.WorkID= wr.WorkID) hasSubmit
                                  FROM HomeWork hw INNER JOIN Course c ON c.CourseID = hw.CourseID
                                 WHERE hw.WorkID = @WorkID");
            if (s.Count == 0)
                return null;
            else
                return s[0];
        }
        public int GetHomeWorkCount(string GradeName, string CourseName, string Title,string CourseID)
        {
            var dic = new Dictionary<string, object>() { { "GradeName", GradeName }, { "CourseName", CourseName }, { "Title", Title } };
            if (string.IsNullOrEmpty(CourseID) == true)
                dic.Add("CourseID", Guid.Empty);
            else
                dic.Add("CourseID", CourseID);
            return int.Parse(_dao.QueryScalar(dic, @"SELECT COUNT(1)	
                                                     FROM HomeWork hw INNER JOIN Course c ON c.CourseID = hw.CourseID
                                                     INNER JOIN ClassGrade cg ON cg.ClassID = c.ClassID
                                                    WHERE cg.GradeName LIKE '%'+@GradeName+'%'  
                                                     AND c.CourseName LIKE '%'+@CourseName+'%'
                                                    AND hw.Title LIKE '%'+@Title+'%'
                                                    and (c.CourseID = @CourseID or @CourseID = '00000000-0000-0000-0000-000000000000')
                                                    ").ToString());
        }

        public List<Dictionary<string, object>> GetMyHomeWork(string username)
        {
            var param = new Dictionary<String, Object>() { { "StudentName", username } };
            return _dao.QueryListData(param, @"SELECT hw.WorkID,hw.Title,c.CourseID
                  FROM Student s INNER JOIN JoinCourse jc ON jc.UserId = s.UserId
                INNER JOIN Course c ON c.CourseID = jc.CourseID
                INNER JOIN HomeWork hw ON hw.CourseID = c.CourseID
                WHERE s.StudentName = @StudentName");
        }

        public List<Dictionary<string, object>> GetHomeworkByCourseID(string CourseID)
        {
            return _dao.QueryListData(new Dictionary<string, object>() { { "CourseID", CourseID } }, @"SELECT hw.WorkID,hw.Title,hw.BeginTime FROM HomeWork hw WHERE hw.CourseID = @CourseID ORDER BY hw.BeginTime ASC");
        }

        public int GetCountSubmit(string WorkId, string UserId) {
            return int.Parse(_dao.QueryScalar(new Dictionary<string, object>() { { "WorkID", WorkId }, { "UserId", UserId } }, @"SELECT COUNT(1) FROM WorkResult wr WHERE wr.WorkID= @WorkID AND wr.Userid = @UserId").ToString());
        }
    }
}
