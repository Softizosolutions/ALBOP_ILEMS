<%@ Page Title="" Language="C#" MasterPageFile="~/Operations/Operations.Master" AutoEventWireup="true" CodeBehind="SearchOperations.aspx.cs" Inherits="Licensing.Operations.SearchOperations" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cntmain" runat="server">

    <script src="../Scripts/JScript.js" language="javascript" type="text/javascript"></script>

    <script type="text/javascript">
        var dataIn = '';
        var sa6 = new sagrid();
        sa6.url = "../WCFGrid/GridService.svc/Getaddloghistory";
        sa6.ispaging = false;
        sa6.isfilters = false;
        sa6.primarykeyval = "changedon";
        sa6.bindid = "grdhistory";
        sa6.cols = [new dcol("Old Value", "Old_Value"), new dcol("New Value", "New_Value"), new dcol("Changed By", "changedby"), new dcol("Changed On", "changedon")];
        sa6.objname = "sa6";
        sa6.aftercall = "openpop";
        function openhistory(sender,keyval)
        {
            var d = '"logid":"' + keyval + '"';
            sa6.data = d;
            sa6.process();

        }
        function openpop()
        {
            $('#hispop').dialog({ title: "Log History", width: "80%" });
            $('#hispop').dialog('open');
        }
        var dataIn = '';
        var sa5 = new sagrid();
        sa5.url = "../WCFGrid/GridService.svc/Bindsearchoperations";

        sa5.primarykeyval = "Add_log_ID";
        sa5.bindid = "grd_searchlogdata";
        sa5.cols = [new dcol("Date Received", "Date_Received"), new dcol("From", "From_Received"), new dcol("Payer", "SSN"), new dcol("Forward To", "Forward_To"), new dcol("Mail Clerk", "MailClerk"), new dcol("Special Entries", "SpecialEntries"), new dcol("Payment Type", "Payment_Type"), new dcol("Check Number", "CheckNumber"), new dcol("Amount", "Amount"), new dcol("Edit", "", "", "1", "1", "edit_lkp", "fa fa-pencil-square-o grdicon"), new dcol("Print", "", "", "1", "1", "openreciept", "fa fa-print grdicon"), new dcol("History", "", "", "1", "1", "openhistory", "fa fa-hand-o-up grdicon"), new dcol("Delete", "", "", "1", "1", "delkp", "fa fa-trash-o grdicon")];
        sa5.objname = "sa5";
        sa5.aftercall = "Aftercall";
        function BindOperation() {
            dataIn = "";
            var date = document.getElementById('<%=txtdatetreceive.ClientID%>').value;
            dataIn = dataIn + '"date":"' + date + '",'
            var sender = document.getElementById('<%=txtfromsender.ClientID%>').value;
            dataIn = dataIn + '"fromsender":"' + sender + '",'
            var frwd = document.getElementById('<%=ddlfrwd.ClientID%>').value;
            dataIn = dataIn + '"frwd":"' + frwd + '",'
            var mail = document.getElementById('<%=ddlsmailclerk.ClientID%>').value;
            dataIn = dataIn + '"smilclerk":"' + mail + '",'
            var walkin = document.getElementById('<%=chkswalkin.ClientID%>').checked;         
           
            dataIn = dataIn + '"walk":"' + walkin + '",'
            var ssn = document.getElementById('<%=txtslicense.ClientID%>').value;
            dataIn = dataIn + '"license":"' + ssn + '",'
            var checkmo = document.getElementById('<%=txt_checkmo.ClientID%>').value;
            dataIn = dataIn + '"checkormo":"' + checkmo + '"'
            sa5.data = dataIn;
            sa5.process();
            return false;
        }
        function Value_Checked(Ctr_Name, Error_Message) {
            if (document.getElementById(Ctr_Name).value.trim() == "") {

                return Error_Message;
            }
            return "";
        }
        function edit_lkp(sender, keyval) {

            document.getElementById('<%= hfdselid.ClientID %>').value = keyval;
            document.getElementById('<%= btnedit.ClientID %>').click();
        }
        function cnffnres(result) {
            if(result=='true')
                document.getElementById('<%= btndel.ClientID %>').click();
       }
        function Delete_lkp(sender, keyval) {
            document.getElementById('<%= hfdselid.ClientID %>').value = keyval;
            cnfbox(" Are you sure do you want to delete this record?", "cnffnres");
            
                
            }
        function cnffnres1(results) {
        if (results == 'true')
            document.getElementById('<%= btndelete.ClientID %>').click();
    }
    function Afterdel() {
        altbox('Record Deleted.');
        sa5.process();

    }
    function delkp(sender, keyval) {
      
        document.getElementById('<%= hfdselid.ClientID %>').value = keyval;
        cnfbox(" Are you sure you want to Delete this Record? ", "cnffnres1");
    }
        function Value_Checked(Ctr_Name, Error_Message) {
            if (document.getElementById(Ctr_Name).value.trim() == "") {

                return Error_Message;
            }
            return "";
        }
        function Value_Checked_checkbox(Ctr_Name, Error_Message) {
            if (document.getElementById(Ctr_Name).checked == false) {
                return Error_Message;
            }
        }
        function Aftercall() {
            var trs = sa5.resultdata;
            if (trs.length > 0) {
                return true;
            }
            else {
                altbox("No results found.");
                document.getElementById("grd_searchlogdata").innerHTML = "";
                return false;
            }
        }
      </script>

    <script language="javascript">

        var selpname = "";
        function afterupdate() {
             altbox('Log updated successfully.');
            BindOperation();
            $('#btnret_pop').dialog("close");
        }
        function Openapplication()
        {
          $('#btnret_pop').dialog({title:'Edit Log Information'});
                $('#btnret_pop').dialog("open");
                 
        }

        function openreciept(sender,addlogid)
        {

            window.open('../Operations/Addlog_paymentreciept.aspx?addlogid=' + addlogid, 'Print', 'left=10,top=10,width=900,height=650,toolbar=0,scrollbars=0,status=0');

            return false;
        }
        function viewlogSearchvalidate() {
         
            var err = "";
            var srch_count = 0;
            if (Value_Checked('<%= txtdatetreceive.ClientID %>', "1") != "1")
                srch_count = srch_count + 1;
            if (Value_Checked('<%= txtslicense.ClientID %>', "1") != "1")
                 srch_count = srch_count + 1;

             if (Value_Checked('<%= txtfromsender.ClientID %>', "1") != "1")
                 srch_count = srch_count + 1;
            if (Value_Checked('<%= txt_checkmo.ClientID %>', "1") != "1")
                 srch_count = srch_count + 1;
             if (document.getElementById('<%= ddlsmailclerk.ClientID %>').value != "-1") {
                 if (Value_Checked('<%= ddlsmailclerk.ClientID %>', "1") != "1")
                    srch_count = srch_count + 1;
             }
            if (Value_Checked_checkbox('<%=chkswalkin.ClientID %>', "1") != "1")
                srch_count = srch_count + 1;
             if (document.getElementById('<%= ddlfrwd.ClientID %>').value != "-1") {
                 if (Value_Checked('<%= ddlfrwd.ClientID %>', "1") != "1")
                     srch_count = srch_count + 1;
             }
            if (srch_count == 0)
                err = err + "Please select atleast one criteria for search.\r\n";
            if (err != "") {
                 altbox(err);
                return false;
            }
            BindOperation();
            return false;
        }
        function SearchlogClear() {
            document.getElementById('<%=ddlsmailclerk.ClientID%>').value = "-1";
            document.getElementById('<%=ddlfrwd.ClientID%>').value = "-1";
            document.getElementById('<%=txtdatetreceive.ClientID%>').value = "";
            document.getElementById('<%=txtslicense.ClientID%>').value = "";
            document.getElementById('<%=txtfromsender.ClientID%>').value = "";
            document.getElementById('<%=txt_checkmo.ClientID%>').value = "";
            document.getElementById('<%=chkswalkin.ClientID%>').checked = false;
            document.getElementById('grd_searchlogdata').innerHTML = '';
            return false;
        }
        function AddLogClear() {
            document.getElementById('<%=txtdatetreceiveedit.ClientID%>').value = "";
            document.getElementById('<%=txtaddlogfrom.ClientID%>').value = "";
            document.getElementById('<%=txtaddlogssn.ClientID%>').value = "";
            document.getElementById('<%=ddlforward.ClientID%>').value = "-1";
            document.getElementById('<%=ddlmailclerk.ClientID%>').value = "-1";
            document.getElementById('<%=txtspecialentry.ClientID%>').value = "";
            document.getElementById('<%=ddlpaymenttype.ClientID%>').value = "-1";
            document.getElementById('<%=txtamount.ClientID%>').value = "";
            document.getElementById('<%=txtchecknumber.ClientID%>').value = "";
            document.getElementById('<%=chk_walkin.ClientID%>').checked = false;
            document.getElementById('<%=ddlfeetype.ClientID%>').value = "-1";
        }
    </script>
    <div id="hispop" class="popup">
        <div id="grdhistory">

        </div>
    </div>
    <div class="cpanel">
 <div class="head">
   Add log Search
       </div>
      
      <div class="body">

    
    <asp:UpdatePanel ID="upd" runat="server">
    <ContentTemplate>
    
     <asp:HiddenField ID="hfdselid" runat="server" Value="0" />
   <asp:Button ID="btnedit" runat="server" style="display:none" OnClick="btnedit_click" />
     <asp:Button ID="btndel" runat="server" style="display:none" OnClick="btndel_click" />
        <asp:Button ID="btndelete" runat="server" style="display:none" OnClick="btndel_click1" />
         
 
  </ContentTemplate>
  </asp:UpdatePanel>
  <div id='btnret_pop' class="popup" style="display: none;">
        <span class="title">Edit Log</span>
        <asp:UpdatePanel ID="upd2" runat="server">
        <ContentTemplate>
        
        <table width="100%" class="spac">
            <tr>
                <td align="right" >Date Received  
                </td>
                <td align="left">
                    <asp:TextBox ID="txtdatetreceiveedit" CssClass="date" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td align="right">From
                </td>
                <td align="left">
                    <asp:TextBox ID="txtaddlogfrom" runat="server"></asp:TextBox>                                       
                </td>
            </tr>
            <tr>
                <td align="right">Payer 
                </td>
                <td align="left">
                    <asp:TextBox ID="txtaddlogssn"  runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td align="right">Forward To 
                </td>
                <td align="left">
                    <asp:DropDownList ID="ddlforward" runat="server">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td align="right">Mail Clerk
                </td>
                <td align="left">
                    <asp:DropDownList ID="ddlmailclerk" runat="server">
                    </asp:DropDownList>
                </td>
            </tr>

            <tr>
                <td align="right">Special Entries 
                </td>
                <td align="left">
                    <asp:TextBox ID="txtspecialentry" runat="server" placeholder="Special Entries"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td align="right">Payment Type </td>
                <td align="left">
                    <asp:DropDownList ID="ddlpaymenttype" runat="server" onchange="javascript:obt_change1(this)">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td align="right" width="30%">Amount</td>
                <td align="left">
                    <asp:TextBox ID="txtamount" runat="server" Width="145px"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td align="left">
                    <table style="display: none" id="checknu" runat="server" align="right">
                        <tr>
                            <td align="right">
                                <asp:Label ID="lblcred" runat="server" Text=""></asp:Label>
                            </td>
                        </tr>
                    </table>
                </td>

                <td>
                    <table style="display: none" id="checknum" runat="server">
                        <tr>
                            <td align="left">
                                <asp:TextBox ID="txtchecknumber" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                    </table>

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



                    if (ctl.value == "541" || ctl.value == "538" || ctl.value == "540" || ctl.value == "542") {
                        // document.getElementById('checknu').style.display = "block";
                        // if (document.getElementById('checknu').style.display == "block")
                        //   document.getElementById('checknum').style.display = "block";
                        document.getElementById('<%= checknu.ClientID %>').style.display = "block"
                        if (document.getElementById('<%= checknu.ClientID %>').style.display = "block")
                            document.getElementById('<%= checknum.ClientID %>').style.display = "block"
                        if (ctl.value == "541" || ctl.value == "540" || ctl.value == "542")
                            document.getElementById('<%= lblcred.ClientID %>').innerText = "Check #";
                        else
                            if (ctl.value == "538")
                                document.getElementById('<%= lblcred.ClientID %>').innerText = "Money Order Number";


                    }

                    else {
                        document.getElementById('<%= checknu.ClientID %>').style.display = "none"
                        document.getElementById('<%= checknum.ClientID %>').style.display = "none"

                    }

                }
                function feetype() {

                    if (document.getElementById('<%= chk_walkin.ClientID %>').checked == true)
                        document.getElementById('feetype').style.display = "block";
                    else
                        document.getElementById('feetype').style.display = "none";
                }


            </script>

            <tr>
                <td colspan="2" align="center">
                    <asp:CheckBox ID="chk_walkin" runat="server" TextAlign="Right" Text="Walk-in?" onclick="feetype()" />
                </td>
            </tr>
            <tr style="display: none;" id="feetype">
                <td colspan="2">
                    <table>
                        <tr>
                            <td>Fee Type
                            </td>
                            <td align="left">
                                <asp:DropDownList ID="ddlfeetype" runat="server">
                                </asp:DropDownList>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>

            <tr>
                <td colspan="2">&nbsp;
                </td>
            </tr>
            <tr>
                <td colspan="2" align="center">
                    <table cellpadding="0" cellspacing="0" align="center">
                        <tr>

                            <td>
                                <asp:Button ID="btnupdateaddlog" runat="server" Text="Update" OnClick="btnupdateaddlog_Click"/>
                            </td>
                            <td>
                                <asp:Button ID="btnaddlogcancel" runat="server"
                                    Text="Clear" Width="108px" OnClientClick="javascript:return AddLogClear();"/>
                                 <asp:HiddenField ID="hfdautoid" runat="server" Value="0" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        </ContentTemplate>
        </asp:UpdatePanel>
    </div>
        <br />
         <asp:Label ID="lbladdlogid" runat="server" Text="" Visible="false"></asp:Label>
           
        <table style="margin-left:auto;margin-right:auto" class="spac">
            <tr>
                <td align="center" >Date
                </td>
              
                <td align="center" >Mail Clerk
                </td>
               
                <td align="center" >Forward To
                </td>
                     <td align="center"  >Payer
                </td>
                  <td align="center"  >Name/License#
                </td>
                <td align="center">Check#/MO#</td>
                <td align="center">
                Only Walk-ins
                </td>
                
                         
                </tr>

           <tr>           
               
                  <td align="left">

                    <asp:TextBox ID="txtdatetreceive" runat="server" class="required date"></asp:TextBox> </td>

           
                 <td align="left">
                    <asp:DropDownList ID="ddlsmailclerk" runat="server" class="required">
                    </asp:DropDownList>
                    </td>
                     <td align="left">
                    <asp:DropDownList ID="ddlfrwd" runat="server" class="required">
                    </asp:DropDownList>
                    </td>
                     <td align="left">
                    <asp:TextBox ID="txtslicense" runat="server" class="required" placeholder="Payer"></asp:TextBox>


                </td>

            
              
                <td align="left">

                    <asp:TextBox ID="txtfromsender" runat="server" class="required" placeholder="Name/License #"></asp:TextBox>


                </td>
               <td align="left"><asp:TextBox ID="txt_checkmo" runat="server" placeholder="Check#/MO#"></asp:TextBox></td>
              <td align="center">
                    <asp:CheckBox ID="chkswalkin" runat="server"  />
                </td>
             

            </tr>

 <tr>
    <td colspan="6" align="center">
               <asp:Button ID="btnsearchlog" runat="server" Text="Search" OnClick="btnsearchlog_click" OnClientClick="javascript:return viewlogSearchvalidate();" />
                                 
                  <asp:Button ID="btnsearchogClear" runat="server" Text="Clear" OnClientClick="javascript:return SearchlogClear();" />
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
   
    <div id="grd_searchlogdata"></div>
     
    </div>
    </div>
    


    
</asp:Content>
