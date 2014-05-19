<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Ueditor.ascx.cs" Inherits="Duihua.WebApp.Admin.Ueditor.Ueditor" %>
   <div>
     <%--  <asp:TextBox ID="editor" runat="server" ClientIDMode="Static" TextMode="MultiLine" Rows="20"></asp:TextBox>--%>

       <textarea id="editor" name="txteditor" runat="server" cols="20" rows="2" clientidmode="Static"></textarea>
   </div>

 <script type="text/javascript" charset="utf-8" src="<%=GetFullContextPath %>/Admin/Ueditor/ueditor.config.js"></script>
 <script type="text/javascript" charset="utf-8" src="<%=GetFullContextPath %>/Admin/Ueditor/ueditor.all.min.js"> </script>
 <script type="text/javascript" charset="utf-8" src="<%=GetFullContextPath %>/Admin/Ueditor/lang/zh-cn/zh-cn.js"></script>
<script type="text/javascript">
    UE.getEditor('editor');
 </script>