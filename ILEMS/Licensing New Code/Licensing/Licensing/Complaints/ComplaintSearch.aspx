<%@ Page Title="" Language="C#" MasterPageFile="~/Complaints/Complaints.Master" AutoEventWireup="true" CodeBehind="ComplaintSearch.aspx.cs" Inherits="Licensing.Complaints.ComplaintSearch" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cntmain" runat="server">




    <script src="../Scripts/JScript.js" language="javascript" type="text/javascript"></script>



    <script language="javascript">
        function PersonSearch_validate() {


            var err = "";
            var srch_count = 0;
            if (Value_Checked('<%= txt_lastname.ClientID %>', "1") != "1")
                srch_count = srch_count + 1;
            if (Value_Checked('<%= txt_firstname.ClientID %>', "1") != "1")
                srch_count = srch_count + 1;
            if (Value_Checked('<%= txt_ssn.ClientID %>', "1") != "1")
                srch_count = srch_count + 1;
            if (Value_Checked('<%= txt_dob.ClientID %>', "1") != "1")
                srch_count = srch_count + 1;
            if (document.getElementById('<%=  txt_licnum.ClientID %>') != null) {
                if (Value_Checked('<%=  txt_licnum.ClientID %>', "1") != "1")
                    srch_count = srch_count + 1;
            }
            if (document.getElementById('<%=txt_compnumb.ClientID %>') != null) {
                if (Value_Checked('<%=txt_compnumb.ClientID %>', "1") != "1")
                    srch_count = srch_count + 1;
            }
            if (document.getElementById('<%=txt_complainant.ClientID %>') != null) {
                if (Value_Checked('<%=txt_complainant.ClientID %>', "1") != "1")
                    srch_count = srch_count + 1;
            }
            if (srch_count == 0)
                err = err + "Please select atleast one criteria for search.\r\n";
            if (err != "") {
                altbox(err);
                return false;
            }
            bindcomplaintsearch();
            
            return false;
        }


        function Save_Validation() {
          

            var errormsg = validateform('frmfld');
            if (errormsg != "") {
                Msgbox(errormsg);
                return false;
            }
           
            return true;
        }
        var selpname = "";
        function Openapplication(pid) {


            document.getElementById('<%= hfdRespondentType.ClientID %>').value = 1;
            document.getElementById('<%= hfdpid.ClientID %>').value = pid;
            $('#btnret_pop').dialog({ title: "New Complaint Against License" });
            $('#btnret_pop').dialog("open");

            return false;
        }
    </script>
    <script type="text/javascript">
        //Checks Values
        function Value_Checked(Ctr_Name, Error_Message) {
            if (document.getElementById(Ctr_Name).value.trim() == "") {

                return Error_Message;
            }
            return "";
        }
        //Checks DropDown Values
        function Value_Checked_Drp(Ctr_Name, Error_Message) {
            if (document.getElementById(Ctr_Name).value == "-1") {

                return Error_Message;
            }
            return "";
        }

        function Clear_Search() {
            document.getElementById('<%=txt_lastname.ClientID%>').value = "";
            document.getElementById('<%=txt_firstname.ClientID%>').value = "";
            document.getElementById('<%=txt_ssn.ClientID%>').value = "";
            document.getElementById('<%=txt_dob.ClientID%>').value = "";
            document.getElementById('<%=txt_compnumb.ClientID%>').value = "";
            document.getElementById('<%=txt_licnum.ClientID%>').value = "";
            document.getElementById("grdcomplaintsearch").innerHTML = "";
        }
    </script>
    <script type="text/javascript" language="javascript">
        function ClearValidation() {

            document.getElementById('<%=ddl_source.ClientID %>').value = '-1';
             document.getElementById('<%=ddl_category.ClientID %>').value = '-1';
             document.getElementById('<%=txt_daterec.ClientID %>').value = "";
             document.getElementById('<%=txt_dateassigned.ClientID %>').value = "";
             document.getElementById('<%=txt_dateinRec.ClientID %>').value = "";
           
             document.getElementById('<%=txtcomplainant.ClientID %>').value = "";
             document.getElementById('<%=ddl_personresp.ClientID %>').value = '-1';
            document.getElementById('<%=ddl_investigater.ClientID %>').value = '-1';
            document.getElementById('<%=ddl_investigater1.ClientID %>').value = '-1';
             return false;
         }
       </script>
     <script language="javascript" type="text/javascript">
        function age() {

            if (document.getElementById('<%= txtdob.ClientID %>').value != '') {
                var curdate = new Date(document.getElementById('<%= hfdcurdate.ClientID %>').value);
                var dob = new Date(document.getElementById('<%= txtdob.ClientID %>').value);
                var dob1 = document.getElementById('<%= txtdob.ClientID %>').value;
                var bD = dob1.split('/');
                var bday = parseInt(bD[1]);
                var bmo = (parseInt(bD[0]) - 1);
                var byr = parseInt(bD[2]);
                var byr;
                var age1;
                var now = new Date();
                tday = now.getDate();
                tmo = (now.getMonth());
                tyr = (now.getFullYear());

                if ((tmo > bmo) || (tmo == bmo & tday >= bday))
                { age1 = byr }

                else
                { age1 = byr + 1 }

                //var age = parseInt(curdate.getFullYear() - dob.getFullYear());
                age1 = tyr - age1;

                document.getElementById('<%= txtage.ClientID %>').value = age1;
                document.getElementById('<%= txtage.ClientID %>').readOnly = true;
            }
            else
                document.getElementById('<%= txtdob.ClientID %>').focus();

        }

    </script>

    <script type="text/javascript">


        var dataIn = '';
        var cmp = new sagrid();
        cmp.url = "../WCFGrid/GridService.svc/BindComplaintInfo";

        cmp.primarykeyval = "Complaint_ID";

        cmp.cols = [new dcol("Complaint #", "Complaint_Number"), new dcol("Category", "Category"), new dcol("Source", "Source"), new dcol("Complainant", "Complainant"), new dcol("Complaint Status", "Complaint_Status"), new dcol("Person Responsible", "Personresponsible")];
        cmp.objname = "cmp";
         cmp.aftercall = "Aftercall1";
        cmp.ispaging = true;
        cmp.isfilters = false;
        var sa5 = new sagrid();
        sa5.url = "../WCFGrid/GridService.svc/Complaintsearch";

        sa5.primarykeyval = "Person_ID";
        sa5.bindid = "grdcomplaintsearch";
        
        sa5.objname = "sa5";
        sa5.aftercall = "Aftercall";
        function bindcomplaintsearch() {

            dataIn = "";
            var lastname = document.getElementById('<%= txt_lastname.ClientID %>').value;
            dataIn = dataIn + '"lastname":"' + lastname + '",'
            var firstname = document.getElementById('<%= txt_firstname.ClientID %>').value;
            dataIn = dataIn + '"firstname":"' + firstname + '",'
            var ssn = document.getElementById('<%= txt_ssn.ClientID %>').value;
            dataIn = dataIn + '"ssn":"' + ssn + '",'
            var dob = document.getElementById('<%= txt_dob.ClientID %>').value;
            dataIn = dataIn + '"dob":"' + dob + '",'
            var licnum = document.getElementById('<%= txt_licnum.ClientID %>').value;
            dataIn = dataIn + '"licnum":"' + licnum + '",'
            var cmpnumber = document.getElementById('<%= txt_compnumb.ClientID %>').value;
            dataIn = dataIn + '"cmpnumber":"' + cmpnumber + '",'
            var complainant = document.getElementById('<%=txt_complainant.ClientID%>').value;
            dataIn = dataIn + '"complainant":"' + complainant + '"'
            sa5.cols = [new dcol("", "<i class='fa fa-hand-o-right'></i>", "", "4", "1", "lic_grd", "", ""), new dcol("Respondent", "Name", "", "1", "0", "nm_click", "", ""), new dcol("SSN", "SSN"), new dcol("Address", "Address1"), new dcol("County", "Address2"), new dcol("C S Z", "State"), new dcol("Phone", "Phone"), new dcol("Email", "Email"), new dcol("Select", "", "", "1", "1", "Select_lkp", "fa fa-hand-o-up grdicon")];
            sa5.data = dataIn;
            sa5.process();
            prev_sender = null; prevkeyval = 0;
            return false;
        }
        var prev_sender = null, prevkeyval = 0;
        function lic_grd(sender, keyval) {
           
                var tbody1 = document.getElementById('grdcomplaintsearch').getElementsByTagName('tbody')[0];
                var i = 0, j = 0;
                var subcount = 0;
                var trs = tbody1.rows[i];

                while (trs != null && j <= sender) {
                    i = i + 1;

                    if (trs.className == "subrow")
                        subcount = subcount + 1;
                    else
                        j = j + 1;
                    trs = tbody1.rows[i];
                }

                var tempi = tbody1.rows[sender + subcount].getElementsByTagName('i')[0];

                if (tempi.className == "fa fa-hand-o-right") {
                    if (prev_sender != null && prev_sender != sender) {
                        lic_grd(prev_sender, prevkeyval);
                    }
                    tempi.className = "fa fa-hand-o-down";

                    var temptr = tbody1.insertRow(sender + 1 );
                    temptr.id = "subrow_" + sender;
                    temptr.className = "subrow";
                    temptr.innerHTML = "<td  colspan='10'><div id='subtd_" + sender + "' style='margin:10px'></div></td>";
                    cmp.bindid = "subtd_" + sender;
                    cmp.data = '"pid":"' + keyval + '"';
                    cmp.hasparent = true;
                    cmp.parentrow = sa5;
                    cmp.parentrowid = keyval;
                    cmp.process();
                   
                    prev_sender = sender;
                    prevkeyval = keyval;
                }
                else {
                    tempi.className = "fa fa-hand-o-right";
                    tbody1.removeChild(document.getElementById("subrow_" + sender));
                    prev_sender = null;
                }
            
            


        }
        function nm_click(sender, keyval) {
            var pid = sa5.resultdata[sender]["Person_ID"];
            var type1 = sa5.resultdata[sender]["object_type"];
           
            var selcmpno = document.getElementById('<%=txt_compnumb.ClientID %>').value;
            if (selcmpno == "")
                selcmpno = "0";
            if (type1 == 1)
                window.location.href = '../PersonLicensing/PersonDetails.aspx?pid=' + pid + '&iscmp=1&selcmpno=' + selcmpno;
            else
                window.location.href = '../PersonLicensing/Business_Details.aspx?pid=' + pid + '&iscmp=1&selcmpno=' + selcmpno;
        }
        function Select_lkp(sender, keyval) {
            document.getElementById('<%= hfdpid.ClientID %>').value = keyval;
            $('#btnret_pop').dialog({ title: "New Complaint Against License" });
            $('#btnret_pop').dialog('open');
        }

        function Aftercall() {
            prev_sender = null; prevkeyval = 0;
            var trs = sa5.resultdata;
            if (trs.length > 0) {
                return true;
            }
            else {
                altbox("No results found.");
                document.getElementById("grdcomplaintsearch").innerHTML = "";
                return false;
            }
        }
        function Aftercall1() {
            var trs = cmp.resultdata;
            if (trs.length > 0) {
                return true;
            }
            else {

                document.getElementById(cmp.bindid).innerHTML = "<span class='error'>No complaints found.</span>";
                return false;
            }
        }
        
function Save_Validationaddnewperson() {
            var errormsg = validateform('frmfld1');
            if (errormsg != "") {
                Msgbox(errormsg);
                return false;
            }
           
            document.getElementById('<%=btnsave.ClientID%>').style.display = "none";
                return true;
            }
            var isautoclick = 0;
            function bindautogrd(pid, firstname, lastname, ssn) {
                Clear_Search();
                document.getElementById('<%= hfdpid.ClientID%>').value = pid;
            document.getElementById('<%= txt_firstname.ClientID%>').value = firstname;
            document.getElementById('<%= txt_lastname.ClientID%>').value = lastname;
            document.getElementById('<%= txt_ssn.ClientID%>').value = ssn;
            $('#btnnew_pop').dialog("close");
            $('#btnret_pop').dialog("open");
            $('#btnret_pop').dialog({ title: "New Complaint Against License" });
         
            bindcomplaintsearch();
            isautoclick = 1;
            }
         function Clear_Addnew() {
            document.getElementById('<%= hfdpid.ClientID %>').value = '0';
            document.getElementById('<%= txtfname.ClientID %>').value = '';
            document.getElementById('<%= txtmname.ClientID %>').value = '';
            document.getElementById('<%= txtlname.ClientID %>').value = '';
            document.getElementById('<%= ddl_gender.ClientID %>').value = '-1';
            document.getElementById('<%= txtmaidenname.ClientID %>').value = '';
            document.getElementById('<%= txtdob.ClientID %>').value = '';
            document.getElementById('<%= txtssn.ClientID %>').value = '';
            document.getElementById('<%= txtage.ClientID %>').value = '';
            document.getElementById('<%= txtaddress1.ClientID %>').value = '';
            document.getElementById('<%= txtaddress2.ClientID %>').value = '';
            document.getElementById('<%= txtcity.ClientID %>').value = '';
            document.getElementById('<%= ddl_state.ClientID %>').value = '-1';
            document.getElementById('<%= ddl_county.ClientID %>').value = '-1';
            document.getElementById('<%= txtzip.ClientID %>').value = '';
            document.getElementById('<%= ddl_phone.ClientID %>').value = 'H';
            document.getElementById('<%= txtphone.ClientID %>').value = '';
            document.getElementById('<%= ddl_altphone.ClientID %>').value = 'H';
            document.getElementById('<%= txtaltphone.ClientID %>').value = '';
            document.getElementById('<%= ddl_mstatus.ClientID %>').value = '-1';
            document.getElementById('<%= txtfax.ClientID %>').value = '';
            document.getElementById('<%= txtemail.ClientID %>').value = '';
            document.getElementById('<%= rdl_uscitizen.ClientID %>' + '_0').checked == false;
            document.getElementById('<%= rdl_uscitizen.ClientID %>' + '_1').checked == false;
            document.getElementById('<%= ddl_suffix.ClientID %>').value = '-1';
            document.getElementById('<%=txtcitizenexpdate.ClientID%>>').value = '';
            document.getElementById('<%=txtcpenumber.ClientID %>').value = '';
             
            
            return false;
        }
    </script>
    <div class="cpanel">
         <div class="head">
            Complaints Search<a id="btnnew" class="poptrg" onclick="javascript: return Clear_Addnew()">
                        Add New</a>
            <asp:HiddenField ID="hfdselappid" runat="server" Value="0" />
              <asp:HiddenField ID="hfdcurdate" Value="0" runat="server" />
        </div>

        <div class="body">
            <asp:UpdatePanel ID="upd" runat="server">
                <ContentTemplate>

                    <table width="100%" align="center" class="spac">
                        <tr>
                            <td align="right">Last Name 
                            </td>
                            <td align="left">
                                <asp:TextBox ID="txt_lastname" runat="server" placeholder="Last Name"></asp:TextBox>
                            </td>
                            <td align="right">First Name 
                            </td>
                            <td align="left">
                                <asp:TextBox ID="txt_firstname" runat="server" placeholder="First Name"></asp:TextBox>
                            </td>

                            <td align="right">SSN
                            </td>
                            <td align="left">
                                <asp:TextBox ID="txt_ssn" CssClass="ssn" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">DOB
                            </td>
                            <td align="left">
                                <asp:TextBox ID="txt_dob" CssClass="date" runat="server"></asp:TextBox>
                            </td>

                            <td align="right">Complaint Number
                            </td>
                            <td align="left">
                                <asp:TextBox ID="txt_compnumb" runat="server" placeholder="Complaint Number"></asp:TextBox>
                            </td>
                            <td align="right">License Number
                            </td>
                            <td align="left">
                                <asp:TextBox ID="txt_licnum" runat="server" placeholder="License Number"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                Complainant
                            </td>
                            <td align="left">
                                <asp:TextBox ID="txt_complainant" runat="server" placeholder="Complainant"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="6" align="center">
                                <asp:Button ID="btn_search" runat="server" Text="Search" OnClick="btn_search_click" OnClientClick="javascript:return PersonSearch_validate();" />&nbsp;&nbsp;
                  <asp:Button ID="btn_searchclear" runat="server" Text="Clear" OnClientClick="javascript:return Clear_Search();" />
                            </td>
                        </tr>
                    </table>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </div>

    <asp:HiddenField ID="hfdpid" runat="server" Value="0" />

    <div class="cpanel">
        <div class="head">
            Search Results
       
 
        </div>

        <div class="body">

            <div id="grdcomplaintsearch"></div>
            
        </div>
    </div>


    <div id='btnret_pop' class="popup">
        <span class="title">New Complaint Against License</span>
        <table align="center" width="100%" id="frmfld" class="spac">
            <tr>
                <td align="right">Source 
                </td>
                <td align="left">
                    <asp:DropDownList ID="ddl_source" runat="server" CssClass="dropdown required" error="Please select source.">
                    </asp:DropDownList>
                    <asp:HiddenField ID="hfdcmpid" runat="server" Value="0" />
                </td>

                <td align="right">Category 
                </td>
                <td align="left">
                    <asp:DropDownList ID="ddl_category" runat="server" CssClass="dropdown required" error="Please select category.">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td align="right">Date Received
                </td>
                <td align="left">
                    <asp:TextBox ID="txt_daterec" CssClass="date required" runat="server" error="Please enter date received."></asp:TextBox>
                </td>

                <td align="right">Investigator Assigned 
                </td>
                <td align="left">
                    <asp:TextBox ID="txt_dateassigned" CssClass="date" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td align="right">Investigator Received 
                </td>
                <td align="left">
                    <asp:TextBox ID="txt_dateinRec" CssClass="date" runat="server"></asp:TextBox>
                </td>
                 <td align="right">Person Responsible 
                </td>
                <td align="left">
                    <asp:DropDownList ID="ddl_personresp" runat="server" CssClass="dropdown required" error="Please select person responsible.">
                    </asp:DropDownList>
                </td>
              <%--  <td align="right">Date Docketed
                </td>
                <td align="left">
                    <asp:TextBox ID="txt_datedocketed" CssClass="date" runat="server"></asp:TextBox>
                </td>--%>
            </tr>
            <tr>
               

                <td align="right">Complainant 
                </td>
                <td align="left">
                    <asp:TextBox ID="txtcomplainant" runat="server" placeholder="Complaint"></asp:TextBox>
                </td>
                 <td align="right">Investigator 
                </td>
                <td align="left">
                    <asp:DropDownList ID="ddl_investigater" runat="server" CssClass="dropdown">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td align="right">Second Investigator
                </td>
                <td align="left">
                    <asp:DropDownList ID="ddl_investigater1" runat="server" CssClass="dropdown">
                    </asp:DropDownList>
                </td>
            </tr>

            
            <tr>
                <td colspan="4" align="center">
                    <asp:Button ID="btn_submit" runat="server" OnClick="btn_submit_click" Text="Submit" OnClientClick="javascript:return Save_Validation();" />&nbsp;&nbsp;
             <asp:Button ID="btn_clear" runat="server" Text="Clear" OnClick="btn_clear_Click" OnClientClick="javascript:return ClearValidation();"/>
                    <asp:HiddenField ID="hfdRespondentType" runat="server" Value="0" />
                </td>
            </tr>
        </table>
    </div>
    <div id='btnnew_pop' class="popup" style="display: none;">
        <span class="title">Add New Person Information</span>
        <asp:UpdatePanel ID="upd3" runat="server">
            <ContentTemplate>
                <table align="center" class="spac" id="frmfld1">
                    <tr>
                        <td align="right">First Name
                        </td>
                        <td align="left">
                            <asp:TextBox ID="txtfname" runat="server" CssClass="required" placeholder="First Name"
                                error="Please enter first name."></asp:TextBox>
                        </td>
                        <td align="right">Middle Name
                        </td>
                        <td align="left">
                            <asp:TextBox ID="txtmname" runat="server" placeholder="Middle Name"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">Last Name
                        </td>
                        <td align="left">
                            <asp:TextBox ID="txtlname" runat="server" CssClass="required" placeholder="Last Name"
                                error="Please enter last name."></asp:TextBox>
                        </td>
                        <td align="right">Suffix
                        </td>
                        <td align="left">
                            <asp:DropDownList ID="ddl_suffix" runat="server">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">Maiden Name
                        </td>
                        <td align="left">
                            <asp:TextBox ID="txtmaidenname" runat="server" placeholder="Maiden Name"></asp:TextBox>
                        </td>
                        <td align="right">SSN
                        </td>
                        <td align="left">
                            <asp:TextBox ID="txtssn" runat="server" CssClass="ssn"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">DOB
                        </td>
                        <td align="left">
                            <asp:TextBox ID="txtdob" runat="server" class="date"
                                onblur="javascript:age();"></asp:TextBox>
                            <%--error="Please enter the date of birth."--%>
                        </td>
                        <td align="right">Gender
                        </td>
                        <td align="left">
                            <asp:DropDownList ID="ddl_gender" runat="server">
                            </asp:DropDownList>
                            <%--error="Please select the gender."--%>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">Age
                        </td>
                        <td align="left">
                            <asp:TextBox ID="txtage" runat="server"  ></asp:TextBox>
                        </td>
                        <td align="right">Address Type
                        </td>
                        <td align="left">
                            <asp:DropDownList ID="ddl_addresstype" runat="server">
                                <asp:ListItem>Home</asp:ListItem>
                                <asp:ListItem>Office</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">Address1
                        </td>
                        <td align="left">
                            <asp:TextBox ID="txtaddress1" runat="server" placeholder="Address"></asp:TextBox>
                        </td>
                        <td align="right">Address2
                        </td>
                        <td align="left">
                            <asp:TextBox ID="txtaddress2" runat="server" placeholder="Address"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">City
                        </td>
                        <td align="left">
                            <asp:TextBox ID="txtcity" runat="server" placeholder="City"></asp:TextBox>
                        </td>
                        <td align="right">State
                        </td>
                        <td align="left">
                            <asp:DropDownList ID="ddl_state" runat="server">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">County
                        </td>
                        <td align="left">
                            <asp:DropDownList ID="ddl_county" runat="server" placeholder="First Name">
                            </asp:DropDownList>
                        </td>
                        <td align="right">Zip
                        </td>
                        <td align="left">
                            <asp:TextBox ID="txtzip" runat="server" CssClass="zip" placeholder="First Name"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">Phone
                        </td>
                        <td align="left">
                            <asp:DropDownList ID="ddl_phone" runat="server" Width="35px">
                                <asp:ListItem>H</asp:ListItem>
                                <asp:ListItem>C</asp:ListItem>
                                <asp:ListItem>O</asp:ListItem>
                            </asp:DropDownList>
                            <asp:TextBox ID="txtphone" runat="server" CssClass="phone" Width="140px"></asp:TextBox>
                        </td>
                        <td align="right">Alternate Phone
                        </td>
                        <td align="left">
                            <asp:DropDownList ID="ddl_altphone" runat="server" Width="35px">
                                <asp:ListItem>H</asp:ListItem>
                                <asp:ListItem>C</asp:ListItem>
                                <asp:ListItem>O</asp:ListItem>
                            </asp:DropDownList>
                            <asp:TextBox ID="txtaltphone" runat="server" CssClass="phone" Width="140px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">Marital Status
                        </td>
                        <td align="left">
                            <asp:DropDownList ID="ddl_mstatus" runat="server">
                            </asp:DropDownList>
                        </td>
                        <td align="right">Fax
                        </td>
                        <td align="left">
                            <asp:TextBox ID="txtfax" runat="server" CssClass="phone"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">Email
                        </td>
                        <td align="left">
                            <asp:TextBox ID="txtemail" runat="server" CssClass="email" placeholder="Email"></asp:TextBox><%--error="Please enter the email."--%>
                        </td>
                        <td align="right">US Citizen
                        </td>
                        <td align="left">
                            <asp:RadioButtonList ID="rdl_uscitizen" runat="server" RepeatDirection="Horizontal">
                                <asp:ListItem Value="0" Text="Yes"></asp:ListItem>
                                <asp:ListItem Value="1" Text="No"></asp:ListItem>
                            </asp:RadioButtonList>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">Citizenship Expiration Date
                        </td>
                        <td align="left">
                            <asp:TextBox ID="txtcitizenexpdate" runat="server" CssClass="date"></asp:TextBox>
                        </td>
                        <td align="right">NABP E-Profile Number
                        </td>
                        <td align="left">
                            <asp:TextBox ID="txtcpenumber" runat="server" placeholder="CPE Number"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">Ethnicity 
                        </td>
                        <td align="left">
                            <asp:DropDownList ID="ddlethincity" runat="server"></asp:DropDownList>
                        </td>
                        <td align="right"> 
                        </td>
                        <td align="left">
                             
                        </td>
                    </tr>
                   
                    <tr>
                        <td colspan="4" align="center">
                            <asp:Button ID="btnsave" runat="server" Text="Save" OnClientClick="javascript:return Save_Validationaddnewperson()" OnClick="btnsave_Click" />
                            <asp:Button Text="Clear" ID="btnclear" runat="server" /><%--OnClientClick="javascript:return Clear_Addnew();"--%>
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>
