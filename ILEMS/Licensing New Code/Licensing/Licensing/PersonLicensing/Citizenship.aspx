<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/PersonLicensing/Person.Master" CodeBehind="Citizenship.aspx.cs" Inherits="Licensing.PersonLicensing.Citizenship" %>

<asp:Content ID="content1" runat="server" ContentPlaceHolderID="cntmain">
    <script type="text/javascript">
        var dataIn = '';
        var res = new sagrid();
        res.url = "../WCFGrid/GridService.svc/GetCitizenship";
        res.primarykeyval = "Lic_no";
        res.bindid = "result";
        res.cols = [new dcol("License #", "Lic_no"), new dcol("First Name", "First_Name"), new dcol("Last Name", "Last_Name")];
        res.objname = "res";
        res.aftercall = "Aftercall";
        function Bindgrd() {
            dataIn = "";
            var refid = document.getElementById('<%= ddl_applictype.ClientID %>').value;
            dataIn = dataIn + '"ltype":"' + refid + '"';
            res.data = dataIn;
            res.process();

            return false;
        }
        function Aftercall() {
            if (res.resultdata.length == 0) {
                altbox('No Records Found.');
                document.getElementById('result').innerHTML = '';
            }
        }
        function clear_data() {

            document.getElementById('<%= ddl_applictype.ClientID %>').value = "-1";
            document.getElementById('result').innerHTML = '';
            return false;
        }
    </script>
    <div class="cpanel">
        <asp:UpdatePanel ID="upd" runat="server">
            <ContentTemplate>
            </ContentTemplate>
        </asp:UpdatePanel>
        <div class="head">
            Citizenship
        </div>
        <div class="body">
            <table align="center" class="spac">
                <tr>
                    <td align="right">License Type :
                    </td>
                    <td align="left">
                        <asp:DropDownList ID="ddl_applictype" runat="server">
                        </asp:DropDownList>

                    </td>

                </tr>
                <tr>
                    <td colspan="2" align="center">
                        <br />
                        <asp:Button ID="btnsearch" runat="server" Text="Search" OnClientClick="javascript:return Bindgrd()" />
                        <asp:Button ID="btnsearchclear" runat="server" Text="Clear" OnClientClick="javascript:return clear_data()" />


                    </td>
                </tr>
            </table>
        </div>
    </div>
    <br />
    <div class="cpanel">
        <div class="head">Search Results</div>
        <div class="body">
            <div id="result"></div>
        </div>
    </div>
</asp:Content>

