<%@ Page Title="本周作业" Language="C#" MasterPageFile="~/Layout/AdminDefault.Master" AutoEventWireup="true" CodeBehind="WeeklyHomework.aspx.cs" Inherits="Duihua.EducationWeb.Modules.Homework.WeeklyHomework" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<div class="row">
        <div class="col-sm-3 col-md-2 sidebar">
        <%foreach (var item in MyCourse)
          { %>
          <ul class="nav nav-sidebar">
            <li><a href="HomeworkResult.aspx?CourseID=<%=item["CourseID"] %>"><%=item["CourseName"].ToString()%></a></li>
          </ul>
         <%} %>
        </div>
        <div class="col-sm-9 col-md-10  main">
          <h1 class="page-header">本周作业</h1>
           <asp:Label runat="server" ID="lbEmptyText" Visible="false">
           <div  class="alert alert-success" role="alert">本周没有安排作业</div>
           </asp:Label>
            <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource1">
                <ItemTemplate>
                <div class="col-sm-6 col-md-6">
                <div class="thumbnail">
                     <h3><%#Eval("Title")%></h3>
                     <dl class="dl-horizontal">
        
                       <dt><label>作业分数：</label></dt>
                       <dd><span class="label label-default"><%#Eval("Score")%></span></dd> 
    
                        <dt><label>开始提交时间：</label></dt>
                        <dd><span class="label label-info"><%#Eval("BeginTime")%></span></dd>
    
                        <dt><label>提交结束时间：</label></dt>
                        <dd><span class="label label-danger"><%#Eval("DeadLine")%></span></dd>
    
                    </dl>
                     <blockquote>
                        <label>作业要求：</label>
                        <p><%#Eval("Content")%></p>
                    </blockquote>
                     <div>
                          <asp:Button ID="btnSubmitWork" _WorkID='<%#Eval("WorkID") %>' _CourseID='<%#Eval("CourseID") %>' runat="server" Text="去做作业" OnClick="btnSubmitWork_Click"   CssClass="btn btn-primary"/>   
                     </div>
                 </div>
                 </div>
                </ItemTemplate>
            </asp:Repeater>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server"
            SelectCommand="SELECT c.CourseID
                            ,c.CourseName
                            ,hw.WorkID
                            ,hw.Title
                            ,hw.Score
                            ,hw.DeadLine
                            ,hw.BeginTime 
                            ,hw.[Content] FROM HomeWork hw
                            INNER JOIN Course c ON c.CourseID = hw.CourseID
                            WHERE hw.CourseID = @CourseID
                            AND GETDATE() <= hw.DeadLine
                            AND GETDATE() >= hw.BeginTime"
                        ConnectionString="<%$ ConnectionStrings:DuihuaDB %>">
        <SelectParameters>
            <asp:QueryStringParameter  QueryStringField="CourseID" Name="CourseID" DefaultValue="00000000-0000-0000-0000-000000000000"/>  
        </SelectParameters>
    </asp:SqlDataSource>
        </div>
      </div>
</asp:Content>
