CREATE TABLE [dbo].[RegisterInfo] (
    [ID]         UNIQUEIDENTIFIER NOT NULL,
    [RegistName] NVARCHAR (50)    NULL,
    [QQ]         NVARCHAR (30)    NULL,
    [Email]      NVARCHAR (50)    NULL,
    [Phone]      NVARCHAR (30)    NULL,
    [Intro]      TEXT             NULL,
    [ClassID]    UNIQUEIDENTIFIER NULL,
    [RegisterNo] NVARCHAR (30)    NULL,
    [CreateTime] DATETIME         NULL,
    [Status]     INT              NULL,
    [Address]    NVARCHAR (500)   NULL
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = '报名信息', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'RegisterInfo';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = '主键', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'RegisterInfo', @level2type = N'COLUMN', @level2name = N'ID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = '报名人', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'RegisterInfo', @level2type = N'COLUMN', @level2name = N'RegistName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = '报名人联系方式QQ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'RegisterInfo', @level2type = N'COLUMN', @level2name = N'QQ';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = '报名人联系方式邮箱', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'RegisterInfo', @level2type = N'COLUMN', @level2name = N'Email';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = '报名人联系方式手机', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'RegisterInfo', @level2type = N'COLUMN', @level2name = N'Phone';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = '报名人简介', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'RegisterInfo', @level2type = N'COLUMN', @level2name = N'Intro';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = '报名人所选班级', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'RegisterInfo', @level2type = N'COLUMN', @level2name = N'ClassID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = '报名号', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'RegisterInfo', @level2type = N'COLUMN', @level2name = N'RegisterNo';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = '创建时间', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'RegisterInfo', @level2type = N'COLUMN', @level2name = N'CreateTime';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = '0：不可用
1：可用', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'RegisterInfo', @level2type = N'COLUMN', @level2name = N'Status';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = '地址', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'RegisterInfo', @level2type = N'COLUMN', @level2name = N'Address';

