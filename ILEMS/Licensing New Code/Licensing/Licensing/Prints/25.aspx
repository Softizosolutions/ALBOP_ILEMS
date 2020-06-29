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
	&nbsp;</p>
<p>
	Dear &nbsp;<%= Getval("Dear") %>&nbsp;<%= Getval("ComplainantName") %></p>
<p>
	&nbsp;</p>
<p>
	Thank you for your submission to the Alabama Board of Pharmacy and your concern for the professionalism of the pharmacies and pharmacy staff with whom you come in contact.&nbsp; While we appreciate your position, we are limited by the guidelines of Alabama law.&nbsp; The Board of Pharmacy is tasked with enforcing Alabama Code related to pharmacy and protecting the public in all aspects written into that code.&nbsp; The corresponding requirement is that the Board may only involve itself in items outlined in Alabama pharmacy law.&nbsp; Actions such as pricing for a prescription, customer service, personnel management or business policy are not reviewed by the Board of Pharmacy unless they involve a violation of pharmacy law.</p>
<p>
	&nbsp;</p>
<p>
	We suggest you contact the business management, the district or national office, or the Better Business Bureau for help with your complaint.&nbsp; We are sorry that we are not able to assist you, but we will keep your complaint on file should it be useful in another set of circumstances.</p>
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
</div></body></html>