<%@ Page Title="" Language="C#" MasterPageFile="~/Administration/Admin.Master" AutoEventWireup="true" CodeBehind="Licenselookup.aspx.cs" Inherits="Licensing.Administration.Licenselookup" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cntmain" runat="server">



    
    <script type="text/javascript">


        var dataIn = '';
        var sa5 = new sagrid();
        sa5.url = "../WCFGrid/GridService.svc/LicenseLookup";

        sa5.primarykeyval = "LicenseType_ID";
        
        sa5.bindid = "grdlookup";
        sa5.cols = [new dcol("License Type", "License_Type"), new dcol("License Format", "License_Format"), new dcol("Exp Type", "ExpType"), new dcol("Exp Day", "Exp_Day"), new dcol("Exp Month", "Exp_Month"), new dcol("License Fee", "License_Fee"), new dcol("Renewal Fee", "Renewal_Fee"), new dcol("Edit", "", "", "1", "1", "edit_lkp", "fa fa-pencil-square-o grdicon"), new dcol("Delete", "", "", "1", "1", "Delete_lkp", "fa fa-trash-o grdicon")];
        sa5.objname = "sa5";
        sa5.data = dataIn;
        sa5.process();
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
           function afterpost(msg) {

               sa5.process();
              
               altbox(msg);

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
     
     <div class="cpanel">
 <div class="head">
    License Lookup
     
 </div>
  <div class="body">
      
    <asp:UpdatePanel ID="upd1" runat="server">
        <ContentTemplate>
            <asp:HiddenField ID="hfdlic" runat="server" Value="0" />
            <table align="center" class="spac" width="98%" id="frmfld">
                    <tr>
                        <td align="right" >License Type 
                        </td>
                        <td align="left" >
                           <asp:TextBox ID="txtlictype" runat="server" placeholder="License Type"  class="required" error="Please enter license type."></asp:TextBox>
                        </td>
                        <td align="right">License Format 
                        </td>
                        <td align="left">
                            <asp:TextBox ID="txt_licformat" runat="server" placeholder="License Format" class="required" error="Please enter license format."></asp:TextBox>
                        </td>
                   
                        <td align="right">Linked License Type 
                        </td>
                        <td align="left">
                            <asp:DropDownList ID="ddl_linkedlictype" runat="server" >
                                
                            </asp:DropDownList>
                        </td>
                         </tr>
                    <tr>
                        <td align="right">Expiry Type 
                        </td>
                        <td align="left">
                            <asp:DropDownList ID="ddl_Exptype" runat="server" class="required" error="Please select expiry type.">
                                <asp:ListItem Value="-1">Select Expiry Type</asp:ListItem>
                                <asp:ListItem Text="1">Days</asp:ListItem>
                                <asp:ListItem Text="2">Months</asp:ListItem>
                                 <asp:ListItem Text="3">Years</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                   
                        <td align="right">Number For Expiry
                        </td>
                        <td align="left">
                            <asp:TextBox ID="txt_noforexpiry" runat="server" placeholder="Number For Expiry" class="required" error="Please enter number for expiry."></asp:TextBox>
                        </td>
                        <td align="right">Expiry Day 
                        </td>
                        <td align="left">
                          <asp:DropDownList ID="ddl_expday" runat="server"  class="required" error="Please select expiry day.">
                              <asp:ListItem Value="-1">Select Expiry Day</asp:ListItem>
                              
                          </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">Expiry Month 
                        </td>
                        <td align="left">
                             <asp:DropDownList ID="ddl_expmonth" runat="server"  class="required" error="Please select expiry month.">
                              <asp:ListItem Value="-1">Select Expiry Month</asp:ListItem>
                                
                          </asp:DropDownList>
                        </td>
                        <td align="right">Renewal Start Day 
                        </td>
                        <td align="left">
                           <asp:DropDownList ID="ddlrenewalstartday" runat="server"  class="required" error="Please select renewal start day.">
                              <asp:ListItem Value="-1">Select Renewal Start Day</asp:ListItem>
                              
                          </asp:DropDownList>
                        </td>
                  
                        <td align="right">Renewal Start Month 
                        </td>
                        <td align="left">
                             <asp:DropDownList ID="ddlrenewalstartmonth" runat="server"  class="required" error="Please select renewal start month.">
                              <asp:ListItem Value="-1">Select Renewal Start Month</asp:ListItem>
                              
                          </asp:DropDownList>
                        </td>
                          </tr>
                    <tr>
                        <td align="right">Renewal End Day
                        </td>
                        <td align="left">
                            <asp:DropDownList ID="ddlrenewalendday" runat="server"  class="required" error="Please select renewal end day.">
                              <asp:ListItem Value="-1">Select Renewal End Day</asp:ListItem>
                              
                          </asp:DropDownList>
                        </td>
                   
                        <td align="right">Renewal End Month 
                        </td>
                        <td align="left">
                            <asp:DropDownList ID="ddlrenewalendmonth" runat="server"   class="required" error="Please select renewal end month.">
                              <asp:ListItem Value="-1">Select Renewal End Month</asp:ListItem>
                              
                          </asp:DropDownList>
                        </td>
                        <td align="right">License Fee 
                        </td>
                        <td align="left">
                            <asp:TextBox ID="txt_licfee" runat="server" class="required" placeholder="License Fee" error="Please enter license fee."></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">Renewal Fee 
                        </td>
                        <td align="left">
                            <asp:TextBox ID="txt_renewalfee" runat="server" class="required" error="Please enter renewal fee." placeholder="Renewal Fee"></asp:TextBox>
                        </td>
                        <td align="right">Reinstate Fee 
                        </td>
                        <td align="left">
                              <asp:TextBox ID="txt_reinstatefee" runat="server" class="required" placeholder="Reinstate Fee" error="Please enter reinstate fee."></asp:TextBox>
                        </td>
                   
                        <td align="right">Late Renewal Fee 
                        </td>
                        <td align="left">
                              <asp:TextBox ID="txt_laterenewalfee" runat="server" class="required" placeholder="Late Renewal Fee" error="Please enter late renewal fee."></asp:TextBox>
                        </td>
                        <td align="right" style="display:none">Is Parent License Must 
                        </td>
                        <td align="left" style="display:none">
                          <asp:CheckBox ID="chk_parentidmust" runat="server" />
                        </td>
                    </tr>
                    
                    <tr>
                        <td colspan="6" align="center">
                            <asp:Button ID="btn_submit" runat="server" Text="Submit" OnClick="btn_submit_Click"  OnClientClick="javascript:return Save_Validation();"/>&nbsp;&nbsp;&nbsp;
                            <asp:Button ID="btn_Clear" runat="server" Text="Clear" OnClick="btn_Clear_Click"  />
                        </td>
                    </tr>
                </table>
        </ContentTemplate>
    </asp:UpdatePanel>
       
        <asp:UpdatePanel ID="upd" runat="server">
        <ContentTemplate>
       
     <asp:HiddenField ID="hfdselid" runat="server" Value="0" />
   <asp:Button ID="btnedit" runat="server" style="display:none" OnClick="btnedit_click" />
     <asp:Button ID="btndel" runat="server" style="display:none" OnClick="btndel_click" />

    </ContentTemplate>
        </asp:UpdatePanel>
        </div>
        </div>

         <div class="cpanel">
 <div class="head">
   Existing License Types
       
 </div>
  <div class="body">
      
    <div id="grdlookup"></div>
    </div>
    </div>





</asp:Content>
