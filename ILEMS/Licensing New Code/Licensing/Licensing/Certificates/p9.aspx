<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="p1.aspx.cs" Inherits="Licensing.Certificates.p1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>




    <STYLE type="text/css">

body {margin-top: 0px;margin-left: 0px;width: 100%;font-family:Arial}

#page_1 {position:relative; overflow: hidden;margin: 0px 0px 0px 0px;padding: 0px;border: none;width: 100%;height: 1320px;}

#page_1 #dimg1 {position:absolute;top:0px;left:0px;z-index:-1;width:100%;height:1320px;}
#page_1 #dimg1 #img1 {width:100%;height:1320px;}

 




</STYLE>
 


</head>
<body>
    <form id="form1" runat="server">
   <asp:DataList ID="dtlst" runat="server" Width="100%" class="grd">
    <ItemTemplate>
     
          
        <DIV id="page_1" >
<DIV id="dimg1" style="margin-top:20px"  >
  
    <div style="font-weight:bold;text-align:right;display:block;margin-top:150px">
     <span style="color:brown;font-size:32pt;font-weight:bolder;margin-right:220px"><%# Eval("nyear") %></span>
     </div>
    <div style="text-align:right;margin-top:70px">
    <div style="margin-right:250px;text-align:center;width:100px">
     <span style="font-size:16pt;font-weight:bold;"> <%# Eval("Lic_no") %></span>
     </div>
    </div>
    <div style="font-size:12pt;margin-left:130px;margin-top:-20px; font-weight:normal;text-align:left;display:block;width:300px;height:100px;border:solid 0px">
  <div  >
  <b><%# Eval("oname") %></b>
   <br /><%# Eval("Address1") %><br />
   <%# Eval("City") %>, <%# Eval("state") %> <%# Eval("Zip") %>
   </div>
    </div>
    <div style="font-weight:bold;float:right;display:block;margin-right:60px;width:350px;margin-top:-30px;border:solid 0px;height:100px">
    <div style="text-align:center">
    <%# Eval("sup") %>
    <br /><%# Eval("suplic") %>
    </div>
    </div>
    
  <div style="font-size:16pt; font-weight:normal;text-align:left;display:block;text-align:left;margin-left:120px;margin-top:50px">
  <b>Retail Medical Oxygen Supplier</b>
  
  </div>  
     <div style="margin-top:47px;float:right;margin-right:240px">
      <span style="font-size:12pt;"><%# Convert.ToDateTime(Eval("expdt")).ToString("MMMMMMM yyyy")%></span>
 
     </div>
     <div style="text-align:right;margin-right:120px;display:block;margin-top:130px">
     <img src="Susan.png" width="250px" />
     </div>
  
    <div id="ncs">
      <div style="font-size:52pt;color:brown;font-weight:bold;text-align:left;display:block;margin-top:480px">
    <table width="85%" align="center">
    <tr>
    <td align="left">
    VOID
    </td>
    <td align="center">
    VOID
    </td>
    <td align="right">
    VOID
    </td>
    </tr>
    </table>
   
    </div>
    </div>
</DIV>
</DIV>
 <%# islst() %> 
</ItemTemplate>
</asp:DataList>

    </form>
</body>
</html>
