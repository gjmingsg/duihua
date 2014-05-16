<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/ListMasterPage.master" AutoEventWireup="true" CodeBehind="ConfigList.aspx.cs" Inherits="Duihua.WebApp.Admin.Config.ConfigList" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Script" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="List" runat="server">
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False"  CssClass="fullwidth table_solid" 
        DataKeyNames="ID" DataSourceID="SqlDataSource1">
        <Columns>
           
           
           
            <asp:BoundField DataField="ConfigName" HeaderText="配置项" HeaderStyle-Width="100" />
            <asp:BoundField DataField="ConfigValue" HeaderText="值"  />
             <asp:BoundField DataField="ConfigValue1" HeaderText="值1" />
            <asp:BoundField DataField="ConfigValue2" HeaderText="值2" />
                 <asp:BoundField DataField="ID" HeaderText="ID" ReadOnly="True" Visible="false"/>
                 
            <asp:CommandField ShowEditButton="True"  HeaderText="操作" HeaderStyle-Width="60"/>
           
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:DuihuaDB %>" 
        SelectCommand="SELECT [ID], [ConfigName], [ConfigValue],[ConfigValue1],[ConfigValue2] FROM [Config]" 
        UpdateCommand="UPDATE Config SET ConfigName = @ConfigName, ConfigValue = @ConfigValue ,
[ConfigValue1]= @ConfigValue1,
[ConfigValue2]=@ConfigValue2
WHERE (ID = @ID)">
        <UpdateParameters>
            
            <asp:Parameter Name="ConfigName"/>
            <asp:Parameter Name="ConfigValue" />
            <asp:Parameter Name="ConfigValue1" />
            <asp:Parameter Name="ConfigValue2" />
            <asp:Parameter Name="ID" />
        </UpdateParameters>
    </asp:SqlDataSource>
    
</asp:Content>
