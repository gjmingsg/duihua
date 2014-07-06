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
                            @"SELECT top 1 * FROM Student s WHERE s.StuNumber = @StuNumber AND s.IDCard = @IDCard");
            if (s.Count == 0)
                return null;
            else
                return s[0];
        }
    }
}
