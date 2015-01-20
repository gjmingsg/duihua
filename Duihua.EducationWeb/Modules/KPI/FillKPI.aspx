<%@ Page Title="" Language="C#" MasterPageFile="~/Layout/Course.master" AutoEventWireup="true" CodeBehind="FillKPI.aspx.cs" Inherits="Duihua.EducationWeb.Modules.KPI.FillKPI" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
<style type="text/css">
    .checkbox-inline label{ margin-right:20px;}
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Main" runat="server">
 <div class="panel panel-success">
  
      <div class="panel-heading">
        <h3 class="panel-title">教师评价指标</h3>
    </div>

      <div class="panel-body" id="panelbody" runat="server" visible="false">

          <div class="form-group">
            <div class="alert alert-danger" role="alert"  runat="server" id="ErrorPlan" visible="false">
               <strong>错误：</strong><asp:Label ID="lbError" runat="server"  Visible="false"></asp:Label>
         </div>

          <asp:Repeater ID="rptKPIFill" runat="server" DataSourceID="SqlDataSource1">
          <ItemTemplate>
              <div>
                <blockquote>
                  <p><%#Eval("KPIName")%></p>
                  该项分数为：<span class="label label-danger"><%#Eval("ShowScore")%></span>
                </blockquote>
                <label class="checkbox-inline">
                  <asp:RadioButtonList ID="Score" runat="server" _ScoreId='<%#Eval("ScoreId") %>' _sel='<%#Eval("Score") %>'  _val='<%#Eval("ShowScore")%>' RepeatDirection="Horizontal" RepeatLayout="Flow">
                  </asp:RadioButtonList>
                 </label>
              </div>
              <hr />
          </ItemTemplate>
          </asp:Repeater>

          <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
              ConnectionString="<%$ ConnectionStrings:DuihuaDB %>" 
              
              SelectCommand="SELECT s.ScoreId
                            ,s.Score
                            ,k2.KPIName
                            ,k2.Score ShowScore
                            ,s.KPITeacherId
                              FROM KPITeacher k INNER JOIN KPIScore s ON s.KPITeacherId = k.KPITeacherId
                            INNER JOIN KPIItem k2 ON k2.KPIId = s.KPIId
                            WHERE k.CourseID=@CourseID
                            AND k.Creator = @UserId
                            and k.KPIReleaseId = @KPIReleaseId
                            ">
                <SelectParameters>
                    <asp:QueryStringParameter Name="CourseID" QueryStringField="CourseID" DefaultValue ="00000000-0000-0000-0000-000000000000" />
                    <asp:SessionParameter Name="UserId" SessionField="UserId" DefaultValue ="00000000-0000-0000-0000-000000000000" />
                    <asp:Parameter Name="KPIReleaseId"/>
                </SelectParameters>
    
             
          </asp:SqlDataSource>

          </div>
       
          <div class="form-group">
              <label for="Memo">总体评价：</label>
              <asp:TextBox ID="Memo" name="Memo" runat="server" TextMode="MultiLine" CssClass="form-control" Rows="10"></asp:TextBox>
              <asp:HiddenField ID="KPITeacherId" runat="server" />
          </div>
        </div>
      <div class="panel-footer" id="panelfoot" runat="server"  visible="false">
            <div class="form-group">
                <asp:Button ID="btnSave" runat="server" Text="保存"  OnClick="btnSave_Click" CssClass="btn btn-primary"/>
                <asp:Button ID="btnBack" runat="server" Text="返回"  OnClick="btnBack_Click" CssClass="btn btn-default"/>
            </div>
        </div>

      <div class="panel-body" id="paneltext" runat="server">
     <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource2">
     <ItemTemplate>
        <div>
            <p>
                <%#Eval("Memo") %>
            </p>
            <p>填报状态：<strong><%#Eval("IsFinishText")%></strong></p>
            <p>发布时间：<span class="label label-info"><%#Eval("CreateTime")%></span></p>
            <asp:Button ID="btnViewDetail" runat="server" Text="查看详情" CssClass="btn btn-primary btn-sm" OnClick="btnViewDetail_Click" _KPITeacherId='<%#Eval("KPITeacherId") %>' _KPIReleaseId='<%#Eval("KPIReleaseId") %>'/>
        </div>
        <hr />
     </ItemTemplate>
     </asp:Repeater>
     </div>
      <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
              ConnectionString="<%$ ConnectionStrings:DuihuaDB %>" 
              SelectCommand="SELECT r.[KPIReleaseId]
                              , r.[CreateTime]
                              , r.[Memo]
                              , r.[Creator]
                              , CASE WHEN  isnull(k.IsFinish,0) =0 then '未填报'
                              else '已填报' end IsFinishText
                              ,isnull(k.IsFinish,0)IsFinish
                              ,k.KPITeacherId
                          FROM [dbo].[KPIRelease] r
                          INNER JOIN   KPITeacher k ON k.KPIReleaseId = r.KPIReleaseId
                        WHERE k.CourseID = @CourseID
                         AND k.Creator = @UserId"
                          
                         >
                <SelectParameters>
                    <asp:QueryStringParameter Name="CourseID" QueryStringField="CourseID" DefaultValue ="00000000-0000-0000-0000-000000000000" />
                    <asp:SessionParameter Name="UserId" SessionField="UserId" DefaultValue ="00000000-0000-0000-0000-000000000000" />
                </SelectParameters>
                
        </asp:SqlDataSource>
 </div>
</asp:Content>
