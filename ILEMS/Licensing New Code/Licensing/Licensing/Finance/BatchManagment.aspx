<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BatchManagment.aspx.cs" Inherits="Licensing.Finance.BatchManagment" MasterPageFile="~/Finance/Finance.Master" %>

<%--<!DOCTYPE html>--%>

<asp:Content ID="cnt" ContentPlaceHolderID="cntmain" runat="server">

     <script language="javascript" type="text/javascript">
         function CallPrint() {


             var prtContenttbl = document.getElementById('transprint');

             var prtmtbl = '<link href="../Styles/product.css" media="print" rel="stylesheet" type="text/css" />';

             var WinPrint = window.open('', '', 'left=0,top=0,width=900,height=600');
             WinPrint.document.write(prtmtbl + prtContenttbl.innerHTML);
             WinPrint.document.close();
             WinPrint.focus();
             WinPrint.print();
              
             return false;
         }
         function Clear_Values() {
             document.getElementById('<%=ddluser.ClientID%>').value = "-1";
             document.getElementById('<%=txtBatch.ClientID%>').value = "";
             document.getElementById('<%=txtreceipt.ClientID%>').value = "";
             document.getElementById('<%=ddlbatchstatus.ClientID%>').value = "-1";
             document.getElementById('<%=txtCreatedFrom.ClientID%>').value = "";
             document.getElementById('<%=txtCreatedTo.ClientID%>').value = "";
             document.getElementById("grd_batchtransation").innerHTML = "";
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
         sa5.url = "../WCFGrid/GridService.svc/BindBatchManagement";

         sa5.primarykeyval = "Batchnum";
         sa5.bindid = "grd_batchtransation";
         sa5.cols = [new dcol("Batch #", "Batchnum"), new dcol("Amount", "Amount"), new dcol("# Of Trans", "noftrans"), new dcol("User", "UserName"), new dcol("Status", "status"), new dcol("Select", "", "", "1", "1", "Select_lkp", "fa fa-hand-o-up grdicon")];
         sa5.objname = "sa5";
         sa5.aftercall = "Aftercall";
         function bindbatch() {
             
        dataIn="";
        var user = document.getElementById('<%= ddluser.ClientID %>').value;
         dataIn = dataIn + '"user":"' + user+'",'
         var batch = document.getElementById('<%= txtBatch.ClientID %>').value;
         dataIn = dataIn + '"batch":"' + batch + '",'
         var receipt = document.getElementById('<%= txtreceipt.ClientID %>').value;
         dataIn = dataIn + '"receipt":"' + receipt + '",'
         var bastatus = document.getElementById('<%= ddlbatchstatus.ClientID %>').value;
          
             dataIn = dataIn + '"bstatus":"' + bastatus + '",'
         var createdfrom = document.getElementById('<%= txtCreatedFrom.ClientID %>').value;
         dataIn = dataIn + '"createdfrom":"' + createdfrom + '",'
         var createdto = document.getElementById('<%= txtCreatedTo.ClientID %>').value;
         dataIn = dataIn + '"createdto":"' + createdto + '"'
       
             sa5.data = dataIn;
             sa5.process();

             return false;
         }
         function Aftercall() {
             var trs = sa5.resultdata;
             if (trs.length > 0) {
                 return true;
             }
             else {
                 altbox("No results found.");
                 document.getElementById("grd_batchtransation").innerHTML = "";
                 return false;
             }
         }
         function afterclose() {
             bindbatch();
    altbox("Batch close sucessfully.");
             $('#batchres').dialog('close');
           
            
         }
         function Select_lkp(sender, keyval) {
             var temptbl = document.getElementById('grd_batchtransation').getElementsByTagName('table')[0].getElementsByTagName('tbody')[0];
             var tr = temptbl.rows[sender];

             bindtransaction(keyval, tr.cells[2].innerText, tr.cells[1].innerText, tr.cells[3].innerText, tr.cells[4].innerText);
            
           }
           function Print_lkp(sender, keyval) {
                
           }


      </script>
    
<script language="javascript">
     

function Search_Validation() {
    var batch;
   
    batch = document.getElementById('<%= txtBatch.ClientID %>').value;
           
    if (batch == "")
    {
                altbox("Enter batch number.");
               return false;
           }
           return true;
       }
function BatchSearchvalidate()
{

    var err = "";
    var srch_count = 0;
    if (Value_Checked('<%= txtBatch.ClientID %>', "1") != "1")
     srch_count = srch_count + 1;
 if (Value_Checked('<%= txtreceipt.ClientID %>', "1") != "1")
          srch_count = srch_count + 1;

      if (Value_Checked('<%= txtCreatedFrom.ClientID %>', "1") != "1")
          srch_count = srch_count + 1;
      if (Value_Checked('<%= txtCreatedTo.ClientID %>', "1") != "1")
          srch_count = srch_count + 1;
      if (document.getElementById('<%= ddlbatchstatus.ClientID %>').value != "-1") {
          if (Value_Checked('<%= ddlbatchstatus.ClientID %>', "1") != "1")
          srch_count = srch_count + 1;
  }
    
          srch_count = srch_count + 1;
  


    if (srch_count == 0)
        err = err + "Please select atleast one criteria for search.\r\n";
    if (err != "") {
         altbox(err);
        return false;
    }

    bindbatch();
    return false;
}


                                        </script>
                                         <script type="text/javascript">
                                             var sa6 = new sagrid();
                                             var dataIn1 = "";
                                             var selbatch = "";
                                             function bindtransaction(batchno,noftrans,amount,user,bstatus) {
                                                   dataIn1 = '"batchno":"'+batchno+'"';
                                                   selbatch = batchno;
                                                 sa6.url = "../WCFGrid/GridService.svc/BindBatchTransaction";
                                                 sa6.ispaging = false;
                                                 sa6.primarykeyval = "Receiptnum";
                                                 sa6.bindid = "grd_batchmanagement";
                                                 sa6.cols = [new dcol("Receipt #", "Receiptnum"), new dcol("Payer", "PayerID"), new dcol("Payment Type", "PaymentType"), new dcol("Check/MO#", "Checknum"), new dcol("Amount Rec", "Amount")];
                                                 sa6.objname = "sa6";
                                                 sa6.data = dataIn1;
                                                 sa6.aftercall = "openpopnof";
                                                 sa6.process();
                                                 document.getElementById('<%= hfdselbatch.ClientID %>').value = batchno;
                                                 document.getElementById('grdheadtrans').innerHTML = "<p style='font-weight:bold;font-size:11pt;'> Transaction Details Of&nbsp;:&nbsp;" + batchno + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;# Of Trans&nbsp;:&nbsp;" + noftrans + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Amount&nbsp;:&nbsp;" + amount + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;user&nbsp;:&nbsp;" + user + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Status&nbsp;:&nbsp;" + bstatus+"</p>";
                                                if (bstatus == 'Open')
                                                 document.getElementById('<%= btnclosebatch.ClientID %>').style.display = 'inline-block';
                                                 else
                                                 document.getElementById('<%= btnclosebatch.ClientID %>').style.display = 'none';

                                             }
                                             function openpopnof() {

                                                 $('#batchres').dialog({ title: "Batch Results For : " + selbatch,width:"70%" });
                                                 $('#batchres').dialog('open');
                                                
                                             }


      </script>
      <asp:HiddenField ID="hfdselbatch" runat="server" Value="" />
       <div id="batchres" class="popup" style="text-align:center;margin-left:auto;margin-right:auto">
                 <div id="transprint">
                 <span id="grdheadtrans"></span>
                  <div id="grd_batchmanagement"></div>
                  </div>
                  <br />
                  <asp:UpdatePanel ID="upd1" runat="server">
                  <ContentTemplate>
                 
                   <asp:Button ID="btnclosebatch" style="display:none" runat="server" Text="Close Batch" onclick="batch_close" />
                  
                  <asp:Button ID="btnprint" runat="server" Text="Print" OnClientClick="javascript:return CallPrint()" />
                  </ContentTemplate>
                  </asp:UpdatePanel>
                  </div>
<div class="cpanel">
<div class="head">
         Batch Management
       </div>
      
      <div class="body">

   
   <table width="100%" 
class="spac" >
                    <tr>
                        <td align="right">User </td>
                        <td align="left">
                            <asp:DropDownList ID="ddluser" runat="server">
                            </asp:DropDownList>
                        </td>
                        <td align="right">Batch #</td>
                        <td align="left">
                            <asp:TextBox ID="txtBatch" runat="server" placeholder="Batch"></asp:TextBox>
                        </td>
                        <td align="right">Receipt # </td>
                        <td align="left">
                            <asp:TextBox ID="txtreceipt" runat="server" placeholder="Receipt"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">Batch Status </td>
                        <td align="left">
                            <asp:DropDownList ID="ddlbatchstatus" runat="server">
                            </asp:DropDownList>
                        </td>
                        <td align="right">Created From </td>
                        <td align="left">
                            <asp:TextBox ID="txtCreatedFrom" runat="server" CssClass="date" ></asp:TextBox>
                        </td>
                        <td align="right">To</td>
                        <td align="left">
                            <asp:TextBox ID="txtCreatedTo" runat="server"  CssClass="date"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td align="center" colspan="6">
                               <br />
                            <table>
                                <tr>
                                    <td>
                                     
                                        <asp:Button ID="btnbatchsearch" runat="server"  OnClientClick="javascript:return BatchSearchvalidate();" OnClick="btnbatchsearch_Click" Text="Search" />
                                    </td>
                                    <td>
                                        <asp:Button ID="btnbatchclear" runat="server" OnClientClick="javascript:return Clear_Values();" Text="Clear" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
                  </div>
                  </div>
                  <div class="cpanel">
                  <div class="head">
         Batch Management
       </div>
      
      <div class="body">
                  <div id="grd_batchtransation"></div>
                 
    </div>
         </div>
</asp:Content>
