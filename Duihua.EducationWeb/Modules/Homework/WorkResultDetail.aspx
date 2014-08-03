<%@ Page Title="课程作业" Language="C#" ValidateRequest="false" MasterPageFile="~/Layout/Course.master" AutoEventWireup="true" CodeBehind="WorkResultDetail.aspx.cs" Inherits="Duihua.EducationWeb.Modules.Homework.WorkResultDetail" %>
<%@ Register Src="~/Modules/Common/UCAttachment.ascx" TagName="Attachment" TagPrefix="UC" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Main" runat="server">

<div id="HomeworkInfo" runat="server">
    <h3><%=HomeWork["Title"].ToString()%></h3>
    <dl class="dl-horizontal">
        
       <dt><label>作业分数：</label></dt>
       <dd><span class="label label-default"><%=HomeWork["Score"] %></span></dd> 
    
        <dt><label>已提交作业数：</label></dt>
       <dd><span class="label label-default"><%=HomeWork["hasSubmit"]%></span> </dd>
   
         <dt><label>开始提交时间：</label></dt>
        <dd><span class="label label-info"><%=HomeWork["BeginTime"]%></span></dd>
    
         <dt><label>提交结束时间：</label></dt>
        <dd><span class="label label-danger"><%=HomeWork["DeadLine"]%></span></dd>
    
    </dl>
     <blockquote>
      <label>作业要求：</label>
      <p><%=HomeWork["Content"].ToString() %></p>
    </blockquote>
     
        <UC:Attachment runat="server" EditMode='false' ID="Attachment" Text="作业说明附件："></UC:Attachment>
     <div>
          <asp:Button ID="btnSubmitWork"  runat="server" Text="交作业" OnClick="btnSubmitWork_Click"   CssClass="btn btn-primary"/>   
          <asp:Button ID="btnEvaluate"  runat="server" Text="改作业" OnClick="btnEvaluate_Click"   CssClass="btn btn-primary"/>   
     </div>
 </div>

<div id="SubmitHomework" runat="server" visible="false">
 <h3><%=HomeWork["Title"].ToString()%></h3>
<div class="alert alert-danger" role="alert" id="WorkTips" runat="server"><strong>注意!</strong>
    作业可以多次提交，但只对最后一次提交的作业进行评分，请在提交结束时间前提交作业，否则不予评分！
</div>
    <div class="form-group">
        <label for="eContent">第
        <span class="label label-danger">
        <asp:Label ID="lbModifyCount" runat="server" name="ModifyCount"></asp:Label>
        </span>次提交</label>
        
     </div>

     <div class="form-group">
        <label for="eContent">提交说明：</label>
        <asp:TextBox ID="eSubmitText" ClientIDMode="Static" runat="server" name="SubmitText"  CssClass="form-control" TextMode="MultiLine" placeholder="作业详细说明" rows="10"></asp:TextBox>   
     </div>
     
    <UC:Attachment runat="server" EditMode='true' ID="Attachment1" ClientIDMode="Static" Text="作业附件："></UC:Attachment>
    
    <asp:TextBox ID="tbWorkResultID" name="WorkResultID" ClientIDMode="Static" runat="server" style="display:none"/>
    <asp:TextBox ID="tbWorkID" name="WorkID" ClientIDMode="Static" runat="server" style="display:none"/>
    <div>
          <asp:Button  ID="btnSave" runat="server" Text="提交" OnClick="btnSave_Click" CssClass="btn btn-primary"/> 
          <asp:Button  ID="btnViewScore" runat="server" Text="查看成绩" data-toggle="modal" data-target=".bs-submit-modal-sm"    CssClass="btn btn-primary"/>  
    </div>
    
    <!--查看成绩 start-->
    <div class="modal fade bs-submit-modal-sm" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content">
         <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
        <h4 class="modal-title" id="myModalLabel">作业成绩</h4>
      </div>
      <div class="modal-body">
        <label>分数：</label><span class="label label-info">
            <asp:Label ID="lbScore" runat="server" name="Score"></asp:Label>
        </span>
        <blockquote>
            <p>
                <asp:Label ID="lbEvaluate" runat="server" name="Evaluate"></asp:Label></p>
             <footer>评分时间：<cite title="Source Title">
                 <asp:Label ID="lbGradeTime" runat="server" name="GradeTime"></asp:Label>
             </cite></footer>
        </blockquote>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      </div>
        </div>
      </div>
    </div>
    <!--查看成绩 end-->


     <asp:SqlDataSource ID="SqlDataSource1" runat="server"  ConnectionString="<%$ ConnectionStrings:DuihuaDB %>" 
     InsertCommand="INSERT INTO [dbo].[WorkResult]
           ([WorkID]
           ,[UserId]
           ,[SubmitTime]
           ,[ModifyCount]
           ,[CreateTime]
           ,WorkResultID
           ,[SubmitText])
     VALUES
           (@WorkID
           ,@UserId
           ,GETDATE()
           ,0
           ,GETDATE()
           ,@WorkResultID
           ,@SubmitText
          )"
     UpdateCommand="UPDATE [dbo].[WorkResult]
   SET  [SubmitText] = @SubmitText
      ,ModifyCount = ModifyCount+1
 WHERE [WorkID] = @WorkID
 AND UserId =@UserId"  >
        <InsertParameters>
        <asp:SessionParameter Name="UserId" SessionField="UserId" DefaultValue="00000000-0000-0000-0000-000000000000"/>
        <asp:QueryStringParameter Name="WorkID" QueryStringField="WorkID" DefaultValue="00000000-0000-0000-0000-000000000000"/>
        <asp:ControlParameter ControlID="eSubmitText" Name="SubmitText" />
        <asp:ControlParameter ControlID="tbWorkResultID" Name="WorkResultID" DefaultValue="00000000-0000-0000-0000-000000000000"/>
        </InsertParameters>
        <UpdateParameters>
        <asp:SessionParameter Name="UserId" SessionField="UserId" DefaultValue="00000000-0000-0000-0000-000000000000"/>
         <asp:QueryStringParameter Name="WorkID" QueryStringField="WorkID" DefaultValue="00000000-0000-0000-0000-000000000000"/>
        <asp:ControlParameter ControlID="eSubmitText" Name="SubmitText" />
        </UpdateParameters>
     </asp:SqlDataSource>
</div>   

<div runat="server" id="EvaluateWork" visible="false">
    <div runat="server" id="list"  class="panel panel-success">
    <div  class="panel-heading">
        <h3 class="panel-title">需要批改的作业</h3>
    </div>
    <div class="panel-body">
            <div class="alert alert-danger" role="alert"  runat="server" id="ErrorPlan" visible="false">
               <strong>错误：</strong><asp:Label ID="lbError" runat="server" ></asp:Label>
            </div>

            <div class="table-responsive">
                <asp:GridView ID="GridView1" runat="server" AllowSorting="True" CssClass="table-hover table" 
                    AutoGenerateColumns="False" DataSourceID="SqlDataSource2" DataKeyNames="WorkID,UserId">
                    <EmptyDataTemplate>
                        <div class="alert alert-info" role="alert">暂时没有作业需要批改</div>
                    </EmptyDataTemplate>
                    <Columns>
                        
                        <asp:TemplateField HeaderText="操作" >
                            <EditItemTemplate>
                                <asp:LinkButton  CommandName="Update"  runat="server">更新</asp:LinkButton>
                               <asp:LinkButton CommandName="Cancel"  runat="server">取消</asp:LinkButton>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:LinkButton CommandName="Edit"  runat="server">编辑</asp:LinkButton>
                                <asp:LinkButton CommandName="View" onclick="lbView_Click" _UserId='<%#Eval("UserId") %>' _WorkID='<%#Eval("WorkID") %>' runat="server">详情</asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                       
                        <asp:BoundField DataField="WorkID" HeaderText="WorkID" ReadOnly="True" Visible="false"/>    
                        <asp:BoundField DataField="UserId" HeaderText="UserId" ReadOnly="True" Visible="false"/>
                        <asp:BoundField DataField="StudentName" HeaderText="学生名"  ApplyFormatInEditMode="false" ReadOnly="true"/>
                        <asp:BoundField DataField="EvaludateStatus" HeaderText="批改状态" ApplyFormatInEditMode="false" ReadOnly="true"/>
                        <asp:BoundField DataField="Score" HeaderText="分数"  HeaderStyle-Width="50"/>
                        <asp:BoundField DataField="Evaluate" HeaderText="评语" />
                    </Columns>
                </asp:GridView>
            </div>
    </div>
        
    </div>
    <div id="detail" runat="server" visible='false'>
         <div class="form-group">
            <label for="eContent">第
            <span class="label label-danger">
            <asp:Label  ClientIDMode="Static" runat="server" name="ModifyCount"></asp:Label>
            </span>次提交</label>
         </div>

         <div class="form-group">
            <label for="eContent">提交说明：</label>
            <blockquote>
             <asp:Label ClientIDMode="Static" runat="server" name="SubmitText" ></asp:Label>
            </blockquote>
         </div>
        
        <UC:Attachment runat="server" EditMode='false' ID="Attachment2" ClientIDMode="Static" Text="作业附件："></UC:Attachment>
       <hr />
       <div class="form-group">
            <label for="eScore">评分：</label>
           <asp:TextBox ID="eScore" runat="server" name="Score" ClientIDMode="Static"  CssClass="form-control"></asp:TextBox>
           <asp:RequiredFieldValidator ControlToValidate="eScore"  runat="server" ErrorMessage="评分为必填项" ></asp:RequiredFieldValidator>
         </div>
         <div class="form-group">
            <label for="eEvaluate">评语：</label>
            <asp:TextBox ID="eEvaluate"  CssClass="form-control" runat="server" name="Evaluate" ClientIDMode="Static" TextMode="MultiLine" Rows="10"></asp:TextBox>
         </div>
        <div>
              <asp:Button  ID="btnSaveEvaluate" runat="server" Text="保存" OnClick="btnSaveEvaluate_Click" CssClass="btn btn-primary"/> 
        </div>
        <asp:TextBox ID="eWorkID" name="WorkID" runat="server"  ClientIDMode="Static" CssClass="hide"></asp:TextBox>
        <asp:TextBox ID="tbUserId" name="UserId" runat="server"  ClientIDMode="Static" CssClass="hide"></asp:TextBox>
        <asp:TextBox ID="eWorkResultID" name="WorkResultID" runat="server"  ClientIDMode="Static" CssClass="hide"></asp:TextBox>
    </div>
    <asp:SqlDataSource ID="SqlDataSource2" runat="server"  ConnectionString="<%$ ConnectionStrings:DuihuaDB %>" 
    UpdateCommand="UPDATE  [dbo].[WorkResult]
   SET 
      [Evaluate] = @Evaluate
      ,[GradeTime] = GETDATE()
      ,[Score] = @Score
 WHERE [WorkID] = @WorkID
      AND [UserId] = @UserId"  
      SelectCommand="SELECT [WorkID]
      ,w.[UserId]
      ,[Evaluate]
      ,[SubmitTime]
      ,[GradeTime]
      ,[ModifyCount]
      ,[CreateTime]
      ,[Score]
      ,[SubmitText]
      ,[WorkResultID]
      ,s.StudentName
      ,CASE WHEN [GradeTime] IS NOT NULL
      THEN '已批改'
      ELSE '未批改' end EvaludateStatus
  FROM  [dbo].[WorkResult] w
  INNER JOIN Student s ON s.UserId = w.UserId
WHERE WorkID=@WorkID" 
        onupdating="SqlDataSource2_Updating">
    <UpdateParameters>
        <asp:Parameter Name="UserId"  />
        <asp:Parameter Name="WorkID" />
        <asp:Parameter   Name="Score" />
         <asp:Parameter  Name="Evaluate" />
        
    </UpdateParameters>
    <SelectParameters>
       <asp:QueryStringParameter Name="WorkID" QueryStringField="WorkID" DefaultValue="00000000-0000-0000-0000-000000000000" />
    </SelectParameters>
    </asp:SqlDataSource>
</div>
  
</asp:Content>
