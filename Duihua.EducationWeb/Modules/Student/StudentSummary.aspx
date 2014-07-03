<%@ Page Title="" Language="C#" MasterPageFile="~/Layout/AdminDefault.Master" AutoEventWireup="true" CodeBehind="StudentSummary.aspx.cs" Inherits="Duihua.EducationWeb.Modules.Student.StudentSummary" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
<script src="../../Scripts/Chart.min.js" type="text/javascript"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<canvas id="myChart" width="400" height="400"></canvas>

<script>
    var data = {
        labels: ["January", "February", "March", "April", "May", "June", "July"],
        datasets: [
		{
		    fillColor: "rgba(220,220,220,0.5)",
		    strokeColor: "rgba(220,220,220,1)",
		    data: [65, 59, 90, 81, 56, 55, 40]
		},
		{
		    fillColor: "rgba(151,187,205,0.5)",
		    strokeColor: "rgba(151,187,205,1)",
		    data: [28, 48, 40, 19, 96, 27, 100]
		}
	]
    };
var ctx = document.getElementById("myChart").getContext("2d");
var myNewChart = new Chart(ctx).Bar(data);
</script>
</asp:Content>
