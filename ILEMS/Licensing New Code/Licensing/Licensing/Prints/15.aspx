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
	&nbsp;</p>
<p>
	<%= Getval("Name") %></p>
<p>
	<%= Getval("Address1") %></p>
<p>
	<%= Getval("Address2") %></p>
<p>
	<%= Getval("City") %>,<%= Getval("County") %>,<%= Getval("State") %>,<%= Getval("Zip") %></p>
<p align="center">
	&nbsp;</p>
<p>
	&nbsp;</p>
<p>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
<p>
	&nbsp;</p>
<p>
	Since your online renewal application was completed after the <%= Getval("RenewalDate") %>&nbsp;deadline, you owe additional late fees. The license or permit will be mailed to you after your fees are paid. See reference to the Board rule below.</p>
<p>
	&nbsp;</p>
<p>
	Please mail a check for <strong><u>$100.00</u></strong> to the address above attached to this letter.</p>
<p>
	&nbsp;</p>
<p style="margin-left:1.0in;">
	<strong>680-X-2-.40 </strong><strong>NON-DISCIPLINARY PENALTY FOR LATE RENEWAL OF LICENSE, PERMIT, REGISTRATION, CERTIFICATION, OR ANY SIMILAR DOCUMENT ISSUED.</strong></p>
<p style="margin-left:1.0in;">
	(1)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; In the event an application for renewal of any type of license, permit, registration, certification or any other similar document issued and required by the Alabama Pharmacy Practice Act, the Alabama Uniform Controlled Substances Act or any applicable Rule and the appropriate renewal fee is not received in the Board&rsquo;s office by December 31 of the applicable year, but is received in the Board&rsquo;s office no later than January 31 of the following year, a non-disciplinary administrative penalty of fifty percent (50%) of the prevailing renewal fee must be paid by January 31 of the following year in order to renew. This penalty shall be in addition to the prevailing renewal fee.</p>
<p style="margin-left:1.0in;">
	(2)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;</p>
<p style="margin-left:1.0in;">
	(3)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; This Rule is adopted pursuant to the Board&rsquo;s authority set forth in <u>Code of Alabama</u> (1975), &sect; 34-23-33(b) and is in lieu of formal disciplinary proceedings.</p>
<p>
	&nbsp;</p>
<p>
	If you have any questions, please let us know.</p>
<p>
	&nbsp;</p>
<p>
	Sincerely,</p>
<p>
	<img height="34" src="file:///C:/Users/cbtpr1/AppData/Local/Temp/msohtmlclip1/01/clip_image002.jpg" width="162" /></p>
<p>
	&nbsp;</p>
<p>
	Executive Secretary</p>
</div></body></html>