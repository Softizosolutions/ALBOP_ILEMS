<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="New_Fee_Adding.aspx.cs" Inherits="Licensing.Finance.New_Fee_Adding" MasterPageFile="~/Finance/Finance.Master" %>

<%--<!DOCTYPE html>--%>

<asp:Content ID="cnt" ContentPlaceHolderID="cntmain" runat="server">
      <script type="text/javascript">


          var dataIn = '';
          var sa5 = new sagrid();
          sa5.url = "../WCFGrid/GridService.svc/BindNewFeeAdd";

          sa5.primarykeyval = "Subobj_Id";
          sa5.bindid = "grd_newfee";
          sa5.cols = [new dcol("Code #", "Subobj_code"), new dcol("Description", "Description"), new dcol("Amount", "Amount"), new dcol("Full Description", "Full_Description"), new dcol("Edit", "", "", "1", "1", "edit_lkp", "fa fa-pencil-square-o grdicon"), new dcol("Delete", "", "", "1", "1", "Delete_lkp", "fa fa-trash-o grdicon")];
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
              $('#btnnew_pop').dialog('close');
              altbox(msg);

          }
      </script>

    <script language="javascript">

        function Save_Validation() {
            var errormsg = validateform('frmfld');
            if (errormsg != "") {
                Msgbox(errormsg);
                return false;
            }
            return true;
        }
    </script>
    <asp:UpdatePanel ID="upd" runat="server" >
    <ContentTemplate>
    <asp:HiddenField ID="hfdselid" runat="server" Value="0" />
   <asp:Button ID="btnedit" runat="server" style="display:none" OnClick="btnedit_click" />
     <asp:Button ID="btndel" runat="server" style="display:none" OnClick="btndel_click" />
    <asp:HiddenField ID="hfdsubonjid" runat="server" Value="0" />
   
           
 <div class="cpanel">
 <div class="head">
     Add New
       
 
       </div>
      
      <div class="body">
   
        <table width="90%" align="center" class="spac" id="frmfld">


            <tr>
                <td align="right" >
                   
                  <asp:Label ID="lbl_code" Text="Code" runat="server"></asp:Label>

                </td>
                <td align="left">
                    <asp:TextBox ID="txt_code" runat="server" Text="" placeholder="Code" CssClass="required" error="Please enter code.">

                    </asp:TextBox>
                </td>
                  
          
                <td align="right">
                     
                  <asp:Label ID="Label2" Text="Amount" runat="server"></asp:Label> 

                </td>
                <td align="left">
                    <asp:TextBox ID="txt_amount" runat="server" Text="" placeholder="Amount" CssClass="required" error="Please enter amount.">

                    </asp:TextBox>
                </td>
                <td align="right">
                     
                  <asp:Label ID="Label4" Text="Object Type" runat="server"></asp:Label> 

                </td>
                <td align="left">
                   <asp:DropDownList ID="ddlobjtype" runat="server" >
                   <asp:ListItem Value="1">Person</asp:ListItem>
                   <asp:ListItem Value="2">Place</asp:ListItem>
                   </asp:DropDownList>
                </td>
             </tr>   
              <tr>
                 <td align="right">
                      
                   <asp:Label ID="Label5" Text="Description" runat="server"></asp:Label>

                </td>
                <td align="left" colspan="5">
                    <asp:TextBox ID="txt_desc" runat="server" width="98%" TextMode="MultiLine" Height="25" CssClass="required" placeholder="Full Description" error="Please enter full description.">

                    </asp:TextBox>
                </td>
            </tr>
             <tr>
                 <td align="right">
                      
                   <asp:Label ID="Label3" Text="Full Description" runat="server"></asp:Label>

                </td>
                <td align="left" colspan="5">
                    <asp:TextBox ID="txt_fulldesc" runat="server" width="98%" TextMode="MultiLine" Height="25" CssClass="required" placeholder="Full Description" error="Please enter full description.">

                    </asp:TextBox>
                </td>
            </tr>
            <tr>
                <td colspan="8" align="center">

                    <asp:Button ID="btn_submit" runat="server" Text="Submit" OnClick="btn_submit_Click" OnClientClick="javascript:return Save_Validation()" />
               <%-- </td>
                  <td colspan="2" align="left">--%>

                    <asp:Button ID="btn_clear" runat="server" Text="Clear" OnClick="btn_clear_Click" />
                </td>
            </tr>
        </table>
        </div>
        </div>
      </ContentTemplate>
    </asp:UpdatePanel>
    <div class="cpanel">
 <div class="head">
        Results
       
 
       </div>
      
      <div class="body">
                <div id="grd_newfee"></div>
               
     </div>
     </div>
        
    
</asp:Content>
