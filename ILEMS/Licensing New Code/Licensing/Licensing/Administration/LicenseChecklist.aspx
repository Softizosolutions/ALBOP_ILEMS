<%@ Page Title="" Language="C#" MasterPageFile="~/Administration/Admin.Master" AutoEventWireup="true" CodeBehind="LicenseChecklist.aspx.cs" Inherits="Licensing.Administration.LicenseChecklist" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cntmain" runat="server">
  
  <script type="text/javascript">


      var dataIn = '';
      var sa5 = new sagrid();
      sa5.url = "../WCFGrid/GridService.svc/BindLicenseChecklist";

      sa5.primarykeyval = "License_CheckList_ID";
      sa5.bindid = "grdchecklist";
      sa5.cols = [new dcol("Checklist", "Values"), new dcol("Status", "Status"), new dcol("Ismandatory", "Is_Mandatory"), new dcol("Edit", "", "", "1", "1", "edit_lkp", "fa fa-pencil-square-o grdicon"), new dcol("Delete", "", "", "1", "1", "Delete_lkp", "fa fa-trash-o grdicon")];
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
<script language="javascript">

    function Save_Validation() {
        var errormsg = validateform('frmfld');
        if (errormsg != "") {
            Msgbox(errormsg);
            return false;
        }
        return true;
    }
function Clear_Data() {
    document.getElementById('<%= hfd_chkid.ClientID %>').value = '0';
    document.getElementById('<%= ddl_checklist.ClientID %>').value = '-1';
    document.getElementById('<%= ddlstatus.ClientID %>').value = '-1';
    document.getElementById('<%= chk_mandatory.ClientID %>').checked = false;
    return false;

}


    function popup() {


        $(function () { $('#btnnew_pop').dialog({ title: 'Edit License CheckList' }); $('#btnnew_pop').dialog("open"); });

    }
    function ddl_bind() {
        var drd1 = $('<%= "#" +ddl_lictypedata.ClientID%>').val();
        var drd2 =$('<%= "#" +ddl_actiondata.ClientID%>').val();
        dataIn = '"sval":"' + drd1 + '","sval2":"' + drd2 + '"';
        
        sa5.data = dataIn;
        sa5.process();
    }
</script>

        
        <asp:UpdatePanel ID="upd2" runat="server">
        <ContentTemplate>
        <asp:HiddenField ID="hfd_chkid" Value="0" runat="server" />
        <asp:HiddenField ID="hfdselid" runat="server" Value="0" />
   <asp:Button ID="btnedit" runat="server" style="display:none" OnClick="btnedit_click" />
     <asp:Button ID="btndel" runat="server" style="display:none" OnClick="btndel_click" />
        </ContentTemplate>
        </asp:UpdatePanel>

    
   
      <div class="cpanel">
 <div class="head">
    License Checklist
      <a   id="btnnew"    class="poptrg" onclick="javascript:return Clear_Data();" >Add New</a>

 </div>
  <div class="body">
      
   
    <table   align="center" class="spac" style="margin-bottom:10px" >
<tr>
<td>
<asp:Label ID="lbl_name" runat="server" Text="License Type "></asp:Label>
</td>
<td><asp:DropDownList ID="ddl_lictypedata" runat="server" onchange="ddl_bind()" ></asp:DropDownList></td>

<td>
&nbsp;<asp:Label ID="Label1" runat="server" Text="Action"></asp:Label>
</td>
<td><asp:DropDownList ID="ddl_actiondata" runat="server"  onchange="ddl_bind()" ></asp:DropDownList></td>
<td>
   
</td>
</tr>
</table>
 
    
     



    <div id="grdchecklist"></div>
   </div>
   </div>
            <div id='btnnew_pop' class="popup" style="display: none;">
   <span class="title">New License CheckList</span>
    <asp:UpdatePanel ID="upd1" runat="server">
        <ContentTemplate>
          <table style="width:100%" id="frmfld">                
                  <tr>
                    <td align="right">
                        Checklist
                    </td>
                    <td align="left">
                        <asp:DropDownList ID="ddl_checklist" runat="server" CssClass="required" error="Please select checklist."></asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        Status
                    </td>
                    <td align="left">
                        <asp:DropDownList ID="ddlstatus" runat="server" CssClass="required" error="Please select status.">
                            <asp:ListItem Value="-1">Select</asp:ListItem>
                            <asp:ListItem>Active</asp:ListItem>
                            <asp:ListItem>InActive</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                       Is Mandatory
                    </td>
                    <td align="left">
                        <asp:CheckBox ID="chk_mandatory" runat="server" />
                    </td>
                </tr>
                <tr><td colspan="2">&nbsp;</td></tr>
                <tr>
                    <td colspan="2" align="center">
                        <asp:Button ID="btn_submit" runat="server" Text="Submit" OnClientClick="javascript:return Save_Validation()" OnClick="btn_submit_Click"  />&nbsp;&nbsp;
                        <asp:Button ID="btn_Clear" runat="server" Text="Clear" OnClick="btn_Clear_Click" />
                    </td>
                </tr>
            </table>
              </ContentTemplate>

    </asp:UpdatePanel>

 </div>
             
      
     

</asp:Content>
