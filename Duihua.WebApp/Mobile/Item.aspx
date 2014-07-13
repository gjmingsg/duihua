<%@ Page Title="" Language="C#" MasterPageFile="~/Mobile/Mobile.Master" AutoEventWireup="true" CodeBehind="~/Item.aspx.cs" Inherits="Duihua.WebApp.Item" %>
<%@ Import Namespace="System.Collections.Generic" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<!--导航开始-->
<div class="position_site">

<nav class="nav">
	<div class="nav_m m">
    	<ul class="clearfix">
            <li><a href="Default.aspx"><font color="white">主页</font></a></li>
        
       
        </ul>
    </div>
</nav>

</div>
<!--导航结束-->

<!--内容1区开始-->
<div class="content1">
	<div class="m">
    <%=Content %>
</div>
</div>
<!--内容1区结束-->
 
</asp:Content>
