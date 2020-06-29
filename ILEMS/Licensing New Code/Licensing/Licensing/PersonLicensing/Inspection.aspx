<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Master Page/frm.Master"
    CodeBehind="Inspection.aspx.cs" Inherits="Licensing.PersonLicensing.Inspection" %>

<asp:Content ID="content1" runat="server" ContentPlaceHolderID="ContentPlaceHolder1">
    <script type="text/javascript">
        var dataIn = '';
        var insp = new sagrid();
        insp.url = "../WCFGrid/GridService.svc/BindInspectionDetails";

        insp.primarykeyval = "Inspection_JournalID";
        insp.bindid = "grdinspection";
        
        insp.objname = "insp";
        insp.process();

        function edit_lkp1(sender, keyval) {

            document.getElementById('<%= hfdinsid.ClientID %>').value = keyval;

            document.getElementById('<%= btnedit.ClientID %>').click();
        }
        function Delete_lkp2(sender, keyval) {
            document.getElementById('<%= hfdinsid.ClientID %>').value = keyval;
             cnfbox(" Are you sure do you want to delete this record?", "cnffnres2");
        }
        function cnffnres2(result) {
            if (result == 'true')
                document.getElementById('<%= btndelinsp.ClientID %>').click();
        }
        function Popup() {
            $(function () {
                $('#btnaddnew_pop').dialog({ title: 'Edit Inspection' });
                $('#btnaddnew_pop').dialog("open");
            });
        }
        function Popup1() {
            $(function () {
                $('#btnnew_pop').dialog({ title: 'Edit Document' });
                $('#btnnew_pop').dialog("open");
            });
        }
        function Popup2() {
            $(function () {
                $('#btninsjournal_pop').dialog({ title: 'Edit inspection Journal',width:'90%' });
                $('#btninsjournal_pop').dialog("open");
            });
        }
    </script>
    <script type="text/javascript">
        var dataIn = '';
        var sub = new sagrid();
        sub.url = "../WCFGrid/GridService.svc/BindInspectionjournal";

        sub.primarykeyval = "InspectionJournal_ID";
        sub.bindid = "grdinspjournaldetails";
        
        sub.objname = "sub";
        function edit_lkp2(sender, keyval) {

            document.getElementById('<%= hfdinsjournal.ClientID %>').value = keyval;
            document.getElementById('<%= btneditjournal.ClientID %>').click();
        }
        function cnffnres1(result) {
            if (result == 'true')
                document.getElementById('<%= btndeljournal.ClientID %>').click();
        }
        function Delete_lkp1(sender, keyval) {
            document.getElementById('<%= hfdinsjournal.ClientID %>').value = keyval;
            cnfbox(" Are you sure do you want to delete this record?", "cnffnres1");
        }
    </script>
    <script type="text/javascript">
        var dataIn = '';
        var sa5 = new sagrid();
        sa5.url = "../WCFGrid/GridService.svc/BindPersonDocument";

        sa5.primarykeyval = "Document_ID";
        sa5.bindid = "grdinspectiondocumnets";
        
        sa5.objname = "sa5";
        sa5.process();
        function down_lkp(sender, keyval) {

            document.getElementById('<%= hfdinsid.ClientID %>').value = keyval;
            var fname = sa5.resultdata[sender]["docpath"];

            if (fname != '') {
                window.open(fname);
            }
            else {
                altbox('Sorry no file attached.');
            }
        }
        function cnffnres(result) {
            if (result == 'true')
                document.getElementById('<%= btndel.ClientID %>').click();
        }

        function Delete_lkp(sender, keyval) {
            document.getElementById('<%= hfdinsid.ClientID %>').value = keyval;
            cnfbox(" Are you sure do you want to delete this record?", "cnffnres");
        }
    </script>
    <script type="text/javascript">
        function Clear_Data() {
            document.getElementById('<%=hfddocid.ClientID %>').value = '0';
            document.getElementById('<%=ddl_cabinet.ClientID %>').value = '-1';
            document.getElementById('<%=ddl_folder.ClientID %>').value = '-1';
            document.getElementById('<%=txt_date.ClientID %>').value = "";
            document.getElementById('<%=ddl_doctype.ClientID %>').value = '-1';
            document.getElementById('<%=chk_approval.ClientID %>').checked = false;
            document.getElementById('<%=upddocument.ClientID %>').value = "";
        }
        function Save_Validations() {
            var errormsg = validateform('frmfld');
            if (errormsg != "") {
                Msgbox(errormsg);
                return false;
            }
            return true;

        }
        function Clearjournal() {
            document.getElementById('<%=txt_journalcomments.ClientID %>').value = '';
            document.getElementById('<%=ddlJournalType.ClientID %>').value = '-1';
            document.getElementById('<%=hfdinsjournal.ClientID %>').value = "0";
            return false;

        }

        function Save_JournalValidation() {
            var errormsg = validateform('frmfld1');
            if (errormsg != "") {
                Msgbox(errormsg);
                return false;
            }
            return true;
        }
        function Save_Validation() {
            var errormsg = validateform('frmfld3');
            if (errormsg != "") {
                Msgbox(errormsg);
                return false;
            }
            return true;
        }
        function afterpost(msg) {
            insp.process();
            sa5.process();
            sub.process();
            $('#btninsjournal_pop').dialog("close");
            $('#btnaddnew_pop').dialog("close");
            $('#btnnew_pop').dialog('close');
            altbox(msg);
        }
        function AddNewClear() {
            document.getElementById('<%=hfdselid.ClientID%>').value = "0";
            document.getElementById('<%=ddl_instype.ClientID%>').value = "-1";
            document.getElementById('<%=ddlstatus.ClientID%>').value = "-1";
            document.getElementById('<%=txtinspectiondate.ClientID%>').value = "";
            document.getElementById('<%=txtinsscope.ClientID%>').value = "";
            document.getElementById('<%=ddlstaff.ClientID%>').value = "-1";
            document.getElementById('<%=txtdescription.ClientID%>').value = "";
            return false;
        }
    </script>
    <asp:UpdatePanel ID="upd1" runat="server">
        <ContentTemplate>
            <asp:HiddenField ID="hfdpid" runat="server" Value="0" />
            <asp:HiddenField ID="hfdinsid" runat="server" Value="0" />
            <asp:HiddenField ID="hfdutype" runat="server" Value="0" />
            <asp:HiddenField ID="hfdselid" runat="server" Value="0" />
            <asp:HiddenField ID="hfddocid" runat="server" Value="0" />
            <asp:Button ID="btnedit" runat="server" Style="display: none;" OnClick="btnedit_click" />
            <asp:Button ID="btndel" runat="server" Style="display: none;" OnClick="btndel_click" />
        </ContentTemplate>
    </asp:UpdatePanel>
    <br />
    <div style="width: 98%; margin-left: auto; margin-right: auto">
        <div class="cpanel">
            <div class="head accr expand">
                Inspection Details
            </div>
            <div class="body">
                 <div style="text-align: right; padding-right: 10px; margin-top: 0px">
                    <input type="button" id="btnaddnew" value="Add New" class="poptrg" onclick="javascript: return AddNewClear()" />
                </div>
                <br />
                <div id="grdinspection">
                </div>
            </div>
        </div>
    </div>
    <div style="width: 98%; margin-left: auto; margin-right: auto;">
        <div class="cpanel">
            <div class="head accr">
                Documents
            </div>
            <div class="body">
                <div style="text-align: right; padding-right: 10px; margin-top: 0px">
                    <input type="button" id="btnnew" value="Add New" class="poptrg" onclick="javascript: return Clear_Data()" />
                </div>
                <br />
                <div id="grdinspectiondocumnets">
                </div>
            </div>
        </div>
    </div>
    <div style="width: 98%; margin-left: auto; margin-right: auto;">
        <div class="cpanel">
            <div class="head accr">
                Inspection Journals</div>
            <div class="body">
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <asp:HiddenField ID="hfdinsjournal" runat="server" Value="0" />
                        <asp:Button ID="btneditjournal" runat="server" Style="display: none" OnClick="btneditjournal_click" />
                        <asp:Button ID="btndeljournal" runat="server" Style="display: none" OnClick="btndeljournal_click" />
                        <asp:Button ID="btndelinsp" runat="server" style="display:none;" OnClick="btndelinsp_Click" />
                    </ContentTemplate>
                </asp:UpdatePanel>
                <div style="text-align: right; padding-right: 10px; margin-top: 0px">
                    <input type="button" id="btninsjournal" value="Add New" class="poptrg" onclick="javascript: return Clearjournal();" />
                </div>
                <br />
                <div id="grdinspjournaldetails">
                </div>
            </div>
        </div>
    </div>
    <div id='btnnew_pop' class="popup" style="display: none;">
        <span class="title">Add New Document</span>
        
                <table align="center" id="frmfld" class="spac">
                    <tr>
                        <td align="right" width="35%">
                            Cabinet
                        </td>
                        <td align="left">
                            <asp:DropDownList ID="ddl_cabinet" runat="server" CssClass="required" error="Please select the cabinet.">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            Folder
                        </td>
                        <td align="left">
                            <asp:DropDownList ID="ddl_folder" runat="server" CssClass="required" error="Please select the folder.">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            Upload
                        </td>
                        <td align="left">
                            <asp:FileUpload ID="upddocument" runat="server" class="required " error="Please select the upload." />
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            Date
                        </td>
                        <td align="left">
                            <asp:TextBox ID="txt_date" runat="server" class="required date" error="Please select the date."></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            Doc Type
                        </td>
                        <td align="left">
                            <asp:DropDownList ID="ddl_doctype" runat="server" CssClass="required" error="Please select the doc type.">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td align="center" colspan="2">
                            <asp:CheckBox ID="chk_approval" runat="server" Text="Approval Needed" />
                        </td>
                    </tr>
                    <tr>
                        <td align="center" colspan="2">
                            <asp:Button ID="btn_submit" runat="server" Text="Submit" OnClick="btn_submit_Click"
                                OnClientClick="javascript:return Save_Validations();" />
                            <asp:Button ID="btn_clear" runat="server" Text="Clear" OnClientClick="javascript:return Clear_Data();" />
                        </td>
                    </tr>
                </table>
           
    </div>
    <div id="btnaddnew_pop" class="popup" style="display: none;">
        <span class="title">Add New Inspection</span>
        <asp:UpdatePanel ID="upd2" runat="server">
            <ContentTemplate>
                <table align="center" class="spac" id="frmfld3">
                    <tr>
                        <td align="right">
                            Inspection Type
                        </td>
                        <td align="left">
                            <asp:DropDownList ID="ddl_instype" runat="server" CssClass="required" error="Please select inspection type.">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            Inspection Status
                        </td>
                        <td align="left">
                            <asp:DropDownList ID="ddlstatus" runat="server" CssClass="required" error="Please select inspection status.">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            Inspection Date
                        </td>
                        <td align="left">
                            <asp:TextBox ID="txtinspectiondate" runat="server" CssClass="required date" error="Please enter inspection date."></asp:TextBox>
                        </td>
                    </tr>
                    <tr style="display: none;">
                        <td align="right">
                            Inspection Scope
                        </td>
                        <td align="left">
                            <asp:TextBox ID="txtinsscope" runat="server" ></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            Staff Assigned
                        </td>
                        <td align="left">
                            <asp:DropDownList ID="ddlstaff" runat="server" CssClass="required" error="Please select staff assigned.">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            Description
                        </td>
                        <td align="left">
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <asp:TextBox ID="txtdescription" runat="server" Width="400px" Height="50px" TextMode="MultiLine"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" align="center">
                            <asp:Button ID="btnsubmit" runat="server" Text="Submit" OnClick="btnsubmit_Click" OnClientClick="javascript:return Save_Validation();"/>
                            <asp:Button ID="btnclear" runat="server" Text="Clear" OnClientClick="javascript:return AddNewClear();"/>
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    <div id='btninsjournal_pop' class="popup" style="display: none;width:60%;">
        <span class="title">Add New Journal</span>
        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
            <ContentTemplate>
                <table align="center" class="spac" id="frmfld1">
                    <tr>
                        <td align="right">
                            Type
                        </td>
                        <td align="left">
                            <asp:DropDownList ID="ddlJournalType" CssClass="required" error="Please select journal type."
                                runat="server">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            Comments
                        </td>
                        <td align="left">
                            <asp:TextBox ID="txt_journalcomments" CssClass="required" error="Please enter comments."
                                placeholder="Comment" runat="server" Width="98%" Height="50" TextMode="MultiLine"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td align="center" colspan="2">
                            <asp:Button ID="btn_addinspectionjournal" runat="server" Text="Submit" OnClick="btn_addinspectionjournal_Click"
                                OnClientClick="javascript:return Save_JournalValidation();" />
                            <asp:Button ID="btn_clear1" runat="server" Text="Clear" OnClientClick="javascript:return Clearjournal();" />
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    <script type="text/javascript">
        var isedit = $('#ctl00_hfdwrite').val();
        var isdel = $('#ctl00_hfddel').val();
        if (isedit == 'False') {
            $('#btnaddnew').addClass('hide');
            $('#btnnew').addClass('hide');
            $('#btninsjournal').addClass('hide');
        }
        if (isedit == 'True' && isdel == 'True') {
            insp.cols = [new dcol("Type", "Inspection_Type"), new dcol("Status", "Inspection_Status"), new dcol("Inspection Date", "Inspection_Date"), new dcol("StaffAssigned", "UserName"), new dcol("Description", "Description"), new dcol("Edit", "", "", "1", "1", "edit_lkp1", "fa fa-pencil-square-o grdicon"), new dcol("Delete", "", "", "1", "1", "Delete_lkp2", "fa fa-trash-o grdicon")];
            sub.cols = [new dcol("Journal Type", "Journal_Type"), new dcol("Comments", "Comments"), new dcol("Created Date", "CreatedDate"), new dcol("Created By", "cUser"), new dcol("Edit", "", "", "1", "1", "edit_lkp2", "fa fa-pencil-square-o grdicon"), new dcol("Delete", "", "", "1", "1", "Delete_lkp1", "fa fa-trash-o grdicon")];
            sa5.cols = [new dcol("Date", "Document_Date"), new dcol("Document Type", "Values"), new dcol("File Name", "Description"), new dcol("User", "UserName"), new dcol("Download", "", "", "1", "1", "down_lkp", "fa fa-download grdicon"), new dcol("Delete", "", "", "1", "1", "Delete_lkp", "fa fa-trash-o grdicon")];
        }
        else if (isedit == 'True') {
            insp.cols = [new dcol("Type", "Inspection_Type"), new dcol("Status", "Inspection_Status"), new dcol("Inspection Date", "Inspection_Date"), new dcol("StaffAssigned", "UserName"), new dcol("Description", "Description"), new dcol("Edit", "", "", "1", "1", "edit_lkp1", "fa fa-pencil-square-o grdicon")];
            sub.cols = [new dcol("Journal Type", "Journal_Type"), new dcol("Comments", "Comments"), new dcol("Created Date", "CreatedDate"), new dcol("Created By", "cUser"), new dcol("Edit", "", "", "1", "1", "edit_lkp2", "fa fa-pencil-square-o grdicon")];
            sa5.cols = [new dcol("Date", "Document_Date"), new dcol("Document Type", "Values"), new dcol("File Name", "Description"), new dcol("User", "UserName"), new dcol("Download", "", "", "1", "1", "down_lkp", "fa fa-download grdicon")];
        }
        else if (isdel == 'True') {
            insp.cols = [new dcol("Type", "Inspection_Type"), new dcol("Status", "Inspection_Status"), new dcol("Inspection Date", "Inspection_Date"), new dcol("StaffAssigned", "UserName"), new dcol("Description", "Description"), new dcol("Delete", "", "", "1", "1", "Delete_lkp2", "fa fa-trash-o grdicon")];
            sub.cols = [new dcol("Journal Type", "Journal_Type"), new dcol("Comments", "Comments"), new dcol("Created Date", "CreatedDate"), new dcol("Created By", "cUser"),  new dcol("Delete", "", "", "1", "1", "Delete_lkp1", "fa fa-trash-o grdicon")];
            sa5.cols = [new dcol("Date", "Document_Date"), new dcol("Document Type", "Values"), new dcol("File Name", "Description"), new dcol("User", "UserName"), new dcol("Download", "", "", "1", "1", "down_lkp", "fa fa-download grdicon"), new dcol("Delete", "", "", "1", "1", "Delete_lkp", "fa fa-trash-o grdicon")];
        }
        else
        {
            insp.cols = [new dcol("Type", "Inspection_Type"), new dcol("Status", "Inspection_Status"), new dcol("Inspection Date", "Inspection_Date"), new dcol("StaffAssigned", "UserName"), new dcol("Description", "Description")];
            sub.cols = [new dcol("Journal Type", "Journal_Type"), new dcol("Comments", "Comments"), new dcol("Created Date", "CreatedDate"), new dcol("Created By", "cUser")];
            sa5.cols = [new dcol("Date", "Document_Date"), new dcol("Document Type", "Values"), new dcol("File Name", "Description"), new dcol("User", "UserName"), new dcol("Download", "", "", "1", "1", "down_lkp", "fa fa-download grdicon")];
        }
    </script>
    <script type="text/javascript">

        dataIn = '"pid":"' + document.getElementById('<%= hfdpid.ClientID %>').value + '"';
        insp.data = dataIn;
        insp.process();
    </script>
    <script type="text/javascript">

        dataIn = '"pid":"' + document.getElementById('<%= hfdpid.ClientID %>').value + '",';
        dataIn = dataIn + '"utype":"' + 3 + '"';

        sa5.data = dataIn;
        sa5.process();
    </script>
    <script type="text/javascript">

        dataIn = '"pid":"' + document.getElementById('<%= hfdpid.ClientID %>').value + '"';
        sub.data = dataIn;
        sub.process();
    </script>
</asp:Content>
