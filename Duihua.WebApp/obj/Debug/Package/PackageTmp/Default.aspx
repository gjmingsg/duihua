<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Duihua.WebApp._Default"  MasterPageFile="~/Admin/Font.Master"%>
<%@ Import Namespace="System.Collections.Generic" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<style type="text/css">
   .SubmitButton
    {
        width:114px;
	height:34px;
	margin-right:10px;
	border:0;
	cursor:pointer;
	background:none;
	font-size:14px;
        }
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

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
                     <% var pic = Duihua.WebApp.Global.Config("default_image");
                        foreach (var picitem in pic)
                        {
                    %>
                        <li class="play_list">
                        <%if (picitem.ContainsKey("ConfigValue2"))
                          { %>
                        <a href='<%=picitem["ConfigValue2"] %>'>
                        <% }
                          else
                          { %>
                          <a href='#'>
                          <%} %>
                        	<img src='<%=picitem["ConfigValue"] %>' alt='<%=picitem["ConfigValue1"] %>' />
                        </a>
                            <div class="show_txt"><p><%=picitem["ConfigValue1"] %></p></div>
                        </li>
                        <%} %>
                       
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
                    	<a href="detail.aspx?ID=C4DDE71F-A08E-4B03-AEF1-A26B3315B478"><img src="images/btn2.gif" alt="视频中心" /></a>
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
            	<h2>对画介绍<sub>DWAD INTRODUCE</sub></h2>
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
                
                    <%=curVideo %>
                
                </div>
            </div>
            <div class="informationDWAD_list rfloat">
            	<div class="module_light light1">
                    <a href='Detail.aspx?ID=<%=(Information["item0"] as List<Dictionary<String,Object>>)[0]["ID"] %>'>
                        <span class="vertical"></span>
                        <div class="module_relative">
                            <span class="moduleLight_ico"></span>
                            <h2>对画新闻</h2>
                             <div style="margin-left:50px;height:100px;">
                            <%
                                var t = (Information["item0"] as List< Dictionary<String,Object>>); 
                                foreach(var ti in t){ %>
                               <p>  <%=ti["Title"]%></p>
                                <% } %>
                            </div>
                        </div>
                    </a>
                </div>
                <div class="module_light light2">
                    <a href='Detail.aspx?ID=<%=(Information["item1"] as List<Dictionary<String,Object>>)[0]["ID"] %>'>
                        <span class="vertical"></span>
                        <div class="module_relative">
                            <span class="moduleLight_ico"></span>
                            <h2>艺考资讯</h2>
                           <div style="margin-left:50px;height:100px;">
                             <%
                                t = (Information["item1"] as List<Dictionary<String,Object>>); 
                                foreach(var ti in t){ %>
                                <p> <%=ti["Title"]%></p>
                                <%} %>
                            </div>
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
                       
                        <%
                    var result = (Result["item0"] as List<Dictionary<String, Object>>);

                    foreach (var item in result)
                    {
                    %> 
                        <li class="play_list">
                        	<p class="y"><%=item["TypeName"]%></p>
                            <p class="ss"><a href="Detail.aspx?ID=<%=item["ID"] %>">广东美术联考</a></p>
                            <p class="s1"><a href="Detail.aspx?ID=<%=item["ID"] %>">全国美术单考</a></p>
                        </li>
                        <%} %>
                       
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
                     <p>  <%=(Work["item1"] as Dictionary<string,object>)["Title"]%></p>
                </div>
            </div>
            <div class="worksDWAD_pt module_pt rfloat">
            	<div class="worksDWAD_pic module_pic lfloat">
                	<a href='Detail.aspx?ID=<%=(Work["item2"] as Dictionary<string,object>)["ID"] %>'><img src="images/pic2.png" alt="" /></a>
                </div>
                <div class="worksDWAD_txt module_txt">
                	<h2><%=(Work["item2"] as Dictionary<string,object>)["TypeName"]%><sub>STUDENTS' WORK</sub></h2>
                 <p>  <%=(Work["item2"] as Dictionary<string,object>)["Title"]%></p>
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
                          <p> <%=(Viewpoint["item1"] as Dictionary<string,object>)["Title"] %></p>
                        </div>
                    </a>
                </div>
                <div class="module_light light4 rfloat">
                    <a href='Detail.aspx?ID=<%=(Viewpoint["item2"] as Dictionary<string,object>)["ID"] %>'>
                        <span class="vertical"></span>
                        <div class="module_relative">
                            <span class="moduleLight_ico"></span>
                            <h2> <%=(Viewpoint["item2"] as Dictionary<string,object>)["TypeName"] %></h2>
                        <p>   <%=(Viewpoint["item2"] as Dictionary<string,object>)["Title"] %></p>
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
                  <p>   <%=(Publish["item1"] as Dictionary<String,Object>)["Content"] %></p>
                </div>
            </div>
            <div class="publishedDWAD_pt module_pt rfloat">
            	<div class="publishedDWAD_pic module_pic lfloat">
                	<a href='Detail.aspx?ID=<%=(Publish["item2"] as Dictionary<String,Object>)["ID"]  %>'><img src="images/pic2.jpg" alt="" /></a>
                </div>
                <div class="publishedDWAD_txt module_txt">
                	<h2> <%=(Publish["item2"] as Dictionary<String,Object>)["TypeName"] %><sub>INTERNAL MATERIALS</sub></h2>
               <p>       <%=(Publish["item2"] as Dictionary<String, Object>)["Content"]%></p>
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
            	<form method="post" runat="server">
                    <div class="leaveMsg_contact clearfix">
                        <input class="leave_name lfloat" type="text" name="UserName" id="UserName" placeholder="姓名"/>
                        <input class="leave_tel rfloat" type="text" name="ContactWay" id="ContactWay" placeholder="邮箱"/>
                    </div>
                    <div class="leaveMsg_content">
                    	<div class="leaveContent_bg">
                        	<textarea name="Message" placeholder="留言内容" id="Message"></textarea>
                        </div>
                    </div>
                    <div class="send_box">
                        <button type="reset" class="res_btn">重新填写</button>
                            <asp:Button runat="server" Text="提交留言"  CssClass="SubmitButton send_btn" ID="btnSubmit" ValidationGroup="vsErrorInfo" 
                onclick="btnSubmit_Click" OnClientClick="Validate()" />
                       <%-- <button type="submit" class="send_btn" id="send_btn" runat="server" onclick="Validate()">提交留言</button>--%>
                    </div>
                </form>
            </div>
        </div>
    </div>
</section>
<!--内容区‘联系对画’结束-->
 
<script type="text/javascript" >
    $(document).ready(function () {
        $('.video_play').find('embed').height(305).width(500);
        $('.video_pt').each(function () {
            var videaHtml = $(this).find(".showVideo").html();
            $(this).bind("click", function () {
                $('.video_play').html(videaHtml).find('embed').height(305).width(500);
            });
        });
       
    });
   
    function Validate() {
        var mail = $('#ContactWay').val();
        var filter = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
        if (filter.test(mail)==false){
            alert('您的电子邮件格式不正确');
            return false;
        }
        if ($('#UserName').val() == '') {
            alert('姓名不能为空')
            return false;
        }
        if ($('#Message').val() == '') {
            alert('内容不能为空')
            return false;
        }
        return true;
    }
</script>
</asp:Content>