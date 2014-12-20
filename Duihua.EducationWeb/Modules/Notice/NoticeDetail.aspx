<%@ Page Title="" Language="C#" MasterPageFile="~/Layout/AdminDefault.Master" AutoEventWireup="true" CodeBehind="NoticeDetail.aspx.cs" Inherits="Duihua.EducationWeb.Modules.Notice.NoticeDetail" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="blog-post" runat="server" id="noticeDiv">
        <h3 class="blog-post-title">
            <asp:Label ID="eTitle" runat="server" name="Title"></asp:Label>
        </h3>
        <p class="blog-post-meta">
            发表于<asp:Label ID="eCreateTime" runat="server" name="CreateTime"></asp:Label>
            
            <span class="badge">
                <asp:Label ID="eUserName" runat="server" name="UserName"></asp:Label>
            </span>
        </p>
        <p>
            <asp:Label ID="eContent" runat="server" name="Content"></asp:Label>
        </p>
    </div>
</asp:Content>
