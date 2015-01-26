<%@ Page Title="学生信息管理" Language="C#" MasterPageFile="~/Layout/AdminDefault.Master" AutoEventWireup="true" CodeBehind="CooperatorStudentList.aspx.cs" Inherits="Duihua.EducationWeb.Modules.Student.CooperatorStudentList" %>
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
              
          
            </div>
        </div>
        <div class="col-sm-12  col-xs-12">
            
            <div class="form-group col-sm-offset-7 col-xs-offset-7  col-sm-2 col-xs-2">
                <asp:Button runat="server" ID="btnSearch" ClientIDMode="Static" Text="搜索" onclick="btnSearch_Click" CssClass="btn btn-default"/>
            </div>
            <div class="form-group  col-sm-offset-1 col-xs-offset-1 col-sm-2 col-xs-2">
              
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
               
                <asp:LinkButton  runat="server" CssClass="fl btn5"   OnClick="lbOperator_Click"   CausesValidation="False" CommandName="View"   Text="查看"   _Id='<%#Eval("UserId") %>' />
               
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
>
       
        <SelectParameters>
             <asp:ControlParameter ControlID="hdend"  ConvertEmptyStringToNull="false" Name="end" />
             <asp:ControlParameter ControlID="hdbegin"  ConvertEmptyStringToNull="false" Name="begin" />
             <asp:ControlParameter ControlID="sIDCard"  ConvertEmptyStringToNull="false" Name="IDCard"/>
             <asp:ControlParameter ControlID="sStudentName"  ConvertEmptyStringToNull="false" Name="StudentName"/>
              <asp:ControlParameter ControlID="sStatus"  ConvertEmptyStringToNull="false" Name="Status" />
              <asp:SessionParameter SessionField="UserId" Name="CooperatorId" ConvertEmptyStringToNull="false" DefaultValue="00000000-0000-0000-0000-000000000000"/>

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
  
</asp:Content>
