<%@ Page Title="学年管理" Language="C#" MasterPageFile="~/Layout/AdminDefault.Master" AutoEventWireup="true" CodeBehind="SemesterList.aspx.cs" Inherits="Duihua.EducationWeb.Modules.Semester.SemesterList" %>
<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <script type="text/javascript" src="../../Scripts/bootstrap-datetimepicker.min.js"></script>
    <link href="../../Styles/bootstrap-datetimepicker.min.css" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<div runat="server" id="list"  class="panel panel-success">
    <div  class="panel-heading">
        <h3 class="panel-title">学年管理</h3>
    </div>
    <div class="panel-body">
        <asp:Button ID="btnCreate" runat="server" Text="新建学年" CssClass="btn btn-default"/>
    </div>
    <div class="table-responsive">
        <table class="table table-hover">
        <thead>
          <tr>
              <th>操作</th>
              <th>学年名称</th>
              <th>学年简介</th>
              <th>学年开始时间</th>
              <th>学年结束时间</th>
              <th>状态</th>
          </tr>
        </thead>
        <tbody>
          <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource1">
            <ItemTemplate>
                <tr class='<%#GetStatus(Eval("IsFinish")) %>'>  
                    <td>
                         <asp:LinkButton ID="lbFinish"  OnClick="lbOperator_Click" runat="server"  _Id='<%#Eval("SemesterID") %>' OnClientClick="return confirm('确认要要结束该学年吗？结束后，该学年全部学生即毕业，不能再使用该系统');" Text="结束学年"/>
                         <asp:LinkButton ID="lbDelete"  OnClick="lbOperator_Click" runat="server"  _Id='<%#Eval("SemesterID") %>' OnClientClick="return confirm('确认要删除吗？');" Text="删除"/>
                         <asp:LinkButton ID="lbEdit"    OnClick="lbOperator_Click" runat="server"  _Id='<%#Eval("SemesterID") %>' Text="修改" />
                         <asp:LinkButton ID="lbView"    OnClick="lbOperator_Click" runat="server"  _Id='<%#Eval("SemesterID") %>' Text="查看" />
                    </td>
                    <td><%#Eval("SemesterName")%></td>
                    <td><%#Eval("Intro")%></td>
                    <td><%#Eval("StartTime")%></td>
                    <td><%#Eval("EndTime")%></td>
                    <td><%#Eval("IsFinish")%></td>
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
         SelectCommand="SELECT [SemesterID]
      ,[SemesterName]
      ,[Intro]
      ,[StartTime]
      ,[EndTime]
      ,[createtime]
      ,CASE WHEN ISNULL([IsFinish],0)=0 THEN '未结束'
      ELSE '已结束'end [IsFinish]
      ,ROW_NUMBER() OVER (ORDER BY createtime DESC) pageindex
  FROM  [dbo].[Semester]"
  InsertCommand="INSERT INTO [dbo].[Semester]
           ([SemesterID]
           ,[SemesterName]
           ,[Intro]
           ,[StartTime]
           ,[EndTime]
           ,[createtime]
           ,[IsFinish])
     VALUES
           (@SemesterID
           ,@SemesterName
           ,@Intro
           ,@StartTime
           ,@EndTime
           ,GETDATE()
           ,0)"
     UpdateCommand="UPDATE [dbo].[Semester]
   SET 
      [SemesterName] = @SemesterName
      ,[Intro] = @Intro
      ,[StartTime] = @StartTime
      ,[EndTime] = @EndTime
 WHERE [SemesterID] = @SemesterID"
  DeleteCommand="DELETE FROM Semester WHERE SemesterID = @SemesterID">
<SelectParameters>
     <asp:ControlParameter ControlID="hdend"  ConvertEmptyStringToNull="false" Name="end" />
     <asp:ControlParameter ControlID="hdbegin"  ConvertEmptyStringToNull="false" Name="begin" />
</SelectParameters>
<InsertParameters>
    <asp:ControlParameter Name="SemesterID" ControlID="SemesterID" />
    <asp:ControlParameter Name="SemesterName" ControlID="eSemesterName" />
    <asp:ControlParameter Name="Intro" ControlID="eIntro" />
    <asp:ControlParameter Name="StartTime" ControlID="eStartTime" />
    <asp:ControlParameter Name="EndTime" ControlID="eEndTime" />
</InsertParameters>
<UpdateParameters>
     <asp:ControlParameter Name="SemesterID" ControlID="SemesterID" />
    <asp:ControlParameter Name="SemesterName" ControlID="eSemesterName" />
    <asp:ControlParameter Name="Intro" ControlID="eIntro" />
    <asp:ControlParameter Name="StartTime" ControlID="eStartTime" />
    <asp:ControlParameter Name="EndTime" ControlID="eEndTime" />
</UpdateParameters>
<DeleteParameters>
    <asp:Parameter Name="SemesterID" />
</DeleteParameters>
</asp:SqlDataSource>

</div>

<div runat="server" id="view" visible="false"  class="panel panel-success">
    <div class="panel-heading">
        <h3 class="panel-title">学年信息</h3>
    </div>
    
    <div class="panel-body">
     
        学年名称：<asp:Label ID="SemesterName"   runat="server" name="SemesterName"></asp:Label>
        <br />
        <br />
         学年开始时间：<asp:Label ID="StartTime"   runat="server" name="StartTime"></asp:Label>
          <br />
        <br />
        学年结束时间：<asp:Label ID="EndTime"   runat="server" name="EndTime"></asp:Label>
         <br />
        <br />
        是否结束：<asp:Label ID="IsFinish"   runat="server" name="IsFinish"></asp:Label>
           <br />
        <br />
        学年简介：
        <blockquote>
        <asp:Label ID="Intro"   runat="server" name="Intro"></asp:Label>
        </blockquote>
        <br />
        <br />
    </div>
    <div class="panel-footer">
        <div class="col-sm-offset-10">
            <asp:Button ID="Button1"   runat="server" Text="返回" onclick="btnBackList_Click" CssClass="btn btn-default"/>
        </div>
    </div>
</div>



<div runat="server" id="detail" visible="false"  class="panel panel-success">
  <div class="panel-heading">
        <h3 class="panel-title">编辑学年信息</h3>
    </div>
    <div class="panel-body">
      <div class="form-group">
         <label for="eSemesterName">学年名称：</label>
         <asp:TextBox ID="eSemesterName" ClientIDMode="Static" runat="server" name="SemesterName" CssClass="form-control" placeholder="学年名称"></asp:TextBox>
          <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ValidationGroup="vd" ControlToValidate="eSemesterName" runat="server" ErrorMessage="“学年名称”必填" Display="Dynamic" CssClass="help-block"></asp:RequiredFieldValidator>
      </div>
      <div class="form-group">
          <label for="eStartTime">学年时间：</label>
         <div>
            <div class="col-md-6  col-xs-6">
                <div class="input-group input-append date form_StartTime" data-date='<%=DateTime.Now %>'>
                     <asp:TextBox ID="eStartTime" ValidationGroup="vs" ClientIDMode="Static" name="StartTime" runat="server" CssClass="form-control"   size="16" ></asp:TextBox>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
		            <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ControlToValidate="eStartTime" runat="server" ErrorMessage="“学年开始时间”必填" Display="Dynamic" CssClass="help-block"></asp:RequiredFieldValidator>
                </div>
            </div>

            <div class="col-md-6  col-xs-6">
                <div class="input-group input-append date form_EndTime" data-date='<%=DateTime.Now %>' >
                     <asp:TextBox ID="eEndTime" ClientIDMode="Static" ValidationGroup="vs" name="EndTime" runat="server" CssClass="form-control"   size="16" ></asp:TextBox>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
		            <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ControlToValidate="eEndTime" runat="server" ErrorMessage="“学年结束时间”必填" Display="Dynamic" CssClass="help-block"></asp:RequiredFieldValidator>
                </div>
            </div>
        </div>
      </div>
      
      <div class="form-group">
        <label for="eIntro">学年简介：</label>
        <asp:TextBox ID="eIntro" ClientIDMode="Static" runat="server" name="Intro"  CssClass="form-control" TextMode="MultiLine" placeholder="学年简介" rows="4"></asp:TextBox>
         <asp:TextBox ID="SemesterID" runat="server" name="SemesterID" CssClass="hidden"></asp:TextBox>
         
      </div>
   </div>
   <div class="panel-footer">
      <div class="form-group col-sm-offset-10 col-sm-2">
         <asp:Button ID="btnSave" runat="server" Text="保存" ValidationGroup="vd"  OnClick="btnSave_Click" CssClass="btn btn-primary"/>
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
