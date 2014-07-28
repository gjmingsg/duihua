<%@ Page Title="" Language="C#" MasterPageFile="~/Layout/AdminDefault.Master" AutoEventWireup="true"  EnableEventValidation="false"
 CodeBehind="JoinClassList.aspx.cs" Inherits="Duihua.EducationWeb.Modules.Class.JoinClassList" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    
 <link href="../../Styles/bootstrap-datetimepicker.min.css" rel="stylesheet" type="text/css" />
 <style type="text/css">
      .btn-sm{ margin:10px}
 </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<div class="panel panel-success">

    <div class="panel-heading">
        <h3 class="panel-title">查询需要加入班级的学生</h3>
        <br />

        <div class="form-group">
            <label class="col-md-2 col-xs-2 control-label">注册时间：</label>
            <div class="col-md-3  col-xs-3">
                <div class="input-group date form_date" data-date="" data-date-format="yyyy-mm-dd" data-link-field="hdStartTime" data-link-format="yyyy-mm-dd">
                     <asp:TextBox ID="tbStartTime" ClientIDMode="Static" runat="server" CssClass="form-control"   size="16" ></asp:TextBox>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
		            <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
            </div>
    
            <label class="col-md-2 col-xs-2 control-label">学生名称：</label>
            <div class="col-md-3  col-xs-3">
                 <asp:TextBox ID="tbStudentName" ClientIDMode="Static" runat="server" CssClass="form-control" size="16" ></asp:TextBox>   
            </div>
            <div class="col-sm-2 col-xs-2">
                <asp:Button runat="server" ID="btnSearch" ClientIDMode="Static" Text="过滤" onclick="btnSearch_Click" CssClass="btn btn-default"/>
            </div>
 
            <asp:HiddenField ID="hdStartTime"  ClientIDMode="Static" runat="server" />
   
         </div>
        
        <br />
    </div>
    
    <div class="panel-body">
        <div class="col-sm-5 col-xs-5 form-group">
    
            <label  for="lbLeft">待选择的学生</label>
             <asp:ListBox ID="lbLeft" ClientIDMode="Static" runat="server"   DataSourceID="SqlDataSource1" Rows="15" CssClass="form-control" DataTextField="StudentName" DataValueField="UserId"></asp:ListBox>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server"   ConnectionString="<%$ ConnectionStrings:DuihuaDB %>"  SelectCommand="
             SELECT s.UserId,s.StudentName
          FROM Student s WHERE s.UserId NOT IN(SELECT jc.UserId FROM JoinClass jc)
      AND s.StudentName LIKE '%'+@StudentName+'%'
      AND (@StartTime is null or s.CreateDate >= @StartTime)
      ORDER BY s.CreateDate DESC">
            <SelectParameters>
                <asp:ControlParameter  ConvertEmptyStringToNull="false" ControlID="tbStudentName" Name="StudentName"/>
                <asp:ControlParameter  ConvertEmptyStringToNull="false" ControlID="hdStartTime" Name="StartTime"/>
            </SelectParameters>
            </asp:SqlDataSource>
        </div>
        <div  class="col-sm-2 col-xs-2">
        <div class="form-group text-center" style=" margin-top:30px">
         <button type="button" id="rightAll" class="btn btn-success  btn-sm">
            <span class="glyphicon glyphicon-fast-forward">全部选则</span>
        </button>
        <button type="button" id="right" class="btn btn-success  btn-sm">
          <span class="glyphicon glyphicon-forward"></span>选&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;择
        </button>
        <button type="button" id="left" class="btn btn-success  btn-sm">
          <span class="glyphicon glyphicon-backward"></span>退&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;选
        </button>
        <button type="button"  id="leftAll" class="btn btn-success  btn-sm">
          <span class="glyphicon glyphicon-fast-backward"></span>退选全部
        </button>
        </div>
        </div>
        <div class="col-sm-5 col-xs-5 form-group">
        <label  for="lbRight">已选择的学生</label>
            <asp:ListBox ID="lbRight" ClientIDMode="Static" runat="server"   DataSourceID="SqlDataSource2"  Rows="15" CssClass="form-control" DataTextField="StudentName" DataValueField="UserId"></asp:ListBox>
          <asp:SqlDataSource ID="SqlDataSource2" runat="server"   ConnectionString="<%$ ConnectionStrings:DuihuaDB %>"  SelectCommand="
          SELECT jc.UserId,s.StudentName FROM JoinClass jc
        INNER JOIN Student s ON s.UserId = jc.UserId WHERE jc.ClassID=@ClassID">
          <SelectParameters>
          <asp:QueryStringParameter QueryStringField="ClassID" Name="ClassID" />
          </SelectParameters>
          </asp:SqlDataSource>
        </div>
        <asp:HiddenField ID="hhSelected" ClientIDMode="Static" runat="server" />
    </div>
  
    <div class="panel-footer">
      <div class="form-group  col-xs-offset-10  col-sm-offset-10  col-sm-2  col-xs-2">
         <asp:Button ID="btnSave" runat="server" Text="保存" OnClientClick="return resethf()"  OnClick="btnSave_Click" CssClass="btn btn-primary"/>
         <asp:Button ID="btnBack" runat="server" Text="返回"  OnClick="btnBackList_Click" CssClass="btn btn-default"/>
      </div>
       <br />
       <br />
    </div>
</div>

<asp:SqlDataSource ID="SqlDataSource3" runat="server"   ConnectionString="<%$ ConnectionStrings:DuihuaDB %>"
     InsertCommand="INSERT INTO JoinClass
                        (
	                        UserId,
	                        ClassID
                        )
                        VALUES
                        (
	                        @UserId,
	                        @ClassID
                        )"
     DeleteCommand="DELETE FROM JoinClass WHERE ClassID=@ClassID">
        <DeleteParameters>
            <asp:QueryStringParameter QueryStringField="ClassID" Name="ClassID" />
        </DeleteParameters>
        <InsertParameters>
             <asp:QueryStringParameter QueryStringField="ClassID" Name="ClassID" />
             <asp:Parameter Name="UserId" />
        </InsertParameters>
    </asp:SqlDataSource>

<script src="../../Scripts/bootstrap-datetimepicker.min.js" type="text/javascript"></script>
<script src="../../Scripts/bootstrap-datetimepicker.zh-CN.js" type="text/javascript"></script>
<script type="text/javascript">

    $('.form_date').datetimepicker({
        language: 'zh-CN',
        weekStart: 1,
        todayBtn: 1,
        autoclose: 1,
        todayHighlight: 1,
        startView: 2,
        minView: 2,
        forceParse: 0
    });
    function resethf() {

        var hf = document.getElementById('<% =hhSelected.ClientID %>');
        hf.value = "";
        $('select[id="lbRight"] option').each(function (index, dom) {
            hf.value += $(dom).val() + ";";
        });
        return true;
    }

    $(document).ready(function () {
        $('select[id="lbLeft"]').dblclick(function () {
            $('select[id="lbLeft"] option:selected').appendTo("#lbRight");
            //resethf();
        });
        $('select[id="lbRight"]').dblclick(function () {
            $('select[id="lbRight"] option:selected').appendTo("#lbLeft");
            //resethf();
        });

        $('#left').click(function () {
            $('select[id="lbRight"] option:selected').appendTo("#lbLeft");
            //resethf();
        });
        $('#right').click(function () {
            $('select[id="lbLeft"] option:selected').appendTo("#lbRight");
           // resethf();
        });
        $('#leftAll').click(function () {
            $('select[id="lbRight"] option').appendTo("#lbLeft");
           // resethf();
        });
        $('#rightAll').click(function () {
            $('select[id="lbLeft"] option').appendTo("#lbRight");
          //  resethf();
        });
    });
</script>
</asp:Content>
