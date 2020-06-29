<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Vw_Print.aspx.cs" Inherits="Licensing.Prints.Vw_Print" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
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

    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"/>
</head>
<body>
    
    <div class="Section1" style="line-height:3px; line-height:15px">
        <div class="col-md-12"  >
            <div class="col-md-4" style="float:left;padding-top:20px">
                <img src="../images/Albop_logo.jpg" style="height:120px !important;width:120px !important;"/>
            </div>
             <div class="col-md-8" align="center" style="padding-top: 20px">
                  <p><span style="font-size:18pt;"><b>ALABAMA STATE BOARD OF PHARMACY</b></span></p>

             <p>111 Village Street, Birmingham, AL  35242 </p>
                   <p>www.albop.com – 205-981-2280</p>
            </div>
          
        </div>
        
            <br />
           
  
           <div class="col-md-12">

               
           <p> <hr  style="border:1px solid black;"/></p>
                <br /><br /><br />
                </div>
        
            <div style="font-size:16pt; font:Arial;padding-left:28px"; >
              <p> <b><u>TO WHOM IT MAY CONCERN:</u></b></p> <br />
            </div>
            
        
            <div style="text-align:center;font-size:16pt; font:Arial";>
                <p><b><i>RE:	<%= Getval("Name") %></i></b></p>
                <p><b><i><%= Getval("licnum") %></i></b></p>
                <br />
            </div>
        
            <div style="padding-left:28px">
                <p>This is to certify that the undersigned is the duly elected executive officer of the Alabama State Board of Pharmacy.  I am in charge of the Board office and all records are made and kept under my direct supervision.</p> 

            </div>
           
        
            <div style="padding-left:28px">
                <p>This is to further, certify that the enclosed records are exact copies of those appearing on file regarding <b><i><%= Getval("Name") %>.</i></b></p>
                 <br /><br /><br />
            </div>
        
            <div style="padding-left:28px">
                <p><img src="../images/sig.png" style="width:250px;height:70px;margin-bottom:-40px" /></p>
                <p>____________________________</p>
                <p>Donna Yeatman, R.Ph.</p>	
                <p>Secretary</p>
                
            </div>
        
            <div style="padding-left:28px">
                
                <p>Subscribed and sworn before me this <%= Getval("currentdate") %>, at Birmingham, Alabama, County of Shelby.</p>
                
            </div>
        
            <div style="text-align:center;font-size:16pt; font:Arial">
          

               <p> ________________________</p>
                    <p>Rhonda Coker</p>
                    <p>Notary Public</p>
                    <p>State-at-Large</p>

            </div>
     

    </div>
    
</body>
</html>
