<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/PersonLicensing/Person.Master" CodeBehind="Contact_Search.aspx.cs" Inherits="Licensing.PersonLicensing.Contact_Search" %>

<asp:Content ID="content1" runat="server" ContentPlaceHolderID="cntmain">
    <script type="text/javascript">
        var dataIn = '';
        var sa5 = new sagrid();
        sa5.url = "../WCFGrid/GridService.svc/GetContactSearch";
        sa5.primarykeyval = "Person_ID";
        sa5.bindid = "grdcontactserach";
        sa5.objname = "sa5";
        sa5.aftercall = "Aftercall";

        function bindpersonsearch() {

            dataIn = "";
            var contacttype = document.getElementById('<%=ddl_contacttype.ClientID%>').value;
            dataIn = dataIn + '"contacttype":"' + contacttype + '",'
            var lastname = document.getElementById('<%= txt_lastname.ClientID %>').value;
            dataIn = dataIn + '"lname":"' + lastname + '",'
            var firstname = document.getElementById('<%= txt_firsname.ClientID %>').value;
            dataIn = dataIn + '"fname":"' + firstname + '",'
            var ssn = document.getElementById('<%= txt_ssn.ClientID %>').value;
            dataIn = dataIn + '"ssn":"' + ssn + '",'
            var dob = document.getElementById('<%= txt_dob.ClientID %>').value;
            dataIn = dataIn + '"dob":"' + dob + '",'
            var pnumber = document.getElementById('<%= txt_phonenuumber.ClientID %>').value;
            dataIn = dataIn + '"pnumber":"' + pnumber + '",'
             var email = document.getElementById('<%= txt_email.ClientID %>').value;
            dataIn = dataIn + '"email":"' + email + '",'
            var address = document.getElementById('<%= txt_address.ClientID %>').value;
            dataIn = dataIn + '"address":"' + address + '",'
            var county = document.getElementById('<%= ddlcounty.ClientID %>').value;
            dataIn = dataIn + '"county":"' + county + '",'
            var state = document.getElementById('<%= ddlstate.ClientID %>').value;
            dataIn = dataIn + '"state":"' + state + '",'
            var zip = document.getElementById('<%= txt_zip.ClientID %>').value;
            dataIn = dataIn + '"zip":"' + zip + '",'
            var city = document.getElementById('<%=txt_city.ClientID%>').value;
            dataIn = dataIn + '"city":"' + city + '",'
            var stype = "1";
            if (document.getElementById('<%= rdblike.ClientID %>' + '_1').checked == true)
                stype = "0";
            dataIn = dataIn + '"resptype":"' + stype + '"'
            
            sa5.cols = [new dcol("Name", "Name", "", "1", "0", "nm_click", "", ""), new dcol("FEIN", "SSN"), new dcol("Phone", "Phone"), new dcol("Address", "Address"), new dcol("C S Z", "CSZ"), new dcol("Email", "Email")];
            sa5.data = dataIn;
            sa5.process();

            return false;
        }
        function Aftercall() {
            var trs = sa5.resultdata;
            if (trs.length > 0) {
                
                return true;
            }
            else {
                altbox("No results found.");
                document.getElementById("grdcontactserach").innerHTML = "";
                return false;
            }
        }
        function nm_click(sender, keyval)
        {
        var pid = sa5.resultdata[sender]["Person_ID"];
        var type1 = sa5.resultdata[sender]["object_type"];
        var selcmpno = document.getElementById('<%=ddl_contacttype.ClientID %>').value;
            if (selcmpno == "")
                selcmpno = "0";
            if (type1 == '1')
            {
                window.open("../PersonLicensing/PersonDetails.aspx?pid=" + pid);
            }
            else
            {
                window.open("../PersonLicensing/Business_Details.aspx?pid=" + pid);

            }
            
    }
    </script>
    <script type="text/javascript">
        function handle(e) {
            if (e.keyCode === 13) {
                document.getElementById('<%= btnsearch.ClientID %>').click();
            }

            return false;
        }
        function Search_Validation() {
            
             var err = "";
             var srch_count = 0;
            if (Value_Checked_Drp('<%=ddl_contacttype.ClientID%>', "1") != "1")
                srch_count = srch_count + 1;
            if (Value_Checked('<%= txt_firsname.ClientID %>', "1") != "1")
                srch_count = srch_count + 1;
            if (Value_Checked('<%= txt_lastname.ClientID %>', "1") != "1")
                srch_count = srch_count + 1;
            if (Value_Checked('<%= txt_ssn.ClientID %>', "1") != "1")
                srch_count = srch_count + 1;
            if (Value_Checked('<%= txt_dob.ClientID %>', "1") != "1")
                srch_count = srch_count + 1;
            if (Value_Checked('<%= txt_phonenuumber.ClientID %>', "1") != "1")
                srch_count = srch_count + 1;
            if (Value_Checked('<%= txt_address.ClientID %>', "1") != "1")
                srch_count = srch_count + 1;
            if (Value_Checked_Drp('<%=ddlcounty.ClientID%>', "1") != "1")
                srch_count = srch_count + 1;
            if (Value_Checked_Drp('<%=ddlstate.ClientID%>', "1") != "1")
                srch_count = srch_count + 1;
            if (Value_Checked('<%= txt_zip.ClientID %>', "1") != "1")
                srch_count = srch_count + 1;
            if (Value_Checked('<%=  txt_email.ClientID %>', "1") != "1")
                srch_count = srch_count + 1;
            if (Value_Checked('<%=txt_city.ClientID%>', "1") != "1")
                srch_count = srch_count + 1;
            
            if (srch_count == 0)
                err = err + "Please select atleast one criteria for search.\r\n";
            if (err != "") {
                altbox(err);
                return false;
            }
            bindpersonsearch();
            return false;
        }
        function Value_Checked(Ctr_Name, Error_Message) {
            if (document.getElementById(Ctr_Name).value.trim() == "") {

                return Error_Message;
            }
            return "";
        }
        function Value_Checked_Drp(Ctr_Name, Error_Message) {
            if (document.getElementById(Ctr_Name).value == "-1") {

                return Error_Message;
            }
            return "";
        }
        function Value_Checked_checkbox(Ctr_Name, Error_Message) {
            if (document.getElementById(Ctr_Name).checked == false) {
                return Error_Message;
            }
        }
        function Clear_search() {
            document.getElementById('<%=ddl_contacttype.ClientID%>').value = '-1';
            document.getElementById('<%=txt_lastname.ClientID%>').value = '';
            document.getElementById('<%=txt_firsname.ClientID%>').value = '';
            document.getElementById('<%=txt_ssn.ClientID%>').value = '';
            document.getElementById('<%=txt_dob.ClientID%>').value = '';
            document.getElementById('<%=txt_phonenuumber.ClientID%>').value = '';
            document.getElementById('<%=txt_address.ClientID%>').value = '';
            document.getElementById('<%= ddlcounty.ClientID %>').value = '-1';
            document.getElementById('<%= ddlstate.ClientID %>').value = '-1';
            document.getElementById('<%= txt_email.ClientID %>').value = '';
            document.getElementById('<%=txt_zip.ClientID%>').value = '';
            document.getElementById("grdcontactserach").innerHTML = "";
            return false;
        }
    </script>
    <div class="cpanel">
        <div class="head">Contact Search</div>
        <div class="body" onkeypress="handle(event)">
            <table width="98%" align="center" class="spac">
                <tr>
                    <td align="right">Contact Type
                    </td>
                    <td align="left">
                        <asp:DropDownList ID="ddl_contacttype" runat="server">
                            <asp:ListItem Value="-1" Text="Select Contact Type"></asp:ListItem>
                            <asp:ListItem Value="1" Text="Officer/Agent/Individual"></asp:ListItem>
                            <asp:ListItem Value="2" Text="Owner/Agent"></asp:ListItem>
                            <asp:ListItem Value="3" Text="Supervising Pharmacist"></asp:ListItem>
                            <asp:ListItem Value="4" Text="Supplier"></asp:ListItem>
                            <asp:ListItem Value="5" Text="Designated Representative"></asp:ListItem>
                            <asp:ListItem Value="6" Text="Compliance Officer"></asp:ListItem>
                            <asp:ListItem Value="7" Text="Customers Details"></asp:ListItem>
                            <asp:ListItem Value="8" Text="Associate Pharmacies Details"></asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td align="right">Last Name
                    </td>
                    <td align="left">
                        <asp:TextBox ID="txt_lastname" runat="server" placeholder="Last Name"></asp:TextBox>
                    </td>
                    <td align="right">First Name
                    </td>
                    <td align="left">
                        <asp:TextBox ID="txt_firsname" runat="server" placeholder="First Name"></asp:TextBox>
                    </td>

                </tr>
                <tr>
                    <td align="right">SSN
                    </td>
                    <td align="left">
                        <asp:TextBox ID="txt_ssn" runat="server" CssClass="ssn"></asp:TextBox>
                    </td>
                    <td align="right">DOB
                    </td>
                    <td align="left">
                        <asp:TextBox ID="txt_dob" runat="server" CssClass="date"></asp:TextBox>
                    </td>
                    <td align="right">Phone Number
                    </td>
                    <td align="left">
                        <asp:TextBox ID="txt_phonenuumber" runat="server" CssClass="phone"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td align="right">Address
                    </td>
                    <td align="left">
                        <asp:TextBox ID="txt_address" runat="server" placeholder="Address"></asp:TextBox>
                    </td>
                    <td align="right">City
                    </td>
                    <td align="left">
                        <asp:TextBox ID="txt_city" runat="server" placeholder="City"></asp:TextBox>
                    </td>
                    <td align="right">County
                    </td>
                    <td align="left">
                        <asp:DropDownList ID="ddlcounty" runat="server">
                        </asp:DropDownList>
                    </td>

                </tr>
                <tr>
                    <td align="right">State
                    </td>
                    <td align="left">
                        <asp:DropDownList ID="ddlstate" runat="server">
                        </asp:DropDownList>
                    </td>
                    <td align="right">Zip
                    </td>
                    <td align="left">
                        <asp:TextBox ID="txt_zip" runat="server" CssClass="zip"></asp:TextBox>
                    </td>
                    <td align="right">Email
                    </td>
                    <td align="left">
                        <asp:TextBox ID="txt_email" runat="server" placeholder="Email"></asp:TextBox>
                    </td>

                </tr>
                <tr>
                    <td align="right">Search Type 
                    </td>
                    <td>
                        <asp:RadioButtonList ID="rdblike" runat="server" RepeatColumns="2">
                            <asp:ListItem Value="0" Selected="True">Like</asp:ListItem>
                            <asp:ListItem Value="1">Exact</asp:ListItem>
                        </asp:RadioButtonList>

                    </td>
                </tr>
                <tr>
                    <td colspan="6" align="center" height="50px;">
                        <asp:Button ID="btnsearch" runat="server" Text="Search" OnClientClick="javascript:return Search_Validation();" />
                        <asp:Button ID="btnsearchclear" runat="server" Text="Clear" OnClientClick="javascript:return Clear_search();" />
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
            <div id="grdcontactserach"></div>
        </div>
    </div>
</asp:Content>
