<%@ Page Title="" Language="C#" ValidateRequest="false" MasterPageFile="~/Layout/AdminDefault.Master" AutoEventWireup="true" CodeBehind="SystemNotice.aspx.cs" Inherits="Duihua.EducationWeb.Modules.Notice.SystemNotice" %>
<%@ Register Src="~/Modules/Common/NoticeEdit.ascx" TagName="edit" TagPrefix="uc" %>
<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<div runat="server" id="list"  class="panel panel-success">
    <div  class="panel-heading">
        <h3 class="panel-title">系统公告管理</h3>
    </div>
     <div class="panel-body">
     <asp:Button runat="server" ID="btnNew" ClientIDMode="Static" Text="添加" onclick="btnNew_Click" CssClass="btn btn-primary"/>
     </div>
    <div class="table-responsive">
        <table class="table table-hover">
        <thead>
          <tr>
              <th>操作</th> 
              <th>公告标题</th>
              <th>发表时间</th>
              <th>发布人</th>
          </tr>
        </thead>
        <tbody>
  <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource1">
   
  <ItemTemplate>

  <tr>  
        <td>
                <asp:LinkButton ID="LinkButton1"    runat="server" CssClass="fl btn5"  OnClick="lbOperator_Click"
                                     CausesValidation="False" CommandName="Edit" 
                                Text="编辑"  _Id='<%#Eval("NoticeID") %>' />
                
                 <%--<asp:LinkButton ID="LinkButton2"    runat="server" CssClass="fl btn5"   OnClick="lbOperator_Click"
                                     CausesValidation="False" CommandName="View" 
                                Text="查看"   _Id='<%#Eval("NoticeID") %>' />--%>

                 <asp:LinkButton ID="LinkButton3"   runat="server" CssClass="fl btn3" CausesValidation="False" CommandName="Delete"
                       OnClick="lbOperator_Click"   Text="删除" OnClientClick="return confirm('确认要删除吗？');" _Id='<%#Eval("NoticeID") %>' />
             </td>
             <td> </td>
             <td><%#Eval("Title")%></td>
            <td><%#Eval("CreateTime")%></td>
            <td><%#Eval("UserName")%></td>
         
          </tr>
  </ItemTemplate>
  
        </asp:Repeater>
 </tbody>
      </table>
      </div>
         共<asp:Label ID="lblCount" runat="server" Text="0"></asp:Label>条数据&nbsp;
    <webdiyer:AspNetPager id="AspNetPager1"  runat="server" Width="500px" FirstPageText="首页" 
    LastPageText="尾页" NextPageText="下一页" PrevPageText="上一页" Height="40px" 
    ShowInputBox="Always" TextAfterInputBox="页"  OnPageChanging="AspNetPager1_PageChanging" 
    PageSize="10" TextBeforeInputBox="跳转到第" AlwaysShow="True" CssClass="pagination"> 
    </webdiyer:AspNetPager> 

</div>

      <asp:HiddenField ID="hdbegin" runat="server" />
      <asp:HiddenField ID="hdend" runat="server" />
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:DuihuaDB %>" 
        SelectCommand="SELECT tx.* FROM (
SELECT 
ROW_NUMBER()OVER(ORDER BY n.createtime desc)pageindex 
,[NoticeID]
            ,[Title]
            ,[Content]
            ,[CreateTime]
            ,[Creator]
            ,[ModuleId]
            ,[ModuleName]
            ,au.UserName
        FROM [dbo].[Notice] n
        INNER JOIN aspnet_Users au ON au.UserId = n.Creator 
 WHERE n.ModuleName = 'System'
)tx where pageIndex between @begin and @end ORDER BY pageIndex asc"  DeleteCommand="DELETE FROM Notice WHERE NoticeID = @NoticeID">
        <DeleteParameters>
            <asp:Parameter Name="NoticeID" />
        </DeleteParameters>
        <SelectParameters>
             <asp:ControlParameter ControlID="hdend"  ConvertEmptyStringToNull="false" Name="end" />
             <asp:ControlParameter ControlID="hdbegin"  ConvertEmptyStringToNull="false" Name="begin" />
        </SelectParameters>
        </asp:SqlDataSource>

<div runat="server" id="deteil" visible="false"  class="panel panel-success">
    <uc:edit runat="server" ID="noticeeditor" />
</div>
</asp:Content>
