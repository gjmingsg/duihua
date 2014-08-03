using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Duihua.Lib.Common;

namespace Duihua.Lib.Services.Education
{
    public class CourseService
    {
        private readonly DBHelper _dao = new DBHelper();
        public int GetCourseCount(string CourseName, string TeachName, string GradeName, string SemesterID, string ClassID)
        {
            var dic = new Dictionary<string, object>() { 
            { "CourseName", CourseName },
            {"TeachName",TeachName},
            {"GradeName",GradeName}
           };
            if (string.IsNullOrEmpty(ClassID))
                dic.Add("ClassID", Guid.Empty);
            else
                dic.Add("ClassID", ClassID);
            if (string.IsNullOrEmpty(SemesterID))
                dic.Add("SemesterID", Guid.Empty);
            else
                dic.Add("SemesterID", SemesterID);
            return int.Parse(_dao.QueryScalar(dic,

                                                                                @"SELECT
                                                                                    COUNT(1)
                                                                                     FROM Course c LEFT JOIN TeachJoinCourse t ON c.CourseID = t.CourseID
                                                                                    LEFT JOIN Teacher t2 ON t2.UserId = t.UserId AND t2.TeachName LIKE '%'+@TeachName+'%'
                                                                                    LEFT JOIN ClassGrade cg ON c.classid = cg.ClassID AND cg.GradeName LIKE '%'+@GradeName+'%'
                                                                                    LEFT JOIN Semester s ON cg.SemesterID = s.SemesterID AND  (@SemesterID ='00000000-0000-0000-0000-000000000000' or s.SemesterID = @SemesterID)
                                                                                    WHERE 1=1
                                                                                    AND c.CourseName LIKE '%'+@CourseName+'%'
                                                                                    and ( c.classid = @ClassID or  @ClassID='00000000-0000-0000-0000-000000000000')").ToString());
        }
        public Dictionary<String, Object> GetCourse(string id)
        {
            var param = new Dictionary<String, Object>() { { "CourseID", id } };
            var list = _dao.QueryListData(param, @"SELECT
                                                    s.SemesterName
                                                    ,cg.GradeName 
                                                    , CONVERT(NVARCHAR(10),c.StartTime,121) StartTime
                                                    ,CONVERT(NVARCHAR(10),c.EndTime,121) EndTime
                                                    ,C.Syllabus
                                                    ,C.CourseID
                                                    ,C.Cover
                                                    ,C.CreateTime
                                                    ,C.CourseName
                                                    ,t2.TeachName
                                                    ,t2.Intro
                                                    ,s.SemesterID
                                                    ,cg.ClassID
                                                    ,(SELECT COUNT(1) FROM JoinCourse j WHERE j.CourseID = c.CourseID) studentCount
                                                    ,ROW_NUMBER () OVER (ORDER BY c.StartTime DESC) pageindex
                                                     FROM Course c LEFT JOIN TeachJoinCourse t ON c.CourseID = t.CourseID
                                                    LEFT JOIN Teacher t2 ON t2.UserId = t.UserId
                                                    LEFT JOIN ClassGrade cg ON c.classid = cg.ClassID
                                                    LEFT JOIN Semester s ON cg.SemesterID = s.SemesterID
                                                    WHERE c.CourseID = @CourseID");
            if (list.Count == 0)
                return null;
            else
                return list[0];
        }

        public List<Dictionary<string,object>> GetMyCourse(string username){
            var param = new Dictionary<String, Object>() { { "StudentName", username } };
             return _dao.QueryListData(param, @"SELECT c.CourseID,c.CourseName
                      FROM Student s INNER JOIN JoinCourse jc ON jc.UserId = s.UserId
                    INNER JOIN Course c ON c.CourseID = jc.CourseID
                    WHERE s.StudentName = @StudentName");
        }
    }
}
