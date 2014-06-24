<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="Duihua.WebApp.Register" %>
<%@ Import Namespace="System.Collections.Generic" %>

<!doctype html>
<html>
<head>
<meta charset="utf-8">
<meta name="renderer" content="webkit">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>在线注册</title>

<link rel="stylesheet" href="Styles/reset.css" />
<link rel="stylesheet" href="Styles/main.css" />
<link rel="stylesheet" href="Styles/animateCSS3.css" />

<style type="text/css">
.failureNotification
{
    font-size: 1.2em;
    color: Red;
    margin:5px;
    
}
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
	
	font-size:20px;
	padding:5px 5px;
	margin:5px 5px;
	border:1px solid gray;
	}
	.lfloat,.send_box
	{
	    clear:both;
	    }
	    .labelCss
	    {
	        margin:5px 5px;
	        width:150px;
	        display:inline-block;
	        }
	        textarea{
	border: 0 none;
    font-size: 20px;
    height: 200px;
    margin: 15px 0 10px 15px;
    resize: none;
    width: 400px;
}
.classTip
{
   border: 1px solid gray;
    font-size: 20px;
    display:block;
    margin-left:170px;
    resize: none;
    width: 400px;
   }
select
{
    margin-left:5px;
    font-size: 20px;   
    resize: none;
    width: 400px;
    }
    .fuAttachment{margin-left:5px;}
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
            	<a href="#" data-fixed='.section1' id="register"><font color="white">报名表</font></a>
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
<form method="post" runat="server" id="FRegisterInfo">
<section class="section1">
<div class="m">
<fieldset>
    <legend>基本信息</legend>
     <p>报名号为自动分配，注册完后凭报名号登陆查询注册结果。
     <br />
     <asp:LinkButton ID="lbCheckRegister" runat="server"  onclick="lbCheckRegister_Click" CommandName="check">查看之前的报名信息</asp:LinkButton>
     </p>
     <asp:ValidationSummary ID="ValidationSummary1" runat="server" ValidationGroup="vsErrorInfo"  CssClass="failureNotification" ></asp:ValidationSummary>
       <div class="lfloat" id="lblRegisterNo" runat="server" visible="False">
      <asp:Label AssociatedControlID="tbRegisterNo" runat="server" Text="报名号：" CssClass="labelCss"></asp:Label>
      <asp:TextBox ID="tbRegisterNo" name="RegisterNo" runat="server" CssClass="inputText" ReadOnly="true"></asp:TextBox>
      <asp:CustomValidator ID="cvRegisterNo" runat="server" ErrorMessage="报名号不能为空" 
               onservervalidate="cvRegisterNo_ServerValidate"></asp:CustomValidator>
      </div>

      <div class="lfloat">
      <asp:Label AssociatedControlID="tbRegistName" runat="server" Text="报名人：" CssClass="labelCss"></asp:Label>
      <asp:TextBox ID="tbRegistName" name="RegistName" runat="server" CssClass="inputText" ClientIDMode="Static"></asp:TextBox>
      <asp:RequiredFieldValidator  ControlToValidate="tbRegistName"  runat="server" ErrorMessage="报名人不能为空"  ValidationGroup="vsErrorInfo"  ToolTip="报名人不能为空"  CssClass="failureNotification">*</asp:RequiredFieldValidator>
       <asp:CustomValidator ID="cvRegistName" runat="server"  ControlToValidate="tbRegistName"
              ErrorMessage="CustomValidator" onservervalidate="cvRegistName_ServerValidate"  ValidationGroup="vsErrorInfo"></asp:CustomValidator>
      </div>
      
      <div  class="lfloat">
      <asp:Label AssociatedControlID="tbQQ" runat="server" Text="QQ：" CssClass="labelCss"></asp:Label>
      <asp:TextBox ID="tbQQ" name="QQ" runat="server" CssClass="inputText"></asp:TextBox>
      <asp:RequiredFieldValidator ID="RequiredFieldValidator1"  ControlToValidate="tbQQ"  runat="server" ErrorMessage="QQ不能为空" ValidationGroup="vsErrorInfo" ToolTip="QQ不能为空"  CssClass="failureNotification">*</asp:RequiredFieldValidator>
       <asp:RegularExpressionValidator  ControlToValidate="tbQQ"  ValidationExpression="[1-9][0-9]{5,9}"  runat="server" ErrorMessage="QQ不符合格式" ValidationGroup="vsErrorInfo"></asp:RegularExpressionValidator>
      
      </div>
      <div  class="lfloat">
      <asp:Label AssociatedControlID="tbEmail" runat="server" Text="Email：" CssClass="labelCss"></asp:Label>
      <asp:TextBox ID="tbEmail" name="Email" runat="server" CssClass="inputText"></asp:TextBox>
      <asp:RequiredFieldValidator ID="RequiredFieldValidator2"   ControlToValidate="tbEmail" runat="server" ErrorMessage="Email不能为空" ValidationGroup="vsErrorInfo" ToolTip="Email不能为空"  CssClass="failureNotification">*</asp:RequiredFieldValidator>
      <asp:RegularExpressionValidator  ControlToValidate="tbEmail" runat="server" ValidationExpression="\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ErrorMessage="Email不符合格式" ValidationGroup="vsErrorInfo"></asp:RegularExpressionValidator>
      </div>
       <div class="lfloat">
      <asp:Label AssociatedControlID="tbPhone" runat="server" Text="电话：" CssClass="labelCss"></asp:Label>
      <asp:TextBox ID="tbPhone" name="Phone" runat="server" CssClass="inputText"></asp:TextBox>
      <asp:RequiredFieldValidator ControlToValidate="tbPhone"  runat="server" ErrorMessage="电话不能为空" ValidationGroup="vsErrorInfo"  ToolTip="电话不能为空"  CssClass="failureNotification">*</asp:RequiredFieldValidator>
   <%--   <asp:RegularExpressionValidator ControlToValidate="tbPhone" ValidationExpression="(d+-)?(d{4}-?d{7}|d{3}-?d{8}|^d{7,8})(-d+)?" runat="server" ErrorMessage="电话不符合格式" ValidationGroup="vsErrorInfo"></asp:RegularExpressionValidator>--%>
      </div>
      
      <div class="lfloat">
      <asp:Label AssociatedControlID="tbAddress" runat="server" Text="地址：" CssClass="labelCss"></asp:Label>
      <asp:TextBox ID="tbAddress" name="Address" runat="server" CssClass="inputText" TextMode="MultiLine"></asp:TextBox>
      <asp:CustomValidator ID="cvAddress" runat="server"  ControlToValidate="tbAddress"
              ErrorMessage="地址不能超过500个字符" ValidationGroup="vsErrorInfo"></asp:CustomValidator>
      </div>
      <div class="lfloat">
      <asp:Label ID="Label1" AssociatedControlID="tbIntro" runat="server" Text="个人简介：" CssClass="labelCss"></asp:Label>
      <asp:TextBox ID="tbIntro" name="Intro" runat="server" CssClass="inputText" TextMode="MultiLine"></asp:TextBox>
      </div>
      
      <div class="lfloat">
      <asp:Label AssociatedControlID="ddClassID" runat="server" Text="所选班级：" CssClass="labelCss"></asp:Label>
     <asp:DropDownList ID="ddClassID" name="ClassID" runat="server" AutoPostBack="true" AppendDataBoundItems="true" 
     DataSourceID="SqlDataSource1" DataTextField="ClassName" DataValueField="ID" 
              onselectedindexchanged="ddClassID_SelectedIndexChanged">
        <asp:ListItem Text="--请选报名的班级--"></asp:ListItem>
     </asp:DropDownList>
     <asp:RequiredFieldValidator ControlToValidate="ddClassID" runat="server" ErrorMessage="班级不能为空" ToolTip="班级不能为空"  CssClass="failureNotification" ValidationGroup="vsErrorInfo">*</asp:RequiredFieldValidator>
     <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
              ConnectionString="<%$ ConnectionStrings:DuihuaDB %>" 
              SelectCommand="SELECT [Intro], [ClassName], [Year], [EndTime], [IsFinish], [StartTime], [ID] FROM [ClassInfo] WHERE ([IsFinish] = @IsFinish)">
         <SelectParameters>
             <asp:Parameter DefaultValue="0" Name="IsFinish" Type="Int32" />
         </SelectParameters>
          </asp:SqlDataSource>
     <asp:Label ID="lbClassInfo" runat="server" CssClass="classTip" ></asp:Label>               
      </div>
      <div class="lfloat">
      <asp:Label  AssociatedControlID="fuAttachment" runat="server" Text="附件/作品：" CssClass="labelCss"></asp:Label>
      <asp:FileUpload ID="fuAttachment" runat="server" CssClass="fuAttachment"></asp:FileUpload>
      </div>
       <br />
       <div class="lfloat">
      <asp:Label   AssociatedControlID="tbValidateCode" runat="server" Text="验证码：" CssClass="labelCss"></asp:Label>
        <asp:TextBox ID="tbValidateCode" name="ValidateCode" runat="server" CssClass="inputText"></asp:TextBox>
        <asp:Image ImageAlign="Middle" ID="imgValidator" ToolTip="点击更新验证码"  runat="server" ImageUrl="~/ImageValidator.aspx?len=4&type=1"/>
        <asp:CustomValidator ID="CustomValidator1" ControlToValidate="tbValidateCode"  ValidationGroup="vsErrorInfo"
               runat="server" ErrorMessage="验证码不正确" ToolTip="验证码不正确"  CssClass="failureNotification" 
               onservervalidate="CustomValidator1_ServerValidate"></asp:CustomValidator>
      </div>
      <br />
    <div class="send_box">
            <button type="reset" class="res_btn">重置</button>
            <asp:Button runat="server" Text="提交"  CssClass="SubmitButton send_btn" ID="btnSubmit" ValidationGroup="vsErrorInfo" 
                onclick="btnSubmit_Click" />
            
    </div>
</fieldset>
</div>
</section>

<footer class="footer"></footer>

<asp:SqlDataSource ID="dsRegister" runat="server" 
    ConnectionString="<%$ ConnectionStrings:DuihuaDB %>" 
    InsertCommand="INSERT INTO RegisterInfo(ID, RegistName, QQ, Email, Phone, Intro, Address, Status, CreateTime, RegisterNo, ClassID) VALUES (
newid(), @RegistName, @QQ, @Email, @Phone, @Intro, @Address, 0, getdate(), @RegisterNo, @ClassID)"
    SelectCommand="SELECT ID, QQ, RegistName, Email, Status, Address, CreateTime, RegisterNo, ClassID, Intro, Phone FROM RegisterInfo
where RegisterNo = @RegisterNo" 
    UpdateCommand="UPDATE RegisterInfo SET RegistName =@RegistName , QQ =@QQ , Email =@Email , Phone =@Phone , Intro =@Intro , Address =@Address ,  CreateTime =@CreateTime , RegisterNo =@RegisterNo , ClassID =@ClassID  WHERE RegisterNo = @RegisterNo">
    <InsertParameters>
        <asp:ControlParameter ControlID="tbRegistName" Name="RegistName" />
        <asp:ControlParameter ControlID="tbQQ" Name="QQ" />
        <asp:ControlParameter ControlID="tbEmail" Name="Email" />
        <asp:ControlParameter ControlID="tbPhone" Name="Phone" />
        <asp:ControlParameter ControlID="tbIntro" Name="Intro" />
        <asp:ControlParameter ControlID="tbAddress" Name="Address" />
        <asp:ControlParameter ControlID="tbRegisterNo" Name="RegisterNo" PropertyName="Text"/>
        <asp:ControlParameter ControlID="ddClassID" Name="ClassID" PropertyName="SelectedValue" />
    </InsertParameters>
    <SelectParameters>
        <asp:ControlParameter ControlID="tbRegisterNo" Name="RegisterNo" 
            PropertyName="Text" />
    </SelectParameters>
    <UpdateParameters>
        <asp:ControlParameter ControlID="tbRegistName" Name="RegistName" />
        <asp:ControlParameter ControlID="tbQQ" Name="QQ" />
        <asp:ControlParameter ControlID="tbEmail" Name="Email" />
        <asp:ControlParameter ControlID="tbPhone" Name="Phone" />
        <asp:ControlParameter ControlID="tbIntro" Name="Intro" />
        <asp:ControlParameter ControlID="tbAddress" Name="Address" />
        <asp:ControlParameter ControlID="tbRegisterNo" Name="RegisterNo" PropertyName="Text"/>
        <asp:ControlParameter ControlID="ddClassID" Name="ClassID"  PropertyName="SelectedValue" />
    </UpdateParameters>
</asp:SqlDataSource>
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
        <a class="leave" href="#tbRegistName">&nbsp;</a>
    </div>
</div>


<script type="text/javascript" src="Scripts/jquery-1.9.1.min.js"></script><!--库-->
<script type="text/javascript" src="Scripts/jquery.easing.1.3.js"></script><!--动画效果-->
<script type="text/javascript" src="Scripts/jquery-wen_play.js"></script><!--轮播插件-->
<script type="text/javascript" src="Scripts/main.js"></script><!--页面事件-->
<script type="text/javascript" >
    $(document).ready(function () {
        $('#register').click();
        $('#<%=imgValidator.ClientID %>').click(function () {
            document.getElementById('<%=imgValidator.ClientID %>').src = "ImageValidator.aspx?len=4&type=1&r" + Math.random();
        });
    });
</script>
</body>
</html>
