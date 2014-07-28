using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Duihua.Lib.Common;

namespace Duihua.Lib.Services.Education
{
    public class AttachmentService
    {
        private readonly DBHelper _dao = new DBHelper();
        public Dictionary<String, Object> GetAttachment(string id)
        {
            var param = new Dictionary<String, Object>() { { "ID", id } };
            var list = _dao.QueryListData(param, @"SELECT a.*,SUBSTRING(a.AttachmentName,CHARINDEX('@',a.AttachmentName,0)+1,LEN(a.AttachmentName)) [filename] FROM Attachment a WHERE a.AttachmentId = @ID");
            if (list.Count == 0)
                return null;
            else
                return list[0];
        }
        public void IncDownloadCount(string id) {
            var param = new Dictionary<String, Object>() { { "ID", id } };
            _dao.ExecuteNonQuery(param, @"UPDATE Attachment
                SET	DownCount = DownCount + 1
                WHERE 	AttachmentId = @ID");
        }

        public void SaveAttachment(string AttachmentName, string Size, string Path, string ModuleName, string ModuleId)
        {
            Dictionary<string, object> doc = new Dictionary<string, object>() { 
            { "AttachmentName", AttachmentName },
            {"Size",Size},
            {"Path",Path},
            {"ModuleName",ModuleName},
            {"ModuleId",ModuleId}
            };
            _dao.ExecuteNonQuery(doc, @"INSERT INTO [dbo].[Attachment]
           ([AttachmentId]
           ,[AttachmentName]
           ,[Size]
           ,[Path]
           ,[DownCount]
           ,[ModuleName]
           ,[ModuleId]
           ,[CreateDate])
     VALUES
           (NEWID()
           ,@AttachmentName
           ,@Size
           ,@Path
           ,0
           ,@ModuleName
           ,@ModuleId
           ,GETDATE())");
        }
    }
}
