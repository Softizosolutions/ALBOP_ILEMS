<%@ Page Language="C#" MasterPageFile="~/PersonLicensing/Person.Master" AutoEventWireup="true"
    CodeBehind="PersonDetails.aspx.cs" Inherits="Licensing.PersonDetails" %>

<%@ Register TagPrefix="uCtl" TagName="UserControl1" Src="~/PersonLicensing/test.ascx" %>
<asp:Content ID="content1" runat="server" ContentPlaceHolderID="cntmain">
    <script type="text/javascript">
        function Popup() {
            $(function () { $('#lnkbtnview1_pop').dialog("open"); });
        }
        function Popup1() {
            $(function () { $('#lnkbtnnoalert_pop').dialog("open"); });
        }
        function openchk(pid, rid) {
            //window.open("https://dashboard.checkr.com/candidates/" + pid + "/reports/" + rid);
            window.open("https://knowmyhire.secure-screening.net/escreening/loginentrance.asp");
        }
    </script>
    <script>
        var sa6 = new sagrid();
        sa6.url = "../WCFGrid/GridService.svc/BindPersonAlerthistory";

        sa6.primarykeyval = "Journal_Id";
        sa6.bindid = "grdalthis";
        sa6.cols = [new dcol("Journal Type", "Journal_Type"), new dcol("Journal Notes", "Description", "", "-1"), new dcol("Alert Created", "alert_created"), new dcol("Created By", "releasedby"), new dcol("Alert Released", "alert_released"), new dcol("Released By", "alert_releasedby")];
        sa6.objname = "sa6";
        function Bindalert_his() {
            var dataIn1 = '';
            dataIn1 = '"pid":"' + document.getElementById('<%= hfdpid.ClientID %>').value + '"';
            sa6.data = dataIn1;
            sa6.process();
            $('#grdalthis').dialog({ title: "Alert Release History", width: "70%" });
            $('#grdalthis').dialog('open');

        }
    </script>
    <script type="text/javascript">
        function clsalrt() {
            $('#grdalerts').dialog('close');
            altbox('Alert released.');

        }
        function chkalrt() {

            dataIn = '';
            dataIn = '"pid":"' + document.getElementById('<%= hfdpid.ClientID %>').value + '"';
            sa5.data = dataIn;

            sa5.process();

        }
        function setalt() {

            var trs = sa5.resultdata;
            if (trs.length > 0) {
                if (!$('#alrt').hasClass('fa-exclamation-triangle')) {
                    $('#alrt').addClass('fa-exclamation-triangle');
                    $('#alrt').click();
                }
               
            }
            else {

                $('#alrt').removeClass('fa-exclamation-triangle');
            }
        }
        var dataIn = '';
        var sa5 = new sagrid();
        sa5.url = "../WCFGrid/GridService.svc/BindPersonAlert";

        sa5.primarykeyval = "Journal_Id";
        sa5.bindid = "grdalerts";
        sa5.cols = [new dcol("Journal Type", "Journal_Type"), new dcol("Journal Notes", "Description", "", "-1"), new dcol("Alert Created", "CreatedDate"), new dcol("Created By", "uname"), new dcol("Release", "", "", "1", "1", "edit_lkp", "fa fa-unlock grdicon")];
        sa5.objname = "sa5";
        sa5.aftercall = "setalt";
        function cnffnres() {
            document.getElementById('<%= btnrelease.ClientID %>').click();
        }
        function edit_lkp(sender, keyval) {
            document.getElementById('<%= hfdaltid.ClientID %>').value = keyval;
            cnfbox(" Are you sure do you want to Release Alert?", "cnffnres");
        }
        function Bindalert() {
            dataIn = '';
            dataIn = '"pid":"' + document.getElementById('<%= hfdpid.ClientID %>').value + '"';
            sa5.data = dataIn;
            sa5.process();
            $('#grdalerts').dialog({ title: "Alert History", width: "70%", minHeight: 250 });
            $('#grdalerts').dialog('open');

        }


        function open_edit(perid) {
            // document.getElementById('iframeedit').getElementsByTagName('tbody')[0].innerHTML = ''; hfdpid.Value
            // altbox(perid);
            document.getElementById('iframeedit').src = "../PersonLicensing/EditDemographiceNew_Person.aspx?Person_id=" + perid;
            $('#Editdemo_pop').dialog({ title: "Edit Demographics", width: '90%' });
            $('#Editdemo_pop').dialog("open");

            return false;

        }

    </script>
    <asp:HiddenField ID="hfdiscmp" runat="server" Value="0" />
    <asp:HiddenField ID="hfdpid" runat="server" Value="0" />
    <asp:UpdatePanel ID="updalrt" runat="server">
        <ContentTemplate>
            <asp:HiddenField ID="hfdaltid" runat="server" Value="0" />
            <asp:Button ID="btnrelease" runat="server" Style="display: none" OnClick="btnrel_click" />
        </ContentTemplate>
    </asp:UpdatePanel>
    <div class="cpanel">
        <div class="head accr expand">
            <asp:Label ID="lblnmhead" runat="server"></asp:Label>
            Personal Information <i class="fa fa-print pull-right" onclick="openfrm(1)"></i>
            <i id="alrt" onclick="javascript:return Bindalert();" class="fa  pull-right"></i>
            <i onclick="javascript:return Bindalert_his();" class="fa fa-bell pull-right"></i>
        </div>
        <div class="body">
            <table width="99%" class="spac">
                <tr height="30px">
                    <td align="right">
                        <b>Name :</b>
                    </td>
                    <td align="left" width="18%">
                        <asp:LinkButton ID="lbl_name" runat="server"></asp:LinkButton>
                    </td>
                    <td align="right">
                        <b>Address1:</b>
                    </td>
                    <td align="left">
                        <asp:Label ID="lbl_addr1" runat="server" Text=""></asp:Label>
                    </td>
                    <td align="right">
                        <b>Social Security Number:</b>
                    </td>
                    <td align="left">
                        <asp:Label ID="lbl_ssn" runat="server" Text=""></asp:Label>
                    </td>

                </tr>
                <tr height="30px">

                    <td align="right">
                     <b>  <asp:Label ID="lbllicnnumber" runat="server" Text="License Details :"></asp:Label></b>
                    </td>

                    <td align="left">
                        <asp:Label ID="lbl_licnum" runat="server" Text=""></asp:Label>
                    </td>
                    <td align="right">
                        <b>Address2 :</b>
                    </td>
                    <td align="left">
                        <asp:Label ID="lbl_address" runat="server" Text=""></asp:Label>
                    </td>
                    <td align="right">
                        <b>DOB :</b>
                    </td>
                    <td align="left">
                        <asp:Label ID="lbl_dob" runat="server" Text=""></asp:Label>
                    </td>
                </tr>
                <tr height="30px">
                    <td align="right">
                        <b>Phone Number :</b>
                    </td>
                    <td align="left">
                        <asp:Label ID="lbl_phone" runat="server" Text=""></asp:Label>
                    </td>
                    <td align="right">
                        <b>City :</b>
                    </td>
                    <td align="left">
                        <asp:Label ID="lbl_city" runat="server" Text=""></asp:Label>
                    </td>
                    <td align="right">
                        <b>Citizenship Verified :</b>
                    </td>
                    <td align="left">
                        <asp:Label ID="lbl_rdblawful" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr height="30px">
                    <td align="right">
                        <b>Alternate Phone Number :</b>
                    </td>
                    <td align="left">
                        <asp:Label ID="lbl_altpone" runat="server"></asp:Label>
                    </td>
                    <td align="right">
                        <b>State/Zip:</b>
                    </td>
                    <td align="left">
                        <asp:Label ID="lbl_zip" runat="server" Text=""></asp:Label>
                    </td>
                    <td align="right">
                        <b>NABP E-Profile Number :</b>
                    </td>
                    <td align="left">
                        <asp:Label ID="lbl_cpenumber" runat="server" Text=""></asp:Label>
                    </td>

                </tr>
                <tr height="30px">
                    <td align="right">
                        <b>Email :</b>
                    </td>
                    <td align="left">
                        <asp:HyperLink ID="lbl_email" runat="server"></asp:HyperLink>
                    </td>
                </tr>
                <tr style="display: none">
                    <td align="right">
                        <b>Age :</b>
                    </td>
                    <td align="left">
                        <asp:Label ID="lbl_age" runat="server" Text=""></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td colspan="8" align="center">


                        <asp:Button ID="btnchecker" runat="server" Visible="false" Text="View Background Check" />

                    </td>
                </tr>
            </table>
        </div>
    </div>
    <div id="viewssn" class="popup" align="center">
        <asp:UpdatePanel ID="upd7" runat="server">
            <ContentTemplate>
                <table style="width: 100%">
                    <tr>
                        <td align="right">Reason
                        </td>
                        <td align="left">
                            <asp:DropDownList ID="ddl_reason" runat="server"></asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td align="center" colspan="2">
                            <asp:Button ID="btnshow" runat="server" Text="Show" OnClientClick="javascript:return ShowSSN();" />
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    <div id="Editdemo_pop" class="popup" align="center">
        <iframe id="iframeedit" width="100%" height="500px" frameborder="0"></iframe>
    </div>
    <div id="grdalerts" class="popup">
    </div>
    <div id="grdalthis" class="popup">
    </div>
    <div class="cpanel">
        <div class="thead">
            <div class="dtab">
                <ul id="tabs" runat="server" style="padding: 0; margin: 0;">
                </ul>
            </div>
        </div>
        <div id="tabcnt" class="body">
            <iframe id="frm" width="100%" height="500px" frameborder="0" scrolling="no"></iframe>
        </div>
    </div>
    <div id="dividperson" class="popup" style="display: none;" align="center">
        <iframe id="iframepart" width="98%" height="500px" frameborder="0"></iframe>
    </div>
    <div id="financepopup" class="popup" style="display:none">
        <span class="title">Online Fee Fine</span>
        <iframe id="iframefinance" width="98%" height="550px" frameborder="0"></iframe>
    </div>
    <script type="text/javascript">
        function addnewperson(pid) {
            document.getElementById('iframepart').src = "../Complaints/AddNewComplaintGeneral.aspx?cmpid=" + pid;

            $('#dividperson').dialog({ title: "Participant General", width: '90%' });
            $('#dividperson').dialog("open");
        }
        function aftersave() {
            altbox("Record inserted successfully.");
            $('#dividperson').dialog("close");
            $('#btnaddpartnew_pop').dialog("close");
            var curl = document.getElementById('frm').src;
            document.getElementById('frm').src = '';

            document.getElementById('frm').src = curl;
        }
        function Popup() {
            $(function () { $('#btnnew_pop').dialog("open"); });
        }
    </script>
    <script language="javascript" type="text/javascript">
        function loaddiv(ctl, lurl) {

            $('#frm').attr('src', lurl);
            $('ul').find('li').removeClass('li_active');
            $(ctl).addClass('li_active');

        }
        function hidetab() {

            $('.dtab li:eq(0)').remove();
            $('.dtab li:eq(0)').click();
        }
        if (document.getElementById('<%= hfdiscmp.ClientID %>').value == '0') {
            if ($('.dtab').find('li').length > 0) {
                $('.dtab li:eq(0)').click();
            }
        }
        else {
            if ($('.dtab').find('li').length > 0) {
                $('.dtab li:eq(' + document.getElementById('<%= hfdiscmp.ClientID %>').value + ')').click();
            }
        }
        function Create_Checklist(ltype, appid) {
            var tr = document.getElementById('tab').rows[0];
            var ntd = tr.insertCell(0);
            ntd.onclick = function () { loaddiv(this, '../Licensing/CLnewapplication.aspx?appid=' + appid); };
            ntd.innerText = "C/L For  " + ltype;
            ntd.className = 'tabs';
            var ntd1 = tr.insertCell(0);
            ntd1.width = '3px';
            ntd1.innerHTML = '&nbsp;';
            ntd.click();
        }
        function openfrm(sid) {
            frmprintshow(1, document.getElementById('<%= hfdpid.ClientID %>').value);
        }
        function printothrs(type, appid) {
            if (type == 3 || type == 4)
                frmprintshow1(type, appid,document.getElementById('<%= hfdpid.ClientID %>').value);
            else
            frmprintshow(type, appid);
        }
        function printcrt(type, appid) {
            frmprintcrt(type, appid);
        }
        function printnewcrt(type, appid) {
            frmprintnewcrt(type, appid);
        }
        function frmprintnewcrt(type, refid) {
            var src1 = '../Prints/show_cert1.aspx?type=' + type + '&refid=' + refid;
            document.getElementById('frmprint').src = src1;
            $('#frmpop').dialog({ title: "View Certificate", width: "95%" });
            $('#frmpop').dialog('open');
            return false;
        }
        chkalrt();
        function chngclr() {

            jQuery("#alrt").attr('style', 'color:red;font-size:18pt;margin-top:-1px');

        }

        setInterval(function () { chngclr(); }, 200);

    </script>
</asp:Content>
