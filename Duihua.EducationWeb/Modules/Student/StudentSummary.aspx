<%@ Page Title="" Language="C#" MasterPageFile="~/Layout/AdminDefault.Master" AutoEventWireup="true" CodeBehind="StudentSummary.aspx.cs" Inherits="Duihua.EducationWeb.Modules.Student.StudentSummary" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
<script src="../../Scripts/Chart.min.js" type="text/javascript"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row">
        <div class="col-md-9" role="main">
        
            <div id="overall">
                <h1 class="page-header">学业总体情况</h1>
                <p class="lead">所修班级：<asp:Literal runat="server" ID="lClassName"></asp:Literal></p>
                <p class="lead">所修课程：<asp:Literal runat="server" ID="loverallCourse"></asp:Literal></p>
                <h3 class="overview-doctype">各课程作业情况</h3>
                <p>
                     <canvas id='overall_canvas'width="600" height="300"></canvas>
                     <script type="text/javascript">
                         var overall_data =[ <% =GetOverallScore()%>];
                         window.onload = function(){
				            var ctx =  document.getElementById('overall_canvas').getContext("2d");
				            window.myDoughnut = new Chart(ctx).Doughnut(overall_data, {responsive : true});
			             };

                     </script>
                </p>
                <h3 class="overview-doctype">总体班级排名(从左到右，成绩由低到高)</h3>
                <p>
                     <canvas id='score_order_canvas' width="600" height="400"></canvas>
                     <script type="text/javascript">
                         var score_order_data = <% =GetAvgScoreOrder()%>;
                         var ctx_score_order = document.getElementById('score_order_canvas').getContext("2d");
                         new Chart(ctx_score_order).Line(score_order_data);
                     </script>
                </p>
            </div>

            <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource1">
                <ItemTemplate>
                    <div id="hot_<%#Eval("CourseID") %>">
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
                    </div>
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
        </div>
        <div class="col-md-3">
            <div role="complementary" class="affix">
                <ul class="nav bs-docs-sidenav">
                    <li><a href="#overall">学业总体情况</a></li>
                    <asp:Repeater ID="Repeater2" runat="server" DataSourceID="SqlDataSource1">
                        <ItemTemplate>
                            <li><a href="#hot_<%#Eval("CourseID") %>">【课程】<%#Eval("CourseName")%></a></li>
                        </ItemTemplate>
                    </asp:Repeater>
                </ul>
            </div>
        </div>
    </div>
</asp:Content>
