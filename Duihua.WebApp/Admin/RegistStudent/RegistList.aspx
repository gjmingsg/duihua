<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/ListMasterPage.master" AutoEventWireup="true" CodeBehind="RegistList.aspx.cs" Inherits="Duihua.WebApp.Admin.RegistStudent.RegistList" %>
<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Script" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="List" runat="server">
<div id="listTemplate" runat="server">
  <div class="block"> 
            <div class="fl">
                    <asp:Button runat="server" ID="btnNew" ClientIDMode="Static"   Text="添加班级"  onclick="btnNew_Click"/></div>
			<div class="fr" id="search">
                报名人名称:   <asp:TextBox runat="server" ID="tbRegistName" ></asp:TextBox>
			    报名号:        <asp:TextBox runat="server" ID="tbRegisterNo" ></asp:TextBox>
                注册状态：  <asp:DropDownList runat="server" ID="ddStatus">
                            <asp:ListItem Value='0' Text="报名中"></asp:ListItem>
                            <asp:ListItem Value='1' Text="结束报名"></asp:ListItem>
                        </asp:DropDownList>
                        <asp:HiddenField ID="hdbegin" runat="server" />
                        <asp:HiddenField ID="hdend" runat="server" />
                        <asp:Button runat="server" ID="btnSearch" ClientIDMode="Static"   Text="搜索" onclick="btnSearch_Click"/>
                        
            </div> 
  	        <div class="clear"></div>
		</div>
         <asp:GridView ID="classList" runat="server"  
         CssClass="fullwidth table_solid" AutoGenerateColumns="False" DataSourceID="ClassDataSource"
         DataKeyNames="ID">
             <Columns>
                 <asp:BoundField DataField="RegistName" HeaderText="报名人"  />
                 <asp:BoundField DataField="QQ" HeaderText="QQ"/>
                 <asp:BoundField DataField="Email" HeaderText="Email"/>
                 <asp:BoundField DataField="Phone" HeaderText="手机"/>
                 <asp:BoundField DataField="ClassName" HeaderText="报名班级" />
                 <asp:BoundField DataField="RegisterNo" HeaderText="报名号" />
                 <asp:BoundField DataField="Address" HeaderText="地址" />
                 <asp:BoundField DataField="Status" HeaderText="注册状态" />
                 <asp:BoundField DataField="CreateTime" HeaderText="创建时间" />
                 <asp:TemplateField HeaderText="操作" ShowHeader="True"  HeaderStyle-Width="200">
       
        <ItemTemplate>
                <asp:LinkButton ID="lbDelete"
             CssClass="fl btn3"  runat="server" _Id='<%#Eval("ID") %>' OnClientClick="return confirm('确认要删除吗？');"  OnClick="lbOperator_Click"  CommandName="Delete" Text="删除"></asp:LinkButton>
                <asp:LinkButton ID="lbEdit" _Id='<%#Eval("ID") %>'
             CssClass="fl btn2"  runat="server"  OnClick="lbOperator_Click" CommandName="EditReg" Text="编辑" ></asp:LinkButton>
               <asp:LinkButton ID="lbView" _Id='<%#Eval("ID") %>'
             CssClass="fl btn5"  runat="server"   OnClick="lbOperator_Click" CommandName="View" Text="查看" ></asp:LinkButton>
        </ItemTemplate>
   </asp:TemplateField>
             </Columns>

         </asp:GridView>
         <asp:SqlDataSource ID="ClassDataSource" runat="server" 
         SelectCommand="SELECT * FROM(
SELECT [RegisterInfo].[ID],
       [RegistName],
       [QQ],
       [Email],
       [Phone],
       [RegisterInfo].[Intro],
       ci.ClassName,
       [RegisterNo],
       [Address],
       [Status],
       [CreateTime],
       ROW_NUMBER()OVER(ORDER BY [RegisterInfo].CreateTime DESC) pageIndex
FROM   [RegisterInfo]
INNER JOIN ClassInfo ci ON ci.ID = [RegisterInfo].ClassID
WHERE  1 = 1
 order x.pageIndex asc"

         UpdateCommand="     
UPDATE [RegisterInfo]
SET    [RegistName] = @RegistName,
       [QQ] = @QQ,
       [Email] = @Email,
       [Phone] = @Phone,
       [Intro] = @Intro,
       [ClassID] = @ClassID,
       [RegisterNo] = @RegisterNo,
       [Address] = @Address,
       [Status] = @Status
WHERE  [ID] = @ID"

        DeleteCommand="DELETE FROM [RegisterInfo] WHERE [ID] = @ID "
         
        InsertCommand="INSERT INTO [RegisterInfo]
  (
    [ID],
    [RegistName],
    [QQ],
    [Email],
    [Phone],
    [Intro],
    [ClassID],
    [RegisterNo],
    [Address],
    [Status],
    [CreateTime]
  )
VALUES
  (
    NEWID(),
    @RegistName,
    @QQ,
    @Email,
    @Phone,
    @Intro,
    @ClassID,
    @RegisterNo,
    @Address,
    @Status,
    GETDATE()
  )" 
        ConnectionString="<%$ ConnectionStrings:DuihuaDB %>" 
       >
    <UpdateParameters>
        <asp:ControlParameter Name="ID" Type="Object" ControlID="eID" />
        <asp:ControlParameter Name="RegistName" Type="String" ControlID="eRegistName"/>
        <asp:ControlParameter Name="QQ" Type="String" ControlID="eQQ" />
        <asp:ControlParameter Name="Email" Type="String"  ControlID="eEmail"/>
        <asp:ControlParameter Name="Phone" Type="String"  ControlID="ePhone"/>
        <asp:ControlParameter Name="Intro" Type="String"  ControlID="eIntro"/>
        <asp:ControlParameter Name="ClassID" Type="Object" ControlID="ddClassName"/>
        <asp:ControlParameter Name="Address" Type="String" ControlID="eAddress" />
        <asp:ControlParameter Name="Status" Type="Int32"  ControlID="ddStatus"/>
     
    </UpdateParameters>
    <InsertParameters>
          
        <asp:ControlParameter Name="RegistName" Type="String" />
        <asp:ControlParameter Name="RegistName" Type="String" ControlID="eRegistName"/>
        <asp:ControlParameter Name="QQ" Type="String" ControlID="eQQ" />
        <asp:ControlParameter Name="Email" Type="String"  ControlID="eEmail"/>
        <asp:ControlParameter Name="Phone" Type="String"  ControlID="ePhone"/>
        <asp:ControlParameter Name="Intro" Type="String"  ControlID="eIntro"/>
        <asp:ControlParameter Name="ClassID" Type="Object" ControlID="ddClassName"/>
        <asp:ControlParameter Name="Address" Type="String" ControlID="eAddress" />
        <asp:ControlParameter Name="Status" Type="Int32"  ControlID="ddStatus"/>
      
    </InsertParameters>
    <DeleteParameters>
        <asp:Parameter Name="ID" Type="Object" />
    </DeleteParameters>
</asp:SqlDataSource>

         共<asp:Label ID="lblCount" runat="server" Text="0"></asp:Label>条数据&nbsp;
        <webdiyer:aspnetpager id="AspNetPager1"  runat="server" Width="500px" FirstPageText="首页" 
        LastPageText="尾页" NextPageText="下一页" PrevPageText="上一页" Height="40px" 
        ShowInputBox="Always" TextAfterInputBox="页"  OnPageChanging="AspNetPager1_PageChanging" 
        PageSize="10" TextBeforeInputBox="跳转到第" AlwaysShow="True" 
        CssClass="page_list"> 
        </webdiyer:aspnetpager> 
    </div>

  <div id="detailTemplate" runat="server">
   <fieldset >
    <fieldset >
    <legend>报名人信息</legend>
            报名号：<asp:Label  runat="server" name="RegisterNo"></asp:Label>
            <br />
            <br />
            报名人：<asp:Label runat="server" name="RegistName"></asp:Label>
            <br />
            <br />
            QQ：<asp:Label runat="server" name="QQ"></asp:Label>
            <br />
            <br />
            Email：<asp:Label runat="server" name="Email"></asp:Label>
            <br />
            <br />
            手机：<asp:Label runat="server" name="Phone"></asp:Label>
             <br />
            <br />
             班级：<asp:Label runat="server" name="ClassName"></asp:Label>
            <br />
            <br />
           地址：<asp:Label  runat="server" name="Address"></asp:Label>
            <br />
            <br />
           注册状态：<asp:Label  runat="server" name="Status"></asp:Label>

       </fieldset>
            <br />
            <br />
            自我简介：<div><br /><asp:Label runat="server" name="Intro"></asp:Label></div>
            <br />
            <br />
         <asp:Button  runat="server" Text="关闭" onclick="btnBackList_Click"/>
   </fieldset>
  </div>

 <div id="editTemplate" runat="server">
 
                  
                    <span class="failureNotification">
                        <asp:Literal ID="ErrorMessage" runat="server"></asp:Literal>
                    </span>
                    <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="failureNotification" 
                         ValidationGroup="RegisterArtValidationGroup"/>
                    <div class="classInfo">
                        <fieldset >
                            <legend>报名人信息</legend>
                            <p class="submitButton">
                            
                                  <asp:Button  runat="server" Text="保存" OnClick="btnSave_Click"
                                   ValidationGroup="RegisterArtValidationGroup"/>
                                <asp:Button   runat="server" Text="关闭" onclick="btnBackList_Click"/>
                             </p>
                            <p>
                                <asp:Label runat="server" AssociatedControlID="eRegistName">报名人:</asp:Label>
                                <asp:TextBox ID="eRegistName" 
                                    runat="server" CssClass="textEntry" name="RegistName"></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="eRegistName" 
                                     CssClass="failureNotification" ErrorMessage="必须填写“注册人名称”。" ToolTip="必须填写“注册人名称”。" 
                                     ValidationGroup="RegisterArtValidationGroup">*</asp:RequiredFieldValidator>
                            </p>
                            <p>
                                <asp:Label runat="server" AssociatedControlID="eQQ">QQ:</asp:Label>
                                <asp:TextBox ID="eQQ" runat="server" 
                                    CssClass="textEntry" name="QQ"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="eQQ" 
                                     CssClass="failureNotification" ErrorMessage="必须填写“QQ”。" ToolTip="必须填写“QQ”。" 
                                     ValidationGroup="RegisterArtValidationGroup">*</asp:RequiredFieldValidator>
                            </p>
                             <p>
                                <asp:Label runat="server" AssociatedControlID="eEmail">Email:</asp:Label>
                                <asp:TextBox ID="eEmail" runat="server" CssClass="textEntry"  name="Email"/>
                                 <asp:RequiredFieldValidator  runat="server" ControlToValidate="eEmail" 
                                     CssClass="failureNotification" ErrorMessage="必须填写“Email”。" ToolTip="必须填写“Email”。" 
                                     ValidationGroup="RegisterArtValidationGroup">*</asp:RequiredFieldValidator>
                                 
                            </p>
                            <p>
                                 <asp:Label runat="server" AssociatedControlID="ePhone">手机:</asp:Label>
                                  <asp:TextBox  ID="ePhone" runat="server" CssClass="textEntry"  name="Phone" />
                                  <asp:RequiredFieldValidator  runat="server" ControlToValidate="ePhone" 
                                     CssClass="failureNotification" ErrorMessage="必须填写“手机”。" ToolTip="必须填写“手机”。" 
                                     ValidationGroup="RegisterArtValidationGroup">*</asp:RequiredFieldValidator>
                                
                            </p>
                            <p>
                                <asp:Label runat="server" AssociatedControlID="ddClassName">班级:</asp:Label>
                                <asp:DropDownList runat="server" ID="ddClassName" name="ClassName" AppendDataBoundItems="true"
                                 DataSourceID="ClassNameDataSource" DataValueField="ID" DataTextField="ClassName">
                                    <asp:ListItem Text="--请选择班级--" Value=""></asp:ListItem>
                                </asp:DropDownList>
                                <asp:SqlDataSource ID="ClassNameDataSource" runat="server"    ConnectionString="<%$ ConnectionStrings:DuihuaDB %>" 
                                   SelectCommand="SELECT ci.ID,ci.ClassName FROM ClassInfo ci WHERE  ci.IsFinish = 0"
                                ></asp:SqlDataSource>
                            </p>
                              <p>
                                <asp:Label runat="server" AssociatedControlID="eAddress">地址:</asp:Label>
                                  <asp:TextBox  ID="eAddress" runat="server" CssClass="textEntry"  name="Address" />
                            </p>
                        </fieldset>

                         <p><asp:Label ID="Label12" AssociatedControlID="eIntro" runat="server">自我简介:</asp:Label>
                             <div>
                                 <textarea id="eIntro" name="Intro" runat="server" cols="20" rows="2" clientidmode="Static"></textarea>

                                 <asp:RequiredFieldValidator  runat="server" ControlToValidate="eIntro" 
                                     CssClass="failureNotification" ErrorMessage="必须填写“自我简介”。" ToolTip="必须填写“自我简介”。" 
                                     ValidationGroup="RegisterArtValidationGroup">*</asp:RequiredFieldValidator>
                        <script type="text/javascript" charset="utf-8" src="<%=GetFullContextPath %>/Admin/Ueditor/ueditor.config.js"></script>
                         <script type="text/javascript" charset="utf-8" src="<%=GetFullContextPath %>/Admin/Ueditor/ueditor.all.min.js"> </script>
                         <script type="text/javascript" charset="utf-8" src="<%=GetFullContextPath %>/Admin/Ueditor/lang/zh-cn/zh-cn.js"></script>
                        <script type="text/javascript">
                            UE.getEditor('<%=eIntro.ClientID %>');
                         </script>
                                </div> 
                       
                         </p>
                         
                         <asp:TextBox ID="eID" runat="server" name="ID" Visible="false"></asp:TextBox>
                        
                        <p class="submitButton">
                            
                                  <asp:Button ID="Button4" runat="server" Text="保存" OnClick="btnSave_Click"
                                   ValidationGroup="RegisterArtValidationGroup"/>
                                <asp:Button ID="Button5"  runat="server" Text="关闭" onclick="btnBackList_Click"/>
                        </p>
                         </div>

  
 </div>


</asp:Content>
