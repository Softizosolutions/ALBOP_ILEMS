<%@ Page Language="C#" MasterPageFile="../Master Page/frm.master" AutoEventWireup="true" CodeBehind="complaints.aspx.cs" Inherits="Licensing.PersonLicensing.complaints" %>

<asp:Content ID="cnt1" runat="server" ContentPlaceHolderID="ContentPlaceHolder1">
    <script type="text/javascript">


        var dataIn = '';
        var sa5 = new sagrid();
        sa5.url = "../WCFGrid/GridService.svc/GetComplaints";

        sa5.primarykeyval = "Complaint_ID";
        sa5.bindid = "grdcomp";
        sa5.aftercall = "bindfrm";
        
        sa5.objname = "sa5";

        var phis = new sagrid();
        phis.url = "../WCFGrid/GridService.svc/Getcmppersonhis";

        phis.primarykeyval = "Person_his_id";
        phis.bindid = "grdhis_per";

        phis.cols = [new dcol("From", "Old"), new dcol("To", "New"), new dcol("Changed by", "chby"), new dcol("Changed Date", "Changeddt")];
        phis.objname = "phis";
        function bindfrm() {
            var trs = document.getElementById('grdcomp').getElementsByTagName('tbody')[0].getElementsByTagName('tr');
            var selcmpno = document.getElementById('<%= hfdselcmpno.ClientID %>').value;

            if (selcmpno == "0") {
                if (trs.length > 0) {
                    var lcell = trs[0].getElementsByTagName('a')[0];
                    lcell.click();
                }
            }
            else {
                for (var i = 0; i < trs.length; i++) {
                    var lcell = trs[i].getElementsByTagName('a')[0];
                    if (lcell.innerText == selcmpno) {
                        lcell.click();
                        return;
                    }
                }
            }
            if (trs.length > 0) {
                var lcell = trs[0].getElementsByTagName('a')[0];
                lcell.click();
            }
        }
        function bindgrd() {
            var pid = document.getElementById('<%= hfdRespondentId.ClientID %>').value;
            var presid = document.getElementById('<%= hfdpresid.ClientID %>').value;

            dataIn = '"resptype":"1","respid":"' + pid + '","responseid":"' + presid + '"';
            sa5.data = dataIn;
            sa5.process();
        }

        function show_his(sender, keyval) {

            phis.data = '"cmpid":"' + keyval + '"';
            phis.process();
            $('#grdhis_per').dialog({ title: 'Person Responsible History', Width: '80%' });
            $('#grdhis_per').dialog('open');
        }
        function select_lkp(sender, keyval) {
            document.getElementById('<%= hfdselid.ClientID %>').value = keyval;
            var cmpno = sa5.resultdata[sender]["Complaint_Number"];
            document.getElementById('<%= hfdstatus.ClientID %>').value = sa5.resultdata[sender]["Complaint_Status"];
            var lis = $('.dtab').find('li');

            for (var i = 0; i < lis.length; i++) {
                $(lis[i]).find('#cnum').html(cmpno + ' ');
            }

            if ($('.dtab').find('li').length > 0) {
                $('.dtab li:eq(0)').click();
            }
        }
        function edit_lkp(sender, keyval) {

            document.getElementById('<%= hfdselid.ClientID %>').value = keyval;
            document.getElementById('<%= btnedit.ClientID %>').click();
        }
        function print_lkp(sender, keyval) {

            parent.printothrs(3, keyval);
        }


    </script>

    <script language="javascript">
        function loaddiv(ctl, url, wrt, del) {
            var cmpid = document.getElementById('<%= hfdselid.ClientID %>').value;
            var pid = document.getElementById('<%=hfdRespondentId.ClientID %>').value;
            var status = document.getElementById('<%=hfdstatus.ClientID %>').value;
            var type = "2";
            document.getElementById('frm').src = url + "?cmpid=" + cmpid + "&pid=" + pid + "&type=" + type + "&iswrite=" + wrt + "&isdel=" + del + "&status=" + status;

            $(ctl).closest('ul').find('li').removeClass('li_active');
            $(ctl).addClass('li_active');
        }
        var selpname = "";
        function Openapplication(Lid) {
            $(function () {
                $('#btnret_pop').dialog({ title: 'Edit Complaint Information', width: '80%' });
                $('#btnret_pop').dialog("open")
            });
        }

        function Openapplication2(pid) {

            document.getElementById('btnCopy').click();
            return false;
        }
        function openaddperson(pid) {

            parent.addnewperson(pid);
            return false;
        }
        function aftercomplete() {
            parent.aftersave();
            return false;
        }
        function ShowHideCheckbox() {
            var preves = $('#<%=hfdpers.ClientID %>').val();
            var cures = $('#<%= ddlcompresposible.ClientID %> option:selected').val();
            if (preves != cures) {
                $('#attachdoc').css("display", "block");
            }
            else {
                $('#attachdoc').css("display", "none");
            }
        }
    </script>

    <input type="button" id="btnCopy" value="New Fileds" class="poptrg" style="display: none" />

    <asp:HiddenField ID="hfdpers" runat="server" Value="0" />
    <asp:HiddenField ID="hfdRespondentType" runat="server" Value="0" />
    <asp:HiddenField ID="hfdcompanioncaseidoutparm" runat="server" Value="0" />
    <asp:HiddenField ID="hfdrelatedcompid" runat="server" Value="0" />
     <asp:HiddenField ID="hfdstatus" runat="server" Value="0" />
    <asp:HiddenField ID="hfdRespondentId" runat="server" Value="0" />
    <asp:HiddenField ID="hfdcompNum" runat="server" Value="0" />
    <asp:HiddenField ID="hfdselid" runat="server" Value="0" />
    <asp:HiddenField ID="hfdselcmpno" runat="server" Value="0" />
    <asp:HiddenField ID="hfdpresid" runat="server" Value="0" />
    <asp:Button ID="btnedit" runat="server" Style="display: none" OnClick="btnedit_click" />

    <div class="cpanel" style="width: 98%; margin-left: auto; margin-right: auto">
        <div class="head accr">Existing Complaints</div>
        <div class="body">
            <div id="grdcomp">
            </div>

        </div>
    </div>

    <div>&nbsp;</div>
    <div id="grdhis_per" class="popup"></div>
    <div class="cpanel" style="width: 98%; margin-left: auto; margin-right: auto">
        <div class="thead">
            <div class="dtab">

                <ul id="tabs" runat="server" style="padding: 0; margin: 0;">
                </ul>

            </div>
        </div>
        <div class="body">
            <div id="tabcnt">
                <iframe id="frm" width="100%" height="400px" frameborder="0" scrolling="no"></iframe>
            </div>
        </div>
    </div>
    <div id='btnret_pop' class="popup" style="display: none;">
        <table width="100%" class="spac">
            <tr>
                <td align="right">
                    <asp:Label ID="Label36" runat="server" Text="Source" CssClass="Labels"></asp:Label></td>
                <td align="left">

                    <asp:DropDownList ID="ddlcompsource" CssClass="drpcssbox" Width="98%" runat="server" class="required">
                    </asp:DropDownList>

                </td>

                <td align="right">
                    <asp:Label ID="Label38" runat="server" Text="Category" CssClass="Labels"></asp:Label></td>
                <td align="left">
                    <asp:DropDownList ID="ddlcompcategory" runat="server" CssClass="drpcssbox" Width="98%" class="required">
                    </asp:DropDownList>
                </td>

            </tr>
            <tr>
                <td align="right">
                    <asp:Label ID="Label2" runat="server" Text="Date Received" CssClass="Labels"></asp:Label>
                </td>
                <td align="left">

                    <asp:TextBox ID="txtcompdaterecive" runat="server" class="required date" CssClass="date"></asp:TextBox>

                </td>
                <td align="right">
                    <asp:Label ID="lblcomstatus" runat="server" Text="Complaint Status" CssClass="Labels"></asp:Label></td>
                <td align="left">
                    <asp:DropDownList ID="ddlcompstatus" runat="server" CssClass="drpcssbox">
                    </asp:DropDownList>
                </td>
                <%--  <td align="right">               
                <asp:Label ID="Label4" runat="server" Text="Date Docketed" CssClass="Labels"></asp:Label>

            </td>
            <td align="left">
               
                    <asp:TextBox ID="txtcomodocketed" runat="server"   CssClass="date"></asp:TextBox>
 
            </td>--%>
            </tr>
            <tr>


                <td align="right">

                    <asp:Label ID="Label10" runat="server" Text="Complainant" CssClass="Labels"></asp:Label>
                </td>
                <td align="left">
                    <asp:TextBox ID="txtcomplainant" runat="server"></asp:TextBox>
                </td>
                <td align="right">
                    <asp:Label ID="Label9" runat="server" Text="Address1" CssClass="Labels"></asp:Label>
                </td>
                <td align="left">

                    <asp:TextBox ID="txtcompadd1" runat="server" placeholder="Address1"></asp:TextBox>

                </td>
            </tr>
            <tr>

                <td align="right">
                    <asp:Label ID="Label23" runat="server" Text="Address2" CssClass="Labels"></asp:Label>
                </td>
                <td align="left">

                    <asp:TextBox ID="txtcompadd2" runat="server" placeholder="Address2"></asp:TextBox>

                </td>

                <td align="right">
                    <asp:Label ID="Label41" runat="server" Text="City" CssClass="Labels"></asp:Label>
                </td>
                <td align="left">

                    <asp:TextBox ID="txtcompcity" runat="server" placeholder="City"></asp:TextBox>

                </td>
            </tr>
            <tr>

                <td align="right">

                    <asp:Label ID="Label43" runat="server" Text="State/Zip" CssClass="Labels"></asp:Label>
                </td>
                <td align="left">
                    <asp:DropDownList ID="ddlcompstate" runat="server" Width="50px" CssClass="drpcssbox">
                    </asp:DropDownList>
                    <asp:TextBox ID="txtcompzip" runat="server" Width="80px" CssClass="zip"></asp:TextBox>
                </td>

                <td align="right">

                    <asp:Label ID="Label6" runat="server" Text="Person Responsible" CssClass="Labels"></asp:Label>
                </td>
                <td align="left">
                    <asp:DropDownList ID="ddlcompresposible" runat="server" CssClass="drpcssbox" class="required" onchange="javascript:return ShowHideCheckbox();">
                    </asp:DropDownList><br />
                    <span style="display: none;" id="attachdoc">
                        <asp:CheckBox ID="chkattachdoc" runat="server" Text="Attach Initial Document" /></span>
                </td>

            </tr>
            <%--  <tr id="attachdoc" style="display:none;">
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td align="right"></td>
            </tr>--%>
            <tr>

                <td align="right">

                    <asp:Label ID="Label11" runat="server" Text="Investigator" CssClass="Labels"></asp:Label>
                </td>
                <td align="left">
                    <asp:DropDownList ID="ddlcompinvestigate" runat="server" CssClass="drpcssbox" class="required">
                    </asp:DropDownList>
                </td>
                                <td align="right">

                    <asp:Label ID="Label4" runat="server" Text="Second Investigator" CssClass="Labels"></asp:Label>
                </td>
                <td align="left">
                    <asp:DropDownList ID="ddlcompinvestigate2" runat="server" CssClass="drpcssbox" class="required">
                    </asp:DropDownList>
                </td>

              

            </tr>


            <tr>

                  <td align="right">

                    <asp:Label ID="lblinvassigned" runat="server" Text="Investigator Assigned" CssClass="Labels"></asp:Label>
                </td>
                <td align="left">

                    <asp:TextBox ID="txtInvestigateAssigned" runat="server" CssClass="date"></asp:TextBox>

                </td>
                <td align="right">

                    <asp:Label ID="Label17" runat="server" Text="Investigator Received" CssClass="Labels"></asp:Label>

                </td>
                <td align="left">

                    <asp:TextBox ID="txtInvestigatorReceived" runat="server" CssClass="date"></asp:TextBox>


                </td>
               
            </tr>
            <tr>
                 <td align="right">

                    <asp:Label ID="lblnurseconsultant" runat="server" Text="Investigation Turned In" CssClass="Labels"></asp:Label>
                </td>
                <td align="left">
                    <asp:TextBox ID="txtdateinvgcomplete" runat="server" CssClass="date"></asp:TextBox>

                </td>
            </tr>
            <tr>
                <td colspan="4" align="center">
                    <table cellpadding="0" cellspacing="0" align="center">

                        <tr>
                            <td align="center">
                                <asp:Button ID="btnupdateComplaint" runat="server" CssClass="button_bg" Height="30" OnClick="btnupdateComplaint_Click"
                                    Text="Submit" Width="108px" />
                            </td>

                            <td align="center">
                                <asp:Button ID="btncomplaintcancel" runat="server" CssClass="button_bg" Height="30" Text="Clear"
                                    Width="108px" />
                                <asp:HiddenField ID="hfdautoid" runat="server" Value="0" />
                            </td>
                            <td align="center">
                                <asp:Button ID="btnNotify_Investigators" runat="server" CssClass="button_bg" Height="30" OnClick="btnNotify_Investigators_Click" Text="Notify Second Investigator"
                                    Width="170px" />
                                
                            </td>

                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>

    <div id='btnCopy_pop' class="popup" style="display: none;">
        <span class="title">Copy - Complaint Information </span>

        <table width="100%" cellpadding="5" cellspacing="5">
            <tr>
                <td align="right">
                    <asp:Label ID="Label1" runat="server" Text="Source" CssClass="Labels"></asp:Label></td>
                <td colspan="2">
                    <table cellpadding="0" cellspacing="0">
                        <tr>
                            <td>
                                <asp:DropDownList ID="ddlcompsource1" CssClass="drpcssbox" runat="server" class="required">
                                </asp:DropDownList>
                            </td>
                            <td></td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td align="right">
                    <asp:Label ID="Label3" runat="server" Text="Category" CssClass="Labels"></asp:Label></td>
                <td>
                    <asp:DropDownList ID="ddlcompcategory1" runat="server" CssClass="drpcssbox" class="required">
                    </asp:DropDownList>
                </td>

            </tr>
            <tr>
                <td align="right">
                    <asp:Label ID="Label5" runat="server" Text="Date Received" CssClass="Labels"></asp:Label>
                </td>
                <td>
                    <div class="txboxdiv">
                        <asp:TextBox ID="TextBox1" runat="server" Width="145px" class="required date" CssClass="date"></asp:TextBox>

                    </div>
                </td>
            </tr>
            <tr>
                <td align="right">
                    <asp:Label ID="Label7" runat="server" Text="Date Docketed" CssClass="Labels"></asp:Label>

                </td>
                <td>
                    <div class="txboxdiv">
                        <asp:TextBox ID="TextBox2" runat="server" Width="145px" CssClass="date"></asp:TextBox>

                    </div>
                </td>
            </tr>
            <tr>
                <td align="right">
                    <asp:Label ID="Label8" runat="server" Text="Status" CssClass="Labels"></asp:Label></td>
                <td>
                    <asp:DropDownList ID="ddlcompstatus1" runat="server" CssClass="drpcssbox">
                        <asp:ListItem Value="-1">--Select--</asp:ListItem>
                        <asp:ListItem Value="1">Open</asp:ListItem>
                        <asp:ListItem Value="0">Close</asp:ListItem>
                    </asp:DropDownList>
                </td>

            </tr>
            <tr>
                <td align="right">
                    <asp:Label ID="Label12" runat="server" Text="Address" CssClass="Labels"></asp:Label>
                </td>
                <td>
                    <div class="txboxdiv">
                        <asp:TextBox ID="TextBox3" runat="server" CssClass="txtcssbox" Width="145px"></asp:TextBox>
                    </div>
                </td>
            </tr>
            <tr>
                <td align="right">
                    <asp:HiddenField ID="HiddenField2" runat="server" Value="0" />
                </td>
                <td>
                    <div class="txboxdiv">
                        <asp:TextBox ID="TextBox4" runat="server" CssClass="txtcssbox" Width="145px"></asp:TextBox>
                    </div>
                </td>
            </tr>
            <tr>
                <td align="right">
                    <asp:Label ID="Label13" runat="server" Text="City" CssClass="Labels"></asp:Label>
                </td>
                <td>
                    <div class="txboxdiv">
                        <asp:TextBox ID="TextBox5" Width="145" runat="server" CssClass="txtcssbox"></asp:TextBox>
                    </div>
                </td>
            </tr>
            <tr>
                <td align="right">

                    <asp:Label ID="Label14" runat="server" Text="State" CssClass="Labels"></asp:Label>
                </td>
                <td>
                    <asp:DropDownList ID="ddlcompstate1" runat="server" CssClass="drpcssbox">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>

                <td align="right">

                    <asp:Label ID="Label15" runat="server" Text="Zip" CssClass="Labels"></asp:Label>
                </td>
                <td align="left">
                    <div class="txboxdivSmall">
                        <asp:TextBox ID="TextBox6" Width="76" runat="server" CssClass="txtcssboxsmall"></asp:TextBox>
                    </div>
                </td>
            </tr>
            <tr>
                <td align="right">

                    <asp:Label ID="Label16" runat="server" Text="Person Responsible" CssClass="Labels"></asp:Label>
                </td>
                <td>
                    <asp:DropDownList ID="ddlcompresposible1" runat="server" CssClass="drpcssbox" class="required">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td align="right">

                    <asp:Label ID="Label18" runat="server" Text="Complainant" CssClass="Labels"></asp:Label>
                </td>
                <td>
                    <asp:RadioButtonList ID="RadioButtonList1" runat="server" RepeatDirection="Horizontal">
                        <asp:ListItem Value="0" Selected="True">Person</asp:ListItem>
                        <asp:ListItem Value="1">Place</asp:ListItem>
                    </asp:RadioButtonList>
                </td>
            </tr>
            <tr>
                <td align="right" class="Labels"></td>
                <td align="left">
                    <table cellpadding="0" cellspacing="0">
                        <tr>
                            <td>
                                <div class="txboxdiv">
                                    <asp:TextBox ID="TextBox7" runat="server" CssClass="txtcssbox"
                                        TabIndex="9" Width="145"></asp:TextBox>
                                </div>
                            </td>
                            <td>

                                <%-- <asp:Button ID="btncmplintsearch" runat="server" CssClass="button_bg" Height="30"
                                Text="Search" Width="108px" OnClientClick="javascript:return open_editcompalint()" />--%>

                            </td>
                        </tr>
                    </table>
                </td>
                <td align="left"></td>
            </tr>

            <tr>
                <td align="right">

                    <asp:Label ID="Label19" runat="server" Text="Investigator" CssClass="Labels"></asp:Label>
                </td>
                <td>
                    <asp:DropDownList ID="ddlcompinvestigate1" runat="server" CssClass="drpcssbox" class="required">
                    </asp:DropDownList>
                </td>
            </tr>

            <tr>
                <td align="right">

                    <asp:Label ID="Label20" runat="server" Text="Date Investigator Assigned" CssClass="Labels"></asp:Label>
                </td>
                <td>
                    <div class="txboxdiv">
                        <asp:TextBox ID="TextBox8" runat="server" Width="145px" CssClass="date"></asp:TextBox>
                    </div>
                </td>
            </tr>
            <tr>
                <td align="right">

                    <asp:Label ID="Label21" runat="server" Text="Date Investigator Received" CssClass="Labels"></asp:Label>

                </td>
                <td>
                    <div class="txboxdiv">
                        <asp:TextBox ID="TextBox9" runat="server" Width="145px" CssClass="date"></asp:TextBox>

                    </div>
                </td>
            </tr>
            <tr>
                <td align="right">

                    <asp:Label ID="Label22" runat="server" Text="Consultant" CssClass="Labels"></asp:Label>
                </td>
                <td>
                    <asp:DropDownList ID="ddlNurseConsultant1" runat="server" CssClass="drpcssbox">
                    </asp:DropDownList>
                </td>
            </tr>

            <tr>
                <td colspan="4" align="center">
                    <table cellpadding="0" cellspacing="0" align="center">

                        <tr>
                            <td align="center">
                                <asp:Button ID="Button1" runat="server" CssClass="button_bg" Height="30"
                                    Text="Submit" Width="108px" />
                            </td>

                            <td align="center">
                                <asp:Button ID="Button2" runat="server" CssClass="button_bg" Height="30" Text="Clear"
                                    Width="108px" OnClientClick="javascript:return compcancel();" />
                                <asp:HiddenField ID="HiddenField3" runat="server" Value="0" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>

   <script type="text/javascript">
        var isedit = $('#ctl00_hfdwrite').val();
        var isdel = $('#ctl00_hfddel').val();
        if (isedit == 'True')
            sa5.cols = [new dcol("Complaint #", "Complaint_Number", "", "1", "0", "select_lkp", ""), new dcol("Source", "SourceDescription"), new dcol("Complainant", "ComplainantName"), new dcol("Category", "CategoryDescription"), new dcol("Status", "Complaint_Status"), new dcol("Resolution", "Resolutions"), new dcol("Board Action", "Board_Action"), new dcol("Person Responsible", "Responsible", "", "1", "0", "show_his", ""), new dcol("Received Date", "DateReceived"), new dcol("Edit", "", "", "1", "1", "edit_lkp", "fa fa-pencil-square-o grdicon"), new dcol("Print", "", "", "1", "1", "print_lkp", "fa fa-print grdicon")];
        else
            sa5.cols = [new dcol("Complaint #", "Complaint_Number", "", "1", "0", "select_lkp", ""), new dcol("Source", "SourceDescription"), new dcol("Complainant", "ComplainantName"), new dcol("Category", "CategoryDescription"), new dcol("Status", "Complaint_Status"), new dcol("Resolution", "Resolutions"), new dcol("Board Action", "Board_Action"), new dcol("Person Responsible", "Responsible", "", "1", "0", "show_his", ""), new dcol("Received Date", "DateReceived"), new dcol("Print", "", "", "1", "1", "print_lkp", "fa fa-print grdicon")];
        bindgrd();
    </script>
    <script type="text/javascript">
        function Popup() {
            $(function () { $('#btnnew_pop').dialog("open"); });
        }
    </script>

</asp:Content>
