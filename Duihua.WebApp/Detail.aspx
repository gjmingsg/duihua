<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Detail.aspx.cs" Inherits="Duihua.WebApp.Detail" %>
<%@ Import Namespace="System.Collections.Generic" %>

<!doctype html>
<html>
<head>
<meta charset="utf-8">
<meta name="renderer" content="webkit">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>对画设计</title>
<link rel="stylesheet" href="Styles/reset.css" />
<link rel="stylesheet" href="Styles/main.css" />
<link rel="stylesheet" href="Styles/animateCSS3.css" />
<script type="text/javascript" src="Scripts/modernizr.custom-css.js"></script>
<!--这个脚本要放这里，其它的可以放底部。用于HTML5及CSS3支持判断-->
</head>
<body>
<!--头部开始-->
<header class="header">
	<div class="header_m m clearfix">
    	<div class="logo lfloat">
        	<img src="images/logo.png" class=" fade-up animate4 animated fadeInUp" alt="对画艺术与设计培训学院" />
        </div>
        <div class="search rfloat">
        	<div class="search_t">
            	<span class="current">综合搜索</span><span>搜名师</span><span>搜班级</span>
            </div>
            <div class="search_m">
            	<input type="text" value="Search......" />
                <button type="button">搜索</button>
            </div>
        </div>
    </div>
</header>
<!--头部结束-->

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
    %><section class="section<%=j %>"><%
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
        <%=item["Content"] %></font>
</div>
 <%} %>
 </section>

<footer class="footer"></footer>
<!--在线报名-->
<div class="enroll_online">
	<a href="Register.aspx"><img src="images/enroll.png" alt="在线报名" /></a>
</div>
<!--在线咨询-->
<div class="consult_online">
	<h1><img src="images/consult.png" alt="在线咨询" /></h1>
    <div class="consultOnline_box">
        <div class="consultOnline_t"></div>
        <div class="consultOnline_m">
        	<div class="consult_list">
            	<h2>在线客服咨询</h2>
                <div class="consult_info">
                	<img src="images/consult_list_ico1.png" alt="" />QQ客服一
                </div>
                <div class="consult_info">
                	<img src="images/consult_list_ico1.png" alt="" />QQ客服二
                </div>
            </div>
            <div class="consult_list">
            	<h2>电话客服咨询</h2>
                <div class="consult_info">
                	<img src="images/consult_list_ico2.png" alt="" />020-3421 5308
                </div>
            </div>
            <div class="consult_list">
            	<h2>公众微信</h2>
                <div class="consult_info">
                	<img src="images/consult_list_ico3.png" alt="" />159 0207 5379
                </div>
            </div>
            <div class="consult_list">
            	<h2>二维码扫描</h2>
                <div class="consult_info ewm">
                	<img src="images/ewm.gif" alt="" />
                </div>
            </div>
        </div>
        <div class="consultOnline_b"></div>
    </div>
</div>

<!--返回顶部-->
<div class="relative">
    <div class="float_ico">
        <a href="#" class="goTop" id="goTop">&nbsp;</a>
        <a class="leave">&nbsp;</a>
    </div>
</div>


<script type="text/javascript" src="Scripts/jquery-1.9.1.min.js"></script><!--库-->
<script type="text/javascript" src="Scripts/jquery.easing.1.3.js"></script><!--动画效果-->
<script type="text/javascript" src="Scripts/jquery-wen_play.js"></script><!--轮播插件-->
<script type="text/javascript" src="Scripts/main.js"></script><!--页面事件-->
<script type="text/javascript" >
    $(document).ready(function () {
        $('#<%=defaultMenu %>').click();
    });
</script>

</body>
</html>
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              
