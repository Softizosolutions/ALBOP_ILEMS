<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="p1.aspx.cs" Inherits="Licensing.Certificates.p1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>


    
    <STYLE type="text/css">


body {margin-top: 0px;margin-left: 0px;font-family:Arial;}

 



</STYLE>
 


</head>
<body style="margin:0px">
    <form id="form1" runat="server">
   

    <asp:DataList ID="dtlst" runat="server" Width="100%" class="grd">
    <ItemTemplate>
   
     <div style="margin-top:20px">
 <div style="font-size:12pt; font-weight:bold;text-align:left;display:block;margin-top:300px;margin-left:100px;height:80px">
  <%# Eval("oname") %>
   <br /><%# Eval("Address1") %><br />
   <%# Eval("City") %>, <%# Eval("state") %> <%# Eval("Zip") %>
    </div>
    <table width="100%" style="margin-top:130px">
    <tr>
    <td align="left">
    <span style="margin-left:100px"><b>CPE # : <%# Eval("CPE") %></b></span>
    </td>
    <td align="right">
    <span style="color:brown;font-size:32pt;font-weight:bolder;margin-right:100px;"><%# Eval("nyear") %></span>
    
    </td>
    </tr>
    </table>
    
     <div style="font-weight:bold;text-align:left;display:block;margin-top:80px;margin-left:350px">
     <span  ><b><%# Eval("Lic_no") %></b> </span>
    <span style=" margin-left:90px;"><%# Eval("expdt") %> </span>
    <span style=" margin-left:60px;">&nbsp;$60.00</span>
     <span style=" margin-left:60px;"><%# renyear() %></span>
   </div>
   <div style="font-weight:bold; display:block;margin-top:80px;margin-left:370px">
      <span style="color:black;font-size:18pt;font-weight:bolder"><%# Eval("oname") %></span>
      </div>
       <div style="font-weight:normal;text-align:left;display:block;margin-top:210px;margin-left:130px">
       
    <b>CPE # : <%# Eval("CPE") %></b>
     <span style="margin-left:180px"> <b><%# Eval("Lic_no") %></b></span>
      
        </div>
       <div style="font-weight:normal;display:block;margin-top:138px;margin-left:100px;width:400px;border:solid 0px;text-align:center">     
    <div style="color:black;font-size:11pt;font-weight:bolder;height:30px"><%# Eval("oname") %></div>
        <div style="font-size:12pt;margin-top:13px;text-align:right;margin-right:80px"><%# Convert.ToDateTime( Eval("expdt")).ToString("MMMMMM dd,yyyy") %></div>
 <div style="text-align:right">
 <img src="Susan.png" width="200px" style="margin-right:10px;margin-top:10px" />
    </div>
    </div>
  
     
    </div>
     <%# islst() %> 
</ItemTemplate>
</asp:DataList>


    </form>
</body>
</html>
