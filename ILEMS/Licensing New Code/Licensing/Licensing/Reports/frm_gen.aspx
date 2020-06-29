<%@ Page Language="C#"   AutoEventWireup="true" MasterPageFile="~/Reports/reports.master" CodeBehind="frm_gen.aspx.cs" Inherits="Licensing.Reports.frm_gen" %>
<%@ Register Assembly="CKEditor.NET" Namespace="CKEditor.NET" TagPrefix="CKEditor" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cntmain" runat="server">
 <script>

     var sa5 = new sagrid();
     sa5.url = "../Reports/Report.svc/getprintsbytype";

     sa5.primarykeyval = "PrintID";
     sa5.bindid = "grdprints";
     sa5.cols = [new dcol("File Name", "fname"), new dcol("Edit", "", "", "1", "1", "edit_lkp", "fa fa-pencil-square-o grdicon"), new dcol("Delete", "", "", "1", "1", "Delete_lkp", "fa fa-trash-o grdicon")];
     sa5.objname = "sa5";
     
     function showprnts() {
         var dataIn = '"ptype":"' + document.getElementById('<%= ddlflds.ClientID %>').value + '"';

         sa5.data = dataIn;

         sa5.process();
         $('#grdprints').dialog({ title: 'Existing Prints', width: '60%' });
         $('#grdprints').dialog('open');
     }
     function afterdel()
     {
      altbox("Record Deleted.");
      sa5.process();
  }
  function afteredit() {
      $('#grdprints').dialog('close');
  }
 </script>

    <div class="cpanel">
        <div class="head">
            Forms Generator
        </div>
        <div class="body">
             <div id="grdprints" class="popup"></div>
  
   <asp:UpdatePanel ID="upd" runat="server" >
  <ContentTemplate> 
  <asp:HiddenField ID="hfdselprnt" runat="server" Value="0" />  
   <asp:Button ID="btnedit" runat="server" Text="Edit" style="display:none"  OnClick="btnedit_click" />
     <asp:Button ID="btndel" runat="server" Text="Delete" style="display:none"  OnClick="btndel_click" />
 
       <table width="95%" align="center" class="spac">
       <tr>
        <td     align="right">
    Select Folder:
    </td>
    <td align="left" >
    <asp:DropDownList ID="ddlflds" runat="server" >
   <asp:ListItem Value="1">Personal</asp:ListItem>
   <asp:ListItem Value="2">License</asp:ListItem>
     <asp:ListItem Value="3">Complaints</asp:ListItem>
    </asp:DropDownList>
    </td>
    <td colspan="4">
    <table width="90%">
    <tr>
    <td class="Labels" width="15%" align="right">
    File Name:
    </td>
    <td >
     <asp:TextBox ID="txtfilename" runat="server" Width="98%" ></asp:TextBox>
    </td>
    <td>
      <asp:Button ID="btn_save" runat="server"  Text="Save" CssClass="button_bg" Width="108" Height="30" OnClick="btn_save_click"  /> 
   <i class="fa fa-pencil-square-o   grdicon1" onclick="showprnts()"> Show Prints </i>
    </td>
    </tr>
    </table>
    </td>
       </tr>
       <tr>
        <td   align="right">
    Select View:
    </td>
    <td align="left">
     <asp:DropDownList ID="ddlviews" runat="server" Width="90%"   AutoPostBack="true" OnSelectedIndexChanged="ddlviews_changed"  >
   
    </asp:DropDownList>
    </td>
         <td    align="right">
    Select Columns:
    </td>
    
    <td align="left"  >
      <asp:DropDownList ID="ddlselectcolmns" Width="90%"  runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlcols_change"  >
   
    </asp:DropDownList>
   
    </td>
    <td align="left">
     <asp:TextBox ID="txtcolumns" runat="server" Width="90%" ></asp:TextBox>
    </td>
    <td><a id="trgpg" class="poptrg" style="cursor:pointer"><i class="fa fa-cog fa-1x"></i> Page Settings</a> </td>
       </tr>
       </table>
       
         <div id="trgpg_pop" class="popup">
          <span class="title">Page Settings</span>
 
 
<table width="500px"  class="spac">
<tr>
<td>Page Width :</td><td> <asp:TextBox ID="txtpagewidth" runat="server" Text="8.5in"></asp:TextBox> </td>
<td>Page Height :</td><td> <asp:TextBox ID="txtpageheight" runat="server" Text="11.0in"></asp:TextBox> </td>
</tr>
<tr>
<td>Margin Top :</td><td> <asp:TextBox ID="txtmrgtop" runat="server" Text="0.75in"></asp:TextBox> </td>
<td>Margin Bottom :</td><td> <asp:TextBox ID="txtmrgbotom" runat="server" Text="0.5in"></asp:TextBox> </td>
</tr>
<tr>
<td>Margin Left :</td><td> <asp:TextBox ID="txtmrgleft" runat="server" Text="1in"></asp:TextBox> </td>
<td>Margin Right :</td><td> <asp:TextBox ID="txtmrgrght" runat="server" Text="1in"></asp:TextBox> </td>
</tr>
</table>
 
</div>
  
 
 
  <CKEditor:CKEditorControl ID="txtsummarycomplaint" ToolTip=""   ToolbarStartupExpanded="True"   runat="server"  Width="98%"   Height="500" BasePath="~/ckeditor"> 
                                         
		</CKEditor:CKEditorControl> 
		 </ContentTemplate>
  </asp:UpdatePanel>
        </div>
    </div>

		 <script language="javascript" type="text/javascript">
		     function clr() {
		          altbox('Saved successfully.');

		     }
		     function cnffnres(result) {
		         if (result == 'true')
		             __doPostBack('<%= btndel.UniqueID %>', "");
       }
		     function Delete_lkp(sender, keyval) {
		         document.getElementById('<%= hfdselprnt.ClientID %>').value = keyval;
                  cnfbox(" Are you sure do you want to delete this record?", "cnffnres");
              }
		     function edit_lkp(sender, keyval) {

		         document.getElementById('<%= hfdselprnt.ClientID %>').value = keyval;
		         __doPostBack('<%= btnedit.UniqueID %>', "");
		     }
		    
		     
		 </script>
         
</asp:Content>