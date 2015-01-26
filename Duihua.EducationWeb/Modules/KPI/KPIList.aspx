<%@ Page Title="绩效评估目标关键评估指标管理" Language="C#" MasterPageFile="~/Layout/AdminDefault.Master" AutoEventWireup="true" CodeBehind="KPIList.aspx.cs" Inherits="Duihua.EducationWeb.Modules.KPI.KPIList" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<div runat="server" id="list"  class="panel panel-success">
    <div  class="panel-heading">
        <h3 class="panel-title">绩效评估目标关键评估指标管理</h3>
    </div>
    <div class="panel-body">
        <asp:Button runat="server" ID="btnNew" ClientIDMode="Static" Text="添加" onclick="btnNew_Click" CssClass="btn btn-primary"/>
    </div>
    <div class="table-responsive">
        <table class="table table-hover">
            <thead>
              <tr>
                  <th style=" width: 180px;">操作</th> 
                  <th>评估指标</th>
                <%--  <th>是否启用</th>--%>
                  <th>描述</th>
              </tr>
            </thead>
            <tbody>
                <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource1">
                    <ItemTemplate>
                        <tr>  
                            <td>
                                 <button type="button" class="btn btn-warning btn-sm"  data-target="#myModal"   _Id='<%#Eval("KPITypeId") %>'>下发指标填报</button>
                                 <asp:LinkButton runat="server" CssClass="fl btn5"  OnClick="lbOperator_Click"  CausesValidation="False" CommandName="Edit"   Text="编辑"  _Id='<%#Eval("KPITypeId") %>' />
                                 <asp:LinkButton runat="server" CssClass="fl btn3" CausesValidation="False" CommandName="Delete" OnClick="lbOperator_Click"   Text="删除" OnClientClick="return delConfirm(this);" _Id='<%#Eval("KPITypeId") %>' _candel='<%#Eval("canDel") %>'/>
                             </td>
                             <td>
                                <a href='KPIItemDetail.aspx?KPITypeId=<%#Eval("KPITypeId") %>&ReturnUrl=<%=Request.RawUrl %>'><%#Eval("KPITypeName")%></a>
                             </td>
                         <%--    <td><%#Eval("Status")%></td>--%>
                             <td><%#Eval("memo")%></td>
                          </tr>
                  </ItemTemplate>
                </asp:Repeater>
            </tbody>
        </table>
    </div>
    
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:DuihuaDB %>" 
        DeleteCommand="DELETE FROM dbo.KPIType WHERE KPITypeId = @KPITypeId" 
   
        SelectCommand="SELECT [KPITypeId]
                              ,[KPITypeName]
                              ,CASE WHEN  [Status]=1
                              THEN '启用'
                              ELSE '禁用' end [Status]
                              ,memo
                              ,(SELECT COUNT(1) FROM KPIItem k WHERE t.KPITypeId = k.KPITypeId) canDel
                          FROM  [dbo].[KPIType] t">
        <DeleteParameters>
            <asp:Parameter Name="KPITypeId" />
        </DeleteParameters>
     
    </asp:SqlDataSource>
</div>
<script type="text/javascript">
    function delConfirm(_this) {
        var item = $(_this).attr('_candel');
        if (item > 0) {
            alert('请先删除指标下的指标项');
            return false;
        }
        return true;
    }
    $(function () {
        $('.btn-warning').each(function () {

            var id = $(this).attr('_Id');
            $(this).click(function () {
                $('#<%=KPITypeId.ClientID %>').val(id);
                $('#myModal').modal('show');
            })
            
        })
    });
   
</script>

<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
        <h4 class="modal-title" id="myModalLabel">下发指标填报</h4>
      </div>
      <div class="modal-body">
          <div class="form-group">
            <label for="Memo">考核说明：</label>
            <asp:TextBox ID="Memo" runat="server" TextMode="MultiLine" Columns="10" Rows="6" CssClass="form-control"></asp:TextBox>   
            <span class="help-block">点击下发后，该说明会成为一条通告，通知需要填报该考核指标</span>
              <asp:TextBox ID="KPITypeId" runat="server" style='display:none'></asp:TextBox>
          </div>
      </div>
      <div class="modal-footer">
       <asp:Button ID="btnSaveKPIRelease" runat="server" Text="下发"   CssClass="btn btn-success" OnClick="btnSaveKPIRelease_Click"/>
        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      </div>
    </div>
  </div>
</div>

</asp:Content>
