using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Duihua.Lib.Common;

namespace Duihua.Lib.Services.Education
{
    public class TeacherService
    {
        private readonly DBHelper _dao = new DBHelper();
        public int GetTeacherCount(string TeachName,string RoleName) {
            return int.Parse(_dao.QueryScalar(new Dictionary<string, object>() { { "TeachName", TeachName }, { "RoleName", RoleName } }, @"SELECT COUNT(1)
  FROM [dbo].[Teacher] t
INNER JOIN aspnet_UsersInRoles auir ON auir.UserId = t.UserId
INNER JOIN aspnet_Roles ar ON ar.RoleId = auir.RoleId
WHERE t.TeachName LIKE '%'+@TeachName+'%'
AND ar.RoleName = @RoleName
").ToString());
        }
        public Dictionary<String, Object> GetTeacher(string ID)
        {
            var l = _dao.QueryListData(new Dictionary<string, object>() { { "UserId", ID } }, @"SELECT
       [UserId]
      ,[TeachName]
  ,[TeachName] userName
      ,CONVERT(NVARCHAR(10),[joinTime],121) [joinTime]
      ,[Intro]
      ,[PicUrl]
      ,Email
      ,Phone
  FROM [dbo].[Teacher] WHERE UserId = @UserId
 ");
            if (l.Count == 0)
                return null;
            else
            {
                if (!l[0].ContainsKey("PicUrl"))
                    l[0].Add("PicUrl", "~/images/Teacher.png");
                return l[0];
            }
                
        }


        public Dictionary<String, Object> GetTeacherByClassID(string ClassID)
        {
            var l = _dao.QueryListData(new Dictionary<string, object>() { { "ClassID", ClassID } }
                , @"SELECT top 1 t.* FROM ClassGrade cg INNER JOIN Teacher t ON t.UserId = cg.TeacherId
WHERE cg.ClassID = @ClassID");
            if (l.Count == 0)
                return null;
            else
            {
                if (!l[0].ContainsKey("PicUrl"))
                    l[0].Add("PicUrl", "~/images/Teacher.png");
                return l[0];
            }

        }

        public Dictionary<String, Object> GetTeacherByCourseID(string CourseID)
        {
            var l = _dao.QueryListData(new Dictionary<string, object>() { { "CourseID", CourseID } }
                                , @"SELECT top 1 t.* FROM TeachJoinCourse cg 
                INNER JOIN Teacher t ON t.UserId = cg.UserId
                WHERE cg.CourseID = @CourseID");
            if (l.Count == 0)
                return null;
            else
            {
                if (!l[0].ContainsKey("PicUrl"))
                    l[0].Add("PicUrl", "~/images/Teacher.png");
                return l[0];
            }

        }
    }
}
