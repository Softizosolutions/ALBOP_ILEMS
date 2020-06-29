<%@ Page Language="C#" MasterPageFile="~/PersonLicensing/Person.Master" AutoEventWireup="true"
    CodeBehind="PersonSearch.aspx.cs" Inherits="Licensing.PersonLicensing.PersonSearch" %>

<asp:Content ID="content1" runat="server" ContentPlaceHolderID="cntmain">
    <script type="text/javascript">
        $(document).ready(function () {
            $('#csubstance').hide();
            $('#outofstate').hide();
            
        });
        function ddl_chng()
        {
            var v = $("#<%= ddl_applictype.ClientID %> option:selected")[0].value;
            if (v === '2') {

                $('#csubstance').show();
                $('#outofstate').show();
            } else {
                document.getElementById('<%= chkcontrolledsubstance.ClientID %>').checked = false;
                document.getElementById('<%= rdbstate.ClientID %>' + "_0").checked = false;
                document.getElementById('<%= rdbstate.ClientID %>' + "_1").checked = false;
                $('#csubstance').hide();
                $('#outofstate').hide();
            }
        }
    </script>
    <script language="javascript" type="text/javascript">
        function handle(e) {
            if (e.keyCode === 13) {
                document.getElementById('<%= btnsearch.ClientID %>').click();
            }

            return false;
        }
        var prev_ctlid = null, previd_lic = 0;
        function expand(id) {

            if (document.getElementById("subgrd" + id).className == "hide") {
                $("#show" + id).removeClass('fa-hand-o-right');
                $("#show" + id).addClass('fa-hand-o-down');

                document.getElementById("subgrd" + id).className = "show";
            }
            else {
                $("#show" + id).removeClass('fa-hand-o-down');

                $("#show" + id).addClass('fa-hand-o-right');

                document.getElementById("subgrd" + id).className = "hide";
            }


            previd_lic = id;

            return false;
        }
    </script>
    <script language="javascript" type="text/javascript">
        function age() {

            if (document.getElementById('<%= txtdob.ClientID %>').value != '') {
                var curdate = new Date(document.getElementById('<%= hfdcurdate.ClientID %>').value);
                var dob = new Date(document.getElementById('<%= txtdob.ClientID %>').value);
                var dob1 = document.getElementById('<%= txtdob.ClientID %>').value;
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

                document.getElementById('<%= txtage.ClientID %>').value = age1;
                document.getElementById('<%= txtage.ClientID %>').readOnly = true;
            }
            else
                document.getElementById('<%= txtdob.ClientID %>').focus();

        }

    </script>
    <script type="text/javascript">
        function Save_Validation() {
            var errormsg = validateform('frmfld');
            if (errormsg != "") {
                Msgbox(errormsg);
                return false;
            }
            document.getElementById('<%=btnsave.ClientID%>').style.display = "none";
            return true;

        }
        function Licensetype_validation() {
            var errormsg = validateform('appinsertion');
            if (errormsg != "") {
                Msgbox(errormsg);
                return false;
            }
            document.getElementById('<%=btnapplication.ClientID%>').style.display = "none";
            return true;
        }
        var isautoclick = 0;
        function bindautogrd(sssn) {
            Clear_search();
            document.getElementById('<%= txt_ssn.ClientID %>').value = sssn;
            bindpersonsearch();
            isautoclick = 1;

        }
    </script>
    <script type="text/javascript">


        var dataIn = '';
        var lic = new sagrid();
        lic.url = "../WCFGrid/GridService.svc/BindLicenseinfo";

        lic.primarykeyval = "License_ID";

        lic.cols = [new dcol("License Type", "License_Type"), new dcol("License Number", "Lic_no"), new dcol("Issue Date", "Issue_date"), new dcol("Expiry Date", "Expire_date"), new dcol("Status", "Lic_status"), new dcol("Reinstate", "License_ID", "", "5", "0", "reinstate_lkp", "fa fa-hand-o-up grdicon")];
        lic.objname = "lic";
        lic.aftercall = "Aftercall1";
        lic.ispaging = false;
        lic.isfilters = false;
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
            var address = document.getElementById('<%= txt_address.ClientID %>').value;
            dataIn = dataIn + '"address":"' + address + '",'
            var county = document.getElementById('<%= ddlcounty.ClientID %>').value;
            dataIn = dataIn + '"county":"' + county + '",'
            var state = document.getElementById('<%= ddlstate.ClientID %>').value;
            dataIn = dataIn + '"state":"' + state + '",'
            var zip = document.getElementById('<%= txt_zip.ClientID %>').value;
            dataIn = dataIn + '"zip":"' + zip + '",'
            var email = document.getElementById('<%= txt_email.ClientID %>').value;
            dataIn = dataIn + '"email":"' + email + '",'
            var cs = document.getElementById('<%=chkcontolledsub.ClientID %>').checked;
            dataIn = dataIn + '"csub":"' + cs + '",'
            var city1 = document.getElementById('<%=txt_city.ClientID%>').value;
            dataIn = dataIn + '"city":"' + city1 + '",'
            var stype = "1";
            if (document.getElementById('<%= rdblike.ClientID %>' + '_1').checked == true)
                stype = "0";
            dataIn = dataIn + '"resptype":"' + stype + '"'
            sa5.cols = [new dcol("", "<i class='fa fa-hand-o-right'></i>", "", "4", "1", "lic_grd", "", ""), new dcol("Name", "Full_Name", "", "1", "0", "nm_click", "", ""), new dcol("SSN", "SSN"), new dcol("Address", "Address1"), new dcol("County", "Address2"), new dcol("C S Z", "State"), new dcol("Phone", "Phone"), new dcol("Email", "Email"), new dcol("Select", "", "", "1", "1", "select_lkp", "fa fa-hand-o-up grdicon"), new dcol("Card Pay", "", "", "1", "1", "Pay_lkp_online", "fa fa-credit-card grdicon")];
            sa5.data = dataIn;
            sa5.process();

            return false;
        }
        function Pay_lkp_online(sender, keyval) {
             var olnk = '<%= System.Configuration.ConfigurationManager.AppSettings["onlinelink"].ToString() %>';
            document.getElementById('iframefinance').src = olnk+'showfee.aspx?' + keyval+'&uid='+<%=Session["UID"].ToString()%>;
            $('#financepopup').dialog({ title: "Finance", width: "95%",height:'auto' });
            $('#financepopup').dialog('open');
        }
        function cnffnres(result) {
            if (result == 'true')
                document.getElementById('<%= btnreinstate.ClientID %>').click();
        }
        function reinstate_lkp(sender, keyval) {
            document.getElementById('<%= hfdsellicid.ClientID %>').value = keyval;
            cnfbox(" Are you sure you want to reinstate this license? ", "cnffnres");
        }
        function lic_grd(sender, keyval) {

            var tbody1 = document.getElementById('grdpersonsearch').getElementsByTagName('tbody')[0];
            var i = 0, j = 0;
            var subcount = 0;
            var trs = tbody1.rows[i];

            while (trs != null && j <= sender) {
                i = i + 1;

                if (trs.className == "subrow")
                    subcount = subcount + 1;
                else
                    j = j + 1;
                trs = tbody1.rows[i];
            }

            var tempi = tbody1.rows[sender + subcount].getElementsByTagName('i')[0];
            if (tempi.className == "fa fa-hand-o-right") {
                tempi.className = "fa fa-hand-o-down";

                var temptr = tbody1.insertRow(sender + 1 + subcount);
                temptr.id = "subrow_" + sender;
                temptr.className = "subrow";
                temptr.innerHTML = "<td  colspan='10'><div id='subtd_" + sender + "' style='margin:10px'></div></td>";
                lic.bindid = "subtd_" + sender;
                lic.data = '"pid":"' + keyval + '"';
                lic.process();

            }
            else {
                tempi.className = "fa fa-hand-o-right";
                tbody1.removeChild(document.getElementById("subrow_" + sender));
            }



        }
        function nm_click(sender, keyval) {
            var pid = sa5.resultdata[sender]["Person_ID"];
            window.location.href = '../PersonLicensing/PersonDetails.aspx?pid=' + pid;
        }
        function select_lkp(sender, keyval) {
            $('#csubstance').hide();
            $('#outofstate').hide();
            document.getElementById('<%=ddl_applictype.ClientID%>').value = '';
            document.getElementById('<%=chkcontrolledsubstance.ClientID%>').checked = false;

            document.getElementById('<%= rdbstate.ClientID %>' + "_0").checked = false;
            document.getElementById('<%= rdbstate.ClientID %>' + "_1").checked = false;

            var pid = sa5.resultdata[sender]["Person_ID"];
            var name = sa5.resultdata[sender]["Full_Name"];
            openapplication(pid, name);
        }

        function Aftercall() {
            var trs = sa5.resultdata;
            if (trs.length > 0) {
                if (isautoclick == 1) {
                    document.getElementById('grdpersonsearch').getElementsByTagName('a')[1].click();
                    isautoclick = 0;
                }
                $('#grdpersonsearch').find('tbody>tr').each(function(i,v){
                    if(trs[i]["AllDocumentsReceived"]==true){
                        $(this).find('td:not(:first)').css({'color':'red'});
                        $(this).find('a').css('color','red');
                        //$(this).find('td:eq(0)').html('<i class="fa fa-lock"></i>');
                    }      
                });
                return true;
            }
            else {
                altbox("No results found.");
                document.getElementById("grdpersonsearch").innerHTML = "";
                return false;
            }
        }
        function Aftercall1() {
            var trs = lic.resultdata;
            if (trs.length > 0) {
                return true;
            }
            else {
                document.getElementById(lic.bindid).innerHTML = "<span class='error'>No license found.</span>";
                return false;
            }
        }
    </script>
    <script>

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
            if (Value_Checked('<%= txt_address.ClientID %>', "1") != "1")
                srch_count = srch_count + 1;
            if (Value_Checked_Drp('<%=ddlcounty.ClientID%>', "1") != "1")
                srch_count = srch_count + 1;
            if (Value_Checked_Drp('<%=ddlstate.ClientID%>', "1") != "1")
                srch_count = srch_count + 1;
            if (Value_Checked('<%= txt_zip.ClientID %>', "1") != "1")
                srch_count = srch_count + 1;
            if (Value_Checked('<%=  txt_email.ClientID %>', "1") != "1")
                srch_count = srch_count + 1;
            if (Value_Checked('<%=txt_city.ClientID%>', "1") != "1")
                srch_count = srch_count + 1;
            if (Value_Checked_checkbox('<%=chkcontolledsub.ClientID %>', "1") != "1")
                srch_count = srch_count + 1;
            if (document.getElementById('<%=  txt_licnumber.ClientID %>') != null) {
                if (Value_Checked('<%=  txt_licnumber.ClientID %>', "1") != "1")
                    srch_count = srch_count + 1;
            }
            if (srch_count == 0)
                err = err + "Please select atleast one criteria for search.\r\n";
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
    </script>
    <script type="text/javascript" language="javascript">
        function Clear_Addnew() {
            document.getElementById('<%= hfdpersonid.ClientID %>').value = '0';
            document.getElementById('<%= txtfname.ClientID %>').value = '';
            document.getElementById('<%= txtmname.ClientID %>').value = '';
            document.getElementById('<%= txtlname.ClientID %>').value = '';
            document.getElementById('<%= ddl_gender.ClientID %>').value = '-1';
            document.getElementById('<%= txtmaidenname.ClientID %>').value = '';
            document.getElementById('<%= txtdob.ClientID %>').value = '';
            document.getElementById('<%= txtssn.ClientID %>').value = '';
            document.getElementById('<%= txtage.ClientID %>').value = '';
            document.getElementById('<%= txtaddress1.ClientID %>').value = '';
            document.getElementById('<%= txtaddress2.ClientID %>').value = '';
            document.getElementById('<%= txtcity.ClientID %>').value = '';
            document.getElementById('<%= ddl_state.ClientID %>').value = '-1';
            document.getElementById('<%= ddl_county.ClientID %>').value = '-1';
            document.getElementById('<%= txtzip.ClientID %>').value = '';
            document.getElementById('<%= ddl_phone.ClientID %>').value = 'H';
            document.getElementById('<%= txtphone.ClientID %>').value = '';
            document.getElementById('<%= ddl_altphone.ClientID %>').value = 'H';
            document.getElementById('<%= txtaltphone.ClientID %>').value = '';
            document.getElementById('<%= ddl_mstatus.ClientID %>').value = '-1';
            document.getElementById('<%= txtfax.ClientID %>').value = '';
            document.getElementById('<%= txtemail.ClientID %>').value = '';
            document.getElementById('<%= rdl_uscitizen.ClientID %>' + '_0').checked == false;
            document.getElementById('<%= rdl_uscitizen.ClientID %>' + '_1').checked == false;


            document.getElementById('<%= ddl_suffix.ClientID %>').value = '-1';
            document.getElementById('<%=txtcitizenexpdate.ClientID%>>').value = '';
            document.getElementById('<%=txtcpenumber.ClientID %>').value = '';
            return false;
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
            document.getElementById('<%=txt_address.ClientID%>').value = '';
            document.getElementById('<%= ddlcounty.ClientID %>').value = '-1';
            document.getElementById('<%= ddlstate.ClientID %>').value = '-1';
            document.getElementById('<%= txt_email.ClientID %>').value = '';
            document.getElementById('<%=txt_zip.ClientID%>').value = '';
            document.getElementById('<%=chkcontolledsub.ClientID%>').checked = false;
            document.getElementById('<%= rdblike.ClientID %>' + '_0').checked = false;
            document.getElementById('<%= rdblike.ClientID %>' + '_1').checked = false;
            document.getElementById('<%=txt_city.ClientID%>').value = "";
            document.getElementById("grdpersonsearch").innerHTML = "";
            return false;
        }
        function Popup() {
            $(function () {
                $('#btnnew_pop').dialog({ title: 'Add New Person Information' });
                $('#btnnew_pop').dialog("open");
            });
        }
    </script>
    <asp:UpdatePanel ID="upd1" runat="server">
        <ContentTemplate>
            <asp:HiddenField ID="hfdsellicid" runat="server" Value="0" />
            <asp:Button ID="btnreinstate" runat="server" Style="display: none" OnClick="btnreinstate_click" />
            <asp:HiddenField ID="hfd_perid" runat="server" Value="0" />
            <asp:HiddenField ID="hfdpersonid" runat="server" Value="0" />
            <asp:HiddenField ID="hfdcurdate" Value="0" runat="server" />
            <div class="cpanel">
                <div class="head">
                    Person Search <a id="btnnew" class="poptrg" onclick="javascript: return Clear_Addnew()">Add New</a>
                </div>
                <div class="body" onkeypress="handle(event)">

                    <table width="98%" align="center" class="spac">
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
                                <asp:TextBox ID="txt_address" runat="server" placeholder="Address"></asp:TextBox>
                            </td>
                            <td align="right">City
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
                                <asp:TextBox ID="txt_email" runat="server" placeholder="Email"></asp:TextBox>
                            </td>

                        </tr>
                        <tr>

                            <td align="right" colspan="2" align="center">
                                <asp:CheckBox ID="chkcontolledsub" runat="server" Text="&nbsp;&nbsp;Controlled Substance" />
                            </td>
                            <td align="right">Search Type 
                            </td>
                            <td>
                                <asp:RadioButtonList ID="rdblike" runat="server" RepeatColumns="2">
                                    <asp:ListItem Value="0" Selected="True">Like</asp:ListItem>
                                    <asp:ListItem Value="1">Exact</asp:ListItem>
                                </asp:RadioButtonList>

                            </td>
                        </tr>
                        <tr>
                            <td colspan="6" align="center" height="50px;">
                                <asp:Button ID="btnsearch" runat="server" Text="Search" OnClientClick="javascript:return Search_Validation();"
                                    OnClick="btnsearch_Click" />
                                <asp:Button ID="btnsearchclear" runat="server" Text="Clear" OnClientClick="javascript:return Clear_search();" />
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <div class="cpanel">
                <div class="head">
                    Result
                </div>
                <div class="body">
                    <div id="grdpersonsearch">
                    </div>
                </div>
            </div>
            <div id='btnnew_pop' class="popup" style="display: none;">
                <span class="title">Add New Person Information</span>
                <asp:UpdatePanel ID="upd3" runat="server">
                    <ContentTemplate>
                        <table align="center" class="spac" id="frmfld">
                            <tr>
                                <td align="right">First Name
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtfname" runat="server" CssClass="required" placeholder="First Name"
                                        error="Please enter first name."></asp:TextBox>
                                </td>
                                <td align="right">Middle Name
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtmname" runat="server" placeholder="Middle Name"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">Last Name
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtlname" runat="server" CssClass="required" placeholder="Last Name"
                                        error="Please enter last name."></asp:TextBox>
                                </td>
                                <td align="right">Suffix
                                </td>
                                <td align="left">
                                    <asp:DropDownList ID="ddl_suffix" runat="server">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">Maiden Name
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtmaidenname" runat="server" placeholder="Maiden Name"></asp:TextBox>
                                </td>
                                <td align="right">SSN
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtssn" runat="server" CssClass="required ssn" error="Please enter the ssn."></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">DOB
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtdob" runat="server" class="required date" error="Please enter the date of birth."
                                        onblur="javascript:age();"></asp:TextBox>
                                </td>
                                <td align="right">Gender
                                </td>
                                <td align="left">
                                    <asp:DropDownList ID="ddl_gender" runat="server" CssClass="required" error="Please select the gender.">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">Age
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtage" runat="server" CssClass="required" error="Please enter the age."></asp:TextBox>
                                </td>
                                <td align="right">Address Type
                                </td>
                                <td align="left">
                                    <asp:DropDownList ID="ddl_addresstype" runat="server" CssClass="required" error="Please select the address type.">
                                        <asp:ListItem>Home</asp:ListItem>
                                        <asp:ListItem>Office</asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">Address1
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtaddress1" runat="server" CssClass="required" placeholder="Address"
                                        error="Please enter the address1."></asp:TextBox>
                                </td>
                                <td align="right">Address2
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtaddress2" runat="server" placeholder="Address"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">City
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtcity" runat="server" CssClass="required" placeholder="City" error="Please enter the city."></asp:TextBox>
                                </td>
                                <td align="right">State
                                </td>
                                <td align="left">
                                    <asp:DropDownList ID="ddl_state" runat="server" CssClass="required" error="Please select the state.">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">County
                                </td>
                                <td align="left">
                                    <asp:DropDownList ID="ddl_county" runat="server" CssClass="required" placeholder="First Name"
                                        error="Please select the county.">
                                    </asp:DropDownList>
                                </td>
                                <td align="right">Zip
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtzip" runat="server" CssClass="required zip" placeholder="First Name"
                                        error="Please enter the zip."></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">Phone
                                </td>
                                <td align="left">
                                    <asp:DropDownList ID="ddl_phone" runat="server" Width="35px">
                                        <asp:ListItem>H</asp:ListItem>
                                        <asp:ListItem>C</asp:ListItem>
                                        <asp:ListItem>O</asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:TextBox ID="txtphone" runat="server" CssClass="required phone" Width="140px"
                                        error="Please enter the phone number."></asp:TextBox>
                                </td>
                                <td align="right">Alternate Phone
                                </td>
                                <td align="left">
                                    <asp:DropDownList ID="ddl_altphone" runat="server" Width="35px">
                                        <asp:ListItem>H</asp:ListItem>
                                        <asp:ListItem>C</asp:ListItem>
                                        <asp:ListItem>O</asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:TextBox ID="txtaltphone" runat="server" CssClass="phone" Width="140px"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">Marital Status
                                </td>
                                <td align="left">
                                    <asp:DropDownList ID="ddl_mstatus" runat="server">
                                    </asp:DropDownList>
                                </td>
                                <td align="right">Fax
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtfax" runat="server" CssClass="phone"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">Email
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtemail" runat="server" CssClass="required email" placeholder="Email"
                                        error="Please enter the email."></asp:TextBox>
                                </td>
                                <td align="right">US Citizen
                                </td>
                                <td align="left">
                                    <asp:RadioButtonList ID="rdl_uscitizen" runat="server" RepeatDirection="Horizontal">
                                        <asp:ListItem Value="0" Text="Yes"></asp:ListItem>
                                        <asp:ListItem Value="1" Text="No"></asp:ListItem>
                                    </asp:RadioButtonList>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">Citizenship Expiration Date
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtcitizenexpdate" runat="server" CssClass="date"></asp:TextBox>
                                </td>
                                <td align="right">NABP E-Profile Number
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtcpenumber" runat="server" placeholder="CPE Number"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">Ethnicity :
                                </td>
                                <td align="left">
                                    <asp:DropDownList ID="ddlethincity" runat="server"></asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="4" align="center">
                                    <asp:Button ID="btnsave" runat="server" Text="Save" OnClick="btnsave_Click" OnClientClick="javascript:return Save_Validation()  " />
                                    <asp:Button Text="Clear" ID="btnclear" runat="server" OnClientClick="javascript:return Clear_Addnew();" />
                                </td>
                            </tr>
                        </table>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
            <asp:Button ID="btnapplication" runat="server" Style="display: none" />
            <div id='btnselect_pop' class="popup" style="display: none;">
                <asp:Label ID="lblheadnew" runat="server" CssClass="title" Text=""></asp:Label>
                <table style="width: 100%;" id="appinsertion">
                    <tr>
                        <td align="right">License Type
                        </td>
                        <td align="left">
                            <asp:DropDownList ID="ddl_applictype" runat="server" onchange="ddl_chng()" CssClass="required" error="Please select license type.">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr id="csubstance">

                        <td align="center" colspan="2">
                            <asp:CheckBox ID="chkcontrolledsubstance" Text="&nbsp;&nbsp;Controlled Substance" runat="server" />
                        </td>
                    </tr>
                    <tr id="outofstate">

                        <td align="center" colspan="2">
                            <asp:RadioButtonList ID="rdbstate" runat="server">
                                <asp:ListItem Value="1">&nbsp;&nbsp;Reciprocity</asp:ListItem>
                                <asp:ListItem Value="2">&nbsp;&nbsp;Score Transfer</asp:ListItem>
                            </asp:RadioButtonList>

                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" align="center">
                            <asp:Button ID="btnlicapplication" runat="server" Text="Submit" OnClick="btnapplication_Click"
                                OnClientClick="javascript: return Licensetype_validation();" />
                        </td>
                    </tr>
                </table>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
    <div id="financepopup" class="popup" style="display:none">
        <iframe id="iframefinance" width="100%" height="500px" frameborder="0"></iframe>
    </div>
    <script type="text/javascript">
        function openapplication(selpid, name) {

            document.getElementById('<%= hfd_perid.ClientID %>').value = selpid;
            $('#btnselect_pop').dialog({ title: name });
            $('#btnselect_pop').dialog('open');
            document.getElementById('<%=lblheadnew.ClientID%>').innerText = name + " New License Information ";
            return false;
        }
    </script>
</asp:Content>
