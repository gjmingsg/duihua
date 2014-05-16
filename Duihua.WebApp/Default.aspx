<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Duihua.WebApp._Default" %>
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
        	<li>
            	<a href="#" data-fixed=".section1"><img src="images/nav1.png" alt="关于对画" /></a>
            </li>
        	<li>
            	<a href="#" data-fixed=".section2"><img src="images/nav2.png" alt="对画资讯" /></a>
            </li>
        	<li>
            	<a href="#" data-fixed=".section3"><img src="images/nav3.png" alt="对画成绩" /></a>
            </li>
        	<li>
            	<a href="#" data-fixed=".section4"><img src="images/nav4.png" alt="对画团队" /></a>
            </li>
        	<li>
            	<a href="#" data-fixed=".section5"><img src="images/nav5.png" alt="对画作品" /></a>
            </li>
        	<li>
            	<a href="#" data-fixed=".section6"><img src="images/nav6.png" alt="对画观点" /></a>
            </li>
        	<li>
            	<a href="#" data-fixed=".section7"><img src="images/nav7.png" alt="对画出版" /></a>
            </li>
        	<li>
            	<a href="#" data-fixed=".section8"><img src="images/nav8.png" alt="联系对画" /></a>
            </li>
        </ul>
    </div>
</nav>
</div>
<!--导航结束-->

<!--内容1区开始-->
<div class="content1">
	<div class="content1_m m clearfix">
    	<div class="content1_show lfloat">
        	<div class="wen_play" id="content1_play">
                <div class="wen_play_body">
                    <ul class="wen_play_box clearfix">
                        <li class="play_list">
                        	<img src="images/show1.jpg" alt="" />
                            <div class="show_txt"><p>佳作欣赏1</p></div>
                        </li>
                        <li class="play_list">
                        	<img src="images/show2.jpg" alt="" />
                            <div class="show_txt"><p>佳作欣赏2</p></div>
                        </li>
                        <li class="play_list">
                        	<img src="images/show3.jpg" alt="" />
                            <div class="show_txt"><p>佳作欣赏3</p></div>
                        </li>
                        <li class="play_list">
                        	<img src="images/show1.jpg" alt="" />
                            <div class="show_txt"><p>佳作欣赏4</p></div>
                        </li>
                        <li class="play_list">
                        	<img src="images/show2.jpg" alt="" />
                            <div class="show_txt"><p>佳作欣赏5</p></div>
                        </li>
                        <li class="play_list">
                        	<img src="images/show3.jpg" alt="" />
                            <div class="show_txt"><p>佳作欣赏6</p></div>
                        </li>
                    </ul>
                </div>
			</div>
        </div>
        <div class="content1_apply rfloat">
        	<div class="content1Apply_t">
                <span class="ico1"></span>
                <h1><a href="Register.aspx">在线报名</a></h1>
            </div>
            <div class="content1Apply_m">
            	<h2><span>服务指南</span></h2>
                <ul class="clearfix">
                	<li>
                    	<a href="#"><img src="images/btn1.gif" alt="新手指南" /></a>
                    </li>
                	<li class="even">
                    	<a href="#"><img src="images/btn2.gif" alt="视频中心" /></a>
                    </li>
                	<li>
                    	<a href="#"><img src="images/btn3.gif" alt="家长沟通" /></a>
                    </li>
                	<li class="even">
                    	<a href="#"><img src="images/btn4.gif" alt="官方微博" /></a>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</div>
<!--内容1区结束-->

<!--内容区‘关于对画’开始-->
<section class="section1">
	<div class="aboutDWAD m">
    	<div class="aboutDWAD_t module_title clearfix">
        	<h1 class="fade-left animate3">关于对画</h1>
            <div class="line"></div>
        </div>
        <div class="aboutDWAD_m clearfix">
        	<div class="aboutDWAD_details lfloat">
            	<h2><%=(About["item1"] as Dictionary<String,object>)["TypeName"] %></h2>
                <%=(About["item1"] as Dictionary<String,object>)["Content"] %>
            </div>
            <div class="aboutDWAD_menu lfloat">
            	<h2>对话介绍<sub>DWAD INTRODUCE</sub></h2>
                <div class="menu_list">
                    <%
                        var x = (About["item2"] as List<Dictionary<String, Object>>);
                        int i = 0;
                        foreach(var item in x){
                            if (i % 2 == 0) { 
                                %><a href='Detail.aspx?ID=<%=item["ID"] %>' class="org_bg"><%=item["TypeName"] %></a><%
                            }
                            else { 
                                %><a href='Detail.aspx?ID=<%=item["ID"] %>' class="gray_bg"><%=item["TypeName"] %></a><%
                            }
                            if (i == 0)
                            { 
                                %><br /><%
                            }
                            i++;
                        }   
                      %>
                </div>
            </div>
        </div>
    </div>
</section>
<!--内容区‘关于对画’结束-->

<!--内容区‘对画资讯’开始-->
<section class="section2">
	<div class="informationDWAD m">
    	<div class="informationDWAD_t module_title clearfix">
        	<h1 class="fade-left animate3">对画资讯</h1>
            <div class="line"></div>
        </div>
        <div class="informationDWAD_m clearfix">
            <div class="informationDWAD_video lfloat">
                <ul class="lfloat">
                <%
                    var list = (Information["item2"] as List<Dictionary<String, Object>>);
                    var curVideo = list[0]["Content"];
                    foreach (var item in list)
                    {
                    %>
                    <li>
                        <div class="video_pt clearfix">
                            <img class="video_pic" src="images/video.jpg" alt="" />
                            <div class="video_txt">
                            	<h2></h2>
                                <p><%=(item["Title"]) %></p>
                                <div style="display:none" class="showVideo">
                                    <%=item["Content"] %>
                                </div>
                            </div>
                        </div>
                    </li>
                    <%
                        }
                 %>

                </ul>
                <div class="video_play lfloat">
                	<!--这里放视频播放器，如果是HTML5播放器要加上 wmode="transparent"属性，如果是flash播放器要加上<param name="wmode" value="transparent" />不然层级是盖不住的。-->
                    <%=curVideo %>
                   	<%--<img src="images/video_play.jpg" />--%>
                </div>
            </div>
            <div class="informationDWAD_list rfloat">
            	<div class="module_light light1">
                    <a href='Detail.aspx?ID=<%=(Information["item0"] as Dictionary<String,Object>)["ID"] %>'>
                        <span class="vertical"></span>
                        <div class="module_relative">
                            <span class="moduleLight_ico"></span>
                            <h2><%=(Information["item0"] as Dictionary<String,Object>)["TypeName"] %></h2>
                            <p><%=(Information["item0"] as Dictionary<String,Object>)["Content"] %></p>
                        </div>
                    </a>
                </div>
                <div class="module_light light2">
                    <a href='Detail.aspx?ID=<%=(Information["item1"] as Dictionary<String,Object>)["ID"] %>'>
                        <span class="vertical"></span>
                        <div class="module_relative">
                            <span class="moduleLight_ico"></span>
                            <h2><%=(Information["item1"] as Dictionary<String,Object>)["TypeName"] %></h2>
                            <p><%=(Information["item1"] as Dictionary<String,Object>)["Content"] %></p>
                        </div>
                    </a>
                </div>
            </div>
        </div>
    </div>
</section>
<!--内容区‘对画资讯’结束-->

<!--内容区‘对画成绩’开始-->
<section class="section3">
	<div class="resultsDWAD m">
    	<div class="resultsDWAD_t module_title clearfix">
        	<h1 class="fade-left animate3">对画成绩</h1>
            <div class="line"></div>
        </div>
        <div class="resultsDWAD_m clearfix">
        	<div class="wen_play" id="resultsDWAD_play">
                <div class="wen_play_body">
                    <ul class="wen_play_box clearfix">
                        <li class="play_list">
                        	<p class="y">2012—2013学年度</p>
                            <p class="ss"><a href="#">广东美术联考</a></p>
                            <p class="s1"><a href="#">美术单考</a></p>
                        </li>
                        <li class="play_list">
                        	<p class="y">2012—2013学年度</p>
                            <p class="ss"><a href="#">广东美术联考</a></p>
                            <p class="s1"><a href="#">美术单考</a></p>
                        </li><li class="play_list">
                        	<p class="y">2012—2013学年度</p>
                            <p class="ss"><a href="#">广东美术联考</a></p>
                            <p class="s1"><a href="#">美术单考</a></p>
                        </li><li class="play_list">
                        	<p class="y">2012—2013学年度</p>
                            <p class="ss"><a href="#">广东美术联考</a></p>
                            <p class="s1"><a href="#">美术单考</a></p>
                        </li><li class="play_list">
                        	<p class="y">2012—2013学年度</p>
                            <p class="ss"><a href="#">广东美术联考</a></p>
                            <p class="s1"><a href="#">美术单考</a></p>
                        </li><li class="play_list">
                        	<p class="y">2012—2013学年度</p>
                            <p class="ss"><a href="#">广东美术联考</a></p>
                            <p class="s1"><a href="#">美术单考</a></p>
                        </li>
                    </ul>
                </div>
			</div>
        </div>
    </div>
</section>
<!--内容区‘对画成绩’结束-->

<!--内容区‘对画团队’开始-->
<section class="section4">
	<div class="teamDWAD m">
    	<div class="teamDWAD_t module_title clearfix">
        	<h1 class="fade-left animate3">对画团队</h1>
            <div class="line"></div>
        </div>
        <div class="teamDWAD_m clearfix">
        	<div class="teamDWAD_ico"><img class="animate2" src="images/ico_team.png" alt="" /></div>
            <div class="teamDWAD_core fade-left animate4">
            	<a href='Detail.aspx?ID=<%=(Team["item1"] as Dictionary<String,object>)["ID"] %>'>
                    <h2><%=(Team["item1"] as Dictionary<String,object>)["TypeName"] %></h2>
                    <sub>THE CORE TEAM</sub>
                </a>
            </div>
            <div class="teamDWAD_teachers fade-left animate4">
                <a href='Detail.aspx?ID=<%=(Team["item2"] as Dictionary<String,object>)["ID"] %>'>
                    <h2><%=(Team["item2"] as Dictionary<String,object>)["TypeName"] %></h2>
                    <sub>PROFESSIONAL TEACHERS</sub>
                </a>
            </div>
        </div>
    </div>
</section>
<!--内容区‘对画团队’结束-->

<!--内容区‘对画作品’开始-->
<section class="section5">
	<div class="worksDWAD m">
    	<div class="worksDWAD_t module_title clearfix">
        	<h1 class="fade-left animate3">对画作品</h1>
            <div class="line"></div>
        </div>
        <div class="worksDWAD_m clearfix">
        	<div class="worksDWAD_pt module_pt lfloat">
            	<div class="worksDWAD_pic module_pic lfloat">
                	<a href='Detail.aspx?ID=<%=(Work["item1"] as Dictionary<string,object>)["ID"] %>'><img src="images/pic1.png" alt="" /></a>
                </div>
                <div class="worksDWAD_txt module_txt">
                	<h2><%=(Work["item1"] as Dictionary<string,object>)["TypeName"]%><sub>TEACHERS' WORK</sub></h2>
                      <%=(Work["item1"] as Dictionary<string,object>)["Content"]%>
                </div>
            </div>
            <div class="worksDWAD_pt module_pt rfloat">
            	<div class="worksDWAD_pic module_pic lfloat">
                	<a href='Detail.aspx?ID=<%=(Work["item2"] as Dictionary<string,object>)["ID"] %>'><img src="images/pic2.png" alt="" /></a>
                </div>
                <div class="worksDWAD_txt module_txt">
                	<h2><%=(Work["item2"] as Dictionary<string,object>)["TypeName"]%><sub>STUDENTS' WORK</sub></h2>
                  <%=(Work["item2"] as Dictionary<string,object>)["Content"]%>
                </div>
            </div>
        </div>
    </div>
</section>
<!--内容区‘对画作品’结束-->

<!--内容区‘对画观点’开始-->
<section class="section6">
	<div class="viewpointDWAD m">
    	<div class="viewpointDWAD_t module_title clearfix">
        	<h1 class="fade-left animate3">对画观点</h1>
            <div class="line"></div>
        </div>
        <div class="viewpointDWAD_m">
            <div class="viewpointDWAD_list clearfix">
            	<div class="module_light light3 lfloat">
                	<a href='Detail.aspx?ID=<%=(Viewpoint["item1"] as Dictionary<string,object>)["ID"] %>'>
                        <span class="vertical"></span>
                        <div class="module_relative">
                            <span class="moduleLight_ico"></span>
                            <h2> <%=(Viewpoint["item1"] as Dictionary<string, object>)["TypeName"]%></h2>
                          <%=(Viewpoint["item1"] as Dictionary<string,object>)["Content"] %>
                        </div>
                    </a>
                </div>
                <div class="module_light light4 rfloat">
                    <a href='Detail.aspx?ID=<%=(Viewpoint["item2"] as Dictionary<string,object>)["ID"] %>'>
                        <span class="vertical"></span>
                        <div class="module_relative">
                            <span class="moduleLight_ico"></span>
                            <h2> <%=(Viewpoint["item2"] as Dictionary<string,object>)["TypeName"] %></h2>
                          <%=(Viewpoint["item2"] as Dictionary<string,object>)["Content"] %>
                        </div>
                    </a>
                </div>
            </div>
        </div>
    </div>
</section>
<!--内容区‘对画观点’结束-->

<!--内容区‘对画出版’开始-->
<section class="section7">
	<div class="publishedDWAD m">
    	<div class="publishedDWAD_t module_title clearfix">
        	<h1 class="fade-left animate3">对画出版</h1>
            <div class="line"></div>
        </div>
        <div class="publishedDWAD_m clearfix">
        	<div class="publishedDWAD_pt module_pt lfloat">
            	<div class="publishedDWAD_pic module_pic lfloat">
                	<a href='Detail.aspx?ID=<%=(Publish["item1"] as Dictionary<String,Object>)["ID"]  %>'><img src="images/pic1.jpg" alt="" /></a>
                </div>
                <div class="publishedDWAD_txt module_txt">
                	<h2> <%=(Publish["item1"] as Dictionary<String,Object>)["TypeName"] %><sub>PUBLICATIONS</sub></h2>
                    <%=(Publish["item1"] as Dictionary<String,Object>)["Content"] %>
                </div>
            </div>
            <div class="publishedDWAD_pt module_pt rfloat">
            	<div class="publishedDWAD_pic module_pic lfloat">
                	<a href='Detail.aspx?ID=<%=(Publish["item2"] as Dictionary<String,Object>)["ID"]  %>'><img src="images/pic2.jpg" alt="" /></a>
                </div>
                <div class="publishedDWAD_txt module_txt">
                	<h2> <%=(Publish["item2"] as Dictionary<String,Object>)["TypeName"] %><sub>INTERNAL MATERIALS</sub></h2>
                     <%=(Publish["item2"] as Dictionary<String,Object>)["Content"] %>
                </div>
            </div>
        </div>
    </div>
</section>
<!--内容区‘对画出版’结束-->

<!--内容区‘联系对画’开始-->
<section class="section8">
	<div class="contactDWAD m">
    	<div class="contactDWAD_t module_title clearfix">
        	<h1 class="fade-left animate3">联系对画</h1>
            <div class="line"></div>
        </div>
        <div class="contactDWAD_m">
        	<div class="contactDWAD_details clearfix">
                <%=(Contact["item1"] as Dictionary<String,Object>)["Content"] %>
            </div>
              <div class="leave_msg">
            	<form action="Default.aspx?Submit=Message" method="post">
                    <div class="leaveMsg_contact clearfix">
                        <input class="leave_name lfloat" type="text" name="UserName"/>
                        <input class="leave_tel rfloat" type="text" name="ContactWay"/>
                    </div>
                    <div class="leaveMsg_content">
                    	<div class="leaveContent_bg">
                        	<textarea name="Message"></textarea>
                        </div>
                    </div>
                    <div class="send_box">
                        <button type="reset" class="res_btn">重新填写</button>
                        <button type="submit" class="send_btn">提交留言</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</section>
<!--内容区‘联系对画’结束-->

<footer class="footer"></footer>

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

   <div id="loading" style="display:none" >
        <div class="load_mg" style="position: absolute; top: 45%; left: 45%; z-index: 1000; border:0px;">
            <table id="Table1">
                <tr>
                    <td>
                    </td>
                    <td>
                        提交中......
                    </td>
                </tr>
            </table>
            <table id="Table2" cellpadding="5" cellspacing="5">
                <tr>
                    <td class="">
                        <img  src="Images/loading.gif" />
                    </td>
                    <td style="padding: 5px;">
                        &nbsp;
                    </td>
                </tr>
            </table>
        </div>
        <div style="background: #fff; filter: alpha(opacity=60); opacity: 0.6; width: 100%;
            height: 100%; position: absolute; left: 0; top: 0; z-index: 999;">
        </div>
    </div>
<script type="text/javascript" src="Scripts/jquery-1.9.1.min.js"></script><!--库-->
<script type="text/javascript" src="Scripts/jquery.easing.1.3.js"></script><!--动画效果-->
<script type="text/javascript" src="Scripts/jquery-wen_play.js"></script><!--轮播插件-->
<script type="text/javascript" src="Scripts/main.js"></script><!--页面事件-->
<script type="text/javascript" >
    $(document).ready(function () {
        $('.video_pt').each(function () {
            var videaHtml = $(this).find(".showVideo").html();
            $(this).bind("click", function () {
                $('.video_play').html(videaHtml).find('embed').height(305).width(500);
            });
        });
        $('.send_btn').click(function () {
            SubmitMessage();
        });
    });
    function SubmitMessage() {
        document.getElementById('loading').style.display = "";

        return true;
    }
</script>

</body>
</html>
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              