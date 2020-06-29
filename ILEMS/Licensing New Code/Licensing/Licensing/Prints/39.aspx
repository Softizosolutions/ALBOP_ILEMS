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
  
  @page Section1 {size:8.5in 11.0in; margin: .5in 1in 1in 1in;} div.Section1 {page:Section1;} Table { font-family:Arial; font-size:11pt; } --> </style> </head> 
    <body lang=EN-US> <div class=Section1> 
 
    <form id="form1" runat="server">
         
        
            <table width="98%">
                 <tr>
                    <td colspan="3" style="text-align:center;font-size:14pt; font:Arial";>
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
                    <td style="text-align:center;  font-size:10pt; font:Arial";>
         <b>     <u>     MEMBERS 2019  </u> <br /> <br />
                    Kenny Sanders, R.Ph. <br />
                    President <br /> <br />
                    Ralph Sorrell, R.Ph. <br />
                    Vice President <br /> <br />
                    Brenda Denson, PharmD <br />
                    Treasurer <br /><br />
                    Chris Phung, R.Ph. <br /><br />
                    Robert Colburn, Jr., R.Ph.
         </b   >
                        </td>
                </tr>
            
                </table><br />
        <table style="width:100%">
            <tr >
                <td style="width:40%"> IN THE MATTER OF:</td>
                <td style="width:20%"></td>
                <td style="width:40%">BEFORE THE ALABAMA STATE</td>

            </tr>
            <tr>
                <td style="width:40%"></td>
                <td style="width:20%"></td>
                <td style="width:40%"></td>

            </tr>

            <tr>
                <td style="width:40%"><%= Getval("Name") %> </td>
                <td style="width:20%"></td>
                <td style="width:40%">BOARD OF PHARMACY</td>

            </tr>

             <tr>
                <td style="width:40%"> </td>
                <td style="width:20%"></td>
                <td style="width:40%"></td>

            </tr>

             <tr>
                <td style="width:40%"> License No.: <%= Getval("LicenseNo") %></td>
                <td style="width:20%"></td>
                <td style="width:40%">CASE NO: <%= Getval("ComplaintNo") %></td>

            </tr>

            <tr>
                <td style="width:40%"> </td>
                <td style="width:20%"></td>
                <td style="width:40%"></td>

            </tr>
        </table>
        <br />
        <div>
          <h3 style="text-align:center"><u>  STATEMENT OF CHARGES AND NOTICE OF HEARING</u></h3>
        </div>
       <div>
           <label>
               TO:&nbsp;&nbsp; <%= Getval("Name") %><br />
	          &nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%= Getval("Address") %> <br />
              &nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%= Getval("City_State_Zip") %>
           </label>
       </div>

        <div style="text-align:justify;">
            <label><p style="line-height:40px">
           &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Pursuant to the provisions of <u>Code of Alabama</u> (1975), &sect;  34-23-34 and &sect; 34-23-92 (12) and <u>Code of Alabama</u> (1975), &sect; 41-22-12, you are hereby notified and requested to appear before the Alabama State Board of Pharmacy (hereinafter referred to as the "Board") on___________________  __________, <%= Getval("CurrentYear") %> at _____ ___.m.,  at the State Board of Pharmacy Conference Room, 111 Village Street, Birmingham, Alabama  35242, and from time to time thereafter as may be required by the Board for the purpose of a hearing to determine why your pharmacy technician registration should not be revoked, suspended or placed on probation and/or whether your right to apply for renewal and/or renewal of your pharmacy technician registration should be denied or a monetary penalty imposed in that it is alleged that you have been guilty of the following, to-wit:
           </p> </label>
                
        </div>
         
       
   <div>
          <h3 style="text-align:center"><u>  COUNT ONE </u></h3>
        </div>

        <div style="text-align:justify;"><label>
              <p style="line-height:40px">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Violating <u>Code of Alabama</u> (1975), &sect; 34-23-132(3) by your failure to pay an administrative fine in the amount of ___________________________ as ordered by the Board in its Final Order dated __________, attached hereto as Exhibit, the same being an action which threatens the public health, safety and welfare.</p>
       </label>

             </div>
    
        <div>
        <label> <p style="line-height:40px">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; At the aforesaid time and place and from time to time thereafter as may be directed by the Board, you may be represented by an attorney, if you so desire, cross-examine all witnesses who testify against you and present such evidence in your own behalf in response to these charges as you consider necessary and appropriate.</p>
       
            </label>
             </div>


        <div style="text-align:center">
            <label>Dated this the ______ day of _______________________________________,&nbsp;&nbsp; <%= Getval("CurrentYear") %>.</label>

        </div>

        <br />
        <br />

        <div style="text-align:right"> <label>ALABAMA STATE BOARD OF PHARMACY</label></div>

        <br />
        <br />
        <div style="text-align:right"><label>______________________________<br />By:	Donna C. Yeatman, R.Ph.<br />
Executive&nbsp;Secretary
            </label>
</div>

     
    </form>
        </div>
</body>
</html>
