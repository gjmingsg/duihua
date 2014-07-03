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

<!--������ʼ-->
<div class="position_site">
<nav class="nav">
	<div class="nav_m m">
    	<ul class="clearfix">
        	<li>
            	<a href="#" data-fixed=".section1"><img src="images/nav1.png" alt="���ڶԻ�" /></a>
            </li>
        	<li>
            	<a href="#" data-fixed=".section2"><img src="images/nav2.png" alt="�Ի���Ѷ" /></a>
            </li>
        	<li>
            	<a href="#" data-fixed=".section3"><img src="images/nav3.png" alt="�Ի��ɼ�" /></a>
            </li>
        	<li>
            	<a href="#" data-fixed=".section4"><img src="images/nav4.png" alt="�Ի��Ŷ�" /></a>
            </li>
        	<li>
            	<a href="#" data-fixed=".section5"><img src="images/nav5.png" alt="�Ի���Ʒ" /></a>
            </li>
        	<li>
            	<a href="#" data-fixed=".section6"><img src="images/nav6.png" alt="�Ի��۵�" /></a>
            </li>
        	<li>
            	<a href="#" data-fixed=".section7"><img src="images/nav7.png" alt="�Ի�����" /></a>
            </li>
        	<li>
            	<a href="#" data-fixed=".section8"><img src="images/nav8.png" alt="��ϵ�Ի�" /></a>
            </li>
        </ul>
    </div>
</nav>
</div>
<!--��������-->

<!--����1����ʼ-->
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
                <h1><a href="Register.aspx">���߱���</a></h1>
            </div>
            <div class="content1Apply_m">
            	<h2><span>����ָ��</span></h2>
                <ul class="clearfix">
                	<li>
                    	<a href="#"><img src="images/btn1.gif" alt="����ָ��" /></a>
                    </li>
                	<li class="even">
                    	<a href="detail.aspx?ID=C4DDE71F-A08E-4B03-AEF1-A26B3315B478"><img src="images/btn2.gif" alt="��Ƶ����" /></a>
                    </li>
                	<li>
                    	<a href="#"><img src="images/btn3.gif" alt="�ҳ���ͨ" /></a>
                    </li>
                	<li class="even">
                    	<a href="#"><img src="images/btn4.gif" alt="�ٷ�΢��" /></a>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</div>
<!--����1������-->

<!--�����������ڶԻ�����ʼ-->
<section class="section1">
	<div class="aboutDWAD m">
    	<div class="aboutDWAD_t module_title clearfix">
        	<h1 class="fade-left animate3">���ڶԻ�</h1>
            <div class="line"></div>
        </div>
        <div class="aboutDWAD_m clearfix">
        	<div class="aboutDWAD_details lfloat">
            	<h2><%=(About["item1"] as Dictionary<String,object>)["TypeName"] %></h2>
                <%=(About["item1"] as Dictionary<String,object>)["Content"] %>
            </div>
            <div class="aboutDWAD_menu lfloat">
            	<h2>�Ի�����<sub>DWAD INTRODUCE</sub></h2>
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
<!--�����������ڶԻ�������-->

<!--���������Ի���Ѷ����ʼ-->
<section class="section2">
	<div class="informationDWAD m">
    	<div class="informationDWAD_t module_title clearfix">
        	<h1 class="fade-left animate3">�Ի���Ѷ</h1>
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
                            <h2>�Ի�����</h2>
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
                            <h2>�տ���Ѷ</h2>
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
<!--���������Ի���Ѷ������-->

<!--���������Ի��ɼ�����ʼ-->
<section class="section3">
	<div class="resultsDWAD m">
    	<div class="resultsDWAD_t module_title clearfix">
        	<h1 class="fade-left animate3">�Ի��ɼ�</h1>
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
                            <p class="ss"><a href="Detail.aspx?ID=<%=item["ID"] %>">�㶫��������</a></p>
                            <p class="s1"><a href="Detail.aspx?ID=<%=item["ID"] %>">ȫ����������</a></p>
                        </li>
                        <%} %>
                       
                    </ul>
                </div>
			</div>
        </div>
    </div>
</section>
<!--���������Ի��ɼ�������-->

<!--���������Ի��Ŷӡ���ʼ-->
<section class="section4">
	<div class="teamDWAD m">
    	<div class="teamDWAD_t module_title clearfix">
        	<h1 class="fade-left animate3">�Ի��Ŷ�</h1>
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
<!--���������Ի��Ŷӡ�����-->

<!--���������Ի���Ʒ����ʼ-->
<section class="section5">
	<div class="worksDWAD m">
    	<div class="worksDWAD_t module_title clearfix">
        	<h1 class="fade-left animate3">�Ի���Ʒ</h1>
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
<!--���������Ի���Ʒ������-->

<!--���������Ի��۵㡯��ʼ-->
<section class="section6">
	<div class="viewpointDWAD m">
    	<div class="viewpointDWAD_t module_title clearfix">
        	<h1 class="fade-left animate3">�Ի��۵�</h1>
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
<!--���������Ի��۵㡯����-->

<!--���������Ի����桯��ʼ-->
<section class="section7">
	<div class="publishedDWAD m">
    	<div class="publishedDWAD_t module_title clearfix">
        	<h1 class="fade-left animate3">�Ի�����</h1>
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
<!--���������Ի����桯����-->

<!--����������ϵ�Ի�����ʼ-->
<section class="section8">
	<div class="contactDWAD m">
    	<div class="contactDWAD_t module_title clearfix">
        	<h1 class="fade-left animate3">��ϵ�Ի�</h1>
            <div class="line"></div>
        </div>
        <div class="contactDWAD_m">
        	<div class="contactDWAD_details clearfix">
                <%=(Contact["item1"] as Dictionary<String,Object>)["Content"] %>
            </div>
              <div class="leave_msg">
            	<form method="post" runat="server">
                    <div class="leaveMsg_contact clearfix">
                        <input class="leave_name lfloat" type="text" name="UserName" id="UserName" placeholder="����"/>
                        <input class="leave_tel rfloat" type="text" name="ContactWay" id="ContactWay" placeholder="����"/>
                    </div>
                    <div class="leaveMsg_content">
                    	<div class="leaveContent_bg">
                        	<textarea name="Message" placeholder="��������" id="Message"></textarea>
                        </div>
                    </div>
                    <div class="send_box">
                        <button type="reset" class="res_btn">������д</button>
                            <asp:Button runat="server" Text="�ύ����"  CssClass="SubmitButton send_btn" ID="btnSubmit" ValidationGroup="vsErrorInfo" 
                onclick="btnSubmit_Click" OnClientClick="Validate()" />
                       <%-- <button type="submit" class="send_btn" id="send_btn" runat="server" onclick="Validate()">�ύ����</button>--%>
                    </div>
                </form>
            </div>
        </div>
    </div>
</section>
<!--����������ϵ�Ի�������-->
 
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
            alert('���ĵ����ʼ���ʽ����ȷ');
            return false;
        }
        if ($('#UserName').val() == '') {
            alert('��������Ϊ��')
            return false;
        }
        if ($('#Message').val() == '') {
            alert('���ݲ���Ϊ��')
            return false;
        }
        return true;
    }
</script>
</asp:Content>