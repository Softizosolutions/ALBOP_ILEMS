<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Complaints/Complaints.Master" CodeBehind="HearingReport.aspx.cs" Inherits="Licensing.Complaints.HearingReport" %>

<asp:Content ID="content1" runat="server" ContentPlaceHolderID="cntmain">
    <script type="text/javascript">
        var dataIn = '';
        var cmphearing = new sagrid();
        cmphearing.url = "../WCFGrid/GridService.svc/BindComplaintsFormalHearing";
        cmphearing.primarykeyval = "Complaint_ID";
        cmphearing.objname = "cmphearing";
        cmphearing.bindid = "grdhearingreport";
        cmphearing.aftercall = "Aftercall1";

        function ClearHearingReport() {
            document.getElementById('<%=txtfromdate.ClientID%>').value = ''
            document.getElementById('<%=txttodate.ClientID%>').value = '';
        }
        function ValidateFormalHearing() {
            if (document.getElementById('<%=txtfromdate.ClientID%>').value == '') {
                altbox("Please enter from date");
                document.getElementById('<%=txtfromdate.ClientID%>').focus()
                return false;
            }
            bindcomplaintsearch();
            return true;
        }

        function bindcomplaintsearch() {

            dataIn = "";
            var fromdate = document.getElementById('<%= txtfromdate.ClientID %>').value;
            dataIn = dataIn + '"fromdate":"' + fromdate + '",'
            var todate = document.getElementById('<%= txttodate.ClientID %>').value;
            dataIn = dataIn + '"todate":"' + todate + '"'
            cmphearing.cols = [new dcol("Complaint #", "Complaint_Number"), new dcol("License #", "Lic_no"), new dcol("License Type", "LicenseType"), new dcol("Respondent's Name", "Name"), new dcol("Category", "Category"), new dcol("Hearing Date", "HearingDate"), new dcol("Hearing Time", "HearingTime"), new dcol("Attorney", "Attorney"), new dcol("Witness", "Complaint_Witness"), new dcol("Investigator", "Inspector_Name"), new dcol("Prior Case Numbers", "Inspector_Signature"), new dcol("Settled", "Settled"), new dcol("Count", "Count")];
            cmphearing.data = dataIn;
            cmphearing.process();
            return false;
        }
        function Aftercall1() {
            var result = cmphearing.resultdata;
            if (result.length > 0)
                return true;
            else {
                altbox("No Records found.");
                document.getElementById('grdhearingreport').innerHTML = '';
            }
        }
    </script>
    <div class="cpanel">
        <div class="head">
            Hearing Report Search
        </div>
        <div class="body">
            <table style="width: 60%" class="spac" align="center">
                <tr>
                    <td align="right">From Date :
                    </td>
                    <td align="left">
                        <asp:TextBox ID="txtfromdate" runat="server" CssClass="date"></asp:TextBox>
                    </td>
                    <td align="right">To Date :
                    </td>
                    <td align="left">
                        <asp:TextBox ID="txttodate" runat="server" CssClass="date"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td align="center" colspan="4">
                        <input type="button" value="Search" id="btnsearch" name="search" onclick="javascript: return ValidateFormalHearing();" />&nbsp;&nbsp;
                        <input type="button" value="Clear" name="clear" id="btnclear" onclick="javascript: return ClearHearingReport()" />
                    </td>
                </tr>
            </table>
        </div>
    </div>
    <div class="cpanel">
        <div class="head">
            Search Result
        </div>
        <div class="body">
            <div id="grdhearingreport"></div>
        </div>
    </div>
</asp:Content>
