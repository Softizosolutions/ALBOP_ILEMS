
if (window.JSON && !window.JSON.dateParser) {
    var reISO = /^(\d{4})-(\d{2})-(\d{2})T(\d{2}):(\d{2}):(\d{2}(?:\.\d*))(?:Z|(\+|-)([\d|:]*))?$/;
    var reMsAjax = /^\/Date\((d|-|.*)\)[\/|\\]$/;
    
    JSON.dateParser = function (key, value) {
        if (typeof value === 'string') {
            var a = reISO.exec(value);
            if (a) {
                var dt = new Date(value);
                
                var m = ((dt.getMonth() + 1) < 10) ? ("0" + (dt.getMonth() + 1)) : (dt.getMonth() + 1);
                var d = (dt.getDate() < 10) ? ("0" + dt.getDate()) : dt.getDate();
                if (dt.getFullYear() == "1900")
                    return "";
                else
                    return m + "/" + d + "/" + dt.getFullYear();
            }
            a = reMsAjax.exec(value);
            if (a) {
                var b = a[1].split(/[-+,.]/);
                var dt = new Date(b[0] ? +b[0] : 0 - +b[1]);
               
                var m = ((dt.getMonth() + 1) < 10) ? ("0" + (dt.getMonth() + 1)) : (dt.getMonth() + 1);
                var d = (dt.getDate() < 10) ? ("0" + dt.getDate()) : dt.getDate();
                if (dt.getFullYear() == "1900")
                    return "";
                else
                    return m + "/" + d + "/" + dt.getFullYear();
            }
        }
        if (value == null)
            return "";
        return value;
    };

}
var dcol = function (header, dbcol, stxt, type, dbtext, clickfn, css, width) {
    this.header = header;
    this.dbcol = dbcol;
    if (!stxt)
        this.stxt = "";
    else
        this.stxt = stxt;
    if (!type)
        this.type = 0;
    else
        this.type = type;
    if (!dbtext)
        this.dbtext = 0;
    else
        this.dbtext = dbtext;

    if (!clickfn)
        this.clickfn = "";
    else
        this.clickfn = clickfn;
    if (!width)
        this.width = "";
    else
        this.width = width;
    if (!css)
        this.css = "";
    else
        this.css = css;
   
}
//setup before functions

var timer = null;
 function txtkeydown(gobj,dbol,ctl) {
     clearTimeout(timer);
     
     timer = setTimeout(doStuff, 500, gobj, dbol, ctl)
}

function doStuff(gobj, dbol, ctl) {
    for (var i = 0; i < gobj.cols.length; i++) {
        if (gobj.cols[i]["dbcol"] == dbol)
            gobj.cols[i]["stxt"] = ctl.value;
    }
    gobj.pageindex = 1;
    gobj.process();
}
var sagrid = function (bindid, primarykeyval, cols, resultdata, url, data, reccount, pagesize, pageindex, objname, sortby, sortexp, ispaging, isfilters,aftercall,title) {
    this.title = "";
    this.bindid = bindid;
    this.cols = cols;
    this.primarykeyval = primarykeyval;
    this.resultdata = resultdata;
    this.reccount = reccount;
    this.url = url;
    this.data = data;
    this.pagesize = 20;
    this.pageindex = 1;
    this.ddl = document.createElement("select");
    this.ddl.setAttribute("style", "width:50px !important;margin-right:10px;float:right");
    this.objname = objname;
    this.ddlpage = document.createElement("select");
    this.ddlpage.setAttribute("style", "width:50px !important;margin-right:10px;margin-left:5px;float:left");
    if (ispaging == undefined)
        this.ispaging = true;
    else
        this.ispaging = ispaging;
    if (isfilters == undefined)
        this.isfilters = true;
    else
        this.isfilters = isfilters;
    if (aftercall == undefined)
        this.aftercall = '';
    else
        this.aftercall = aftercall;
    
    if (!sortby)
        this.sortby = "";
    else
        this.sortby = sortby;
    if (!sortexp)
        this.sortexp = "";
    else
        this.sortexp = sortexp;
    this.hasparent = false;
    this.parentrow = null;
    this.parentrowid = 0;
}
    function sortby(gobj, colname, isasc) {
       
        gobj.sortby = colname;
        gobj.sortexp = isasc;
       
        gobj.process();
    }
    function onpagechange(gobj, sa2) {
       
    gobj.pageindex = sa2.value;
    gobj.process();
}
function gotopage(gobj, pindex) {
    
    gobj.pageindex = pindex;
    gobj.process();
}
function geturl() {
    return "";
}
function onpagesizechange(gobj, sa2) {
    
    gobj.pageindex = 1;
    gobj.pagesize = sa2.value;
    gobj.process();
}
function createheader(gobj) {
    var thead = document.createElement("thead");
    var ttr = document.createElement("tr");
    ttr.setAttribute("class", "grdheadbg");
    var ttr1 = document.createElement("tr");
    ttr1.setAttribute("class", "grdheadbg1");
    if (gobj.isfilters == false)
        ttr1.setAttribute("style", "display:none");
    for (var tcol = 0; tcol < gobj.cols.length; tcol++) {
        var ttd = document.createElement("th");
        var ttd1 = document.createElement("td");
        if (gobj.cols[tcol].dbtext == 0) {
            if (gobj.sortby == gobj.cols[tcol].dbcol && gobj.sortexp == "asc") {
                ttd.setAttribute("class", "asc");
                ttd.setAttribute("onclick", "sortby(" + gobj.objname + ",'" + gobj.cols[tcol].dbcol + "','desc')");
            }
            else {
                if (gobj.sortby == gobj.cols[tcol].dbcol)
                    ttd.setAttribute("class", "dsc");
                ttd.setAttribute("onclick", "sortby(" + gobj.objname + ",'" + gobj.cols[tcol].dbcol + "','asc')");
            }
      
        var tbox = document.createElement("input");
        tbox.setAttribute("type", "text");
        tbox.setAttribute("placeholder", "Filters");
        if (gobj.cols[tcol].stxt != "")
            tbox.setAttribute("value", gobj.cols[tcol].stxt);
        tbox.setAttribute("onkeydown", "txtkeydown(" + gobj.objname + ",'" + gobj.cols[tcol].dbcol+"',this)");

        ttd1.appendChild(tbox);
         
        
         }
        ttd.innerHTML = gobj.cols[tcol].header;
        ttr1.appendChild(ttd1);
        ttr.appendChild(ttd);
    }
    thead.appendChild(ttr);
    if (gobj.isfilters != false)
    thead.appendChild(ttr1);
     
    return thead;
}
function createheader_print(gobj) {
    var thead = document.createElement("thead");
    var ttr = document.createElement("tr");
    ttr.setAttribute("class", "grdheadbg");
    var ttr1 = document.createElement("tr");

    for (var tcol = 0; tcol < gobj.cols.length; tcol++) {
        var ttd = document.createElement("th");
        var ttd1 = document.createElement("td");
        if (gobj.cols[tcol].dbtext == 0) {
            if (gobj.sortby == gobj.cols[tcol].dbcol && gobj.sortexp == "asc") {
                ttd.setAttribute("class", "asc");
                ttd.setAttribute("onclick", "sortby(" + gobj.objname + ",'" + gobj.cols[tcol].dbcol + "','desc')");
            }
            else {
                if (gobj.sortby == gobj.cols[tcol].dbcol)
                    ttd.setAttribute("class", "dsc");
                ttd.setAttribute("onclick", "sortby(" + gobj.objname + ",'" + gobj.cols[tcol].dbcol + "','asc')");
            }

            var tbox = document.createElement("input");
            tbox.setAttribute("type", "text");
            tbox.setAttribute("placeholder", "Filters");
            if (gobj.cols[tcol].stxt != "")
                tbox.setAttribute("value", gobj.cols[tcol].stxt);
            tbox.setAttribute("onkeydown", "txtkeydown(" + gobj.objname + ",'" + gobj.cols[tcol].dbcol + "',this)");

            ttd1.appendChild(tbox);

            var spflt = document.createElement("span");
            spflt.setAttribute("class", "flt");
            spflt.innerText = "";
            ttd1.appendChild(spflt);
        }
        ttd.innerText = gobj.cols[tcol].header;
        if (gobj.cols[tcol].dbtext == 0) {
            ttr1.appendChild(ttd1);
            ttr.appendChild(ttd);
        }
    }
    thead.appendChild(ttr);
    thead.appendChild(ttr1);

    return thead;
}
function createtdcontrol(rowid,tcol,resrow,pcol) {
    var temp;
    if (tcol.type == 6) {
        temp = document.createElement("a");
        if (resrow['totdis'] == resrow['bal']) {
           
            if (tcol.dbtext == 1)
                temp.innerText = tcol.dbcol;
            else
                temp.innerText = resrow[tcol.dbcol];
            if (tcol.css != "")
                temp.setAttribute("class", tcol.css);
            temp.setAttribute("style", "cursor:pointer");
            temp.setAttribute("onclick", tcol.clickfn + "(" + rowid + ",'" + resrow[pcol] + "')");
        }
    }
    else
    if (tcol.type == 5) {
        temp = document.createElement("a");
        if (resrow[tcol.dbcol] != tcol.dbtext) {
         
            if (tcol.css != "")
                temp.setAttribute("class", tcol.css);
            temp.setAttribute("style", "cursor:pointer");
            temp.setAttribute("onclick", tcol.clickfn + "(" + rowid + ",'" + resrow[pcol] + "')");
        }
    }
    else
    if (tcol.type == 4) {
        temp = document.createElement("div");
        if (tcol.dbtext == 1)
            temp.innerHTML = tcol.dbcol;
        else
            temp.innerHTML = resrow[tcol.dbcol];
        if (tcol.css != "")
            temp.setAttribute("class", tcol.css);

        temp.setAttribute("style", "cursor:pointer");
        temp.setAttribute("onclick", tcol.clickfn + "(" + rowid + ",'" + resrow[pcol] + "')");
    }
    else
    if (tcol.type == 1) {
        temp = document.createElement("a");
        if(tcol.dbtext==1)
            temp.innerText = tcol.dbcol;
        else
            temp.innerText = resrow[tcol.dbcol];
        if (tcol.css != "")
            temp.setAttribute("class", tcol.css);
        temp.setAttribute("style", "cursor:pointer");
        temp.setAttribute("onclick", tcol.clickfn + "(" + rowid + ",'" + resrow[pcol] + "')");
    }
    else
        if (tcol.type == 3) {
            temp = document.createElement("input");
            temp.setAttribute("type", "checkbox");
            if (resrow["bal"] == "$0.00")
                temp.setAttribute("disabled", "true");

            temp.setAttribute("style", "cursor:pointer");
            temp.setAttribute("onclick", tcol.clickfn + "(" + rowid + ",'" + resrow[pcol] + "')");
        }
        else
        if (tcol.type == 2) {
            temp = document.createElement("input");
            temp.setAttribute("type", "button");
            if (tcol.dbtext == 1)
                temp.setAttribute("value", tcol.dbcol);
            else
                  temp.setAttribute("value", resrow[tcol.dbcol]);
            if (tcol.css != "")
                temp.setAttribute("class", tcol.css);
            temp.setAttribute("style", "cursor:pointer");
            temp.setAttribute("onclick", tcol.clickfn + "(" + rowid + ",'" + resrow[pcol] + "')");
        }
    return temp;
}
function createrows(gobj) {

    var tbdy = document.createElement("tbody");

    for (var oid = 0; oid < gobj.resultdata.length; oid++) {

        var tstr = document.createElement("tr");
        for (var tcol = 0; tcol < gobj.cols.length; tcol++) {
            var tstd = document.createElement("td");

            if (gobj.cols[tcol]["type"] == 0)
                tstd.innerHTML = gobj.resultdata[oid][gobj.cols[tcol]["dbcol"]];
            else
                if (gobj.cols[tcol]["type"] == '-1')
                    tstd.innerHTML = gobj.resultdata[oid][gobj.cols[tcol]["dbcol"]];
                else {
                    tstd.appendChild(createtdcontrol(oid, gobj.cols[tcol], gobj.resultdata[oid], gobj.primarykeyval));

                }
            tstr.appendChild(tstd);
        }
        tbdy.appendChild(tstr);
    }
    return tbdy;

}
function createrows_print(gobj) {

    var tbdy = document.createElement("tbody");

    for (var oid = 0; oid < gobj.resultdata.length; oid++) {
        var tstr = document.createElement("tr");
        for (var tcol = 0; tcol < gobj.cols.length; tcol++) {
            var tstd = document.createElement("td");
            if (gobj.cols[tcol]["dbtext"] == 0) {
                tstd.innerText = gobj.resultdata[oid][gobj.cols[tcol]["dbcol"]];

                tstr.appendChild(tstd);
            }
        }
        tbdy.appendChild(tstr);
    }
    return tbdy;

}
function createfooter(gobj) {
    var tfoot = document.createElement('tfoot');
    gobj.ddl.innerHTML = "";
    gobj.ddlpage.innerHTML = "";
    gobj.ddl.setAttribute("onchange", "onpagechange(" + gobj.objname + ",this)");
    gobj.ddlpage.setAttribute("onchange", "onpagesizechange(" + gobj.objname + ",this)");

    var pcoun = gobj.reccount / gobj.pagesize;
    if (gobj.reccount % gobj.pagesize != 0)
        pcoun = pcoun + 1;
    for (var i = 1; i <= pcoun; i++) {
        var nli = document.createElement("option");
        nli.text = i;
        nli.value = i;
        gobj.ddl.appendChild(nli);
    }
    gobj.ddl.value = gobj.pageindex;
    var ftr = document.createElement('tr');
    var ftd = document.createElement('td');
    ftd.setAttribute("colspan", gobj.cols.length);
   // ftd.setAttribute("class", "grdheadbg1");
    var pstart = (parseInt(gobj.pagesize) * (parseInt(gobj.pageindex) - 1) + 1);
    var plast = (gobj.pagesize * (gobj.pageindex));
    if (plast > gobj.reccount)
        plast = gobj.reccount;
    var sptxt = document.createElement("span");
    sptxt.setAttribute("style", "float:left;margin-left:10px;");
    sptxt.innerHTML = "Page size :";
    ftd.appendChild(sptxt);
    var nli = document.createElement("option");
    nli.text = "5";
    nli.value = "5";
    gobj.ddlpage.appendChild(nli);
    nli = document.createElement("option");
    nli.text = "10";
    nli.value = "10";
    gobj.ddlpage.appendChild(nli);
    nli = document.createElement("option");
    nli.text = "20";
    nli.value = "20";
    gobj.ddlpage.appendChild(nli);
    nli = document.createElement("option");
    nli.text = "50";
    nli.value = "50";
    gobj.ddlpage.appendChild(nli);
    nli = document.createElement("option");
    nli.text = "100";
    nli.value = "100";
    gobj.ddlpage.appendChild(nli);
    nli = document.createElement("option");
    nli.text = "200";
    nli.value = "200";
    gobj.ddlpage.appendChild(nli);
    gobj.ddlpage.value = gobj.pagesize;
    ftd.appendChild(gobj.ddlpage);
    sptxt = document.createElement("span");
    sptxt.setAttribute("style", "float:left;margin-left:10px");
    sptxt.innerHTML = "Records : " + pstart + " - " + plast + " of " + gobj.reccount;
    ftd.appendChild(sptxt);
    var nind = 0, prvind = 0, curindex = gobj.pageindex, lastind = parseInt(pcoun);
    if (curindex == 1) {
        prvind = 1;
        if (lastind > 1)
            nind = 2;
        else
            nind = 1;
    }
    else
        if (curindex == lastind) {
            prvind = curindex - 1;
            nind = lastind;
        }
        else {
            prvind = curindex - 1;
            nind = curindex + 1;
        }
    var btnpdf = document.createElement("i");
    btnpdf.setAttribute("class", "fa   fa-file-pdf-o");
    btnpdf.setAttribute("style", "float:right;margin-right:5px;cursor:pointer;margin-top:3px;color:red;font-size:17px;font-weight:normal");
    btnpdf.setAttribute("onclick", "generate_pdf(" + gobj.objname + ")");
    ftd.appendChild(btnpdf);
    var btnpdf1 = document.createElement("i");
    btnpdf1.setAttribute("class", "fa    fa-file-excel-o");
    btnpdf1.setAttribute("style", "float:right;margin-right:5px;cursor:pointer;margin-top:3px;color:green;font-size:17px;font-weight:normal");
    btnpdf1.setAttribute("onclick", "generate_xls(" + gobj.objname + ")");
    ftd.appendChild(btnpdf1);
    sptxt = document.createElement("span");
    sptxt.setAttribute("style", "float:right;margin-right:5px;");
    sptxt.innerHTML = '<i class="fa fa-angle-right" onclick="gotopage(' + gobj.objname + ',' + nind + ')" style="font-size:16pt;cursor:pointer;margin-left:5px;margin-right:5px"></i><i class="fa fa-angle-double-right" onclick="gotopage(' + gobj.objname + ',' + parseInt(pcoun) + ')" style="font-size:16pt;cursor:pointer;margin-left:5px;margin-right:5px"></i>';
    ftd.appendChild(sptxt);
    ftd.appendChild(gobj.ddl);
   
    sptxt = document.createElement("span");
    sptxt.setAttribute("style", "float:right;margin-right:5px;");
    sptxt.innerHTML = '<i class="fa fa-angle-double-left" onclick="gotopage(' + gobj.objname + ',1)" style="font-size:16pt;cursor:pointer;margin-left:5px;margin-right:5px"></i><i class="fa fa-angle-left" onclick="gotopage(' + gobj.objname + ','+prvind+')"  style="font-size:16pt;cursor:pointer;margin-left:5px;margin-right:5px"></i>';
    ftd.appendChild(sptxt);
    sptxt = document.createElement("span");
    sptxt.setAttribute("style", "float:right;margin-right:50px");
    sptxt.innerHTML = "Pages : " + gobj.pageindex + " of " + parseInt(pcoun);
   
    ftd.appendChild(sptxt);
    ftr.appendChild(ftd);
    tfoot.appendChild(ftr);
    return tfoot;
}
var ptype = "";
function generate_pdf(gobj) {
    ptype = "pdf";
    gobj.process_print();

}
function generate_xls(gobj) {
    ptype = "xls";
    gobj.process_print();
}
function genrate_print(sa) {
     
    
    generate(sa,ptype);
    
}
function bind(sa) {
    
    $('#' + sa.bindid).html('');
    var temptab = document.createElement('table');
    temptab.setAttribute("id", sa.bindid + "_tbl");
    temptab.setAttribute("width", "97%");
    temptab.setAttribute("class", "gridmain1");
    temptab.setAttribute("cellspacing", "0");
    temptab.setAttribute("cellpadding", "0");
 
    temptab.appendChild(createheader(sa));
   
    temptab.appendChild(createrows(sa));
    if(sa.ispaging!=false)
      temptab.appendChild(createfooter(sa));
  $('#' + sa.bindid).append(temptab);
  
  if(sa.aftercall!='')
      window[sa.aftercall](sa.bindid);
  setheight();
}
function getsdata(gobj) {
    var listOfObjects = new Array();
    for (var j = 0; j < gobj.cols.length; j++) {
    if(gobj.cols[j].stxt!="")
    {
        var MyEntity = new Object();
        MyEntity.dbfield = gobj.cols[j].dbcol;
        MyEntity.searchtxt = gobj.cols[j].stxt;
        listOfObjects.push(MyEntity);
    }
}
var jsonList = JSON.stringify(listOfObjects);
return jsonList;
}
function appendprogress(gobj) {
    var dv = document.createElement("div");
    dv.setAttribute("class", "lad");
    var dv2 = document.createElement("div");
    dv2.setAttribute("class", " fa fa-refresh fa-spin fa-3x");
    if ($('#' + gobj.bindid).height() != null) {
        var t = ($('#' + gobj.bindid).height() / 2)+20;
        var l = ($('#' + gobj.bindid).width() / 2)-50;
        
        dv.setAttribute("style", "margin-top:-"+t+"px;margin-left:"+l+"px;");
    }
    dv.appendChild(dv2);
    $('#' + gobj.bindid).append(dv);


}

$.extend(sagrid.prototype, {
    process: function () {
      
        var slef = this;
        appendprogress(slef);
       
        var pdata = '';
        if (self.ispaging == undefined)
            self.ispaging = true;
        if (self.ispaging == true) {
            if (slef.data != '')
                pdata = '{' + slef.data + ',"pageSize":' + slef.pagesize + ',"page":' + slef.pageindex + ',"sortby":"' + slef.sortby + '","sortexp":"' + slef.sortexp + '","sdata":' + getsdata(slef) + '}';
            else
                pdata = '{"pageSize":' + slef.pagesize + ',"page":' + slef.pageindex + ',"sortby":"' + slef.sortby + '","sortexp":"' + slef.sortexp + '","sdata":' + getsdata(slef) + '}';
        }
        else {
            if (slef.data != '')
                pdata = '{' + slef.data + ',"sortby":"' + slef.sortby + '","sortexp":"' + slef.sortexp + '","sdata":' + getsdata(slef) + '}';
            else
                pdata = '{"sortby":"' + slef.sortby + '","sortexp":"' + slef.sortexp + '","sdata":' + getsdata(slef) + '}';

        }
       
        $.ajax({
            url:  slef.url,
            type: "POST",
            contentType: "application/json; charset=utf-8",
            data: pdata,
            dataType: "json",
            success: function (data) {
                
                var res = JSON.parse(data.d);
                slef.resultdata = JSON.parse(res.Response, JSON.dateParser);
                slef.reccount = res.reccount;
               
                bind(slef);

            },
            failure: function (error) {
               
            altbox("Failure:" + JSON.parse(error));
            },
            error: function (error) {
                
                 altbox("Error: " + JSON.parse(error));
            }
        });
       
    },
    process_print: function () {

        var slef = this;

        var pdata = '';
        if (slef.data != '')
            pdata = '{' + slef.data + ',"pageSize":' + slef.reccount + ',"page":1,"sortby":"' + slef.sortby + '","sortexp":"' + slef.sortexp + '","sdata":' + getsdata(slef) + '}';
        else
            pdata = '{"pageSize":' + slef.reccount + ',"page":1,"sortby":"' + slef.sortby + '","sortexp":"' + slef.sortexp + '","sdata":' + getsdata(slef) + '}';

        $.ajax({
        url:   slef.url,
            type: "POST",
            contentType: "application/json; charset=utf-8",
            data: pdata,
            dataType: "json",
            success: function (data) {
                var res = JSON.parse(data.d);

                slef.resultdata = JSON.parse(res.Response, JSON.dateParser);
                slef.reccount = res.reccount;
               
                genrate_print(slef);

            },
            failure: function (error) {
                 altbox("Failure:" + error);
            },
            error: function (error) {
                 altbox("Error: " + error);
            }
        });
    }

});