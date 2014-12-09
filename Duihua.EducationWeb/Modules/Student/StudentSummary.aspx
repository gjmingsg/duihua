<%@ Page Title="" Language="C#" MasterPageFile="~/Layout/AdminDefault.Master" AutoEventWireup="true" CodeBehind="StudentSummary.aspx.cs" Inherits="Duihua.EducationWeb.Modules.Student.StudentSummary" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
<script src="../../Scripts/Chart.min.js" type="text/javascript"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource1">
        <ItemTemplate>
            <h1 class="page-header"><%#Eval("CourseName")%></h1>
            <p class="lead"><%#Eval("Syllabus")%></p>
            <h3 class="overview-doctype">
                课程进度（以作业分数进行评价）
            </h3>
            <p>
                <canvas id='<%#Eval("CourseID") %>' width="600" height="400"></canvas>
                <script type="text/javascript">
                    var data<%#Eval("indexId") %>  = <%#GetScoreBarData(Eval("CourseID")) %>;
		            var ctx<%#Eval("indexId") %> = document.getElementById('<%#Eval("CourseID") %>').getContext("2d");
                    new Chart(ctx<%#Eval("indexId") %>).Bar(data<%#Eval("indexId") %>);
                </script>
            </p>
        </ItemTemplate>
    </asp:Repeater>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DuihuaDB %>"
    SelectCommand="SELECT c.CourseID,c.CourseName,c.Syllabus, ROW_NUMBER()OVER(ORDER BY c.starttime DESC) indexId
              FROM Course c INNER JOIN JoinCourse jc ON jc.CourseID = c.CourseID
            WHERE jc.UserId = @UserId">
        <SelectParameters>
            <asp:SessionParameter ConvertEmptyStringToNull="true" Name="UserId" SessionField="UserId"/>
        </SelectParameters>
    </asp:SqlDataSource>
    <%=UserId%>
</asp:Content>
