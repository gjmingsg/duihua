<%@ Page Title="" Language="C#" MasterPageFile="~/Layout/AdminDefault.Master" AutoEventWireup="true"  ValidateRequest="false"
CodeBehind="TopicTypeSub.aspx.cs" Inherits="Duihua.EducationWeb.Modules.Forum.TopicTypeSub" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div>
        <a href='TopicTypeSub.aspx?TypeId=<%=TopicType["TypeId"] %>' style="float:left">
            <img src="../../Images/topicicon.png" alt='<%=TopicType["TypeName"] %>'  class="thumbnail"/>
        </a>
        <div  style=" float:left; margin:-10px 5px 0px 5px; padding:5px;">
        <h3>
            <%=TopicType["TypeName"] %>
        </h3>
        <div>
            发帖数：
            <span class="label label-success">
                <%=TopicType["topicCount"]%>
            </span>
            回复数：
            <span class="label label-success">
                <%=TopicType["replyCount"]%>
            </span>
        </div>
        </div>
        <div style=" float:right"> 
            <asp:Button ID="btnCreatePost" runat="server" Text="发布帖子" OnClick="btnCreatePost_Click" CssClass="btn btn-success"/>
        </div>
    </div>
    <hr  style="clear:both"/>
    
    <asp:Repeater ID="rptTopicList" runat="server" DataSourceID="SqlDataSource1">
        <ItemTemplate>
            <div>
                <div style="float:left; width:95px; height:85px; margin:5px;">
                    <img src='<%#Eval("PicUrl") %>' alt='<%#Eval("UserName") %>' />
                </div>
                <div style=" float:left">
                    <div>
                        <h4>
                            <a href='Topic.aspx?TopicId=<%#Eval("TopicId") %>&TypeId=<%=TopicType["TypeId"] %>'><%#Eval("Title")%></a>
                        </h4>
                    </div>
                    <div>
                        <span class="label label-primary"><%#Eval("UserName")%></span>发表•
                        <span class="label label-success"><%#Eval("replyCount")%></span>个回复•
                        <span><%#Eval("CreateDate")%></span>
                        <asp:Button ID="btnReplyPost" runat="server" Text="回复" OnClick="btnReplyPost_Click" 
                        CssClass="btn btn-success btn-xs" _id='<%#Eval("TopicId") %>'/>
                    </div>
                </div>   
            </div>
             
           <hr style=" clear:both" />
        </ItemTemplate>
    </asp:Repeater>

    <asp:SqlDataSource ID="SqlDataSource1" runat="server"  ConnectionString="<%$ ConnectionStrings:DuihuaDB %>" 
    SelectCommand="SELECT c.[TopicId]
                          ,c.[Title]
                          ,c.[Content]
                          ,c.[CreateDate]
                          ,c.[Creator]
                          ,c.[TypeId]
                          ,au.UserName
                          ,(SELECT TOP 1 isnull(replace(x.PicUrl,'~',''),'/Images/noimage_small.jpg') FROM (
      	                        SELECT s.PicUrl FROM dbo.Student s WHERE au.UserId =s.UserId
		                        UNION
		                        SELECT t.PicUrl FROM Teacher t WHERE t.UserId = au.UserId
		                        )x
                              )PicUrl
                          ,(SELECT COUNT(1) FROM TopicReply r where r.TopicId = c.TopicId) replyCount
                      FROM  [dbo].[Topic] c
                      INNER JOIN aspnet_Users au ON au.UserId = c.[Creator]
                    WHERE c.typeid = @TypeId
                    ORDER BY [CreateDate] DESC"
     InsertCommand="INSERT INTO [dbo].[Topic]
                       ([TopicId]
                       ,[Title]
                       ,[Content]
                       ,[CreateDate]
                       ,[Creator]
                       ,[TypeId])
                 VALUES
                       (@TopicId
                       ,@Title
                       ,@Content
                       ,GETDATE()
                       ,@Creator
                       ,@TypeId)"
     UpdateCommand="UPDATE [dbo].[Topic]
                       SET 
                          [Title] = @Title
                          ,[Content] = @Content
                     WHERE [TopicId] = @TopicId">
    <SelectParameters>
        <asp:QueryStringParameter Name="TypeId" QueryStringField="TypeId" />
    </SelectParameters>
    <InsertParameters>
        <asp:ControlParameter Name="TopicId" ControlID="eTopicId"/>
        <asp:ControlParameter Name="Title" ControlID="eTitle"/>
        <asp:ControlParameter Name="Content" ControlID="eContent" PropertyName="InnerText"/>
        <asp:SessionParameter Name="Creator" SessionField="UserId" />
        <asp:QueryStringParameter Name="TypeId" QueryStringField="TypeId" />
    </InsertParameters>
    <UpdateParameters>
        <asp:ControlParameter Name="Content" ControlID="eContent" PropertyName="InnerText"/>
        <asp:ControlParameter Name="Title" ControlID="eTitle"/>
        <asp:ControlParameter Name="TopicId" ControlID="eTopicId"/>
    </UpdateParameters>
    </asp:SqlDataSource>
    
    <div class="panel panel-success" runat="server" visible="false" id="detail">
        <div class="panel-heading">
            <h3 class="panel-title">编辑帖子</h3>
        </div>
        <div class="panel-body" id="panelbody" runat="server">
            <div class="form-group">
                <label for="Title">标题：</label>
                <asp:TextBox ID="eTitle" name="Title" runat="server"  ClientIDMode="Static" CssClass="form-control"></asp:TextBox>
                 <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="eTitle" 
                CssClass="failureNotification" ErrorMessage="必须填写“标题”。" ToolTip="必须填写“标题”。">*</asp:RequiredFieldValidator>
            </div>
            <div class="form-group">
                <textarea id="eContent" name="Content" style=" height:200px;" runat="server" cols="40" rows="10" clientidmode="Static"></textarea>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="eContent" 
                CssClass="failureNotification" ErrorMessage="必须填写“内容”。" ToolTip="必须填写“内容”。" >*</asp:RequiredFieldValidator>
                <asp:TextBox ID="eTopicId" name="TopicId" runat="server" style="display:none"></asp:TextBox>
            </div> 
        </div>
        <div class="panel-footer">
            <div class="form-group">
                <asp:Button ID="btnSave" runat="server" Text="保存"  ValidationGroup="vs" OnClick="btnSave_Click" CssClass="btn btn-primary"/>
                <asp:Button ID="btnBack" runat="server" Text="返回"  OnClick="btnBackList_Click" CssClass="btn btn-default"/>
            </div>
        </div>

        <script type="text/javascript" charset="utf-8" src="<%=GetFullContextPath %>/scripts/Ueditor/ueditor.config.js"></script>
        <script type="text/javascript" charset="utf-8" src="<%=GetFullContextPath %>/scripts/Ueditor/ueditor.all.min.js"> </script>
        <script type="text/javascript" charset="utf-8" src="<%=GetFullContextPath %>/scripts/Ueditor/lang/zh-cn/zh-cn.js"></script>
        <script type="text/javascript">
            window.UEDITOR_CONFIG.toolbars = [['source', 'undo', 'redo', '|',
                'bold', 'italic', 'underline', 'fontborder', 'strikethrough', 'superscript', 'subscript', 'removeformat', 'formatmatch', 'autotypeset', 'blockquote', 'pasteplain', '|',
                'forecolor', 'backcolor', 'insertorderedlist', 'insertunorderedlist', 'selectall', 'cleardoc', '|',
                'rowspacingtop', 'rowspacingbottom', 'lineheight', 'fontsize', 'directionalityltr', 'directionalityrtl', 'indent', '|',
                'justifyleft', 'justifycenter', 'justifyright', 'justifyjustify', 'link', 'unlink', 'anchor', '|',
                'insertimage', 'emotion', 'scrawl', 'insertvideo', 'music', 'attachment', 'map', 'insertframe', '|',
                'horizontal', 'date', 'time', 'spechars', 'snapscreen', 'preview']];
            UE.getEditor('<%=eContent.ClientID %>');
        </script>
    </div>
</asp:Content>
