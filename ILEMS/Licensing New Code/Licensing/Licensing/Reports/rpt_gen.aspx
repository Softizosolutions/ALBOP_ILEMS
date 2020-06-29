<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Reports/reports.master" CodeBehind="rpt_gen.aspx.cs" Inherits="Licensing.Reports.rpt_gen" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cntmain" runat="server">
  
    <script src="rpt.js" type="text/javascript"></script>
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
            tdiv.innerHTML = vallist[0]+" :&nbsp;";
            tdiv.appendChild(thfd1);
          
            tdiv.appendChild(dispcontrol(vallist[3], vallist[5]));
            return tdiv;
        }
        function createbtn() {
            var ibtn = document.createElement("input");
            ibtn.setAttribute("type", "button");
            ibtn.setAttribute("value", "Genarate");
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
            if(flist[i]!="")
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
        function showprv() {

        }

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
            return  cond;
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
           var dbcols= document.getElementById('ctl00_ctl00_cntbdy_cntmain_hfdcols').value;
            
           var query= document.getElementById('ctl00_ctl00_cntbdy_cntmain_hfdquery').value;
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
        function urlchng(ctl, pid) {
            
            if (pid == 'pnl2') {

                $('#pnl2').dialog({ title: "Report Generator Preview", width: "95%" });
                $('#pnl2').dialog('open'); 
                createquery();
                

            }
            else
                $('#pnl2').dialog('close');

        }

      </script>
      <script>

          var sa6 = new sagrid();
          sa6.url = "../Reports/Report.svc/Getallrpts";

          sa6.primarykeyval = "rptid";
          sa6.bindid = "grdprints";
          sa6.cols = [new dcol("Report Name", "rptname"), new dcol("Delete", "", "", "1", "1", "Delete_lkp", "fa fa-trash-o grdicon")];
          sa6.objname = "sa6";

          function showprnts() {
              var dataIn = '';  
              sa6.data = dataIn;

              sa6.process();
              $('#grdprints').dialog({ title: 'Existing Reports', width: '60%' });
              $('#grdprints').dialog('open');
          }
          function afterdel() {
               altbox("Record Deleted.");
              sa6.process();
          }
          function cnffnres(result) {
              if (result == 'true')
                  __doPostBack('<%= btndel.UniqueID %>', "");
       }
          function Delete_lkp(sender, keyval) {
              document.getElementById('<%= hfdsel.ClientID %>').value = keyval;
               cnfbox(" Are you sure do you want to delete this record?", "cnffnres");
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
     <div id="grdprints" class="popup"></div>
     <div class="cpanel">
     <div class="head">
      Report Generator <a onclick="showprnts()"> <i class="fa fa-pencil-square-o   grdicon1" ></i> Show Reports  </a>  
     </div>
     <div class="body">
     
    <div id="pnl1">
    
    <asp:UpdatePanel ID="updedt" runat="server">
    <ContentTemplate>
    <asp:HiddenField ID="hfdsel" runat="server" Value="0" />
     <asp:Button ID="btndel" runat="server" Text="Delete" style="display:none"  OnClick="btndel_click" />
 
    </ContentTemplate>
    </asp:UpdatePanel>
    <div  style="width:100%;height:200px;overflow:auto;">
    <table width="100%" cellpadding="0" cellspacing="0">
    <tr>
    <td valign="top" >
    <div >
    <asp:UpdatePanel ID="upd" runat="server" >
    <ContentTemplate>
    <div id="dbsettings" style="width:200px"  > 
    <asp:DataList ID="dtlst"  class="gridmain1" runat="server" Width="100%" >
    <HeaderStyle CssClass="grdheadbg" />
    <HeaderTemplate>
    Tables
    </HeaderTemplate>
    <ItemTemplate>
    
    <asp:CheckBox ID="chb"  runat="server" ToolTip='<%# Eval("TABLE_NAME").ToString() %>' Text='<%# shorttxt(Eval("TABLE_NAME").ToString()) %>' AutoPostBack="true" OnCheckedChanged="chb_chnage" />
    
    </ItemTemplate>
    
    <ItemStyle  HorizontalAlign="Left"  />
    <AlternatingItemStyle HorizontalAlign="Left"   />
    </asp:DataList>
     
    
     
    
    <asp:DataList ID="dtlst1" runat="server" CssClass="gridmain1" Width="100%" >
    <HeaderStyle CssClass="grdheadbg" />
    <HeaderTemplate>
    Select Table
    </HeaderTemplate>
    <ItemTemplate>
    
    <asp:CheckBox ID="chb" runat="server" ToolTip='<%# Eval("view_name").ToString() %>' Text='<%# shorttxt(Eval("view_name").ToString()) %>' AutoPostBack="true" OnCheckedChanged="chb_chnage"/>
    
    </ItemTemplate>
      <ItemStyle  HorizontalAlign="Left"  />
    <AlternatingItemStyle HorizontalAlign="Left"   />
    </asp:DataList>
     </div>
    </ContentTemplate>
    </asp:UpdatePanel>
    </div>
    </td>
    <td id="designer" valign="top" width="100%" class="indiv" >
   
     
    
    
    </td>
    </tr>
    </table>
    <br style="clear: left;" />
    </div>
   </div>
     </div>
     <div class="indiv">
    <center>
  
   <table class="spac" width="100%">
    <tr>
    <td>
     <asp:UpdatePanel ID="upd1" runat="server">
   <ContentTemplate>
  <b> Select Main Table :</b> <asp:DropDownList ID="ddlmtables" runat="server"   Width="250px" ></asp:DropDownList>
   </ContentTemplate>
   </asp:UpdatePanel>
    </td>
    <td> 
    Report Name : <asp:TextBox ID="txtrpt" runat="server" ></asp:TextBox>&nbsp;&nbsp;&nbsp;
   <asp:Button ID="btnsave" runat="server" Text="Save" OnClientClick="javascript:return saverpt()" OnClick="btnrpt_save"  />
   <asp:Button ID="btnclear" runat="server" Text="Clear" OnClientClick="javascript:return clearall()" style="display:none" />
   <asp:HiddenField ID="hfdrptid" runat="server" Value="0" />
   
   </td>
  
   <td>
     <a onclick="javascript:urlchng(this,'pnl2')" style="cursor:pointer">Click Here To Show Preview</a> 
    
   </td>
    </tr>
    </table>
   </center>
   </div>
   <div class="cpanel">
   <div class="head">Selected Columns 
   </div>
   <div class="body">
     
    <div id="selcols" style="display:block;margin:5px;overflow:auto">
    <table  border="1" class="gridmain1" align="center"    cellpadding="0px" cellspacing="0px" width="100%">
    <thead>
    <tr class="grdheadbg" >
    <th>
    Table Name
    </th>
    <th>
    Column Name
    </th>
    <th>
    Column Type
    </th>
    <th width="50px">
    show
    </th>
    <th>
    Display Name
    </th>
    
   
   
    </tr>
    </thead>
  <tbody id="tblselcols">
   
    
     
  </tbody>
    </table>
    </div>
     </div>
   </div>
   
  <div class="cpanel">
   <div class="head"> Add Relations
    
    <a onclick="javascript:return addtables2relation()">Add Relation</a>
   
   
   </div>
   <div class="body">
    <div id="divrelation" style="display:block;margin:5px;overflow:auto">

    <table  border="1" class="gridmain1" align="center"    cellpadding="0px" cellspacing="0px" width="100%">
    <thead>
    <tr class="grdheadbg" >
    <th >
    Table Name
    </th>
    <th >
   Relation Type
    </th>
    <th>
    Relation
    </th>
    <th >
    &nbsp;
    </th>
    
    </tr>
    </thead>
  <tbody id="tbodyrelation">
   
    
     
  </tbody>
    </table>
    </div>
     </div>
   </div>
   <div class="cpanel">
   <div class="head">Add Filters  <a onclick="javascript:return addtables2filters()">Add Filters</a>
   
   </div>
   <div class="body"> 
    
    <div id="div1" style="display:block;margin:5px;overflow:auto">
    <table  border="1" class="gridmain1" align="center"    cellpadding="0px" cellspacing="0px" width="100%">
    <thead>
    <tr class="grdheadbg" >
    <th   >
    Display
    </th>
    <th  >
    Table Name
    </th>
    <th  >
   Column Name
    </th>
    <th  >
    Filter Type
    </th>
    <th  >
    Condition
    </th>
     <th  >
    &nbsp;
    </th>
    </tr>
    </thead>
  <tbody id="tbfilters">
   
    
     
  </tbody>
    </table>
    </div>
    </div>
   </div>
    
   
     
   </div>
   
   <asp:HiddenField ID="hfdquery" runat="server" Value="" />
   <asp:HiddenField ID="hfdfltrs" runat="server" Value="" />
    <asp:HiddenField ID="hfdcols" runat="server" Value="" />
   
   <div id="pnl2"  class="popup" style="width:100%">
    <div id="fltr" style="width:100%"></div>
       <div id="rptgrd"   >
 
 </div>
   
   
   </div>
     <div class="popup" id="retpop">
            <table width="95%" align="center" cellpadding="2" cellspacing="2">
            <tr>
            <td align="right">Select Relation Table :</td><td align="left">
            <select id='retselect' onchange="relationtbchange()" width="250px"></select>
            <asp:CheckBox ID="chbretreq" Text="Allow Nulls" runat="server" />
            <asp:Button ID="btnaddnewroe" runat="server" Text="New Rule" OnClientClick="javascript:return addsubretrow();" />
            </td>
            </tr>
            <tr >
            <td colspan='2'>
            <table width="100%" cellpadding="0" cellspacing="0" class="gridmain1">
            <tr class="grdheadbg">
            <th>
            Column Name
            </th>
            <th>
            Condition
            </th>
            <th>
            Sorce Table
            </th>
            <th>
            Source Column
            </th>
            <th width="50px">
            &nbsp;
            </th>
            </tr>
            <tbody id="tblretsub">
            
            </tbody>
            </table>
            </td>
            </tr>
            <tr>
            <td colspan='2' align="center">
            <input type="button" value="Save" onclick="javascript:saverelation_main();" />
 
            </td>
            </tr>
            </table>
            <br />
        </div>
    
   
     <div class="popup" id="fltpop">
           <div style="text-align:center">
           Display Name : <input type="text" id="txtdisp" />
           </div>
            <table width="98%" align="center" cellpadding="0" cellspacing="0" class="gridmain1">
            <tr class="grdheadbg">
            <th>
            Table Name
            </th>
            <th>
            Column Name
            </th>
            <th>
            Filter Type
            </th>
            <th>
            Condition
            </th>
           
            </tr>
            <tbody id="trfltadd">
            <tr>
            <td>
            <select id="ddlflttabls" onchange="addcolumnsfilters()"></select>
            </td>
            <td>
            <select id="ddlfltcolumns"></select>
            </td>
            <td>
            <select id="flttype" onchange="flttypechng(this)">
            
            <option >Text Box</option>
            <option >Date Time</option>
            <option >Drop Down</option>
            <option >Fixed Value</option>
            </select>
            </td>
            <td>
            <select id="fltcnd">
            <option>like</option>
            <option>=</option>
            <option>!=</option>
            <option><</option>
            <option><=</option>
            <option>></option>
            <option>>=</option>
            </select>
            </td>
            </tr>
            </tbody>
            </table>
            <table align="center" id="flttxt" style="display:none">
            <tr>
            <td>Fixed Value :</td>
            <td>    <input type="text" id="flttxt_val"   /></td>
            </tr>
            </table>
        
            <table id="fltdrptb" style="display:none" width="800px" align="center" cellpadding="0" cellspacing="0" class="gridmain1">
            <tr class="grdheadbg">
            <th width="200px">
            Table Name
            </th>
            <th width="200px">
            Display Column
            </th>
            <th width="200px">
            Value Column
            </th> 
            </tr>
            <tbody id="Tbody1">
            <tr>
            <td>
            <select id="ddlfldrptbls" onchange="addcolumnsfilters2()"></select>
            </td>
            <td>
            <select id="ddlfldrpcls1"></select>
            </td>
            <td>
            <select id="ddlfldrpcls2">
            
            </select>
            </td>
            
            </tr>
            </tbody>
            </table>
            <br />
            <center>
            <input type="button" value="Add Filter" onclick="javascript:return addfltr2table()" />
             </center>
            <br />
        </div>
    
    
   
    
</asp:Content>