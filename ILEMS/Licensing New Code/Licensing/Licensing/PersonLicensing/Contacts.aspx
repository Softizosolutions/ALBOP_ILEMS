<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="../Master Page/frm.master"
    CodeBehind="Contacts.aspx.cs" Inherits="Licensing.PersonLicensing.Contacts" %>

<asp:Content ID="content1" runat="server" ContentPlaceHolderID="ContentPlaceHolder1">
    <script type="text/javascript">
        var dataIn = '';
        var contact = new sagrid();
        contact.url = "../WCFGrid/GridService.svc/Bindcontacts";

        contact.primarykeyval = "contact_id";
        contact.bindid = "grdcontactdetails";

        contact.objname = "contact";

        function Select_lkp(sender, keyval) {
            var selperid = contact.resultdata[sender]["Person_ID"];
            var otype = contact.resultdata[sender]["object_type"];
            if (otype == "1")
                parent.window.location.href = '../PersonLicensing/PersonDetails.aspx?perid=' + selperid;
            else
                parent.window.location.href = '../PersonLicensing/Business_Details.aspx?perid=' + selperid;
        }
        function Delete_contactlkp(sender, keyval) {
            document.getElementById('<%= hfdselid.ClientID %>').value = keyval;
            document.getElementById('<%= btncontact.ClientID %>').click();
        }
        function DeleteContact(sender, keyval) {
            document.getElementById('<%=hfdselid.ClientID%>').value = keyval;
             cnfbox(" Are you sure do you want to delete this record?", "cnffnres");
         }
         function cnffnres(result) {
             if (result == 'true')
                 document.getElementById('<%=btndeletecontact.ClientID%>').click();
        }
    </script>
     <script type="text/javascript">
       
        var agent = new sagrid();
        agent.url = "../WCFGrid/GridService.svc/Bindcontacts";

        agent.primarykeyval = "contact_id";
        agent.bindid = "grdagentdetails";

        agent.objname = "agent";

        function Select_lkp_agent(sender, keyval) {
            var selperid = agent.resultdata[sender]["Person_ID"];
            var otype = agent.resultdata[sender]["object_type"];
            if (otype == "1")
                parent.window.location.href = '../PersonLicensing/PersonDetails.aspx?perid=' + selperid;
            else
                parent.window.location.href = '../PersonLicensing/Business_Details.aspx?perid=' + selperid;
        }
        
    </script>
    <script type="text/javascript">
        var dataIn = '';
        var owner = new sagrid();
        owner.url = "../WCFGrid/GridService.svc/Bindcontacts";

        owner.primarykeyval = "contact_id";
        owner.bindid = "grdownerdetails";

        owner.objname = "owner";

        function Select_lkp1(sender, keyval) {
            var selperid = owner.resultdata[sender]["Person_ID"];
            var otype = owner.resultdata[sender]["object_type"];
            if (otype == "1")
                parent.window.location.href = '../PersonLicensing/PersonDetails.aspx?perid=' + selperid;
            else
                parent.window.location.href = '../PersonLicensing/Business_Details.aspx?perid=' + selperid;
        }
        function Delete_ownerlkp(sender, keyval) {
            document.getElementById('<%= hfdselid.ClientID %>').value = keyval;
            document.getElementById('<%= btnowner.ClientID %>').click();
        }
    </script>
    <script type="text/javascript">
        var dataIn = '';
        var supr = new sagrid();
        supr.url = "../WCFGrid/GridService.svc/Bindcontacts";

        supr.primarykeyval = "contact_id";
        supr.bindid = "grdsupervisordetails";

        supr.objname = "supr";

        function Select_lkp2(sender, keyval) {
            var selperid = supr.resultdata[sender]["Person_ID"];
            var otype = supr.resultdata[sender]["object_type"];
            if (otype == "1")
                parent.window.location.href = '../PersonLicensing/PersonDetails.aspx?perid=' + selperid;
            else
                parent.window.location.href = '../PersonLicensing/Business_Details.aspx?perid=' + selperid;
        }
        function Delete_suprlkp(sender, keyval) {
            document.getElementById('<%= hfdselid.ClientID %>').value = keyval;
            document.getElementById('<%= btnsupervisor.ClientID %>').click();
        }
        function edit_lkp(sender, keyval) {
            document.getElementById('<%=hfdeditid.ClientID%>').value = keyval;
            document.getElementById('<%=btnedit.ClientID%>').click();
        }
    </script>
    <script type="text/javascript">
        var dataIn = '';
        var Supl = new sagrid();
        Supl.url = "../WCFGrid/GridService.svc/Bindcontacts";

        Supl.primarykeyval = "contact_id";
        Supl.bindid = "grdsupplierdetails";

        Supl.objname = "Supl";

        function Select_lkp3(sender, keyval) {
            var selperid = Supl.resultdata[sender]["Person_ID"];
            var otype = Supl.resultdata[sender]["object_type"];
            if (otype == "1")
                parent.window.location.href = '../PersonLicensing/PersonDetails.aspx?perid=' + selperid;
            else
                parent.window.location.href = '../PersonLicensing/Business_Details.aspx?perid=' + selperid;
        }
        function Delete_supllkp(sender, keyval) {
            document.getElementById('<%= hfdselid.ClientID %>').value = keyval;
            document.getElementById('<%= btnsupplier.ClientID %>').click();
        }
        function open_edit(pid) {
            document.getElementById('iframecontact').src = "../PersonLicensing/AddNewContact.aspx?Person_id=" + pid;
            $('#btnaddnew_pop').dialog({ title: "Add New Contact Details", width: '90%' });
            $('#btnaddnew_pop').dialog("open");

            return false;

        }
        function open_NewAddPerson(pid) {
            parent.openaddperson(pid);

            return false;
        }
        function afterpost(msg) {
            $('#btnedit_pop').dialog('close');
            $('#btneditcomment_popup').dialog('close');
            contact.process();
            owner.process();
            supr.process();
            Supl.process();
            desrep.process();
            cmpoff.process();
            keyholder.process();
            agent.process();
            altbox(msg);

        }
        function aftersave() {
            $('#btnaddnew_pop').dialog('close');
            $('#btnaddperson').dialog("close");
            contact.process();
            owner.process();
            supr.process();
            Supl.process();
            desrep.process();
            cmpoff.process();
            keyholder.process();
            parent.aftersave();
        }
        function BacktoSearchpage() {
            $('#btnaddperson').dialog("close");
            var pid = document.getElementById('<%=hfdpid.ClientID %>').value;
            open_edit(pid);
        }
        function Popup() {
            $(function () {
                $('#btnedit_pop').dialog({ title: 'Edit Supervising Pharmacist Details' });
                $('#btnedit_pop').dialog("open");
            });
        }
        function editcomment_lkp(sender, keyval) {
            document.getElementById('<%=hfdeditid.ClientID%>').value = keyval;
            document.getElementById('<%=btneditcomment.ClientID%>').click();
        }
        function EditComments() {
            $(function () {
                $('#btneditcomment_popup').dialog({ title: 'Edit Comments' });
                $('#btneditcomment_popup').dialog("open");
            });
        }
        function ClearComments() {
            document.getElementById('<%=txtcomment.ClientID%>').value = '';
        }
    </script>
    <script type="text/javascript">

        var dataIn = '';
        var desrep = new sagrid();
        desrep.url = "../WCFGrid/GridService.svc/Bindcontacts";

        desrep.primarykeyval = "contact_id";
        desrep.bindid = "grddesignatedrep";

        desrep.objname = "desrep";

        function Select_lkp4(sender, keyval) {
            var selperid = desrep.resultdata[sender]["Person_ID"];
            var otype = desrep.resultdata[sender]["object_type"];

            if (otype == "1")
                parent.window.location.href = '../PersonLicensing/PersonDetails.aspx?perid=' + selperid;
            else
                parent.window.location.href = '../PersonLicensing/Business_Details.aspx?perid=' + selperid;
        }
        function Delete_contactlkp(sender, keyval) {
            document.getElementById('<%= hfdselid.ClientID %>').value = keyval;
            document.getElementById('<%= btncontact.ClientID %>').click();
        }
    </script>
    <script type="text/javascript">

        var dataIn = '';
        var cmpoff = new sagrid();
        cmpoff.url = "../WCFGrid/GridService.svc/Bindcontacts";

        cmpoff.primarykeyval = "contact_id";
        cmpoff.bindid = "grdcmpofficer";

        cmpoff.objname = "cmpoff";

        function Select_lkp5(sender, keyval) {
            var selperid = cmpoff.resultdata[sender]["Person_ID"];
            var otype = cmpoff.resultdata[sender]["object_type"];
            if (otype == "1")
                parent.window.location.href = '../PersonLicensing/PersonDetails.aspx?perid=' + selperid;
            else
                parent.window.location.href = '../PersonLicensing/Business_Details.aspx?perid=' + selperid;
        }
        function Delete_contactlkp(sender, keyval) {
            document.getElementById('<%= hfdselid.ClientID %>').value = keyval;
            document.getElementById('<%= btncontact.ClientID %>').click();
        }
    </script>
    <script type="text/javascript">

        var dataIn = '';
        var keyholder = new sagrid();
        keyholder.url = "../WCFGrid/GridService.svc/Bindcontacts";

        keyholder.primarykeyval = "contact_id";
        keyholder.bindid = "grdkeyholderdetails";

        keyholder.objname = "keyholder";

        function Select_lkp6(sender, keyval) {
            var selperid = keyholder.resultdata[sender]["Person_ID"];
            var otype = keyholder.resultdata[sender]["object_type"];
            if (otype == "1")
                parent.window.location.href = '../PersonLicensing/PersonDetails.aspx?perid=' + selperid;
            else
                parent.window.location.href = '../PersonLicensing/Business_Details.aspx?perid=' + selperid;
        }
        function Delete_contactlkp(sender, keyval) {
            document.getElementById('<%= hfdselid.ClientID %>').value = keyval;
            document.getElementById('<%= btncontact.ClientID %>').click();
        }
    </script>
    <asp:UpdatePanel ID="upd1" runat="server">
        <ContentTemplate>
            <asp:HiddenField ID="hfdpid" runat="server" Value="0" />
            <asp:HiddenField ID="hfdselid" runat="server" Value="0" />
            <asp:HiddenField ID="hfdeditid" runat="server" Value="0" />
            <asp:HiddenField ID="hfdcontacttype" runat="server" Value="0" />
            <asp:Button ID="btndeletecontact" runat="server" Style="display: none" OnClick="btndeletecontact_Click" />
            <asp:Button ID="btncontact" runat="server" Style="display: none" OnClick="btncontact_Click" />
            <asp:Button ID="btnowner" runat="server" Style="display: none" OnClick="btnowner_Click" />
            <asp:Button ID="btnsupervisor" runat="server" Style="display: none" OnClick="btnsupervisor_Click" />
            <asp:Button ID="btnsupplier" runat="server" Style="display: none" OnClick="btnsupplier_Click" />
            <asp:Button ID="btnedit" runat="server" Style="display: none;" OnClick="btnedit_Click" />
            <asp:Button ID="btneditcomment" runat="server" Style="display: none" OnClick="btneditcomment_Click" />
        </ContentTemplate>
    </asp:UpdatePanel>

    <div style="width: 98%; margin-left: auto; margin-right: auto;">
        <div align="right">
            <asp:Button ID="btnaddnew" runat="server" Text="Add New" />
        </div>
        <br />
        <div id="btnaddnew_pop" class="popup" style="display: none;" align="center">
            <iframe id="iframecontact" width="98%" height="300px" frameborder="0"></iframe>
        </div>

        <div class="cpanel">
            <div class="head accr expand">
                Contact Details
            </div>
            <div class="body">
                <div id="grdcontactdetails">
                </div>
            </div>
        </div>
    </div>
    <div style="width: 98%; margin-left: auto; margin-right: auto;">
        <div class="cpanel">
            <div class="head accr expand">
                Agent Details
            </div>
            <div class="body">
                <div id="grdagentdetails">
                </div>
            </div>
        </div>
    </div>
    <div style="width: 98%; margin-left: auto; margin-right: auto;">
        <div class="cpanel">
            <div class="head accr expand">
                Owner Details
            </div>
            <div class="body">
                <div id="grdownerdetails">
                </div>
            </div>
        </div>
    </div>
    <div style="width: 98%; margin-left: auto; margin-right: auto;">
        <div class="cpanel">
            <div class="head accr expand">
                Supervising Pharmacist Details
            </div>
            <div class="body">
                <div id="grdsupervisordetails">
                </div>
            </div>
        </div>
    </div>
      <div style="width: 98%; margin-left: auto; margin-right: auto;">
        <div class="cpanel">
            <div class="head accr expand">
               Key Holder
            </div>
            <div class="body">
                <div id="grdkeyholderdetails">
                </div>
            </div>
        </div>
    </div>
    <div style="width: 98%; margin-left: auto; margin-right: auto;">
        <div class="cpanel">
            <div class="head accr expand">
                Supplier Details
            </div>
            <div class="body">
                <div id="grdsupplierdetails">
                </div>
            </div>
        </div>
    </div>
    <div style="width: 98%; margin-left: auto; margin-right: auto;">
        <div class="cpanel">
            <div class="head accr expand">
                Designated Representative
            </div>
            <div class="body">
                <div id="grddesignatedrep">
                </div>
            </div>
        </div>
    </div>
    <div style="width: 98%; margin-left: auto; margin-right: auto;">
        <div class="cpanel">
            <div class="head accr expand">
                Compliance Officer
            </div>
            <div class="body">
                <div id="grdcmpofficer">
                </div>
            </div>
        </div>
    </div>

    <div id="btnedit_pop" class="popup" style="display: none;">
        <span class="title">Edit Supervising Pharmacist Details</span>
        <asp:UpdatePanel ID="upd2" runat="server">
            <ContentTemplate>
                <table class="spac" align="center">
                    <tr>
                        <td align="right">Start Date 
                        </td>
                        <td align="left">
                            <asp:TextBox ID="txt_startdate" runat="server" CssClass="date" placeholder="Start Date"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">End Date
                        </td>
                        <td align="left">
                            <asp:TextBox ID="txt_enddate" runat="server" CssClass="date" placeholder="End Date"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">Comments
                        </td>
                        <td align="left">
                            <asp:TextBox ID="txt_comments" runat="server" TextMode="MultiLine"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td align="center" colspan="2">
                            <asp:Button ID="btnsubmit" runat="server" Text="Submit" OnClick="btnsubmit_Click" />&nbsp;
                            <asp:Button ID="btnclear" runat="server" Text="Clear" OnClick="btnclear_Click" />
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    <div class="popup" id="btneditcomment_popup" style="display: none">
        <span class="title">Edit Comments</span>
        <asp:UpdatePanel ID="upd4" runat="server">
            <ContentTemplate>
                <table style="width: 100%;">
                    <tr id="ownerdisp" runat="server">
                        <td align="right">Percentage
                        </td>
                        <td align="left">
                            <asp:TextBox ID="txtPercentage" runat="server" ></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">Comment
                        </td>
                        <td align="left">
                            <asp:TextBox ID="txtcomment" runat="server" TextMode="MultiLine"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td align="center" colspan="2">
                            <asp:Button ID="btncommentsubmit" runat="server" Text="Submit" OnClick="btncommentsubmit_Click" />&nbsp;
                            <input type="button" value="Clear" name="cancel" onclick="ClearComments();" />
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    <script type="text/javascript">
        var isedit = $('#ctl00_hfdwrite').val();
        var isdel = $('#ctl00_hfddel').val();
        if (isedit == 'False')
            $('#ctl00_ContentPlaceHolder1_btnaddnew').addClass('hide');
        if (isedit == 'True' && isdel == 'True') {
            contact.cols = [new dcol("Name", "Name"), new dcol("Type", "Type"), new dcol("Address", "Address1"), new dcol("CSZ", "CSZ"), new dcol("Phone", "Phone"), new dcol("Status", "Status"), new dcol("Comments", "Comments"), new dcol("Edit", "", "", "1", "1", "editcomment_lkp", "fa fa-pencil-square-o grdicon"), new dcol("Select", "", "", "1", "1", "Select_lkp", "fa fa-hand-o-up grdicon"), new dcol("Status Change", "", "", "1", "1", "Delete_contactlkp", "fa fa-exchange grdicon"), new dcol("Delete", "", "", "1", "1", "DeleteContact", "fa fa-trash-o grdicon")];
            agent.cols = [new dcol("Name", "Name"), new dcol("Type", "Type"), new dcol("Address", "Address1"), new dcol("CSZ", "CSZ"), new dcol("Phone", "Phone"), new dcol("Status", "Status"), new dcol("Comments", "Comments"), new dcol("Edit", "", "", "1", "1", "editcomment_lkp", "fa fa-pencil-square-o grdicon"), new dcol("Select", "", "", "1", "1", "Select_lkp_agent", "fa fa-hand-o-up grdicon"), new dcol("Status Change", "", "", "1", "1", "Delete_contactlkp", "fa fa-exchange grdicon"), new dcol("Delete", "", "", "1", "1", "DeleteContact", "fa fa-trash-o grdicon")];
            owner.cols = [new dcol("Name", "Name"), new dcol("Type", "Type"), new dcol("Address", "Address1"), new dcol("CSZ", "CSZ"), new dcol("Phone", "Phone"), new dcol("Status", "Status"), new dcol("Comments", "Comments"), new dcol("Percentage", "Percentage"), new dcol("Edit", "", "", "1", "1", "editcomment_lkp", "fa fa-pencil-square-o grdicon"), new dcol("Select", "", "", "1", "1", "Select_lkp1", "fa fa-hand-o-up grdicon"), new dcol("Status Change", "", "", "1", "1", "Delete_ownerlkp", "fa fa-exchange grdicon"), new dcol("Delete", "", "", "1", "1", "DeleteContact", "fa fa-trash-o grdicon")];
            supr.cols = [new dcol("Start Date", "StartDate"), new dcol("End Date", "EndDate"), new dcol("Name", "Name"), new dcol("Type", "Type"), new dcol("Address", "Address1"), new dcol("CSZ", "CSZ"), new dcol("Phone", "Phone"), new dcol("Status", "Status"), new dcol("Comments", "Comments"), new dcol("Edit", "", "", "1", "1", "edit_lkp", "fa fa-pencil-square-o grdicon"), new dcol("Select", "", "", "1", "1", "Select_lkp2", "fa fa-hand-o-up grdicon"), new dcol("Status Change", "", "", "1", "1", "Delete_suprlkp", "fa fa-exchange grdicon"), new dcol("Delete", "", "", "1", "1", "DeleteContact", "fa fa-trash-o grdicon")];
            Supl.cols = [new dcol("Name", "Name"), new dcol("Type", "Type"), new dcol("Address", "Address1"), new dcol("CSZ", "CSZ"), new dcol("Phone", "Phone"), new dcol("Status", "Status"), new dcol("Comments", "Comments"), new dcol("Edit", "", "", "1", "1", "editcomment_lkp", "fa fa-pencil-square-o grdicon"), new dcol("Select", "", "", "1", "1", "Select_lkp3", "fa fa-hand-o-up grdicon"), new dcol("Status Change", "", "", "1", "1", "Delete_supllkp", "fa fa-exchange grdicon"), new dcol("Delete", "", "", "1", "1", "DeleteContact", "fa fa-trash-o grdicon")];
            desrep.cols = [new dcol("Start Date", "StartDate"), new dcol("End Date", "EndDate"), new dcol("Name", "Name"), new dcol("Type", "Type"), new dcol("Address", "Address1"), new dcol("CSZ", "CSZ"), new dcol("Phone", "Phone"), new dcol("Status", "Status"), new dcol("Comments", "Comments"), new dcol("Edit", "", "", "1", "1", "editcomment_lkp", "fa fa-pencil-square-o grdicon"), new dcol("Select", "", "", "1", "1", "Select_lkp4", "fa fa-hand-o-up grdicon"), new dcol("Status Change", "", "", "1", "1", "Delete_contactlkp", "fa fa-exchange grdicon"), new dcol("Delete", "", "", "1", "1", "DeleteContact", "fa fa-trash-o grdicon")];
            cmpoff.cols = [new dcol("Name", "Name"), new dcol("Type", "Type"), new dcol("Address", "Address1"), new dcol("CSZ", "CSZ"), new dcol("Phone", "Phone"), new dcol("Status", "Status"), new dcol("Comments", "Comments"), new dcol("Edit", "", "", "1", "1", "editcomment_lkp", "fa fa-pencil-square-o grdicon"), new dcol("Select", "", "", "1", "1", "Select_lkp5", "fa fa-hand-o-up grdicon"), new dcol("Status Change", "", "", "1", "1", "Delete_contactlkp", "fa fa-exchange grdicon"), new dcol("Delete", "", "", "1", "1", "DeleteContact", "fa fa-trash-o grdicon")];
            keyholder.cols = [new dcol("Name", "Name"), new dcol("Type", "Type"), new dcol("Address", "Address1"), new dcol("CSZ", "CSZ"), new dcol("Phone", "Phone"), new dcol("Status", "Status"), new dcol("Comments", "Comments"), new dcol("Edit", "", "", "1", "1", "editcomment_lkp", "fa fa-pencil-square-o grdicon"), new dcol("Select", "", "", "1", "1", "Select_lkp", "fa fa-hand-o-up grdicon"), new dcol("Status Change", "", "", "1", "1", "Delete_contactlkp", "fa fa-exchange grdicon"), new dcol("Delete", "", "", "1", "1", "DeleteContact", "fa fa-trash-o grdicon")];
        }
        else if (isedit == 'True') {
            contact.cols = [new dcol("Name", "Name"), new dcol("Type", "Type"), new dcol("Address", "Address1"), new dcol("CSZ", "CSZ"), new dcol("Phone", "Phone"), new dcol("Status", "Status"), new dcol("Comments", "Comments"), new dcol("Edit", "", "", "1", "1", "editcomment_lkp", "fa fa-pencil-square-o grdicon"), new dcol("Select", "", "", "1", "1", "Select_lkp", "fa fa-hand-o-up grdicon"), new dcol("Status Change", "", "", "1", "1", "Delete_contactlkp", "fa fa-exchange grdicon")];
            agent.cols = [new dcol("Name", "Name"), new dcol("Type", "Type"), new dcol("Address", "Address1"), new dcol("CSZ", "CSZ"), new dcol("Phone", "Phone"), new dcol("Status", "Status"), new dcol("Comments", "Comments"), new dcol("Edit", "", "", "1", "1", "editcomment_lkp", "fa fa-pencil-square-o grdicon"), new dcol("Select", "", "", "1", "1", "Select_lkp_agent", "fa fa-hand-o-up grdicon"), new dcol("Status Change", "", "", "1", "1", "Delete_contactlkp", "fa fa-exchange grdicon")];

            owner.cols = [new dcol("Name", "Name"), new dcol("Type", "Type"), new dcol("Address", "Address1"), new dcol("CSZ", "CSZ"), new dcol("Phone", "Phone"), new dcol("Status", "Status"), new dcol("Comments", "Comments"), new dcol("Percentage", "Percentage"), new dcol("Edit", "", "", "1", "1", "editcomment_lkp", "fa fa-pencil-square-o grdicon"), new dcol("Select", "", "", "1", "1", "Select_lkp1", "fa fa-hand-o-up grdicon"), new dcol("Status Change", "", "", "1", "1", "Delete_ownerlkp", "fa fa-exchange grdicon")];
            supr.cols = [new dcol("Start Date", "StartDate"), new dcol("End Date", "EndDate"), new dcol("Name", "Name"), new dcol("Type", "Type"), new dcol("Address", "Address1"), new dcol("CSZ", "CSZ"), new dcol("Phone", "Phone"), new dcol("Status", "Status"), new dcol("Comments", "Comments"), new dcol("Edit", "", "", "1", "1", "edit_lkp", "fa fa-pencil-square-o grdicon"), new dcol("Select", "", "", "1", "1", "Select_lkp2", "fa fa-hand-o-up grdicon"), new dcol("Status Change", "", "", "1", "1", "Delete_suprlkp", "fa fa-exchange grdicon")];
            Supl.cols = [new dcol("Name", "Name"), new dcol("Type", "Type"), new dcol("Address", "Address1"), new dcol("CSZ", "CSZ"), new dcol("Phone", "Phone"), new dcol("Status", "Status"), new dcol("Comments", "Comments"), new dcol("Edit", "", "", "1", "1", "editcomment_lkp", "fa fa-pencil-square-o grdicon"), new dcol("Select", "", "", "1", "1", "Select_lkp3", "fa fa-hand-o-up grdicon"), new dcol("Status Change", "", "", "1", "1", "Delete_supllkp", "fa fa-exchange grdicon")];
            desrep.cols = [new dcol("Start Date", "StartDate"), new dcol("End Date", "EndDate"), new dcol("Name", "Name"), new dcol("Type", "Type"), new dcol("Address", "Address1"), new dcol("CSZ", "CSZ"), new dcol("Phone", "Phone"), new dcol("Status", "Status"), new dcol("Comments", "Comments"),  new dcol("Edit", "", "", "1", "1", "editcomment_lkp", "fa fa-pencil-square-o grdicon"), new dcol("Select", "", "", "1", "1", "Select_lkp4", "fa fa-hand-o-up grdicon"), new dcol("Status Change", "", "", "1", "1", "Delete_contactlkp", "fa fa-exchange grdicon")];
            cmpoff.cols = [new dcol("Name", "Name"), new dcol("Type", "Type"), new dcol("Address", "Address1"), new dcol("CSZ", "CSZ"), new dcol("Phone", "Phone"), new dcol("Status", "Status"), new dcol("Comments", "Comments"), new dcol("Edit", "", "", "1", "1", "editcomment_lkp", "fa fa-pencil-square-o grdicon"), new dcol("Select", "", "", "1", "1", "Select_lkp5", "fa fa-hand-o-up grdicon"), new dcol("Status Change", "", "", "1", "1", "Delete_contactlkp", "fa fa-exchange grdicon")];
            keyholder.cols = [new dcol("Name", "Name"), new dcol("Type", "Type"), new dcol("Address", "Address1"), new dcol("CSZ", "CSZ"), new dcol("Phone", "Phone"), new dcol("Status", "Status"), new dcol("Comments", "Comments"), new dcol("Edit", "", "", "1", "1", "editcomment_lkp", "fa fa-pencil-square-o grdicon"), new dcol("Select", "", "", "1", "1", "Select_lkp", "fa fa-hand-o-up grdicon"), new dcol("Status Change", "", "", "1", "1", "Delete_contactlkp", "fa fa-exchange grdicon")];
        }
        else if (isdel == 'True') {
            contact.cols = [new dcol("Name", "Name"), new dcol("Type", "Type"), new dcol("Address", "Address1"), new dcol("CSZ", "CSZ"), new dcol("Phone", "Phone"), new dcol("Status", "Status"), new dcol("Comments", "Comments"), new dcol("Select", "", "", "1", "1", "Select_lkp", "fa fa-hand-o-up grdicon"), new dcol("Delete", "", "", "1", "1", "DeleteContact", "fa fa-trash-o grdicon")];
            agent.cols = [new dcol("Name", "Name"), new dcol("Type", "Type"), new dcol("Address", "Address1"), new dcol("CSZ", "CSZ"), new dcol("Phone", "Phone"), new dcol("Status", "Status"), new dcol("Comments", "Comments"), new dcol("Select", "", "", "1", "1", "Select_lkp_agent", "fa fa-hand-o-up grdicon"), new dcol("Delete", "", "", "1", "1", "DeleteContact", "fa fa-trash-o grdicon")];
            owner.cols = [new dcol("Name", "Name"), new dcol("Type", "Type"), new dcol("Address", "Address1"), new dcol("CSZ", "CSZ"), new dcol("Phone", "Phone"), new dcol("Status", "Status"), new dcol("Comments", "Comments"),new dcol("Percentage", "Percentage"), new dcol("Select", "", "", "1", "1", "Select_lkp1", "fa fa-hand-o-up grdicon"), new dcol("Delete", "", "", "1", "1", "DeleteContact", "fa fa-trash-o grdicon")];
            supr.cols = [new dcol("Start Date", "StartDate"), new dcol("End Date", "EndDate"), new dcol("Name", "Name"), new dcol("Type", "Type"), new dcol("Address", "Address1"), new dcol("CSZ", "CSZ"), new dcol("Phone", "Phone"), new dcol("Status", "Status"), new dcol("Comments", "Comments"), new dcol("Select", "", "", "1", "1", "Select_lkp2", "fa fa-hand-o-up grdicon"), new dcol("Delete", "", "", "1", "1", "DeleteContact", "fa fa-trash-o grdicon")];
            Supl.cols = [new dcol("Name", "Name"), new dcol("Type", "Type"), new dcol("Address", "Address1"), new dcol("CSZ", "CSZ"), new dcol("Phone", "Phone"), new dcol("Status", "Status"), new dcol("Comments", "Comments"), new dcol("Select", "", "", "1", "1", "Select_lkp3", "fa fa-hand-o-up grdicon"), new dcol("Delete", "", "", "1", "1", "DeleteContact", "fa fa-trash-o grdicon")];
            desrep.cols = [new dcol("Start Date", "StartDate"), new dcol("End Date", "EndDate"), new dcol("Name", "Name"), new dcol("Type", "Type"), new dcol("Address", "Address1"), new dcol("CSZ", "CSZ"), new dcol("Phone", "Phone"), new dcol("Status", "Status"), new dcol("Comments", "Comments"),  new dcol("Select", "", "", "1", "1", "Select_lkp4", "fa fa-hand-o-up grdicon"), new dcol("Delete", "", "", "1", "1", "DeleteContact", "fa fa-trash-o grdicon")];
            cmpoff.cols = [new dcol("Name", "Name"), new dcol("Type", "Type"), new dcol("Address", "Address1"), new dcol("CSZ", "CSZ"), new dcol("Phone", "Phone"), new dcol("Status", "Status"), new dcol("Comments", "Comments"), new dcol("Select", "", "", "1", "1", "Select_lkp5", "fa fa-hand-o-up grdicon"), new dcol("Delete", "", "", "1", "1", "DeleteContact", "fa fa-trash-o grdicon")];
            keyholder.cols = [new dcol("Name", "Name"), new dcol("Type", "Type"), new dcol("Address", "Address1"), new dcol("CSZ", "CSZ"), new dcol("Phone", "Phone"), new dcol("Status", "Status"), new dcol("Comments", "Comments"), new dcol("Select", "", "", "1", "1", "Select_lkp", "fa fa-hand-o-up grdicon"), new dcol("Delete", "", "", "1", "1", "DeleteContact", "fa fa-trash-o grdicon")];
        }
        else {
            contact.cols = [new dcol("Name", "Name"), new dcol("Type", "Type"), new dcol("Address", "Address1"), new dcol("CSZ", "CSZ"), new dcol("Phone", "Phone"), new dcol("Status", "Status"), new dcol("Comments", "Comments"), new dcol("Select", "", "", "1", "1", "Select_lkp", "fa fa-hand-o-up grdicon")];
            agent.cols = [new dcol("Name", "Name"), new dcol("Type", "Type"), new dcol("Address", "Address1"), new dcol("CSZ", "CSZ"), new dcol("Phone", "Phone"), new dcol("Status", "Status"), new dcol("Comments", "Comments"), new dcol("Select", "", "", "1", "1", "Select_lkp_agent", "fa fa-hand-o-up grdicon")];
            owner.cols = [new dcol("Name", "Name"), new dcol("Type", "Type"), new dcol("Address", "Address1"), new dcol("CSZ", "CSZ"), new dcol("Phone", "Phone"), new dcol("Status", "Status"), new dcol("Comments", "Comments"),new dcol("Percentage", "Percentage"), new dcol("Select", "", "", "1", "1", "Select_lkp1", "fa fa-hand-o-up grdicon")];
            supr.cols = [new dcol("Start Date", "StartDate"), new dcol("End Date", "EndDate"), new dcol("Name", "Name"), new dcol("Type", "Type"), new dcol("Address", "Address1"), new dcol("CSZ", "CSZ"), new dcol("Phone", "Phone"), new dcol("Status", "Status"), new dcol("Comments", "Comments"), new dcol("Select", "", "", "1", "1", "Select_lkp2", "fa fa-hand-o-up grdicon")];
            Supl.cols = [new dcol("Name", "Name"), new dcol("Type", "Type"), new dcol("Address", "Address1"), new dcol("CSZ", "CSZ"), new dcol("Phone", "Phone"), new dcol("Status", "Status"), new dcol("Comments", "Comments"), new dcol("Select", "", "", "1", "1", "Select_lkp3", "fa fa-hand-o-up grdicon")];
            desrep.cols = [new dcol("Start Date", "StartDate"), new dcol("End Date", "EndDate"), new dcol("Name", "Name"), new dcol("Type", "Type"), new dcol("Address", "Address1"), new dcol("CSZ", "CSZ"), new dcol("Phone", "Phone"), new dcol("Status", "Status"), new dcol("Comments", "Comments"), new dcol("Select", "", "", "1", "1", "Select_lkp4", "fa fa-hand-o-up grdicon")];
            cmpoff.cols = [new dcol("Name", "Name"), new dcol("Type", "Type"), new dcol("Address", "Address1"), new dcol("CSZ", "CSZ"), new dcol("Phone", "Phone"), new dcol("Status", "Status"), new dcol("Comments", "Comments"), new dcol("Select", "", "", "1", "1", "Select_lkp5", "fa fa-hand-o-up grdicon")];
            keyholder.cols = [new dcol("Name", "Name"), new dcol("Type", "Type"), new dcol("Address", "Address1"), new dcol("CSZ", "CSZ"), new dcol("Phone", "Phone"), new dcol("Status", "Status"), new dcol("Comments", "Comments"), new dcol("Select", "", "", "1", "1", "Select_lkp", "fa fa-hand-o-up grdicon")];
        }
    </script>
    <script type="text/javascript">

        var pid1 = '<%= Request.QueryString[0].ToString() %>';

        contact.data = '"objid":"1","pid":"' + pid1 + '"';
        contact.process();
        agent.data = '"objid":"8","pid":"' + pid1 + '"';
        agent.process();
    </script>
    <script type="text/javascript">


        owner.data = '"objid":"2" ,"pid":"' + pid1 + '"';
        owner.process();
    </script>
    <script type="text/javascript">


        supr.data = '"objid":"3","pid":"' + pid1 + '"';
        supr.process();
    </script>
    <script type="text/javascript">


        Supl.data = '"objid":"4","pid":"' + pid1 + '"';
        Supl.process();
    </script>
    <script type="text/javascript">
        desrep.data = '"objid":"5","pid":"' + pid1 + '"';
        desrep.process();
    </script>
    <script type="text/javascript">
        cmpoff.data = '"objid":"6","pid":"' + pid1 + '"';
        cmpoff.process();
    </script>
      <script type="text/javascript">
        keyholder.data = '"objid":"7","pid":"' + pid1 + '"';
        keyholder.process();
    </script>
</asp:Content>
