<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Master Page/frm.Master" CodeBehind="Wellness.aspx.cs" Inherits="Licensing.PersonLicensing.Wellness" %>

<asp:Content ID="content1" runat="server" ContentPlaceHolderID="ContentPlaceHolder1">
    <style type="text/css">
        #save_dig .process {
            color: #ee0000;
        }

        #save_dig .complete {
            color: green;
        }
    </style>
    <script type="text/javascript">
        function Popup() {
            $(function () {
                $('#btnnew_pop').dialog({ title: 'Edit Document' });
                $('#btnnew_pop').dialog("open");
            });
        }

        var ferror = 0, fall = 0, fsuccess = 0;
        function startprocess() { 
                $('#save_dig').dialog({ title: 'Uploading Documents...', width: '250px' });
                $('#save_dig').dialog('open');
                $('#save_dig').html('');
                $('#save_dig').append('<table></table>');
                $(':file').each(function (index) {
                    var fileUpload = $(this).get(0);
                    var files = fileUpload.files; 
                    var sfiles = []; 
                    fall = files.length;
                    var data = new FormData();
                    var fname = '';
                    for (var i = 0; i < files.length; i++) {
                       
                        fname = files[i].name;
                        data.append(files[i].name, files[i]);
                      
                   
                        $.ajax({
                            url: "../fileupload1.ashx",
                            type: "POST",
                            data: data,
                            contentType: false,
                            processData: false,
                            beforeSend: function () {
                             },
                            complete: function () {
                                $('#fp' + index).removeClass('process').addClass('complete');
                                $('#fp' + index + ' i').removeClass('fa-spinner').removeClass('fa-pulse').addClass('fa-check');
                                if (fall > 0 && fsuccess == fall) {
                                    $('#save_dig').dialog({ title: 'Submitting Record...', width: '250px' });
                                    $('#save_dig').html('<div style="text-align:center"><i class="fa  fa-spinner fa-pulse fa-3x" ></i></div> ');
                                    $('#save_dig').dialog('close');
                                    $('#' + '<%= hfddocument.ClientID %>').val(JSON.stringify(sfiles));
                                    $('#' + '<%= btndocsave.ClientID %>').click();
                                    
                                }
                            },
                            success: function (result) {                                
                               
                                sfiles.push(result);
                                fsuccess++;
                            },
                            error: function (xhr, ajaxOptions, thrownError) {
                                ferror++;
                                $(ctl).removeClass('hide');
                            }
                        });
                        }
                });
                    return false;
                 
            }
    </script>
    <script type="text/javascript" language="javascript">
        function Clear_Data() {
            document.getElementById('<%=hfddocid.ClientID %>').value = '0';
            document.getElementById('<%=ddl_doctype.ClientID %>').value = '-1';
            document.getElementById('mulupload').value = "";
            document.getElementById('<%=txtdoccomments.ClientID%>').value = '';
            document.getElementById('<%=chkalldocumentsreceived.ClientID%>').checked = false;
            todaysdate();
            return false;
        }
        function Save_Validations() {
            var errormsg = validateform('frmfld');
            if (errormsg != "") {
                Msgbox(errormsg);
                return false;
            }
            startprocess();
            return false;
            return true;

        }

    </script>
    <script type="text/javascript">


        var dataIn = '';
        var sa5 = new sagrid();
        sa5.url = "../WCFGrid/GridService.svc/BindPersonwellnessDocument";

        sa5.primarykeyval = "Wellness_ID";
        sa5.bindid = "grddocumnet1";
        
        sa5.objname = "sa5";
        sa5.process();
        function down_lkp(sender, keyval) {

            document.getElementById('<%= hfdselid.ClientID %>').value = keyval;
            var fname = sa5.resultdata[sender]["Doc_Path"];

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
             altbox(msg);

         }


    </script>

    
 <div id="save_dig" class="popup">
    </div>

    <asp:UpdatePanel ID="upd" runat="server">
        <ContentTemplate>
            <asp:HiddenField ID="hfddocid" runat="server" Value="0" />
            <asp:HiddenField ID="hfdperid" runat="server" Value="0" />
            <asp:HiddenField ID="hfdutype" runat="server" Value="0" />
            <asp:HiddenField ID="hfdselid" runat="server" Value="0" />

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
        <div style="text-align:center;padding-right:110px;margin-top:-25px">
              
                        <asp:CheckBox ID="chkalldocumentsreceived" runat="server" Text="&nbsp;All documents received" />&nbsp;<asp:Button ID="btnsubmitall" runat="server" Text="Save" OnClick="btnsubmitall_Click"/>
                   
        </div>
        <br />
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
                        <input type="file" id="mulupload" multiple="multiple" class="required" error="Please Upload Document." />
                        <asp:HiddenField ID="hfddocument" runat="server" Value="0" />
                    </td>
                </tr>


                <tr>
                    <td align="right">Comments 
                    </td>
                    <td align="left">
                        <asp:TextBox ID="txtdoccomments" runat="server" TextMode="MultiLine" Height="50px" Width="200px"></asp:TextBox>
                    </td>
                </tr>
               
                <tr>
                    <td align="center" colspan="2">
                        <asp:Button ID="btn_submit" runat="server" Text="Submit" OnClientClick="javascript:return Save_Validations();" />
                        <asp:Button ID="btndocsave" runat="server" Style="display: none" OnClick="btn_submit_Click" />
                        <asp:Button ID="btn_clear" runat="server" Text="Clear" OnClientClick="javascript:return Clear_Data();" />
                    </td>
                </tr>
            </table>

        </div>

    </div>
    <div id="grddocumnet1"></div>
    <script type="text/javascript">
        var isedit = $('#ctl00_hfdwrite').val();
        var isdel = $('#ctl00_hfddel').val();
        if (isedit == 'False')
            $('#btnnew').addClass('hide');
        if (isdel == 'True')
            sa5.cols = [new dcol("Date", "Created_Date"), new dcol("Document Type", "Doc_Type"), new dcol("File Name", "Filename"), new dcol("Comments", "Comments"), new dcol("User", "UserName"), new dcol("All Documents Received", "AllDocumentsReceived"), new dcol("Download", "", "", "1", "1", "down_lkp", "fa fa-download grdicon"), new dcol("Delete", "", "", "1", "1", "Delete_lkp", "fa fa-trash-o grdicon")];
        else
            sa5.cols = [new dcol("Date", "Created_Date"), new dcol("Document Type", "Doc_Type"), new dcol("File Name", "Filename"), new dcol("Comments", "Comments"), new dcol("User", "UserName"),new dcol("All Documents Received", "AllDocumentsReceived"), new dcol("Download", "", "", "1", "1", "down_lkp", "fa fa-download grdicon")];

        dataIn = '"pid":"' + document.getElementById('<%= hfdperid.ClientID %>').value + '"';
        sa5.data = dataIn;
        sa5.process();
    </script>
</asp:Content>
