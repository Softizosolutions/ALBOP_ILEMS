<%@ Page Language="C#" AutoEventWireup="true"  MasterPageFile="../Master Page/frm.master" CodeBehind="Paymenthistory.aspx.cs" Inherits="Licensing.PersonLicensing.Paymenthistory" %>

<asp:Content ID="content1" runat="server" ContentPlaceHolderID="ContentPlaceHolder1">

     <script type="text/javascript">


         var dataIn = '';
         var sa5 = new sagrid();
         sa5.url = "../WCFGrid/GridService.svc/BindPersonpaymenthistory";

         sa5.primarykeyval = "Receipt_ID";
         sa5.bindid = "grd_Paymenthistory1";
         sa5.cols = [new dcol("Receipt #", "PayerID"), new dcol("Payment Method", "PaymentType"), new dcol("Date Received", "DatePaid"), new dcol("Payer", "PayerID"), new dcol("Amount", "Amount"), new dcol("User", "CCHolderName"), new dcol("Void", "", "", "1", "1", "void_lkp", "fa fa-exclamation-triangle grdicon")];
         sa5.objname = "sa5";
       
         
         function void_lkp(sender, keyval) {
             if (confirm("Are you sure do you want to Void this Transaction?")) {
                 document.getElementById('<%= hfdselrecid.ClientID %>').value = keyval;
                 $('#voidpay').dialog({ title: "Void Transaction" });
                 
                 $('#voidpay').dialog('open');
             }
         }


    </script>
  

      <asp:HiddenField ID="hfdpid" runat="server" Value="0" />
    <fieldset>
            <legend>Payment History</legend>            
        <div id="grd_Paymenthistory1"></div>
       </fieldset>
       <div id="voidpay" class="popup" >
       
       <asp:UpdatePanel ID="upd" runat="server" >
       <ContentTemplate>
       
       <table style="margin-left:auto;margin-right:auto">
       <tr>
       <td align="right" >Void Reason : </td>
       <td align="left"> 
       <asp:DropDownList ID="ddlvoidres" runat="server"></asp:DropDownList>
       <asp:HiddenField ID="hfdselrecid" runat="server" Value="0" />
       </td>
       </tr>
       <tr>
       <td colspan="2" align="center">
       <asp:Button ID="btnvoid" runat="server" OnClick="void_trans" Text="Void Transaction" />
       </td>
       </tr>
       </table>
       </ContentTemplate>
       </asp:UpdatePanel>
       </div>
         <script type="text/javascript">
             function aftervoid() {
                  altbox('Void Transaction Completed');
                 dataIn = '"pid":"' + document.getElementById('<%= hfdpid.ClientID %>').value + '"';
                 sa5.data = dataIn;
                 sa5.process();
               $('#voidpay').dialog('close');
             }
             dataIn = '"pid":"' + document.getElementById('<%= hfdpid.ClientID %>').value + '"';
             sa5.data = dataIn;
             sa5.process();
         </script>
    </asp:Content>