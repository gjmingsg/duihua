<%@ Page Language="C#"  MasterPageFile="~/Admin/Font.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="Duihua.WebApp.Register" %>
<%@ Import Namespace="System.Collections.Generic" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
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
	overflow:auto;
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
	        vertical-align:text-top;
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
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


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
    <legend>报名信息</legend>
     
    <p>
     <asp:LinkButton ID="lbCheckRegister" runat="server"  onclick="lbCheckRegister_Click" CommandName="check">查看之前的报名信息</asp:LinkButton>
     </p>
     <asp:ValidationSummary ID="ValidationSummary1" runat="server" ValidationGroup="vsErrorInfo"  CssClass="failureNotification" ></asp:ValidationSummary>
       <div class="lfloat" id="lblRegisterNo" runat="server" visible="False">
      <asp:Label ID="Label1" AssociatedControlID="tbRegisterNo" runat="server" Text="报名号：" CssClass="labelCss"></asp:Label>
      <asp:TextBox ID="tbRegisterNo" name="RegisterNo" runat="server" CssClass="inputText" ReadOnly="true"></asp:TextBox>
      <asp:CustomValidator ID="cvRegisterNo" runat="server" ErrorMessage="报名号不能为空" 
               onservervalidate="cvRegisterNo_ServerValidate"></asp:CustomValidator>
      </div>

      <div class="lfloat">
      <asp:Label ID="Label2" AssociatedControlID="tbRegistName" runat="server" Text="姓名：" CssClass="labelCss"></asp:Label>
      <asp:TextBox ID="tbRegistName" name="RegistName" runat="server" CssClass="inputText" ClientIDMode="Static"></asp:TextBox>
      <asp:RequiredFieldValidator ID="RequiredFieldValidator1"  ControlToValidate="tbRegistName"  runat="server" ErrorMessage="姓名不能为空"  ValidationGroup="vsErrorInfo"  ToolTip="姓名不能为空"  CssClass="failureNotification">*</asp:RequiredFieldValidator>
       <asp:CustomValidator ID="cvRegistName" runat="server"  ControlToValidate="tbRegistName"
              ErrorMessage="CustomValidator" onservervalidate="cvRegistName_ServerValidate"  ValidationGroup="vsErrorInfo"></asp:CustomValidator>
      </div>
      
      <div  class="lfloat">
      <asp:Label ID="Label3" AssociatedControlID="tbQQ" runat="server" Text="QQ：" CssClass="labelCss"></asp:Label>
      <asp:TextBox ID="tbQQ" name="QQ" runat="server" CssClass="inputText"></asp:TextBox>
      <asp:RequiredFieldValidator ID="RequiredFieldValidator2"  ControlToValidate="tbQQ"  runat="server" ErrorMessage="QQ不能为空" ValidationGroup="vsErrorInfo" ToolTip="QQ不能为空"  CssClass="failureNotification">*</asp:RequiredFieldValidator>
       <asp:RegularExpressionValidator ID="RegularExpressionValidator1"  ControlToValidate="tbQQ"  ValidationExpression="[1-9][0-9]{5,9}"  runat="server" ErrorMessage="QQ不符合格式" ValidationGroup="vsErrorInfo"></asp:RegularExpressionValidator>
      </div>
      
      <div  class="lfloat">
      <asp:Label ID="Label4" AssociatedControlID="tbEmail" runat="server" Text="Email：" CssClass="labelCss"></asp:Label>
      <asp:TextBox ID="tbEmail" name="Email" runat="server" CssClass="inputText"></asp:TextBox>
      <asp:RequiredFieldValidator ID="RequiredFieldValidator3"   ControlToValidate="tbEmail" runat="server" ErrorMessage="Email不能为空" ValidationGroup="vsErrorInfo" ToolTip="Email不能为空"  CssClass="failureNotification">*</asp:RequiredFieldValidator>
      <asp:RegularExpressionValidator ID="RegularExpressionValidator2"  ControlToValidate="tbEmail" runat="server" ValidationExpression="\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ErrorMessage="Email不符合格式" ValidationGroup="vsErrorInfo"></asp:RegularExpressionValidator>
      </div>
       
      <div class="lfloat">
      <asp:Label ID="Label5" AssociatedControlID="tbPhone" runat="server" Text="电话：" CssClass="labelCss"></asp:Label>
      <asp:TextBox ID="tbPhone" name="Phone" runat="server" CssClass="inputText"></asp:TextBox>
      <asp:RequiredFieldValidator ID="RequiredFieldValidator4" ControlToValidate="tbPhone"  runat="server" ErrorMessage="电话不能为空" ValidationGroup="vsErrorInfo"  ToolTip="电话不能为空"  CssClass="failureNotification">*</asp:RequiredFieldValidator>
      </div>
    
     <div class="lfloat">
         <asp:Label ID="Label7"   AssociatedControlID="tbIntro" runat="server" Text="就读高中：" CssClass="labelCss"></asp:Label>
         <asp:TextBox runat="server" ID="tbIntro" name="Intro"  CssClass="inputText"></asp:TextBox>
        </div>

       <div class="lfloat">
      <asp:Label ID="Label6" AssociatedControlID="ddClassID" runat="server" Text="所选班级：" CssClass="labelCss"></asp:Label>
     <asp:DropDownList ID="ddClassID" name="ClassID" runat="server" AutoPostBack="true" AppendDataBoundItems="true" 
     DataSourceID="SqlDataSource1" DataTextField="ClassName" DataValueField="ID" 
              onselectedindexchanged="ddClassID_SelectedIndexChanged">
        <asp:ListItem Text="--请选报名的班级--" Value=""></asp:ListItem>
     </asp:DropDownList>
     <asp:RequiredFieldValidator ID="RequiredFieldValidator5" ControlToValidate="ddClassID" runat="server" ErrorMessage="班级不能为空" ToolTip="班级不能为空"  CssClass="failureNotification" ValidationGroup="vsErrorInfo">*</asp:RequiredFieldValidator>
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
         <asp:Label   AssociatedControlID="tbAddress" runat="server" Text="地址：" CssClass="labelCss"></asp:Label>
         <asp:TextBox runat="server" ID="tbAddress" name="Address" Rows="10" TextMode="MultiLine" CssClass="inputText"></asp:TextBox>
        </div>
       
       <div class="lfloat">
        <asp:Label ID="Label8"   AssociatedControlID="tbValidateCode" runat="server" Text="验证码：" CssClass="labelCss"></asp:Label>
        <asp:TextBox ID="tbValidateCode" name="ValidateCode" runat="server" CssClass="inputText"></asp:TextBox>
        <asp:Image ImageAlign="Middle" ID="imgValidator" ToolTip="点击更新验证码"  runat="server" ImageUrl="~/ImageValidator.aspx?len=4&type=1"/>
        <asp:CustomValidator ID="CustomValidator1" ControlToValidate="tbValidateCode"  ValidationGroup="vsErrorInfo"
               runat="server" ErrorMessage="验证码不正确" ToolTip="验证码不正确"  CssClass="failureNotification" 
               onservervalidate="CustomValidator1_ServerValidate"></asp:CustomValidator>
      </div>
       
      <div class="send_box">
            <button type="reset" class="res_btn">重置</button>
            <asp:Button runat="server" Text="提交"  CssClass="SubmitButton send_btn" ID="btnSubmit" ValidationGroup="vsErrorInfo" 
                onclick="btnSubmit_Click" />
            
    </div>
</fieldset>
</div>
</section>
 

<asp:SqlDataSource ID="dsRegister" runat="server" 
    ConnectionString="<%$ ConnectionStrings:DuihuaDB %>" 
    InsertCommand="INSERT INTO RegisterInfo(ID, RegistName, QQ, Email, Phone
    , Intro, Address
    , Status, CreateTime
    , RegisterNo, ClassID) VALUES (
newid(), @RegistName, @QQ, @Email, @Phone
, @Intro
, @Address
, 0, getdate(), @RegisterNo, @ClassID)"
    SelectCommand="SELECT ID, QQ, RegistName, Email, Status, Address, CreateTime, RegisterNo, ClassID, Intro, Phone FROM RegisterInfo
where RegisterNo = @RegisterNo" 
    UpdateCommand="UPDATE RegisterInfo SET RegistName =@RegistName , QQ =@QQ 
    , Email =@Email , Phone =@Phone
   , Intro =@Intro 
   , Address =@Address 
     ,  CreateTime =@CreateTime , RegisterNo =@RegisterNo
      , ClassID =@ClassID  
      WHERE RegisterNo = @RegisterNo">
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
        <%--<asp:ControlParameter ControlID="tbIntro" Name="Intro" />--%>
       <asp:ControlParameter ControlID="tbAddress" Name="Address" />
        <asp:ControlParameter ControlID="tbRegisterNo" Name="RegisterNo" PropertyName="Text"/>
        <asp:ControlParameter ControlID="ddClassID" Name="ClassID"  PropertyName="SelectedValue" />
    </UpdateParameters>
</asp:SqlDataSource>
 

 </form>
<script type="text/javascript" >
    $(document).ready(function () {
        $('#register').click();
        $('#<%=imgValidator.ClientID %>').click(function () {
            document.getElementById('<%=imgValidator.ClientID %>').src = "ImageValidator.aspx?len=4&type=1&r" + Math.random();
        });
    });
</script>
 
</asp:Content>


 