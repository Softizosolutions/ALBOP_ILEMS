<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EditDemographiceNew_Person.aspx.cs" Inherits="Licensing.PersonLicensing.EditDemographiceNew_Person" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport' />
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

    <script language="javascript">


        function popup() {
            $(function () { $('#btnnew_pop').dialog({ title: "Reason for Removing" }); $('#btnnew_pop').dialog("open"); });

        }

    </script>

    <script language="javascript">
        var us = "0", lawful = "0";
        function lawfulchange1(val) {
            if (val == 1 && lawful == "1") {
                us = '1';
                document.getElementById('lawyestr').style.display = 'none';
                document.getElementById('lawnotr').style.display = 'none';
            }
            else {
                us = '0';
                document.getElementById('lawyestr').style.display = 'none';
                document.getElementById('lawnotr').style.display = 'block';
            }
        }
        function lawfulchange(val) {
            lawful = val;
            if (val == 1) {
                lawfulchange1(us);
                document.getElementById('lawvertr').style.display = 'block';
                document.getElementById('lawusertr').style.display = 'block';
            }
            else {
                document.getElementById('lawvertr').style.display = 'none';
                document.getElementById('lawyestr').style.display = 'none';
                document.getElementById('lawusertr').style.display = 'none';
                document.getElementById('lawnotr').style.display = 'none';
            }
        }
    </script>
    <script language="javascript" type="text/javascript">

        function age() {

            if (document.getElementById('<%= txt_dob.ClientID %>').value != '') {
                var curdate = new Date(document.getElementById('<%= hfdcurdate.ClientID %>').value);
                var dob = new Date(document.getElementById('<%= txt_dob.ClientID %>').value);
                var dob1 = document.getElementById('<%= txt_dob.ClientID %>').value;
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

                document.getElementById('<%= txt_age.ClientID %>').value = age1;
                document.getElementById('<%= txt_age.ClientID %>').readOnly = true;
            }

        }

    </script>

    <script>
        var prvid = 0;
        function show(ctl, tid) {

            $('.dtab').find('li').removeClass('li_active');
            $(ctl).addClass('li_active');
            if (prvid != 0)
                $('#tabcnt' + prvid).addClass('hide');
            else {
                $('#tabcnt1').addClass('hide');
                $('#tabcnt2').addClass('hide');
                $('#tabcnt3').addClass('hide');
                $('#tabcnt4').addClass('hide');
            }
            $('#tabcnt' + tid).removeClass('hide');
            $('#tabcnt' + tid).fadeOut("fast");
            $('#tabcnt' + tid).fadeIn("slow");
            prvid = tid;

        }


    </script>

    <script type="text/javascript">
        function Save_Validation() {
            var errormsg = validateform('frmfld');
            if (errormsg != "") {
                Msgbox(errormsg);
                return false;
            }


            return true;
        }
        function Save_Validation1() {
            var errormsg = validateform('frmfld1');
            if (errormsg != "") {
                Msgbox(errormsg);
                return false;
            }


            return true;
        }
        function Save_Validation2() {
            var errormsg = validateform('frmfld2');
            if (errormsg != "") {
                Msgbox(errormsg);
                return false;
            }


            return true;
        }
        function afterpost(str) {
            nm.process();
            addr.process();
            altbox(str);
        }
    </script>
    <script>
        var nm = new sagrid();
        nm.url = "../WCFGrid/GridService.svc/Getnamehistory";

        nm.primarykeyval = "SSN";
        nm.bindid = "nmgrd";
        nm.cols = [new dcol("First Name", "fname"), new dcol("Middle Name", "mname"), new dcol("Last Name", "name"), new dcol("DOB", "dob"), new dcol("SSN", "SSN"), new dcol("Created By", "crtby"), new dcol("Created Date", "CreatedDate"), new dcol("Modified By", "mdfby"), new dcol("Modified date", "ModifiedDate")];
        nm.objname = "nm";


        var addr = new sagrid();
        addr.url = "../WCFGrid/GridService.svc/Getaddresshistory";

        addr.primarykeyval = "Zip";
        addr.bindid = "addrgrd";
        addr.cols = [new dcol("Address1", "Address1"), new dcol("Address2", "Address2"), new dcol("City", "City"), new dcol("State", "State"), new dcol("Zip", "Zip"), new dcol("Created By", "crtby"), new dcol("Created Date", "CreatedDate"), new dcol("Modified By", "ndfby"), new dcol("Modified date", "ModifiedDate")];
        addr.objname = "addr";

        function bind_grs() {

            var dataIn1 = '';
            dataIn1 = '"pid":"' + document.getElementById('<%= hfdpersonid.ClientID %>').value + '"';
            nm.data = dataIn1;

            nm.process();

            dataIn1 = '';
            dataIn1 = '"pid":"' + document.getElementById('<%= hfdpersonid.ClientID %>').value + '"';

            addr.data = dataIn1;
            addr.process();
        }


    </script>
    <title></title>

</head>
<body style="background: transparent !important;">
    <form id="form1" runat="server">
        <asp:ScriptManager ID="scriptmanager1" runat="server"></asp:ScriptManager>
        <div style="width: 98%; margin-left: auto; margin-right: auto">
            <asp:HiddenField ID="hfdpid" runat="server" Value="0" />
            <asp:HiddenField ID="hfdpersonid" runat="server" Value="0" />
            <asp:HiddenField ID="hfdcurdate" Value="0" runat="server" />
            <div class="cpanel">
                <div class="thead">

                    <ul class="dtab" style="padding: 0; margin: 0;">
                        <li onclick="show(this,1)"><i class="fa fa-user"></i>Personal Information</li>
                        <li onclick="show(this,2)"><i class="fa fa-mobile"></i>Contact Information</li>
                        <li onclick="show(this,3)"><i class="fa fa-map-marker"></i>Address Information</li>
                        <li onclick="show(this,4)"><i class="fa fa-check-square"></i>Citizenship Information</li>
                    </ul>

                </div>
                <div class="body">

                    <div id="tabcnt1" class="tabcnt">
                        <asp:UpdatePanel ID="upd1" runat="server">
                            <ContentTemplate>

                                <table width="100%" class="spac" id="frmfld">
                                    <tr>
                                        <td align="right" style="font-family: Calibri;">First Name 
                                        </td>
                                        <td align="left">
                                            <asp:TextBox ID="txt_fname" runat="server" CssClass="required" error="Please enter first name." placeholder="First Name"> </asp:TextBox>
                                        </td>
                                        <td align="right" style="font-family: Calibri;">Middle Name 
                                        </td>
                                        <td align="left">
                                            <asp:TextBox ID="txt_mname" runat="server" CssClass="" error="Please enter middle name." placeholder="Middle Name"></asp:TextBox>
                                        </td>

                                        <td align="right" style="font-family: Calibri;">Last Name 
                                        </td>
                                        <td align="left">
                                            <asp:TextBox ID="txt_lname" runat="server" CssClass="required" error="Please enter last name." placeholder="Last Name"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right" style="font-family: Calibri;">Suffix

                                        </td>
                                        <td align="left">
                                            <asp:DropDownList ID="ddl_suffix" runat="server"></asp:DropDownList>
                                        </td>
                                        <td align="right" style="font-family: Calibri;">Maiden Name 
                                        </td>
                                        <td align="left">
                                            <asp:TextBox ID="txt_maidenname" runat="server" placeholder="Maiden Name"></asp:TextBox>
                                        </td>

                                        <td align="right" style="font-family: Calibri;">DOB 
                                        </td>
                                        <td align="left">
                                            <asp:TextBox ID="txt_dob" runat="server" CssClass="date" onblur="javascript:age();"></asp:TextBox>
                                        </td>

                                    </tr>
                                    <tr>
                                        <td align="right" style="font-family: Calibri;">Current Age 
                                        </td>
                                        <td align="left">
                                            <asp:TextBox ID="txt_age" runat="server" Width="40px" error="Please enter age." placeholder="Age"></asp:TextBox>
                                        </td>
                                        <td align="right" style="font-family: Calibri;">SSN 
                                        </td>
                                        <td align="left">
                                            <asp:TextBox ID="txt_ssn" runat="server" CssClass="ssn required" error="Please enter ssn."></asp:TextBox>
                                        </td>
                                        <td align="right" style="font-family: Calibri;">Gender 
                                        </td>
                                        <td align="left">
                                            <asp:DropDownList ID="ddl_gender" runat="server" Width="70px">
                                            </asp:DropDownList>
                                        </td>


                                    </tr>
                                    <tr>
                                        <td align="right" style="font-family: Calibri;">Marital Status 
                                        </td>
                                        <td align="left">
                                            <asp:DropDownList ID="ddl_maritalstatus" runat="server" Width="110px">
                                            </asp:DropDownList>
                                        </td>
                                        <td align="right">NABP E-Profile Number
                                        </td>
                                        <td align="left">
                                            <asp:TextBox ID="txtcpe" runat="server" placeholder="NABP E-Profile Number"></asp:TextBox>
                                        </td>
                                        <td align="right">Ethincity :
                                        </td>
                                        <td align="left">
                                            <asp:DropDownList ID="ddlethincity" runat="server"></asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td >
                                        </td>
                                        <td >
                                            
                                        </td>
                                        <td align="right">Training Completed
                                        </td>
                                        <td align="left">
                                            <asp:CheckBox ID="chk_training" runat="server"></asp:CheckBox>
                                        </td>
                                        <td >
                                        </td>
                                        <td >
                                            
                                        </td>
                                    </tr>
                                </table>


                                <table align="center">
                                    <tr>
                                        <td width="80%">
                                            <br />
                                            <asp:Button ID="btn_personal" runat="server"
                                                Text="Submit" OnClientClick="javascript:return Save_Validation();" OnClick="btn_personal_Click" />



                                        </td>
                                    </tr>
                                </table>
                                <br />
                                <br />
                            </ContentTemplate>
                        </asp:UpdatePanel>

                    </div>

                    <div id="tabcnt2" class="tabcnt">
                        <asp:UpdatePanel ID="upd2" runat="server">
                            <ContentTemplate>

                                <table width="100%" class="spac" id="frmfld2">
                                    <tr>
                                        <td align="right" style="font-family: Calibri;">Phone 
                                        </td>
                                        <td align="left">
                                            <asp:TextBox ID="txt_phone" runat="server" Width="130px" CssClass="phone"></asp:TextBox>
                                        </td>
                                        <td align="right" style="font-family: Calibri;">Alternate Phone
                                        </td>
                                        <td align="left">
                                            <asp:TextBox ID="txt_altphone" runat="server" Width="130px" CssClass="phone"></asp:TextBox>
                                        </td>

                                        <td align="right" style="font-family: Calibri;">Email
                                        </td>
                                        <td align="left">
                                            <asp:TextBox ID="txt_email" runat="server" Width="200px" placeholder="Email"></asp:TextBox>
                                        </td>

                                        <td align="right" style="font-family: Calibri;">Fax 
                                        </td>
                                        <td align="left">
                                            <asp:TextBox ID="txt_fax" runat="server" CssClass="phone"></asp:TextBox>
                                        </td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td></td>
                                        <td></td>
                                    </tr>
                                </table>

                                <table align="center">
                                    <tr>
                                        <td width="80%">
                                            <br />
                                            <asp:Button ID="btn_contact" runat="server"
                                                Text="Submit" OnClick="btn_contact_Click" OnClientClick="javascript:return Save_Validation2();" />



                                        </td>
                                    </tr>
                                </table>
                                <br />
                                <br />
                            </ContentTemplate>
                        </asp:UpdatePanel>

                    </div>
                    <div id="tabcnt3" class="tabcnt">
                        <asp:UpdatePanel ID="upd3" runat="server">
                            <ContentTemplate>

                                <table width="100%" class="spac" id="frmfld1">
                                    <tr>
                                        <td align="right" style="font-family: Calibri;">Address line1
                                        </td>
                                        <td align="left">
                                            <asp:TextBox ID="txt_address1" runat="server" CssClass="required" error="Please enter address1." placeholder="Address"></asp:TextBox>

                                        </td>
                                        <td align="right" style="font-family: Calibri;">Address line2 
                                        </td>
                                        <td align="left">
                                            <asp:TextBox ID="txt_address2" runat="server" CssClass="" error="Please enter address2." placeholder="Address"></asp:TextBox>
                                        </td>

                                        <td align="right" style="font-family: Calibri;">City 
                                        </td>
                                        <td align="left">
                                            <asp:TextBox ID="txt_city" runat="server" CssClass="required" error="Please enter city." placeholder="City"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right" style="font-family: Calibri;">State 
                                        </td>
                                        <td align="left">
                                            <asp:DropDownList ID="ddl_state" runat="server" Width="90px" CssClass="required" error="Please select state.">
                                            </asp:DropDownList>
                                        </td>

                                        <td align="right" style="font-family: Calibri;">County 
                                        </td>
                                        <td align="left">
                                            <asp:DropDownList ID="ddl_county" runat="server" Width="90px">
                                            </asp:DropDownList>
                                        </td>
                                        <td align="right" style="font-family: Calibri;">Zip 
                                        </td>
                                        <td align="left">
                                            <asp:TextBox ID="txt_zip" runat="server" Width="100px" CssClass="zip required" error="Please enter zip."></asp:TextBox>
                                        </td>
                                    </tr>
                                </table>


                                <table align="center">
                                    <tr>
                                        <td width="80%">
                                            <br />
                                            <asp:Button ID="btn_address" runat="server"
                                                Text="Submit" OnClick="btn_address_Click" OnClientClick="javascript:return Save_Validation1();" />



                                        </td>
                                    </tr>
                                </table>
                                <br />
                                <br />
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                    <div id="tabcnt4" class="tabcnt">

                        <asp:UpdatePanel ID="upd4" runat="server">
                            <ContentTemplate>

                                <table class="spac" width="100%">
                                    <tr>
                                        <td align="right" style="font-family: Calibri;" width="10%">US Citizen
                                        </td>
                                        <td style="width: 10%">
                                            <asp:RadioButtonList ID="rdl_uscitizen" runat="server" RepeatDirection="Horizontal" AutoPostBack="true" OnSelectedIndexChanged="rdl_uscitizen_SelectedIndexChanged">
                                                <asp:ListItem Value="0" Text="Yes"></asp:ListItem>
                                                <asp:ListItem Value="1" Text="No"></asp:ListItem>
                                            </asp:RadioButtonList>
                                        </td>
                                        <td style="font-family: Calibri; text-align: right">Citizenship/Lawful Presence Verified 
                                        </td>
                                        <td>
                                            <asp:RadioButtonList ID="rdblawful" runat="server" RepeatColumns="2">
                                                <asp:ListItem Value="1" onclick="lawfulchange(1)">Yes</asp:ListItem>
                                                <asp:ListItem Value="0" onclick="lawfulchange(0)">No</asp:ListItem>
                                            </asp:RadioButtonList>
                                        </td>
                                        <td style="font-family: Calibri;">User 
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtuser" runat="server"></asp:TextBox>
                                        </td>

                                    </tr>
                                    <tr>
                                        <td style="font-family: Calibri;" align="right">Date Verified 
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtverdt" CssClass="date" runat="server"></asp:TextBox>
                                        </td>
                                        <td align="center" colspan="2">
                                            <asp:Panel ID="pnl1" runat="server">
                                                <table style="width: 100%">
                                                    <tr>
                                                        <td align="right">Citizen Expiration Date 
                                                        </td>
                                                        <td align="left">
                                                            <asp:TextBox ID="txtcitizenexpirationdate" runat="server" CssClass="date"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </asp:Panel>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center" colspan="8">
                                            <table width="90%" class="spac">
                                                <tr align="center">
                                                    <td>


                                                        <asp:CheckBoxList ID="chk_usdata" runat="server" RepeatColumns="3">
                                                        </asp:CheckBoxList>

                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>


                                    <tr>
                                        <td align="center" colspan="8">
                                            <table id="lawusertr" style="display: block" width="60%" class="spac">
                                                <tr align="center">
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center" colspan="8">
                                            <table id="lawyestr" style="display: none" width="50%">
                                                <tr align="center">
                                                    <td align="right" style="font-family: Calibri;" width="6%">Documents 
                                                    </td>
                                                    <td align="left" width="10%">
                                                        <asp:ListBox ID="lstdoc1" runat="server" SelectionMode="Multiple" Width="90px" Height="100px"></asp:ListBox>
                                                    </td>
                                                    <td align="right" style="font-family: Calibri;" width="3%">Documents 
                                                    </td>
                                                    <td align="left" width="10%">
                                                        <asp:ListBox ID="lstdoc2" runat="server" SelectionMode="Multiple" Width="90px" Height="100px"></asp:ListBox>
                                                    </td>

                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                                <table align="center">
                                    <tr>
                                        <td width="80%">

                                            <asp:Button ID="btn_uscitizen" runat="server"
                                                Text="Submit" OnClick="btn_uscitizen_Click" />
                                        </td>
                                    </tr>
                                </table>
                                <br />
                                <br />
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                </div>
            </div>
        
        <fieldset>
            <legend>Name Change History
            </legend>
            <div id="nmgrd"></div>
        </fieldset>
        <fieldset>
            <legend>Address Change History
            </legend>
            <div id="addrgrd"></div>
        </fieldset>

        </div>
    </form>
    <script>
        age();
        bind_grs();
        if ($('.dtab').find('li').length > 0) {
            $('.dtab li:eq(0)').click();
        }
        Sys.WebForms.PageRequestManager.getInstance().add_endRequest(EndRequestHandler);
        function EndRequestHandler() {

            loadele();
        }
    </script>
</body>
</html>
