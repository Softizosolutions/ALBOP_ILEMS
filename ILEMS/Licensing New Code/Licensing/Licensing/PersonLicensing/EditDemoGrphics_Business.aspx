<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EditDemoGrphics_Business.aspx.cs" Inherits="Licensing.PersonLicensing.EditDemoGrphics_Business" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
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
    <script type="text/javascript">
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
                $('#tabcnt5').addClass('hide');
                $('#tabcnt6').addClass('hide');
                $('#tabcnt7').addClass('hide');
                $('#tabcnt8').addClass('hide');
                $('#tabcnt9').addClass('hide');
            }
            $('#tabcnt' + tid).removeClass('hide');
            $('#tabcnt' + tid).fadeOut("fast");
            $('#tabcnt' + tid).fadeIn("slow");
            prvid = tid;

        }


    </script>
    <script>
        var nm = new sagrid();
        nm.url = "../WCFGrid/GridService.svc/Getnamehistory";

        nm.primarykeyval = "SSN";
        nm.bindid = "nmgrd";
        nm.cols = [new dcol("Business Name", "name"), new dcol("FEIN", "SSN"), new dcol("Created By", "crtby"), new dcol("Created Date", "CreatedDate"), new dcol("Modified By", "mdfby"), new dcol("Modified date", "ModifiedDate")];
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

            function Save_Validation() {
                var errormsg = validateform('frmfld3');
                if (errormsg != "") {
                    Msgbox(errormsg);
                    return false;
                }


                return true;
            }
            function Save_Validation1() {
                var errormsg = validateform('frmfld');
                if (errormsg != "") {
                    Msgbox(errormsg);
                    return false;
                }


                return true;
            }
            function Save_Validation2() {
                var errormsg = validateform('frmfld1');
                if (errormsg != "") {
                    Msgbox(errormsg);
                    return false;
                }


                return true;
            }
            function Save_Validation3() {
                var errormsg = validateform('frmfld2');
                if (errormsg != "") {
                    Msgbox(errormsg);
                    return false;
                }


                return true;
            }
            function Save_Validation4() {
                var errormsg = validateform('frmfld4');
                if (errormsg != "") {
                    Msgbox(errormsg);
                    return false;
                }


                return true;
            }
            function Save_Validation5() {
                var errormsg = validateform('frmfld5');
                if (errormsg != "") {
                    Msgbox(errormsg);
                    return false;
                }


                return true;
            }
            function afterpost(msg) {
                nm.process();
                addr.process();
                 
                altbox(msg);
            }
    </script>
</head>
<body style="background: transparent !important;">
    <form id="form1" runat="server">
        <asp:ScriptManager ID="scritpmanager1" runat="server"></asp:ScriptManager>
        <div style="width: 98%; margin-left: auto; margin-right: auto">
            <asp:HiddenField ID="hfdmailingaddressid" runat="server" Value="0" />
            <asp:HiddenField ID="hfdpersonid" runat="server" Value="0" />
            <div class="cpanel">
                 <div class="thead">

                    <ul class="dtab" style="padding: 0; margin: 0;">
                        <li onclick="show(this,1)"><i class="fa fa-briefcase"></i>Business Information</li>
                        <li onclick="show(this,2)"><i class="fa fa-mobile"></i>Contact Information</li>
                        <li onclick="show(this,3)"><i class="fa fa-map-marker"></i>Physical Address Information</li>
                        <li onclick="show(this,9)"><i class="fa fa-globe"></i>Mailing Address Information</li>
                        <li onclick="show(this,4)"><i class="fa fa-file-o"></i>USP</li>
                        
                        <li onclick="show(this,7)"><i class="fa fa-server"></i>Operations</li>
                         
                    </ul>

                </div>
                <div class="body">
                     <div id="tabcnt1" class="tabcnt">

                    <asp:UpdatePanel ID="upd1" runat="server">
                        <ContentTemplate>

                            <table width="100%" class="spac" id="frmfld">
                                <tr>
                                    <td align="right" style="font-family: Calibri;">Business Name 
                                    </td>
                                    <td align="left" colspan="3">
                                        <asp:TextBox ID="txt_businessname" runat="server" Width="70%" placeholder="Business Name" CssClass="required" error="Please enter business name."> </asp:TextBox>

                                    </td>


                                    <td align="right" style="font-family: Calibri;">Owners Name 
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="txt_ownername" runat="server" placeholder="Owners Name"></asp:TextBox>
                                    </td>
                                </tr>

                                <tr>
                                    <td align="right" style="font-family: Calibri;">FEIN
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="txt_fein" runat="server" CssClass="required fein" error="Please enter fein."></asp:TextBox>
                                    </td>
                                    <td align="right" style="font-family: Calibri;">DEA Number
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="txt_dea" runat="server" MaxLength="9"></asp:TextBox>
                                    </td>

                                    <td align="right" style="font-family: Calibri;">Date Started
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="txt_datestarted" runat="server" CssClass="date"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                     <td align="right" style="font-family: Calibri;">Skip Payment
                                    </td>
                                     <td align="left">
                                    <asp:CheckBox Text="" runat="server" ID="chk_skippayment" />

                                     <td align="right" style="font-family: Calibri;">NABP E-Profile Number
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="txt_eprofilenumber" runat="server" placeholder="NABP E-Profile #" CssClass="required eprofilenumber" ></asp:TextBox>
                                    </td>
                
                                </tr>

                            </table>

                            <br />
                            <table align="center">
                                <tr>
                                    <td width="80%">

                                        <asp:Button ID="btn_business" runat="server" Text="Submit" OnClick="btn_business_Click" OnClientClick="javascript:retrun Save_Validation1();" />
                                    </td>
                                </tr>
                            </table>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                         </div>
                    <div id="tabcnt2" class="tabcnt">

                    

                    <asp:UpdatePanel ID="upd2" runat="server">
                        <ContentTemplate>
                            <table width="100%" class="spac" id="frmfld1">
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
                                        <asp:TextBox ID="txt_email" runat="server" Width="200px" placeholder="Email" CssClass="email"></asp:TextBox>
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
                        </ContentTemplate>
                    </asp:UpdatePanel>
                   </div>
                     <div id="tabcnt3" class="tabcnt">

                    

                    <asp:UpdatePanel ID="upd3" runat="server">
                        <ContentTemplate>
                            <table width="100%" class="spac" id="frmfld2">
                                <tr>
                                    <td align="right" style="font-family: Calibri;">Address line1
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="txt_address1" runat="server" placeholder="Address" CssClass="required" error="Please enter address1."></asp:TextBox>

                                    </td>
                                    <td align="right" style="font-family: Calibri;">Address line2 
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="txt_address2" runat="server" placeholder="Address"></asp:TextBox>
                                    </td>

                                    <td align="right" style="font-family: Calibri;">City 
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="txt_city" runat="server" placeholder="City" CssClass="required" error="Please enter city."></asp:TextBox>
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
                                        <asp:TextBox ID="txt_zip" runat="server" Width="100px" CssClass="required zip" error="Please enter zip."></asp:TextBox>
                                    </td>
                                </tr>
                            </table>


                            <table align="center">
                                <tr>
                                    <td width="80%">
                                        <br />
                                        <asp:Button ID="btn_address" runat="server"
                                            Text="Submit" OnClick="btn_address_Click" OnClientClick="javascript:return Save_Validation3();" />



                                    </td>
                                </tr>
                            </table>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                    </div>
                    <div id="tabcnt4" class="tabcnt">

                    <asp:UpdatePanel ID="upd4" runat="server">
                        <ContentTemplate>
                            <table class="spac" width="70%" align="center" id="frmfld3">
                                <tr>
                                    <td align="right">Sterile Compounding
                                         <asp:HiddenField ID="hfdusp" runat="server" Value="0" />
                                    </td>
                                    <td align="left">
                                        <asp:CheckBox ID="chkusp797" runat="server" />
                                    </td>
                                    <td align="right">Non-Sterile Compounding
                                    </td>
                                    <td align="left">
                                        <asp:CheckBox ID="chkusp795" runat="server" />
                                    </td>
                                    <td align="right">Sterile Compounding Effective Date
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="txtusp797effcetivedate" runat="server" CssClass="date" error="Please enter Sterile Compounding effective date."></asp:TextBox>
                                    </td>
                                    <td align="right">Non-Sterile Compounding Effective Date
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="txtusp795effectivedate" runat="server" CssClass="date" error="Please enter Non-Sterile Compounding effective date."></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="8" align="center">
                                        <asp:Button ID="btnuspsubmit" runat="server" Text="Submit" OnClick="btnuspsubmit_Click" OnClientClick="javascript:return Save_Validation();" />
                                    </td>
                                </tr>
                            </table>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                   </div>

                     <div id="tabcnt7" class="tabcnt">
                    <asp:UpdatePanel ID="upd7" runat="server">
                        <ContentTemplate>
                            <table class="spac" width="100%" id="frmfld4">
                                <tr>
                                    <td align="right">Monday - Friday
                                              <asp:HiddenField ID="hfdoperation" runat="server" Value="0" />
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="txt_moday_friday" runat="server" placeholder="Monday - Friday" CssClass="required" error="Please enter monday-friday."></asp:TextBox>
                                    </td>
                                    <td align="right">Saturday 
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="txt_saturday" Text="" runat="server" placeholder="Saturday" CssClass="required" error="Please enter saturday."></asp:TextBox>
                                    </td>
                                    <td align="right">Sunday
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="txt_sunday" Text="" runat="server" placeholder="Sunday" CssClass="required" error="Please enter sunday."></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>

                                    <td align="right">Comments
                                    </td>
                                    <td align="left" colspan="5">
                                        <asp:TextBox ID="txt_comments_operations" runat="server" TextMode="MultiLine"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="6" align="center">
                                        <asp:Button ID="btnoperations" runat="server" Text="Submit" OnClick="btnoperations_Click" OnClientClick="javascript:return Save_Validation4();" />
                                    </td>
                                </tr>
                            </table>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                    </div>

                     <div id="tabcnt9" class="tabcnt">
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                            <table width="100%" class="spac" id="frmfld5">
                                <tr>
                                    <td align="right" style="font-family: Calibri;">Address line1
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="txt_mailingaddress1" runat="server" placeholder="Address" CssClass="required" error="Please enter address1."></asp:TextBox>

                                    </td>
                                    <td align="right" style="font-family: Calibri;">Address line2 
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="txt_mailingaddress2" runat="server" placeholder="Address"></asp:TextBox>
                                    </td>

                                    <td align="right" style="font-family: Calibri;">City 
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="txt_mailingcity" runat="server" placeholder="City" CssClass="required" error="Please enter city."></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right" style="font-family: Calibri;">State 
                                    </td>
                                    <td align="left">
                                        <asp:DropDownList ID="ddl_mailingstate" runat="server" Width="90px" CssClass="required" error="Please select state.">
                                        </asp:DropDownList>
                                    </td>

                                    <td align="right" style="font-family: Calibri;">County 
                                    </td>
                                    <td align="left">
                                        <asp:DropDownList ID="ddl_mailingcounty" runat="server" Width="90px">
                                        </asp:DropDownList>
                                    </td>
                                    <td align="right" style="font-family: Calibri;">Zip 
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="txt_mailingzip" runat="server" Width="100px" CssClass="required zip" error="Please enter zip."></asp:TextBox>
                                    </td>
                                </tr>
                            </table>


                            <table align="center">
                                <tr>
                                    <td width="80%">
                                        <br />
                                        <asp:Button ID="btn_mailingaddresssubmit" runat="server"
                                            Text="Submit" OnClick="btn_mailingaddresssubmit_Click" OnClientClick="javascript:return Save_Validation5();" />
                                    </td>
                                </tr>
                            </table>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                   </div>


 
                    <div id="tabcnt5" class="tabcnt" style="display: none">
                        <asp:UpdatePanel ID="upd5" runat="server">
                            <ContentTemplate>
                                <table class="spac" width="100%">
                                    <tr>
                                        <td align="right" width="30%">Community Pharmacies
                                             <asp:HiddenField ID="hfdbuyer" runat="server" Value="0" />
                                        </td>
                                        <td align="left">
                                            <asp:CheckBox ID="Chk_communitypharma" runat="server" />
                                        </td>
                                        <td align="right">Hospitals 
                                        </td>
                                        <td align="left">
                                            <asp:CheckBox ID="Chk_hospitals" runat="server" />
                                        </td>
                                        <td align="right">Other Wholesalers
                                        </td>
                                        <td align="left">
                                            <asp:CheckBox ID="Chk_Otherwholesale" runat="server" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right">Physicians or Other practitioners Licensed To Prescribe
                                        </td>
                                        <td align="left">
                                            <asp:CheckBox ID="Chk_phisician" runat="server" />
                                        </td>
                                        <td align="right">Veterinarians
                                        </td>
                                        <td align="left">
                                            <asp:CheckBox ID="Chk_veterinarians" runat="server" />
                                        </td>
                                        <td align="right">Other
                                        </td>
                                        <td align="left">
                                            <asp:CheckBox ID="Chk_Other" runat="server" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right">If other, Please specify 
                                        </td>
                                        <td align="left">
                                            <asp:TextBox ID="txt_otherspecify" runat="server" TextMode="MultiLine"></asp:TextBox>
                                        </td>
                                        <td align="right">Comments 
                                        </td>
                                        <td align="left" colspan="3">
                                            <asp:TextBox ID="txt_comments" runat="server" TextMode="MultiLine"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" align="center">
                                            <asp:Button ID="btnbuyers" runat="server" Text="Submit" OnClick="btnbuyers_Click" />
                                        </td>
                                    </tr>
                                </table>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                    <div id="tabcnt6" class="tabcnt" style="display: none">
                        <asp:UpdatePanel ID="upd6" runat="server">
                            <ContentTemplate>
                                <table class="spac" width="100%">
                                    <tr>
                                        <td align="right">Controlled Substances
                                            <asp:HiddenField ID="hfddistributor" runat="server" Value="0" />
                                        </td>
                                        <td align="left">
                                            <asp:CheckBox ID="chk_controledsubstance" runat="server" />
                                        </td>
                                        <td align="right">Prescription Drugs
                                        </td>
                                        <td align="left">
                                            <asp:CheckBox ID="chk_presbdrugs" runat="server" />
                                        </td>
                                        <td align="right">Over-The-Counter Drugs
                                        </td>
                                        <td align="left">
                                            <asp:CheckBox ID="chk_overCounter" runat="server" />
                                        </td>
                                    </tr>
                                    <tr>

                                        <td align="right">Please Specify Over-The-Conter Drugs
                                        </td>
                                        <td align="left">
                                            <asp:TextBox ID="txt_precursorchemical" Text="" runat="server" TextMode="MultiLine"></asp:TextBox>
                                        </td>
                                        <td align="right">Precursor Chemicals
                                        </td>
                                        <td align="left">
                                            <asp:CheckBox ID="chk_precursor" runat="server" />
                                        </td>
                                        <td align="right">Medical Gases
                                        </td>
                                        <td align="left">
                                            <asp:CheckBox ID="chk_medicalgases" runat="server" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right">Other
                                        </td>
                                        <td align="left">
                                            <asp:CheckBox ID="chk_other_dist" runat="server" />
                                        </td>
                                        <td align="right">If Other,please specify
                                        </td>
                                        <td align="left">
                                            <asp:TextBox ID="txt_ifotherspecify" runat="server" TextMode="MultiLine"></asp:TextBox>
                                        </td>
                                        <td align="right" colspan="2">Comments
                                        </td>
                                        <td align="left" colspan="2">
                                            <asp:TextBox ID="txtdiscomments" runat="server" TextMode="MultiLine"></asp:TextBox>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td align="center" colspan="6">
                                            <asp:Button ID="btndistributor" runat="server" Text="Submit" OnClick="btndistributor_Click" />
                                        </td>
                                    </tr>
                                </table>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                    <div class="tabcnt" id="tabcnt8" style="display: none">
                        <asp:UpdatePanel ID="upd8" runat="server">
                            <ContentTemplate>
                                <table class="spac" width="100%">
                                    <tr>
                                        <td align="right">Full Service 
                                             <asp:HiddenField ID="hfdtypeoperation" runat="server" Value="0" />
                                        </td>
                                        <td align="left">
                                            <asp:CheckBox ID="chk_fullservice" runat="server" />
                                        </td>
                                        <td align="right">Manufacturer
                                        </td>
                                        <td align="left">
                                            <asp:CheckBox ID="chk_manufarer" runat="server" />
                                        </td>
                                        <td align="right">Repackager
                                        </td>
                                        <td align="left">
                                            <asp:CheckBox ID="chk_repackager" runat="server" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right">Pharmacist Name
                                        </td>
                                        <td align="left">
                                            <asp:TextBox ID="txt_pharmacistname" Text="" runat="server"></asp:TextBox>
                                        </td>
                                        <td align="right">Buying Group
                                        </td>
                                        <td align="left">
                                            <asp:CheckBox ID="chk_byinggroup" runat="server" />
                                        </td>
                                        <td align="right">Import / Export
                                        </td>
                                        <td align="left">
                                            <asp:CheckBox ID="chk_import_export" runat="server" />
                                        </td>
                                    </tr>

                                    <tr>
                                        <td align="right">Distribution Center For Multiunit Pharmacy
                                        </td>
                                        <td align="left">
                                            <asp:CheckBox ID="chk_distributemulphar" runat="server" />
                                        </td>
                                        <td align="right">Virtual (Never takes possession of drugs/products)
                                        </td>
                                        <td align="left">
                                            <asp:CheckBox ID="chk_virtual" runat="server" />
                                        </td>
                                        <td align="right">Sterile Compounding 
                                        </td>
                                        <td align="left">
                                            <asp:CheckBox ID="chk_streliecomp" runat="server" />
                                        </td>
                                    </tr>
                                    <tr>

                                        <td align="right">Non-Sterile Compounding 
                                        </td>
                                        <td align="left">
                                            <asp:CheckBox ID="chk_nonsterilcomp" runat="server" />
                                        </td>
                                        <td align="right">Other
                                        </td>
                                        <td align="left">
                                            <asp:CheckBox ID="chk_typeother" runat="server" />
                                        </td>
                                        <td align="right">If Other, please specify
                                        </td>
                                        <td align="left">
                                            <asp:TextBox ID="txt_operationsotherspecify" runat="server" TextMode="MultiLine"></asp:TextBox>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td align="right">Comments
                                        </td>
                                        <td colspan="5" align="left">
                                            <asp:TextBox ID="txt_operationcomments" runat="server" TextMode="MultiLine"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center" colspan="6">
                                            <asp:Button ID="btntypeoperations" runat="server" Text="Submit" OnClick="btntypeoperations_Click" />
                                        </td>
                                    </tr>
                                </table>
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
    <script type="text/javascript">
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
