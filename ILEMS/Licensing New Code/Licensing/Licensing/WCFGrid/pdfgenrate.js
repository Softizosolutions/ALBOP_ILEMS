 
function tableToJson(table) {
    var data = [];

    // first row needs to be headers
    var headers = [];
    for (var i = 0; i < table.rows[0].cells.length; i++) {
        headers[i] = table.rows[0].cells[i].innerHTML;
    }


    // go through cells
    for (var i = 2; i < table.rows.length ; i++) {

        var tableRow = table.rows[i];
        var rowData = {};

        for (var j = 0; j < tableRow.cells.length; j++) {

            rowData[headers[j]] = tableRow.cells[j].innerHTML;

        }

        data.push(rowData);

    }

    return data;
}
$.makeTable1 = function (saobj) {
    var table = $('<table border=1>');
    var colcnt = 0;
    var tblHeader = "";
    for (var i = 0; i < saobj.cols.length; i++) {

        if (saobj.cols[i].header != '' && saobj.cols[i].dbcol != '') {
            colcnt++;
            tblHeader += "<th style='color:#ffffff;background:#2980ba;'>" + saobj.cols[i].header + "</th>";
        }
    }
    tblHeader = "<tr >" + tblHeader + "</tr>";

    $(tblHeader).appendTo(table);
    $.each(saobj.resultdata, function (index, value) {
        var TableRow = "<tr>";
        for (var i = 0; i < saobj.cols.length; i++) {
            if (saobj.cols[i].header != '' && saobj.cols[i].dbcol != '')
                if (index % 2 == 0)
                    TableRow += "<td style='color:#575656;background:#f5f5f5;'>" + value[saobj.cols[i].dbcol] + "</td>";
                else
                    TableRow += "<td style='color:#575656;background:#ffffff;'>" + value[saobj.cols[i].dbcol] + "</td>";
        }

        TableRow += "</tr>";
        $(table).append(TableRow);
    });
    return ($(table));
};
$.makeTable = function (saobj) {
    var table = $('<table border=1>');
    var colcnt = 0;
    var tblHeader = "";
    for (var i = 0; i < saobj.cols.length; i++) {

        if (saobj.cols[i].header != '' && saobj.cols[i].dbcol != '') {
            colcnt++;
            tblHeader += "<th style='color:#ffffff;background:#2980ba;'>" + saobj.cols[i].header + "</th>";
        }
    }
    tblHeader = "<tr> <td align='center' colspan='" + colcnt + "'> <h2 style='color:#2980ba'>ALABAMA BOARD OF PHARMACY</h2></td></tr><tr >" + tblHeader + "</tr>";
    
    $(tblHeader).appendTo(table);
    $.each(saobj.resultdata, function (index, value) {
        var TableRow = "<tr>";
        for (var i = 0; i < saobj.cols.length; i++) {
            if (saobj.cols[i].header != '' && saobj.cols[i].dbcol != '')
                if (index % 2 == 0)
                    TableRow += "<td style='color:#575656;background:#f5f5f5;'>" + value[saobj.cols[i].dbcol] + "</td>";
                else
                    TableRow += "<td style='color:#575656;background:#ffffff;'>" + value[saobj.cols[i].dbcol] + "</td>";
        }

        TableRow += "</tr>";
        $(table).append(TableRow);
    });
    return ($(table));
};
function generate(sa, ptype) {
 if (ptype == 'xls') {
     var table;
     if (sa.parentrow != null) {
         var pobj =  JSON.parse(JSON.stringify(sa.parentrow));
        
           pobj.resultdata = pobj.resultdata.filter(function (el) {
              
             return el[pobj.primarykeyval] == sa.parentrowid;
           });

           table = $.makeTable(pobj);
          
           table.append($.makeTable1(sa));
           
     }
     else {
         table = $.makeTable(sa);
     
    
        
     }
     $(table).table2excel({
         exclude: ".noExl",
         name: "Alabama Board of Pharmacy",
         filename: "gridprint",
         exclude_img: false,
         exclude_links: true,
         exclude_inputs: true
     });
        return;
    }
    else {
    var   options;
    if (sa.cols.length < 6) {
        options = {
            orientation: "0",
            unit: "pt",
            format: "legal"
        };
    }
    else {
        options = {
        orientation: "l",
        unit: "pt",
        format: "legal"
    };
    }
    var doc = new jsPDF(options);
    
    var header = function (data) {
        doc.setFontSize(20);
        doc.setTextColor(200);
        doc.setFontStyle('bold');
        doc.addImage(headerImgData, 'JPEG', data.settings.margin.left, 40, 35, 35);
        
        if (sa.title != '') {
            doc.text("ALABAMA BOARD OF PHARMACY", data.settings.margin.left + 55, 50);
            doc.setFontSize(10);
            doc.text(sa.title, data.settings.margin.left + 55, 70);
        }
        else
            doc.text("ALABAMA BOARD OF PHARMACY", data.settings.margin.left + 55, 60);


    };

    var totalPagesExp = "{total_pages_count_string}";
    var footer = function (data) {
        var str = "Page " + data.pageCount;
        // Total page number plugin only available in jspdf v1.0+
        if (typeof doc.putTotalPages === 'function') {
            str = str + " of " + totalPagesExp;
        }
        var str1 = "  Count : " + sa.resultdata.length;
        doc.setFontSize(10);
        doc.text(str, data.settings.margin.left, doc.internal.pageSize.height - 30);
        doc.text(str1, data.settings.margin.left + 450, doc.internal.pageSize.height - 30);
    };
    var tcols = getColumns(sa);
    var cwidth = parseInt(950 / tcols.length);
    if (sa.cols.length < 6)
        cwidth = parseInt(550 / tcols.length);
    var options = {
        tableWidth: '100%',
        
        beforePageContent: header,
        afterPageContent: footer,
        margin: { top: 80,bottom:50 },
        pageBreak: 'always',
        styles: {
            fillStyle: 'DF',
            lineColor: [44, 62, 80], overflow: 'linebreak', columnWidth:cwidth, valign: 'top', lineWidth: 0.2, cellPadding: 1.5
        } 
    };
    var options1 = {
        tableWidth: '90%', 
        margin: { top: 150 },
        pageBreak: 'avoid',
        styles: {
            fillStyle: 'DF',
            lineColor: [44, 62, 80], overflow: 'linebreak'
        }
    };

    if (sa.parentrow != null) {
        var resdata = JSON.parse(JSON.stringify(sa.parentrow.resultdata));
        var fldata = resdata.filter(function (el) {
            
            return el[sa.parentrow.primarykeyval] == sa.parentrowid;
      });
     
      doc.autoTable(getColumns(sa.parentrow), fldata, options);
        doc.autoTable(getColumns(sa), sa.resultdata, options1);

    }
    else {

        doc.autoTable(tcols, sa.resultdata, options);
    }

    // Total page number plugin only available in jspdf v1.0+
    if (typeof doc.putTotalPages === 'function') {
        doc.putTotalPages(totalPagesExp);
    }

    doc.save("gridprint.pdf");
}
};

var totcols = 0;
// Returns a new array each time to avoid pointer issues
var getColumns = function (sa) {
    var theadr = new Array();
    for (var i = 0; i < sa.cols.length; i++)
    {
       
        if (sa.cols[i].header != '' && sa.cols[i].dbcol != '') {
            var b = new Object();
            b.title = sa.cols[i].header;
            b.dataKey = sa.cols[i].dbcol;
         
            theadr.push(b);
        }
    }
    totcols = theadr.length;
    return theadr;
};
 

 

// Use http://dopiaza.org/tools/datauri or similar service to convert an image into image data
var headerImgData = 'data:image/png;base64,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';