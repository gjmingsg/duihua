<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="Duihua.WebApp.Register" %>
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
<style>

fieldset
{
    margin: 1em 0px;
    padding: 1em;
    border: 1px solid #ccc;
}

fieldset p 
{
    margin: 2px 12px 10px 10px;
}

fieldset.register label
{
    display: block;
}

fieldset label.inline 
{
    display: inline;
}

legend 
{
    font-size: 1.1em;
    font-weight: 600;
    padding: 2px 4px 8px 4px;
}
.inputText
{
    width:400px;
	height:30px;
	font-size:20px;
	padding:13px 15px;
	border:1px solid gray;
	}
</style>
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
            <li>
                <a href="Default.aspx"><font color="white">主页</font></a>
            </li>
        	<li>
            	<a href="#" data-fixed='.section1'><font color="white">基本信息</font></a>
            </li>
        	<li>
            	<a href="#" data-fixed='.section2'><font color="white">个人简介</font></a>
            </li>
            <li>
            	<a href="#" data-fixed='.section3'><font color="white">附件（简历/作品）</font></a>
            </li>
        </ul>
    </div>
</nav>
</div>
<!--导航结束-->

<!--内容1区开始-->
<div class="content1">
	
</div>
<!--内容1区结束-->
<form action="Default.aspx?Submit=Message" method="post" runat="server">
<section class="section1">
<div class="m">
<fieldset>
    <legend>基本信息</legend>
     <p>
                     附件（简历/作品）要求
                                     附件（简历/作品）要求
                                                     附件（简历/作品）要求
                    </p>
      <div class="lfloat">
      <asp:Label runat="server" Text="报名人："></asp:Label>
      <asp:TextBox ID="TextBox2" runat="server" CssClass="inputText"></asp:TextBox>
      </div>
       <div class="rfloat">
      <asp:Label ID="Label2" runat="server" Text="报名号："></asp:Label>
      <asp:TextBox ID="TextBox1" runat="server" CssClass="inputText"></asp:TextBox>
      </div>

      <div  class="lfloat">
      <asp:Label ID="Label3" runat="server" Text="QQ："></asp:Label>
      <asp:TextBox ID="TextBox3" runat="server" CssClass="inputText"></asp:TextBox>
      </div>
      <div  class="rfloat">
      <asp:Label ID="Label4" runat="server" Text="Email："></asp:Label>
      <asp:TextBox ID="TextBox4" runat="server" CssClass="inputText"></asp:TextBox>
      </div>

       <div class="lfloat">
      <asp:Label ID="Label1" runat="server" Text="电话："></asp:Label>
      <asp:TextBox ID="TextBox5" runat="server" CssClass="inputText"></asp:TextBox>
      </div>
      <div class="rfloat">
      <asp:Label ID="Label5" runat="server" Text="所选班级："></asp:Label>
      <asp:TextBox ID="TextBox6" runat="server" CssClass="inputText"></asp:TextBox>
      </div>
      <div class="lfloat">
      <asp:Label ID="Label6" runat="server" Text="地址："></asp:Label>
      <asp:TextBox ID="TextBox7" runat="server" CssClass="inputText"></asp:TextBox>
      </div>
      
</fieldset>
</div>
</section>
<section class="section2">
<div class="m">
<fieldset>
    <legend>个人简介</legend>
     <p>
                     附件（简历/作品）要求
                                     附件（简历/作品）要求
                                                     附件（简历/作品）要求
                    </p>
                    	<div class="leaveContent_bg">
                        	<textarea></textarea>
                        </div>
                    
</fieldset>
</div>
</section>
<section class="section3">
<div class="m">
<fieldset>
    <legend>附件（简历/作品）</legend>
     <p>
                     附件（简历/作品）要求
                                     附件（简历/作品）要求
                                                     附件（简历/作品）要求
                    </p>
     <asp:FileUpload ID="FileUpload1" runat="server"></asp:FileUpload>
    <div class="send_box">
            <button type="reset" class="res_btn">重置</button>
            <button type="submit" class="send_btn">提交</button>
    </div>
</fieldset>
</div>
</section>
</form>
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
   
</script>

</body>
</html>
