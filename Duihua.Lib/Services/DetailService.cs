using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Duihua.Lib.Common;

namespace Duihua.Lib.Services
{
    public class DetailService
    {
        private readonly DBHelper _dao = new DBHelper();
        public List<Dictionary<String, Object>> LoadMenu(String Id) {
            return _dao.QueryListData(new Dictionary<string, object>(){{"Id",Id}}, @"SELECT at.* FROM ArticleType at 
                    INNER JOIN ArticleType at2 ON  at2.ParentID = at.ParentID
                    WHERE  at2.ID = @Id
                    order by at.TypeCode asc");
        }

        public List<Dictionary<string,object>> GetArticleList(String Id){
            return _dao.QueryListData(new Dictionary<string,object>(){{"Id",Id}},@"SELECT a.*,at.TypeCode FROM Article a
                    INNER JOIN   ArticleType at ON at.ID = a.TypeId 
                    INNER JOIN ArticleType at2 ON  at2.ParentID = at.ParentID
                    WHERE  at2.ID =@Id
                    ORDER BY at.TypeCode asc");
        }
        
    }
}
