<%@ Page Title="" Language="C#" MasterPageFile="~/Operations/Operations.Master" AutoEventWireup="true" CodeBehind="AddNewOperations.aspx.cs" Inherits="Licensing.Operations.AddNewOperations" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cntmain" runat="server">
    <script src="../Scripts/JScript.js" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">
        function afterpost(msg) {
            altbox(msg);
        }
        function Save_Validation() {
            var errormsg = validateform('frmfld');
            if (errormsg != "") {
                Msgbox(errormsg);
                return false;
            }
            return true;
        }
        function ClearSubmit() {

            document.getElementById('<%= txtdatetreceive.ClientID %>').value = '';
         document.getElementById('<%= txtaddlogfrom.ClientID %>').value = '';
         document.getElementById('<%= txtaddlogssn.ClientID %>').value = '';
         document.getElementById('<%= ddlforward.ClientID %>').value = '-1';
         document.getElementById('<%= ddlmailclerk.ClientID %>').value = '';
         document.getElementById('<%= ddlpaymenttype.ClientID %>').value = '-1';
         document.getElementById('<%= ddlsfeetype.ClientID %>').value = '-1';
         document.getElementById('<%= chk_walkin.ClientID %>').checked = false;
         document.getElementById('<%= txtamount.ClientID %>').value = '';
         document.getElementById('<%= txtspecialentry.ClientID %>').value = '';
         document.getElementById('<%= txtchecknumber.ClientID %>').value = '';

         return false;
     }
    </script>

    <div class="cpanel">
        <div class="head">
            Add New Operations
        </div>

        <div class="body">



            <div>
                <br />

                <table width="98%" align="center" class="spac" id="frmfld">

                    <tr>
                       

                        <td align="right">Name/License#</td>
                        <td align="left">
                            <asp:TextBox ID="txtaddlogfrom" runat="server" class="required" error="Please enter from." placeholder="From"></asp:TextBox>
                        </td>
                         <td align="right">Date Received</td>
                        <td align="left">
                            <asp:TextBox ID="txtdatetreceive" runat="server" class="required date" error="Please enter received date." TabIndex="0"></asp:TextBox>
                        </td>
                        <td align="right">Payer</td>
                        <td align="left">
                            <asp:TextBox ID="txtaddlogssn" runat="server" placeholder="Payer" class="required" error="Please enter payer."></asp:TextBox>
                        </td>

                    </tr>
                    <tr>
                        <td align="right">Forward To</td>
                        <td align="left">
                            <asp:DropDownList ID="ddlforward" runat="server" class="required" error="Please enter Forward to." placeholder="Forward To">
                            </asp:DropDownList>

                        </td>

                        <td align="right">Mail Clerk</td>
                        <td align="left">
                            <asp:DropDownList ID="ddlmailclerk" runat="server" class="required" error="Please select mail clerk.">
                            </asp:DropDownList>

                        </td>
                        <td align="right">Payment Type</td>


                        <td align="left">
                            <asp:DropDownList ID="ddlpaymenttype" runat="server" onchange="javascript:obt_change1(this)" class="required" error="Please select payment type."></asp:DropDownList>
                        </td>

                    </tr>
                    <tr>


                        <td align="right" id="amount" >Amount</td>
                        <td align="left">
                            <table id="amounttext" >
                                <tr>
                                    <td valign="top">
                                        <asp:TextBox ID="txtamount" runat="server" placeholder="Amount"></asp:TextBox>
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td align="right">
                            <table style="display: none" id="checknu" align="right" class="spac">
                                <tr>
                                    <td align="right">
                                        <asp:Label ID="lblcred" runat="server" Text=""></asp:Label>
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td align="left">
                            <table style="display: none" id="checknum" class="spac">
                                <tr>
                                    <td align="left">
                                        <asp:TextBox ID="txtchecknumber" runat="server"></asp:TextBox></td>
                                </tr>
                            </table>
                        </td>
                        <td colspan="2">
                            <table>
                                <tr>
                                    <td align="center">
                                        <asp:CheckBox ID="chk_walkin" runat="server" TextAlign="Right" Text="Walk-in?" onclick="feetype()" />
                                    </td>
                                    <td align="left">
                                        <table style="display: none;" id="feetype" class="spac">
                                            <tr>
                                                <td align="left">Fee Type
                                                </td>
                                                <td align="left">
                                                    <asp:DropDownList ID="ddlsfeetype" runat="server">
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>

                                </tr>
                            </table>
                        </td>

                    </tr>


                    <tr>
                        <td colspan="6">

                            <asp:TextBox ID="txtspecialentry" runat="server" TextMode="MultiLine" placeholder="Enter Special Entries" Height="30px" Width="98%"></asp:TextBox>

                        </td>

                    </tr>
                    <script language="javascript">
                        function obt_change1(ctl) {

                            if (ctl.value == "543") {

                                document.getElementById('amount').style.display = "none";
                                document.getElementById('amounttext').style.display = "none";
                            }
                            else {

                                document.getElementById('amount').style.display = "block";
                                document.getElementById('amounttext').style.display = "block";
                            }


                            if (ctl.value == "541" || ctl.value == "538" || ctl.value == "539" || ctl.value == "540" || ctl.value == "542") {
                                document.getElementById('checknu').style.display = "block";
                                if (document.getElementById('checknu').style.display == "block")
                                    document.getElementById('checknum').style.display = "block";

                                if (ctl.value == "541" || ctl.value == "540" || ctl.value == "542") {
                                    document.getElementById('<%= lblcred.ClientID %>').innerText = "Check #";
                            document.getElementById('<%=txtchecknumber.ClientID%>').placeholder = "Check Number";
                        }
                        else
                            if (ctl.value == "538") {
                                document.getElementById('<%= lblcred.ClientID %>').innerText = "Money Order Number";
                                document.getElementById('<%=txtchecknumber.ClientID%>').placeholder = "Money Order Number";
                            }
                            else
                                if (ctl.value == "539") {
                                    document.getElementById('<%= lblcred.ClientID %>').innerText = "Credit Card Number";
                                    document.getElementById('<%=txtchecknumber.ClientID%>').placeholder = "Credit Card Number";
                                }
                    }

                    else {
                        document.getElementById('checknu').style.display = "none";
                        document.getElementById('checknum').style.display = "none";

                    }

                }
                function feetype() {

                    if (document.getElementById('<%= chk_walkin.ClientID %>').checked == true)
                        document.getElementById('feetype').style.display = "block";
                    else {
                        document.getElementById('feetype').style.display = "none";
                        document.getElementById('<%=ddlsfeetype.ClientID%>').value = "-1";
                    }
                        
                }


                    </script>



                    <tr>
                        <td align="center" colspan="6">
                            <table align="center" class="spac">
                                <tr>
                                    <td>
                                        <asp:Button ID="btnaddlog" runat="server" Text="Save" OnClick="btnaddlog_Click" OnClientClick="javascript:return Save_Validation();" /></td>
                                    <td>
                                        <asp:Button ID="btnaddlogClear" runat="server" Text="Clear" OnClientClick="javascript:return ClearSubmit();" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>

                </table>
                <br />
                <br />

            </div>
        </div>
    </div>
    <script>
        $("#" + '<%= txtaddlogfrom.ClientID %>').focus();
    </script>
</asp:Content>
