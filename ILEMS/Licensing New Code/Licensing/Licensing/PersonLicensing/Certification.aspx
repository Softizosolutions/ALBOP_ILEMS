<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Master Page/frm.Master"
    CodeBehind="Certification.aspx.cs" Inherits="Licensing.PersonLicensing.Certification" %>

<asp:Content ID="cnt1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <script type="text/javascript">
        function Popup() {
            $(function () {
                $('#btnnew_pop').dialog({ title: 'Edit Certification' });
                $('#btnnew_pop').dialog("open");
            });
        }
        function Clear() {

            document.getElementById('<%=ddl_certification_type.ClientID %>').value = '-1';
            document.getElementById('<%=ddl_status.ClientID %>').value = '-1';

            document.getElementById('<%=effective_date.ClientID %>').value = '';
            document.getElementById('<%=exp_date.ClientID %>').value = '';
            document.getElementById('<%=txt_orginaldate.ClientID %>').value = '';
            document.getElementById('<%=txt_comments.ClientID %>').value = '';
            document.getElementById('<%=hfdcerti_id.ClientID %>').value = "0";
            return false;

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
        function afterpost(msg) {
            sa5.process();
            $('#btnnew_pop').dialog('close');
            altbox(msg);

        }
    </script>


    <script type="text/javascript">
        var dataIn = '';
        var sa5 = new sagrid();
        sa5.url = "../WCFGrid/GridService.svc/Bindperson_Certification";

        sa5.primarykeyval = "Cert_id";
        sa5.bindid = "grdcertification";
        
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

    <asp:UpdatePanel ID="upd1" runat="server">
        <ContentTemplate>
            <asp:HiddenField ID="hfdperid" runat="server" Value="0" />
            <asp:HiddenField ID="hfdcerti_id" runat="server" Value="0" />
            <asp:HiddenField ID="hfdselid" runat="server" Value="0" />
            <asp:Button ID="btnedit" runat="server" Style="display: none" OnClick="btnedit_click" />
            <asp:Button ID="btndel" runat="server" Style="display: none" OnClick="btndel_click" />
        </ContentTemplate>
    </asp:UpdatePanel>
    <div style="text-align: right; padding-right: 10px; margin-top: 0px">
        <input type="button" id="btnnew" value="Add New" class="poptrg" onclick="javascript: return Clear()" />
    </div>
    <br />
    <div id='btnnew_pop' class="popup" style="display: none;">
        <span class="title">Add New</span>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <table align="center" class="spac" id="frmfld">
                    <tr>
                        <td align="right">Certification Type
                        </td>
                        <td align="left">
                            <asp:DropDownList ID="ddl_certification_type" runat="server" CssClass="required" placeholder="Certification Type" error="Please select the Certification type.">
                            </asp:DropDownList>

                        </td>
                    </tr>

                    <tr>
                        <td align="right">Status
                        </td>
                        <td align="left">
                            <asp:DropDownList ID="ddl_status" runat="server" CssClass="required" placeholder="Status" error="Please select the status.">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">Effective Date
                        </td>
                        <td align="left">
                            <asp:TextBox ID="effective_date" runat="server" class="required date" placeholder="Effective Date" error="Please enter effective date."></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">Expire Date
                        </td>
                        <td align="left">
                            <asp:TextBox ID="exp_date" runat="server" class="required date" placeholder="Expire Date" error="Please enter expire date."></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">Original Date
                        </td>
                        <td align="left">
                            <asp:TextBox ID="txt_orginaldate" runat="server" CssClass="required date" error="Please enter the original date"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">Comments
                        </td>
                        <td align="left">
                            <asp:TextBox ID="txt_comments" runat="server" TextMode="MultiLine"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td align="center" colspan="2">
                            <asp:Button ID="btn_submit" runat="server" Text="Submit" OnClick="btn_submit_Click"
                                OnClientClick="javascript:return Save_Validation();" />
                            <asp:Button ID="btn_clear" runat="server" Text="Clear" OnClientClick="javascript:return Clear();" />
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    <div id="grdcertification">
    </div>

    <script type="text/javascript">
        var isedit = $('#ctl00_hfdwrite').val();
        var isdel = $('#ctl00_hfddel').val();
        if (isedit == 'False')
            $('#btnnew').addClass('hide');
        if (isedit == 'True' && isdel == 'True')
            sa5.cols = [new dcol("Certification Type", "Type"), new dcol("Status", "cStatus"), new dcol("Original Date", "Orginal_Date"), new dcol("Effective Date", "Effective_dt"), new dcol("Expiry Date", "Expiry_dt"), new dcol("Comments", "Comments"), new dcol("Edit", "", "", "1", "1", "edit_lkp", "fa fa-pencil-square-o grdicon"), new dcol("Delete", "", "", "1", "1", "Delete_lkp", "fa fa-trash-o grdicon")];
        else if (isedit == 'True')
            sa5.cols = [new dcol("Certification Type", "Type"), new dcol("Status", "cStatus"), new dcol("Original Date", "Orginal_Date"), new dcol("Effective Date", "Effective_dt"), new dcol("Expiry Date", "Expiry_dt"), new dcol("Comments", "Comments"), new dcol("Edit", "", "", "1", "1", "edit_lkp", "fa fa-pencil-square-o grdicon")];
        else if (isdel == 'True')
            sa5.cols = [new dcol("Certification Type", "Type"), new dcol("Status", "cStatus"), new dcol("Original Date", "Orginal_Date"), new dcol("Effective Date", "Effective_dt"), new dcol("Expiry Date", "Expiry_dt"), new dcol("Comments", "Comments"), new dcol("Delete", "", "", "1", "1", "Delete_lkp", "fa fa-trash-o grdicon")];
        else
            sa5.cols = [new dcol("Certification Type", "Type"), new dcol("Status", "cStatus"), new dcol("Original Date", "Orginal_Date"), new dcol("Effective Date", "Effective_dt"), new dcol("Expiry Date", "Expiry_dt"), new dcol("Comments", "Comments")];
        dataIn = '"pid":"' + document.getElementById('<%= hfdperid.ClientID %>').value + '"';
        sa5.data = dataIn;
        sa5.process();
    </script>

</asp:Content>
