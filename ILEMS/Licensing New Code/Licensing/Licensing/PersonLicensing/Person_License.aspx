<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="../Master Page/frm.master"
    CodeBehind="Person_License.aspx.cs" Inherits="Licensing.PersonLicensing.Person_License" %>

<%@ Register Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<%@ Register Src="PersonLicense_Details.ascx" TagName="PersonLicense_Details" TagPrefix="uc1" %>
<asp:Content ID="content1" runat="server" ContentPlaceHolderID="ContentPlaceHolder1">
    <style>
        .ajax__tab_default .ajax__tab_header /* this makes the tabs wrap*/ {
            white-space: normal !important;
        }
    </style>
    <script type="text/javascript">

        var disp = new sagrid();
        disp.url = "../WCFGrid/GridService.svc/GetDisplanraryInfo";

        disp.primarykeyval = "Disp_Info_ID";
        disp.bindid = "dispres";

        disp.objname = "disp";

        var dataIn = '';
        var sa5 = new sagrid();
        sa5.url = "../WCFGrid/GridService.svc/LicensingHistoryChange";

        sa5.primarykeyval = "Lic_Status_Id";
        sa5.bindid = "grdstatushistory";
        sa5.cols = [new dcol("Old Status", "Old"), new dcol("New Status", "new"), new dcol("Status Change Reason", "Reason"), new dcol("Changed Date", "Changedate"), new dcol("Changed By", "cUser")];
        sa5.objname = "sa5";

        var dataIn1 = '';
        var sa6 = new sagrid();
        sa6.url = "../WCFGrid/GridService.svc/BindLicense_Renewals";

        sa6.primarykeyval = "lic_No";
        sa6.bindid = "grdrenewals";
        sa6.cols = [new dcol("License No", "lic_No"), new dcol("Status", "Status"), new dcol("Issue Date", "Start_Dt"), new dcol("Expiration Date", "End_Dt"), new dcol("Comments", "comments")];
        sa6.objname = "sa6";
        function Popup() {
            $(function () {
                $('#buttonnew_pop').dialog({ title: 'Edit Mail Order' });
                $('#buttonnew_pop').dialog("open");
            });
        }
      
    </script>
    <script type="text/javascript">


        var dataIn = '';
        var plicense = new sagrid();
        plicense.url = "../WCFGrid/GridService.svc/BindPerson_License";

        plicense.primarykeyval = "Lic_no";
        plicense.bindid = "grdverification_list";
        plicense.objname = "plicense";
        plicense.aftercall = "AfterLicense";

        var lcontact = new sagrid();
        lcontact.url = "../WCFGrid/GridService.svc/GetRenewalContact";
        lcontact.cols = [new dcol("Order Id", "OrderID"), new dcol("Renewal Date", "Dateofsubmission"), new dcol("Contact Pereson", "Contactperson"), new dcol("Contact Phone", "Contactphone"), new dcol("Contact Email", "Contactemail")];
        lcontact.primarykeyval = "OrderID";
        lcontact.bindid = "grdrcontact";
        lcontact.objname = "lcontact";
        function print_lkp2(sender, keyval) {
            var appid = plicense.resultdata[sender]["App_Id"];
            parent.printnewcrt(2, appid);
        }
        function renewalcontact(sender, keyval)
        {
            var appid = plicense.resultdata[sender]["App_Id"];
            lcontact.data = '"appid":"' + appid + '"';
            lcontact.process();

            $('#rencnt').dialog({ title: "Renewal Conatct Info", width: "70%" });
            $('#rencnt').dialog('open');
        }
        function print_lkp(sender, keyval) {
            var appid = plicense.resultdata[sender]["App_Id"];
            parent.printothrs(2, appid);
        }
        function print_lkp1(sender, keyval) {
            var lstatus = plicense.resultdata[sender]["License_status"];

            if (lstatus != "Revoked" && lstatus != "Surrendered" && lstatus != "Administrative Hold ") {
                var appid = plicense.resultdata[sender]["App_Id"];
                parent.printcrt(2, appid);
            }
        }
        function AfterLicense() {
            var trs = plicense.resultdata;
            if (trs.length > 0) {
                
                $('#grdverification_list').find('tbody>tr').each(function (i, v) {
                    
                    if (trs[i]["AllDocumentsReceived"] == true) {
                        $(this).find('td').css({ 'color': 'red' });
                        $(this).find('td[a]').css({ 'color': 'red' });
                       
                        //$(this).find('td:eq(0)').html('<i class="fa fa-lock"></i>');
                    }
                });
                return true;
            }
           
        }
    </script>
    <script type="text/javascript">
        var cs = '';
        var sub = new sagrid();
        sub.url = "../WCFGrid/GridService.svc/Bindcontrolledsubstances";

        sub.primarykeyval = "Cert_id";
        sub.bindid = "grsubstances";

        sub.objname = "sub";
        function edit_lkp1(sender, keyval) {

            document.getElementById('<%= hfdcerti_id1.ClientID %>').value = keyval;
            document.getElementById('<%= btnedit1.ClientID %>').click();
        }
        function cnffnres1(result) {
            if (result == 'true')
                document.getElementById('<%= btndel1.ClientID %>').click();
        }
        function Delete_lkp1(sender, keyval) {
            document.getElementById('<%= hfdcerti_id1.ClientID %>').value = keyval;
            cnfbox(" Are you sure do you want to delete this record?", "cnffnres1");
        }
    </script>
    <script type="text/javascript">
        var mdataIn = '';
        var mailord = new sagrid();
        mailord.url = "../WCFGrid/GridService.svc/BindMailorders";

        mailord.primarykeyval = "Cert_id";
        mailord.bindid = "Mailordres";
        mailord.cols = [new dcol("Order #", "Certno"), new dcol("Status", "cStatus"), new dcol("Effective Date", "Effective_dt"), new dcol("Expiry Date", "Expiry_dt"), new dcol("Edit", "", "", "1", "1", "edit_lkp2", "fa fa-pencil-square-o grdicon")];
        mailord.objname = "mailord";

        function edit_lkp2(sender, keyvalue) {
            document.getElementById('<%=hfdmailid.ClientID%>').value = keyvalue;
            document.getElementById('<%= btnedit2.ClientID %>').click();
        }
    </script>
    <script>
        function afterchang() {
            Msgbox('License status information changed.');
            mailord.process();
            sub.process();
            window.location.href = window.location.href;
        }
        function chngestatus(ctl) {
            var licid = document.getElementById(ctl.id.replace('btn_changestatus', 'hfd_licid')).value;
            var curstatus = document.getElementById(ctl.id.replace('btn_changestatus', 'lbllicstatus')).innerText;
            var expdt = document.getElementById(ctl.id.replace('btn_changestatus', 'lbllicexpdate')).innerText;
            document.getElementById('<%= hfd_licid.ClientID %>').value = licid;
            document.getElementById('<%= lblCurrentStatus.ClientID %>').innerText = curstatus;
            document.getElementById('<%= txtExpiration_Date.ClientID %>').value = expdt;
            $('#btn_changestatus_pop').dialog({ title: "Change Status", width: '60%' });
            $('#btn_changestatus_pop').dialog('open');
            return false;
        }
        function ChangeLicensetype(ctl) {
            var licno = document.getElementById(ctl.id.replace('btn_changelictype', 'hfdlicno')).value;
            var lictypeid = document.getElementById(ctl.id.replace('btn_changelictype', 'hfdlictypeid')).value;
            var appid = document.getElementById(ctl.id.replace('btn_changelictype', 'hfd_Appid')).value;
            document.getElementById('<%=hfdlicensetype.ClientID%>').value = lictypeid;
            document.getElementById('<%=txt_licenseno.ClientID%>').value = licno;
            document.getElementById('<%=hfdselappid.ClientID%>').value = appid;
            
            document.getElementById('<%=txt_licenseno.ClientID%>').disabled = true;
            $('#btnchangelictype_pop').dialog({ title: "Change License Type", width: 'auto' });
            $('#btnchangelictype_pop').dialog('open');
            return false;
        }
        function chngestatusapp(ctl) {
            var licid = document.getElementById(ctl.id.replace('btn_changestatus', 'hfd_Appid')).value;
            var curstatus = document.getElementById(ctl.id.replace('btn_changestatus', 'lbllicstatus')).innerText;
            document.getElementById('<%= hfd_appid.ClientID %>').value = licid;
            document.getElementById('<%= lblCurrentappStatus.ClientID %>').innerText = curstatus;

            $('#btn_changestatusapp_pop').dialog({ title: "Change Status", width: '60%' });
            $('#btn_changestatusapp_pop').dialog('open');
            return false;
        }
        function statushistory(ctl) {

            var licid = document.getElementById(ctl.id.replace('btnstatushistory', 'hfd_licid')).value;
            dataIn = '"licid":"' + licid + '"';
            sa5.data = dataIn;

            sa5.process();
            $('#grdstatushistory').dialog({ title: "Status Change History", width: '90%' });
            $('#grdstatushistory').dialog('open');
            return false;
        }

        function renewalhistory(ctl) {

            var licid = document.getElementById(ctl.id.replace('btnrenewalhistory', 'hfd_licid')).value;
            dataIn1 = '"licid":"' + licid + '"';
            sa6.data = dataIn1;

            sa6.process();
            $('#grdrenewals').dialog({ title: "Renewal History", width: '90%' });
            $('#grdrenewals').dialog('open');
            return false;
        }
        function dispbind() {
            var pid = document.getElementById('<%= hfdperid.ClientID %>').value;
            disp.data = '"Pid":"' + pid + '"';

            disp.process();
        }
        function Popup1() {
            $(function () {
                $('#btnnew1_pop').dialog({ title: 'Edit Controlled Substances' });
                $('#btnnew1_pop').dialog("open");
            });
        }
        function Clear1() {


            document.getElementById('<%=ddl_status1.ClientID %>').value = '-1';

            document.getElementById('<%=effective_date1.ClientID %>').value = '';
            document.getElementById('<%=exp_date1.ClientID %>').value = '';
            document.getElementById('<%=hfdcerti_id1.ClientID %>').value = "0";
            return false;

        }

        function Clear_MailOrderValues() {
            document.getElementById('<%=ddlmailorderstatus.ClientID %>').value = '-1';
            document.getElementById('<%=txteffectivedate.ClientID %>').value = "";
            document.getElementById('<%=txtexpirydate.ClientID %>').value = "";
            document.getElementById('<%=hfdmailid.ClientID %>').value = "0";
        }
        function Save_Validation1() {
            var errormsg = validateform('frmfld1');
            if (errormsg != "") {
                Msgbox(errormsg);
                return false;
            }
            return true;
        }
        function Save_Validation() {
            var errormsg = validateform('frmfld');
            if (errormsg != "") {
                Msgbox(errormsg);
                return false;
            }
            return true;
        }
        function afterpost(msg) {
            $('#btnnew1_pop').dialog('close');
            $('#buttonnew_pop').dialog('close');
            $('#btnnew2_pop').dialog("close");
            Interview.process();
            sub.process();
            mailord.process();
            altbox(msg);

        }
        function afterlicensetypechange(msg) {
            $('#btnchangelictype_pop').dialog('close');
            $('#btnalert_Pop').find('li').text(msg);
            $('#btnalert_Pop').dialog({ title: "Alert Message", width: 'auto' });
            $('#btnalert_Pop').dialog('open');
        }
        $(document).ready(function () {
            $('#btnok').click(function () {
                $('#btnalert_Pop').dialog('close');
                window.location.reload(true);
            });
        });
        function Validatestatus() {
            if (document.getElementById('<%=ddlnewappstatus.ClientID%>').value == "-1") {
                altbox("Please select new status.");
                document.getElementById('<%=ddlnewappstatus.ClientID%>').focus()
                return false;
            }
        }
        function ClearStatusValues() {
            document.getElementById('<%=ddlnewappstatus.ClientID%>').value = "-1";
            document.getElementById('<%=ddlappreason.ClientID%>').value = "-1";
            document.getElementById('<%=txtappdt.ClientID%>').value = "";
            return false;
        }
        function ValidateLicenseType() {
            if (document.getElementById('<%=ddl_buslictypes.ClientID%>').value == '-1') {
                altbox("Please select new license type.")
                document.getElementById('<%=ddl_buslictypes.ClientID%>').focus()
                 return false;
             }
         }
         function ClearLicensetype() {
             document.getElementById('<%=ddl_buslictypes.ClientID%>').value = '-1';
        }
        function BindGridByUsingPersonid() {

            var chekcboxlistitems = '';
            var chk = document.getElementById('<%=chklictypes.ClientID%>');
            var chkinput = chk.getElementsByTagName('input');
            var listoflables = chk.getElementsByTagName('span')
            for (var i = 0; i < chkinput.length; i++) {
                if (chkinput[i].checked) {
                    if (chekcboxlistitems == '')
                        chekcboxlistitems = listoflables[i].attributes["app_id"].value;
                    else
                        chekcboxlistitems += ',' + listoflables[i].attributes["app_id"].value;
                }
            }
            cs = '"pid":"' + document.getElementById('<%= hfdperid.ClientID %>').value + '",';
            cs = cs + '"appid":"' + chekcboxlistitems + '"';

            sub.data = cs;
            sub.process();
        }
        var atLeast = 1
        function ValidateSchedules() {
            if (document.getElementById('<%=ddl_schedulelicensetype.ClientID%>').value == '-1') {
                altbox("Please select license type");
                return false;
            }
            var CHK = document.getElementById("<%=chkschedules.ClientID%>");
            var checkbox = CHK.getElementsByTagName("input");
            var counter = 0;
            for (var i = 0; i < checkbox.length; i++) {
                if (checkbox[i].checked) {
                    counter++;
                }
            }
            if (atLeast > counter) {
                altbox("Please select schedule.");
                return false;
            }
           
        }
        function ClearSchedules() {
            var cbl = document.getElementById('<%=chkschedules.ClientID %>').getElementsByTagName("input");
            for (i = 0; i < cbl.length; i++) cbl[i].checked = false;
            return false;
        }
    </script>
    <script type="text/javascript">


       
        var InterviewDataIn = '';
        var Interview = new sagrid();
        Interview.url = "../WCFGrid/GridService.svc/Bindinterview";
        Interview.primarykeyval = "Auid";
        Interview.bindid = "grd2";
        Interview.objname = "Interview";

       


       
        function editinterview_lkp1(sender, keyval) {
            document.getElementById('<%=hfdauid.ClientID%>').value = keyval;
            document.getElementById('<%=btninterviewedit.ClientID%>').click();
        }
        function Deleteinterview_lkp1(sender, keyval) {
            document.getElementById('<%=hfdauid.ClientID%>').value = keyval;
            cnfbox(" Are you sure do you want to delete this record?", "cnffnres2");
        }
        function cnffnres2(result) {
            if (result == 'true')
                document.getElementById('<%= btninterviewdel.ClientID %>').click();
        }
        function Popup2() {
            $('#btnnew2_pop').dialog({ title: 'Edit Interview Details' });
            $('#btnnew2_pop').dialog("open");
        }
         function Clear2()
            {
                document.getElementById('<%= ddllictype.ClientID %>').value = "-1";
                document.getElementById('<%= txt_date.ClientID %>').value = "";
                document.getElementById('<%= rdblawful.ClientID %>').value = "";
                document.getElementById('<%=hfdauid.ClientID%>').value = '0';
                return false;
            }
    </script>
    <div id="rencnt" class="popup">
        <div id="grdrcontact"></div>
    </div>
    <div style="width: 98%; margin-left: auto; margin-right: auto">
        <div class="cpanel">
            <div class="head accr expand">
                Licensing
            </div>
            <div class="body">
                <div id="grdstatushistory" class="popup">
                </div>
                <div id="grdrenewals" class="popup">
                </div>
                <asp:HiddenField ID="hfdlicid" runat="server" Value="0" />
                <asp:HiddenField ID="hfdperid" runat="server" Value="0" />
                <asp:HiddenField ID="hfdobjtype" runat="server" Value="0" />
                <div id="grdverification_list">
                </div>
                <asp:UpdatePanel ID="updtab" runat="server">
                    <ContentTemplate>
                        <ajaxToolkit:TabContainer runat="server" ID="lic_Tabs" CssClass="Tab" EnableViewState="true"
                            Width="98%" OnInit="lic_Tabs_Init">
                        </ajaxToolkit:TabContainer>
                    </ContentTemplate>
                </asp:UpdatePanel>
                <div id='btn_changestatusapp_pop' class="popup" style="display: none;">
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                            <asp:HiddenField ID="hfd_appid" runat="server" Value="0" />
                            <table width="100%" cellpadding="5" cellspacing="5">
                                <tr>
                                    <td align="right">Current Status
                                    </td>
                                    <td align="left">
                                        <asp:Label ID="lblCurrentappStatus" runat="server"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">New Status
                                    </td>
                                    <td align="left">
                                        <asp:DropDownList ID="ddlnewappstatus" runat="server" onclick="setexpdt(this)">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">Reason
                                    </td>
                                    <td align="left">
                                        <asp:DropDownList ID="ddlappreason" runat="server">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">Date Of Change
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="txtappdt" runat="server"></asp:TextBox>
                                    </td>
                                </tr>


                                <tr>
                                    <td colspan="2">
                                        <table width="70%" align="center">
                                            <tr>
                                                <td align="center">
                                                    <asp:Button ID="Button1" runat="server" Text="Change Status" OnClick="update_appsattus" OnClientClick="javascript:return Validatestatus();" /><%--OnClientClick="javascript:return Newchangestatusvalidate(this)" --%>
                                                    <asp:Button ID="btnclear" runat="server" Text="Clear" OnClientClick="javascript:return ClearStatusValues();" />

                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
                <div id='btn_changestatus_pop' class="popup" style="display: none;">
                    <asp:UpdatePanel ID="updchng" runat="server">
                        <ContentTemplate>
                            <asp:HiddenField ID="hfd_licid" runat="server" Value="0" />
                            <table width="100%" cellpadding="5" cellspacing="5">
                                <tr>
                                    <td align="right">Current Status
                                    </td>
                                    <td align="left">
                                        <asp:Label ID="lblCurrentStatus" runat="server"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">New Status
                                    </td>
                                    <td align="left">
                                        <asp:DropDownList ID="ddlnewstatus" runat="server" onclick="setexpdt(this)">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">Reason
                                    </td>
                                    <td align="left">
                                        <asp:DropDownList ID="ddlReason" runat="server">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">Date Of Change
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="txtDateOfChange" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">Expiration Date
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="txtExpiration_Date" runat="server"></asp:TextBox>
                                    </td>
                                </tr>

                                <tr>
                                    <td colspan="2">
                                        <table width="70%" align="center">
                                            <tr>
                                                <td align="center">
                                                    <asp:Button ID="btnchangestatus" OnClick="Update_License" runat="server" Text="Change Status" /><%--OnClientClick="javascript:return Newchangestatusvalidate(this)" --%>
                                                    <asp:Button ID="btncancel1" runat="server" Text="Clear" OnClick="btncancel1_Click" />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
                <div class="popup" id="btnchangelictype_pop" style="display: none">
                    <asp:UpdatePanel ID="updchangelictype" runat="server">
                        <ContentTemplate>
                            <asp:HiddenField ID="hfdlicensetype" runat="server" Value="0" />
                             <asp:HiddenField ID="hfdselappid" runat="server" Value="0" />
                            <table class="spac">
                                <tr>
                                    <td align="right">License #
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="txt_licenseno" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">Change To License Type
                                    </td>
                                    <td align="left">
                                        <asp:DropDownList ID="ddl_buslictypes" runat="server"></asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2" align="center">
                                        <asp:Button ID="btnchangelictypesave" runat="server" Text="Submit" OnClick="btnchangelictypesave_Click" OnClientClick="javascript:return ValidateLicenseType();" />&nbsp;
                                        <asp:Button ID="btnchangelictypeclear" runat="server" Text="Clear" OnClientClick="javascript:return ClearLicensetype();" />
                                    </td>
                                </tr>
                            </table>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
                <div id="btnalert_Pop" class="popup" style="display: none">
                    <div>
                        <ul>
                            <li></li>
                        </ul>
                        <center>
                            <input type="button" value="Ok" name="ok" id="btnok" />
                        </center>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div style="width: 98%; margin-left: auto; margin-right: auto">
        <div class="cpanel">
            <div class="head accr">
                Controlled Substances
            </div>
            <div class="body">
                <asp:UpdatePanel ID="upd2" runat="server">
                    <ContentTemplate>
                        <asp:HiddenField ID="hfdcerti_id1" runat="server" Value="0" />
                        <asp:HiddenField ID="hfdselid1" runat="server" Value="0" />
                        <asp:Button ID="btnedit1" runat="server" Style="display: none" OnClick="btnedit1_click" />
                        <asp:Button ID="btndel1" runat="server" Style="display: none" OnClick="btndel1_click" />
                    </ContentTemplate>
                </asp:UpdatePanel>
                <div style="text-align: right; padding-right: 10px; margin-top: 0px">
                    <input type="button" id="btnnew1" value="Add New" class="poptrg" onclick="javascript: return Clear1()" />
                </div>
                <br />
                <div style="text-align: center">
                    <center>
                        <asp:CheckBoxList ID="chklictypes" runat="server" RepeatDirection="Horizontal" onclick="javascript:return BindGridByUsingPersonid();"></asp:CheckBoxList></center>
                </div>
                <br />
                <div id='btnnew1_pop' class="popup" style="display: none;">
                    <span class="title">Add New</span>
                    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                        <ContentTemplate>
                            <table align="center" class="spac" id="frmfld1">
                                <tr>
                                    <td align="right">License Type
                                    </td>
                                    <td align="left">
                                        <asp:DropDownList ID="ddl_licensetype" runat="server">
                                        </asp:DropDownList>

                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">Status
                                    </td>
                                    <td align="left">
                                        <asp:DropDownList ID="ddl_status1" runat="server" CssClass="required" placeholder="Status"
                                            error="Please select the status.">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">Effective Date
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="effective_date1" runat="server" class="required date" placeholder="Effective Date"
                                            error="Please enter effective date."></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">Expire Date
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="exp_date1" runat="server" class="required date" placeholder="Expire Date"
                                            error="Please enter expire date."></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center" colspan="2">
                                        <asp:Button ID="btn_addcontrolsubstances" runat="server" Text="Submit" OnClick="btn_addcontrolsubstances_Click"
                                            OnClientClick="javascript:return Save_Validation1();" />
                                        <asp:Button ID="btn_clear1" runat="server" Text="Clear" OnClientClick="javascript:return Clear1();" />
                                    </td>
                                </tr>
                            </table>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
                <div id="grsubstances">
                </div>
            </div>
        </div>
        <div class="cpanel" id="mailorder" runat="server" style="display: none;">
            <div class="head accr">
                Mail Order Permits
            </div>
            <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                <ContentTemplate>
                    <asp:HiddenField ID="hfdmailid" runat="server" Value="0" />
                    <asp:HiddenField ID="HiddenField2" runat="server" Value="0" />
                    <asp:Button ID="btnedit2" runat="server" Style="display: none" OnClick="btnedit2_Click" />
                </ContentTemplate>
            </asp:UpdatePanel>
            <div class="body">
                <div style="text-align: right; padding-right: 10px; margin-top: 0px">
                    <input type="button" id="buttonnew" value="Add New" class="poptrg" />
                </div>
                <br />
                <div id="Mailordres">
                </div>
                <div class="popup" id="buttonnew_pop" style="display: none;">
                    <span class="title">Add New Mail Order</span>
                    <asp:UpdatePanel ID="upd3" runat="server">
                        <ContentTemplate>
                            <table align="center" class="spac" id="frmfld">
                                <tr>
                                    <td align="right">Status
                                    </td>
                                    <td align="left">
                                        <asp:DropDownList ID="ddlmailorderstatus" runat="server" CssClass="required" error="Please select status.">
                                        </asp:DropDownList>

                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">Effective Date
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="txteffectivedate" runat="server" CssClass="required date" error="Please enter effective date."></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">Expiry Date
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="txtexpirydate" runat="server" CssClass="date"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center" colspan="2">
                                        <asp:CheckBox ID="chknotnew" runat="server" Text="Not New" />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2" align="center">
                                        <asp:Button ID="btnmaiordersubmit" runat="server" Text="Submit" OnClick="btnmailordersubmit_Click" OnClientClick="javascript:return Save_Validation();" />
                                        <asp:Button ID="btnmailorderclear" runat="server" Text="Clear" OnClientClick="javascript:return Clear_MailOrderValues();" />
                                    </td>
                                </tr>
                            </table>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
            </div>
        </div>
        <div class="cpanel">
            <div class="head accr">
                Discipline Info
            </div>
            <asp:UpdatePanel ID="upddisp1" runat="server">
                <ContentTemplate>
                    <asp:HiddenField ID="hfdauid_disp" runat="server" Value="0" />
                    <asp:Button ID="btndel_disp" runat="server" Style="display: none" OnClick="btndel_disp_click" />
                </ContentTemplate>
            </asp:UpdatePanel>
            <div class="body">
                <div style="text-align: right; margin: 10px">
                    <input type="button" id="btnnew" class="poptrg" onclick="javascript: return disp_Addnew()"
                        value="Add New" />
                </div>
                <div id="dispres">
                </div>
                <div id="dispop" class="popup">
                    <asp:UpdatePanel ID="upddisp" runat="server">
                        <ContentTemplate>

                            <table class="spac" id="disptbl">
                                <tr>
                                    <td align="right">Complaint # :
                                    </td>
                                    <td align="left">
                                        <asp:DropDownList ID="ddlcmp" runat="server">
                                        </asp:DropDownList>
                                    </td>
                                    <td align="right">Is Discipline :
                                    </td>
                                    <td align="left">
                                        <asp:CheckBox ID="chbdisp" runat="server" />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">Start Date :
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="txtdispsdt" runat="server" CssClass="date required" error="Please Enter Start Date"></asp:TextBox>
                                    </td>
                                    <td align="right">End Date :
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="txtdispenddt" runat="server" CssClass="date required" error="Please Enter End Date"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Comments :
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="4">
                                        <asp:TextBox ID="txtdispcmnt" runat="server" TextMode="MultiLine" Width="98%" Height="50px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="4" align="center">
                                        <asp:Button ID="btndispsave" runat="server" Text="Save" OnClick="btnsave_disp" OnClientClick="javascript:return validate_disp()" />
                                        &nbsp;
                            <asp:Button ID="btndispclear" runat="server" Text="Clear" OnClientClick="javascript:return Clear_Disp();" />

                                    </td>
                                </tr>
                            </table>
                            <div id="myprofilepopup" class="popup" style="display: none">
                                <iframe id="iframeprofile" width="100%" height="500px" frameborder="0"></iframe>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
            </div>
        </div>
    </div>
    <div style="width: 98%; margin-left: auto; margin-right: auto">
        <div class="cpanel">
            <div class="head accr">
                Schedule
            </div>
            <div class="body">
                <asp:UpdatePanel ID="upd6" runat="server">
                    <ContentTemplate>
                        <table class="spac" align="center" id="sections">
               
                    <tr>
                        <td align="right">
                            License Type
                        </td>
                        <td align="center">
                            <asp:DropDownList ID="ddl_schedulelicensetype" runat="server" OnSelectedIndexChanged="ddl_licensetype_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
                            </td>
                        <td align="right">Schedule
                        </td>
                        <td align="left">
                            <asp:CheckBoxList ID="chkschedules" runat="server" RepeatDirection="Horizontal" RepeatColumns="6"></asp:CheckBoxList>
                        </td>
                    </tr>
                    <tr>
                        <td align="center" colspan="4">
                            <asp:Button ID="btnschedulesubmit" runat="server" Text="Submit" OnClick="btnschedulesubmit_Click" OnClientClick="javascript:return ValidateSchedules();" />&nbsp;
                           <asp:Button ID="btnscheduleclear" runat="server" Text="Clear" OnClientClick="javascript:return ClearSchedules();" />
                        </td>
                    </tr>
                </table>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
        </div>
    </div>
    <div style="width: 98%; margin-left: auto; margin-right: auto">
        <div class="cpanel">
            <div class="head accr">
                Interview Details
                <asp:UpdatePanel ID="upd" runat="server">
                    <ContentTemplate>
                        <asp:HiddenField ID="hfdauid" runat="server" Value="0" />
                       
                        <asp:Button ID="btninterviewedit" runat="server" Style="display: none"  OnClick="btninterviewedit_Click"/>
                        <asp:Button ID="btninterviewdel" runat="server" Style="display: none"  OnClick="btninterviewdel_Click"/>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
            <div class="body">
                <div style="text-align: right; padding-right: 10px; margin-top: 0px">
                    <input type="button" id="btnnew2" value="Add New" class="poptrg" onclick="javascript:return Clear2();" />
                </div>
                <br />
                <div id="grd2"></div>
                <div id='btnnew2_pop' class="popup" style="display: none;">
                    <span class="title">Person Interview Details</span>
                    <asp:UpdatePanel ID="upd1" runat="server">
                        <ContentTemplate>
                            <table align="center" class="spac" id="frmfld2">
                                <tr>
                                    <td align="right">License Type
                                    </td>
                                    <td align="left">
                                        <asp:DropDownList ID="ddllictype" runat="server">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                
                                <tr>
                                    <td align="right"> Date
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="txt_date" runat="server" placeholder=" Date" class="date"
                                            error="Please enter  date."></asp:TextBox>
                                    </td>
                                </tr>
                               
                                <tr>
                                    <td align="right">
                                        Attended
                                    </td>
                                    <td align="left">
                                       <asp:RadioButtonList ID="rdblawful" runat="server" RepeatColumns="2">
                                                <asp:ListItem Value="1" >Yes</asp:ListItem>
                                                <asp:ListItem Value="0" >No</asp:ListItem>
                                            </asp:RadioButtonList>
                                    </td>
                                </tr>


                                <tr>
                                    <td align="center" colspan="2">
                                        <asp:Button ID="btn_submit" runat="server" Text="Save" OnClick="btn_submit_Click"
                                            OnClientClick="javascript:return Save_Validation2();" />
                                        <asp:Button ID="btn_clear" runat="server" Text="Clear" OnClientClick="javascript:return Clear2();" />
                                    </td>
                                </tr>
                            </table>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        var isedit = $('#ctl00_hfdwrite').val();
        var isdel = $('#ctl00_hfddel').val();
        if (isedit == 'False') {
            $('#btnnew1').addClass('hide');
            $('#btnnew').addClass('hide');
            $('#btnnew2').addClass('hide');
            $('#ctl00_ContentPlaceHolder1_lic_Tabs_ctl00_ctl00_btn_changestatus').addClass('hide');
        }
        if (isedit == 'True' && isdel == 'True') {
            if (document.getElementById('<%= hfdobjtype.ClientID %>').value == 1) {
                plicense.cols = [new dcol("License #", "Lic_no"), new dcol("Type", "License_Type"), new dcol("Issue Date", "Issued_Date"), new dcol("Exp Date", "Expired_Date"), new dcol("Obtained By", "obtby"), new dcol("Print", "", "", "1", "1", "print_lkp", "fa fa-print grdicon"), new dcol("Certificate", "", "", "1", "1", "print_lkp1", "fa fa-print grdicon"), new dcol("NewCertificate", "", "", "1", "1", "print_lkp2", "fa fa-print grdicon"), new dcol("More Profile", "", "", "1", "1", "showprofile", "fa fa-hand-o-up grdicon")];
            }
            else {
                plicense.cols = [new dcol("License #", "Lic_no"), new dcol("Type", "License_Type"), new dcol("Issue Date", "Issued_Date"), new dcol("Exp Date", "Expired_Date"), new dcol("Print", "", "", "1", "1", "print_lkp", "fa fa-print grdicon"), new dcol("Certificate", "", "", "1", "1", "print_lkp1", "fa fa-print grdicon"), new dcol("NewCertificate", "", "", "1", "1", "print_lkp2", "fa fa-print grdicon"), new dcol("More Profile", "", "", "1", "1", "showprofile", "fa fa-hand-o-up grdicon"), new dcol("Renewal Contact", "", "", "1", "1", "renewalcontact", "fa fa-hand-o-up grdicon", "50px")];
            }
        }
        else
            if (isedit == 'False') {
                if (document.getElementById('<%= hfdobjtype.ClientID %>').value == 1) {
                    plicense.cols = [new dcol("License #", "Lic_no"), new dcol("Type", "License_Type"), new dcol("Issue Date", "Issued_Date"), new dcol("Exp Date", "Expired_Date"), new dcol("Obtained By", "obtby"), new dcol("Print", "", "", "1", "1", "print_lkp", "fa fa-print grdicon"), new dcol("Certificate", "", "", "1", "1", "print_lkp1", "fa fa-print grdicon"), new dcol("NewCertificate", "", "", "1", "1", "print_lkp2", "fa fa-print grdicon")];
                }
                else {
                    plicense.cols = [new dcol("License #", "Lic_no"), new dcol("Type", "License_Type"), new dcol("Issue Date", "Issued_Date"), new dcol("Exp Date", "Expired_Date"), new dcol("Print", "", "", "1", "1", "print_lkp", "fa fa-print grdicon"), new dcol("Certificate", "", "", "1", "1", "print_lkp1", "fa fa-print grdicon"), new dcol("NewCertificate", "", "", "1", "1", "print_lkp2", "fa fa-print grdicon"), new dcol("Renewal Contact", "", "", "1", "1", "renewalcontact", "fa fa-hand-o-up grdicon", "50px")];
                }
            }
        
        if (isedit == 'True' && isdel == 'True') {
            sub.cols = [new dcol("License Type", "License_Type_ID"), new dcol("License Number", "Lic_no"), new dcol("Status", "cStatus"), new dcol("Effective Date", "Effective_dt"), new dcol("Expiry Date", "Expiry_dt"), new dcol("Edit", "", "", "1", "1", "edit_lkp1", "fa fa-pencil-square-o grdicon"), new dcol("Delete", "", "", "1", "1", "Delete_lkp1", "fa fa-trash-o grdicon")];
            disp.cols = [new dcol("Complaint #", "Complaint_Number"), new dcol("Start Date", "Start_Date"), new dcol("End Date", "End_Date"), new dcol("Comments", "Comments"), new dcol("Public Info", "IS_Discipline"), new dcol("Edit", "", "", "1", "1", "edit_disp", "fa fa-pencil-square-o grdicon"), new dcol("Delete", "", "", "1", "1", "Delete_disp", "fa fa-trash-o grdicon")];
            Interview.cols = [new dcol("License Type", "License_Type"), new dcol("Interview Date", "Interview_Date"), new dcol("Attended", "Appoved"), new dcol("Edit", "", "", "1", "1", "editinterview_lkp1", "fa fa-pencil-square-o grdicon"), new dcol("Delete", "", "", "1", "1", "Deleteinterview_lkp1", "fa fa-trash-o grdicon")];

        }
        else if (isedit == 'True') {
            sub.cols = [new dcol("License Type", "License_Type_ID"), new dcol("License Number", "Lic_no"), new dcol("Status", "cStatus"), new dcol("Effective Date", "Effective_dt"), new dcol("Expiry Date", "Expiry_dt"), new dcol("Edit", "", "", "1", "1", "edit_lkp1", "fa fa-pencil-square-o grdicon")];
            disp.cols = [new dcol("Complaint #", "Complaint_Number"), new dcol("Start Date", "Start_Date"), new dcol("End Date", "End_Date"), new dcol("Comments", "Comments"), new dcol("Public Info", "IS_Discipline"), new dcol("Edit", "", "", "1", "1", "edit_disp", "fa fa-pencil-square-o grdicon")];
            Interview.cols = [new dcol("License Type", "License_Type"), new dcol("Interview Date", "Interview_Date"), new dcol("Attended", "Appoved"), new dcol("Edit", "", "", "1", "1", "editinterview_lkp1", "fa fa-pencil-square-o grdicon")];
        }
        else if (isdel == 'True') {
            sub.cols = [new dcol("License Type", "License_Type_ID"), new dcol("License Number", "Lic_no"), new dcol("Status", "cStatus"), new dcol("Effective Date", "Effective_dt"), new dcol("Expiry Date", "Expiry_dt"), new dcol("Delete", "", "", "1", "1", "Delete_lkp1", "fa fa-trash-o grdicon")];
            disp.cols = [new dcol("Complaint #", "Complaint_Number"), new dcol("Start Date", "Start_Date"), new dcol("End Date", "End_Date"), new dcol("Comments", "Comments"), new dcol("Public Info", "IS_Discipline"), new dcol("Delete", "", "", "1", "1", "Delete_disp", "fa fa-trash-o grdicon")];
            Interview.cols = [new dcol("License Type", "License_Type"), new dcol("Interview Date", "Interview_Date"), new dcol("Attended", "Appoved"), new dcol("Delete", "", "", "1", "1", "Deleteinterview_lkp1", "fa fa-trash-o grdicon")];
        }
        else {
            sub.cols = [new dcol("License Type", "License_Type_ID"), new dcol("License Number", "Lic_no"), new dcol("Status", "cStatus"), new dcol("Effective Date", "Effective_dt"), new dcol("Expiry Date", "Expiry_dt")];
            disp.cols = [new dcol("Complaint #", "Complaint_Number"), new dcol("Start Date", "Start_Date"), new dcol("End Date", "End_Date"), new dcol("Comments", "Comments"), new dcol("Public Info", "IS_Discipline")];
            Interview.cols = [new dcol("License Type", "License_Type"), new dcol("Interview Date", "Interview_Date"), new dcol("Attended", "Appoved")];
        }
    </script>
    <script type="text/javascript">
        function validate_disp() {

            var errormsg = validateform('disptbl');
            if (errormsg != "") {
                Msgbox(errormsg);
                return false;
            }
            return true;
        }
        function Clear_Disp() {
            document.getElementById('<%=chbdisp.ClientID%>').checked = false;
            document.getElementById('<%=txtdispsdt.ClientID%>').value = '';
            document.getElementById('<%=txtdispenddt.ClientID%>').value = '';
            document.getElementById('<%=txtdispcmnt.ClientID%>').value = '';
            return false;
        }
        function edit_disp(sender, keyval) {
            document.getElementById('<%= hfdauid_disp.ClientID %>').value = keyval;
            if (disp.resultdata[sender]["IS_Discipline"] == 'Yes')
                document.getElementById('<%= chbdisp.ClientID %>').checked = true;
            else
                document.getElementById('<%= chbdisp.ClientID %>').checked = false;
            document.getElementById('<%= txtdispsdt.ClientID %>').value = disp.resultdata[sender]["Start_Date"];
            document.getElementById('<%= txtdispenddt.ClientID %>').value = disp.resultdata[sender]["End_Date"];
            document.getElementById('<%= txtdispcmnt.ClientID %>').value = disp.resultdata[sender]["Comments"];
            if (disp.resultdata[sender]["Complaint_Number"] != '-1' && disp.resultdata[sender]["Complaint_Number"] != '')
                document.getElementById('<%= ddlcmp.ClientID %>').value = disp.resultdata[sender]["Complaint_Number"];
            $('#dispop').dialog({ title: "Edit Discipline Info" });
            $('#dispop').dialog('open');


        }
        function afterdisp() {
            dispbind();
            $('#dispop').dialog('close');

        }
        function cnffnres_disp(result) {
            if (result == 'true')
                document.getElementById('<%= btndel_disp.ClientID %>').click();
        }

        function Delete_disp(sender, keyval) {
            document.getElementById('<%= hfdauid_disp.ClientID %>').value = keyval;
            cnfbox(" Are you sure do you want to delete this record?", "cnffnres_disp");
        }
        function disp_Addnew() {
            document.getElementById('<%= hfdauid_disp.ClientID %>').value = '0';
            document.getElementById('<%= ddlcmp.ClientID %>').value = '-1';
            document.getElementById('<%= chbdisp.ClientID %>').checked = false;
            document.getElementById('<%= txtdispsdt.ClientID %>').value = '';
            document.getElementById('<%= txtdispenddt.ClientID %>').value = '';
            document.getElementById('<%= txtdispcmnt.ClientID %>').value = '';
            $('#dispop').dialog({ title: "New Discipline Info" });
            $('#dispop').dialog('open');


        }
    </script>
    <script type="text/javascript">
        function showprofile(sender, keyval) {
            var ctl = parent.document.getElementsByTagName('body');
             var olnk = '<%= System.Configuration.ConfigurationManager.AppSettings["onlinelink"].ToString() %>';
            $('#iframeprofile').attr('src', olnk+'ProfileRedirect.aspx?id=' + $('[id$=hfdobjtype]').val() + '&pid=' + $('[id$=hfdperid]').val() + '&licid=' + plicense.resultdata[sender].License_ID);
            $('#myprofilepopup').dialog({ title: "My Profile", width: "99%" });
            $('#myprofilepopup').dialog('open');
        }

        dataIn = '"pid":"' + document.getElementById('<%= hfdperid.ClientID %>').value + '"';
        plicense.data = dataIn;
        plicense.process();
    </script>
    <script type="text/javascript">

        dataIn = '"pid":"' + document.getElementById('<%= hfdperid.ClientID %>').value + '"';

        mailord.data = dataIn;
        mailord.process();
        dispbind();
    </script>
    <script type="text/javascript">
        cs = '"pid":"' + document.getElementById('<%= hfdperid.ClientID %>').value + '",';
        cs = cs + '"appid":""';
        sub.data = cs;
        sub.process();

         InterviewDataIn = '"personid":"' + document.getElementById('<%= hfdperid.ClientID %>').value + '"';
        Interview.data = InterviewDataIn;
        Interview.process();
    </script>
</asp:Content>
