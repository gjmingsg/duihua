<%@ Page Title="" Language="C#" MasterPageFile="~/Layout/Site.Master" AutoEventWireup="true" CodeBehind="LoginT.aspx.cs" Inherits="Duihua.EducationWeb.LoginT" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
<style type="text/css">
.form-signin {
  max-width: 330px;
  padding: 15px;
  margin: 0 auto;
}
.form-signin .form-signin-heading,
.form-signin .checkbox {
  margin-bottom: 10px;
}
.form-signin .checkbox {
  font-weight: normal;
}
.form-signin .form-control {
  position: relative;
  font-size: 16px;
  height: auto;
  padding: 10px;
  -webkit-box-sizing: border-box;
     -moz-box-sizing: border-box;
          box-sizing: border-box;
}
.form-signin .form-control:focus {
  z-index: 2;
}
.form-signin input[type="text"] {
  margin-bottom: -1px;
  border-bottom-left-radius: 0;
  border-bottom-right-radius: 0;
}
.form-signin input[type="password"] {
  margin-bottom: 10px;
  border-top-left-radius: 0;
  border-top-right-radius: 0;
}
</style>
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
     <h2 class="form-signin-heading">
        登录
    </h2>
    <p>
        <%--请输入用户名和密码。
        <asp:HyperLink ID="RegisterHyperLink" runat="server" EnableViewState="false">注册</asp:HyperLink> 如果您没有帐户。--%>
    </p>
    <asp:Login ID="LoginUser" runat="server" EnableViewState="false" RenderOuterTable="false">
        <LayoutTemplate>
            <span class="failureNotification">
                <asp:Literal ID="FailureText" runat="server"></asp:Literal>
            </span>
            <asp:ValidationSummary ID="LoginUserValidationSummary" runat="server" CssClass="failureNotification" 
                 ValidationGroup="LoginUserValidationGroup"/>
            <div class="form-signin     form-horizontal">
                <fieldset >
                    <legend>请输入登录凭证</legend>
                    <p>
                        <label for="UserName" class="sr-only">用户名</label>
                        <asp:TextBox ClientIDMode="Static" ID="UserName" runat="server" CssClass="form-control" placeholder="用户名"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" ControlToValidate="UserName" 
                             CssClass="failureNotification" ErrorMessage="必须填写“用户名”。" ToolTip="必须填写“用户名”。" 
                             ValidationGroup="LoginUserValidationGroup">*</asp:RequiredFieldValidator>
                    </p>
                    <p>
                           <label for="Password" class="sr-only">密码</label>
                        <asp:TextBox  ClientIDMode="Static" ID="Password" runat="server" CssClass="form-control" TextMode="Password"  placeholder="密码"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="PasswordRequired" runat="server" ControlToValidate="Password" 
                             CssClass="failureNotification" ErrorMessage="必须填写“密码”。" ToolTip="必须填写“密码”。" 
                             ValidationGroup="LoginUserValidationGroup">*</asp:RequiredFieldValidator>
                    </p>
                    

                    <p class="input-group">
                        <label for="tbValidateCode" class="sr-only">验证码</label>
                        <asp:TextBox  ClientIDMode="Static" ID="tbValidateCode" runat="server" CssClass="form-control"   placeholder="验证码"></asp:TextBox>
                        <span class="input-group-addon">
                        <asp:Image ImageAlign="Middle" ID="imgValidator" ToolTip="点击更新验证码"  runat="server" ImageUrl="~/ImageValidator.aspx?len=4&type=1" ClientIDMode="Static" CssClass="img-responsive"/>
                        </span>
                    </p>
                    <p>
                        <label class="checkbox">
                        <asp:CheckBox ID="RememberMe" runat="server"/>保持登录状态
                        </label>
                    </p>
                </fieldset>
                <p class="submitButton">
                    <asp:Button ID="LoginButton" runat="server" CommandName="Login" Text="登录" ValidationGroup="LoginUserValidationGroup" CssClass="btn btn-lg btn-primary btn-block"/>
                </p>
            </div>
        </LayoutTemplate>
    </asp:Login>
</asp:Content>
