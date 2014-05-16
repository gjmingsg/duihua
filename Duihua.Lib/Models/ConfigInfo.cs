using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Duihua.Lib.Models
{
    [Serializable]
    public class ConfigInfo
    {		

        /// <summary>
        /// 主键
        /// </summary>
        public Guid? Id { get; set; }

        /// <summary>
        /// 配置名
        /// </summary>
        public String ConfigName { get; set; }		

        /// <summary>
        /// 配置值
        /// </summary>
        public String ConfigValue { get; set; }		
    }
}