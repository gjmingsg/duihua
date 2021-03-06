﻿using System;
using System.Collections.Generic;
using Duihua.Lib.Common;



namespace Duihua.Lib.Services
{
    public class ArticleService
    {
        private readonly DBHelper _dao = new DBHelper();

        public int GetArticleCount(string Title, string Content, string TypeId, string Status, String QTypeId)
        {
            var q = new Dictionary<string, object>() { { "Title", Title }, { "Content", Content }, { "Status", Status }, { "QTypeId", QTypeId } };
            if (string.IsNullOrEmpty(TypeId) == false)
                q.Add("TypeId", TypeId);
            else
                q.Add("TypeId", null);
            
                
            var result = _dao.QueryScalar(q,
            @"
           SELECT COUNT(1) FROM Article a INNER JOIN ArticleType at
                ON at.ID = a.TypeId
                WHERE 1=1
                AND a.Title LIKE '%' +@Title+ '%'
                AND(a.[Content] is null or a.[Content] LIKE '%'+@Content+'%')
                AND at.ParentID = @QTypeId");
            return int.Parse(result.ToString());
        }

        public Dictionary<String, Object> GetArticle(String id)
        {
            var l = _dao.QueryListData(new Dictionary<string, object>() { { "Id", id } }, 
                            @"SELECT a.*,at.TypeName,ROW_NUMBER()OVER(ORDER BY updatetime desc)pageIndex
                              FROM Article a INNER JOIN ArticleType at
                            ON at.ID = a.TypeId
                            WHERE a.ID = @Id");
            if(l.Count==0)
                return null;
            return l[0];
        }
        public List<Dictionary<String, Object>> GetArticleList(String id)
        {
            return _dao.QueryListData(new Dictionary<string, object>() { { "Id", id } },
                            @"SELECT a.*,at.TypeName,ROW_NUMBER()OVER(ORDER BY updatetime desc)pageIndex
                              FROM Article a INNER JOIN ArticleType at
                            ON at.ID = a.TypeId
                            WHERE at.ID = @Id");
        }
        public void PubishArt(string Id) {
            _dao.ExecuteNonQuery(new Dictionary<String, Object>() { { "Id", Id } }, @"update Article set status = 1 where id = @Id");
        }
    }
}