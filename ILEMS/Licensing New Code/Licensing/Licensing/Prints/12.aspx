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
	&nbsp;</p>
<p align="center">
	<%= Getval("CurrentDate") %></p>
<p>
	&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<strong>From the Desk of:</strong></p>
<p>
	<strong>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;</strong><strong>Rhonda Coker</strong><strong>&nbsp;&nbsp;</strong><strong>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Licensing Manager-Technicians &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</strong></p>
<p>
	&nbsp;</p>
<p>
	<strong>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; </strong></p>
<p>
	<strong>&nbsp;&nbsp;</strong><%= Getval("Name") %></p>
<p>
	<%= Getval("Address1") %></p>
<p>
	<%= Getval("Address2") %></p>
<p>
	<%= Getval("City") %>,<%= Getval("County") %>,<%= Getval("State") %>,<%= Getval("Zip") %></p>
<p>
	<%= Getval("Lic_no") %></p>
<p>
	&nbsp;</p>
<p>
	<strong>In order to complete the renewal process we need the following items:</strong></p>
<p>
	&nbsp;</p>
<ul>
	<li>
		<strong>You were previously registered as a pharmacy technician.&nbsp; Please fill out the enclosed application, have notarized and return with requested items.&nbsp; </strong></li>
</ul>
<p>
	&nbsp;</p>
<ul>
	<li>
		<strong>Employment Statement &ndash; <em>We need a notarized statement from you and your supervising pharmacist as to whether or not you have been performing technician duties since your license expired.&nbsp; Please be specific about the date that you last worked and explain your current duties in the spaces provided.&nbsp; If you have not worked as a technician during this time, please write a statement to that effect and a supervising pharmacist&rsquo;s signature will not be necessary.&nbsp; STATEMENT ENCLOSED</em></strong></li>
</ul>
<p>
	&nbsp;</p>
<p>
	&middot;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <strong>If you do not maintain your license you are required to pay back fees and penalties to get your license up to date.&nbsp; </strong></p>
<p>
	&nbsp;</p>
<p style="margin-left:36.0pt;">
	<em>&ldquo;(10) All pharmacy technicians shall register with the Alabama State Board of Pharmacy. This</em></p>
<p style="margin-left:36.0pt;">
	<em>registration shall expire on December 31 of odd numbered years. Effective January 1, 2006, the initial</em></p>
<p style="margin-left:36.0pt;">
	<em>registration fee and renewal fee shall be sixty dollar ($60). All pharmacy technicians shall pay the renewal fee</em></p>
<p style="margin-left:36.0pt;">
	<em>biennially with this fee being due on October 31 and delinquent after December 31 of odd numbered years. All</em></p>
<p style="margin-left:36.0pt;">
	<em>pharmacy technician registrations shall expire on December 31 biennially in odd-numbered years. The</em></p>
<p style="margin-left:36.0pt;">
	<em>payment of the renewal fee shall entitle the registrant to renewal of their registration at the discretion of the</em></p>
<p style="margin-left:36.0pt;">
	<em>Board. If any pharmacy technician shall fail to pay a renewal fee on or before December 31 of any year, such</em></p>
<p style="margin-left:36.0pt;">
	<em>registration shall become null and void, and the holder of such registration may be reinstated as a pharmacy</em></p>
<p style="margin-left:36.0pt;">
	<em>technician <strong><u>only upon payment of a penalty of Ten Dollars ($10.00) for each lapsed year and all lapsed fees for</u></strong></em></p>
<p style="margin-left:36.0pt;">
	<strong><em><u>each lapsed year</u></em></strong><em>, provided the lapsed time of registration shall not exceed five (5) years, in which case</em></p>
<p>
	<em>reinstatement may be had only upon satisfactory examination by the Board.&rdquo;</em></p>
<p>
	<strong>Amount due is $310 (2008-9-$80; 2010-11-$80; 2012-13-$80; 2014-15-$70)</strong></p>
<ul>
	<li>
		&middot;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <strong>You need to set up a CPE monitor number.&nbsp; Instructions are enclosed.</strong></li>
	<li>
		&middot;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <strong>You will need to show proof of 2 live and 4 non-live hours of continuing education.</strong></li>
	<li>
		<strong>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; We are not allowed to hold money in our office so I am returning your fee.&nbsp; Please resend with requested items.&nbsp;</strong></li>
</ul>
<p>
	<strong>Thank you.&nbsp; Please return this letter with your reply.</strong></p>
</div></body></html>