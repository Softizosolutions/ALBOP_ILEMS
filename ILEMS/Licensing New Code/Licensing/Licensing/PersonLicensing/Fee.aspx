<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="../Master Page/frm.master" CodeBehind="Fee.aspx.cs" Inherits="Licensing.PersonLicensing.Fee" %>

<asp:Content ID="content1" runat="server" ContentPlaceHolderID="ContentPlaceHolder1">
    <script type="text/javascript">
        function Popup() {
            $(function () {
                $('#btn_receptdata_pop').dialog({ title: "Add Receipt Information" });
                $('#btn_receptdata_pop').dialog("open");
            });
            return false;
        }
    </script>
    <script language="javascript">



        function Clear() {

            document.getElementById('<%=ddl_paymenttype.ClientID %>').value = '-1';
            document.getElementById('<%=txtcreditcardnumber.ClientID %>').value = '';
            document.getElementById('<%=txtchknumber.ClientID %>').value = '';


            return false;
        }
        function Validation() {

            if (document.getElementById('<%=ddl_paymenttype.ClientID%>').selectedIndex == 0) {
                 altbox("Please select Payment type.")
                document.getElementById('<%=ddl_paymenttype.ClientID %>').focus()
                return false;
            }

            var ctl = "";
            ctl = document.getElementById('<%=ddl_paymenttype.ClientID%>').value;

            if (ctl == "538" || ctl == "540" || ctl == "541" || ctl == "542") {
                if (document.getElementById('<%=txtchknumber.ClientID%>').value == "") {
                     altbox("Please enter cheque number.")
                    document.getElementById('<%=txtchknumber.ClientID %>').focus()
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
            return true;

        }
        function obt_change(ctl) {

            if (ctl.value == "538" || ctl.value == "540" || ctl.value == "541" || ctl.value == "542") {
                document.getElementById("tblst").style.display = "block";
                document.getElementById("tblst1").style.display = "none";

            }
            else
                if (ctl.value == "539") {
                    document.getElementById("tblst").style.display = "none";
                    document.getElementById("tblst1").style.display = "block";

                }
                else {
                    document.getElementById("tblst").style.display = "none";
                    document.getElementById("tblst1").style.display = "none";
                }
        }

        function Get_chkitems() {

            var ctls = document.getElementsByTagName("input");

            var sa = "";
            for (var i = 0; i < ctls.length; i++) {
                if (ctls[i].type == "checkbox") {

                    if (ctls[i].checked == true)
                        sa += document.getElementById(ctls[i].id.replace("chkselect", "hfd_feeid")).value + ",";

                }
            }
            if (sa != "") {
                document.getElementById('sat').value = sa.substring(0, sa.length - 1);

                return true;
            }
            else {
                 altbox("Select Fee Details For Receipt");
                return false;
            }
        }



        function payername11(id, val) {

            //document.getElementById('editdel').click();
            document.getElementById('sat').value = id;

            // document.getElementById('btnMaintainAuditHistory').click();

            return true;
        }




    </script>
    <script type="text/javascript">


        var dataIn = '';
        var sa5 = new sagrid();
        sa5.url = "../WCFGrid/GridService.svc/BindPersonFeeDetails";

        sa5.primarykeyval = "FeeID";
        sa5.bindid = "grd_feedetails1";
        sa5.cols = [new dcol(" ", "", "", "3", "1", "chksel", "", "15"), new dcol("Fee Type", "Feetype"), new dcol("License Type", "License_Type"), new dcol("Due Date", "DueDate"), new dcol("Fee Amount", "totdis"), new dcol("Amount Paid", "feepaiddisp"), new dcol("Balance", "bal"), new dcol("Fee Status", "Fee_Status")];
        sa5.objname = "sa5";

        function chksel(sender, keyval) {


        }
        function recpsel() {
            var chks = document.getElementById('grd_feedetails1').getElementsByTagName('input');
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
                 altbox("Please Select Atleast one Fee");
                return false;
            }
        }
        


    </script>
    <div style="text-align: center; padding-right: 10px; margin-top: 0px">
        <asp:HiddenField ID="sat" runat="server" />
        <asp:HiddenField ID="hfdreceipt" runat="server" Value="0" />
        <asp:HiddenField ID="hfdrecdetail" runat="server" Value="0" />
        <asp:HiddenField ID="hfd_feeaudID" runat="server" Value="0" />
        <asp:UpdatePanel ID="upd1" runat="server">
            <ContentTemplate>
                <asp:Button ID="btn_receptdata1" runat="server" OnClientClick="javascript:return recpsel()" Text="Receipt Selected" OnClick="btn_receptdata_Click" />

                <asp:HiddenField ID="hfdpid" runat="server" Value="0" />
                <asp:HiddenField ID="hfdselfeeids" runat="server" Value="0" />
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    <div id="grd_feedetails1"></div>



    <div id='btn_receptdata_pop' class="popup" style="display: none;">
        <span class="title">Receipt/Receipt selected Click</span>
        <asp:UpdatePanel ID="upd2" runat="server">
            <ContentTemplate>
                 <fieldset>
                    <legend>Amount Owed</legend>
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
                                        <asp:TextBox ID="txtamnt" runat="server" Width="80px" Text="0.00"></asp:TextBox>
                                    </td>
                                </tr>
                            </ItemTemplate>

                        </asp:DataList>
                    </center>
                </fieldset>
                <table width="100%" align="center">
                    <tr>
                        <td align="right">Payer :
                        </td>
                        <td align="left">
                            <asp:TextBox ID="txt_payer" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">Date Paid :
                        </td>
                        <td align="left">
                            <asp:TextBox ID="txt_datepaid" CssClass="date" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">Payment Type :
                        </td>
                        <td align="left">
                            <asp:DropDownList ID="ddl_paymenttype" runat="server" onchange="javascript:obt_change(this)" Width="150px">
                            </asp:DropDownList>


                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <table width="100%" align="center">



                                <tr id="tblst" style="display: none">
                                    <td align="right">
                                        <asp:Label ID="lblcred" runat="server" Text="Check Number :"></asp:Label>
                                    </td>
                                    <td align="left">

                                        <asp:TextBox ID="txtchknumber" runat="server" MaxLength="6"></asp:TextBox>

                                    </td>

                                </tr>
                                <tr id="tblst1" style="display: none">
                                    <td align="right">
                                        <asp:Label ID="lblcreditno" runat="server" Text="Credit Card Number :"></asp:Label>
                                    </td>
                                    <td align="left">

                                        <asp:TextBox ID="txtcreditcardnumber" runat="server" MaxLength="14"></asp:TextBox>

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
                                        <asp:Button ID="btn_clear" runat="server" Text="Clear" OnClientClick="javascript:return Clear()" />
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
    <script type="text/javascript">

        dataIn = '"pid":"' + document.getElementById('<%= hfdpid.ClientID %>').value + '"';

        sa5.data = dataIn;
        sa5.process();
    </script>
</asp:Content>
