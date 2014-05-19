<%@ Page Title="班级信息" ValidateRequest="false" Language="C#" MasterPageFile="~/Admin/ListMasterPage.master" AutoEventWireup="true" CodeBehind="ClassList.aspx.cs" Inherits="Duihua.WebApp.Admin.RegistStudent.ClassList" %>
<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Script" runat="server">
<script type="text/javascript" src="../../Scripts/My97DatePicker/WdatePicker.js" ></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="List" runat="server">
 <div id="listTemplate" runat="server">
  <div class="block"> 
            <div class="fl">
                    <asp:Button runat="server" ID="btnNew" ClientIDMode="Static"   Text="添加班级"  onclick="btnNew_Click"/></div>
			<div class="fr" id="search">
            班级名称:   <asp:TextBox runat="server" ID="tbClassName" ></asp:TextBox>
			开班年份:   <asp:TextBox runat="server" ID="tbYear" ></asp:TextBox>
            报名状态：  <asp:DropDownList runat="server" ID="ddIsFinish">
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
                 <asp:BoundField DataField="ClassName" HeaderText="班级名称" />
                 <asp:BoundField DataField="Year" HeaderText="班级年度" />
                 <asp:BoundField DataField="StartTime" HeaderText="报名开始时间" />
                 <asp:BoundField DataField="EndTime" HeaderText="报名结束时间" />
                 <asp:BoundField DataField="IsFinish" HeaderText="是否结束报名" />
                 <asp:TemplateField HeaderText="操作" ShowHeader="True"  HeaderStyle-Width="200">
                 <ItemTemplate>
                      <asp:LinkButton ID="lbDelete"
             CssClass="fl btn3"  runat="server" _Id='<%#Eval("ID") %>' OnClientClick="return confirm('确认要删除吗？');"  OnClick="lbOperator_Click"  CommandName="Delete" Text="删除"></asp:LinkButton>
              
                <asp:LinkButton ID="lbEdit" _Id='<%#Eval("ID") %>'
             CssClass="fl btn2"  runat="server"  OnClick="lbOperator_Click" CommandName="EditClass" Text="编辑" ></asp:LinkButton>

               <asp:LinkButton ID="lbView" _Id='<%#Eval("ID") %>'
             CssClass="fl btn5"  runat="server"   OnClick="lbOperator_Click" CommandName="View" Text="查看" ></asp:LinkButton>
                 </ItemTemplate>
                 </asp:TemplateField>
             </Columns>

         </asp:GridView>
         <asp:SqlDataSource ID="ClassDataSource" runat="server" 
         SelectCommand="SELECT x.ID
,x.ClassName
,x.[Year]
,x.StartTime
,x.EndTime
,x.pageIndex
,x.Intro
,case when x.IsFinish=1 THEN '结束报名'
ELSE '报名中' end IsFinish FROM (
SELECT *,ROW_NUMBER()OVER(ORDER BY ci.year desc) pageIndex FROM ClassInfo ci
WHERE 1=1 
and ci.[Year] = @Year
AND ci.ClassName LIKE '%'+@ClassName+'%'
and ci.IsFinish = @IsFinish
) x 
WHERE x.pageIndex BETWEEN @begin AND @end
ORDER BY x.pageIndex 
"
         UpdateCommand="UPDATE ClassInfo
SET
	ClassName = @ClassName,
	[Year] = @Year,
	StartTime = @StartTime,
	EndTime = @EndTime,
	IsFinish = @IsFinish,
	Intro = @Intro
WHERE Id = @Id"

         DeleteCommand="delete from ClassInfo where id =@Id"
         InsertCommand="INSERT INTO ClassInfo
(
	ID,
	ClassName,
	[Year],
	StartTime,
	EndTime,
	IsFinish,
	Intro
)
VALUES
(
	NEWID(),
	@ClassName,
	@Year,
	@StartTime,
	@EndTime,
	@IsFinish,
	@Intro
)" ConnectionString="<%$ ConnectionStrings:DuihuaDB %>" >
    <SelectParameters>
    <asp:ControlParameter ControlID="tbYear" Name="Year" ConvertEmptyStringToNull="true"/>
    <asp:ControlParameter ControlID="tbClassName" Name="ClassName" ConvertEmptyStringToNull="false"/>
    <asp:ControlParameter ControlID="ddIsFinish" Name="IsFinish"/>
     <asp:ControlParameter ControlID="hdend"  ConvertEmptyStringToNull="false" Name="end" />
     <asp:ControlParameter ControlID="hdbegin"  ConvertEmptyStringToNull="false" Name="begin" />
    </SelectParameters>
    <UpdateParameters>
    <asp:ControlParameter  Name="ClassName" ControlID="eClassName"/>
    <asp:ControlParameter  Name="Year" ControlID="eYear"/>
    <asp:ControlParameter  Name="StartTime" ControlID="eStartTime"/>
    <asp:ControlParameter  Name="EndTime" ControlID="eEndTime"/>
    <asp:ControlParameter  Name="IsFinish" ControlID="eIsFinish"/>
    <asp:ControlParameter  Name="Intro" ControlID="eIntro"  PropertyName="InnerText"/>
    <asp:ControlParameter  Name="Id" ControlID="eId"/>
    </UpdateParameters>
    <InsertParameters>
    <asp:ControlParameter  Name="ClassName" ControlID="eClassName"/>
    <asp:ControlParameter  Name="Year" ControlID="eYear"/>
    <asp:ControlParameter  Name="StartTime" ControlID="eStartTime"/>
    <asp:ControlParameter  Name="EndTime" ControlID="eEndTime"/>
    <asp:ControlParameter  Name="IsFinish" ControlID="eIsFinish"/>
    <asp:ControlParameter  Name="Intro" ControlID="eIntro"  PropertyName="InnerText"/>
    </InsertParameters>
    <DeleteParameters>
    <asp:Parameter Name="Id" />
    </DeleteParameters>
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
    <fieldset >
            班级名称：<asp:Label runat="server" name="ClassName"></asp:Label>
            <br />
            <br />
            开班年份：<asp:Label runat="server" name="Year"></asp:Label>
            <br />
            <br />
            开始注册时间：<asp:Label runat="server" name="StartTime"></asp:Label>
            <br />
            <br />
            注册结束时间：<asp:Label runat="server" name="EndTime"></asp:Label>
            <br />
            <br />
            是否允许注册：<asp:Label  runat="server" name="IsFinish"></asp:Label>
       </fieldset>
            <br />
            <br />
            班级简介：<div><br /><asp:Label runat="server" name="Intro"></asp:Label></div>
            <br />
            <br />
         <asp:Button  runat="server" Text="关闭" onclick="btnBackList_Click"/>
   </fieldset>
  </div>

 <div id="editTemplate" runat="server" visible="false">
 
                  
                    <span class="failureNotification">
                        <asp:Literal ID="ErrorMessage" runat="server"></asp:Literal>
                    </span>
                    <asp:ValidationSummary runat="server" CssClass="failureNotification" 
                         ValidationGroup="RegisterArtValidationGroup"/>
                    <div class="classInfo">
                        <fieldset >
                            <legend>班级信息</legend>
                            <p class="submitButton">
                            
                                  <asp:Button  runat="server" Text="保存" OnClick="btnSave_Click"
                                   ValidationGroup="RegisterArtValidationGroup"/>
                                <asp:Button   runat="server" Text="关闭" onclick="btnBackList_Click"/>
                             </p>
                            <p>
                                <asp:Label runat="server" AssociatedControlID="eClassName">班级名称:</asp:Label>
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:TextBox ID="eClassName" runat="server" CssClass="textEntry" name="ClassName"></asp:TextBox>
                                <asp:RequiredFieldValidator  runat="server" ControlToValidate="eClassName" 
                                     CssClass="failureNotification" ErrorMessage="必须填写“班级名称”。" ToolTip="必须填写“班级名称”。" 
                                     ValidationGroup="RegisterArtValidationGroup">*</asp:RequiredFieldValidator>
                            </p>
                            <p>
                                <asp:Label runat="server" AssociatedControlID="eYear">开班年份:</asp:Label>
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <asp:TextBox ID="eYear" runat="server" CssClass="textEntry" name="Year"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="eYear" 
                                     CssClass="failureNotification" ErrorMessage="必须填写“开班年份”。" ToolTip="必须填写“开班年份”。" 
                                     ValidationGroup="RegisterArtValidationGroup">*</asp:RequiredFieldValidator>
                            </p>
                             <p>
                                <asp:Label runat="server" AssociatedControlID="eStartTime">注册开始时间:</asp:Label>
                                <asp:TextBox ID="eStartTime" ClientIDMode="Static" runat="server" CssClass="textEntry"  name="StartTime" onClick="WdatePicker({dateFmt:'yyyy-M-d'})"/>
                                 
                            </p>
                            <p>
                                 <asp:Label runat="server" AssociatedControlID="eEndTime">注册结束时间:</asp:Label>
                                  <asp:TextBox  ID="eEndTime" runat="server" CssClass="textEntry"  name="EndTime" onClick="WdatePicker({dateFmt:'yyyy-M-d',minDate:$('#eStartTime').val()})"/>
                                 
                            </p>
                            <p>
                                 <asp:Label ID="Label1" runat="server" AssociatedControlID="eIsFinish">是否允许注册:</asp:Label>
                                <asp:DropDownList runat="server" ID="eIsFinish" name="IsFinish"  CssClass="textEntry">
                                <asp:ListItem Value="0">报名中</asp:ListItem>
                                <asp:ListItem Value="1">结束报名</asp:ListItem>
                                </asp:DropDownList>
                            </p>
                        </fieldset>

                         <p><asp:Label AssociatedControlID="eIntro" runat="server">班级信息:</asp:Label>
                             <div>
                                 <textarea id="eIntro" name="Intro" runat="server" cols="20" rows="2" clientidmode="Static"></textarea>

                                 <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="eIntro" 
                                     CssClass="failureNotification" ErrorMessage="必须填写“班级信息”。" ToolTip="必须填写“班级信息”。" 
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
                            
                                  <asp:Button runat="server" Text="保存" OnClick="btnSave_Click"
                                   ValidationGroup="RegisterArtValidationGroup"/>
                                <asp:Button  runat="server" Text="关闭" onclick="btnBackList_Click"/>
                        </p>
                         </div>

  
 </div>


  
</asp:Content>
