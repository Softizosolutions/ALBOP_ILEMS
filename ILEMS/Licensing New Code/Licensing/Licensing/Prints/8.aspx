<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Vw_Print.aspx.cs" Inherits="Licensing.Prints.Vw_Print" %>

<html  xmlns:o='urn:schemas-microsoft-com:office:office'  xmlns:w='urn:schemas-microsoft-com:office:word'  xmlns='http://www.w3.org/TR/REC-html40'>
<head>
<!--[if gte mso 9]>
<xml>
  <w:WordDocument> 
    <w:View>Print</w:View>
      <w:Zoom>90</w:Zoom> 
      
         <w:DoNotOptimizeForBrowser/> n  </w:WordDocument>     </xml>  
             <![endif]-->
   
    <title></title>
 
  <style>
  
  @page Section1 {size:8.5in 11.0in; margin:0.75in 1in 0.5in 1in;} div.Section1 {page:Section1;} Table { font-family:Arial; font-size:11pt; } --> </style> </head> <body lang=EN-US> <div class=Section1> <p align="center">
	&nbsp;</p>
<p align="center">
	<strong><%= Getval("curdt") %></strong></p>
<p>
	<strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong></p>
<p style="margin-left:1.0in;">
	<strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong></p>
<p>
	&nbsp;</p>
<p>
	<strong><%= Getval("Name") %></strong></p>
<p>
	<strong><%= Getval("Address1") %></strong></p>
<p>
	<strong><%= Getval("Address2") %></strong></p>
<p>
	<strong><%= Getval("City") %> ,&nbsp;<%= Getval("State") %> &nbsp;<%= Getval("Zip") %>.</strong></p>
<p>
	<strong><%= Getval("licnos") %></strong></p>
<p>
	&nbsp;</p>
<p>
	<strong><u>RE: U. S. Citizenship</u></strong></p>
<p>
	&nbsp;</p>
<p>
	<strong>Dear&nbsp;<%= Getval("dear") %>&nbsp;<%= Getval("Last_Name") %>:</strong></p>
<p>
	&nbsp;</p>
<p>
	According to the records of this office, your U. S. Citizenship expired <a>on</a>________<strong>. </strong>&nbsp;Therefore, we will need documentation of your proof of U. S. Citizenship that has been updated in this office no later <a>than</a>&nbsp;&nbsp;<strong>__________</strong> in order to keep your Alabama Pharmacy Technician registration. <strong>If not received, action will be taken against your license.</strong></p>
<p>
	<strong>You can mail to above address, fax @ 205-981-2330 or email to info@albop.com.</strong></p>
<p>
	&nbsp;</p>
<p>
	&nbsp;</p>
<p>
	<strong>Thank you.</strong></p>
<div>
	&nbsp;</div>
<p>
	&nbsp;</p>
</div></body></html>