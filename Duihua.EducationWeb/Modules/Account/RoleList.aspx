<%@ Page Title="" Language="C#" MasterPageFile="~/Layout/AdminDefault.Master" AutoEventWireup="true" CodeBehind="RoleList.aspx.cs" Inherits="Duihua.EducationWeb.Modules.Account.RoleList" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1" AutoGenerateColumns="true" Width="99%" CssClass="table  table-hover" AlternatingRowStyle-BorderWidth="0" RowStyle-BorderWidth="0" BorderWidth=0>
        <Columns>
            <asp:CommandField HeaderText="操作"  ShowCancelButton="true" ShowDeleteButton="true" ShowEditButton="true"/>
        <%--     <asp:TemplateField HeaderText="角色">
            <ItemTemplate>
               <%#Container.DataItem%>
             </ItemTemplate>
          </asp:TemplateField>--%>
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" 
     DataObjectTypeName="System.String"
     TypeName="System.Web.Security.Roles"
     SelectMethod="GetAllRoles"
        DeleteMethod="DeleteRole"
    InsertMethod="CreateRole"
     >
     
     </asp:ObjectDataSource>
</asp:Content>
