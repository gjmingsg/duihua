<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/ListMasterPage.master" AutoEventWireup="true" CodeBehind="MessageList.aspx.cs" Inherits="Duihua.WebApp.Admin.Message.MessageList" %>
<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Script" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="List" runat="server">

    <div id="listTemplate" runat="server">
    <div class="block"> 
			  
			<div class="fr" id="search"> 
            留言者姓名: <asp:TextBox runat="server" ID="tbUserName" ></asp:TextBox>
            留言方式:   <asp:TextBox runat="server" ID="tbContactWay" ></asp:TextBox>
            留言内容:   <asp:TextBox runat="server" ID="tbMessage" ></asp:TextBox>
                <asp:HiddenField ID="hdbegin" runat="server" />
                <asp:HiddenField ID="hdend" runat="server" />
                        <asp:Button runat="server" ID="btnSearch" ClientIDMode="Static"  
                    Text="搜索" onclick="btnSearch_Click"/>
			</div>
			<div class="clear"></div>
		</div><!--end: block -->
       
    <asp:GridView ID="GridView1" runat="server" DataKeyNames="Id"  AutoGenerateColumns="False"
      CssClass="fullwidth table_solid" DataSourceID="SqlDataSource"  >
      <EmptyDataTemplate>
      没有留言  
      </EmptyDataTemplate>
        <Columns>
            <asp:BoundField DataField="pageIndex" HeaderText="序号" HeaderStyle-Width="50"/>
            <asp:BoundField DataField="UserName" HeaderText="留言者姓名" HeaderStyle-Width="100"/>
            <asp:BoundField DataField="ContactWay" HeaderText="联系方式" HeaderStyle-Width="100"/>
            <asp:BoundField DataField="CreateTime" HeaderText="留言时间" SortExpression="CreateTime" HeaderStyle-Width="170"/>
            <asp:BoundField DataField="Message" HeaderText="留言内容" />
            <asp:TemplateField HeaderText="操作" ShowHeader="True"  HeaderStyle-Width="130">
                        <ItemTemplate>
                             
                            <asp:LinkButton ID="LinkButton3" runat="server" CssClass="fl btn3" CausesValidation="False" CommandName="Delete"
                                Text="删除" OnClientClick="return confirm('确认要删除吗？');"></asp:LinkButton>
                            <asp:LinkButton ID="LinkButton2" runat="server" CssClass="fl btn5" 
                                     CausesValidation="False" CommandName="Select" 
                                Text="查看" onclick="LinkButton2_Click" _Id='<%#Eval("ID") %>'></asp:LinkButton>
                        </ItemTemplate>  
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    共<asp:Label ID="lblCount" runat="server" Text="0"></asp:Label>条数据&nbsp;
    <webdiyer:AspNetPager id="AspNetPager1"  runat="server" Width="500px" FirstPageText="首页" 
    LastPageText="尾页" NextPageText="下一页" PrevPageText="上一页" Height="40px" 
    ShowInputBox="Always" TextAfterInputBox="页"  OnPageChanging="AspNetPager1_PageChanging" 
    PageSize="10" TextBeforeInputBox="跳转到第" AlwaysShow="True" CssClass="page_list"> 
</webdiyer:AspNetPager> 

    <asp:SqlDataSource ID="SqlDataSource" runat="server" 
        ConnectionString="<%$ ConnectionStrings:DuihuaDB %>" 
        SelectCommand="SELECT [UserName], [ContactWay], [Message], [CreateTime], [ID],pageIndex FROM (
SELECT ROW_NUMBER()OVER(ORDER BY [CreateTime] desc) pageIndex ,
[UserName], [ContactWay], LEFT (cast([Message] as nvarchar(200)),150)+'...' Message, [CreateTime], [ID] 
FROM [Message]
WHERE 1=1 
and ContactWay LIKE '%'+@ContactWay+'%'
AND [UserName] LIKE '%'+@UserName+'%'
and Message like '%' + @Message + '%'
) x
where pageIndex between @begin and @end
ORDER BY pageIndex asc"
 DeleteCommand="delete from Message where id=@Id"
>
        <SelectParameters>
        <asp:ControlParameter ControlID="tbContactWay"  ConvertEmptyStringToNull="false" Name="ContactWay" />
        <asp:ControlParameter ControlID="tbUserName"  ConvertEmptyStringToNull="false" Name="UserName" />
        <asp:ControlParameter ControlID="tbMessage"  ConvertEmptyStringToNull="false" Name="Message" />
       <asp:ControlParameter ControlID="hdend"  ConvertEmptyStringToNull="false" Name="end" />
        <asp:ControlParameter ControlID="hdbegin"  ConvertEmptyStringToNull="false" Name="begin" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="Id" DbType="Guid" />
        </DeleteParameters>
    </asp:SqlDataSource>
    
    </div>

    <div id="detailTemplate" runat="server" visible="false">
           
            留言者姓名：<asp:Label ID="Label1" runat="server" name="UserName"></asp:Label>
            <br />
            <br />
            联系方式：<asp:Label ID="Label2" runat="server" name="ContactWay"></asp:Label>
            <br />
            <br />
            留言时间：<asp:Label ID="Label3" runat="server" name="CreateTime"></asp:Label>
            <br />
            <br />
            留言内容：<div><br /><asp:Label ID="Label4" runat="server" name="Message"></asp:Label></div>
            <br />
            <br />
            <asp:Button ID="Button4" runat="server" Text="关闭" onclick="Button4_Click"/>
    </div>
</asp:Content>
