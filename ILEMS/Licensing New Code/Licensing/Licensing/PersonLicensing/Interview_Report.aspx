<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Interview_Report.aspx.cs" MasterPageFile="~/PersonLicensing/Person.Master" Inherits="Licensing.PersonLicensing.Interview_Report" %>

<asp:Content ID="content1" runat="server" ContentPlaceHolderID="cntmain">
     <script type="text/javascript">
        var dataIn = '';
        var cmphearing = new sagrid();
        cmphearing.url = "../WCFGrid/GridService.svc/BindInterviewReport";
        cmphearing.primarykeyval = "Auid";
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
            cmphearing.cols = [new dcol("First Name", "First_Name"), new dcol("Middle Name", "Middle_Name"), new dcol("Last Name", "Last_Name"), new dcol("School", "School"), new dcol("State", "State"), new dcol("Purpose", "Purpose"), new dcol("Signature", "Signature")];
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
            Interview Report Search
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
