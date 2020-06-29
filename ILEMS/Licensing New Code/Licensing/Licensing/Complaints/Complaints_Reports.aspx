<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Complaints/Complaints.Master" CodeBehind="Complaints_Reports.aspx.cs" Inherits="Licensing.Complaints.Complaints_Reports" %>

<asp:Content ID="content1" runat="server" ContentPlaceHolderID="cntmain">
    <script src="../Reports/rpt.js" type="text/javascript"></script>
    <script language="javascript">
        function dispcontrol(type1, tbquery) {
            var temp = null;

            if (type1 == "Text Box") {
                temp = document.createElement('input');
                temp.setAttribute("type", "text");

            }
            else
                if (type1 == "Date Time") {
                    temp = document.createElement('input');
                    temp.setAttribute("type", "text");
                    temp.setAttribute("class", "date1");
                }
                else
                    if (type1 == "Drop Down") {
                        temp = document.createElement('select');
                        var cls = tbquery.split(',');
                        var qur = "select distinct " + cls[1] + " [a]," + cls[2] + " [b] from " + cls[0];
                        bindropdown(temp, qur);

                    }
                    else
                        if (type1 == "Fixed Value") {
                            temp = document.createElement('input');
                            temp.setAttribute("type", "text");
                            temp.setAttribute("value", tbquery);
                            temp.setAttribute("disabled", "true");

                        }

            return temp;
        }
        function createfltcontrol(val) {
            var vallist = val.split('^');

            var tdiv = document.createElement('div');
            var thfd1 = document.createElement('input');
            thfd1.setAttribute("type", "hidden");
            thfd1.setAttribute("value", val);
            tdiv.innerHTML = vallist[0] + " :&nbsp;";
            tdiv.appendChild(thfd1);

            tdiv.appendChild(dispcontrol(vallist[3], vallist[5]));
            return tdiv;
        }
        function createbtn() {

            var ibtn = document.createElement("input");
            ibtn.setAttribute("type", "button");
            ibtn.setAttribute("value", "Generator");
            ibtn.setAttribute("onclick", "genraterpt()");
            ibtn.setAttribute("style", "display:block;margin-left:auto;margin-right:auto");
            return ibtn;
        }
        function bindfltrs() {
            $('#fltr').html('');
            $('#rptgrd').html('');
            var fltrs = document.getElementById('ctl00_ctl00_cntbdy_cntmain_hfdfltrs').value;
            var flist = fltrs.split('~')

            for (var i = 0; i < flist.length; i++) {
                if (flist[i] != "")

                    document.getElementById('fltr').appendChild(createfltcontrol(flist[i]));

            }
            document.getElementById('fltr').appendChild(createbtn());

            $(".date1").mask("99/99/9999");
            $(".date1").attr("placeholder", "MM/DD/YYYY");
            $(".date1").datepicker({
                changeMonth: true,
                changeYear: true
            });

        }
    </script>
    <script type="text/javascript">


        var dataIn = '';
        var sa5 = new sagrid();
        sa5.url = "../Reports/Report.svc/Runreportquery";


        sa5.bindid = "rptgrd";
        sa5.objname = "sa5";
        var qcond = '';
        function getfiltervals() {
            qcond = '';
            var cond = '';
            var opr = '';
            var chkval = '';
            var type = '';
            var fdivs = $('#fltr').find("div");
            for (var i = 0; i < fdivs.length; i++) {
                var hfd = $(fdivs[i]).find("input[type=hidden]")[0];
                var hcls = $(hfd).val().split('^');
                opr = hcls[4];
                type = hcls[3];
                if (type != 'Drop Down') {
                    chkval = $(fdivs[i]).find("input[type=text]")[0];
                    chkval = $(chkval).val();
                }
                else {
                    chkval = $(fdivs[i]).find("select")[0];
                    chkval = $(chkval).val();
                    if (chkval == '-1')
                        chkval = '';
                }
                if (opr == 'like' && chkval != '') {
                    chkval = chkval + '%';
                }
                if (chkval != '') {
                    cond = cond + hcls[1] + '.' + hcls[2] + ' ' + hcls[4] + " '" + chkval + "' and ";
                }

            }
            if (cond != '')
                cond = cond.substring(0, cond.length - 4);
            return cond;
        }
        function genraterpt() {
            qcond = getfiltervals();
            var dbcols = document.getElementById('ctl00_ctl00_cntbdy_cntmain_hfdcols').value;

            var query = document.getElementById('ctl00_ctl00_cntbdy_cntmain_hfdquery').value;
            if (qcond != '')
                query = query + ' where ' + qcond;
            var fcols = dbcols.split('^');
            var fdbcols = new Array();
            for (var i = 0; i < fcols.length; i++)
                fdbcols[i] = new dcol(fcols[i], fcols[i]);

            $('#rptgrd').html('');
            sa5.primarykeyval = fdbcols[0][0];
            sa5.cols = fdbcols;
          
            dataIn = '"query":"' + query + '"';
            sa5.data = dataIn;
            sa5.process();
        }
        function grdbind() {
            var dbcols = document.getElementById('ctl00_ctl00_cntbdy_cntmain_hfdcols').value;

            var query = document.getElementById('ctl00_ctl00_cntbdy_cntmain_hfdquery').value;
            var fcols = dbcols.split('^');
            var fdbcols = new Array();
            for (var i = 0; i < fcols.length; i++)
                fdbcols[i] = new dcol(fcols[i], fcols[i]);

            $('#rptgrd').html('');
            sa5.primarykeyval = fdbcols[0][0];
            sa5.cols = fdbcols;
            dataIn = '"query":"' + query + '"';
            sa5.data = dataIn;
            sa5.process();
        }


    </script>
    <style>
        #fltr {
            text-align: center;
        }

            #fltr div {
                display: inline-block;
                margin-left: auto;
                margin-right: auto;
                padding: 5px;
            }

        .indiv td {
            text-align: left;
        }

        .indiv .indiv {
            float: left;
        }

        .indiv {
            background: transparent; /* Old browsers */
            -webkit-box-shadow: 0 0 1px 0 #000000;
            box-shadow: 0 0 1px 0 #000000;
            -webkit-border-radius: 2px;
            border-radius: 2px;
            border: solid 1px black;
            margin: 5px;
            -webkit-box-shadow: 0 0 8px 0 #B0B0B0;
            box-shadow: 0 0 8px 0 #B0B0B0;
        }
    </style>
   <script language="javascript">
        var i = 0;
        function afterbind() {
            $('#fltr').html('');
            $('#pnl2').show();
            $('#complaints').hide();
            $('#uspdiv').hide();
            if (document.getElementById('ctl00_ctl00_cntbdy_cntmain_hfdfltrs').value != '') {
                bindfltrs();
            }
            else {
                grdbind();
            }
        }
        function ComplaintsDataBind() {
            i = 1;
            $('#complaints').show();
            $('#pnl2').hide();
            $('#uspdiv').hide();
        }
        function ComplaintsDataBind1() {
            i = 2;

            $('#complaints').show();
            $('#pnl2').hide();
            $('#uspdiv').hide();
        }
        <%--function ShowUSPDiv() {
            var lictype = document.getElementById('<%=ddl_lic_type.ClientID%>').value;
            if (lictype == "1" || lictype == "2" || lictype == "3"||lictype=="-1")
                $('#uspdiv').hide();
            else
                $('#uspdiv').show();
        }--%>
        var CmpData = new sagrid();
        function BindData(selids) {

            var CmpDataIn = ''; 

            if (i == 1)
                CmpData.url = "../Reports/Report.svc/GetComplaintDateReceived";
            else if (i == 2)
                CmpData.url = "../Reports/Report.svc/GetComplaintDateReceived1";
            CmpData.primarykeyval = "Complaint_ID";
            CmpData.bindid = "rptgrd";
            CmpData.objname = "CmpData";
            var sdt = document.getElementById('<%= txt_fromdate.ClientID %>').value;
            CmpDataIn = CmpDataIn + '"sdt":"' + sdt + '",'
            var edt = document.getElementById('<%= txt_todate.ClientID %>').value;
            CmpDataIn = CmpDataIn + '"edt":"' + edt + '",'
          
            CmpDataIn = CmpDataIn + '"lictype":"' + selids + '",'
            var usp797 = document.getElementById('<%= chkusp797.ClientID %>').checked;
            if (usp797 == true)
                usp797 = "1";
            else
                usp797 = "";
            CmpDataIn = CmpDataIn + '"usp797":"' + usp797 + '",'
            var usp795 = document.getElementById('<%= chkusp795.ClientID %>').checked;
            if (usp795 == true)
                usp795 = "1";
            else
                usp795 = "";
            CmpDataIn = CmpDataIn + '"usp795":"' + usp795 + '"';
            CmpData.cols = [new dcol("Comp Number", "Complaint_Number"), new dcol("Respondent", "Respondent"), new dcol("Date Rcvd", "DateReceived"), new dcol("Comp Source", "ComplaintSource"), new dcol("Comp Category", "ComplaintCategory"), new dcol("Comp Resolution", "Resolutions"), new dcol("Resolution Date", "ResolutionDate"), new dcol("Compl Name", "ComplainantName"), new dcol("Compl Address", "ComplainantAddress"), new dcol("CSZ", "CSZ"), new dcol("Phone#", "ComplainantPhoneNumber"), new dcol("Email", "ComplainantEmail")];
           
            CmpData.data = CmpDataIn;
            
            CmpData.process();
            return false;
        }
    </script>


    <div class="cpanel">
        <div class="head">
            Snapshot Reports
        </div>
        <div class="body">
            <asp:UpdatePanel ID="upd5" runat="server">
                <ContentTemplate>
                    <div align="center">
                        Select Report
                        <asp:DropDownList ID="ddlrpt" runat="server" Width="500px" AutoPostBack="true" OnSelectedIndexChanged="ddlrpt_change"></asp:DropDownList>
                    </div>
                    <asp:HiddenField ID="hfdquery" runat="server" Value="" />
                    <asp:HiddenField ID="hfdfltrs" runat="server" Value="" />
                    <asp:HiddenField ID="hfdcols" runat="server" Value="" />
                    <br />
                      <div id="complaints">
                          <center>
                     <table style="width:75%" class="spac">
                         <tr>
                             <td align="right">
                                 From Date :
                             </td>
                             <td align="left">
                                 <asp:TextBox ID="txt_fromdate" runat="server" CssClass="date"></asp:TextBox>
                             </td>
                             <td align="right">
                                 To Date :
                             </td>
                             <td align="left">
                                 <asp:TextBox ID="txt_todate" runat="server" CssClass="date"></asp:TextBox>
                             </td>
                         </tr>
                         <tr>
                             
                             <td align="left" colspan="4">
                                 <asp:CheckBoxList ID="chk_lictypes" runat="server" RepeatDirection="Horizontal" RepeatColumns="4"></asp:CheckBoxList>
                              </td>
                         </tr>
                         <tr>
                             <td align="center" colspan="2">
                                 <asp:CheckBox ID="chkusp795" runat="server" Text="Non-Sterile Compounding" />
                             </td>
                             <td align="center" colspan="2">
                                 <asp:CheckBox ID="chkusp797" runat="server" Text="Sterile Compounding" />
                             </td>
                         </tr>
                         <tr>
                             <td colspan="6" align="center"><br />
                                 <asp:Button ID="btngenerate" runat="server" Text="Generate" OnClick="btngenerate_Click1" />
                             </td>
                         </tr>
                     </table>
                   
                        
                    </center>
                      </div>

                </ContentTemplate>
            </asp:UpdatePanel>
            <br />
            <div id="pnl2" style="width: 100%">
                <div id="fltr" style="width: 100%"></div>




            </div>
        </div>
    </div>
    <div class="cpanel">
        <div class="head">Results</div>
        <div class="body">
            <div id="rptgrd">
            </div>
        </div>
    </div>
</asp:Content>
