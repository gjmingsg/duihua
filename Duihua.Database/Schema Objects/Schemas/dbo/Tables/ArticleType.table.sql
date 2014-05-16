CREATE TABLE [dbo].[ArticleType] (
    [ID]       UNIQUEIDENTIFIER NOT NULL,
    [ParentID] UNIQUEIDENTIFIER NULL,
    [TypeName] NVARCHAR (50)    NULL,
    [TypeCode] NVARCHAR (5)     NULL
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = '0：关于对画
1：对画资讯
2：对画成绩
3：对画团队
4：对画作品
5：对画观点
6：对画出版
7：联系对画', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ArticleType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = '主键', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ArticleType', @level2type = N'COLUMN', @level2name = N'ID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = '父键', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ArticleType', @level2type = N'COLUMN', @level2name = N'ParentID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = '类型名称', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ArticleType', @level2type = N'COLUMN', @level2name = N'TypeName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = '类型编码', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ArticleType', @level2type = N'COLUMN', @level2name = N'TypeCode';

