<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Detail.aspx.cs" Inherits="Duihua.WebApp.Detail"  MasterPageFile="~/Admin/Font.Master"%>
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
        
        <%
            int i = 1;
            foreach (var item in Menu)
            {    %>
        	<li>
            	<a href="#" data-fixed='.section<%=i %>' id='<%=item["TypeCode"] %>'><font color="white"><%=item["TypeName"] %></font></a>
            </li>
        <% 
                i++;
         }%>	 
        </ul>
    </div>
</nav>
</div>
<!--导航结束-->

<!--内容1区开始-->
<div class="content1">
	
</div>
<!--内容1区结束-->
    <%
    int j = 1;
    if (ArticleList.Count == 0)
        return;
    var lastCode = ArticleList[0]["TypeCode"];
    var defaultMenu = lastCode;
    %>
    <section class="section<%=j %>">
    <%
    foreach (var item in ArticleList)
    {
        if (lastCode.Equals(item["TypeCode"]) == false) {
            j++;
            lastCode = item["TypeCode"];
            %>
            </section>
            <section class="section<%=j %>">
            <%
        }
        if (Id.Equals(item["TypeId"].ToString().ToUpper()))
        {
            defaultMenu = lastCode;
        }
  %><div class="m">
  <%if (j % 2 == 0)
    {%>
        <font color="white">
    <%} %>
        <%=item["Content"] %>
        </font>
</div>
 <%} %>
 </section>
 <script type="text/javascript" >
     $(document).ready(function () {
         $('#<%=defaultMenu %>').click();
     });
</script>
</asp:Content>
  
 