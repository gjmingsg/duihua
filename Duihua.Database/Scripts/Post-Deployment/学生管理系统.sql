/*==============================================================*/
/* DBMS name:      Microsoft SQL Server 2008                    */
/* Created on:     2014/6/21 星期六 23:03:44                       */
/*==============================================================*/


if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('ClassGrade') and o.name = 'FK_CLASSGRA_REFERENCE_TEACHER')
alter table ClassGrade
   drop constraint FK_CLASSGRA_REFERENCE_TEACHER
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('HomeWork') and o.name = 'FK_HOMEWORK_REFERENCE_CLASSGRA')
alter table HomeWork
   drop constraint FK_HOMEWORK_REFERENCE_CLASSGRA
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('JoinClass') and o.name = 'FK_JOINCLAS_REFERENCE_STUDENT')
alter table JoinClass
   drop constraint FK_JOINCLAS_REFERENCE_STUDENT
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('JoinClass') and o.name = 'FK_JOINCLAS_REFERENCE_CLASSGRA')
alter table JoinClass
   drop constraint FK_JOINCLAS_REFERENCE_CLASSGRA
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('Student') and o.name = 'FK_STUDENT_REFERENCE_COOPERAT')
alter table Student
   drop constraint FK_STUDENT_REFERENCE_COOPERAT
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('WorkResult') and o.name = 'FK_WORKRESU_REFERENCE_STUDENT')
alter table WorkResult
   drop constraint FK_WORKRESU_REFERENCE_STUDENT
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('WorkResult') and o.name = 'FK_WORKRESU_REFERENCE_HOMEWORK')
alter table WorkResult
   drop constraint FK_WORKRESU_REFERENCE_HOMEWORK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('Attachment')
            and   type = 'U')
   drop table Attachment
go

if exists (select 1
            from  sysobjects
           where  id = object_id('ClassGrade')
            and   type = 'U')
   drop table ClassGrade
go

if exists (select 1
            from  sysobjects
           where  id = object_id('ComMessage')
            and   type = 'U')
   drop table ComMessage
go

if exists (select 1
            from  sysobjects
           where  id = object_id('Cooperator')
            and   type = 'U')
   drop table Cooperator
go

if exists (select 1
            from  sysobjects
           where  id = object_id('HomeWork')
            and   type = 'U')
   drop table HomeWork
go

if exists (select 1
            from  sysobjects
           where  id = object_id('JoinClass')
            and   type = 'U')
   drop table JoinClass
go

if exists (select 1
            from  sysobjects
           where  id = object_id('Student')
            and   type = 'U')
   drop table Student
go

if exists (select 1
            from  sysobjects
           where  id = object_id('Teacher')
            and   type = 'U')
   drop table Teacher
go

if exists (select 1
            from  sysobjects
           where  id = object_id('WorkResult')
            and   type = 'U')
   drop table WorkResult
go

/*==============================================================*/
/* Table: Attachment                                            */
/*==============================================================*/
create table Attachment (
   AttachmentId         uniqueidentifier     not null,
   AttachmentName       nvarchar(100)        null,
   Size                 decimal              null,
   Path                 nvarchar(500)        null,
   DownCount            int                  null,
   ModuleName           nvarchar(30)         null,
   ModuleId             uniqueidentifier     null,
   constraint PK_ATTACHMENT primary key (AttachmentId)
)
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sys.sp_addextendedproperty 'MS_Description', 
   '附件',
   'user', @CurrentUser, 'table', 'Attachment'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '附件主键',
   'user', @CurrentUser, 'table', 'Attachment', 'column', 'AttachmentId'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '附件名称',
   'user', @CurrentUser, 'table', 'Attachment', 'column', 'AttachmentName'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '附件大小',
   'user', @CurrentUser, 'table', 'Attachment', 'column', 'Size'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '附件路径',
   'user', @CurrentUser, 'table', 'Attachment', 'column', 'Path'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '下载次数',
   'user', @CurrentUser, 'table', 'Attachment', 'column', 'DownCount'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '所属模块',
   'user', @CurrentUser, 'table', 'Attachment', 'column', 'ModuleName'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '模块主键',
   'user', @CurrentUser, 'table', 'Attachment', 'column', 'ModuleId'
go

/*==============================================================*/
/* Table: ClassGrade                                            */
/*==============================================================*/
create table ClassGrade (
   ClassID              uniqueidentifier     not null,
   UserId               uniqueidentifier     null,
   GradeName            nvarchar(500)        null,
   Year                 nvarchar(50)         null,
   班级说明                 text                 null,
   constraint PK_CLASSGRADE primary key (ClassID)
)
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sys.sp_addextendedproperty 'MS_Description', 
   '班级',
   'user', @CurrentUser, 'table', 'ClassGrade'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '班级主键',
   'user', @CurrentUser, 'table', 'ClassGrade', 'column', 'ClassID'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '教师主键',
   'user', @CurrentUser, 'table', 'ClassGrade', 'column', 'UserId'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '班级名称',
   'user', @CurrentUser, 'table', 'ClassGrade', 'column', 'GradeName'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '班级学年',
   'user', @CurrentUser, 'table', 'ClassGrade', 'column', 'Year'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '班级说明',
   'user', @CurrentUser, 'table', 'ClassGrade', 'column', '班级说明'
go

/*==============================================================*/
/* Table: ComMessage                                            */
/*==============================================================*/
create table ComMessage (
   MessageId            uniqueidentifier     not null,
   Content              text                 null,
   Title                nvarchar(100)        null,
   CreateTime           datetime             null,
   Creator              uniqueidentifier     null,
   Receive              uniqueidentifier     null,
   "Rule"               nvarchar(500)        null,
   RefMessageId         uniqueidentifier     null,
   constraint PK_COMMESSAGE primary key (MessageId)
)
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sys.sp_addextendedproperty 'MS_Description', 
   '沟通留言',
   'user', @CurrentUser, 'table', 'ComMessage'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '留言主键',
   'user', @CurrentUser, 'table', 'ComMessage', 'column', 'MessageId'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '留言内容',
   'user', @CurrentUser, 'table', 'ComMessage', 'column', 'Content'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '留言标题',
   'user', @CurrentUser, 'table', 'ComMessage', 'column', 'Title'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '留言时间',
   'user', @CurrentUser, 'table', 'ComMessage', 'column', 'CreateTime'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '留言者',
   'user', @CurrentUser, 'table', 'ComMessage', 'column', 'Creator'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '接收留言的人',
   'user', @CurrentUser, 'table', 'ComMessage', 'column', 'Receive'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '查看权限',
   'user', @CurrentUser, 'table', 'ComMessage', 'column', 'Rule'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '所回复的留言',
   'user', @CurrentUser, 'table', 'ComMessage', 'column', 'RefMessageId'
go

/*==============================================================*/
/* Table: Cooperator                                            */
/*==============================================================*/
create table Cooperator (
   CooperatorId         uniqueidentifier     not null,
   CooperatorName       nvarchar(200)        null,
   Address              nvarchar(300)        null,
   Intro                text                 null,
   constraint PK_COOPERATOR primary key (CooperatorId)
)
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sys.sp_addextendedproperty 'MS_Description', 
   '合作单位',
   'user', @CurrentUser, 'table', 'Cooperator'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '单位主键',
   'user', @CurrentUser, 'table', 'Cooperator', 'column', 'CooperatorId'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '单位名称',
   'user', @CurrentUser, 'table', 'Cooperator', 'column', 'CooperatorName'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '所在地址',
   'user', @CurrentUser, 'table', 'Cooperator', 'column', 'Address'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '单位描述',
   'user', @CurrentUser, 'table', 'Cooperator', 'column', 'Intro'
go

/*==============================================================*/
/* Table: HomeWork                                              */
/*==============================================================*/
create table HomeWork (
   ClassID              uniqueidentifier     null,
   WorkID               uniqueidentifier     not null,
   Title                nvarchar(100)        null,
   Content              text                 null,
   DeadLine             datetime             null,
   Score                decimal(8,1)         null,
   constraint PK_HOMEWORK primary key (WorkID)
)
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sys.sp_addextendedproperty 'MS_Description', 
   '作业任务',
   'user', @CurrentUser, 'table', 'HomeWork'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '班级主键',
   'user', @CurrentUser, 'table', 'HomeWork', 'column', 'ClassID'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '作业主键',
   'user', @CurrentUser, 'table', 'HomeWork', 'column', 'WorkID'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '作业标题',
   'user', @CurrentUser, 'table', 'HomeWork', 'column', 'Title'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '作业内容',
   'user', @CurrentUser, 'table', 'HomeWork', 'column', 'Content'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '作业提交期限',
   'user', @CurrentUser, 'table', 'HomeWork', 'column', 'DeadLine'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '作业分值',
   'user', @CurrentUser, 'table', 'HomeWork', 'column', 'Score'
go

/*==============================================================*/
/* Table: JoinClass                                             */
/*==============================================================*/
create table JoinClass (
   UserId               uniqueidentifier     not null,
   ClassID              uniqueidentifier     not null,
   constraint PK_JOINCLASS primary key (UserId, ClassID)
)
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sys.sp_addextendedproperty 'MS_Description', 
   '加入班级',
   'user', @CurrentUser, 'table', 'JoinClass'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '学生主键',
   'user', @CurrentUser, 'table', 'JoinClass', 'column', 'UserId'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '班级主键',
   'user', @CurrentUser, 'table', 'JoinClass', 'column', 'ClassID'
go

/*==============================================================*/
/* Table: Student                                               */
/*==============================================================*/
create table Student (
   UserId               uniqueidentifier     not null,
   CooperatorId         uniqueidentifier     null,
   StuNumber            nvarchar(30)         null,
   StudentName          nvarchar(50)         null,
   ParentName           nvarchar(50)         null,
   Phone                nvarchar(20)         null,
   Email                nvarchar(30)         null,
   CreateDate           datetime             null,
   UpdateDate           datetime             null,
   Intro                text                 null,
   IDCard               nvarchar(50)         null,
   Address              nvarchar(500)        null,
   constraint PK_STUDENT primary key (UserId)
)
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sys.sp_addextendedproperty 'MS_Description', 
   '学生注册信息',
   'user', @CurrentUser, 'table', 'Student'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '学生主键',
   'user', @CurrentUser, 'table', 'Student', 'column', 'UserId'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '单位主键',
   'user', @CurrentUser, 'table', 'Student', 'column', 'CooperatorId'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '学号',
   'user', @CurrentUser, 'table', 'Student', 'column', 'StuNumber'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '姓名',
   'user', @CurrentUser, 'table', 'Student', 'column', 'StudentName'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '家长名称',
   'user', @CurrentUser, 'table', 'Student', 'column', 'ParentName'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '联系电话',
   'user', @CurrentUser, 'table', 'Student', 'column', 'Phone'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '邮箱',
   'user', @CurrentUser, 'table', 'Student', 'column', 'Email'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '创建时间',
   'user', @CurrentUser, 'table', 'Student', 'column', 'CreateDate'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '更新时间',
   'user', @CurrentUser, 'table', 'Student', 'column', 'UpdateDate'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '简介',
   'user', @CurrentUser, 'table', 'Student', 'column', 'Intro'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '身份证',
   'user', @CurrentUser, 'table', 'Student', 'column', 'IDCard'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '地址',
   'user', @CurrentUser, 'table', 'Student', 'column', 'Address'
go

/*==============================================================*/
/* Table: Teacher                                               */
/*==============================================================*/
create table Teacher (
   UserId               uniqueidentifier     not null,
   TeachName            nvarchar(50)         null,
   joinTime             datetime             null,
   Intro                text                 null,
   constraint PK_TEACHER primary key (UserId)
)
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sys.sp_addextendedproperty 'MS_Description', 
   '教师信息',
   'user', @CurrentUser, 'table', 'Teacher'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '教师主键',
   'user', @CurrentUser, 'table', 'Teacher', 'column', 'UserId'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '教师名称',
   'user', @CurrentUser, 'table', 'Teacher', 'column', 'TeachName'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '教师入职时间',
   'user', @CurrentUser, 'table', 'Teacher', 'column', 'joinTime'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '教师简介',
   'user', @CurrentUser, 'table', 'Teacher', 'column', 'Intro'
go

/*==============================================================*/
/* Table: WorkResult                                            */
/*==============================================================*/
create table WorkResult (
   WorkID               uniqueidentifier     null,
   UserId               uniqueidentifier     null,
   ProductId            uniqueidentifier     not null,
   Evaluate             text                 null,
   SubmitTime           datetime             null,
   GradeTime            datetime             null,
   ModifyCount          int                  null,
   CreateTime           datetime             null,
   Score                decimal(8,1)         null,
   constraint PK_WORKRESULT primary key (ProductId)
)
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sys.sp_addextendedproperty 'MS_Description', 
   '作业成果',
   'user', @CurrentUser, 'table', 'WorkResult'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '作业主键',
   'user', @CurrentUser, 'table', 'WorkResult', 'column', 'WorkID'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '学生主键',
   'user', @CurrentUser, 'table', 'WorkResult', 'column', 'UserId'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '成果主键',
   'user', @CurrentUser, 'table', 'WorkResult', 'column', 'ProductId'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '评价',
   'user', @CurrentUser, 'table', 'WorkResult', 'column', 'Evaluate'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '提交时间',
   'user', @CurrentUser, 'table', 'WorkResult', 'column', 'SubmitTime'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '评分时间',
   'user', @CurrentUser, 'table', 'WorkResult', 'column', 'GradeTime'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '修改次数',
   'user', @CurrentUser, 'table', 'WorkResult', 'column', 'ModifyCount'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '创建时间',
   'user', @CurrentUser, 'table', 'WorkResult', 'column', 'CreateTime'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '获得分数',
   'user', @CurrentUser, 'table', 'WorkResult', 'column', 'Score'
go

alter table ClassGrade
   add constraint FK_CLASSGRA_REFERENCE_TEACHER foreign key (UserId)
      references Teacher (UserId)
go

alter table HomeWork
   add constraint FK_HOMEWORK_REFERENCE_CLASSGRA foreign key (ClassID)
      references ClassGrade (ClassID)
go

alter table JoinClass
   add constraint FK_JOINCLAS_REFERENCE_STUDENT foreign key (UserId)
      references Student (UserId)
go

alter table JoinClass
   add constraint FK_JOINCLAS_REFERENCE_CLASSGRA foreign key (ClassID)
      references ClassGrade (ClassID)
go

alter table Student
   add constraint FK_STUDENT_REFERENCE_COOPERAT foreign key (CooperatorId)
      references Cooperator (CooperatorId)
go

alter table WorkResult
   add constraint FK_WORKRESU_REFERENCE_STUDENT foreign key (UserId)
      references Student (UserId)
go

alter table WorkResult
   add constraint FK_WORKRESU_REFERENCE_HOMEWORK foreign key (WorkID)
      references HomeWork (WorkID)
go

