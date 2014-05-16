using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Duihua.Lib.Models
{
    [Serializable]
    public class MessageInfo
    {		

        /// <summary>
        /// 姓名
        /// </summary>
        public String UserName { get; set; }		

        /// <summary>
        /// 联系方式
        /// </summary>
        public String ContactWay { get; set; }		

        /// <summary>
        /// 留言内容
        /// </summary>
        public String Message { get; set; }		

        /// <summary>
        /// 留言时间
        /// </summary>
        public DateTime? CreateTime { get; set; }

        /// <summary>
        /// 留言主键
        /// </summary>
        public Guid? Id { get; set; }
    }
}