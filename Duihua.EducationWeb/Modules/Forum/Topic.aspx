<%@ Page Title="" Language="C#" MasterPageFile="~/Layout/AdminDefault.Master" AutoEventWireup="true" ValidateRequest="false"
CodeBehind="Topic.aspx.cs" Inherits="Duihua.EducationWeb.Modules.Forum.Topic" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
<style type="text/css">
    .sub-reply{margin-left:95px; clear:left; border:1px solid #ddd;overflow:hidden;}
    .sub-picurl{float:left; width:95px; height:85px; margin:5px;clear:left}
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h3>
        <span  class="label label-info">
            <a href='TopicTypeSub.aspx?TypeId=<%=TopicType["TypeId"] %>'><%=TopicType["TypeName"] %></a>
         </span>
    </h3>
    <br />
    <div runat="server" id="topicDiv">
        <h2>
            <asp:Label ID="lTitle" name="Title" runat="server"></asp:Label>
        </h2>
        <div class="sub-picurl">
            <asp:Image ID="picUrl" runat="server" Width="95px" Height="85px"/>
        </div>
        <asp:Label ID="lCreateTime" name="CreateDate" runat="server" CssClass="label label-danger"></asp:Label>
        <asp:Button ID="btnReplyPost" runat="server" Text="回复" _RefReplyId=''
        OnClick="btnReplyPost_Click" CssClass="btn btn-success btn-xs btn-reply"  _id='<%=TopicId %>'/>
        <p>
            <asp:Label ID="lContent" name="Content" runat="server"></asp:Label>
        </p>
    </div>
    <br />
    <h3>
        <asp:Literal ID="lreplyCount" runat="server"></asp:Literal>个回复
    </h3>
    
    <hr />

    <div class="panel panel-success" runat="server" id="detail" visible="false">
        <div class="panel-heading">
            <h3 class="panel-title">回复</h3>
        </div>
        <div class="panel-body" id="panelbody" runat="server">
            <div class="form-group">
                <textarea id="eContent" name="Content" style=" height:150px;" runat="server" cols="40" rows="10" clientidmode="Static"></textarea>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="eContent" 
                CssClass="failureNotification" ErrorMessage="必须填写“内容”。" ToolTip="必须填写“内容”。" >*</asp:RequiredFieldValidator>
                <asp:TextBox ID="eReplyId" name="ReplyId" runat="server" style="display:none"></asp:TextBox>
                <asp:TextBox ID="eRefReplyId" name="RefReplyId" ClientIDMode="Static" runat="server" style="display:none"></asp:TextBox>
            </div> 
        </div>
        <div class="panel-footer">
            <div class="form-group">
                <asp:Button ID="btnSave" runat="server" Text="发布"  ValidationGroup="vs" OnClick="btnSave_Click" CssClass="btn btn-primary"/>
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

    <asp:Repeater ID="rptReply" runat="server" DataSourceID="SqlDataSource1">
        <ItemTemplate>
            <div>
                <div class="sub-picurl">
                    <img src='<%#Eval("PicUrl") %>' alt='<%#Eval("UserName") %>' />
                </div>
                <div style=" float:left">
                    <div>
                        <p><%#Eval("Content") %></p>
                        <span class="label label-primary"><%#Eval("UserName")%></span>•
                        <span class="label label-danger"><%#Eval("CreateTime")%></span>
                        <asp:Button ID="btnReplyPost" runat="server" Text="回复" _RefReplyId='<%#Eval("ReplyId") %>'
                         OnClick="btnReplyPost_Click" CssClass="btn btn-success btn-xs btn-reply"  _id='<%#Eval("TopicId") %>'/>
                    </div>
                </div>
                
                <asp:Repeater ID="rptRefReply" runat="server">
                    <HeaderTemplate>
                        <div class="sub-reply">
                    </HeaderTemplate>
                    <ItemTemplate>
                        <div class="sub-picurl">
                            <img src='<%#Eval("PicUrl") %>' alt='<%#Eval("UserName") %>' />
                        </div>
                        <div style="float:left">
                            <div>
                                <p><%#Eval("Content") %></p>
                                <span class="label label-primary"><%#Eval("UserName")%></span>•
                                <span class="label label-danger"><%#Eval("CreateTime")%></span>
                            </div>
                        </div>
                    </ItemTemplate>
                    <FooterTemplate>
                        </div>
                    </FooterTemplate>
                </asp:Repeater>
                
                <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:DuihuaDB %>" 
                 SelectCommand="SELECT r.[ReplyId]
                          ,r.[TopicId]
                          ,r.[Content]
                          ,r.[CreateTime]
                          ,r.[Creator]
                          ,r.[RefReplyId]
                          ,au.UserName
                          ,(SELECT TOP 1 isnull(replace(x.PicUrl,'~',''),'/Images/noimage_small.jpg') FROM (
      	                        SELECT s.PicUrl FROM dbo.Student s WHERE au.UserId =s.UserId
		                        UNION
		                        SELECT t.PicUrl FROM Teacher t WHERE t.UserId = au.UserId
		                        )x
                              )PicUrl
                      FROM [dbo].[TopicReply] r
                      INNER JOIN aspnet_Users au ON r.Creator = au.UserId
                    WHERE TopicId = @TopicId
                    AND r.RefReplyId = @ReplyId
                    ORDER BY CreateTime DESC">
                 <SelectParameters>
                    <asp:ControlParameter ControlID="ReplyId" Name="ReplyId" />
                    <asp:QueryStringParameter Name="TopicId" QueryStringField="TopicId" />
                 </SelectParameters>
                 </asp:SqlDataSource>
                    <asp:TextBox ID="ReplyId" runat="server" style="display:none" _id='<%#Eval("ReplyId") %>'></asp:TextBox>
            </div>
            
            <hr style=" clear:left" />
        </ItemTemplate>
    </asp:Repeater>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server"  ConnectionString="<%$ ConnectionStrings:DuihuaDB %>" 
    SelectCommand="SELECT r.[ReplyId]
                          ,r.[TopicId]
                          ,r.[Content]
                          ,r.[CreateTime]
                          ,r.[Creator]
                          ,r.[RefReplyId]
                          ,au.UserName
                          ,(SELECT TOP 1 isnull(replace(x.PicUrl,'~',''),'/Images/noimage_small.jpg') FROM (
      	                        SELECT s.PicUrl FROM dbo.Student s WHERE au.UserId =s.UserId
		                        UNION
		                        SELECT t.PicUrl FROM Teacher t WHERE t.UserId = au.UserId
		                        )x
                              )PicUrl
                      FROM [dbo].[TopicReply] r
                      INNER JOIN aspnet_Users au ON r.Creator = au.UserId
                    WHERE TopicId = @TopicId
                    AND r.RefReplyId IS NULL
                    ORDER BY CreateTime DESC"
    InsertCommand="INSERT INTO  [dbo].[TopicReply]
                           ([ReplyId]
                           ,[TopicId]
                           ,[Content]
                           ,[CreateTime]
                           ,[Creator]
                           ,[RefReplyId])
                     VALUES
                           (@ReplyId
                           ,@TopicId
                           ,@Content
                           ,GETDATE()
                           ,@Creator
                           ,@RefReplyId)"
    DeleteCommand="DELETE FROM TopicReply WHERE ReplyId = @ReplyId"
    UpdateCommand="UPDATE [dbo].[TopicReply]
                       SET [Content] = @Content
                          ,[RefReplyId] = @RefReplyId
                     WHERE [ReplyId] = @ReplyId">
        <SelectParameters>
            <asp:QueryStringParameter Name="TopicId" QueryStringField="TopicId" />
        </SelectParameters>
        <InsertParameters>
            <asp:ControlParameter Name="ReplyId" ControlID="eReplyId" />
            <asp:ControlParameter Name="Content" ControlID="eContent" PropertyName="InnerText"/>
            <asp:ControlParameter Name="RefReplyId" ControlID="eRefReplyId" />
            <asp:QueryStringParameter Name="TopicId" QueryStringField="TopicId" />
            <asp:SessionParameter Name="Creator" SessionField="UserId"/>
        </InsertParameters>
        <DeleteParameters>
            <asp:Parameter  Name="ReplyId"/>
        </DeleteParameters>
        <UpdateParameters>
            <asp:ControlParameter Name="ReplyId" ControlID="eReplyId" />
            <asp:ControlParameter Name="Content" ControlID="eContent" PropertyName="InnerText"/>
        </UpdateParameters>
    </asp:SqlDataSource>
   
    
</asp:Content>
