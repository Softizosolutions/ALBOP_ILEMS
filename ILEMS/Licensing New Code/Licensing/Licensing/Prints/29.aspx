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
<h1 style="text-align: center;">
	<%= Getval("CurrentDate") %></h1>
<p>
	<%= Getval("RespondentName") %></p>
<p>
	<%= Getval("RespondentAddress1") %></p>
<p>
	&nbsp;<%= Getval("RespondentAddress2") %></p>
<p>
	<%= Getval("RespondentCity") %>,<%= Getval("RespondentState") %> &nbsp;&nbsp;<%= Getval("RespondentZip") %></p>
<p>
	&nbsp;</p>
<p>
	Dear &nbsp;<%= Getval("RespondentDear") %> &nbsp;<%= Getval("RespondentName") %></p>
<p>
	As the Director of Compliance for the Alabama State Board of Pharmacy, I am responding to the complaint that was filed against &nbsp;<%= Getval("RespondentName") %> &nbsp;concerning COMPLAINT-MANUALLY ENTER. The complaint was investigated and presented to the Board for review.&nbsp;</p>
<p>
	&nbsp;</p>
<p>
	After a review of the investigative findings, this Letter of Concern is being sent to you.&nbsp; While this letter does not rise to the level of formal disciplinary action by the Board, it may be considered in any disciplinary matter that may arise in the future.</p>
<p>
	&nbsp;</p>
<p>
	Issuance of this letter is intended to bring the above incidents and responsibilities to the pharmacy&rsquo;s attention and for the pharmacists to review, weigh, consider and fulfillprofessional duties and obligations.</p>
<p>
	&nbsp;</p>
<p>
	If you have any questions please call.</p>
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
	cc: &nbsp;<%= Getval("ComplainantName") %></p>
</div></body></html>