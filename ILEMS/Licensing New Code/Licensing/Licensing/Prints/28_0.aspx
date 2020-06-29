<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Vw_Print.aspx.cs" Inherits="Licensing.Prints.Vw_Print" %>

<html>
<head>
 
   
    <title></title>
 
  </head> 
    <body lang=EN-US>
       <div class=Section1 > 
       <table id="tbmain" align="left" border="0" cellpadding="0" cellspacing="0" class="MsoNormalTable" style="width:99.0%;border-collapse:collapse;margin-left:7.1pt;
 margin-right:7.1pt">
	<tbody>
		<tr style="height:.2in">
			<td style="width:135.2pt;border:none;border-bottom:solid #999999 1.0pt;
  padding:0in 5.75pt 0in 5.75pt;height:.2in">
				<p class="Body">
					<img alt="Alabama-state-seal-png" height="93" id="Picture 1" src="../Prints/image001[1].gif" width="94" /></p>
			</td>
			<td align="left" colspan="14" style="width:400.75pt;border:none;border-bottom:
  solid #999999 1.0pt;padding:0in 5.75pt 0in 5.75pt;height:.2in" width="518">
				<h2 align="center">
					ALABAMA STATE BOARD OF PHARMACY</h2>
				<h2 align="center">
					INVESTIGATIVE REPORT</h2>
				<p align="center" class="Body" style="text-align:center">
					<b>&nbsp;</b></p>
			</td>
		</tr>
		<tr style="height:.2in">
			<td  style="width:135.2pt;border:solid #999999 1.0pt;
  border-top:none;padding:0in 5.75pt 0in 5.75pt;height:.2in" width="180">
				<p class="Body">
					<b>Case #:&nbsp;</b><%= Getval("Complaint_Number") %></p>
			</td>
			<td colspan="10" style="width:233.9pt;border-top:none;border-left:
  none;border-bottom:solid #999999 1.0pt;border-right:solid #999999 1.0pt;
  padding:0in 5.75pt 0in 5.75pt;height:.2in" width="312">
				<p class="Body" style="width:146%">
					<b>Agency Name:&nbsp;&nbsp;&nbsp; Alabama State Board of Pharmacy </b></p>
			</td>
			<td colspan="6" style="width:154.85pt;border-top:none;border-left:
  none;border-bottom:solid #999999 1.0pt;border-right:solid #999999 1.0pt;
  padding:0in 5.75pt 0in 5.75pt;height:.2in" width="206">
				<p class="Body">
					<b>Date Received:&nbsp;</b><%= Getval("DateReceived") %></p>
			</td>
		</tr>
		<tr style="height:.2in">
			<td colspan="11" style="width:369.1pt;border:solid #999999 1.0pt;
  border-top:none;padding:0in 5.75pt 0in 5.75pt;height:.2in" width="492">
				<p class="Body">
					<b>Investigation Type:</b></p>
			</td>
			<td colspan="6" style="width:154.85pt;border-top:none;border-left:
  none;border-bottom:solid #999999 1.0pt;border-right:solid #999999 1.0pt;
  padding:0in 5.75pt 0in 5.75pt;height:.2in" width="206">
				<p class="Body">
					<b>Date Turned In:&nbsp;</b><%= Getval("DateInvestigationCompleted") %></p>
			</td>
		</tr>
		<tr style="height:.2in">
			<td colspan="7" style="width:247.95pt;border:solid #999999 1.0pt;
  border-top:none;padding:0in 5.75pt 0in 5.75pt;height:.2in" width="331">
				<p class="Body">
					<b>Violation(s):</b></p>
			</td>
			<td colspan="10" style="width:276.0pt;border-top:none;border-left:
  none;border-bottom:solid #999999 1.0pt;border-right:solid #999999 1.0pt;
  padding:0in 5.75pt 0in 5.75pt;height:.2in" width="368">
				<p class="Body">
					<b>Violations confirmed:&nbsp; Yes/NO</b></p>
			</td>
		</tr>
		<tr style="height:.2in">
			<td colspan="17" style="width:523.95pt;border:solid #999999 1.0pt;
  border-top:none;padding:0in 5.75pt 0in 5.75pt;height:.2in" width="699">
				<p class="Body">
					<b>Place of Occurrence:</b></p>
			</td>
		</tr>
		<tr style="height:.2in">
			<td colspan="17" style="width:523.95pt;border:solid #999999 1.0pt;
  border-top:none;padding:0in 5.75pt 0in 5.75pt;height:.2in" width="699">
				<p class="Body">
					<b>Is There Video/Audio Evidence?</b></p>
			</td>
		</tr>
		<tr style="height:.2in">
			<td colspan="12" style="width:369.55pt;border:solid #999999 1.0pt;
  border-top:none;padding:0in 5.75pt 0in 5.75pt;height:.2in" width="493">
				<p class="Body">
					<b>Has There Been a Referral to the Wellness Program?&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </b></p>
			</td>
			<td colspan="5" style="width:154.4pt;border-top:none;border-left:
  none;border-bottom:solid #999999 1.0pt;border-right:solid #999999 1.0pt;
  padding:0in 5.75pt 0in 5.75pt;height:.2in" width="206">
				<p class="Body">
					<b>Referral Date:</b></p>
			</td>
		</tr>
		<tr style="height:.2in">
			<td colspan="17" style="width:523.95pt;border:solid #999999 1.0pt;
  border-top:none;padding:0in 5.75pt 0in 5.75pt;height:.2in" width="699">
				<p class="Body">
					<b>Investigator:&nbsp;</b><%= Getval("InvestigatorID") %></p>
			</td>
		</tr>
		<tr style="height:27pt">
			<td colspan="17" style="width:523.95pt;border:none;
  border-bottom:solid #999999 1.0pt;padding:0in 5.75pt 0in 5.75pt;height:27pt">
			
				<p align="center" class="Body" style="text-align:center; width: 973px;">
					<b><span style="font-size:17.5pt">Complainant</span></b></p>
				
			</td>
		</tr>
		<tr style="height:.2in">
			<td colspan="8" style="width:308.3pt;border:solid #999999 1.0pt;
  border-top:none;padding:0in 5.75pt 0in 5.75pt;height:.2in" width="411">
				<p class="Body">
					<b>Name:&nbsp;</b><%= Getval("ComplainantName") %></p>
			</td>
			<td colspan="9" style="width:215.65pt;border-top:none;border-left:
  none;border-bottom:solid #999999 1.0pt;border-right:solid #999999 1.0pt;
  padding:0in 5.75pt 0in 5.75pt;height:.2in" width="288">
				<p class="Body">
					<b>Complainant Contacted? </b></p>
			</td>
		</tr>
		<tr style="height:.2in">
			<td colspan="8" style="width:308.3pt;border:solid #999999 1.0pt;
  border-top:none;padding:0in 5.75pt 0in 5.75pt;height:.2in" width="411">
				<p class="Body">
					<b>Address:&nbsp;</b><%= Getval("ComplainantAddress1") %></p>
			</td>
			<td colspan="9" style="width:215.65pt;border-top:none;border-left:
  none;border-bottom:solid #999999 1.0pt;border-right:solid #999999 1.0pt;
  padding:0in 5.75pt 0in 5.75pt;height:.2in" width="288">
				<p class="Body">
					<b>Date of Contact:</b></p>
			</td>
		</tr>
		<tr style="height:.2in">
			<td colspan="4" style="width:200.7pt;border:solid #999999 1.0pt;
  border-top:none;padding:0in 5.75pt 0in 5.75pt;height:.2in" width="268">
				<p class="Body">
					<b>Phone:&nbsp;</b><%= Getval("ComplainantPhone") %></p>
			</td>
			<td colspan="13" style="width:323.25pt;border-top:none;border-left:
  none;border-bottom:solid #999999 1.0pt;border-right:solid #999999 1.0pt;
  padding:0in 5.75pt 0in 5.75pt;height:.2in" width="431">
				<p class="Body">
					<b>Email:</b></p>
			</td>
		</tr>
		<tr style="height:.2in">
			<td colspan="17" style="width:523.95pt;border:solid #999999 1.0pt;
  border-top:none;padding:0in 5.75pt 0in 5.75pt;height:.2in" width="699">
				<p class="Body">
					<b>Any Reported Injury? (Explain)</b></p>
			</td>
		</tr>
		
      <tr style="page-break-before:avoid;">
      <td colspan="18">
        <asp:DataList ID="dtlstresp" runat="server" border="0" cellpadding="0" cellspacing="0" Width="98%" >
        <ItemTemplate>
      
        <tr style="height:27pt">
			<td colspan="17" style="width:523.95pt;border:none;
  border-bottom:solid #999999 1.0pt;padding:0in 5.75pt 0in 5.75pt;height:27pt">
			
				<p align="center" class="Body" style="text-align:center; ">
					<b><span style="font-size:17.5pt">Respondent</span></b></p>
				
		</tr>
        <tr style="height:.2in">
			<td colspan="6" style="width:233.45pt;border:solid #999999 1.0pt;
  border-top:none;padding:0in 5.75pt 0in 5.75pt;height:.2in" width="311">
				<p class="Body">
					<b>Name:&nbsp;</b><%# Eval("RespondentName") %></p>
			</td>
			<td colspan="8" style="width:182.6pt;border-top:none;border-left:
  none;border-bottom:solid #999999 1.0pt;border-right:solid #999999 1.0pt;
  padding:0in 5.75pt 0in 5.75pt;height:.2in"  >
				<p class="Body">
					<b>License/Registration #:&nbsp;</b><%# Eval("RespondantLicense") %></p>
			</td>
			<td colspan="3" style="width:107.9pt;border-top:none;border-left:
  none;border-bottom:solid #999999 1.0pt;border-right:solid #999999 1.0pt;
  padding:0in 5.75pt 0in 5.75pt;height:.2in" >
				<p class="Body">
					<b>Arrested:</b></p>
			</td>
		</tr>
		<tr style="height:.2in">
			<td colspan="17" style="width:523.95pt;border:solid #999999 1.0pt;
  border-top:none;padding:0in 5.75pt 0in 5.75pt;height:.2in" width="699">
				<p class="Body">
					<b>Address 1:&nbsp;</b><%# Eval("RespondentAddress1") %></p>
			</td>
		</tr>
		<tr style="height:.2in">
			<td colspan="17" style="width:523.95pt;border:solid #999999 1.0pt;
  border-top:none;padding:0in 5.75pt 0in 5.75pt;height:.2in" width="699">
				<p class="Body">
					<b>Address 2:&nbsp;</b><%# Eval("RespondentAddress2") %></p>
			</td>
		</tr>
		<tr style="height:.2in">
			<td colspan="6" style="width:233.45pt;border:solid #999999 1.0pt;
  border-top:none;padding:0in 5.75pt 0in 5.75pt;height:.2in" width="311">
				<p class="Body">
					<b>Phone:&nbsp;</b><%# Eval("RespondentPhone") %></p>
			</td>
			<td colspan="11" style="width:290.5pt;border-top:none;border-left:
  none;border-bottom:solid #999999 1.0pt;border-right:solid #999999 1.0pt;
  padding:0in 5.75pt 0in 5.75pt;height:.2in"  >
				<p class="Body">
					<b>Email:&nbsp;</b><%# Eval("RespondentEmail") %></p>
			</td>
		</tr>
		<tr style="height:.2in">
			<td colspan="11" style="width:369.1pt;border:solid #999999 1.0pt;
  border-top:none;padding:0in 5.75pt 0in 5.75pt;height:.2in" width="492">
				<p class="Body">
					<b>Pharmacy:</b></p>
			</td>
			<td colspan="6" style="width:154.85pt;border-top:none;border-left:
  none;border-bottom:solid #999999 1.0pt;border-right:solid #999999 1.0pt;
  padding:0in 5.75pt 0in 5.75pt;height:.2in"  >
				<p class="Body">
					<b>License #:</b></p>
			</td>
		</tr>
		<tr style="height:.2in">
			<td colspan="17" style="width:523.95pt;border:solid #999999 1.0pt;
  border-top:none;padding:0in 5.75pt 0in 5.75pt;height:.2in" width="699">
				<p class="Body">
					<b>Pharmacy Address:</b></p>
			</td>
		</tr>
		<tr style="height:.2in">
			<td colspan="11" style="width:369.1pt;border:solid #999999 1.0pt;
  border-top:none;padding:0in 5.75pt 0in 5.75pt;height:.2in" width="492">
				<p class="Body">
					<b>Supervising Pharmacist:</b></p>
			</td>
			<td colspan="6" style="width:154.85pt;border-top:none;border-left:
  none;border-bottom:solid #999999 1.0pt;border-right:solid #999999 1.0pt;
  padding:0in 5.75pt 0in 5.75pt;height:.2in"  >
				<p class="Body">
					<b>License #:</b></p>
			</td>
		</tr>
    
        </ItemTemplate>
        </asp:DataList>
        </td>
        </tr>
      
		<tr style="height:27pt;">
			<td colspan="17" style="width:523.95pt;border:none;
  border-bottom:solid #999999 1.0pt;padding:0in 5.75pt 0in 5.75pt;height:27pt">
				
				<p align="center" class="Body" style="text-align:center; width: 973px;">
					<b><span style="font-size:17.5pt">Diverted Drugs/Other</span></b></p>
				 
			</td>
		</tr>
		<tr style="height:.2in">
			<td rowspan="2" style="width:32.65pt;border:solid #999999 1.0pt;
  border-top:none;padding:0in 5.75pt 0in 5.75pt;height:.2in" width="44">
				<p class="Body">
					<b>Qty.</b></p>
			</td>
			<td colspan="8" rowspan="2" style="width:285.15pt;border-top:none;
  border-left:none;border-bottom:solid #999999 1.0pt;border-right:solid #999999 1.0pt;
  padding:0in 5.75pt 0in 5.75pt;height:.2in" width="380">
				<p align="center" class="Body" style="text-align:center">
					<b>&nbsp;Description</b></p>
			</td>
			<td colspan="6" style="width:103.25pt;border-top:none;border-left:
  none;border-bottom:solid #999999 1.0pt;border-right:solid #999999 1.0pt;
  padding:0in 5.75pt 0in 5.75pt;height:.2in" width="138">
				<p class="Body">
					<b>&nbsp;Dollar Value</b></p>
			</td>
			<td colspan="2" style="width:102.9pt;border-top:none;border-left:
  none;border-bottom:solid #999999 1.0pt;border-right:solid #999999 1.0pt;
  padding:0in 5.75pt 0in 5.75pt;height:.2in" width="137">
				<p align="center" class="Body" style="text-align:center">
					<b>Recovered</b></p>
			</td>
		</tr>
		<tr style="height:.1in">
			<td style="width:46.95pt;border-top:none;border-left:none;
  border-bottom:solid #999999 1.0pt;border-right:solid #999999 1.0pt;
  padding:0in 5.75pt 0in 5.75pt;height:.1in" width="63">
				<p class="Body">
					<b>Stolen</b></p>
			</td>
			<td colspan="5" style="width:56.3pt;border:solid #999999 1.0pt;
  border-left:none;padding:0in 5.75pt 0in 5.75pt;height:.1in" width="75">
				<p class="Body">
					<b>Damaged</b></p>
			</td>
			<td style="width:51.45pt;border-top:none;border-left:none;
  border-bottom:solid #999999 1.0pt;border-right:solid #999999 1.0pt;
  padding:0in 5.75pt 0in 5.75pt;height:.1in" width="69">
				<p align="center" class="Body" style="text-align:center">
					<b>Date</b></p>
			</td>
			<td style="width:51.45pt;border-top:none;border-left:none;
  border-bottom:solid #999999 1.0pt;border-right:solid #999999 1.0pt;
  padding:0in 5.75pt 0in 5.75pt;height:.1in" width="69">
				<p class="Body">
					<b>Value</b></p>
			</td>
		</tr>
		<tr style="height:.2in">
			<td style="width:32.65pt;border:solid #999999 1.0pt;border-top:none;
  padding:0in 5.75pt 0in 5.75pt;height:.2in" width="44">
				<p class="Body">
					&nbsp;</p>
			</td>
			<td colspan="8" style="width:285.15pt;border-top:none;border-left:
  none;border-bottom:solid #999999 1.0pt;border-right:solid #999999 1.0pt;
  padding:0in 5.75pt 0in 5.75pt;height:.2in" width="380">
				<p class="Body">
					&nbsp;</p>
			</td>
			<td style="width:46.95pt;border-top:none;border-left:none;
  border-bottom:solid #999999 1.0pt;border-right:solid #999999 1.0pt;
  padding:0in 5.75pt 0in 5.75pt;height:.2in" width="63">
				<p class="Body">
					&nbsp;</p>
			</td>
			<td colspan="5" style="width:56.3pt;border-top:none;border-left:none;
  border-bottom:solid #999999 1.0pt;border-right:solid #999999 1.0pt;
  padding:0in 5.75pt 0in 5.75pt;height:.2in" width="75">
				<p class="Body">
					&nbsp;</p>
			</td>
			<td style="width:51.45pt;border-top:none;border-left:none;
  border-bottom:solid #999999 1.0pt;border-right:solid #999999 1.0pt;
  padding:0in 5.75pt 0in 5.75pt;height:.2in" width="69">
				<p class="Body">
					&nbsp;</p>
			</td>
			<td style="width:51.45pt;border-top:none;border-left:none;
  border-bottom:solid #999999 1.0pt;border-right:solid #999999 1.0pt;
  padding:0in 5.75pt 0in 5.75pt;height:.2in" width="69">
				<p class="Body">
					&nbsp;</p>
			</td>
		</tr>
		<tr style="height:.2in">
			<td style="width:32.65pt;border:solid #999999 1.0pt;border-top:none;
  padding:0in 5.75pt 0in 5.75pt;height:.2in" width="44">
				<p class="Body">
					&nbsp;</p>
			</td>
			<td colspan="8" style="width:285.15pt;border-top:none;border-left:
  none;border-bottom:solid #999999 1.0pt;border-right:solid #999999 1.0pt;
  padding:0in 5.75pt 0in 5.75pt;height:.2in" width="380">
				<p class="Body">
					&nbsp;</p>
			</td>
			<td style="width:46.95pt;border-top:none;border-left:none;
  border-bottom:solid #999999 1.0pt;border-right:solid #999999 1.0pt;
  padding:0in 5.75pt 0in 5.75pt;height:.2in" width="63">
				<p class="Body">
					&nbsp;</p>
			</td>
			<td colspan="5" style="width:56.3pt;border-top:none;border-left:none;
  border-bottom:solid #999999 1.0pt;border-right:solid #999999 1.0pt;
  padding:0in 5.75pt 0in 5.75pt;height:.2in" width="75">
				<p class="Body">
					&nbsp;</p>
			</td>
			<td style="width:51.45pt;border-top:none;border-left:none;
  border-bottom:solid #999999 1.0pt;border-right:solid #999999 1.0pt;
  padding:0in 5.75pt 0in 5.75pt;height:.2in" width="69">
				<p class="Body">
					&nbsp;</p>
			</td>
			<td style="width:51.45pt;border-top:none;border-left:none;
  border-bottom:solid #999999 1.0pt;border-right:solid #999999 1.0pt;
  padding:0in 5.75pt 0in 5.75pt;height:.2in" width="69">
				<p class="Body">
					&nbsp;</p>
			</td>
		</tr>
		<tr style="height:.2in">
			<td style="width:32.65pt;border:solid #999999 1.0pt;border-top:none;
  padding:0in 5.75pt 0in 5.75pt;height:.2in" width="44">
				<p class="Body">
					&nbsp;</p>
			</td>
			<td colspan="8" style="width:285.15pt;border-top:none;border-left:
  none;border-bottom:solid #999999 1.0pt;border-right:solid #999999 1.0pt;
  padding:0in 5.75pt 0in 5.75pt;height:.2in" width="380">
				<p class="Body">
					&nbsp;</p>
			</td>
			<td style="width:46.95pt;border-top:none;border-left:none;
  border-bottom:solid #999999 1.0pt;border-right:solid #999999 1.0pt;
  padding:0in 5.75pt 0in 5.75pt;height:.2in" width="63">
				<p class="Body">
					&nbsp;</p>
			</td>
			<td colspan="5" style="width:56.3pt;border-top:none;border-left:none;
  border-bottom:solid #999999 1.0pt;border-right:solid #999999 1.0pt;
  padding:0in 5.75pt 0in 5.75pt;height:.2in" width="75">
				<p class="Body">
					&nbsp;</p>
			</td>
			<td style="width:51.45pt;border-top:none;border-left:none;
  border-bottom:solid #999999 1.0pt;border-right:solid #999999 1.0pt;
  padding:0in 5.75pt 0in 5.75pt;height:.2in" width="69">
				<p class="Body">
					&nbsp;</p>
			</td>
			<td style="width:51.45pt;border-top:none;border-left:none;
  border-bottom:solid #999999 1.0pt;border-right:solid #999999 1.0pt;
  padding:0in 5.75pt 0in 5.75pt;height:.2in" width="69">
				<p class="Body">
					&nbsp;</p>
			</td>
		</tr>
		<tr style="height:.2in">
			<td style="width:32.65pt;border:solid #999999 1.0pt;border-top:none;
  padding:0in 5.75pt 0in 5.75pt;height:.2in" width="44">
				<p class="Body">
					&nbsp;</p>
			</td>
			<td colspan="8" style="width:285.15pt;border-top:none;border-left:
  none;border-bottom:solid #999999 1.0pt;border-right:solid #999999 1.0pt;
  padding:0in 5.75pt 0in 5.75pt;height:.2in" width="380">
				<p class="Body">
					&nbsp;</p>
			</td>
			<td style="width:46.95pt;border-top:none;border-left:none;
  border-bottom:solid #999999 1.0pt;border-right:solid #999999 1.0pt;
  padding:0in 5.75pt 0in 5.75pt;height:.2in" width="63">
				<p class="Body">
					&nbsp;</p>
			</td>
			<td colspan="5" style="width:56.3pt;border-top:none;border-left:none;
  border-bottom:solid #999999 1.0pt;border-right:solid #999999 1.0pt;
  padding:0in 5.75pt 0in 5.75pt;height:.2in" width="75">
				<p class="Body">
					&nbsp;</p>
			</td>
			<td style="width:51.45pt;border-top:none;border-left:none;
  border-bottom:solid #999999 1.0pt;border-right:solid #999999 1.0pt;
  padding:0in 5.75pt 0in 5.75pt;height:.2in" width="69">
				<p class="Body">
					&nbsp;</p>
			</td>
			<td style="width:51.45pt;border-top:none;border-left:none;
  border-bottom:solid #999999 1.0pt;border-right:solid #999999 1.0pt;
  padding:0in 5.75pt 0in 5.75pt;height:.2in" width="69">
				<p class="Body">
					&nbsp;</p>
			</td>
		</tr>
		<tr style="height:.2in">
			<td style="width:32.65pt;border:solid #999999 1.0pt;border-top:none;
  padding:0in 5.75pt 0in 5.75pt;height:.2in" width="44">
				<p class="Body">
					&nbsp;</p>
			</td>
			<td colspan="8" style="width:285.15pt;border-top:none;border-left:
  none;border-bottom:solid #999999 1.0pt;border-right:solid #999999 1.0pt;
  padding:0in 5.75pt 0in 5.75pt;height:.2in" width="380">
				<p class="Body">
					&nbsp;</p>
			</td>
			<td style="width:46.95pt;border-top:none;border-left:none;
  border-bottom:solid #999999 1.0pt;border-right:solid #999999 1.0pt;
  padding:0in 5.75pt 0in 5.75pt;height:.2in" width="63">
				<p class="Body">
					&nbsp;</p>
			</td>
			<td colspan="5" style="width:56.3pt;border-top:none;border-left:none;
  border-bottom:solid #999999 1.0pt;border-right:solid #999999 1.0pt;
  padding:0in 5.75pt 0in 5.75pt;height:.2in" width="75">
				<p class="Body">
					&nbsp;</p>
			</td>
			<td style="width:51.45pt;border-top:none;border-left:none;
  border-bottom:solid #999999 1.0pt;border-right:solid #999999 1.0pt;
  padding:0in 5.75pt 0in 5.75pt;height:.2in" width="69">
				<p class="Body">
					&nbsp;</p>
			</td>
			<td style="width:51.45pt;border-top:none;border-left:none;
  border-bottom:solid #999999 1.0pt;border-right:solid #999999 1.0pt;
  padding:0in 5.75pt 0in 5.75pt;height:.2in" width="69">
				<p class="Body">
					&nbsp;</p>
			</td>
		</tr>
		<tr style="height:.2in">
			<td colspan="5" style="width:215.05pt;border:solid #999999 1.0pt;
  border-top:none;padding:0in 5.75pt 0in 5.75pt;height:.2in" width="287">
				<p class="Body">
					<b>DEA 106 Form Completed?</b></p>
			</td>
			<td colspan="12" style="width:308.9pt;border-top:none;border-left:
  none;border-bottom:solid #999999 1.0pt;border-right:solid #999999 1.0pt;
  padding:0in 5.75pt 0in 5.75pt;height:.2in" width="412">
				<p class="Body">
					<b>Copy of DEA 106 obtained?</b></p>
			</td>
		</tr>
		<tr style="height:27pt;page-break-after:always">
			<td colspan="17" style="width:523.95pt;border:none;
  border-bottom:solid #999999 1.0pt;padding:0in 5.75pt 0in 5.75pt;height:27pt">
				
				<p align="center" class="Body" style="text-align:center; width: 973px;">
					<b><span style="font-size:17.5pt">Witnesses</span></b></p>
				 
			</td>
		</tr>
		<tr style="height:.2in">
			<td colspan="2" style="width:112.3pt;border:solid #999999 1.0pt;
  border-top:none;padding:0in 5.75pt 0in 5.75pt;height:.2in" width="150">
				<h3>
					Name</h3>
			</td>
			<td colspan="11" style="width:280.65pt;border-top:none;border-left:
  none;border-bottom:solid #999999 1.0pt;border-right:solid #999999 1.0pt;
  padding:0in 5.75pt 0in 5.75pt;height:.2in" width="374">
				<p align="center" class="Body" style="text-align:center">
					<b>Address</b></p>
			</td>
			<td colspan="4" style="width:131.0pt;border-top:none;border-left:
  none;border-bottom:solid #999999 1.0pt;border-right:solid #999999 1.0pt;
  padding:0in 5.75pt 0in 5.75pt;height:.2in" width="175">
				<p align="center" class="Body" style="text-align:center">
					<b>Phone</b></p>
			</td>
		</tr>
		<tr style="height:.2in">
			<td colspan="2" style="width:112.3pt;border:solid #999999 1.0pt;
  border-top:none;padding:0in 5.75pt 0in 5.75pt;height:.2in" width="150">
				<p class="Body">
					<b>1.</b></p>
			</td>
			<td colspan="11" style="width:280.65pt;border-top:none;border-left:
  none;border-bottom:solid #999999 1.0pt;border-right:solid #999999 1.0pt;
  padding:0in 5.75pt 0in 5.75pt;height:.2in" width="374">
				<p class="Body">
					&nbsp;</p>
			</td>
			<td colspan="4" style="width:131.0pt;border-top:none;border-left:
  none;border-bottom:solid #999999 1.0pt;border-right:solid #999999 1.0pt;
  padding:0in 5.75pt 0in 5.75pt;height:.2in" width="175">
				<p class="Body">
					&nbsp;</p>
			</td>
		</tr>
		<tr style="height:.2in">
			<td colspan="2" style="width:112.3pt;border:solid #999999 1.0pt;
  border-top:none;padding:0in 5.75pt 0in 5.75pt;height:.2in" width="150">
				<p class="Body">
					<b>2.</b></p>
			</td>
			<td colspan="11" style="width:280.65pt;border-top:none;border-left:
  none;border-bottom:solid #999999 1.0pt;border-right:solid #999999 1.0pt;
  padding:0in 5.75pt 0in 5.75pt;height:.2in" width="374">
				<p class="Body">
					&nbsp;</p>
			</td>
			<td colspan="4" style="width:131.0pt;border-top:none;border-left:
  none;border-bottom:solid #999999 1.0pt;border-right:solid #999999 1.0pt;
  padding:0in 5.75pt 0in 5.75pt;height:.2in" width="175">
				<p class="Body">
					&nbsp;</p>
			</td>
		</tr>
		<tr style="height:.2in">
			<td colspan="2" style="width:112.3pt;border:solid #999999 1.0pt;
  border-top:none;padding:0in 5.75pt 0in 5.75pt;height:.2in" width="150">
				<p class="Body">
					<b>3.</b></p>
			</td>
			<td colspan="11" style="width:280.65pt;border-top:none;border-left:
  none;border-bottom:solid #999999 1.0pt;border-right:solid #999999 1.0pt;
  padding:0in 5.75pt 0in 5.75pt;height:.2in" width="374">
				<p class="Body">
					&nbsp;</p>
			</td>
			<td colspan="4" style="width:131.0pt;border-top:none;border-left:
  none;border-bottom:solid #999999 1.0pt;border-right:solid #999999 1.0pt;
  padding:0in 5.75pt 0in 5.75pt;height:.2in" width="175">
				<p class="Body">
					&nbsp;</p>
			</td>
		</tr>
		<tr style="height:.2in">
			<td colspan="2" style="width:112.3pt;border:solid #999999 1.0pt;
  border-top:none;padding:0in 5.75pt 0in 5.75pt;height:.2in" width="150">
				<p class="Body">
					<b>4.</b></p>
			</td>
			<td colspan="11" style="width:280.65pt;border-top:none;border-left:
  none;border-bottom:solid #999999 1.0pt;border-right:solid #999999 1.0pt;
  padding:0in 5.75pt 0in 5.75pt;height:.2in" width="374">
				<p class="Body">
					&nbsp;</p>
			</td>
			<td colspan="4" style="width:131.0pt;border-top:none;border-left:
  none;border-bottom:solid #999999 1.0pt;border-right:solid #999999 1.0pt;
  padding:0in 5.75pt 0in 5.75pt;height:.2in" width="175">
				<p class="Body">
					&nbsp;</p>
			</td>
		</tr>
		<tr style="height:.2in">
			<td colspan="2" style="width:112.3pt;border:solid #999999 1.0pt;
  border-top:none;padding:0in 5.75pt 0in 5.75pt;height:.2in" width="150">
				<p class="Body">
					<b>5.</b></p>
			</td>
			<td colspan="11" style="width:280.65pt;border-top:none;border-left:
  none;border-bottom:solid #999999 1.0pt;border-right:solid #999999 1.0pt;
  padding:0in 5.75pt 0in 5.75pt;height:.2in" width="374">
				<h2>
					&nbsp;</h2>
			</td>
			<td colspan="4" style="width:131.0pt;border-top:none;border-left:
  none;border-bottom:solid #999999 1.0pt;border-right:solid #999999 1.0pt;
  padding:0in 5.75pt 0in 5.75pt;height:.2in" width="175">
				<h2>
					&nbsp;</h2>
			</td>
		</tr>
		<tr style="height:.2in">
			<td colspan="2" style="width:112.3pt;border:solid #999999 1.0pt;
  border-top:none;padding:0in 5.75pt 0in 5.75pt;height:.2in" width="150">
				<p class="Body">
					<b>6.</b></p>
			</td>
			<td colspan="11" style="width:280.65pt;border-top:none;border-left:
  none;border-bottom:solid #999999 1.0pt;border-right:solid #999999 1.0pt;
  padding:0in 5.75pt 0in 5.75pt;height:.2in" width="374">
				<p class="Body">
					<b>&nbsp;</b></p>
			</td>
			<td colspan="4" style="width:131.0pt;border-top:none;border-left:
  none;border-bottom:solid #999999 1.0pt;border-right:solid #999999 1.0pt;
  padding:0in 5.75pt 0in 5.75pt;height:.2in" width="175">
				<p class="Body">
					<b>&nbsp;</b></p>
			</td>
		</tr>
		<tr height="70pt">
			<td style="border:none" width="44">
				&nbsp;</td>
			<td style="border:none" width="108">
				&nbsp;</td>
			<td style="border:none" width="31">
				&nbsp;</td>
			<td style="border:none" width="89">
				&nbsp;</td>
			<td style="border:none" width="19">
				&nbsp;</td>
			<td style="border:none" width="25">
				&nbsp;</td>
			<td style="border:none" width="20">
				&nbsp;</td>
			<td style="border:none" width="82">
				&nbsp;</td>
			<td style="border:none" width="13">
				&nbsp;</td>
			<td style="border:none" width="64">
				&nbsp;</td>
			<td style="border:none" width="6">
				&nbsp;</td>
			<td style="border:none" width="1">
				&nbsp;</td>
			<td style="border:none" width="32">
				&nbsp;</td>
			<td style="border:none" width="31">
				&nbsp;</td>
			<td style="border:none" width="7">
				&nbsp;</td>
			<td style="border:none" width="70">
				&nbsp;</td>
			<td style="border:none" width="70">
				&nbsp;</td>
		</tr>
		<tr style="height:27pt;page-break-after:always">
			<td colspan="17" style="width:523.95pt;border:solid;
  border-bottom:solid #999999 3px;padding:0in 5.75pt 0in 5.75pt;height:27pt">
 
				
				<p align="center" class="Body" style="text-align:center; width: 973px;">
					<b><span style="font-size:17.5pt">Investigative Summary</span></b></p>
				<p align="center" class="Body" style="text-align:center">
					&nbsp;</p>
				<p align="center" class="Body" style="text-align:center">
					 </p>
				<p align="center" class="Body" style="text-align:center">
					&nbsp;</p>
				<p align="center" class="Body" style="text-align:center">
					&nbsp;</p>
				<p align="center" class="Body" style="text-align:center">
					&nbsp;</p>
				<p align="center" class="Body" style="text-align:center">
					&nbsp;</p>
				<p align="center" class="Body" style="text-align:center">
					&nbsp;</p>
				<p align="center" class="Body" style="text-align:center">
					&nbsp;</p>
			</td>
		</tr>
		<tr style="height:27pt;">
			<td colspan="17" style="width:523.95pt;border:solid;
  border-bottom:solid #999999 3px;padding:0in 5.75pt 0in 5.75pt;height:27pt">
			
				<p align="center" class="Body" style="text-align:center; width: 973px;">
					<b><span style="font-size:17.5pt">Investigation Details</span></b></p>
				<p align="center" class="Body" style="text-align:center">
					&nbsp;</p>
				<p align="center" class="Body" style="text-align:center">
					 </p>
				<p align="center" class="Body" style="text-align:center">
					&nbsp;</p>
				<p align="center" class="Body" style="text-align:center">
					&nbsp;</p>
				<p align="center" class="Body" style="text-align:center">
					&nbsp;</p>
				<p align="center" class="Body" style="text-align:center">
					&nbsp;</p>
				<p align="center" class="Body" style="text-align:center">
					&nbsp;</p>
				<p align="center" class="Body" style="text-align:center">
					&nbsp;</p>
			</td>
		</tr>
	</tbody>
</table>

</div>

          </body>

</html>