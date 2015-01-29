<%@ Page Title="" Language="C#" MasterPageFile="~/Layout/AdminDefault.Master" AutoEventWireup="true" CodeBehind="StudentRange.aspx.cs" Inherits="Duihua.EducationWeb.Modules.Homework.StudentRange" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<div class="panel panel-default">
  <div class="panel-heading">优秀作业精选</div>
    <div class="panel-body">


    <div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
       <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource1">
            <ItemTemplate>
              <div class="panel panel-info">
                <div class="panel-heading" role="tab" id='h-<%#Eval("WorkID") %>'>
                  <h4 class="panel-title">
                    <a data-toggle="collapse" data-parent="#accordion" href='#<%#Eval("WorkID") %>' aria-expanded="true" aria-controls='<%#Eval("WorkID") %>'>
                     【<%#Eval("CourseName")%> / 课程老师：<%#Eval("Teacher")%>】<%#Eval("Title")%>
                     <span class="label label-info"><%#Eval("CreateTime")%></span>
                        <asp:TextBox ID="tbHideData" style=" display:none" _CourseID='<%#Eval("CourseID") %>' _WorkID='<%#Eval("WorkID") %>' runat="server"></asp:TextBox>
                    </a>
                  </h4>
                </div>
                <div id='<%#Eval("WorkID") %>' class="panel-collapse collapse in" role="tabpanel" aria-labelledby='h-<%#Eval("WorkID") %>'>
                    <div class=" col-xs-12 col-sm-12" style=" margin-top:10px;">
                        <asp:Repeater ID="Repeater2" runat="server" DataSourceID="SqlDataSource2">
                            <ItemTemplate>
                             <div class="col-xs-4 col-sm-4">
                                <div  class="col-xs-6 col-sm-6">
                                    <img class="img-responsive" alt='第<%#Eval("orderindex") %>名' src='../../Images/cup_<%#Eval("orderindex") %>.png' />
                                </div>
                                <div class="col-xs-6 col-sm-6 pull-right">
                                    <h3><span class="label label-success">第<%#Eval("orderindex")%>名</span></h3>
                                    <p>
                                    学生：<%#Eval("UserName") %><br />
                                    分数：<span class="label label-success"><%#Eval("Score") %></span>(满分<span class="label label-default"><%#Eval("TotalScore") %></span>)
                                    </p>
                                
                                    <p>作业说明：<%#Eval("Evaluate") %></p>
                                    <p>
                                        <a href='../Homework/WorkResultView.aspx?WorkResultID=<%#Eval("WorkResultID") %>' class="btn btn-primary" role="button">查看</a>
                                    </p>
                                </div>
                            </div>
                        
                          </ItemTemplate>
                      </asp:Repeater>
                        <asp:SqlDataSource ID="SqlDataSource2" runat="server"  ConnectionString="<%$ ConnectionStrings:DuihuaDB %>" 
                         SelectCommand="SELECT
                                        TOP 3 
                                        wr.WorkResultID
                                        ,wr.Evaluate
                                        ,wr.Score
                                        ,wr.UserId
                                        ,au.UserName
                                        ,hw.Score TotalScore
                                        ,ROW_NUMBER()OVER(ORDER BY wr.Score DESC) orderindex
                                         FROM WorkResult wr
                                        INNER JOIN HomeWork hw ON hw.WorkID = wr.WorkID
                                        INNER JOIN aspnet_Users au ON au.UserId = wr.UserId
                                        WHERE hw.WorkID = @WorkID
                                        AND hw.CourseID = @CourseID
                                        ---and wr.Score is not null
                                        ORDER BY wr.Score DESC">
                                        <SelectParameters>
                                            <asp:Parameter Name="WorkID" />
                                            <asp:Parameter Name="CourseID"/>
                                        </SelectParameters>
                                        </asp:SqlDataSource>
                    </div>
                    
                    
                    <table class="table  table-hover">
                        <thead>
                            <tr>
                                <th>名次</th>
                                <th>学生</th>
                                <th>得分</th>
                                <th>满分</th>
                                <th>作业说明</th>
                            </tr>
                        </thead>
                        <tbody>
                            
                            <asp:Repeater ID="Repeater3" runat="server" DataSourceID="SqlDataSource3">
                                <ItemTemplate>
                                    <tr class='<%#Eval("UserId").ToString()==Session["UserId"].ToString()?"danger":"" %>'>
                                        <td><a href='../Homework/WorkResultView.aspx?WorkResultID=<%#Eval("WorkResultID") %>'><%#Eval("orderindex")%></a></td>
                                        <td><%#Eval("UserName")%></td>
                                        <td><%#Eval("Score")%></td>
                                        <td><%#Eval("TotalScore")%></td>
                                        <td><%#Eval("Evaluate")%></td>
                                    </tr>
                                </ItemTemplate>
                            </asp:Repeater>
                                
                        </tbody>
                    </table>
                        
                    <asp:SqlDataSource ID="SqlDataSource3" runat="server"   ConnectionString="<%$ ConnectionStrings:DuihuaDB %>"
                         SelectCommand="SELECT
                                        wr.WorkResultID
                                        ,wr.Evaluate
                                        ,wr.Score
                                        ,wr.UserId
                                        ,au.UserName
                                        ,hw.Score TotalScore
                                        ,ROW_NUMBER()OVER(ORDER BY wr.Score DESC) orderindex
                                         FROM WorkResult wr
                                        INNER JOIN HomeWork hw ON hw.WorkID = wr.WorkID
                                        INNER JOIN aspnet_Users au ON au.UserId = wr.UserId
                                        WHERE hw.WorkID = @WorkID
                                        AND hw.CourseID = @CourseID
                                        ORDER BY wr.Score DESC">
                                         <SelectParameters>
                                            <asp:Parameter Name="WorkID" />
                                            <asp:Parameter Name="CourseID"/>
                                        </SelectParameters>
                                        </asp:SqlDataSource>
                    
                </div>
              </div>
            </ItemTemplate>
        </asp:Repeater>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server"  ConnectionString="<%$ ConnectionStrings:DuihuaDB %>" 
         SelectCommand="SELECT c.CourseID
                                ,c.CourseName
                                ,hw.WorkID
                                ,hw.Title
                                ,au.UserName Teacher
                                ,hw.CreateTime 
                                  FROM JoinCourse jc INNER JOIN Course c ON c.CourseID = jc.CourseID
                                INNER JOIN HomeWork hw ON hw.CourseID = c.CourseID
                                INNER JOIN TeachJoinCourse tjc ON tjc.CourseID = c.CourseID
                                INNER JOIN aspnet_Users au ON au.UserId = tjc.UserId
                                WHERE jc.UserId = @UserId
                                ORDER BY hw.CreateTime DESC">
            <SelectParameters>
                <asp:SessionParameter Name="UserId" SessionField="UserId" DefaultValue="00000000-0000-0000-0000-000000000000" />
            </SelectParameters>
        </asp:SqlDataSource>

  </div>



         
  </div>
</div>
</asp:Content>
