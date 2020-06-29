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
	<%= Getval("ComplainantCity") %>,<%= Getval("ComplainantCounty") %>,<%= Getval("ComplainantState") %>,<%= Getval("ComplainantZip") %></p>
<p>
	&nbsp;</p>
<p>
	Dear &nbsp;<%= Getval("ComplainantDear") %> <%= Getval("ComplainantName") %>&nbsp; :</p>
<p>
	As the Director of Compliance for the Alabama State Board of Pharmacy, I am responding to the complaint that was filed concerning filling and reporting the incorrect physician on a controlled substance prescription.The complaint was investigated and sent to the Case Review Committee before being presented to the Board of Pharmacy.&nbsp;</p>
<p>
	&nbsp;</p>
<p>
	After a review of the investigative findings with the Board of Pharmacy, this Warning Letter &nbsp;is being sent.While this letter does not rise to the level of formal disciplinary action by the Board, it may be considered in any disciplinary matter that may arise in the future. You are also required to submit documentation, for Board review, showing that you corrected all physician information with both the PDMP and Insurance. This documentation is expected within 14 days from the date of this letter. Failure to comply with this request will result in the Board taking more formal action.</p>
<p>
	If prescription information is not recorded properly it not only affects the patient, and the physician, but also the integrity of the Prescription Drug Monitoring Program, which maintains a listing of all controlled substances dispensed, physicians prescribing them and pharmacists filling them.</p>
<p>
	Issuance of this letter is intended to bring the above incident and responsibilities to your attention concerning proper recordkeeping, and to encourage you to review, weigh, consider, and fulfill your professional duties and obligations as a pharmacist.</p>
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
	Cristal Anderson</p>
<p>
	Director of Compliance</p>
<p>
	Alabama State Board of Pharmac</p>
<p>
	cc: <%= Getval("ComplainantName") %></p>
</div></body></html>