<%@ Page Title="考核指标结果明细" Language="C#" MasterPageFile="~/Layout/AdminDefault.Master" AutoEventWireup="true" CodeBehind="KPIResultDetail.aspx.cs" Inherits="Duihua.EducationWeb.Modules.KPI.KPIResultDetail" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <script src="../../Scripts/Chart.min.js" type="text/javascript"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<div class="panel panel-default">
  <div class="panel-heading">课程各个指标考核分数分布情况</div>
  <div class="panel-body">
 
   <div class="col-md-6" id="canvas-holder">
    <canvas id="chart-area" width="500" height="500"/>
   </div>
   <div class="col-md-6">
       
        <div class="table-responsive">
        <table class="table">
            <thead>
                <tr>
                    <th>指标</th>
                    <th>获得分数</th>
                </tr>
            </thead>
            <tbody>
           <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource1">
                <ItemTemplate>
                    <tr>
                        <td><%#Eval("KPIName")%></td>
                        <td><%#Eval("sumscore")%></td>
                    </tr>
                </ItemTemplate>
           </asp:Repeater>
           </tbody>
       </table>
       </div>
       <asp:SqlDataSource ID="SqlDataSource1" runat="server"  ConnectionString="<%$ ConnectionStrings:DuihuaDB %>" 
        SelectCommand="SELECT x.sumscore,k.KPIName FROM KPIItem k INNER JOIN (
SELECT sum(isnull(k2.Score,0)) sumscore,k2.KPIId
FROM KPITeacher k 
INNER JOIN KPIScore k2 ON k2.KPITeacherId = k.KPITeacherId
INNER JOIN KPIItem k3 ON k3.KPIId = k2.KPIId
WHERE k.CourseID = @CourseID
and k.KPIReleaseId =@KPIReleaseId
GROUP BY k2.KPIId) x ON x.KPIId = k.KPIId
ORDER BY x.sumscore DESC">
    <SelectParameters>
        <asp:QueryStringParameter Name="KPIReleaseId" QueryStringField="KPIReleaseId"  DefaultValue="00000000-0000-0000-0000-000000000000"/>
        <asp:QueryStringParameter Name="CourseID" QueryStringField="CourseID"  DefaultValue="00000000-0000-0000-0000-000000000000" />
    </SelectParameters>
</asp:SqlDataSource>


    

   </div>

  </div>


</div>



<div class="panel panel-success" runat="server" id="commentDiv" visible="false">
<div class="panel-heading">学生的评价</div>

<table class="table table-hover">
    <thead>
        <tr>
            <th>学生名称</th>
            <th>发表时间</th>
            <th>评价</th>
        </tr>
    </thead>
    <tbody>
    <asp:Repeater ID="Repeater2" runat="server" DataSourceID="SqlDataSource2">
    <ItemTemplate>
        <tr>
            <td><%#Eval("UserName")%></td>
            <td><%#Eval("CreateTime")%></td>
            <td><%#Eval("Memo")%></td>
        </tr>
    </ItemTemplate>
    </asp:Repeater>
    </tbody>
</table>
    <asp:SqlDataSource ID="SqlDataSource2" runat="server"  ConnectionString="<%$ ConnectionStrings:DuihuaDB %>" 
    SelectCommand="SELECT k.Memo,au.UserName,k.CreateTime  FROM KPITeacher k 
INNER JOIN aspnet_Users au ON au.UserId = k.Creator
WHERE k.IsFinish = 1
AND k.KPIReleaseId = @KPIReleaseId
AND k.CourseID = @CourseID">
    <SelectParameters>
        <asp:QueryStringParameter Name="KPIReleaseId" QueryStringField="KPIReleaseId"  DefaultValue="00000000-0000-0000-0000-000000000000"/>
        <asp:QueryStringParameter Name="CourseID" QueryStringField="CourseID"  DefaultValue="00000000-0000-0000-0000-000000000000" />
    </SelectParameters>
    </asp:SqlDataSource>
</div>

<script type="text/javascript">

    var pieData = [<%=KPIResultDetailData %>];

    window.onload = function () {
        var ctx = document.getElementById("chart-area").getContext("2d");
        window.myPie = new Chart(ctx).Pie(pieData);
    };

	</script>
</asp:Content>
