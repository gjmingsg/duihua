<%@ Page Title="" Language="C#" MasterPageFile="~/Layout/AdminDefault.Master" AutoEventWireup="true" CodeBehind="FillKPITaskList.aspx.cs" Inherits="Duihua.EducationWeb.Modules.KPI.FillKPITaskList" %>
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
                <li><a href="FillKPI.aspx?CourseID=<%#Eval("CourseID") %>">考核课程：<%#Eval("CourseName")%>/任课老师：<%#Eval("TeacherName")%></a>【<%#Eval("IsFinishText")%>】</li>
            </ItemTemplate>
            </asp:Repeater>
            </ul>
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:DuihuaDB %>" 
                SelectCommand="SELECT c.CourseName
                                    ,au.UserName TeacherName
                                    ,c.CourseID
                                    , CASE WHEN  isnull(k.IsFinish,0) =0 then '未填报'
                              else '已填报' end IsFinishText
                                      FROM  KPITeacher k 
                                    INNER JOIN Course c ON c.CourseID = k.CourseID
                                    INNER JOIN TeachJoinCourse tjc ON tjc.CourseID = c.CourseID
                                    INNER JOIN aspnet_Users au ON au.UserId = tjc.UserId
                                    WHERE k.Creator = @UserId
                                    AND k.KPIReleaseId=@KPIReleaseId" >
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
