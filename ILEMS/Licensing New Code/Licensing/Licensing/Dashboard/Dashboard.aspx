<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Master Page/Main.Master" CodeBehind="Dashboard.aspx.cs" Inherits="Licensing.Dashboard.Dashboard" %>

<asp:Content ID="cnr" ContentPlaceHolderID="cntheader" runat="server">
    <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-tachometer"></i>Dashboard</a></li>
        <li id="cur" class="active">Dashboard</li>
    </ol>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cntbdy" runat="server">
    <script src="../Statistical_reports/chartinator.js" type="text/javascript"></script>
    <style>
        fieldset div {
            margin-bottom: 10px;
        }

        .linefld fieldset {
            float: left;
    width: 33%;
    margin: 2px;
    padding-top: 0px !important;
    border-radius: 3px !important;
        }
    </style>


    <script>

        var dataIn = '';
        var cmpbycat = new sagrid();
        cmpbycat.url = "../Reports/Report.svc/GetComplaintsbycategory";
        cmpbycat.ispaging = false;
        cmpbycat.isfilters = false;
        cmpbycat.primarykeyval = "Category";
        cmpbycat.bindid = "cmpbycatg_div";
        cmpbycat.cols = [new dcol("Category", "Category"), new dcol("Files #", "Files")];
        cmpbycat.objname = "cmpbycat";
        cmpbycat.data = dataIn;

        cmpbycat.aftercall = 'bindpiechart';
        cmpbycat.process();
    </script>
    <script>

        var dataIn = '';
        var myfiles = new sagrid();
        myfiles.url = "../Reports/Report.svc/BindMyFiles";

        myfiles.primarykeyval = "Complaint_ID";
        myfiles.bindid = "myfiles_div";
        myfiles.cols = [new dcol("Complaint Number", "Complaint_Number"), new dcol("Name", "Name"), new dcol("Category", "Category"), new dcol("Source", "Source"), new dcol("Date Received", "DateReceived"), new dcol("Date Docketed", "DateDocketed"), new dcol("Person Responsible", "Personresponsible")];
        //myfiles.cols = [new dcol("Complaint Number", "Complaint_Number"), new dcol("Name", "Name"), new dcol("Category", "Category"), new dcol("Source", "Source"), new dcol("Date Received", "DateReceived"), new dcol("Date Docketed", "DateDocketed"), new dcol("Person Responsible", "Personresponsible")];
        myfiles.objname = "myfiles";
        function bindmyfiles() {

            var dataIn4 = '"perres":"' + document.getElementById('<%= ddlperres.ClientID %>').value + '"';
          myfiles.data = dataIn4;

          myfiles.process();

      }

    </script>
    <script>

        var dataIn = '';
        var standfee = new sagrid();
        standfee.url = "../Reports/Report.svc/BindOutStandingFee";

        standfee.primarykeyval = "Last_Name";
        standfee.bindid = "outstandingfee_div";
        standfee.cols = [new dcol("Name", "Full_Name"), new dcol("License #", "Lic_no"), new dcol("Due Date", "DueDate"), new dcol("Description", "Description"), new dcol("SubOrg Amount", "SubOrgAmount")];
        standfee.objname = "standfee";
        standfee.data = dataIn;
        standfee.process();


        var outfine = '';
        var standfine = new sagrid();
        standfine.url = "../Reports/Report.svc/BindOutStandingFeeFine";

        standfine.primarykeyval = "Last_Name";
        standfine.bindid = "outstandingfeefine_div";
        standfine.cols = [new dcol("Name", "Full_Name"), new dcol("License #", "Lic_no"), new dcol("Due Date", "DueDate"), new dcol("Description", "Description"), new dcol("SubOrg Amount", "SubOrgAmount")];
        standfine.objname = "standfine";
        standfine.data = outfine;
        standfine.process();
    </script>
    <script>

        var dataIn = '';
        var liccount = new sagrid();
        liccount.url = "../Reports/Report.svc/Bindlicissuecount";
        liccount.ispaging = false;
        liccount.isfilters = false;
        liccount.primarykeyval = "License_Type";
        liccount.bindid = "lictypewisecount_div";
        liccount.cols = [new dcol("License Type", "License_Type"), new dcol("No Of License", "noflic")];
        liccount.objname = "liccount";
        liccount.data = dataIn;

        liccount.aftercall = 'bindpiechart';
        liccount.process();
    </script>
    <script>

        var dataIn = '';
        var feetypecoll = new sagrid();
        feetypecoll.url = "../Reports/Report.svc/BindFeeTypeCollect";
        feetypecoll.ispaging = false;
        feetypecoll.isfilters = false;

        feetypecoll.primarykeyval = "Fee_type";
        feetypecoll.bindid = "feetypewiseamtrecvd_div";
        feetypecoll.cols = [new dcol("Fee Type", "Fee_type"), new dcol("Amount", "Amount")];
        feetypecoll.objname = "feetypecoll";
        feetypecoll.data = dataIn;

        feetypecoll.aftercall = 'bindpiechart';
        feetypecoll.process();
    </script>

    <div class="Content">

        <div class="cpanel">
            <div class="head accr expand">My Files</div>
            <div class="body">
                <div style="text-align: center; margin: 5px">
                    Select Person Responsible
                    <asp:DropDownList ID="ddlperres" Width="250px" onChange="bindmyfiles()" runat="server"></asp:DropDownList>
                </div>
                <div id="myfiles_div"></div>
            </div>
        </div>
        <div class="cpanel">
            <div class="head accr expand" id="out">Out Standing Fee / Fine </div>
            <div class="body">
                <div class="body">
                <center>
                    <p style="text-align: center;font-weight: bold;text-decoration: underline;">Out Standing Fees</p>
                </center>
                <div id="outstandingfee_div"></div>
                <br />
                <center>
                    <p style="text-align: center;font-weight: bold;text-decoration: underline;">Out Standing Fines</p>
                </center>
                <div id="outstandingfeefine_div"></div>
            </div>
            </div>
        </div>

        <div class="linefld">

            <fieldset>
                <legend>Fee Type Wise Amount Received</legend>
                <div id="feetypewiseamtrecvd_div" class="pie"></div>
            </fieldset>
            <fieldset>
                <legend>Complaints By Category</legend>
                <div id="cmpbycatg_div" class="pie"></div>
            </fieldset>
            <fieldset>
                <legend>License Type Wise Count </legend>
                <div id="lictypewisecount_div" class="pie"></div>
            </fieldset>

        </div>

        <div class="clr"></div>
        <br />

    </div>




    <script type="text/javascript" language="javascript">

        $("#dash").addClass("active");

    </script>
    <script type="text/javascript">

        function bindpiechart(tbid) {

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
                    width: "100%",

                    // Height of chart in pixels - Number
                    // Default: automatic (unspecified)
                    height: 200,

                    chartArea: {
                        top: 0,
                        width: "100%",
                        height: "80%"
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
                        position: 'bottom',
                        alignment: 'start',
                        height: '500'
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
                showTable: 'hide'
            });

        }


        bindmyfiles();

    </script>
</asp:Content>

