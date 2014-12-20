<%@ Page Title="" Language="C#" MasterPageFile="~/Layout/AdminDefault.Master" AutoEventWireup="true" ValidateRequest="false"
CodeBehind="MessageDetail.aspx.cs" Inherits="Duihua.EducationWeb.Modules.Message.MessageDetail" %>
<%@ Register Src="~/Modules/Common/MessageEdit.ascx" TagName="msg" TagPrefix="uc" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="blog-post" runat="server" id="msgDiv">
        <h3 class="blog-post-title">
            <asp:Label ID="eTitle" runat="server" name="Title"></asp:Label>
        </h3>
        <p class="blog-post-meta">
            <span class="badge">
                <asp:Label ID="eUserName" runat="server" name="UserName"></asp:Label>
            </span>
            在
            <asp:Label ID="eCreateTime" runat="server" name="CreateTime" CssClass="label label-danger"></asp:Label>
            给你的留言
        </p>
        <blockquote>
        <p>
            <asp:Label ID="eContent" runat="server" name="Content"></asp:Label>
        </p>
        </blockquote>
        <hr />
        <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource1">
        <ItemTemplate>
            <div style="padding:15px;border-color: #ddd;border-width: 1px;">
                <p class="blog-post-meta">
                    <span class="badge">
                       <%#Eval("CreatorName")%>
                    </span>
                    在
                     <span class="label label-danger">
                        <%#Eval("CreateTime")%>
                     </span>
                    回复道：
                </p>
           
                <p>
                    <%#Eval("Content") %>
                </p>
                <asp:Button ID="btnReply" CssClass="btn btn-primary" runat="server" Text="回复" OnClick="btnReply_Click" _id='<%#Eval("Creator") %>' />
            </div>
        </ItemTemplate>
        </asp:Repeater>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DuihuaDB %>"
         SelectCommand="SELECT cm.*,au.UserName CreatorName,au2.UserName [ReceivorName] FROM ComMessage cm
                        INNER JOIN aspnet_Users au ON au.UserId = cm.Creator
                        INNER JOIN aspnet_Users au2 ON au2.UserId = cm.[Receive]
                         WHERE cm.RefMessageId =@MessageId ORDER BY cm.CreateTime ASC">
    <SelectParameters>
        <asp:QueryStringParameter Name="MessageId" QueryStringField="MessageId" />
    </SelectParameters>
 </asp:SqlDataSource>
    </div>
    <hr />
    <div>
        <uc:msg runat="server" id="msg" EditTitle="回复留言" Visible="false"></uc:msg>
    </div>
</asp:Content>
