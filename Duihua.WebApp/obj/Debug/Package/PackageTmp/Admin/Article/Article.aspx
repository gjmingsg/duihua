<%@ Page ValidateRequest="false" Language="C#" MasterPageFile="~/Admin/ListMasterPage.master"  AutoEventWireup="true"
 CodeBehind="Article.aspx.cs" Inherits="Duihua.WebApp.Admin.Article.Article" %>
<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>


<asp:Content ID="Content1" ContentPlaceHolderID="Script" runat="server">
   <meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="List" runat="server">
 <div id="listTemplate" runat="server">
 <div class="block"> 
 
			<div class="fl"><asp:Button runat="server" ID="btnNew" ClientIDMode="Static"   Text="发表文章"  onclick="btnNew_Click"/></div>
			<div class="fr" id="search"> 
            <!--
            分类:       <asp:DropDownList runat="server" ID="ddTypeId" AppendDataBoundItems='true' DataSourceID="TypeDataSource"
                          DataTextField="TypeName" DataValueField="ID">
                             <asp:ListItem Value="" Text="---请选择---"></asp:ListItem>
                        </asp:DropDownList>
            状态:       <asp:DropDownList runat="server" ID="ddStatus">
                            <asp:ListItem Value="" Text="---请选择---"></asp:ListItem>
                            <asp:ListItem Value='0' Text="草稿"></asp:ListItem>
                            <asp:ListItem Value='1' Text="发布"></asp:ListItem>
                        </asp:DropDownList>
                        --->
            标题:       <asp:TextBox runat="server" ID="tbTitle" ></asp:TextBox>
			文章内容:   <asp:TextBox runat="server" ID="tbContent" ></asp:TextBox>
                        <asp:HiddenField ID="hdbegin" runat="server" />
                        <asp:HiddenField ID="hdend" runat="server" />

                        <asp:Button runat="server" ID="btnSearch" ClientIDMode="Static"   Text="搜索" onclick="btnSearch_Click"/>
                        
                        <asp:SqlDataSource ID="TypeDataSource" runat="server"  ConnectionString="<%$ ConnectionStrings:DuihuaDB %>"
                         SelectCommand="SELECT * FROM ArticleType at  where at.ParentID =@ID order by at.TypeCode asc">
                          <SelectParameters>
                            <asp:QueryStringParameter ConvertEmptyStringToNull="false" Name="ID" QueryStringField="ID" />
                          </SelectParameters>
                         </asp:SqlDataSource>
                        
			</div>
			<div class="clear"></div>
		</div><!--end: block -->
		
    <asp:GridView ID="artlist" runat="server" DataKeyNames="ID" DataSourceID="Artsource" CssClass="fullwidth table_solid" AutoGenerateColumns="false">
    <Columns>
    <asp:BoundField DataField="pageIndex" HeaderText="序号"  HeaderStyle-Width="40" />
    <asp:TemplateField>
        <HeaderTemplate>标题</HeaderTemplate>
        <ItemTemplate>
            <a href='<%=FontBaseUrl %>/Detail/<%#Eval("ID") %>' target="_blank"><%#Eval("Title") %></a>
        </ItemTemplate>
    </asp:TemplateField>
    <asp:BoundField DataField="Author" HeaderText="作者姓名" HeaderStyle-Width="70" />   
    <asp:BoundField DataField="TypeName" HeaderText="文章分类"  HeaderStyle-Width="70"/>
    <asp:BoundField DataField="UpdateTime" HeaderText="更新时间" />
    <asp:BoundField DataField="CreateTime" HeaderText="创建时间" />
    <asp:BoundField DataField="Content" HeaderText="内容" />
    <asp:BoundField DataField="Status"  HeaderText="状态" HeaderStyle-Width="40" />
    <asp:TemplateField HeaderText="操作" ShowHeader="True"  HeaderStyle-Width="200">
       
        <ItemTemplate>
                <asp:LinkButton ID="lbDelete"
             CssClass="fl btn3"  runat="server" _Id='<%#Eval("ID") %>' OnClientClick="return confirm('确认要删除吗？');"  OnClick="lbOperator_Click"  CommandName="Delete" Text="删除"></asp:LinkButton>
              
                <asp:LinkButton ID="lbEdit" _Id='<%#Eval("ID") %>'
             CssClass="fl btn2"  runat="server"  OnClick="lbOperator_Click" CommandName="EditArt" Text="编辑" ></asp:LinkButton>

                <asp:LinkButton ID="lbPublish" _Id='<%#Eval("ID") %>'
             CssClass="fl btn1"  runat="server"   OnClick="lbOperator_Click" CommandName="Publish" Text="发布" ></asp:LinkButton>

               <asp:LinkButton ID="lbView" _Id='<%#Eval("ID") %>'
             CssClass="fl btn5"  runat="server"   OnClick="lbOperator_Click" CommandName="View" Text="查看" ></asp:LinkButton>
        </ItemTemplate>
   </asp:TemplateField>
    </Columns>
    </asp:GridView>
    
  <asp:SqlDataSource SelectCommand="
  SELECT x.ID
,x.Title
,x.Author
,left(cast(x.[Content] as nvarchar(250)),150) + '...' as Content
,x.TypeName
,x.CreateTime
,x.UpdateTime
,x.UpdateUser
,case x.[Status] WHEN 1 THEN '发布'
ELSE '草稿' end [Status]
,x.pageIndex FROM (
SELECT a.*,at.TypeName,ROW_NUMBER()OVER(ORDER BY updatetime desc)pageIndex FROM Article a INNER JOIN ArticleType at
ON at.ID = a.TypeId
WHERE 1=1
AND a.Title LIKE '%' +@Title+ '%'
AND(a.[Content] is null or a.[Content] LIKE '%'+@Content+'%')
and AT.ParentID = @QTypeId
) x 
WHERE x.pageIndex BETWEEN @begin AND @end
ORDER BY x.pageIndex"
  
 UpdateCommand="UPDATE [dbo].[Article]
   SET [Title] = @Title
      ,[Author] = @Author
      ,[Content] = @Content
      ,[TypeId] = @TypeId
      ,[UpdateTime] = GETDATE()
      ,[UpdateUser] = @UpdateUser
      ,[Status] =@Status
 WHERE id = @Id"

 DeleteCommand="DELETE FROM Article WHERE ID = @ID"

 InsertCommand="INSERT INTO [dbo].[Article]
           ([ID]
           ,[Title]
           ,[Author]
           ,[Content]
           ,[TypeId]
           ,[CreateTime]
           ,[UpdateTime]
           ,[UpdateUser]
           ,[Creator]
           ,[Status])
     VALUES
           (NEWID()
           ,@Title
           ,@Author
           ,@Content
           ,@TypeId
           ,GETDATE()
           ,GETDATE()
           ,@UpdateUser
           ,@Creator
           ,@Status)"
  ConnectionString="<%$ ConnectionStrings:DuihuaDB %>" runat="server" ID="Artsource">
  <SelectParameters>
    
     <asp:ControlParameter  ControlID="tbContent" ConvertEmptyStringToNull="false" Name="Content"/>
     <asp:ControlParameter  ControlID="tbTitle" ConvertEmptyStringToNull="false" Name="Title"/>
     <asp:ControlParameter ControlID="hdend"  ConvertEmptyStringToNull="false" Name="end" />
     <asp:ControlParameter ControlID="hdbegin"  ConvertEmptyStringToNull="false" Name="begin" />
     <asp:QueryStringParameter ConvertEmptyStringToNull="true" Name="QTypeId" QueryStringField="ID" />
  </SelectParameters> 
  
   <DeleteParameters>
      <asp:Parameter Name="ID" DbType="Guid" />
   </DeleteParameters>

   <InsertParameters>
      <asp:ControlParameter ControlID="eContent" ConvertEmptyStringToNull="false" Name="Content" PropertyName="InnerText"/>
     <%--<asp:Parameter Name="Content" DbType="String" />--%>
     <asp:ControlParameter ControlID="eTitle"   ConvertEmptyStringToNull="false" Name="Title"/>
     <asp:ControlParameter ControlID="eAuthor"  ConvertEmptyStringToNull="false" Name="Author" />
     <asp:ControlParameter ControlID="eCreator"  ConvertEmptyStringToNull="false" Name="Creator" />
     <asp:ControlParameter ControlID="eUpdateUser" ConvertEmptyStringToNull="false" Name="UpdateUser" />
     <asp:ControlParameter ControlID="eTypeId"  ConvertEmptyStringToNull="true" Name="TypeId" />
     <asp:ControlParameter ControlID="eStatus"  ConvertEmptyStringToNull="false" Name="Status" />
   </InsertParameters>

   <UpdateParameters>
     <asp:ControlParameter ControlID="eContent" ConvertEmptyStringToNull="false" Name="Content" PropertyName="InnerText"/>
    <%--<asp:Parameter Name="Content" DbType="String" />--%>
     <asp:ControlParameter ControlID="eTitle"   ConvertEmptyStringToNull="false" Name="Title"/>
     <asp:ControlParameter ControlID="eAuthor"  ConvertEmptyStringToNull="false" Name="Author" />
     <asp:ControlParameter ControlID="eUpdateUser"  ConvertEmptyStringToNull="false" Name="UpdateUser" />
     <asp:ControlParameter ControlID="eTypeId"  ConvertEmptyStringToNull="true" Name="TypeId" />
     <asp:ControlParameter ControlID="eID" ConvertEmptyStringToNull="false" Name="Id"/>
     <asp:ControlParameter ControlID="eStatus"  ConvertEmptyStringToNull="false" Name="Status" />
   </UpdateParameters>
  </asp:SqlDataSource>

    共<asp:Label ID="lblCount" runat="server" Text="0"></asp:Label>条数据&nbsp;
    <webdiyer:AspNetPager id="AspNetPager1"  runat="server" Width="500px" FirstPageText="首页" 
    LastPageText="尾页" NextPageText="下一页" PrevPageText="上一页" Height="40px" 
    ShowInputBox="Always" TextAfterInputBox="页"  OnPageChanging="AspNetPager1_PageChanging" 
    PageSize="10" TextBeforeInputBox="跳转到第" AlwaysShow="True" CssClass="page_list"> 
    </webdiyer:AspNetPager> 
    </div>

    <div id="detailTemplate" runat="server" visible="false">
      <fieldset >
            标题：<asp:Label ID="Label1" runat="server" name="Title"></asp:Label>
            <br />
            <br />
            作者：<asp:Label ID="Label2" runat="server" name="Author"></asp:Label>
            <br />
            <br />
            发表时间：<asp:Label ID="Label3" runat="server" name="CreateTime"></asp:Label>
       </fieldset>
            <br />
            <br />
            内容：<div><br /><asp:Label ID="Label4" runat="server" name="Content"></asp:Label></div>
            <br />
            <br />
         <asp:Button runat="server" Text="关闭" onclick="btnBackList_Click"/>
    </div>

    <div id="editTemplate" runat="server" visible="false">
            <h2>
                文章明细
            </h2>
                  
                    <span class="failureNotification">
                        <asp:Literal ID="ErrorMessage" runat="server"></asp:Literal>
                    </span>
                    <asp:ValidationSummary ID="RegisterArtValidationSummary" runat="server" CssClass="failureNotification" 
                         ValidationGroup="RegisterArtValidationGroup"/>
                    <div class="artInfo">
                        <fieldset >
                            <legend>文章信息</legend>
                            <p class="submitButton">
                            
                                  <asp:Button ID="Button2" runat="server" Text="保存" OnClick="btnSave_Click"
                                   ValidationGroup="RegisterArtValidationGroup"/>
                                <asp:Button ID="Button3"  runat="server" Text="关闭" onclick="btnBackList_Click"/>
                             </p>
                            <p>
                                <asp:Label ID="lbeTitle" runat="server" AssociatedControlID="eTitle">标题:</asp:Label>
                                <asp:TextBox ID="eTitle" runat="server" CssClass="textEntry" name="Title"></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="eTitle" 
                                     CssClass="failureNotification" ErrorMessage="必须填写“标题”。" ToolTip="必须填写“标题”。" 
                                     ValidationGroup="RegisterArtValidationGroup">*</asp:RequiredFieldValidator>
                            </p>
                            <p>
                                <asp:Label ID="lbAuthor" runat="server" AssociatedControlID="eAuthor">作者:</asp:Label>
                                <asp:TextBox ID="eAuthor" runat="server" CssClass="textEntry" Text="管理员" name="Author"></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="eAuthor" 
                                     CssClass="failureNotification" ErrorMessage="必须填写“作者”。" ToolTip="必须填写“作者”。" 
                                     ValidationGroup="RegisterArtValidationGroup">*</asp:RequiredFieldValidator>
                            </p>
                             <p>
                                <asp:Label ID="Label5" runat="server" AssociatedControlID="eStatus">发布状态:</asp:Label>
                                <asp:DropDownList runat="server" ID="eStatus" name="Status">
                                    <asp:ListItem Value='1' Text="发布"></asp:ListItem>
                                     <asp:ListItem Value='0' Text="草稿"></asp:ListItem>
                                 </asp:DropDownList>
                            </p>
                            <p>
                                <asp:Label ID="lbTypeId" runat="server" AssociatedControlID="eTypeId">分类:</asp:Label>
                                <asp:DropDownList runat="server" ID="eTypeId" AppendDataBoundItems='true' DataSourceID="TypeDataSource"
                                     DataTextField="TypeName" DataValueField="ID" name="TypeId">
                                    <asp:ListItem Value="" Text="---请选择---"></asp:ListItem>
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="eTypeId" 
                                     CssClass="failureNotification" ErrorMessage="必须填写“分类”。" ToolTip="必须填写“分类”。" 
                                     ValidationGroup="RegisterArtValidationGroup">*</asp:RequiredFieldValidator>
                            </p>
                           
                        </fieldset>
                         <p><asp:Label ID="lbContent" runat="server">内容:</asp:Label>
                             <div>
                                 <textarea id="eContent" name="Content" runat="server" cols="20" rows="2" clientidmode="Static"></textarea>

                                 <asp:RequiredFieldValidator runat="server" ControlToValidate="eContent" 
                                     CssClass="failureNotification" ErrorMessage="必须填写“内容”。" ToolTip="必须填写“内容”。" 
                                     ValidationGroup="RegisterArtValidationGroup">*</asp:RequiredFieldValidator>

                                </div> 
                         <script type="text/javascript" charset="utf-8" src="<%=GetFullContextPath %>/Admin/Ueditor/ueditor.config.js"></script>
                         <script type="text/javascript" charset="utf-8" src="<%=GetFullContextPath %>/Admin/Ueditor/ueditor.all.min.js"> </script>
                         <script type="text/javascript" charset="utf-8" src="<%=GetFullContextPath %>/Admin/Ueditor/lang/zh-cn/zh-cn.js"></script>
                        <script type="text/javascript">
                            UE.getEditor('<%=eContent.ClientID %>');
                         </script>
                         </p>
                         
                         <asp:TextBox ID="eID" runat="server" name="ID" Visible="false"></asp:TextBox>
                         <asp:TextBox ID="eUpdateUser" runat="server" name="UpdateUser" Visible="false"></asp:TextBox>
                         <asp:TextBox ID="eCreator" runat="server" name="Creator" Visible="false"></asp:TextBox>

                        <p class="submitButton">
                            
                                  <asp:Button ID="btnSave" runat="server" Text="保存" OnClick="btnSave_Click"
                                   ValidationGroup="RegisterArtValidationGroup"/>
                                <asp:Button ID="Button1"  runat="server" Text="关闭" onclick="btnBackList_Click"/>
                        </p>
                    </div>
       
    </div>
</asp:Content>
