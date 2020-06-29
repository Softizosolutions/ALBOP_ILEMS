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
	<%= Getval("CurrentDate") %></h1>
<h2>
	&nbsp;</h2>
<h2>
	&nbsp;</h2>
<p>
	&nbsp;</p>
<p>
	<%= Getval("RespondentName") %></p>
<p>
	<%= Getval("RespondentAddress1") %></p>
<p>
	<%= Getval("RespondentAddress2") %></p>
<p>
	<%= Getval("RespondentCity") %> ,&nbsp;<%= Getval("RespondentCounty") %>,<%= Getval("RespondentState") %> &nbsp;, <%= Getval("RespondentZip") %></p>
<p>
	&nbsp;</p>
<p>
	Dear &nbsp;<%= Getval("RespondentDear") %>&nbsp; <%= Getval("RespondentName") %> :</p>
<p>
	&nbsp;</p>
<p>
	As the Director of Compliance for the Alabama State Board of Pharmacy, I have been directed to contact you in connection with a complaint the Board received concerning a medication error.&nbsp; DESCRIPTION OF COMPLAINT.</p>
<p>
	&nbsp;</p>
<p>
	This complaint was investigated and presented to the Board for review.&nbsp; While the investigation concluded there were no violations, the Board is concerned about this type of error.&nbsp; Therefore, you are requested to submit a corrective action plan for the Board&rsquo;s review within 14 days from the date of this letter. This corrective action plan shall include CASE SPECIFIC PLAN OF ACTION. Failure to comply with this request will result in the Board taking more formal action.</p>
<p>
	&nbsp;</p>
<p>
	If you have any questions, feel free to call.</p>
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
	Cristal Anderson</p>
<p>
	Director of Compliance&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
<h2>
	Alabama State Board of Pharmacy</h2>
<p>
	&nbsp;</p>
<p>
	cc: <%= Getval("ComplainantName") %></p>
</div></body></html>