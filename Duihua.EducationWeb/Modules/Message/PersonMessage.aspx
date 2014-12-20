<%@ Page Title="" Language="C#" MasterPageFile="~/Layout/Personal.master" ValidateRequest="false" AutoEventWireup="true" CodeBehind="PersonMessage.aspx.cs" Inherits="Duihua.EducationWeb.Modules.Message.PersonMessage" %>
<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>
<%@ Register Src="~/Modules/Common/MessageEdit.ascx" TagName="msg" TagPrefix="uc" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Main" runat="server">
<div id="list" runat="server">
    <ul class="nav nav-tabs" role="tablist">
  <li role="presentation" class="active">
    <a href="#sendToMe" role="tab" data-toggle="tab">
        发送给我的留言
    </a>
  </li>
  <li role="presentation">
    <a href="#sendToOther" role="tab" data-toggle="tab">
        我发送的留言
    </a>
  </li>
</ul>
    <div class="tab-content">
    <div role="tabpanel" class="tab-pane active" id="sendToMe">
   
     <div class="table-responsive">
        <table class="table table-hover">
        <thead>
          <tr>
              <th>留言标题</th>
              <th>留言时间</th>
              <th>接收人</th>
              <th>状态</th>
          </tr>
        </thead>
        <tbody>
            <asp:Repeater ID="Repeater2" runat="server" DataSourceID="SqlDataSource2">
   
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
         共<asp:Label ID="Label1" runat="server" Text="0"></asp:Label>条数据&nbsp;
    <webdiyer:AspNetPager id="AspNetPager2"  runat="server" Width="500px" FirstPageText="首页" 
    LastPageText="尾页" NextPageText="下一页" PrevPageText="上一页" Height="40px" 
    ShowInputBox="Always" TextAfterInputBox="页"  OnPageChanging="AspNetPager2_PageChanging" 
    PageSize="10" TextBeforeInputBox="跳转到第" AlwaysShow="True" CssClass="pagination"> 
    </webdiyer:AspNetPager> 


      <asp:HiddenField ID="HiddenField1" runat="server" />
      <asp:HiddenField ID="HiddenField2" runat="server" />
       <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
        ConnectionString="<%$ ConnectionStrings:DuihuaDB %>"
         SelectCommand="SELECT 
                        t.messageid
                        ,t.Title
                        ,t.CreateTime
                        ,(select au.UserName FROM  aspnet_Users au where t.[Receive] = au.UserId)UserName
                        ,case when ISNULL(nms.ItemStatus,'I') = 'I' THEN '未读'
                            ELSE '已读' end ItemStatus
                        FROM commessage t
                        LEFT JOIN NoticeMessageStatus nms ON nms.ItemId = t.MessageId AND nms.[UserId] =@UserId
                        where  t.[Receive]=@UserId">
            <SelectParameters>
                <asp:SessionParameter ConvertEmptyStringToNull="true" Name="UserId" SessionField="UserId"/>
            </SelectParameters>
            </asp:SqlDataSource>
    </div>

    <div role="tabpanel" class="tab-pane" id="sendToOther">
     
     <div class="table-responsive">
        <table class="table table-hover">
        <thead>
          <tr>
              <th>留言标题</th>
              <th>留言时间</th>
              <th>留言者</th>
              <th>状态</th>
              <th>操作</th>
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
                    <td>
                        <asp:TextBox ID="hdItemStatus" runat="server" _status='<%#Eval("ItemStatus")%>' style=" display:none"></asp:TextBox>
                        <asp:Button ID="btnEdit" CssClass="btn btn-primary" runat="server" Text="编辑" OnClick="btnEdit_Click" _id='<%#Eval("messageid") %>' />
                        <asp:Button ID="btnDel" CssClass="btn btn-primary" runat="server" Text="删除" OnClick="btnDel_Click" _id='<%#Eval("messageid") %>' />
                    </td>
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
                        ,case when ISNULL(nms.ItemStatus,'I') = 'I' THEN '未读'
                            ELSE '已读' end ItemStatus
                        FROM commessage t
                        LEFT JOIN NoticeMessageStatus nms ON nms.ItemId = t.MessageId AND nms.UserId =@UserId
                        where  t.[creator]=@UserId">
            <SelectParameters>
                <asp:SessionParameter ConvertEmptyStringToNull="true" Name="UserId" SessionField="UserId"/>
            </SelectParameters>
            </asp:SqlDataSource>
    </div>
</div>
</div>
<uc:msg runat="server" id="msg" EditTitle="添加留言" Visible="false" IsShowTitle="true"></uc:msg>

</asp:Content>
