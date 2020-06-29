<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Master Page/frm.Master" CodeBehind="Complaint_Documnets.aspx.cs" Inherits="Licensing.Complaints.Complaint_Documnets" %>

<asp:Content ID="content1" runat="server" ContentPlaceHolderID="ContentPlaceHolder1">
<script type="text/javascript">
    function open_edit(pid) {
        document.getElementById('iframeedit').src = "../PersonLicensing/Documents.aspx?pid="+pid;

        return false;

    }
</script>
<asp:HiddenField ID="hfdcompid" runat="server" Value="0" />
<asp:HiddenField ID="hfdpid" runat="server" Value="0" />
 <iframe id="iframeedit" width="100%" height="500px" frameborder="0" ></iframe>
 <script>
     var value = document.getElementById("<%=hfdpid.ClientID %>").value;
     open_edit(value);
 </script>
</asp:Content>