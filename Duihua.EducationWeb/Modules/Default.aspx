<%@ Page Title="控制面板" Language="C#" MasterPageFile="~/Layout/AdminDefault.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Duihua.EducationWeb.Modules.Default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
<style type="text/css">
.thumbnail{float:left; margin:10px;}
.caption{ text-align:center;}
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<div class="alert alert-success alert-dismissable">
<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
欢迎 <strong><%=Page.User.Identity.Name%></strong> 登录系统
<asp:Literal runat="server" ID="lnotice"></asp:Literal>
<asp:Literal runat="server" ID="lmessage"></asp:Literal>
</div>
<div class="panel panel-default">
<div class="panel-group" id="accordion">
  <% var menu = SiteMap.RootNode;
     int i=0;
     foreach (SiteMapNode item in menu.ChildNodes)
     {
         i++;
   %>
  <div class="panel panel-default">
    <div class="panel-heading">
      <h4 class="panel-title">
        <a data-toggle="collapse" data-toggle="collapse" data-parent="#accordion" href='#collapse<%=i %>'>
          <%=item.Title %>
        </a>
      </h4>
    </div>
    <div id='collapse<%=i %>' class="panel-collapse collapse in">
      <div class="panel-body">
      <%foreach (SiteMapNode item1 in item.ChildNodes)
        { %>
       <div class="thumbnail col-sm-2 col-md-2 col-xs-12">
          <a href='<%=item1.Url %>'>
            <img src='../Images/<%=item1.Title %>.png' alt='<%=item1.Title %>' class="img-rounded" />
          </a>
          <div class="caption">
            <h4><%=item1.Title %></h4>
            <p><%=item1.Description %></p>
          </div>
        </div>
        <%} %>
      </div>
    </div>
  </div>
  <%} %>
   
</div>
</div>
</asp:Content>
