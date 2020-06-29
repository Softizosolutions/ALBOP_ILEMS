<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Finance_VerifyBatch.aspx.cs" Inherits="Licensing.Finance.Finance_VerifyBatch" MasterPageFile="~/Finance/Finance.Master" %>
  
<asp:Content ID="cnt" ContentPlaceHolderID="cntmain" runat="server">
     
  
    

    <script language ="javascript" >

        function Clear() {

            document.getElementById('<%=txtstartdate.ClientID %>').value = '';
            document.getElementById('<%=Txtenddate.ClientID %>').value = '';
            document.getElementById("grd_verifybatch").innerHTML = "";
            return false;
        }
        function totaloftypes()
        {

            var s1 = document.getElementById('<%= txtcash.ClientID %>').value;
            var s2 = document.getElementById('<%= txtchecks.ClientID %>').value;
            var s3 = document.getElementById('<%= txtmoneyorders.ClientID %>').value;
            var s4 = document.getElementById('<%= txtcreditcard.ClientID %>').value;
            var s5 = document.getElementById('<%= lbltotoftypes_get.ClientID %>');
            s5.innerText = parseFloat(parseFloat(s1) + parseFloat(s2) + parseFloat(s3) + parseFloat(s4));
         }

        function verifymsg()
        {
             var tottypes = parseFloat(document.getElementById('<%= txtcash.ClientID %>').value) + parseFloat(document.getElementById('<%= txtchecks.ClientID %>').value) + parseFloat(document.getElementById('<%= txtmoneyorders.ClientID %>').value) + parseFloat(document.getElementById('<%= txtcreditcard.ClientID %>').value);
             var tot = parseFloat(document.getElementById('<%= lbltotal_get.ClientID %>').innerText);
            if (tottypes != tot)
            {
               altbox("Verified totals don't equal the batch totals.");
              document.getElementById('<%= txtcash.ClientID %>').value = "0";
              document.getElementById('<%= txtchecks.ClientID %>').value = "0";
              document.getElementById('<%= txtmoneyorders.ClientID %>').value = "0";
              document.getElementById('<%= txtcreditcard.ClientID %>').value = "0";
              document.getElementById('<%= lbltotoftypes_get.ClientID %>').innerText = "0";
              document.getElementById('<%= txtcash.ClientID %>').focus();
              return false;
           }
        }

       
    </script>
     <script type="text/javascript">


         var dataIn = '';
         var sa5 = new sagrid();
         sa5.url = "../WCFGrid/GridService.svc/BindverifyBatchTransaction";

         sa5.primarykeyval = "Batchnum";
         sa5.bindid = "grd_verifybatch";
         sa5.cols = [new dcol("Batch #", "Batchnum"), new dcol("Amount", "Amount"), new dcol("# Of Trans", "noftrans"), new dcol("User", "UserName"), new dcol("Status", "BatchStatus"), new dcol("Select", "", "", "1", "1", "Select_lkp", "fa fa-hand-o-up grdicon")];
         sa5.objname = "sa5";
         sa5.aftercall = "Aftercall";
         function bindbatch() {
             dataIn = '"sdate":"' + document.getElementById('<%= txtstartdate.ClientID %>').value + '","edate":"' + document.getElementById('<%= Txtenddate.ClientID %>').value + '"';

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
                 document.getElementById("grd_verifybatch").innerHTML = "";
                 return false;
             }
         }
         function afterverify() {
             altbox("Batch verify completed.");
             bindbatch();
             $('.popup').each(function(   ) {
   $(this).dialog("close");
});
             
         }
         function Select_lkp(sender, keyval) {
             
             var temptbl = document.getElementById('grd_verifybatch').getElementsByTagName('table')[0].getElementsByTagName('tbody')[0];
             var tr = temptbl.rows[sender];
            
             bindtransaction(keyval, tr.cells[2].innerText, tr.cells[1].innerText, tr.cells[3].innerText, tr.cells[4].innerText);

         }

      </script>
     <script type="text/javascript">
         var sa6 = new sagrid();
         var dataIn1 = "";
         var selbatch = "";
         function bindtransaction(batchno, noftrans, amount, user, bstatus) {
             dataIn1 = '"batchno":"' + batchno + '"';
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
             document.getElementById('<%= lbltotal_get.ClientID %>').innerText = amount;
             document.getElementById('<%= hfdselbatch.ClientID %>').value = batchno;
             document.getElementById('grdheadtrans').innerHTML = "<p style='font-weight:bold;font-size:11pt;'> Transaction Details Of&nbsp;:&nbsp;" + batchno + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;# Of Trans&nbsp;:&nbsp;" + noftrans + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Amount&nbsp;:&nbsp;" + amount + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;user&nbsp;:&nbsp;" + user + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Status&nbsp;:&nbsp;" + bstatus + "</p>";
             if (bstatus == 'Unverified')
                 document.getElementById('<%= btnclosebatch.ClientID %>').style.display = 'inline-block';
             else
                 document.getElementById('<%= btnclosebatch.ClientID %>').style.display = 'none';

         }
         function openpopnof() {
             $('#batchres').dialog({ title: "Batch Results For : " + selbatch, width: '70%' });
             $('#batchres').dialog('open');
           
         }

         function openverifybatch() {
             $('#btnret_pop').dialog({ title: "Verify Batch " + document.getElementById('<%= hfdselbatch.ClientID %>').value, position: ['center', 'middle'] });
            
             $('#btnret_pop').dialog("open");
             return false;
         }

         function Save_Validation() {
             var errormsg = validateform('frmfld');
             if (errormsg != "") {
                 Msgbox(errormsg);
                 return false;
                
             }
             bindbatch();
             return false;

         }


         
      </script>
 
   

      <asp:HiddenField ID="hfdselbatch" runat="server" Value="" />
       <div id="batchres" class="popup" style="text-align:center;margin-left:auto;margin-right:auto">
                 <div id="transprint">
                 <span id="grdheadtrans"></span>
                  <div id="grd_batchmanagement"></div>
                  </div>
                  <br />
                 
                 
                   <asp:Button ID="btnclosebatch"   runat="server" Text="Verify Batch" OnClientClick="javascript:return openverifybatch()"   />
                  
                  <asp:Button ID="btnprint" runat="server" Text="Print" OnClientClick="javascript:return CallPrint()" />
                  
                  </div>
    <div style="width: 100%; margin-left: auto; margin-right: auto">
        
       <div class="cpanel">
 <div class="head">
     Unverified Batches
       </div>
      
      <div class="body">

          
                       <table  style="margin-left:auto;margin-right:auto" width="60%" class="spac" id="frmfld">
                                <tr>
                                    <td align="right">
                                        Start Date 
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="txtstartdate" runat="server" CssClass="date required" placeholder="Start Date" error="Please enter start date."></asp:TextBox>
                                    </td>
                                    <td align="right">
                                        End Date 
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="Txtenddate" runat="server" CssClass="date required" placeholder="End Date" error="Please enter end date."></asp:TextBox>
                                    </td>
                                    <td align="left">
                                       <asp:Button ID="btn_Search" runat="server" Text="Search"   OnClientClick="javascript:return Save_Validation();" />
                                    </td>
                                    <td align="left">
                                      <asp:Button ID="btn_Clear" runat="server" Text="Clear"  OnClientClick="javascript:return Clear();"  />
                                   </td>
                                </tr>
                            </table>
                          
                     </div>
                     </div>
                            <div class="cpanel">
 <div class="head">
    Result
       </div>
      
      <div class="body">
                       <div id="grd_verifybatch"></div> 
</div>
</div>
         
        <br />
         <asp:Button ID="btnverifybatchpopup" runat="server" style="display:none;" />
        
        
         <div id='btnret_pop' class="popup" style="display: none;">
<span class="title">Verify</span>    
    
            <br />
          
                   <asp:UpdatePanel ID="upd1" runat="server">
                   <ContentTemplate>
                               
             <table width="100%" align="center" class="spac">


                 <tr>
                     <td align="right">
                         <asp:Label ID="Label4" runat="server" Text="Cash :"></asp:Label></td>
                     <td>

                         <asp:TextBox ID="txtcash" runat="server" onblur="javascript:totaloftypes();" Text="0"></asp:TextBox>
                     </td>

                     </tr>
                 <tr>
                     <td align="right">
                         <asp:Label ID="Label5" runat="server" Text="Checks :"></asp:Label></td>
                     <td>

                         <asp:TextBox ID="txtchecks" runat="server" onblur="javascript:totaloftypes();" Text="0"></asp:TextBox>
                     </td>

                 </tr>

                 <tr>
                     <td align="right">
                         <asp:Label ID="Label9" runat="server" Text="Money Orders :"></asp:Label>
                     </td>
                     <td>

                         <asp:TextBox ID="txtmoneyorders" runat="server" onblur="javascript:totaloftypes();" Text="0"></asp:TextBox>
                     </td>
                     </tr>
                 <tr>

                     <td align="right">
                         <asp:Label ID="Label1" runat="server" Text="Credit Cards :"></asp:Label>
                     </td>
                     <td>

                         <asp:TextBox ID="txtcreditcard" onblur="javascript:totaloftypes();" Text="0" runat="server"></asp:TextBox>
                     </td>
                 </tr>

                 <tr>
                     <td align="right">
                         <asp:Label ID="Label2" runat="server" Text="Total Of Types :"></asp:Label>
                     </td>
                     <td>
                         <asp:Label ID="lbltotoftypes_get" runat="server" Text=""></asp:Label>
                     </td>
                     </tr>
                 <tr>
                     <td align="right">
                         <asp:Label ID="Label3" runat="server" Text="Total :"></asp:Label>
                     </td>
                     <td>
                         <asp:Label ID="lbltotal_get" runat="server" Text=""></asp:Label>
                     </td>
                 </tr>

                 <tr>
                     <td align="center" colspan="2">

                         <asp:Button ID="btnVerifyBatchOK" OnClientClick="javascript:return verifymsg();" runat="server" OnClick="btnVerifyBatchOK_Click"
                             Text="Submit" />


                         <asp:Button ID="btnVerifyBatchCancel" runat="server" Text="Clear" />


                     </td>
                 </tr>


             </table>
                          </ContentTemplate>
                   </asp:UpdatePanel>                    
                                          
                                   
            <br />
      
             </div>
  
    </div>
    <script language="javascript">

        function open_verify(batchid)
        {
             
           
        }
        
      </script>
           
</asp:Content>
