<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PyamentHist_Print.aspx.cs" Inherits="Licensing.PersonLicensing.PyamentHist_Print" %>



<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script>
        // window.print();
      
    </script>
    <style type="text/css">
        @media print {
            table.gridmain1 {
                border: 1px solid;
                background-color: #cfcfcf;
                margin-bottom: 5px;
                font-size: 12pt;
            }

                table.gridmain1 thead tr:nth-child(2) {
                    display: none;
                }

                table.gridmain1 tfoot {
                    display: none;
                }
        }
    </style>

    <meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport' />
    <link rel="shortcut icon" href="../images/favicon.ico" />
    <link href="../bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="../Styles/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
    <link href="../Styles/AdminLTE.min.css" rel="stylesheet" type="text/css" />
    <link href="../Styles/skin-blue.min.css" rel="stylesheet" type="text/css" />
    <link href="../Styles/jquery-ui.css" rel="stylesheet" type="text/css" />
    <link href="../Styles/product.css" rel="stylesheet" type="text/css" />
    <script src="../Scripts/jquery.js" type="text/javascript"></script>
    <script src="../Scripts/jquery-ui.min.js" type="text/javascript"></script>
    <script src="../Scripts/jquery.maskedinput.min.js" type="text/javascript"></script>
    <script src="../bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="../Scripts/DemoScript.js"></script>
    <script src="../WCFGrid/FileSaver.js" type="text/javascript"></script>
    <script src="../WCFGrid/grd.js" type="text/javascript"></script>
    <script src="../WCFGrid/jspdf.js" type="text/javascript"></script>
    <script src="../WCFGrid/jspdf.plugin.cell.js" type="text/javascript"></script>
    <script src="../WCFGrid/jspdf.plugin.table.js" type="text/javascript"></script>
    <script src="../WCFGrid/pdfgenrate.js" type="text/javascript"></script>
    <script src="../WCFGrid/jquery.table2excel.js"></script>
    <script src="../Scripts/app.js" type="text/javascript"></script>
    
</head>
<body>
    <form id="form1" runat="server">

        <div>
            <table style="width: 100%;">
                <tr>
                    <td>
                        <img src="../images/Seal_of_Alabama.png" style="height: 140px; width: 140px;" /></td>
                    <td>
                        <h2>ALABAMA BOARD OF PHARMACY</h2>
                    </td>
                </tr>
            </table>
            <hr />
            <asp:HiddenField ID="hfd_orderid" Value="0" runat="server" />
            <table align="center" class="spac" style="width: 100%; align-content: center; font-size: 20px;">
                <tr>
                    <td colspan="4" align="center">
                        <b>Finance Receipt</b><br />
                        ----------------------------------------------------------------
                    </td>
                </tr>

                <tr>
                    <td align="right">
                        <b>Name :</b>
                    </td>
                    <td align="left">
                        <asp:Label ID="lbl_Name" runat="server" Text=""></asp:Label>
                    </td>

                    <td align="right">
                        <b>License # :</b>
                    </td>
                    <td align="left">
                        <asp:Label ID="lbl_License" runat="server" Text=""></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <b>Date Paid :</b>
                    </td>
                    <td align="left">
                        <asp:Label ID="lbl_datepaid" runat="server" Text=""></asp:Label>
                    </td>

                    <td align="right">
                        <b>Amount Paid :</b>
                    </td>
                    <td align="left">
                        <asp:Label ID="lbl_amountpaid" runat="server" Text=""></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <b>Order Id :</b>
                    </td>
                    <td align="left">
                        <asp:Label ID="lbl_orderid" runat="server" Text=""></asp:Label>
                    </td>
                    <td align="right">
                        <b>Payment Type :</b>
                    </td>
                    <td align="left">
                        <asp:Label ID="lbl_payment_type" runat="server" Text=""></asp:Label>
                    </td>

                </tr>
                <tr>
                    <td align="right">
                        <b>Fee Type :</b>
                    </td>
                    <td align="left" style="width:40%">
                        <asp:Label ID="lblfeetype" runat="server" Text=""></asp:Label>
                    </td>
                    <td align="right" id="checklbl" runat="server">
                        <b>Check No# :</b>
                    </td>
                    <td align="left" id="chkno" runat="server">
                        <asp:Label ID="lbl_check_no" runat="server" Text=""></asp:Label>
                    </td>
                </tr>
               
                <tr id="cardnumber"  runat="server">
                    <td align="right">
                        <b>Card Number :</b>
                    </td>
                    <td align="left">
                        <asp:Label ID="lblcardnumber" runat="server" Text=""></asp:Label>
                    </td>
                    <td align="right">
                        <b>Transaction Amount :</b>
                    </td>
                    <td align="left">
                        <asp:Label ID="lbltransactionamount" runat="server" Text=""></asp:Label>
                    </td>
                </tr>
                <tr id="totalamount" runat="server">
                    <td align="right">
                        <b>Total Amount :</b>
                    </td>
                    <td align="left">
                        <asp:Label ID="lbltotalamount" runat="server" Text=""></asp:Label>
                    </td>
                </tr>
            </table>
        </div>
        <script type="text/javascript">
            window.print();
        </script>
    </form>
</body>
</html>
