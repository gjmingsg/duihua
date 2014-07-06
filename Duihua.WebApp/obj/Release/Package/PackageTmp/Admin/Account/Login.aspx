<%@ Page Title="登录" Language="C#" MasterPageFile="~/Admin/Site.master" AutoEventWireup="true"
    CodeBehind="Login.aspx.cs" Inherits="Duihua.WebApp.Admin.Account.Login" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
<script type="text/javascript" >
    $(document).ready(function () {
        $('#register').click();
        $('#imgValidator').click(function () {
           $(this).attr('src', "../../ImageValidator.aspx?len=4&type=1&r" + Math.random());
        });
    });
</script>
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <h2>
        登录
    </h2>
    <p>
        请输入用户名和密码。
        <asp:HyperLink ID="RegisterHyperLink" runat="server" EnableViewState="false" Visible="false">注册</asp:HyperLink> <%--如果您没有帐户。--%>
    </p>
    <asp:Login ID="LoginUser" runat="server" EnableViewState="false" RenderOuterTable="false">
        <LayoutTemplate>
            <span class="failureNotification">
                <asp:Literal ID="FailureText" runat="server"></asp:Literal>
            </span>
            <asp:ValidationSummary ID="LoginUserValidationSummary" runat="server" CssClass="failureNotification" 
                 ValidationGroup="LoginUserValidationGroup"/>
            <div class="accountInfo">
                <fieldset class="login">
                    <legend>帐户信息</legend>
                    <p>
                        <asp:Label ID="UserNameLabel" runat="server" AssociatedControlID="UserName">用户名:</asp:Label>
                        <asp:TextBox ID="UserName" runat="server" CssClass="textEntry"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" ControlToValidate="UserName" 
                             CssClass="failureNotification" ErrorMessage="必须填写“用户名”。" ToolTip="必须填写“用户名”。" 
                             ValidationGroup="LoginUserValidationGroup">*</asp:RequiredFieldValidator>
                    </p>
                    <p>
                        <asp:Label ID="PasswordLabel" runat="server" AssociatedControlID="Password">密码:</asp:Label>
                        <asp:TextBox ID="Password" runat="server" CssClass="passwordEntry" TextMode="Password"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="PasswordRequired" runat="server" ControlToValidate="Password" 
                             CssClass="failureNotification" ErrorMessage="必须填写“密码”。" ToolTip="必须填写“密码”。" 
                             ValidationGroup="LoginUserValidationGroup">*</asp:RequiredFieldValidator>
                    </p>
                    <p>
                        <asp:Label runat="server" AssociatedControlID="tbValidateCode">验证码:</asp:Label>
                        <asp:TextBox ID="tbValidateCode" name="ValidateCode" runat="server" CssClass="textEntry"></asp:TextBox>
                        
                       <asp:CustomValidator ID="cvValidateCode" ControlToValidate="tbValidateCode"  Display="Dynamic" 
                        runat="server" ErrorMessage="验证码不正确" ToolTip="验证码不正确"  CssClass="failureNotification" 
                        OnServerValidate="CustomValidator1_ServerValidate" ValidationGroup="LoginUserValidationGroup">*</asp:CustomValidator>
                        <asp:Image ImageAlign="Middle" ID="imgValidator" ToolTip="点击更新验证码"  runat="server" ImageUrl="~/ImageValidator.aspx?len=4&type=1" ClientIDMode="Static"/>
                          <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="tbValidateCode" 
                             CssClass="failureNotification" ErrorMessage="必须填写“验证码”。" ToolTip="必须填写“验证码”。"  Display="Dynamic" 
                             ValidationGroup="LoginUserValidationGroup">*</asp:RequiredFieldValidator>
                    </p>
                    <p>
                        <asp:CheckBox ID="RememberMe" runat="server"/>
                        <asp:Label ID="RememberMeLabel" runat="server" AssociatedControlID="RememberMe" CssClass="inline">保持登录状态</asp:Label>
                    </p>
                </fieldset>
                <p class="submitButton">
                    <asp:Button ID="LoginButton" runat="server" CommandName="Login" Text="登录" ValidationGroup="LoginUserValidationGroup"/>
                </p>
            </div>
        </LayoutTemplate>
    </asp:Login>
</asp:Content>
