<%@ Page Title="" Language="C#" MasterPageFile="~/Layout/AdminDefault.Master" AutoEventWireup="true" CodeBehind="StudentList.aspx.cs" Inherits="Duihua.EducationWeb.Modules.Student.StudentList" %>
<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <script type="text/javascript" src="../../Scripts/bootstrap-datetimepicker.min.js"></script>
      <link href="../../Styles/bootstrap-datetimepicker.min.css" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<div runat="server" id="list"  class="panel panel-success">
    <div  class="panel-heading">
        <h3 class="panel-title">学生信息管理</h3>
    </div>
    <div class="panel-body">
        <div  class="col-sm-12  col-xs-12">
            <div class="form-group  col-sm-offset-4  col-sm-2 col-xs-3">
                <label class="sr-only" for="IDCard">身份证</label>
                <asp:TextBox runat="server" ClientIDMode="Static"  ID="sIDCard" CssClass="form-control" placeholder="输入身份证"></asp:TextBox>
            </div>
            <div class="form-group col-sm-2 col-xs-3">
                <label class="sr-only" for="sStudentName">姓名</label>
                <asp:TextBox runat="server" ClientIDMode="Static"  ID="sStudentName" CssClass="form-control" placeholder="输入姓名"></asp:TextBox>
            </div>
             <div class="form-group col-sm-2 col-xs-3">
                <label class="sr-only" for="sStatus">状态</label>
                 <asp:DropDownList ID="sStatus" runat="server" CssClass="form-control">
                 <asp:ListItem Text="--请选择状态--" Value=""></asp:ListItem>
                 <asp:ListItem Text="入学未交费" Value="0"></asp:ListItem>
                 <asp:ListItem Text="入学已缴费" Value="1"></asp:ListItem>
                 <asp:ListItem Text="毕业" Value="2"></asp:ListItem>
                 </asp:DropDownList>

            </div>
            <div class="form-group col-sm-2  col-xs-3">
                <label class="sr-only" for="sCooperatorId">曾就读的学校</label>
                <asp:DropDownList runat="server"  ClientIDMode="Static"  ID="sCooperatorId" DataTextField="CooperatorName" DataValueField="CooperatorId" DataSourceID="SqlDataSource2" CssClass="form-control" AppendDataBoundItems="true">
                <asp:ListItem Text="--请选择学校--" Value="00000000-0000-0000-0000-000000000000"></asp:ListItem>
                </asp:DropDownList>
                <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
                     ConnectionString="<%$ ConnectionStrings:DuihuaDB %>" 
                     SelectCommand="SELECT c.CooperatorId,c.CooperatorName FROM Cooperator c"></asp:SqlDataSource> 
          
            </div>
        </div>
        <div class="col-sm-12  col-xs-12">
            
            <div class="form-group col-sm-offset-7 col-xs-offset-7  col-sm-2 col-xs-2">
                <asp:Button runat="server" ID="btnSearch" ClientIDMode="Static" Text="搜索" onclick="btnSearch_Click" CssClass="btn btn-default"/>
            </div>
            <div class="form-group  col-sm-offset-1 col-xs-offset-1 col-sm-2 col-xs-2">
                <asp:Button runat="server" ID="btnNew" ClientIDMode="Static" Text="添加" onclick="btnNew_Click" CssClass="btn btn-primary"/>
                <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#myModal">导入学生</button>
            </div>
        </div>
        <br />
        <br />
    </div>
    
     <asp:Label runat="server" ID="msg" ForeColor="Red"></asp:Label>

<div class="table-responsive">
<table class="table table-hover">
        <thead>
          <tr>
            <th>操作</th>
            <th>序号</th>
            <th>身份证</th>
            <th>学号</th>
            <th>姓名</th>
            <th>注册时间</th>
            <th>联系电话</th>
            <th>状态</th>
          </tr>
        </thead>
        <tbody>
 <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource1">
  <ItemTemplate>
    <tr class="active">  
            <td>
                <asp:LinkButton  runat="server" CssClass="fl btn5"  OnClick="lbOperator_Click" CausesValidation="False" CommandName="Edit" Text="编辑"  _Id='<%#Eval("UserId") %>' />
                <asp:LinkButton  runat="server" CssClass="fl btn5"   OnClick="lbOperator_Click"   CausesValidation="False" CommandName="View"   Text="查看"   _Id='<%#Eval("UserId") %>' />
                <asp:LinkButton  runat="server" CssClass="fl btn3" CausesValidation="False" CommandName="Delete" OnClick="lbOperator_Click"   Text="删除" OnClientClick="return confirm('确认要删除吗？');" _Id='<%#Eval("UserId") %>' />
            </td>
            <td><%#Eval("pageindex")%></td>
            <td><%#Eval("IDCard")%></td>
             <td><%#Eval("StuNumber")%></td>
            <td><%#Eval("StudentName")%></td>
            <td><%#Eval("RegisterTime")%></td>
            <td><%#Eval("Phone")%></td>
            <td><%#Eval("Status")%></td>
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
        DeleteCommand="DELETE FROM Student WHERE UserId = @UserId" 
        InsertCommand="INSERT INTO [dbo].[Student]
           ([UserId]
           ,[CooperatorId]
           ,[StuNumber]
           ,[StudentName]
           ,[ParentName]
           ,[Phone]
           ,[Email]
           ,[CreateDate]
           ,[Intro]
           ,[IDCard]
           ,[Address]
           ,[Status]
           ,[Sex]
           ,[RegisterTime]
           ,[PicUrl])
     VALUES
           (@UserId
           ,@CooperatorId
           ,@StuNumber
           ,@StudentName
           ,@ParentName
           ,@Phone
           ,@Email
           ,GETDATE()
           ,@Intro
           ,@IDCard
           ,@Address
           ,@Status
           ,@Sex
           ,@RegisterTime
           ,@PicUrl)" 
        SelectCommand="SELECT t.* FROM (
                        SELECT s.[UserId]
                              ,s.[CooperatorId]
                              ,s.[StuNumber]
                              ,s.[StudentName]
                              ,s.[ParentName]
                              ,s.[Phone]
                              ,am.Email
                              ,s.[CreateDate]
                              ,s.[UpdateDate]
                              ,s.[Intro]
                              ,s.[IDCard]
                              ,s.[Address]
                              
                               ,CASE s.[Status] when '0' THEN '入学未交费'
                              WHEN '1' THEN '入学已缴费'
							WHEN '2' THEN '毕业' end as [Status]

                              ,s.[Sex]
                              ,CONVERT(NVARCHAR(10),s.[RegisterTime],121)[RegisterTime]
                              ,ROW_NUMBER() OVER (ORDER BY s.CreateDate DESC) pageindex
                              ,c.CooperatorName
                        FROM [dbo].[Student] s
                        INNER JOIN aspnet_Users au ON au.UserId = s.UserId
                        INNER JOIN aspnet_Membership am ON am.UserId = au.UserId 
                        LEFT JOIN Cooperator c ON c.CooperatorId = s.CooperatorId
                        WHERE 1=1
                        AND s.IDCard LIKE '%'+@IDCard+'%'
                        AND s.StudentName LIKE '%'+@StudentName+'%'
                        AND ( @Status ='' or @Status is null or s.[Status] = @Status)
                        AND (@CooperatorId = '00000000-0000-0000-0000-000000000000' OR s.CooperatorId = @CooperatorId)
                        ) t WHERE t.pageindex BETWEEN @begin AND @end
                        ORDER BY pageIndex asc" 
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
      ,picUrl =@PicUrl
 WHERE UserId = @UserId" ondeleting="SqlDataSource1_Deleting" 
        oninserting="SqlDataSource1_Inserting" onupdating="SqlDataSource1_Updating">
        <DeleteParameters>
            <asp:Parameter Name="UserId" />
        </DeleteParameters>
        <InsertParameters>
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
        </InsertParameters>
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
        <SelectParameters>
             <asp:ControlParameter ControlID="hdend"  ConvertEmptyStringToNull="false" Name="end" />
             <asp:ControlParameter ControlID="hdbegin"  ConvertEmptyStringToNull="false" Name="begin" />
             <asp:ControlParameter ControlID="sIDCard"  ConvertEmptyStringToNull="false" Name="IDCard"/>
             <asp:ControlParameter ControlID="sStudentName"  ConvertEmptyStringToNull="false" Name="StudentName"/>
              <asp:ControlParameter ControlID="sStatus"  ConvertEmptyStringToNull="false" Name="Status" />
             <asp:ControlParameter ControlID="sCooperatorId" Name="CooperatorId"  ConvertEmptyStringToNull="false" DefaultValue="00000000-0000-0000-0000-000000000000"/>
        </SelectParameters>
    </asp:SqlDataSource>
</div>

<div runat="server" id="view" visible="false"  class="panel panel-success">
    <div class="panel-heading">
        <h3 class="panel-title">学生信息</h3>
    </div>
    
    <div class="panel-body">
      照片：
         <asp:TextBox ID="tbShowImg"  runat="server" name="PicUrl" style="display:none" ></asp:TextBox>
          <asp:Image ID="ImgShowImg" runat="server" Visible="false" CssClass="img-responsive img-thumbnail"/>  
        <br />
        <br />
       
        学号：<asp:Label   runat="server" name="StuNumber"></asp:Label>
        <br />
        <br />
        姓名：<asp:Label   runat="server" name="StudentName"></asp:Label>
        <br />
        <br />
          性别：<asp:Label   runat="server" name="Sex"></asp:Label>
        <br />
        <br />
         家长名称：<asp:Label    runat="server" name="ParentName"></asp:Label>
        <br />
        <br />
        联系电话：<asp:Label   runat="server" name="Phone"></asp:Label>
        <br />
        <br />
        邮箱：<asp:Label   runat="server" name="Email"></asp:Label>
        <br />
        <br />
        身份证：<asp:Label   runat="server" name="IDCard"></asp:Label>
          <br />
        <br />
       注册时间：<asp:Label   runat="server" name="RegisterTime"></asp:Label>
          <br />
        <br />
        曾就读的学校：<asp:Label   runat="server" name="CooperatorName"></asp:Label>
        <br />
        <br />
        状态：<asp:Label   runat="server" name="Status"></asp:Label>
          <br />
        <br />
       
        地址：<div>
         <address>
         <asp:Label runat="server" name="Address"></asp:Label>
         <address>
         </div>
        
        <br />
        <br />
        <blockquote>
        简介：<div><br /><asp:Label   runat="server" name="Intro"></asp:Label></div>
        </blockquote>
        <br />
        <br />
    </div>
    <div class="panel-footer">
        <div class="col-sm-offset-10">
            <asp:Button   runat="server" Text="返回" onclick="btnBackList_Click" CssClass="btn btn-default"/>
        </div>
    </div>
</div>

<div runat="server" id="detail" visible="false"  class="panel panel-success">
  <div class="panel-heading">
        <h3 class="panel-title">编辑学生信息</h3>
    </div>
    <div class="panel-body">
      <div class="form-group">
          <label for="eStuNumber">学号：</label>
          <asp:TextBox ID="eStuNumber" name="StuNumber" runat="server" ReadOnly="true" ClientIDMode="Static" CssClass="form-control"></asp:TextBox>
      </div>
       <div class="form-group">
           <label for="eStudentName">姓名：</label>
           <asp:TextBox ID="eStudentName" name="StudentName" runat="server" ClientIDMode="Static" CssClass="form-control"></asp:TextBox> 
           <asp:RequiredFieldValidator   ValidationGroup="vs" ControlToValidate="eStudentName" runat="server" ErrorMessage="“姓名”必填" Display="Dynamic" CssClass="help-block"></asp:RequiredFieldValidator>
      </div>
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
        <asp:RequiredFieldValidator ValidationGroup="vs" ControlToValidate="eParentName" runat="server" ErrorMessage="“家长名称”必填" Display="Dynamic" CssClass="help-block"></asp:RequiredFieldValidator>
      </div>
       <div class="form-group">
        <label for="ePhone">联系电话：</label>
        <asp:TextBox ID="ePhone" ClientIDMode="Static"  runat="server" name="Phone"  CssClass="form-control" placeholder="联系电话"></asp:TextBox>
        <asp:RequiredFieldValidator  ValidationGroup="vs" ControlToValidate="ePhone" runat="server" ErrorMessage="“联系电话”必填" Display="Dynamic" CssClass="help-block"></asp:RequiredFieldValidator>
      </div>
       <div class="form-group">
        <label for="eEmail">邮箱：</label>
        <asp:TextBox ID="eEmail" ClientIDMode="Static"   runat="server" name="Email"  CssClass="form-control" placeholder="邮箱"></asp:TextBox>
        <asp:RequiredFieldValidator ValidationGroup="vs" ControlToValidate="eEmail" runat="server" ErrorMessage="“邮箱”必填" Display="Dynamic" CssClass="help-block"></asp:RequiredFieldValidator>
      </div>
       <div class="form-group">
        <label for="eIDCard">身份证：</label>
        <asp:TextBox ID="eIDCard" ClientIDMode="Static"  runat="server"  name="IDCard"  CssClass="form-control" placeholder="身份证"></asp:TextBox>
        <asp:RequiredFieldValidator  ControlToValidate="eIDCard" ValidationGroup="vs" runat="server" ErrorMessage="“身份证”必填" Display="Dynamic" CssClass="help-block"></asp:RequiredFieldValidator>
      </div>
        <div class="form-group">
        <label for="eStatus">状态：</label>
            <asp:DropDownList ID="eStatus" name="Status" runat="server"  CssClass="form-control">
                 <asp:ListItem Text="--请选择状态--" Value=""></asp:ListItem>
                 <asp:ListItem Text="入学未交费" Value="0"></asp:ListItem>
                 <asp:ListItem Text="入学已缴费" Value="1"></asp:ListItem>
                 <asp:ListItem Text="毕业" Value="2"></asp:ListItem>
            </asp:DropDownList>
            <asp:RequiredFieldValidator  ValidationGroup="vs" ControlToValidate="eStatus" runat="server" ErrorMessage="“状态”必填" Display="Dynamic" CssClass="help-block"></asp:RequiredFieldValidator>
      </div>
      <div class="form-group">
                <label for="eCooperatorId">曾就读的学校：</label>
                <asp:DropDownList runat="server" name="CooperatorId"  ClientIDMode="Static"  ID="eCooperatorId" DataTextField="CooperatorName" DataValueField="CooperatorId" DataSourceID="SqlDataSource2" CssClass="form-control">
               
                </asp:DropDownList>
               
            </div>
      <div class="form-group">
        <label for="eRegisterTime">注册时间：</label>
        <div>
            <div class="input-group input-append date form_RegisterTime" data-date='<%=DateTime.Now %>'>
                <asp:TextBox ID="eRegisterTime"  ClientIDMode="Static" name="RegisterTime" runat="server" CssClass="form-control"   size="16" ></asp:TextBox>
                <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
		        <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                <asp:RequiredFieldValidator  ValidationGroup="vs" ControlToValidate="eRegisterTime" runat="server" ErrorMessage="“注册时间”必填" Display="Dynamic" CssClass="help-block"></asp:RequiredFieldValidator>
            </div>
        </div>
      </div>
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
          <asp:Image ID="ImgPicUrl" runat="server" Visible="false" CssClass="img-responsive img-thumbnail"/>  
      </div>
       <div class="form-group">
        <label for="eAddress">地址：</label>
        <asp:TextBox ID="eAddress" ClientIDMode="Static"   runat="server" name="Address"  CssClass="form-control" placeholder="地址"></asp:TextBox>
        <asp:RequiredFieldValidator   ValidationGroup="vs" ControlToValidate="eAddress" runat="server" ErrorMessage="“地址”必填" Display="Dynamic" CssClass="help-block"></asp:RequiredFieldValidator>
      </div>
  
      <div class="form-group">
        <label for="eIntro">简介：</label>
        <asp:TextBox ID="eIntro" ClientIDMode="Static" runat="server" name="Intro"  CssClass="form-control" TextMode="MultiLine" placeholder="简介" rows="10"></asp:TextBox>
         <asp:TextBox ID="eUserId" runat="server" name="UserId" style="display:none"></asp:TextBox>
      </div>
   </div>
   <div class="panel-footer">
      <div class="form-group col-sm-offset-10 col-sm-2">
         <asp:Button ID="btnSave" runat="server" Text="保存"  ValidationGroup="vs" OnClick="btnSave_Click" CssClass="btn btn-primary"/>
         <asp:Button ID="btnBack" runat="server" Text="返回"  OnClick="btnBackList_Click" CssClass="btn btn-default"/>
      </div>
      <br />
       <br />
   </div>
</div>


<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
        <h4 class="modal-title" id="myModalLabel">导入学生数据</h4>
      </div>
      <div class="modal-body">
         <div class="form-group">
            <label for="SemesterID">学年：</label>
              <asp:DropDownList CssClass="form-control" ID="SemesterID" runat="server" ClientIDMode="Static" DataSourceID="SqlDataSource3" DataTextField="SemesterName" DataValueField="SemesterID">
                </asp:DropDownList>
              <asp:SqlDataSource ID="SqlDataSource3" runat="server"   ConnectionString="<%$ ConnectionStrings:DuihuaDB %>" 
                 SelectCommand="SELECT s.SemesterID, s.SemesterName FROM Semester s" ></asp:SqlDataSource>
         </div>
         <div class="form-group">
             <label for="ePicUrl">学生数据表格（只支持excel 97~2003）：</label>
             <div class="input-group">
                <asp:FileUpload ID="fuExcelFile" runat="server" ClientIDMode="Static" CssClass="form-control" placeholder="学生数据表格"/>
                <span class="input-group-btn">
                    <asp:Button ID="btnImportExcel" runat="server" Text="上传"  
                    CssClass="btn btn-success" OnClick="btnImportExcel_Click"/>
                    <button type="button" class="btn btn-success" id="templateDownload">模板下载</button>
                </span>
             </div>

            <asp:TextBox ID="TextBox1" runat="server"  name="PicUrl" style="display:none" ></asp:TextBox>
            <asp:Image ID="Image1" runat="server" Visible="false" CssClass="img-responsive img-thumbnail"/>  
         </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      </div>
    </div>
  </div>
</div>

<script type="text/javascript">
    $(function () {
        $('.form_RegisterTime').datetimepicker({
            language: 'zh-CN',
            weekStart: 1,
            todayBtn: 1,
            autoclose: 1,
            todayHighlight: 1,
            startDate: '<%=DateTime.Now %>',
            format: 'yyyy-mm-dd'
        });

        $('#templateDownload').click(function () {
            window.open('/Attachment/file/学生数据收集.xls');
        });
    });
   
</script>
</asp:Content>
