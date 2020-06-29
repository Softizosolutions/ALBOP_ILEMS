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
  
  @page Section1 {size:8.5in 11.0in; margin:0.75in 1in 0.5in 1in;} div.Section1 {page:Section1;} Table { font-family:Arial; font-size:11pt; } --> </style> </head> <body lang=EN-US> <div class=Section1> <h1 style="text-align: center;">
	<span style="font-size:14px;">&nbsp; &nbsp;</span></h1>
<h1 style="text-align: center;">
	<%= Getval("CurrentDate") %></h1>
<h2>
	&nbsp;</h2>
<p>
	&nbsp;</p>
<p>
	<%= Getval("ComplainantName") %></p>
<p>
	<%= Getval("ComplainantAddress1") %></p>
<p>
	<%= Getval("ComplainantAddress2") %></p>
<p>
	&nbsp;<%= Getval("ComplainantCity") %>,<%= Getval("ComplainantCounty") %>,<%= Getval("ComplainantState") %>,<%= Getval("ComplainantZip") %></p>
<p>
	&nbsp;</p>
<p>
	&nbsp;</p>
<p>
	Dear &nbsp;<%= Getval("Dear") %> <%= Getval("ComplainantName") %> :</p>
<p>
	&nbsp;</p>
<p>
	As the Director of Compliance for the Alabama State Board of Pharmacy, I am contacting you in regards to the complaint that you filed with the Alabama State Board of Pharmacy.&nbsp;&nbsp;&nbsp;&nbsp;</p>
<p>
	&nbsp;</p>
<p>
	The complaint was investigated and then prepared for a possible hearing before the Alabama State Board of Pharmacy. &nbsp;There was enough evidence to conduct a hearing to determine if any violations of the Alabama Pharmacy Practice Act had been committed. &nbsp;A final determination was made by the Board of Pharmacy and the results are as follows. INSERT CHARGE &amp; FINE.</p>
<p>
	&nbsp;</p>
<p>
	If you have any questions in regard to the outcome of these proceedings or if I can be of further assistance please do not hesitate to contact me at this office.</p>
<p>
	&nbsp;</p>
<p>
	&nbsp;</p>
<p>
	&nbsp;</p>
<p>
	&nbsp;</p>
<p>
	&nbsp;</p>
<p>
	Cristal Anderson&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
<p>
	Director of Compliance</p>
<p>
	Alabama State Board of Pharmacy&nbsp;</p>
<p>
	&nbsp;</p>
<p>
	&nbsp;</p>
<p>
	&nbsp;</p>
<p>
	&nbsp;</p>
</div></body></html>