<%@ Page Title="" Language="C#" MasterPageFile="~/Layout/AdminDefault.Master" AutoEventWireup="true" 
CodeBehind="AllForum.aspx.cs" Inherits="Duihua.EducationWeb.Modules.Forum.AllForum" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<% if(HttpContext.Current.User.IsInRole("管理员")){ %>
    <div class="alert alert-danger" role="alert">
        <asp:Button ID="btnCreateTopicType" runat="server" Text="添加讨论组" CssClass="btn btn-primary" data-toggle="modal" data-target="#myModal"/>
    </div>
    <%} %>
    <div class="alert alert-success alert-dismissable">
        公开论坛
    </div>

    <div class="row">
    <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource1">
        <ItemTemplate>
            <div class="col-lg-4 col-md-4 col-sm-6">
                <a href='TopicTypeSub.aspx?TypeId=<%#Eval("TypeId") %>' style=" float:left">
                    <img src="../../Images/topicicon.png" alt='<%#Eval("TypeName")%>'  class="thumbnail"/>
                </a>
                <div  style=" float:left; margin:-10px 5px 0px 5px; padding:5px;">
                    <h3 style=" width:260px"><a href='TopicTypeSub.aspx?TypeId=<%#Eval("TypeId") %>'><%#Eval("TypeName")%></a></h3>
                    <div>
                        发帖数：
                        <span class="label label-success">
                            <%#Eval("topicCount")%>
                        </span>
                        回复数：
                        <span class="label label-success">
                            <%#Eval("replyCount")%>
                        </span>
                        <span style="margin-left:10px">
                            <asp:Button ID="btnDel" runat="server" CssClass="btn btn-danger btn-sm" Text="删除" 
                             OnClick="btnDel_Click" _id='<%#Eval("TypeId") %>' _count=' <%#Eval("topicCount")%>' />
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
                                       AND parentid IS NULL)" 
      InsertCommand="INSERT INTO [dbo].[TopicType]
           ([TypeId]
           ,[TypeName]
           ,[ParentId]
           ,[IsOpen])
     VALUES
           (NEWID()
           ,@TypeName
           ,'42056A1D-43F3-40CB-9B92-CCC67257EB58'
           ,@IsOpen)" 
           DeleteCommand="DELETE FROM TopicType WHERE TypeId = @TypeId" >
            <DeleteParameters>
                <asp:Parameter Name="TypeId" />
                </DeleteParameters>
           <InsertParameters>
            <asp:ControlParameter ControlID="TypeName" Name="TypeName" />
            <asp:ControlParameter ControlID="IsOpen" Name="IsOpen"  />
           </InsertParameters>
    </asp:SqlDataSource>

    <div class="alert alert-warning alert-dismissable">
        内部论坛
    </div>
    <div class="row">
    <asp:Repeater ID="Repeater3" runat="server" DataSourceID="SqlDataSource3">
        <ItemTemplate>
            <div class="col-lg-4 col-md-4 col-sm-6">
                <a href='TopicTypeSub.aspx?TypeId=<%#Eval("TypeId") %>' style=" float:left">
                    <img src="../../Images/内部论坛.png" alt='<%#Eval("TypeName")%>'  class="thumbnail"/>
                </a>
                <div  style=" float:left; margin:-10px 5px 0px 5px; padding:5px;">
                    <h3 style=" width:260px"><a href='TopicTypeSub.aspx?TypeId=<%#Eval("TypeId") %>'><%#Eval("TypeName")%></a></h3>
                    <div>
                        发帖数：
                        <span class="label label-success">
                            <%#Eval("topicCount")%>
                        </span>
                        回复数：
                        <span class="label label-success">
                            <%#Eval("replyCount")%>
                        </span>
                        <span  style="margin-left:10px">
                            <asp:Button ID="btnDel" runat="server" CssClass="btn btn-danger btn-sm" Text="删除"
                            OnClick="btnDel_Click"  _id='<%#Eval("TypeId") %>' _count=' <%#Eval("topicCount")%>' />
                        </span>
                    </div>
                </div>
            </div>
        </ItemTemplate>
        
    </asp:Repeater>
    </div>
    <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:DuihuaDB %>" 
            SelectCommand="SELECT [TypeId],
               [TypeName],
               [ParentId],
               [IsOpen],
               (SELECT COUNT(1) FROM topic c WHERE c.TypeId = t.TypeId) topicCount,
               (SELECT COUNT(1) FROM TopicReply r WHERE r.TopicId IN(SELECT c.TopicId FROM topic c WHERE c.TypeId = t.TypeId) ) replyCount
               
        FROM   [dbo].[TopicType] t
        WHERE  isopen = 0
               AND parentid ='42056A1D-43F3-40CB-9B92-CCC67257EB58'"
       DeleteCommand="DELETE FROM TopicType WHERE TypeId = @TypeId" >
       <DeleteParameters>
        <asp:Parameter Name="TypeId" />
       </DeleteParameters>
    </asp:SqlDataSource>

    <div class="alert alert-info alert-dismissable">
        课程论坛
    </div>
    <div class="row">
    <asp:Repeater ID="Repeater2" runat="server" DataSourceID="SqlDataSource2">
        <ItemTemplate>
            <div class="col-lg-4 col-md-4 col-sm-6">
                <a href='TopicTypeSub.aspx?TypeId=<%#Eval("TypeId") %>' style=" float:left">
                    <img src="../../Images/forum.png" alt='<%#Eval("TypeName")%>'  class="thumbnail"/>
                </a>
                <div  style=" float:left; margin:-10px 5px 0px 5px; padding:5px;">
                    <h3 style=" width:260px"><a href='TopicTypeSub.aspx?TypeId=<%#Eval("TypeId") %>'><%#Eval("TypeName")%></a></h3>
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
    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:DuihuaDB %>" 
            SelectCommand="SELECT [TypeId],
               '【'+s.SemesterName+'/'+cg.GradeName+'】'+[TypeName] as TypeName,
               [ParentId],
               [IsOpen],
               (SELECT COUNT(1) FROM topic c WHERE c.TypeId = t.TypeId) topicCount,
               (SELECT COUNT(1) FROM TopicReply r WHERE r.TopicId IN(SELECT c.TopicId FROM topic c WHERE c.TypeId = t.TypeId) ) replyCount
               
        FROM   [dbo].[TopicType] t
        INNER JOIN Course c ON c.CourseID = t.TypeId
        INNER JOIN ClassGrade cg ON cg.ClassID = c.ClassID
        INNER JOIN Semester s ON s.SemesterID = cg.SemesterID
        WHERE  isopen = 0
               AND parentid ='7A10235E-D4A4-46BA-AB34-9521F32845D1'" >
    </asp:SqlDataSource>





<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
        <h4 class="modal-title" id="myModalLabel">添加讨论组</h4>
      </div>
      <div class="modal-body">
        <div class="form-group">
          <label for="TypeName">名称：</label>
          <asp:TextBox ID="TypeName" name="TypeName" runat="server"  ClientIDMode="Static" CssClass="form-control"></asp:TextBox>
        </div>
        <div class="form-group">
          <label for="IsOpen">是否公开：</label>
            <asp:DropDownList ID="IsOpen" runat="server" name="IsOpen"  ClientIDMode="Static" CssClass="form-control">
                <asp:ListItem Text="是" Value="1" Selected="True"></asp:ListItem>
                <asp:ListItem Text="否" Value="0"></asp:ListItem>
            </asp:DropDownList>
        </div>
      </div>
      <div class="modal-footer">
        <asp:Button ID="btnSave" CssClass="btn btn-primary" runat="server" Text="保存"  />
        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      </div>
    </div>
  </div>
</div>
</asp:Content>
