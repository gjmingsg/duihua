<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="MessageEdit.ascx.cs" Inherits="Duihua.EducationWeb.Modules.Common.MessageEdit" %>
<div class="panel panel-success">
    <div class="panel-heading">
        <h3 class="panel-title"><asp:Literal runat="server" ID="ToolTips"></asp:Literal></h3>
    </div>
    <div class="panel-body" id="panelbody" runat="server">
      <div class="form-group" runat="server" id="titlegroup">
          <label for="Title">标题：</label>
          <asp:TextBox ID="Title" name="Title" runat="server"  ClientIDMode="Static" CssClass="form-control"></asp:TextBox>
      </div>
       <div class="form-group">
           <label for="Content">内容：</label>
          <textarea id="Content" name="Content" style=" height:200px;" runat="server" cols="40" rows="10" clientidmode="Static"></textarea>
          <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="Content" 
            CssClass="failureNotification" ErrorMessage="必须填写“内容”。" ToolTip="必须填写“内容”。" 
            ValidationGroup="RegisterArtValidationGroup">*</asp:RequiredFieldValidator>
           <asp:TextBox ID="RefMessageId" name="RefMessageId" runat="server" style="display:none"></asp:TextBox>
           <asp:TextBox ID="MessageId" name="MessageId" runat="server" style="display:none"></asp:TextBox>
           <asp:TextBox ID="Receive" name="Receive" runat="server" style="display:none"  ClientIDMode="Static" ></asp:TextBox>
          
        </div> 
        <script type="text/javascript" charset="utf-8" src="<%=GetFullContextPath %>/scripts/Ueditor/ueditor.config.js"></script>
        <script type="text/javascript" charset="utf-8" src="<%=GetFullContextPath %>/scripts/Ueditor/ueditor.all.min.js"> </script>
        <script type="text/javascript" charset="utf-8" src="<%=GetFullContextPath %>/scripts/Ueditor/lang/zh-cn/zh-cn.js"></script>
        <script type="text/javascript">
            window.UEDITOR_CONFIG.toolbars=[
            [ 'source',   'undo', 'redo', '|',
                'bold', 'italic', 'underline', 'fontborder', 'strikethrough', 'superscript', 'subscript', 'removeformat', 'formatmatch', 'autotypeset', 'blockquote', 'pasteplain', '|', 
                'forecolor', 'backcolor', 'insertorderedlist', 'insertunorderedlist', 'selectall', 'cleardoc', '|',
                'rowspacingtop', 'rowspacingbottom', 'lineheight', 'fontsize', 'directionalityltr', 'directionalityrtl', 'indent', '|',
                'justifyleft', 'justifycenter', 'justifyright', 'justifyjustify', 'link', 'unlink', 'anchor', '|',
                'insertimage', 'emotion', 'scrawl', 'insertvideo', 'music', 'attachment', 'map',  'insertframe','|',
                'horizontal', 'date', 'time', 'spechars', 'snapscreen', 'preview']
        ];
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