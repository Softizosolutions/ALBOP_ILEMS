<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Finance_ReportofCollections.aspx.cs" Inherits="Licensing.Finance.Finance_ReportofCollections" MasterPageFile="~/Finance/Finance.Master"  %>

<%--<!DOCTYPE html>--%>

<asp:Content ID="cnt" ContentPlaceHolderID="cntmain" runat="server">
    <script>
        var dataIn = '';
        
        var sa5 = new sagrid();        
        sa5.bindid = "grd_div";
        sa5.objname = "sa5";
        sa5.aftercall = "Aftercall";
     
        sa5.primarykeyval = "Subobj_Id";

        sa5.cols = [new dcol("Fee Code", "code", "", "1", "", "Nm_Click", "", ""), new dcol("Fee Type", "Fee_type", "", "1", "", "Nm_Click", "", ""), new dcol("Amount", "Amount") ];
        sa5.url = "../Reports/Report.svc/GetROC";

        function BindRocData() {
            dataIn = "";
            var seltype = 0;
            if(document.getElementById('<%= rdblst.ClientID %>' +'_0').checked){
                sa5.cols = [new dcol("Fee Code", "code", "", "1", "", "Nm_Click", "", ""), new dcol("Fee Type", "Fee_type", "", "1", "", "Nm_Click", "", ""), new dcol("Amount", "Amount") ];
                seltype = 0;
            }
               
             else if(document.getElementById('<%= rdblst.ClientID %>' +'_1').checked){
                 sa5.cols = [new dcol("Fee Code", "code", "", "1", "", "Nm_Click", "", ""), new dcol("Fee Type", "Fee_type", "", "1", "", "Nm_Click", "", ""), new dcol("Amount", "Amount") ];
                 seltype = 1;
             }
             else if(document.getElementById('<%= rdblst.ClientID %>'+'_2').checked){
                 sa5.cols = [new dcol("Fee Code", "code", "", "1", "", "Nm_Click", "", ""), new dcol("Fee Type", "Fee_type", "", "1", "", "Nm_Click", "", ""), new dcol("Method of payment", "Methodofpayment"), new dcol("Date Received", "DateReceived"), new dcol("Date Posted", "DatePosted"), new dcol("Amount", "Amount")];
             seltype = 2;
             }
             
     dataIn = dataIn + '"type":"' + seltype + '",'
     var sdt = document.getElementById('<%= txt_startdate.ClientID %>').value;
             dataIn = dataIn + '"sdt":"' + sdt + '",'
             var edt = document.getElementById('<%= txt_enddate.ClientID %>').value;
             dataIn = dataIn + '"edt":"' + edt + '"';
             sa5.data = dataIn;
             sa5.process();
         }
             
    </script>
    <script>
        var dataIn = '';
        var roc = new sagrid();
        roc.bindid = "grdroc";
            
        roc.objname = "roc";
        roc.primarykeyval = "Fee_type";
        roc.cols = [new dcol("Name", "Pname"), new dcol("License #", "licno"), new dcol("Fee Type", "Fee_type"), new dcol("Amount", "Amount"), new dcol("Check #", "CheckNumber")];
        roc.url = "../Reports/Report.svc/GetROCDetails";
        roc.aftercall = "Aftercall1";

        function BindRoc(sender, keyval) {
           
            dataIn = '';
            var seltype = 0;
            if(document.getElementById('<%= rdblst.ClientID %>' +'_0').checked)
                       seltype = 0;
                   else
                       if(document.getElementById('<%= rdblst.ClientID %>' +'_1').checked)
                     seltype = 1;
                 else
                     if(document.getElementById('<%= rdblst.ClientID %>'+'_2').checked)
                       seltype = 2;
           dataIn = dataIn + '"type":"' + seltype + '",'
           var date1 = document.getElementById('<%=txt_startdate.ClientID %>').value;
                 dataIn = dataIn + '"sdt":"' + date1 + '",'
                 var date2 = document.getElementById('<%=txt_enddate.ClientID%>').value;
                 dataIn = dataIn + '"edt":"' + date2 + '",'
                 var feeid = keyval;
                 dataIn = dataIn + '"id":"' + feeid + '",'

                 dataIn = dataIn + '"paytype":"' + sa5.resultdata[sender]["Methodofpayment"] + '",'
                 dataIn = dataIn + '"dr":"' + sa5.resultdata[sender]["DateReceived"] + '",'
                 dataIn = dataIn + '"dp":"' + sa5.resultdata[sender]["DatePosted"] + '"'
                
                 roc.data = dataIn;
                 roc.process();
                 return false;
             }
           
    </script>
    <script type="text/javascript">
        function Aftercall1() {
            var trs = roc.resultdata;
            if (trs.length > 0) {
                $('#grdroc').find('tbody tr').each(function () {
                    $(this).find('td:eq(3)').html('$ ' + $(this).find('td:eq(3)').html());
                });

                return true;
            }
           
        }
        function Aftercall() {
            var trs = sa5.resultdata;
            if (trs.length > 0) {
                $('#grd_div').find('tbody tr').each(function () {
                    if(!document.getElementById('<%= rdblst.ClientID %>'+'_2').checked)
                    $(this).find('td:eq(2)').html('$ ' + $(this).find('td:eq(2)').html());
                    if (document.getElementById('<%= rdblst.ClientID %>' + '_2').checked)  
                    $(this).find('td:eq(5)').html('$ ' + $(this).find('td:eq(5)').html());
                });

                return true;
            }
            else {
                altbox("No results found.");
                document.getElementById("grd_div").innerHTML = "";
                return false;
            }
        }
        function Nm_Click(sender, keyval) {
            $(function () {
                $('#rocdiv_pop').dialog({ title: 'ROC Details', width: '70%'});
                $('#rocdiv_pop').dialog("open");
            });
            BindRoc(sender,keyval);
        }
    </script>
    <script type="text/javascript" language="javascript">

        function Clear()
        {

            document.getElementById('<%=txt_startdate.ClientID %>').value = '';
         document.getElementById('<%=txt_enddate.ClientID%>').value = '';
         document.getElementById("grd_div").innerHTML = "";
         return false;
     }
     function Print_roc(typ) {
         if (document.getElementById('<%=txt_startdate.ClientID%>').value == "") {
             altbox("Please enter the date.")
             document.getElementById('<%= txt_startdate.ClientID %>').focus()
             return false;
         }
         var sdt = document.getElementById('<%= txt_startdate.ClientID %>').value
         var edt = document.getElementById('<%=txt_enddate.ClientID%>').value;
         var seltype = 0;
         if(document.getElementById('<%= rdblst.ClientID %>' +'_0').checked)
             seltype = 0;
         else
             if (document.getElementById('<%= rdblst.ClientID %>' + '_1').checked) {
                  
                   seltype = 1;
                   
               }
               else
                   if (document.getElementById('<%= rdblst.ClientID %>' + '_2').checked)
                         seltype = 2;
        
         if (typ != '2')
             window.open('../Prints/print_roc.aspx?sdt=' + sdt + '&edt=' + edt + '&type=' + typ + "&mc=" + seltype);
         else
             window.open('../Prints/PrintRocExcel.aspx?sdt=' + sdt + '&edt=' + edt + '&type=' + typ + "&mc=" + seltype);
             return false;
         }
    </script>

    <script type="text/javascript">
       
        function Save_Validation1() {
            var errormsg = validateform('frmfld');
            if (errormsg != "") {
                Msgbox(errormsg);
                return false;                  
            }           
            return true;

        }

    </script>

    </script>

    <br />
    <div class="cpanel">
        <div class="head">
            Reports Of Collections
 
        </div>

        <div class="body">


            <table class="spac" id="frmfld" align="center">
                <tr>
                    <td align="right">From Date 
                    </td>
                    <td align="left">
                        <asp:TextBox ID="txt_startdate" runat="server" CssClass="date required" error="Please enter from date." placeholder="Date"></asp:TextBox>
                    </td>
                    <td align="right">To Date
                    </td>
                    <td align="left">
                        <asp:TextBox ID="txt_enddate" runat="server" CssClass="date"></asp:TextBox>
                    </td>
                    <td align="left">
                        <asp:Button ID="btn_generate" runat="server" Text="Submit" OnClientClick="javascript:return Save_Validation1()" OnClick="btn_generate_Click"/>
                    </td>
                    <td align="left">
                        <asp:Button ID="btn_Clear" runat="server" Text="Clear" OnClientClick="javascript:return Clear()" />
                    </td>
                    <td align="left">
                        <asp:Button ID="Button1" runat="server" Text="Print" OnClientClick="javascript:return Print_roc(0)" />
                    </td>
                    <td align="left">
                        <asp:Button ID="Button2" runat="server" Text="Print Detail" OnClientClick="javascript:return Print_roc(1)" />
                    </td>
                    <td align="left">
                         <asp:Button ID="Button3" runat="server" Text="Print Detail Excel" OnClientClick="javascript:return Print_roc(2)" />
                    </td>
                </tr>
                <tr>
                    <td colspan="4">
                        <asp:RadioButtonList ID="rdblst" runat="server" RepeatColumns="3" Width="100%">
                            <asp:ListItem Value="0" Selected="True">All</asp:ListItem>
                            <asp:ListItem Value="1">Online only</asp:ListItem>
                            <asp:ListItem Value="2">Manual only</asp:ListItem>
                        </asp:RadioButtonList>
                    </td>
                </tr>
            </table>

        </div>
    </div>
    <div class="cpanel">
        <div class="head">
            Result
 <asp:Label ID="lbltotalamount" style="padding-right:40px;float:right" runat="server"></asp:Label>&nbsp;&nbsp;
           <asp:Label ID="lblamount" style="float:right" runat="server" Text="Total Amount : &nbsp;"></asp:Label>
        </div>

        <div class="body">
            <div id="grd_div"></div>

        </div>
    </div>
    <div id="rocdiv_pop" class="popup" style="display: none;">
        <span class="title">ROC Details</span>
        <div id="grdroc"></div>
    </div>
</asp:Content>