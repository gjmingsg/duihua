﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Layout/AdminDefault.Master" AutoEventWireup="true" CodeBehind="UserList.aspx.cs" Inherits="Duihua.EducationWeb.Modules.Account.UserList" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="block"> 
			<div class="fl"> 
				<button id="AddUser">新增用户</button>
			</div>
		<%--	<div class="fr" id="search"> 
			<input type="text" id="txtSearch" />
			<input type="button" id="btnSearch" value="搜索" />
			</div>
			<div class="clear"></div>--%>
		</div><!--end: block -->
		
    <asp:GridView ID="gvUserList" runat="server" DataSourceID="dbdUserList" CssClass="table" AutoGenerateColumns="false">
    <Columns>
    <asp:BoundField DataField="UserName" HeaderText="账号" />
    <asp:BoundField DataField="Email" HeaderText="邮箱" />
    <asp:BoundField DataField="CreationDate" HeaderText="创建时间" />
    <asp:BoundField DataField="LastLoginDate" HeaderText="上次登录时间" />
    <asp:TemplateField HeaderStyle-Width="100">
        <HeaderTemplate>操作</HeaderTemplate>
        <ItemTemplate>
               <%-- <a class="fl btn1" href="#">查看</a>
				<a class="fl btn2" href="/Admin/Account/ChangePassword.aspx">修改密码</a>--%>
				<asp:LinkButton ID="lbDeleteUser" CssClass="fl btn3" _username='<%#Eval("UserName") %>'  OnClick="lbOperator_Click"  OnClientClick="return confirm('确定删除该用户？')" runat="server" Text="删除"></asp:LinkButton>
        </ItemTemplate>
    </asp:TemplateField>
    </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="dbdUserList" runat="server"
     DataObjectTypeName="System.Web.Security.MembershipUser"
     TypeName="System.Web.Security.Membership"
     SelectMethod="GetAllUsers"
    >
    
     </asp:ObjectDataSource>

     <script type="text/javascript">
         $(function () {
             $('#AddUser').click(function () {
                 window.location = "/Modules/Account/Register.aspx";
             });
         })
     </script>
</asp:Content>