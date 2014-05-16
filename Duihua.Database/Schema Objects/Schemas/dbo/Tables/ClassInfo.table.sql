CREATE TABLE [dbo].[ClassInfo] (
    [ID]        UNIQUEIDENTIFIER NOT NULL,
    [ClassName] NVARCHAR (50)    NULL,
    [Year]      INT              NULL,
    [StartTime] DATETIME         NULL,
    [EndTime]   DATETIME         NULL,
    [IsFinish]  INT              NULL,
    [Intro]     TEXT             NULL
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = '开班信息', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ClassInfo';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = '主键', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ClassInfo', @level2type = N'COLUMN', @level2name = N'ID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = '班级名称', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ClassInfo', @level2type = N'COLUMN', @level2name = N'ClassName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = '开班年份', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ClassInfo', @level2type = N'COLUMN', @level2name = N'Year';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = '注册时间开始', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ClassInfo', @level2type = N'COLUMN', @level2name = N'StartTime';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = '注册结束时间', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ClassInfo', @level2type = N'COLUMN', @level2name = N'EndTime';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = '是否允许注册', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ClassInfo', @level2type = N'COLUMN', @level2name = N'IsFinish';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = '班级信息', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ClassInfo', @level2type = N'COLUMN', @level2name = N'Intro';

