using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Duihua.Lib.Models
{
    [Serializable]
    public class ArticleInfo
    {		

        /// <summary>
        /// 文章主键
        /// </summary>
        public Guid? Id { get; set; }

        /// <summary>
        /// 文章标题
        /// </summary>
        public String Title { get; set; }		

        /// <summary>
        /// 文章作者
        /// </summary>
        public String Author { get; set; }		

        /// <summary>
        /// 文章内容
        /// </summary>
        public String Content { get; set; }		

        /// <summary>
        /// 文章分类
        /// </summary>
        public Guid? TypeId { get; set; }

        /// <summary>
        /// 创建时间
        /// </summary>
        public DateTime? CreateTime { get; set; }

        /// <summary>
        /// 更新时间
        /// </summary>
        public DateTime? UpdateTime { get; set; }

        /// <summary>
        /// 更新人
        /// </summary>
        public Guid? UpdateUser { get; set; }

        /// <summary>
        /// 创建人
        /// </summary>
        public Guid? Creator { get; set; }

        /// <summary>
        /// 0：不可用
        ///1：可用
        /// </summary>
        public Int32? Status { get; set; }
    }
}