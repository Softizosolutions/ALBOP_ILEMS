<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="../Master Page/frm.master"
    CodeBehind="Employment.aspx.cs" Inherits="Licensing.PersonLicensing.Employment" %>

<asp:Content ID="cnt1" runat="server" ContentPlaceHolderID="ContentPlaceHolder1">
    <script type="text/javascript">
        function Popup() {
            $(function () {
                $('#btnnew_pop').dialog({ title: 'Edit Employment' });
                $('#btnnew_pop').dialog("open");
            });
        }
    </script>
    <script type="text/javascript" language="javascript">
        function Clear_Emp() {
            document.getElementById('<%= hfdemployeeid.ClientID %>').value = '0';
            document.getElementById('<%= txt_employeetype.ClientID %>').value = '';
            document.getElementById('<%= txt_Name.ClientID %>').value = '';
            document.getElementById('<%= ddlcounty.ClientID %>').value = '-1';
            document.getElementById('<%= txt_address.ClientID %>').value = '';
            document.getElementById('<%= ddlstate.ClientID %>').value = '-1';
            document.getElementById('<%= txt_city.ClientID %>').value = '';
            document.getElementById('<%= txt_zip.ClientID %>').value = '';
            return false;
        }

        function Save_Validations() {
            var errormsg = validateform('frmfld');

            if (errormsg != "") {
                Msgbox(errormsg);
                return false;
            }
            return true;
        }


    </script>
    <script type="text/javascript">
        var dataIn = '';
        var supr = new sagrid();
        supr.url = "../WCFGrid/GridService.svc/GetSUpervisor";

        supr.primarykeyval = "Person_ID";
        supr.bindid = "supres";
        supr.cols = [new dcol("Start Date", "Start_dt"), new dcol("Name", "Name"), new dcol("Type", "Type"), new dcol("Address", "Address1"), new dcol("City", "City"), new dcol("State", "State"), new dcol("Zip", "Zip"), new dcol("Phone", "Phone"), new dcol("Status", "Status"), new dcol("Select", "", "", "1", "1", "Select_lkp2", "fa fa-hand-o-up grdicon")];
        supr.objname = "supr";

        function Select_lkp2(sender, keyval) {

            var otype = supr.resultdata[sender]["object_type"];
            if (otype == "1")
                parent.window.location.href = '../PersonLicensing/PersonDetails.aspx?perid=' + keyval;
            else
                parent.window.location.href = '../PersonLicensing/Business_Details.aspx?perid=' + keyval;
        }

    </script>
    <script type="text/javascript">
        var dataIn = '';
        var haspe = new sagrid();
        haspe.url = "../WCFGrid/GridService.svc/GetHasEmployer";

        haspe.primarykeyval = "has_emp_id";
        haspe.bindid = "grdhasemployee";
        
        haspe.objname = "haspe";

        function Select_lkp3(sender, keyval) {
            var pid = haspe.resultdata[sender]["Person_ID"];
            var otype = haspe.resultdata[sender]["object_type"];
            if (otype == "1")
                parent.window.location.href = '../PersonLicensing/PersonDetails.aspx?perid=' + pid;
            else
                parent.window.location.href = '../PersonLicensing/Business_Details.aspx?perid=' + pid;
        }
        function Delete_lkp1(sender, keyval) {
            document.getElementById('<%= hfdselid.ClientID %>').value = keyval;
              document.getElementById('<%= btnhas.ClientID %>').click();
          }
    </script>
    <script type="text/javascript">


        var dataIn = '';
        var sa5 = new sagrid();
        sa5.url = "../WCFGrid/GridService.svc/BindPersonEmployment";

        sa5.primarykeyval = "Employer_Id";
        sa5.bindid = "grdemployee";
        
        sa5.objname = "sa5";
        sa5.process();
        function edit_lkp(sender, keyval) {
            //altbox(sa5.resultdata[sender]["Employer_Name"]);
            document.getElementById('<%= hfdselid.ClientID %>').value = keyval;
            document.getElementById('<%= btnedit.ClientID %>').click();
        }
        function cnffnres(result) {
            alert(result);
            if (result == 'true')
                document.getElementById('<%= btndel.ClientID %>').click();
        }

        function Delete_lkp(sender, keyval) {
            document.getElementById('<%= hfdselid.ClientID %>').value = keyval;
            cnfbox(" Are you sure do you want to delete this record?", "cnffnres");
        }

        function afterpost(msg) {

            sa5.process();
            hasp.process();
            osl.process();
            haspe.process();
            $('#btnnew_pop').dialog('close');
            $('#buttonnew_pop').dialog('close');
            altbox(msg);

        }


    </script>
    <script type="text/javascript">


        var dataIn = '';
        var hasp = new sagrid();
        hasp.url = "../WCFGrid/GridService.svc/BindHasPharmacy";

        hasp.primarykeyval = "has_emp_id";
        hasp.bindid = "grdhaspharmacy";
        
        hasp.objname = "hasp";
        hasp.process();

        function Select_lkp(sender, keyval) {
            var selperid = hasp.resultdata[sender]["Person_ID"];
            parent.window.location.href = '../PersonLicensing/PersonDetails.aspx?perid=' + selperid;
        }
        function Delete_haslkp(sender, keyval) {
            document.getElementById('<%= hfdselid.ClientID %>').value = keyval;
            document.getElementById('<%= btnhas.ClientID %>').click();
        }
        function Delete_emp(sender, keyval) {
            document.getElementById('<%=hfdselid.ClientID%>').value = keyval;
            cnfbox(" Are you sure do you want to delete this record?", "cnffnres2");

        }
        function cnffnres2(result) {
            if (result == 'true')
                document.getElementById('<%=btndeleteemp.ClientID%>').click();
        }
        function aftersave() {
            $('#btnadd_pop').dialog('close');
            $('#btnaddemployer_pop').dialog('close');
            hasp.process();
            haspe.process();
        }
    </script>

    <script>
        function open_edit(pid) {
            document.getElementById('iframehaspharmacy').src = "../PersonLicensing/HasPharmacyEmp.aspx?Person_id=" + pid;
            $('#btnadd_pop').dialog({ title: "Add New Has Pharmacy Employee Details", width: '90%' });
            $('#btnadd_pop').dialog("open");

            return false;

        }
        function Open_employer(pid) {

            document.getElementById('iframeemployer').src = "../PersonLicensing/AddNewEmployer.aspx?Person_id=" + pid;
            $('#btnaddemployer_pop').dialog({ title: "Add New Employer Details", width: '90%' });
            $('#btnaddemployer_pop').dialog("open");

            return false;
        }
    </script>
    <script type="text/javascript">
        var dataIn = '';
        var osl = new sagrid();
        osl.url = "../WCFGrid/GridService.svc/BindPersonotherstatelic";

        osl.primarykeyval = "Osl_ID";
        osl.bindid = "grdotherstatelicense";
        
        osl.objname = "osl";
        osl.process();

        function edit_lkp2(sender, keyval) {
            //altbox(sa5.resultdata[sender]["Employer_Name"]);
            document.getElementById('<%= hfdstateid.ClientID %>').value = keyval;
            document.getElementById('<%= buttonedit.ClientID %>').click();
        }
        function cnffnres1(result) {
            if (result == 'true')
                document.getElementById('<%= buttondelete.ClientID %>').click();
         }

         function Delete_lkp2(sender, keyval) {
             document.getElementById('<%= hfdstateid.ClientID %>').value = keyval;
            cnfbox(" Are you sure do you want to delete this record?", "cnffnres1");
        }
        function Popup2() {
            $(function () {
                $('#buttonnew_pop').dialog({ title: 'Edit Other State License', width: '50%' });
                $('#buttonnew_pop').dialog("open");
            });
        }
    </script>

    <script type="text/javascript" language="javascript">
        function Clear_otherstatelic() {
            document.getElementById('<%= hfdstateid.ClientID %>').value = '0';
            document.getElementById('<%= Txt_licnum.ClientID %>').value = '';
            document.getElementById('<%= ddlstatus.ClientID %>').value = '-1';
            document.getElementById('<%= Txt_datereceived.ClientID %>').value = '';
           
            document.getElementById('<%= Txt_state.ClientID %>').value = '';
            document.getElementById('<%= Chk_otherstatelic.ClientID %>').checked = false;
            return false;
        }
        function Save_validation1() {
            var errormsg = validateform('frmid1');
            if (errormsg != "") {
                Msgbox(errormsg);
                return false;
            }
            return true;
        }
    </script>
    <asp:HiddenField ID="hfdpid" runat="server" Value="0" />
    <asp:UpdatePanel ID="upd" runat="server">
        <ContentTemplate>
            <asp:HiddenField ID="hfdemployeeid" runat="server" Value="0" />
            <asp:HiddenField ID="hfdselid" runat="server" Value="0" />
            <asp:HiddenField ID="hfdobjtype" runat="server" Value="0" />
            <asp:Button ID="btnedit" runat="server" Style="display: none" OnClick="btnedit_click" />
            <asp:Button ID="btndel" runat="server" Style="display: none" OnClick="btndel_click" />
            <asp:Button ID="btnhas" runat="server" Style="display: none" OnClick="btnhas_click" />
            <asp:Button ID="btndeleteemp" runat="server" Style="display: none" OnClick="btndeleteemp_Click" />
        </ContentTemplate>
    </asp:UpdatePanel>
    <div style="width: 98%; margin-left: auto; margin-right: auto">
        <div class="cpanel" id="employee" runat="server">
            <div class="head accr expand">
                Employee at
            </div>


            <div class="body">
                <div style="text-align: right; padding-right: 10px; margin-top: 0px">
                    <asp:Button ID="btnaddemployer" runat="server" Text="Add New" />
                </div>
                <br />
                <div id="grdhasemployee">
                </div>
            </div>
        </div>
    </div>
    <div style="width: 98%; margin-left: auto; margin-right: auto">
        <div class="cpanel" id="supervisor" runat="server">
            <div class="head accr">
                Supervisor at 
                
            </div>


            <div class="body">
                <div id="supres">
                </div>
            </div>
        </div>
    </div>




    <div style="width: 98%; margin-left: auto; margin-right: auto">
        <div class="cpanel" id="haspharmacy" runat="server">
            <div class="head accr expand">
                Has Pharmacy Employee Details
            </div>
            <div class="body">
                <div style="text-align: right; padding-right: 10px; margin-top: 0px">
                    <asp:Button ID="btnadd" runat="server" Text="Add New" />
                </div>
                <br />
                <div id="grdhaspharmacy"></div>
            </div>
        </div>
    </div>
    <div style="width: 98%; margin-left: auto; margin-right: auto">
        <div class="cpanel" id="outofstate" runat="server">
            <div class="head accr">
                Out Of State Employee Details
            </div>
            <div class="body">
                <div style="text-align: right; padding-right: 10px; margin-top: 0px">
                    <input type="button" id="btnnew" value="Add New" class="poptrg" onclick="javascript: return Clear_Emp()" />
                </div>
                <br />
                <div id='btnnew_pop' class="popup" style="display: none;">
                    <span class="title">Add New Employee</span>
                    <asp:UpdatePanel ID="upd1" runat="server">
                        <ContentTemplate>
                            <table align="center" class="spac" id="frmfld">
                                <tr>
                                    <td align="right" width="35%">Name
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="txt_Name" runat="server" CssClass="required" placeholder="Name"
                                            error="Please enter name."></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">Employee Type
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="txt_employeetype" runat="server" placeholder="Employee Type"
                                            error="Please enter employee type."></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">State
                                    </td>
                                    <td align="left">
                                        <asp:DropDownList ID="ddlstate" runat="server" CssClass="required" error="Please select the state.">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">County
                                    </td>
                                    <td align="left">
                                        <asp:DropDownList ID="ddlcounty" runat="server" error="Please select county.">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">Address
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="txt_address" runat="server" CssClass="required" placeholder="Address"
                                            error="Please enter address."></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">City
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="txt_city" runat="server" CssClass="required" placeholder="City"
                                            error="Please enter city."></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">Zip
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="txt_zip" runat="server" class="required zip" placeholder="Zip" error="Please enter zip."></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center" colspan="2">
                                        <asp:Button ID="btn_submit" runat="server" Text="Submit" OnClick="btn_submit_Click"
                                            OnClientClick="javascript:return Save_Validations();" />
                                        <asp:Button ID="btn_clear" runat="server" Text="Clear" OnClientClick="javascript:return Clear_Emp();" />
                                    </td>
                                </tr>
                            </table>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
                <div id="grdemployee">
                </div>
            </div>
        </div>
    </div>
    <div style="width: 98%; margin-left: auto; margin-right: auto">
        <div class="cpanel" id="otherstate" runat="server">
            <div class="head accr">
                Other State License
            </div>
            <div class="body">
                <asp:UpdatePanel ID="UpdatePanel" runat="server">
                    <ContentTemplate>
                        <asp:HiddenField ID="hfdstateid" runat="server" Value="0" />
                        <asp:Button ID="buttonedit" runat="server" Style="display: none" OnClick="buttonedit_click" />
                        <asp:Button ID="buttondelete" runat="server" Style="display: none" OnClick="buttondelete_click" />
                    </ContentTemplate>
                </asp:UpdatePanel>
                <div style="text-align: right; padding-right: 10px; margin-top: 0px">
                    <input type="button" id="buttonnew" value="Add New" class="poptrg" onclick="javascript: return Clear_otherstatelic()" />
                </div>
                <br />
                <div id='buttonnew_pop' class="popup" style="display: none;">
                    <span class="title">Add New Other State License</span>
                    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                        <ContentTemplate>
                            <table align="center" class="spac" id="frmid1">
                                <tr>
                                    <td align="right" width="42%">License number
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="Txt_licnum" runat="server" placeholder="License number"
                                            error="Please enter License number."></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">Status
                                    </td>
                                    <td align="left">
                                        <asp:DropDownList ID="ddlstatus" runat="server">
                                            <asp:ListItem Value="-1" Text="Select"></asp:ListItem>
                                            <asp:ListItem Value="0" Text="Current"></asp:ListItem>
                                            <asp:ListItem Value="1" Text="Previous"></asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <%-- <%-- <tr>
                                   <%-- <td align="right">
                                        State
                                    </td>
                                    <td align="left">
                                        <asp:DropDownList ID="DropDownList1" runat="server" CssClass="required" error="Please select the state.">
                                        </asp:DropDownList>
                                    </td>
                                </tr>--%>
                                <%--<tr>
                                    <td align="right">
                                        County
                                    </td>
                                    <td align="left">
                                        <asp:DropDownList ID="DropDownList2" runat="server" CssClass="required" error="Please select county.">
                                        </asp:DropDownList>
                                    </td>
                                </tr>--%>
                                <tr>
                                    <td align="right">Issue Date
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="Txt_datereceived" runat="server" CssClass="date"
                                            error="Please enter Date received."></asp:TextBox>
                                    </td>
                                </tr>
                               
                                <tr>
                                    <td align="right">Other state license
                                    </td>
                                    <td align="left">
                                        <asp:CheckBox ID="Chk_otherstatelic" runat="server" />
                                    </td>
                                </tr>

                                <tr>
                                    <td align="right">State
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="Txt_state" runat="server" placeholder="State" error="Please enter State."></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center" colspan="2">
                                        <asp:Button ID="btn_licsubmit" runat="server" Text="Submit" OnClick="btn_licsubmit_Click"
                                            OnClientClick="javascript:return Save_validation1();" />
                                        <asp:Button ID="btn_licclear" runat="server" Text="Clear" OnClientClick="javascript:return Clear_otherstatelic();" />
                                    </td>
                                </tr>
                            </table>
                        </ContentTemplate>
                    </asp:UpdatePanel>

                </div>
                <div id="grdotherstatelicense">
                </div>
            </div>

        </div>
    </div>

    <div class="popup" id="btnadd_pop" style="display: none">
        <iframe id="iframehaspharmacy" width="100%" height="350px" frameborder="0"></iframe>
    </div>
    <div class="popup" id="btnaddemployer_pop" style="display: none;">
        <iframe id="iframeemployer" width="100%" height="400px" frameborder="0"></iframe>
    </div>
     <script type="text/javascript">
        var isedit = $('#ctl00_hfdwrite').val();
        var isdel = $('#ctl00_hfddel').val();
        if (isedit == 'False') {
            $('#ctl00_ContentPlaceHolder1_btnaddemployer').addClass('hide');
            $('#ctl00_ContentPlaceHolder1_btnadd').addClass('hide');
            $('#btnnew').addClass('hide');
            $('#buttonnew').addClass('hide');
        }
        if (isedit == 'True' && isdel == 'True') {
            haspe.cols = [new dcol("Start Date", "StartDate"), new dcol("Name", "Name"), new dcol("Type", "Type"), new dcol("Address", "Address1"), new dcol("City", "City"), new dcol("State", "State"), new dcol("Zip", "Zip"), new dcol("Phone", "Phone"), new dcol("Status", "Status"), new dcol("Select", "", "", "1", "1", "Select_lkp3", "fa fa-hand-o-up grdicon"), new dcol("Status Change", "", "", "1", "1", "Delete_lkp1", "fa fa-exchange grdicon"), new dcol("Delete", "", "", "1", "1", "Delete_emp", "fa fa-trash-o grdicon")];
            sa5.cols = [new dcol("Name", "Employer_Name"), new dcol("State", "State"), new dcol("County", "County"), new dcol("Address", "Address"), new dcol("City", "City"), new dcol("Zip", "Zip"), new dcol("Edit", "", "", "1", "1", "edit_lkp", "fa fa-pencil-square-o grdicon"), new dcol("Delete", "", "", "1", "1", "Delete_lkp", "fa fa-trash-o grdicon")];
            osl.cols = [new dcol("License Number", "Licno"), new dcol("Status", "Status"), new dcol("Issue Date", "Date_Received"), new dcol("OtherStateLicense", "isothers"), new dcol("States", "states"), new dcol("Edit", "", "", "1", "1", "edit_lkp2", "fa fa-pencil-square-o grdicon"), new dcol("Delete", "", "", "1", "1", "Delete_lkp2", "fa fa-trash-o grdicon")];
            hasp.cols = [new dcol("Start Date", "StartDate"), new dcol("Last Name", "Last_Name"), new dcol("First Name", "First_Name"), new dcol("Middle Name", "Middle_Name"), new dcol("Address", "Address1"), new dcol("City", "City"), new dcol("State", "State"), new dcol("Zip", "Zip"), new dcol("Phone", "Phone"), new dcol("Status", "Status"), new dcol("Select", "", "", "1", "1", "Select_lkp", "fa fa-hand-o-up grdicon"), new dcol("Status Change", "", "", "1", "1", "Delete_haslkp", "fa fa-exchange grdicon"), new dcol("Delete", "", "", "1", "1", "Delete_emp", "fa fa-trash-o grdicon")];
        }
        else if (isedit == 'True') {
            haspe.cols = [new dcol("Start Date", "StartDate"), new dcol("Name", "Name"), new dcol("Type", "Type"), new dcol("Address", "Address1"), new dcol("City", "City"), new dcol("State", "State"), new dcol("Zip", "Zip"), new dcol("Phone", "Phone"), new dcol("Status", "Status"), new dcol("Select", "", "", "1", "1", "Select_lkp3", "fa fa-hand-o-up grdicon"), new dcol("Status Change", "", "", "1", "1", "Delete_lkp1", "fa fa-exchange grdicon")];
            sa5.cols = [new dcol("Name", "Employer_Name"), new dcol("State", "State"), new dcol("County", "County"), new dcol("Address", "Address"), new dcol("City", "City"), new dcol("Zip", "Zip"), new dcol("Edit", "", "", "1", "1", "edit_lkp", "fa fa-pencil-square-o grdicon")];
            osl.cols = [new dcol("License Number", "Licno"), new dcol("Status", "Status"), new dcol("Issue Date", "Date_Received"), new dcol("OtherStateLicense", "isothers"), new dcol("States", "states"), new dcol("Edit", "", "", "1", "1", "edit_lkp2", "fa fa-pencil-square-o grdicon")];
            hasp.cols = [new dcol("Start Date", "StartDate"), new dcol("Last Name", "Last_Name"), new dcol("First Name", "First_Name"), new dcol("Middle Name", "Middle_Name"), new dcol("Address", "Address1"), new dcol("City", "City"), new dcol("State", "State"), new dcol("Zip", "Zip"), new dcol("Phone", "Phone"), new dcol("Status", "Status"), new dcol("Select", "", "", "1", "1", "Select_lkp", "fa fa-hand-o-up grdicon"), new dcol("Status Change", "", "", "1", "1", "Delete_haslkp", "fa fa-exchange grdicon")];
        }
        else if (isdel == 'True') {
            haspe.cols = [new dcol("Start Date", "StartDate"), new dcol("Name", "Name"), new dcol("Type", "Type"), new dcol("Address", "Address1"), new dcol("City", "City"), new dcol("State", "State"), new dcol("Zip", "Zip"), new dcol("Phone", "Phone"), new dcol("Status", "Status"), new dcol("Select", "", "", "1", "1", "Select_lkp3", "fa fa-hand-o-up grdicon"), new dcol("Delete", "", "", "1", "1", "Delete_emp", "fa fa-trash-o grdicon")];
            sa5.cols = [new dcol("Name", "Employer_Name"), new dcol("State", "State"), new dcol("County", "County"), new dcol("Address", "Address"), new dcol("City", "City"), new dcol("Zip", "Zip"), new dcol("Delete", "", "", "1", "1", "Delete_lkp", "fa fa-trash-o grdicon")];
            osl.cols = [new dcol("License Number", "Licno"), new dcol("Status", "Status"), new dcol("Issue Date", "Date_Received"), new dcol("OtherStateLicense", "isothers"), new dcol("States", "states"), new dcol("Delete", "", "", "1", "1", "Delete_lkp2", "fa fa-trash-o grdicon")];
            hasp.cols = [new dcol("Start Date", "StartDate"), new dcol("Last Name", "Last_Name"), new dcol("First Name", "First_Name"), new dcol("Middle Name", "Middle_Name"), new dcol("Address", "Address1"), new dcol("City", "City"), new dcol("State", "State"), new dcol("Zip", "Zip"), new dcol("Phone", "Phone"), new dcol("Status", "Status"), new dcol("Select", "", "", "1", "1", "Select_lkp", "fa fa-hand-o-up grdicon"), new dcol("Delete", "", "", "1", "1", "Delete_emp", "fa fa-trash-o grdicon")];
        }
        else
        {
            haspe.cols = [new dcol("Start Date", "StartDate"), new dcol("Name", "Name"), new dcol("Type", "Type"), new dcol("Address", "Address1"), new dcol("City", "City"), new dcol("State", "State"), new dcol("Zip", "Zip"), new dcol("Phone", "Phone"), new dcol("Status", "Status"), new dcol("Select", "", "", "1", "1", "Select_lkp3", "fa fa-hand-o-up grdicon")];
            sa5.cols = [new dcol("Name", "Employer_Name"), new dcol("State", "State"), new dcol("County", "County"), new dcol("Address", "Address"), new dcol("City", "City"), new dcol("Zip", "Zip")];
            osl.cols = [new dcol("License Number", "Licno"), new dcol("Status", "Status"), new dcol("Issue Date", "Date_Received"), new dcol("OtherStateLicense", "isothers"), new dcol("States", "states")];
            hasp.cols = [new dcol("Start Date", "StartDate"), new dcol("Last Name", "Last_Name"), new dcol("First Name", "First_Name"), new dcol("Middle Name", "Middle_Name"), new dcol("Address", "Address1"), new dcol("City", "City"), new dcol("State", "State"), new dcol("Zip", "Zip"), new dcol("Phone", "Phone"), new dcol("Status", "Status"), new dcol("Select", "", "", "1", "1", "Select_lkp", "fa fa-hand-o-up grdicon")];
        }
    </script>
    <script type="text/javascript">

        dataIn = '"pid":"' + document.getElementById('<%= hfdpid.ClientID %>').value + '"';
        sa5.data = dataIn;
        sa5.process();
    </script>
    <script type="text/javascript">

        dataIn = '"pid":"' + document.getElementById('<%= hfdpid.ClientID %>').value + '"';
        osl.data = dataIn;
        osl.process();
    </script>
    <script type="text/javascript">

        dataIn = '"pid":"' + document.getElementById('<%= hfdpid.ClientID %>').value + '"';
        hasp.data = dataIn;
        hasp.process();
    </script>
    <script type="text/javascript">

        dataIn = '"pid":"' + document.getElementById('<%= hfdpid.ClientID %>').value + '"';
        supr.data = dataIn;
        supr.process();
    </script>
    <script type="text/javascript">

        dataIn = '"pid":"' + document.getElementById('<%= hfdpid.ClientID %>').value + '"';
        haspe.data = dataIn;
        haspe.process();
    </script>
</asp:Content>
