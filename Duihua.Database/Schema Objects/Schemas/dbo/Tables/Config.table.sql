CREATE TABLE [dbo].[Config] (
    [ID]          UNIQUEIDENTIFIER NOT NULL,
    [ConfigName]  NVARCHAR (10)    NULL,
    [ConfigValue] NVARCHAR (1000)  NULL
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = '配置信息', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Config';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = '主键', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Config', @level2type = N'COLUMN', @level2name = N'ID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = '配置名', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Config', @level2type = N'COLUMN', @level2name = N'ConfigName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = '配置值', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Config', @level2type = N'COLUMN', @level2name = N'ConfigValue';

