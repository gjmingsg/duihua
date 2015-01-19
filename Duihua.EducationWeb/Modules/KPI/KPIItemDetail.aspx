<%@ Page Title="教师评价指标" Language="C#" MasterPageFile="~/Layout/AdminDefault.Master" AutoEventWireup="true" CodeBehind="KPIItemDetail.aspx.cs" Inherits="Duihua.EducationWeb.Modules.KPI.KPIItemDetail" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<div class="panel panel-success">
    
    <div class="panel-heading">
        <h3 class="panel-title">教师评价指标</h3>
    </div>
    <div class="panel-body" id="panelbody" runat="server">
        <asp:FormView ID="FormView1" runat="server" DefaultMode="Insert" DataSourceID="SqlDataSource2" Width="100%">
        <EditItemTemplate>
      <div class="form-group">
          <label for="Title">绩效评估目标关键评估指标名称：</label>
          <asp:TextBox ID="KPITypeName" name="KPITypeName" runat="server" Text='<%#Bind("KPITypeName") %>'
              ClientIDMode="Static" CssClass="form-control"></asp:TextBox>
      </div>
       <div class="form-group">
           <label for="Memo">描述：</label>
           <asp:TextBox runat="server" ID="Memo" TextMode="MultiLine" Rows="10" Columns="20" CssClass="form-control" Text='<%#Bind("Memo") %>'></asp:TextBox>
           <asp:TextBox ID="KPITypeId" runat="server" name="KPITypeId" style='display:none' Text='<%#Bind("KPITypeId") %>' ClientIDMode="Static"></asp:TextBox> 
        </div> 
      </div>
    </EditItemTemplate>
    <InsertItemTemplate>
      <div class="form-group">
          <label for="Title">绩效评估目标关键评估指标名称：</label>
          <asp:TextBox ID="KPITypeName" name="KPITypeName" runat="server" Text='<%#Bind("KPITypeName") %>'   ClientIDMode="Static" CssClass="form-control"></asp:TextBox>
      </div>
       <div class="form-group">
           <label for="Memo">描述：</label>
           <asp:TextBox runat="server" ID="Memo" TextMode="MultiLine" Rows="10" Columns="20" CssClass="form-control"  Text='<%#Bind("Memo") %>'></asp:TextBox>
           <asp:TextBox ID="KPITypeId" runat="server" name="KPITypeId" style='display:none' Text='<%#Bind("KPITypeId") %>'  ClientIDMode="Static"></asp:TextBox> 
        </div> 
      </div>
    </InsertItemTemplate>
    </asp:FormView>
    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:DuihuaDB %>" 
     SelectCommand="SELECT [KPITypeId]
                      ,[KPITypeName]
                      ,[Memo]
                       
                  FROM [dbo].[KPIType]
                WHERE KPITypeId = @KPITypeId"
      InsertCommand="INSERT INTO [dbo].[KPIType]
                           ([KPITypeId]
                           ,[KPITypeName]
                           ,[Memo]
                           ,[Status])
                     VALUES
                           (@KPITypeId
                           ,@KPITypeName
                           ,@Memo
                           ,1)"
      UpdateCommand="UPDATE [dbo].[KPIType]
                       SET 
                          [KPITypeName] = @KPITypeName
                          ,[Memo] = @Memo
                     WHERE [KPITypeId] = @KPITypeId">
               <InsertParameters>
                    <asp:Parameter Name="KPITypeId" /> 
                    <asp:Parameter Name="Memo"  Size="2000"  Type="String"/> 
                     <asp:Parameter Name="KPITypeName" Size="500" Type="String" /> 
                    
               </InsertParameters>
               <SelectParameters>
                    <asp:QueryStringParameter  Name="KPITypeId" QueryStringField="KPITypeId" DefaultValue="00000000-0000-0000-0000-000000000000"/>
               </SelectParameters>   
               <UpdateParameters>
                    <asp:QueryStringParameter  Name="KPITypeId" QueryStringField="KPITypeId"/>
                      <asp:Parameter Name="Memo"  Size="2000" Type="String"/> 
                     <asp:Parameter Name="KPITypeName" Size="500" Type="String" /> 
                    
               </UpdateParameters>
                  </asp:SqlDataSource>

      
      <div class="panel-footer">
        <div class="form-group">
         <asp:Button ID="btnSave" runat="server" Text="保存"  ValidationGroup="vs" OnClick="btnSave_Click" CssClass="btn btn-primary"/>
         <asp:Button ID="btnBack" runat="server" Text="返回"  OnClick="btnBackList_Click" CssClass="btn btn-default"/>
      </div>
      </div>
</div>
</div>

<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
        <h4 class="modal-title" id="myModalLabel">指标明细</h4>
      </div>
      <div class="modal-body">
         <div class="form-group">
            <label for="KPIName">指标名称：</label>
             <asp:TextBox ID="KPIName" runat="server" CssClass="form-control" name="KPIName"></asp:TextBox>    
             <asp:TextBox ID="KPIId" runat="server" style="display:none" name="KPIId"></asp:TextBox>       
          </div>
          <div class="form-group">
            <label for="Score">指标分值（分）：</label>
              <asp:DropDownList ID="Score" runat="server" CssClass="form-control" name="Score">
                <asp:ListItem Text="1" Value="1"></asp:ListItem>
                <asp:ListItem Text="2" Value="2"></asp:ListItem>
                <asp:ListItem Text="3" Value="3"></asp:ListItem>
                <asp:ListItem Text="4" Value="4"></asp:ListItem>
                <asp:ListItem Text="5" Value="5"></asp:ListItem>
                <asp:ListItem Text="6" Value="6"></asp:ListItem>
                <asp:ListItem Text="7" Value="7"></asp:ListItem>
                <asp:ListItem Text="8" Value="8"></asp:ListItem>
                <asp:ListItem Text="9" Value="9"></asp:ListItem>
                <asp:ListItem Text="10" Value="10"></asp:ListItem>
              </asp:DropDownList>    
          </div>
      </div>
      <div class="modal-footer">
       <asp:Button ID="btnSaveKPI" runat="server" Text="保存"   CssClass="btn btn-success" OnClick="btnSaveKPI_Click"/>
        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      </div>
    </div>
  </div>
</div>

<div class="form-group">
         <div class="alert alert-danger" role="alert"  runat="server" id="ErrorPlan" visible="false">
               <strong>错误：</strong><asp:Label ID="lbError" runat="server"  Visible="false"></asp:Label>
         </div>
         <button type="button" class="btn btn-primary" runat="server" data-toggle="modal" data-target="#myModal" id="btnCreateKPI">添加指标</button>
          <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
              DataKeyNames="KPIId" DataSourceID="SqlDataSource1"  CssClass="table-hover table" BorderWidth="0px" RowStyle-BorderWidth="0px" >
                <EmptyDataTemplate>
                     <div class="alert alert-info" role="alert">暂时没有指标项</div>
               </EmptyDataTemplate>
              <Columns>
                  <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" HeaderText="操作" HeaderStyle-Width="100px" />
                  <asp:BoundField DataField="KPIId" HeaderText="KPIId" ReadOnly="True"   Visible="False" />
                  <asp:BoundField DataField="KPITypeId" HeaderText="KPITypeId"  Visible="False" />
                  <asp:BoundField DataField="KPIName" HeaderText="指标名称"  />
                  <asp:BoundField DataField="Score" HeaderText="指标分值" />
              </Columns>
          </asp:GridView>
          <asp:SqlDataSource ID="SqlDataSource1" runat="server"    onupdating="SqlDataSource1_Updating"
              ConnectionString="<%$ ConnectionStrings:DuihuaDB %>" 
              DeleteCommand="DELETE FROM KPIItem where KPIId  = @KPIId" 
              InsertCommand="INSERT INTO KPIItem(KPIId, KPITypeId, KPIName, Score ) VALUES (@KPIId, @KPITypeId, @KPIName, @Score )" 
              SelectCommand="SELECT [KPIId], [KPITypeId], [KPIName], [Score], [Way] FROM [KPIItem] where KPITypeId=@KPITypeId" 
              UpdateCommand="UPDATE KPIItem SET KPITypeId =@KPITypeId , KPIName =@KPIName , Score =@Score   where [KPIId] = @KPIId" >
              <DeleteParameters>
                  <asp:Parameter Name="KPIId" />
              </DeleteParameters>
              <InsertParameters>
                   <asp:ControlParameter Name="KPIId" ControlID="KPIId" />
                  <asp:QueryStringParameter  Name="KPITypeId" QueryStringField="KPITypeId" />
                  <asp:ControlParameter Name="KPIName" ControlID="KPIName" />
                  <asp:ControlParameter Name="Score" ControlID="Score" />
              </InsertParameters>
              <UpdateParameters>
                  <asp:QueryStringParameter  Name="KPITypeId" QueryStringField="KPITypeId" />
                   <asp:Parameter Name="KPIName" />
                   <asp:Parameter Name="Score" /> 
                   <asp:Parameter Name="KPIId" /> 
              </UpdateParameters>
               <SelectParameters>
                    <asp:QueryStringParameter  Name="KPITypeId" QueryStringField="KPITypeId" DefaultValue="00000000-0000-0000-0000-000000000000"/>
               </SelectParameters>   
          </asp:SqlDataSource>
      </div>

</asp:Content>
