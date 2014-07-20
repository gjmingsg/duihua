<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Font.Master" AutoEventWireup="true" CodeBehind="ImageList.aspx.cs" Inherits="Duihua.WebApp.ImageList" %>
<%@ Import Namespace="System.Collections.Generic" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

<style type='text/css'>
  .picList{margin:20px;}
  .picItem{float:left;}
  .picInterface{ border:1.5px solid gray; padding:2px;margin:5px }
  .showPic{ display:none}
  .content1{ height:500px;}
</style>
<script src="/Scripts/uaredirect.js" type="text/javascript"></script>
<script  type="text/javascript">
    uaredirect("/mobile/default.aspx");
</script>
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
        <div class="picList">
        <%
            if (ArticleList==null||ArticleList.Count == 0)
            { 
                %>
                    没有相关作品
                <%
            }
            foreach (var item in ArticleList)
            {
                var temp = item["Content"].ToString().Split(new String[]{"<p>","</p>"},StringSplitOptions.RemoveEmptyEntries);
                if (temp.Length == 0)
                    continue;
                
                %>
                <div class="picItem">
                <a href="ImageShow.aspx?ID=<%=item["ID"] %>">
                   
                    <div class="picInterface"><%=temp[0].Replace("Attachment/img/", "Attachment/img/min/")%></div>
                    <div style="text-overflow: ellipsis;padding:5px; width:115px"><%=item["Title"]%></div>  
                 </a>      
                </div>
        
        <% }%>
        </div>

       
    </div>
</div>
<div class="clearfix" style="margin:10px"></div>
<script type="text/javascript">
//    $(function () {
//        $('.picItem').each(function () {
//            var imglist = $(this).find('.picPList').html();
//            var interface = $(this).find('.picPList>p').html();
//            interface = interface.replace('Attachment/img/', 'Attachment/img/min/');
//            $(this).find('.picInterface').html(interface);
//        });
//    })
</script>
</asp:Content>