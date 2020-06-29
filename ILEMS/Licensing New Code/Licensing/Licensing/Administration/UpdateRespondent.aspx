<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Administration/Admin.Master" 
    CodeBehind="UpdateRespondent.aspx.cs" Inherits="Licensing.Administration.UpdateRespondent" %>

<asp:Content ID="content1" ContentPlaceHolderID="cntmain" runat="server">

     <script type="text/javascript">
        function ValidateFields() {
             if (document.getElementById('<%=txt_complaintnmber.ClientID%>').value == '') {
                altbox("Please enter Complaint #");
                return false;
            }
            if (document.getElementById('<%=txt_newrespondentid.ClientID%>').value == '') {
                altbox("Please enter to new respondent id.");
                return false;
            }
        }
        function ClearFields() {
            document.getElementById('<%=txt_complaintnmber.ClientID%>').value = '';
            document.getElementById("<%=txt_newrespondentid.ClientID%>").value = '';
            return false;
        }
        function AfterUpdate() {
            altbox("Records updated successfully.");
            ClearFields();
        }
    </script>
    <div class="cpanel">
        <div class="head">
            Update Respondent
        </div>
        <div class="body">
            <table style="width:40%" class="spac" align="center">
                <tr>
                    <td align="right">
                       <asp:Label ID="lbl" runat="server" Text="*" style="color:red;"></asp:Label>  Complaint # :
                    </td>
                    <td align="left">
                        <asp:TextBox ID="txt_complaintnmber" runat="server" placeholder="Complaint #"></asp:TextBox>
                    </td>
                    <td align="right">
                        New Respondent ID :
                    </td>
                    <td align="left">
                        <asp:TextBox ID="txt_newrespondentid" runat="server" CssClass="numbers" placeholder="New Respondent ID"></asp:TextBox>
                    </td>
                   
                </tr>
                <tr>
                     <td align="center" colspan="4">
                        <asp:Button ID="btnsubmit" runat="server" Text="Update" OnClick="btnsubmit_Click" OnClientClick="javascript:return ValidateFields();" />&nbsp;
                        <asp:Button ID="btnclear" runat="server" Text="Clear" OnClientClick="javascript:return ClearFields();" />
                    </td>
                </tr>
            </table>
        </div>
    </div>


</asp:Content>