<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Complaints/Complaints.Master" CodeBehind="Documentsreport.aspx.cs" Inherits="Licensing.Complaints.Documentsreport" %>

<asp:Content ID="content1" runat="server" ContentPlaceHolderID="cntmain">
    <script type="text/javascript">
        function Validate_documentFields() {
            if (document.getElementById('<%=ddl_doctype.ClientID%>').value == '-1') {
                altbox("Please select document type");
                document.getElementById('<%=ddl_doctype.ClientID%>').focus()
                return false;
            }
            if (document.getElementById('<%=txtfromdate.ClientID%>').value == '') {
                altbox("Please select from date");
                document.getElementById('<%=txtfromdate.ClientID%>').focus()
                return false;
            }
            if (document.getElementById('<%=txttodate.ClientID%>').value == '') {
                altbox("Please select to date");
                document.getElementById('<%=txttodate.ClientID%>').focus()
                return false;
            }
            Get_DocumentsDetails();
            return false;
        }
    </script>
    <script type="text/javascript">
        var datain = '';
        var docdata = new sagrid();
        docdata.url = '../WCFGrid/GridService.svc/BindDcoumentsDetails';
        docdata.primarykeyval = 'Person_ID';
        docdata.cols = [new dcol("Name", "Name"), new dcol("License #", "Lic_no"), new dcol("Case #", "Case_Number"), new dcol("Date Uploaded", "DocumentDate"), new dcol("View/download", "", "", "1", "1", "down_lkp", "fa fa-download grdicon")];
        docdata.bindid = 'grddocdetails';
        docdata.objname = 'docdata';
      
        function Get_DocumentsDetails() {
            datain = '';
            var doctype = document.getElementById('<%=ddl_doctype.ClientID%>').value;
            datain = datain + '"doctype":"' + doctype + '",'
            var fromdate = document.getElementById('<%=txtfromdate.ClientID%>').value;
            datain = datain + '"fromdate":"' + fromdate + '",'
            var todate = document.getElementById('<%=txttodate.ClientID%>').value;
            datain = datain + '"todate":"' + todate + '"';
            docdata.title = "Document Report - " + $('#<%=ddl_doctype.ClientID%> option:selected').text();
            docdata.data = datain;
            docdata.process();
        }
        function down_lkp(sender, keyval) {

             
            var fname = docdata.resultdata[sender]["docpath"];
             
             if (fname != '') {
                 window.open(  fname);
             }
             else {
                 altbox('Sorry no file attached.');
             }
        }
    </script>
    <div class="cpanel">
        <div class="head">
            Documents Search
            
        </div>
        <div class="body">
            <table style="width: 65%" class="spac" align="center">
                <tr>
                    <td align="center" colspan="4">Document Type :
                        <asp:DropDownList ID="ddl_doctype" runat="server"></asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td align="right" style="width:30%">From :
                    </td>
                    <td align="left" style="width:10%">
                        <asp:TextBox ID="txtfromdate" runat="server" CssClass="date"></asp:TextBox>
                    </td>
                    <td align="right">To :
                    </td>
                    <td align="left">
                        <asp:TextBox ID="txttodate" runat="server" CssClass="date"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td align="center" colspan="4">
                        <asp:Button ID="btngenerate" runat="server" Text="Generate" OnClientClick="javascript:return Validate_documentFields();"/>&nbsp;
                          <asp:Button ID="btnclear" runat="server" Text="Clear" />
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
            <div id="grddocdetails"></div>
        </div>
    </div>
</asp:Content>
