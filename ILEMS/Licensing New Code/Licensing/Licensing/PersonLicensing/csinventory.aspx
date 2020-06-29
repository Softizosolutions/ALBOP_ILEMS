<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="csinventory.aspx.cs" MasterPageFile="~/Master Page/frm.Master" Inherits="Licensing.PersonLicensing.csinventory" %>

<asp:Content ID="cnt1" runat="server" ContentPlaceHolderID="ContentPlaceHolder1">
    <script type="text/javascript">
        var dataIn = '';
        var sa5 = new sagrid();
        sa5.url = "../WCFGrid/GridService.svc/Bindcsinventory";
        sa5.primarykeyval = "CSInventoryID";
        sa5.bindid = "grddocumnet1";
        sa5.objname = "sa5";
        sa5.cols = [
            new dcol("InventoryDate", "InventoryDate1"),
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
    </script>
    
             <script type="text/javascript">
                 function Save_Validation()
                 {
                     var date = document.getElementById('<%= txt_Inventory_Date.ClientID %>').value;                   
                     if(date == '' || date =="__/__/____")  
                 {
                 altbox("Please Enter Date");
                return false;
            }
            return true;
        }
        function Clear_Data()

        {
            document.getElementById('<%= txt_Inventory_Date.ClientID %>').value = '';  
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
        <div id='btnnew_pop' class="popup" style="display: none;">
            <span class="title">Add CS Inventory</span>
            <table align="center" id="frmfld" class="spac">
                
                <tr>
                    <td align="right">Inventory Date   
                    </td>
                    <td align="left">
                        <asp:TextBox ID="txt_Inventory_Date" runat="server" CssClass="date2" ></asp:TextBox>
                    </td>
                </tr>
                <tr>
                
                    <td align="center" colspan="2" style="padding-top:25px">
                        <asp:Button ID="btn_submit" runat="server" Text="Submit" OnClientClick="javascript:return Save_Validation();" OnClick="btn_submit_Click" />
                        <asp:Button ID="btn_clear" runat="server" Text="Clear" OnClientClick="javascript:return Clear_Data();" />
                    </td>
                </tr>
            </table>
        </div>
    </div>
    <script type="text/javascript">
        $(".date2").mask("99/99");
        $(".date2").attr("placeholder", "MM/DD");
        $(".date2").datepicker({
            changeMonth: true,
            changeYear: true,
            dateFormat: 'mm/dd'
        });
        dataIn = '"pid":"' + document.getElementById('<%= hfdperid.ClientID %>').value + '"';
        
        sa5.data = dataIn;
        sa5.process();
    </script>
</asp:Content>
