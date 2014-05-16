using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Duihua.Lib.Common;

namespace Duihua.Lib.Services
{
    public class DefaultService
    {
        private readonly DBHelper _dao = new DBHelper();

        public Dictionary<String, Object> GetAbout() {
            var item1 = _dao.QueryListData(new Dictionary<String, Object>(), @"SELECT TOP 1 
at.TypeName
,at.ID
,a.[Content]
 FROM ArticleType at
INNER JOIN Article a ON a.TypeId = at.ID WHERE at.ParentID
IN(SELECT at2.id FROM ArticleType at2 WHERE at2.TypeCode = '00')
AND a.[Status] = 1
ORDER BY at.TypeCode ASC")[0];

            var item2 = _dao.QueryListData(new Dictionary<String, Object>(), @"SELECT at.ID,at.TypeName FROM ArticleType at WHERE
at.ParentID IN (
SELECT at2.id FROM ArticleType at2 WHERE at2.TypeCode = '00'	
)
ORDER BY at.TypeCode ASC");

            return new Dictionary<String,object>(){{"item1",item1},{"item2",item2}};
        }

        public Dictionary<String, Object> GetViewpoint() {
            var item1 = _dao.QueryListData(new Dictionary<String, Object>(), @"SELECT TOP 1 
at.TypeName
,at.ID
,a.[Content]
 FROM ArticleType at
INNER JOIN Article a ON a.TypeId = at.ID WHERE at.TypeCode = 20
AND a.[Status] = 1
ORDER BY a.UpdateTime DESC")[0];

            var item2 = _dao.QueryListData(new Dictionary<String, Object>(), @"SELECT TOP 1 
at.TypeName
,at.ID
,a.[Content]
 FROM ArticleType at
INNER JOIN Article a ON a.TypeId = at.ID WHERE at.TypeCode =19
AND a.[Status] = 1
ORDER BY a.UpdateTime DESC")[0];

            return new Dictionary<String, object>() { { "item1", item1 }, { "item2", item2 } };
        }

        public Dictionary<String, Object> GetWork() {
            var item1 = _dao.QueryListData(new Dictionary<String, Object>(), @"SELECT top 1 at.TypeName
,at.ID
,a.[Content]
 FROM ArticleType at
INNER JOIN Article a ON a.TypeId = at.ID WHERE at.TypeCode='17'
AND a.[Status] = 1
ORDER BY a.UpdateTime DESC")[0];

            var item2 = _dao.QueryListData(new Dictionary<String, Object>(), @"SELECT top 1 at.TypeName
,at.ID
,a.[Content]
 FROM ArticleType at
INNER JOIN Article a ON a.TypeId = at.ID WHERE at.TypeCode='18'
AND a.[Status] = 1
ORDER BY a.UpdateTime DESC")[0];
            return new Dictionary<String, object>() { { "item1", item1 }, { "item2", item2 } };
        }

        public Dictionary<String, Object> GetTEAM()
        {
            var item0 = _dao.QueryListData(new Dictionary<String, Object>(), @"SELECT
	at.ID,
	at.TypeName
FROM
	ArticleType at
	where at.TypeCode='03'")[0];
            var item1 = _dao.QueryListData(new Dictionary<String, Object>(), @"SELECT at.ID,at.TypeName FROM ArticleType at WHERE at.ParentID IN(
SELECT at1.ID FROM ArticleType at1 WHERE at1.TypeCode='03')
AND at.TypeCode=15")[0];

            var item2 = _dao.QueryListData(new Dictionary<String, Object>(), @"SELECT at.ID,at.TypeName FROM ArticleType at WHERE at.ParentID IN(
SELECT at1.ID FROM ArticleType at1 WHERE at1.TypeCode='03')
AND at.TypeCode=16")[0];

            return new Dictionary<String, object>() {{ "item0", item0 }, { "item1", item1 }, { "item2", item2 } };
        }

        public Dictionary<String, Object> GetPublish()
        {
            var item1 = _dao.QueryListData(new Dictionary<String, Object>(), @"SELECT TOP 1 
at.TypeName
,at.ID
,a.[Content]
 FROM ArticleType at
INNER JOIN Article a ON a.TypeId = at.ID WHERE at.TypeCode = 21
AND a.[Status] = 1
ORDER BY a.UpdateTime DESC")[0];

            var item2 = _dao.QueryListData(new Dictionary<String, Object>(), @"SELECT TOP 1 
at.TypeName
,at.ID
,a.[Content]
 FROM ArticleType at
INNER JOIN Article a ON a.TypeId = at.ID WHERE at.TypeCode =22
AND a.[Status] = 1
ORDER BY a.UpdateTime DESC")[0];

            return new Dictionary<String, object>() { { "item1", item1 }, { "item2", item2 } };
        }

        public Dictionary<String, Object> GetContact() {
            var item1 = _dao.QueryListData(new Dictionary<String, Object>(), @"SELECT TOP 1 
at.TypeName
,at.ID
,a.[Content]
 FROM ArticleType at
INNER JOIN Article a ON a.TypeId = at.ID WHERE at.TypeCode ='07'
AND a.[Status] = 1
ORDER BY a.UpdateTime DESC")[0];
            return new Dictionary<String, object>() { { "item1", item1 } };
        }

        public Dictionary<String, Object> GetInformation()
        {
            var item0 = _dao.QueryListData(new Dictionary<String, Object>(), @"SELECT TOP 1 
at.TypeName
,at.ID
,a.[Content]
 FROM ArticleType at
INNER JOIN Article a ON a.TypeId = at.ID WHERE at.TypeCode ='13'
AND a.[Status] = 1
ORDER BY a.UpdateTime DESC")[0];
            var item1 = _dao.QueryListData(new Dictionary<String, Object>(), @"SELECT TOP 1 
at.TypeName
,at.ID
,a.[Content]
 FROM ArticleType at
INNER JOIN Article a ON a.TypeId = at.ID WHERE at.TypeCode ='14'
AND a.[Status] = 1
ORDER BY a.UpdateTime DESC
")[0];
            var item2 = _dao.QueryListData(new Dictionary<String, Object>(), @"SELECT TOP 5
at.TypeName
,at.ID
,a.[Content]
,a.Title
 FROM ArticleType at
INNER JOIN Article a ON a.TypeId = at.ID WHERE at.TypeCode ='23'
AND a.[Status] = 1
ORDER BY a.UpdateTime DESC");
            return new Dictionary<String, object>() {{"item0",item0}, { "item1", item1 }, { "item2", item2 } };
        }
    }
}
