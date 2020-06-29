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
  
  @page Section1 {size:8.5in 11.0in; margin:0.75in 1in 0.5in 1in;} div.Section1 {page:Section1;} Table { font-family:Arial; font-size:11pt; } --> </style> </head> <body lang=EN-US> <div class=Section1> <p>
	&nbsp;</p>
<p>
	&nbsp;</p>
<p align="center">
	<%= Getval("CurrentDate") %></p>
<p align="center">
	&nbsp;</p>
<p align="center">
	<strong>INTERNSHIP HOURS TRANSFERRED TO TENNESSEE</strong></p>
<p align="center">
	&nbsp;</p>
<h1>
	Student&rsquo;s Name- <%= Getval("Name") %></h1>
<p>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <strong>Intern Number-&nbsp;</strong><%= Getval("LicNumber") %></p>
<p>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong>Alabama License #&nbsp;</strong><%= Getval("LicNumber") %></p>
<p>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
<p>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;</p>
<p>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
<p>
	<strong>CURRICULUM HOURS</strong></p>
<p>
	&nbsp;</p>
<p>
	<%= Getval("Curriculamhours") %><strong>&nbsp;hours</strong></p>
<p>
	&nbsp;</p>
<p>
	<strong>NON-CURRICULUM HOURS</strong></p>
<p>
	&nbsp;</p>
<p>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
<p>
	<strong>TRADITIONAL HOURS</strong></p>
<p>
	(After the 2<sup>rd</sup> professional year)</p>
<p>
	&nbsp;</p>
<p>
	<strong>9/9/13 thru 10/7/13 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;</strong><%= Getval("Hours1") %></p>
<p>
	<strong>3/17/14 thru 4/14/14 &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;</strong><%= Getval("Hours1") %></p>
<p>
	&nbsp;</p>
<p>
	<strong>Total number of hour&rsquo;s credit&nbsp;</strong><%= Getval("Totalhours") %></p>
<p>
	&nbsp;</p>
<p>
	<strong><img height="99" src="file:///C:/Users/cbtpr1/AppData/Local/Temp/msohtmlclip1/01/clip_image002.png" width="336" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; BOARD SEAL</strong></p>
<p>
	&nbsp;&nbsp;&nbsp;&nbsp; Executive Secretary</p>
</div></body></html>