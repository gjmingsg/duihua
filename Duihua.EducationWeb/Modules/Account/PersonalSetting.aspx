<%@ Page Title="" Language="C#" MasterPageFile="~/Layout/Personal.Master" AutoEventWireup="true" CodeBehind="PersonalSetting.aspx.cs" Inherits="Duihua.EducationWeb.Modules.Account.PersonalSetting" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
   <script type="text/javascript" src="../../Scripts/bootstrap-datetimepicker.min.js"></script>
      <link href="../../Styles/bootstrap-datetimepicker.min.css" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Main" runat="server"> 
     <div id="view" runat="server">
          <div class="jumbotron">
             <%if (!(HttpContext.Current.User.IsInRole("管理员") || HttpContext.Current.User.IsInRole("合作单位")))
         {%>
              <asp:Image ID="imgPicUrl" runat="server" />
               <%} %>
               <div  style="padding:0px 60px 0px 0px" id="baseInfo" runat="server">
               <dl class="dl-horizontal">
                  <dt><label for="lName">姓名：</label></dt>
                  <dd><asp:Label ID="lName" name="userName" runat="server"></asp:Label></dd>

                  <dt><label for="lPhone">电话：</label></dt>
                  <dd><asp:Label ID="lPhone" name="Phone" runat="server"></asp:Label></dd>

                    <dt><label for="lEmail">Email：</label></dt>
                  <dd><asp:Label ID="lEmail" name="Email" runat="server"></asp:Label></dd>

                    <dt> <label for="lAddress">地址：</label></dt>
                  <dd><asp:Label ID="lAddress" name="Address" runat="server"></asp:Label></dd>
                 
               <% if (HttpContext.Current.User.IsInRole("学生"))
         {%>
         
                    <dt>  <label for="lStuNumber">学号：</label></dt>
                  <dd><asp:Label ID="lStuNumber" name="StuNumber" runat="server"></asp:Label></dd>

                    <dt><label for="lParentName">家长名称：</label></dt>
                  <dd><asp:Label ID="lParentName" name="ParentName" runat="server"></asp:Label></dd>
                
                    <dt><label for="lIDCard">身份证：</label></dt>
                    <dd><asp:Label ID="lIDCard" name="IDCard" runat="server"></asp:Label></dd>

                       <dt><label for="lSex">性别：</label></dt>
                    <dd><asp:Label ID="lSex" name="Sex" runat="server"></asp:Label></dd>  
                     
                    <dt><label for="lRegisterTime">注册时间：</label></dt>
                    <dd><asp:Label ID="lRegisterTime" name="RegisterTime" runat="server"></asp:Label></dd>   
                   
                 
      <%}
         else if (HttpContext.Current.User.IsInRole("教师") || HttpContext.Current.User.IsInRole("教务"))
         {%>
                <dt><label for="ljoinTime">教师入职时间：</label></dt>
                    <dd><asp:Label ID="ljoinTime" name="joinTime" runat="server"></asp:Label></dd>
                
               
                <!--曾任教的班级-->
                <!--曾任教的课程-->
      <%}
         else if (HttpContext.Current.User.IsInRole("合作单位"))
         {%>
                <!--本单位学生-->
      <%}%>
         </dl>

              </div>
          </div>
       
          <div class="row">
            <div class="col-6 col-sm-6 col-lg-4" style=" padding:0px 60px;">
              <h3>个人简介</h3>
            
              <blockquote>
              <%=Person["Intro"]%>
              </blockquote>
             
              <p>
                  <asp:Button ID="btnModify" runat="server" Text="修改»" 
                      CssClass="btn btn-primary"  role="button" onclick="btnModify_Click"/>
              </p>
            </div><!--/span-->
             
          </div><!--/row-->

          </div>
          <div runat="server" id="edit" visible="false">
               
        <div class="form-group">
        <label for="ePicUrl">照片：</label>
           <div class="input-group">
                <asp:FileUpload ID="ePicUrl" runat="server" ClientIDMode="Static" CssClass="form-control" placeholder="照片"/>
                <span class="input-group-btn">
                    <asp:Button ID="btnUpload" runat="server" Text="上传"  
                    CssClass="btn btn-success" onclick="btnUpload_Click"/>
                </span>
          </div>
          <asp:TextBox ID="tbPicUrl" runat="server"  name="PicUrl" style="display:none" ></asp:TextBox>
          <asp:Image ID="Image1" runat="server"  ImageUrl="~/Images/noimage.jpg" CssClass="img-responsive img-thumbnail"/>  
      </div>
      
      <div class="form-group">
           <label for="eUserName">姓名：</label>
           <asp:TextBox ID="eUserName" name="UserName" runat="server" ClientIDMode="Static" CssClass="form-control"></asp:TextBox> 
           <asp:RequiredFieldValidator ID="RequiredFieldValidator1"   ValidationGroup="vs" ControlToValidate="eUserName" runat="server" ErrorMessage="“姓名”必填" Display="Dynamic" CssClass="help-block"></asp:RequiredFieldValidator>
      </div>
       <div class="form-group">
        <label for="ePhone">联系电话：</label>
        <asp:TextBox ID="ePhone" ClientIDMode="Static"  runat="server" name="Phone"  CssClass="form-control" placeholder="联系电话"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator3"  ValidationGroup="vs" ControlToValidate="ePhone" runat="server" ErrorMessage="“联系电话”必填" Display="Dynamic" CssClass="help-block"></asp:RequiredFieldValidator>
      </div>
       <div class="form-group">
        <label for="eEmail">邮箱：</label>
        <asp:TextBox ID="eEmail" ClientIDMode="Static"   runat="server" name="Email"  CssClass="form-control" placeholder="邮箱"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" ValidationGroup="vs" ControlToValidate="eEmail" runat="server" ErrorMessage="“邮箱”必填" Display="Dynamic" CssClass="help-block"></asp:RequiredFieldValidator>
      </div>
        <div class="form-group">
        <label for="eAddress">地址：</label>
        <asp:TextBox ID="eAddress" ClientIDMode="Static"   runat="server" name="Address"  CssClass="form-control" placeholder="地址"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ValidationGroup="vs" ControlToValidate="eEmail" runat="server" ErrorMessage="“地址”必填" Display="Dynamic" CssClass="help-block"></asp:RequiredFieldValidator>
      </div>

      <% if (HttpContext.Current.User.IsInRole("学生"))
         {%>
          <div  class="form-group">
          <label for="eSex">性别：</label>
          <asp:DropDownList ID="eSex" name="Sex" ClientIDMode="Static" runat="server" CssClass="form-control">
          <asp:ListItem Text="男" Value="男"></asp:ListItem>
          <asp:ListItem Text="女" Value="女"></asp:ListItem>
          </asp:DropDownList>
      </div>
      <div class="form-group">
        <label for="eParentName">家长名称：</label>
        <asp:TextBox ID="eParentName" ClientIDMode="Static"   runat="server"  name="ParentName"  CssClass="form-control" placeholder="家长名称"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator6" ValidationGroup="vs" ControlToValidate="eParentName" runat="server" ErrorMessage="“家长名称”必填" Display="Dynamic" CssClass="help-block"></asp:RequiredFieldValidator>
      </div>
         <div class="form-group">
        <label for="eIDCard">身份证：</label>
        <asp:TextBox ID="eIDCard" ClientIDMode="Static"  runat="server"  name="IDCard"  CssClass="form-control" placeholder="身份证"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator5"  ControlToValidate="eIDCard" ValidationGroup="vs" runat="server" ErrorMessage="“身份证”必填" Display="Dynamic" CssClass="help-block"></asp:RequiredFieldValidator>
      </div>
          <div class="form-group">
                <label for="eCooperatorId">曾就读的学校：</label>
                <asp:DropDownList runat="server" name="CooperatorId"  ClientIDMode="Static"  ID="eCooperatorId" DataTextField="CooperatorName" DataValueField="CooperatorId" DataSourceID="SqlDataSource2" CssClass="form-control">
               
                </asp:DropDownList>
                 <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
                     ConnectionString="<%$ ConnectionStrings:DuihuaDB %>" 
                     SelectCommand="SELECT c.CooperatorId,c.CooperatorName FROM Cooperator c"></asp:SqlDataSource> 
          
            </div>

         <asp:SqlDataSource ID="sdStudent" runat="server"  ConnectionString="<%$ ConnectionStrings:DuihuaDB %>" onupdating="sdStudent_Updating"
            UpdateCommand="UPDATE [dbo].[Student]
   SET [CooperatorId] = @CooperatorId
      ,[ParentName] = @ParentName
      ,[Phone] = @Phone
      ,email = @Email
      ,[UpdateDate] = GETDATE()
      ,[Intro] = @Intro
      ,[IDCard] = @IDCard
      ,[Address] = @Address
      ,[Status] = @Status
      ,[Sex] = @Sex
      ,[RegisterTime] = @RegisterTime
      ,picUrl =@PicUrl" >
              <UpdateParameters>
                  <asp:ControlParameter ControlID="eUserId" Name="UserId" />
            <asp:ControlParameter ControlID="eCooperatorId" Name="CooperatorId" />
            <asp:ControlParameter ControlID="eStuNumber" Name="StuNumber" />
            <asp:ControlParameter ControlID="eStudentName" Name="StudentName" />
            <asp:ControlParameter ControlID="eParentName" Name="ParentName" />
            <asp:ControlParameter ControlID="ePhone" Name="Phone" />
            <asp:ControlParameter ControlID="eEmail" Name="Email" />
            <asp:ControlParameter ControlID="eIntro" Name="Intro" />
            <asp:ControlParameter ControlID="eIDCard" Name="IDCard" />
            <asp:ControlParameter ControlID="eAddress" Name="Address" />
            <asp:ControlParameter ControlID="eStatus" Name="Status" />
            <asp:ControlParameter ControlID="eSex" Name="Sex" />
            <asp:ControlParameter ControlID="eRegisterTime" Name="RegisterTime" />
            <asp:ControlParameter ControlID="tbPicUrl" Name="PicUrl" />
              </UpdateParameters>
          </asp:SqlDataSource>
      <%}
         else if (HttpContext.Current.User.IsInRole("教师") || HttpContext.Current.User.IsInRole("教务"))
         {%>

         <div class="form-group">
        <label for="ejoinTime">入职时间：</label>
        <div>
            <div class="input-group input-append date form_ejoinTime" data-date='<%=DateTime.Now %>'>
                <asp:TextBox ID="ejoinTime"  ClientIDMode="Static" name="joinTime" runat="server" CssClass="form-control"   size="16" ></asp:TextBox>
                <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
		        <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator7"  ValidationGroup="vs" ControlToValidate="ejoinTime" runat="server" ErrorMessage="“入职时间”必填" Display="Dynamic" CssClass="help-block"></asp:RequiredFieldValidator>
            </div>
        </div>
      </div>

         <asp:SqlDataSource ID="sdTeacher" runat="server"  ConnectionString="<%$ ConnectionStrings:DuihuaDB %>"
         UpdateCommand="UPDATE [dbo].[Teacher]
   SET 
      [TeachName] = @TeachName
      ,[joinTime] = @joinTime
      ,[Intro] = @Intro
      ,[PicUrl] = @PicUrl
 WHERE [UserId] = @UserId"
 onupdating="sdTeacher_Updating"
>
  <UpdateParameters>
            <asp:ControlParameter ControlID="eUserId" Name="UserId" />
            <asp:ControlParameter ControlID="ePicUrl" Name="PicUrl" />
            <asp:ControlParameter ControlID="eTeachName" Name="TeachName" />
            <asp:ControlParameter ControlID="ejoinTime" Name="joinTime" />
            <asp:ControlParameter ControlID="eIntro" Name="Intro" />
        </UpdateParameters>
</asp:SqlDataSource>
      <%}
         else if (HttpContext.Current.User.IsInRole("合作单位"))
         {%>
         <asp:SqlDataSource ID="sdCooperator" runat="server" ConnectionString="<%$ ConnectionStrings:DuihuaDB %>"
         UpdateCommand="UPDATE [dbo].[Cooperator]
   SET
      [CooperatorName] = @CooperatorName
      ,[Address] = @Address
      ,[Intro] = @Intro
      ,[UpdateTime] =GETDATE()
     
 WHERE [CooperatorId]=@eUserId
"  onupdating="sdCooperator_Updating">
<UpdateParameters>
            <asp:ControlParameter ControlID="eUserId" Name="eUserId" />
            <asp:ControlParameter ControlID="eIntro" Name="Intro" />
            <asp:ControlParameter ControlID="eAddress" Name="Address" />
            <asp:ControlParameter ControlID="eCooperatorName" Name="CooperatorName" />
        </UpdateParameters>
</asp:SqlDataSource>
      <%}%>
              
       <div class="form-group">
        <label for="eIntro">简介：</label>
        <asp:TextBox ID="eIntro" ClientIDMode="Static" runat="server" name="Intro"  CssClass="form-control" TextMode="MultiLine" placeholder="简介" rows="10"></asp:TextBox>
         <asp:TextBox ID="eUserId" runat="server" name="UserId" style="display:none"></asp:TextBox>
      </div>  
              
              
                <div class="form-group">
                    <asp:Button ID="btnSave" runat="server" ValidationGroup="vs" Text="保存"  OnClick="btnSave_Click" CssClass="btn btn-primary"/>
                    <asp:Button ID="btnBack" runat="server" Text="返回"  OnClick="btnBackList_Click" CssClass="btn btn-default"/>
                </div>
          </div>
</asp:Content>
