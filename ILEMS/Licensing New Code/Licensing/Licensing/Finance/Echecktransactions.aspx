<%@ Page Language="C#" MasterPageFile="~/Finance/Finance.Master" AutoEventWireup="true" CodeBehind="Echecktransactions.aspx.cs" Inherits="Licensing.Finance.Echecktransactions" %>

<asp:Content ID="cnt" ContentPlaceHolderID="cntmain" runat="server">
    <script>
        var dataIn = '';        
        var sa5 = new sagrid();        
        sa5.bindid = "grd_div";
        sa5.objname = "sa5";
        sa5.aftercall = "Aftercall";         
        sa5.primarykeyval = "Account";
        sa5.cols = [new dcol("Name", "username"), new dcol("Charge #", "charge_id"), new dcol("Description", "comment"), new dcol("Date", "charge_timestamp"), new dcol("Amount", "total_amount"), new dcol("Status", "result_code"), new dcol("Result", "result_text")];
        sa5.url = "../Reports/Report.svc/GetOnlineACH";
        sa5.isfilters = false;
        
        function BindRocData()
        {
            dataIn = "";
            var seltype = 0;
            
     var sdt = document.getElementById('<%= txt_startdate.ClientID %>').value;
             dataIn = dataIn + '"sdt":"' + sdt + '",'
             var edt = document.getElementById('<%= txt_enddate.ClientID %>').value;
            dataIn = dataIn + '"edt":"' + edt + '"';
            sa5.pageindex = 1;
             sa5.data = dataIn;
             sa5.process();
         }
             
    </script>
    
    <script type="text/javascript">
       
        function Aftercall() {
            var trs = sa5.resultdata;
            if (trs.length > 0) {
               
              
            }
            else {
                altbox("No results found.");
                document.getElementById("grd_div").innerHTML = "";
                return false;
            }
        }
       
    </script>
    <script type="text/javascript" language="javascript">
        function parseDate(str) {
            var mdy = str.split('/');
            return new Date(mdy[2], mdy[0] - 1, mdy[1]);
        }

        function datediff(first, second) {
            // Take the difference between the dates and divide by milliseconds per day.
            // Round to nearest whole number to deal with DST.
            return Math.round((second - first) / (1000 * 60 * 60 * 24));
        }

        function Clear()
        {

            document.getElementById('<%=txt_startdate.ClientID %>').value = document.getElementById('<%=hfdtdt.ClientID %>').value;
         document.getElementById('<%=txt_enddate.ClientID%>').value = document.getElementById('<%=hfdtdt.ClientID %>').value;
         document.getElementById("grd_div").innerHTML = "";
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
              var sdt = document.getElementById('<%= txt_startdate.ClientID %>').value;
             var tdt = document.getElementById('<%= hfdtdt.ClientID %>').value;
            var edt = document.getElementById('<%= txt_enddate.ClientID %>').value;
           
            if (datediff(parseDate(sdt), parseDate(tdt)) < 0 || datediff(parseDate(edt), parseDate(tdt)) < 0)
            {
                altbox("Start and End date cannot be future date.");
                return false;
            }
            if(datediff(parseDate(sdt), parseDate(edt))>5)
            {
                altbox("Start and End date cannot be more than 5 days apart.");
                return false;
            }
            BindRocData();
            return false;

        }

    </script>

    <br />
    <div class="cpanel">
        <div class="head">
            Search Online Transactions
 
        </div>

        <div class="body">

            <asp:HiddenField ID="hfdtdt" runat="server" />
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
                        <asp:Button ID="btn_generate" runat="server" Text="Submit" OnClientClick="javascript:return Save_Validation1()" />
                    </td>
                    <td align="left">
                        <asp:Button ID="btn_Clear" runat="server" Text="Clear" OnClientClick="javascript:return Clear()" />
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
            <div id="grd_div" ></div>

        </div>
    </div>
  
</asp:Content>