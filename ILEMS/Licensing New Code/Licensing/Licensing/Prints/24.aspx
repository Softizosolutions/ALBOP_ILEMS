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
<p>
	&nbsp;</p>
<p>
	&nbsp;</p>
<p>
	&nbsp;</p>
<p>
	<%= Getval("ComplainantName") %></p>
<p>
	<%= Getval("ComplainantAddress1") %></p>
<p>
	<%= Getval("ComplainantAddress2") %></p>
<p>
	<%= Getval("ComplainantCity") %>,&nbsp;<%= Getval("ComplainantCounty") %>,<%= Getval("ComplainantState") %>,<%= Getval("ComplainantZip") %></p>
<p>
	&nbsp;</p>
<p>
	Dear <%= Getval("Dear") %>&nbsp;<%= Getval("ComplainantName") %></p>
<p>
	As the Director of Compliance for the Alabama State Board of Pharmacy, I am responding to the complaint that was filed concerning <%= Getval("RespondentName") %>. The complaint was investigated and sent to the Case Review Committee before being presented to the Board of Pharmacy.&nbsp;</p>
<p>
	&nbsp;</p>
<p>
	After a review of the investigative findings with the Board of Pharmacy, this Warning Letter &nbsp;is being sent.DESCRIPTION OF WARNING-MANUALLY ENTER.&nbsp; While this letter does not rise to the level of formal disciplinary action by the Board, it may be considered in any disciplinary matter that may arise in the future.</p>
<p>
	&nbsp;</p>
<p>
	SUMMARY OF OFFENSE PARAGRAPH. ANY LAW REFERENCES, ETC.&mdash;ENTERED MANUALLY</p>
<p>
	&nbsp;</p>
<p>
	Issuance of this letter is intended to bring the above incident and responsibilities to your attention and to encourage you to review, weigh, consider, and fulfill your professional duties and obligations as a pharmacist.<strong>(THIS FINAL PARAGRAPH SHOULD PREPOPULATE WITH THE ABILITY TO ADJUST THE LANGUAGE IF NEEDED)</strong></p>
<p>
	&nbsp;</p>
<p>
	If you have any questions please do not hesitate to contact me.</p>
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
	cc:<%= Getval("RespondentName") %></p>
</div></body></html>