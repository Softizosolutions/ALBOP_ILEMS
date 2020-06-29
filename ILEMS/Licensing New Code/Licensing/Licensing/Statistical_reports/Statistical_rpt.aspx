<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Reports/reports.master" CodeBehind="Statistical_rpt.aspx.cs" Inherits="Licensing.Statistical_reports.Statistical_rpt" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cntmain" runat="server">


  <%--  <script src="chartinator.js" type="text/javascript"></script>--%>
     <script type="text/javascript" src="locader.js"></script>
   

    <style>
        .rhead
        {
            text-align:center;
            font-size:15pt;
            font-weight:bold;
            padding:10px;
            margin-top:-40px;
            margin-bottom:10px;
            
        }
       .legtt
       {
           display:inline-block;
       }
        .crl {
  height: 25px;
  width: 25px;
  
  border-radius: 50%;
  display: inline-block;
}
        tfoot i {
            padding: 5px;
        }

        tfoot select {
            display: none;
        }

        tfoot span {
            display: none;
        }
        .gridmain1 th
            {
                font-weight:bold;
                border:1px solid #000 !important;
            }
            .gridmain1 td{
                 border:1px solid #000 !important;
            }
        @media print
        {
            .gridmain1 {
                border:0px;
                border-radius:0px;
            }
            .rpthead{
                display:none;
            }
            .head
            {
                display:none;
            }
            footer
            {
                display:none;
            }
            .body
            {
border:0px !important;
padding:0px !important;

            }
        }
    </style>

    <script>
        var dataIn = '';
        var sa5 = new sagrid();
        sa5.ispaging = false;
        sa5.isfilters = false;
        sa5.aftercall = 'bindpiechart';
        sa5.bindid = "grd_div";
        sa5.objname = "sa5";
        sa5.pagesize = 1000;
        function setargument() {
            var selval = document.getElementById('<%= ddlrpt.ClientID %>').value;
            if (selval == "1") {
                sa5.primarykeyval = "Category";
                sa5.cols = [new dcol("Category", "Category"), new dcol("Files", "Files")];
                sa5.url = "../Reports/Report.svc/GetComplaintbycategory";
            }
            else
                if (selval == "2") {
                    sa5.primarykeyval = "category";
                    sa5.cols = [new dcol("Category", "category"), new dcol("Avg", "no_")];
                    sa5.url = "../Reports/Report.svc/GetResolveDays";
                }
                else
                    if (selval == "3") {
                        sa5.primarykeyval = "Fee_type";
                        sa5.cols = [new dcol("Fee Type", "Fee_type"), new dcol("Amount", "Amount")];
                        sa5.url = "../Reports/Report.svc/Getfeetypecount";
                    }
                    else
                        if (selval == "4") {
                            sa5.primarykeyval = "License_Type";
                            sa5.cols = [new dcol("License Type", "License_Type"), new dcol("Count", "no_")];
                            sa5.url = "../Reports/Report.svc/GetApplications";
                        }
                        else
                            if (selval == "5") {
                                sa5.primarykeyval = "License_Type";
                                sa5.cols = [new dcol("License Type", "License_Type"), new dcol("Count", "noflic")];
                                sa5.url = "../Reports/Report.svc/GetLicenseCount";
                            }
                            else
                                if (selval == "6") {
                                    sa5.primarykeyval = "Board_Action";
                                    sa5.cols = [new dcol("Board Action", "Board_Action"), new dcol("Count", "No_")];
                                    sa5.url = "../Reports/Report.svc/GetBoardAction";
                                }
                                else
                                    if (selval == "7") {
                                        sa5.primarykeyval = "Board_Action";
                                        sa5.cols = [new dcol("Board Action", "Board_Action"), new dcol("Count", "No_")];
                                        sa5.url = "../Reports/Report.svc/GetResolution";
                                    }

        }
        function ddl_change() {
            if (document.getElementById('<%= ddlrpt.ClientID %>').value != "-1")
                setargument();
            else {
                altbox("Please select report type.");
                return false;
            }
            if (document.getElementById('<%= txtstartdate.ClientID %>').value != '') {
                dataIn = '"sdt":"' + document.getElementById('<%= txtstartdate.ClientID %>').value + '","edt":"';
                if (document.getElementById('<%= txtenddate.ClientID %>').value == "")
                    dataIn = dataIn + document.getElementById('<%= txtstartdate.ClientID %>').value + '"';
                 else
                     dataIn = dataIn + document.getElementById('<%= txtenddate.ClientID %>').value + '"';

                 sa5.data = dataIn;
                 sa5.process();
             }
             else {
                 altbox("Please enter start date.");
             }
             return false;
         }
         function cprint() {
             var css = '';
             if (sa5.resultdata.length > 8) {
                 css = '@page { size: potrait; }',
          head = document.head || document.getElementsByTagName('head')[0],
         style = document.createElement('style');
                 // $('#grd_div_tbl').next().attr("style", "height:650px !important");
             }
             else
                 if (sa5.resultdata.length < 5) {
                     css = '@page { size: potrait; }',
              head = document.head || document.getElementsByTagName('head')[0],
             style = document.createElement('style');
                     //  $('#grd_div_tbl').next().attr("style", "margin-top:-50px !important");
                 }
                 else {
                     css = '@page { size: potrait; }',
              head = document.head || document.getElementsByTagName('head')[0],
             style = document.createElement('style');
                     // $('#grd_div_tbl').next().attr("style", "height:900px !important");
                 }
             style.type = 'text/css';
             style.media = 'print';

             if (style.styleSheet) {
                 style.styleSheet.cssText = css;
             } else {
                 style.appendChild(document.createTextNode(css));
             }

             head.appendChild(style);

             window.print();
             head.removeChild(style);

         }
    </script>

    <script type="text/javascript">
        google.charts.load("current", { packages: ["corechart"] });
        var chart = null;
        function drawChart(data) {
            
            var options = {
                
                is3D: true,
                sliceVisibilityThreshold: 0,
                chartArea: {
                    width: "600px", height: "80%" 
                },
                fontSize: 'body',
                backgroundColor: 'transparent',
                fontName: 'calibri',

                // Chart Title - String
                // Default: Table caption.
                //title: 'Pie Chart',
                     
                titleTextStyle: {

                    // The font size in pixels - Number
                    // Or use css selectors as keywords to assign font sizes from the page
                    // For example: 'body'
                    // Default: false - Use Google Charts defaults
                    fontSize: '11'
                },
                legend: {

                    // Legend position - String
                    // Options: bottom, top, left, right, in, none.
                    // Default: right
                    position: 'none',
                    alignment: 'left',
                    ///height:'400px',
                    textStyle: { fontSize: 18 },
                    maxLines: '45'
                }
            };

              chart = new google.visualization.PieChart(document.getElementById('piechart_3d'));
              google.visualization.events.addListener(chart, 'ready', function () {
                  var gdata = chart.ga.F;
                  $('.legends').html('');
                  $.each(gdata, function (i, d) {
                      $('.legends').append('<div class="legtt"><svg height="30" width="30"> <circle cx="15" cy="15" r="6" stroke="none" stroke-width="0" fill="' +d["color"]["color"]+'" /></svg> <div style="margin-left: 30px;display: block; margin-top: -25px;"> '+d["title"]+' ('+d["Te"]+')</div></div>');
                  });
              });

            chart.draw(data, options);
            
        }

        function bindpiechart(tbid) {

            var data = new google.visualization.DataTable();
            data.addColumn('string', $('#' + tbid + '_tbl thead').find('th:eq(0)').text());
            data.addColumn('number', $('#' + tbid + '_tbl thead').find('th:eq(1)').text());
            
            var rows = [];
            
            tot = 0;
            $('#' + tbid + '_tbl tbody').find('tr').each(function () {
                var rd = [];
                rd.push($(this).find('td:eq(0)').text());
                rd.push(parseInt($(this).find('td:eq(1)').text()));
                if ($(this).find('td:eq(1)').text()!=''  )
                rows.push(rd);
                tot += Number($(this).find('td:eq(1)').text().trim());
            });
            data.addRows(rows);
            $('#' + tbid + '_tbl').append("<tfoot><tr><td><b>Total</b></td><td><b>" + tot + "</b></td></tr></tfoot>");
            $('.rhead').text($('#ctl00_ctl00_cntbdy_cntmain_ddlrpt').find(':selected').text() + ' ' + $('#ctl00_ctl00_cntbdy_cntmain_txtstartdate').val() + ' to ' + $('#ctl00_ctl00_cntbdy_cntmain_txtenddate').val());

            
            drawChart(data);
        }



        function bindpiechartold(tbid) {

            var chart2 = $('#' + tbid + '_tbl').chartinator({
               
                createTable: false,

                // The data title
                // A title used to identify the set of data
                // Used as a caption when generating an HTML table
                dataTitle: 'Pie Chart Data',

                // The chart type - String
                // Derived from the Google Charts visualization class name
                // Default: 'BarChart'
                // Use TitleCase names. eg. BarChart, PieChart, ColumnChart, Calendar, GeoChart, Table.
                // See Google Charts Gallery for a complete list of Chart types

                chartType: 'PieChart',

                // The class to apply to the chart container element
                chartClass: 'col',

                // The class to apply to the table element
                // tableClass: 'col-table',

                // The chart aspect ratio custom option - width/height
                // Used to calculate the chart dimensions relative to the width or height
                // this is overridden if the Google Chart's height and width options have values
                // Suggested value: 1.25
                // Default: false - not used
                //chartAspectRatio: 1.25,

                // Google Pie Chart Options
                pieChart: {

                    // Width of chart in pixels - Number
                    // Default: automatic (unspecified)
                     width:800,

                    // Height of chart in pixels - Number
                    // Default: automatic (unspecified)
                    height: 600,

                    chartArea: {
                        width: "60%", height: "70%",top:"40%"
                    },

                    // The font size in pixels - Number
                    // Or use css selectors as keywords to assign font sizes from the page
                    // For example: 'body'
                    // Default: false - Use Google Charts defaults
                    fontSize: 'body',
                    backgroundColor: 'transparent',

                    // Font-family name - String
                    // Default: 'Arial'
                    fontName: 'calibri',

                    // Chart Title - String
                    // Default: Table caption.
                    //title: 'Pie Chart',
                     
                    titleTextStyle: {

                        // The font size in pixels - Number
                        // Or use css selectors as keywords to assign font sizes from the page
                        // For example: 'body'
                        // Default: false - Use Google Charts defaults
                        fontSize: '11'
                    },
                    legend: {

                        // Legend position - String
                        // Options: bottom, top, left, right, in, none.
                        // Default: right
                        position: 'top',
                        alignment: 'left',
                        ///height:'400px',
                        textStyle: { fontSize:18},
                        maxLines: '25',
                        labels: {
                            "maxWidth": 150,
                            "truncate": false,
                            wrap:true
                        }
                    },

                    // Array of colours
                    //  colors: ['#94ac27', '#3691ff', '#e248b3', '#f58327', '#bf5cff'],

                    // Make chart 3D - Boolean
                    // Default: false.
                    is3D: true,

                    tooltip: {

                        // Shows tooltip with values on hover - String
                        // Options: focus, none.
                        // Default: focus
                        trigger: 'focus'
                    }
                },
                // Show table as well as chart - String
                // Options: 'show', 'hide', 'remove'
                showTable: 'show'
            });
             
             
               
             
             tot = 0;
            $('#' + tbid + '_tbl tbody').find('tr').each(function () {
                tot += Number($(this).find('td:eq(1)').text().trim()); 
            });
            $('#' + tbid + '_tbl').append("<tfoot><tr><td><b>Total</b></td><td><b>" + tot + "</b></td></tr></tfoot>");
             


        }




    </script>

    <style>
        .col {
            /*float:right;*/
              
            width: 100%;
            text-align: center;
            vertical-align:top;
        }

         
    </style>

    <div class="cpanel rpthead">
        <div class="head">
            Statistical Reports
        </div>
        <div class="body">
            <center>
                <table style="width: 60%;" align="center" class="spac">
                    <tr>
                        <td colspan="4" align="center">Select Report Type 
   <asp:DropDownList ID="ddlrpt" runat="server" Width="60%">
       <asp:ListItem Value="-1">Select</asp:ListItem>
       <asp:ListItem Value="1">Complaints Count By  Complaint Category </asp:ListItem>
       <asp:ListItem Value="2">Days Take To Resolve Complaints By Complaint Category </asp:ListItem>
       <asp:ListItem Value="3">Fee/Amount Collected By Each Fee Type</asp:ListItem>
       <asp:ListItem Value="4">Application Count By License Type </asp:ListItem>
       <asp:ListItem Value="5">License Issued By License Type  </asp:ListItem>
       <asp:ListItem Value="6">Complaint Board Action Statistic </asp:ListItem>
       <asp:ListItem Value="7">Complaint Resolution Statistic  </asp:ListItem>
   </asp:DropDownList>

                        </td>
                    </tr>
                    <tr>
                        <td align="right">Start Date
                        </td>
                        <td align="left">
                            <asp:TextBox ID="txtstartdate" runat="server" CssClass="date"></asp:TextBox>
                        </td>
                        <td align="right">End Date
                        </td>
                        <td align="left">
                            <asp:TextBox ID="txtenddate" runat="server" CssClass="date"></asp:TextBox>
                        </td>
                        <td align="left">
                            <asp:Button ID="btnsubmit" runat="server" Text="Submit" OnClientClick="javascript:return ddl_change()" />
                        </td>
                    </tr>
                </table>
            </center>

        </div>
    </div>
    <div class="cpanel">
        <div class="head">
            Results
       <i class="fa fa-1x fa-print pull-right" style="margin-right: 10px; cursor: pointer; font-size: 13pt" onclick="cprint();"></i>

        </div>
        <div class="body">
           <div class="rhead">

           </div>
            <div style="display:table-cell;width:400px">
                
 <div id="piechart_3d" style="width: 400px; height: 300px;"></div>
                 <div class="legends">

            </div>
            </div>
            <div id="grd_div" style="display:table-cell;width:100%;vertical-align:top"></div>
         
        </div>
    </div>

</asp:Content>
