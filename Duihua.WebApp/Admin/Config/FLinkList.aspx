<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/ListMasterPage.master" AutoEventWireup="true" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Script" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="List" runat="server">
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False"  CssClass="fullwidth table_solid" 
        DataKeyNames="ID" DataSourceID="SqlDataSource1">
        <Columns>
            <asp:BoundField DataField="ConfigName" HeaderText="配置项" HeaderStyle-Width="100" Visible="false"/>
            <asp:BoundField DataField="ConfigValue" HeaderText="链接名称"  />
            <asp:BoundField DataField="ConfigValue1" HeaderText="值1" Visible="false"/>
            <asp:BoundField DataField="ConfigValue2" HeaderText="链接地址" />
            <asp:BoundField DataField="ID" HeaderText="ID" ReadOnly="True" Visible="false"/>      
            <asp:CommandField ShowEditButton="True" ShowDeleteButton="true"  HeaderText="操作" HeaderStyle-Width="60"/>
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:DuihuaDB %>" 
        SelectCommand="SELECT [ID], [ConfigName], [ConfigValue],[ConfigValue1],[ConfigValue2] FROM [Config] where ConfigName='flink'" 
        UpdateCommand="UPDATE Config SET ConfigName = 'flink', ConfigValue = @ConfigValue ,
[ConfigValue1]= @ConfigValue1,
[ConfigValue2]=@ConfigValue2
WHERE (ID = @ID)" InsertCommand="INSERT INTO Config
(
	ID,
	ConfigName,
	ConfigValue,
	ConfigValue1,
	ConfigValue2
)
VALUES
(
	NEWID(),
	'flink',
	@ConfigValue,
	@ConfigValue1,
	@ConfigValue2
)" DeleteCommand="DELETE FROM Config WHERE ID = @ID"
        >
        <InsertParameters>
        <asp:Parameter Name="ConfigValue" />
            <asp:Parameter Name="ConfigValue1" />
            <asp:Parameter Name="ConfigValue2" />
        </InsertParameters>
        <UpdateParameters>
            
            <asp:Parameter Name="ConfigValue" />
            <asp:Parameter Name="ConfigValue1" />
            <asp:Parameter Name="ConfigValue2" />
            <asp:Parameter Name="ID" />
        </UpdateParameters>
        <DeleteParameters>
            <asp:Parameter Name="ID" />
        </DeleteParameters>
    </asp:SqlDataSource>
    
</asp:Content>
