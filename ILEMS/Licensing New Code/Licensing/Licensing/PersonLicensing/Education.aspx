<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="../Master Page/frm.master"
    CodeBehind="Education.aspx.cs" Inherits="Licensing.PersonLicensing.Education" %>

<asp:Content ID="cnt1" runat="server" ContentPlaceHolderID="ContentPlaceHolder1">
    <script type="text/javascript">
        function Popup() {
            $(function () {
                $('#btnnew_pop').dialog({ title: 'Edit Education' });
                $('#btnnew_pop').dialog("open");
            });
        }
        function Clear() {

            document.getElementById('<%=ddl_degree.ClientID %>').value = '-1';

            document.getElementById('<%=ddl_licensetype.ClientID %>').value = '-1';
            document.getElementById('<%=txtcollege.ClientID %>').value = '';

            document.getElementById('<%=start_date.ClientID %>').value = '';
            document.getElementById('<%=expected_date.ClientID %>').value = '';
            document.getElementById('<%=txt_graduationdate.ClientID %>').value = '';
            document.getElementById('<%=traditional_hours.ClientID %>').value = '';
            document.getElementById('<%=total_hours.ClientID %>').value = '';
            document.getElementById('<%=hfdeduid.ClientID %>').value = "0";
            return false;
        }
        function Clear_Exam() {
            document.getElementById('<%= hfd_examid.ClientID %>').value = '0';
            document.getElementById('<%= txt_NPLEXDT.ClientID %>').value = '';
            document.getElementById('<%= txt_nplexscr.ClientID %>').value = '';
            document.getElementById('<%= ddllictype.ClientID %>').value = '-1';
            document.getElementById('<%= txt_MPJEdate.ClientID %>').value = '';
            document.getElementById('<%= ddl_examtype.ClientID %>').value = '-1';
            document.getElementById('<%= txt_MPJE_SCR.ClientID %>').value = '';
            document.getElementById('<%= txt_Inter_Score.ClientID %>').value = '';
            return false;
        }
    </script>
    <script type="text/javascript">
        var dataIn = '';
        var exam = new sagrid();
        exam.url = "../WCFGrid/GridService.svc/BindPersonexamdetails";

        exam.primarykeyval = "exam_id";
        exam.bindid = "grdexmdetails";
        
        exam.objname = "exam";
        exam.process();

        function edit_lkp1(sender, keyval) {

            document.getElementById('<%= hfd_examid.ClientID %>').value = keyval;

            document.getElementById('<%= btnedit1.ClientID %>').click();
        }
        function Popup1() {
            $(function () {
                $('#btnnew1_pop').dialog({ title: 'Edit Exam' });
                $('#btnnew1_pop').dialog("open");
            });
        }

        function Delete_lkp1(sender, keyval) {
            document.getElementById('<%= hfd_examid.ClientID %>').value = keyval;
            cnfbox(" Are you sure do you want to delete this record?", "cnffnres2");
        }
        function cnffnres2(result) {
            if (result == 'true')
                document.getElementById('<%= btndel1.ClientID %>').click();
        }
    </script>
    <script type="text/javascript">
        function Save_Validation() {
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
        var sa5 = new sagrid();
        sa5.url = "../WCFGrid/GridService.svc/BindPersonEducation";

        sa5.primarykeyval = "Education_ID";
        sa5.bindid = "grdeducation1";
        
        sa5.objname = "sa5";

        function edit_lkp(sender, keyval) {

            document.getElementById('<%= hfdselid.ClientID %>').value = keyval;
            document.getElementById('<%= btnedit.ClientID %>').click();
        }
        function cnffnres(result) {
            if (result == 'true')
                document.getElementById('<%= btndel.ClientID %>').click();
        }
        function Delete_lkp(sender, keyval) {
            document.getElementById('<%= hfdselid.ClientID %>').value = keyval;
            cnfbox(" Are you sure do you want to delete this record?", "cnffnres");
        }

        function afterpost(msg) {
            altbox(msg);
            sa5.process();
            exam.process();
            emp.process();
            $('#btnnew_pop').dialog('close');
            $('#btnnew1_pop').dialog('close');
            $('#btnnew2_pop').dialog("close");
        }
    </script>
    <script type="text/javascript">
function Popup2() {
            $(function () {
                $('#btnnew2_pop').dialog({ title: 'Edit Exam Eligible' });
                $('#btnnew2_pop').dialog("open");
            });
        }
function Clear_Eligible()
        {
             document.getElementById('<%= hfd_Eligible_id.ClientID %>').value = '0';
            document.getElementById('<%= ddl_Eligibletype.ClientID %>').value = '-1';
            document.getElementById('<%= txt_EligibleDate.ClientID %>').value = '';
            
            return false;
         }


        var dataIn = '';
        var emp = new sagrid();
        emp.url = "../WCFGrid/GridService.svc/insertGrid";
        emp.primarykeyval = "Exam_EligibleID";
        emp.bindid = "grdexmdetails1";
        emp.objname = "emp";
       


         function Edit_exam(sender, keyval)
        {
            
            document.getElementById('<%= hfd_Eligible_id.ClientID %>').value = keyval;           
            document.getElementById('<%= btnexameligibleedit.ClientID %>').click();
        }
        function cnffnres1(result)
        {
            if (result == 'true')
                document.getElementById('<%= btnexameligibledelete.ClientID %>').click();
        }
        function Delete_exam(sender, keyval)
        {
           
            document.getElementById('<%= hfd_Eligible_id.ClientID %>').value = keyval;
            cnfbox(" Are you sure do you want to delete this record?", "cnffnres1");
        }
    </script>
    <div style="width: 98%; margin-left: auto; margin-right: auto">
        <div class="cpanel">
            <div class="head accr expand">
                Education Details
                <asp:UpdatePanel ID="upd" runat="server">
                    <ContentTemplate>
                        <asp:HiddenField ID="hfdeduid" runat="server" Value="0" />
                        <asp:HiddenField ID="hfdperid" runat="server" Value="0" />
                        <asp:HiddenField ID="hfdselid" runat="server" Value="0" />
                        <asp:Button ID="btnedit" runat="server" Style="display: none" OnClick="btnedit_click" />
                        <asp:Button ID="btndel" runat="server" Style="display: none" OnClick="btndel_click" />
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
            <div class="body">
                <div style="text-align: right; padding-right: 10px; margin-top: 0px">
                    <input type="button" id="btnnew" value="Add New" class="poptrg" onclick="javascript: return Clear()" />
                </div>
                <br />
                <div id="grdeducation1">
                </div>
                <div id='btnnew_pop' class="popup" style="display: none;">
                    <span class="title">Add New Education</span>
                    <asp:UpdatePanel ID="upd1" runat="server">
                        <ContentTemplate>
                            <table align="center" class="spac" id="frmfld">
                                <tr>
                                    <td align="right">License Type
                                    </td>
                                    <td align="left">
                                        <asp:DropDownList ID="ddl_licensetype" runat="server">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">Degree
                                    </td>
                                    <td align="left">
                                        <asp:DropDownList ID="ddl_degree" runat="server" placeholder="Degree"
                                            error="Please select the degree.">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">College
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="txtcollege" runat="server" placeholder="College"
                                            error="Please enter college."></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">Attended From
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="start_date" runat="server" placeholder="Start Date" class="date"
                                            error="Please enter attended from."></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">Expected Date
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="expected_date" runat="server" placeholder="Expected Date" class="date"
                                            error="Please enter expected date."></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">Attended To
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="txt_graduationdate" runat="server" placeholder="Graduation Date"
                                            class="date" error="Please enter attended to."></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">Traditional Hours
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="traditional_hours" runat="server" placeholder="Traditional Hours"
                                            error="Please enter traditional hours."></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">Total Hours
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="total_hours" runat="server" placeholder="Total Hours"
                                            error="Please enter total hours."></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center" colspan="2">
                                        <asp:Button ID="btn_submit" runat="server" Text="Submit" OnClick="btn_submit_Click"
                                            OnClientClick="javascript:return Save_Validation();" />
                                        <asp:Button ID="btn_clear" runat="server" Text="Clear" OnClientClick="javascript:return Clear();" />
                                    </td>
                                </tr>
                            </table>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
            </div>
        </div>
    </div>
    <div style="width: 98%; margin-left: auto; margin-right: auto">
        <div class="cpanel" id="exam" runat="server">
            <div class="head accr">
                Exam Details
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <asp:HiddenField ID="hfd_examid" runat="server" Value="0" />
                        <asp:Button ID="btnedit1" runat="server" Style="display: none" OnClick="btnedit1_click" />
                        <asp:Button ID="btndel1" runat="server" Style="display: none" OnClick="btndel1_click" />
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
            <div class="body">
                <div style="text-align: right; padding-right: 10px; margin-top: 0px">
                    <input type="button" id="btnnew1" value="Add New" class="poptrg" onclick="javascript: return Clear_Exam()" />
                </div>
                <br />
                <div id='btnnew1_pop' class="popup" style="display: none;">
                    <span class="title">Add New Exam</span>
                    <asp:UpdatePanel ID="upd2" runat="server">
                        <ContentTemplate>
                            <table align="center" class="spac" id="frmfld1">
                                <tr>
                                    <td align="right">License Type
                                    </td>
                                    <td align="left">
                                        <asp:DropDownList ID="ddllictype" runat="server">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">Exam Type
                                    </td>
                                    <td align="left">
                                        <asp:DropDownList ID="ddl_examtype" runat="server">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">NPLEX Date
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="txt_NPLEXDT" runat="server" CssClass="date"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">NPLEX Score
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="txt_nplexscr" runat="server" placeholder="NPLEX_SCR"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">MPJE Date
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="txt_MPJEdate" runat="server" CssClass="date"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">MPJE Score
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="txt_MPJE_SCR" runat="server" placeholder="MPJE_SCR"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">Inter Score
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="txt_Inter_Score" runat="server" placeholder="Inter Score"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center" colspan="2">
                                        <asp:Button ID="btn_examsubmit" runat="server" Text="Submit" OnClick="btn_examsubmit_Click"
                                            OnClientClick="javascript:return Save_ExamValidations();" />
                                        <asp:Button ID="btn_examclear" runat="server" Text="Clear" OnClientClick="javascript:return Clear_Exam();" />
                                    </td>
                                </tr>
                            </table>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
                <div id="grdexmdetails">
                </div>
            </div>
        </div>
    </div>
    <div style="width: 98%; margin-left: auto; margin-right: auto">
        <div class="cpanel" id="Div1" runat="server">
            <div class="head accr">
                Exam Eligible
                <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                    <ContentTemplate>
                        <asp:HiddenField ID="hfd_Eligible_id" runat="server" Value="0" />
                        <asp:Button ID="btnexameligibleedit" runat="server" Style="display: none" OnClick="btnexameligibleedit_Click" />
                        <asp:Button ID="btnexameligibledelete" runat="server" Style="display: none" OnClick="btnexameligibledelete_Click" />
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
            <div class="body">
                <div style="text-align: right; padding-right: 10px; margin-top: 0px">
                    <input type="button" id="btnnew2" value="Add New" class="poptrg" onclick="javascript: return Clear_Eligible()" />
                </div>
                <br />
                <div id='btnnew2_pop' class="popup" style="display: none;">
                    <span class="title">Add New Exam</span>
                    <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                        <ContentTemplate>
                            <table align="center" class="spac" id="frmfld2">
                                <tr>
                                    <td align="right">Exam Type
                                    </td>
                                    <td align="left">
                                        <asp:DropDownList ID="ddl_Eligibletype" runat="server" CssClass="required" error="please select exam type">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">Eligible Date
                                    </td>
                                    <td align="left">
                                      <asp:TextBox ID="txt_EligibleDate" runat="server"  CssClass="required date" error="please enter Eligible date"></asp:TextBox>
                                    </td>
                                </tr>
                                
                                    <td align="center" colspan="2">
                                        <asp:Button ID="btnexameligiblesbmit" runat="server" Text="Submit" OnClick="btnexameligiblesbmit_Click"
                                            OnClientClick="javascript:return Save_ExamValidations1();" />
                                        <asp:Button ID="Button4" runat="server" Text="Clear" OnClientClick="javascript:return Clear_Eligible();" />
                                    </td>
                             
                            </table>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
                <div id="grdexmdetails1">
                </div>
            </div>
            </div>
        </div>
    <script type="text/javascript">
        var isedit = $('#ctl00_hfdwrite').val();
        var isdel = $('#ctl00_hfddel').val();
        if (isedit == 'False') {
            $('#btnnew').addClass('hide');
            $('#btnnew1').addClass('hide');
        }
        if (isedit == 'True' && isdel == 'True') {
            sa5.cols = [new dcol("Degree", "degree"), new dcol("College", "College"), new dcol("Attended From", "Start_dt"), new dcol("Expected Graduation", "End_dt"), new dcol("Attended To", "DateOfGraduation"), new dcol("Traditional Hrs", "Traditional"), new dcol("Total Hrs", "total"), new dcol("Edit", "", "", "1", "1", "edit_lkp", "fa fa-pencil-square-o grdicon"), new dcol("Delete", "", "", "1", "1", "Delete_lkp", "fa fa-trash-o grdicon")];
            exam.cols = [new dcol("Exam Type", "examtype"), new dcol("NAPLEX Date", "NPLEX_DT"), new dcol("NAPLEX Score", "NPLEX_SCR"), new dcol("MPJE Date", "MPJE_DT"), new dcol("MPJE Score", "MPJE_SCR"), new dcol("Intern Hours", "Inter_Score"), new dcol("Edit", "", "", "1", "1", "edit_lkp1", "fa fa-pencil-square-o grdicon"), new dcol("Delete", "", "", "1", "1", "Delete_lkp1", "fa fa-trash-o grdicon")];
            emp.cols = [new dcol("ExamType", "ExamType"), new dcol("EligibleDate", "EligibleDate"), new dcol("Edit", "", "", "1", "1", "Edit_exam", "fa fa-pencil-square-o grdicon"), new dcol("Delete", "", "", "1", "1", "Delete_exam", "fa fa-trash-o grdicon")];
        }
        else if(isedit=='True')
        {
            sa5.cols = [new dcol("Degree", "degree"), new dcol("College", "College"), new dcol("Attended From", "Start_dt"), new dcol("Expected Graduation", "End_dt"), new dcol("Attended To", "DateOfGraduation"), new dcol("Traditional Hrs", "Traditional"), new dcol("Total Hrs", "total"), new dcol("Edit", "", "", "1", "1", "edit_lkp", "fa fa-pencil-square-o grdicon")];
            exam.cols = [new dcol("Exam Type", "examtype"), new dcol("NAPLEX Date", "NPLEX_DT"), new dcol("NAPLEX Score", "NPLEX_SCR"), new dcol("MPJE Date", "MPJE_DT"), new dcol("MPJE Score", "MPJE_SCR"), new dcol("Intern Hours", "Inter_Score"), new dcol("Edit", "", "", "1", "1", "edit_lkp1", "fa fa-pencil-square-o grdicon")];
            emp.cols = [new dcol("ExamType", "ExamType"), new dcol("EligibleDate", "EligibleDate"), new dcol("Edit", "", "", "1", "1", "Edit_exam", "fa fa-pencil-square-o grdicon")];
        }
        else if (isdel == 'True') {
            sa5.cols = [new dcol("Degree", "degree"), new dcol("College", "College"), new dcol("Attended From", "Start_dt"), new dcol("Expected Graduation", "End_dt"), new dcol("Attended To", "DateOfGraduation"), new dcol("Traditional Hrs", "Traditional"), new dcol("Total Hrs", "total"), new dcol("Delete", "", "", "1", "1", "Delete_lkp", "fa fa-trash-o grdicon")];
            exam.cols = [new dcol("Exam Type", "examtype"), new dcol("NAPLEX Date", "NPLEX_DT"), new dcol("NAPLEX Score", "NPLEX_SCR"), new dcol("MPJE Date", "MPJE_DT"), new dcol("MPJE Score", "MPJE_SCR"), new dcol("Intern Hours", "Inter_Score"), new dcol("Delete", "", "", "1", "1", "Delete_lkp1", "fa fa-trash-o grdicon")];
            emp.cols = [new dcol("ExamType", "ExamType"), new dcol("EligibleDate", "EligibleDate"), new dcol("Delete", "", "", "1", "1", "Delete_exam", "fa fa-trash-o grdicon")];
        }
        else
        {
            sa5.cols = [new dcol("Degree", "degree"), new dcol("College", "College"), new dcol("Attended From", "Start_dt"), new dcol("Expected Graduation", "End_dt"), new dcol("Attended To", "DateOfGraduation"), new dcol("Traditional Hrs", "Traditional"), new dcol("Total Hrs", "total")];
            exam.cols = [new dcol("Exam Type", "examtype"), new dcol("NAPLEX Date", "NPLEX_DT"), new dcol("NAPLEX Score", "NPLEX_SCR"), new dcol("MPJE Date", "MPJE_DT"), new dcol("MPJE Score", "MPJE_SCR"), new dcol("Intern Hours", "Inter_Score")];
            emp.cols = [new dcol("ExamType", "ExamType"), new dcol("EligibleDate", "EligibleDate")];
        }
    </script>
    <script type="text/javascript">

        dataIn = '"pid":"' + document.getElementById('<%= hfdperid.ClientID %>').value + '"';
        sa5.data = dataIn;
        sa5.process();
    </script>
    <script type="text/javascript">

        dataIn = '"pid":"' + document.getElementById('<%= hfdperid.ClientID %>').value + '"';
        exam.data = dataIn;
        exam.process();

        dataIn = '"pid":"' + document.getElementById('<%= hfdperid.ClientID %>').value + '"';
       
        emp.data = dataIn;
        emp.process();

    </script>
</asp:Content>
