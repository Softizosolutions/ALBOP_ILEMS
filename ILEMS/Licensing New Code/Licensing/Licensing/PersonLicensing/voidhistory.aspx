<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="../Master Page/frm.master" CodeBehind="voidhistory.aspx.cs" Inherits="Licensing.PersonLicensing.voidhistory" %>
<asp:Content ID="content1" runat="server" ContentPlaceHolderID="ContentPlaceHolder1">

     <script type="text/javascript">


         var dataIn = '';
         var sa5 = new sagrid();
         sa5.url = "../WCFGrid/GridService.svc/BindPersonpaymentvoidhistory";

         sa5.primarykeyval = "Receipt_ID";
         sa5.bindid = "grdtabsVoidHistory";
         sa5.cols = [new dcol("Payment Method", "PaymentType"), new dcol("Payer", "PayerID"), new dcol("Void Amount", "Amount"), new dcol("Void Reason", "VoidReason_ID"), new dcol("User", "CCHolderName"), new dcol("To", "ReceiptToName")];
         sa5.objname = "sa5";
         sa5.data = dataIn;
         sa5.process();
         function edit_lkp(sender, keyval) {

         }
         function Delete_lkp(sender, keyval) {
             if (confirm("are you sure do you want to delete this record?")) {

             }
         }


    </script>
  

      <asp:HiddenField ID="hfdpid" runat="server" Value="0" />
    <fieldset>
            <legend>Void History</legend>            
        <div id="grdtabsVoidHistory"></div>
       </fieldset>
         <script type="text/javascript">
             dataIn = '"pid":"' + document.getElementById('<%= hfdpid.ClientID %>').value + '"';
             sa5.data = dataIn;
             sa5.process();
         </script>
    </asp:Content>