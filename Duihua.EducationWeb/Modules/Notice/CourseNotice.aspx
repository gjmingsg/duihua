<%@ Page Title="课程公告" Language="C#" MasterPageFile="~/Layout/Course.master" AutoEventWireup="true" 
 CodeBehind="CourseNotice.aspx.cs" Inherits="Duihua.EducationWeb.Modules.Notice.CourseNotice" ValidateRequest="false" %>
<%@ MasterType VirtualPath="~/Layout/Course.master"%> 
<%@ Register Src="~/Modules/Common/NoticeEdit.ascx" TagName="edit" TagPrefix="uc" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Main" runat="server">

    <div class="col-xs-offset-9 col-sm-offset-9">
        <asp:Button ID="btnSubmitNotice" runat="server" Text="发布公告"  CssClass="btn btn-primary"/>
    </div>
    <div id="list" runat="server">
        <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource1">
              <ItemTemplate>
                  <div class="blog-post">
                    <h3 class="blog-post-title"><%#Eval("Title")%></h3>
                    <p class="blog-post-meta">发表于<%#Eval("CreateTime")%><a href='#?UserId=<%#Eval("Creator") %>'><span class="badge"><%#Eval("UserName")%></span></a></p>
                    <p><%#Eval("Content")%></p>
                    <asp:Button ID="btnModifyNotice" _NoticeID='<%#Eval("NoticeID")%>' OnClick="btnModifyNotice_Click" runat="server" Text="修改公告"  CssClass="btn btn-primary"/>
                    <asp:Button ID="btnDeleteNotice" _NoticeID='<%#Eval("NoticeID")%>' OnClick="btnDeleteNotice_Click" runat="server" Text="删除公告"  CssClass="btn btn-primary"/>
                  </div>
              </ItemTemplate>
        </asp:Repeater>
    </div>
    <div id="detail" runat="server" visible="false">
        <uc:edit runat="server" id="noticeedit" ></uc:edit>
    </div>
    <asp:SqlDataSource  ConnectionString="<%$ ConnectionStrings:DuihuaDB %>"  ID="SqlDataSource1" runat="server" SelectCommand="SELECT [NoticeID]
            ,[Title]
            ,[Content]
            ,[CreateTime]
            ,[Creator]
            ,[ModuleId]
            ,[ModuleName]
            ,au.UserName
        FROM [dbo].[Notice] n
        INNER JOIN aspnet_Users au ON au.UserId = n.Creator 
    WHERE ModuleName = 'Course'
    AND ModuleId = @CourseID
    order by CreateTime desc">
        <SelectParameters>
            <asp:QueryStringParameter QueryStringField="CourseID" Name="CourseID" DefaultValue="00000000-0000-0000-0000-000000000000" />
        </SelectParameters>
    </asp:SqlDataSource>
  
</asp:Content>
