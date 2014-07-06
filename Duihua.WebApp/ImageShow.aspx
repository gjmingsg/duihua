<%@ page Title="" Language="C#" MasterpageFile="~/admin/Font.Master" autoEventWireup="true" CodeBehind="ImageShow.aspx.cs" Inherits="Duihua.WebApp.ImageShow" %>
<asp:Content ID="Content1" ContentplaceHolderID="head" runat="server">
<style type='text/css' media='print'>
    .secondaryHeader {
	DISpLaY: none !important
}
.eControl {
	BORDER-TOp: #000 1px solid; BORDER-RIGHT: #000 1px solid; WIDTH: 300px; BORDER-BOTTOM: #000 1px solid; BORDER-LEFT: #000 1px solid; DISpLaY: none !important
}
#efpTxt .others {
	DISpLaY: none !important
}
#efppicList {
	DISpLaY: none !important
}
.footer {
	DISpLaY: none !important
}
#efpClew {
	DISpLaY: none !important
}
#CommFormBottomBox {
	DISpLaY: none !important
}
#efpLeftarea {
	DISpLaY: none !important
}
#efpRightarea {
	DISpLaY: none !important
}
.eTitle h1 {
	MaRGIN: 0px
}
</style>
<link href="/Styles/album.css" rel='stylesheet' type='text/css'  />

    <script src="/scripts/sinaflash.js" type="text/javascript"></script>
    <script src="/scripts/heiphoto.js" type="text/javascript"></script>
</asp:Content>

<asp:Content ID="Content2" ContentplaceHolderID="ContentplaceHolder1" runat="server">

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
 

<DIV id=wrap>
<DIV class=pic><!-- /place --><!--相册代码开始-->
<DIV class=eTitle>
<H1><SPAN id=txtTitle><%=ArticleTitle %></SPAN><SPAN id=total>(<SPAN class=cC00>0</SPAN>/0)</SPAN></H1></DIV>
<DIV class=eControl>
<DIV class=ecCont>
<DIV id=ecbSpeed>
<DIV id=ecbSpeedInfo class=buttonCont>5秒</DIV></DIV>
<DIV id=ecbPre title=上一张>上一张 
<DIV class=1buttonCont></DIV></DIV>
<DIV id=ecbPlay>
<DIV id=ecpPlayStatus class=play></DIV></DIV>
<DIV id=ecbNext title=下一张>
<DIV class=buttonCont></DIV></DIV>
<DIV id=ecbLine>
<DIV class=buttonCont></DIV></DIV>
<DIV id=ecbMode title=列表模式(tab)>
<DIV class=buttonCont></DIV></DIV>
<DIV id=ecbModeReturn title=返回幻灯模式(tab)>
<DIV class=buttonCont></DIV></DIV>
<DIV id=ecbFullScreen title=全屏浏览>
<DIV id=fullScreenFlash class=buttonCont></DIV></DIV><!-- 速度条 begin -->
<DIV id=SpeedBox>
<DIV id=SpeedCont>
<DIV id=SpeedSlide></DIV>
<DIV id=SpeedNonius></DIV></DIV></DIV><!-- 速度条 end --></DIV></DIV>
<DIV id=eFramePic>
<DIV id=efpBigPic>
<DIV id=efpClew></DIV>
<DIV id=d_BigPic></DIV>
<DIV id=efpLeftArea title=上一张 class=arrLeft></DIV>
<DIV id=efpRightArea title=下一张 class=arrRight></DIV>
<DIV id=endSelect>
<DIV id=endSelClose></DIV>
<DIV class=bg></DIV>
<DIV class=E_Cont>
<P>您已经浏览完所有图片<BR><BR><A id=rePlayBut href="javascript:void(0)"></A><A 
id=nextPicsBut href="javascript:void(0)"></A></P></DIV></DIV><!-- endSelect end --></DIV>
<DIV id=efpTxt>
 </DIV>
<DIV id=efpTxt style="DISPLAY: none">
<H2 id=d_picTit></H2>
<DIV id=d_picTime></DIV>
<DIV id=d_picIntro></DIV></DIV>
<DIV id=efpContent>
<DIV class=jianjietuji></DIV>
<DIV style="CLEAR: both"></DIV></DIV>
<DIV id=efpPicList>
<DIV id=efpPreGroup>
<DIV onmouseover="this.className='selected'" onmouseout="this.className=''" id=efpPrePic style=" display:none"></DIV>
</DIV>
<DIV onmouseover="this.className='selected'" onmouseout="this.className=''" id=efpListLeftArr></DIV>
<DIV id=efpPicListCont></DIV>
<DIV onmouseover="this.className='selected'" onmouseout="this.className=''" id=efpListRightArr></DIV>
<DIV id=efpNextGroup>
<DIV onmouseover="this.className='selected'" onmouseout="this.className=''" id=efpNextPic  style=" display:none"></DIV>
</DIV></DIV></DIV>
<DIV id=ePicList></DIV>
 
 
 
 <div id="picartList" style="display:none">
    <%=ArticleContent%>
</div>

 
 
<script language='javascript' type='text/javascript'>
   
          <!--    //--><![CDaTa[//><!--
    var dataInfo = {
        title: "<%=ArticleTitle %>"
    };
    function echoFocus() {
        var flashpic = "", flashTxt = "";
        var newHref;
        var datas =document.getElementById('picartList').getElementsByTagName('p');
        for (var i = 0; i < datas.length; i++) {
            //try{
            var title, pic, middlepic, smallpic, datetime, intro, commUrl;
            title = datas[i].getElementsByTagName('img').alt;
            if (title) {
            
            } else {
                title = 'null';
            };
            var info = datas[i].getElementsByTagName('img');
            if (info) {
                pic = jQuery(info).attr('src');
                middlepic = pic.replace('attachment/img/', 'attachment/img/min/');
                smallpic = middlepic;
                datetime = new Date().toLocaleString();
                intro = title;
                imageId = i+1;
                commUrl = '';
            };
            epidiascope.add({
                src: pic,
                lowsrc_b: middlepic,
                lowsrc_s: smallpic,
                date: datetime,
                title: title,
                text: intro,
                comment: commUrl,
                id: imageId
            });
            if (flashpic != "") { flashpic += "|" };
            flashpic += encodeURIComponent(pic);

            if (flashTxt != "") { flashTxt += "|" };
            flashTxt += encodeURIComponent(title) + "#" + encodeURIComponent(intro.replace(/<.*?>/g, ''));
            //}catch(e){}
        };
        epidiascope.autoplay = false;
        epidiascope.init();
        fullFlash(flashTxt, flashpic);

        if (Math.random() <= 0.01) {
            epidiascope.stop();
        };
    };
    function fullFlash(txt, pic) {
        var flashurl = "/attachment/photo.swf";
        var fullScreen = new sinaFlash(flashurl, "fullScreenObj", "100%", "100%", "8", "#000000");
        fullScreen.addparam("quality", "best");
        fullScreen.addparam("wmode", "transparent");
        fullScreen.addparam("allowFullScreen", "true");
        fullScreen.addparam("allowscriptaccess", "always");
        fullScreen.addVariable("mylinkpic", pic);
        fullScreen.addVariable("infotxt", dataInfo.title);
        fullScreen.addVariable("mytxt", txt);
        fullScreen.addVariable("fulls_btnx", "0");
        fullScreen.addVariable("fulls_btny", "0");
        fullScreen.addVariable("fulls_btnalpha", "0")
        fullScreen.write("fullScreenFlash");
    };
    function flash_to_js(name) {
        name = new String(name);
        var status = name.split("|");
        epidiascope.speedBar.setGrade(status[1]);
        epidiascope.select(parseInt(status[0]));
    };
    function js_to_flash() {
        epidiascope.stop();
        return epidiascope.selectedIndex + "|" + epidiascope.speedBar.grade;
    };
    var sendT = {
        getHeader: function () {
            return document.getElementById("txtTitle").innerHTML + '-' + document.getElementById("d_picTit").innerHTML;
        },
        getFirstImgSrc: function () {
            if (document.getElementById("d_Bigpic").getElementsByTagName("img")[0]) {
                return document.getElementById("d_Bigpic").getElementsByTagName("img")[0].src;
            } else {
                return null;
            }
        }
    }

    echoFocus();
    //--><!]]>
          </script>

<div style="CLEaR: both"></div></div></div>
</asp:Content>
