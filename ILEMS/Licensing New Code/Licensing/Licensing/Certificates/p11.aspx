﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="p1.aspx.cs" Inherits="Licensing.Certificates.p1" %>

<!DOCTYPE html>

<HTML>
<HEAD>
<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META http-equiv="X-UA-Compatible" content="IE=8">
<TITLE></TITLE>
<STYLE type="text/css">
body {margin-top: 0px;margin-left: 0px;width: 100%;font-family:Arial}

#page_1 {position:relative; overflow: hidden;margin: 0px 0px 0px 0px;padding: 0px;border: none;width: 100%;height: 816px;}

#page_1 #dimg1 {position:absolute;top:0px;left:0px;z-index:-1;width:100%;height:816px;}
#page_1 #dimg1 #img1 {width:100%;height:816px;}

 
  




</STYLE>
</HEAD>

<BODY style="margin:0px">
 <asp:DataList ID="dtlst" runat="server" Width="100%" class="grd">
    <ItemTemplate>

     
 <div style="font-weight:normal;text-align:center;display:block;width:1090px">
  <span style="font-size:20pt;font-weight:bold">
<br /><br /><br /><br />
 Alabama State Board Of Pharmacy</span><br />
 <img src="plogo2.png" /><br /><br />
 <span>
 This is to certify that<br /> 
 <span style="font-size:20pt;font-weight:bold;margin-top:10px;margin-bottom:10px;line-height:2;">
 <%# Eval("oname") %></span><br /> 
 <b>Extern/Intern # <%# Eval("Lic_no") %></b><br /><br />
 </span>
 <p style="margin-left:20px;margin-right:20px;line-height:2">
 is duly registered as an extern/intern and is authorized to practice pharmacy under the immediate and<br />
 direct surpervision of a preceptor in accordance with Act #205, General Acts of Alabama, 1966 special<br />
 Session, and Rule and Regulations of the Board.
 </p>
 <br />
 <br />
 <br /> 
 <div style="line-height:2">
 <div style="float:left;margin-left:200px;padding-top:10px;">
 
 
Issued <%# Eval("issudt") %>      <br />
Expires <%# Eval("expdt") %> 
</div>
<div style="float:right;margin-right:200px;font-weight:bold;width:300px;text-align:center;margin-top:-50px">
<img src="Susan.png" style="width:300px;border-bottom:1px solid #000;padding-bottom:10px" />
<div style="margin-top:-10px">
  Donna Yeatman<br />
     Secretary</div>
  </div>
</div>
   </DIV>
  
    </ItemTemplate>
    </asp:DataList>
</BODY>
</HTML>

