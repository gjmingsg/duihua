<%@ Page Title="" Language="C#" MasterPageFile="~/Layout/Course.master" AutoEventWireup="true" CodeBehind="MyCoursemate.aspx.cs" Inherits="Duihua.EducationWeb.Modules.Student.MyCoursemate" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">

<script type="text/javascript">
    $(function () {
        $('#learnMore').click(function () {
            if ($(this).text() == '了解更多...') {
                $('.shortTeacherIntro').hide();
                $('.fullTeacherIntro').show();
                $(this).text('收起<<')
            } else {
                $('.shortTeacherIntro').show();
                $('.fullTeacherIntro').hide();
                $(this).text('了解更多...')
            }
        });
    })
</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Main" runat="server">
 <h1 class="page-header">我的任课老师(<%=TeacherInfo["TeachName"]%>)</h1>
<div class="jumbotron">
    <a href="#" class="thumbnail">
      <asp:Image ID="ImgTeacher" runat='server'  CssClass="img-responsive"/>  
    </a>
  
  <blockquote>
  <p  class="shortTeacherIntro">
   <%=TeacherInfo["Intro"].ToString().Length > 100 ? TeacherInfo["Intro"].ToString().Substring(0, 100) + "..." : TeacherInfo["Intro"].ToString()%>
  </p>
   <p style="display:none" class='fullTeacherIntro'>
      <%=TeacherInfo["Intro"]%>
  </p>
    </blockquote>
  <p><a class="btn btn-primary btn-lg" role="button" id="learnMore">了解更多...</a></p>
</div>
<h2 class="page-header">我的同学</h2>
    <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource1">
        <ItemTemplate>
            <div class="col-xs-6 col-sm-3 placeholder">
              <a href='../Account/PersonalSetting.aspx?UserId=<%#Eval("UserId") %>'>
                 <asp:Image ID="ImgShowImg" AlternateText='<%#Eval("StudentName")%>' runat="server" ImageUrl='<%#Eval("PicUrl") %>' CssClass="img-responsive img-thumbnail"/>  
              </a>
              <h4><%#Eval("StudentName")%></h4>
              <span class="text-muted"><%#Eval("Email") %></span>
            </div>
        </ItemTemplate>
    </asp:Repeater>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server"  ConnectionString="<%$ ConnectionStrings:DuihuaDB %>" 
     SelectCommand="
SELECT 
                    ISNULL(s.PicUrl,'/Images/noimage.jpg') PicUrl
                    ,s.StudentName
                    ,s.UserId
                    ,s.Email
			FROM JoinCourse jc
                    INNER JOIN Student s ON s.UserId = jc.UserId
                    WHERE jc.CourseID = @CourseID"
                >
                    <SelectParameters>
                        <asp:QueryStringParameter QueryStringField="CourseID" Name="CourseID" DefaultValue ="00000000-0000-0000-0000-000000000000" />
                    </SelectParameters>
                </asp:SqlDataSource>
</asp:Content>
