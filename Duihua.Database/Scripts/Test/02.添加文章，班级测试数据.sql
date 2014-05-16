INSERT INTO [Duihua].[dbo].[Article]
           ([ID]
           ,[Title]
           ,[Author]
           ,[Content]
           ,[TypeId]
           ,[CreateTime]
           ,[UpdateTime]
           ,[UpdateUser]
           ,[Creator]
           ,[Status])
     select
           NEWID()
           ,'用Ueditor为Asp.net mvc打造可视化HTML编辑器'
           ,'guest'
           ,'在Asp.net WebForm时代，Web系统的HTML可视化编辑器可以使用FTB一类的控件，直接引入工具箱拖拉即可实现。但是在Asp.net MVC时代，直接使用服务器端控件是不符合MVC的标准和约束，会出现这样或者那样的问题。UEditor似乎又是不错的一款可视化编辑器，有百度做后台支撑，开源，而且样式漂亮，自定义容易……所以我决定在我的系统中使用Ueditor作为可视化编辑工具，但是因为Ueditor支持了Php，并没有合适asp.net mvc的应用实例。所以我决定改造下Ueditor来满足MVC下的需要。'
           ,at.ID
           ,GETDATE()
           ,GETDATE()
           ,'guest'
           ,'guest'
           ,1
     FROM ArticleType at
GO
INSERT INTO [Duihua].[dbo].[Article]
           ([ID]
           ,[Title]
           ,[Author]
           ,[Content]
           ,[TypeId]
           ,[CreateTime]
           ,[UpdateTime]
           ,[UpdateUser]
           ,[Creator]
           ,[Status])
     select
           NEWID()
           ,'用Ueditor为Asp.net mvc打造可视化HTML编辑器'
           ,'guest'
           ,'在Asp.net WebForm时代，Web系统的HTML可视化编辑器可以使用FTB一类的控件，直接引入工具箱拖拉即可实现。但是在Asp.net MVC时代，直接使用服务器端控件是不符合MVC的标准和约束，会出现这样或者那样的问题。UEditor似乎又是不错的一款可视化编辑器，有百度做后台支撑，开源，而且样式漂亮，自定义容易……所以我决定在我的系统中使用Ueditor作为可视化编辑工具，但是因为Ueditor支持了Php，并没有合适asp.net mvc的应用实例。所以我决定改造下Ueditor来满足MVC下的需要。'
           ,at.ID
           ,GETDATE()
           ,GETDATE()
           ,'guest'
           ,'guest'
           ,0
     FROM ArticleType at
GO



INSERT INTO ClassInfo
(
	ID,
	ClassName,
	[Year],
	StartTime,
	EndTime,
	IsFinish,
	Intro
)
VALUES
(
	NEWID(),
	'普通班',
	2014,
	GETDATE(),
	GETDATE(),
	0,
	''
)


INSERT INTO [Duihua].[dbo].[RegisterInfo]
           ([ID]
           ,[RegistName]
           ,[QQ]
           ,[Email]
           ,[Phone]
           ,[Intro]
           ,[ClassID]
           ,[RegisterNo]
           ,[CreateTime]
           ,[Status]
           ,[Address])
     VALUES
           (NEWID()
           ,'张三'
           ,'396043897'
           ,'396043897@qq.com'
           ,'1390000000'
           ,'abc'
           ,'E649FAF8-710D-47A7-9404-C6ECF84FE65E'
           ,'123'
           ,GETDATE()
           ,1
           ,'广州番禺')



