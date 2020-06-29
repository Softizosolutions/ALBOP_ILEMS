<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Complaints/Complaints.Master" CodeBehind="Inspection_Search.aspx.cs" Inherits="Licensing.Complaints.Inspection_Search" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cntmain" runat="server">
    <script>
        var bus = new sagrid();
        bus.url = "../Reports/Report.svc/GetInspectioninside";

        bus.primarykeyval = "FEIN";
        bus.bindid = "res";
        bus.cols = [new dcol("Business Name", "Business"), new dcol("User", "FEIN"), new dcol("License #", "Lic_no"), new dcol("Description", "Description"), new dcol("Date", "dcdt"), new dcol("Download", "", "", "1", "1", "down_lkp", "fa fa-download grdicon")];

        bus.objname = "bus";
        bus.aftercall = "Aftercall";
        function down_lkp(sender, keyval) {

            var fname = bus.resultdata[sender]["docpath"];

            if (fname != '') {
                window.open(fname);
            }
            else {
                altbox('Sorry no file attached.');
            }
        }
        function Bindgrd() {
            dataIn = "";
            var sdt = document.getElementById('<%= txtsdt.ClientID %>').value;
            dataIn = dataIn + '"sdt":"' + sdt + '",'
            var edt = document.getElementById('<%= txtedt.ClientID %>').value;
        dataIn = dataIn + '"edt":"' + edt + '",'
        var seltype = 0;
        if (document.getElementById('<%=rbltype.ClientID%>' + '_0').checked)
                seltype = 0;
            else if (document.getElementById('<%=rbltype.ClientID%>' + '_1').checked)
                seltype = 1;
            else
                seltype = 2;
            dataIn = dataIn + '"type":"' + seltype + '"'
            bus.data = dataIn;
            bus.process();

            return false;
        }

        function Afterdel() {
            altbox('Record Deleted.');
            bus.process();

        }

        function Aftercall() {
            if (bus.resultdata.length == 0) {
                altbox('No Records Found.');
            }
        }
        function clear_data() {
            document.getElementById('<%= txtsdt.ClientID %>').value = "";
        document.getElementById('<%= txtedt.ClientID %>').value = "";
        document.getElementById('res').innerHTML = '';
        return false;
    }
    </script>
    <div class="cpanel">
        <div class="head">
            Inspection Search
        </div>
        <div class="body">
            <table align="center" class="spac">
                <tr>
                    <td align="right">Start Date :
                    </td>
                    <td align="left">
                        <asp:TextBox ID="txtsdt" runat="server" CssClass="date"></asp:TextBox>
                    </td>
                    <td align="right">End Date :
                    </td>
                    <td align="left">
                        <asp:TextBox ID="txtedt" runat="server" CssClass="date"></asp:TextBox>
                    </td>

                </tr>
                <tr>
                    <td align="center" colspan="4">
                        <asp:RadioButtonList ID="rbltype" runat="server" RepeatDirection="Horizontal">
                            <asp:ListItem Value="0" Text="All" Selected="True"></asp:ListItem>
                            <asp:ListItem Value="1" Text="Online"></asp:ListItem>
                            <asp:ListItem Value="2" Text="Manual"></asp:ListItem>
                        </asp:RadioButtonList>
                    </td>
                </tr>
                <tr>
                    <td colspan="4" align="center">
                        <br />
                        <asp:Button ID="btnsearch" runat="server" Text="Search" OnClientClick="javascript:return Bindgrd()" />
                        <asp:Button ID="btnsearchclear" runat="server" Text="Clear" OnClientClick="javascript:return clear_data()" />


                    </td>
                </tr>
            </table>
        </div>
    </div>

    <div class="cpanel">
        <div class="head">Search Results</div>
        <div class="body">
            <div id="res"></div>
        </div>
    </div>
</asp:Content>
