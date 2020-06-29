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
	<%= Getval("CurrentDate") %></p>
<p align="center">
	&nbsp;</p>
<p align="center">
	&nbsp;</p>
<p>
	&nbsp;</p>
<p>
	&nbsp;</p>
<p>
	We received your official application for licensure transfer. In order to process this application we will need your proof of citizenship and a copy of your Driver&rsquo;s License. Please email &nbsp;for our records.&nbsp; Your application will be processed once we receive this info.&nbsp; Email address <a href="mailto:LMartin@albop.com">LMartin@albop.com</a> and fax (205) 981-2330.</p>
<p>
	&nbsp;</p>
<h1>
	Thank You</h1>
</div></body></html>