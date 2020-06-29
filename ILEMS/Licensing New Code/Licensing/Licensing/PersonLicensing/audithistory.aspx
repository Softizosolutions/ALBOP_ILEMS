<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="../Master Page/frm.master" CodeBehind="audithistory.aspx.cs" Inherits="Licensing.PersonLicensing.audithistory" %>
<asp:Content ID="content1" runat="server" ContentPlaceHolderID="ContentPlaceHolder1">

      <script type="text/javascript">


          var dataIn = '';
          var sa5 = new sagrid();
          sa5.url = "../WCFGrid/GridService.svc/BindPersonpaymentaudithistory";

          sa5.primarykeyval = "FeeAudit_Id";
          sa5.bindid = "grdtabsAuditHistory";
          sa5.cols = [new dcol("Fee Type", "FeeType"), new dcol("Amount", "Amount"), new dcol("Date", "Datepaid"), new dcol("User", "user1"), new dcol("Type/Action", "TypeofAction")];
          sa5.objname = "sa5";
          sa5.data = dataIn;
          sa5.process();

    </script>
  

      <asp:HiddenField ID="hfdpid" runat="server" Value="0" />
    <fieldset>
            <legend>Audit History</legend>            
        <div id="grdtabsAuditHistory"></div>
       </fieldset>
         <script type="text/javascript">
             dataIn = '"pid":"' + document.getElementById('<%= hfdpid.ClientID %>').value + '"';
             sa5.data = dataIn;
             sa5.process();
         </script>
    </asp:Content>