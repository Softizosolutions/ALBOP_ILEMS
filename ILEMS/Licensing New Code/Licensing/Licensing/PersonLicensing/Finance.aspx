<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="../Master Page/frm.master" CodeBehind="Finance.aspx.cs" Inherits="Licensing.PersonLicensing.Finance" %>

<asp:Content ID="content1" runat="server" ContentPlaceHolderID="ContentPlaceHolder1">
    <script type="text/javascript">
       
          function recp_error() {
            obt_change(document.getElementById('<%= ddl_paymenttype.ClientID %>'));
            altbox('Check not in logs.');
            Popup();
        }
        function recp_error1() {
            obt_change(document.getElementById('<%= ddl_paymenttype.ClientID %>'));
            altbox('Insufficient funds on check.');
            Popup();
        }
        function Popup() {
            $(function () {
                $('#btn_receptdata_pop').dialog({ title: "Add Receipt Information" });
                $('#btn_receptdata_pop').dialog("open");
            });
            return false;
        }
        function bindgrd() {
            if ($('ul').find('li').length > 0) {

                $('ul li:eq(0)').click();
            }
            $('#btnnew_pop').dialog("close");

        }
    </script>
    <script type="text/javascript">
        function Clear_button() {

            document.getElementById('<%=hfd_feeid.ClientID %>').value = '0';
            document.getElementById('<%=hfdoamount.ClientID %>').value = '0';
            document.getElementById('<%=txt_Amount.ClientID %>').value = '';
            document.getElementById('<%=ddl_lictype.ClientID %>').value = '-1';
            document.getElementById('<%=ddl_feetype.ClientID %>').value = '-1';
            document.getElementById('<%=txt_Duedate.ClientID %>').value = '';
            document.getElementById('<%=recurring.ClientID%>').style.display='none';
            document.getElementById('recurringdays').style.display='none';
            return false;
        }
        function DuedateSaveValidation() {
            if (document.getElementById('<%=txt_edit_amount.ClientID%>').value == '') {
                altbox("Please enter amount.")
                return false;
            }
        }
        function DueDateClear() {
            document.getElementById('<%=txt_edit_amount.ClientID%>').value = '';
            document.getElementById('<%=txtDueDate.ClientID%>').value='';
        }
        function Save_Validation() {
            var errormsg = validateform('frmfld');
            if (errormsg != "") {
                Msgbox(errormsg);
                return false;
            }
            return true;
        }
        function Validation() {

            if (document.getElementById('<%=ddl_paymenttype.ClientID%>').selectedIndex == 0) {
                  altbox("Please select payment type.")
                  document.getElementById('<%=ddl_paymenttype.ClientID %>').focus()
                return false;
            }

            var ctl = "";
            ctl = document.getElementById('<%=ddl_paymenttype.ClientID%>').value;

            if (ctl == "540" || ctl == "541" || ctl == "542") {
                if (document.getElementById('<%=txtchknumber.ClientID%>').value == "") {
                    altbox("Please enter cheque number.")
                    document.getElementById('<%=txtchknumber.ClientID %>').focus()
                    return false;
                }
            }
            if (ctl == "538") {
                if (document.getElementById('<%=txtmorderno.ClientID%>').value == "") {
                    altbox("Please enter money oredr number.")
                    document.getElementById('<%=txtmorderno.ClientID %>').focus()
                    return false;
                }
            }

            if (ctl == "539") {
                if (document.getElementById('<%=txtcreditcardnumber.ClientID%>').value == "") {
                    altbox("Please enter credit card number.")
                    document.getElementById('<%=txtcreditcardnumber.ClientID %>').focus()
                    return false;
                }
            }
            iszero = 1;
            $('.recp').each(function () {

                if (parseFloat($(this).val()) == 0) {
                    iszero = 0;

                }

            });
            if (iszero == 0) {
                altbox("Amount receipted cannot be zero.");
                return false;
            }
            return true;

        }
        var iszero = 1;
        function obt_change(ctl) {

            if (ctl.value == "540" || ctl.value == "541" || ctl.value == "542") {
                document.getElementById("tblst").style.display = "block";
                document.getElementById("tblst1").style.display = "none";
                document.getElementById("tblst2").style.display = "none";
            }
            else
                if (ctl.value == "538") {
                    document.getElementById("tblst").style.display = "none";
                    document.getElementById("tblst1").style.display = "none";
                    document.getElementById("tblst2").style.display = "block";
                }
                else
                    if (ctl.value == "539") {
                        document.getElementById("tblst").style.display = "none";
                        document.getElementById("tblst1").style.display = "block";
                        document.getElementById("tblst2").style.display = "none";
                    }
                    else {
                        document.getElementById("tblst").style.display = "none";
                        document.getElementById("tblst1").style.display = "none";
                        document.getElementById("tblst2").style.display = "none";
                    }
        }
    </script>
    <script type="text/javascript">


        var dataIn = '';
        var sa5 = new sagrid();
        sa5.url = "../WCFGrid/GridService.svc/BindPersonFeeDetails";

        sa5.primarykeyval = "FeeID";
        sa5.bindid = "grd_feedetails";
        //  sa5.cols = [new dcol(" ", "", "", "3", "1", "chksel", "", "15"), new dcol("Fee Type", "Feetype"), new dcol("License Type", "License_Type"), new dcol("Due Date", "DueDate"), new dcol("Fee Amount", "totdis"), new dcol("Amount Paid", "feepaiddisp"), new dcol("Balance", "bal"), new dcol("Fee Status", "Fee_Status"), new dcol("Delete", "", "", "6", "1", "Delete_lkp", "fa fa-trash-o grdicon")];
        sa5.objname = "sa5";

        function chksel(sender, keyval) {


        }
        function cnffnres_fee(result) {
            if (result == 'true')
                document.getElementById('<%= btndel.ClientID %>').click();
        }

        function Delete_lkp(sender, keyval) {
            document.getElementById('<%= hfdselid.ClientID %>').value = keyval;
            cnfbox(" Are you sure do you want to delete this record?", "cnffnres_fee");
        }
        function recpsel() {
            var chks = document.getElementById('grd_feedetails').getElementsByTagName('input');
            var selid = '';

            for (var i = 0; i < chks.length; i++) {
                if (chks[i].getAttribute("type") == "checkbox") {

                    if (chks[i].checked) {
                        var temp = chks[i].getAttribute("onclick");
                        var lind = temp.lastIndexOf(',') + 2;
                        var lind1 = temp.lastIndexOf(')') - 1;

                        temp = temp.substring(lind, lind1);

                        selid = selid + temp + ',';
                    }
                }

            }
            if (selid != '') {
                selid = selid.substring(0, selid.length - 1);

                document.getElementById('<%= hfdselfeeids.ClientID %>').value = selid;
                return true;
            }
            else {
                altbox("Please select atleast one fee");
                return false;
            }
        }

        function afterpost(msg) {
            sa5.process();
            paymenthis.process();
            voidhis.process();
            audithis.process();
            $('#btn_receptdata_pop').dialog('close');
            $('#btnnew_pop').dialog("close");
            $('#voidpay').dialog('close');
            $('#divduedate').dialog('close');
            altbox(msg);

        }
        function editduedate_lkp(sender, keyval) {

            document.getElementById('<%=hfdduedateid.ClientID%>').value = keyval;
            document.getElementById('<%=btnfeeedit.ClientID%>').click();
        }
        function Fee_EditPopup(){
            $(function () {
                $('#divduedate').dialog({ title: "Edit Amount" });
                $('#divduedate').dialog("open");
            });
        }
        function Recurring_Change(){
            
            if(document.getElementById('<%=chkrecuringfee.ClientID%>').checked==true)
                document.getElementById('recurringdays').style.display='block';
            else
                document.getElementById('recurringdays').style.display='none';
        }
    </script>
    <script type="text/javascript">


        var dataIn = '';
        var paymenthis = new sagrid();
        paymenthis.url = "../WCFGrid/GridService.svc/BindPersonpaymenthistory";

        paymenthis.primarykeyval = "Receipt_ID";
        paymenthis.bindid = "grd_Paymenthistory";
        
        paymenthis.objname = "paymenthis";
        function cnffnres(result) {
            if (result == 'true') {
                $('#voidpay').dialog({ title: "Void Transaction" });

                $('#voidpay').dialog('open');
            }
        }

        function void_lkp(sender, keyval) {
            cnfbox(" Are you sure do you want to Void this Transaction?", "cnffnres");
            document.getElementById('<%= hfdselrecid.ClientID %>').value = keyval;



        }
        function Payonline(sender, keyval) {
             var olnk = '<%= System.Configuration.ConfigurationManager.AppSettings["onlinelink"].ToString() %>';
            parent.document.getElementById('iframefinance').src = olnk+'showfee.aspx?' + sa5.resultdata[sender]["Person_ID"]+'&uid='+<%=Session["UID"].ToString()%>;
            var body=parent.document.getElementsByTagName('body');
            $(body).find('#financepopup').dialog({ title: "Finance", width: "90%"});
            $(body).find('#financepopup').dialog('open');
        }
        function print_lkp(sender, keyval) {
            var orderid = '';
            orderid = paymenthis.resultdata[sender]["Receipt_ID"]
            window.open("PyamentHist_Print.aspx?Receiptnum=" + orderid+'&pid='+document.getElementById('<%=hfdpid.ClientID%>').value);

        }
    </script>
    <script type="text/javascript">


        var dataIn = '';
        var voidhis = new sagrid();
        voidhis.url = "../WCFGrid/GridService.svc/BindPersonpaymentvoidhistory";

        voidhis.primarykeyval = "Receipt_ID";
        voidhis.bindid = "grdtabsVoidHistory";
        voidhis.cols = [new dcol("Payment Method", "PaymentType"), new dcol("Payer", "PayerID"), new dcol("Void Amount", "Amount"), new dcol("Void Reason", "VoidReason_ID"), new dcol("User", "CCHolderName"), new dcol("To", "ReceiptToName")];
        voidhis.objname = "voidhis";

    </script>
    <script type="text/javascript">


        var dataIn = '';
        var audithis = new sagrid();
        audithis.url = "../WCFGrid/GridService.svc/BindPersonpaymentaudithistory";

        audithis.primarykeyval = "FeeAudit_Id";
        audithis.bindid = "grdtabsAuditHistory";
        audithis.cols = [new dcol("Fee Type", "FeeType"), new dcol("Amount", "Amount"), new dcol("Date", "Datepaid"), new dcol("User", "user1"), new dcol("Type/Action", "TypeofAction")];
        audithis.objname = "audithis";


    </script>
    <asp:UpdatePanel ID="upd3" runat="server">
        <ContentTemplate>
            <asp:HiddenField Value="0" runat="server" ID="hfd_feeid" />
            <asp:HiddenField Value="0" runat="server" ID="hfdpid" />
            <asp:HiddenField ID="hfdreceipt" runat="server" Value="0" />
            <asp:HiddenField ID="hfdrecdetail" runat="server" Value="0" />
            <asp:HiddenField ID="hfdselfeeids" runat="server" Value="0" />
            <asp:HiddenField ID="hfdutype" runat="server" Value="0" />
            <asp:HiddenField ID="hfdduedateid" runat="server" Value="0" />
             <asp:Button ID="btnfeeedit" runat="server" Style="display: none" OnClick="btnfeeedit_Click" />
        </ContentTemplate>
    </asp:UpdatePanel>
    <div style="text-align: right; padding-right: 10px; margin-top: 0px">
    </div>
    <div style="width: 98%; margin-left: auto; margin-right: auto">
        <div class="cpanel">
            <div class="head accr expand">
                Fee Details  
            </div>
            <div class="body">
                <div style="float: right; margin-right: 10px; margin-bottom: 10px; margin-top: -3px">
                    <asp:UpdatePanel ID="updfin" runat="server">
                        <ContentTemplate>
                            <input type="button" id="btnnew" value="Add New Fee" class="poptrg" onclick="javascript: return Clear_button()" />
                            <asp:HiddenField ID="hfdselid" runat="server" Value="0" />
                            <asp:Button ID="btndel" runat="server" Style="display: none" OnClick="btndel_click" />

                            <asp:Button ID="btn_receptdata1" runat="server" OnClientClick="javascript:return recpsel()" Text="Receipt Selected" OnClick="btn_receptdata_Click" />
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
                <div id="grd_feedetails"></div>
            </div>
        </div>

        <div class="cpanel">
            <div class="head accr">
                Payment History    
            </div>
            <div class="body">

                <div id="grd_Paymenthistory"></div>
            </div>
        </div>
        <div class="cpanel">
            <div class="head accr">
                Void History   
            </div>
            <div class="body">

                <div id="grdtabsVoidHistory"></div>
            </div>
        </div>

        <div class="cpanel">
            <div class="head accr">
                Audit History   
            </div>
            <div class="body">

                <div id="grdtabsAuditHistory"></div>
            </div>
        </div>

    </div>
    <div id='btnnew_pop' class="popup" style="display: none;">
        <span class="title">Add New Fee Information</span>
        <asp:UpdatePanel ID="upd" runat="server">
            <ContentTemplate>

                <table align="center" cellpadding="5" cellspacing="5" id="frmfld">
                    <tr>
                        <td align="right">Select License Type 
                        </td>
                        <td align="left">
                            <asp:HiddenField ID="hfdoamount" runat="server" Value="0" />
                            <asp:DropDownList ID="ddl_lictype" runat="server" CssClass="required" error="Please select the license type."></asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">Fee Type 
                        </td>
                        <td align="left">
                            <asp:DropDownList ID="ddl_feetype" runat="server" CssClass="required" AutoPostBack="true" OnSelectedIndexChanged="ddl_feetype_SelectedIndexChanged" error="Please select the fee type.">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr id="recurring" runat="server">
                        <td colspan="2" align="center">
                            <asp:CheckBox ID="chkrecuringfee" runat="server" Text="&nbsp;Recurring Fee" onclick="Recurring_Change()" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <table style="width: 100%" align="center">
                                <tr id="recurringdays" style="display: none; margin-left: 65px;">
                                    <td align="right" style="width: 45%">Day
                                    </td>
                                    <td align="left">
                                        <asp:DropDownList ID="ddl_days" runat="server"></asp:DropDownList>
                                    </td>
                                </tr>
                            </table>
                        </td>

                    </tr>
                    <tr id="fnneew" runat="server" visible="false">
                        <td align="right">
                            <asp:Label ID="Label13" runat="server" Text="Number of pages:"></asp:Label>
                        </td>
                        <td align="left">
                            <div class="txboxdiv">
                                <asp:TextBox ID="txtnofpages" runat="server" onblur="javascript:calamnt(this)"></asp:TextBox>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">Amount 
                        </td>
                        <td align="left">
                            <div class="txboxdiv">
                                <script language="javascript">
                                    function calamnt(ctl) {
                                        try {
                                            document.getElementById('<%= txt_Amount.ClientID %>').value = parseFloat(ctl.value * 0.25) + 5;
                                        }
                                        catch (e) {
                                        }
                                    }
                                </script>

                                <asp:TextBox ID="txt_Amount" runat="server" placeholder="Amount"></asp:TextBox>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">Due Date 
                        </td>
                        <td align="left">
                            <asp:TextBox ID="txt_Duedate" CssClass="date" runat="server"></asp:TextBox>
                        </td>
                    </tr>

                    <tr>
                        <td colspan="2" align="center">
                            <asp:Button ID="btnsave" runat="server" Text="Save" OnClick="btnsave_Click" OnClientClick="javascript:return Save_Validation();" />
                            <asp:Button ID="bntclear" runat="server" Text="Clear" OnClientClick="javascript:return Clear_button()" />
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>

    </div>

    <div id='btn_receptdata_pop' class="popup" style="display: none;">
        <span class="title">Receipt/Receipt selected Click</span>
        <asp:UpdatePanel ID="upd2" runat="server">
            <ContentTemplate>
                <center>
                    <asp:DataList ID="dlistAmtOwed" runat="server" GridLines="Both" CssClass="gridmain" RepeatDirection="Vertical" CellPadding="0" CellSpacing="0" Width="90%">
                        <ItemTemplate>
                            <tr class="grdalt">
                                <td><%# Eval("Subobj_code") %></td>
                                <td>
                                    <%#  "$"+feebalance(Eval("tot").ToString(), Eval("fee_paid").ToString())%></td>

                                <td>
                                    <asp:HiddenField ID="hfdtot" runat="server" Value='<%#  feebalance(Eval("tot").ToString(), Eval("fee_paid").ToString()) %>' />
                                    <asp:HiddenField ID="hfddlistfeeid" runat="server" Value='<%# Eval("FeeID").ToString() %>' />
                                    <asp:TextBox ID="txtamnt" runat="server" CssClass="recp" Width="80px" Text="0.00"></asp:TextBox>
                                </td>
                            </tr>
                        </ItemTemplate>

                    </asp:DataList>
                </center>
                </fieldset>
                <table width="100%" align="center">
                    <tr>
                        <td align="right">Payer 
                        </td>
                        <td align="left">
                            <asp:TextBox ID="txt_payer" Width="200px" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">Date Paid
                        </td>
                        <td align="left">
                            <asp:TextBox ID="txt_datepaid" CssClass="date" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">Payment Type
                        </td>
                        <td align="left">
                            <asp:DropDownList ID="ddl_paymenttype" runat="server" onchange="javascript:obt_change(this)" Width="150px" CssClass="required" error="Please Select Payment Type.">
                            </asp:DropDownList>


                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <table width="100%" align="center">

                                <tr id="tblst2" style="display: none">
                                    <td align="right">
                                        <asp:Label ID="lblmorder" runat="server" Text="Money Order Number"></asp:Label>
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="txtmorderno" MaxLength="15" runat="server" placeholder="Money Order Number" CssClass="required" error="Please Enter Money Order Number."></asp:TextBox>
                                    </td>
                                </tr>

                                <tr id="tblst" style="display: none">
                                    <td align="right">
                                        <asp:Label ID="lblcred" runat="server" Text="Check Number"></asp:Label>
                                    </td>
                                    <td align="left">

                                        <asp:TextBox ID="txtchknumber" MaxLength="30" runat="server" placeholder="Check Number" error="Please Enter Check Number."></asp:TextBox>

                                    </td>

                                </tr>
                                <tr id="tblst1" style="display: none">
                                    <td align="right">
                                        <asp:Label ID="lblcreditno" runat="server" Text="Credit Card Number"></asp:Label>
                                    </td>
                                    <td align="left">

                                        <asp:TextBox ID="txtcreditcardnumber" runat="server" MaxLength="16" placeholder="Credit Card Number" error="Please Enter Credit Card Number."></asp:TextBox>

                                    </td>
                                </tr>

                            </table>
                        </td>
                    </tr>

                    <tr>
                        <td colspan="2" width="100%">
                            <table align="center">
                                <tr>
                                    <td>
                                        <asp:Button ID="btn_submit" runat="server" Text="Submit"
                                            OnClick="btn_submit_Click" OnClientClick="javascript:return Validation()" />
                                    </td>
                                    <td>
                                        <asp:Button ID="btn_clear" runat="server" Text="Clear" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    <asp:Button ID="btn_receptdata" runat="server" Style="display: none" />
    <div id="voidpay" class="popup">

        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>

                <table style="margin-left: auto; margin-right: auto">
                    <tr>
                        <td align="right">Void Reason : </td>
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
    <div id="divduedate" class="popup" style="display: none;">
        <span class="title">Edit Amount</span>
        <asp:UpdatePanel ID="upd1" runat="server">
            <ContentTemplate>
               
                <table style="width: 100%" class="spac">


                    <tr>
                        <td align="right">Amount 
                        </td>
                        <td align="left">
                            <div class="txboxdiv">
                                
                                <asp:HiddenField ID="hfdeditamount" runat="server" Value="0" />
                                <asp:HiddenField ID="hfdisedit" runat="server" Value="0" />

                                <asp:TextBox ID="txt_edit_amount" runat="server" placeholder="Amount"></asp:TextBox>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">Due Date 
                        </td>
                        <td align="left">
                            <asp:TextBox ID="txtDueDate" CssClass="date" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr id="isrecurringfee" runat="server">
                        <td colspan="2" align="center">
                            <asp:CheckBox ID="chk_edit_recurringfee" runat="server" Text="&nbsp;Recurring Fee" />
                        </td>
                    </tr>
                    <tr id="isrecurringdays" runat="server">
                        <td align="right">Day
                        </td>
                        <td align="left">
                            <asp:DropDownList ID="ddl_edit_days" runat="server"></asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td align="center" colspan="2">
                            <asp:Button ID="btnduedatesubmit" runat="server" Text="Submit" OnClick="btnduedatesubmit_Click" OnClientClick="javascript:return DuedateSaveValidation();" />&nbsp;
                            <asp:Button ID="btnduwdateclear" runat="server" Text="Clear" OnClientClick="javascript:return DueDateClear();" />
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    <script type="text/javascript">
        var utype = document.getElementById('<%= hfdutype.ClientID %>').value;
        var isedit = $('#ctl00_hfdwrite').val();
        var isdel = $('#ctl00_hfddel').val();
        if(isedit=='False'){
            $('#btnnew').addClass('hide');
            $('#ctl00_ContentPlaceHolder1_btn_receptdata1').addClass('hide');
        }
        if(isedit=='True'&&isedit=='True'){
            if (utype == "1228") {
                sa5.cols = [new dcol(" ", "", "", "3", "1", "chksel", "", "15"),  new dcol("Date Created", "Date_Created"),  new dcol("Created By", "CreatedBy"), new dcol("Fee Type", "Feetype"), new dcol("License Type", "License_Type"), new dcol("Due Date", "DueDate"), new dcol("Fee Amount", "totdis"), new dcol("Amount Paid", "feepaiddisp"), new dcol("Balance", "bal"), new dcol("Fee Status", "Fee_Status"), new dcol("Edit", "", "", "1", "1", "editduedate_lkp", "fa fa-pencil-square-o grdicon"), new dcol("Delete", "", "", "6", "1", "Delete_lkp", "fa fa-trash-o grdicon"), new dcol("Pay Online", "", "", "6", "1", "Payonline", "fa fa-usd grdicon")];
            }
            else {
                sa5.cols = [new dcol(" ", "", "", "3", "1", "chksel", "", "15"),  new dcol("Date Created", "Date_Created"),new dcol("Created By", "CreatedBy"), new dcol("Fee Type", "Feetype"), new dcol("License Type", "License_Type"), new dcol("Due Date", "DueDate"), new dcol("Fee Amount", "totdis"), new dcol("Amount Paid", "feepaiddisp"), new dcol("Balance", "bal"), new dcol("Fee Status", "Fee_Status"), new dcol("Delete", "", "", "6", "1", "Delete_lkp", "fa fa-trash-o grdicon"), new dcol("Pay Online", "", "", "6", "1", "Payonline", "fa fa-usd grdicon")];
            }
            paymenthis.cols = [new dcol("Receipt #", "Receiptnum"), new dcol("Payment Method", "PaymentType"), new dcol("Date Received", "DatePaid"), new dcol("Payer", "PayerID"), new dcol("Amount", "Amount"), new dcol("User", "CCHolderName"),new dcol("Receipt", "", "", "1", "1", "print_lkp", "fa fa-print grdicon"), new dcol("Void", "", "", "1", "1", "void_lkp", "fa fa-exclamation-triangle grdicon")];
        }
        else if(isedit=='True'){
            if (utype == "1228") {
                sa5.cols = [new dcol(" ", "", "", "3", "1", "chksel", "", "15"),  new dcol("Date Created", "Date_Created"),new dcol("Created By", "CreatedBy"), new dcol("Fee Type", "Feetype"), new dcol("License Type", "License_Type"), new dcol("Due Date", "DueDate"), new dcol("Fee Amount", "totdis"), new dcol("Amount Paid", "feepaiddisp"), new dcol("Balance", "bal"), new dcol("Fee Status", "Fee_Status"), new dcol("Edit", "", "", "1", "1", "editduedate_lkp", "fa fa-pencil-square-o grdicon"), new dcol("Pay Online", "", "", "6", "1", "Payonline", "fa fa-usd grdicon")];
            }
            else {
                sa5.cols = [new dcol(" ", "", "", "3", "1", "chksel", "", "15"),  new dcol("Date Created", "Date_Created"),new dcol("Created By", "CreatedBy"), new dcol("Fee Type", "Feetype"), new dcol("License Type", "License_Type"), new dcol("Due Date", "DueDate"), new dcol("Fee Amount", "totdis"), new dcol("Amount Paid", "feepaiddisp"), new dcol("Balance", "bal"), new dcol("Fee Status", "Fee_Status"), new dcol("Pay Online", "", "", "6", "1", "Payonline", "fa fa-usd grdicon")];
            }
            paymenthis.cols = [new dcol("Receipt #", "Receiptnum"), new dcol("Payment Method", "PaymentType"), new dcol("Date Received", "DatePaid"), new dcol("Payer", "PayerID"), new dcol("Amount", "Amount"), new dcol("User", "CCHolderName"),new dcol("Receipt", "", "", "1", "1", "print_lkp", "fa fa-print grdicon"), new dcol("Void", "", "", "1", "1", "void_lkp", "fa fa-exclamation-triangle grdicon")];
        }
        else if(isdel=='True'){
            if (utype == "1228") {
                sa5.cols = [new dcol("Fee Type", "Feetype"), new dcol("License Type", "License_Type"), new dcol("Due Date", "DueDate"), new dcol("Fee Amount", "totdis"), new dcol("Amount Paid", "feepaiddisp"), new dcol("Balance", "bal"), new dcol("Fee Status", "Fee_Status"), new dcol("Delete", "", "", "6", "1", "Delete_lkp", "fa fa-trash-o grdicon")];
            }
            else {
                sa5.cols = [new dcol(" ", "", "", "3", "1", "chksel", "", "15"), new dcol("Fee Type", "Feetype"), new dcol("License Type", "License_Type"), new dcol("Due Date", "DueDate"), new dcol("Fee Amount", "totdis"), new dcol("Amount Paid", "feepaiddisp"), new dcol("Balance", "bal"), new dcol("Fee Status", "Fee_Status"), new dcol("Delete", "", "", "6", "1", "Delete_lkp", "fa fa-trash-o grdicon")];
            }
            paymenthis.cols = [new dcol("Receipt #", "Receiptnum"), new dcol("Payment Method", "PaymentType"), new dcol("Date Received", "DatePaid"), new dcol("Payer", "PayerID"), new dcol("Amount", "Amount"), new dcol("User", "CCHolderName"),new dcol("Receipt", "", "", "1", "1", "print_lkp", "fa fa-print grdicon")];
        }
        else{
            if (utype == "1228") {
                sa5.cols = [new dcol(" ", "", "", "3", "1", "chksel", "", "15"), new dcol("Fee Type", "Feetype"), new dcol("License Type", "License_Type"), new dcol("Due Date", "DueDate"), new dcol("Fee Amount", "totdis"), new dcol("Amount Paid", "feepaiddisp"), new dcol("Balance", "bal"), new dcol("Fee Status", "Fee_Status")];
            }
            else {
                sa5.cols = [new dcol(" ", "", "", "3", "1", "chksel", "", "15"), new dcol("Fee Type", "Feetype"), new dcol("License Type", "License_Type"), new dcol("Due Date", "DueDate"), new dcol("Fee Amount", "totdis"), new dcol("Amount Paid", "feepaiddisp"), new dcol("Balance", "bal"), new dcol("Fee Status", "Fee_Status")];
            }
            paymenthis.cols = [new dcol("Receipt #", "Receiptnum"), new dcol("Payment Method", "PaymentType"), new dcol("Date Received", "DatePaid"), new dcol("Payer", "PayerID"), new dcol("Amount", "Amount"), new dcol("User", "CCHolderName"),new dcol("Receipt", "", "", "1", "1", "print_lkp", "fa fa-print grdicon")];
        }
    </script>
    <script type="text/javascript">

        dataIn = '"pid":"' + document.getElementById('<%= hfdpid.ClientID %>').value + '"';

        sa5.data = dataIn;
        sa5.process();
    </script>
    <script type="text/javascript">
        dataIn = '"pid":"' + document.getElementById('<%= hfdpid.ClientID %>').value + '"';
        paymenthis.data = dataIn;
        paymenthis.process();
    </script>
    <script type="text/javascript">
        dataIn = '"pid":"' + document.getElementById('<%= hfdpid.ClientID %>').value + '"';
        voidhis.data = dataIn;
        voidhis.process();
    </script>
    <script type="text/javascript">
        dataIn = '"pid":"' + document.getElementById('<%= hfdpid.ClientID %>').value + '"';
        audithis.data = dataIn;
        audithis.process();
    </script>
</asp:Content>

