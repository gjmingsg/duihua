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
        public Dictionary<string,object> GetHomeWork(string id) {
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
    }
}
