﻿<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="../Master Page/frm.master" CodeBehind="Documents.aspx.cs" Inherits="Licensing.PersonLicensing.Documents" %>

<asp:Content ID="cnt1" runat="server" ContentPlaceHolderID="ContentPlaceHolder1">
    <style>
        .doctye{

            color:red;
        }
    </style>
    <script type="text/javascript">

        function Popup() {
            $(function () {
                $('#btnnew_pop1').dialog({ title: 'Edit Documents' });
                $('#btnnew_pop1').dialog("open");
            });
        }
        function Clear_Data1() {

            document.getElementById('<%=txt_com.ClientID%>').value = '';
            return false;
        }
    </script>
    <script type="text/javascript" language="javascript">
        function Clear_Data() {
            document.getElementById('<%=hfddocid.ClientID %>').value = '0';
            document.getElementById('<%=ddl_cabinet.ClientID %>').value = '-1';
            document.getElementById('<%=ddl_folder.ClientID %>').value = '-1';
            document.getElementById('<%=txt_date.ClientID %>').value = '';
            document.getElementById('<%=ddl_doctype.ClientID %>').value = '-1';
            document.getElementById('<%=chk_approval.ClientID %>').checked = false;
            document.getElementById('<%=upddocument.ClientID %>').value = "";
            document.getElementById('<%=txtdoccomments.ClientID%>').value = '';
            todaysdate();
            return false;
        }
        function Save_Validations() {
            var errormsg = validateform('frmfld');
            if (errormsg != "") {
                Msgbox(errormsg);
                return false;
            }
            return true;

        }
        function todaysdate() {

            var today = new Date();
            var dd = today.getDate();
            var mm = today.getMonth() + 1; //January is 0!

            var yyyy = today.getFullYear();
            if (dd < 10) {
                dd = '0' + dd
            }
            if (mm < 10) {
                mm = '0' + mm
            }
            var today = mm + '/' + dd + '/' + yyyy;
            document.getElementById('<%=txt_date.ClientID %>').value = today;

        }
    </script>
    <script type="text/javascript">


        var dataIn = '';
        var sa5 = new sagrid();
        sa5.url = "../WCFGrid/GridService.svc/BindPersonDocument";

        sa5.primarykeyval = "Document_ID";
        sa5.bindid = "grddocumnet1";

        sa5.objname = "sa5";
        
        sa5.aftercall = "chkdoctype";
        function chkdoctype()
        {
            var dtype = [ "Permanent Surrender","Final/Consent Order", "Final Order", "Consent Order", "Emergency Suspension", "SOC & Notice of Hearing"];
      
            $.each(sa5.resultdata, function (j, o)
            {
                 
                
                if (dtype.includes(o["Values"].trim()))
                    $('#grddocumnet1 tbody').find('tr:eq(' + j + ')').attr("Style", "color:red !important");
            });
        }
        function down_lkp(sender, keyval) {

            document.getElementById('<%= hfdselid.ClientID %>').value = keyval;
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
            document.getElementById('<%= hfdselid.ClientID %>').value = keyval;
             cnfbox(" Are you sure do you want to delete this record?", "cnffnres");
         }

         function afterpost(msg) {

             sa5.process();
             $('#btnnew_pop').dialog('close');
             $('#btnnew_pop1').dialog('close');
             altbox(msg);

         }
         function edit_lkp(sender, keyval) {

             document.getElementById('<%= hfdselid.ClientID %>').value = keyval;
            document.getElementById('<%= btnedit.ClientID %>').click();
        }
        function BindGridByUsingPersonid() {

            var chekcboxlistitems = '';
            var chk = document.getElementById('<%=chklictypes.ClientID%>');
            var chkinput = chk.getElementsByTagName('input');
            var listoflables = chk.getElementsByTagName('span')
            for (var i = 0; i < chkinput.length; i++) {
                if (chkinput[i].checked) {
                    if (chekcboxlistitems == '')
                        chekcboxlistitems = listoflables[i].attributes["app_id"].value;
                    else
                        chekcboxlistitems += ',' + listoflables[i].attributes["app_id"].value;
                }
            }
            dataIn = '"pid":"' + document.getElementById('<%= hfdperid.ClientID %>').value + '",';
            dataIn = dataIn + '"utype":"' + document.getElementById('<%= hfdutype.ClientID %>').value + '",';

            dataIn = dataIn + '"appid":"'+chekcboxlistitems+'"';

            sa5.data = dataIn;
            sa5.process();
        }
    </script>
    <asp:UpdatePanel ID="upd" runat="server">
        <ContentTemplate>
            <asp:HiddenField ID="hfddocid" runat="server" Value="0" />
            <asp:HiddenField ID="hfdperid" runat="server" Value="0" />
            <asp:HiddenField ID="hfdutype" runat="server" Value="0" />
            <asp:HiddenField ID="hfdselid" runat="server" Value="0" />
            <asp:Button ID="btnedit" runat="server" Style="display: none" OnClick="btnedit_click" />
            <asp:Button ID="btndel" runat="server" Style="display: none" OnClick="btndel_click" />
        </ContentTemplate>
    </asp:UpdatePanel>
    <div>

        <div style="text-align: right; padding-right: 10px; margin-top: 0px">
            <input type="button" id="btnnew" value="Add New" class="poptrg" onclick="javascript: return Clear_Data()" />
        </div>
        <div style="text-align: right; padding-right: 110px; margin-top: -25px">
            <button id="btndownloadall" onserverclick="btndownloadall_ServerClick" style="background: #1d6e99 !important; border-radius: 4px; transition-duration: .2s; transition-timing-function: linear; border: 1px solid #666; transition-property: background, border-radius; color: white" runat="server" title="Downlaod">Download All Files <i class="fa fa-download"></i></button>
        </div>
        <br />
        <br />
         <div style="text-align:center">
           <center> <asp:CheckBoxList ID="chklictypes" runat="server" RepeatDirection="Horizontal" onclick="javascript:return BindGridByUsingPersonid();"></asp:CheckBoxList></center>
        </div><br />
        <div id='btnnew_pop' class="popup" style="display: none;">
            <span class="title">Add New Document</span>

            <table align="center" id="frmfld" class="spac">
                <tr id="lictype" runat="server">
                    <td align="right">License Type
                    </td>
                    <td align="left">
                        <asp:DropDownList ID="ddl_licensetype" runat="server">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr class="hide">
                    <td align="right" width="35%">Cabinet  
                    </td>
                    <td align="left">
                        <asp:DropDownList ID="ddl_cabinet" runat="server">
                        </asp:DropDownList>

                    </td>
                </tr>
                <tr class="hide">
                    <td align="right">Folder  
                    </td>
                    <td align="left">
                        <asp:DropDownList ID="ddl_folder" runat="server">
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
                    <td align="right">Doc Type  
                    </td>
                    <td align="left">
                        <asp:DropDownList ID="ddl_doctype" runat="server" CssClass="required" error="Please select the doc type.">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td align="right">Comments 
                    </td>
                    <td align="left">
                        <asp:TextBox ID="txtdoccomments" runat="server" TextMode="MultiLine" Height="50px" Width="200px"></asp:TextBox>
                    </td>
                </tr>
                <tr class="hide">
                    <td align="center" colspan="2">
                        <asp:CheckBox ID="chk_approval" runat="server" Text="Approval Needed" />
                    </td>
                </tr>

                <tr>
                    <td align="center" colspan="2">
                        <asp:Button ID="btn_submit" runat="server" Text="Submit" OnClick="btn_submit_Click" OnClientClick="javascript:return Save_Validations();" />
                        <asp:Button ID="btn_clear" runat="server" Text="Clear" OnClientClick="javascript:return Clear_Data();" />
                    </td>
                </tr>
            </table>

        </div>

    </div>
    <div id='btnnew_pop1' class="popup" style="display: none;">
        <span class="title">Edit Document</span>
        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
            <ContentTemplate>
                <table align="center" id="frmfld1" class="spac">
                    <tr>
                        <td align="right">License Type
                        </td>
                        <td align="left">
                            <asp:DropDownList ID="ddl_lictypeedit" runat="server">
                            </asp:DropDownList>
                        </td>
                    </tr>
                     <tr>
                        <td align="right">Document Type
                        </td>
                        <td align="left">
                            <asp:DropDownList ID="ddl_doctypeedit" runat="server">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">Comments 
                        </td>
                        <td align="left">
                            <asp:TextBox ID="txt_com" runat="server" TextMode="MultiLine" Height="50px" Width="200px"></asp:TextBox>
                        </td>
                    </tr>


                    <tr>
                        <td align="center" colspan="2">
                            <asp:Button ID="btn_submit1" runat="server" Text="Submit" OnClick="btn_submit1_Click" />
                            <asp:Button ID="btn_clear1" runat="server" Text="Clear" OnClientClick="javascript:return Clear_Data1();" />
                        </td>
                    </tr>
                </table>

            </ContentTemplate>
        </asp:UpdatePanel>
    </div>

    <div id="grddocumnet1"></div>
    <script type="text/javascript">
        var isedit = $('#ctl00_hfdwrite').val();
        var isdel = $('#ctl00_hfddel').val();
        if (isedit == 'False')
            $('#btnnew').addClass('hide');
        if (isedit == 'True' && isdel == 'True') {
            if (document.getElementById('<%=hfdutype.ClientID%>').value == "1")
                sa5.cols = [new dcol("Date", "Document_Date"), new dcol("License Type", "LiceseType"), new dcol("Document Type", "Values"), new dcol("Download", "", "", "1", "1", "down_lkp", "fa fa-download grdicon"), new dcol("File Name", "Description"), new dcol("Edit", "", "", "1", "1", "edit_lkp", "fa fa-pencil-square-o grdicon"), new dcol("Comments", "Comments"), new dcol("User", "UserName"), new dcol("Delete", "", "", "1", "1", "Delete_lkp", "fa fa-trash-o grdicon")];

            else
                sa5.cols = [new dcol("Date", "Document_Date"), new dcol("Document Type", "Values"), new dcol("Download", "", "", "1", "1", "down_lkp", "fa fa-download grdicon"), new dcol("File Name", "Description"), new dcol("Edit", "", "", "1", "1", "edit_lkp", "fa fa-pencil-square-o grdicon"), new dcol("Comments", "Comments"), new dcol("User", "UserName"), new dcol("Delete", "", "", "1", "1", "Delete_lkp", "fa fa-trash-o grdicon")];
        }
        else if (isedit == 'True') {
            if (document.getElementById('<%=hfdutype.ClientID%>').value == "1")
                sa5.cols = [new dcol("Date", "Document_Date"), new dcol("License Type", "LiceseType"), new dcol("Document Type", "Values"), new dcol("Download", "", "", "1", "1", "down_lkp", "fa fa-download grdicon"), new dcol("File Name", "Description"), new dcol("Edit", "", "", "1", "1", "edit_lkp", "fa fa-pencil-square-o grdicon"), new dcol("Comments", "Comments"), new dcol("User", "UserName")];

            else
                sa5.cols = [new dcol("Date", "Document_Date"), new dcol("Document Type", "Values"), new dcol("Download", "", "", "1", "1", "down_lkp", "fa fa-download grdicon"), new dcol("File Name", "Description"), new dcol("Edit", "", "", "1", "1", "edit_lkp", "fa fa-pencil-square-o grdicon"), new dcol("Comments", "Comments"), new dcol("User", "UserName")];
        }
        else if (isdel == 'True') {
            if (document.getElementById('<%=hfdutype.ClientID%>').value == "1")
                sa5.cols = [new dcol("Date", "Document_Date"), new dcol("License Type", "LiceseType"), new dcol("Document Type", "Values"), new dcol("Download", "", "", "1", "1", "down_lkp", "fa fa-download grdicon"), new dcol("File Name", "Description"),new dcol("Comments", "Comments"), new dcol("User", "UserName"), new dcol("Delete", "", "", "1", "1", "Delete_lkp", "fa fa-trash-o grdicon")];

            else
                sa5.cols = [new dcol("Date", "Document_Date"), new dcol("Document Type", "Values"), new dcol("Download", "", "", "1", "1", "down_lkp", "fa fa-download grdicon"), new dcol("File Name", "Description"), new dcol("Comments", "Comments"), new dcol("User", "UserName"), new dcol("Delete", "", "", "1", "1", "Delete_lkp", "fa fa-trash-o grdicon")];
        }
        else
        {
            if (document.getElementById('<%=hfdutype.ClientID%>').value == "1")
                sa5.cols = [new dcol("Date", "Document_Date"), new dcol("License Type", "LiceseType"), new dcol("Document Type", "Values"), new dcol("Download", "", "", "1", "1", "down_lkp", "fa fa-download grdicon"), new dcol("File Name", "Description"), new dcol("Comments", "Comments"), new dcol("User", "UserName")];

            else
                sa5.cols = [new dcol("Date", "Document_Date"), new dcol("Document Type", "Values"), new dcol("Download", "", "", "1", "1", "down_lkp", "fa fa-download grdicon"), new dcol("File Name", "Description"), new dcol("Comments", "Comments"), new dcol("User", "UserName")];
        }
        dataIn = '"pid":"' + document.getElementById('<%= hfdperid.ClientID %>').value + '",';
       dataIn = dataIn + '"utype":"' + document.getElementById('<%= hfdutype.ClientID %>').value + '",';
       
        dataIn = dataIn + '"appid":""';

       
        sa5.data = dataIn;
        sa5.process();
    </script>
</asp:Content>

