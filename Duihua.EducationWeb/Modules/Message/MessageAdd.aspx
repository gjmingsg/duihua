<%@ Page Title="" Language="C#" MasterPageFile="~/Layout/AdminDefault.Master"  ValidateRequest="false" 
AutoEventWireup="true" CodeBehind="MessageAdd.aspx.cs" Inherits="Duihua.EducationWeb.Modules.Message.MessageAdd" %>
<%@ Register Src="~/Modules/Common/MessageEdit.ascx" TagName="msg" TagPrefix="uc" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <uc:msg runat="server" id="msg" EditTitle="添加留言" IsShowTitle="true"></uc:msg>
</asp:Content>
