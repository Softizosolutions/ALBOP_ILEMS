<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/PersonLicensing/Person.Master" CodeBehind="Merge.aspx.cs" Inherits="Licensing.PersonLicensing.Merge" %>

<asp:Content ID="content1" runat="server" ContentPlaceHolderID="cntmain">
     <script type="text/javascript">
        function Save_Validation() {
            var errormsg = validateform('frmfld');
            if (errormsg != "") {
                Msgbox(errormsg);
                return false;
            }
            return true;
        }
        function Clear_Fields() {
            document.getElementById('<%=txtfrom.ClientID%>').value = '';
            document.getElementById('<%=txtto.ClientID%>').value = '';
        }
    </script>
    <div class="cpanel">
        <div class="head">
            Merge
        </div>
        <div class="body">
            <table class="spac" align="center" id="frmfld">
                <tr>
                    <td align="right">
                        From :
                    </td>
                    <td align="left">
                        <asp:TextBox ID="txtfrom" runat="server" placeholder="From" CssClass="required" error="Please enter from."></asp:TextBox>
                    </td>
                    <td align="right">
                        To :
                    </td>
                    <td align="left">
                        <asp:TextBox ID="txtto" runat="server" placeholder="To" CssClass="required" error="Please enter to."></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td align="center" colspan="4">
                        <asp:Button ID="btnsubmit" runat="server" Text="Submit" OnClientClick="javascript:return Save_Validation();" OnClick="btnsubmit_Click"/>&nbsp;
                        <asp:Button ID="btnclear" runat="server" Text="Clear" OnClientClick="javascript:return Clear_Fields();"/>
                    </td>
                </tr>
            </table>
        </div>
    </div>
</asp:Content>
