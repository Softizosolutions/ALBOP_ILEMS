<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddNewEmployer.aspx.cs" Inherits="Licensing.PersonLicensing.AddNewEmployer" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no'
        name='viewport' />
    <link href="../bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="../Styles/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
    <link href="../Styles/AdminLTE.min.css" rel="stylesheet" type="text/css" />
    <link href="../Styles/skin-blue.min.css" rel="stylesheet" type="text/css" />
    <link href="../Styles/jquery-ui.css" rel="stylesheet" type="text/css" />
    <link href="../Styles/product.css" rel="stylesheet" type="text/css" />
    <script src="../bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
    <script src="../Scripts/jquery.js" type="text/javascript"></script>
    <script src="../Scripts/jquery-ui.min.js" type="text/javascript"></script>
    <script src="../Scripts/jquery.maskedinput.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="../Scripts/DemoScript.js"></script>
    <script src="../WCFGrid/FileSaver.js" type="text/javascript"></script>
    <script src="../WCFGrid/grd.js" type="text/javascript"></script>
    <script src="../WCFGrid/jspdf.js" type="text/javascript"></script>
    <script src="../WCFGrid/jspdf.plugin.cell.js" type="text/javascript"></script>
    <script src="../WCFGrid/jspdf.plugin.table.js" type="text/javascript"></script>
    <script src="../WCFGrid/pdfgenrate.js" type="text/javascript"></script>
    <script src="../Scripts/app.js" type="text/javascript"></script>
    <title></title>

    <script type="text/javascript">


        var dataIn = '';
        var bus = new sagrid();
        bus.url = "../WCFGrid/GridService.svc/Getbusinessearchforcontact";

        bus.primarykeyval = "Person_ID";
        bus.bindid = "grdbusinesssearch";
       
        bus.objname = "bus";
        bus.aftercall = "Aftercall";
        function bindbusinesssearch() {

            dataIn = "";
            var lastname = document.getElementById('<%= txtbusinessname.ClientID %>').value;
            dataIn = dataIn + '"lname":"' + lastname + '",'
            var firstname = document.getElementById('<%= txtownersname.ClientID %>').value;
            dataIn = dataIn + '"fname":"' + firstname + '",'
            var ssn = document.getElementById('<%= txtfein.ClientID %>').value;
            dataIn = dataIn + '"ssn":"' + ssn + '",'
            var dob = document.getElementById('<%= txtdatestarted.ClientID %>').value;
            dataIn = dataIn + '"dob":"' + dob + '",'
            var pnumber = document.getElementById('<%= txtpnumber.ClientID %>').value;
            dataIn = dataIn + '"pnumber":"' + pnumber + '",'
            var phtype = document.getElementById('<%= ddlptype.ClientID %>');
            var ptype = phtype.options[phtype.selectedIndex].text;
            dataIn = dataIn + '"ptype":"' + ptype + '",'
            var licnum = document.getElementById('<%= txtlicno.ClientID %>').value;
            dataIn = dataIn + '"licno":"' + licnum + '",'
            var lictype = document.getElementById('<%= ddllictype.ClientID %>').value;
            dataIn = dataIn + '"lictype":"' + lictype + '",'
            var licstatus = document.getElementById('<%= ddllicstatus.ClientID %>').value;
            dataIn = dataIn + '"licstatus":"' + licstatus + '",'
            var address = document.getElementById('<%= txt_address.ClientID %>').value;
            dataIn = dataIn + '"address":"' + address + '",'
            var city = document.getElementById('<%= txt_city.ClientID %>').value;
            dataIn = dataIn + '"city":"' + city + '",'
            var county = document.getElementById('<%= ddlcounty.ClientID %>').value;
            dataIn = dataIn + '"county":"' + county + '",'
            var state = document.getElementById('<%= ddlstate.ClientID %>').value;
            dataIn = dataIn + '"state":"' + state + '",'
            var zip = document.getElementById('<%= txt_zip.ClientID %>').value;
            dataIn = dataIn + '"zip":"' + zip + '",'
            var email = document.getElementById('<%= txtemail.ClientID %>').value;
            dataIn = dataIn + '"email":"' + email + '",'
            var cert = document.getElementById('<%= txt_mailorder.ClientID %>').value;
            dataIn = dataIn + '"cert":"' + cert + '",'
            var cs = document.getElementById('<%=chkcontrolsub.ClientID %>').checked;
            dataIn = dataIn + '"csub":"' + cs + '",'
            var u797 = document.getElementById('<%=chkusp797.ClientID %>').checked;
            if (u797 == true)
                dataIn = dataIn + '"usp797":"' + 1 + '",'
            else
                dataIn = dataIn + '"usp797":"' + ' ' + '",'

            var u795 = document.getElementById('<%=chkusp795.ClientID %>').checked;
            if (u795 == true)
                dataIn = dataIn + '"usp795":"' + 1 + '"'
            else
                dataIn = dataIn + '"usp795":"' + ' ' + '"'
            dataIn = dataIn + ',"resptype":"1"';
          
            bus.cols = [new dcol("Business Name", "Business"), new dcol("FEIN", "FEIN"), new dcol("Address", "Address1"), new dcol("County", "County"), new dcol("C S Z", "Address2"), new dcol("Phone", "Phone"), new dcol("Select", "", "", "1", "1", "Select_lkp", "fa fa-hand-o-up grdicon")];
            bus.data = dataIn;
            bus.process();

            return false;
        }
        function Select_lkp(sender, keyval) {
            document.getElementById('<%= hfdpid.ClientID %>').value = keyval;
            document.getElementById('<%= btnsumbit.ClientID %>').click();
        }

        function Aftercall() {
            var trs = bus.resultdata;
            if (trs.length > 0) {
                return true;
            }
            else {
                altbox("No results found.");
                document.getElementById("grdbusinesssearch").innerHTML = "";
                return false;
            }
        }
    </script>
    <script type="text/javascript">

        function BusinessSearch_Validation() {

            var err = "";
            var srch_count = 0;
            if (Value_Checked('<%= txtbusinessname.ClientID %>', "1") != "1")
                srch_count = srch_count + 1;
            if (Value_Checked('<%= txtownersname.ClientID %>', "1") != "1")
                srch_count = srch_count + 1;
            if (Value_Checked('<%= txtfein.ClientID %>', "1") != "1")
                srch_count = srch_count + 1;
            if (Value_Checked('<%= txtdatestarted.ClientID %>', "1") != "1")
                srch_count = srch_count + 1;
            if (Value_Checked('<%= txtpnumber.ClientID %>', "1") != "1")
                srch_count = srch_count + 1;
            if (Value_Checked_Drp('<%=ddlptype.ClientID%>', "1") != "1")
                srch_count = srch_count + 1;
            if (Value_Checked_Drp('<%=ddllictype.ClientID%>', "1") != "1")
                srch_count = srch_count + 1;
            if (Value_Checked_Drp('<%=ddllicstatus.ClientID%>', "1") != "1")
                srch_count = srch_count + 1;
            if (Value_Checked('<%= txt_address.ClientID %>', "1") != "1")
                srch_count = srch_count + 1;
            if (Value_Checked('<%= txt_city.ClientID %>', "1") != "1")
                srch_count = srch_count + 1;
            if (Value_Checked_Drp('<%=ddlcounty.ClientID%>', "1") != "1")
                srch_count = srch_count + 1;
            if (Value_Checked_Drp('<%=ddlstate.ClientID%>', "1") != "1")
                srch_count = srch_count + 1;
            if (Value_Checked('<%= txt_zip.ClientID %>', "1") != "1")
                srch_count = srch_count + 1;
            if (Value_Checked('<%=txtemail.ClientID %>', "1") != "1")
                srch_count = srch_count + 1;
            if (Value_Checked('<%=txt_mailorder.ClientID %>', "1") != "1")
                srch_count = srch_count + 1;
            if (Value_Checked_checkbox('<%=chkcontrolsub.ClientID %>', "1") != "1")
                srch_count = srch_count + 1;
            if (Value_Checked_checkbox('<%=chkusp797.ClientID %>', "1") != "1")
                srch_count = srch_count + 1;
            if (Value_Checked_checkbox('<%=chkusp795.ClientID %>', "1") != "1")
                srch_count = srch_count + 1;
            if (document.getElementById('<%=  txtlicno.ClientID %>') != null) {
                if (Value_Checked('<%=  txtlicno.ClientID %>', "1") != "1")
                    srch_count = srch_count + 1;
            }
            if (srch_count == 0)
                err = err + "Please select atleast one criteria for search.\r\n";
            if (err != "") {
                altbox(err);
                return false;
            }
            bindbusinesssearch();
            return false;
        }
        function Value_Checked(Ctr_Name, Error_Message) {
            if (document.getElementById(Ctr_Name).value.trim() == "") {

                return Error_Message;
            }
            return "";
        }
        function Value_Checked_Drp(Ctr_Name, Error_Message) {
            if (document.getElementById(Ctr_Name).value == "-1") {

                return Error_Message;
            }
            return "";
        }
        function Value_Checked_checkbox(Ctr_Name, Error_Message) {
            if (document.getElementById(Ctr_Name).checked == false) {
                return Error_Message;
            }
        }
        function BusinessClear_search() {
            document.getElementById('<%= txtbusinessname.ClientID %>').value = '';
            document.getElementById('<%= txtownersname.ClientID %>').value = '';
            document.getElementById('<%= txtfein.ClientID %>').value = '';
            document.getElementById('<%= txtdatestarted.ClientID %>').value = '';
            document.getElementById('<%= txtpnumber.ClientID %>').value = '';
            document.getElementById('<%= ddlptype.ClientID %>').value = '-1';
            document.getElementById('<%= txtlicno.ClientID %>').value = '';
            document.getElementById('<%= ddllictype.ClientID %>').value = '-1';
            document.getElementById('<%= ddllicstatus.ClientID %>').value = '-1';
            document.getElementById('<%=txt_address.ClientID%>').value = '';
            document.getElementById('<%= ddlcounty.ClientID %>').value = '-1';
            document.getElementById('<%= ddlstate.ClientID %>').value = '-1';
            document.getElementById('<%=txtemail.ClientID%>').value = '';
            document.getElementById('<%=txt_zip.ClientID%>').value = '';
            document.getElementById('<%=txt_mailorder.ClientID %>').value = '';
            document.getElementById('<%=chkcontrolsub.ClientID%>').checked = false;
            document.getElementById('<%=chkusp795.ClientID%>').checked = false;
            document.getElementById('<%=chkusp797.ClientID%>').checked = false;
            document.getElementById('<%=txt_city.ClientID%>').value = '';
            document.getElementById("grdbusinesssearch").innerHTML = "";
            return false;
        }
        function afterpost(msg) {
            parent.aftersave();
            altbox(msg);
        }

    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:HiddenField ID="hfdpid" runat="server" Value="0" />
            <asp:HiddenField ID="hfdrelid" runat="server" Value="0" />
            <asp:Button ID="btnsumbit" runat="server" Style="display: none" OnClick="btnsubmit_click" />
        </div>
        <br />

        <div class="cpanel" id="businesssearch">
            <div class="head">
                Business Search
            </div>
            <div class="body">
                <asp:Panel ID="panle1" runat="server" DefaultButton="Button1">
                    <table align="center" class="spac">
                    <tr>
                        <td align="right">Business Name
                        </td>
                        <td align="left">
                            <asp:TextBox ID="txtbusinessname" runat="server" placeholder="Business Name"></asp:TextBox>
                        </td>
                        <td align="right">Owners Name
                        </td>
                        <td align="left">
                            <asp:TextBox ID="txtownersname" runat="server" placeholder="Owners Name"></asp:TextBox>
                        </td>
                        <td align="right">FEIN
                        </td>
                        <td align="left">
                            <asp:TextBox ID="txtfein" runat="server" CssClass="fein"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">Date Started
                        </td>
                        <td align="left">
                            <asp:TextBox ID="txtdatestarted" runat="server" class="date"></asp:TextBox>
                        </td>
                        <td align="right">Phone Number
                        </td>
                        <td align="left">
                            <asp:TextBox ID="txtpnumber" runat="server" class="phone"></asp:TextBox>
                        </td>
                        <td align="right">Phone Type
                        </td>
                        <td align="left">
                            <asp:DropDownList ID="ddlptype" runat="server" class="dropdown">
                                <asp:ListItem Value="-1">Select Phone Type</asp:ListItem>
                                <asp:ListItem>Office</asp:ListItem>
                                <asp:ListItem>Cell</asp:ListItem>
                                <asp:ListItem>Home</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">License Number
                        </td>
                        <td align="left">
                            <asp:TextBox ID="txtlicno" runat="server" placeholder="License Number"></asp:TextBox>
                        </td>
                        <td align="right">License Type
                        </td>
                        <td align="left">
                            <asp:DropDownList ID="ddllictype" runat="server" class="dropdown">
                            </asp:DropDownList>
                        </td>
                        <td align="right">License Status
                        </td>
                        <td align="left">
                            <asp:DropDownList ID="ddllicstatus" runat="server" class="dropdown">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">Address
                        </td>
                        <td align="left">
                            <asp:TextBox ID="txt_address" runat="server" placeholder="Address"></asp:TextBox>
                        </td>
                        <td align="right">
                            City
                        </td>
                        <td align="left">
                            <asp:TextBox ID="txt_city" runat="server" placeholder="City"></asp:TextBox>
                        </td>
                        <td align="right">County
                        </td>
                        <td align="left">
                            <asp:DropDownList ID="ddlcounty" runat="server">
                            </asp:DropDownList>
                        </td>
                       
                    </tr>
                    <tr>
                         <td align="right">State
                        </td>
                        <td align="left">
                            <asp:DropDownList ID="ddlstate" runat="server">
                            </asp:DropDownList>
                        </td>
                        <td align="right">Zip
                        </td>
                        <td align="left">
                            <asp:TextBox ID="txt_zip" runat="server" CssClass="zip"></asp:TextBox>
                        </td>
                        <td align="right">Email
                        </td>
                        <td align="left">
                            <asp:TextBox ID="txtemail" runat="server" placeholder="Email"></asp:TextBox>
                        </td>
                     
                    </tr>
                    <tr>
                           <td align="right">Mail Order Number
                        </td>
                        <td align="left">
                            <asp:TextBox ID="txt_mailorder" runat="server" placeholder="Mail Order Number"></asp:TextBox>
                        </td>
                        <td align="right" colspan="2">
                            <asp:CheckBox ID="chkcontrolsub" runat="server" Text="&nbsp;&nbsp;Controlled Substance" />
                        </td>
                        <td align="center" colspan="2">
                            <asp:CheckBox ID="chkusp797" runat="server" Text="Sterile Compounding" />
                        </td>
                       
                    </tr>
                    <tr>
                         <td align="center" colspan="2">
                            <asp:CheckBox ID="chkusp795" runat="server" Text="Non-Sterile Compounding" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="6" align="center" height="50px;">
                            <asp:Button ID="Button1" runat="server" Text="Search" OnClientClick="javascript:return BusinessSearch_Validation();" />
                            <asp:Button ID="Button2" runat="server" Text="Clear" OnClientClick="javascript:return BusinessClear_search();" />
                        </td>
                    </tr>
                </table>
                </asp:Panel>
            </div>
        </div>

        <div class="cpanel" id="businesssearchresult">
            <div class="head">
                Business Result
            </div>
            <div class="body">
                <div id="grdbusinesssearch">
                </div>
            </div>
        </div>

    </form>
</body>
</html>
