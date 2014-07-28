using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Duihua.Lib.Common;

namespace Duihua.Lib.Services.Education
{
    public class ClassGradeService
    {
        private readonly DBHelper _dao = new DBHelper();
        public int GetClassGradeCount(string GradeName, string SemesterID)
        {
            var param = new Dictionary<String, Object>();
            if (string.IsNullOrEmpty(GradeName))
                param.Add("GradeName", DBNull.Value);
            else
                param.Add("GradeName", GradeName);
            if (string.IsNullOrEmpty(SemesterID))
                param.Add("SemesterID", DBNull.Value);
            else
                param.Add("SemesterID", SemesterID);

            return int.Parse(_dao.QueryScalar(param, 
                            @"SELECT COUNT(1) FROM ClassGrade cg
                            WHERE (@SemesterID is null or cg.SemesterID = @SemesterID)
                            AND (@GradeName is null or cg.GradeName LIKE '%'+@GradeName+'%')").ToString());
        }
        /// <summary>
        /// 查询班级信息
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public Dictionary<String, Object> GetClassGrade(string id) {
            var param = new Dictionary<String, Object>() { { "ID", id } };
            var list = _dao.QueryListData(param, @"SELECT 
                                                    cg.*
                                                    ,s.SemesterName
                                                    ,t.TeachName
                                                    ,(SELECT COUNT(1) FROM JoinClass jc WHERE jc.ClassID = cg.ClassID) studentCount
                                                      FROM ClassGrade cg left JOIN Semester s ON s.SemesterID = cg.SemesterID
                                                    left JOIN Teacher t ON t.UserId = cg.TeacherId
                                                    WHERE cg.ClassID=@ID");
            if (list.Count == 0)
                return null;
            else
                return list[0];
        }
    }
}
