<%@ Page Title="" Language="C#" MasterPageFile="~/Layout/AdminDefault.Master" 
AutoEventWireup="true" CodeBehind="WorkResultView.aspx.cs" 
Inherits="Duihua.EducationWeb.Modules.Homework.WorkResultView" %>
<%@ Register Src="~/Modules/Common/UCAttachment.ascx" TagName="Attachment" TagPrefix="UC" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<div class="panel panel-default" runat="server" id="view">
  <!-- Default panel contents -->
  <div class="panel-heading">
      <asp:Label ID="lbTitle" runat="server" name="Title"></asp:Label>
  </div>
  <div class="panel-body">
      
       <dl class="dl-horizontal">
        
       <dt><label>作业分数：</label></dt>
       <dd><span class="label label-default"> <asp:Label ID="Score" runat="server"></asp:Label></span></dd> 
   
         <dt><label>开始提交时间：</label></dt>
        <dd><span class="label label-info"> <asp:Label ID="BeginTime" runat="server"></asp:Label></span></dd>
    
         <dt><label>提交结束时间：</label></dt>
        <dd><span class="label label-danger">
            <asp:Label ID="DeadLine" runat="server"></asp:Label> </span></dd>
    
    </dl>
     <blockquote>
      <label>作业要求：</label>
     
    </blockquote>
      <label>评分：</label><span class="label label-info">
            <asp:Label ID="lbScore" runat="server" name="getScore"></asp:Label>
        </span>
        <blockquote>
            <p>
                <asp:Label ID="lbEvaluate" runat="server" name="Evaluate"></asp:Label>
            </p>
             <footer>评分时间：
                 <cite title="Source Title">
                    <asp:Label ID="lbGradeTime" runat="server" name="GradeTime"></asp:Label>
                 </cite>
             </footer>
        </blockquote>
  </div>

   <UC:Attachment runat="server" EditMode='false' ID="Attachment1" ClientIDMode="Static" Text="作业附件："></UC:Attachment>
</div>

</asp:Content>
