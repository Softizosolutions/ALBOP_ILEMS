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
	<%= Getval("Date") %></p>
<p align="center">
	&nbsp;</p>
<p>
	<%= Getval("Name") %></p>
<p>
	<%= Getval("Address") %></p>
<p>
	&nbsp;<%= Getval("City") %>,<%= Getval("County") %>,<%= Getval("State") %>,<%= Getval("Zip") %></p>
<p>
	&nbsp;</p>
<p>
	&nbsp;</p>
<p>
	<strong>Dear &nbsp;</strong><%= Getval("Gender") %>&nbsp;<%= Getval("Last Name") %></p>
<p>
	&nbsp;</p>
<p>
	<strong>This letter is in regards to the NAPLEX Licensure Examination which you took on&nbsp;</strong><%= Getval("NAPLEX Date") %><strong>.</strong></p>
<p>
	&nbsp;</p>
<p>
	<strong>The National Associations of Boards of Pharmacy has advised us that you made&nbsp;</strong><%= Getval("NAPLEX Score") %>&nbsp;<strong>on your exam.&nbsp; In order to pass the exam, you must have at least a 75 average.&nbsp; In Code of Alabama 1975, title 34 Chapter 23, Practice of Pharmacy Act 205, 34-23-51 reads in part,&nbsp; &ldquo;In case of failure of a first examination, the applicant shall have within three years privilege of a second and third examination. In case of failure in the third examination, the applicant shall be eligible for only <u>one</u> additional examination and this only after he/she has satisfactorily completed additional preparation as directed and approved by the Board&rdquo;.&nbsp; We must have documentation of the review course that you took and passed in order for you to be eligible to retake the exam for the final time.</strong></p>
<p>
	&nbsp;</p>
<p>
	<strong>If we may be of further assistance, please feel free to contact this office.</strong></p>
<p>
	&nbsp;</p>
<p>
	<strong>Sincerely,</strong></p>
<p>
	&nbsp;</p>
<p>
	<strong>FOR THE ALABAMA STATE BOARD OF PHARMACY:</strong></p>
<p>
	&nbsp;</p>
<p>
	&nbsp;</p>
<p>
	&nbsp;</p>
<h4>
	<strong>Lynn Martin</strong></h4>
<p>
	<strong>Licensing Manager-Pharmacists</strong></p>
<p>
	&nbsp;</p>
</div></body></html>