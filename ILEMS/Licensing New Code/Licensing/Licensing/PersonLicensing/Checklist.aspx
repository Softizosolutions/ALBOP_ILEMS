<%@ Page Language="C#" MasterPageFile="~/PersonLicensing/Person.Master" AutoEventWireup="true" CodeBehind="Checklist.aspx.cs" Inherits="Licensing.PersonLicensing.Checklist"  %>

<asp:Content ID="content1" runat="server" ContentPlaceHolderID="cntmain">
    <script language="javascript" type="text/javascript">

       

        function defsearchreset()
        {
            document.getElementById('<%= txt_Lastname.ClientID %>').value = "";
           document.getElementById('<%= txt_Firstname.ClientID %>').value = "";
            document.getElementById('<%= txt_ssn.ClientID %>').value = "";
            document.getElementById('<%= txt_dob.ClientID %>').value = "";
            document.getElementById('<%= txt_phonenum.ClientID %>').value = "";
            document.getElementById('<%= ddl_Lictype.ClientID %>').value = "-1";
             document.getElementById('<%= ddlperres.ClientID %>').value = "-2";
             return false;
         }
         function bindchk() {
             dataIn = '"lastname":"' + document.getElementById('<%= txt_Lastname.ClientID %>').value + '"';
             dataIn += ',"fname":"' + document.getElementById('<%= txt_Firstname.ClientID %>').value + '"';
             dataIn += ',"ssn":"' + document.getElementById('<%= txt_ssn.ClientID %>').value + '"';
             dataIn += ',"dob":"' + document.getElementById('<%= ddl_Lictype.ClientID %>').value + '"';
              dataIn += ',"pres":"' + document.getElementById('<%= ddlperres.ClientID %>').value + '"';
             sa5.data = dataIn;
             sa5.process();

             return false;
         }
         function Search_Validation() {

             var err = "";
             var srch_count = 0;
             if (Value_Checked('<%= txt_Lastname.ClientID %>', "1") != "1")
                 srch_count = srch_count + 1;
             if (Value_Checked('<%= txt_Firstname.ClientID %>', "1") != "1")
                 srch_count = srch_count + 1;
             if (Value_Checked('<%= txt_ssn.ClientID %>', "1") != "1")
                 srch_count = srch_count + 1;
             if (Value_Checked('<%= txt_dob.ClientID %>', "1") != "1")
                 srch_count = srch_count + 1;
             if (Value_Checked('<%= txt_phonenum.ClientID %>', "1") != "1")
                 srch_count = srch_count + 1;
             if (Value_Checked_Drp('<%=ddl_Lictype.ClientID%>', "1") != "1")
                 srch_count = srch_count + 1;
              if (Value_Checked_Drp1('<%=ddlperres.ClientID%>', "1") != "-2")
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
        function Value_Checked_Drp1(Ctr_Name, Error_Message) {
            if (document.getElementById(Ctr_Name).value == "-2" || document.getElementById(Ctr_Name).value == 'undefined') {
                return Error_Message;
            }
            return "";
        }
    </script>
     <script type="text/javascript">
         function Value_Checked(Ctr_Name, Error_Message) {
             if (document.getElementById(Ctr_Name).value.trim() == "") {

                 return Error_Message;
             }
             return "";
         }
         function Value_Checked_Drp(Ctr_Name, Error_Message) {
             if (document.getElementById(Ctr_Name).value == "-1") {

                 return Error_Message;
             }
             return "";
         }
    </script>
     <script type="text/javascript">


         var dataIn = '';
         var sa5 = new sagrid();
         sa5.url = "../WCFGrid/GridService.svc/BindPersonChecklist";

         sa5.primarykeyval = "App_ID";
         sa5.bindid = "grdchecklist";
         sa5.cols = [new dcol("Name", "Name", "", "1", "0", "nm_click", "", ""), new dcol("SSN", "SSN"), new dcol("Address1", "Address1"), new dcol("Address2", "Address2"), new dcol("C S Z", "CSZ"), new dcol("Lic Type", "Lic_type"), new dcol("Action", "action1"), new dcol("Application Date", "appdate"), new dcol("Person Responsible", "Perresp"), new dcol("Delete", "", "", "1", "1", "Delete_lkp", "fa fa-trash-o grdicon")];
         sa5.objname = "sa5";
         sa5.aftercall = "Aftercall";
         function nm_click(sender, keyval) {
             var pid = sa5.resultdata[sender]["Person_ID"];
             var typeid = sa5.resultdata[sender]["object_type"];
             if(typeid=="1")
                 window.location.href = '../PersonLicensing/PersonDetails.aspx?pid=' + pid;
             else
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
        function Save_Validation()
        {
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
                            Last Name / Business 
                        </td>
                        <td align="left">
                            <asp:TextBox ID="txt_Lastname" runat="server" CssClass="required" placeholder="Last Name / Business" error="Please enter last name or Business."></asp:TextBox>
                        </td>
                        <td align="right">
                            <%--<asp:Label ID="Label1" runat="server" Style="color: Red; font-style: Bold;"
                                Text="*"></asp:Label>--%>
                            First Name 
                        </td>
                        <td align="left">
                            <asp:TextBox ID="txt_Firstname" runat="server" CssClass="required" placeholder="First Name" error="Please enter first name."></asp:TextBox>
                        </td>
                    
                        <td align="right">
                           <%-- <asp:Label ID="Label2" runat="server" Style="color: Red; font-style: Bold;"
                                Text="*"></asp:Label>--%>
                            SSN 
                        </td>
                        <td align="left">
                            <asp:TextBox ID="txt_ssn" runat="server" CssClass="ssn required"  error="Please enter valid ssn."></asp:TextBox>
                        </td>
                        </tr>
                    <tr>
                        <td align="right">
                            <%--<asp:Label ID="Label3" runat="server" Style="color: Red; font-style: Bold;"
                                Text="*"></asp:Label>--%>
                            DOB 
                        </td>
                        <td align="left">
                            <asp:TextBox ID="txt_dob" runat="server" CssClass="date required"  error="Please enter dob."></asp:TextBox>
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
                    <td align="right">Person Responsible 
                    </td>
                    <td align="left">
                        <asp:HiddenField ID="hfdctype" runat="server" Value="1" />
                        <asp:DropDownList ID="ddlperres" runat="server">
                        </asp:DropDownList>
                    </td>
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
