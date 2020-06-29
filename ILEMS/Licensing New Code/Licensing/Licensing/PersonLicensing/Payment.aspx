<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="../Master Page/frm.master" CodeBehind="Payment.aspx.cs" Inherits="Licensing.PersonLicensing.Payment" %>

<asp:Content ID="content1" runat="server" ContentPlaceHolderID="ContentPlaceHolder1">

    <script type="text/javascript">


        var dataIn = '';
        var sa5 = new sagrid();
        sa5.url = "../WCFGrid/GridService.svc/BindPersonpayment";

        sa5.primarykeyval = "Receipt_ID";
        sa5.bindid = "grd_Paymenthistory";
        sa5.cols = [new dcol("Receipt #", "PayerID"), new dcol("Payment Method", "PaymentType"), new dcol("Date Received", "UserName"), new dcol("Payer", "PayerID"), new dcol("Amount Recd", "Amount"), new dcol("User", "CCHolderName"), new dcol("IsVoid", "IsVoid"), new dcol("ISRefund", "ISRefund"), new dcol("From", "ReReceiptFrom"), new dcol("Edit", "", "", "1", "1", "edit_lkp", "fa fa-pencil-square-o grdicon"), new dcol("Delete", "", "", "1", "1", "Delete_lkp", "fa fa-trash-o grdicon")];
        sa5.objname = "sa5";
        sa5.data = dataIn;
        
        function edit_lkp(sender, keyval) {

        }
        function Delete_lkp(sender, keyval) {
            if (confirm("are you sure do you want to delete this record?")) {

            }
        }


    </script>
    <script type="text/javascript">


        var dataIn = '';
        var sa5 = new sagrid();
        sa5.url = "../WCFGrid/GridService.svc/BindPersonpaymentvoid";

        sa5.primarykeyval = "Receipt_ID";
        sa5.bindid = "grdtabsVoidHistory1";
        sa5.cols = [new dcol("Payment Method", "PaymentType"), new dcol("Payer", "PayerID"), new dcol("Void Amount", "Amount"), new dcol("Void Reason", "VoidReason_ID"), new dcol("User", "CCHolderName"), new dcol("To", "ReceiptToName"), new dcol("Edit", "", "", "1", "1", "edit_lkp", "fa fa-pencil-square-o grdicon"), new dcol("Delete", "", "", "1", "1", "Delete_lkp", "fa fa-trash-o grdicon")];
        sa5.objname = "sa5";
        sa5.data = dataIn;
        
        function edit_lkp(sender, keyval) {

        }
        function Delete_lkp(sender, keyval) {
            if (confirm("are you sure do you want to delete this record?")) {

            }
        }


    </script>
    <script type="text/javascript">


        var dataIn = '';
        var sa5 = new sagrid();
        sa5.url = "../WCFGrid/GridService.svc/BindPersonpaymentaudit";

        sa5.primarykeyval = "FeeAudit_Id";
        sa5.bindid = "grdtabsAuditHistory1";
        sa5.cols = [new dcol("Fee Type", "FeeType"), new dcol("Amount", "Amount"), new dcol("Date", "Datepaid"), new dcol("User", "user1"), new dcol("Type/Action", "TypeofAction"), new dcol("Edit", "", "", "1", "1", "edit_lkp", "fa fa-pencil-square-o grdicon"), new dcol("Delete", "", "", "1", "1", "Delete_lkp", "fa fa-trash-o grdicon")];
        sa5.objname = "sa5";
        sa5.data = dataIn;
       
        function edit_lkp(sender, keyval) {

        }
        function Delete_lkp(sender, keyval) {
            if (confirm("are you sure do you want to delete this record?")) {

            }
        }


    </script>
    <asp:HiddenField ID="hfdpid" runat="server" Value="0" />

    <fieldset>
        <legend>Payment History</legend>
        <asp:GridView ID="grd_Paymenthistory" CssClass="gridmain" runat="server" AutoGenerateColumns="false" Width="90%" BorderWidth="1">
            <RowStyle CssClass="grditem" />
            <AlternatingRowStyle CssClass="grdalt" />
            <HeaderStyle CssClass="grdheadbg" />
            <Columns>
                <asp:TemplateField HeaderText="Receipt #">
                    <ItemTemplate>
                        <asp:HiddenField ID="hfd_rectid" runat="server" Value='<%# Eval("Receipt_ID") %>' />
                        <asp:Label ID="lbl_payer" runat="server" Text='<%# Eval("PayerID").ToString() %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Payment Method">
                    <ItemTemplate>
                        <asp:Label ID="lbl_paymntmethod" runat="server" Text='<%# Eval("PaymentType").ToString() %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Date Received">
                    <ItemTemplate>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Payer">
                    <ItemTemplate>
                        <asp:Label ID="lbl_amount" runat="server" Text='<%# Eval("PayerID").ToString() %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Amount Recd">
                    <ItemTemplate>
                        <asp:Label ID="lbl_amount" runat="server" Text='<%# Eval("Amount").ToString() %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="User">
                    <ItemTemplate>
                        <asp:Label ID="lbl_amount" runat="server" Text='<%# Eval("CCHolderName").ToString() %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="IsVoid">
                    <ItemTemplate>
                        <asp:Label ID="lbl_isvoid" runat="server" Text='<%# Eval("IsVoid").ToString() %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="ISRefund">
                    <ItemTemplate>
                        <asp:Label ID="lbl_refund" runat="server" Text='<%# Eval("ISRefund").ToString() %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="From">
                    <ItemTemplate>
                        <asp:Label ID="lbl_refundfrm" runat="server" Text='<%# Eval("ReReceiptFrom").ToString() %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Mark As Bad Payment">
                    <ItemTemplate>
                        Mark As Bad Payment
                    </ItemTemplate>
                </asp:TemplateField>
                <%--  <asp:TemplateField HeaderText="Delete">
                                <ItemTemplate>
                                    <asp:LinkButton ID="lbl_del" runat="server" CommandName="Delete" Text="Delete"></asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>--%>
            </Columns>
        </asp:GridView>
        <div id="grd_Paymenthistory"></div>
    </fieldset>
    <br />

    <fieldset>
        <legend>Void History</legend>
        <asp:GridView ID="grdtabsVoidHistory1" CssClass="gridmain" runat="server" AutoGenerateColumns="false" Width="90%" BorderWidth="1">
            <RowStyle CssClass="grditem" />
            <AlternatingRowStyle CssClass="grdalt" />
            <HeaderStyle CssClass="grdheadbg" />
            <Columns>
                <asp:TemplateField HeaderText="LMS Receipt#">
                    <ItemTemplate>
                        <asp:HiddenField ID="hfdgrdhistoryid" runat="server" Value='<%# Eval("Receipt_ID") %>' />
                        <asp:HiddenField ID="hfdgrd1histnurfeeid" runat="server" Value='<%# Eval("FeeID") %>' />
                        <asp:Label ID="lbl_payer" runat="server" Text='<%# Eval("Receiptnum").ToString() %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Payment Method">
                    <ItemTemplate>
                        <asp:Label ID="lbl_paymntmethod" runat="server" Text='<%# Eval("PaymentType").ToString() %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Payer">
                    <ItemTemplate>
                        <asp:Label ID="lbl_amount" runat="server" Text='<%# Eval("PayerID").ToString() %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Void Amount">
                    <ItemTemplate>
                        <asp:Label ID="lbl_amount" runat="server" Text='<%# Eval("Amount").ToString() %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Void Reason">
                    <ItemTemplate>
                        <asp:Label ID="lbl_amount" runat="server" Text='<%# Eval("VoidReason_ID").ToString() %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="User">
                    <ItemTemplate>
                        <asp:Label ID="lbl_isvoid" runat="server" Text='<%# Eval("CCHolderName").ToString() %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <%--<asp:TemplateField HeaderText="Re-Receipt" Visible="false">
                                    <ItemTemplate>
                                        <a style="cursor: hand;" onclick="javascript:return rerecupt('<%# Eval("Nurse_Receipt_ID") %>')">
                                            <asp:Label ID="lbllnkrereciptpay" runat="server" Text="Re-Receipt"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField> --%>
                <asp:TemplateField HeaderText="To">
                    <ItemTemplate>
                        <asp:Label ID="lbl_refundfrm" runat="server" Text='<%# Eval("ReceiptToName").ToString() %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
        <div id="grdtabsVoidHistory1"></div>
    </fieldset>
    <br />
    <fieldset>
        <legend>Audit History</legend>
        <asp:GridView ID="grdtabsAuditHistory1" CssClass="gridmain" runat="server" AutoGenerateColumns="false" Width="90%" BorderWidth="1">
            <RowStyle CssClass="grditem" />
            <AlternatingRowStyle CssClass="grdalt" />
            <HeaderStyle CssClass="grdheadbg" />
            <Columns>
                <asp:TemplateField HeaderText="Fee Type">
                    <ItemTemplate>
                        <asp:Label ID="lbl_feetype" runat="server" Text='<%# Eval("FeeType").ToString() %>'></asp:Label>
                        <asp:HiddenField ID="hdnaudithisid" runat="server" Value='<%# Eval("FeeAudit_Id") %>' />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Amount">
                    <ItemTemplate>
                        <asp:Label ID="lbl_amount" runat="server" Text='<%# Eval("Amount").ToString() %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Date">
                    <ItemTemplate>
                        <asp:Label ID="lbl_date" runat="server" Text='<%# Eval("Datepaid").ToString() %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="User">
                    <ItemTemplate>
                        <asp:Label ID="lbl_user" runat="server" Text='<%# Eval("user1").ToString() %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Type/Action">
                    <ItemTemplate>
                        <asp:Label ID="lbl_typeofaction" runat="server" Text='<%# Eval("TypeofAction").ToString() %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
        <div id="grdtabsAuditHistory1"></div>
    </fieldset>



</asp:Content>
