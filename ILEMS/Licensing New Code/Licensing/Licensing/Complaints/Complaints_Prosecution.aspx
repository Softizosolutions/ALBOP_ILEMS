<%@ Page Title="" Language="C#" MasterPageFile="~/Master Page/frm.Master" AutoEventWireup="true" CodeBehind="Complaints_Prosecution.aspx.cs" Inherits="Licensing.Complaints.Complaints_Prosecution" %>

<%@ Register Assembly="CKEditor.NET" Namespace="CKEditor.NET" TagPrefix="CKEditor" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="cntwin1" style="width: 98%; margin-left: auto; margin-right: auto;">

        <asp:UpdatePanel ID="upd1" runat="server">
            <ContentTemplate>

                <asp:HiddenField ID="hfd_pid" runat="server" />
                <asp:HiddenField ID="hfdrelatedcompid" runat="server" />
                <asp:HiddenField ID="hfdrelatedattorneyid" runat="server" />
                <asp:HiddenField ID="hfdParticipantType" runat="server" />
                <asp:HiddenField ID="hfdParticipantstatus" runat="server" value="0"/>
                <asp:HiddenField ID="hfdadmcomplaints" runat="server" Value="0" />
                <asp:HiddenField ID="hfdconlaw" runat="server" Value="0" />
                <asp:HiddenField ID="hfdcourtoffid" runat="server" Value="0" />
                <asp:HiddenField ID="hfdreporterid" runat="server" Value="0" />
                <asp:HiddenField ID="hfd_violation" runat="server" Value="0" />
                <asp:HiddenField ID="hfd_consent" runat="server" Value="0" />
                <asp:HiddenField ID="hfd_forhearing" runat="server" Value="0" />
                <asp:Button ID="btnhearingdelete" runat="server" Text="Delete" Style="display: none;" OnClick="btnhearingdelete_Click" />
            </ContentTemplate>
        </asp:UpdatePanel>

        <script type="text/javascript">
            var reshis = '';
            var resolutionhis = new sagrid();
            resolutionhis.url = '../WCFGrid/GridService.svc/BindResolutionHistory';
            resolutionhis.primarykeyval = 'Person_ID';
            resolutionhis.bindid = 'grdresolutionhistory';
            resolutionhis.cols = [new dcol("Resolution", "Resolution"), new dcol("Date of Resolution", "Old_Date_Of_Resolution"), new dcol("Date of Change", "Created_Date"), new dcol("User", "LogUser")];
            resolutionhis.objname = 'resolutionhis';
            resolutionhis.aftercall = 'Aftercall';

            function Aftercall() {
                var result = resolutionhis.resultdata;
                if (result.length > 0) {
                    document.getElementById('divresolutionhistory').style.display = 'block';
                    return true;
                }
                else {
                    document.getElementById('divresolutionhistory').style.display = 'none';
                    document.getElementById('grdresolutionhistory').innerHTML = '';
                    return false;
                }
            }
        </script>

        <script type="text/javascript">


            var dataIn = '';



            var sa2 = new sagrid();
            sa2.url = "../WCFGrid/GridService.svc/BindConsentoffer";
            sa2.primarykeyval = "ConsentOffer_ID";
            sa2.bindid = "grdconsentoffer";
            sa2.cols = [new dcol("Template", "ChooseOffer"), new dcol("Fine Amt", "FineAmount"), new dcol("Probation", "ProbationLength"), new dcol("Suspention", "SuspensionLength"), new dcol("Offer Date", "Offer_date"), new dcol("Due Date", "Due_date"), new dcol("Courses", "coursenames"), new dcol("Edit", "", "", "1", "1", "editConsentoffer_lkp", "fa fa-pencil-square-o grdicon")];
            sa2.objname = "sa2";
            dataIn = '"comid":"' + document.getElementById('<%= hfdrelatedcompid.ClientID %>').value + '"';
            sa2.data = dataIn;
            sa2.process();

            var sa3 = new sagrid();
            sa3.url = "../WCFGrid/GridService.svc/BindFormalHearing";
            sa3.primarykeyval = "Hearing_Id";
            sa3.bindid = "grdFormalHearing";
            
            sa3.objname = "sa3";


            var sa4 = new sagrid();
            sa4.url = "../WCFGrid/GridService.svc/BindViolation";
            sa4.primarykeyval = "Violation_ID";
            sa4.bindid = "grdviolation";
            sa4.cols = [new dcol("Violation  ", "Violations"), new dcol("Date Added", "DateAdded"), new dcol("Entered By", "UserName"), new dcol("Edit", "", "", "1", "1", "editViolation_lkp", "fa fa-pencil-square-o grdicon")];
            sa4.objname = "sa4";
            dataIn = '"comid":"' + document.getElementById('<%= hfdrelatedcompid.ClientID %>').value + '"';
            sa4.data = dataIn;
            sa4.process();



            function editConsentoffer_lkp(sender, keyval) {

                fill_consent(sa2.resultdata[sender]["ConsentOffer_ID"], sa2.resultdata[sender]["ChooseOffer"], sa2.resultdata[sender]["FineAmount"], sa2.resultdata[sender]["ProbationLength"], sa2.resultdata[sender]["IsProationTillCondition"], sa2.resultdata[sender]["SuspensionLength"], sa2.resultdata[sender]["IsSuspensionTillCondition"], sa2.resultdata[sender]["coursenames"], sa2.resultdata[sender]["Offer_date"], sa2.resultdata[sender]["Due_date"]);

            }

            function DeleteConsentoffer_lkp(sender, keyval) {

            }

            function editFormalHearing_lkp(sender, keyval) {


                fill_hearing(sa3.resultdata[sender]["Hearing_Id"], sa3.resultdata[sender]["Hearingdate"], sa3.resultdata[sender]["HearingTime"],
                    sa3.resultdata[sender]["HearingLocation"], sa3.resultdata[sender]["HearingOffer"], sa3.resultdata[sender]["CourtReporter"],
                    sa3.resultdata[sender]["IsRespondent"], sa3.resultdata[sender]["her_off"], sa3.resultdata[sender]["cur_off"], sa3.resultdata[sender]["tbd"], sa3.resultdata[sender]["Settled"], sa3.resultdata[sender]["HearingLocation"]);

            }

            function deleteFormalHearing_lkp(sender, keyval) {
                document.getElementById('<%=hfd_forhearing.ClientID%>').value = keyval;
             cnfbox(" Are you sure do you want to delete this record?", "cnffnreshearing");
         }
         function cnffnreshearing(result) {
             if (result == 'true')
                 document.getElementById('<%= btnhearingdelete.ClientID %>').click();
         }



         function editViolation_lkp(sender, keyval) {

             fill_violation(sa4.resultdata[sender]["Violation_ID"], sa4.resultdata[sender]["Violations"], sa4.resultdata[sender]["public_Info"]);

         }


         function print_lkp(sender, keyval) {

             var appid = sa3.resultdata[sender]["Hearing_Id"];
             parent.parent.printothrs(4, appid);
         }


         function afterpost(msg) {

             sa3.process();
             $('#btnHearingNew_pop').dialog('close');
             altbox(msg);

         }


         function ddl_change(ctl) {
             dataIn = '"sval":"' + ctl.value + '"';
             sa5.data = dataIn;
             sa5.process();
         }




         function Save_ValidationConclusion() {
             var errormsg = validateform('frmConclusion');
             if (errormsg != "") {
                 Msgbox(errormsg);
                 return false;
             }
             return true;

         }

         function Save_ValidationConsentOrder() {
             var errormsg = validateform('frmConsentOrder');
             if (errormsg != "") {
                 Msgbox(errormsg);
                 return false;
             }
             return true;

         }

         function Save_ValidationFormalhearing() {
             var errormsg = validateform('frmFormalHearing');
             if (errormsg != "") {
                 Msgbox(errormsg);
                 return false;
             }
             return true;

         }


         function Save_ValidationResolution() {
             var errormsg = validateform('frmResolution');
             var sts = document.getElementById('<%=hfdParticipantstatus.ClientID%>').value;
             if (sts == 'Closed')
             {
                if (errormsg != "") {
                    Msgbox(errormsg);
                    return false;
                }
             }
             else
             return true;

         }

         function Save_ValidationVoilation() {
             var errormsg = validateform('frmVoilation');
             if (errormsg != "") {
                 Msgbox(errormsg);
                 return false;
             }
             return true;

         }




        </script>

        <div class="cpanel">
            <div class="head accr">Finding Of Facts</div>
            <div class="body">
                <CKEditor:CKEditorControl ID="txtfindingoffacts" ToolTip="" ToolbarStartupExpanded="True" runat="server" Width="100%" Height="300" BasePath="~/ckeditor"> 
                                         
                </CKEditor:CKEditorControl>
                <asp:Label ID="lblfactid" runat="server" Visible="false" Text="0"></asp:Label>

                <%--  <asp:Button ID="Button27" runat="server" Text="Submit" />--%>
                <center>
                    <asp:Button ID="btnfindingfacts" OnClick="btnfindingfacts_Click" runat="server" Text="Submit" />

                    &nbsp;&nbsp;
                                                         <asp:Button ID="btnfindingfactscancel" runat="server" Text="Clear" />

                </center>
            </div>
        </div>

        <div class="cpanel" style="display: none;">
            <div class="head accr">
                Conclusion Of Law
            </div>
            <div class="body">
                <table style="width: 100%;">
                    <tr>
                        <td align="right">

                            <div align="right" style="margin-top: 10px; margin-right: 15px; margin-bottom: 8px;">
                                <input type="button" id="btnconclusionlaw1" value="Add New " onclick="javascript: return clear_conclusionoflaw()" class="poptrg" />
                            </div>

                        </td>
                    </tr>
                    <tr>
                        <td>



                            <script language="javascript">
                                function clear_conclusionoflaw() {

                                    if (document.getElementById('txtfindingoffacts').value == '')
                                        document.getElementById('btnfindview').style.display = 'none';
                                    document.getElementById('btnconclusionlaw1').click();
                                    //document.getElementById('btn_updateconclusion.ClientID').style.display = 'none';
                                    closefindfacts();
                                    return false;
                                }

                            </script>


                            <script language="javascript">
                                function clearconcclusionoflaw() {


                                    var opt = document.getElementById('<%= ddladmcodes.ClientID %>').options;
                                    for (var i = 0; i < opt.length; i++) {
                                        document.getElementById("ctl00_ContentPlaceHolder1_chk_administarativecode_" + i).checked = false;
                                    }

                                    document.getElementById('<%= txtsummaryconclusionoflaw.ClientID %>').value = " ";
                                    return false;
                                }

                                function addtextarea(ctl) {

                                    document.getElementById('<%= txtsummaryconclusionoflaw.ClientID %>').value = '';

                                    var opt = document.getElementById('<%= ddladmcodes.ClientID %>').options;

                                    for (var i = 0; i < opt.length; i++) {
                                        if (document.getElementById("ctl00_ContentPlaceHolder1_chk_administarativecode_" + i).checked == true) {
                                            document.getElementById('<%= txtsummaryconclusionoflaw.ClientID %>').value += "\r\n \r\n" + opt[i].text;
                                                                         }
                                                                     }


                                                                 }

                            </script>

                            <center>
                            </center>
                            <div id='btnconclusionlaw1_pop' class="popup" style="display: none;">
                                <span class="title">Conclusions of Law - Add New</span>

                                <table width="100%" align="center" class="normalfont" id="frmConclusion">
                                    <tr>
                                        <td>&nbsp;</td>
                                        <td></td>

                                    </tr>
                                    <tr>
                                        <td align="left" valign="top" width="20%">

                                            <asp:Label ID="Label8" runat="server" Text="ALBOP Adminstrative Code" CssClass="Labels"></asp:Label></td>
                                        <td align="left">
                                            <asp:DropDownList ID="ddladmcodes" runat="server" Style="display: none">
                                            </asp:DropDownList>
                                            <asp:CheckBoxList ID="chk_administarativecode" runat="server" class="Labels" RepeatDirection="Horizontal" RepeatColumns="6">
                                            </asp:CheckBoxList>

                                        </td>
                                    </tr>

                                    <tr>
                                        <td align="left" width="20%" valign="top">

                                            <asp:Label ID="Label10" runat="server" Text="Conclusion Of Law" CssClass="Labels"></asp:Label></td>

                                        <td height="150" align="left">
                                            <asp:TextBox ID="txtsummaryconclusionoflaw" runat="server" placeholder="Conclusion Of Law" CssClass="required" error="Please enter conclusion of law." TextMode="MultiLine" Height="320px"
                                                Width="95%"></asp:TextBox>
                                        </td>
                                    </tr>


                                    <tr>
                                        <td colspan="2" align="center">
                                            <table align="center">
                                                <tr>
                                                    <td align="center">
                                                        <asp:Button ID="btn_conclusion" OnClick="btn_conclusion_Click" OnClientClick="javascript:return Save_ValidationConclusion();" runat="server" Text="Submit" Width="108px" />




                                                    </td>
                                                    <td>
                                                        <%-- <asp:Button ID="btnfindview"  runat="server"  Text="View Finding of Facts" OnClientClick="javascript:return viewfindfacts()" />--%>
                                                    </td>
                                                    <td>
                                                        <%--<asp:Button ID="btn_updateconclusion"  runat="server"  />--%>
                                                    </td>
                                                    <td>
                                                        <asp:Button ID="btn_conclusioncancel"
                                                            runat="server" Text="Clear" Width="108px" OnClick="btn_conlawclear" OnClientClick="javascript:return clearconcclusionoflaw()" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>

                                    </tr>

                                </table>



                            </div>

                        </td>
                    </tr>


                </table>
            </div>
        </div>

        <div class="cpanel" style="display: none;">
            <div class="head accr">
                Consent Order
            </div>
            <div class="body">
                <table style="width: 100%;">
                    <tr>
                        <td align="right">

                            <div align="right" style="margin-top: 10px; margin-right: 15px; margin-bottom: 8px;">
                                <input type="button" id="btnconsentnew" value="Add New " onclick="javascript: return clear_consent()" class="poptrg" />
                            </div>



                        </td>
                    </tr>
                    <tr>
                        <td>
                            <script language="javascript">
                                function clear_consent() {


                                    document.getElementById('<%= ddlchooseoffer.ClientID %>').value = '-1';
                                    document.getElementById('<%= txtfineAmount.ClientID %>').value = '';
                                    document.getElementById('<%= txtprobationdays.ClientID %>').value = '';

                                    document.getElementById('<%= chkprobation.ClientID %>').checked = false;
                                    document.getElementById('<%= txtsuspensiondays.ClientID %>').value = '';

                                    document.getElementById('<%= chksuspension.ClientID %>').checked = false;

                                    document.getElementById('<%= txtoffdate.ClientID %>').value = '';
                                    document.getElementById('<%= txtduedate.ClientID %>').value = '';


                                    var ctls = document.getElementById('<%= chbcourse.ClientID %>').getElementsByTagName("input");
                                    for (var i = 0; i < ctls.length; i++)
                                        ctls[i].checked = false;
                                    document.getElementById('<%= btnconsentsubmit.ClientID %>').style.display = 'block';
                                    document.getElementById('<%= btnconsentsupdate.ClientID %>').style.display = 'none';
                                    document.getElementById('<%= hfd_consent.ClientID %>').value = '0';

                                    // document.getElementById('btnconsentnew').click();

                                    return false;
                                }
                                function fill_consent(hfdid, offer, fineamt, probdays, chkprob, susdays, chksus, course, offdate1, duedate1) {

                                    var crs_vals = course.toString().split(',');
                                    for (var i = 0; i < crs_vals.length; i++) {
                                        var chb_ctls = document.getElementById('<%= chbcourse.ClientID %>').getElementsByTagName("input");
                                        for (var j = 0; j < chb_ctls.length; j++) {
                                            if (chb_ctls[j].parentElement.innerText == crs_vals[i])
                                                chb_ctls[j].checked = true;
                                        }
                                    }
                                    var opt = document.getElementById('<%= ddlchooseoffer.ClientID %>').options;
                                    for (var i = 0; i < opt.length; i++) {
                                        if (opt[i].text == offer) {
                                            document.getElementById('<%= ddlchooseoffer.ClientID %>').value = opt[i].value;
                                            i = opt.length;
                                        }
                                    }


                                    if (chksus == "True")
                                        document.getElementById('<%= chksuspension.ClientID %>').checked = true;
                                                                     else if (chkprob == "False")
                                                                         document.getElementById('<%= chksuspension.ClientID %>').checked = false;
                                                                 if (chkprob == "True")
                                                                     document.getElementById('<%= chkprobation.ClientID %>').checked = true;
                                                                 else if (chksus == "False")
                                                                     document.getElementById('<%= chkprobation.ClientID %>').checked = false;

                                                             document.getElementById('<%= txtfineAmount.ClientID %>').value = fineamt;
                                    document.getElementById('<%= txtprobationdays.ClientID %>').value = probdays;

                                    // document.getElementById('<%= chkprobation.ClientID %>').value='';
                                    document.getElementById('<%= txtsuspensiondays.ClientID %>').value = susdays;

                                    //document.getElementById('<%= chksuspension.ClientID %>').value='';  

                                    document.getElementById('<%= txtoffdate.ClientID %>').value = offdate1;
                                    document.getElementById('<%= txtduedate.ClientID %>').value = duedate1;
                                    document.getElementById('<%= btnconsentsubmit.ClientID %>').style.display = 'none';
                                    document.getElementById('<%= btnconsentsupdate.ClientID %>').style.display = 'block';
                                    document.getElementById('<%= hfd_consent.ClientID %>').value = hfdid;
                                    sus();

                                    $(function () { $('#btnconsentnew_pop').dialog("open"); });

                                    return false;
                                }
                                function consent_cancel() {
                                    document.getElementById('imgcancelConsent').click();
                                    return false;
                                }
                            </script>
                            <center>

                                <div id="grdconsentoffer">
                                </div>


                            </center>
                            <script language="javascript" type="text/javascript">
                                function printopen() {

                                    var vURL = './PrintProducts/Mental_Health_Psychiatric_Shell.aspx';
                                    //changes end

                                    window.location.href = vURL;
                                    return false;

                                }
                            </script>

                            <div id='btnconsentnew_pop' class="popup" style="display: none;">
                                <span class="title">Consent Order</span>
                                <table width="100%" align="center" class="normalfont" id="frmConsentOrder">
                                    <tr>
                                        <td>&nbsp;</td>
                                        <td></td>

                                    </tr>

                                    <tr>
                                        <td align="right">

                                            <asp:Label ID="Label68" runat="server" Text="Choose an Offer" CssClass="Labels"></asp:Label></td>
                                        <td align="left">

                                            <asp:DropDownList ID="ddlchooseoffer" CssClass="required" error="Please select offer." runat="server">
                                            </asp:DropDownList>
                                        </td>
                                    </tr>


                                    <tr>
                                        <td align="right">

                                            <asp:Label ID="Label70" runat="server" Text="Fine Amount" CssClass="Labels"></asp:Label>
                                        </td>
                                        <td align="left">
                                            <div class="txboxdiv">
                                                <asp:TextBox ID="txtfineAmount" runat="server" placeholder="Fine Amount" CssClass="required" error="Please enter amount." Width="145"></asp:TextBox>
                                            </div>
                                        </td>
                                    </tr>

                                    <tr>

                                        <td align="right">

                                            <asp:Label ID="Label72" runat="server" Text="Probation Length" CssClass="Labels"></asp:Label>

                                        </td>
                                        <td align="left">
                                            <table>
                                                <tr>
                                                    <td>
                                                        <div class="txboxdivSmall" style="display: block" id="trprobation">

                                                            <asp:TextBox ID="txtprobationdays" Width="50" runat="server" placeholder="Probation Length"></asp:TextBox>
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <asp:CheckBox ID="chkprobation" runat="server" TextAlign="Right" Text="Till Conditions Met" CssClass="Labels" onclick="javascript:sus();" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>


                                    </tr>



                                    <tr>

                                        <td align="right">

                                            <asp:Label ID="Label74" runat="server" Text="Suspension Length" CssClass="Labels"></asp:Label>

                                        </td>
                                        <td align="left">

                                            <table>
                                                <tr>
                                                    <td>
                                                        <div class="txboxdivSmall" style="display: block" id="trsuspension">

                                                            <asp:TextBox ID="txtsuspensiondays" Width="50" runat="server" placeholder="Suspension Length" CssClass="txtcssboxsmall"></asp:TextBox>
                                                        </div>
                                                    </td>
                                                    <td>

                                                        <asp:CheckBox ID="chksuspension" runat="server" TextAlign="Right" Text="Till Conditions Met" CssClass="Labels" onclick="javascript:sus();" />

                                                    </td>
                                                </tr>
                                            </table>
                                        </td>

                                    </tr>

                                    <tr>
                                        <td align="right">

                                            <asp:Label ID="Label78" runat="server" Text="Offer Date" CssClass="Labels"></asp:Label>
                                        </td>
                                        <td align="left">
                                            <div class="txboxdivSmall" style="display: block" id="deadline">
                                                <asp:TextBox ID="txtoffdate" runat="server" CssClass="date required" placeholder="Offer Date" error="Please enter offer date." Width="76"></asp:TextBox>

                                            </div>

                                        </td>

                                    </tr>
                                    <tr>
                                        <td align="right">
                                            <%-- <asp:Label ID="Label1" runat="server" Text="*" style="color:Red;font-family:Arial;font-style:Bold;font-size:11pt;"></asp:Label>--%>
                                            <asp:Label ID="Label2" runat="server" Text="Due Date" CssClass="Labels"></asp:Label>
                                        </td>
                                        <td align="left">
                                            <div class="txboxdivSmall" style="display: block" id="Div1">
                                                <asp:TextBox ID="txtduedate" runat="server" placeholder="Due Date" Width="76" CssClass="date"></asp:TextBox>

                                            </div>

                                        </td>

                                    </tr>


                                    <tr>
                                        <td colspan="2">
                                            <script language="javascript">

                                                function sus() {

                                                    if (document.getElementById('<%= chksuspension.ClientID %>').checked == true) {
                                                        document.getElementById('trsuspension').style.display = 'none';
                                                        document.getElementById('<%= txtsuspensiondays.ClientID %>').value = "";
                                                    }


                                                    else {
                                                        document.getElementById('trsuspension').style.display = 'block';

                                                    }
                                                    if (document.getElementById('<%= chkprobation.ClientID %>').checked == true) {
                                                        document.getElementById('trprobation').style.display = 'none';
                                                        document.getElementById('<%= txtprobationdays.ClientID %>').value = "";
                                                    }
                                                    else {
                                                        document.getElementById('trprobation').style.display = 'block';
                                                    }

                                                }
                                            </script>
                                            <table width="100%">
                                                <tr>
                                                    <td align="right" valign="top">
                                                        <%--<asp:Label ID="Label75" runat="server" Text="*" style="color:Red;font-family:Arial;font-style:Bold;font-size:11pt;"></asp:Label>--%>
                                                        <asp:Label ID="Label76" runat="server" Text="Select Courses" CssClass="Labels"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <div style="overflow: auto; width: 150px; height: 75px; border: 1px solid #336699; padding-left: 5px">
                                                            <asp:CheckBoxList ID="chbcourse" runat="server" RepeatColumns="2" CssClass="Labels"></asp:CheckBoxList>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>







                                    <tr>
                                        <td colspan="2" align="center">

                                            <table align="center">

                                                <tr>

                                                    <td>
                                                        <%-- <asp:Button ID="btnconsentsubmit" OnClientClick="javascript:return Officervalidation()"
                                                                                 
                                                                                  OnClick="btnconsentsubmit_Click" runat="server"  Text="Submit" />--%>

                                                        <asp:Button ID="btnconsentsubmit" OnClientClick="javascript:return Save_ValidationConsentOrder()"
                                                            OnClick="btnconsentsubmit_Click" runat="server" Text="Submit" />


                                                        <script language="javascript" type="text/javascript">

                                                            function Officervalidation() {

                                                                var err = "";
                                                                var cmp_count = 0;



                                                                var val = document.getElementById('<%= ddlchooseoffer.ClientID %>').value;

                                                                if (val == "-1")
                                                                    err += 'Please Select Choose an Offer.\r\n';


                                                                if (document.getElementById('<%= txtfineAmount.ClientID %>').value == '')
                                                                    err += 'Please enter Fine Amount.\r\n';

                                                                if (document.getElementById('<%= txtoffdate.ClientID %>').value == '')
                                                                    err += 'Please enter Offdate.\r\n';



                                                                // err+=Value_Checked('<%= txtduedate.ClientID %>',"Please enter Duedate.\r\n");
                                                                //err+=Value_checkbox_Checked('<%= chbcourse.ClientID %>',"Please Check Course.\r\n");

                                                                if (err != "") {
                                                                    altbox(err);
                                                                    return false;

                                                                }
                                                                return true;

                                                            }
                                                        </script>

                                                    </td>
                                                    <td>
                                                        <asp:Button ID="btnconsentsupdate" OnClientClick="javascript:return Officervalidation()" OnClick="btnconsentsupdate_Click" runat="server" Text="Update" />
                                                    </td>
                                                    <td>
                                                        <%-- <asp:Button ID="btnconsentcancel" OnClientClick="javascript:return consent_cancel()" runat="server"  Text="Clear"  />--%>
                                                        <input type="button" id="btnconsentcancel" value=" Clear " onclick="javascript: return clear_consent()" class="iconbtn poptrg" />

                                                    </td>

                                                </tr>
                                            </table>
                                    </tr>
                                </table>


                            </div>


                        </td>
                    </tr>


                </table>


                <center>
                    <asp:CheckBox ID="Chkadminstitativecode" runat="server" TextAlign="Right" Text="Administrative Complaint" onclick="javascript:admincompdisrow(this);" />

                </center>


                <script language="javascript">
                    function bind_admincodes(ctl) {
                        if (ctl.checked == true) {
                            document.getElementById('<%= txtstatementcharges.ClientID %>').value = document.getElementById('<%= txtfindingoffacts.ClientID %>').value;
                            document.getElementById('<%= TxtCounts.ClientID %>').value = document.getElementById('<%= txtsummaryconclusionoflaw.ClientID %>').value;
                        }


                    }
                </script>


                <script language="javascript" type="text/javascript">
                    function admincompdisrow(ctl) {
                        bind_admincodes(ctl);
                        var chkadminsign = document.getElementById('<%= Chkadminstitativecode.ClientID %>');
                        if (chkadminsign.checked == true) {


                            document.getElementById('admincode').style.display = 'block';

                        }
                        else {

                            document.getElementById('admincode').style.display = 'none';
                        }

                    }
                </script>
            </div>
        </div>

        <div class="cpanel" id="admincode" style="display: none">
            <div class="head accr">
                Administrative Complaint
            </div>
            <div class="body">
                <table width="100%" class="normalfont">

                    <tr>
                        <td>
                            <table width="100%">
                                <tr>
                                    <td class="Labels" align="right">Statement Of Charges</td>
                                    <td height="150" align="left" width="80%">
                                        <asp:TextBox ID="txtstatementcharges" runat="server" TextMode="MultiLine" Height="145px"
                                            Width="95%"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="Labels" align="right">Counts</td>
                                    <td height="150" align="left" width="80%">
                                        <asp:TextBox ID="TxtCounts" runat="server" placeholder="Counts" TextMode="MultiLine" Height="145px"
                                            Width="95%"></asp:TextBox>
                                    </td>
                                </tr>
                            </table>
                        </td>

                    </tr>
                    <tr>
                        <td align="center">
                            <table width="70%">
                                <tr>
                                    <td align="center">
                                        <asp:Button ID="btnadmincodesave" OnClick="btnadmincodesave_click" runat="server" Text="Submit" />
                                    </td>
                                    <td align="left" style="display: none">
                                        <asp:Button ID="btnadmincancel" runat="server" Text="Clear" />
                                    </td>

                                </tr>
                            </table>
                            <asp:Label ID="Label13" runat="server" Visible="false" Text="0"></asp:Label>
                        </td>
                    </tr>
                </table>
            </div>
        </div>

        <div class="cpanel">
            <div class="head accr">
                Formal Hearing
            </div>
            <div class="body">
                <table width="100%">
                    <tr>
                        <td>
                            <table width="100%">
                                <tr>
                                    <td width="50%"></td>
                                    <td width="50%" align="right">

                                        <div align="right" style="margin-top: 10px; margin-right: 15px; margin-bottom: 8px;">
                                            <input type="button" id="btnHearingNew" value="Add New " onclick="javascript: return clear_hearing()" class="poptrg" />
                                        </div>



                                        <script language="javascript">
                                            function clear_hearing() {
                                                document.getElementById('<%= txthearingdate.ClientID %>').value = '';
                                                document.getElementById('<%= ddlhearingHours.ClientID %>').value = '-1';
                                                document.getElementById('<%= rdblisttime.ClientID %>').value = '';
                                                document.getElementById('<%= ddlHearingMinutes.ClientID %>').value = '-1';
                                                document.getElementById('<%=chktbd.ClientID%>').checked = false;
                                                  document.getElementById('<%= txthcount.ClientID %>').value = '';

                                                if (document.getElementById('<%= chkrespondent.ClientID %>' + '_0').checked == true)
                                                    document.getElementById('<%= chkrespondent.ClientID %>' + '_0').checked = false;
                                                if (document.getElementById('<%= chkrespondent.ClientID %>' + '_1').checked == true)
                                                    document.getElementById('<%= chkrespondent.ClientID %>' + '_1').checked = false;
                                                document.getElementById('<%= hfdcourtoffid.ClientID %>').value = '2';
                                                document.getElementById('<%= hfdreporterid.ClientID %>').value = '3';
                                                document.getElementById('<%= btnhearingsubmit.ClientID %>').style.display = 'block';
                                                document.getElementById('<%= btnhearingupdate.ClientID %>').style.display = 'none';
                                                document.getElementById('<%= hfd_forhearing.ClientID %>').value = '0';
                                                //document.getElementById('btnHearingNew').click();
                                                return false;
                                            }


                                            function formalhearingValidation() {

                                                var err = "";

                                                var count = 0;
                                                if (document.getElementById('<%=chktbd.ClientID%>').checked == false) {
                                                    if (document.getElementById('<%= txthearingdate.ClientID %>').value == '')
                                                        err += '<li>Please Enter Hearing date.</li>';
                                                    if (document.getElementById('<%= ddlhearingHours.ClientID %>').value == '-1')
                                                        err += '<li>Please Enter Hearing Hours.</li>';

                                                    if (document.getElementById('<%= ddlHearingMinutes.ClientID %>').value == '-1')
                                                        err += '<li>Please Enter Hearing Minutes.</li>';
                                                }






                                                // if(document.getElementById('<%= chkrespondent.ClientID %>'+'_0').checked==false && document.getElementById('<%= chkrespondent.ClientID %>'+'_1').checked==false) 
                                                //err+="Please Select Respondent.\r\n";

                                                // err+=Value_checkbox_Checked('<%= chkrespondent.ClientID %>',"Please select Respondent. \r\n");

                                                if (err != "") {

                                                    Msgbox(err);

                                                    return false;

                                                }

                                                return true;


                                            }





                                            function fill_hearing(hfdid, heardate, hrs, loc, off, rep, res, her_off, cur_off, tbd,settled,count) {
                                                if (settled == 'Yes')
                                                    document.getElementById('<%=chksetteld.ClientID%>').checked = true;
                                                else
                                                    document.getElementById('<%=chksetteld.ClientID%>').checked = false;
                                                if (tbd == 'Yes')
                                                    document.getElementById('<%=chktbd.ClientID%>').checked = true;
                                               else
                                                   document.getElementById('<%=chktbd.ClientID%>').checked = false;
                                               if (res == "Yes")
                                                   document.getElementById('ctl00_ContentPlaceHolder1_chkrespondent_0').checked = true;
                                               else if (res == "No")
                                                   document.getElementById('ctl00_ContentPlaceHolder1_chkrespondent_1').checked = true;

                                                 document.getElementById('<%= txthcount.ClientID %>').value = count;
                                               document.getElementById('<%= txthearingdate.ClientID %>').value = heardate;
                                                             var hrsmnts = hrs.toString().split(':');
                                                             var hrsmnts1 = hrsmnts[1].toString().split(' ');

                                                             document.getElementById('<%= ddlhearingHours.ClientID %>').value = hrsmnts[0];

                                                            if (hrsmnts1[1] == "AM")
                                                                //cl.cells[0].all[0].checked = true;
                                                                document.getElementById('<%= rdblisttime.ClientID %>' + '_0').checked = true;
                                                            else
                                                                // cl.cells[1].all[0].checked = true;
                                                                document.getElementById('<%= rdblisttime.ClientID %>' + '_1').checked = true;


                                                            document.getElementById('<%= ddlHearingMinutes.ClientID %>').value = hrsmnts1[0];

                                               document.getElementById('<%= hfdreporterid.ClientID %>').value = rep;
                                               document.getElementById('<%= hfdcourtoffid.ClientID %>').value = off;


                                               //document.getElementById('<%= chkrespondent.ClientID %>').value=res; 
                                               document.getElementById('<%= btnhearingsubmit.ClientID %>').style.display = 'none';
                                               document.getElementById('<%= btnhearingupdate.ClientID %>').style.display = 'block';
                                               document.getElementById('<%= hfd_forhearing.ClientID %>').value = hfdid;



                                               $(function () {
                                                   $('#btnHearingNew_pop').dialog({ title: 'Edit Formal Hearing' });
                                                   $('#btnHearingNew_pop').dialog("open");
                                               });
                                               return false;
                                           }


                                           function hearing_cancel() {


                                               document.getElementById('<%= ddlhearingHours.ClientID %>').value = '-1';
                                                            document.getElementById('<%= ddlHearingMinutes.ClientID %>').value = '-1';
                                                            document.getElementById('<%=chktbd.ClientID%>').checked = false;
                                                            document.getElementById('<%= txthearingdate.ClientID %>').value = '';


                                                            if (document.getElementById('<%= chkrespondent.ClientID %>' + '_0').checked == true)
                                                                document.getElementById('<%= chkrespondent.ClientID %>' + '_0').checked = false;
                                                            if (document.getElementById('<%= chkrespondent.ClientID %>' + '_1').checked == true)
                                                                document.getElementById('<%= chkrespondent.ClientID %>' + '_1').checked = false;
                                                            //document.getElementById('imgcancelhearing').click();

                                                            $(function () {
                                                                $('#btnHearingNew_pop').dialog({ title: 'Edit Formal Hearing' });
                                                                $('#btnHearingNew_pop').dialog("open");
                                                            });
                                                            return false;
                                                        }
                                                        function chk_drp(ctl, val) {

                                                            if (ctl.value == "0") {
                                                                if (val == 1)
                                                                    document.getElementById('<%= btnnewlocation.ClientID %>').click();
                                                                return false;
                                                            }
                                                            else
                                                                return false;
                                                        }
                                        </script>



                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <center>
                                <div id="grdFormalHearing">
                                </div>



                            </center>
                            <div id='btnHearingNew_pop' class="popup" style="display: none;">
                                <span class="title">Formal Hearing</span>


                                <table id="frmFormalHearing">
                                    <tr>
                                        <td colspan="2" align="center">
                                            <asp:CheckBox ID="chktbd" runat="server" Text="&nbsp;&nbsp;TBD" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" align="center">
                                            <asp:CheckBox ID="chksetteld" runat="server" Text="&nbsp;&nbsp;Settled" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right">

                                            <asp:Label ID="Label54" runat="server" Text="Hearing Date" CssClass="Labels"></asp:Label></td>
                                        <td align="left">
                                            <div class="txboxdiv">

                                                <asp:TextBox ID="txthearingdate" runat="server" placeholder="Hearing Date" CssClass="date" error="Please enter date."></asp:TextBox>

                                            </div>
                                        </td>


                                    </tr>


                                    <tr>

                                        <td align="right">

                                            <asp:Label ID="Label56" runat="server" Text="Hearing Time" CssClass="Labels"></asp:Label>
                                        </td>

                                        <td align="left">

                                            <table>
                                                <tr>
                                                    <td align="left">
                                                        <asp:DropDownList ID="ddlhearingHours" Width="50px" error="Please select time." runat="server">
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
                                                    <td align="left">
                                                        <asp:DropDownList ID="ddlHearingMinutes" Width="50px" runat="server" error="Please select mnts.">
                                                            <asp:ListItem Value="-1">Select</asp:ListItem>
                                                            <asp:ListItem Value="00">00</asp:ListItem>
                                                            <asp:ListItem Value="01">01</asp:ListItem>
                                                            <asp:ListItem Value="02">02</asp:ListItem>
                                                            <asp:ListItem Value="03">03</asp:ListItem>
                                                            <asp:ListItem Value="04">04</asp:ListItem>
                                                            <asp:ListItem Value="05">05</asp:ListItem>
                                                            <asp:ListItem Value="06">06</asp:ListItem>
                                                            <asp:ListItem Value="07">07</asp:ListItem>
                                                            <asp:ListItem Value="08">08</asp:ListItem>
                                                            <asp:ListItem Value="09">09</asp:ListItem>
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
                                                    <td align="left">
                                                        <asp:RadioButtonList ID="rdblisttime" runat="server" RepeatDirection="Horizontal">
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
                                            <%-- <asp:Label ID="Label63" runat="server" Text="*" style="color:Red;font-family:Arial;font-style:Bold;font-size:11pt;"></asp:Label>--%>
                                            <asp:Label ID="Label1" runat="server" Text="Count" CssClass="Labels"></asp:Label>
                                        </td>

                                        <td>
                                          <asp:TextBox ID="txthcount" runat="server" placeholder="Count" ></asp:TextBox>
                                            <%--<asp:CheckBox ID="chkrespondent" runat="server" Checked="true"/>--%>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td align="right">
                                            <%-- <asp:Label ID="Label63" runat="server" Text="*" style="color:Red;font-family:Arial;font-style:Bold;font-size:11pt;"></asp:Label>--%>
                                            <asp:Label ID="Label64" runat="server" Text="Is Respondent Expected?" CssClass="Labels"></asp:Label>
                                        </td>

                                        <td>
                                            <asp:CheckBoxList ID="chkrespondent" runat="server" RepeatDirection="Horizontal">
                                                <asp:ListItem Value="Yes">Yes</asp:ListItem>
                                                <asp:ListItem Value="No">No</asp:ListItem>
                                            </asp:CheckBoxList>
                                            <%--<asp:CheckBox ID="chkrespondent" runat="server" Checked="true"/>--%>
                                        </td>
                                    </tr>



                                    <tr>
                                        <td colspan="2" align="center">
                                            <asp:CheckBox ID="chkignore" runat="server" Text="&nbsp;Ignore" />
                                        </td>

                                    </tr>
                                    <tr>
                                        <td colspan="2" align="center">
                                            <table>
                                                <tr>

                                                    <td>
                                                        <asp:Button ID="btnhearingsubmit" OnClientClick="javascript:return formalhearingValidation()" runat="server"
                                                            Text="Submit" OnClick="btnhearingsubmit_Click" />






                                                    </td>
                                                    <td>
                                                        <asp:Button ID="btnhearingupdate" OnClick="btnhearingupdate_Click" OnClientClick="javascript:return formalhearingValidation()" runat="server"
                                                            Text="Update" />
                                                    </td>
                                                    <td>
                                                        <asp:Button ID="btnhearingcancel" runat="server" Text="Cancel" OnClientClick="javascript:return hearing_cancel()" />

                                                    </td>

                                                </tr>
                                            </table>
                                        </td>

                                    </tr>

                                </table>

                            </div>


                            <asp:Button ID="btnnewlocation" runat="server" Style="display: none" Text="New" />

                            <div id='Div2' class="popup" style="display: none;">
                                <span class="title">New Location</span>

                                <table height="100%" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td colspan="2" height="100%" valign="top">
                                            <div id="defnew">
                                                <asp:UpdatePanel ID="updfund" runat="server">
                                                    <ContentTemplate>


                                                        <table align="center" width="100%">
                                                            <tr>
                                                                <td width="40%">&nbsp;
                                                                </td>
                                                                <td></td>
                                                            </tr>

                                                            <tr>

                                                                <td align="right" width="15%">
                                                                    <asp:Label ID="lblfunddescr" runat="server" Text="Hearing Description" CssClass="Labels"></asp:Label>
                                                                </td>
                                                                <td align="left">

                                                                    <asp:TextBox ID="txthearingdesc" placeholder="Hearing Description" runat="server" Height="85" TextMode="MultiLine" Width="90%"></asp:TextBox>

                                                                </td>

                                                            </tr>

                                                            <tr>
                                                                <td colspan="2">
                                                                    <table width="35%" align="center">
                                                                        <tr>
                                                                            <td>
                                                                                <asp:Button ID="btndescSubmit" runat="server" OnClientClick="javascript:return cls('imgfund',1)" CssClass="button_bg" Height="30" OnClick="btndescSubmit_Click"
                                                                                    Text="Submit" Width="108px" />
                                                                            </td>
                                                                            <td>
                                                                                <asp:Button ID="btnCancel" runat="server" OnClientClick="javascript:return cls('imgfund',0)" CssClass="button_bg" Height="30" Text="Clear"
                                                                                    Width="108px" />
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                    <script language="javascript">
                                                                        function cls(ctlid, flg) {
                                                                            document.getElementById(ctlid).click();
                                                                            if (flg == 1)
                                                                                return true;
                                                                            else
                                                                                return false;
                                                                        }



                                                                    </script>
                                                                </td>
                                                            </tr>


                                                        </table>
                                                    </ContentTemplate>
                                                </asp:UpdatePanel>
                                            </div>
                                        </td>
                                    </tr>

                                </table>
                            </div>

                        </td>
                    </tr>
                </table>
            </div>
        </div>

        <div class="cpanel">
            <div class="head accr">
                Complaint Resolution & Action
            </div>
            <div class="body">
                <script language="javascript">
                    function clear_resolution() {
                        document.getElementById('<%= ddlresoultion.ClientID %>').value = '-1';
                        document.getElementById('<%= txtdateresolution.ClientID %>').value = '';
                        document.getElementById('<%= ddlboardaction.ClientID %>').value = '-1';
                        document.getElementById('<%= txtdateaction.ClientID %>').value = '';

                        return false;
                    }
                    function resolution_cancel() {
                        document.getElementById('imgcancelresolution').click();
                        return false;
                    }
                </script>


                <%--<asp:Button ID="btnresolution" runat="server" Style="display: none" />--%>

                <table align="center" class="spac" width="99%">

                    <tr>

                        <td colspan="4" align="right">

                            <div align="right" style="margin-top: 10px; margin-right: 15px; margin-bottom: 8px;">
                                <input type="button" id="btneditresolution" value="Add New/Edit " class="poptrg" />
                            </div>




                            <br />

                        </td>

                    </tr>

                    <tr>

                        <td valign="top" width="100%" width="100%">
                            <table width="100%">
                                <tr>
                                    <td align="right" class="Labels" width="25%">Complaint Resolution :
                                    </td>
                                    <td align="left" width="25%" class="Labels">
                                        <asp:Label ID="lbl_GetResolution" runat="server" Text=""></asp:Label>
                                    </td>
                                    <td align="right" class="Labels" width="25%">Complaint Resolution Date :
                                    </td>
                                    <td align="left" class="Labels">
                                        <asp:Label ID="lbl_Getresolutiondate" runat="server" Text=""></asp:Label>
                                    </td>
                                </tr>
                                <tr style="display: none;">
                                    <td align="right" class="Labels" width="25%">Board Action :
                                    </td>
                                    <td align="left" width="25%" class="Labels">
                                        <asp:Label ID="lbl_getboardaction" runat="server" Text=""></asp:Label>
                                    </td>
                                    <td align="right" class="Labels" width="25%">Board Action Date :
                                    </td>
                                    <td align="left" width="25%" class="Labels">
                                        <asp:Label ID="lbl_getboardactionDate" runat="server" Text=""></asp:Label>
                                    </td>
                                </tr>
                            </table>
                        </td>

                    </tr>

                </table>


                <div id='btneditresolution_pop' class="popup" style="display: block;">
                    <span class="title">Resolution</span>


                    <table width="100%" align="center" class="normalfont" id="frmResolution">


                        <tr>
                            <td align="right">

                                <asp:Label ID="Label18" runat="server" Text="Complaint Resolution" CssClass="Labels"></asp:Label></td>
                            <td>
                                <asp:DropDownList ID="ddlresoultion" runat="server" CssClass="required" error="Please select resolution.">
                                    <%--  <asp:ListItem Value="-1">Select</asp:ListItem>    --%>
                                </asp:DropDownList>
                                <asp:HiddenField ID="hfd_resolution" runat="server" Value="0" />
                            </td>
                        </tr>


                        <tr>
                            <td align="right">

                                <asp:Label ID="Label21" runat="server" Text="Date Of Complaint Resolution" CssClass="Labels"></asp:Label>
                            </td>
                            <td>
                                <div class="txboxdiv">
                                    <asp:TextBox ID="txtdateresolution" runat="server" placeholder="Date Of Complaint Resolution" Width="145" CssClass="date required" error="Please select date."></asp:TextBox>

                                </div>
                            </td>
                        </tr>
                        <tr style="display: none;">
                            <td align="right">
                                <%--<asp:Label ID="Label22" runat="server" Text="*" style="color:Red;font-family:Arial;font-style:Bold;font-size:11pt;"></asp:Label>--%>
                                <asp:Label ID="Label25" runat="server" Text="Board Action" CssClass="Labels"></asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlboardaction" runat="server" CssClass="drpcssbox">
                                    <%-- <asp:ListItem Value="-1">Select</asp:ListItem> --%>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr style="display: none;">
                            <td align="right">
                                <%--<asp:Label ID="Label26" runat="server" Text="*" style="color:Red;font-family:Arial;font-style:Bold;font-size:11pt;"></asp:Label>--%>
                                <asp:Label ID="Label27" runat="server" Text="Date of Board Action" CssClass="Labels"></asp:Label>
                            </td>
                            <td>
                                <div class="txboxdiv">
                                    <asp:TextBox ID="txtdateaction" runat="server" placeholder="Date of Board Action" Width="145" CssClass="date"></asp:TextBox>

                                </div>
                            </td>
                        </tr>





                        <tr>
                            <td colspan="2" align="center">
                                <table align="center">
                                    <tr>
                                        <td>
                                            <asp:Button ID="btnresolutionsubmit" runat="server" CssClass="button_bg"
                                                Text="Submit" OnClick="btnresolutionsubmit_Click" OnClientClick="javascript:return Save_ValidationResolution()" />

                                            <script type="text/javascript" language="javascript">

                                                function ResolutionValidation() {

                                                    //                                                                    if(document.getElementById ('<%= txtdateresolution.ClientID %>').value='' )

                                                    //                                                                    {

                                                    //                                                                     altbox("Please Enter DateOfResolution");

                                                    //                                                                    return false;

                                                    //                                                                    }

                                                    var err = "";
                                                    var cmp_count = 0;
                                                    if (document.getElementById('<%= txtdateresolution.ClientID %>').value == '')
                                                        err += 'Please Enter Date Of Complaint Resolution.\r\n';
                                                    if (document.getElementById('<%= ddlresoultion.ClientID %>').value == '-1')
                                                        err += 'Please select Resoultion.\r\n';


                                                    if (err != "") {
                                                        altbox(err);
                                                        return false;
                                                    }

                                                    return true;



                                                }

                                            </script>


                                        </td>
                                        <td>
                                            <asp:Button ID="btnresolutionupdate" OnClientClick="javascript:return Save_ValidationResolution();" runat="server" CssClass="button_bg"
                                                Text="Update" OnClick="btnresolutionupdate_Click" Visible="false" />

                                        </td>
                                        <td>
                                            <asp:Button ID="btnresolutioncancel" runat="server" CssClass="button_bg" Text="Clear"
                                                OnClientClick="javascript:return resolution_cancel();" />

                                        </td>
                                    </tr>
                                </table>
                            </td>

                        </tr>

                    </table>

                </div>
            </div>
        </div>
        <div class="cpanel" id="divresolutionhistory" style="display: none;">
            <div class="head">
                Resolution History Grid
            </div>
            <div class="body">
                <div id="grdresolutionhistory"></div>
            </div>
        </div>
        <div class="cpanel" style="display: none;">
            <div class="head accr">
                Violation
            </div>
            <div class="body">
                <script language="javascript">
                    function clear_Violation() {
                        document.getElementById('<%= ddlviolations.ClientID %>').value = '-1';
                        document.getElementById('tblChbVoilation').style.display = 'block';

                        document.getElementById('<%=chk_publicinfo.ClientID %>').checked = false;
                        // document.getElementById('<%= txtviolationdateadded.ClientID %>').value='';
                        // document.getElementById('<%= txtviolationenteredby.ClientID %>').value='admin';                                                                                           
                        document.getElementById('<%= btnviolationsubmit.ClientID %>').style.display = 'block';
                        document.getElementById('<%= btnviolationupdate.ClientID %>').style.display = 'none';
                        document.getElementById('<%= hfd_violation.ClientID %>').value = '0';
                        document.getElementById('<%= ddlviolations.ClientID %>').style.display = 'none';
                        document.getElementById('<%= chbvilation.ClientID %>').style.display = 'block';
                        //document.getElementById('btnnewviolation').click();
                        return false;
                    }
                    function fill_violation(hfdviolationid, violation, publicinfo) {

                        document.getElementById('<%= ddlviolations.ClientID %>').style.display = 'block';
                        document.getElementById('<%= chbvilation.ClientID %>').style.display = 'none';
                        var opt = document.getElementById('<%= ddlviolations.ClientID %>').options;
                        for (var i = 0; i < opt.length; i++) {
                            if (opt[i].text == violation) {
                                document.getElementById('<%= ddlviolations.ClientID %>').value = opt[i].value;
                                i = opt.length;
                            }
                        }
                        document.getElementById('<%=chk_publicinfo.ClientID %>').value = publicinfo;

                        if (publicinfo == "True") {

                            document.getElementById('<%=chk_publicinfo.ClientID %>').checked = true;
                        }

                        // document.getElementById('<%= ddlviolations.ClientID %>').value=violation;                                                                                           

                        // document.getElementById('<%= txtviolationdateadded.ClientID %>').value=dateadded;
                        //document.getElementById('<%= txtviolationenteredby.ClientID %>').value=enteredby;

                        document.getElementById('<%= btnviolationsubmit.ClientID %>').style.display = 'none';
                        document.getElementById('<%= btnviolationupdate.ClientID %>').style.display = 'block';
                        document.getElementById('<%= hfd_violation.ClientID %>').value = hfdviolationid;

                        document.getElementById('tblChbVoilation').style.display = 'none';


                        //document.getElementById('btnnewviolation').click();
                        $(function () {
                            $('#btnnewviolation_pop').dialog({ title: 'Edit Violation' });
                            $('#btnnewviolation_pop').dialog("open");
                        });


                        return false;
                    }
                    function Vilation_cancel() {

                        //document.getElementById('imgcancelviolation').click();
                        $(function () { $('#btnnewviolation_pop').dialog("close"); });
                        return false;
                    }
                </script>


                <table align="center" cellpadding="0" cellspacing="0" width="99%">


                    <tr>


                        <td align="right">

                            <div align="right" style="margin-top: 10px; margin-right: 15px; margin-bottom: 8px;">
                                <input type="button" id="btnnewviolation" value="Add New " onclick="javascript: return clear_Violation()" class="poptrg" />
                            </div>



                            <br />

                        </td>
                    </tr>




                    <tr>

                        <td width="100%">
                            <center>

                                <div id="grdviolation">
                                </div>



                            </center>
                        </td>
                    </tr>
                </table>





                <div id='btnnewviolation_pop' class="popup" style="display: block;">
                    <span class="title">Resolution</span>

                    <table width="100%" align="center" class="normalfont" id="frmVoilation">


                        <tr>
                            <td>
                                <%--<asp:Label ID="Label31" runat="server" Text="*" style="color:Red;font-family:Arial;font-style:Bold;font-size:11pt;"></asp:Label>--%>
                                <asp:Label ID="Label32" runat="server" Text="Violations" CssClass="Labels"></asp:Label></td>
                            <td>
                                <asp:DropDownList ID="ddlviolations" runat="server" CssClass="required" error="Please select voilation." Style="display: none">
                                </asp:DropDownList>
                                <table height="100px" id="tblChbVoilation">
                                    <tr>

                                        <td>
                                            <div class="POPUP_SCROLLBARS_cal" style="border: 1px solid #800000;">
                                                <div style="overflow-y: scroll; height: 100px">

                                                    <asp:CheckBoxList ID="chbvilation" CssClass="required" error="Please select voilation." runat="server" Width="250px" Style="display: none"></asp:CheckBoxList>
                                                </div>

                                            </div>

                                        </td>
                                    </tr>
                                </table>

                            </td>
                        </tr>


                        <tr style="display: none" id="sss">
                            <td align="right">

                                <asp:Label ID="Label34" runat="server" Text="Date Added" CssClass="Labels"></asp:Label>
                            </td>
                            <td>
                                <div class="txboxdiv">
                                    <asp:TextBox ID="txtviolationdateadded" runat="server" CssClass="date"></asp:TextBox>

                                </div>
                            </td>
                        </tr>

                        <tr style="display: none">
                            <td align="right">

                                <asp:Label ID="Label51" runat="server" Text="Entered By" CssClass="Labels"></asp:Label>
                            </td>
                            <td>
                                <div class="txboxdiv">
                                    <asp:TextBox ID="txtviolationenteredby" runat="server" CssClass="txtcssbox" ReadOnly="true"></asp:TextBox>
                                </div>
                            </td>
                        </tr>


                        <tr>
                            <td>

                                <asp:Label ID="Label4" runat="server" Text="Public Info" CssClass="Labels"></asp:Label>
                            </td>
                            <td>
                                <asp:CheckBox ID="chk_publicinfo" runat="server" TextAlign="Left" />
                            </td>
                        </tr>

                        <tr>
                            <td></td>
                            <td></td>

                        </tr>
                        <tr>
                            <td colspan="2" align="center">
                                <table align="center">
                                    <tr>
                                        <td align="center">
                                            <asp:Button ID="btnviolationsubmit" OnClientClick="javascript:return violationValidation()" runat="server" Height="30"
                                                Text="Submit" Width="108px" OnClick="btnviolationsubmit_Click" />

                                            <script language="javascript" type="text/javascript">

                                                function violationValidation() {


                                                    var err = "";
                                                    var cmp_count = 0;

                                                    //err+=Value_listbox_selected('<%= ddlviolations.ClientID %>',"Please Select Violations.\r\n");   

                                                    //                                                                        err+=Value_Checked_Drp('<%= ddlviolations.ClientID %>',"Please Select Violations.\r\n");

                                                    //  err+=Value_Checked('<%= txtviolationdateadded.ClientID %>',"Please enter Violationdateadded.\r\n");
                                                    // err+=Value_Checked('<%= txtviolationenteredby.ClientID %>',"Please enter Violationentereby.\r\n");

                                                    if (document.getElementById('<%=chk_publicinfo.ClientID %>').checked == false)
                                                        err += "Please select public info.\r\n";



                                                    if (err != "") {

                                                        altbox(err);
                                                        //  altbox(err);


                                                        return false;

                                                    }
                                                    return true;


                                                }

                                            </script>


                                        </td>
                                        <td>
                                            <asp:Button ID="btnviolationupdate" OnClick="btnviolationupdate_Click" runat="server" Text="Update" />
                                        </td>
                                        <td align="center">

                                            <input type="submit" name="ad" value="Cancel" onclick="javascript: return Vilation_cancel();" id="btnviolationcancel" />



                                        </td>
                                    </tr>
                                </table>
                            </td>

                        </tr>

                    </table>
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        var isedit = $('#ctl00_hfdwrite').val();
        var isdel = $('#ctl00_hfddel').val();
        if (isedit == 'False') {
            $('#ctl00_ContentPlaceHolder1_btnfindingfacts').addClass('hide');
            $('#btnHearingNew').addClass('hide');
            $('#btneditresolution').addClass('hide');
        }
        if (isedit == 'True' && isdel == 'True') {
            sa3.cols = [new dcol("Hearing Date & Time", "hearingdatetime"), new dcol("Count", "HearingLocation"), new dcol("TBD", "tbd"), new dcol("Is Respondent Expected", "IsRespondent"), new dcol("Print", "", "", "1", "1", "print_lkp", "fa fa-print grdicon"), new dcol("Edit", "", "", "1", "1", "editFormalHearing_lkp", "fa fa-pencil-square-o grdicon"), new dcol("Delete", "", "", "1", "1", "deleteFormalHearing_lkp", "fa fa-trash-o grdicon")];
        }
        else if (isedit == 'True')
            sa3.cols = [new dcol("Hearing Date & Time", "hearingdatetime"), new dcol("Count", "HearingLocation"), new dcol("TBD", "tbd"), new dcol("Is Respondent Expected", "IsRespondent"), new dcol("Print", "", "", "1", "1", "print_lkp", "fa fa-print grdicon"), new dcol("Edit", "", "", "1", "1", "editFormalHearing_lkp", "fa fa-pencil-square-o grdicon")];
        else if (isdel == 'True')
            sa3.cols = [new dcol("Hearing Date & Time", "hearingdatetime"), new dcol("Count", "HearingLocation"), new dcol("TBD", "tbd"), new dcol("Is Respondent Expected", "IsRespondent"), new dcol("Print", "", "", "1", "1", "print_lkp", "fa fa-print grdicon"), new dcol("Delete", "", "", "1", "1", "deleteFormalHearing_lkp", "fa fa-trash-o grdicon")];
        else
            sa3.cols = [new dcol("Hearing Date & Time", "hearingdatetime"), new dcol("Count", "HearingLocation"), new dcol("TBD", "tbd"), new dcol("Is Respondent Expected", "IsRespondent"), new dcol("Print", "", "", "1", "1", "print_lkp", "fa fa-print grdicon")];
    </script>
    <script type="text/javascript">

        reshis = '"pid":"' + document.getElementById('<%= hfd_pid.ClientID %>').value + '"';
        resolutionhis.data = reshis;
        resolutionhis.process();

        dataIn = '"comid":"' + document.getElementById('<%= hfdrelatedcompid.ClientID %>').value + '",'
        dataIn = dataIn + '"pid":"' + document.getElementById('<%= hfd_pid.ClientID %>').value + '"';
        
        sa3.data = dataIn;
        sa3.process();
    </script>
</asp:Content>
