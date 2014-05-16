CREATE TABLE [dbo].[Message] (
    [UserName]   NVARCHAR (30)    NULL,
    [ContactWay] NVARCHAR (50)    NULL,
    [Message]    TEXT             NULL,
    [CreateTime] DATETIME         NULL,
    [ID]         UNIQUEIDENTIFIER NOT NULL
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = '留言', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Message';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = '姓名', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Message', @level2type = N'COLUMN', @level2name = N'UserName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = '联系方式', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Message', @level2type = N'COLUMN', @level2name = N'ContactWay';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = '留言内容', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Message', @level2type = N'COLUMN', @level2name = N'Message';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = '留言时间', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Message', @level2type = N'COLUMN', @level2name = N'CreateTime';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = '留言主键', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Message', @level2type = N'COLUMN', @level2name = N'ID';

