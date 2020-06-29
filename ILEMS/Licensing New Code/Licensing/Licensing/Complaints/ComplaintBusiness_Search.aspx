<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Complaints/Complaints.Master" CodeBehind="ComplaintBusiness_Search.aspx.cs" Inherits="Licensing.Complaints.ComplaintBusiness_Search" %>

<asp:Content ID="content1" runat="server" ContentPlaceHolderID="cntmain">
  <script src="../Scripts/JScript.js" language="javascript" type="text/javascript"></script>
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
    sa5.url = "../WCFGrid/GridService.svc/Complaintbusinesssearch";

    sa5.primarykeyval = "Person_ID";
    sa5.bindid = "grdcomplaintbusinesssearch";
   
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
        sa5.cols = [new dcol("", "<i class='fa fa-hand-o-right'></i>", "", "4", "1", "lic_grd", "", ""), new dcol("Respondent", "Business", "", "1", "0", "nm_click", "", ""), new dcol("FEIN", "FEIN"), new dcol("Address", "Address1"), new dcol("County", "Address2"), new dcol("C S Z", "State"), new dcol("Phone", "Phone"), new dcol("Email", "PhoneType"), new dcol("Select", "", "", "1", "1", "Select_lkp", "fa fa-hand-o-up grdicon")];
        sa5.data = dataIn;
        sa5.process();
        prev_sender = null; prevkeyval = 0;
        return false;
    }
    var prev_sender = null, prevkeyval = 0;
    function lic_grd(sender, keyval) {

        var tbody1 = document.getElementById('grdcomplaintbusinesssearch').getElementsByTagName('tbody')[0];
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
            document.getElementById("grdcomplaintbusinesssearch").innerHTML = "";
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
    function Clear_Search() {
        document.getElementById('<%=txt_lastname.ClientID%>').value = "";
        document.getElementById('<%=txt_firstname.ClientID%>').value = "";
        document.getElementById('<%=txt_ssn.ClientID%>').value = "";
        document.getElementById('<%=txt_dob.ClientID%>').value = "";
        document.getElementById('<%=txt_compnumb.ClientID%>').value = "";
        document.getElementById('<%=txt_licnum.ClientID%>').value = "";
        document.getElementById('<%=txt_complainant.ClientID%>').value = "";
        document.getElementById("grdcomplaintsearch").innerHTML = "";
    }
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
    </script>
   



    <script language="javascript">
        function BusinessSearch_validate() {


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
<div class="cpanel">
        <div class="head">
            Complaints Business Search
           <asp:HiddenField ID="hfdselappid" runat="server" Value="0" />
        </div>

        <div class="body">
            <asp:UpdatePanel ID="upd" runat="server">
                <ContentTemplate>

                    <table width="100%" align="center" class="spac">
                        <tr>
                            <td align="right">Business Name 
                            </td>
                            <td align="left">
                                <asp:TextBox ID="txt_lastname" runat="server" placeholder="Business Name"></asp:TextBox>
                            </td>
                            <td align="right">Owner Name 
                            </td>
                            <td align="left">
                                <asp:TextBox ID="txt_firstname" runat="server" placeholder="Owners Name"></asp:TextBox>
                            </td>

                            <td align="right">FEIN
                            </td>
                            <td align="left">
                                <asp:TextBox ID="txt_ssn" CssClass="fein" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Date Started
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
                                <asp:Button ID="btn_search" runat="server" Text="Search" OnClientClick="javascript:return BusinessSearch_validate();" />&nbsp;&nbsp;
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

            <div id="grdcomplaintbusinesssearch"></div>
            
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

                <td align="right">Date Docketed
                </td>
                <td align="left">
                    <asp:TextBox ID="txt_datedocketed" CssClass="date" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td align="right">Person Responsible 
                </td>
                <td align="left">
                    <asp:DropDownList ID="ddl_personresp" runat="server" CssClass="dropdown required" error="Please select person responsible.">
                    </asp:DropDownList>
                </td>

                <td align="right">Complainant 
                </td>
                <td align="left">
                    <asp:TextBox ID="txtcomplainant" runat="server" placeholder="Complaint"></asp:TextBox>
                </td>
            </tr>

            <tr>
                <td align="right">Investigator 
                </td>
                <td align="left">
                    <asp:DropDownList ID="ddl_investigater" runat="server" CssClass="dropdown">
                    </asp:DropDownList>
                </td>

               <td align="right">Second Investigator
                </td>
                <td align="left">
                    <asp:DropDownList ID="ddl_investigater1" runat="server" CssClass="dropdown">
                    </asp:DropDownList>
                </td>

            </tr>
            <tr>
                <td colspan="4" align="center">
                    <asp:Button ID="btn_submit" runat="server" Text="Submit" OnClick="btn_submit_click" OnClientClick="javascript:return Save_Validation();" />&nbsp;&nbsp;
             <asp:Button ID="btn_clear" runat="server" Text="Clear" OnClick="btn_clear_Click"/>
                    <asp:HiddenField ID="hfdRespondentType" runat="server" Value="0" />
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
