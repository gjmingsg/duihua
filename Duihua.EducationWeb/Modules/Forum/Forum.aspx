<%@ Page Title="" Language="C#" MasterPageFile="~/Layout/AdminDefault.Master" AutoEventWireup="true" CodeBehind="Forum.aspx.cs" Inherits="Duihua.EducationWeb.Modules.Forum.Forum" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<div class="alert alert-success alert-dismissable">
<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
    欢迎对大家进行留言，我们将及时进行答复
  <strong>注意：</strong>
  <ul>
  <li>1，不能发表危害国家安全,,,</li>
  <li>2，不能发表危害国家安全,,,</li>
  </ul>
</div>

    <div class="row">
    <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource1">
        <ItemTemplate>
            <div class="col-lg-4 col-md-4 col-sm-6">
                <a href='TopicTypeSub.aspx?TypeId=<%#Eval("TypeId") %>' style=" float:left">
                    <img src="../../Images/topicicon.png" alt='<%#Eval("TypeName")%>'  class="thumbnail"/>
                </a>
                <div  style=" float:left; margin:-10px 5px 0px 5px; padding:5px;">
                    <h3><a href='TopicTypeSub.aspx?TypeId=<%#Eval("TypeId") %>'><%#Eval("TypeName")%></a></h3>
                    <div>
                        发帖数：
                        <span class="label label-success">
                            <%#Eval("topicCount")%>
                        </span>
                        回复数：
                        <span class="label label-success">
                            <%#Eval("replyCount")%>
                        </span>
                    </div>
                </div>
            </div>
        </ItemTemplate>
        
    </asp:Repeater>
    </div>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DuihuaDB %>" 
            SelectCommand="SELECT [TypeId],
               [TypeName],
               [ParentId],
               [IsOpen],
               (SELECT COUNT(1) FROM topic c WHERE c.TypeId = t.TypeId) topicCount,
               (SELECT COUNT(1) FROM TopicReply r WHERE r.TopicId IN(SELECT c.TopicId FROM topic c WHERE c.TypeId = t.TypeId) ) replyCount
               
        FROM   [dbo].[TopicType] t
        WHERE  isopen = 1
               AND parentid IN (SELECT [TypeId]
                                FROM   [dbo].[TopicType]
                                WHERE  isopen = 1
                                       AND parentid IS NULL)" >
    </asp:SqlDataSource>

</asp:Content>
