<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Discipline.aspx.cs" MasterPageFile="~/Master Page/frm.Master" Inherits="Licensing.PersonLicensing.Discipline" %>

<asp:Content ID="cnt1" runat="server" ContentPlaceHolderID="ContentPlaceHolder1">
    <script type="text/javascript">
        var dataIn = '';
        var sa5 = new sagrid();
        sa5.url = "../WCFGrid/GridService.svc/BindDiscline";
        sa5.primarykeyval = "DisciplineID";
        sa5.bindid = "grddocumnet1";
        sa5.objname = "sa5";
        sa5.cols = [
            new dcol("License Number", "LicenseNumber"),
            new dcol("Case Number", "CaseNumber"),
            new dcol("Start Date", "StartDate"),
            new dcol("End Date", "EndDate"),
            new dcol("State Of Discipline", "StateOfDiscipline"),
            new dcol("Brief Synopsis", "BriefSynopsis"),
            new dcol("Reviewer Comment", "ReviewerComment"),
           // new dcol("BriefSynopsis", "BriefSynopsis"),
            new dcol("Download", "", "", "1", "1", "down_lkp", "fa fa-download grdicon"),
            new dcol("Edit", "", "", "1", "1", "edit_lkp", "fa fa-pencil-square-o grdicon"),
            new dcol("Delete", "", "", "1", "1", "Delete_lkp", "fa fa-trash-o grdicon")
        ];
       
        function down_lkp(sender, keyval) {

            document.getElementById('<%= hfdselid.ClientID %>').value = keyval;
            var fname = sa5.resultdata[sender]["DocumentPath"];

                    if (fname != '') {
                        window.open(fname);
                    }
                    else {
                        altbox('Sorry no file attached.');
                    }
                }
                function edit_lkp(sender, keyval) {

                    document.getElementById('<%= hfdselid.ClientID %>').value = keyval;
                 document.getElementById('<%= btnedit.ClientID %>').click();
             }
             function Delete_lkp(sender, keyval) {
                 document.getElementById('<%= hfdselid.ClientID %>').value = keyval;
              cnfbox(" Are you sure do you want to delete this record?", "cnffnres");
          }
          function cnffnres(result) {
              if (result == 'true')
                  document.getElementById('<%= btndel.ClientID %>').click();
        }
        function Popup() {
            $(function () {
                $('#btnnew_pop').dialog({ title: 'Edit Discipline' });
                $('#btnnew_pop').dialog("open");
            });
        }
        function afterpost(msg) {
            altbox(msg);
            sa5.process();
            $('#btnnew_pop').dialog('close');
        }
        function Clear_Data() {
            document.getElementById('<%=hfdselid.ClientID %>').value = '0';
            document.getElementById('<%=txt_Brief_Synopsis.ClientID %>').value = '';
            document.getElementById('<%=txt_Case_Number.ClientID %>').value = '';
            document.getElementById('<%=txt_End_Date.ClientID %>').value = '';
            document.getElementById('<%=txt_License_Number.ClientID %>').value = '';
              document.getElementById('<%=txt_Reviewer_comments.ClientID %>').value = '';
           // document.getElementById('<%=upddocument.ClientID %>').value = "";
              document.getElementById('<%=txt_Start_Date.ClientID%>').value = '';
                document.getElementById('<%=ddl_State_Of_Discipline.ClientID%>').value = '-1'; 
           
            return false;
        }  
    </script>
    
            
            <asp:HiddenField ID="hfdperid" runat="server" Value="0" />
            <asp:HiddenField ID="hfdselid" runat="server" Value="0" />
            <asp:Button ID="btndel" runat="server" Style="display: none" OnClick="btndel_Click" />
            <asp:Button ID="btnedit" runat="server" Style="display: none" OnClick="btnedit_Click" />
        

    <div>
        <div style="text-align: right; padding-right: 10px; margin-top: 0px">
            <input type="button" id="btnnew" value="Add New" class="poptrg" onclick="javascript: return Clear_Data()" />

        </div>
        <br />
        <div id="grddocumnet1"></div>
        <div id='btnnew_pop' class="popup" style="display: none;height:1000px;">
            <span class="title">Add New Discipline</span>
            <table align="center" id="frmfld" class="spac">
                <tr id="lictype" runat="server">
                    <td align="right">License Numbers
                    </td>
                    <td align="left">
                        <asp:TextBox ID="txt_License_Number" runat="server" placeholder="License #"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td align="right" width="35%">Case Number  
                    </td>
                    <td align="left">
                        <asp:TextBox ID="txt_Case_Number" runat="server" placeholder="Case Number"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td align="right">Start Date   
                    </td>
                    <td align="left">
                        <asp:TextBox ID="txt_Start_Date" runat="server" CssClass="date"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td align="right">End date</td>
                    <td align="left">
                        <asp:TextBox ID="txt_End_Date" runat="server" CssClass="date"></asp:TextBox>
                    </td>
                </tr>


                <tr>
                    <td align="right">State of Discipline  
                    </td>
                    <td align="left">
                        <asp:DropDownList ID="ddl_State_Of_Discipline" runat="server">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td align="right">Brief Synopsis  
                    </td>
                    <td align="left">
                        <asp:TextBox ID="txt_Brief_Synopsis" runat="server" TextMode="MultiLine" Height="50px" Width="200px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td align="right">Reviewer comments   
                    </td>
                    <td align="left">
                        <asp:TextBox ID="txt_Reviewer_comments" runat="server" TextMode="MultiLine" Height="50px" Width="200px"></asp:TextBox>
                    </td>
                </tr>

                <tr>
                    <td align="right">Upload  
                    </td>
                    <td align="left">
                        <asp:FileUpload ID="upddocument" runat="server"  />

                    </td>
                </tr>
                 
                <tr>
                    <td align="center" colspan="2">
                        <asp:Button ID="btn_submit" runat="server" Text="Submit" OnClick="btn_submit_Click" />
                        <asp:Button ID="btn_clear" runat="server" Text="Clear" OnClientClick="javascript:return Clear_Data();" />
                    </td>
                </tr>
             
            </table>
           
        </div>
    </div>
    <script type="text/javascript">
        dataIn = '"pid":"' + document.getElementById('<%= hfdperid.ClientID %>').value + '"';
        
        sa5.data = dataIn;
        sa5.process();
    </script>
</asp:Content>
