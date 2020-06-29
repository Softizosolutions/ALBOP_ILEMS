<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/PersonLicensing/Person.Master"
    CodeBehind="RenewalProcess.aspx.cs" Inherits="Licensing.PersonLicensing.RenewalProcess" %>

<asp:Content ID="content1" runat="server" ContentPlaceHolderID="cntmain">
    <script type="text/javascript">



        var sa5 = new sagrid();
        sa5.url = "../WCFGrid/GridService.svc/Getrenewaldata";

        sa5.primarykeyval = "Order_ID";
        sa5.bindid = "grddata";
        sa5.cols = [new dcol("Name", "e_Signature"), new dcol("License #", "License_No"), new dcol("Order ID", "Order_ID"), new dcol("Date Of Submission", "Date_Of_Submission"), new dcol("Is US", "isus"), new dcol("Email", "Email", "", "1", "", "Email_click", "", "")];
        sa5.objname = "sa5";
        sa5.aftercall = "aftercall";
        function Bindgrd() {
            var dataIn = '';
            dataIn = '"sdt":"' + document.getElementById('<%= txtfromdate.ClientID %>').value + '",';
            dataIn = dataIn + '"edt":"' + document.getElementById('<%= txttodate.ClientID %>').value + '",';
            dataIn = dataIn + '"ltype":"' + document.getElementById('<%= ddlrenewaltype.ClientID %>').value + '",';
           
            if (document.getElementById('<%= rdlfiltertype.ClientID %>' + '_0').checked == true) {
                sa5.cols = [new dcol("Select", "", "", "1", "1", "select_lkp", "fa fa-hand-o-up grdicon"),new dcol("Name", "e_Signature", "", "1", "", "per_det", "", ""), new dcol("License #", "License_No"), new dcol("Order ID", "Order_ID", "", "1", "", "nm_click", "", ""), new dcol("Date Of Submission", "Date_Of_Submission"), new dcol("US Citizen?", "isus"), new dcol("Email", "Email", "", "1", "", "Email_click", "", "")];

                dataIn = dataIn + '"isprocess":"0",';
            }
            else {
                sa5.cols = [new dcol("<input id='mctl' type='checkbox' onclick='chkall()'>", "", "", "3", "1", "selchk", "", ""),new dcol("Select", "", "", "1", "1", "select_lkp", "fa fa-hand-o-up grdicon"), new dcol("Name", "e_Signature", "", "1", "", "per_det", "", ""), new dcol("License #", "License_No"), new dcol("Order ID", "Order_ID", "", "1", "", "nm_click1", "", ""), new dcol("Date Of Submission", "Date_Of_Submission"), new dcol("US Citizen?", "isus"), new dcol("Email", "Email", "", "1", "", "Email_click", "", "")];

                dataIn = dataIn + '"isprocess":"1",';
            }
            dataIn = dataIn + '"licno":"' + document.getElementById('<%= txtlicno.ClientID %>').value + '"';
           
            
            sa5.data = dataIn;
            sa5.process();
        }
        function aftercall() {
            var res = sa5.resultdata;
            if (res.length > 0) {
                
                $('#grddata tbody tr').each(function() {
                    var mctd = $(this).find('td:last');
                       
                    if ($(mctd).text() != "") {
                        $(mctd).html('<a href="mailto:' + $(mctd).text() + '">' + $(mctd).text() + '</a>');
                        }
                    });
                return true;
            }
            else {
                altbox("No records found.");
                document.getElementById('grddata').innerHTML = "";
                return false;
            }
        }
        function select_lkp(sender, keyval) {
            var objtype = sa5.resultdata[sender]["object_type"];
            var perid = sa5.resultdata[sender]["Person_ID"];
            var licid = sa5.resultdata[sender]["License_Id"];
             var olnk = '<%= System.Configuration.ConfigurationManager.AppSettings["onlinelink"].ToString() %>';
            document.getElementById('iframeprofile').src = olnk+'ProfileRedirect.aspx?id=' + objtype + '&pid=' + perid + '&licid=' + licid + '&nomenu=1';
            $('#myprofilepopup').dialog({ title: "My Profile", width: "95%" });
            $('#myprofilepopup').dialog('open');

        }
        function Email_click(sender, keyval) {

            var email1 = sa5.resultdata[sender]["Email"];
            document.getElementById('email').value = email;
            document.getElementById('email').href = 'mailto:' + email1;
           
            document.getElementById('email').click();
            document.getElementById('email').href = "";
           
        }
    </script>
    <script type="text/javascript">
        function selchk(sender, keyval) {
            var ischk = 0;
            $('#grddata').find(':checkbox').each(function () {
                if (this.checked)
                    ischk = 1;
            });
            if (ischk == 1)
            {
                document.getElementById('btnprint').style.display = 'block';
                document.getElementById('btnlabl').style.display = 'block';
            }
            else
            {
                document.getElementById('btnprint').style.display = 'none';
                document.getElementById('btnlabl').style.display = 'none';
            }
        }
        function per_det(sender,keyval)
        {
            var perid = sa5.resultdata[sender]["Person_ID"];
            var objtype = sa5.resultdata[sender]["object_type"];
            if (objtype == "1")
            {
                window.open("PersonDetails.aspx?id=" + perid);
            }
            else
                window.open("Business_Details.aspx?id=" + perid);
            

        }
        function nm_click(sender, keyval) {
            Clearvalues();
            document.getElementById('<%=hfdorderid.ClientID %>').value = keyval;
            $('#frm').attr('src', document.getElementById('<%= hfdurl.ClientID %>').value + '?ordid=' + keyval + '&noprint=0');
            document.getElementById('<%= ddlrenewalstatus.ClientID %>').value = sa5.resultdata[sender]["rstatus"];
            document.getElementById('<%= txtrenewaldate.ClientID %>').value = sa5.resultdata[sender]["rdt"];
            document.getElementById('<%= txtcomments.ClientID %>').value = sa5.resultdata[sender]["rcmnt"];
            $('#rflds').show();
             $('#btn_popup').dialog({ title: "Renewal Process", width: "90%", minHeight: 250 });
             $('#btn_popup').dialog('open');

        }
          function nm_click1(sender, keyval) {
            Clearvalues();
            document.getElementById('<%=hfdorderid.ClientID %>').value = keyval;
            $('#frm').attr('src', document.getElementById('<%= hfdurl.ClientID %>').value + '?ordid=' + keyval + '&noprint=0');
            document.getElementById('<%= ddlrenewalstatus.ClientID %>').value = sa5.resultdata[sender]["rstatus"];
            document.getElementById('<%= txtrenewaldate.ClientID %>').value = sa5.resultdata[sender]["rdt"];
              document.getElementById('<%= txtcomments.ClientID %>').value = sa5.resultdata[sender]["rcmnt"];
              $('#rflds').hide();
             $('#btn_popup').dialog({ title: "Renewal Process", width: "90%", minHeight: 250 });
             $('#btn_popup').dialog('open');

        }
         
        function chkall() {
            var selval = document.getElementById('mctl').checked;

            $('#grddata').find(':checkbox').each(function () {
                this.checked = selval;
            });
            if (selval == true) {
                document.getElementById('btnlabl').style.display = 'block';
                
                document.getElementById('btnprint').style.display = 'block';
            }
            else {

                document.getElementById('btnlabl').style.display = 'none';
                document.getElementById('btnprint').style.display = 'none';
            }
        }
        function validate_search() {
            if (document.getElementById('<%= ddlrenewaltype.ClientID %>').value == '-1') {
            altbox('Please Renewal License Type');
            return false;
        }
            if (document.getElementById('<%= txtfromdate.ClientID %>').value == '' && document.getElementById('<%= txtlicno.ClientID %>').value == '') {
                altbox('Please Enter Start Date or License #');
                return false;
            }
            Bindgrd();
            return false;
        }
        function afterpost(msg) {
            
            $('#btn_popup').dialog('close');
            altbox(msg);
            sa5.process();
        }
        function SerachClear() {
            document.getElementById('<%=txtfromdate.ClientID %>').value = '';
            document.getElementById('<%=txttodate.ClientID %>').value = '';
            document.getElementById('<%=ddlrenewaltype.ClientID %>').value = "-1";
            document.getElementById('<%=rdlfiltertype.ClientID %>').value = "-1";
            document.getElementById('grddata').innerHTML = '';
        }
        function Clearvalues() {
            document.getElementById('<%=ddlrenewalstatus.ClientID %>').value = '-1';
            document.getElementById('<%=txtrenewaldate.ClientID %>').value = '';
            document.getElementById('<%=txtcomments.ClientID %>').value = '';
        }
        function print_cert(typ) {
            var selids = "";
            var trs = document.getElementById('grddata').getElementsByTagName('tbody')[0].getElementsByTagName('tr');
            for (var i = 0; i < trs.length; i++) {
                if (trs[i].getElementsByTagName('input')[0].checked == true) {
                    selids = selids + sa5.resultdata[i]["App_Id"] + ",";
                }
            }
            var lictype = $('[id$=ddlrenewaltype]').val();
            $('[id$=ddl_Printpages]').find('option').each(function () {
                if ($(this).val() == lictype) {
                    lictype = $(this).text();
                }
            })
            if (selids != "")
                selids = selids.substring(0, selids.length - 1);
            if (typ == 0)
                window.open("../Prints/prnt_cert.aspx?pname=" + lictype + "&refid=" + selids);
            else
                window.open("../Prints/labelPrinting.aspx?refid=" + selids);
            return false;
          }
    </script>
      <a id="email" href="#" style="display:none"></a>
    <asp:DropDownList ID="ddl_Printpages" runat="server" style="display:none"></asp:DropDownList>
    <div class="cpanel">
        <div class="head">
            Renewal Processing
        </div>
        <div class="body">
        <asp:HiddenField ID="hfdurl" runat="server" Value="" />
            <table id="frmfld" class="spac" align="center" cellpadding="10" cellspacing="10">
                <tr>
                    <td align="right">
                        From Date
                      
                    </td>
                    <td align="left">
                        <asp:TextBox ID="txtfromdate" runat="server" CssClass="date" error="Please Enter Start Date"></asp:TextBox>
                    </td>
                    <td>
                        &nbsp;
                    </td>
                    <td align="right">
                        To Date
                    </td>
                    <td align="left">
                        <asp:TextBox ID="txttodate" runat="server" CssClass="date" error="Please Enter End Date"></asp:TextBox>
                    </td>
                    <td align="right">
                    License # :
                    </td>
                    <td align="left">
                    <asp:TextBox ID="txtlicno" runat="server"></asp:TextBox>

                    </td>
                </tr>
                <tr>
                    <td align="right">
                        Renewal Type
                    </td>
                    <td align="left">
                        <asp:DropDownList ID="ddlrenewaltype" runat="server" CssClass="required" error="Please Select Renewal Type">
                        </asp:DropDownList>
                    </td>
                    <td>
                        &nbsp;
                    </td>
                    <td align="right">
                        Filter Type
                    </td>
                    <td align="left">
                        <asp:RadioButtonList ID="rdlfiltertype" runat="server" RepeatDirection="Horizontal">
                            <asp:ListItem Value="0" Selected="True" Text="Yes Answers"></asp:ListItem>
                            <asp:ListItem Value="1" Text="Renewed"></asp:ListItem>
                        </asp:RadioButtonList>
                    </td>
                </tr>
                <tr>
                    <td colspan="6" align="center">
                        <asp:Button ID="btnsearch" runat="server" Text="Search" OnClientClick="javascript:return validate_search()" />
                        <asp:Button ID="btnclear" runat="server" Text="Clear" OnClientClick="javascript:return SerachClear()"/>
                    </td>
                </tr>
            </table>
        </div>
    </div>
    <div class="cpanel">
        <div class="head">
            Results
        </div>
        <div class="body">
            <div id="grddata">
            </div>
            <center>
            <br />
            <table align="center">
            <tr>
            <td>
            <input type="button" id="btnprint" value="Print Certificates" style="display:none" onclick="javascript:print_cert(0)" />
            
            </td>
            <td>&nbsp;</td>
            <td>
             <input type="button" id="btnlabl" value="Print Labels" style="display:none" onclick="javascript:print_cert(1)" />
            
            </td>
            </tr>
            </table>
            </center>
        </div>
    </div>
     
    <div id="btn_popup" class="popup" style="display: none;">
        <iframe id="frm" width="100%" height="350px" frameborder="0"></iframe>
        <div id="rflds">
       <asp:UpdatePanel ID="UpdatePanel1" runat="server" >
        <ContentTemplate>
         
        <table style="width: 100%">
            <tr>
                <td align="right">
                    Renewal Status
                    <asp:HiddenField ID="hfdorderid" runat="server" Value="0" />
                    <asp:HiddenField ID="hfdrelid" runat="server" Value="0" />
                </td>
                <td align="left">
                    <asp:DropDownList ID="ddlrenewalstatus" runat="server">
                    </asp:DropDownList>
                </td>
                <td align="right">
                    Process Date
                </td>
                <td align="left">
                    <asp:TextBox ID="txtrenewaldate" runat="server" CssClass="date"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td align="right">
                    Comments
                </td>
                <td align="left" colspan="3">
                    <asp:TextBox ID="txtcomments" runat="server" Width="100%" Height="50px" TextMode="MultiLine"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td align="center" colspan="4">
                    <asp:Button ID="btnsubmit" runat="server" Text="Submit" OnClick="btnsubmit_Click"/>
                </td>
            </tr>
        </table>
         </ContentTemplate>
        </asp:UpdatePanel>
            </div>
    </div>
     <div id="myprofilepopup" class="popup" style="display:none">
        <iframe id="iframeprofile" width="100%" height="500px" frameborder="0"></iframe>
    </div>
</asp:Content>