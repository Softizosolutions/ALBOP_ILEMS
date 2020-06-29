<%@ Page Title="" Language="C#" MasterPageFile="~/Master Page/frm.Master" AutoEventWireup="true" CodeBehind="ComplaintInvestigation.aspx.cs" Inherits="Licensing.PersonLicensing.ComplaintInvestigation" %>

<%@ Register Assembly="CKEditor.NET" Namespace="CKEditor.NET" TagPrefix="CKEditor" %>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="cntwin1" style="width: 98%; margin-left: auto; margin-right: auto;">

        <asp:HiddenField ID="hfd_saved" runat="server" Value="" />
        <asp:HiddenField ID="hfd_invid" runat="server" Value="" />
        <asp:HiddenField ID="hfd_sumcomp" runat="server" Value="" />
        <asp:HiddenField ID="hfd_concl" runat="server" Value="" />
        <asp:HiddenField ID="hfd_relev" runat="server" Value="" />
        <%--<asp:HiddenField ID="hfd_jouid" runat="server" />--%>
        <%-- <asp:HiddenField ID="hfdpharmacyid" runat="server" Value="0" />
                            <asp:HiddenField ID="hfdrelatedphyid" runat="server" Value="0" />--%>
        <asp:HiddenField ID="hfdcomid" runat="server" Value="" />



        <script language="javascript" type="text/javascript">
            function SummaryValidation() {

                var val1 = CKEDITOR.instances.ctl00_ContentPlaceHolder1_txtcomplaint.getData();
                var err = "";

                if (val1 == "")
                    err += '<li>Please enter summary.</li></br>';
                if (err != "") {
                    altbox(err);
                    return false;
                }

                return true;
            }
            function SummaryClear() {
                CKEDITOR.instances.ctl00_ContentPlaceHolder1_txtcomplaint.setData('');
                return false;
            }
            function Summaryload() {

                CKEDITOR.instances.ctl00_ContentPlaceHolder1_txtcomplaint.setData('');
                var cmpid = document.getElementById('<%=hfdcomid.ClientID%>').value;

                 $.ajax({
                     type: "POST",
                     url: "../Prints/28_0.aspx?print=1&pgid=28&refid=" + cmpid + "&dt=1",
                     success: function (msg) {


                         CKEDITOR.instances.ctl00_ContentPlaceHolder1_txtcomplaint.setData(msg);
                     },
                     error: function (e) {
                         alert('error');
                     }
                 });


                 return false;

             }


             function RelevantValidation() {

                 var val1 = CKEDITOR.instances.ctl00_ContentPlaceHolder1_txtRelevantHistory.getData();
                 var err = "";

                 if (val1 == "")
                     err += '<li>Please enter relevant.</li></br>';
                 if (err != "") {
                     altbox(err);
                     return false;
                 }

                 return true;
             }

             function RelevantClear() {


                 CKEDITOR.instances.ctl00_ContentPlaceHolder1_txtRelevantHistory.setData('');



                 return false;

             }


             function InvestigationValidation() {

                 var val1 = CKEDITOR.instances.ctl00_ContentPlaceHolder1_txtinvestigation.getData();
                 var err = "";

                 if (val1 == "")
                     err += '<li>Please enter investigation.</li></br>';
                 if (err != "") {
                     altbox(err);
                     return false;
                 }

                 return true;
             }

             function InvestigationClear() {


                 CKEDITOR.instances.ctl00_ContentPlaceHolder1_txtinvestigation.setData('');



                 return false;

             }


             function ViolationsValidation() {

                 var val1 = CKEDITOR.instances.ctl00_ContentPlaceHolder1_txtinvconclusion.getData();
                 var err = "";

                 if (val1 == "")
                     err += '<li>Please enter violation.</li></br>';
                 if (err != "") {
                     altbox(err);
                     return false;
                 }

                 return true;
             }

             function ViolationsClear() {


                 CKEDITOR.instances.ctl00_ContentPlaceHolder1_txtinvconclusion.setData('');



                 return false;

             }

        </script>

        <div class="cpanel">
            <div class="head accr expand">Summary Of Complaint</div>
            <div class="body">
                <CKEditor:CKEditorControl ID="txtcomplaint" ToolTip="" ToolbarStartupExpanded="True" runat="server" Width="100%" Height="500" BasePath="~/ckeditor"> 
                                         
                </CKEditor:CKEditorControl>
                <center>

                    <asp:Button ID="btnAddSummary" OnClientClick="javascript:return SummaryValidation()" runat="server" Text="Submit" OnClick="btnAddSummary_Click" />
                    &nbsp;&nbsp;
                                                         <asp:Button ID="Button1" runat="server" OnClientClick="javascript:return Summaryload()" Text="Load Blank Template" />
                    &nbsp;&nbsp;
             <asp:Button ID="btndocs" runat="server" OnClick="btnsendoc_click" Visible="false" Text="Send to documents" />
                    &nbsp;&nbsp;
            <asp:Button ID="btnprint" runat="server" Text="Print" OnClick="btnprint_Click" />&nbsp;&nbsp;
                                                         <asp:Button ID="Button28" runat="server" OnClientClick="javascript:return SummaryClear()" Text="Clear" />

                </center>
            </div>
        </div>

        <div style="display: none">
            <div class="cpanel">
                <div class="head accr">Relevant History</div>
                <div class="body">

                    <CKEditor:CKEditorControl ID="txtRelevantHistory" ToolTip="" ToolbarStartupExpanded="True" runat="server" Width="100%" Height="300" BasePath="~/ckeditor"> 
                                         
                    </CKEditor:CKEditorControl>
                    <center>
                        <asp:Button ID="btnRelevantHistory" runat="server" Text="Submit" OnClientClick="javascript:return RelevantValidation()" OnClick="btnRelevantHistory_Click" />&nbsp;&nbsp;
                                                         <asp:Button ID="Button2" runat="server" Text="Clear" OnClientClick="javascript:return RelevantClear()" />

                    </center>
                </div>
            </div>
            <div class="cpanel">
                <div class="head accr">Investigation Findings</div>
                <div class="body">
                    <table>
                        <tr>
                            <td>&nbsp; &nbsp; 
                                <asp:CheckBox ID="chkDrugDiversion" runat="server" Text="Drug Diversion Chart" />
                                &nbsp; &nbsp;<asp:CheckBox ID="chkPriscriptionprofile" runat="server" Text="Prescription Profile Chart" />
                            </td>
                        </tr>
                    </table>

                    <CKEditor:CKEditorControl ID="txtinvestigation" ToolTip="" ToolbarStartupExpanded="True" runat="server" Width="100%" Height="300" BasePath="~/ckeditor"> 
                                         
                    </CKEditor:CKEditorControl>
                    <center>
                        <asp:Button ID="btnInvestigationFindings" runat="server" OnClientClick="javascript:return InvestigationValidation()" OnClick="btnInvestigationFindings_Click" Text="Submit" />&nbsp;&nbsp;
                                                         <asp:Button ID="Button4" runat="server" OnClientClick="javascript:return InvestigationClear()" Text="Clear" />

                    </center>
                </div>
            </div>

            <div class="cpanel" style="display: none">
                <div class="head accr">Drug Diversion</div>
                <div class="body">
                    <table>
                        <tr>
                            <td>&nbsp; &nbsp;  
                                 <asp:CheckBox ID="chkaddinvstfind" runat="server" Text="Add to Investigation Findings"
                                     Checked="True" />

                            </td>
                        </tr>
                    </table>

                    <CKEditor:CKEditorControl ID="txtdrugdrivision" ToolTip="" ToolbarStartupExpanded="True" runat="server" Width="100%" Height="300" BasePath="~/ckeditor"> 
                                         
                    </CKEditor:CKEditorControl>
                    <center>
                        <asp:Button ID="btnDrugDiversion" runat="server" Text="Submit" OnClick="btnDrugDiversion_Click" />&nbsp;&nbsp;
                                                         <asp:Button ID="Button6" runat="server" Text="Clear" />

                    </center>
                </div>
            </div>

            <div class="cpanel" style="display: none">
                <div class="head accr">Prescription Profile</div>
                <div class="body">

                    <CKEditor:CKEditorControl ID="txtpros" ToolTip="" ToolbarStartupExpanded="True" runat="server" Width="100%" Height="300" BasePath="~/ckeditor"> 
                                         
                    </CKEditor:CKEditorControl>
                    <center>
                        <asp:Button ID="Button7" runat="server" Text="Submit" />&nbsp;&nbsp;
                                                         <asp:Button ID="Button8" runat="server" Text="Clear" />

                    </center>
                </div>
            </div>

            <div class="cpanel">
                <div class="head accr">Investigative Violations</div>
                <div class="body">

                    <table>
                        <tr>
                            <td>
                                <asp:Label ID="Label8" runat="server" Text=" Violations :" CssClass="Labels"></asp:Label>
                                &nbsp; &nbsp; 
                                <asp:DropDownList ID="ddlVoilations" runat="server">
                                </asp:DropDownList>
                            </td>
                        </tr>
                    </table>
                    <br />
                    <CKEditor:CKEditorControl ID="txtinvconclusion" ToolTip="" ToolbarStartupExpanded="True" runat="server" Width="100%" Height="300" BasePath="~/ckeditor"> 
                                         
                    </CKEditor:CKEditorControl>
                    <center>
                        <asp:Button ID="btnINvestiativeVoilations" runat="server" Text="Submit" OnClientClick="javascript:return ViolationsValidation()" OnClick="btnINvestiativeVoilations_Click" />&nbsp;&nbsp;
                                                         <asp:Button ID="Button10" OnClientClick="javascript:return ViolationsClear()" runat="server" Text="Clear" />

                    </center>
                </div>
            </div>
        </div>
        <br />
        <br />
        <br />

    </div>
    <script type="text/javascript">
        var isedit = $('#ctl00_hfdwrite').val();
        var isdel = $('#ctl00_hfddel').val();
        if (isedit == 'False')
            $('#ctl00_ContentPlaceHolder1_btnAddSummary').addClass('hide');
        
    </script>
</asp:Content>
