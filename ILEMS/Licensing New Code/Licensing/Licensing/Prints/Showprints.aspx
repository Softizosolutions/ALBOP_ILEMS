<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Showprints.aspx.cs" Inherits="Licensing.Prints.Showprints" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../Styles/product.css" rel="stylesheet" type="text/css" />
    <link href="../Styles/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
    
     <script language="javascript">
         function printopen(ctl) {
             var selid = ctl.value;
             var refid = document.getElementById('<%= hfdid.ClientID %>').value;
             var folder = '<%= Request.QueryString[0].ToString() %>';
             if (folder != 3 && selid != 34 && folder != 4)
                 document.getElementById('frm').src = './' + selid + '.aspx?print=1&pgid=' + selid + '&refid=' + refid;
             else {
               var pid=document.getElementById('<%= hfdpid.ClientID %>').value;
                 document.getElementById('frm').src = './' + selid + '.aspx?print=1&pgid=' + selid + '&refid=' + refid+'&pid='+pid;
             }
         }
         function printcnt() {
             var frm = document.getElementById('frm').contentWindow;
             frm.focus(); // focus on contentWindow is needed on some ie versions
             frm.print();
             return false;
         }
    </script>
    <style>
    #prnt
    {
        top:5px;
       right:10px;
        position:fixed;
    }
    .divround
{
    margin-top:-8px;
	border-radius: 15px;
	border: solid 1px #7A7A7A;
	min-height: 200px;
	background: #ffffff; /* Old browsers */
background: -moz-linear-gradient(top,  #ffffff 0%, #e5e5e5 100%); /* FF3.6+ */
background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,#ffffff), color-stop(100%,#e5e5e5)); /* Chrome,Safari4+ */
background: -webkit-linear-gradient(top,  #ffffff 0%,#e5e5e5 100%); /* Chrome10+,Safari5.1+ */
background: -o-linear-gradient(top,  #ffffff 0%,#e5e5e5 100%); /* Opera 11.10+ */
background: -ms-linear-gradient(top,  #ffffff 0%,#e5e5e5 100%); /* IE10+ */
background: linear-gradient(to bottom,  #ffffff 0%,#e5e5e5 100%); /* W3C */

}
    </style>
</head>
<body style="background:transparent !important">
    <form id="form1" runat="server">
    <asp:HiddenField ID="hfdid" runat="server" Value="0" />
        <asp:HiddenField ID="hfdpid" runat="server" Value="0" />
    <div id="prnt">
    <table  >
    <tr>
       
    <td> 
    <asp:Button ID="btnword" style="font-size:15pt !important" runat="server" CssClass="grdicon1"  Text="&#xf1c2;" OnClick="btnprint_click" />
    
    </td>
    
    <td> 
    <asp:Button ID="Button2" style="font-size:15pt  !important;" runat="server"  CssClass="grdicon1"  Text="&#xf02f;" OnClientClick="javascript:return printcnt()" />
    
    </td>
         <td> 
    <asp:Button ID="Button1" style="font-size:15pt !important;display:none" runat="server" CssClass="grdicon1"  Text="&#xf1c1;" OnClick="btnprint_click1" />
    
    </td>
    
    </tr>
    </table>
    </div>
    <table width="100%" cellpadding="0" cellspacing="0" border="0">
    <tr>
    <td width="20%">
    <asp:ListBox ID="ddllst" runat="server" Height="480" Width="100%" onclick="printopen(this)"></asp:ListBox>
    
    </td>
    <td width="100%" style="padding-top:5px">
    <div class="divround">
    
    <iframe id="frm" frameborder="0" width="100%" height="480px"  ></iframe>
    </div>
    </td>
    </tr>
    </table>
    </form>
</body>

</html>
