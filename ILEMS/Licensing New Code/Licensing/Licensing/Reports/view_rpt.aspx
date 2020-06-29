<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Reports/reports.master" CodeBehind="view_rpt.aspx.cs" Inherits="Licensing.Reports.view_rpt" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cntmain" runat="server">
    <script src="rpt.js" type="text/javascript"></script>
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
            sa5.title = '';
            sa5.primarykeyval = fdbcols[0][0];
            sa5.cols = fdbcols;
            dataIn = '"query":"' + query + '"';
            sa5.data = dataIn;

            if ($('#<%=ddlrpt.ClientID%> option:selected').text() == "Cases By Status")
                sa5.title = "Case by Status Report - " + $('#pnl2').find('select option:selected').text();
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
        function afterbind() {
            $('#fltr').html('');
            document.getElementById('pnl2').style.display = 'block';
            document.getElementById('resultpanel').style.display = 'block';
            if (document.getElementById('ctl00_ctl00_cntbdy_cntmain_hfdfltrs').value != '') {
                bindfltrs();
            }
            else {
                grdbind();
            }
        }
        function HideDivandResultPanel()
        {
            document.getElementById('pnl2').style.display = 'none';
            document.getElementById('resultpanel').style.display = 'none';
            document.getElementById('lictype').style.marginTop = "75px";
        }
        function GetExcelDocumentLink(licensetypes,county) {

            window.open("../Prints/Excel_Emails.aspx?lictypes=" + licensetypes + "&county=" + county);
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
                        <asp:DropDownList ID="ddlrpt" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlrpt_change"></asp:DropDownList>
                        &nbsp; &nbsp;<asp:Label ID="lblcounty" runat="server" Text="County"></asp:Label> &nbsp; <asp:ListBox ID="ddl_county" runat="server" SelectionMode="Multiple" Height="100px" style="position:absolute"></asp:ListBox>
                       
                    </div>
                    <asp:HiddenField ID="hfdquery" runat="server" Value="" />
                    <asp:HiddenField ID="hfdfltrs" runat="server" Value="" />
                    <asp:HiddenField ID="hfdcols" runat="server" Value="" />
                   
                    <center>
                       <div id="lictype">
                            <asp:CheckBoxList ID="chklicensetypes" runat="server" RepeatDirection="Horizontal" RepeatColumns="4"></asp:CheckBoxList>
                       </div>
                      
                        <asp:Button ID="btngenerate" runat="server" Text="Generate" OnClick="btngenerate_Click" />
                    </center>

                </ContentTemplate>
            </asp:UpdatePanel>
            <br />
            <div id="pnl2" style="width: 100%">
                <div id="fltr" style="width: 100%"></div>




            </div>
        </div>
    </div>
    <div class="cpanel" id="resultpanel">
        <div class="head">Results</div>
        <div class="body">
            <div id="rptgrd">
            </div>
        </div>
    </div>

</asp:Content>
