<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Print_ConsumerInvoice.aspx.cs" Inherits="Licensing.Finance.Print_ConsumerInvoice" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    
</head>
<body style="background:transparent !important;max-width:480px !important">
    <form id="form1" runat="server">
    <style>
    .gridmain1
{
    margin-left:auto;
    margin-right:auto;
    margin-top:5px;
     text-align:center;
      box-shadow: 0 0 15px 1px rgba(0, 0, 0, 0.4);
      
}
.gridmain1 td:first-child,th:first-child
{
    border-left:1px solid #000;
}
.gridmain1 td,th
{
    border-right:1px solid #000;
    border-bottom:1px solid #000;
}

.gridmain1 td 
{
    padding-left:5px;
    padding-right:5px;
    padding-top:5px;
    padding-bottom:5px;
}
.gridmain1 th 
{
    padding-left:5px;
    
    padding-top:7px;
    padding-bottom:7px;
}
.gridmain1 tbody tr:nth-child(odd)
{
    background-color:White;
     font-family:Calibri;
    font-size:10pt;
    
}
.gridmain1 tbody tr:nth-child(even)
{
  background: #e4f5fc;
     font-family:Calibri;
    font-size:10pt;
     text-align:center;
    
}
.gridmain td
{
    text-align:center;
    
}
.grdheadbg td,th
{
    padding-top:3px !important;
padding-bottom:3px !important;
cursor:pointer;
}
.grdheadbg
{
     background: rgb(63,76,107); /* Old browsers */
/* IE9 SVG, needs conditional override of 'filter' to 'none' */
background: url(data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiA/Pgo8c3ZnIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgd2lkdGg9IjEwMCUiIGhlaWdodD0iMTAwJSIgdmlld0JveD0iMCAwIDEgMSIgcHJlc2VydmVBc3BlY3RSYXRpbz0ibm9uZSI+CiAgPGxpbmVhckdyYWRpZW50IGlkPSJncmFkLXVjZ2ctZ2VuZXJhdGVkIiBncmFkaWVudFVuaXRzPSJ1c2VyU3BhY2VPblVzZSIgeDE9IjAlIiB5MT0iMCUiIHgyPSIwJSIgeTI9IjEwMCUiPgogICAgPHN0b3Agb2Zmc2V0PSIwJSIgc3RvcC1jb2xvcj0iIzNmNGM2YiIgc3RvcC1vcGFjaXR5PSIxIi8+CiAgICA8c3RvcCBvZmZzZXQ9IjEwMCUiIHN0b3AtY29sb3I9IiMzZjRjNmIiIHN0b3Atb3BhY2l0eT0iMSIvPgogIDwvbGluZWFyR3JhZGllbnQ+CiAgPHJlY3QgeD0iMCIgeT0iMCIgd2lkdGg9IjEiIGhlaWdodD0iMSIgZmlsbD0idXJsKCNncmFkLXVjZ2ctZ2VuZXJhdGVkKSIgLz4KPC9zdmc+);
background: -moz-linear-gradient(top,  rgba(63,76,107,1) 0%, rgba(63,76,107,1) 100%); /* FF3.6+ */
background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,rgba(63,76,107,1)), color-stop(100%,rgba(63,76,107,1))); /* Chrome,Safari4+ */
background: -webkit-linear-gradient(top,  rgba(63,76,107,1) 0%,rgba(63,76,107,1) 100%); /* Chrome10+,Safari5.1+ */
background: -o-linear-gradient(top,  rgba(63,76,107,1) 0%,rgba(63,76,107,1) 100%); /* Opera 11.10+ */
background: -ms-linear-gradient(top,  rgba(63,76,107,1) 0%,rgba(63,76,107,1) 100%); /* IE10+ */
background: linear-gradient(to bottom,  rgba(63,76,107,1) 0%,rgba(63,76,107,1) 100%); /* W3C */
filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#3f4c6b', endColorstr='#3f4c6b',GradientType=0 ); /* IE6-8 */
color:White !important;
font-size:11pt;
padding-top:3px !important;
padding-bottom:3px !important;
font-family:Calibri;
text-shadow:1px 1px 1px #000;
}
    </style>
    <div>
    <h2 align="center">Consumer Invoice Receipt</h2>
    <table style="width:470px;margin-left:auto;margin-right:auto;font-family:Calibri;font-size:10pt;font-weight:bold" cellspacing="5" cellpadding="5">
    <tr>
    <td align="right">
    Bill To :
    </td>
    <td align="left" >
    <asp:Label ID="lblbillto" runat="server" ></asp:Label>
    </td>
    <td align="right">
    Invoice Number : 
    </td>
    <td align="left">
    <asp:Label ID="lblinvno" runat="server"></asp:Label>
    </td>
    <td align="right">
    License No# : 
    </td>
    <td align="left">
    <asp:Label ID="lbllicno" runat="server"></asp:Label>
    </td>

    </tr>
    <tr>
    <td align="right" valign="top">Address : </td>
    <td colspan="5" align="left">
    <asp:Label ID="lbladdr" runat="server"></asp:Label>
    </td>
    </tr>
    </table>
    <center>
    <asp:GridView ID="grd" Width="450px" runat="server" CssClass="gridmain1" AutoGenerateColumns="true">
    <HeaderStyle CssClass="grdheadbg" />
    </asp:GridView>
</center>
    </div>
    </form>
</body>
</html>
