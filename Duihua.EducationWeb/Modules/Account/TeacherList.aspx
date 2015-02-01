<%@ Page Title="教师管理" Language="C#" MasterPageFile="~/Layout/AdminDefault.Master" AutoEventWireup="true" CodeBehind="TeacherList.aspx.cs" Inherits="Duihua.EducationWeb.Modules.Account.TeacherList" %>
<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
   <script type="text/javascript" src="../../Scripts/bootstrap-datetimepicker.min.js"></script>
    <script src="../../Scripts/bootstrap-datetimepicker.zh-CN.js" type="text/javascript"></script>
   <link href="../../Styles/bootstrap-datetimepicker.min.css" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<div runat="server" id="list"  class="panel panel-success">
    <div  class="panel-heading">
        <h3 class="panel-title">教师信息管理</h3>
    </div>
    <div class="panel-body">
        <div class="form-group col-sm-offset-4 col-sm-4 col-xs-8">
            <label class="sr-only" for="sTeachName">教师名称：</label>
            <asp:TextBox runat="server" ClientIDMode="Static"  ID="sTeachName" CssClass="form-control" placeholder="输入教师名称"></asp:TextBox>
        </div>
        
        <div class="form-group  col-sm-2  col-xs-2">
            <asp:Button runat="server" ID="btnSearch" ClientIDMode="Static" Text="搜索" onclick="btnSearch_Click" CssClass="btn btn-default"/>
        </div>
        <div class="form-group  col-sm-2   col-xs-2">
            <asp:Button ID="Button1" runat="server"  ClientIDMode="Static" Text="添加" onclick="btnNew_Click" CssClass="btn btn-primary"/>
        </div>
        <br />
        <br />
    </div>
<div class="table-responsive">
<table class="table table-hover">
        <thead>
          <tr>
              <th>操作</th> 
              <th>教师名称</th>
              <th>教师入职时间</th>         
          </tr>
        </thead>
        <tbody>
  <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource1">
   
  <ItemTemplate>
  <tr class="active">  
        <td>
                <asp:LinkButton ID="LinkButton1"   runat="server" CssClass="fl btn5"  OnClick="lbOperator_Click"
                                     CausesValidation="False" CommandName="Edit" 
                                Text="编辑"  _Id='<%#Eval("UserId") %>' />
                
                 <asp:LinkButton ID="LinkButton2"   runat="server" CssClass="fl btn5"   OnClick="lbOperator_Click"
                                     CausesValidation="False" CommandName="View" 
                                Text="查看"   _Id='<%#Eval("UserId") %>' />

                 <asp:LinkButton ID="LinkButton3"   runat="server" CssClass="fl btn3" CausesValidation="False" CommandName="Delete"
                       OnClick="lbOperator_Click"   Text="删除" OnClientClick="return confirm('确认要删除吗？');" _Id='<%#Eval("UserId") %>' />
             </td>
            <td><%#Eval("TeachName")%></td>
            <td><%#Eval("joinTime")%></td>
          </tr>
  </ItemTemplate>
  
        </asp:Repeater>
 </tbody>
      </table>
</div>
         共<asp:Label ID="lblCount" runat="server" Text="0"></asp:Label>条数据&nbsp;
    <webdiyer:AspNetPager id="AspNetPager1"  runat="server" Width="500px" FirstPageText="首页" 
    LastPageText="尾页" NextPageText="下一页" PrevPageText="上一页" Height="40px" 
    ShowInputBox="Always" TextAfterInputBox="页"  OnPageChanging="AspNetPager1_PageChanging" 
    PageSize="10" TextBeforeInputBox="跳转到第" AlwaysShow="True" CssClass="pagination"> 
    </webdiyer:AspNetPager> 


      <asp:HiddenField ID="hdbegin" runat="server" />
      <asp:HiddenField ID="hdend" runat="server" />
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:DuihuaDB %>" 
        DeleteCommand="DELETE FROM Teacher WHERE UserId = @UserId" 
        InsertCommand="INSERT INTO [dbo].[Teacher]
           ([UserId]
           ,[TeachName]
           ,[joinTime]
           ,[Intro]
           ,[PicUrl])
     VALUES
           (@UserId
           ,@TeachName
           ,@joinTime
           ,@Intro
           ,@PicUrl)
" SelectCommand="
SELECT tx.* FROM (
SELECT t.[UserId]
      ,t.[TeachName]
      ,CONVERT(NVARCHAR(10),t.[joinTime],121) [joinTime]
      ,t.[Intro]
      ,t.[PicUrl]
      ,ROW_NUMBER() OVER (ORDER BY t.joinTime DESC) pageindex
  FROM [dbo].[Teacher] t
INNER JOIN aspnet_UsersInRoles auir ON auir.UserId = t.UserId
INNER JOIN aspnet_Roles ar ON ar.RoleId = auir.RoleId
WHERE t.TeachName LIKE '%'+@TeachName+'%'
AND ar.RoleName = @RoleName

) tx
where pageIndex between @begin and @end
ORDER BY pageIndex asc
" UpdateCommand="UPDATE [dbo].[Teacher]
   SET 
      [TeachName] = @TeachName
      ,[joinTime] = @joinTime
      ,[Intro] = @Intro
      ,[PicUrl] = @PicUrl
 WHERE [UserId] = @UserId
" ondeleting="SqlDataSource1_Deleting" oninserting="SqlDataSource1_Inserting" 
        onupdating="SqlDataSource1_Updating">
        <DeleteParameters>
            <asp:Parameter Name="UserId" />
        </DeleteParameters>
        <InsertParameters>
            <asp:ControlParameter ControlID="eUserId" Name="UserId" />
            <asp:ControlParameter ControlID="ePicUrl" Name="PicUrl" />
            <asp:ControlParameter ControlID="eTeachName" Name="TeachName" />
            <asp:ControlParameter ControlID="ejoinTime" Name="joinTime" />
            <asp:ControlParameter ControlID="eIntro" Name="Intro" />
        </InsertParameters>
        <UpdateParameters>
            <asp:ControlParameter ControlID="eUserId" Name="UserId" />
            <asp:ControlParameter ControlID="ePicUrl" Name="PicUrl" />
            <asp:ControlParameter ControlID="eTeachName" Name="TeachName" />
            <asp:ControlParameter ControlID="ejoinTime" Name="joinTime" />
            <asp:ControlParameter ControlID="eIntro" Name="Intro" />
        </UpdateParameters>
        <SelectParameters>
             <asp:ControlParameter ControlID="hdend"  ConvertEmptyStringToNull="false" Name="end" />
             <asp:ControlParameter ControlID="hdbegin"  ConvertEmptyStringToNull="false" Name="begin" />
             <asp:ControlParameter ControlID="sTeachName"  ConvertEmptyStringToNull="false" Name="TeachName"/><asp:Parameter Name="RoleName" />
        </SelectParameters>
    </asp:SqlDataSource>

</div>

<div runat="server" id="view" visible="false"  class="panel panel-success">
    <div class="panel-heading">
        <h3 class="panel-title">教师信息</h3>
    </div>
    
    <div class="panel-body">
        教师名称：<asp:Label runat="server" name="TeachName"></asp:Label>
        <br />
        <br />
        入职时间：<asp:Label   runat="server" name="joinTime"></asp:Label>
        <br />
        <br />
        教师图片：
         <asp:TextBox ID="tbShowImg"  runat="server" name="PicUrl" style="display:none" ></asp:TextBox>
         <asp:Image ID="ImgShowImg" runat="server" Visible="false" CssClass="img-responsive img-thumbnail"/>  
         <asp:Image ID="ImgShowImgSmall" runat="server" Visible="false" CssClass="img-responsive img-thumbnail"/>  
         <blockquote>
        教师简介：<asp:Label ID="Label4"   runat="server" name="Intro"></asp:Label>
        </blockquote>
         <br />
        <br />
       
    </div>
    <div class="panel-footer">
        <div class="col-sm-offset-10">
            <asp:Button ID="Button2"  runat="server" Text="返回" onclick="btnBackList_Click" CssClass="btn btn-default"/>
        </div>
    </div>
</div>

<div runat="server" id="detail" visible="false"  class="panel panel-success">
  <div class="panel-heading">
        <h3 class="panel-title">编辑教师信息</h3>
    </div>
    <div class="panel-body">
      <div class="form-group">
         <label for="eTeachName">教师名称：</label>
         <asp:TextBox ID="eTeachName" ClientIDMode="Static" runat="server" name="TeachName" CssClass="form-control" placeholder="教师名称"></asp:TextBox>
          <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ValidationGroup="vd" ControlToValidate="eTeachName" runat="server" ErrorMessage="“教师名称”必填" Display="Dynamic" CssClass="error-info"></asp:RequiredFieldValidator>
      </div>
       <div class="form-group">
        <label for="ejoinTime">入职时间：</label>
        <div>
            <div class="input-group input-append date form_ejoinTime"  data-date='' data-link-field='ejoinTime' data-date-format='yyyy-MM-dd' data-link-format="yyyy-MM-dd">
                <asp:TextBox ID="ejoinTime"  ClientIDMode="Static" name="joinTime" runat="server" CssClass="form-control"   size="16" ></asp:TextBox>
                <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
		        <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2"  ValidationGroup="vs" ControlToValidate="ejoinTime" runat="server" ErrorMessage="“入职时间”必填" Display="Dynamic" CssClass="error-info"></asp:RequiredFieldValidator>
            </div>
        </div>
      </div>
      <div class="form-group">
        <label for="ePicUrl">照片：</label>
           <div class="input-group">
                <asp:FileUpload ID="fPicUrl" runat="server" ClientIDMode="Static" CssClass="form-control" placeholder="照片"/>
                <span class="input-group-btn">
                    <asp:Button ID="btnUpload" runat="server" Text="上传"  
                    CssClass="btn btn-success" onclick="btnUpload_Click"/>
                </span>
          </div>

          <asp:TextBox ID="ePicUrl" runat="server"  name="PicUrl" style="display:none" ></asp:TextBox>
          <asp:Image ID="ImgPicUrl" runat="server" Visible="false" CssClass="img-responsive img-thumbnail"/>  
          <asp:Image ID="ImgPicUrlSmall" runat="server" Visible="false" CssClass="img-responsive img-thumbnail"/> 
      </div>
      <div class="form-group">
        <label for="eIntro">单位描述：</label>
        <asp:TextBox ID="eIntro" ClientIDMode="Static" runat="server" name="Intro"  CssClass="form-control" TextMode="MultiLine" placeholder="单位描述" rows="4"></asp:TextBox>
         <asp:TextBox ID="eUserId" runat="server" name="UserId" CssClass="hidden"></asp:TextBox>
       
      </div>
   </div>
   <div class="panel-footer">
      <div class="form-group col-sm-offset-10 col-sm-2">
         <asp:Button ID="btnSave" runat="server" Text="保存" ValidationGroup="vd"  OnClick="btnSave_Click" CssClass="btn btn-primary"/>
         <asp:Button ID="btnBack" runat="server" Text="返回"  OnClick="btnBackList_Click" CssClass="btn btn-default"/>
      </div>
      <br />
       <br />
   </div>
</div>
<script type="text/javascript">
    $(function () {
        $('.form_ejoinTime').datetimepicker({
            language: 'zh-CN',
            weekStart: 1,
            todayBtn: 1,
            autoclose: 1,
            todayHighlight: 1,
            startView: 2,
            minView: 2,
            forceParse: 0
        });
        
    });
   
</script>
</asp:Content>