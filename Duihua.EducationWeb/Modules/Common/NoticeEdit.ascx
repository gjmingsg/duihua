<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="NoticeEdit.ascx.cs" Inherits="Duihua.EducationWeb.Modules.Common.NoticeEdit" %>
<div class="panel panel-success">
    <div class="panel-heading">
        <h3 class="panel-title"><asp:Literal runat="server" ID="NoticeToolTips"></asp:Literal></h3>
    </div>
    <div class="panel-body" id="panelbody" runat="server">
      <div class="form-group">
          <label for="Title">标题：</label>
          <asp:TextBox ID="Title" name="Title" runat="server"  ClientIDMode="Static" CssClass="form-control"></asp:TextBox>
      </div>
       <div class="form-group">
           <label for="Content">公告内容：</label>
          <textarea id="Content" name="Content" runat="server" cols="20" rows="2" clientidmode="Static"></textarea>
          <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="Content" 
            CssClass="failureNotification" ErrorMessage="必须填写“内容”。" ToolTip="必须填写“内容”。" 
            ValidationGroup="RegisterArtValidationGroup">*</asp:RequiredFieldValidator>
            <asp:TextBox ID="NoticeID" runat="server" name="NoticeID" Visible="false"></asp:TextBox>
            <asp:HiddenField ID="hdModuleId" runat="server" />
            <asp:HiddenField ID="hdModuleName" runat="server" />
        </div> 
        <script type="text/javascript" charset="utf-8" src="<%=GetFullContextPath %>/scripts/Ueditor/ueditor.config.js"></script>
        <script type="text/javascript" charset="utf-8" src="<%=GetFullContextPath %>/scripts/Ueditor/ueditor.all.min.js"> </script>
        <script type="text/javascript" charset="utf-8" src="<%=GetFullContextPath %>/scripts/Ueditor/lang/zh-cn/zh-cn.js"></script>
        <script type="text/javascript">
            UE.getEditor('<%=Content.ClientID %>');
        </script>
      </div>
    <div class="panel-footer">
      <div class="form-group">
         <asp:Button ID="btnSave" runat="server" Text="保存"  ValidationGroup="vs" OnClick="btnSave_Click" CssClass="btn btn-primary"/>
         <asp:Button ID="btnBack" runat="server" Text="返回"  OnClick="btnBackList_Click" CssClass="btn btn-default"/>
      </div>
   </div>
</div>
 