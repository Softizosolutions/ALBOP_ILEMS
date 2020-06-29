<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="p1.aspx.cs" Inherits="Licensing.Certificates.p1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>


    <STYLE type="text/css">

body {margin-top: 0px;margin-left: 0px;font-family:Arial;}

 



</STYLE>


</head>
<body>
 
    <form id="form1" runat="server">
    <asp:DataList ID="dtlst" runat="server" Width="100%"   class="grd">
    <ItemTemplate>

       <div>
    <div style="margin-top:15px;width:100%">
    <table width="100%">
    <tr>
    <td width="55%">
     <div style="text-align:center;margin-left:250px">
     
    CPE Monitor #
    <br /><b><%# Eval("CPE") %></b>
     
    </div>
    
    </td>
    <td  width="45%" valign="bottom">
    <div style="text-align:center;margin-left:15px">
     <span style="color:brown;font-size:32pt;font-weight:bolder"><%# Eval("nyear") %></span>
     <br />
     <span style="font-size:18pt;font-weight:bold;">Pharmacist</span>
     </div> 
    </td>
    </tr>
    </table>

      <table width="100%">
    <tr>
    <td width="50%" valign="bottom"> 
   
    <div style="margin-left:150px;" >
    <br /><br />
      <%# Eval("oname") %>
   <br /><%# Eval("Address1") %><br />
        
   <%# Eval("City") %>, <%# Eval("state") %> <%# Eval("Zip") %>
    </div>
    </td>
    <td  width="40%" align="center" valign="bottom" > 
     
    <p style="text-align:center;margin-top:150px;margin-left:20px">
     <span style="font-size:16pt;font-weight:bold;"><%# Eval("oname") %> </span>
     <br />
     <span style="font-size:16pt;font-weight:bold;"><%# Eval("Lic_no")%></span>
     </p>
   
   </td>
    </tr>
    </table>
      
     <div style="font-weight:normal;margin-right:50px;margin-top:23px;text-align:right">
    <%# Convert.ToDateTime( Eval("expdt")).ToString("MMMMMMM dd, yyyy") %>
    </div>
   <div style="text-align:right">
    <img src="Susan.png" width="200px" style="margin-right:10px;margin-top:8px" />
    
   </div>
    </div>
      <div id="ncs" <%# isnotcs(Eval("CS").ToString()) %>>
     <div  style="font-size:52pt;color:brown;font-weight:bold;text-align:left; margin-top:700px;margin-left:20px">
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
    <div id="cs" <%# iscs(Eval("CS").ToString()) %>>
    <div style="font-weight:normal;text-align:center;margin-top:510px;margin-left:300px">
     <div style="color:brown;font-size:32pt;font-weight:bolder;text-align:right;margin-right:150px"><%# Eval("nyear") %></div>
    
    <div style="font-weight:normal;text-align:left;display:block;margin-top:60px;margin-left:160px">
     <span  ><b><%# Eval("Lic_no") %></b> </span>
    <span style=" margin-left:150px;"><%# Eval("expdt") %> </span>
    <span style=" margin-left:50px;">$100.00</span>
    </div>
    <div style="font-weight:normal;text-align:left;display:block;margin-top:40px;margin-left:140px ">
     <span  >II III IV V </span>
    <span style=" margin-left:170px;">Pharmacist </span>
    <span style=" margin-left:50px;"><%# Eval("issudt") %></span>
    
    
    
    </div>
     <div style="font-size:16pt; font-weight:normal;text-align:left;display:block;margin-top:40px;margin-left:210px ">
  <%# Eval("oname") %>
   <br /><%# Eval("Address1") %><br />
         
   <%# Eval("City") %>, <%# Eval("state") %> <%# Eval("Zip") %>
    </div>
    </div>
    </div>
  
  
      
   
  
 </div>
 <%# islst() %> 
    </ItemTemplate>
    </asp:DataList>
    

    </form>
</body>
</html>
