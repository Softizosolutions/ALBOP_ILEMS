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
  
  @page Section1 {size:8.5in 11.0in; margin:0.75in 0.75in 0.75in 0.75in;} div.Section1 {page:Section1;} Table { font-family:Arial; font-size:11pt; }  </style> 
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">

</head> 
    <body lang=EN-US> 
        <div class=Section1> 
            
                
            <table width="98%">
                 <tr>
                    <td colspan="3" style="text-align:center;font-size:18pt; font:Arial";>
              <b>  ALABAMA <br />
                BOARD OF PHARMACY </b>
                        </td>
                    </tr>
                <tr>
                   <td style="text-align:center; font-size:10pt; font:Arial";>
                <b>    Donna Yeatman, R.Ph.   <br />
                    Executive Secretary <br /> <br />
                    <u> Location: </u> <br />
                    111 Village Street <br />
                  Birmingham, AL 35242 <br /> <br />
                    (205) 981-2280 <br />
                  (205) 981-2330 Fax <br /> 
                    WWW.albop.com </b>
                        </td>
                   
               <td align="center">
                   <img src="https://igovsolution.net/albop/images/Albop_logo.png" style="width:150px; height:150px;" />

               </td> 
                    <td style="text-align:center;  font-size:11pt; font:Arial";>
         <b>     <u>     MEMBERS 2018  </u> <br /> <br />
                    David Darby, R.Ph. <br />
                    President <br /> <br />
                    Ralph Sorrell, R.Ph. <br />
                    Treasurer <br /> <br />
                    Brenda Denson, PharmD <br /> <br />
                    Chris Phung, R.Ph. </b>
                        </td>
                </tr>
            
                </table>
                    <br />
            <div style="text-align: justify;">
Dear&nbsp;&nbsp;<%= Getval("Respondent") %>:</div>
            <br />
<div style="text-align: justify;">
	<p>
		The Alabama State Board of Pharmacy has received a complaint alleging your violation of the Alabama Pharmacy Practice Act. The investigation reveals sufficient evidence to initiate disciplinary proceedings. The purpose of this letter is to fully explain your options.</p>
	<p>
		Please understand you have certain rights in connection with any disciplinary proceeding involving your registration. Those include a right to receive a Statement of Charges and Notice of Hearing; the right to a hearing before the Board, the right to counsel, the right to cross examine the Board&rsquo;s witnesses and the right to present evidence on your behalf. Please also understand the burden is upon the Board to meet its required burden of proof concerning any charges.</p>
	<p>
		If you are found guilty of any violations of the Alabama Pharmacy Practice Act, the Board, in its discretion, can revoke, suspend or place your registration on probation and/or impose administrative disciplinary fines up to $1,000.00 per violation.</p>
	
	<p>
		If there is a hearing and the decision is adverse to you, you also have the right to judicial review.</p>
	<p>
		You certainly have the option of the rights explained above and there will not be any adverse inference whatsoever if you decide to contest any future charges and exercise all the rights to which you are entitled.</p>
	<p>
		On the other hand, you have the option of waiving, i.e. giving up, all those rights and resolving any possible charges against you. You can exercise this option by signing the enclosed Agreement. As you will see, the Agreement provides that your registration shall be permanently surrendered. You will see and please carefully read the paragraphs of the Agreement which explain your rights and you&rsquo;re waiving of those rights.</p>
	<p>
		If you choose to sign the Agreement, you are advised that the Board is required by Federal Law to report the Permanent Surrender to the National Practitioner
	
		Databank. Such reporting may result in you being placed on a list maintained by the Office of Inspector General of the Health and Human Services Department and could also impact future employment, to include in any healthcare field.</p>
	<p>
		You are encouraged, if you so desire, to consult with a lawyer before deciding how to proceed. If the Board does not receive in its office within fourteen (14) days from the date you receive this letter, the offer to sign the Agreement will be withdrawn and disciplinary proceedings will be initiated.</p>
</div>
 
<div>
	<p>
		Sincerely,</p>
	<p>
		FOR THE ALABAMA STATE BOARD OF PHARMACY</p>
	<img height="60" src="https://igovsolution.net/albop/images/sig.png" width="180" />
	<p>
		Donna yeatman, R.Ph.<br />
		Executive Secretary</p>
</div>
<p style="page-break-before:always">
	&nbsp;</p>
<div>
	<table>
		<tbody>
			<tr>
				<td>
					IN THE MATTER OF:</td>
				<td style="padding-left: 100px"> )</td>
				<td>
					&nbsp;</td>
			</tr>
			<tr>
				<td>
					&nbsp;</td>
				<td style="padding-left: 100px">
					)</td>
				<td>
					BEFORE THE ALABAMA STATE</td>
			</tr>
			<tr>
				<td>
					<%= Getval("Respondent") %></td>
				<td style="padding-left: 100px">
					)</td>
				<td>
					&nbsp;</td>
			</tr>
			<tr>
				<td>
					&nbsp;</td>
				<td style="padding-left: 100px">
					)</td>
				<td>
					BOARD OF PHARMACY</td>
			</tr>
			<tr>
				<td>
					Pharmacy Technician</td>
				<td style="padding-left: 100px">
					)</td>
				<td>
					&nbsp;</td>
			</tr>
			<tr>
				<td>
					Registration No.:&nbsp;<%= Getval("techno") %></td>
				<td style="padding-left: 100px">
					)</td>
				<td>
					&nbsp;</td>
			</tr>
			<tr>
				<td>
					Case No.:<%= Getval("Complaint_Number") %></td>
				<td style="padding-left: 100px">
					)</td>
				<td>
					&nbsp;</td>
			</tr>
		</tbody>
	</table>
</div>
 
<div>
	<div style="text-align:center"><br /> <u><b>AGREEMENT</b></u><br /></div>
	<p>
	        This Agreement is entered on this ____ day of _____________, ____ between the Alabama State Board of Pharmacy (hereafter referred to as Board) and&nbsp;<%= Getval("Respondent") %> (hereinafter referred to as respondent).</p>
	<p>
		WHEREAS, the Board has received a complaint alleging that respondent has violated the Alabama Pharmacy Practice Act;</p>
	<p>
		WHEREAS, respondent has represented to the Board Investigator identified below that he/she has no further desire to be registered or work as a pharmacy technician;</p>
	<p>
		WHEREAS, respondent acknowledges receiving the letter attached hereto and acknowledges that he/she has had sufficient time to review the letter and ask any questions;</p>
	<p>
		WHEREAS, respondent desires to surrender his/her registration as a pharmacy technician with the understanding that he/she can never work or receive a registration as a pharmacy technician in the State of Alabama;</p>
	<p>
		WHEREAS, respondent acknowledges the Board is obligated to report any permanent surrender that is executed in lieu of a disciplinary hearing to the National Practitioner Data Bank (NPDB)&rdquo;;</p>
	<p>
		WHEREAS, this Agreement is made and entered pursuant to the provisions of<u> Code of Alabama 1975,</u> &sect; 41-22-12(f)</p><br />
	
    
    <p><b>IT IS THEREFORE UNDERSTOOD AND AGREED BY AND BETWEEN THE PARTIES AS FOLLOWS: </b></p><br />
	<p>
		1. Respondent shall permanently surrender his/her registration as a Pharmacy Technician in the State of Alabama.</p>
	<p>
		2. Respondent agrees never to work again as a Pharmacy Technician in the State of Alabama or attempt to obtain permission, authority or registration to do so.</p>
	<p>
		3. In consideration of respondent&rsquo;s representations in paragraphs (1) and (2) above, the Board shall not initiate or seek any disciplinary sanctions against respondent, if said permanent surrender is approved and accepted by the Board.</p>
	<p>
		4. Respondent  acknowledges that he/she voluntarily waives his/her rights pursuant to the Alabama Pharmacy Practice Act, <u>Code of Alabama</u> 1975 &sect; 34-23-1 et seq., and the Alabama Administrative Procedure Act,<u> Code of Alabama 1975 </u>&sect; 41-22-1 et seq. including, but not limited to, a Statement of Charges and Notice of Hearing, a hearing before the Board, the right to counsel, the right to cross-examine witnesses who may testify against him/her, the right to introduce evidence on his/her own behalf and the right to judicial review.
		<br />Respondent acknowledges, agrees and understands the permanent surrender of the referenced pharmacy technician registration must and shall be reported to the NPDB as such a surrender in lieu of a disciplinary hearing</p>
	<p>
		5. Respondent also waives any objection pursuant to <u>Code of Alabama </u>1975 &sect; 41-22-18 in relation to the Board&rsquo;s attorney preparing or drafting this Agreement.</p>
	<p>
		6. Respondent acknowledges that he/she has read and understands completely the terms of this Agreement, that he/she is executing this Agreement of his/her own free will and without any promise, coercion, or duress. He/she fully understands and appreciates the opportunity to consult with counsel and is voluntarily and freely choosing not to do so.</p>
	<p>
		Dated this the _____ day of __________,_______.</p>
</div>

<div style="padding-right:25px;">
    <div style="text-align:right;" >
        <p>____________________________________________</p>
        <p>TECHNICIAN</p>
        <p>____________________________________________</p>
        <p>INVESTIGATOR</p>

    </div>
	
</div>
<div style="text-align:center">
	ALABAMA STATE BOARD OF PHARMACY</div>
<div>
	<p>
		Date approved and accepted by Alabama State Board of Pharmacy</p>
	<p>
		Dated this the _____ day of ___________,_______.</p>
</div>
<div style="padding-right:25px;">

       <div style="text-align:right;" >
        <p>____________________________________________</p>
        <p>Board President</p>
        

    </div>
	
</div>

</div></body></html>