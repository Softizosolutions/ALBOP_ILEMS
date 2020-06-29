<%@ Page Title="" Language="C#" MasterPageFile="~/Administration/Admin.Master" AutoEventWireup="true" CodeBehind="ManageLookups.aspx.cs" Inherits="Licensing.Administration.ManageLookups" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cntmain" runat="server">

    
  <script type="text/javascript">


      var dataIn = '';
      var sa5 = new sagrid();
      sa5.url = "../WCFGrid/GridService.svc/ManageLookup";

      sa5.primarykeyval = "Lkp_data_ID";
      sa5.bindid = "grdlookup";
      sa5.cols = [new dcol("Value", "Values"), new dcol("Edit", "", "", "1", "1", "edit_lkp", "fa fa-pencil-square-o grdicon"), new dcol("Delete", "", "", "1", "1", "Delete_lkp", "fa fa-trash-o grdicon")];
      sa5.objname = "sa5";
     
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
  <script language="javascript" type="text/javascript">
      function Save_Validation() {
          var errormsg = validateform('frmfld');
          if (errormsg != "") {
              Msgbox(errormsg);
              return false;
          }
          return true;
      }
     
        function Clear_Data() {
            document.getElementById('<%= txtvalue.ClientID %>').value = '';
            return false;
        }


      function popup() {


          $(function () { $('#btnnew_pop').dialog({title:'Edit Lookup Data'}); $('#btnnew_pop').dialog("open"); });

      }
      function ddl_change(ctl) {
          dataIn = '"sval":"' + ctl.value + '"';
          sa5.data = dataIn;
          sa5.process();
      }

    </script>

    <div class="cpanel">
 <div class="head">
    Manage User Lookups 
     <a  id="btnnew" class="poptrg" onclick="javascript:return Clear_Data();">New Item</a>
        
 </div>
  <div class="body">
      

      <table  align="center" style="margin-bottom:10px">
                <tr>
                    <td>
                        Select Lookup &nbsp;
                        <asp:DropDownList ID="ddl_suffix" runat="server"  CssClass="dropdown" onchange="ddl_change(this)">
                          </asp:DropDownList>
                    </td>
                    
                </tr>
                <tr>
                    <td>
                       
                    </td>
                </tr>
                
            </table>

        <div id="grdlookup"></div>   
     </div>
     </div>
                <asp:UpdatePanel ID="upd" runat="server">
                <ContentTemplate>
                     
         <asp:HiddenField ID="hfdauid" runat="server" Value="0" />

           <asp:HiddenField ID="hfdselid" runat="server" Value="0" />
   <asp:Button ID="btnedit" runat="server" style="display:none" OnClick="btnedit_click" />
     <asp:Button ID="btndel" runat="server" style="display:none" OnClick="btndel_click" />
</ContentTemplate>
                </asp:UpdatePanel>   
    
                     
                        

   
            <div id='btnnew_pop' class="popup" style="display: none;">
   <span class="title">New Lookup Data</span>
    <asp:UpdatePanel ID="upd1" runat="server">
        <ContentTemplate>
   <table id="frmfld">
                        <tr>
                            <td >
                                Value 
                            </td>
                            <td >
                                 <asp:TextBox ID="txtvalue" runat="server" class="required" placeholder="Value" error="Please enter value."></asp:TextBox>
                            </td>
                        </tr>
                        <tr><td colspan="2">&nbsp;</td></tr>
                        <tr>
                            <td style="text-align:center;" colspan="2">
                                 <asp:Button ID="btn_submit" runat="server" Text="Submit" OnClick="btn_submit_click" OnClientClick="javascript:return Save_Validation()" />
                                        &nbsp; &nbsp; &nbsp;
                                        <asp:Button ID="btn_back" runat="server" Text="Clear" OnClick="btn_back_Click" />
                            </td>
                        </tr>
                    </table>
                    </ContentTemplate>
    </asp:UpdatePanel>
        </div>
           
        


    







</asp:Content>
