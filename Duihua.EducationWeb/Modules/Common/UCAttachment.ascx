<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="UCAttachment.ascx.cs" Inherits="Duihua.EducationWeb.Modules.Common.UCAttachment" %>
 <asp:SqlDataSource ID="SqlDataSource2" runat="server"  ConnectionString="<%$ ConnectionStrings:DuihuaDB %>" 
    SelectCommand="SELECT SUBSTRING(a.AttachmentName,CHARINDEX('@',a.AttachmentName,0)+1,LEN(a.AttachmentName)) [filename]
,a.AttachmentName
,a.AttachmentId
,a.DownCount
, FLOOR(a.[Size]/1024)Size FROM Attachment a WHERE a.ModuleName = @ModuleName
AND a.ModuleId = @ModuleId" DeleteCommand="DELETE FROM Attachment WHERE AttachmentId = @ID"
 >
    <SelectParameters>
       <asp:Parameter Name="ModuleId" />
       <asp:Parameter Name="ModuleName" />
    </SelectParameters>
    <DeleteParameters>
        <asp:Parameter Name="ID"/>
    </DeleteParameters>
</asp:SqlDataSource>
<asp:HiddenField ID="hdModuleId" runat="server" />
<asp:HiddenField ID="hdModuleName" runat="server" />
<asp:HiddenField ID="hdEditMode" runat="server" />
  <div class="panel panel-info">
      <div class="panel-heading">
      <asp:Label ID="lbControlName" AssociatedControlID="Repeater2" runat="server" Text="附件："></asp:Label>
      </div>
      
 <div class="table-responsive">
            <table class="table">
                <thead>
                    <tr>
                        <%if(EditMode){ %>
                        <th>操作</th>
                        <%} %>
                        <th>附件名称</th>
                        <th>大小(kb)</th>
                        <th>下载次数</th>
                    </tr>
                </thead>
                <tbody>
                    <asp:Repeater ID="Repeater2" runat="server">
                        <ItemTemplate>
                            <tr>
                                <%if(EditMode){ %>
                                <td>  <asp:LinkButton  runat="server" CssClass="fl btn3" CausesValidation="False" CommandName="Delete"
                                         OnClick="lbOperator_Click"   Text="删除" OnClientClick="return confirm('确认要删除吗？');" _Id='<%#Eval("AttachmentId") %>' />
                                </td>
                                <%} %>
                                <td><a href='/Modules/Common/DownloadHandler.ashx?ID=<%#Eval("AttachmentId") %>'><%#Eval("filename")%></a></td>
                                <td><%#Eval("Size") %></td>
                                <td><%#Eval("DownCount")%></td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
                </tbody>
            </table>
</div>
<%if(EditMode){ %>
<div class="form-group">
    <label for="eCover">上传附件：</label>
    <div class="input-group">
        <asp:FileUpload ID="eCover" runat="server" ClientIDMode="Static" CssClass="form-control" placeholder="上传附件"/>
        <span class="input-group-btn">
            <asp:Button ID="btnUpload" runat="server" Text="上传"  
            CssClass="btn btn-success" onclick="btnUpload_Click"/>
        </span>
    </div>
     <span class="help-block">上传文件格式为：<%=ConfigurationManager.AppSettings["AttachmentType"]%></span>
 </div>
 <%} %>
  </div>