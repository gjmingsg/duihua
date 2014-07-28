<%@ Page Title="" Language="C#" MasterPageFile="~/Layout/AdminDefault.Master" AutoEventWireup="true" CodeBehind="HomeworkList.aspx.cs" Inherits="Duihua.EducationWeb.Modules.Homework.HomeworkList" %>
<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>
<%@ Register Src="~/Modules/Common/UCAttachment.ascx" TagName="Attachment" TagPrefix="UC" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
 <script type="text/javascript" src="../../Scripts/bootstrap-datetimepicker.min.js"></script>
    <link href="../../Styles/bootstrap-datetimepicker.min.css" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<div runat="server" id="list"  class="panel panel-success">
    <div  class="panel-heading">
        <h3 class="panel-title">作业管理</h3>
    </div>
    <div class="panel-body">
      
        <div class="form-group  col-sm-offset-2  col-sm-2  col-xs-3">
            <label class="sr-only" for="tbGradeName">班级名称</label>
             <asp:TextBox runat="server" ClientIDMode="Static"  ID="tbGradeName" CssClass="form-control" placeholder="输入班级名称"></asp:TextBox>
        </div>
         <div class="form-group  col-sm-2  col-xs-3">
            <label class="sr-only" for="tbCourseName">课程名称</label>
             <asp:TextBox runat="server" ClientIDMode="Static"  ID="tbCourseName" CssClass="form-control" placeholder="输入课程名称"></asp:TextBox>
        </div>
        <div class="form-group col-sm-2 col-xs-3">
            <label class="sr-only" for="tbTitle">作业名称</label>
            <asp:TextBox runat="server" ClientIDMode="Static"  ID="tbTitle" CssClass="form-control" placeholder="输入作业名称"></asp:TextBox>
        </div>
        <div class="form-group  col-sm-2  col-xs-3">
            <asp:Button runat="server" ID="btnSearch" ClientIDMode="Static" Text="搜索" onclick="btnSearch_Click" CssClass="btn btn-default"/>
        </div>
        <div class="form-group  col-sm-2   col-xs-3">
            <asp:Button runat="server" ID="btnNew" ClientIDMode="Static" Text="添加" onclick="btnNew_Click" CssClass="btn btn-primary"/>
            <asp:HiddenField ID="HiddenField1" runat="server" />
            <asp:HiddenField ID="HiddenField2" runat="server" />
        </div>
        <br />
        <br />
    </div>
    <div class="table-responsive">
<table class="table table-hover">
        <thead>
          <tr>
              <th>操作</th> 
              <th>作业提交情况</th>
              <th>课程名称</th>
              <th>作业名称</th>
              <th>截止提交时间</th>
              <th>分值</th>
              <th>状态</th>
          </tr>
        </thead>
        <tbody>
  <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource1">
   
  <ItemTemplate>

  <tr class='<%#GetStatus(Eval("homeworkstatus")) %>'>  
        <td>
                <asp:LinkButton    runat="server" CssClass="fl btn5"  OnClick="lbOperator_Click"
                                     CausesValidation="False" CommandName="Edit" 
                                Text="编辑"  _Id='<%#Eval("WorkID") %>' />
                
                 <asp:LinkButton    runat="server" CssClass="fl btn5"   OnClick="lbOperator_Click"
                                     CausesValidation="False" CommandName="View" 
                                Text="查看"   _Id='<%#Eval("WorkID") %>' />

                 <asp:LinkButton   runat="server" CssClass="fl btn3" CausesValidation="False" CommandName="Delete"
                       OnClick="lbOperator_Click"   Text="删除" OnClientClick="return confirm('确认要删除吗？');" _Id='<%#Eval("WorkID") %>' />
             </td>
             <td><a href='HomeworkResult.aspx?WorkID=<%#Eval("WorkID") %>&ReturnUrl=<%=Request.RawUrl %>'>
             <span class="label label-info"><%#Eval("hasSubmitHomeworkCount")%> </span>/ 
             <span class="label label-success"><%#Eval("allNeedSumbitCount")%></span></a></td>
             <td><%#Eval("CourseName")%></td>
            <td><%#Eval("Title")%></td>
            <td><%#Eval("DeadLine")%></td>
            <td><%#Eval("Score")%></td>
            <td><%#Eval("homeworkstatus")%></td>
          
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
        DeleteCommand="DELETE FROM HomeWork WHERE WorkID = @WorkID" InsertCommand="
INSERT INTO HomeWork
(
	WorkID,
	CourseID,
	Title,
	[Content],
	DeadLine,
	Score,
    BeginTime,
	createtime
)
VALUES
(
	@WrokID,
	@CourseID,
	@Title,
	@Content,
	@DeadLine,
	@Score,
    @BeginTime,
	GETDATE()
)
" SelectCommand="
SELECT tx.* FROM (
SELECT hw.*
,c.CourseName
,(SELECT COUNT(1) FROM WorkResult wr INNER JOIN Student s ON s.UserId = wr.UserId WHERE wr.WorkID=hw.WorkID) hasSubmitHomeworkCount
,(SELECT COUNT(1) FROM JoinCourse jc WHERE jc.CourseID = hw.CourseID) allNeedSumbitCount
,ROW_NUMBER() OVER (ORDER BY c.CreateTime DESC) pageindex
,CASE WHEN Convert(varchar(50),hw.beginTime,121) >  Convert(varchar(50),GETDATE(),121) THEN
	'未开始'
	WHEN   Convert(varchar(50),hw.beginTime,121) <=  Convert(varchar(50),GETDATE(),121) AND Convert(varchar(50),GETDATE(),121)<=  Convert(varchar(50),hw.DeadLine,121) THEN
	'进行中'
	WHEN Convert(varchar(50),GETDATE(),121)> Convert(varchar(50),hw.DeadLine,121) THEN
	'已结束'
	ELSE
		'未知'
	END homeworkstatus		
 FROM HomeWork hw INNER JOIN Course c ON c.CourseID = hw.CourseID
 INNER JOIN ClassGrade cg ON cg.ClassID = c.ClassID
WHERE cg.GradeName LIKE '%'+@GradeName+'%'  
AND c.CourseName LIKE '%'+@CourseName+'%' 
and (c.CourseID = @CourseID or @CourseID = '00000000-0000-0000-0000-000000000000')
AND hw.Title LIKE '%'+@Title+'%') tx where pageIndex between @begin and @end ORDER BY pageIndex asc" 
 
UpdateCommand="UPDATE HomeWork
SET
	CourseID = @CourseID,
	Title = @Title,
	[Content] = @Content,
	DeadLine = @DeadLine,
    BeginTime = @BeginTime,
	Score = @Score
WHERE WorkID  = @WrokID">
        <DeleteParameters>
            <asp:Parameter Name="WorkID" />
        </DeleteParameters>
        <InsertParameters>
            <asp:ControlParameter ControlID="eCourseID" Name="CourseID" />
            <asp:ControlParameter ControlID="eTitle" Name="Title" />
            <asp:ControlParameter ControlID="eContent" Name="Content" />
            <asp:ControlParameter ControlID="eDeadLine" Name="DeadLine" />
            <asp:ControlParameter ControlID="eScore" Name="Score" />
            <asp:ControlParameter ControlID="eBeginTime" Name="BeginTime" />
            <asp:ControlParameter ControlID="eID" Name="WrokID" />
        </InsertParameters>
        <UpdateParameters>
            <asp:ControlParameter ControlID="eCourseID" Name="CourseID" />
            <asp:ControlParameter ControlID="eTitle" Name="Title" />
            <asp:ControlParameter ControlID="eContent" Name="Content" />
            <asp:ControlParameter ControlID="eDeadLine" Name="DeadLine" />
            <asp:ControlParameter ControlID="eScore" Name="Score" />
             <asp:ControlParameter ControlID="eBeginTime" Name="BeginTime" />
            <asp:ControlParameter ControlID="eID" Name="WrokID" />
        </UpdateParameters>
        <SelectParameters>
             <asp:ControlParameter ControlID="hdend"  ConvertEmptyStringToNull="false" Name="end" />
             <asp:ControlParameter ControlID="hdbegin"  ConvertEmptyStringToNull="false" Name="begin" />
             <asp:ControlParameter ControlID="tbGradeName"  ConvertEmptyStringToNull="false" Name="GradeName"/>
             <asp:ControlParameter ControlID="tbCourseName"  ConvertEmptyStringToNull="false" Name="CourseName"/>
             <asp:ControlParameter ControlID="tbTitle"  ConvertEmptyStringToNull="false" Name="Title"/>
                 <asp:QueryStringParameter QueryStringField="CourseID" Name="CourseID" ConvertEmptyStringToNull="true" DefaultValue="00000000-0000-0000-0000-000000000000" />
        </SelectParameters>
    </asp:SqlDataSource>

    <%if (string.IsNullOrEmpty(Request.QueryString["CourseID"]) == false)
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
        <h3 class="panel-title">作业信息</h3>
      
    </div>
    
    <div class="panel-body">
        课程名称：<asp:Label runat="server" name="GradeName"></asp:Label>
        <asp:TextBox ID="tbWorkID" runat="server" name="WorkID" CssClass="hidden"></asp:TextBox>
        <br />
        <br />
        作业名称：<asp:Label runat="server" name="Title"></asp:Label>
        <br />
        <br />
        作业分值：<asp:Label runat="server" name="Score"></asp:Label>
        <br />
        <br />
        提交时间：<asp:Label  runat="server" name="BeginTime"></asp:Label>
        <br />
        <br />
        截止时间：<asp:Label runat="server" name="DeadLine"></asp:Label>
        <br />
        <br />
        作业详细说明：
        <div><br /><asp:Label  runat="server" name="Content"></asp:Label></div>
        <br />
        <br />
        附件：
        <UC:Attachment runat="server" EditMode='false' ID="Attachment" ></UC:Attachment>
    </div>
    <div class="panel-footer">
        <div class="col-sm-offset-10">
            <asp:Button ID="Button1"  runat="server" Text="返回" onclick="btnBackList_Click" CssClass="btn btn-default"/>
        </div>
    </div>
</div>

<div runat="server" id="detail" visible="false"  class="panel panel-success">
  <div class="panel-heading">
        <h3 class="panel-title">编辑作业信息</h3>
    </div>
    <div class="panel-body">
           
      <div class="form-group">
         <label for="eCourseID">课程名称：</label>
          <asp:TextBox ID="eID" runat="server" name="WorkID" CssClass="hidden"></asp:TextBox>
          <asp:DropDownList ID="eCourseID" name="CourseID"  ClientIDMode="Static" runat="server" DataSourceID="SqlDataSource2"  CssClass="form-control"
            DataTextField="CourseName" DataValueField="CourseID" >
            <%--<asp:ListItem Value="00000000-0000-0000-0000-000000000000" Text="--请选择作业所属课程--"></asp:ListItem>--%>
          </asp:DropDownList>
          <asp:SqlDataSource  ConnectionString="<%$ ConnectionStrings:DuihuaDB %>"  ID="SqlDataSource2" runat="server" 
          SelectCommand="SELECT c.CourseID,c.CourseName FROM Course c WHERE c.CourseID = @CourseID or @CourseID='00000000-0000-0000-0000-000000000000'">
              <SelectParameters>
                    <asp:QueryStringParameter QueryStringField="CourseID" Name="CourseID" ConvertEmptyStringToNull="true" DefaultValue="00000000-0000-0000-0000-000000000000" />
              </SelectParameters>
          </asp:SqlDataSource>
        <%--  <asp:RequiredFieldValidator  ControlToValidate="eCourseID" runat="server" ErrorMessage="“课程名称”必选" ValidationGroup="vsError"></asp:RequiredFieldValidator>--%>
      </div>
      <div class="form-group">
          <label for="eTitle">作业名称：</label>
          <asp:TextBox ID="eTitle" ClientIDMode="Static" runat="server" name="Title"  CssClass="form-control"  placeholder="作业名称"></asp:TextBox>
          <asp:RequiredFieldValidator ControlToValidate="eTitle"  runat="server" ErrorMessage="“作业名称”必填"   CssClass="help-block"  Display="Dynamic"></asp:RequiredFieldValidator>
      </div>
    
      <div class="form-group">
        <label for="eBeginTime">提交时间：</label>
        <div class="input-group date form_eBeginTime">
            <asp:TextBox ID="eBeginTime" ClientIDMode="Static" runat="server" name="BeginTime"   CssClass="form-control"></asp:TextBox>
            <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
            <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="eBeginTime" runat="server"    ErrorMessage="“提交时间”必填"  CssClass="help-block" Display="Dynamic"></asp:RequiredFieldValidator>
        </div>
       </div>
       <div class="form-group">
        <label for="eDeadLine">截止时间：</label>
         <div class="input-group date form_eDeadLine">
            <asp:TextBox ID="eDeadLine" ClientIDMode="Static" runat="server" name="DeadLine"  CssClass="form-control"></asp:TextBox>
            <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
            <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ControlToValidate="eDeadLine" runat="server"  ErrorMessage="“截止时间”必填"  CssClass="help-block" Display="Dynamic"></asp:RequiredFieldValidator>
         </div>
       </div>
      
       <div class="form-group">
        <label for="eScore">分值：</label>
        <asp:TextBox ID="eScore" ClientIDMode="Static" Text="100" runat="server" name="Score"  CssClass="form-control"></asp:TextBox>
           <asp:RequiredFieldValidator  runat="server" ErrorMessage="“分值”必填"  ControlToValidate="eScore"      CssClass="help-block"></asp:RequiredFieldValidator>
           <asp:RegularExpressionValidator runat="server" ErrorMessage="“分值”必为数字" ControlToValidate="eScore"    ValidationExpression="^[1-9][0-9]*$" CssClass="help-block"  Display="Dynamic"></asp:RegularExpressionValidator>
      </div>
      <div class="form-group">
        <label for="eContent">作业详细说明：</label>
        <asp:TextBox ID="eContent" ClientIDMode="Static" runat="server" name="Content"  CssClass="form-control" TextMode="MultiLine" placeholder="作业详细说明" rows="10"></asp:TextBox>   
      </div>
     
      <UC:Attachment runat="server" EditMode='true' ID="Attachment1" ClientIDMode="Static"></UC:Attachment>
     
   </div>
   <div class="panel-footer">
      <div class="form-group col-sm-offset-10 col-sm-2">
         <asp:Button ID="btnSave" runat="server" Text="保存"  OnClick="btnSave_Click" CssClass="btn btn-primary"/>
         <asp:Button ID="btnBack" runat="server" Text="返回"  OnClick="btnBackList_Click" CssClass="btn btn-default"/>
          
      </div>
      <br />
       <br />
   </div>
</div>
    <asp:HiddenField ID="hdMode" runat="server" />

<script type="text/javascript">
    $(".form_eBeginTime").datetimepicker({
        language: 'zh-CN',
        weekStart: 1,
        todayBtn: 1,
        autoclose: 1,
        todayHighlight: 1,
        startDate:'<%=DateTime.Now %>',
        format: "yyyy-mm-dd hh:ii"
    });
    $(".form_eDeadLine").datetimepicker({
        language: 'zh-CN',
        weekStart: 1,
        todayBtn: 1,
        autoclose: 1,
        todayHighlight: 1,
        startDate:'<%=DateTime.Now %>',
        format: "yyyy-mm-dd hh:ii"
    });
    
</script> 
</asp:Content>
