<%@ Page Title="考核指标结果" Language="C#" MasterPageFile="~/Layout/AdminDefault.Master" AutoEventWireup="true" CodeBehind="KPIResultList.aspx.cs" Inherits="Duihua.EducationWeb.Modules.KPI.KPIResultList" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<div class="panel panel-success">
  
      <div class="panel-heading">
        <h3 class="panel-title">教师评价指标</h3>
      </div>

      <div class="panel-body" id="panelbody" runat="server" >


    <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource1">
        <ItemTemplate>
            <div>
                <asp:TextBox ID="KPIReleaseId" runat="server" Visible="false" _KPIReleaseId='<%#Eval("KPIReleaseId") %>'></asp:TextBox>
                <p>
                    <%#Eval("Memo") %>
                </p>
                <p>发布人：<strong><%#Eval("UserName")%></strong></p>
                <p>发布时间：<span class="label label-info"><%#Eval("CreateTime")%></span></p>
            </div>
            <ul>
            <asp:Repeater ID="Repeater2" runat="server"  DataSourceID="SqlDataSource2">
            <ItemTemplate>
                <li>
                    <a href="KPIResultDetail.aspx?CourseID=<%#Eval("CourseID") %>&KPIReleaseId=<%#Eval("KPIReleaseId") %>">
                        考核课程：<%#Eval("CourseName")%>/<span class='label label-warning'>获得分数：<%#Eval("allscore")%></span>
                    </a>
                    【课程学生总数/参与填报学生数：<span class='label label-danger'><%#Eval("hasfill")%>/<%#Eval("hasfill")%></span>】
                </li>
            </ItemTemplate>
            </asp:Repeater>
            </ul>
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:DuihuaDB %>" 
                SelectCommand="SELECT c.CourseID,c.CourseName,k.KPIReleaseId
,SUM(ISNULL(k2.Score,0)) allscore
,(SELECT sum(isnull(t.IsFinish,0)) FROM kpiteacher t WHERE t.KPIReleaseId =@KPIReleaseId AND t.CourseID = c.CourseID) hasfill
,(SELECT COUNT(t.KPITeacherId) FROM kpiteacher t WHERE t.KPIReleaseId = @KPIReleaseId AND t.CourseID = c.CourseID) needfill
  FROM Course c INNER JOIN KPITeacher k ON k.CourseID = c.CourseID
INNER JOIN KPIScore k2 ON k2.KPITeacherId = k.KPITeacherId
INNER JOIN TeachJoinCourse tjc ON tjc.CourseID = c.CourseID 
WHERE k.KPIReleaseId = @KPIReleaseId
AND tjc.UserId =@UserId 
GROUP BY c.CourseID,c.CourseName,k.KPIReleaseId
" >
                <SelectParameters>
                    <asp:SessionParameter Name="UserId" SessionField="UserId" DefaultValue ="00000000-0000-0000-0000-000000000000" />
                    <asp:Parameter Name="KPIReleaseId"/>
                </SelectParameters>
            </asp:SqlDataSource>
            <hr />

            
            
        </ItemTemplate>
    </asp:Repeater>

    <asp:SqlDataSource ID="SqlDataSource1" runat="server"  ConnectionString="<%$ ConnectionStrings:DuihuaDB %>" 
      SelectCommand="
SELECT k.KPIReleaseId,k.CreateTime,k.Memo,k.Creator,au.UserName
  FROM KPIRelease k
INNER JOIN aspnet_Users au ON k.Creator = au.UserId" >
             
    </asp:SqlDataSource>
    </div>
 </div>       

</asp:Content>
