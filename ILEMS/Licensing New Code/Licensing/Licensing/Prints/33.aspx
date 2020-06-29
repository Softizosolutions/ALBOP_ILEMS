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
<p>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
<p>
	&nbsp;</p>
<p>
	<%= Getval("ComplainantName") %></p>
<p>
	<%= Getval("ComplainantAddress1") %></p>
<p>
	<%= Getval("ComplainantAddres2") %></p>
<p>
	&nbsp;<%= Getval("ComplainantCity") %>,<%= Getval("ComplainantCounty") %>,<%= Getval("ComplainantState") %>,<%= Getval("ComplainantZip") %></p>
<p>
	&nbsp;</p>
<p>
	Dear &nbsp;<%= Getval("ComplainantDear") %>&nbsp;<%= Getval("ComplainantName") %> :</p>
<p>
	&nbsp;</p>
<p>
	As the Director of Compliance for the Alabama State Board of Pharmacy, I am responding to the complaint that was filed concerning <%= Getval("RespondentName") %>.&nbsp;&nbsp;</p>
<p>
	&nbsp;</p>
<p>
	The complaint was investigated and during the course of the investigation, <%= Getval("RespondentName") %>&nbsp; signed a permanent voluntary surrender agreement.&nbsp; By signing this agreement, <%= Getval("RespondentName") %>&nbsp;surrendered &nbsp;<%= Getval("RespondentGender") %> &nbsp;pharmacy technician registration, with the understanding that &nbsp;<%= Getval("RespondentDear") %> &nbsp;can never work or receive a registration as a pharmacy technician in the State of Alabama.</p>
<p>
	&nbsp;</p>
<p>
	Because of this surrender, no further action will be taken against &nbsp;<%= Getval("RespondentName") %>.&nbsp;&nbsp; If you have any questions please call.</p>
<p>
	&nbsp;</p>
<p>
	Sincerely,</p>
<p>
	&nbsp;</p>
<p>
	&nbsp;</p>
<p>
	&nbsp;</p>
<p>
	&nbsp;</p>
<p>
	Cristal Anderson</p>
<p>
	Director of Compliance</p>
<p>
	Alabama State Board of Pharmacy</p>
<p>
	&nbsp;</p>
<p>
	cc:&nbsp;<%= Getval("RespondentName") %></p>
</div></body></html>