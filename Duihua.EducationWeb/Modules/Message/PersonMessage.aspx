<%@ Page Title="" Language="C#" MasterPageFile="~/Layout/Personal.master" AutoEventWireup="true" CodeBehind="PersonMessage.aspx.cs" Inherits="Duihua.EducationWeb.Modules.Message.PersonMessage" %>
<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Main" runat="server">
    <div class="table-responsive">
        <table class="table table-hover">
        <thead>
          <tr>
              <th>留言标题</th>
              <th>留言时间</th>
              <th>留言者</th>
              <th>状态</th>
          </tr>
        </thead>
        <tbody>
  <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource1">
   
  <ItemTemplate>

  <tr class='<%#GetStatus(Eval("ItemStatus")) %>'>  
        
             <td>
                <a href='../ReadHandler.ashx?Id=<%#Eval("messageid") %>&ItemName=ComMessage'>
                    <%#Eval("Title")%>
                </a>
            </td>
             <td><%#Eval("CreateTime")%></td>
            <td><%#Eval("UserName")%></td>
            <td><%#Eval("ItemStatus")%></td>
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


      <asp:HiddenField ID="hdbegin" runat="server" />
      <asp:HiddenField ID="hdend" runat="server" />
       <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:DuihuaDB %>"
         SelectCommand="SELECT 
                        t.messageid
                        ,t.Title
                        ,t.CreateTime
                        ,(select au.UserName FROM  aspnet_Users au where t.creator = au.UserId)UserName
                        ,case when ISNULL(nms.ItemStatus,'I') = 'I' THEN '未开始'
                            ELSE '已结束' end ItemStatus
                        FROM commessage t
                        LEFT JOIN NoticeMessageStatus nms ON nms.ItemId = t.MessageId AND nms.UserId =@UserId">
<SelectParameters>
    <asp:SessionParameter ConvertEmptyStringToNull="true" Name="UserId" SessionField="UserId"/>
</SelectParameters>
</asp:SqlDataSource>

</asp:Content>
