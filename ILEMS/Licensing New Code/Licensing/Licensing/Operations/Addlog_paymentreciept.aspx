<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Addlog_paymentreciept.aspx.cs" Inherits="Licensing.Operations.Addlog_paymentreciept" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>::Payment Receipt ::</title>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="scr" runat="server"></asp:ScriptManager>

        <div class="contentbody">


            <table  cellpadding="5" cellspacing="5"  align="center" width="100%">
              
                <tr>
                    <td colspan="2" align="center" valign="middle" >
                    <img src="../Prints/image001[1].gif" style="display:inline-block;margin-right:5px" />
                    
                   <div style="display:inline-block;vertical-align:middle"><h2 >Alabama Board Of Pharmacy</h2></div> 
                    </td>
                </tr>

                <tr>
                    <td align="center" colspan="2">
                        <b>Payment Receipt </b>
                        <br />
                        <u>------------------------------------------------------------------------</u>
                    </td>
                </tr>
                <tr>

                    
                    <td colspan="2" align="center">
                     <b>Printed on: </b>  <asp:Label ID="lbltransationdate" runat="server"></asp:Label>&nbsp;&nbsp;&nbsp;
                    </td>

                </tr>
                <tr>
                    <td width="100%" colspan="2">

                        <table width="100%" align="center" cellpadding="2" cellspacing="2">
                            <tr>
                                <td align="right" style="font-weight:bold">Received From:</td>
                                <td>
                                    <asp:Label ID="lbl_receivedfrom" runat="server"></asp:Label>
                                </td>
                                 <td align="right" style="font-weight:bold">Payement Type :</td>
                                <td>
                                    <asp:Label ID="lbl_paymenttype" runat="server"></asp:Label>
                                </td>
                              

                            </tr>
                            <tr>
                              <td align="right" style="font-weight:bold">Name/License # :</td>
                                <td>
                                    <asp:Label ID="lbl_license" runat="server"></asp:Label>
                                </td>
                                <td align="right" style="font-weight:bold">Amount:</td>
                                <td>
                                   $ <asp:Label ID="lbl_amt" runat="server"></asp:Label>
                                </td>
                               

                            </tr>
                            <tr>
                                 <td align="right" style="font-weight:bold" >Payment Receipt #: </td>
                                <td>
                                    <asp:Label ID="lbl_receipt" runat="server"></asp:Label>
                                </td>
                                
                                <td align="right" style="font-weight:bold">CheckNumber:</td>
                                <td>
                                    <asp:Label ID="lbl_chknum" runat="server"></asp:Label>
                                </td>

                            </tr>
                          


                            <tr style="display:none">
                                <td align="right" style="font-weight:bold">Fee Type:</td>
                                <td  >
                                    <asp:Label ID="lbl_feetype" runat="server"></asp:Label>
                                </td>

                            </tr>
                         
                        </table>
                    </td>
                </tr>
              
               
            </table>

        </div>




        <script language="javascript">
            
            window.print();
            

        </script>
    </form>
</body>

</html>
