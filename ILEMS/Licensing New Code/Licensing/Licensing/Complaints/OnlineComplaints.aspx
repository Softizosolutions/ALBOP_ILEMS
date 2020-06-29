<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Complaints/Complaints.Master" CodeBehind="OnlineComplaints.aspx.cs" Inherits="Licensing.Complaints.OnlineComplaints" %>

<asp:Content ID="content1" runat="server" ContentPlaceHolderID="cntmain">
     <script type="text/javascript">
        function popup() {
            $(function () {
                //$('#btn_popup').dialog({ title: 'Edit Comments' });
                //$('#btn_popup').dialog("open");
                                document.getElementById('<%=hfdselid.ClientID %>').value = keyval;                document.getElementById('<%=chk_processed.ClientID%>').checked = bus.resultdata[sender]["Processed"];                document.getElementById('<%=txtcomments.ClientID%>').value = bus.resultdata[sender]["Comments"];                $('#frm').attr('src', document.getElementById('<%= hfdurl.ClientID %>').value + '?id=' + keyval);                $('#btn_popup').dialog({ title: "Edit Online Complaint", width: "90%", minHeight: 500 });                $('#btn_popup').dialog('open');
            });
        }
    </script>
    <script type="text/javascript">
    var bus = new sagrid();
    bus.url = "../WCFGrid/GridService.svc/GetOnlineComplaints";

    bus.primarykeyval = "OnlineComplaint_ID";
    bus.bindid = "res";
    bus.cols = [new dcol("Pharmacy Name", "Pharmacy_Name", "", "1", "", "nm_click", "", ""), new dcol("Complaint Against", "Complaint_Against"), new dcol("Explanation", "Explanation"), new dcol("Name", "Full_Name"), new dcol("Business Name", "Business_Name"), new dcol("Processed", "ComplaintsProcessed"), new dcol("Print", "PrintPDF"), new dcol("Documents", "Download"), new dcol("Comments", "Comments"),
       // new dcol("Edit", "", "", "1", "1", "edit_lkp", "fa fa-pencil-square-o grdicon"),
        new dcol("Delete", "", "", "1", "1", "Delete_lkp", "fa fa-trash-o grdicon")];

    bus.objname = "bus";
    bus.aftercall = "Aftercall";
     function cnffnres(result) {
           if(result=='true')
               document.getElementById('<%= btndel.ClientID %>').click();
           }

           function Delete_lkp(sender, keyval) {
               document.getElementById('<%= hfdselid.ClientID %>').value = keyval;
               cnfbox(" Are you sure do you want to delete this record?", "cnffnres");
           }
         function edit_lkp(sender, keyval) {
     
     document.getElementById('<%= hfdselid.ClientID %>').value = keyval;
     
            document.getElementById('<%= btnedit.ClientID %>').click();
        }

        function clear_commemts() {
            document.getElementById('<%= hfdselid.ClientID %>').value = "0";
        document.getElementById('<%= txtcomments.ClientID %>').value = "";
        document.getElementById('<%= chk_processed.ClientID %>').value = "";
       
        return false;
    }
    function Bindgrd() {
        dataIn = "";
        var refid = document.getElementById('<%= txtsdt.ClientID %>').value;
        dataIn = dataIn + '"sdt":"' + refid + '",'
        var type = document.getElementById('<%= txtedt.ClientID %>').value;
        dataIn = dataIn + '"edt":"' + type + '"'
        bus.data = dataIn;
        bus.process();

        return false;
    }
    
   
    
    function Aftercall() {
        if (bus.resultdata.length == 0) {
            altbox('No Records Found.');
        }
    }
    function clear_data() {
        document.getElementById('<%= txtsdt.ClientID %>').value = "";
        document.getElementById('<%= txtedt.ClientID %>').value = "";
        document.getElementById('res').innerHTML = '';
        return false;
    }
        function nm_click(sender, keyval) {
           
            document.getElementById('<%=hfdselid.ClientID %>').value = keyval;
            document.getElementById('<%= txtcomments.ClientID %>').value = "";            document.getElementById('<%= chk_processed.ClientID %>').value = "";
            document.getElementById('<%=chk_processed.ClientID%>').checked = bus.resultdata[sender]["Processed"];
            document.getElementById('<%=txtcomments.ClientID%>').value = bus.resultdata[sender]["Comments"];
            $('#frm').attr('src', document.getElementById('<%= hfdurl.ClientID %>').value + '?id=' + keyval);
             $('#btn_popup').dialog({ title: "Online Complaint", width: "90%", minHeight: 500 });
             $('#btn_popup').dialog('open');

        }
        function ClearValues() {
            document.getElementById('<%=chk_processed.ClientID%>').checked = false;
            document.getElementById('<%=txtcomments.ClientID%>').value = false;

            return false;
        }
        function afterpost(msg) {
            altbox(msg);
            Bindgrd();
            $('#btn_popup').dialog('close');
        }
</script>
    <div class="cpanel">
        <div class="head">
            Online Complaint Search
            
 <asp:UpdatePanel ID="upd" runat="server" >
 <ContentTemplate>
 
  <asp:HiddenField ID="hfdselid" runat="server" Value="0" />
     
     <asp:Button ID="btndel" runat="server" style="display:none" OnClick="btndel_click" />
  </ContentTemplate>
 </asp:UpdatePanel>
          <asp:Button ID="btnedit" runat="server" style="display:none" OnClick="btnedit_Click" />
            <asp:UpdatePanel ID="upd1" runat="server">
                <ContentTemplate>
                     <asp:HiddenField ID="hfdorderid" runat="server" Value="0" />
                    <asp:HiddenField ID="hfdurl" runat="server" Value="" />
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
        <div class="body">
            <table align="center" class="spac">
                <tr>
                    <td align="right">Start Date :
                    </td>
                    <td align="left">
                        <asp:TextBox ID="txtsdt" runat="server" CssClass="date"></asp:TextBox>
                    </td>
                    <td align="right">End Date :
                    </td>
                    <td align="left">
                        <asp:TextBox ID="txtedt" runat="server" CssClass="date"></asp:TextBox>
                    </td>

                </tr>
                <tr>
                    <td colspan="4" align="center">
                        <br />
                        <asp:Button ID="btnsearch" runat="server" Text="Search" OnClientClick="javascript:return Bindgrd()" />
                        <asp:Button ID="btnsearchclear" runat="server" Text="Clear" OnClientClick="javascript:return clear_data()" />


                    </td>
                </tr>
            </table>
        </div>
    </div>
    <br />
    <div class="cpanel">
        <div class="head">Search Results</div>
        <div class="body">
            <div id="res"></div>
        </div>
    </div>
    <div id="btn_popup" class="popup" style="display: none;">
        <iframe id="frm" width="100%" height="500px" frameborder="0"></iframe>
        <div id="rflds">
      
         
        <%--<table style="width: 100%">
            <tr>
                <td align="center">
                    <asp:CheckBox ID="chk_processed" runat="server" Text="&nbsp;Processed" />
                </td>
            </tr>
            <tr>
                <td align="center">
                    <asp:Button ID="btn_submit" runat="server" Text="Submit" OnClick="btn_submit_Click" />&nbsp;
                </td>
            </tr>
        </table>--%>
            <table style="width: 100%">
            <tr>
                
                  <td style="padding-left:250px" align="right">
                    Comments
                </td>
                <td  align="left">
                    <asp:TextBox TextMode="MultiLine" id="txtcomments" runat="server"></asp:TextBox>
                </td>
                
                    
                
                 <td style="padding-right:500px">
                    <asp:CheckBox ID="chk_processed" runat="server" Text="&nbsp;Processed" />
                </td>
                
            </tr>
            <tr>
                 <td></td>
                <td style="padding-left:200px" align="center">
                    <asp:Button ID="btn_submit" runat="server" Text="Submit" OnClick="btn_submit_Click" />
                </td>
                <td></td>
            </tr>
        </table>
        
            </div>
    </div>
</asp:Content>
