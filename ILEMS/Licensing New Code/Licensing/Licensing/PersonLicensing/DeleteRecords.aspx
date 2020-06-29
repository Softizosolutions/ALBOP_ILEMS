<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/PersonLicensing/Person.Master" CodeBehind="DeleteRecords.aspx.cs" Inherits="Licensing.PersonLicensing.DeleteRecords" %>

<asp:Content ID="content1" runat="server" ContentPlaceHolderID="cntmain">
<script>
    var bus = new sagrid();
    bus.url = "../Reports/Report.svc/Getdellst";

    bus.primarykeyval = "auid";
    bus.bindid = "res";
    bus.cols = [new dcol("Name", "Name"), new dcol("SSN", "SSN"), new dcol("License Type", "License_Type"), new dcol("Lic #", "Lic_no"), new dcol("Status", "Status"), new dcol("Delete", "", "", "1", "1", "delkp1", "fa fa-hand-o-up grdicon")];
       
    bus.objname = "bus";
    bus.aftercall = "Aftercall";
    function Bindgrd() {
        dataIn = "";
        var refid = document.getElementById('<%= txtrefid.ClientID %>').value;
        dataIn = dataIn + '"refid":"' + refid + '",'
        var type = document.getElementById('<%= ddltype.ClientID %>').value;
        dataIn = dataIn + '"type":"' + type + '"'
        bus.data = dataIn;
        bus.process();

        return false;
    }
    function cnffnres(results) {
        if (results == 'true')
            document.getElementById('<%= btndel.ClientID %>').click();
    }
    function Afterdel() {
        altbox('Record Deleted.');
        bus.process();

    }
    function delkp1(sender, keyval) {
        alert(keyval);
        document.getElementById('<%= hfdauid.ClientID %>').value = keyval;
        cnfbox(" Are you sure you want to Delete this Record? ", "cnffnres");
    }
    function Aftercall() {
        if (bus.resultdata.length == 0) {
            altbox('No Records Found.');
        }
    }
    function clear_data() {
        document.getElementById('<%= hfdauid.ClientID %>').value = "0";
        document.getElementById('<%= txtrefid.ClientID %>').value = "";
        document.getElementById('<%= ddltype.ClientID %>').value = "-1";
        document.getElementById('res').innerHTML = '';
        return false;
    }
</script>
 <div class="cpanel">
 <asp:UpdatePanel ID="upd" runat="server">
 <ContentTemplate>
 <asp:Button ID="btndel" runat="server" style="display:none" OnClick="btndel_click" />
  <asp:HiddenField ID="hfdauid" runat="server" Value="0"  />
 </ContentTemplate>
 </asp:UpdatePanel>
                <div class="head">
                Delete Records
                </div>
                <div class="body">
                <table align="center" class="spac">
                <tr>
                <td align="right">
                Search Type :
                </td>
                <td align="left">
                <asp:DropDownList ID="ddltype" runat="server">
                <asp:ListItem Value="0">By Person ID</asp:ListItem>
                 <asp:ListItem Value="1">By License No</asp:ListItem>
                    <asp:ListItem Value="2">Complaint No</asp:ListItem>
                </asp:DropDownList>
               
                  </td>
                <td align="right">
                License #/Person ID/Complaint # :
                </td>
                <td align="left">
                <asp:TextBox ID="txtrefid" runat="server"></asp:TextBox>
                </td>
                </tr>
                <tr>
                <td colspan="4" align="center">
                <br />
                  <asp:Button ID="btnsearch" runat="server" Text="Search" OnClientClick="javascript:return Bindgrd()"  />
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
                <div id="res"></div>
                </div>
                </div>
   </asp:Content>
