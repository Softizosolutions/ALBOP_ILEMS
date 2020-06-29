$(function () {
    for (var k = 0, temp = 40; k < $(".htab").find("li").length; k++) {

        $(".htab li:eq(" + k + ")").css("margin-top", temp);
        
        temp = $(".htab li:eq(" + k + ")").width();
        temp = temp + 20;
    }
    
    var theight = $(".htab").height();
    

    theight = $('#frmcnt').height();

    if (theight < 400)
        parent.$('#frm').height(400);
    else
        parent.$('#frm').height(theight + 50);
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
            $(this).parent().appendTo($("form:first"));
        },
        close: function (e) {
            $(this).dialog("close");
            $(this).dialog('destroy');
        }
    });
    $("#msgdialog").dialog({
        dialogClass: 'DynamicDialogStyle',
        autoOpen: false,
        resizable: true,
        draggable: true,
        title: "Alert Message",
        modal: false,
        minWidth: '350px',
        maxHeight: '100px',
        position: ['center', 20],
        hide: { effect: 'scale', duration: 400 },
        show: { effect: 'scale', duration: 400 },
        buttons: [
                                {
                                    text: 'ok',
                                    "class": 'showcss',
                                    click: function () {
                                        setfocus(msgctl);
                                        $("#msgdialog").dialog('close');

                                    }
                                },
                                {
                                    text: 'cancel',
                                    "class": 'hidecss',
                                    click: function () {

                                        $("#msgdialog").dialog('close');

                                    }
                                }
                            ],
        open: function () {
            $(":button:contains('ok')").focus();
        },
        close: function () {
            setfocus(msgctl);
        }
    });

    $(".ssn").mask("?999-99-9999");
    $(".ssn").attr("placeholder", "___-__-____");
    $(".fein").mask("?99-9999999");
    $(".fein").attr("placeholder", "__-_______");
    $(".phone").mask("?(999) 999-9999");
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
    $(".required").each(function () {
        if ($(this).hasClass("nomark") == false) {

            var tdind = $(this).closest('td').index();
            if (tdind != 0)
                tdind = tdind - 1;
            var ext = $(this).closest('tr').find('td:eq(' + tdind + ')').html();
            if ($(this).closest('tr').find('td:eq(' + tdind + ')').text().indexOf(':') > 0)
                $(this).closest('tr').find('td:eq(' + tdind + ')').html("<sup>*</sup>" + ext);
        }
    });


});                                                  //end of main jQuery Ready method
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
            $(this).parent().appendTo($("form:first"));
        },
        close: function (e) {
            $(this).dialog("close");
            $(this).dialog('destroy');
        }
    });
    $("#msgdialog").dialog({
        dialogClass: 'DynamicDialogStyle',
        autoOpen: false,
        resizable: true,
        draggable: true,
        title: "Alert Message",
        modal: false,
        minWidth: '350px',
        maxHeight: '100px',
        position: ['center', 20],
        hide: { effect: 'scale', duration: 400 },
        show: { effect: 'scale', duration: 400 },
        buttons: [
                                {
                                    text: 'ok',
                                    "class": 'showcss',
                                    click: function () {
                                        setfocus(msgctl);
                                        $("#msgdialog").dialog('close');

                                    }
                                },
                                {
                                    text: 'cancel',
                                    "class": 'hidecss',
                                    click: function () {

                                        $("#msgdialog").dialog('close');

                                    }
                                }
                            ],
        open: function () {
            $(":button:contains('ok')").focus();
        },
        close: function () {
            setfocus(msgctl);
        }
    });

    $(".ssn").mask("?999-99-9999");
    $(".ssn").attr("placeholder", "___-__-____");
    $(".fein").mask("?99-9999999");
    $(".fein").attr("placeholder", "__-_______");
    $(".phone").mask("?(999) 999-9999");
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
    $(".required").each(function () {
        if ($(this).hasClass("nomark") == false) {

            var tdind = $(this).closest('td').index();
            if (tdind != 0)
                tdind = tdind - 1;
            var ext = $(this).closest('tr').find('td:eq(' + tdind + ')').html();
            if ($(this).closest('tr').find('td:eq(' + tdind + ')').text().indexOf(':') > 0)
                $(this).closest('tr').find('td:eq(' + tdind + ')').html("<sup>*</sup>" + ext);
        }
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
function validateform(fid) {
    var errormsg = "";
    fctl = null;
    $('#' + fid).find('.required').each(function () {

        if ($(this).val() == "" || $(this).val() == null || ($(this).val() == "-1" && $(this).is('select')))
            errormsg = errormsg + '<li>' + $(this).attr("error") + "</li><br>";
        else
            if ($(this).hasClass("fein") && $(this).val().length < 10)
                errormsg = errormsg + '<li>' + "Please Enter Valid FEIN" + "</li><br>";
        else
            if ($(this).hasClass("ssn") && $(this).val().length < 11)
                errormsg = errormsg + ' <li>' + "Please Enter Valid SSN" + "</li><br>";
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
function Msgbox(message, ctl) {
    msgctl = ctl;
    $("#msgdialog").dialog("open");

    $("#lblMessage").html('<ul>' + message + '</ul>');

}