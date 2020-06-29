<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Vw_Print.aspx.cs" Inherits="Licensing.Prints.Vw_Print" %>

<html xmlns:o='urn:schemas-microsoft-com:office:office' xmlns:w='urn:schemas-microsoft-com:office:word' xmlns='http://www.w3.org/TR/REC-html40'>
<head>
    <title></title>

    <style>
        @page Section {
            size: 8.5in 11.0in;
            margin: 0.5in 0.5in 0.5in 0.5in;
        }

        div.Section {
            page: Section1;
        }
          Table {
          font-family: Cambria;
          font-size: 11pt; 
        width:98%;
             }
    </style>

 
</head>

<body>
<Section>
    <table > <tr>
            <td align="center" >
                <b>ALABAMA STATE BOARD OF PHARMACY</b><br />
        <b><u><i>Administrative Hearing</i></u></b> <br />
        <i>Confidential for office use only</i><br />
            </td>
        </tr></table>
    <table style="line-height:25px !important;" >
       <tr> <td > Date: <b><u><%= Getval("hearingdate") %></u></b> &nbsp;&nbsp&nbsp;&nbsp&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;   Case #: &nbsp;&nbsp; <u><b><%= Getval("Complaint_Number") %></b></u>&nbsp;&nbsp&nbsp;&nbsp&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  # Of Counts :&nbsp;&nbsp<u><b><%= Getval("noofcounts") %></b></u>  </td></tr>
      <tr> <td >Respondent(s) Name(s):   <u><%= Getval("RespondantName") %></u></td> </tr>
        <tr> <td >  License/Registration/Permit Number(s):  <u><%= Getval("Lic_no") %></u> </td> </tr>
         <tr> <td > Counts <b>Guilty</b>__________________&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Counts <b>Not Guilty</b>__________________ </td> </tr>
 </table>
    
    <table style="line-height:18px !important;"> 
        <tr> <td><span style="font-size:20px;" > &#9633; </span> Revocation &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span style="font-size: 20px;"> &#9633; </span> Granted </td></tr>
 <tr><td> <span style="font-size:20px;" > &#9633; </span>  Reprimand  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span style="font-size: 20px;"> &#9633; </span> Not Granted</td></tr>
        <tr><td> <span style="font-size:20px;" > &#9633; </span>  Suspension reverted to probation  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  Length of Probation _________________ </td></tr>
         <tr><td>  <span style="font-size:20px;" > &#9633; </span>  Probation  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; Length of Suspension _________________ </td></tr>
        <tr> <td><span style="font-size:20px;" > &#9633; </span> Suspension </td> </tr>
        <tr> <td><span style="font-size:20px; " > &#9633; </span>  Consent</td></tr>
        </table>
     <table style="line-height:30px !important; font-size:14px !important;">
         <tr><td> <b>NABP CODE ____________________ &nbsp;&nbsp WEBSITE STATUS __________________________</b></td> </tr>
         </table> 
    <table style="padding-left:22px;  line-height:18px !important;"> 
        <tr> <td >   <b><u><i>Conditions of Probation:</i></u></b></td></tr>
    <tr ><td > <span style="font-size: 20px;"> &#9633; </span> Monitoring Contract	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  Length of contract _____________	</tr>
    <tr> <td> <span style="font-size: 20px;"> &#9633; </span> No supervising pharmacist </td> </tr>
        <tr> <td> <span style="font-size: 20px;"> &#9633; </span> No preceptor </td></tr>
        <tr> <td> <span style="font-size: 20px;"> &#9633; </span> No designated "Non-Pharmacist Key Holder" </td></tr>
        <tr><td><span style="font-size: 20px;"> &#9633; </span> Standard graded return to work            </td></tr>
        <tr><td><span style="font-size: 20px;"> &#9633; </span> Notify employers</td></tr>
        <tr><td> <span style="font-size: 20px;"> &#9633; </span> Report to ___________________________________________________
    </td></tr>
        <tr><td> <span style="font-size: 20px;"> &#9633; </span> Disciplinary Fine $_________________                Due in _________ months/days     </td></tr><tr><td>        <span style="font-size: 20px;"> &#9633; </span> Administrative Fine $ _________________         Due in _________ months/days</td> </tr> 
        </table>
    <table style="line-height:28px !important;"><tr> <td > <b><u><i>Special Provisions of Order:</i></u></b> </td> </tr>        
        <tr><td>__________________________________________________________________________________________________________________________</td></tr>    
        <tr><td>__________________________________________________________________________________________________________________________</td></tr>    
        <tr><td>__________________________________________________________________________________________________________________________</td></tr>    
        <tr><td>__________________________________________________________________________________________________________________________</td></tr>    
        <tr><td>__________________________________________________________________________________________________________________________</td></tr>
        <tr><td>Board President_________________________________________________________________________________________</td></tr>    
        <tr><td>Board Vice-President____________________________________________________________________________________</td></tr>
        <tr><td>Board Treasurer_________________________________________________________________________________________</td></tr>
        <tr><td>Board Member____________________________________________________________________________________________</td></tr>
        <tr><td>Board Member____________________________________________________________________________________________</td></tr>
       </table>
      </Section>
</body>
</html>
