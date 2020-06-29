<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Administration/Admin.Master" CodeBehind="DisciplinaryFiles.aspx.cs" Inherits="Licensing.Administration.DisciplinaryFiles" %>

<asp:Content ID="cnt" ContentPlaceHolderID="cntmain" runat="server">
    <script type="text/javascript">
        var dataIn = '';
        var sa5 = new sagrid();
        sa5.url = "../WCFGrid/GridService.svc/BindUploadDisciplinaryFiles";

        sa5.primarykeyval = "DisciplinaryFindingsID";
        sa5.bindid = "grdUploads";
        sa5.cols = [new dcol("File Name", "Filename"),
                    //new dcol("File Path", "DocumentPath"),
                    new dcol("Uploaded By", "UserName"),
                    new dcol("Uploaded Date", "CreatedDate"),
                    new dcol("Download", "", "", "1", "1", "down_lkp", "fa fa-download grdicon"),
                    new dcol("Delete", "", "", "1", "1", "Delete_lkp", "fa fa-trash-o grdicon")];
        sa5.objname = "sa5";
        sa5.data = dataIn;
        sa5.process();

        function down_lkp(sender, keyval) {

            document.getElementById('<%= hfddocid.ClientID %>').value = keyval;
            var fname = sa5.resultdata[sender]["DocumentPath"];

            if (fname != '') {
                window.open(fname);
            }
            else {
                altbox('Sorry no file attached.');
            }
        }
        function Delete_lkp(sender, keyval) {
            document.getElementById('<%= hfddocid.ClientID %>').value = keyval;
            cnfbox(" Are you sure do you want to delete this record?", "cnffnres");
        }
        function cnffnres(result) {
            if (result == 'true')
                document.getElementById('<%= btndel.ClientID %>').click();
        }
        function afterpost(msg) {
            sa5.process();
            altbox(msg);

        }
        function Save_Validation() {
            var errormsg = validateform('frmfld');
            if (errormsg != "") {
                Msgbox(errormsg);
                return false;
            }
            return true;
        }
    </script>
    <asp:UpdatePanel ID="upd" runat="server">
        <ContentTemplate>
            <asp:HiddenField ID="hfddocid" runat="server" Value="0" />
            <asp:Button ID="btndel" runat="server" Style="display: none" OnClick="btndel_click" />
        </ContentTemplate>
    </asp:UpdatePanel>
    <div class="cpanel">
        <div class="head">
            Disciplinary Files  
        </div>
        <div class="body">

            <table align="center" id="frmfld" class="spac">
                <tr align="center">
                    <td align="right"><span style="width: 80px;"><b>File Name  :</b></span>
                    </td>
                    <td align="left">
                        <asp:TextBox ID="txtFileName" runat="server" class="required " error="Please Enter File Name." /> 
                    </td>
                </tr>
                <tr align="center">
                    <td align="right"><span style="width: 80px;"><b>Upload  :</b></span>
                    </td>
                    <td align="left">
                        <asp:FileUpload ID="upddocument" runat="server" class="required " error="Please Upload File." />

                    </td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                </tr>
                <tr align="center">
                    <td colspan="2">
                        <asp:Button ID="btnUpload" runat="server" Text="Submit" OnClick="btnUpload_Click" OnClientClick="javascript:return Save_Validation();" />
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
            <div id="grdUploads"></div>
        </div>
    </div>
    <script type="text/javascript">
        
    </script>
</asp:Content>
