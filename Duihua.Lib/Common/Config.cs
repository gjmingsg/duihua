using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Configuration;
using System.ComponentModel;
using System.Runtime.Serialization;
/// <summary>
/// Config 的摘要说明
/// </summary>

namespace Duihua.Lib.Common
{

    public enum SystemUserRole
    {
        [EnumMember(Value ="学生")]
        Student = 0,
         [EnumMember(Value = "合作单位")]
        Cooperator = 1,
           [EnumMember(Value = "老师")]
        Teacher = 2,
            [EnumMember(Value = "教务")]
        SuperTeacher = 3,
            [EnumMember(Value = "管理员")]
        Admin = 4
    }
}
public class Config
{
    public static string AttachmentPath { get { return HttpRuntime.AppDomainAppVirtualPath + ConfigurationManager.AppSettings["AttachmentPath"] +"/"; } }
    public static string[] ImageSavePath = new string[] { AttachmentPath + "img"
        , AttachmentPath + "flash"
        , AttachmentPath + "file" 
        , AttachmentPath + "video" 
    };

    
}
