<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddNewComplaintGeneral.aspx.cs"
    Inherits="Licensing.Complaints.AddNewComplaintGeneral" %>

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
        $(document).ready(function () {

            $("#personsearch").show();
            $("#businesssearch").hide();
            $("#personsearchresult").show();
            $("#businesssearchresult").hide();

            $("#<%= rdlcontacttype.ClientID %>").click(function () {


                var selected = $("#<%= rdlcontacttype.ClientID %> input:checked").val();

                if (selected == "0") {
                    $("#personsearch").show();
                    $("#personsearchresult").show();
                    $("#businesssearch").hide();
                    $("#businesssearchresult").hide();
                }
                if (selected == "1") {
                    $("#personsearch").hide();
                    $("#personsearchresult").hide();
                    $("#businesssearch").show();
                    $("#businesssearchresult").show();
                }

            });

        });
    </script>
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
            document.getElementById('<%= hfdpid.ClientID %>').value = keyval;
            var objtype = sa5.resultdata[sender]["object_type"];
            document.getElementById('<%=hfdcmppartid.ClientID%>').value = objtype;
            $('#addnew_pop').dialog({ title: "Add New Participant General", width: '30%' });
            $('#addnew_pop').dialog('open');
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
    </script>
    <script type="text/javascript">


        var dataIn = '';
        var bus = new sagrid();
        bus.url = "../WCFGrid/GridService.svc/Getbusinessearchforcontact";

        bus.primarykeyval = "Person_ID";
        bus.bindid = "grdbusinesssearch";

        bus.objname = "bus";
        bus.aftercall = "Aftercall1";
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
            bus.cols = [new dcol("Business Name", "Business"), new dcol("FEIN", "FEIN"), new dcol("Address", "Address1"), new dcol("County", "County"), new dcol("C S Z", "Address2"), new dcol("Phone", "Phone"), new dcol("Select", "", "", "1", "1", "Select_buslkp", "fa fa-hand-o-up grdicon")];
            bus.data = dataIn;
            bus.process();

            return false;
        }
        function Select_buslkp(sender, keyval) {
            document.getElementById('<%= hfdpid.ClientID %>').value = keyval;
            var objtype = bus.resultdata[sender]["object_type"];
            document.getElementById('<%=hfdcmppartid.ClientID%>').value = objtype;
            $('#addnew_pop').dialog({ title: "Add New Participant General", width: '30%' });
            $('#addnew_pop').dialog('open');
        }

        function Aftercall1() {
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
    <script language="javascript" type="text/javascript">
        function age() {

            if (document.getElementById('<%= txtpersondob.ClientID %>').value != '') {
                var curdate = new Date(document.getElementById('<%= hfdcurdate.ClientID %>').value);
                var dob = new Date(document.getElementById('<%= txtpersondob.ClientID %>').value);
                var dob1 = document.getElementById('<%= txtpersondob.ClientID %>').value;
                var bD = dob1.split('/');
                var bday = parseInt(bD[1]);
                var bmo = (parseInt(bD[0]) - 1);
                var byr = parseInt(bD[2]);
                var byr;
                var age1;
                var now = new Date();
                tday = now.getDate();
                tmo = (now.getMonth());
                tyr = (now.getFullYear());

                if ((tmo > bmo) || (tmo == bmo & tday >= bday))
                { age1 = byr }

                else
                { age1 = byr + 1 }

                //var age = parseInt(curdate.getFullYear() - dob.getFullYear());
                age1 = tyr - age1;

                document.getElementById('<%= txtpersonage.ClientID %>').value = age1;
                document.getElementById('<%= txtpersonage.ClientID %>').readOnly = true;
            }
            else
                document.getElementById('<%= txtpersondob.ClientID %>').focus();

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


        function BusinessClear_search() {
            document.getElementById('<%= txtbusinessname.ClientID %>').value = '';
            document.getElementById('<%= txtownersname.ClientID %>').value = '';
            document.getElementById('<%= txtfein.ClientID %>').value = '';
            document.getElementById('<%= txtdatestarted.ClientID %>').value = '';
            document.getElementById('<%= txtpnumber.ClientID %>').value = '';
            document.getElementById('<%= ddlptype.ClientID %>').value = '-1';
            document.getElementById('<%= txtlicno.ClientID %>').value = '';
            document.getElementById('<%= ddllictype.ClientID %>').value = '-1';
            document.getElementById('<%=txt_address.ClientID%>').value = '';
            document.getElementById('<%= ddlcounty.ClientID %>').value = '-1';
            document.getElementById('<%= ddlstate.ClientID %>').value = '-1';
            document.getElementById('<%=txtemail.ClientID%>').value = '';
            document.getElementById('<%=txt_zip.ClientID%>').value = '';
            document.getElementById('<%= ddllicstatus.ClientID %>').value = '-1';
            document.getElementById('<%=txt_mailorder.ClientID %>').value = '';
            document.getElementById('<%=chkcontrolsub.ClientID%>').checked = false;
            document.getElementById('<%=chkusp795.ClientID%>').checked = false;
            document.getElementById('<%=chkusp797.ClientID%>').checked = false;
            document.getElementById('<%=txt_city.ClientID%>').value = '';
            document.getElementById("grdbusinesssearch").innerHTML = "";
            return false;
        }
    </script>
    <script type="text/javascript">

        function PersonSave_Validation() {
            var errormsg = validateform('frmfld');
            if (errormsg != "") {
                Msgbox(errormsg);
                return false;
            }
            return true;

        }
        function BusinessSave_Validation() {
            var errormsg = validateform('frmfld1');
            if (errormsg != "") {
                Msgbox(errormsg);
                return false;
            }
            return true;

        }
        function PersonClear_Addnew() {
            document.getElementById('<%= txtpersonfname.ClientID %>').value = '';
            document.getElementById('<%= txtpersonmname.ClientID %>').value = '';
            document.getElementById('<%= txtpersonlname.ClientID %>').value = '';
            document.getElementById('<%= ddlpersongender.ClientID %>').value = '-1';
            document.getElementById('<%= txtpersonmaidenname.ClientID %>').value = '';
            document.getElementById('<%= txtpersondob.ClientID %>').value = '';
            document.getElementById('<%= txtpersonssn.ClientID %>').value = '';
            document.getElementById('<%= txtpersonage.ClientID %>').value = '';
            document.getElementById('<%= txtpersonaddress1.ClientID %>').value = '';
            document.getElementById('<%= txtpersonaddress2.ClientID %>').value = '';
            document.getElementById('<%= txtpersoncity.ClientID %>').value = '';
            document.getElementById('<%= ddlpersonstate.ClientID %>').value = '-1';
            document.getElementById('<%= ddlpersoncounty.ClientID %>').value = '-1';
            document.getElementById('<%= txtpersonzip.ClientID %>').value = '';
            document.getElementById('<%= ddlpersonphone.ClientID %>').value = '-1';
            document.getElementById('<%= txtpersonphone.ClientID %>').value = '';
            document.getElementById('<%= ddlpersonaltphone.ClientID %>').value = 'H';
            document.getElementById('<%= txtpersonaltphone.ClientID %>').value = '';
            document.getElementById('<%= ddlpersonmstatus.ClientID %>').value = 'H';
            document.getElementById('<%= txtpersonfax.ClientID %>').value = '';
            document.getElementById('<%= txtpersonemail.ClientID %>').value = '';
            document.getElementById('<%= rdlpersonuscitizen.ClientID %>' + '_0').checked == false;
            document.getElementById('<%= rdlpersonuscitizen.ClientID %>' + '_1').checked == false;
            document.getElementById('<%= ddlpersonsuffix.ClientID %>').value = '-1';
            document.getElementById('<%=txtpersoncitizenexpdate.ClientID%>>').value = '';
            document.getElementById('<%=txtpersoncpenumber.ClientID %>').value = '';
            return false;
        }
        function BusinessClear_Addnew() {
            document.getElementById('<%= txtbusinessname.ClientID %>').value = '';
            document.getElementById('<%= txtbusinessownersname.ClientID %>').value = '';
            document.getElementById('<%= txtbusinessstartdate.ClientID %>').value = '';
            document.getElementById('<%= txtbusinessenddate.ClientID %>').value = '';
            document.getElementById('<%= txtbusinessfein.ClientID %>').value = '';
            document.getElementById('<%= txtbusinessaddress1.ClientID %>').value = '';
            document.getElementById('<%= txtbusinessaddress2.ClientID %>').value = '';
            document.getElementById('<%= txtbusinesscity.ClientID %>').value = '';
            document.getElementById('<%= ddlbusinessstate.ClientID %>').value = '-1';
            document.getElementById('<%= ddlbusinesstype.ClientID %>').value = '-1';
            document.getElementById('<%= ddlbusinessstatus.ClientID %>').value = '-1';
            document.getElementById('<%= ddlbusinesscounty.ClientID %>').value = '-1';
            document.getElementById('<%= txtbusinesszip.ClientID %>').value = '';
            document.getElementById('<%= ddlbusinessphone.ClientID %>').value = 'H';
            document.getElementById('<%= txtbusinessphone.ClientID %>').value = '';
            document.getElementById('<%= ddlbusinessaltphone.ClientID %>').value = 'H';
            document.getElementById('<%= txtbusinessaltphone.ClientID %>').value = '';
            document.getElementById('<%= txtbusinessfax.ClientID %>').value = '';
            document.getElementById('<%= txtbusinessemail.ClientID %>').value = '';
            document.getElementById('<%=txtbusinessdea.ClientID%>>').value = '';
            return false;
        }

        function InsertContact(pid) {
            document.getElementById('<%=hfdpid.ClientID %>').value = pid;
            $(function () {
                $('#addnew_pop').dialog({ title: "Add New Participant General", width: '30%' });
                $('#addnew_pop').dialog('open');
            });
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
            <asp:HiddenField ID="hfdcmpid" runat="server" Value="0" />
            <asp:HiddenField ID="hfdcmpgenid" runat="server" Value="0" />
            <asp:HiddenField ID="hfdcmppartid" runat="server" Value="0" />
            <asp:HiddenField ID="hfdcurdate" runat="server" Value="0" />
            <div style="width: 98%; margin-left: auto; margin-right: auto">
                <div class="body">
                    <table style="width: 100%;" class="spac">
                        <tr>
                            <td align="right" style="width: 50%">Select Type &nbsp;
                            </td>
                            <td align="left">
                                <asp:RadioButtonList ID="rdlcontacttype" runat="server" RepeatDirection="Horizontal">
                                    <asp:ListItem Value="0" Text="Individual" Selected="True"></asp:ListItem>
                                    <asp:ListItem Value="1" Text="Others"></asp:ListItem>
                                </asp:RadioButtonList>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
        <br />
        <div class="cpanel" id="personsearch">
            <div class="head">
                Person Search
            </div>
            <div class="body">
                <table align="center" class="spac">
                    <tr>
                        <td align="right">Last Name
                        </td>
                        <td align="left">
                            <asp:TextBox ID="txt_Lastname" runat="server" placeholder="Last Name"></asp:TextBox>
                        </td>
                        <td align="right">First Name
                        </td>
                        <td align="left">
                            <asp:TextBox ID="txt_Firstname" runat="server" placeholder="First Name"></asp:TextBox>
                        </td>
                        <td align="right">SSN
                        </td>
                        <td align="left">
                            <asp:TextBox ID="txt_ssn" runat="server" class="ssn"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">DOB
                        </td>
                        <td align="left">
                            <asp:TextBox ID="txt_dob" runat="server" class="date"></asp:TextBox>
                        </td>
                        <td align="right">Phone Number
                        </td>
                        <td align="left">
                            <asp:TextBox ID="txt_phonenum" runat="server" class="phone"></asp:TextBox>
                        </td>
                        <td align="right">Phone Type
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
                        <td align="right">License Number
                        </td>
                        <td align="left">
                            <asp:TextBox ID="txt_licnumber" runat="server" placeholder="License Number"></asp:TextBox>
                        </td>
                        <td align="right">License Type
                        </td>
                        <td align="left">
                            <asp:DropDownList ID="ddl_lictype" runat="server" class="dropdown">
                            </asp:DropDownList>
                        </td>
                        <td align="right">License Status
                        </td>
                        <td align="left">
                            <asp:DropDownList ID="ddl_licstatus" runat="server" class="dropdown">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">Address
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
                        <td align="right">County
                        </td>
                        <td align="left">
                            <asp:DropDownList ID="ddl_county" runat="server">
                            </asp:DropDownList>
                        </td>
                       
                    </tr>
                    <tr>
                         <td align="right">State
                        </td>
                        <td align="left">
                            <asp:DropDownList ID="ddl_state" runat="server">
                            </asp:DropDownList>
                        </td>
                        <td align="right">Zip
                        </td>
                        <td align="left">
                            <asp:TextBox ID="txtzip" runat="server" CssClass="zip"></asp:TextBox>
                        </td>
                        <td align="right">Email
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
                            <input type="button" id="btnaddnewperson" value="Add New" class="poptrg" onclick="javascript: return PersonClear_Addnew();"/>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
        <div id="btnaddnewperson_pop" class="popup" style="display: none;">
            <span class="title">Add New Person</span>
            <table align="center" class="spac" id="frmfld">
                <tr>
                    <td align="right">First Name
                    </td>
                    <td align="left">
                        <asp:TextBox ID="txtpersonfname" runat="server" CssClass="required" placeholder="First Name"
                            error="Please enter first name."></asp:TextBox>
                    </td>
                    <td align="right">Middle Name
                    </td>
                    <td align="left">
                        <asp:TextBox ID="txtpersonmname" runat="server" placeholder="Middle Name"></asp:TextBox>
                    </td>
                    <td align="right">Last Name
                    </td>
                    <td align="left">
                        <asp:TextBox ID="txtpersonlname" runat="server" CssClass="required" placeholder="Last Name"
                            error="Please enter last name."></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td align="right">Suffix
                    </td>
                    <td align="left">
                        <asp:DropDownList ID="ddlpersonsuffix" runat="server">
                        </asp:DropDownList>
                    </td>
                    <td align="right">Maiden Name
                    </td>
                    <td align="left">
                        <asp:TextBox ID="txtpersonmaidenname" runat="server" placeholder="Maiden Name"></asp:TextBox>
                    </td>
                    <td align="right">SSN
                    </td>
                    <td align="left">
                        <asp:TextBox ID="txtpersonssn" runat="server" CssClass="ssn" error="Please enter the ssn."></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td align="right">DOB
                    </td>
                    <td align="left">
                        <asp:TextBox ID="txtpersondob" runat="server" class="date" error="Please enter the date of birth."
                            onblur="javascript:age();"></asp:TextBox>
                    </td>
                    <td align="right">Age
                    </td>
                    <td align="left">
                        <asp:TextBox ID="txtpersonage" runat="server" error="Please enter the age."></asp:TextBox>
                    </td>
                    <td align="right">Gender
                    </td>
                    <td align="left">
                        <asp:DropDownList ID="ddlpersongender" runat="server" error="Please select the gender.">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td align="right">Address Type
                    </td>
                    <td align="left">
                        <asp:DropDownList ID="ddlpersonaddresstype" runat="server" error="Please select the address type.">
                            <asp:ListItem>Home</asp:ListItem>
                            <asp:ListItem>Office</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td align="right">Address1
                    </td>
                    <td align="left">
                        <asp:TextBox ID="txtpersonaddress1" runat="server" placeholder="Address"
                            error="Please enter the address1."></asp:TextBox>
                    </td>
                    <td align="right">Address2
                    </td>
                    <td align="left">
                        <asp:TextBox ID="txtpersonaddress2" runat="server" placeholder="Address"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td align="right">City
                    </td>
                    <td align="left">
                        <asp:TextBox ID="txtpersoncity" runat="server" placeholder="City"
                            error="Please enter the city."></asp:TextBox>
                    </td>
                    <td align="right">State
                    </td>
                    <td align="left">
                        <asp:DropDownList ID="ddlpersonstate" runat="server" error="Please select the state.">
                        </asp:DropDownList>
                    </td>
                    <td align="right">County
                    </td>
                    <td align="left">
                        <asp:DropDownList ID="ddlpersoncounty" runat="server" placeholder="First Name"
                            error="Please select the county.">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td align="right">Zip
                    </td>
                    <td align="left">
                        <asp:TextBox ID="txtpersonzip" runat="server" CssClass="zip" placeholder="First Name"
                            error="Please enter the zip."></asp:TextBox>
                    </td>
                    <td align="right">Phone
                    </td>
                    <td align="left">
                        <asp:DropDownList ID="ddlpersonphone" runat="server" Width="30px">
                            <asp:ListItem>H</asp:ListItem>
                            <asp:ListItem>C</asp:ListItem>
                            <asp:ListItem>O</asp:ListItem>
                        </asp:DropDownList>
                        <asp:TextBox ID="txtpersonphone" runat="server" CssClass="phone" Width="110px"
                            error="Please enter the phone number."></asp:TextBox>
                    </td>
                    <td align="right">Alternate Phone
                    </td>
                    <td align="left">
                        <asp:DropDownList ID="ddlpersonaltphone" runat="server" Width="30px">
                            <asp:ListItem>H</asp:ListItem>
                            <asp:ListItem>C</asp:ListItem>
                            <asp:ListItem>O</asp:ListItem>
                        </asp:DropDownList>
                        <asp:TextBox ID="txtpersonaltphone" runat="server" CssClass="phone" Width="110px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td align="right">Marital Status
                    </td>
                    <td align="left">
                        <asp:DropDownList ID="ddlpersonmstatus" runat="server">
                        </asp:DropDownList>
                    </td>
                    <td align="right">Fax
                    </td>
                    <td align="left">
                        <asp:TextBox ID="txtpersonfax" runat="server" CssClass="phone"></asp:TextBox>
                    </td>
                    <td align="right">Email
                    </td>
                    <td align="left">
                        <asp:TextBox ID="txtpersonemail" runat="server" CssClass="email" placeholder="Email"
                            error="Please enter the email."></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td align="right">US Citizen
                    </td>
                    <td align="left">
                        <asp:RadioButtonList ID="rdlpersonuscitizen" runat="server" RepeatDirection="Horizontal">
                            <asp:ListItem>Yes</asp:ListItem>
                            <asp:ListItem>No</asp:ListItem>
                        </asp:RadioButtonList>
                    </td>
                    <td align="right">Citizenship Expiration Date
                    </td>
                    <td align="left">
                        <asp:TextBox ID="txtpersoncitizenexpdate" runat="server" CssClass="date"></asp:TextBox>
                    </td>
                    <td align="right">NABP E-Profile Number
                    </td>
                    <td align="left">
                        <asp:TextBox ID="txtpersoncpenumber" runat="server" placeholder="CPE Number"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                            <td align="right">
                            Ethnicity :
                            </td>
                            <td align="left">
                            <asp:DropDownList ID="ddlethincity" runat="server" ></asp:DropDownList>
                            </td>
                            </tr>
                <tr>
                    <td colspan="6" align="center">
                        <asp:Button ID="btnpersonsave" runat="server" Text="Save" OnClientClick="javascript:return PersonSave_Validation()" OnClick="btnpersonsave_Click" />
                        <asp:Button Text="Clear" ID="btnpersonclear" runat="server" OnClientClick="javascript:return PersonClear_Addnew();" />
                    </td>
                </tr>
            </table>
        </div>
        <div class="cpanel" id="businesssearch">
            <div class="head">
                Business Search
            </div>
            <div class="body">
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
                            <input type="button" id="btnbusinessadd" value="Add New" class="poptrg" onclick="javascript: return BusinessClear_Addnew();"/>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
        <div id="btnbusinessadd_pop" class="popup" style="display: none;">
            <span class="title">Add New Business</span>
            <table align="center" class="spac" id="frmfld1">
                <tr>
                    <td align="right">Business Name
                    </td>
                    <td align="left">
                        <asp:TextBox ID="txtbusiness" runat="server" CssClass="required" placeholder="Business Name"
                            error="Please enter business name."></asp:TextBox>
                    </td>
                    <td align="right">Owners Name(If Diiferent)
                    </td>
                    <td align="left">
                        <asp:TextBox ID="txtbusinessownersname" runat="server" placeholder="Owners Name"></asp:TextBox>
                    </td>
                    <td align="right">FEIN
                    </td>
                    <td align="left">
                        <asp:TextBox ID="txtbusinessfein" runat="server" CssClass="fein" error="Please enter fein number."></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td align="right">Start Date
                    </td>
                    <td align="left">
                        <asp:TextBox ID="txtbusinessstartdate" runat="server" class="date" error="Please enter the start date."></asp:TextBox>
                    </td>
                    <td align="right">End Date
                    </td>
                    <td align="left">
                        <asp:TextBox ID="txtbusinessenddate" runat="server" CssClass="date"></asp:TextBox>
                    </td>
                    <td align="right">Business Type
                    </td>
                    <td align="left">
                        <asp:DropDownList ID="ddlbusinesstype" runat="server">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td align="right">Status
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlbusinessstatus" runat="server">
                            <asp:ListItem Value="-1" Text="Select"></asp:ListItem>
                            <asp:ListItem Value="1" Text="Close"></asp:ListItem>
                            <asp:ListItem Value="2" Text="Open"></asp:ListItem>
                            <asp:ListItem Value="3" Text="Pending"></asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td align="right">Address Type
                    </td>
                    <td align="left">
                        <asp:DropDownList ID="ddlbusinessaddress" runat="server" error="Please select the address type.">
                            <asp:ListItem>Home</asp:ListItem>
                            <asp:ListItem>Office</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td align="right">Address1
                    </td>
                    <td align="left">
                        <asp:TextBox ID="txtbusinessaddress1" runat="server" placeholder="Address"
                            error="Please enter the address1."></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td align="right">Address2
                    </td>
                    <td align="left">
                        <asp:TextBox ID="txtbusinessaddress2" runat="server" placeholder="Address"></asp:TextBox>
                    </td>
                    <td align="right">City
                    </td>
                    <td align="left">
                        <asp:TextBox ID="txtbusinesscity" runat="server" placeholder="City"
                            error="Please enter the city."></asp:TextBox>
                    </td>
                    <td align="right">State
                    </td>
                    <td align="left">
                        <asp:DropDownList ID="ddlbusinessstate" runat="server" error="Please select the state.">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td align="right">County
                    </td>
                    <td align="left">
                        <asp:DropDownList ID="ddlbusinesscounty" runat="server" placeholder="First Name"
                            error="Please select the county.">
                        </asp:DropDownList>
                    </td>
                    <td align="right">Zip
                    </td>
                    <td align="left">
                        <asp:TextBox ID="txtbusinesszip" runat="server" CssClass="zip" placeholder="First Name"
                            error="Please enter the zip."></asp:TextBox>
                    </td>
                    <td align="right">Phone
                    </td>
                    <td align="left">
                        <asp:DropDownList ID="ddlbusinessphone" runat="server" Width="30px">
                            <asp:ListItem>H</asp:ListItem>
                            <asp:ListItem>C</asp:ListItem>
                            <asp:ListItem>O</asp:ListItem>
                        </asp:DropDownList>
                        <asp:TextBox ID="txtbusinessphone" runat="server" CssClass="phone" Width="110px"
                            error="Please enter the phone number."></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td align="right">Alternate Phone
                    </td>
                    <td align="left">
                        <asp:DropDownList ID="ddlbusinessaltphone" runat="server" Width="30px">
                            <asp:ListItem>H</asp:ListItem>
                            <asp:ListItem>C</asp:ListItem>
                            <asp:ListItem>O</asp:ListItem>
                        </asp:DropDownList>
                        <asp:TextBox ID="txtbusinessaltphone" runat="server" CssClass="phone" Width="110px"></asp:TextBox>
                    </td>
                    <td align="right">Fax
                    </td>
                    <td align="left">
                        <asp:TextBox ID="txtbusinessfax" runat="server" CssClass="phone"></asp:TextBox>
                    </td>
                    <td align="right">DEA Number
                    </td>
                    <td align="left">
                        <asp:TextBox ID="txtbusinessdea" runat="server" placeholder="DEA Number"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td align="right">Email
                    </td>
                    <td align="left">
                        <asp:TextBox ID="txtbusinessemail" runat="server" CssClass="email" placeholder="Email"
                            error="Please enter the email."></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td colspan="6" align="center">
                        <asp:Button ID="btnbusinesssave" runat="server" Text="Save" OnClientClick="javascript:return BusinessSave_Validation()" OnClick="btnbusinesssave_Click" />
                        <asp:Button Text="Clear" ID="btnbusinessclear" runat="server" OnClientClick="javascript:return BusinessClear_Addnew();" />
                    </td>
                </tr>
            </table>
        </div>
        <div class="cpanel" id="personsearchresult">
            <div class="head">
                Person Result
            </div>
            <div class="body">
                <div id="grdpersonsearch">
                </div>
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
        <div class="popup" id="addnew_pop">
            <div class="body">
                <table class="spac" align="center">
                    <tr>
                        <td align="right" class="Labels">Role :
                        </td>
                        <td align="left">
                            <asp:DropDownList ID="ddlparticipantRole" runat="server" CssClass="required" error="Please select role.">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" align="center">
                            <asp:Button ID="btnsubmit" runat="server" Text="Submit" OnClick="btnsubmit_Click" />&nbsp;
                        <asp:Button ID="btnclear" runat="server" Text="Clear" />
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </form>
</body>
</html>
