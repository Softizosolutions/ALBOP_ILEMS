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
  
  @page Section1 {size:8.5in 11.0in; margin:0.75in 1in 0.5in 1in;} div.Section1 {page:Section1;} Table { font-family:Arial; font-size:11pt; } --> </style> </head> <body lang=EN-US> <div class=Section1> <p style="text-align: center;">
	<%= Getval("CurrentDate") %></p>
<p style="text-align: center;">
	&nbsp;</p>
<div>
	<%= Getval("ComplainantName") %></div>
<div>
	<%= Getval("ComplainantAddress1") %></div>
<div>
	<%= Getval("ComplainantAddress2") %></div>
<div>
	<%= Getval("ComplainantCity") %> ,<%= Getval("ComplainantCounty") %>&nbsp;, <%= Getval("ComplainantState") %>&nbsp; <%= Getval("ComplainantZip") %></div>
<div>
	&nbsp;</div>
<div>
	&nbsp;</div>
<div>
	&nbsp;</div>
<div>
	Dear <%= Getval("ComplainantDear") %>&nbsp;&nbsp;<%= Getval("ComplainantName") %> :</div>
<div>
	&nbsp;</div>
<div>
	&nbsp;</div>
<div>
	&nbsp;</div>
<div>
	This letter is to advise you we received your complaint concerning<%= Getval("RespondentName") %>. Your complaint will be investigated and you will be notified as to the results of the investigation.</div>
<div>
	&nbsp;</div>
<div>
	&nbsp;</div>
<div>
	The Board&#39;s inspectors try to address complaints as soon as possible. Please understand that inspectors are assigned complaints other than yours and in addition have other duties such as inspecting all the pharmacies in this state. Not completing the investigation as quickly as all would desire should not suggest your complaint is considered as unimportant.</div>
<div>
	&nbsp;</div>
<div>
	&nbsp;</div>
<div>
	Please feel free to contact me if you have any questions or concerns. If contacting about the status or questions about your complaint please refer to complaint number <%= Getval("Complaint_Number") %>.</div>
<div>
	&nbsp;</div>
<div>
	&nbsp;</div>
<div>
	Sincerely,</div>
<div>
	&nbsp;</div>
<div>
	&nbsp;</div>
<div>
	&nbsp;</div>
<div>
	Edward R. Braden</div>
<div>
	Chief Drug Inspector</div>
<div>
	Alabama State Board of Pharmacy</div>
</div></body></html>