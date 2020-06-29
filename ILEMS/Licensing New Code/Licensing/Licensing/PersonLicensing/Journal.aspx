<%@ Page Language="C#" MasterPageFile="../Master Page/frm.master" AutoEventWireup="true" CodeBehind="Journal.aspx.cs" Inherits="Licensing.PersonLicensing.Journal" %>

<%@ Register Assembly="CKEditor.NET" Namespace="CKEditor.NET" TagPrefix="CKEditor" %>
<asp:Content ID="cnt1" runat="server" ContentPlaceHolderID="ContentPlaceHolder1">
    <script type="text/javascript">
        function Popup() {

            $('#fldadd').addClass("expand");

        }
    </script>
    <script type="text/javascript" language="javascript">

        function Clear() {
            document.getElementById('<%= hfdjournalid.ClientID %>').value = '0';
            document.getElementById('<%= ddlJournalType.ClientID %>').value = '-1';
            document.getElementById('<%= txtjournaltype.ClientID %>').value = '';
            document.getElementById('<%= ChkjournalAlert.ClientID %>').checked = false;
            return false;
        }
        function Save_Validations() {
            if (document.getElementById('<%=ddlJournalType.ClientID%>').selectedIndex == 0) {
                altbox("Please Select the Journal Type.")
                document.getElementById('<%= ddlJournalType.ClientID %>').focus()
                 return false;
             }
             if (document.getElementById('<%=txtjournaltype.ClientID%>').value == "") {
                altbox("Please Enter the Description.")
                document.getElementById('<%=txtjournaltype.ClientID %>').focus()
                 return false;
             }
         }
    </script>
    <script type="text/javascript">


        var dataIn = '';
        var sa5 = new sagrid();
        sa5.url = "../WCFGrid/GridService.svc/BindPersonjournal";

        sa5.primarykeyval = "Journal_Id";
        sa5.bindid = "grdjournal1";
        
        sa5.objname = "sa5";

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


    </script>
    <script type="text/javascript">
        function Save_Validation() {
            var errormsg = validateform('frmfld');
            if (errormsg != "") {
                Msgbox(errormsg);
                return false;
            }
            return true;

        }

    </script>

    <asp:HiddenField ID="hfdjournalid" runat="server" Value="0" />
    <asp:HiddenField ID="hfdpid" runat="server" Value="0" />
    <asp:HiddenField ID="hfdisce" runat="server" Value="0" />
    <asp:HiddenField ID="hfdselid" runat="server" Value="0" />
    <asp:Button ID="btnedit" runat="server" Style="display: none" OnClick="btnedit_click" />
    <asp:Button ID="btndel" runat="server" Style="display: none" OnClick="btndel_click" />

    <div style="width: 98%; margin-left: auto; margin-right: auto">
        <div class="cpanel" id="divjournal">
            <div id="fldadd" class="head accr">Add New Journal</div>
            <div class="body">

                <table align="center" width="100%" class="spac" id="frmfld">

                    <tr>
                        <td align="center">Type&nbsp;&nbsp; 
                                     
                                        <asp:DropDownList ID="ddlJournalType" runat="server" CssClass="required" error="Please enter type."></asp:DropDownList>&nbsp;&nbsp;
                                        <asp:CheckBox ID="ChkjournalAlert" runat="server" Text="Alert" TextAlign="Right" />&nbsp;&nbsp;
                                     <asp:Button ID="btn_submit" runat="server" Text="Submit" OnClick="btn_submit_Click" OnClientClick="javascript:return Save_Validation();" />&nbsp;&nbsp;
                                        <asp:Button ID="btn_clear" runat="server" Text="Clear" OnClick="btn_clear_Click" />&nbsp;&nbsp;
                                 
                        </td>
                    </tr>
                    <tr>
                        <td align="center">
                            <CKEditor:CKEditorControl ID="txtjournaltype" ToolbarStartupExpanded="true" Width="100%" runat="server" BasePath="~/ckeditor"> 
                            </CKEditor:CKEditorControl>
                        </td>
                    </tr>

                </table>

            </div>
        </div>
        <div class="cpanel">
            <div class="head accr expand">Existing Journals</div>
            <div class="body">
                <div id="grdjournal1"></div>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        var isedit = $('#ctl00_hfdwrite').val();
        var isdel = $('#ctl00_hfddel').val();
        if (isedit == 'False')
            $('#divjournal').addClass('hide');
        if (isedit == 'True' && isdel == 'True')
            sa5.cols = [new dcol("Type", "Values"), new dcol("Created Date", "CreatedDate"), new dcol("Created By", "cUser"), new dcol("Is Alert", "Is_Alert"), new dcol("Note", "Description", "", "-1"), new dcol("Edit", "", "", "1", "1", "edit_lkp", "fa fa-pencil-square-o grdicon"), new dcol("Delete", "", "", "1", "1", "Delete_lkp", "fa fa-trash-o grdicon")];
        else if (isedit == 'True')
            sa5.cols = [new dcol("Type", "Values"), new dcol("Created Date", "CreatedDate"), new dcol("Created By", "cUser"), new dcol("Is Alert", "Is_Alert"), new dcol("Note", "Description", "", "-1"), new dcol("Edit", "", "", "1", "1", "edit_lkp", "fa fa-pencil-square-o grdicon")];
        else if (isdel == 'True')
            sa5.cols = [new dcol("Type", "Values"), new dcol("Created Date", "CreatedDate"), new dcol("Created By", "cUser"), new dcol("Is Alert", "Is_Alert"), new dcol("Note", "Description", "", "-1"), new dcol("Delete", "", "", "1", "1", "Delete_lkp", "fa fa-trash-o grdicon")];
        else
            sa5.cols = [new dcol("Type", "Values"), new dcol("Created Date", "CreatedDate"), new dcol("Created By", "cUser"), new dcol("Is Alert", "Is_Alert"), new dcol("Note", "Description", "", "-1")];

        dataIn = '"pid":"' + document.getElementById('<%= hfdpid.ClientID %>').value + '"';
        sa5.data = dataIn;
        sa5.process();

    </script>
</asp:Content>
