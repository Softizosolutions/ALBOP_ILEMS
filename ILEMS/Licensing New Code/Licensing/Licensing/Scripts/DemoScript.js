$(function () {
    $(".accr").each(function () {
        if ($(this).parent().find('.head').hasClass('expand')) {
            $(this).parent().find('.body').addClass('show');

            $(this).parent().find('.head').prepend('<i class="fa fa-hand-o-down pull-left"></i>');

        }
        else {
            $(this).parent().find('.body').addClass('hide');
            $(this).parent().find('.head').addClass('addbtm');
            $(this).parent().find('.head').prepend('<i class="fa fa-hand-o-right pull-left"></i>');
        }
        $(this).click(function () {

            if ($(this).parent().find('.body').hasClass('hide')) {
                $(this).parent().find('.head').find('i:eq(0)').removeClass('fa-hand-o-right');
                $(this).parent().find('.head').find('i:eq(0)').addClass('fa-hand-o-down');
                $(this).parent().find('.body').removeClass('hide');

                $(this).parent().find('.head').removeClass('addbtm');
            }
            else {
                $(this).parent().find('.head').find('i:eq(0)').removeClass('fa-hand-o-down');
                $(this).parent().find('.head').find('i:eq(0)').addClass('fa-hand-o-right');
                $(this).parent().find('.body').addClass('hide');
                $(this).parent().find('.head').addClass('addbtm');
            }
            setheight();
        }
        );
    });

    $(".numbers").keypress(function (e) {
        //if the letter is not digit then display error and don't type anything
        if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
            //display error message

            return false;
        }
    });
    $('.upper').keyup(function () {
        $(this).val($(this).val().toUpperCase());
    });
    $('.chars').keypress(function (e) {
        var regex = new RegExp("^[a-zA-Z]+$");
        var str = String.fromCharCode(!e.charCode ? e.which : e.charCode);
        if (regex.test(str)) {
            return true;
        }
        else {
            e.preventDefault();

            return false;
        }
    });
    $(".decimal").keydown(function (event) {


        if (event.shiftKey == true) {
            event.preventDefault();
        }

        if ((event.keyCode >= 48 && event.keyCode <= 57) ||
            (event.keyCode >= 96 && event.keyCode <= 105) ||
            event.keyCode == 8 || event.keyCode == 9 || event.keyCode == 37 ||
            event.keyCode == 39 || event.keyCode == 46 || event.keyCode == 190) {

        } else {
            event.preventDefault();
        }

        if ($(this).val().indexOf('.') !== -1 && event.keyCode == 190)
            event.preventDefault();
        //if a decimal has been added, disable the "."-button

    });
    $("#tabs").tabs({
        idPrefix: "ui-tabs-",
        selected: 0,
        load: function (event, ui) {
            var uind = ui.index + 1;




        },
        select: function (event, ui) {
            var uind = ui.index + 1;

        }
    });
    //get selected tab
    function getSelectedTabIndex() {
        return $tabs.tabs('option', 'active');
    }




    $(".poptrg").off("click");

    var winW = $(window).width() - 180;
    var winH = $(window).height() - 180;

    $(".popup").dialog({
        dialogClass: 'DynamicDialogStyle',
        autoOpen: false,
        resizable: true,
        draggable: true,
        modal: true,
        width: "auto",
        height: "auto",
        open: function (type, data) {
            if ($(this).parent().find(".ui-dialog-titlebar").find('.ui-icon-help').length == 0)
                $(this).parent().find(".ui-dialog-titlebar").append("<div class='ui-icon ui-icon-help' style='color:#fff !important;cursor:pointer' onclick='opendesk()'>Help Desk</div>");

            $(this).parent().appendTo($("form:first"));
        },
        close: function (e) {

        }
    });

   
    $(".ssn").mask("?999-99-9999");
    $(".ssn").attr("placeholder", "___-__-____");
    $(".fein").mask("?99-9999999");
    $(".fein").attr("placeholder", "__-_______");
    $(".phone").mask("?(999) 999-9999 *****");
    $(".phone").attr("placeholder", "(___) ___-____");
    $(".dea").mask("aa9999999");
    $(".dea").attr("placeholder", "_________");
    $(".zip").mask("?99999");
    $(".zip").attr("placeholder", "_____");
    $(".date").mask("99/99/9999");
    $(".date").attr("placeholder", "MM/DD/YYYY");
    $(".date").datepicker({
        changeMonth: true,
        changeYear: true
    });


    $(document).on("click", ".poptrg", function () {
        //debugger;
        //$("#adduser").dialog("open");
        dialogopen(this);
    });



});                                         //end of main jQuery Ready method
function loadele() {
     
    $(".numbers").keypress(function (e) {
        //if the letter is not digit then display error and don't type anything
        if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
            //display error message

            return false;
        }
    });
    $('.upper').keyup(function () {
        $(this).val($(this).val().toUpperCase());
    });
    $('.chars').keypress(function (e) {
        var regex = new RegExp("^[a-zA-Z]+$");
        var str = String.fromCharCode(!e.charCode ? e.which : e.charCode);
        if (regex.test(str)) {
            return true;
        }
        else {
            e.preventDefault();

            return false;
        }
    });
    $(".decimal").keydown(function (event) {


        if (event.shiftKey == true) {
            event.preventDefault();
        }

        if ((event.keyCode >= 48 && event.keyCode <= 57) ||
            (event.keyCode >= 96 && event.keyCode <= 105) ||
            event.keyCode == 8 || event.keyCode == 9 || event.keyCode == 37 ||
            event.keyCode == 39 || event.keyCode == 46 || event.keyCode == 190) {

        } else {
            event.preventDefault();
        }

        if ($(this).val().indexOf('.') !== -1 && event.keyCode == 190)
            event.preventDefault();
        //if a decimal has been added, disable the "."-button

    });
    $(".poptrg").off("click");

    var winW = $(window).width() - 180;
    var winH = $(window).height() - 180;

    $(".popup").dialog({
        dialogClass: 'DynamicDialogStyle',
        autoOpen: false,
        resizable: true,
        draggable: true,
        modal: true,
        width: "auto",
        height: "auto",
        open: function (type, data) {
            if ($(this).parent().find(".ui-dialog-titlebar").find('.ui-icon-help').length == 0)
                $(this).parent().find(".ui-dialog-titlebar").append("<div class='ui-icon ui-icon-help' style='color:#fff !important;cursor:pointer' onclick='opendesk()'>Help Desk</div>");

            $(this).parent().appendTo($("form:first"));
        },
        close: function (e) {
           
        }
    });
    

    $(".ssn").mask("?999-99-9999");
    $(".ssn").attr("placeholder", "___-__-____");
    $(".fein").mask("?99-9999999");
    $(".fein").attr("placeholder", "__-_______");
    $(".dea").mask("**9999999");
    $(".dea").attr("placeholder", "_________");
    $(".phone").mask("?(999) 999-9999 *****");
    $(".phone").attr("placeholder", "(___) ___-____");
    $(".date").mask("99/99/9999");
    $(".date").attr("placeholder", "MM/DD/YYYY");
    $(".zip").mask("?99999");
    $(".zip").attr("placeholder", "_____");
    $(".date").datepicker({
        changeMonth: true,
        changeYear: true
    });


    $(document).on("click", ".poptrg", function () {
        //debugger;
        //$("#adduser").dialog("open");
        dialogopen(this);
    });
    
}
function resize(frame) {
     altbox(frame.contents().find('body').find("#tabcnt"));
    
}
function dialogopen(ctl) {

    var head = $("#" + ctl.id + "_pop").find('.title').text();
   
    $("#" + ctl.id + "_pop").dialog({ title: head });
    $("#" + ctl.id + "_pop").dialog("open");
}
var fctl = null;
function validateEmail(sEmail) {
    var filter = /^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
    if (filter.test(sEmail)) {
        return false;
    }
    else {
        return true;
    }
}
function validateform(fid) {
    var errormsg = "";
    fctl = null;
    $('#' + fid).find('.required').each(function () {

        if ($(this).val() == "" || $(this).val() == null || ($(this).val() == "-1" && $(this).is('select')))
            errormsg = errormsg + '<li>' + $(this).attr("error") + "</li><br>";
        else
            if ($(this).hasClass("ssn") && $(this).val().length < 11)
                errormsg = errormsg + '<li>' + "Please Enter Valid SSN" + "</li><br>";
            else
                if ($(this).hasClass("fein") && $(this).val().length < 10)
                    errormsg = errormsg + '<li>' + "Please Enter Valid FEIN" + "</li><br>";
                else
                    if ($(this).hasClass("dea") && $(this).val().length < 9)
                        errormsg = errormsg + '<li>' + "Please Enter Valid DEA number" + "</li><br>";
            else
                if ($(this).hasClass("phone") && $(this).val().length < 10)
                    errormsg = errormsg + '<li>' + "Please Enter Valid Phone" + "</li><br>";
                else
                    if ($(this).hasClass("zip") && $(this).val().length < 5)
                        errormsg = errormsg + '<li>' + "Please Enter Valid Zip" + "</li><br>";
                    else
                        if ($(this).hasClass("email") && validateEmail($(this).val()))
                            errormsg = errormsg + '<li>' + "Please Enter Valid Email" + "</li><br>";
                        else
                            if ($(this).hasClass("confirmemail") && validateEmail($(this).val()))
                                errormsg = errormsg + '<li>' + "Please Enter Valid Confirm Email" + "</li><br>";
                     

        if (errormsg != "" && fctl == null)
            fctl = this;
    });

    return errormsg;
}
function setfocus(ctl) {
    if (ctl != null)
        ctl.focus();
}
var msgctl = null;
function Msgbox(message) {
    msgctl = fctl;
    var dynamicdialog = $('<div id="msgdialog"><ul>' + message + '</ul></div>');
    $(dynamicdialog).dialog({
        dialogClass: 'DynamicDialogStyle',
        autoOpen: true,
        resizable: true,
        draggable: true,
        title: "Alert Message",
        minWidth: '350px',
        maxHeight: 'auto',
        modal: true,
        hide: { effect: 'scale', duration: 400 },
        show: { effect: 'puff', duration: 400 },
        buttons: [
                                {
                                    text: 'Ok',
                                    "class": 'showcss',
                                    click: function () {
                                        setfocus(msgctl);
                                        $(dynamicdialog).dialog('close');

                                    }
                                },
                                {
                                    text: 'cancel',
                                    "class": 'hidecss',
                                    click: function () {

                                        $(dynamicdialog).dialog('close');

                                    }
                                }
                            ],
        open: function () {
            $(":button:contains('Ok')").focus();
        },
        close: function () {
            setfocus(msgctl);
        }
    });


}
function cnfbox(message,resfn) {
    
    var dynamicdialog = $('<div id="cnfdialog"><ul><li>' + message + '</li></ul></div>');
    $(dynamicdialog).dialog({
        dialogClass: 'DynamicDialogStyle',
        autoOpen: true,
        resizable: true,
        draggable: true,
        title: "Confirmation Message",
        width: 'auto',
        height: 'auto',
        modal: true,
        hide: { effect: 'scale', duration: 400 },
        show: { effect: 'puff', duration: 400 },
        buttons: [
                                {
                                    text: 'Yes',
                                    "class": 'showcss',
                                    click: function () {
                                        
                                        $(dynamicdialog).dialog('close');
                                        if (resfn != '')
                                            window[resfn]('true');
                                    }
                                },
                                {
                                    text: 'No',
                                    "class": 'showcss',
                                    click: function () {
                                     
                                        $(dynamicdialog).dialog('close');
                                        if (resfn != '')
                                            window[resfn]('false');
                                    }
                                }
                            ],
        open: function () {
            $(":button:contains('Yes')").focus();
        },
        close: function () {
            setfocus(msgctl);
        }
    });


}
function altbox(message) {

    var dynamicdialog = $('<div id="altdialog"><ul><li>' + message + '</li></ul></div>');
    $(dynamicdialog).dialog({
        dialogClass: 'DynamicDialogStyle',
        autoOpen: true,
        resizable: true,
        draggable: true,
        title: "Alert Message",
        width: 'auto',
        height: 'auto',
        modal: true,
        hide: { effect: 'scale', duration: 400 },
        show: { effect: 'puff', duration: 400 },
        buttons: [
                                {
                                    text: 'Ok',
                                    "class": 'showcss',
                                    click: function () {
                                      

                                        $(dynamicdialog).dialog('close');
                                         
                                    }
                                },
                                {
                                    text: 'No',
                                    "class": 'hidecss',
                                    click: function () {

                                        $(dynamicdialog).dialog('close');
                                        
                                    }
                                }
                            ],
        open: function () {
            $(":button:contains('Ok')").focus();
        },
        close: function () {
            setfocus(msgctl);
        }
    });


}