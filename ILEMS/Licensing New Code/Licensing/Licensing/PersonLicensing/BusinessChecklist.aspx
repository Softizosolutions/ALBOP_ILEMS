<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/PersonLicensing/Person.Master" CodeBehind="BusinessChecklist.aspx.cs" Inherits="Licensing.PersonLicensing.BusinessChecklist" %>

<asp:Content ID="content1" runat="server" ContentPlaceHolderID="cntmain">
    <script language="javascript" type="text/javascript">



        function defsearchreset() {
            document.getElementById('<%= txt_businessname.ClientID %>').value = "";
            document.getElementById('<%= txt_ownersname.ClientID %>').value = "";
            document.getElementById('<%= txt_fein.ClientID %>').value = "";
            document.getElementById('<%= txt_datestarted.ClientID %>').value = "";
            document.getElementById('<%= txt_phonenum.ClientID %>').value = "";
            document.getElementById('<%= ddl_Lictype.ClientID %>').value = "-1";
            return false;
        }
        function bindchk() {
            dataIn = '"lastname":"' + document.getElementById('<%= txt_businessname.ClientID %>').value + '"';
            dataIn += ',"fname":"' + document.getElementById('<%= txt_ownersname.ClientID %>').value + '"';
            dataIn += ',"ssn":"' + document.getElementById('<%= txt_fein.ClientID %>').value + '"';
            dataIn += ',"dob":"' + document.getElementById('<%= txt_datestarted.ClientID %>').value + '"';
            dataIn += ',"pnumber":"' + document.getElementById('<%= txt_phonenum.ClientID %>').value + '"';
            dataIn += ',"lictype":"' + document.getElementById('<%= ddl_Lictype.ClientID %>').value + '"';

            sa5.data = dataIn;
            sa5.process();

            return false;
        }
        function Search_Validation() {

            var err = "";
            var srch_count = 0;
            if (Value_Checked('<%= txt_businessname.ClientID %>', "1") != "1")
                srch_count = srch_count + 1;
            if (Value_Checked('<%= txt_ownersname.ClientID %>', "1") != "1")
                srch_count = srch_count + 1;
            if (Value_Checked('<%= txt_fein.ClientID %>', "1") != "1")
                srch_count = srch_count + 1;
            if (Value_Checked('<%= txt_datestarted.ClientID %>', "1") != "1")
                srch_count = srch_count + 1;
            if (Value_Checked('<%= txt_phonenum.ClientID %>', "1") != "1")
                srch_count = srch_count + 1;

            if (srch_count == 0)
                err = err + "Please select atleast one criteria for search.\r\n";
            if (err != "") {
                altbox(err);
                return false;
            }
            bindchk();
            return false;

        }
    </script>
     <script type="text/javascript">
         function Value_Checked(Ctr_Name, Error_Message) {
             if (document.getElementById(Ctr_Name).value.trim() == "") {

                 return Error_Message;
             }
             return "";
         }
    </script>
     <script type="text/javascript">


         var dataIn = '';
         var sa5 = new sagrid();
         sa5.url = "../WCFGrid/GridService.svc/BindBusinessChecklist";

         sa5.primarykeyval = "App_ID";
         sa5.bindid = "grdchecklist";
         sa5.cols = [new dcol("Name", "Name", "", "1", "0", "nm_click", "", ""), new dcol("FEIN", "FEIN"), new dcol("Lic Type", "Lic_type"), new dcol("Action", "action1"), new dcol("Delete", "", "", "1", "1", "Delete_lkp", "fa fa-trash-o grdicon")];
         sa5.objname = "sa5";
         sa5.aftercall = "Aftercall";
         function nm_click(sender, keyval) {
             var pid = sa5.resultdata[sender]["Person_ID"];
             window.location.href = '../PersonLicensing/Business_Details.aspx?pid=' + pid;
         }
         function cnffnres(result) {
             if (result == 'true') {
                 $('#btnnew_pop').dialog({ title: "Reason for Removing" });
                 $('#btnnew_pop').dialog('open');
             }
         }
         function Delete_lkp(sender, keyval) {
             document.getElementById('<%= hfdselappid.ClientID %>').value = keyval;
             cnfbox(" Are you sure do you want to delete this record?", "cnffnres");
         }


         function Aftercall() {
             var trs = sa5.resultdata;
             if (trs.length > 0) {
                 return true;
             }
             else {
                 altbox("No results found.");
                 document.getElementById("grdchecklist").innerHTML = "";
                 return false;
             }
         }
      </script>
    <script type="text/javascript">
        function Save_Validation() {
            bindchk();
            return false;

        }

    </script>

    <asp:HiddenField ID="hfd_Apid" runat="server" Value="0" />
    <asp:HiddenField ID="hfd_PersonID" runat="server" Value="0" />
 <div class="cpanel">
 <div class="head">
   Checklist
       </div>
      
      <div class="body">
   
    
     <asp:HiddenField ID="hfdselid" runat="server" Value="0" />
   <asp:Button ID="btnedit" runat="server" style="display:none"   />
     <asp:Button ID="btndel" runat="server" style="display:none"   />
     
                <table  style="margin-left:auto;margin-right:auto" width="98%"class="spac" id="frmfld">
                    <tr>
                        <td align="right">
                           <%-- <asp:Label ID="Label5" runat="server" Style="color: Red; font-style: Bold;" Text="*"></asp:Label>--%>
                            Business Name 
                        </td>
                        <td align="left">
                            <asp:TextBox ID="txt_businessname" runat="server" CssClass="required" placeholder="Business Name" error="Please enter business name."></asp:TextBox>
                        </td>
                        <td align="right">
                            <%--<asp:Label ID="Label1" runat="server" Style="color: Red; font-style: Bold;"
                                Text="*"></asp:Label>--%>
                            Owners Name 
                        </td>
                        <td align="left">
                            <asp:TextBox ID="txt_ownersname" runat="server" CssClass="required" placeholder="Owners Name" error="Please enter owners name."></asp:TextBox>
                        </td>
                    
                        <td align="right">
                           <%-- <asp:Label ID="Label2" runat="server" Style="color: Red; font-style: Bold;"
                                Text="*"></asp:Label>--%>
                            FEIN
                        </td>
                        <td align="left">
                            <asp:TextBox ID="txt_fein" runat="server" CssClass="fein"  error="Please enter valid fein."></asp:TextBox>
                        </td>
                        </tr>
                    <tr>
                        <td align="right">
                            <%--<asp:Label ID="Label3" runat="server" Style="color: Red; font-style: Bold;"
                                Text="*"></asp:Label>--%>
                            Date Started
                        </td>
                        <td align="left">
                            <asp:TextBox ID="txt_datestarted" runat="server" CssClass="date required"  error="Please enter start date."></asp:TextBox>
                        </td>
                   
                        <td align="right">Phone Number 
                        </td>
                        <td align="left">
                            <asp:TextBox ID="txt_phonenum" runat="server" class="phone"></asp:TextBox>
                        </td>
                        <td align="right">License Type 
                       </td>
                       <td align="left">
                           <asp:DropDownList ID="ddl_Lictype" runat="server" CssClass="required"  error="Please enter license type.">
                             
                           </asp:DropDownList>
                       </td>
                        <%--<td align="left">
                            <asp:DropDownList ID="ddl_Phonetype" runat="server">
                                <asp:ListItem>Select Phone Type</asp:ListItem>
                                <asp:ListItem Value="O">Office</asp:ListItem>
                                <asp:ListItem Value="C">Cell</asp:ListItem>
                                <asp:ListItem Value="H">Home</asp:ListItem>
                            </asp:DropDownList>
                        </td>--%>
                    </tr>
                    <tr>
                        <td colspan="6" align="center">
                            <asp:Button ID="btnsearch" runat="server" Text="Filter"   OnClientClick="javascript:return Search_Validation();" />
                        
                            <asp:Button ID="btn_searchclear" runat="server" Text="Clear"  OnClientClick="javascript:return defsearchreset();"/>
                        </td>
                    </tr>
                </table>
  
    <asp:HiddenField ID="hfdselappid" runat="server" Value="0" />
    <asp:Button ID="btnpopup" runat="server" Style="display: none;" />
    </div>
    </div>
    <div class="cpanel">
 <div class="head">
   Result
       </div>
      
      <div class="body">

    <div id="grdchecklist"></div>
    </div>
    </div>
    <asp:UpdatePanel ID="upd" runat="server" >
    <ContentTemplate>

    <div id='btnnew_pop' class="popup" style="display: none;">
        <span class="title">Reason for Removing</span>

        <table width="100%" class="spac" align="center" class="normalfont">
            <tr>
                <td>&nbsp;
                                                        
                </td>
                <td></td>
            </tr>
            <tr>
                <td class="Labels" align="right">
                    <asp:Label ID="lbl_reason" runat="server" Text="Reason"></asp:Label>
                </td>
                <td align="left">
                    <asp:DropDownList ID="ddlreasonforreject" runat="server" CssClass="drpcssbox">
                    </asp:DropDownList>
                </td>
            </tr>

            <tr>
                <td>&nbsp;
                </td>
                <td>&nbsp;
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <table align="center" class="spac">
                        <tr>
                            <td align="center">
                                <asp:Button ID="btnOK" runat="server" CssClass="button_bg" Height="30"
                                    Text="Submit" Width="108px" OnClick="btnOK_Click" />
                            </td>
                           
                        </tr>
                    </table>
                </td>
            </tr>
        </table>

    </div>
    </ContentTemplate>
    </asp:UpdatePanel>

    <script>
        bindchk();
    </script>
     
</asp:Content>
