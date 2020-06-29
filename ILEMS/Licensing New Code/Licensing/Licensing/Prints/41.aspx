<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Vw_Print.aspx.cs" Inherits="Licensing.Prints.Vw_Print" %>

<html  xmlns:o='urn:schemas-microsoft-com:office:office'  xmlns:w='urn:schemas-microsoft-com:office:word'  xmlns='http://www.w3.org/TR/REC-html40'>
<head>  
    <title></title>
 
  <style>
      @page Section1 {
          size: 8.5in 11.0in;
          margin: 0.75in 0.75in 0.75in 0.75in;
      }

      div.Section1 {
          page: Section1;
      }

      Table {
          font-family: Arial;
          font-size: 11pt;
      }
  </style> 
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">

</head> 
    <body lang=EN-US> 
        <div class="Section1" style="line-height:3px; line-height:15px" > 
            <table width="98%">
                
                <tr>
                   <td style="text-align:center; font-size:10pt; font:Arial";>
                    Donna Yeatman, R.Ph.   <br />
                    Executive Secretary <br /> <br />
                    <u> Location: </u> <br />
                    111 Village Street <br />
                  Birmingham, AL 35242 <br /> <br />
                    (205) 981-2280 <br />
                  (205) 981-2330 Fax <br /> 
                   www.albop.com 
                        </td>                   
               
                   <td style="text-align:center;font-size:16pt; font:Arial";> <b>   ALABAMA <br /> BOARD OF PHARMACY </b>
                       <br /> <br /> 
                   <img src="https://igovsolution.net/albop/images/Albop_logo.jpg" style="width:150px; height:150px;" />

               </td> 
                    <td style="text-align:center;  font-size:10pt; font:Arial";>
             <u>     MEMBERS 2019  </u> <br /> <br />
                    Kenny Sanders, R.Ph <br />
                    President <br /> <br />
                    Ralph Sorrell, R.Ph. <br />
                    Vice President <br /> <br />
                    Brenda Denson, PharmD <br /> 
                    Treasurer <br /><br />
                    Chris Phung, R.Ph<br /><br />
                    Robert Colburn, Jr., R.Ph.
                        </td>
                </tr>              
                </table><br />
            <div style="text-align:center" > <b><%= Getval("currentdate") %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</b></div> 
            <br />
            <table  width="98%">
                     <tr><td style="padding-left:28px"><b>To:</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%= Getval("Name") %><br />
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%= Getval("address") %><br />
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%= Getval("citystatezip") %><br />
                    				</td>			</tr>
                        <tr>			
				<td style="padding-left:28px"><br/>
					<b>FROM:</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Wendy Passmore, Operations Manager<br />
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;EMAIL- wpassmore@albop.com<br />
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;FAX - 205-803-6481<br />
				</td>
			</tr>
                    <tr><td style="padding-left:28px"><br/><b>RE:</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ADMINISTRATIVE HEARINGS<br />
                    </td>
			</tr>
            <tr>
                 <td style="padding-left:28px" ><br/> Your hearing is scheduled for
                       <b> <u><%= Getval("hearingdate") %></u>&nbsp;<%= Getval("at") %>&nbsp; <u><%= Getval("hearingtime") %></u></b>
                       <br /><br />
                       </td>
                        </tr>
                    </table> 
                <table width="98%">
                    <tr> <td style="padding-left:28px"> <b> Please provide the following information.</b><br /><br /></td></tr>
                    </table> 
                <table width="98%"><tr>
                  <td style="padding-left:28px">
                  NAME:______________________________________________________________________________
                  <br /><br/>
                  </td>
                  </tr>
                  <tr>
                     <td style="padding-left:28px"><b>  LICENSE/ REGISTRATION NUMBER </b> ________________________<b>PHONE #</b> (___)_______________
                                <br /> <br/>
                            </td>
                        </tr>
            <tr><td style="padding-left:28px"> <b>ADDRESS: </b>__________________________________________________________________________<br /> ___________________________________________________________________________________</td></tr>
                         <tr>
                        <td>
					</td>
                    </table> 
                <table width="98%"><tr>
                       <td style="padding-left:28px"><br /><spane style="font-size:20px;" > &#9633; </spane> <b>   I DO </b>plan to attend the Hearing.     <br />                           
                            </td>
                        </tr>
                        <tr><td style="padding-left:28px">
                            <spane style="font-size:20px;" > &#9633; </spane><b>   I DO NOT</b> plan to attend the Hearing.   <br />                               
                            </td>
                        </tr>
                        <tr>
                            <td style="padding-left:28px">                              
                          <spane style="font-size:20px;" > &#9633; </spane> <b> I WILL NOT</b> be represented by an Attorney  <br />                               
                            </td>
                        </tr>
                        <tr><td style="padding-left:28px">                              
                           <spane style="font-size:20px;" > &#9633; </spane><b>  I WILL</b> be represented by the Attorney listed below: <br /> <br />                               
                            </td>
                        </tr>
                        <tr>
                            <td style="padding-left:28px"><b> ATTORNEY'S NAME:</b> _____________________________________<b>PHONE # </b>___________________
                                <br /><br />
                            </td>
                        </tr>
                        <tr>
                            <td style="padding-left:28px">
                             <b> ADDRESS:</b>__________________________________________________________________________
                                <br /><br />
                            </td>
                        </tr>
                        <tr>                            
                            <td style="padding-left:28px">                               
                             <b> EMAIL</b> _____________________________________________________________________________
                                <br /><br />
                            </td>
                        </tr>
                        <tr>
                            <td style="padding-left:28px" >
                            **************************************************************************************************************************** <br />
                            WHILE A CONTINUANCE IS NOT AUTOMATIC, ANY REQUEST FOR ONE MUST BE FILED AND RECEIVED BY THE BOARD'S HEARING OFFICER THIRTY (30) DAYS PRIOR TO YOUR SCHEDULED HEARING DATE.
                            </td>
                        </tr>   
                    </table>
            </div>
                
</body></html>
