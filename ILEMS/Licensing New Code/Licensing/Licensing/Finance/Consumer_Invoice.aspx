<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Finance/Finance.Master"
    CodeBehind="Consumer_Invoice.aspx.cs" Inherits="Licensing.Finance.Consumer_Invoice" %>

<%--<!DOCTYPE html>--%>
<asp:Content ID="cnt" ContentPlaceHolderID="cntmain" runat="server">
    <script language="javascript">
        function printfrm() {
             var x = document.getElementById("frm");
            var y = x.contentWindow || x.contentDocument;
            if (y.document) 
            y = y.document;
           
            
            var WinPrint = window.open('', '', 'left=0,top=0,width=900,height=600');
            WinPrint.document.write(y.getElementById('form1').innerHTML);
            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.print();
              
            return false;
        }
        function Validation() {
        }
        function addlineitem() {

            var feetype = $("#" + '<%= ddlfeetype.ClientID %>' + " option:selected").text();
            var feedid = $("#" + '<%= ddlfeetype.ClientID %>' + " option:selected").val();
            var amount = $("#" + '<%= txtnewinvoceamt.ClientID %>').val();
            var duedt = $("#" + '<%= txtduedt.ClientID %>').val();
             
            if (feedid != "-1" && amount != "" && duedt!='') {
                var tr = document.createElement("tr");
                var td = document.createElement("td");
                td.innerText = feetype;
                tr.appendChild(td);

                td = document.createElement("td");
                td.innerText = amount;
                tr.appendChild(td);
              

                td = document.createElement("td");
                td.innerText = duedt;
                tr.appendChild(td);

                td = document.createElement("td");
                td.innerHTML = '<input type="hidden" value="' + feedid + '" /><i onclick="delete_fee(this)" class="fa fa-trash-o grdicon"></i>';

                tr.appendChild(td);
                var tbody = document.getElementById('feelineitems').getElementsByTagName('tbody')[0];
                tbody.appendChild(tr);
                $("#" + '<%= ddlfeetype.ClientID %>').val('-1');
                $("#" + '<%= txtnewinvoceamt.ClientID %>').val('');
                $("#" + '<%= txtduedt.ClientID %>').val('');
            }
            else {
                var errormsg = validateform('frmfld1');
                if (errormsg != "") {
                    Msgbox(errormsg);
                    // addlineitem()
                    return false;
                }
                return false;
            }
            return false;
        }
        var tempctl = null;
        function cnffnres(result, ctl) {
            if (result == 'true')
                var seltr = $(tempctl).closest('tr')[0];
            document.getElementById('feelineitems').deleteRow(seltr.rowIndex);
            tempctl = null;
          }
          function delete_fee(ctl) {
              tempctl = ctl;
            cnfbox(" Are you sure do you want to delete this record?", "cnffnres")
            
        }
        function beforesubmit() {
            var errormsg = validateform('frmfld');
            if (errormsg != "") {
                Msgbox(errormsg);
                return false;
            }
            var temp = '';
            var trs = document.getElementById('feelineitems').getElementsByTagName('tbody')[0].getElementsByTagName('tr');
            for (var i = 0; i < trs.length; i++) {
                var feeid = trs[i].getElementsByTagName('input')[0].value;
                temp = temp + feeid + "~" + trs[i].cells[1].innerText+ "~" + trs[i].cells[2].innerText + "^";
            }
            if (temp != "") {
                temp = temp.substring(0, temp.length - 1);
                document.getElementById('<%= hfdsellines.ClientID %>').value = temp;
            }
            else {
                altbox("Please add atleast one line item.");
                return false;
            }
            return true;
        }
        function aftersave(latid) {
            document.getElementById('frm').src = './Print_ConsumerInvoice.aspx?invid=' + latid;
            $('#printrec').dialog({ title: "Print Consumer Invoice" });
            $('#printrec').dialog("open");
            altbox('Information saved.');
            document.getElementById('feelineitems').getElementsByTagName('tbody')[0].innerHTML = '';
        }
    </script>

    

   
    
<div class="cpanel">
 <div class="head">
    Consumer Invoice
       
 
       </div>
      
      <div class="body">

    
    <div>
      
        <asp:HiddenField ID="hfdsellines" runat="server" Value="" />
       
        <table width="90%" style="margin-left:auto;margin-right:auto" class="spac" cellpadding="5" cellspacing="5" id="frmfld">
            <tr>
                <td align="right" width="18%">
                    <asp:Label ID="lblbillto" runat="server" Text="Bill To Name" ></asp:Label>&nbsp;&nbsp;
                </td>
                <td align="left">
                    <asp:TextBox ID="txtconsumerinvoicename" runat="server" CssClass="required" placeholder="Bill To Name" error="Please enter bill to name."></asp:TextBox>
                </td>
                <td align="right">
                    <asp:Label ID="Label15" runat="server" Text="License #"></asp:Label>
                </td>
                <td align="left">
                    <asp:TextBox ID="txtsubscriber" runat="server"  CssClass="required" placeholder="License #" error="Please enter license number."></asp:TextBox>
                </td>
                
            </tr>
            <tr>
                <td align="right">
                    <asp:Label ID="lbladdress" runat="server" Text="Address1"></asp:Label>
                </td>
                <td align="left" >
                    <asp:TextBox ID="txtconsumeraddress1" runat="server"  CssClass="required" placeholder="Address 1" error="Please enter address1."></asp:TextBox>
                </td>
                <td align="right">
                    <asp:Label ID="Label1" runat="server" Text="Address2"></asp:Label>
                </td>
                <td align="left" >
                    <asp:TextBox ID="txtconsumeraddress2" runat="server"   placeholder="Address 2"></asp:TextBox>
                </td>
               
            </tr>
            <tr>
                <td colspan="4" align="center">
                <table width="90%" cellpadding="5" cellspacing="5" >
                <tr>
                 <td align="right" width="14%">
                    <asp:Label ID="Label13" runat="server" Text="City"></asp:Label>
                </td>
                <td align="left">
                    <asp:TextBox ID="txtreccity" runat="server" CssClass="required" placeholder="City" error="Please enter city."></asp:TextBox>
                </td>
                 <td align="right" width="18%">
                    <asp:Label ID="Label2" runat="server" Text="State"></asp:Label>
                </td>
                <td align="left">
                    <asp:DropDownList ID="ddlrecstate" runat="server" CssClass="required" error="Please select state." >
                    </asp:DropDownList>
                </td>
                    </tr><tr>
                <td align="right">
                    <asp:Label ID="Label3" runat="server" Text="Zip"></asp:Label>
                </td>
                <td align="left">
                    <asp:TextBox ID="txtreczip" CssClass="zip required" runat="server" error="Please enter zip."></asp:TextBox>
                </td>
                </tr>
                </table>
                </td>
               
                
            </tr>
        </table>

        <asp:UpdatePanel ID="upd" runat="server">
                  <ContentTemplate>
                            <table   align="center" class="spac" id="frmfld1">
                                <tr>
                                    <td align="right">
                                        <asp:Label ID="Label4" runat="server" Text="Fee Type "></asp:Label>
                                    </td>
                                    <td align="left">
                                        <asp:DropDownList ID="ddlfeetype" runat="server" CssClass="required" OnSelectedIndexChanged="ddlfeetype_SelectedIndexChanged"
                                          error="Please select feeType."  AutoPostBack="true">
                                        </asp:DropDownList>
                                    </td>
                                    <td align="right" class="Labels">
                                        <asp:Label ID="Label6" runat="server" Text="Amount" ></asp:Label>
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="txtnewinvoceamt" runat="server" placeholder="Amount"></asp:TextBox>
                                    </td>
                                    <td align="right">
                                    Due Date
                                    </td>
                                    <td align="left">
                                    <asp:TextBox ID="txtduedt" runat="server"  error="Please enter date." CssClass="date required"></asp:TextBox>
                                    </td>
                                    <td>
                                        <asp:Button ID="btnlineitem" runat="server" Text="Add Line Item"  OnClientClick="javascript:return addlineitem();" />
                                    </td>
                                </tr>
                            </table>
                      </ContentTemplate>
                  </asp:UpdatePanel>
          <br />
        <table id="feelineitems" width="80%" class="gridmain1" style="margin-left: auto;margin-right: auto" class="spac">
                        <thead>
                            <tr class="grdheadbg">
                                <td>
                                    Fee Type
                                </td>
                                <td>
                                    Amount
                                </td>
                                <td>
                                    Due Date
                                </td>
                                <td width="50px">
                                    Delete
                                </td>
                            </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
        
        
        
        <table style="margin-left: auto; margin-right: auto" class="spac" align="center">
            <tr>
                <td>
                    <asp:Button ID="btnnewinvoceOK" runat="server" Text="Submit" OnClick="btnnewinvoceOK_Click"
                        OnClientClick="javascript:return beforesubmit();" />
                </td>
                <td align="center">
                    <asp:Button ID="btnconsumercancel" runat="server" Text="Clear" OnClientClick="javascript:return invocancel();"  OnClick="btnconsumercancel_Click"/>
                </td>
            </tr>
        </table>
        
    </div>
    <div id="printrec" class="popup">
    <i class="fa fa-print fa-4x grdicon" style="float:right;margin-right:10px" onclick="javascript:return printfrm()"></i>
     
    <br />
    <iframe id="frm" width="500px" height="400px" frameborder="0" ></iframe>
    
    </div>
    </div>
    </div>
</asp:Content>
