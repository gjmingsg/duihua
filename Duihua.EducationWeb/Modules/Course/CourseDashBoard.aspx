<%@ Page Title="我的课程" Language="C#" MasterPageFile="~/Layout/AdminDefault.Master" AutoEventWireup="true" CodeBehind="CourseDashBoard.aspx.cs" Inherits="Duihua.EducationWeb.Modules.Course.CourseDashBoard" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<div class="row">
 
    <asp:Repeater ID="Repeater1" runat="server">
        <ItemTemplate>
        <div class="col-lg-4 col-sm-6 col-xs-12 ">
         <div class="thumbnail">
                <asp:Image ID="ImgShowImg" runat="server" ImageUrl='<%#Eval("Cover") %>' CssClass="img-responsive img-thumbnail"/>  
                    <h2><%#Eval("CourseName")%></h2><span class="label label-danger"><%#GetStatus(Eval("datelength"), Eval("datespend"))%></span>
                    <p>任课老师：<%#Eval("TeachName")%><asp:Button OnClick="btnLeaveMessage_Click" runat="server" Text="留言" CssClass="btn btn-warning btn-sm" style="margin-left:5px;" /></p>
                    <p class="bg-warning">课程时间：<%#Eval("StartTime")%>~<%#Eval("EndTime")%></p>
                    
                    <div class="progress">
                      <div class="progress-bar progress-bar-primary" role="progressbar" aria-valuenow='<%#GetProgress(Eval("datelength"),Eval("datespend")) %>' aria-valuemin="0" aria-valuemax="100" style='width: <%#GetProgress(Eval("datelength"),Eval("datespend")) %>%'>
                        <span class="sr-only"><%#GetProgress(Eval("datelength"),Eval("datespend")) %>% Complete</span>
                      </div>
                    </div>
                    <div class="col-lg-offset-5 col-sm-offset-5">
                    
                     <asp:Button  runat="server" Text="进入课程" _id='<%#Eval("CourseID") %>' CssClass="btn btn-success" OnClick="btnGotoCourse_Click"/>
                    
                    </div>
             </div>
          </div>
        </ItemTemplate>
    </asp:Repeater>
   
    <asp:SqlDataSource ID="SqlDataSource1"  ConnectionString="<%$ ConnectionStrings:DuihuaDB %>"  runat="server"
     SelectCommand=" SELECT 
      c.[CourseID]
      ,[CourseName]
      ,CONVERT(NVARCHAR(19),c.StartTime,121)[StartTime]
      ,CONVERT(NVARCHAR(19),c.EndTime,121) [EndTime]
      ,[Cover]
      ,[CreateTime]
      ,t.UserId
      ,t2.TeachName
      ,DATEDIFF(ss,[StartTime],[EndTime]) datelength
      ,DATEDIFF(ss,[StartTime],GETDATE()) datespend
  FROM [dbo].[Course] c
  INNER JOIN TeachJoinCourse t ON t.CourseID = c.CourseID
  INNER JOIN Teacher t2 ON t2.UserId = t.UserId
 WHERE EXISTS(SELECT 1 FROM JoinCourse j 
              INNER JOIN Student s ON s.UserId = j.UserId AND s.StudentName = @userName
              WHERE c.CourseID = j.CourseID)
               OR (t2.TeachName = @userName) " >
        <SelectParameters>
            <asp:Parameter Name="userName" />
        </SelectParameters>
     </asp:SqlDataSource>
</div>

</asp:Content>
