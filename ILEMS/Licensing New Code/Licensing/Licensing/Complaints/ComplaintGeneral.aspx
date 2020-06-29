<%@ Page Title="" Language="C#" MasterPageFile="~/Master Page/frm.Master" AutoEventWireup="true"
    EnableViewState="true" CodeBehind="ComplaintGeneral.aspx.cs" Inherits="Licensing.Complaints.ComplaintGeneral" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:HiddenField ID="hfdcomid" runat="server" />
    <asp:HiddenField ID="hfdpartid" runat="server" Value="0" />
    <asp:HiddenField ID="hfdrelatedcompid" runat="server" />
    <asp:HiddenField ID="hfdrelatedattorneyid" runat="server" />
    <asp:HiddenField ID="hfdParticipantType" runat="server" />
    <asp:HiddenField ID="hdnevents" runat="server" Value="0" />
    <asp:HiddenField ID="hfd_jouid" runat="server" Value="0" />
    <asp:HiddenField ID="hfd_delparid" runat="server" Value="0" />
    <asp:Button ID="btnhfd_delparid" runat="server" Style="display: none" OnClick="btnhfd_delparid_click" />
    <div style="width: 98%; margin-left: auto; margin-right: auto">
        <div class="cpanel" style="margin-left: auto; margin-right: auto">
            <div class="head accr expand">
                Participants
            </div>
            <div class="body">
                <script type="text/javascript">
                    function Save_ValidationServices() {
                        var errormsg = validateform('frmServices');
                        if (errormsg != "") {
                            Msgbox(errormsg);
                            return false;
                        }

                        if (ServiceValidation()) {
                            return true;

                        }
                        else {
                            return false

                        }

                        return true;

                    }

                    function Save_ValidationAttorney() {

                        var errormsg = validateform('frmAttorney');

                        if (errormsg != "") {
                            Msgbox(errormsg);
                            return false;
                        }

                        return true;
                    }


                    function Save_ValidationEvents() {

                        var errormsg = validateform('frmEvents');

                        if (errormsg != "") {
                            Msgbox(errormsg);
                            return false;
                        }

                        return true;
                    }

                    function Save_ValidationJournal() {

                        var errormsg = validateform('frmJournal');

                        if (errormsg != "") {
                            Msgbox(errormsg);
                            return false;
                        }

                        return true;
                    }



                </script>
                <script type="text/javascript">


                    var dataIn = '';

                    var sa1 = new sagrid();
                    sa1.url = "../WCFGrid/GridService.svc/BindParticipateGeneral";
                    sa1.primarykeyval = "Cmp_Paticipant_ID";
                    sa1.bindid = "grdParticipateGeneral";


                    
                    sa1.objname = "sa1";
                    sa1.aftercall = "bindfrm";
                    dataIn = '"comid":"' + document.getElementById('<%= hfdcomid.ClientID %>').value + '"';
                    sa1.data = dataIn;
                  

                    var sa2 = new sagrid();
                    sa2.url = "../WCFGrid/GridService.svc/BindParticipantservice";
                    sa2.primarykeyval = "Cmp_Service_id";
                    sa2.bindid = "grdparticipantservice";
                    sa2.cols = [new dcol("Doc Type", "DocType"), new dcol("Service Type", "ServiceType"), new dcol("Chk Service", "Check"), new dcol("Upload", "", "", "1", "1", "edit_lkp", "fa fa-pencil-square-o grdicon"), new dcol("Edit", "", "", "1", "1", "editParticipantservice_lkp", "fa fa-pencil-square-o grdicon")];
                    sa2.objname = "sa2";
                    dataIn = '"comid":"' + document.getElementById('<%= hfdcomid.ClientID %>').value + '"' + ',' + '"partid":"' + document.getElementById('<%= hfdpartid.ClientID %>').value + '"';
                    sa2.data = dataIn;
                    sa2.process();

                    var sa3 = new sagrid();
                    sa3.url = "../WCFGrid/GridService.svc/BindAttorney";
                    sa3.primarykeyval = "Cmp_Attoerney_Id";
                    sa3.bindid = "grdAttorney";
                    sa3.cols = [new dcol("Name", "Name"), new dcol("Address", "Address"), new dcol("City", "City"), new dcol("State", "State"), new dcol("Status", "Status"), new dcol("Edit", "", "", "1", "1", "editAttorney_lkp", "fa fa-pencil-square-o grdicon")];
                    sa3.objname = "sa3";
                    dataIn = '"comid":"' + document.getElementById('<%= hfdcomid.ClientID %>').value + '"' + ',' + '"partid":"' + document.getElementById('<%= hfdpartid.ClientID %>').value + '"';
                    sa3.data = dataIn;
                    sa3.process();

                    var sa4 = new sagrid();
                    sa4.url = "../WCFGrid/GridService.svc/BindEvents";
                    sa4.primarykeyval = "CompEventId";
                    sa4.bindid = "grdCompEvents";
                    sa4.cols = [new dcol("Date", "eventdate"), new dcol("Time", "EventTime"), new dcol("Type", "EventName"), new dcol("Responsible Person", "resname"), new dcol("Edit", "", "", "1", "1", "editEvents_lkp", "fa fa-pencil-square-o grdicon"), new dcol("Delete", "", "", "1", "1", "DeleteEvents_lkp", "fa fa-trash-o grdicon")];
                    sa4.objname = "sa4";
                    dataIn = '"comid":"' + document.getElementById('<%= hfdcomid.ClientID %>').value + '"' + ',' + '"partid":"' + document.getElementById('<%= hfdpartid.ClientID %>').value + '"';
                    sa4.data = dataIn;
                    sa4.process();

                    var sa5 = new sagrid();
                    sa5.url = "../WCFGrid/GridService.svc/BindJournal";
                    sa5.primarykeyval = "Journal_ID";
                    sa5.bindid = "grdnursejournal";
                    
                    sa5.objname = "sa5";
                    dataIn = '"comid":"' + document.getElementById('<%= hfdcomid.ClientID %>').value + '"' + ',' + '"partid":"' + document.getElementById('<%= hfdpartid.ClientID %>').value + '"';
                    sa5.data = dataIn;
                    

                    var sa6 = new sagrid();
                    sa6.url = "../WCFGrid/GridService.svc/BindCompanionCases";
                    sa6.primarykeyval = "CompanionCase_ID";
                    sa6.bindid = "grdCompanionCases";
                    sa6.objname = "sa6";
                    dataIn = '"comid":"' + document.getElementById('<%= hfdcomid.ClientID %>').value + '"';
                    sa6.data = dataIn;
                  


                    function selectPartid_lkp(sender, keyval) {

                        //document.getElementById('<%= hfdcomid.ClientID %>').value=
                        document.getElementById('<%= hfdpartid.ClientID %>').value = sa1.resultdata[sender]["Cmp_Paticipant_ID"]
                        sa2.process();
                        sa3.process();
                        sa4.process();
                        sa5.process();


                    }
                    function nm_click(sender, keyval) {
                        var pid = sa1.resultdata[sender]["Person_ID"];
                        var otype = sa1.resultdata[sender]["object_type"];
                        if (otype == "1")
                            window.open('../PersonLicensing/PersonDetails.aspx?perid=' + pid);
                        else
                            window.open('../PersonLicensing/Business_Details.aspx?perid=' + pid);
                    }
                    function Select_Person(sender, keyval) {
                        var selperid = owner.resultdata[sender]["Person_ID"];
                        var otype = owner.resultdata[sender]["object_type"];
                        if (otype == "1")
                            parent.window.location.href = '../PersonLicensing/PersonDetails.aspx?perid=' + selperid;
                        else
                            parent.window.location.href = '../PersonLicensing/Business_Details.aspx?perid=' + selperid;
                    }
                    function bindfrm() {

                        var trs = document.getElementById('grdParticipateGeneral').getElementsByTagName('tbody')[0].getElementsByTagName('tr');
                        if (trs.length > 0) {
                            var lcell = trs[0].getElementsByTagName('td')[4];
                            $(lcell).find('.fa-hand-o-up').click();
                        }
                    }

                    function cnffnres(result) {
                        if (result == 'true') {
                            document.getElementById('<%= btnhfd_delparid.ClientID %>').click();

                        }
                    }

                    function delPartid_lkp(sender, keyval) {
                        document.getElementById('<%= hfd_delparid.ClientID %>').value = keyval;

                        cnfbox(" Are you sure do you want to delete this record?", "cnffnres");

                    }


                    function editParticipantservice_lkp(sender, keyval) {

                        fill_service(sa2.resultdata[sender]["Cmp_Service_Id"], sa2.resultdata[sender]["DocType"], sa2.resultdata[sender]["ServiceType"], sa2.resultdata[sender]["Is_Effectuated"], sa2.resultdata[sender]["NoticeDate"],
                                                                                sa2.resultdata[sender]["ServedDate"], sa2.resultdata[sender]["AttemptedDate"], sa2.resultdata[sender]["Reason"], sa2.resultdata[sender]["Comments"], sa2.resultdata[sender]["County"],
                                                                                sa2.resultdata[sender]["TrackingNo"], sa2.resultdata[sender]["Create_User"], sa2.resultdata[sender]["Mailnumber"], sa2.resultdata[sender]["DeliveryDate"], sa2.resultdata[sender]["ReturnDate"],
                                                                                sa2.resultdata[sender]["MailedDate"], sa2.resultdata[sender]["NotSatisfied"], sa2.resultdata[sender]["Undeliverable"], sa2.resultdata[sender]["Is_Service_Archieved"], sa2.resultdata[sender]["Is_Service_Delivered"], sa2.resultdata[sender]["Service_Satisfied"]);

                    }

                    function DeletedParticipantservice_lkp(sender, keyval) {
                        if (confirm("are you sure do you want to delete this record?")) {

                        }
                    }



                    function editAttorney_lkp(sender, keyval) {

                        fill_attorney(sa3.resultdata[sender]["Cmp_Attoerney_Id"], sa3.resultdata[sender]["Name"], sa3.resultdata[sender]["Address"], sa3.resultdata[sender]["City"], sa3.resultdata[sender]["State"], sa3.resultdata[sender]["Status"]);

                    }

                    function DeleteAttorney_lkp(sender, keyval) {
                        if (confirm("are you sure do you want to delete this record?")) {

                        }
                    }

                    function editEvents_lkp(sender, keyval) {
                        fill_events(sa4.resultdata[sender]["CompEventId"], sa4.resultdata[sender]["eventdate"], sa4.resultdata[sender]["EventTime"], sa4.resultdata[sender]["EventType"], sa4.resultdata[sender]["EventResPerson"], sa4.resultdata[sender]["EventRem"], sa4.resultdata[sender]["Comments"]);

                    }

                    function DeleteEvents_lkp(sender, keyval) {
                        // if (confirm("are you sure do you want to delete this record?"))
                        // {
                        DeleteEvent(sa4.resultdata[sender]["CompEventId"]);
                        document.getElementById('<%= btneventremove.ClientID %>').click();
                        // }
                    }

                    function editJournal_lkp(sender, keyval) {

                        fill_jou(sa5.resultdata[sender]["Journal_ID"], sa5.resultdata[sender]["JrnlName"], sa5.resultdata[sender]["Comments"], sa5.resultdata[sender]["ModifiedDate"]);
                    }

                    function DeleteJournal_lkp(sender, keyval) {
                        // if (confirm("are you sure do you want to delete this record?"))
                        //  {

                        DeleteJournal(sa5.resultdata[sender]["Journal_ID"]);
                        document.getElementById('<%= btnJournalremove.ClientID %>').click();

                        // }
                    }


                    function afterpost(msg) {

                        sa5.process();
                        $('#btnnew_pop').dialog('close');
                        altbox(msg);

                    }


                    function ddl_change(ctl) {
                        dataIn = '"sval":"' + ctl.value + '"';
                        sa5.data = dataIn;
                        sa5.process();
                    }
                    function open_edit(pid) {
                        document.getElementById('iframeparticipant').src = "../Complaints/AddNewComplaintGeneral.aspx?Person_id=" + pid;
                        $('#btnnew_pop').dialog({ title: "Participant General", width: '90%' });
                        $('#btnnew_pop').dialog("open");

                        return false;

                    }
                    function open_NewAddPerson(pid) {
                        parent.openaddperson(pid);
                        return false;
                    }
                    function aftersave() {
                        $('#btnaddpartnew_pop').dialog('close');
                        parent.aftercomplete();
                        sa1.process();
                    }
                </script>
                <div align="right" style="margin-top: 10px; margin-right: 15px; margin-bottom: 8px;">
                    <asp:Button ID="btnaddpartnew" runat="server" Text="Add New" />
                </div>
                <div id="grdParticipateGeneral">
                </div>
                <div id='btnaddpartnew_pop' class="popup" style="display: none;" align="center">
                    <span class="title">Participant General</span>
                    <iframe id="iframeparticipant" width="98%" height="300px" frameborder="0"></iframe>
                </div>
            </div>
        </div>
        <div class="cpanel" style="display: none;">
            <div class="head accr">
                Services
            </div>
            <div class="body">
                <script language="javascript">


                    function clear_serviceNew() {

                        document.getElementById('<%= ddlserdocument.ClientID %>').value = '-1';
                        document.getElementById('<%= ddlservicetype.ClientID %>').value = '-1';
                        document.getElementById('<%= rbleffectuated.ClientID %>').value = '';
                        document.getElementById('<%= txtnoticedate.ClientID %>').value = '';
                        document.getElementById('<%= txtserveddate.ClientID %>').value = '';
                        document.getElementById('<%= txtdeliverydate.ClientID %>').value = '';
                        document.getElementById('<%= txtreturndate.ClientID %>').value = '';
                        document.getElementById('<%= ddlattempteddate.ClientID %>').value = '';
                        document.getElementById('<%= ddlservicereason.ClientID %>').value = '-1';
                        document.getElementById('<%= txtservicecomments.ClientID %>').value = '';
                        document.getElementById('<%= ddlservicecountry.ClientID %>').value = '-1';
                        document.getElementById('<%= txttracking.ClientID %>').value = '';
                        document.getElementById('<%= ddlrequester.ClientID %>').value = '-1';

                        document.getElementById('<%= chknotsatis.ClientID %>').checked = false;
                        document.getElementById('<%= chkundeliverable.ClientID %>').checked = false;
                        document.getElementById('<%= chkservicesatified.ClientID %>').checked = false;
                        document.getElementById('<%= rdbservicearchieved.ClientID %>').value = '';
                        document.getElementById('<%= rdbdelivered.ClientID %>').value = '';
                        document.getElementById('<%= txtsingleattempteddate.ClientID %>').value = '';
                        document.getElementById('<%= txtDateMailed.ClientID %>').value = '';






                        $('#attemdatetr').hide();

                        $('#Certifiedmail').hide();
                        $('#tracking').hide();
                        $('#trdatemailed').hide();
                        $('#serveddate').hide();
                        $('#attemdate').hide();
                        $('#requestor').hide();
                        $('#comment').hide();
                        $('#trrbldateeffectuated').hide();
                        $('#date1').hide();
                        $('#date2').hide();
                        $('#date3').hide();
                        $('#reason').hide();
                        $('#country').hide();
                        $('#tracking').hide();
                        $('#tr20daysnotdate').hide();
                        $('#trchkundeliverable').hide();
                        $('#trservicearchieved').hide();
                        $('#trdelivered').hide();
                        $('#trservicesatisfied').hide();
                        $('#trsingleattempteddate').hide();

                        document.getElementById('<%= btnservicesubmit.ClientID %>').style.display = 'block';
                        document.getElementById('<%= btnservicesupdate.ClientID %>').style.display = 'none';
                        document.getElementById('<%= hfd_service.ClientID %>').value = '0';
                        document.getElementById('btnnewservice1').click();






                    }

                    function clear_service() {




                        //if (document.getElementById('<%= hfdselarid.ClientID %>').value != '0') {
                        document.getElementById('<%= ddlserdocument.ClientID %>').value = '-1';
                        document.getElementById('<%= ddlservicetype.ClientID %>').value = '-1';
                        document.getElementById('<%= rbleffectuated.ClientID %>').value = '';
                        document.getElementById('<%= txtnoticedate.ClientID %>').value = '';
                        document.getElementById('<%= txtserveddate.ClientID %>').value = '';
                        document.getElementById('<%= txtdeliverydate.ClientID %>').value = '';
                        document.getElementById('<%= txtreturndate.ClientID %>').value = '';
                        document.getElementById('<%= ddlattempteddate.ClientID %>').value = '';
                        document.getElementById('<%= ddlservicereason.ClientID %>').value = '-1';
                        document.getElementById('<%= txtservicecomments.ClientID %>').value = '';
                        document.getElementById('<%= ddlservicecountry.ClientID %>').value = '-1';
                        document.getElementById('<%= txttracking.ClientID %>').value = '';
                        document.getElementById('<%= ddlrequester.ClientID %>').value = '-1';

                        document.getElementById('<%= chknotsatis.ClientID %>').checked = false;
                        document.getElementById('<%= chkundeliverable.ClientID %>').checked = false;
                        document.getElementById('<%= chkservicesatified.ClientID %>').checked = false;
                        document.getElementById('<%= rdbservicearchieved.ClientID %>').value = '';
                        document.getElementById('<%= rdbdelivered.ClientID %>').value = '';
                        document.getElementById('<%= txtsingleattempteddate.ClientID %>').value = '';
                        document.getElementById('<%= txtDateMailed.ClientID %>').value = '';

                        document.getElementById("Certifiedmail").style.display = 'none';
                        document.getElementById("tracking").style.display = 'none';

                        document.getElementById("trdatemailed").style.display = "none";

                        document.getElementById("serveddate").style.display = "none";
                        document.getElementById("attemdate").style.display = "none";
                        document.getElementById("requestor").style.display = "none";
                        document.getElementById("comment").style.display = "none";


                        document.getElementById("trrbldateeffectuated").style.display = "none";

                        document.getElementById("date1").style.display = "none";
                        document.getElementById("date2").style.display = "none";
                        document.getElementById("date3").style.display = "none";

                        document.getElementById("reason").style.display = "none";

                        document.getElementById("country").style.display = "none";
                        document.getElementById("tracking").style.display = "none";

                        document.getElementById("tr20daysnotdate").style.display = "none";
                        document.getElementById("trchkundeliverable").style.display = "none";
                        document.getElementById("trservicearchieved").style.display = "none";
                        document.getElementById("trdelivered").style.display = "none";
                        document.getElementById("trservicesatisfied").style.display = "none";
                        document.getElementById("trsingleattempteddate").style.display = "none";

                        document.getElementById('<%= btnservicesubmit.ClientID %>').style.display = 'block';
                        document.getElementById('<%= btnservicesupdate.ClientID %>').style.display = 'none';
                        document.getElementById('<%= hfd_service.ClientID %>').value = '0';
                        document.getElementById('btnnewservice1').click();
                        // }
                        // else
                        //  altbox("Select Participant!");
                        return false;
                    }

                    function fill_service(hfdid, doctype, sertype, effe, ndate, sdate, adate, reason, comm,
                                                                                                   county, track, req, mailnum, delivery,
                                                                                                 returndate, MailedDate, NotSatisfied, Undeliverable, Is_Service_Archieved,
                                                                                                 Is_Service_Delivered, Service_Satisfied) {
                        document.getElementById('<%= ddlservicetype.ClientID %>').value = sertype;





                                                                                                     var optser = document.getElementById('<%= ddlservicetype.ClientID %>').options;

                        for (var i = 0; i < optser.length; i++) {

                            if (optser[i].text == sertype) {
                                document.getElementById('<%= ddlservicetype.ClientID %>').value = optser[i].value;
                                i = optser.length;
                            }
                        }



                        var optdoc = document.getElementById('<%= ddlserdocument.ClientID %>').options;
                        for (var i = 0; i < optdoc.length; i++) {
                            if (optdoc[i].text == doctype) {
                                document.getElementById('<%= ddlserdocument.ClientID %>').value = optdoc[i].value;
                                i = optdoc.length;
                            }
                        }


                        if (sertype == "Regular Mail") {

                            document.getElementById("trdatemailed").style.display = "block";
                            document.getElementById('<%= txtDateMailed.ClientID %>').value = MailedDate;
                            document.getElementById("serveddate").style.display = "none";
                            document.getElementById("attemdate").style.display = "block";
                            document.getElementById('<%= txtsingleattempteddate.ClientID %>').value = adate;
                            document.getElementById("comment").style.display = "block";
                            document.getElementById('<%= txtservicecomments.ClientID %>').value = comm;
                            document.getElementById("requestor").style.display = "none";
                            document.getElementById("trrbldateeffectuated").style.display = "none";
                            document.getElementById("date1").style.display = "none";

                            document.getElementById("date2").style.display = "none";
                            document.getElementById("date3").style.display = "none";
                            document.getElementById("reason").style.display = "none";
                            document.getElementById("country").style.display = "none";
                            document.getElementById("tracking").style.display = "none";
                            document.getElementById("tr20daysnotdate").style.display = "none";
                            document.getElementById("trchkundeliverable").style.display = "none";
                            document.getElementById("trservicearchieved").style.display = "none";
                            document.getElementById("trdelivered").style.display = "none";
                            document.getElementById("trservicesatisfied").style.display = "none";
                            document.getElementById("trsingleattempteddate").style.display = "none";
                        }
                        if (sertype == "Certified Mail") {
                            document.getElementById("trdatemailed").style.display = "block";
                            document.getElementById('<%= txtDateMailed.ClientID %>').value = MailedDate;
                            document.getElementById("serveddate").style.display = "none";
                            document.getElementById("attemdate").style.display = "none";
                            document.getElementById("requestor").style.display = "none";
                            document.getElementById("comment").style.display = "block";
                            document.getElementById('<%= txtservicecomments.ClientID %>').value = comm;
                            document.getElementById("trrbldateeffectuated").style.display = "none";
                            document.getElementById("date1").style.display = "block";
                            document.getElementById('<%= txtnoticedate.ClientID %>').value = ndate;
                            document.getElementById("date2").style.display = "none";
                            document.getElementById("date3").style.display = "none";
                            document.getElementById("reason").style.display = "none";
                            document.getElementById("country").style.display = "none";
                            document.getElementById("tracking").style.display = "block";
                            document.getElementById('<%= txttracking.ClientID %>').value = track;
                            document.getElementById("tr20daysnotdate").style.display = "block";
                            if (NotSatisfied == "Yes")
                                document.getElementById('<%= chknotsatis.ClientID %>').checked = true;
                            else
                                document.getElementById('<%= chknotsatis.ClientID %>').checked = false;

                            document.getElementById("trchkundeliverable").style.display = "block";
                            if (Undeliverable == "Yes")
                                document.getElementById('<%= chkundeliverable.ClientID %>').checked = true;
                            else
                                document.getElementById('<%= chkundeliverable.ClientID %>').checked = false;
                            document.getElementById("trservicearchieved").style.display = "none";
                            document.getElementById("trdelivered").style.display = "none";
                            document.getElementById("trservicesatisfied").style.display = "none";
                            document.getElementById("trsingleattempteddate").style.display = "none";
                        }
                        if (sertype == "By Sheriff") {
                            document.getElementById("trdatemailed").style.display = "block";
                            document.getElementById('<%= txtDateMailed.ClientID %>').value = MailedDate;
                            document.getElementById("serveddate").style.display = "none";
                            document.getElementById("attemdate").style.display = "none";
                            document.getElementById("requestor").style.display = "none";
                            document.getElementById("comment").style.display = "block";
                            document.getElementById('<%= txtservicecomments.ClientID %>').value = comm;
                            document.getElementById("trrbldateeffectuated").style.display = "none";
                            document.getElementById("date1").style.display = "none";
                            document.getElementById("date2").style.display = "none";
                            document.getElementById("date3").style.display = "block";
                            document.getElementById('<%= txtreturndate.ClientID %>').value = returndate;
                            document.getElementById("reason").style.display = "none";
                            document.getElementById("country").style.display = "block";

                            var opt = document.getElementById('<%= ddlservicecountry.ClientID %>').options;
                            for (var i = 0; i < opt.length; i++) {
                                if (opt[i].text == county) {
                                    document.getElementById('<%= ddlservicecountry.ClientID %>').value = opt[i].value;
                                    i = opt.length;
                                }
                            }
                            document.getElementById("tracking").style.display = "none";
                            document.getElementById("tr20daysnotdate").style.display = "block";
                            if (NotSatisfied == "Yes")
                                document.getElementById('<%= chknotsatis.ClientID %>').checked = true;
                            else
                                document.getElementById('<%= chknotsatis.ClientID %>').checked = false;
                            document.getElementById("trchkundeliverable").style.display = "none";
                            document.getElementById("trservicearchieved").style.display = "block";
                            var cl = document.getElementById('<%= rdbservicearchieved.ClientID %>');

                            if (Is_Service_Archieved == "Yes") {
                                cl.cells[0].all[0].checked = true;
                                document.getElementById('serveddate').style.display = 'block';
                                document.getElementById('<%= txtserveddate.ClientID %>').value = sdate;
                            }
                            else if (Is_Service_Archieved == "No") {

                                cl.cells[1].all[0].checked = true;
                                document.getElementById('serveddate').style.display = 'none';
                            }
                            document.getElementById("trdelivered").style.display = "none";
                            document.getElementById("trservicesatisfied").style.display = "none";
                            document.getElementById("trsingleattempteddate").style.display = "none";

                        }
                        if (sertype == "In Person") {
                            document.getElementById("trdatemailed").style.display = "none";
                            document.getElementById('<%= txtDateMailed.ClientID %>').value = MailedDate;
                            document.getElementById("serveddate").style.display = "none";
                            document.getElementById("attemdate").style.display = "none";
                            document.getElementById("requestor").style.display = "none";
                            document.getElementById("comment").style.display = "block";

                            document.getElementById('<%= txtservicecomments.ClientID %>').value = comm;
                            document.getElementById("trrbldateeffectuated").style.display = "none";

                            document.getElementById("date1").style.display = "none";
                            document.getElementById("date2").style.display = "none";
                            document.getElementById("date3").style.display = "none";

                            document.getElementById("reason").style.display = "none";

                            document.getElementById("country").style.display = "none";
                            document.getElementById("tracking").style.display = "none";

                            document.getElementById("tr20daysnotdate").style.display = "none";
                            document.getElementById("trchkundeliverable").style.display = "none";
                            document.getElementById("trservicearchieved").style.display = "none";
                            document.getElementById("trdelivered").style.display = "block";
                            var cl = document.getElementById('<%= rdbdelivered.ClientID %>');

                            if (Is_Service_Delivered == "Yes") {
                                cl.cells[0].all[0].checked = true;
                                document.getElementById('date2').style.display = 'block';
                                document.getElementById('<%= txtdeliverydate.ClientID %>').value = delivery;
                            }
                            else if (Is_Service_Delivered == "No") {

                                cl.cells[1].all[0].checked = true;
                                document.getElementById('date2').style.display = 'none';
                            }
                            document.getElementById("trservicesatisfied").style.display = "block";
                            if (Service_Satisfied == "Yes")
                                document.getElementById('<%= chkservicesatified.ClientID %>').checked = true;
                            else
                                document.getElementById('<%= chkservicesatified.ClientID %>').checked = false;
                            document.getElementById("trsingleattempteddate").style.display = "block";
                            document.getElementById('<%= txtsingleattempteddate.ClientID %>').value = adate;
                        }


                        //document.getElementById('<%= ddlserdocument.ClientID %>').value=doctype;
                        if (doctype == "Witness Subpoena" || doctype == "Document Subpoena") {

                            document.getElementById("requestor").style.display = "block";
                            var opt = document.getElementById('<%= ddlrequester.ClientID %>').options;
                            for (var i = 0; i < opt.length; i++) {
                                if (opt[i].text == req) {
                                    document.getElementById('<%= ddlrequester.ClientID %> ').value = opt[i].value;
                                    i = opt.length;
                                }
                            }
                        }
                        else {
                            document.getElementById("requestor").style.display = "none";
                        }
                        document.getElementById('<%= btnservicesubmit.ClientID %>').style.display = 'none';
                        document.getElementById('<%= btnservicesupdate.ClientID %>').style.display = 'block';
                        document.getElementById('<%= hfd_service.ClientID %>').value = hfdid;
                        // document.getElementById('btnnewservice1').click();

                        $(function () { $('#btnnewservice1_pop').dialog("open"); });

                        return false;
                    }
                    function service_cancel() {
                        document.getElementById('imgcancelservice').click();
                        return false;
                    }
                </script>
                <div align="right" style="margin-top: 10px; margin-right: 15px; margin-bottom: 8px;">
                    <input type="button" id="btnnewservice1" value="Add New " onclick="javascript: return clear_serviceNew()"
                        class="poptrg" />
                </div>
                <asp:HiddenField ID="hfdselarid" runat="server" Value="0" />
                <center>
                    <div id="grdparticipantservice">
                    </div>
                </center>
                <div id='btnnewservice1_pop' class="popup" style="display: none;">
                    <span class="title">Participant Service</span>
                    <table id="frmServices">
                        <tr>
                            <td align="right">
                                <asp:Label ID="Label36" runat="server" Text="Document Type "></asp:Label>
                            </td>
                            <td align="left">
                                <asp:DropDownList ID="ddlserdocument" CssClass="required" error="Please select document type."
                                    runat="server" onchange="javascript:obt_changecerti(this)">
                                </asp:DropDownList>
                                <asp:HiddenField ID="hfd_service" runat="server" Value="0" />
                                <script language="javascript">
                                    function obt_changecerti(ctl) {


                                        if (ctl.value == "618" || ctl.value == "619")
                                            // document.getElementById("requestor").style.display = "block";
                                        {
                                            $('#requestor').show();
                                            $('#trdatemailed').show();
                                            if (ctl.value == "619") {
                                                $('#tracking').show();
                                            }
                                        }
                                        else
                                            // document.getElementById("requestor").style.display = "none";
                                        {
                                            $('#requestor').hide();

                                        }
                                        if (ctl.value == "620") {
                                            $('#trdatemailed').show();
                                            $('#country').show();
                                            $('#date3').show();

                                        }
                                    }
                                </script>
                            </td>
                        </tr>
                        <tr>
                            <script language="javascript">



                                function obt_changeNew(ctl) {


                                    //                                                        
                                    if (ctl.value == "624") {






                                        $('#trdatemailed').show();
                                        $('#serveddate').hide();
                                        $('#attemdate').hide();

                                        $('#attemdatetr').hide();
                                        $('#comment').show();

                                        $('#trrbldateeffectuated').hide();
                                        $('#date1').show();
                                        $('#date2').hide();
                                        $('#date3').hide();
                                        $('#reason').hide();
                                        $('#country').hide();
                                        $('#tracking').show();
                                        $('#tr20daysnotdate').show();
                                        $('#trchkundeliverable').show();
                                        $('#trservicearchieved').hide();
                                        $('#trdelivered').hide();
                                        $('#trservicesatisfied').hide();
                                        $('#trsingleattempteddate').hide();







                                    }
                                        //                                                      if(ctl.Text=="By Sheriff")
                                    else
                                        if (ctl.value == "625") {


                                            $('#trdatemailed').show();
                                            $('#serveddate').hide();
                                            $('#attemdatetr').hide(); //attemdate
                                            $('#comment').show();

                                            $('#trrbldateeffectuated').hide();
                                            $('#date1').hide();
                                            $('#date2').hide();
                                            $('#date3').show();
                                            $('#reason').hide();
                                            $('#country').show();
                                            $('#tracking').hide();

                                            // $('tr20daysnotdate').show();

                                            $('#trchkundeliverable').hide();
                                            $('#trservicearchieved').show();
                                            $('#trdelivered').hide();
                                            $('#trservicesatisfied').hide();
                                            $('#trsingleattempteddate').hide();






                                        }
                                            //                                                        if(ctl.Text == "Regular Mail")
                                        else
                                            if (ctl.value == "623") {


                                                $('#trdatemailed').show();
                                                $('#serveddate').hide();
                                                $('#attemdate').show();
                                                $('#comment').show();

                                                $('#trrbldateeffectuated').hide();
                                                $('#date1').hide();
                                                $('#date2').hide();
                                                $('#date3').hide();
                                                $('#reason').hide();
                                                $('#country').hide();
                                                $('#tracking').hide();
                                                $('#tr20daysnotdate').hide();
                                                $('#trchkundeliverable').hide();
                                                $('#trservicearchieved').hide();
                                                $('#trdelivered').hide();
                                                $('#trservicesatisfied').hide();
                                                $('#trsingleattempteddate').hide();



                                            }
                                            else
                                                if (ctl.value == "626") {



                                                    $('#trdatemailed').hide();
                                                    $('#serveddate').hide();
                                                    $('#attemdate').hide();
                                                    $('#comment').show();

                                                    $('#trrbldateeffectuated').hide();
                                                    $('#date1').hide();
                                                    $('#date2').hide();
                                                    $('#date3').hide();
                                                    $('#reason').hide();
                                                    $('#country').hide();
                                                    $('#tracking').hide();
                                                    $('#tr20daysnotdate').hide();
                                                    $('#trchkundeliverable').hide();
                                                    $('#trservicearchieved').hide();
                                                    $('#trdelivered').show();
                                                    $('#trservicesatisfied').show();
                                                    $('#trsingleattempteddate').show();


                                                }
                                                else {

                                                    $('#trdatemailed').hide();
                                                    $('#serveddate').hide();
                                                    $('#attemdate').hide();
                                                    $('#requestor').hide();
                                                    $('#comment').show();

                                                    $('#trrbldateeffectuated').hide();
                                                    $('#date1').hide();
                                                    $('#date2').hide();
                                                    $('#date3').hide();
                                                    $('#reason').hide();
                                                    $('#country').hide();
                                                    $('#tracking').hide();
                                                    $('#tr20daysnotdate').hide();
                                                    $('#trchkundeliverable').hide();
                                                    $('#trservicearchieved').hide();
                                                    $('#trdelivered').hide();
                                                    $('#trservicesatisfied').hide();
                                                    $('#trsingleattempteddate').hide();



                                                }
                                }



                                function obt_change(ctl) {
                                    //                                                        
                                    if (ctl.value == "624") {


                                        document.getElementById("trdatemailed").style.display = "block";
                                        document.getElementById("serveddate").style.display = "none";
                                        document.getElementById("attemdate").style.display = "none";



                                        // document.getElementById("requestor").style.display="none";


                                        document.getElementById("comment").style.display = "block";
                                        $('comment').show();


                                        document.getElementById("trrbldateeffectuated").style.display = "none";
                                        document.getElementById("date1").style.display = "block";
                                        document.getElementById("date2").style.display = "none";
                                        document.getElementById("date3").style.display = "none";
                                        document.getElementById("reason").style.display = "none";
                                        document.getElementById("country").style.display = "none";
                                        document.getElementById("tracking").style.display = "block";
                                        document.getElementById("tr20daysnotdate").style.display = "block";
                                        document.getElementById("trchkundeliverable").style.display = "block";
                                        document.getElementById("trservicearchieved").style.display = "none";
                                        document.getElementById("trdelivered").style.display = "none";
                                        document.getElementById("trservicesatisfied").style.display = "none";
                                        document.getElementById("trsingleattempteddate").style.display = "none";








                                    }
                                        //                                                      if(ctl.Text=="By Sheriff")
                                    else
                                        if (ctl.value == "625") {

                                            document.getElementById("trdatemailed").style.display = "block";
                                            document.getElementById("serveddate").style.display = "none";
                                            document.getElementById("attemdate").style.display = "none";
                                            //document.getElementById("requestor").style.display="none";
                                            document.getElementById("comment").style.display = "block";
                                            document.getElementById("trrbldateeffectuated").style.display = "none";


                                            document.getElementById("date1").style.display = "none";
                                            document.getElementById("date2").style.display = "none";
                                            document.getElementById("date3").style.display = "block";
                                            document.getElementById("reason").style.display = "none";



                                            document.getElementById("country").style.display = "block";
                                            document.getElementById("tracking").style.display = "none";



                                            //document.getElementById("tr20daysnotdate").style.display = "block";
                                            document.getElementById("trchkundeliverable").style.display = "none";
                                            document.getElementById("trservicearchieved").style.display = "block";
                                            document.getElementById("trdelivered").style.display = "none";
                                            document.getElementById("trservicesatisfied").style.display = "none";
                                            document.getElementById("trsingleattempteddate").style.display = "none";






                                        }
                                            //                                                        if(ctl.Text == "Regular Mail")
                                        else
                                            if (ctl.value == "623") {
                                                document.getElementById("trdatemailed").style.display = "block";
                                                document.getElementById("serveddate").style.display = "none";
                                                document.getElementById("attemdate").style.display = "block";

                                                document.getElementById("comment").style.display = "block";
                                                // document.getElementById("requestor").style.display="none";

                                                document.getElementById("trrbldateeffectuated").style.display = "none";

                                                document.getElementById("date1").style.display = "none";
                                                document.getElementById("date2").style.display = "none";
                                                document.getElementById("date3").style.display = "none";

                                                document.getElementById("reason").style.display = "none";

                                                document.getElementById("country").style.display = "none";
                                                document.getElementById("tracking").style.display = "none";
                                                document.getElementById("tr20daysnotdate").style.display = "none";
                                                document.getElementById("trchkundeliverable").style.display = "none";
                                                document.getElementById("trservicearchieved").style.display = "none";
                                                document.getElementById("trdelivered").style.display = "none";
                                                document.getElementById("trservicesatisfied").style.display = "none";
                                                document.getElementById("trsingleattempteddate").style.display = "none";
                                            }
                                            else
                                                if (ctl.value == "626") {
                                                    document.getElementById("trdatemailed").style.display = "none";
                                                    document.getElementById("serveddate").style.display = "none";
                                                    document.getElementById("attemdate").style.display = "none";
                                                    //document.getElementById("requestor").style.display="none";
                                                    document.getElementById("comment").style.display = "block";


                                                    document.getElementById("trrbldateeffectuated").style.display = "none";

                                                    document.getElementById("date1").style.display = "none";
                                                    document.getElementById("date2").style.display = "none";
                                                    document.getElementById("date3").style.display = "none";

                                                    document.getElementById("reason").style.display = "none";

                                                    document.getElementById("country").style.display = "none";
                                                    document.getElementById("tracking").style.display = "none";

                                                    document.getElementById("tr20daysnotdate").style.display = "none";
                                                    document.getElementById("trchkundeliverable").style.display = "none";
                                                    document.getElementById("trservicearchieved").style.display = "none";
                                                    document.getElementById("trdelivered").style.display = "block";
                                                    document.getElementById("trservicesatisfied").style.display = "block";
                                                    document.getElementById("trsingleattempteddate").style.display = "block";
                                                }
                                                else {
                                                    document.getElementById("trdatemailed").style.display = "none";
                                                    document.getElementById("serveddate").style.display = "none";
                                                    document.getElementById("attemdate").style.display = "none";
                                                    document.getElementById("requestor").style.display = "none";
                                                    document.getElementById("comment").style.display = "block";


                                                    document.getElementById("trrbldateeffectuated").style.display = "none";

                                                    document.getElementById("date1").style.display = "none";
                                                    document.getElementById("date2").style.display = "none";
                                                    document.getElementById("date3").style.display = "none";

                                                    document.getElementById("reason").style.display = "none";

                                                    document.getElementById("country").style.display = "none";
                                                    document.getElementById("tracking").style.display = "none";

                                                    document.getElementById("tr20daysnotdate").style.display = "none";
                                                    document.getElementById("trchkundeliverable").style.display = "none";
                                                    document.getElementById("trservicearchieved").style.display = "none";
                                                    document.getElementById("trdelivered").style.display = "none";
                                                    document.getElementById("trservicesatisfied").style.display = "none";
                                                    document.getElementById("trsingleattempteddate").style.display = "none";
                                                }
                                }


                            </script>
                            <script language="javascript" type="text/javascript">
                                function ServiceValidation() {


                                    var val = document.getElementById('<%= ddlservicetype.ClientID %>').value;
                                    var val1 = document.getElementById('<%= ddlserdocument.ClientID %>').value;
                                    var err = "";
                                    var cmp_count = 0;

                                    if (val == "-1")
                                        err += '<li>Please select service type.</li></br>';
                                    if (val1 == "-1")
                                        err += '<li>Please select service document type.</li></br>';
                                    if (err != "") {
                                        altbox(err);
                                        return false;
                                    }




                                    if (val1 == "618" || val1 == "619") {
                                        if (document.getElementById('<%= ddlrequester.ClientID %>').value == '-1')
                                            err += '<li>Please select requester.</li></br>';
                                    }


                                    if (val1 == "618") {

                                        if (document.getElementById('<%= txtDateMailed.ClientID %>').value == '')
                                            err += '<li>Please enter date mailed.</li></br>';


                                    }
                                    else
                                        if (val1 == "619") {

                                            if (document.getElementById('<%= txtDateMailed.ClientID %>').value == '')
                                                err += '<li>Please enter date mailed.</li></br>';

                                            if (document.getElementById('<%= txttracking.ClientID %>').value == '')
                                                err += '<li>Please enter tracking.</li></br>';


                                        }
                                        else
                                            if (val1 == "620") {

                                                if (document.getElementById('<%= txtDateMailed.ClientID %>').value == '')
                                                    err += '<li>Please enter date mailed.</li></br>';

                                                if (document.getElementById('<%= txtreturndate.ClientID %>').value == '')
                                                    err += '<li>Please enter return date.</li></br>';

                                                if (document.getElementById('<%= ddlservicecountry.ClientID %>').value == '-1')
                                                    err += '<li>Please select county.</li></br>';





                                            }
                                            else
                                                if (val1 == "621") {


                                                }

                                    if (err != "") {
                                        Msgbox(err)
                                        return false;
                                    }

                                    return true;
                                }

                            </script>
                            <td align="right">
                                <asp:Label ID="Label38" runat="server" Text="Service Type"></asp:Label>
                            </td>
                            <td align="left">
                                <asp:DropDownList ID="ddlservicetype" CssClass="required" error="Please Select Service Type."
                                    runat="server" onchange="javascript:obt_changeNew(this)">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr id="Certifiedmail">
                            <td align="right">
                                <asp:Label ID="Label2" runat="server" Text="Certified Mail Number"></asp:Label>
                            </td>
                            <td align="left">
                                <asp:TextBox ID="txtcetifiedmailnumber" placeholder="Certified Mail Number" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr id="trdatemailed">
                            <td align="right">
                                <asp:Label ID="Label14" runat="server" Text="Date Mailed"></asp:Label>
                            </td>
                            <td align="left">
                                <asp:TextBox ID="txtDateMailed" placeholder="Date Mailed" runat="server" CssClass="date"></asp:TextBox>
                            </td>
                        </tr>
                        <tr id="trrbldateeffectuated">
                            <td align="right">
                                <%-- <asp:Label ID="Label46" runat="server" Text="*" style="color:Red;font-family:Arial;font-style:Bold;font-size:11pt;"></asp:Label>--%>
                                <asp:Label ID="Label10" runat="server" Text="Delivery effectuated?"></asp:Label>
                            </td>
                            <td align="left">
                                <asp:RadioButtonList ID="rbleffectuated" runat="server" RepeatDirection="Horizontal"
                                    onclick="validdisplay()">
                                    <asp:ListItem Value="Yes">Yes</asp:ListItem>
                                    <asp:ListItem Value="No">No</asp:ListItem>
                                    <asp:ListItem Value="UnKnown">UnKnown</asp:ListItem>
                                </asp:RadioButtonList>
                            </td>
                        </tr>
                        <tr id="date1">
                            <td align="right" id="noticedate">
                                <asp:Label ID="Label9" runat="server" Text="First Notice Attempted Date:"></asp:Label>
                            </td>
                            <td align="left">
                                <asp:TextBox ID="txtnoticedate" placeholder="First Notice Attempted Date" runat="server"
                                    CssClass="date"></asp:TextBox>
                            </td>
                        </tr>
                        <tr id="date3">
                            <td align="right">
                                <asp:Label ID="Label84" runat="server" Text="Return Date"></asp:Label>
                            </td>
                            <td align="left">
                                <asp:TextBox ID="txtreturndate" placeholder="Return Date" runat="server" CssClass="date"></asp:TextBox>
                            </td>
                        </tr>
                        <tr id="trservicearchieved">
                            <td align="right">
                                <%-- <asp:Label ID="Label46" runat="server" Text="*" style="color:Red;font-family:Arial;font-style:Bold;font-size:11pt;"></asp:Label>--%>
                                <asp:Label ID="Label15" runat="server" Text="Service Achived"></asp:Label>
                            </td>
                            <td align="left">
                                <asp:RadioButtonList ID="rdbservicearchieved" runat="server" RepeatDirection="Horizontal"
                                    onclick="serachieved()">
                                    <asp:ListItem Value="Yes">Yes</asp:ListItem>
                                    <asp:ListItem Value="No">No</asp:ListItem>
                                </asp:RadioButtonList>
                                <script language="javascript">

                                    function serachieved() {
                                        var rb = document.getElementById('<%= rdbservicearchieved.ClientID %>');

                                        var selection = get_radiobuttonselectedindex(rb);
                                        if (selection == 0) {
                                            //document.getElementById("trdatemailed").style.display="none";
                                            document.getElementById("serveddate").style.display = "block";

                                        }
                                        else if (selection == 1) {
                                            //document.getElementById("trdatemailed").style.display="none";
                                            document.getElementById("serveddate").style.display = "none";

                                        }



                                    }


                                </script>
                            </td>
                        </tr>
                        <tr id="trdelivered">
                            <td align="right">
                                <%-- <asp:Label ID="Label46" runat="server" Text="*" style="color:Red;font-family:Arial;font-style:Bold;font-size:11pt;"></asp:Label>--%>
                                <asp:Label ID="Label17" runat="server" Text="Delivered?"></asp:Label>
                            </td>
                            <td align="left">
                                <asp:RadioButtonList ID="rdbdelivered" runat="server" RepeatDirection="Horizontal"
                                    onclick="delivered()">
                                    <asp:ListItem Value="Yes">Yes</asp:ListItem>
                                    <asp:ListItem Value="No">No</asp:ListItem>
                                </asp:RadioButtonList>
                                <script language="javascript">

                                    function delivered() {
                                        var rb = document.getElementById('<%= rdbdelivered.ClientID %>');

                                        var selection = get_radiobuttonselectedindex(rb);
                                        if (selection == 0) {
                                            //document.getElementById("trdatemailed").style.display="none";
                                            document.getElementById("date2").style.display = "block";


                                        }
                                        else if (selection == 1) {
                                            //document.getElementById("trdatemailed").style.display="none";
                                            document.getElementById("date2").style.display = "none";

                                        }



                                    }


                                </script>
                            </td>
                        </tr>
                        <tr id="serveddate">
                            <td align="right">
                                <asp:Label ID="Label7" runat="server" Text="Served Date"></asp:Label>
                            </td>
                            <td align="left">
                                <asp:TextBox ID="txtserveddate" placeholder="Served Date" runat="server" CssClass="date"></asp:TextBox>
                            </td>
                        </tr>
                        <tr id="date2">
                            <td align="right">
                                <asp:Label ID="Label82" runat="server" Text="Delivery Date"></asp:Label>
                            </td>
                            <td align="left">
                                <asp:TextBox ID="txtdeliverydate" placeholder="Delivery Date" runat="server" CssClass="date"></asp:TextBox>
                            </td>
                        </tr>
                        <tr id="trsingleattempteddate">
                            <td align="right">
                                <asp:Label ID="Label19" runat="server" Text="First Attempted Date"></asp:Label>
                            </td>
                            <td align="left">
                                <asp:TextBox ID="txtsingleattempteddate" placeholder="First Attempted Date" runat="server"
                                    CssClass="date"></asp:TextBox>
                                <script language="javascript">
                                    function clear_attdate() {

                                    }
                                </script>
                            </td>
                        </tr>
                        <tr id="attemdatetr">
                            <td id="attemdate" align="right">
                                <asp:Label ID="Label41" runat="server" Text="Attempted Date"></asp:Label>
                            </td>
                            <td align="left">
                                <asp:DropDownList ID="ddlattempteddate" runat="server">
                                </asp:DropDownList>
                                <asp:Button ID="btn_AddNewAttemptedDate" CssClass="btn_next" runat="server" Style="background: url(./images/button_bg_small_2.png); color: #ffffff; font-family: Calibri; font-size: 13px; border: 0; font-weight: bold; background-repeat: no-repeat; height: 28px; width: 79px;"
                                    Text="New" OnClientClick="javascript:return clear_attdate()" />
                            </td>
                        </tr>
                        <tr id="tr20daysnotdate">
                            <td align="right">
                                <%--<asp:Label ID="Label15" runat="server" Text="*" style="display:none;color:Red;font-family:Arial;font-style:Bold;font-size:11pt;"></asp:Label>
                                                    <asp:Label ID="Label17" runat="server" Text="20 days notice satisfied:" ></asp:Label>--%>
                            </td>
                            <td>
                                <asp:CheckBox ID="chknotsatis" runat="server" Text="20 days notice satisfied" />
                            </td>
                        </tr>
                        <tr id="trchkundeliverable">
                            <td align="right">
                                <%--<asp:Label ID="Label15" runat="server" Text="*" style="display:none;color:Red;font-family:Arial;font-style:Bold;font-size:11pt;"></asp:Label>
                                                    <asp:Label ID="Label17" runat="server" Text="20 days notice satisfied:" ></asp:Label>--%>
                            </td>
                            <td>
                                <asp:CheckBox ID="chkundeliverable" runat="server" Text="Undeliverable" />
                            </td>
                        </tr>
                        <tr id="trservicesatisfied">
                            <td align="right">
                                <%--<asp:Label ID="Label15" runat="server" Text="*" style="display:none;color:Red;font-family:Arial;font-style:Bold;font-size:11pt;"></asp:Label>
                                                    <asp:Label ID="Label17" runat="server" Text="20 days notice satisfied:" ></asp:Label>--%>
                            </td>
                            <td>
                                <asp:CheckBox ID="chkservicesatified" runat="server" Text="Service Satisfied" />
                            </td>
                        </tr>
                        <tr id="reason">
                            <td align="right">
                                <asp:Label ID="Label43" runat="server" Text="Reason"></asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlservicereason" runat="server">
                                    <%--  <asp:ListItem Value="-1" >Select </asp:ListItem>
                                                        <asp:ListItem Value="Un-Claimed Certified mail">Un-Claimed Certified mail</asp:ListItem>
                                                        <asp:ListItem Value="Moved">Moved</asp:ListItem>
                                                        <asp:ListItem Value="Deceased">Deceased</asp:ListItem>
                                                        <asp:ListItem Value="Refused">Refused</asp:ListItem>
                                                        <asp:ListItem Value="Undeliverable">Undeliverable</asp:ListItem>--%>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr id="comment">
                            <td align="right">
                                <asp:Label ID="Label45" runat="server" Text="Comments"></asp:Label>
                            </td>
                            <td align="left">
                                <asp:TextBox ID="txtservicecomments" Width="250" placeholder="Comments" runat="server"
                                    Height="60" TextMode="MultiLine"></asp:TextBox>
                            </td>
                        </tr>
                        <tr id="country">
                            <td align="right">
                                <asp:Label ID="Label16" runat="server" Text="County"></asp:Label>
                            </td>
                            <td align="left">
                                <asp:DropDownList ID="ddlservicecountry" runat="server">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr id="tracking">
                            <td align="right">
                                <asp:Label ID="Label8" runat="server" Text="Tracking #"></asp:Label>
                            </td>
                            <td align="left">
                                <div class="txboxdiv">
                                    <asp:TextBox ID="txttracking" runat="server" placeholder="Tracking #"></asp:TextBox>
                                </div>
                            </td>
                        </tr>
                        <tr id="requestor">
                            <td align="right">
                                <asp:Label ID="Label50" runat="server" Text="Requestor "></asp:Label>
                            </td>
                            <td align="left">
                                <asp:DropDownList ID="ddlrequester" runat="server">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                <asp:Button ID="btnservicesubmit" OnClientClick="javascript:return Save_ValidationServices()"
                                    OnClick="btnservicesubmit_Click" runat="server" Text="Submit" />
                                <asp:Button ID="btnservicesupdate" OnClick="btnservicesupdate_Click" OnClientClick="javascript:return Save_ValidationServices()"
                                    runat="server" Text="Update" />
                            </td>
                            <td align="left">
                                <asp:Button ID="btnservicecancel" OnClientClick="javascript:return service_cancel()"
                                    runat="server" Text="Clear" />
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
        <div class="cpanel" style="display: none;">
            <div class="head accr">
                Attorney
            </div>
            <div class="body">
                <div align="right" style="margin-top: 10px; margin-right: 15px; margin-bottom: 8px;">
                    <input type="button" id="btnnewattorney1" value="Add New " onclick="javascript: return clear_attorney()"
                        class="poptrg" />
                </div>
                <div id='btnnewattorney1_pop' class="popup" style="display: none;">
                    <span class="title">Attorney</span>
                    <centre>



                                          <table width="100%" align="center" id="frmAttorney">
                                          
                                            <tr>
                                                <td align="right" class="Labels">
                                                    Attorney Name
                                                </td>
                                                <td align="left">
                                                <div class="txboxdiv">
                                                        <asp:TextBox ID="txtattorneyname" CssClass="required" error="Please enter name." placeholder="Attorney Name" Width="150" runat="server" ></asp:TextBox>
                                                     <asp:HiddenField ID="hfd_att" runat="server" Value="0" /> 
                                                        </div>
                                                  <asp:HiddenField ID="HiddenField1" runat="server" Value="0" />
                                                </td>
                                                <td align="left">
                                                                          <%-- <asp:UpdatePanel id="UpdatePanel1" runat="server"><ContentTemplate>
                                                                                <asp:Button ID="Button1" runat="server" CssClass="button_bg" Height="30" 
                                                                                   Text="Search" Width="108px" OnClientClick="javascript:return open_editcompalint()"/>
                                                                                    </ContentTemplate> </asp:UpdatePanel> --%>
                                                                            </td>
                                            </tr>
                                            <tr>
                                                <td align="right" class="Labels">
                                                    Address
                                                </td>
                                                <td align="left">
                                                <div class="txboxdiv">
                                                        <asp:TextBox ID="txtattorneyAddress" CssClass="required" placeholder="Address" error="Please enter address." Width="150" runat="server" ></asp:TextBox>
                                                        </div>
                                                  
                                                </td>
                                                </tr>
                                                 <tr>
                                                <td align="right" class="Labels">
                                                    City
                                                </td>
                                                <td align="left">
                                                <div class="txboxdiv">
                                                        <asp:TextBox ID="txtattroneyCity" CssClass="required" placeholder="City" error="Please enter city."  Width="150" runat="server" ></asp:TextBox>
                                                        </div>
                                                  
                                                </td>
                                                </tr>
                                                 <tr>
                                                <td align="right" class="Labels">
                                                    State
                                                </td>
                                                <td align="left">
                                                <div class="txboxdiv">
                                                        <asp:TextBox ID="txtattorneyState" placeholder="State" CssClass="required" error="Please enter state."  Width="150" runat="server" ></asp:TextBox>
                                                        </div>
                                                  
                                                </td>
                                                </tr>
                                            <tr>
                                                <td align="right" class="Labels">
                                                    Status
                                                </td>
                                                <td align="left">
                                                    <asp:DropDownList ID="ddlattorneystatus" CssClass="required" error="Please select status." runat="server"  >
                                                        <asp:ListItem Value="-1" >Select Status</asp:ListItem>
                                                        <asp:ListItem Value="1" >Active</asp:ListItem>
                                                        <asp:ListItem Value="0" >Inactive</asp:ListItem>
                                                    </asp:DropDownList>
                                                </td>
                                                <td>&nbsp;</td>
                                            </tr>
                                            <%-- <tr>
                                               <td></td>
                                                <td align="left" class="Labels">
                                                    <asp:CheckBox ID="chbexpecathear" runat="server" Text="Expected at Hearing?" Checked="true"/>
                                                </td>
                                                <td></td>
                                            </tr>--%>
                                           
                                            <tr>
                                                <td colspan="3"  align="center">
                                                   <table >
                                                            <tr>

                                                                <td align="center">

                                                                     <asp:Button ID="btnattorneysubmit"  OnClick="btnattorneysubmit_Click"  OnClientClick="javascript:return Save_ValidationAttorney()" runat="server" Text="Submit" />

                                                                
                                                            </td>
                                                            <td>
                                                                 <asp:Button ID="btnattorneyupdate" OnClientClick="javascript:return Save_ValidationAttorney()" OnClick="btnattorneyupdate_Click" runat="server" Text="Update" />

                                                              
                                                            </td>
                                                            <td>
                                                                 <asp:Button ID="btnattorneycancel" OnClientClick="javascript:return attorney_cancel()" runat="server" Text="Clear" />

                                                               
                                                            </td>
                                                                </tr>
                                                            </table>
                                                </td>
                                            </tr>
                                          
                                        </table>


                                    
                                                   
                                      </centre>
                </div>
                <script language="javascript" type="text/javascript">
                    function clear_attorney() {
                        // if (document.getElementById('<%= hfdselarid.ClientID %>').value != '0')
                        //  {
                        document.getElementById('<%= txtattorneyname.ClientID %>').value = '';
                        document.getElementById('<%= ddlattorneystatus.ClientID %>').value = '-1';

                        document.getElementById('<%= txtattorneyAddress.ClientID %>').value = '';
                        document.getElementById('<%= txtattroneyCity.ClientID %>').value = '';
                        document.getElementById('<%= txtattorneyState.ClientID %>').value = '';

                        // document.getElementById(' Label4.ClientID ').innerText = 'Attorney';

                        document.getElementById('<%= btnattorneysubmit.ClientID %>').style.display = 'block';
                        document.getElementById('<%= btnattorneyupdate.ClientID %>').style.display = 'none';
                        document.getElementById('<%= hfd_att.ClientID %>').value = '0';
                        document.getElementById('btnnewattorney1').click();
                        // }
                        // else
                        // altbox("Select Participant!");
                        return false;
                    }
                    function fill_attorney(hfdid, name, add, city, sate, status) {

                        document.getElementById('<%= txtattorneyname.ClientID %>').value = name;

                        document.getElementById('<%= txtattorneyAddress.ClientID %>').value = add;
                        document.getElementById('<%= txtattroneyCity.ClientID %>').value = city;
                        document.getElementById('<%= txtattorneyState.ClientID %>').value = sate;


                        document.getElementById('<%= ddlattorneystatus.ClientID %>').value = status;

                        // document.getElementById(' Label4.ClientID ').innerText = 'Attorney - for ' + name;


                        document.getElementById('<%= ddlattorneystatus.ClientID %>').value = status;
                        document.getElementById('<%= btnattorneysubmit.ClientID %>').style.display = 'none';
                        document.getElementById('<%= btnattorneyupdate.ClientID %>').style.display = 'block';

                        document.getElementById('<%= hfd_att.ClientID %>').value = hfdid;

                        $(function () { $('#btnnewattorney1_pop').dialog("open"); });
                        // document.getElementById('btnnewattorney1').click();
                        return false;
                    }
                    function attorney_cancel() {
                        document.getElementById('imgcancelattorney').click();
                        return false;
                    }
                </script>
                <center>
                    <div id="grdAttorney">
                    </div>
                </center>
            </div>
        </div>

        <div class="cpanel" style="display: none;">
            <div class="head accr">
                Events
            </div>
            <div class="body">
                <div align="right" style="margin-top: 10px; margin-right: 15px; margin-bottom: 8px;">
                    <input type="button" id="btnCompEventsNew1" value="Add New " onclick="javascript: return clear_events()"
                        class="poptrg" />
                </div>
                <center>
                    <div id="grdCompEvents">
                    </div>
                    <asp:Button ID="btneventremove" OnClick="btneventremove_Click" Style="display: none"
                        runat="server" Text="Delete" />

                </center>
                <div id='btnCompEventsNew1_pop' class="popup" style="display: none;">
                    <span class="title">Events</span>
                    <table width="100%" class="spac" id='frmEvents'>
                        <tr>
                            <td>&nbsp;
                            </td>
                            <td></td>
                        </tr>
                        <tr>
                            <td align="right">
                                <asp:Label ID="Label87" runat="server" Text="Date"></asp:Label>
                            </td>
                            <td>
                                <div class="txboxdiv">
                                    <asp:TextBox ID="txteventdate" CssClass=" date required" error="Please enter date."
                                        runat="server" Width="145"></asp:TextBox>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                <asp:Label ID="Label89" runat="server" Text="Time"></asp:Label>
                            </td>
                            <td>
                                <table>
                                    <tr>
                                        <td>
                                            <asp:DropDownList ID="ddleventhrs" runat="server" CssClass="required" Width="50px"
                                                error="Please select time.">
                                                <asp:ListItem Value="-1">Select</asp:ListItem>
                                                <asp:ListItem Text="1" Value="1"></asp:ListItem>
                                                <asp:ListItem Text="2" Value="2"></asp:ListItem>
                                                <asp:ListItem Text="3" Value="3"></asp:ListItem>
                                                <asp:ListItem Text="4" Value="4"></asp:ListItem>
                                                <asp:ListItem Text="5" Value="5"></asp:ListItem>
                                                <asp:ListItem Text="6" Value="6"></asp:ListItem>
                                                <asp:ListItem Text="7" Value="7"></asp:ListItem>
                                                <asp:ListItem Text="8" Value="8"></asp:ListItem>
                                                <asp:ListItem Text="9" Value="9"></asp:ListItem>
                                                <asp:ListItem Text="10" Value="10"></asp:ListItem>
                                                <asp:ListItem Text="11" Value="11"></asp:ListItem>
                                                <asp:ListItem Text="12" Value="12"></asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="ddleventmnts" runat="server" CssClass="required" Width="50px"
                                                error="Please select mnts.">
                                                <asp:ListItem Value="-1">Select</asp:ListItem>
                                                <asp:ListItem Value="0">00</asp:ListItem>
                                                <asp:ListItem Value="1">01</asp:ListItem>
                                                <asp:ListItem Value="2">2</asp:ListItem>
                                                <asp:ListItem Value="3">3</asp:ListItem>
                                                <asp:ListItem Value="4">4</asp:ListItem>
                                                <asp:ListItem Value="5">5</asp:ListItem>
                                                <asp:ListItem Value="6">6</asp:ListItem>
                                                <asp:ListItem Value="7">7</asp:ListItem>
                                                <asp:ListItem Value="8">8</asp:ListItem>
                                                <asp:ListItem Value="9">9</asp:ListItem>
                                                <asp:ListItem Value="10">10</asp:ListItem>
                                                <asp:ListItem Value="11">11</asp:ListItem>
                                                <asp:ListItem Value="12">12</asp:ListItem>
                                                <asp:ListItem Value="13">13</asp:ListItem>
                                                <asp:ListItem Value="14">14</asp:ListItem>
                                                <asp:ListItem Value="15">15</asp:ListItem>
                                                <asp:ListItem Value="16">16</asp:ListItem>
                                                <asp:ListItem Value="17">17</asp:ListItem>
                                                <asp:ListItem Value="18">18</asp:ListItem>
                                                <asp:ListItem Value="19">19</asp:ListItem>
                                                <asp:ListItem Value="20">20</asp:ListItem>
                                                <asp:ListItem Value="21">21</asp:ListItem>
                                                <asp:ListItem Value="22">22</asp:ListItem>
                                                <asp:ListItem Value="23">23</asp:ListItem>
                                                <asp:ListItem Value="24">24</asp:ListItem>
                                                <asp:ListItem Value="25">25</asp:ListItem>
                                                <asp:ListItem Value="26">26</asp:ListItem>
                                                <asp:ListItem Value="27">27</asp:ListItem>
                                                <asp:ListItem Value="28">28</asp:ListItem>
                                                <asp:ListItem Value="29">29</asp:ListItem>
                                                <asp:ListItem Value="30">30</asp:ListItem>
                                                <asp:ListItem Value="31">31</asp:ListItem>
                                                <asp:ListItem Value="32">32</asp:ListItem>
                                                <asp:ListItem Value="33">33</asp:ListItem>
                                                <asp:ListItem Value="34">34</asp:ListItem>
                                                <asp:ListItem Value="35">35</asp:ListItem>
                                                <asp:ListItem Value="36">36</asp:ListItem>
                                                <asp:ListItem Value="37">37</asp:ListItem>
                                                <asp:ListItem Value="38">38</asp:ListItem>
                                                <asp:ListItem Value="39">39</asp:ListItem>
                                                <asp:ListItem Value="40">40</asp:ListItem>
                                                <asp:ListItem Value="41">41</asp:ListItem>
                                                <asp:ListItem Value="42">42</asp:ListItem>
                                                <asp:ListItem Value="43">43</asp:ListItem>
                                                <asp:ListItem Value="44">44</asp:ListItem>
                                                <asp:ListItem Value="45">45</asp:ListItem>
                                                <asp:ListItem Value="46">46</asp:ListItem>
                                                <asp:ListItem Value="47">47</asp:ListItem>
                                                <asp:ListItem Value="48">48</asp:ListItem>
                                                <asp:ListItem Value="49">49</asp:ListItem>
                                                <asp:ListItem Value="50">50</asp:ListItem>
                                                <asp:ListItem Value="51">51</asp:ListItem>
                                                <asp:ListItem Value="52">52</asp:ListItem>
                                                <asp:ListItem Value="53">53</asp:ListItem>
                                                <asp:ListItem Value="54">54</asp:ListItem>
                                                <asp:ListItem Value="55">55</asp:ListItem>
                                                <asp:ListItem Value="56">56</asp:ListItem>
                                                <asp:ListItem Value="57">57</asp:ListItem>
                                                <asp:ListItem Value="58">58</asp:ListItem>
                                                <asp:ListItem Value="59">59</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                        <td>
                                            <asp:RadioButtonList ID="rdbevent" runat="server" RepeatDirection="Horizontal">
                                                <asp:ListItem Value="AM" Selected="True">AM</asp:ListItem>
                                                <asp:ListItem Value="PM">PM</asp:ListItem>
                                            </asp:RadioButtonList>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                <asp:Label ID="Label91" runat="server" Text="Event Type"></asp:Label>
                            </td>
                            <td>
                                <%-- <asp:UpdatePanel ID="updloc" runat="server" ><ContentTemplate>--%>
                                <%--<asp:TextBox ID="txthearinglocation" runat="server"   Width="145"  ></asp:TextBox>--%>
                                <asp:DropDownList ID="ddleventtype" runat="server" CssClass="required" error="Please select event type">
                                </asp:DropDownList>
                                <%--  </ContentTemplate></asp:UpdatePanel>--%>
                            </td>
                        </tr>
                        <tr>
                            <td align="right" valign="top">
                                <%-- <asp:Label ID="Label92" runat="server" Text="*" style="color:Red;font-family:Arial;font-style:Bold;font-size:11pt;"></asp:Label>--%>
                                <asp:Label ID="Label93" runat="server" Text="Responsible Person"></asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddleventresponseperson" runat="server" Style="display: block">
                                </asp:DropDownList>
                                <div style="border: 1px solid #800000;">
                                    <asp:CheckBoxList ID="chbeventresperson" runat="server" Width="250px" Style="display: block"
                                        Height="100px">
                                    </asp:CheckBoxList>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                <%--<asp:Label ID="Label94" runat="server" Text="*" style="color:Red;font-family:Arial;font-style:Bold;font-size:11pt;"></asp:Label>--%>
                                <asp:Label ID="Label95" runat="server" Text="Email Reminder"></asp:Label>
                            </td>
                            <td>
                                <asp:RadioButtonList ID="rbtnEmailrem" runat="server" RepeatDirection="Vertical">
                                    <asp:ListItem Value="4">15 minutes before</asp:ListItem>
                                    <asp:ListItem Value="5">30 minutes before</asp:ListItem>
                                    <asp:ListItem Value="0">One Hour before</asp:ListItem>
                                    <asp:ListItem Value="1">A day before</asp:ListItem>
                                    <asp:ListItem Value="2">Two days before</asp:ListItem>
                                    <asp:ListItem Value="3">One week before</asp:ListItem>
                                </asp:RadioButtonList>
                                <%--  <asp:CheckBoxList ID="chkeventsemailrem" runat="server" RepeatDirection="Vertical"  >
                                                    <asp:ListItem   Value="4">15 minutes before</asp:ListItem>
                                                     <asp:ListItem Value="5">30 minutes before</asp:ListItem>
                                                    <asp:ListItem Value="0">One Hour before</asp:ListItem>
                                                   <asp:ListItem Value="1">A day before</asp:ListItem>
                                                   <asp:ListItem Value="2">Two days before</asp:ListItem>
                                                   <asp:ListItem Value="3">One week before</asp:ListItem>
                                                   
                                                   </asp:CheckBoxList>--%>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                <%--<asp:Label ID="Label96" runat="server" Text="*" style="color:Red;font-family:Arial;font-style:Bold;font-size:11pt;"></asp:Label>--%>
                                <asp:Label ID="Label97" runat="server" Text="Comments"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtEventsComments" placeholder="Comments" runat="server" TextMode="MultiLine"
                                    Width="200px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <center>
                                    <table align="center">
                                        <tr>
                                            <td align="center">
                                                <asp:Button ID="btnEventsInsert" OnClick="btnEventsInsert_Click" OnClientClick="javascript:return Save_ValidationEvents()"
                                                    runat="server" Text="Submit" />
                                                <script type="text/javascript" language="javascript">



                                                    function EventsValidation() {


                                                        var err = "";

                                                        var count = 0;



                                                        if (document.getElementById('<%= txteventdate.ClientID %>').value == '') {

                                                            err += 'Please enter event date. \r\n';
                                                        }
                                                        if (document.getElementById('<%= ddleventhrs.ClientID %>').value == '-1') {

                                                            err += 'Please enter event hours. \r\n';
                                                        }
                                                        if (document.getElementById('<%= ddleventmnts.ClientID %>').value == '-1') {

                                                            err += 'Please enter event mnts. \r\n';
                                                        }

                                                        if (document.getElementById('<%= ddleventtype.ClientID %>').value == '1') {

                                                            err += 'Please enter event type. \r\n';
                                                        }




                                                        //err+=Value_Checked('<%= txtEventsComments.ClientID %>',"Please Enter EventsComments. \r\n");

                                                        //err+=Value_checkbox_Checked('<%= rbtnEmailrem.ClientID %>',"Please select Email Remainder. \r\n");========

                                                        if (err != "") {

                                                            altbox(err);

                                                            return false;

                                                        }

                                                        return true;



                                                    }

                                                </script>
                                            </td>
                                            <td>
                                                <asp:Button ID="btnEventsUpdate" OnClick="btnEventsUpdate_Click" OnClientClick="javascript:return Save_ValidationEvents()"
                                                    runat="server" Text="Update" />
                                            </td>
                                            <td align="center">
                                                <asp:Button ID="btnEventsCancel" OnClientClick="javascript:return events_cancel()"
                                                    runat="server" Text="Clear" />
                                            </td>
                                        </tr>
                                    </table>
                                </center>
                            </td>
                        </tr>
                    </table>
                    <script language="javascript">
                        function clear_events() {
                            // if (document.getElementById('<%= hfdselarid.ClientID %>').value != '0') {

                            document.getElementById('<%= txteventdate.ClientID %>').value = '';
                            document.getElementById('<%= ddleventhrs.ClientID %>').value = '-1';
                            document.getElementById('<%= rdbevent.ClientID %>').value = '';
                            document.getElementById('<%= ddleventmnts.ClientID %>').value = '-1';
                            document.getElementById('<%= ddleventtype.ClientID %>').value = '1';
                            document.getElementById('<%= ddleventresponseperson.ClientID %>').value = '';
                            document.getElementById('<%= txtEventsComments.ClientID %>').value = '';
                            document.getElementById('<%= btnEventsInsert.ClientID %>').style.display = 'block';
                            document.getElementById('<%= btnEventsUpdate.ClientID %>').style.display = 'none';

                            document.getElementById('<%= hdnevents.ClientID %>').value = '0';

                            document.getElementById('ctl00_ContentPlaceHolder1_rbtnEmailrem_0').checked = false;
                            document.getElementById('ctl00_ContentPlaceHolder1_rbtnEmailrem_1').checked = false;
                            document.getElementById('ctl00_ContentPlaceHolder1_rbtnEmailrem_2').checked = false;
                            document.getElementById('ctl00_ContentPlaceHolder1_rbtnEmailrem_3').checked = false;
                            document.getElementById('ctl00_ContentPlaceHolder1_rbtnEmailrem_4').checked = false;
                            document.getElementById('ctl00_ContentPlaceHolder1_rbtnEmailrem_5').checked = false;

                            // document.getElementById('<%= ddleventresponseperson.ClientID %>').style.display = 'none';

                            //document.getElementById(' btnCompEventsNew1').click();

                            // }
                            // else {
                            //   altbox("Please Select Participant");
                            // }
                            return false;
                        }
                        function checkuserext(userid, susers) {
                            for (var i = 0; i < susers.length; i++) {
                                if (susers[i] == userid)
                                    return true;
                            }

                            return false;
                        }


                        function DeleteEvent(hfdid) {




                            var retVal = confirm("Do you want to delete this event ?");
                            if (retVal == true) {
                                document.getElementById('<%= hdnevents.ClientID %>').value = hfdid;


                                return true;
                            }
                            else {

                                return false;
                            }

                        }


                        function fill_events(hfdid, date, time, etype, resper, emailrem, comments) {
                            //document.getElementById('<%= ddleventresponseperson.ClientID %>').value = resper;

                            document.getElementById('<%= txteventdate.ClientID %>').value = date;


                            // var opt1 = document.getElementById('<%= ddleventresponseperson.ClientID %>').options;
                            // for (var k = 0; j < opt1.length; k++) {
                            //   if (opt1[k].value == resper.trim()) {
                            //        document.getElementById('<%= ddleventresponseperson.ClientID %>').value = opt1[k].value;
                            //        k = opt1.length;
                            //   }
                            // }

                            document.getElementById('<%= ddleventresponseperson.ClientID %>').value = resper;

                            var opt = document.getElementById('<%= ddleventtype.ClientID %>').options;




                            for (var j = 0; j < opt.length; j++) {
                                if (opt[j].value == etype.trim()) {
                                    document.getElementById('<%= ddleventtype.ClientID %>').value = opt[j].value;
                                    j = opt.length;
                                }
                            }


                            var hrsmnts = time.toString().split(':');

                            var hrsmnts1 = hrsmnts[1].toString().split(' ');
                            document.getElementById('<%= ddleventhrs.ClientID %>').value = hrsmnts[0];




                            document.getElementById('<%= ddleventmnts.ClientID %>').value = hrsmnts1[0];

                            var cl = document.getElementById('<%= rdbevent.ClientID %>');

                            if (hrsmnts1[1] == "AM")
                                document.getElementById('ctl00_ContentPlaceHolder1_rdbevent_0').checked = true;

                                //cl.cells[0].all[0].checked = true;
                            else
                                document.getElementById('ctl00_ContentPlaceHolder1__rdbevent_1').checked = true;
                            // cl.cells[1].all[0].checked = true;


                            //document.getElementById('<%= ddleventmnts.ClientID %>').value = hrsmnts1[0];



                            var cl1 = document.getElementById('<%= rbtnEmailrem.ClientID %>');



                            if (emailrem == "15 minutes before") {

                                document.getElementById('ctl00_ContentPlaceHolder1_rbtnEmailrem_0').checked = true;
                                document.getElementById('ctl00_ContentPlaceHolder1_rbtnEmailrem_1').checked = false;
                                document.getElementById('ctl00_ContentPlaceHolder1_rbtnEmailrem_2').checked = false;
                                document.getElementById('ctl00_ContentPlaceHolder1_rbtnEmailrem_3').checked = false;
                                document.getElementById('ctl00_ContentPlaceHolder1_rbtnEmailrem_4').checked = false;
                                document.getElementById('ctl00_ContentPlaceHolder1_rbtnEmailrem_5').checked = false;

                            }
                            else

                                if (emailrem == "30 minutes before") {

                                    document.getElementById('ctl00_ContentPlaceHolder1_rbtnEmailrem_0').checked = false;
                                    document.getElementById('ctl00_ContentPlaceHolder1_rbtnEmailrem_1').checked = true;
                                    document.getElementById('ctl00_ContentPlaceHolder1_rbtnEmailrem_2').checked = false;
                                    document.getElementById('ctl00_ContentPlaceHolder1_rbtnEmailrem_3').checked = false;
                                    document.getElementById('ctl00_ContentPlaceHolder1_rbtnEmailrem_4').checked = false;
                                    document.getElementById('ctl00_ContentPlaceHolder1_rbtnEmailrem_5').checked = false;
                                }
                                else
                                    if (emailrem == "One Hour before") {

                                        document.getElementById('ctl00_ContentPlaceHolder1_rbtnEmailrem_0').checked = false;
                                        document.getElementById('ctl00_ContentPlaceHolder1_rbtnEmailrem_1').checked = false;
                                        document.getElementById('ctl00_ContentPlaceHolder1_rbtnEmailrem_2').checked = true;
                                        document.getElementById('ctl00_ContentPlaceHolder1_rbtnEmailrem_3').checked = false;
                                        document.getElementById('ctl00_ContentPlaceHolder1_rbtnEmailrem_4').checked = false;
                                        document.getElementById('ctl00_ContentPlaceHolder1_rbtnEmailrem_5').checked = false;
                                    }
                                    else
                                        if (emailrem == "A day before") {
                                            document.getElementById('ctl00_ContentPlaceHolder1_rbtnEmailrem_0').checked = false;
                                            document.getElementById('ctl00_ContentPlaceHolder1_rbtnEmailrem_1').checked = false;
                                            document.getElementById('ctl00_ContentPlaceHolder1_rbtnEmailrem_2').checked = false;
                                            document.getElementById('ctl00_ContentPlaceHolder1_rbtnEmailrem_3').checked = true;
                                            document.getElementById('ctl00_ContentPlaceHolder1_rbtnEmailrem_4').checked = false;
                                            document.getElementById('ctl00_ContentPlaceHolder1_rbtnEmailrem_5').checked = false;
                                        }
                                        else
                                            if (emailrem == "Two days before") {
                                                document.getElementById('ctl00_ContentPlaceHolder1_rbtnEmailrem_0').checked = false;
                                                document.getElementById('ctl00_ContentPlaceHolder1_rbtnEmailrem_1').checked = false;
                                                document.getElementById('ctl00_ContentPlaceHolder1_rbtnEmailrem_2').checked = false;
                                                document.getElementById('ctl00_ContentPlaceHolder1_rbtnEmailrem_3').checked = false;
                                                document.getElementById('ctl00_ContentPlaceHolder1_rbtnEmailrem_4').checked = true;
                                                document.getElementById('ctl00_ContentPlaceHolder1_rbtnEmailrem_5').checked = false;
                                            }
                                            else
                                                if (emailrem == "One week before") {
                                                    document.getElementById('ctl00_ContentPlaceHolder1_rbtnEmailrem_0').checked = false;
                                                    document.getElementById('ctl00_ContentPlaceHolder1_rbtnEmailrem_1').checked = false;
                                                    document.getElementById('ctl00_ContentPlaceHolder1_rbtnEmailrem_2').checked = false;
                                                    document.getElementById('ctl00_ContentPlaceHolder1_rbtnEmailrem_3').checked = false;
                                                    document.getElementById('ctl00_ContentPlaceHolder1_rbtnEmailrem_4').checked = false;
                                                    document.getElementById('ctl00_ContentPlaceHolder1_rbtnEmailrem_5').checked = true;
                                                }


                            document.getElementById('<%= txtEventsComments.ClientID %>').value = comments;
                            document.getElementById('<%= btnEventsInsert.ClientID %>').style.display = 'none';
                            document.getElementById('<%= btnEventsUpdate.ClientID %>').style.display = 'block';
                            document.getElementById('<%= hdnevents.ClientID %>').value = hfdid;

                            $(function () { $('#btnCompEventsNew1_pop').dialog("open"); });
                            //document.getElementById('btnCompEventsNew1').click();
                            return false;
                        }
                        function events_cancel() {
                            document.getElementById('imgeventcancel').click();
                            return false;
                        }


                    </script>
                </div>
            </div>
        </div>
        <div class="cpanel">
            <div class="head accr">
                Journal
            </div>
            <div class="body">
                <div align="right" style="margin-top: 10px; margin-right: 15px; margin-bottom: 8px;">
                    <input type="button" id="btnjournalnew1" value="Add New " onclick="javascript: return clear_jour()"
                        class="poptrg" />
                </div>
                <script language="javascript">

                    function ValidateJournal() {
                        var err = "";



                        if (document.getElementById('<%= ddlJournalType.ClientID %>').value == '-1') {
                            err += 'Please select journal type.\r\n';
                        }

                        if (document.getElementById('<%= txtjournaltype.ClientID %>').value == '') {
                            err += 'Please enter comments.\r\n';

                        }
                        if (err != "") {
                            altbox(err);
                            return false;
                        }
                        return true;


                    }

                    function DeleteJournal(hfdid) {




                        var retVal = confirm("Do you want to delete this Journal ?");
                        if (retVal == true) {
                            document.getElementById('<%= hfd_jouid.ClientID %>').value = hfdid;



                            return true;
                        }
                        else {

                            return false;
                        }

                    }



                    function clear_jour() {
                        document.getElementById('<%= ddlJournalType.ClientID %>').value = '-1';
                        document.getElementById('<%= txtjournaltype.ClientID %>').value = '';
                        document.getElementById('<%= btnjornalok.ClientID %>').style.display = 'block';
                        document.getElementById('<%= btnupdatejournal.ClientID %>').style.display = 'none';
                        document.getElementById('<%= hfd_jouid.ClientID %>').value = '0';
                        document.getElementById('journaldate').style.display = 'none';
                        document.getElementById('cmplist').style.display = 'block';

                        document.getElementById('btnjournalnew1').click();
                        return false;
                    }
                    function fill_jou(hfdid, joutype, notes, jdate) {
                        document.getElementById('cmplist').style.display = 'none';
                        var opt = document.getElementById('<%= ddlJournalType.ClientID %>').options;
                        for (var i = 0; i < opt.length; i++) {
                            if (opt[i].text == joutype) {
                                document.getElementById('<%= ddlJournalType.ClientID %>').value = opt[i].value;
                                i = opt.length;
                            }
                        }
                        document.getElementById('<%= txtjournaltype.ClientID %>').value = notes;
                        document.getElementById('<%= btnjornalok.ClientID %>').style.display = 'none';


                        document.getElementById('<%= btnupdatejournal.ClientID %>').style.display = 'block';

                        $('#journaldate').show();
                        //document.getElementById('journaldate').style.display = 'block';


                        document.getElementById('<%= txtjournaldate.ClientID %>').value = jdate;
                        document.getElementById('<%= hfd_jouid.ClientID %>').value = hfdid;

                        $(function () { $('#btnjournalnew1_pop').dialog("open"); });

                        // document.getElementById('btnjournalnew1').click();
                        return false;
                    }
                    function jou_cancel() {
                        document.getElementById('Img5').click();
                        return false;
                    }
                </script>
                <div id="grdnursejournal">
                </div>
                <asp:Button ID="btnJournalremove" Style="display: none" runat="server" OnClick="btnJournalremove_Click"
                    Text="Delete" />
                <div id='btnjournalnew1_pop' class="popup" style="display: none;">
                    <span class="title">New Journal</span>
                    <table width="100%" align="center" id="frmJournal" class="spac">
                        <tr id="cmplist" style="display: none">
                            <td align="right" class="Labels">Complaints
                            </td>
                            <td align="left">
                                <asp:CheckBoxList ID="chbcomp" runat="server" RepeatColumns="4">
                                </asp:CheckBoxList>
                            </td>
                        </tr>
                        <tr>
                            <td align="right" class="Labels">Type
                            </td>
                            <td align="left">
                                <%--<div class="txboxdiv">
                                                                                                                                       <asp:TextBox ID="TextBox4" Width="150" runat="server"  ></asp:TextBox></div>--%>
                                <asp:DropDownList ID="ddlJournalType" CssClass="required" error="Please select journal type"
                                    runat="server">
                                </asp:DropDownList>
                                <%-- <asp:CheckBox ID="ChkjournalAlert" runat="server" Text="Alert" TextAlign="Right" />--%>
                            </td>
                        </tr>
                        <tr id="journaldate" style="display: none">
                            <td align="right" class="Labels">Date
                            </td>
                            <td align="left">
                                <div class="txboxdiv">
                                    <asp:TextBox ID="txtjournaldate" runat="server" Width="145px"></asp:TextBox>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td align="right" class="Labels">Comment
                            </td>
                            <td colspan="" align="left">
                                <%-- <div class="txboxdiv">
                                                                                                                                    <asp:TextBox ID="txtjournaltype" Width="150" runat="server" ></asp:TextBox></div>--%>
                                <asp:TextBox ID="txtjournaltype" CssClass="required" error="Please enter comments"
                                    placeholder="Comment" runat="server" Width="98%" Height="50" TextMode="MultiLine"></asp:TextBox>
                                <asp:Label ID="lbljouid" Text="0" Visible="false" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" align="center">
                                <table>
                                    <tr>
                                        <td>
                                            <asp:Button ID="btnjornalok" OnClientClick="javascript:return Save_ValidationJournal()"
                                                OnClick="btnjornalok_Click" runat="server" Text="Submit" />
                                        </td>
                                        <td>
                                            <asp:Button ID="btnupdatejournal" OnClick="btnupdatejournal_Click" OnClientClick="javascript:return Save_ValidationJournal()"
                                                runat="server" Text="Update" />
                                        </td>
                                        <td>
                                            <asp:Button ID="btnjournalcancel" OnClientClick="javascript:return jou_cancel()"
                                                runat="server" Text="Clear" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
        <div class="cpanel">
            <div class="head accr">
                Companion Cases
            </div>
            <div class="body">
                 <div align="right" style="margin-top: 10px; margin-right: 15px; margin-bottom: 8px;">
                    <asp:Button ID="btngroup" runat="server" Text="Group Cases" OnClientClick="javascript:return grpcases()" />
                </div>
                <div id="grdCompanionCases">
                </div>
            </div>
        </div>
    </div>
    <div id="grpcs" class="popup">
        <div>
            Complaint # : <input id="scmpno" type="text" placeholder="Complaint #" width="100%" style="margin:10px" /> 
            <center>
               <asp:Button ID="btngrpcase" runat="server" Text="Group Complaint" OnClientClick="javascript:return savegroup()" />
            </center>
        </div>
    </div>
    <script type="text/javascript">
        function savegroup()
        {
            if ($('#scmpno').val() == '')
                altbox('Please enter complaint #.');
            else {
                var pdata = {};
                pdata["comid"] = $('#'+'<%= hfdcomid.ClientID %>').val();
                pdata["cmpnumber"] = $('#scmpno').val();
                $.ajax({
                    url: "../WCFGrid/GridService.svc/GroupCases",
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    data:JSON.stringify( pdata),
                    dataType: "json",
                    success: function (res) {
 
                        if(res.d!="")
                        {
                            altbox(res.d);
                        }
                        else
                        {
                            altbox("Information saved");
                            $('#grpcs').dialog('close');
                            sa6.process();
                        }

                    },
                    failure: function (error) {

                        
                    },
                    error: function (error) {

                       
                    }
                });
            }
            return false;
        }
        var selcasid = 0;
        function cnfdelungroup(res)
        {
            if(res=='true')
            {
                var pdata = {};
                pdata["auid"] = selcasid;
                $.ajax({
                    url: "../WCFGrid/GridService.svc/ungroupCases",
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    data: JSON.stringify(pdata),
                    dataType: "json",
                    success: function (res) {


                        altbox("Information Removed");

                        sa6.process();


                    },
                    failure: function (error) {


                    },
                    error: function (error) {


                    }
                });
            }
        }
        function Deletegroupcase(sender,keyval)
        {
            selcasid = keyval;
            cnfbox("Do you want to ungroup this case?", "cnfdelungroup");
        }
        function grpcases()
        {
            $('#scmpno').val('');
            $('#grpcs').dialog({ title: "Group Cases", width: "250px" });
            $('#grpcs').dialog('open');
            return false;
        }
        var isedit = $('#ctl00_hfdwrite').val();
        var isdel = $('#ctl00_hfddel').val();
        if (isedit == 'False') {
            $('#ctl00_ContentPlaceHolder1_btnaddpartnew').addClass('hide');
            $('#btnjournalnew1').addClass('hide');
        }
        if (isedit == 'True' && isdel == 'True') {
            sa1.cols = [new dcol("Name", "Name", "", "1", "0", "nm_click", "", ""), new dcol("Address1", "Address1"), new dcol("Address2", "Address2"), new dcol("CSZ", "CSZ"), new dcol("Phone", "Phone"), new dcol("Email", "Email"), new dcol("Role", "role"), new dcol("Select", "", "", "1", "1", "selectPartid_lkp", "fa fa-hand-o-up grdicon"), new dcol("Delete", "", "", "1", "1", "delPartid_lkp", "fa fa-trash-o grdicon")];
            sa5.cols = [new dcol("Type", "JrnlName"), new dcol("Comments", "Comments"), new dcol("Created Date", "Create_Date"), new dcol("Created By", "cUser"), new dcol("Edit", "", "", "1", "1", "editJournal_lkp", "fa fa-pencil-square-o grdicon"), new dcol("Delete", "", "", "1", "1", "DeleteJournal_lkp", "fa fa-trash-o grdicon")];
            sa6.cols = [new dcol("Complaint#", "Complaint_Number"), new dcol("Respondent", "respondentname"), new dcol("Status", "Status"), new dcol("Category", "CategoryDescription"), new dcol("Resolution", "Resolutions"), new dcol("Board Action", "Board_Action"), new dcol("Date Received", "DateReceived"), new dcol("Date Docketed", "DateDocketed"), new dcol("Ungroup", "", "", "1", "1", "Deletegroupcase", "fa fa-trash-o grdicon")];

        }
        else if (isedit == 'True') {
            sa1.cols = [new dcol("Name", "Name", "", "1", "0", "nm_click", "", ""), new dcol("Address1", "Address1"), new dcol("Address2", "Address2"), new dcol("CSZ", "CSZ"), new dcol("Phone", "Phone"), new dcol("Email", "Email"), new dcol("Role", "role"), new dcol("Select", "", "", "1", "1", "selectPartid_lkp", "fa fa-hand-o-up grdicon")];
            sa5.cols = [new dcol("Type", "JrnlName"), new dcol("Comments", "Comments"), new dcol("Created Date", "Create_Date"), new dcol("Created By", "cUser"), new dcol("Edit", "", "", "1", "1", "editJournal_lkp", "fa fa-pencil-square-o grdicon")];
            sa6.cols = [new dcol("Complaint#", "Complaint_Number"), new dcol("Respondent", "respondentname"), new dcol("Status", "Status"), new dcol("Category", "CategoryDescription"), new dcol("Resolution", "Resolutions"), new dcol("Board Action", "Board_Action"), new dcol("Date Received", "DateReceived"), new dcol("Date Docketed", "DateDocketed")];

        }
       else if (isdel == 'True') {
            sa1.cols = [new dcol("Name", "Name", "", "1", "0", "nm_click", "", ""), new dcol("Address1", "Address1"), new dcol("Address2", "Address2"), new dcol("CSZ", "CSZ"), new dcol("Phone", "Phone"), new dcol("Email", "Email"), new dcol("Role", "role"), new dcol("Select", "", "", "1", "1", "selectPartid_lkp", "fa fa-hand-o-up grdicon"), new dcol("Delete", "", "", "1", "1", "delPartid_lkp", "fa fa-trash-o grdicon")];
            sa5.cols = [new dcol("Type", "JrnlName"), new dcol("Comments", "Comments"), new dcol("Created Date", "Create_Date"), new dcol("Created By", "cUser"), new dcol("Delete", "", "", "1", "1", "DeleteJournal_lkp", "fa fa-trash-o grdicon")];
            sa6.cols = [new dcol("Complaint#", "Complaint_Number"), new dcol("Respondent", "respondentname"), new dcol("Status", "Status"), new dcol("Category", "CategoryDescription"), new dcol("Resolution", "Resolutions"), new dcol("Board Action", "Board_Action"), new dcol("Date Received", "DateReceived"), new dcol("Date Docketed", "DateDocketed"), new dcol("Ungroup", "", "", "1", "1", "Deletegroupcase", "fa fa-trash-o grdicon")];

        }
        else
        {
            sa1.cols = [new dcol("Name", "Name", "", "1", "0", "nm_click", "", ""), new dcol("Address1", "Address1"), new dcol("Address2", "Address2"), new dcol("CSZ", "CSZ"), new dcol("Phone", "Phone"), new dcol("Email", "Email"), new dcol("Role", "role"), new dcol("Select", "", "", "1", "1", "selectPartid_lkp", "fa fa-hand-o-up grdicon")];
            sa5.cols = [new dcol("Type", "JrnlName"), new dcol("Comments", "Comments"), new dcol("Created Date", "Create_Date"), new dcol("Created By", "cUser")];
            sa6.cols = [new dcol("Complaint#", "Complaint_Number"), new dcol("Respondent", "respondentname"), new dcol("Status", "Status"), new dcol("Category", "CategoryDescription"), new dcol("Resolution", "Resolutions"), new dcol("Board Action", "Board_Action"), new dcol("Date Received", "DateReceived"), new dcol("Date Docketed", "DateDocketed")];

        }
        sa1.process();
        sa5.process();
        sa6.process();
    </script>
</asp:Content>
