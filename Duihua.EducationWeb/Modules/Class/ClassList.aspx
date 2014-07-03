<%@ Page Title="" Language="C#" MasterPageFile="~/Layout/AdminDefault.Master" AutoEventWireup="true" CodeBehind="ClassList.aspx.cs" Inherits="Duihua.EducationWeb.Modules.Class.ClassList" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
<script type="text/javascript" src="../../Scripts/bootstrap-datetimepicker.min.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<div>
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
          <tr class="active">
            <td>1</td>
            <td>Column content</td>
            <td>Column content</td>
            <td>Column content</td>
          </tr>
          <tr>
            <td>2</td>
            <td>Column content</td>
            <td>Column content</td>
            <td>Column content</td>
          </tr>
          <tr class="success">
            <td>3</td>
            <td>Column content</td>
            <td>Column content</td>
            <td>Column content</td>
          </tr>
          <tr>
            <td>4</td>
            <td>Column content</td>
            <td>Column content</td>
            <td>Column content</td>
          </tr>
          <tr class="warning">
            <td>5</td>
            <td>Column content</td>
            <td>Column content</td>
            <td>Column content</td>
          </tr>
          <tr>
            <td>6</td>
            <td>Column content</td>
            <td>Column content</td>
            <td>Column content</td>
          </tr>
          <tr class="danger">
            <td>7</td>
            <td>Column content</td>
            <td>Column content</td>
            <td>Column content</td>
          </tr>
        </tbody>
      </table>
</div>

<div class="form-horizontal">
 
    <fieldset>
      <div id="legend" class="">
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
            <input class="input-file" id="fileInput" type="file">
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