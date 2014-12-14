<%@ Page Title="课程信息" Language="C#" MasterPageFile="~/Layout/Course.master" AutoEventWireup="true" CodeBehind="CourseDetail.aspx.cs" Inherits="Duihua.EducationWeb.Modules.Course.CourseDetail" %>
 <%@ MasterType VirtualPath="~/Layout/Course.master"%> 
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Main" runat="server">

  <div>
    <h2>课程大纲</h2>
    <p><%=Master.CourseInfo["Syllabus"]%></p>
  </div>

</asp:Content>
