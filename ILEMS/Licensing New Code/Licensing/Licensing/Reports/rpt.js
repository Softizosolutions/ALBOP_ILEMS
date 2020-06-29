function bind_dropdown(dctl,data) {
    $(dctl).empty();
    var topt = document.createElement("option");
    topt.value = "-1";
    topt.text = "ALL";
    dctl.appendChild(topt);
    for (var i = 0; i < data.length; i++) {
        topt= document.createElement("option");
       topt.value = data[i].b;
       topt.text = data[i].a;
       dctl.appendChild(topt);
    }
    
}
function bindropdown(dctl, qur) {
   
    var qury = '{"query":"'+qur+'"}';
    $.ajax({
        url: "../Reports/Report.svc/Runquery",
        type: "POST",
        contentType: "application/json; charset=utf-8",
        data: qury,
        dataType: "json",
        success: function (data) {
            var res = JSON.parse(data.d);
            
            bind_dropdown(dctl,JSON.parse(res.Response));

        },
        failure: function (error) {
             altbox("Failure:" + error);
        },
        error: function (error) {
             altbox("Error: " + JSON.parse(error));
        }
    });
}

function relationtbchange(ctl) {
    var subtd = document.getElementById('tblretsub');
    subtd.innerHTML = '';
    addsubretrow();
}
function subretchang(ctl) {
    var drps = ctl.parentElement.parentElement.getElementsByTagName('select');
    if (drps.length == 4)
        drps[3].innerHTML = '';

    if (ctl.value != 'User Input') {
        if (drps.length != 4) {
            var td5 = ctl.parentElement.parentElement.getElementsByTagName('td');
            var inps = ctl.parentElement.parentElement.getElementsByTagName('input');
            td5[3].removeChild(inps[0]);

            td5[3].appendChild(createdropdown());
        }
        var spans1 = document.getElementById(ctl.value).getElementsByTagName('span');

        for (var i = 0; i < spans1.length; i++) {
            var tempopt1 = document.createElement("option");
            tempopt1.text = spans1[i].innerText;
            drps[3].appendChild(tempopt1);
        }
    }
    else {

        var td5 = ctl.parentElement.parentElement.getElementsByTagName('td');
        td5[3].removeChild(drps[3]);

        td5[3].appendChild(createtextbox());
    }

}
function delretsubrow(ctl) {
    var objrow = ctl.parentElement.parentElement;
    document.getElementById('tblretsub').removeChild(objrow);
}
function addsubretrow() {
    var rstr = document.createElement('tr');
    var rstd1 = document.createElement('td');
    var rstd2 = document.createElement('td');
    var rstd3 = document.createElement('td');
    var rstd4 = document.createElement('td');
    var rstd5 = document.createElement('td');
    rstd5.innerHTML = "<i  class='fa fa-trash-o grdicon' onclick='delretsubrow(this)' />";
    var tempdrp4 = createdropdown();
    var tempopt4 = document.createElement("option");
    tempopt4.text = "=";
    tempdrp4.appendChild(tempopt4);
    tempopt4 = document.createElement("option");
    tempopt4.text = "!=";
    tempdrp4.appendChild(tempopt4);
    tempopt4 = document.createElement("option");
    tempopt4.text = "<";
    tempdrp4.appendChild(tempopt4);
    tempopt4 = document.createElement("option");
    tempopt4.text = ">";
    tempdrp4.appendChild(tempopt4);
    tempopt4 = document.createElement("option");
    tempopt4.text = "<=";
    tempdrp4.appendChild(tempopt4);
    tempopt4 = document.createElement("option");
    tempopt4.text = ">=";
    tempdrp4.appendChild(tempopt4);
    rstd4.appendChild(tempdrp4);
    var tempdrp1 = createdropdown();
   
    var spans = document.getElementById(document.getElementById('retselect').value).getElementsByTagName('span');
   
    for (var i = 0; i < spans.length; i++) {
        var tempopt1 = document.createElement("option");
        tempopt1.text = spans[i].innerText;
        tempdrp1.appendChild(tempopt1);
    }
    
    var tempdrp2 = createdropdown();
    var tcount = document.getElementById('ctl00_ctl00_cntbdy_cntmain_ddlmtables').length;
    for (var k = 0; k < tcount; k++) {

        if (document.getElementById('ctl00_ctl00_cntbdy_cntmain_ddlmtables')[k].text != document.getElementById('retselect').value) {

            var tempopt = document.createElement("option");
            tempopt.text = document.getElementById('ctl00_ctl00_cntbdy_cntmain_ddlmtables')[k].text;
            tempdrp2.appendChild(tempopt);

        }
    }
    var tempopt = document.createElement("option");
    tempopt.text = "User Input";
    tempdrp2.appendChild(tempopt);
    tempdrp2.onchange = function () { subretchang(this); }
    var tempdrp3 = createdropdown();
    var spans1 = document.getElementById(tempdrp2.value).getElementsByTagName('span');
  
    for (var i = 0; i < spans1.length; i++) {
        var tempopt1 = document.createElement("option");
        tempopt1.text = spans1[i].innerText;
        tempdrp3.appendChild(tempopt1);
    }
    rstd1.appendChild(tempdrp1);
    rstd2.appendChild(tempdrp2);
    rstd3.appendChild(tempdrp3);
    rstr.appendChild(rstd1);
    rstr.appendChild(rstd4);
    rstr.appendChild(rstd2);
    rstr.appendChild(rstd3);
    rstr.appendChild(rstd5);
    
    document.getElementById('tblretsub').appendChild(rstr);
    return false;
}
function addtables2relation() {
    $('#retpop').dialog({ title: "New Relation", width: '70%' });
    $('#retpop').dialog("open");
    
     var tcount = document.getElementById('ctl00_ctl00_cntbdy_cntmain_ddlmtables').length;
  
    var obj = document.getElementById('retselect');
    obj.innerHTML = '';
    var subtd = document.getElementById('tblretsub');
    subtd.innerHTML = '';
   
    var tempdrp = createdropdown();
   
    for (var k = 0; k < tcount; k++) {

        if (document.getElementById('ctl00_ctl00_cntbdy_cntmain_ddlmtables')[k].text != document.getElementById('ctl00_ctl00_cntbdy_cntmain_ddlmtables').value) {
            if (document.getElementById('tr_sub_' + document.getElementById('ctl00_ctl00_cntbdy_cntmain_ddlmtables')[k].text) == null) {
                var tempopt = document.createElement("option");
                tempopt.text = document.getElementById('ctl00_ctl00_cntbdy_cntmain_ddlmtables')[k].text;
                obj.appendChild(tempopt);
            }
        }
    }
    
    addsubretrow();
  
    return false;

}
function addcolumnsfilters() {
    var spans = document.getElementById(document.getElementById('ddlflttabls').value).getElementsByTagName('span');
    var tempdrp1 = document.getElementById('ddlfltcolumns');
    tempdrp1.innerHTML = '';
    for (var i = 0; i < spans.length; i++) {
        var tempopt1 = document.createElement("option");
        tempopt1.text = spans[i].innerText;
        tempdrp1.appendChild(tempopt1);
    }
}
function addcolumnsfilters2() {
    var spans = document.getElementById(document.getElementById('ddlfldrptbls').value).getElementsByTagName('span');
    var tempdrp1 = document.getElementById('ddlfldrpcls1');
    tempdrp1.innerHTML = '';
    var tempdrp2 = document.getElementById('ddlfldrpcls2');
    tempdrp2.innerHTML = '';
    for (var i = 0; i < spans.length; i++) {
        var tempopt1 = document.createElement("option");
        tempopt1.text = spans[i].innerText;
        tempdrp1.appendChild(tempopt1);

    }
    for (var i = 0; i < spans.length; i++) {
        var tempopt1 = document.createElement("option");
        tempopt1.text = spans[i].innerText;
        tempdrp2.appendChild(tempopt1);

    }
}
function flttypechng(ctl) {
    if (ctl.value == "Fixed Value")
        document.getElementById('flttxt').style.display = 'block';
    else
        document.getElementById('flttxt').style.display = 'none';
    if (ctl.value == "Drop Down") {

        document.getElementById('fltdrptb').style.display = 'block';

        var tcount = document.getElementById('ctl00_ctl00_cntbdy_cntmain_ddlmtables').length;
        var obj = document.getElementById('ddlfldrptbls');
        obj.innerHTML = '';
        for (var k = 0; k < tcount; k++) {
            var tempopt = document.createElement("option");
            tempopt.text = document.getElementById('ctl00_ctl00_cntbdy_cntmain_ddlmtables')[k].text;
            obj.appendChild(tempopt);

        }
        addcolumnsfilters2();
    }
    else {
        document.getElementById('fltdrptb').style.display = 'none';
        var drp = document.getElementById('ddlfldrptbls');
        drp.innerHTML = '';
    }
}
function addtables2filters() {
    $('#fltpop').dialog({ title: "New Filters",width:'70%' });
    $('#fltpop').dialog("open");
   
    var tcount = document.getElementById('ctl00_ctl00_cntbdy_cntmain_ddlmtables').length;
    var obj = document.getElementById('ddlflttabls');
    obj.innerHTML = '';
    for (var k = 0; k < tcount; k++) {
        var tempopt = document.createElement("option");
        tempopt.text = document.getElementById('ctl00_ctl00_cntbdy_cntmain_ddlmtables')[k].text;
        obj.appendChild(tempopt);

    }
    addcolumnsfilters();

    return true;

}
function createthead(hname) {
    var tdhead = document.createElement("div");
    tdhead.setAttribute("style", "padding-left:5px;padding-right:5px");
    tdhead.className = 'grdheadbg';
    tdhead.innerText = hname;

    return tdhead;
}
function delretrow(ctl) {
    var obj = ctl.parentElement.parentElement.id;
    document.getElementById('tbodyrelation').removeChild(document.getElementById(obj));
}
function delretrow_fltr(ctl) {
    var obj = ctl.parentElement.parentElement.id;
    document.getElementById('tbfilters').removeChild(document.getElementById(obj));
}
function saverelation_main() {
    var rettab = document.getElementById('retselect').value;
    if (rettab == '') {
         altbox('Please Select Relation Table.');
        return false;
    }
    var isreq = document.getElementById('ctl00_ctl00_cntbdy_cntmain_chbretreq').checked;
    var rtrows = document.getElementById('tblretsub').getElementsByTagName('tr');
    var rat = ''
    if (rtrows.length == 0) {
         altbox('atleat add one rule');
        return false;
    }
    for (var i = 0; i < rtrows.length; i++) {
        var drps = rtrows[i].getElementsByTagName('select');
        var inps = rtrows[i].getElementsByTagName('input');

        if (drps.length == 4)
            rat += rettab + "." + drps[0].value + drps[1].value + drps[2].value + "." + drps[3].value + " and ";
        else
            rat += rettab + "." + drps[0].value + drps[1].value + inps[0].value + " and ";

    }
   
    if (rat != '')
        rat = rat.substring(0, rat.length - 4);
    var rtr = document.createElement('tr');
    var rtd1 = document.createElement('td');
    var rtd2 = document.createElement('td');
    var rtd3 = document.createElement('td');
    var rtd4 = document.createElement('td');
    rtd1.innerText = rettab;
    if (!isreq)
        rtd2.innerText = 'Inner join';
    else
        rtd2.innerText = 'Left outer join';
    rtd3.innerText = rat;
    rtd4.innerHTML = "<i class='fa fa-trash-o grdicon' onclick='delretrow(this)' />";
    rtr.appendChild(rtd1);
    rtr.appendChild(rtd2);
    rtr.appendChild(rtd3);
    rtr.appendChild(rtd4);
   
    rtr.align = 'center';
    rtr.id = "tr_sub_" + rettab;

    document.getElementById('tbodyrelation').appendChild(rtr);

    $('#retpop').dialog('close');
  
    return false;
}
var fltcnt = 1;
function addfltr2table() {
    var rtr = document.createElement('tr');
    var rtd1 = document.createElement('td');
    var rtd2 = document.createElement('td');
    var rtd3 = document.createElement('td');
    var rtd4 = document.createElement('td');
    var rtd5 = document.createElement('td');
    var rtd6 = document.createElement('td');
    var hdcnt = '';
    rtd6.innerText = document.getElementById('txtdisp').value;
    rtd1.innerText = document.getElementById('ddlflttabls').value;
    rtd2.innerText = document.getElementById('ddlfltcolumns').value;
    rtd3.innerText = document.getElementById('flttype').value;
    rtd4.innerText = document.getElementById('fltcnd').value;
    if (document.getElementById('flttype').value == 'Fixed Value')
        hdcnt = document.getElementById('flttxt_val').value;
    else
        if (document.getElementById('flttype').value == 'Drop Down')
            hdcnt = document.getElementById('ddlfldrptbls').value + ',' + document.getElementById('ddlfldrpcls1').value + ',' + document.getElementById('ddlfldrpcls2').value;

    rtd5.innerHTML = "<input type='hidden' value='" + hdcnt + "'/><i class='fa fa-trash-o grdicon' onclick='delretrow_fltr(this)' />";
    rtr.appendChild(rtd6);
    rtr.appendChild(rtd1);
    rtr.appendChild(rtd2);
    rtr.appendChild(rtd3);
    rtr.appendChild(rtd4);
    rtr.appendChild(rtd5);
    
    rtr.align = 'center';
    rtr.id = "tr_sub_" + fltcnt;
    fltcnt++;
    document.getElementById('tbfilters').appendChild(rtr);
    document.getElementById('txtdisp').value = '';
    $('#fltpop').dialog('close');
    return false;
}
function addrelations() {
    var tcount = document.getElementById('ctl00_ctl00_cntbdy_cntmain_ddlmtables').length;
    if (tcount > 1) {
        var rtr = document.createElement('tr');
        var rtd1 = document.createElement('td');
        var rtd2 = document.createElement('td');
        var rtd3 = document.createElement('td');
        var tempdrp = createdropdown();
        for (var k = 0; k < tcount; k++) {
            var tempopt = document.createElement("option");
            tempopt.text = document.getElementById('ctl00_ctl00_cntbdy_cntmain_ddlmtables')[k].text;
            tempdrp.appendChild(tempopt);
        }
        rtd1.appendChild(tempdrp);
        var temptxt = createtextbox();
        temptxt.style.width = "90%";
        rtd3.appendChild(temptxt);
        rtd2.appendChild(createcheckbox());
        rtr.appendChild(rtd1);
        rtr.appendChild(rtd2);
        rtr.appendChild(rtd3);
        rtr.className = 'Griditem';
        rtr.align = 'center';
        document.getElementById('tbodyrelation').appendChild(rtr);
    }
}
function createrows1(vals) {
    var ttr = document.createElement("tr");
    var ttd = document.createElement('td');
    var cols = vals.toString().split('~');
    for (var i = 0; i < cols.length; i++) {
        var hid = document.createElement("input");
        hid.type = 'hidden';
        hid.value = cols[i];
        ttd.appendChild(hid);
    }
    var chb = document.createElement("input");
    chb.type = "checkbox";

    chb.addEventListener('click', function () {
        addcolumn(this);
    });
    ttd.appendChild(chb);
    var spn = document.createElement("span");
    spn.innerText = cols[0];
    ttd.appendChild(spn);
    ttr.appendChild(ttd);
    
    return ttr;
}
function removetable(tid) {
    var temp = document.getElementById(tid);

    var cols = document.getElementById(tid).getElementsByTagName('span');
    for (var k = 0; k < cols.length; k++) {
        var temptr = document.getElementById('tr_' + cols[k].innerText);
        if (temptr != null) {
            document.getElementById('tblselcols').removeChild(temptr);
        }
    }
    if (temp != null)
        document.getElementById('designer').removeChild(temp)
}
function createtable(tname, cols) {
    var tdiv = document.createElement("div");
    tdiv.appendChild(createthead(tname));
    tdiv.id = tname;
    tdiv.className = 'indiv';
    var cntdiv = document.createElement("div");
    var tb = document.createElement("Table");
     
    tb.width = "100%";
    tb.setAttribute("cellspaccing", "0");
    tb.setAttribute("cellpadding", "0");
    tb.setAttribute("border", "1");
    tb.setAttribute("class", "gridmain1");
    var drows = cols.toString().split('^');
    for (var j = 0; j < drows.length; j++)
        tb.appendChild(createrows1(drows[j]));
    cntdiv.appendChild(tb);
    tdiv.appendChild(cntdiv);
    document.getElementById('designer').appendChild(tdiv);

}
function createdropdown() {
    var drp = document.createElement('select');
    return drp;
}
function createcheckbox() {
    var cchb = document.createElement("input");
    cchb.type = "checkbox";
    return cchb;
}
function createtextbox() {
    var cchb = document.createElement("input");
    cchb.type = "text";
    return cchb;
}
function addcolumn(ctl) {
    var hids = ctl.parentElement.getElementsByTagName("input");

    var colname = hids[0].value;
    var dtype = hids[1].value;
    var dlength = hids[2].value;

    if (ctl.checked) {
        var ctr = document.createElement("tr");
        ctr.id = "tr_" + colname;
        var ctd1 = document.createElement("td");
        var ctd2 = document.createElement("td");
        var ctd3 = document.createElement("td");
        var ctd4 = document.createElement("td");

        var ctd9 = document.createElement("td");
        ctd1.innerText = colname;
        if (dlength != "")
            dtype = dtype + " (" + dlength + ")";
        ctd2.innerText = dtype;
        var tchb = createcheckbox();
        tchb.checked = true;
        ctd3.appendChild(tchb);
        var temptxt = createtextbox();
        temptxt.value = colname;
        ctd4.appendChild(temptxt);


        var sdiv = ctl.parentElement.parentElement.parentElement.parentElement.parentElement.getElementsByTagName('div');
        ctd9.innerText = sdiv[0].innerText;
        ctr.appendChild(ctd9);
        ctr.appendChild(ctd1);
        ctr.appendChild(ctd2);
        ctr.appendChild(ctd3);
        ctr.appendChild(ctd4);

        
        ctr.align = 'center';
        document.getElementById('tblselcols').appendChild(ctr);
    }
    else {
        var temptr = document.getElementById("tr_" + colname);
        document.getElementById('tblselcols').removeChild(temptr);
    }
}
 
function saverpt() {
    var qur = "select  "
    var cols = " ";
    var ordby = "";
    var grpby = "";
    var fcolumn = "";
    var filters = "";
    var dbcols = "";

    var tables = document.getElementById('ctl00_ctl00_cntbdy_cntmain_ddlmtables').value + ' ';
    var colrows = document.getElementById('tblselcols').getElementsByTagName('tr');
    for (var i = 0; i < colrows.length; i++) {
        var rtds = colrows[i].getElementsByTagName('td');
        var schb = rtds[3].getElementsByTagName('input');
        var schdisp = rtds[4].getElementsByTagName('input');

        if (schb[0].checked) {
            if (rtds[2].innerText == 'datetime')
                cols += ' convert(varchar(50),' + rtds[0].innerText + '.' + rtds[1].innerText + ',101) as [' + schdisp[0].value + '],';
            else
                cols += rtds[0].innerText + '.' + rtds[1].innerText + ' as [' + schdisp[0].value + '],';
        }
        if (fcolumn == "") {
            fcolumn = schdisp[0].value;
        }
        dbcols = dbcols + schdisp[0].value + "^";
    }
    if (cols != "")
        cols = cols.substring(0, cols.length - 1);
    if (ordby != "")
        ordby = ordby.substring(0, ordby.length - 1);
    else
        ordby = fcolumn;

    var retrows = document.getElementById('tbodyrelation').getElementsByTagName('tr');
    for (var i = 0; i < retrows.length; i++) {
        var rettds = retrows[i].getElementsByTagName('td');
        tables += rettds[1].innerText + ' ' + rettds[0].innerText + ' on ' + rettds[2].innerText + ' ';
    }
    qur = qur + ' ' + cols + ' from ' + tables;
    var fltrs = document.getElementById('tbfilters').getElementsByTagName('tr');
    var selfltrs = "";
    for (var i = 0; i < fltrs.length; i++) {
        var ftds = fltrs[i].getElementsByTagName('td');
        selfltrs += ftds[0].innerHTML + "^" + ftds[1].innerHTML + "^" + ftds[2].innerHTML + "^" + ftds[3].innerHTML + "^" + ftds[4].innerHTML + "^" + ftds[5].getElementsByTagName('input')[0].value + "~";

    }
    if (dbcols != "")
        dbcols = dbcols.substring(0, dbcols.length - 1);
    document.getElementById('ctl00_ctl00_cntbdy_cntmain_hfdcols').value = dbcols;
    document.getElementById('ctl00_ctl00_cntbdy_cntmain_hfdfltrs').value = selfltrs;
    document.getElementById('ctl00_ctl00_cntbdy_cntmain_hfdquery').value = qur;
}
function createquery() {
    var qur = "select  "
    var cols = " ";
    var ordby = "";
    var grpby = "";
    var fcolumn = "";
    var filters = "";
    var tables = document.getElementById('ctl00_ctl00_cntbdy_cntmain_ddlmtables').value + ' ';
    var colrows = document.getElementById('tblselcols').getElementsByTagName('tr');
    var dbcols ="";

    for (var i = 0; i < colrows.length; i++) {
        var rtds = colrows[i].getElementsByTagName('td');
        var schb = rtds[3].getElementsByTagName('input');
        var schdisp = rtds[4].getElementsByTagName('input');

        if (schb[0].checked) {
            if (rtds[2].innerText == 'datetime')
                cols += ' convert(varchar(50),' + rtds[0].innerText + '.' + rtds[1].innerText + ',101) as [' + schdisp[0].value + '],';
            else
                cols += rtds[0].innerText + '.' + rtds[1].innerText + ' as [' + schdisp[0].value + '],';
        }
        if (fcolumn == "") {
            fcolumn = schdisp[0].value;
        }
        dbcols = dbcols+schdisp[0].value+"^";

    }
    if (cols != "")
        cols = cols.substring(0, cols.length - 1);
    if (ordby != "")
        ordby = ordby.substring(0, ordby.length - 1);
    else
        ordby = fcolumn;

    var retrows = document.getElementById('tbodyrelation').getElementsByTagName('tr');
    for (var i = 0; i < retrows.length; i++) {
        var rettds = retrows[i].getElementsByTagName('td');
        tables += rettds[1].innerText + ' ' + rettds[0].innerText + ' on ' + rettds[2].innerText + ' ';
    }
    qur = qur + ' ' + cols + ' from ' + tables;
    var fltrs = document.getElementById('tbfilters').getElementsByTagName('tr');
    var selfltrs = "";
    for (var i = 0; i < fltrs.length; i++) {
        var ftds = fltrs[i].getElementsByTagName('td');
        selfltrs += ftds[0].innerHTML + "^" + ftds[1].innerHTML + "^" + ftds[2].innerHTML + "^" + ftds[3].innerHTML + "^" + ftds[4].innerHTML + "^" + ftds[5].getElementsByTagName('input')[0].value + "~";

    }
    if (dbcols != "")
        dbcols = dbcols.substring(0, dbcols.length - 1);
    document.getElementById('ctl00_ctl00_cntbdy_cntmain_hfdcols').value = dbcols;
    document.getElementById('ctl00_ctl00_cntbdy_cntmain_hfdfltrs').value = selfltrs;
     document.getElementById('ctl00_ctl00_cntbdy_cntmain_hfdquery').value = qur;
     if (selfltrs == "")
         grdbind();
     else
         bindfltrs();
}
prevtd = document.getElementById('1-1');
prevtd.className = "td_hover";
function setgrdheight() {


}
  
function aftersave() {
     altbox("Report Saved Completed.");

}
  