<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HasPharmacyEmp.aspx.cs"
    Inherits="Licensing.PersonLicensing.HasPharmacyEmp" %>

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
        var sa5 = new sagrid();
        sa5.url = "../WCFGrid/GridService.svc/Getpersonsearchforcontact";

        sa5.primarykeyval = "Person_ID";
        sa5.bindid = "grdpersonsearch";
       
        sa5.objname = "sa5";
        sa5.aftercall = "Aftercall";
        function bindpersonsearch() {

            dataIn = "";
            var lastname = document.getElementById('<%= txt_Lastname.ClientID %>').value;
            dataIn = dataIn + '"lname":"' + lastname + '",'
            var firstname = document.getElementById('<%= txt_Firstname.ClientID %>').value;
            dataIn = dataIn + '"fname":"' + firstname + '",'
            var ssn = document.getElementById('<%= txt_ssn.ClientID %>').value;
            dataIn = dataIn + '"ssn":"' + ssn + '",'
            var dob = document.getElementById('<%= txt_dob.ClientID %>').value;
            dataIn = dataIn + '"dob":"' + dob + '",'
            var pnumber = document.getElementById('<%= txt_phonenum.ClientID %>').value;
            dataIn = dataIn + '"pnumber":"' + pnumber + '",'
            var phtype = document.getElementById('<%= ddl_Phonetype.ClientID %>');
            var ptype = phtype.options[phtype.selectedIndex].text;
            dataIn = dataIn + '"ptype":"' + ptype + '",'
            var licnum = document.getElementById('<%= txt_licnumber.ClientID %>').value;
            dataIn = dataIn + '"licno":"' + licnum + '",'
            var lictype = document.getElementById('<%= ddl_lictype.ClientID %>').value;
            dataIn = dataIn + '"lictype":"' + lictype + '",'
            var licstatus = document.getElementById('<%= ddl_licstatus.ClientID %>').value;
            dataIn = dataIn + '"licstatus":"' + licstatus + '",'
            var address = document.getElementById('<%= txtaddress.ClientID %>').value;
            dataIn = dataIn + '"address":"' + address + '",'
            var county = document.getElementById('<%= ddl_county.ClientID %>').value;
            dataIn = dataIn + '"county":"' + county + '",'
            var state = document.getElementById('<%= ddl_state.ClientID %>').value;
            dataIn = dataIn + '"state":"' + state + '",'
            var zip = document.getElementById('<%= txtzip.ClientID %>').value;
            dataIn = dataIn + '"zip":"' + zip + '",'
            var email = document.getElementById('<%= txt_email.ClientID %>').value;
            dataIn = dataIn + '"email":"' + email + '",'
            var cs = document.getElementById('<%=chkcontolledsub.ClientID %>').checked;
            dataIn = dataIn + '"csub":"' + cs + '",'
            var city = document.getElementById('<%=txtcity.ClientID%>').value;
            dataIn = dataIn + '"city":"' + city + '"'
            dataIn = dataIn + ',"resptype":"1"';

            sa5.cols = [new dcol("Name", "Full_Name"), new dcol("SSN", "SSN"), new dcol("Address", "Address1"), new dcol("County", "Address2"), new dcol("C S Z", "State"), new dcol("Phone", "Phone"), new dcol("Select", "", "", "1", "1", "Select_lkp", "fa fa-hand-o-up grdicon")];
            sa5.data = dataIn;
            sa5.process();

            return false;
        }
        function Select_lkp(sender, keyval) {
            document.getElementById('<%= hfdrelid.ClientID %>').value = keyval;
            document.getElementById('<%= btnsumbit.ClientID %>').click();
        }

        function Aftercall() {
            var trs = sa5.resultdata;
            if (trs.length > 0) {
                return true;
            }
            else {
                altbox("No results found.");
                document.getElementById("grdpersonsearch").innerHTML = "";
                return false;
            }
        }
    </script>
    <script type="text/javascript">

        function Search_Validation() {

            var err = "";
            var srch_count = 0;
            if (Value_Checked('<%= txt_Firstname.ClientID %>', "1") != "1")
                srch_count = srch_count + 1;
            if (Value_Checked('<%= txt_Lastname.ClientID %>', "1") != "1")
                srch_count = srch_count + 1;
            if (Value_Checked('<%= txt_ssn.ClientID %>', "1") != "1")
                srch_count = srch_count + 1;
            if (Value_Checked('<%= txt_dob.ClientID %>', "1") != "1")
                srch_count = srch_count + 1;
            if (Value_Checked('<%= txt_phonenum.ClientID %>', "1") != "1")
                srch_count = srch_count + 1;
            if (Value_Checked_Drp('<%=ddl_Phonetype.ClientID%>', "1") != "1")
                srch_count = srch_count + 1;
            if (Value_Checked_Drp('<%=ddl_lictype.ClientID%>', "1") != "1")
                srch_count = srch_count + 1;
            if (Value_Checked_Drp('<%=ddl_licstatus.ClientID%>', "1") != "1")
                srch_count = srch_count + 1;
            if (Value_Checked('<%= txtaddress.ClientID %>', "1") != "1")
                srch_count = srch_count + 1;
            if (Value_Checked_Drp('<%=ddl_county.ClientID%>', "1") != "1")
                srch_count = srch_count + 1;
            if (Value_Checked_Drp('<%=ddl_state.ClientID%>', "1") != "1")
                srch_count = srch_count + 1;
            if (Value_Checked('<%= txtzip.ClientID %>', "1") != "1")
                srch_count = srch_count + 1;
            if (Value_Checked('<%= txt_email.ClientID %>', "1") != "1")
                srch_count = srch_count + 1;
            if (Value_Checked('<%= txtcity.ClientID %>', "1") != "1")
                srch_count = srch_count + 1;
            if (Value_Checked_checkbox('<%=chkcontolledsub.ClientID %>', "1") != "1")
                srch_count = srch_count + 1;
            if (document.getElementById('<%=  txt_licnumber.ClientID %>') != null) {
                if (Value_Checked('<%=  txt_licnumber.ClientID %>', "1") != "1")
                    srch_count = srch_count + 1;
            }
            if (srch_count == 0) {
                err = err + "Please select atleast one criteria for search.\r\n";
            }
            if (err != "") {
                altbox(err);
                return false;
            }
            bindpersonsearch();
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
        function Clear_search() {
            document.getElementById('<%= txt_Lastname.ClientID %>').value = '';
            document.getElementById('<%= txt_Firstname.ClientID %>').value = '';
            document.getElementById('<%= txt_ssn.ClientID %>').value = '';
            document.getElementById('<%= txt_dob.ClientID %>').value = '';
            document.getElementById('<%= txt_phonenum.ClientID %>').value = '';
            document.getElementById('<%= ddl_Phonetype.ClientID %>').value = '-1';
            document.getElementById('<%= txt_licnumber.ClientID %>').value = '';
            document.getElementById('<%= ddl_lictype.ClientID %>').value = '-1';
            document.getElementById('<%= ddl_licstatus.ClientID %>').value = '-1';
            document.getElementById('<%=txtaddress.ClientID%>').value = '';
            document.getElementById('<%= ddl_county.ClientID %>').value = '-1';
            document.getElementById('<%= ddl_state.ClientID %>').value = '-1';
            document.getElementById('<%= txt_email.ClientID %>').value = '';
            document.getElementById('<%=txtzip.ClientID%>').value = '';
            document.getElementById('<%=chkcontolledsub.ClientID%>').checked = false;
            document.getElementById('<%=txtcity.ClientID%>').value = "";
            document.getElementById("grdpersonsearch").innerHTML = "";
            return false;
        }
        function afterpost() {
            parent.aftersave();
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:HiddenField ID="hfdrelid" Value="0" runat="server" />
        <asp:HiddenField ID="hfdpid" Value="0" runat="server" />
        <asp:HiddenField ID="haspid" Value="0" runat="server" />
        <asp:Button ID="btnsumbit" runat="server" Style="display: none" OnClick="btnsubmit_click" />
        <div class="cpanel" id="personsearch">
            <div class="head">
                Person Search
            </div>
            <div class="body">
                <asp:Panel ID="panel1" runat="server" DefaultButton="btnsearch">
                    <table align="center" class="spac">
                    <tr>
                        <td align="right">
                            Last Name
                        </td>
                        <td align="left">
                            <asp:TextBox ID="txt_Lastname" runat="server" placeholder="Last Name"></asp:TextBox>
                        </td>
                        <td align="right">
                            First Name
                        </td>
                        <td align="left">
                            <asp:TextBox ID="txt_Firstname" runat="server" placeholder="First Name"></asp:TextBox>
                        </td>
                        <td align="right">
                            SSN
                        </td>
                        <td align="left">
                            <asp:TextBox ID="txt_ssn" runat="server" class="ssn"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            DOB
                        </td>
                        <td align="left">
                            <asp:TextBox ID="txt_dob" runat="server" class="date"></asp:TextBox>
                        </td>
                        <td align="right">
                            Phone Number
                        </td>
                        <td align="left">
                            <asp:TextBox ID="txt_phonenum" runat="server" class="phone"></asp:TextBox>
                        </td>
                        <td align="right">
                            Phone Type
                        </td>
                        <td align="left">
                            <asp:DropDownList ID="ddl_Phonetype" runat="server" class="dropdown">
                                <asp:ListItem Value="-1">Select Phone Type</asp:ListItem>
                                <asp:ListItem>Office</asp:ListItem>
                                <asp:ListItem>Cell</asp:ListItem>
                                <asp:ListItem>Home</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            License Number
                        </td>
                        <td align="left">
                            <asp:TextBox ID="txt_licnumber" runat="server" placeholder="License Number"></asp:TextBox>
                        </td>
                        <td align="right">
                            License Type
                        </td>
                        <td align="left">
                            <asp:DropDownList ID="ddl_lictype" runat="server" class="dropdown">
                            </asp:DropDownList>
                        </td>
                        <td align="right">
                            License Status
                        </td>
                        <td align="left">
                            <asp:DropDownList ID="ddl_licstatus" runat="server" class="dropdown">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            Address
                        </td>
                        <td align="left">
                            <asp:TextBox ID="txtaddress" runat="server" placeholder="Address"></asp:TextBox>
                        </td>
                        <td align="right">
                            City
                        </td>
                        <td align="left">
                            <asp:TextBox ID="txtcity" runat="server" placeholder="City"></asp:TextBox>
                        </td>
                        <td align="right">
                            County
                        </td>
                        <td align="left">
                            <asp:DropDownList ID="ddl_county" runat="server">
                            </asp:DropDownList>
                        </td>
                     
                    </tr>
                    <tr>
                           <td align="right">
                            State
                        </td>
                        <td align="left">
                            <asp:DropDownList ID="ddl_state" runat="server">
                            </asp:DropDownList>
                        </td>
                        <td align="right">
                            Zip
                        </td>
                        <td align="left">
                            <asp:TextBox ID="txtzip" runat="server" CssClass="zip"></asp:TextBox>
                        </td>
                        <td align="right">
                            Email
                        </td>
                        <td align="left">
                            <asp:TextBox ID="txt_email" runat="server" placeholder="Email"></asp:TextBox>
                        </td>
                        
                    </tr>
                    <tr>
                         <td align="right" colspan="2">
                            <asp:CheckBox ID="chkcontolledsub" runat="server" Text="&nbsp;&nbsp;Controlled Substance" />
                            </td>
                    </tr>
                    <tr>
                        <td colspan="6" align="center" height="50px;">
                            <asp:Button ID="btnsearch" runat="server" Text="Search" OnClientClick="javascript:return Search_Validation();" />
                            <asp:Button ID="btnsearchclear" runat="server" Text="Clear" OnClientClick="javascript:return Clear_search();" />
                        </td>
                    </tr>
                </table>
                </asp:Panel>
            </div>
        </div>
        <div class="cpanel">
            <div class="head">
                Person Search Result</div>
            <div class="body">
                <div id="grdpersonsearch">
                </div>
            </div>
        </div>
    </div>
    </form>
</body>
</html>
