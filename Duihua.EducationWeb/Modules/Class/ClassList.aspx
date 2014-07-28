<%@ Page Title="" Language="C#" MasterPageFile="~/Layout/AdminDefault.Master" AutoEventWireup="true" CodeBehind="ClassList.aspx.cs" Inherits="Duihua.EducationWeb.Modules.Class.ClassList" %>
<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<div runat="server" id="list"  class="panel panel-success">
    <div  class="panel-heading">
        <h3 class="panel-title">班级信息管理</h3>
    </div>
    <div class="panel-body">
        <div class="form-group col-sm-offset-4 col-sm-2 col-xs-3">
            <label class="sr-only" for="tbClassName">班级名称</label>
            <asp:TextBox runat="server" ClientIDMode="Static"  ID="tbClassName" CssClass="form-control" placeholder="输入班级名称"></asp:TextBox>
        </div>
        <div class="form-group  col-sm-2  col-xs-5">
            <label class="sr-only" for="ddSemester">学期</label>
            <asp:DropDownList runat="server"  ClientIDMode="Static"  ID="ddSemester" DataTextField="SemesterName" DataValueField="SemesterID" DataSourceID="SqlDataSource2" CssClass="form-control" AppendDataBoundItems="true">
            <asp:ListItem Text="--请选择学期--" Value="00000000-0000-0000-0000-000000000000"></asp:ListItem>
            </asp:DropDownList>
        </div>
        <div class="form-group  col-sm-2  col-xs-2">
            <asp:Button runat="server" ID="btnSearch" ClientIDMode="Static" Text="搜索" onclick="btnSearch_Click" CssClass="btn btn-default"/>
        </div>
        <div class="form-group  col-sm-2   col-xs-2">
            <asp:Button runat="server" ID="Button1" ClientIDMode="Static" Text="添加" onclick="btnNew_Click" CssClass="btn btn-primary"/>
            <asp:HiddenField ID="HiddenField1" runat="server" />
            <asp:HiddenField ID="HiddenField2" runat="server" />
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
              <th>班级人数</th>
              <th>课程数</th>
              <th>班级名称</th>
              <th>学年</th>
              <th>班主任</th>
          </tr>
        </thead>
        <tbody>
  <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource1">
   
  <ItemTemplate>
  <tr class="active">  
        <td>
                <asp:LinkButton   runat="server" CssClass="fl btn5"  OnClick="lbOperator_Click"
                                     CausesValidation="False" CommandName="Edit" 
                                Text="编辑"  _Id='<%#Eval("ClassID") %>' />
                
                 <asp:LinkButton   runat="server" CssClass="fl btn5"   OnClick="lbOperator_Click"
                                     CausesValidation="False" CommandName="View" 
                                Text="查看"   _Id='<%#Eval("ClassID") %>' />

                 <asp:LinkButton   runat="server" CssClass="fl btn3" CausesValidation="False" CommandName="Delete"
                       OnClick="lbOperator_Click"   Text="删除" OnClientClick="return confirm('确认要删除吗？');" _Id='<%#Eval("ClassID") %>' />
             </td>
             <td><a href='JoinClassList.aspx?ClassID=<%#Eval("ClassID") %>&ReturnUrl=<%=Request.RawUrl %>'><%#Eval("studentCount")%></a></td>
             <td><a href="../Course/CourseList.aspx?ClassID=<%#Eval("ClassID") %>&ReturnUrl=<%=Request.RawUrl %>"><%#Eval("courseCount")%></a></td>
            <td><%#Eval("GradeName")%></td>
            <td><%#Eval("SemesterName")%></td>
            <td><%#Eval("TeachName")%></td>
          
          
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
        DeleteCommand="DELETE FROM ClassGrade WHERE ClassID = @ClassID" InsertCommand="INSERT INTO [dbo].[ClassGrade]
           ([ClassID]
           ,[TeacherId]
           ,[SemesterID]
           ,[GradeName]
           ,[Intro])
     VALUES
           (NEWID()
           ,@UserId
           ,@SemesterID
           ,@GradeName
           ,@Intro)
" SelectCommand="
SELECT tx.* FROM (
SELECT 
cg.*
,s.SemesterName
,t.TeachName
,(SELECT COUNT(1) FROM JoinClass jc WHERE jc.ClassID = cg.ClassID) studentCount
,(SELECT COUNT(1) FROM Course s WHERE s.ClassID = cg.ClassID) courseCount
,ROW_NUMBER()OVER(ORDER BY cg.createtime DESC) pageIndex
  FROM ClassGrade cg left JOIN Semester s ON s.SemesterID = cg.SemesterID
left JOIN Teacher t ON t.UserId = cg.TeacherId
WHERE 1=1
and (@SemesterID ='00000000-0000-0000-0000-000000000000' or cg.SemesterID = @SemesterID)
AND cg.GradeName LIKE '%'+@GradeName+'%'
) tx
where pageIndex between @begin and @end
ORDER BY pageIndex asc
" UpdateCommand="UPDATE  [dbo].[ClassGrade]
   SET [TeacherId] = @UserId
      ,[SemesterID] = @SemesterID
      ,[GradeName] = @GradeName
      ,[Intro] = @Intro
 WHERE  [ClassID] = @ClassID">
        <DeleteParameters>
            <asp:Parameter Name="ClassID" />
        </DeleteParameters>
        <InsertParameters>
            <asp:ControlParameter ControlID="ddTeacherId" Name="UserId" />
            <asp:ControlParameter ControlID="ddSemesterID" Name="SemesterID" />
            <asp:ControlParameter ControlID="tbGradeName" Name="GradeName" />
            <asp:ControlParameter ControlID="tbIntro" Name="Intro" />
        </InsertParameters>
        <UpdateParameters>
            <asp:ControlParameter ControlID="ddTeacherId" Name="UserId" />
            <asp:ControlParameter ControlID="ddSemesterID" Name="SemesterID" />
            <asp:ControlParameter ControlID="tbGradeName" Name="GradeName" />
            <asp:ControlParameter ControlID="tbIntro" Name="Intro" />
            <asp:ControlParameter ControlID="eID" Name="ClassID" />
        </UpdateParameters>
        <SelectParameters>
             <asp:ControlParameter ControlID="hdend"  ConvertEmptyStringToNull="false" Name="end" />
             <asp:ControlParameter ControlID="hdbegin"  ConvertEmptyStringToNull="false" Name="begin" />
             <asp:ControlParameter ControlID="ddSemester"  ConvertEmptyStringToNull="false" Name="SemesterID" DefaultValue="00000000-0000-0000-0000-000000000000"  PropertyName="SelectedValue" DbType="Guid"/>
             <asp:ControlParameter ControlID="tbClassName"  ConvertEmptyStringToNull="false" Name="GradeName"/>
        </SelectParameters>
    </asp:SqlDataSource>

</div>

<div runat="server" id="view" visible="false"  class="panel panel-success">
    <div class="panel-heading">
        <h3 class="panel-title">班级信息</h3>
    </div>
    
    <div class="panel-body">
        班级名称：<asp:Label  runat="server" name="GradeName"></asp:Label>
        <br />
        <br />
        学年：<asp:Label   runat="server" name="SemesterName"></asp:Label>
        <br />
        <br />
        班主任：<asp:Label  runat="server" name="TeachName"></asp:Label>
        <br />
        <br />
        班级说明：<div><br /><asp:Label   runat="server" name="Intro"></asp:Label></div>
        <br />
        <br />
    </div>
    <div class="panel-footer">
        <div class="col-sm-offset-10">
            <asp:Button  runat="server" Text="返回" onclick="btnBackList_Click" CssClass="btn btn-default"/>
        </div>
    </div>
</div>

<div runat="server" id="detail" visible="false"  class="panel panel-success">
  <div class="panel-heading">
        <h3 class="panel-title">编辑班级信息</h3>
    </div>
    <div class="panel-body">
      <div class="form-group">
         <label for="tbGradeName">班级名称：</label>
         <asp:TextBox ID="tbGradeName" ClientIDMode="Static" runat="server" name="GradeName" CssClass="form-control" placeholder="班级名称"></asp:TextBox>
          <asp:RequiredFieldValidator ControlToValidate="tbGradeName" runat="server" ErrorMessage="“班级名称”必填" Display="Dynamic" CssClass="help-block"></asp:RequiredFieldValidator>
      </div>
      <div class="form-group">
          <label for="ddSemesterID">学年：</label>
          <asp:DropDownList ID="ddSemesterID" name="SemesterID" ClientIDMode="Static" runat="server" CssClass="form-control"
           DataTextField="SemesterName" DataValueField="SemesterID" DataSourceID="SqlDataSource2">
          </asp:DropDownList>
      </div>
      <div  class="form-group">
          <label for="ddTeacherId">班主任：</label>
          <asp:DropDownList ID="ddTeacherId" name="TeacherId" ClientIDMode="Static" runat="server" CssClass="form-control"
          DataTextField="TeachName" DataValueField="UserId" DataSourceID="SqlDataSource3">
          </asp:DropDownList>
          <asp:SqlDataSource ID="SqlDataSource3" runat="server" SelectCommand="SELECT t.TeachName,t.UserId FROM Teacher t"
            ConnectionString="<%$ ConnectionStrings:DuihuaDB %>" ></asp:SqlDataSource>
      </div>
      <div class="form-group">
        <label for="tbIntro">班级说明：</label>
        <asp:TextBox ID="tbIntro" ClientIDMode="Static" runat="server" name="Intro"  CssClass="form-control" TextMode="MultiLine" placeholder="班级说明" rows="4"></asp:TextBox>
         <asp:TextBox ID="eID" runat="server" name="ClassID" CssClass="hidden"></asp:TextBox>
         
      </div>
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
</asp:Content>