<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Showcrt.aspx.cs" Inherits="Licensing.Prints.Showcrt" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <link href="../Styles/product.css" rel="stylesheet" type="text/css" />
    <link href="../Styles/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
    <script src="../Scripts/pdfobject.js" type="text/javascript"></script>
    <script language="javascript">

        function printopen(ctl) {
            var refid = document.getElementById('<%= hfdid.ClientID %>').value;
            var path = document.getElementById('<%= ddllst.ClientID %>').value;
             var selid = ctl.value;
             if (selid == "-1") {
                 window.open("../Prints/labelPrinting.aspx?refid=" + refid);

                 return false;
             }
             if (ctl.value == "NEW BUSINESS CERTIFICATE ALBOP") {
                 var surl = './print_cert_new.aspx?pname=' + path + '&refid=' + refid + '&uid=31';
             }
             else {
                 var surl = './prnt_cert.aspx?pname=' + selid + '&refid=' + refid;
             }
             //var surl = './prnt_cert.aspx?pname=' + selid + '&refid=' + refid;


             var myParams = {
                 url: surl, pdfOpenParams: {
                     navpanes: 1,
                     statusbar: 1,
                     zoom: '100%',
                     pagemode: "thumbs"
                 }
             };
             var success = new PDFObject(myParams).embed("pdf");
             if (success == false)
                 window.open(surl);



         }
    </script>
    <style>
        #prnt {
            top: 5px;
            right: 10px;
            position: fixed;
        }

        .divround {
            margin-top: -8px;
            border-radius: 15px;
            border: solid 1px #7A7A7A;
            min-height: 200px;
            background: #ffffff; /* Old browsers */
            background: -moz-linear-gradient(top, #ffffff 0%, #e5e5e5 100%); /* FF3.6+ */
            background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,#ffffff), color-stop(100%,#e5e5e5)); /* Chrome,Safari4+ */
            background: -webkit-linear-gradient(top, #ffffff 0%,#e5e5e5 100%); /* Chrome10+,Safari5.1+ */
            background: -o-linear-gradient(top, #ffffff 0%,#e5e5e5 100%); /* Opera 11.10+ */
            background: -ms-linear-gradient(top, #ffffff 0%,#e5e5e5 100%); /* IE10+ */
            background: linear-gradient(to bottom, #ffffff 0%,#e5e5e5 100%); /* W3C */
        }
    </style>
</head>
<body style="background: transparent !important">
    <form id="form1" runat="server">
        <asp:HiddenField ID="hfdid" runat="server" Value="0" />
        <div id="prnt">
            <table>
                <tr>

                    <td></td>
                    <td>&nbsp;
    
                    </td>

                </tr>
            </table>
        </div>
        <table width="100%" cellpadding="0" cellspacing="0" border="0">
            <tr>
                <td width="20%">
                    <asp:ListBox ID="ddllst" runat="server" Height="480" Width="100%" onChange="printopen(this)"></asp:ListBox>

                </td>
                <td width="100%" style="padding-top: 5px">
                    <div class="divround">
                        <div id="pdf" style="height: 500px"></div>
                    </div>
                </td>
            </tr>
        </table>
    </form>
</body>

</html>
