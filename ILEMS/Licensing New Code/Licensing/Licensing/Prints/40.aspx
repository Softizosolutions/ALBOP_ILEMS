<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Vw_Print.aspx.cs" Inherits="Licensing.Prints.Vw_Print" %>

<html  xmlns:o='urn:schemas-microsoft-com:office:office'  xmlns:w='urn:schemas-microsoft-com:office:word'  xmlns='http://www.w3.org/TR/REC-html40'>
<head>
<title></title>
  <style>
  
  @page Section1 {size:8.5in 11.0in; margin:0.75in 1in 0.75in 1in;} div.Section1 {page:Section1;} Table { font-family:Arial; font-size:11pt; } --> </style> </head>
    <body lang=EN-US>
        <div class=Section1>
          <%--  <div>
        <div style="float:left; padding-left:15%;"> <img src="https://igovsolution.net/albop/images/Albop_logo.jpg" style="align-content:center;" height="100" width="100" /> </div>
        <div style="float:left;padding-left:2%; "> <div style="text-align:center;"> <p style="font-family:Georgia;font-size:18px; padding-left:15px;"> ALABAMA STATE BOARD OF PHARMACY </p> <p style="font-family:Calibri;font-size:16px;"> <b>111 Village Street, Birmingham, AL 35242</b> <br /> <a href="https://www.albop.com"><b>www.albop.com</b></a> <b> Phone: 205-981-2280</b></p> </div> </div>
        
    </div>--%>

            <table width="98%" align="center" >
        <tr>
               <td width="5%" ></td>
            <td align="right"  ><div> <img src="https://igovsolution.net/albop/images/Albop_logo.jpg"  height="100" width="100" /> </div></td>
         
             <td align="left"  ><div style="padding-right:150px;" > <p style="font-family:Georgia;font-size:18px; text-align:center;"> ALABAMA STATE BOARD OF PHARMACY </p> <p style="font-family:Calibri;font-size:16px; text-align:center;"> <b>111 Village Street, Birmingham, AL 35242</b> <br /> <a href="https://www.albop.com"><b>www.albop.com</b></a> <b> Phone: 205-981-2280</b></p> </div> </div></td>
          
        </tr>
    </table>

           <%--     <div >
            <div style="float:left; padding-left:50px;"> <img src="https://igovsolution.net/albop/images/Albop_logo.jpg" style="align-content:center;" height="100" width="100"/> </div>
               
                    <div style="text-align:center;"> <p style="font-family:Georgia;font-size:18px; padding-left:15px;">
                    ALABAMA STATE BOARD OF PHARMACY  </p>
                 <p style="font-family:Calibri;font-size:16px;"> <b>111 Village Street, Birmingham, AL 35242</b> <br />
                   <a href="https://www.albop.com"><b>www.albop.com</b></a> <b> Phone: 205-981-2280</b></p>
                    </div> 
             </div>--%>
        <%--    <table>
            <tr>
                <td style="padding-left:180px;">
                <img src="https://igovsolution.net/albop/images/Albop_logo.jpg" height="100" width="100"/> <br />
            </td>
                <td style="padding-left:45px;padding-top:20px;font-family:Georgia;font-size:18px;">
                    ALABAMA STATE BOARD OF PHARMACY 
                 <p style="padding-left:40px;font-family:Calibri;font-size:16px;"> <b>111 Village Street, Birmingham, AL 35242</b></p> 
                    <p style="padding-left:80px;padding-bottom:20px;font-family:Calibri;font-size:16px;"><a href="https://www.albop.com"><b>www.albop.com</b></a> <b> -205-981-2280</b></p>
                     </td>
            </tr>
            </table>--%>
         </div>
        <br />  
        <div style="border-style:solid">
            
            <p style="font-style:italic;font-size:30px; font-weight:600;text-align:center;" >License Verification</p>
            <p style="padding-left:5px; font-size:16px;font-family:Calibri;">
               <%--<h2><i><b>This is to certify the status of the permit/registration/license of:</b> </i></h2> <br /> <br /> <br /> <br />--%>

            <b> Name: <%= Getval("Name") %> <br /> <br /> 
                Permit/Registration/License Number: <%=Getval("Licno") %> <br /> <br /> 
                License Type: <%= Getval("LicenseType") %> <br /> <br /> 
                  License Status: <%= Getval("licStatus") %> <br /> <br />
                Date Issued: <%= Getval("IssueDate") %> <br /> <br /> 
                Expiration Date: <%=Getval("ExpireDate") %> <br /> <br /> 
                Disciplinary Action: <%=Getval("disp") %> <br /> <br /> 
                Date Prepared: <%=Getval("Currentdate") %> <br /> </b>    
            </p>
            <p style="padding-left:5px;">  
                <img src="https://igovsolution.net/albop/images/sig.png" height="60" width="180" /> <br /></p>
            <p style="padding-left:5px; font-size:16px;font-family:Calibri;">
              <b>  Donna Yeatman, R.Ph. <br />
                Executive Secretary </b>
            </p>
        </div>
    </body>
</html>
