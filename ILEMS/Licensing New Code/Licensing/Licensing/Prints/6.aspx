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
	Re: License Verification &nbsp;&nbsp;</p>
<p>
	<%= Getval("Name") %></p>
<p>
	Intern/Extern Number:&nbsp;<%= Getval("LicNumber") %></p>
<p>
	&nbsp;</p>
<p>
	&nbsp;</p>
<p>
	To Whom It May Concern:</p>
<p>
	&nbsp;</p>
<p>
	This letter is to certify the above named intern/extern is registered with the Alabama State Board of Pharmacy. He was originally licensed on <%= Getval("Issuedate") %> and his license will expire on <%= Getval("ExpireDate") %> . There has been no disciplinary action against this license. He has met his 1500 intern hour requirement.</p>
<p>
	&nbsp;</p>
<p>
	If you have any questions, please feel free to contact me.</p>
<p>
	&nbsp;</p>
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
	Lynn Martin</p>
<p>
	Licensing Manager-Pharmacists</p>
</div></body></html>