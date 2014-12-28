using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Duihua.Lib.Common;
using System.Web.Security;

namespace Duihua.Lib.Services.Education
{
    public class UserService
    {
        private readonly DBHelper _dao = new DBHelper();
        public Dictionary<String, Object> GetUser(string ID) {
            var l = _dao.QueryListData(new Dictionary<string, object>() { { "UserId", ID } }, 
@"SELECT au.UserId,au.UserName,au.MobileAlias Phone
,am.Email
,am.CreateDate
,am.Comment Intro
 FROM aspnet_Users au INNER JOIN aspnet_Membership am ON am.UserId = au.UserId
where  am.userid = @UserId");
            if (l.Count == 0)
                return null;
            else
            {
                if (!l[0].ContainsKey("PicUrl"))
                    l[0].Add("PicUrl", "~/images/noimage.jpg");
                return l[0];
            }
        }


        string sqlInsertStudent = @"INSERT INTO [dbo].[Student]
                                       ([UserId]
                                       ,[CooperatorId]
                                       ,[StuNumber]
                                       ,[StudentName]
                                       ,[ParentName]
                                       ,[Phone]
                                       ,[Email]
                                       ,[CreateDate]
                                       ,[Intro]
                                       ,[IDCard]
                                       ,[Address]
                                       ,[Status]
                                       ,[Sex]
                                       ,[RegisterTime]
                                       ,[PicUrl])
                                 VALUES
                                       (@UserId
                                       ,@CooperatorId
                                       ,@StuNumber
                                       ,@StudentName
                                       ,@ParentName
                                       ,@Phone
                                       ,@Email
                                       ,GETDATE()
                                       ,@Intro
                                       ,@IDCard
                                       ,@Address
                                       ,@Status
                                       ,@Sex
                                       ,@RegisterTime
                                       ,@PicUrl)";
        string sqlCooperator = @"SELECT [CooperatorId]
                                          ,[CooperatorName]
                                          ,[Address]
                                          ,[Intro]
                                          ,[CreateTime]
                                          ,[UpdateTime]
                                          ,[Creator]
                                          ,[UpdateUser]
                                          ,[Email]
                                          ,[Phone]
                                      FROM  [dbo].[Cooperator]
                                     WHERE CooperatorName = @CooperatorName";
        string sqlInsertCooperator = @"INSERT INTO  [dbo].[Cooperator]
                                           ([CooperatorId]
                                            ,[CooperatorName]
                                            ,[Address]
                                            ,[Intro]
                                            ,[CreateTime]
                                            ,[Creator]
                                            )
                                        VALUES
                                            (@CooperatorId
                                            ,@CooperatorName
                                            ,@Address
                                            ,@Intro
                                            ,GETDATE()
                                            ,@Creator
                                            )";
        public string InsertStudent(Dictionary<string, object> dic)
        {
            try
            {
                var lCooperator = _dao.QueryListData(new Dictionary<string, object>() { { "CooperatorName", dic["CooperatorName"] } }, sqlCooperator);
                if (lCooperator == null || lCooperator.Count == 0)
                {
                    Membership.CreateUser(dic["CooperatorName"].ToString(), "123456");
                    var CooperatorId = Membership.GetUser(dic["CooperatorName"].ToString()).ProviderUserKey.ToString();
                    var Creator = "B780FF21-DEF6-499E-8955-DF440F4B3A68";
                    dic.Add("CooperatorId", CooperatorId);
                    _dao.ExecuteNonQuery(new Dictionary<string, object>() { 
                            { "CooperatorId", CooperatorId } 
                            ,{"Creator",Creator}
                            ,{"CooperatorName",dic["CooperatorName"]}
                            ,{"Address",dic["CooperatorName"]}
                            ,{"Intro",dic["CooperatorName"]}
                            }, sqlInsertCooperator);

                    Roles.AddUsersToRole(new string[] { dic["CooperatorName"].ToString() }, "合作单位");
                }
                else
                {
                    dic.Add("CooperatorId", lCooperator[0]["CooperatorId"]);
                }
                var count = int.Parse(_dao.QueryScalar(new Dictionary<string, object>() { { "StudentName", dic["StudentName"] } }, "SELECT COUNT(1) FROM aspnet_Users au WHERE au.UserName = @StudentName").ToString());
                if (count > 0)
                {
                    return string.Format("第【{0}】行的学生名称【{1}】在系统中存在，或者重名，请修改名称或这个给该名称加前缀。<br/>", dic["RowNum"], dic["StudentName"]);
                };
                dic["Address"] = (dic["Address"] + "") + "。宿舍号：" + (dic["RoomId"] + "") + "。家长电话：" + (dic["ParentPhone"] + "");
                dic.Remove("CooperatorName");
                dic.Remove("RoomId");
                dic.Remove("ParentPhone");
                dic.Remove("ClassName");
                dic.Remove("RowNum");
                dic.Add("Intro", DBNull.Value);
                dic.Add("Email", DBNull.Value);
                dic.Add("PicUrl", DBNull.Value);
                dic.Add("Status", "1");
                Membership.CreateUser(dic["StudentName"].ToString(), "123456");
                dic.Add("UserId", Membership.GetUser(dic["StudentName"].ToString()).ProviderUserKey.ToString());
                _dao.ExecuteNonQuery(dic, sqlInsertStudent);
                
            }
            catch (Exception e) {
                return e.Message;
            }
            return "";
        }

    }
}
