<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="PersonLicense_Details.ascx.cs" Inherits="Licensing.PersonLicensing.PersonLicense_Details" %>


<style>
    .Labels {
        font-weight: bold;
    }
</style>

<asp:HiddenField ID="hfd_Appid" runat="server" Value="0" />
<asp:HiddenField ID="hfd_licid" runat="server" Value="0" />
<asp:HiddenField ID="hfd_rnexpdt" runat="server" Value="0" />
<asp:HiddenField ID="hfdlicno" runat="server" Value="0" />
<asp:HiddenField ID="hfd_ltypeid" runat="server" />
<asp:HiddenField ID="hfdlictypeid" runat="server" Value="0" />
<div style="padding: 10px; padding-bottom: 20px">
    <table width="100%">
        <tr>
            <td align="right">
                <asp:Button ID="btn_changelictype" runat="server" Text="Change Type" />
                <asp:Button ID="btn_changestatus" runat="server" Text="Change Status"  />
                <asp:Button ID="btnstatushistory" runat="server" Text="Status History"   />
                <asp:Button ID="btnrenewalhistory" runat="server" Text="Renewal History" OnClientClick="javascript:return renewalhistory(this);" />

            </td>
        </tr>
    </table>
    <table style="width: 90%; margin-left: auto; margin-right: auto; margin-top: 5px" class="gridmain1" cellpadding="0" cellspacing="0" border="1">

        <tr>
            <td align="right" class="Labels" width="200px">Appl. Date :
            </td>
            <td class="style5">
                <asp:Label ID="lbl_Appldate" runat="server"></asp:Label>
            </td>
            <td align="right" class="Labels" width="200px">Issue Date :
            </td>
            <td class="style5">
                <asp:Label ID="lbllicence_issuedate" runat="server"></asp:Label>
            </td>
        </tr>

        <tr>
            <td align="right" class="Labels" width="200px">Expiration Date :
            </td>
            <td class="style5">
                <asp:Label ID="lbllicexpdate" runat="server"></asp:Label>
            </td>
            <td align="right" class="Labels">Status :
            </td>
            <td class="style3">
                <asp:Label ID="lbllicstatus" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td align="right" class="Labels" width="205px">Status Change Date :
            </td>
            <td>
                <asp:Label ID="lblcicstatuschannge" runat="server"></asp:Label>
            </td>
            <td align="right" class="Labels">Last Renewal Date :</td>
            <td>
                <asp:Label ID="lbllastrenewdt" runat="server"></asp:Label>
            </td>
        </tr>
         <tr>
             <td colspan="4">
                 <asp:Panel ID="pnlreason" runat="server">
                     <table style="width:100%;">
                         <tr>
                             <td align="right" width="204px">
                                 Reason :
                             </td>
                             <td align="center" width="294px">
                                 <asp:Label ID="lblreason" runat="server"></asp:Label>
                             </td>
                             <td width="199px"></td><td></td>
                         </tr>
                     </table>
                 </asp:Panel>
             </td>
         </tr>
    </table>



</div>



