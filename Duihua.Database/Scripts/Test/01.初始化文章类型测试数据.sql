INSERT INTO [dbo].[ArticleType]
           ([ID]
           ,[ParentID]
           ,[TypeName]
           ,[TypeCode])
    SELECT 
    NEWID()
    ,null
    ,'关于对画'
    ,'0'
    UNION
    SELECT 
    NEWID()
    ,NULL
    ,'对画资讯'
    ,'1'
     UNION
     SELECT 
    NEWID()
    ,NULL
	,'对画成绩'
	,'2'
	 UNION
     SELECT 
    NEWID()
    ,NULL
	,'对画团队'
	,'3'
 UNION
     SELECT 
    NEWID()
    ,NULL
	,'对画作品'
	,'4'
 UNION
     SELECT 
    NEWID()
    ,NULL
	,'对画观点'
	,'5'
 UNION
     SELECT 
    NEWID()
    ,NULL
	,'对画出版'
	,'6'
 UNION
     SELECT 
    NEWID()
    ,NULL
,'联系对画'
,'7'
GO


INSERT INTO ArticleType
(
	ID,
	ParentID,
	TypeName,
	TypeCode
)
VALUES
(
	NEWID(),
	'A7F157CA-E2DD-455A-9A4E-4D2640B056D4',
	'对画简介',
	8
) 

INSERT INTO ArticleType
(
	ID,
	ParentID,
	TypeName,
	TypeCode
)
VALUES
(
	NEWID(),
	'A7F157CA-E2DD-455A-9A4E-4D2640B056D4',
	'对画理念',
	9
) 

INSERT INTO ArticleType
(
	ID,
	ParentID,
	TypeName,
	TypeCode
)
VALUES
(
	NEWID(),
	'A7F157CA-E2DD-455A-9A4E-4D2640B056D4',
	'对画文化',
	10
)

INSERT INTO ArticleType
(
	ID,
	ParentID,
	TypeName,
	TypeCode
)
VALUES
(
	NEWID(),
	'A7F157CA-E2DD-455A-9A4E-4D2640B056D4',
	'对画环境',
	11
)
INSERT INTO ArticleType
(
	ID,
	ParentID,
	TypeName,
	TypeCode
)
VALUES
(
	NEWID(),
	'A7F157CA-E2DD-455A-9A4E-4D2640B056D4',
	'核心团队',
	12
)


INSERT INTO ArticleType
(
	ID,
	ParentID,
	TypeName,
	TypeCode
)
VALUES
(
	NEWID(),
	'13E4E4F8-95A4-4AA8-AA83-0E227ADD476D',
	'对画新闻',
	'13'
)
INSERT INTO ArticleType
(
	ID,
	ParentID,
	TypeName,
	TypeCode
)
VALUES
(
	NEWID(),
	'13E4E4F8-95A4-4AA8-AA83-0E227ADD476D',
	'艺考资讯',
	'14'
)


INSERT INTO ArticleType
(
	ID,
	ParentID,
	TypeName,
	TypeCode
)
VALUES
(
	NEWID(),
	'2A25436B-B23B-4C53-A489-30F2EABEE128',
	'教师作品',
	17
)
INSERT INTO ArticleType
(
	ID,
	ParentID,
	TypeName,
	TypeCode
)
VALUES
(
	NEWID(),
	'2A25436B-B23B-4C53-A489-30F2EABEE128',
	'学生作品',
	18
)

INSERT INTO ArticleType
(
	ID,
	ParentID,
	TypeName,
	TypeCode
)
VALUES
(
	NEWID(),
	'F981B36E-0AFC-4237-849A-41709CC948A8',
	'核心团队',
	15
)
INSERT INTO ArticleType
(
	ID,
	ParentID,
	TypeName,
	TypeCode
)
VALUES
(
	NEWID(),
	'F981B36E-0AFC-4237-849A-41709CC948A8',
	'专业教师',
	16
)


INSERT INTO ArticleType
(
	ID,
	ParentID,
	TypeName,
	TypeCode
)
VALUES
(
	NEWID(),
	'2A25436B-B23B-4C53-A489-30F2EABEE128',
	'教师作品',
	17
)
INSERT INTO ArticleType
(
	ID,
	ParentID,
	TypeName,
	TypeCode
)
VALUES
(
	NEWID(),
	'2A25436B-B23B-4C53-A489-30F2EABEE128',
	'学生作品',
	18
)




INSERT INTO ArticleType
(
	ID,
	ParentID,
	TypeName,
	TypeCode
)
VALUES
(
	NEWID(),
	'51FA9C5E-C9CF-498C-9BE3-D2B3F7007D53',
	'教学札记',
	19
)
INSERT INTO ArticleType
(
	ID,
	ParentID,
	TypeName,
	TypeCode
)
VALUES
(
	NEWID(),
	'51FA9C5E-C9CF-498C-9BE3-D2B3F7007D53',
	'艺言艺语',
	20
)




INSERT INTO ArticleType
(
	ID,
	ParentID,
	TypeName,
	TypeCode
)
VALUES
(
	NEWID(),
	'2E827D8F-15DE-44CE-923A-BDD3F8BA1D17',
	'出版刊物',
	21
)
INSERT INTO ArticleType
(
	ID,
	ParentID,
	TypeName,
	TypeCode
)
VALUES
(
	NEWID(),
	'2E827D8F-15DE-44CE-923A-BDD3F8BA1D17',
	'内容教材',
	22
)

INSERT INTO ArticleType
(
	ID,
	ParentID,
	TypeName,
	TypeCode
)
VALUES
(
	NEWID(),
	'4C7B84A4-8AB0-4686-8469-00AA5E760AC9',
	'视频新闻',
	23
)