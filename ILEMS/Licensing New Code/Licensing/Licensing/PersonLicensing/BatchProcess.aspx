<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/PersonLicensing/Person.Master" CodeBehind="BatchProcess.aspx.cs" Inherits="Licensing.PersonLicensing.BatchProcess" %>
<asp:Content ID="content1" runat="server" ContentPlaceHolderID="cntmain">
<script>
    function printlabels() {
        var ltype = document.getElementById('<%= ddllictype.ClientID %>').value;
        var ctype = document.getElementById('<%= ddlcert.ClientID %>').value;
       
        if (ltype == "-1") {
            altbox("Please Select License Type");
            return false;
        }
        var bdt = document.getElementById('<%= txtdt.ClientID %>').value;
        var bdt1 = document.getElementById('<%= txtdt1.ClientID %>').value;
        var licno = document.getElementById('<%= txtlicno.ClientID %>').value;

        if (bdt == "" && licno == "") {
            altbox("Please Enter Batch Date or License #");
            return false;
        }
        if (bdt1 == "")
            bdt1 = bdt;
        document.getElementById('<%= ddltypehide.ClientID %>').value = ltype;
        var skillsSelect = document.getElementById('<%= ddltypehide.ClientID %>');
        pid = skillsSelect.options[skillsSelect.selectedIndex].text;
        if (ctype != "-1")
            pid = ltype;
        window.open('../Prints/labelPrinting.aspx?sdt=' + bdt + '&edt=' + bdt1 + '&ltype=' + pid+'&licno='+licno+'&cert='+ctype);
        return false;
    }
    function bindres() {
        var ltype = document.getElementById('<%= ddllictype.ClientID %>').value;
        var ctype = document.getElementById('<%= ddlcert.ClientID %>').value;
        
        if (ltype == "-1") {
        altbox("Please Select License Type");
        return false;
        }
    var bdt = document.getElementById('<%= txtdt.ClientID %>').value;
    var bdt1 = document.getElementById('<%= txtdt1.ClientID %>').value;
    var licno = document.getElementById('<%= txtlicno.ClientID %>').value;
    if (bdt == "" && licno=="") {
        altbox("Please Enter Batch Date or License #");
        return false;
    }
        document.getElementById('<%= ddltypehide.ClientID %>').value = ltype;
        var skillsSelect = document.getElementById('<%= ddltypehide.ClientID %>');
        pid = skillsSelect.options[skillsSelect.selectedIndex].text;
        
       
        if (ctype != "-1")
         pid = ltype;
      
        dataIn = '"pid":"' + pid + '","sdt":"' + bdt + '","edt":"' + bdt1 + '","licno":"' + licno + '","cert":"' + ctype + '"';
        
        batprint.data = dataIn;
        batprint.process();
        return false;
    }
    function aftdata() {
        if (batprint.resultdata.length == 0) {
            document.getElementById('grd').innerHTML = "";
            altbox("No Records found");
            document.getElementById('btnprint').style.display = 'none';
    
        }

    }
    function clearfrm() {
        $('#grd').html('');

        document.getElementById('<%= ddlcert.ClientID %>').value = "-1";
        document.getElementById('<%= ddllictype.ClientID %>').value = "-1";
        document.getElementById('<%= txtdt.ClientID %>').value = "";
        document.getElementById('<%=txtdt1.ClientID%>').value = '';
        return false;
    }
</script>
 <script>
 var pid;
     var dataIn = '';
     var batprint = new sagrid();
     batprint.url = "../Reports/Report.svc/GetBatchPrints";
     batprint.primarykeyval = "App_ID";
     batprint.bindid = "grd";
     batprint.aftercall = "aftdata";
     batprint.cols = [new dcol("<input id='mctl' type='checkbox' onclick='chkall()'>", "", "", "3", "1", "selchk", "", ""), new dcol("Name", "pname"), new dcol("License #", "Lic_no"), new dcol("Issue Date", "issudt"), new dcol("Expiry Date", "Expire_date")];
     batprint.objname = "batprint";
     function selchk(sender, keyval) {
         var ischk = 0;
         $('#grd').find(':checkbox').each(function () {
             if (this.checked)
                 ischk = 1;
         });
         if (ischk == 1)
             document.getElementById('btnprint').style.display = 'block';
         else
             document.getElementById('btnprint').style.display = 'none';
     }
     

     function chkall() {
         var selval = document.getElementById('mctl').checked;

         $('#grd').find(':checkbox').each(function () {
             this.checked = selval;
         });
         if (selval == true)
             document.getElementById('btnprint').style.display = 'block';
         else
             document.getElementById('btnprint').style.display = 'none';
     }
     function print_cert() {
         var selids = "";
         var trs = document.getElementById('grd').getElementsByTagName('tbody')[0].getElementsByTagName('tr');
         for (var i = 0; i < trs.length; i++) {
             if (trs[i].getElementsByTagName('input')[0].checked == true) {
                 selids = selids+batprint.resultdata[i]["App_ID"] + ",";
             }
         }
         if (selids != "")
             selids = selids.substring(0, selids.length - 1);
         var ctype = document.getElementById('<%= ddlcert.ClientID %>').value;
         if (ctype != "-1")
             pid = ctype;
         document.getElementById('<%= hfdselids.ClientID %>').value = selids;
         window.open("../Prints/prnt_cert.aspx?pname=" + pid + "&refid=" + selids);
         document.getElementById('<%= btnupd.ClientID %>').click();
     }
 </script>
  <div class="cpanel">
        <div class="head">
            Batch Certificates
        </div>
        <div class="body">
        <asp:HiddenField ID="hfduid" runat="server" Value="0" />
        <table class="spac" align="center">
        <tr>
        <td align="right">
        Select License Type :
        </td>
        <td align="left">
        <asp:DropDownList ID="ddllictype" runat="server" Width="250px"></asp:DropDownList>
       <asp:DropDownList ID="ddltypehide" runat="server" style="display:none" ></asp:DropDownList>
       
        </td>
        <td align="right">
        Select Certification :
        </td>
        <td align="left">
        <asp:DropDownList ID="ddlcert" runat="server">
        
        </asp:DropDownList>
        </td>
     
        </tr>
        <tr>
        <td colspan="4">
        <table width="100%" >
        <tr>
        
        
          <td align="right">
       License # :
       </td>
       <td align="left">
       <asp:TextBox ID="txtlicno" runat="server" ></asp:TextBox>
       </td>
         <td align="right">
        Start Date :
        </td>
        <td align="left">
        <asp:TextBox ID="txtdt" runat="server" CssClass="date" ></asp:TextBox>
        </td>
         <td align="right">
        End Date :
        </td>
        <td align="left">
        <asp:TextBox ID="txtdt1" runat="server" CssClass="date" ></asp:TextBox>
        </td>
        </tr>
        </table>
        </td>
        </tr>
        <tr>
        <td colspan="4" align="center">
        <asp:Button ID="btnsearhc" runat="server" Text="Show" OnClientClick="javascript:return bindres()" />
        <asp:Button ID="btn" runat="server" Text="Clear" OnClientClick="javascript:return clearfrm()" />
        <asp:Button ID="Button2" runat="server" Text="Print Labels" OnClientClick="javascript:return printlabels()"  />
        </td>
        </tr>
        </table>
        </div>
        </div>
        <div class="cpanel">
        <div class="head">Results</div>
        <div class="body">
        <div id="grd"></div>
        <center><br />
        <asp:HiddenField ID="hfdselids" runat="server" Value="0" />
        <asp:UpdatePanel ID="upd" runat="server">
        <ContentTemplate>
        <asp:Button ID="btnupd" runat="server" OnClick="btnupd_click" style="display:none" />
        </ContentTemplate>
        </asp:UpdatePanel>
        <input type="button" id="btnprint" value="Print Certificates" style="display:none" onclick="print_cert()" />
        </center>
        </div>
        </div>
 </asp:Content>