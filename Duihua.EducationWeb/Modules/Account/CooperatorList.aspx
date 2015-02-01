<%@ Page Title="合作单位" Language="C#" MasterPageFile="~/Layout/AdminDefault.Master" AutoEventWireup="true" CodeBehind="CooperatorList.aspx.cs" Inherits="Duihua.EducationWeb.Modules.Account.CooperatorList" %>
<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<div runat="server" id="list"  class="panel panel-success">
    <div  class="panel-heading">
        <h3 class="panel-title">合作单位信息管理</h3>
    </div>
    <div class="panel-body">
        <div class="form-group col-sm-offset-4 col-sm-4 col-xs-8">
            <label class="sr-only" for="sCooperatorName">合作单位名称</label>
            <asp:TextBox runat="server" ClientIDMode="Static"  ID="sCooperatorName" CssClass="form-control" placeholder="输入班级名称"></asp:TextBox>
        </div>
        
        <div class="form-group  col-sm-2  col-xs-2">
            <asp:Button runat="server" ID="btnSearch" ClientIDMode="Static" Text="搜索" onclick="btnSearch_Click" CssClass="btn btn-default"/>
        </div>
        <div class="form-group  col-sm-2   col-xs-2">
            <asp:Button runat="server"  ClientIDMode="Static" Text="添加" onclick="btnNew_Click" CssClass="btn btn-primary"/>
        </div>
        <br />
        <br />
    </div>
<div class="table-responsive">
<table class="table table-hover">
        <thead>
          <tr>
              <th>操作</th> 
              <th>单位名称</th>
              <th>所在地址</th>
              <th>生源数</th>
                            
          </tr>
        </thead>
        <tbody>
  <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource1">
   
  <ItemTemplate>
  <tr class="active">  
        <td>
                <asp:LinkButton ID="LinkButton1"   runat="server" CssClass="fl btn5"  OnClick="lbOperator_Click"
                                     CausesValidation="False" CommandName="Edit" 
                                Text="编辑"  _Id='<%#Eval("CooperatorId") %>' />
                
                 <asp:LinkButton ID="LinkButton2"   runat="server" CssClass="fl btn5"   OnClick="lbOperator_Click"
                                     CausesValidation="False" CommandName="View" 
                                Text="查看"   _Id='<%#Eval("CooperatorId") %>' />

                 <asp:LinkButton ID="LinkButton3"   runat="server" CssClass="fl btn3" CausesValidation="False" CommandName="Delete"
                       OnClick="lbOperator_Click"   Text="删除" OnClientClick="return confirm('确认要删除吗？');" _Id='<%#Eval("CooperatorId") %>' />
             </td>
            <td><%#Eval("CooperatorName")%></td>
            <td><%#Eval("Address")%></td>
            <td><a href='JoinClassList.aspx?ClassID=<%#Eval("CooperatorId") %>&ReturnUrl=<%=Request.RawUrl %>'><%#Eval("studentcount")%></a></td>
          
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
        DeleteCommand="DELETE FROM Cooperator WHERE CooperatorId = @CooperatorId" 
        InsertCommand="INSERT INTO  [dbo].[Cooperator]
           ([CooperatorId]
           ,[CooperatorName]
           ,[Address]
           ,[Intro]
           ,[CreateTime]
           ,[Creator]
           )
     VALUES
           (@CooperatorId
           ,@CooperatorName
           ,@Address
           ,@Intro
           ,GETDATE()
           ,@Creator
           )


" SelectCommand="
SELECT tx.* FROM (
SELECT [CooperatorId]
      ,[CooperatorName]
      ,[Address]
      ,[Intro]
      ,[CreateTime]
      ,[Creator]
      ,[UpdateTime]
      ,[UpdateUser]
      ,(SELECT COUNT(1) FROM Student s WHERE s.CooperatorId = [dbo].[Cooperator].CooperatorId) studentcount
      ,ROW_NUMBER() OVER ( ORDER BY CreateTime DESC) pageindex
  FROM [dbo].[Cooperator]
WHERE CooperatorName LIKE '%'+@CooperatorName+'%'
) tx
where pageIndex between @begin and @end
ORDER BY pageIndex asc
" UpdateCommand="UPDATE [dbo].[Cooperator]
   SET
      [CooperatorName] = @CooperatorName
      ,[Address] = @Address
      ,[Intro] = @Intro
      ,[UpdateTime] =GETDATE()
      ,[UpdateUser] = @UpdateUser
 WHERE [CooperatorId]=@CooperatorId
" ondeleting="SqlDataSource1_Deleting" oninserting="SqlDataSource1_Inserting" 
        onupdating="SqlDataSource1_Updating">
        <DeleteParameters>
            <asp:Parameter Name="CooperatorId" />
        </DeleteParameters>
        <InsertParameters>
            <asp:ControlParameter ControlID="eCooperatorId" Name="CooperatorId" />
            <asp:Parameter Name="Creator"/>
            <asp:ControlParameter ControlID="eIntro" Name="Intro" />
            <asp:ControlParameter ControlID="eAddress" Name="Address" />
            <asp:ControlParameter ControlID="eCooperatorName" Name="CooperatorName" />
        </InsertParameters>
        <UpdateParameters>
            <asp:ControlParameter ControlID="eCooperatorId" Name="CooperatorId" />
            <asp:Parameter Name="UpdateUser"/>
            <asp:ControlParameter ControlID="eIntro" Name="Intro" />
            <asp:ControlParameter ControlID="eAddress" Name="Address" />
            <asp:ControlParameter ControlID="eCooperatorName" Name="CooperatorName" />
        </UpdateParameters>
        <SelectParameters>
             <asp:ControlParameter ControlID="hdend"  ConvertEmptyStringToNull="false" Name="end" />
             <asp:ControlParameter ControlID="hdbegin"  ConvertEmptyStringToNull="false" Name="begin" />
             <asp:ControlParameter ControlID="sCooperatorName"  ConvertEmptyStringToNull="false" Name="CooperatorName"/>
        </SelectParameters>
    </asp:SqlDataSource>

</div>

<div runat="server" id="view" visible="false"  class="panel panel-success">
    <div class="panel-heading">
        <h3 class="panel-title">合作单位信息</h3>
    </div>
    
    <div class="panel-body">
        单位名称：<asp:Label    runat="server" name="CooperatorName"></asp:Label>
        <br />
        <br />
        所在地址：<asp:Label    runat="server" name="Address"></asp:Label>
        <br />
        <br />
         生源数：<span class="badge"><br /><asp:Label   runat="server" name="studentcount"></asp:Label></span>
        <br />
        <br />
         <blockquote>
        单位描述：<asp:Label   runat="server" name="Intro"></asp:Label>
        </blockquote>
         <br />
        <br />
       
    </div>
    <div class="panel-footer">
        <div class="col-sm-offset-10">
            <asp:Button ID="Button1"  runat="server" Text="返回" onclick="btnBackList_Click" CssClass="btn btn-default"/>
        </div>
    </div>
</div>

<div runat="server" id="detail" visible="false"  class="panel panel-success">
  <div class="panel-heading">
        <h3 class="panel-title">合作单位信息</h3>
    </div>
    <div class="panel-body">
      <div class="form-group">
         <label for="eCooperatorName">单位名称：</label>
         <asp:TextBox ID="eCooperatorName" ClientIDMode="Static" runat="server" name="CooperatorName" CssClass="form-control" placeholder="单位名称"></asp:TextBox>
          <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ValidationGroup="vd" ControlToValidate="eCooperatorName" runat="server" ErrorMessage="“单位名称”必填" Display="Dynamic" CssClass="error-info"></asp:RequiredFieldValidator>
      </div>
      <div class="form-group">
          <label for="eAddress">所在地址：</label>
           <asp:TextBox ID="eAddress" ClientIDMode="Static" runat="server" name="Address" CssClass="form-control" placeholder="单位名称"></asp:TextBox>
          <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ValidationGroup="vd" ControlToValidate="eAddress" runat="server" ErrorMessage="“所在地址”必填" Display="Dynamic" CssClass="error-info"></asp:RequiredFieldValidator>
      </div>
       
     
      <div class="form-group">
        <label for="eIntro">单位描述：</label>
        <asp:TextBox ID="eIntro" ClientIDMode="Static" runat="server" name="Intro"  CssClass="form-control" TextMode="MultiLine" placeholder="单位描述" rows="4"></asp:TextBox>
         <asp:TextBox ID="eCooperatorId" runat="server" name="CooperatorId" CssClass="hidden"></asp:TextBox>
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
</asp:Content>