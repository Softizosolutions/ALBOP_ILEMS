<%@ Page Language="C#" MasterPageFile="~/PersonLicensing/Person.Master" AutoEventWireup="true" CodeBehind="Licensing_Reports.aspx.cs" Inherits="Licensing.PersonLicensing.Licensing_Reports" %>

<asp:Content ID="content1" runat="server" ContentPlaceHolderID="cntmain">
     <script src="../Reports/rpt.js" type="text/javascript"></script>
    <script language="javascript" >
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
             if ($('#' + '<%= ddlrpt.ClientID %>').val() == "54") {
                sa5.aftercall = "setpop";
            }
            else
                sa5.aftercall = "";
            $('#rptgrd').html('');
            sa5.primarykeyval = fdbcols[0][0];
            sa5.cols = fdbcols;
            dataIn = '"query":"' + query + '"';
            sa5.data = dataIn;
            sa5.process();
        }
        function setpop() {
            $.each(sa5.resultdata, function (i, o) {
                $('#rptgrd tbody').find('tr:eq(' + i + ')').find('td:eq(0)').html('<a style="cursor:pointer" onclick="openpop( ' + i + ')" >' + o["Name"] + '</a>');
            });
        }
        function processsave() {
            var psdata = {};
            psdata["renid"] = $('#popcmnt').find('[type="hidden"]').val();
            psdata["proc"] = $('#ddlproc').val();
            psdata["cmnt"] = $('#txtcmnt').val();
            $.ajax({
                url: "../WCFGrid/GridService.svc/processduplicaterequest",
                type: "POST",
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify(psdata),
                dataType: "json",
                success: function (data) {

                    altbox("Information Saved.");
                    $('#popcmnt').dialog('close');
                    sa5.process();
                },
                failure: function (error) {
                    altbox("Information Not Saved.");
                    $('#savebtn').show();
                },
                error: function (error) {
                    altbox("Information Not Saved.");
                    $('#savebtn').show();
                }
            });
        }
        function openpop(selid) {
            var so = sa5.resultdata[selid];

            $('#popcmnt').find('[type="text"]').val('');
            $('#popcmnt').find('[type="hidden"]').val(so["auid"]);
            $('#popcmnt').find('select').val('-1');
            $('#popcmnt').find('textarea').val('');
            $('#popcmnt').dialog({ title: "Process Duplicate Request", width: "60%" });

            $('#txtlicno').val(so["License#"]);
            if (so["Processed"] == '')
                so["Processed"] = '-1';
            $('#ddlproc').val(so["Processed"]);
            $('#txtcmnt').val(so["Comments"]);
            $('#popcmnt').dialog('open');

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
        #fltr
        {
            text-align:center;
        }
        #fltr div
        {
            display:inline-block;
            margin-left:auto;
            margin-right:auto;
            padding:5px;
        }
        
        .indiv td
        {
            text-align:left;
            }
             .indiv  .indiv
             {
                 float:left; 
             }
    .indiv
    {
     background: transparent; /* Old browsers */
	 
      	-webkit-box-shadow: 0 0 1px 0 #000000;
	box-shadow: 0 0 1px 0 #000000;
	-webkit-border-radius: 2px;
	border-radius: 2px;
	border: solid 1px black; 
	 
	
	 margin:5px;
	 -webkit-box-shadow: 0 0 8px 0 #B0B0B0;
	box-shadow: 0 0 8px 0 #B0B0B0;
	 
    }
    </style>
<script language="javascript">
    function afterbind() {
        $('#fltr').html('');
        if (document.getElementById('ctl00_ctl00_cntbdy_cntmain_hfdfltrs').value != '') {
            bindfltrs();
        }
        else {
            grdbind();
        }
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
   Select Report <asp:DropDownList ID="ddlrpt" runat="server" Width="500px" AutoPostBack="true" OnSelectedIndexChanged="ddlrpt_change"></asp:DropDownList>
   </div>
   <asp:HiddenField ID="hfdquery" runat="server" Value="" />
    <asp:HiddenField ID="hfdfltrs" runat="server" Value="" />
   <asp:HiddenField ID="hfdcols" runat="server" Value="" />
   
   
    
   </ContentTemplate>
   </asp:UpdatePanel>
       <br />
     <div id="pnl2"   style="width:100%">
    <div id="fltr" style="width:100%"></div>
       
 
   
   
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
    <div id="popcmnt" class="popup">
        <table width="100%">
            <tr>
                <td align="right">License # : </td><td align="left"><input type="text" disabled id="txtlicno" bdata="License#" />
                    <input type="hidden" id="hfdauid" />

                                                   </td>
                <td align="right">Processed : </td><td align="left"><select id="ddlproc" bdata="Processed">
                      <option value="-1">Select</option>
                    <option value="Yes">Yes</option>
                    <option value="No">No</option>
                                                                    </select> </td>
                
            </tr>
            <tr>
                <td  align="right">
                    Comments :
                </td>
            </tr>
             <tr>
                
                <td   width="100%" colspan="4">
                    <textarea id="txtcmnt" style="width:90%;margin:0px auto;height:80px" rows="10" bdata="Comments"></textarea>
                </td>
            </tr>
            <tr>
                <td colspan="4" align="center">
                    <input type="button" value="Save" onclick="processsave()" />
                </td>
            </tr>
        </table>
    </div>
</asp:Content>