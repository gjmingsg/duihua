<%@ Page Title="考核后课程得分排名" Language="C#" MasterPageFile="~/Layout/AdminDefault.Master" AutoEventWireup="true" CodeBehind="KPIRange.aspx.cs" Inherits="Duihua.EducationWeb.Modules.KPI.KPIRange" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <script src="../../Scripts/Chart.min.js" type="text/javascript"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<div class="panel panel-default">
  <div class="panel-heading">考核后课程得分排名</div>
  <div class="panel-body">

       <div class="form-group pull-right">
            <label class="col-sm-4 control-label" for="SemesterID">考核年度</label>
            <div class="col-sm-8">
                <asp:DropDownList CssClass="form-control" ID="SemesterID" runat="server" ClientIDMode="Static" DataSourceID="SqlDataSource1" DataTextField="SemesterName" DataValueField="SemesterID" AutoPostBack="true">
                </asp:DropDownList>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server"   ConnectionString="<%$ ConnectionStrings:DuihuaDB %>" 
                 SelectCommand="SELECT s.SemesterID, s.SemesterName FROM Semester s"
                ></asp:SqlDataSource>
            </div>
        </div>

      
        <div class="col-xs-12 col-sm-12">

             <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource2">
                <ItemTemplate>
                    <div class="col-xs-4 col-sm-4">
                        <div  class="col-xs-6 col-sm-6">
                            <img class="img-responsive" alt='第<%#Eval("pageindex") %>名' src='../../Images/cup_<%#Eval("pageindex") %>.png' />
                        </div>
                        <div class="col-xs-6 col-sm-6 pull-right">
                            <h3><span class="label label-success">第<%#Eval("pageindex") %>名</span></h3>
                            <%#Eval("CourseName")%>
                            <a href="../Account/PersonalSetting.aspx?UserId=<%#Eval("UserId") %>">【<%#Eval("TeachName")%>】</a>
                            <br />
                            就读该课程的人数：<span class="label  label-danger"><%#Eval("stucount")%></span>
                        </div>
                    </div>
                </ItemTemplate>
              </asp:Repeater>
        </div>
        <div class="col-xs-12 col-sm-12">
			<canvas id="canvas" height="450" width="1200"></canvas>
		</div>
  </div>

   <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:DuihuaDB %>"
    SelectCommand="SELECT TOP 3
x.CourseID 
,x.CourseName
,x.sumscore
,(SELECT COUNT(1) FROM JoinCourse jc WHERE jc.CourseID = x.CourseID) stucount
,t.*
,ROW_NUMBER() OVER (order by x.sumscore DESC) pageindex
  FROM TeachJoinCourse tjc  INNER JOIN 
(SELECT c.CourseName
,c.CourseID
,SUM(ISNULL(k.score,0))sumscore 
 FROM KPIScore k
INNER JOIN KPITeacher k2 ON k2.KPITeacherId = k.KPITeacherId
INNER JOIN KPIRelease k3 ON k3.KPIReleaseId = k2.KPIReleaseId
INNER JOIN Course c ON c.CourseID = k2.CourseID
WHERE k3.SemesterID = @SemesterID
GROUP BY c.CourseID,c.CourseName
) x ON tjc.CourseID = x.CourseID
INNER JOIN Teacher t ON t.UserId = tjc.UserId
ORDER BY x.sumscore DESC">
    <SelectParameters>
    <asp:ControlParameter Name="SemesterID" ControlID="SemesterID" />
    </SelectParameters>
    </asp:SqlDataSource>

  <div class="table-responsive">
    <table  class="table table-hover">
        <thead>
            <tr>
                <td>单次考核排名</td>
                <th>课程</th>
                <th>任课老师</th>
                <th>得分</th>
                <th>指标总分</th>
                <th>人均得分</th>
                <th>班级人数</th>
                <th>参与评分人数</th>
                <th>考核发布时间</th>
            </tr>
        </thead>
        <tbody>
            <asp:Repeater ID="Repeater2" runat="server" DataSourceID="SqlDataSource3">
                <ItemTemplate>
                    <tr>
                        <td>第<%#Eval("Rank") %>名</td>
                        <td><a href="KPIResultDetail.aspx?CourseID=<%#Eval("CourseID") %>&KPIReleaseId=<%#Eval("KPIReleaseId") %>"><%#Eval("CourseName")%></a></td>
                        <td><%#Eval("TeachName")%></td>
                        <td><%#Eval("sumscore")%></td>
                        <td><%#Eval("upscore")%></td>
                        <td><%#Eval("avgscore")%></td>
                        <td><%#Eval("stucount")%></td>
                        <td><%#Eval("hasfinish")%></td>
                        <td><%#Eval("CreateTime")%></td>
                    </tr>
                </ItemTemplate>
            </asp:Repeater>
        </tbody>
    </table>
  </div>
</div>

    <asp:SqlDataSource ID="SqlDataSource3" runat="server"  ConnectionString="<%$ ConnectionStrings:DuihuaDB %>"
     SelectCommand="SELECT
    RANK() OVER(PARTITION BY x.KPIReleaseId ORDER BY k.CreateTime,x.sumscore DESC) AS Rank
,
x.CourseID 
,x.CourseName
,x.sumscore
,x.upscore
,x.KPIReleaseId
,x.hasfinish
,CASE WHEN x.hasfinish=0 THEN NULL ELSE x.sumscore / x.hasfinish END avgscore
,(SELECT COUNT(1) FROM JoinCourse jc WHERE jc.CourseID = x.CourseID) stucount
,t.TeachName
,t.UserId
, k.CreateTime
  FROM TeachJoinCourse tjc  INNER JOIN 
(SELECT c.CourseName
,c.CourseID
,SUM(ISNULL(k.score,0))sumscore 
,SUM(ISNULL(k4.Score,0)) upscore
,(SELECT COUNT(1) FROM KPITeacher t WHERE t.IsFinish=1 AND t.CourseID=c.CourseID AND t.KPIReleaseId=k3.KPIReleaseId) hasfinish
,k3.KPIReleaseId
 FROM KPIScore k
 INNER JOIN KPIItem k4 ON k4.KPIId = k.KPIId
INNER JOIN KPITeacher k2 ON k2.KPITeacherId = k.KPITeacherId
INNER JOIN KPIRelease k3 ON k3.KPIReleaseId = k2.KPIReleaseId
INNER JOIN Course c ON c.CourseID = k2.CourseID
WHERE k3.SemesterID = @SemesterID
GROUP BY c.CourseID,c.CourseName,k3.KPIReleaseId
) x ON tjc.CourseID = x.CourseID
INNER JOIN Teacher t ON t.UserId = tjc.UserId
INNER JOIN KPIRelease k ON k.KPIReleaseId = x.KPIReleaseId
ORDER BY k.CreateTime,x.sumscore DESC">
         <SelectParameters>
    <asp:ControlParameter Name="SemesterID" ControlID="SemesterID" />
    </SelectParameters>
     </asp:SqlDataSource>
<script type="text/javascript">
   
    var barChartData = {
        labels: [<%=KPIName %>],
        datasets: [
			<%=Score %>
		]

    }
    window.onload = function () {
        var ctx = document.getElementById("canvas").getContext("2d");
        window.myBar = new Chart(ctx).Bar(barChartData, {
            responsive: true
        });
    }

	</script>
</asp:Content>
