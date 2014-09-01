using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Duihua.Lib.Common;

namespace Duihua.Lib.Services.Education
{
    public class StudentService
    {
        private readonly DBHelper _dao = new DBHelper();
        
        /// <summary>
        /// 是否为有效的学生
        /// </summary>
        /// <param name="IDCard">身份证号</param>
        /// <param name="StuNumber">学生学号</param>
        /// <returns></returns>
        public Dictionary<String, Object> GetStudent(string IDCard, string StuNumber)
        {
            var s = _dao.QueryListData(new Dictionary<String, Object>() { { "StuNumber", StuNumber }, { "IDCard", IDCard } },
                            @"SELECT top 1 s.*,jc.ClassID FROM Student s
INNER JOIN JoinClass jc ON jc.UserId = s.UserId WHERE s.StuNumber = @StuNumber AND s.IDCard = @IDCard");
            if (s.Count == 0)
                return null;
            else
                return s[0];
        }
        public Dictionary<String, Object> GetStudent(string ID)
        {
            var s = _dao.QueryListData(new Dictionary<String, Object>() { { "ID", ID }},
                            @" SELECT 
s.[UserId]
      ,s.[CooperatorId]
      ,s.[StuNumber]
      ,s.[StudentName]
      ,s.[ParentName]
      ,s.[Phone]
        ,s.[StudentName] userName
      ,s.[CreateDate]
      ,s.[UpdateDate]
      ,s.[Intro]
      ,s.[IDCard]
      ,s.[Address]
      ,s.[Status]
      ,s.[Sex]
     ,CONVERT(NVARCHAR(10),s.[RegisterTime],121)[RegisterTime]
      ,s.[PicUrl]
,au.MobileAlias,am.Email,c.CooperatorName
                        FROM [dbo].[Student] s
                        INNER JOIN aspnet_Users au ON au.UserId = s.UserId
                        INNER JOIN aspnet_Membership am ON am.UserId = au.UserId 
                        LEFT JOIN Cooperator c ON c.CooperatorId = s.CooperatorId
                        WHERE  s.UserId = @ID");
            if (s.Count == 0)
                return null;
            else
            {
                if (!s[0].ContainsKey("PicUrl"))
                {
                    if ("男".Equals(s[0]["Sex"]))
                        s[0].Add("PicUrl", "~/images/boy.png");
                    else
                        s[0].Add("PicUrl", "~/images/girl.png");
                }
                return s[0];
            }
        }

        public int GetStudentCount(string IDCard, string StudentName, string Status, string CooperatorId)
        {
            var count = _dao.QueryScalar(new Dictionary<string, object>() { { "IDCard", IDCard }, { "StudentName", StudentName }
            ,{"Status",Status},{"CooperatorId",CooperatorId}}, @" SELECT COUNT(1)
                        FROM [dbo].[Student] s
                        INNER JOIN aspnet_Users au ON au.UserId = s.UserId
                        INNER JOIN aspnet_Membership am ON am.UserId = au.UserId 
                        LEFT JOIN Cooperator c ON c.CooperatorId = s.CooperatorId
                        WHERE 1=1
                        AND s.IDCard LIKE '%'+@IDCard+'%'
                        AND s.StudentName LIKE '%'+@StudentName+'%'
                        AND (@Status='' or @Status is null or s.[Status] = @Status)
                        AND (@CooperatorId = '00000000-0000-0000-0000-000000000000' OR s.CooperatorId = @CooperatorId)");
            return int.Parse(count.ToString());
        }
    }
}
