CREATE TABLE [dbo].[Article] (
    [ID]         UNIQUEIDENTIFIER NOT NULL,
    [Title]      NVARCHAR (100)   NULL,
    [Author]     NVARCHAR (50)    NULL,
    [Content]    TEXT             NULL,
    [TypeId]     UNIQUEIDENTIFIER NULL,
    [CreateTime] DATETIME         NULL,
    [UpdateTime] DATETIME         NULL,
    [UpdateUser] NVARCHAR (30)    NULL,
    [Creator]    NVARCHAR (30)    NULL,
    [Status]     INT              NULL
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = '文章', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Article';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = '文章主键', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Article', @level2type = N'COLUMN', @level2name = N'ID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = '文章标题', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Article', @level2type = N'COLUMN', @level2name = N'Title';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = '文章作者', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Article', @level2type = N'COLUMN', @level2name = N'Author';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = '文章内容', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Article', @level2type = N'COLUMN', @level2name = N'Content';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = '文章分类', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Article', @level2type = N'COLUMN', @level2name = N'TypeId';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = '创建时间', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Article', @level2type = N'COLUMN', @level2name = N'CreateTime';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = '更新时间', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Article', @level2type = N'COLUMN', @level2name = N'UpdateTime';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = '更新人', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Article', @level2type = N'COLUMN', @level2name = N'UpdateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = '创建人', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Article', @level2type = N'COLUMN', @level2name = N'Creator';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = '0：不可用
1：可用', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Article', @level2type = N'COLUMN', @level2name = N'Status';

