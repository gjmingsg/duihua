using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Duihua.Lib.Models
{
    [Serializable]
    public class RegisterInfo
    {		

        /// <summary>
        /// 主键
        /// </summary>
        public Guid? Id { get; set; }

        /// <summary>
        /// 报名人
        /// </summary>
        public String RegistName { get; set; }		

        /// <summary>
        /// 报名人联系方式QQ
        /// </summary>
        public String QQ { get; set; }		

        /// <summary>
        /// 报名人联系方式邮箱
        /// </summary>
        public String Email { get; set; }		

        /// <summary>
        /// 报名人联系方式手机
        /// </summary>
        public String Phone { get; set; }		

        /// <summary>
        /// 报名人简介
        /// </summary>
        public String Intro { get; set; }		

        /// <summary>
        /// 报名人所选班级
        /// </summary>
        public Guid? ClassID { get; set; }

        /// <summary>
        /// 报名号
        /// </summary>
        public String RegisterNo { get; set; }		

        /// <summary>
        /// 创建时间
        /// </summary>
        public DateTime? CreateTime { get; set; }

        /// <summary>
        /// 0：不可用
        ///1：可用
        /// </summary>
        public Int32? Status { get; set; }

        public string Address { get; set; }
    }
}