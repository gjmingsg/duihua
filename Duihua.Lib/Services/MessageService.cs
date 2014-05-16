using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Duihua.Lib.Common;

namespace Duihua.Lib.Services
{
    public class MessageService
    {
        private readonly DBHelper _dao = new DBHelper();

        public int GetMessageCount(string username,string contactway,string message) {
            var result = _dao.QueryScalar(new Dictionary<String, Object>() { { "UserName", username }, { "ContactWay", contactway }, { "Message",message } }
                , @"select count(1) from message 
                    where  ContactWay LIKE '%'+@ContactWay+'%'
                    AND [UserName] LIKE '%'+@UserName+'%'
                    AND [Message] LIKE '%'+@Message+'%'"
                );
            return int.Parse(result.ToString());
        }

        public Dictionary<String, Object> GetMessage(String id) {
            return _dao.QueryListData(new Dictionary<string, object>() { { "Id", id } }, "select * from message where Id =@Id")[0];
        }

        public void InsertMessage(Dictionary<string, Object> dic) {
            _dao.ExecuteNonQuery(dic, @"INSERT INTO [dbo].[Message]
           ([UserName]
           ,[ContactWay]
           ,[Message]
           ,[CreateTime]
           ,[ID])
     VALUES
           (@UserName
           ,@ContactWay
           ,@Message
           ,GETDATE()
           ,NEWID())");
        }
    }
}
