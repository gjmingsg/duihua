<%@ Page Title="" Language="C#" MasterPageFile="~/Layout/AdminDefault.Master" AutoEventWireup="true" CodeBehind="ClassList.aspx.cs" Inherits="Duihua.EducationWeb.Modules.Class.ClassList" %>
<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
<script type="text/javascript" src="../../Scripts/bootstrap-datetimepicker.min.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<div>
  <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource1">
  <HeaderTemplate>
  <table class="table">
        <thead>
          <tr>
            <th>序号</th>
            <th>Column heading</th>
            <th>Column heading</th>
            <th>Column heading</th>
          </tr>
        </thead>
        <tbody>
  </HeaderTemplate>
  <ItemTemplate>
  <tr class="active">
            <td>1</td>
            <td>Column content</td>
            <td>Column content</td>
            <td>Column content</td>
          </tr>
  </ItemTemplate>
  <AlternatingItemTemplate>
   <tr>
            <td>4</td>
            <td>Column content</td>
            <td>Column content</td>
            <td>Column content</td>
          </tr>
  </AlternatingItemTemplate>
  <FooterTemplate>
    </tbody>
      </table>
  </FooterTemplate>
        </asp:Repeater>
         共<asp:Label ID="lblCount" runat="server" Text="0"></asp:Label>条数据&nbsp;
    <webdiyer:AspNetPager id="AspNetPager1"  runat="server" Width="500px" FirstPageText="首页" 
    LastPageText="尾页" NextPageText="下一页" PrevPageText="上一页" Height="40px" 
    ShowInputBox="Always" TextAfterInputBox="页"  OnPageChanging="AspNetPager1_PageChanging" 
    PageSize="10" TextBeforeInputBox="跳转到第" AlwaysShow="True" CssClass="page_list"> 
    </webdiyer:AspNetPager> 
      <asp:HiddenField ID="hdbegin" runat="server" />
      <asp:HiddenField ID="hdend" runat="server" />
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:DuihuaDB %>" 
        DeleteCommand="DELETE FROM ClassGrade WHERE ClassID = @ClassID" InsertCommand="INSERT INTO ClassGrade
(
	ClassID,
	UserId,
	SemesterID,
	GradeName,
	[Year],
	Intro
)
VALUES
(
	NEWID(),
	@UserId,
	@SemesterID,
	@GradeName,
	@[Year],
	@Intro
)
" SelectCommand="SELECT *,t.TeachName,(SELECT COUNT(1) FROM JoinClass jc WHERE jc.ClassID = cg.ClassID) studentCount
  FROM ClassGrade cg INNER JOIN Teacher t ON t.UserId = cg.UserId" UpdateCommand="UPDATE ClassGrade
SET
	UserId = @UserId,
	SemesterID = @SemesterID,
	GradeName = @GradeName,
	[Year] = @[Year],
	Intro = @Intro
WHERE ClassID = @ClassID">
        <DeleteParameters>
            <asp:Parameter Name="ClassID" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="UserId" />
            <asp:Parameter Name="SemesterID" />
            <asp:Parameter Name="GradeName" />
            <asp:Parameter />
            <asp:Parameter Name="Intro" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="UserId" />
            <asp:Parameter Name="SemesterID" />
            <asp:Parameter Name="GradeName" />
            <asp:Parameter />
            <asp:Parameter Name="Intro" />
            <asp:Parameter Name="ClassID" />
        </UpdateParameters>
    </asp:SqlDataSource>
</div>

<div class="form-horizontal">
 
    <fieldset>
      <div id="legend" class="">
        
        </div>
        
        <legend class="">添加作业</legend>
      </div>
    

    <div class="control-group">
      

          <!-- Text input-->
          <label class="control-label" for="input01">作业名称</label>
          <div class="controls">
            <input type="text" placeholder="请填写作业名称" class="input-xlarge">
            <p class="help-block"></p>
          </div>
        </div><div class="control-group">

          <!-- Text input-->
          <label class="control-label" for="input01">提交期限</label>
          <div class="controls">
            <input type="text" placeholder="请选择提交期限" class="input-xlarge">
            <p class="help-block"></p>
          </div>
        </div>

   
    <div class="control-group">

          <!-- Textarea -->
          <label class="control-label">作业描述</label>
          <div class="controls">
            <div class="textarea">
                  <textarea type="" class="" style="margin: 0px; width: 267px; height: 39px;"> </textarea>
            </div>
          </div>
        </div>

    <div class="control-group">
          <label class="control-label">附件</label>

          <!-- File Upload -->
          <div class="controls">
            <input class="input-file" id="fileInput" type="file" />
          </div>
        </div><div class="control-group">
          <label class="control-label"></label>

          <!-- Button -->
          <div class="controls">
            <button class="btn btn-default">保存</button>
          </div>
        </div>

    </fieldset>
  
  </div>
</asp:Content>