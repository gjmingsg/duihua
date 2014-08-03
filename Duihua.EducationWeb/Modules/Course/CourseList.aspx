<%@ Page Title="课程信息管理" Language="C#" MasterPageFile="~/Layout/AdminDefault.Master" AutoEventWireup="true" CodeBehind="CourseList.aspx.cs" Inherits="Duihua.EducationWeb.Modules.Course.CourseList" %>
<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <script type="text/javascript" src="../../Scripts/bootstrap-datetimepicker.min.js"></script>
      <link href="../../Styles/bootstrap-datetimepicker.min.css" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<div runat="server" id="list"  class="panel panel-success">
    <div  class="panel-heading">
        <h3 class="panel-title">课程信息管理</h3>
    </div>
    <div class="panel-body">
        <div  class="col-sm-12  col-xs-12">
            <div class="form-group  col-sm-offset-6  col-xs-offset-3 col-sm-2 col-xs-3">
                <label class="sr-only" for="tbClassName">班级名称</label>
                <asp:TextBox runat="server" ClientIDMode="Static"  ID="tbClassName" CssClass="form-control" placeholder="输入班级名称"></asp:TextBox>
            </div>
            <div class="form-group col-sm-2 col-xs-3">
                <label class="sr-only" for="tbCourseName">课程名称</label>
                <asp:TextBox runat="server" ClientIDMode="Static"  ID="tbCourseName" CssClass="form-control" placeholder="输入课程名称"></asp:TextBox>
            </div>
             <div class="form-group col-sm-2 col-xs-3">
                <label class="sr-only" for="tbTeachName">教师名称</label>
                <asp:TextBox runat="server" ClientIDMode="Static"  ID="tbTeachName" CssClass="form-control" placeholder="输入教师名称"></asp:TextBox>

            </div>
        </div>
        <div class="col-sm-12  col-xs-12">
            <div class="form-group col-sm-offset-6  col-xs-offset-3  col-sm-2  col-xs-5">
                <label class="sr-only" for="ddSemester">学期</label>
                <asp:DropDownList runat="server"  ClientIDMode="Static"  ID="ddSemester" DataTextField="SemesterName" DataValueField="SemesterID" DataSourceID="SqlDataSource2" CssClass="form-control" AppendDataBoundItems="true">
                <asp:ListItem Text="--请选择学期--" Value="00000000-0000-0000-0000-000000000000"></asp:ListItem>
                </asp:DropDownList>
            </div>
            <div class="form-group  col-sm-2 col-xs-2">
                <asp:Button runat="server" ID="btnSearch" ClientIDMode="Static" Text="搜索" onclick="btnSearch_Click" CssClass="btn btn-default"/>
            </div>
            <div class="form-group  col-sm-2 col-xs-2">
                <asp:Button runat="server" ID="btnNew" ClientIDMode="Static" Text="添加" onclick="btnNew_Click" CssClass="btn btn-primary"/>
                <asp:HiddenField ID="HiddenField1" runat="server" />
                <asp:HiddenField ID="HiddenField2" runat="server" />
            </div>
        </div>
        <br />
        <br />
    </div>
    
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
        ConnectionString="<%$ ConnectionStrings:DuihuaDB %>" 
        SelectCommand="SELECT [SemesterID], [SemesterName] FROM [Semester]"></asp:SqlDataSource>   
<div class="table-responsive">
<table class="table table-hover">
        <thead>
          <tr>
              <th>操作</th> 
            <%--  <th>学生数</th>--%>
              <th>作业量</th>
              <th>课程名称</th>
              <th>班级名称</th>
              <th>学年</th>
              <th>任课老师</th>
             <th>开课时间</th>
          </tr>
        </thead>
        <tbody>
  <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource1">
   
  <ItemTemplate>
  <tr class="active">  
        <td>
                <asp:LinkButton ID="LinkButton1"   runat="server" CssClass="fl btn5"  OnClick="lbOperator_Click"
                                     CausesValidation="False" CommandName="Edit" 
                                Text="编辑"  _Id='<%#Eval("CourseID") %>' />
                
                 <asp:LinkButton ID="LinkButton2"   runat="server" CssClass="fl btn5"   OnClick="lbOperator_Click"
                                     CausesValidation="False" CommandName="View" 
                                Text="查看"   _Id='<%#Eval("CourseID") %>' />

                 <asp:LinkButton ID="LinkButton3"   runat="server" CssClass="fl btn3" CausesValidation="False" CommandName="Delete"
                       OnClick="lbOperator_Click"   Text="删除" OnClientClick="return confirm('确认要删除吗？');" _Id='<%#Eval("CourseID") %>' />
             </td>
            <%-- <td><%#Eval("studentCount")%></td>--%>
            <td><a href='../Homework/HomeworkList.aspx?CourseID=<%#Eval("CourseID")%>&ReturnUrl=<%=Request.RawUrl%>'><%#Eval("homeworkCount")%></a></td>
             <td><%#Eval("CourseName")%></td>
            <td><%#Eval("GradeName")%></td>
            <td><%#Eval("SemesterName")%></td>
            <td><%#Eval("TeachName")%></td>
           <td><%#Eval("StartTime")%></td>
          
          </tr>
  </ItemTemplate>
  
        </asp:Repeater>
 </tbody>
      </table>
</div>
         共<asp:Label ID="lblCount" runat="server" Text="0"></asp:Label>条数据&nbsp;
    <webdiyer:AspNetPager id="AspNetPager1"  runat="server" Width="500px" FirstPageText="首页" 
    LastPageText="尾页" NextPageText="下一页" PrevPageText="上一页" Height="40px" 
    ShowInputBox="Always" TextAfterInputBox="页"  OnPageChanging="AspNetPager1_PageChanging" 
    PageSize="10" TextBeforeInputBox="跳转到第" AlwaysShow="True" CssClass="pagination"> 
    </webdiyer:AspNetPager> 


      <asp:HiddenField ID="hdbegin" runat="server" />
      <asp:HiddenField ID="hdend" runat="server" />
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:DuihuaDB %>" 
        DeleteCommand="DELETE FROM Course WHERE courseid = @CourseID" InsertCommand="
        DECLARE @courseID UNIQUEIDENTIFIER
        set @courseID = newid()
        INSERT INTO [dbo].[Course]
           ([ClassID]
           ,[CourseID]
           ,[CourseName]
           ,[StartTime]
           ,[EndTime]
           ,[Syllabus]
           ,[Cover]
           ,[CreateTime])
        VALUES
           (@ClassID
           ,@courseID
           ,@CourseName
           ,@StartTime
           ,@EndTime
           ,@Syllabus
           ,@Cover
           ,GETDATE())
           INSERT INTO TeachJoinCourse
            (
	            UserId,
	            CourseID
            )
            VALUES
            (
	            @TeacherId,
	            @courseID   
            )
            
            INSERT INTO JoinCourse
            (
	            UserId,
	            CourseID
            )
            SELECT jc.UserId
            ,@courseID
             FROM JoinClass jc
            WHERE jc.ClassID=@ClassID
            and NOT EXISTS(SELECT 1 FROM JoinCourse c WHERE c.UserId = jc.UserId AND c.CourseID = @courseID)
" SelectCommand="
SELECT * FROM (
SELECT
s.SemesterName
,cg.GradeName 
,c.CourseName
,t2.TeachName
,(SELECT COUNT(1) FROM JoinCourse j WHERE j.CourseID = c.CourseID) studentCount
,(SELECT COUNT(1) FROM HomeWork hw WHERE hw.CourseID = c.CourseID) homeworkCount
,CONVERT(NVARCHAR(19),c.StartTime,121) StartTime
,CONVERT(NVARCHAR(19),c.EndTime,121) EndTime
,c.CourseID
,ROW_NUMBER () OVER (ORDER BY c.StartTime DESC) pageindex
 FROM Course c LEFT JOIN TeachJoinCourse t ON c.CourseID = t.CourseID
LEFT JOIN Teacher t2 ON t2.UserId = t.UserId AND t2.TeachName LIKE '%'+@TeachName+'%'
LEFT JOIN ClassGrade cg ON c.classid = cg.ClassID AND cg.GradeName LIKE '%'+@GradeName+'%'
LEFT JOIN Semester s ON cg.SemesterID = s.SemesterID AND (@SemesterID ='00000000-0000-0000-0000-000000000000' or s.SemesterID = @SemesterID)
WHERE 1=1
AND c.CourseName LIKE '%'+@CourseName+'%'
and ( c.classid = @ClassID or  @ClassID='00000000-0000-0000-0000-000000000000')
) t
where pageIndex between @begin and @end
ORDER BY pageIndex asc
" UpdateCommand="UPDATE [dbo].[Course]
   SET [ClassID] = @ClassID
      ,[CourseName] = @CourseName
      ,[StartTime] = @StartTime
      ,[EndTime] = @EndTime
      ,[Syllabus] = @Syllabus
      ,[Cover] = @Cover
WHERE [CourseID] =@CourseID
delete from TeachJoinCourse where courseID= @courseID
 INSERT INTO TeachJoinCourse
            (
	            UserId,
	            CourseID
            )
            VALUES
            (
	            @TeacherId,
	            @courseID   
            )
            ">
        <DeleteParameters>
            <asp:Parameter Name="CourseID" />
        </DeleteParameters>
        <InsertParameters>
            <asp:ControlParameter ControlID="eClassID" Name="ClassID" />
            <asp:ControlParameter ControlID="eCourseName" Name="CourseName" />
            <asp:ControlParameter ControlID="eStartTime" Name="StartTime" />
            <asp:ControlParameter ControlID="eEndTime" Name="EndTime" />
            <asp:ControlParameter ControlID="eSyllabus" Name="Syllabus" />
            <asp:ControlParameter ControlID="tbCover" Name="Cover" />
            <asp:ControlParameter ControlID="eTeacherId" Name="TeacherId" />
        </InsertParameters>
        <UpdateParameters>
            <asp:ControlParameter ControlID="eClassID" Name="ClassID" />
            <asp:ControlParameter ControlID="eCourseName" Name="CourseName" />
            <asp:ControlParameter ControlID="eStartTime" Name="StartTime" />
            <asp:ControlParameter ControlID="eEndTime" Name="EndTime" />
            <asp:ControlParameter ControlID="eSyllabus" Name="Syllabus" />
            <asp:ControlParameter ControlID="tbCover" Name="Cover" />
            <asp:ControlParameter ControlID="eID" Name="CourseID" />
            <asp:ControlParameter ControlID="eTeacherId" Name="TeacherId" />
        </UpdateParameters>
        <SelectParameters>
             <asp:ControlParameter ControlID="hdend"  ConvertEmptyStringToNull="false" Name="end" />
             <asp:ControlParameter ControlID="hdbegin"  ConvertEmptyStringToNull="false" Name="begin" />
             <asp:ControlParameter ControlID="ddSemester"  ConvertEmptyStringToNull="false" Name="SemesterID" DefaultValue="00000000-0000-0000-0000-000000000000"  PropertyName="SelectedValue" DbType="Guid"/>
             <asp:ControlParameter ControlID="tbClassName"  ConvertEmptyStringToNull="false" Name="GradeName"/>
              <asp:ControlParameter ControlID="tbTeachName"  ConvertEmptyStringToNull="false" Name="TeachName" />
             <asp:ControlParameter ControlID="tbCourseName"  ConvertEmptyStringToNull="false" Name="CourseName" />
             <asp:QueryStringParameter QueryStringField="ClassID" Name="ClassID"  ConvertEmptyStringToNull="false" DefaultValue="00000000-0000-0000-0000-000000000000"/>
        </SelectParameters>
    </asp:SqlDataSource>

    <%if (string.IsNullOrEmpty(ClassID) == false)
      {%>
     <div class="panel-footer">
        <div class="col-sm-offset-10">
            <asp:Button ID="Button2"  runat="server" Text="返回" onclick="btnBackClassList_Click" CssClass="btn btn-default"/>
        </div>
    </div>
    <%} %>
</div>

<div runat="server" id="view" visible="false"  class="panel panel-success">
    <div class="panel-heading">
        <h3 class="panel-title">课程信息</h3>
    </div>
    
    <div class="panel-body">
        班级名称：<asp:Label    runat="server" name="GradeName"></asp:Label>
        <br />
        <br />
        学年：<asp:Label   runat="server" name="SemesterName"></asp:Label>
        <br />
        <br />
         课程名：<asp:Label  runat="server" name="CourseName"></asp:Label>
        <br />
        <br />
        报名人数：<span class="badge"><asp:Label runat="server" name="studentCount"></asp:Label></span>
        <br />
        <br />
        任课老师：<asp:Label runat="server" name="TeachName"></asp:Label>
        <br />
        <br />
        课程持续时间：
        <em>
        <asp:Label runat="server" name="StartTime"></asp:Label>~<asp:Label runat="server" name="EndTime"></asp:Label>
        </em>
        <br />
        <br />
        课程封面图片：
         <asp:TextBox ID="tbShowImg"  runat="server" name="Cover" style="display:none" ></asp:TextBox>
          <asp:Image ID="ImgShowImg" runat="server" Visible="false" CssClass="img-responsive img-thumbnail"/>  
        <br />
        <br />
        <blockquote>
        课程大纲：<div><br /><asp:Label  runat="server" name="Syllabus"></asp:Label></div>
        </blockquote>
        <br />
        <br />
    </div>
    <div class="panel-footer">
        <div class="col-sm-offset-10">
            <asp:Button ID="Button1"  runat="server" Text="返回" onclick="btnBackList_Click" CssClass="btn btn-default"/>
        </div>
    </div>
</div>

<div runat="server" id="detail" visible="false"  class="panel panel-success">
  <div class="panel-heading">
        <h3 class="panel-title">编辑课程信息</h3>
    </div>
    <div class="panel-body">
      <div class="form-group">
          <label for="eSemesterID">学年：</label>
          <asp:DropDownList ID="eSemesterID" name="SemesterID" ClientIDMode="Static" runat="server" CssClass="form-control"
           DataTextField="SemesterName" DataValueField="SemesterID"  AutoPostBack="true"   onselectedindexchanged="eSemesterID_SelectedIndexChanged">
          </asp:DropDownList>
      </div>
       <div class="form-group">
         <label for="eClassID">班级名称：</label>
           <asp:DropDownList ID="eClassID" name="ClassID" runat="server"  CssClass="form-control"
            DataTextField="GradeName" DataValueField="ClassID" 
             >
           </asp:DropDownList>
           <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:DuihuaDB %>" 
           SelectCommand="SELECT cg.ClassID,cg.GradeName FROM ClassGrade cg WHERE cg.SemesterID = @SemesterID OR @SemesterID='00000000-0000-0000-0000-000000000000' or cg.ClassID=@ClassID" >
                <SelectParameters>
                    <asp:ControlParameter  ControlID="eSemesterID" Name="SemesterID" DefaultValue="00000000-0000-0000-0000-000000000000" />
                    <asp:QueryStringParameter QueryStringField="ClassID" Name="ClassID" DefaultValue="00000000-0000-0000-0000-000000000000" />
                </SelectParameters>
           </asp:SqlDataSource>
      </div>
      <div  class="form-group">
          <label for="eTeacherId">班主任：</label>
          <asp:DropDownList ID="eTeacherId" name="TeacherId" ClientIDMode="Static" runat="server" CssClass="form-control"
          DataTextField="TeachName" DataValueField="UserId" DataSourceID="SqlDataSource3">
          </asp:DropDownList>
          <asp:SqlDataSource ID="SqlDataSource3" runat="server" SelectCommand="SELECT t.TeachName,t.UserId FROM Teacher t"
            ConnectionString="<%$ ConnectionStrings:DuihuaDB %>" ></asp:SqlDataSource>
      </div>
      <div class="form-group">
        <label for="eCourseName">课程名称：</label>
        <asp:TextBox ID="eCourseName" ClientIDMode="Static"  ValidationGroup="vs" runat="server" name="CourseName"  CssClass="form-control" placeholder="课程名称"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="eCourseName" runat="server" ErrorMessage="“课程名称”必填" Display="Dynamic" CssClass="help-block"></asp:RequiredFieldValidator>
      </div>
      <div class="form-group">
        <label for="eStartTime">课程时间：</label>
        <div>
            <div class="col-md-6  col-xs-6">
                <div class="input-group input-append date form_StartTime" data-date='<%=DateTime.Now %>'>
                     <asp:TextBox ID="eStartTime" ValidationGroup="vs" ClientIDMode="Static" name="StartTime" runat="server" CssClass="form-control"   size="16" ></asp:TextBox>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
		            <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ControlToValidate="eStartTime" runat="server" ErrorMessage="“课程时间”必填" Display="Dynamic" CssClass="help-block"></asp:RequiredFieldValidator>
                </div>
            </div>

            <div class="col-md-6  col-xs-6">
                <div class="input-group input-append date form_EndTime" data-date='<%=DateTime.Now %>' >
                     <asp:TextBox ID="eEndTime" ClientIDMode="Static" ValidationGroup="vs" name="EndTime" runat="server" CssClass="form-control"   size="16" ></asp:TextBox>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
		            <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ControlToValidate="eEndTime" runat="server" ErrorMessage="“课程时间”必填" Display="Dynamic" CssClass="help-block"></asp:RequiredFieldValidator>
                </div>
            </div>
 
        </div>
      </div>
      <div class="form-group">
        <label for="eCover">课程封面图片：</label>
           <div class="input-group">
                <asp:FileUpload ID="eCover" runat="server" ClientIDMode="Static" CssClass="form-control" placeholder="课程封面图片"/>
                <span class="input-group-btn">
                    <asp:Button ID="btnUpload" runat="server" Text="上传"  
                    CssClass="btn btn-success" onclick="btnUpload_Click"/>
                </span>
          </div>

          <asp:TextBox ID="tbCover" runat="server"  name="Cover" style="display:none" ></asp:TextBox>
          <asp:Image ID="ImgCover" runat="server" Visible="false" CssClass="img-responsive img-thumbnail"/>  
      </div>
      
      <div class="form-group">
        <label for="eSyllabus">课程大纲：</label>
        <asp:TextBox ID="eSyllabus" ClientIDMode="Static" runat="server" name="Syllabus"  CssClass="form-control" TextMode="MultiLine" placeholder="课程大纲" rows="10"></asp:TextBox>
         <asp:TextBox ID="eID" runat="server" name="CourseID" CssClass="hidden"></asp:TextBox>
      </div>
   </div>
   <div class="panel-footer">
      <div class="form-group col-sm-offset-10 col-sm-2">
         <asp:Button ID="btnSave" runat="server" Text="保存"  ValidationGroup="vs" OnClick="btnSave_Click" CssClass="btn btn-primary"/>
         <asp:Button ID="btnBack" runat="server" Text="返回"  OnClick="btnBackList_Click" CssClass="btn btn-default"/>
      </div>
      <br />
       <br />
   </div>
</div>
<script type="text/javascript">
    $(function () {
        $('.form_StartTime').datetimepicker({
            language: 'zh-CN',
            weekStart: 1,
            todayBtn: 1,
            autoclose: 1,
            todayHighlight: 1,
            startDate: '<%=DateTime.Now %>',
            format: 'yyyy-mm-dd'
        });
        $('.form_EndTime').datetimepicker({
            language: 'zh-CN',
            weekStart: 1,
            todayBtn: 1,
            autoclose: 1,
            todayHighlight: 1,
            startDate: '<%=DateTime.Now %>',
            format: 'yyyy-mm-dd'
        });
    });
   
</script>
</asp:Content>
