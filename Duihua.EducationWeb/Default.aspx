<%@ Page Title="主页" Language="C#" MasterPageFile="~/Layout/Site.master" AutoEventWireup="true"
    CodeBehind="Default.aspx.cs" Inherits="Duihua.EducationWeb._Default" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
<style type="text/css">
.carousel {
height: 460px;
}
body {
font-family: ff-tisa-web-pro-1,ff-tisa-web-pro-2,"Lucida Grande","Helvetica Neue",Helvetica,Arial,"Hiragino Sans GB","Hiragino Sans GB W3","WenQuanYi Micro Hei",sans-serif;
}
.carousel .item {
height: 460px;
background-color: #777;
}
.carousel .masthead-bg {
position: absolute;
top: 0;
left: 0;
min-width: 100%;
height: 460px;
text-shadow: 0 1px 3px rgba(0,0,0,.4),0 0 30px rgba(0,0,0,.075);
background-repeat: repeat-x;
background-image: -webkit-linear-gradient(45deg,#CC9900,#f26522);
background-image: -o-linear-gradient(45deg,#CC9900,#f26522);
background-image: linear-gradient(45deg,#CC9900,#f26522);
}
.carousel-caption {
z-index: 10;
bottom: 40px;
left: 15%;
right: 15%;
}
.masthead .bs2-link {
color: #fff;
color: rgba(255,255,255,.5);
-webkit-transition: all .2s ease-in-out;
-moz-transition: all .2s ease-in-out;
transition: all .2s ease-in-out;
}
@media screen and (min-width: 992px)
.masthead h1 {
font-size: 100px;
}
@media screen and (min-width: 768px)
.masthead h1 {
font-size: 90px;
}
.masthead h1 {
font-size: 60px;
line-height: 1;
letter-spacing: -2px;
font-weight: 700;
}
h1, .h1, h2, .h2, h3, .h3, h4, .h4, .lead {
font-family: ff-tisa-web-pro-1,ff-tisa-web-pro-2,"Lucida Grande","Helvetica Neue",Helvetica,Arial,"Hiragino Sans GB","Hiragino Sans GB W3","Microsoft YaHei UI","Microsoft YaHei","WenQuanYi Micro Hei",sans-serif;
}
.bc-social {
padding: 15px 0;
text-align: center;
background-color: #f5f5f5;
border-top: 1px solid #fff;
border-bottom: 1px solid #ddd;
}
.bc-social-buttons {
margin-left: 0;
margin-bottom: 0;
padding-left: 0;
list-style: none;
}
.bc-social-buttons li {
display: inline-block;
padding: 5px 8px;
line-height: 1;
font-size: 16px;
}
</style>
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    
    <div id="myCarousel" class="carousel slide">
      <div class="carousel-inner">
        <div class="item active masthead">
          <div class="masthead-bg"></div>
          <div class="container">
            <div class="carousel-caption">
              <h1>对画艺术教育</h1>
              <h2>欢迎使用对画学生档案管理系统!</h2>
              <p>
                <a class="btn btn-lg btn-primary btn-shadow bs3-link" href="/login.aspx" role="button">登&nbsp;录&nbsp;系&nbsp;统</a>
              </p>

                <a class="bs2-link" href="http://dwad.com.cn" target="_blank" role="button">画艺术教育官网</a>

            </div>
          </div>
        </div>
      </div>
    </div>

    <div class="bc-social">
    <div class="container">
      <ul class="bc-social-buttons">
        <li>
          <span class="label label-success">对画艺术教育官方QQ:</span>2197064910 
        </li>
        <li>
          <a href="http://weibo.com/dwad" title="对画艺术教育官方微博" target="_blank"><img src="/images/weibo.png" style="height: 30px;" alt="对画艺术教育官方微博"></a>
        </li>
      </ul>
    </div>
  </div>

</asp:Content>
