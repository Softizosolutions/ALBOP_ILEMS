<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Specialties.aspx.cs" MasterPageFile="~/Master Page/frm.Master" Inherits="Licensing.PersonLicensing.Specialties" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script>
        var dataIn = '';
        var sa5 = new sagrid();
        sa5.url = "../WCFGrid/GridService.svc/BindPersonSpecialityDocument";
        sa5.primarykeyval = "Document_ID";
        sa5.bindid = "grdinspectiondocumnets";
        sa5.objname = "sa5";

        sa5.cols = [new dcol("Date", "Document_Date"), new dcol("Document Type", "Values"), new dcol("File Name", "Description"), new dcol("Download", "", "", "1", "1", "down_lkp", "fa fa-download grdicon"), new dcol("Edit", "", "", "1", "1", "edit_lkp1", "fa fa-pencil-square-o grdicon"), new dcol("Delete", "", "", "1", "1", "Delete_lkp", "fa fa-trash-o grdicon")];


        // sa5.process();
        function afterpost(msg) {
            altbox(msg);
            parent.window.location.reload(true);
        }
        function afterpost1(msg) {
            altbox(msg);
         
            $('#btnnew_pop1').dialog("close");
            sa5.process();

        }
        function Save_Validations() {
            var errormsg = validateform('frmfld');
            if (errormsg != "") {
                Msgbox(errormsg);
                return false;
            }
            return true;

        }

        function Save_ValidationsSpecialityedit() {
            var errormsg = validateform('frmfld1');
            if (errormsg != "") {
                Msgbox(errormsg);
                return false;
            }
            return true;

        }

        function Delete_lkp(sender, keyval) {
            document.getElementById('<%= hfdinsid.ClientID %>').value = keyval;
            cnfbox(" Are you sure do you want to delete this record?", "cnffnres");
        }
        function cnffnres(result) {
            if (result == 'true')
                document.getElementById('<%= btndel.ClientID %>').click();
         }
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
        function edit_lkp1(sender, keyval) {

            document.getElementById('<%= hfdinsid.ClientID %>').value = keyval;

               document.getElementById('<%= btnedit.ClientID %>').click();
           }
           function Popup() {
               $(function () {
                   $('#btnnew_pop1').dialog({ title: 'Edit Exam' });
                   $('#btnnew_pop1').dialog("open");
                 
               });
           }

         function Clear_Data() {
            document.getElementById('<%=hfddocid.ClientID %>').value = '0';           
            document.getElementById('<%=txt_date.ClientID %>').value = "";
            document.getElementById('<%=ddl_doctype.ClientID %>').value = '-1';           
            document.getElementById('<%=upddocument.ClientID %>').value = "";
         }
            function Clear_Data1() {

                document.getElementById('<%=txt_editDate.ClientID%>').value = '';
                 document.getElementById('<%=ddl_Doctypeedit.ClientID%>').value = '-1';
            return false;
        }
    </script>

    <asp:UpdatePanel ID="upd2" runat="server">
        <ContentTemplate>
            <asp:HiddenField ID="hfd_chkid" Value="0" runat="server" />
            <asp:HiddenField ID="hfdperid" Value="0" runat="server" />
            <asp:HiddenField ID="hfddocid" runat="server" Value="0" />
            <asp:HiddenField ID="hfdinsid" runat="server" Value="0" />
            <asp:Button ID="btndel" runat="server" Style="display: none;" OnClick="btndel_Click" />
            <asp:Button ID="btnedit" runat="server" Style="display: none;" OnClick="btnedit_Click" />
        </ContentTemplate>
    </asp:UpdatePanel>

    <br />

    <table style="text-align: center; padding-left: 50px;" cellpadding="10" cellspacing="10">

        <tr>
            <td align="left" style="padding-left: 550px">
                <asp:CheckBox Text="Drug Collector" runat="server" ID="drugcollect" />
            </td>
        </tr>
        <tr>
            <td align="left" style="padding-left: 550px">
                <asp:CheckBox Text="Parenteral" runat="server" ID="txtparent" />
            </td>
        </tr>
        <tr>
            <td align="left" style="padding-left: 550px">
                <asp:CheckBox Text="Nuclear" runat="server" ID="txtnuclear" />
            </td>
        </tr>
        <tr>
            <td align="left" style="padding-left: 550px">
                <asp:CheckBox Text="Remote Order Entry" runat="server" ID="txtremorder" />
            </td>
        </tr>
        <tr>
            <td align="left" style="padding-left: 550px">
                <asp:CheckBox Text="Non-Pharmacy Key Holder" runat="server" ID="txtnonpharmacy" />
            </td>
        </tr>



        <tr>
            <td colspan="2" style="padding-left: 550px">
                <br />
                <asp:Button ID="btn_submit" runat="server" Text="Save" OnClientClick="javascript:return Save_Validation()" OnClick="btn_submit_Click1" />&nbsp;&nbsp;
            </td>
        </tr>
    </table>

    <div style="width: 98%; margin-left: auto; margin-right: auto;">
        <div class="cpanel ">
            <div class="head expand accr">
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

    <div id='btnnew_pop' class="popup" style="display: none;">
        <span class="title">Add New Document</span>
       
        <table align="center" id="frmfld" class="spac">
            <tr>
                <td align="right">Doc Type
                </td>
                <td align="left">
                    <asp:DropDownList ID="ddl_doctype" runat="server" CssClass="required" error="Please select the doc type.">
                    </asp:DropDownList>
                </td>
            </tr>

            <tr>
                <td align="right">Upload
                </td>
                <td align="left">
                    <asp:FileUpload ID="upddocument" runat="server" class="required " error="Please select the upload." />
                </td>
            </tr>
            <tr>
                <td align="right">Date
                </td>
                <td align="left">
                    <asp:TextBox ID="txt_date" runat="server" class="required date" error="Please select the date."></asp:TextBox>
                </td>
            </tr>


            <tr>
                <td align="center" colspan="2">
                    <asp:Button ID="btn_upload" runat="server" Text="Submit" OnClick="btn_upload_Click"
                        OnClientClick="javascript:return Save_Validations();" />
                    <asp:Button ID="btn_clear" runat="server" Text="Clear" OnClientClick="javascript:return Clear_Data();" />
                </td>
            </tr>
        </table>
   
    </div>
    <div id='btnnew_pop1' class="popup" style="display: none;">
        <span class="title">Edit Document</span>
        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
            <ContentTemplate>
                <table align="center" id="frmfld1" class="spac">
                    <tr>
                        <td align="right">Speciality Type
                        </td>
                        <td align="left">
                            <asp:DropDownList ID="ddl_Doctypeedit" runat="server" class="required" error="Please select the Speciality Type.">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr style="display:none">
                        <td align="right">Upload
                        </td>
                        <td align="left">
                            <asp:FileUpload ID="upl_editdoc" runat="server" class=" " error="Please select the upload." />
                        </td>
                    </tr>
                    <tr>
                        <td align="right">Date
                        </td>
                        <td align="left">
                            <asp:TextBox ID="txt_editDate" runat="server" class="required date" error="Please select the date."></asp:TextBox>
                        </td>
                    </tr>


                    <tr>
                        <td align="center" colspan="2">
                            <asp:Button ID="btn_submit1" runat="server" Text="Submit" OnClientClick="javascript:return Save_ValidationsSpecialityedit();" OnClick="btn_submit1_Click" />
                            <asp:Button ID="btn_clear1" runat="server" Text="Clear" OnClientClick="javascript:return Clear_Data1();" />
                        </td>
                    </tr>
                </table>

            </ContentTemplate>
        </asp:UpdatePanel>
    </div>

    <script type="text/javascript">

        dataIn = '"pid":"' + document.getElementById('<%= hfdperid.ClientID %>').value + '"';
        sa5.data = dataIn;
        sa5.process();
    </script>
</asp:Content>
