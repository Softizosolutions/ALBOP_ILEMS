<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/PersonLicensing/Person.Master"
    CodeBehind="BusinessSearch.aspx.cs" Inherits="Licensing.PersonLicensing.BusinessSearch" %>

<asp:Content ID="content1" runat="server" ContentPlaceHolderID="cntmain">
    <asp:HiddenField ID="hfd_objtype" runat="server" Value="0" />
    <script type="text/javascript">
        $(document).ready(function () {
            $('#csubstance').hide();
            
           
        });
         function ddlchng()
            {
                document.getElementById('<%= chkcontrolledsubstance.ClientID %>').checked = false;

                var v = $("#<%= ddl_applictype.ClientID %> option:selected")[0].value;
                if (v == '17' || v == '12' || v == '13' || v === '8' || v === '9' || v === '10' || v == '11' || v == '32' || v == '33'  || v == '18'  || v == '21'  || v == '25'  || v == '27'  || v == '35'  || v == '29') {
                    $('#csubstance').show();
                }
                else if (v >= "18" && v <= "29") {
                    $('#csubstance').show();
                }
                else {

                    $('#csubstance').hide();
                }
           
        }
    </script>
    <script type="text/javascript">
        function handle(e) {
            if (e.keyCode === 13) {
                document.getElementById('<%= btnsearch.ClientID %>').click();
            }

            return false;
        }
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
            document.getElementById('<%=btnlicapplication.ClientID%>').style.display = "none";
            return true;
        }
        var isautoclick = 0;
        function bindautogrd(sssn, bname, oname, sdate, phone, city, state, county, zip, email) {
            Clear_search();
            document.getElementById('<%= txt_fein.ClientID %>').value = sssn;
            document.getElementById('<%=txt_businessname.ClientID%>').value = bname;

            document.getElementById('<%=txt_datestarted.ClientID%>').value = sdate;
            <%--document.getElementById('<%=txt_phonenum.ClientID%>').value = phone;
            document.getElementById('<%=txt_city.ClientID%>').value = city;
            document.getElementById('<%=ddl_state.ClientID%>').value = state;
            document.getElementById('<%=ddl_county.ClientID%>').value = county;
            document.getElementById('<%=txt_ownersname.ClientID%>').value = oname;--%>
            document.getElementById('<%=txt_email.ClientID%>').value = email;
            bindbusinesssearch();
            isautoclick = 1;

        }
        function afterpost(msg) {
            altbox(msg);
            document.getElementById('<%=ddl_applictype.ClientID%>').value = "-1";
            document.getElementById('<%=btnlicapplication.ClientID%>').style.display = "block";
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
        var bus = new sagrid();
        bus.url = "../WCFGrid/GridService.svc/Getbusinessearchforcontact";

        bus.primarykeyval = "Person_ID";
        bus.bindid = "grdbusinesssearch";

        bus.objname = "bus";
        bus.aftercall = "Aftercall";
        function cnffnres(result) {
            if (result == 'true')
                document.getElementById('<%= btnreinstate.ClientID %>').click();
}
function reinstate_lkp(sender, keyval) {
    document.getElementById('<%= hfdsellicid.ClientID %>').value = keyval;
    cnfbox(" Are you sure you want to reinstate this license? ", "cnffnres");
}
function bindbusinesssearch() {

    dataIn = "";
    var lastname = document.getElementById('<%= txt_businessname.ClientID %>').value;
    dataIn = dataIn + '"lname":"' + lastname + '",'
    var firstname = document.getElementById('<%= txt_ownersname.ClientID %>').value;
    dataIn = dataIn + '"fname":"' + firstname + '",'
    var ssn = document.getElementById('<%= txt_fein.ClientID %>').value;
            dataIn = dataIn + '"ssn":"' + ssn + '",'
            var dob = document.getElementById('<%= txt_datestarted.ClientID %>').value;
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
            var city = document.getElementById('<%= txt_city.ClientID %>').value;
            dataIn = dataIn + '"city":"' + city + '",'

            var county = document.getElementById('<%= ddlcounty.ClientID %>').value;
    dataIn = dataIn + '"county":"' + county + '",'
    var state = document.getElementById('<%= ddlstate.ClientID %>').value;
    dataIn = dataIn + '"state":"' + state + '",'
    var zip = document.getElementById('<%= txt_zip.ClientID %>').value;
            dataIn = dataIn + '"zip":"' + zip + '",'
            var email = document.getElementById('<%= txt_email.ClientID %>').value;
            dataIn = dataIn + '"email":"' + email + '",'
           <%-- var cert = document.getElementById('<%= txt_mailorder.ClientID %>').value;--%>
    dataIn = dataIn + '"cert":"' + ' ' + '",'
    var cs = document.getElementById('<%=chkcontrolsub.ClientID %>').checked;
            dataIn = dataIn + '"csub":"' + cs + '",'
            var u797 = document.getElementById('<%=chkusp797.ClientID %>').checked;
            if (u797 == true)
                dataIn = dataIn + '"usp797":"' + 1 + '",'
            else
                dataIn = dataIn + '"usp797":"' + ' ' + '",'

            var u795 = document.getElementById('<%=chkusp795.ClientID %>').checked;
            if (u795 == true)
                dataIn = dataIn + '"usp795":"' + 1 + '",'
            else
                dataIn = dataIn + '"usp795":"' + ' ' + '",'
            var stype = "1";
            if (document.getElementById('<%= rdblike.ClientID %>' + '_1').checked == true)
                stype = "0";
            dataIn = dataIn + '"resptype":"' + stype + '"'

            bus.cols = [new dcol("", "<i class='fa fa-hand-o-right'></i>", "", "4", "1", "lic_grd", "", ""), new dcol("Business Name", "Business", "", "1", "0", "nm_click", "", ""), new dcol("Supervising Pharmacist", "Ownersifdiff"), new dcol("FEIN", "FEIN"), new dcol("Address", "Address1"), new dcol("County", "County"), new dcol("C S Z", "Address2"), new dcol("Phone", "Phone"), new dcol("Email", "Email"), new dcol("Select", "", "", "1", "1", "Select_buslkp", "fa fa-hand-o-up grdicon"), new dcol("Card Pay", "", "", "1", "1", "Pay_lkp_online", "fa fa-credit-card grdicon")];
            bus.data = dataIn;
            bus.process();

            return false;
        }
        function Pay_lkp_online(sender, keyval) {
             var olnk = '<%= System.Configuration.ConfigurationManager.AppSettings["onlinelink"].ToString() %>';
            document.getElementById('iframefinance').src = olnk+'showfee.aspx?' + keyval+'&uid='+<%=Session["UID"].ToString()%>;
            $('#financepopup').dialog({ title: "Finance", width: "95%",height:'auto' });
            $('#financepopup').dialog('open');
        }
        function lic_grd(sender, keyval) {

            var tbody1 = document.getElementById('grdbusinesssearch').getElementsByTagName('tbody')[0];
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
                temptr.innerHTML = "<td  colspan='9'><div id='subtd_" + sender + "' style='margin:10px'></div></td>";
                lic.bindid = "subtd_" + sender;
                lic.data = '"pid":"' + keyval + '"';
                lic.process();

            }
            else {
                tempi.className = "fa fa-hand-o-right";
                tbody1.removeChild(document.getElementById("subrow_" + sender));
            }



        }
        function Select_buslkp(sender, keyval) {
            $('#csubstance').hide();
            document.getElementById('<%=ddl_applictype.ClientID%>').value = '';
            document.getElementById('<%=chkcontrolledsubstance.ClientID%>').checked = false;
            var pid = bus.resultdata[sender]["Person_ID"];
            var name = bus.resultdata[sender]["Business"];
            openapplication(pid, name);
        }
         function Select_buslkp1(pid, name) {
             $('#csubstance').hide();
             $('#btnnew_pop').dialog('close');
            document.getElementById('<%=ddl_applictype.ClientID%>').value = '';
            document.getElementById('<%=chkcontrolledsubstance.ClientID%>').checked = false;
            var pid = pid;
            var name = name;
            openapplication(pid, name);
        }
        function nm_click(sender, keyval) {
            var pid = bus.resultdata[sender]["Person_ID"];
            var objtype = bus.resultdata[sender]["object_type"];
          
            window.location.href = '../PersonLicensing/Business_Details.aspx?pid=' + pid;
        }
        function Aftercall() {
            var trs = bus.resultdata;
            if (trs.length > 0) {
                if (isautoclick == 1) {
                    document.getElementById('grdbusinesssearch').getElementsByTagName('a')[1].click();
                    isautoclick = 0;
                }
                return true;
            }
            else {
                altbox("No results found.");
                document.getElementById("grdbusinesssearch").innerHTML = "";
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
    <script type="text/javascript">

        function Search_Validation() {

            var err = "";
            var srch_count = 0;
            if (Value_Checked('<%= txt_businessname.ClientID %>', "1") != "1")
                srch_count = srch_count + 1;
            if (Value_Checked('<%= txt_ownersname.ClientID %>', "1") != "1")
                srch_count = srch_count + 1;
            if (Value_Checked('<%= txt_fein.ClientID %>', "1") != "1")
                srch_count = srch_count + 1;
            if (Value_Checked('<%= txt_datestarted.ClientID %>', "1") != "1")
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
            if (Value_Checked('<%= txt_city.ClientID %>', "1") != "1")
                srch_count = srch_count + 1;
            if (Value_Checked_Drp('<%=ddlstate.ClientID%>', "1") != "1")
                srch_count = srch_count + 1;
            if (Value_Checked('<%= txt_zip.ClientID %>', "1") != "1")
                srch_count = srch_count + 1;
            if (Value_Checked('<%=txt_email.ClientID %>', "1") != "1")
                srch_count = srch_count + 1;
           <%-- if (Value_Checked('<%=txt_mailorder.ClientID %>', "1") != "1")
                srch_count = srch_count + 1;--%>
            if (Value_Checked_checkbox('<%=chkcontrolsub.ClientID %>', "1") != "1")
                srch_count = srch_count + 1;
            if (Value_Checked_checkbox('<%=chkusp797.ClientID %>', "1") != "1")
                srch_count = srch_count + 1;
            if (Value_Checked_checkbox('<%=chkusp795.ClientID %>', "1") != "1")
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
    </script>
    <script type="text/javascript" language="javascript">
        function Clear_Addnew() {
            document.getElementById('<%= hfdpersonid.ClientID %>').value = '0';
            document.getElementById('<%= txtbusinessname.ClientID %>').value = '';
            document.getElementById('<%= txtownersname.ClientID %>').value = '';
            document.getElementById('<%= txtstartdate.ClientID %>').value = '';
            document.getElementById('<%= txtenddate.ClientID %>').value = '';
            document.getElementById('<%= txtfein.ClientID %>').value = '';
            document.getElementById('<%= txtaddress1.ClientID %>').value = '';
            document.getElementById('<%= txtaddress2.ClientID %>').value = '';
            document.getElementById('<%= txtcity.ClientID %>').value = '';
            document.getElementById('<%= ddl_state.ClientID %>').value = '-1';
            document.getElementById('<%= ddlbusinesstype.ClientID %>').value = '-1';
            document.getElementById('<%= ddlstatus.ClientID %>').value = '-1';
            document.getElementById('<%= ddl_county.ClientID %>').value = '-1';
            document.getElementById('<%= txtzip.ClientID %>').value = '';
            document.getElementById('<%= ddl_phone.ClientID %>').value = 'H';
            document.getElementById('<%= txtphone.ClientID %>').value = '';
            document.getElementById('<%= ddl_altphone.ClientID %>').value = 'H';
            document.getElementById('<%= txtaltphone.ClientID %>').value = '';
            document.getElementById('<%= txtfax.ClientID %>').value = '';
            document.getElementById('<%= txtemail.ClientID %>').value = '';
            document.getElementById('<%=txtdea.ClientID%>>').value = '';
            return false;
        }
        function Clear_search() {
            document.getElementById('<%= txt_businessname.ClientID %>').value = '';
            document.getElementById('<%= txt_ownersname.ClientID %>').value = '';
            document.getElementById('<%= txt_fein.ClientID %>').value = '';
            document.getElementById('<%= txt_datestarted.ClientID %>').value = '';
            document.getElementById('<%= txt_phonenum.ClientID %>').value = '';
            document.getElementById('<%= ddl_Phonetype.ClientID %>').value = '-1';
            document.getElementById('<%= txt_licnumber.ClientID %>').value = '';
            document.getElementById('<%= ddl_lictype.ClientID %>').value = '-1';
            document.getElementById('<%= ddl_licstatus.ClientID %>').value = '-1';
            document.getElementById('<%=txt_address.ClientID%>').value = '';
            document.getElementById('<%= ddlcounty.ClientID %>').value = '-1';
            document.getElementById('<%= ddlstate.ClientID %>').value = '-1';
            document.getElementById('<%=txt_email.ClientID%>').value = '';
            document.getElementById('<%=txt_zip.ClientID%>').value = '';
            <%--document.getElementById('<%=txt_mailorder.ClientID %>').value = '';--%>
            document.getElementById('<%=chkcontrolsub.ClientID%>').checked = false;
            document.getElementById('<%=chkusp795.ClientID%>').checked = false;
            document.getElementById('<%=chkusp797.ClientID%>').checked = false;
            document.getElementById('<%= rdblike.ClientID %>' + '_0').checked = false;
            document.getElementById('<%= rdblike.ClientID %>' + '_1').checked = false;
            document.getElementById('<%=txt_city.ClientID%>').value = '';
            document.getElementById("grdbusinesssearch").innerHTML = "";
            return false;
        }
    </script>
    <script language="javascript" type="text/javascript">
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
    <asp:UpdatePanel ID="upd1" runat="server">
        <ContentTemplate>
            <asp:HiddenField ID="hfdsellicid" runat="server" Value="0" />
            <asp:Button ID="btnreinstate" runat="server" Style="display: none" OnClick="btnreinstate_click" />

            <asp:HiddenField ID="hfd_perid" runat="server" Value="0" />
            <asp:HiddenField ID="hfdpersonid" runat="server" Value="0" />
            <div class="cpanel">
                <div class="head">
                    Business Search <a id="btnnew" class="poptrg" onclick="javascript: return Clear_Addnew()">Add New</a>
                </div>
                <div class="body">
                    <asp:UpdatePanel ID="upd2" runat="server">
                        <ContentTemplate>
                            <table width="98%" align="center" class="spac" onkeypress="handle(event)">
                                <tr>
                                    <td align="right">Business Name
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="txt_businessname" runat="server" placeholder="Business Name"></asp:TextBox>
                                    </td>
                                    <td align="right">Owners Name
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="txt_ownersname" runat="server" placeholder="Owners Name"></asp:TextBox>
                                    </td>
                                    <td align="right">FEIN
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="txt_fein" runat="server" CssClass="fein"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">Date Started
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="txt_datestarted" runat="server" class="date"></asp:TextBox>
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
                                        <asp:DropDownList ID="ddlcounty" runat="server"></asp:DropDownList>
                                    </td>

                                </tr>
                                <tr>
                                    <td align="right">State
                                    </td>
                                    <td align="left">
                                        <asp:DropDownList ID="ddlstate" runat="server"></asp:DropDownList>
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
                                    <%-- <td align="right">Mail Order Number
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="txt_mailorder" runat="server" placeholder="Mail Order Number"></asp:TextBox>
                                    </td>--%>
                                    <td align="right" colspan="2">
                                        <asp:CheckBox ID="chkcontrolsub" runat="server" Text="&nbsp;&nbsp;Controlled Substance" />
                                    </td>
                                    <td align="center" colspan="2">
                                        <asp:CheckBox ID="chkusp797" runat="server" Text="Sterile Compounding" />
                                    </td>
                                    <td align="center" colspan="2">
                                        <asp:CheckBox ID="chkusp795" runat="server" Text="Non-Sterile Compounding" />
                                    </td>
                                </tr>
                                <tr>

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
                                        <asp:Button ID="btnsearch" runat="server" Text="Search" OnClick="btnsearch_Click" OnClientClick="javascript:return Search_Validation();" />
                                        <asp:Button ID="btnsearchclear" runat="server" Text="Clear" OnClientClick="javascript:return Clear_search();" />
                                    </td>
                                </tr>
                            </table>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
            </div>
            <div class="cpanel">
                <div class="head">
                    Result
                </div>

                <div class="body">
                    <div id="grdbusinesssearch"></div>

                </div>
            </div>
            <asp:Button ID="btnapplication" runat="server" Style="display: none" />
        
        </ContentTemplate>
    </asp:UpdatePanel>
        <div id='btnselect_pop' class="popup" style="display: none;">
                <asp:Label ID="lblheadnew" runat="server" CssClass="title" Text=""></asp:Label>
                <asp:UpdatePanel ID="upd3" runat="server">
                    <ContentTemplate>
                        <table style="width: 100%;" id="appinsertion">
                            <tr>
                                <td align="right">License Type 
                                </td>
                                <td align="left">
                                    <asp:DropDownList ID="ddl_applictype" onchange="ddlchng()" runat="server" CssClass="required" error="Please select license type."></asp:DropDownList>
                                </td>
                            </tr>
                            <tr id="csubstance">

                                <td align="center" colspan="2">
                                    <asp:CheckBox ID="chkcontrolledsubstance" runat="server" Text="&nbsp;&nbsp;Controlled Substance" />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" align="center">
                                    <asp:Button ID="btnlicapplication" runat="server" Text="Submit" OnClientClick="javascript: return Licensetype_validation();" OnClick="btnapplication_Click" />
                                </td>
                            </tr>
                        </table>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
            <div id='btnnew_pop' class="popup" style="display: none;">
                <span class="title">Add New Business Information</span>
                <asp:UpdatePanel ID="upd4" runat="server">
                    <ContentTemplate>
                        <table align="center" class="spac" id="frmfld">
                            <tr>
                                <td align="right">Business Name
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtbusinessname" runat="server" CssClass="required" placeholder="Business Name"
                                        error="Please enter business name."></asp:TextBox>
                                </td>
                                <td align="right">Owners Name(If Different)
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtownersname" runat="server" placeholder="Owners Name"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">FEIN
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtfein" runat="server" CssClass="required fein" error="Please enter fein number."></asp:TextBox>
                                </td>
                                <td align="right">Start Date
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtstartdate" runat="server" class="date" error="Please enter the start date."></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">End Date
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtenddate" runat="server" CssClass="date"></asp:TextBox>
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
                                    <asp:DropDownList ID="ddlstatus" runat="server">
                                        <asp:ListItem Value="-1" Text="Select"></asp:ListItem>
                                        <asp:ListItem Value="1" Text="Close"></asp:ListItem>
                                        <asp:ListItem Value="2" Text="Open"></asp:ListItem>
                                        <asp:ListItem Value="3" Text="Pending"></asp:ListItem>
                                    </asp:DropDownList>
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
                                <td align="right">Fax
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtfax" runat="server" CssClass="phone"></asp:TextBox>
                                </td>
                                <td align="right">DEA Number
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtdea" runat="server" MaxLength="9"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">Email
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtemail" runat="server" CssClass="required" placeholder="Email"
                                        error="Please enter the email."></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="4" align="center">
                                    <asp:Button ID="btnsave" runat="server" Text="Save" OnClientClick="javascript:return Save_Validation()" OnClick="btnsave_Click" />
                                    <asp:Button Text="Clear" ID="btnclear" runat="server" OnClientClick="javascript:return Clear_Addnew();" />
                                </td>
                            </tr>
                        </table>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
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
