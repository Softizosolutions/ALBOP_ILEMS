<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CE_Audit.aspx.cs" MasterPageFile="~/Master Page/frm.Master"  Inherits="Licensing.PersonLicensing.CE_Audit" %>
<asp:Content ID="ce" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script type="text/javascript">

        function Popup() {
            $(function () {
                $('#btnnew_pop').dialog({ title: 'Edit Ce Audit' });
                $('#btnnew_pop').dialog("open");
            });
        }
        var dataIn = '';
        var sa5 = new sagrid();
        sa5.url = "../WCFGrid/GridService.svc/Bindceaudit";

        sa5.primarykeyval = "CeAuditID";
        sa5.bindid = "grdceaudit";

        sa5.objname = "sa5";
        sa5.cols = [new dcol("Year", "Year"), new dcol("Date Sent", "DateSent"), new dcol("Date Received", "DateReceived"), new dcol("Live Hours", "LiveHours"), new dcol("Non Live Hours", "Non_live_hours"), new dcol("Status", "CeStatus"),new dcol("Fee Paid", "FeePaid"), new dcol("Comments", "Comments"), new dcol("Edit", "", "", "1", "1", "edit_lkp", "fa fa-pencil-square-o grdicon"), new dcol("Delete", "", "", "1", "1", "Delete_lkp", "fa fa-trash-o grdicon")];
        sa5.process();



        
        function edit_lkp(sender, keyval) {
           
            document.getElementById('<%= hfdselid.ClientID %>').value = keyval;
            document.getElementById('<%= btnedit.ClientID %>').click();
        }
        function cnffnres(result) {
      
            if (result == 'true')
                document.getElementById('<%= btndel.ClientID %>').click();
        }

        function Delete_lkp(sender, keyval) {
            document.getElementById('<%= hfdselid.ClientID %>').value = keyval;
            cnfbox(" Are you sure do you want to delete this record?", "cnffnres");
        }

        function afterpost(msg) {
            sa5.process();
            altbox(msg);
            $('#btnnew_pop').dialog('close');
            $('#buttonnew_pop').dialog('close');      

        }


        function Clear_CEAUDIT() {
            document.getElementById('<%= hfdceauditid.ClientID %>').value = '0';
            document.getElementById('<%= txt_comment.ClientID %>').value = '';
            document.getElementById('<%= txt_datereceived.ClientID %>').value = '';
            //document.getElementById('<%= txt_datesent.ClientID %>').value = '';
            document.getElementById('<%= txt_live_hours.ClientID %>').value = '';
            document.getElementById('<%= ddl_status.ClientID %>').value = '-1';
                 //document.getElementById('<%= ddl_year.ClientID %>').value = '-1';
            document.getElementById('<%= txt_Non_live_hours.ClientID %>').value = '';
            document.getElementById('<%= ddl_feepaid.ClientID %>').value = '-1';
           
            return false;
        }

        $('#ddl_year').find('select').val('2018');
    </script>
    <asp:UpdatePanel ID="upd" runat="server">
        <ContentTemplate>
            <asp:HiddenField ID="hfdceauditid" runat="server" Value="0" />
            <asp:HiddenField ID="hfdselid" runat="server" Value="0" />
            <asp:HiddenField ID="hfdobjtype" runat="server" Value="0" />
            <asp:Button ID="btnedit" runat="server" Style="display: none" OnClick="btnedit_Click" />
            <asp:Button ID="btndel" runat="server" Style="display: none" OnClick="btndel_Click" />
        </ContentTemplate>
    </asp:UpdatePanel>
        <asp:HiddenField ID="hfdpid" runat="server" Value="0" />
   <div style="width: 98%; margin-left: auto; margin-right: auto">
        <div class="cpanel" id="outofstate" runat="server">
            <div class="head accr expand">
                CE Audit Details
            </div>
            <div class="body">
                <div style="text-align: right; padding-right: 10px; margin-top: 0px">
                    <input type="button" id="btnnew" value="Add New" class="poptrg" onclick="javascript: return Clear_CEAUDIT()" />
                </div>
                <br />
                <div id='btnnew_pop' class="popup" style="display: none;">
                    <span class="title">Add New Ce Audit</span>
                    <asp:UpdatePanel ID="upd1" runat="server">
                        <ContentTemplate>
                            <table align="center" class="spac" id="frmfld">
                                <tr>
                                    <td align="right">Year
                                    </td>
                                    <td align="left">
                                        <asp:DropDownList ID="ddl_year" runat="server"  >
                                         
                                        </asp:DropDownList>
                                        
                                    
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">Date Sent
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="txt_datesent"  CssClass="date" placeholder="Date Sent" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">Date Received 
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="txt_datereceived" placeholder="Date Received"  CssClass="date" runat="server">
                                        </asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">Live Hours
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="txt_live_hours" runat="server"  placeholder="Live Hours">
                                        </asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">Non Live Hours
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="txt_Non_live_hours" runat="server"  placeholder="Non Live Hours"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">Status
                                    </td>
                                    <td align="left">
                                        <asp:DropDownList ID="ddl_status" runat="server">
                                            <asp:ListItem Text="Select Status" Value="-1"></asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                            <td align="right">Fee Paid?</td>
                            <td align="left">
                                <asp:DropDownList ID="ddl_feepaid" runat="server" >
                                    <asp:ListItem Value="-1">Select Fee Paid</asp:ListItem>
                                    <asp:ListItem Value="Yes">Yes</asp:ListItem>
                                    <asp:ListItem Value="No">No</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                                <tr>
                                    <td align="right">Comments
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="txt_comment" runat="server" placeholder="Comment" TextMode="MultiLine"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center" colspan="2">
                                        <asp:Button ID="btn_submit" runat="server" Text="Submit" OnClick="btn_submit_Click" 
                                            OnClientClick="javascript:return Save_Validations();" />
                                        <asp:Button ID="btn_clear" runat="server" Text="Clear" OnClientClick="javascript:return Clear_CEAUDIT();" />
                                    </td>
                                </tr>
                            </table>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
                <div id="grdceaudit">
                </div>
            </div>
        </div>
    </div>
        <script type="text/javascript">

        dataIn = '"pid":"' + document.getElementById('<%= hfdpid.ClientID %>').value + '"';
        sa5.data = dataIn;
        sa5.process();
    </script>
</asp:Content>
