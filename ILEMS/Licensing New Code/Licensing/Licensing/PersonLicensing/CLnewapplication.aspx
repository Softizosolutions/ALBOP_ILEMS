<%@ Page Language="C#" MasterPageFile="../Master Page/frm.master" AutoEventWireup="true" CodeBehind="CLnewapplication.aspx.cs" Inherits="Licensing.PersonLicensing.CLnewapplication" %>

<asp:Content ID="cnt1" runat="server" ContentPlaceHolderID="ContentPlaceHolder1">
    <script type="text/javascript">
        function checkval(cnt) {
            if (cnt == 0) {
                
                parent.hidetab();
            }
            else
                $('#makecomplete_pop').dialog("close");
        }
        function Popup() {
            $('#makecomplete_pop').dialog({ title: "Make Complete" });
            $('#makecomplete_pop').dialog("open");
        }
    </script>
    <script language="javascript">
        function chekall(ctl,tid) {
            var selval = ctl.checked;
           
            $('#' + '<%= grdchkitems_list.ClientID %>').find('.cmp :radio').each(function () {
                if (tid == 1)
                    this.checked = selval;
                else
                    this.checked = false;

            });
            $('#' + '<%= grdchkitems_list.ClientID %>').find('.incmp :radio').each(function () {
                if (tid == 2)
                    this.checked = selval;
                else
                    this.checked = false;

            });
            $('#' + '<%= grdchkitems_list.ClientID %>').find('.nav :radio').each(function () {
                if (tid == 4)
                    this.checked = selval;
                else
                    this.checked = false;

            });
            $('#' + '<%= grdchkitems_list.ClientID %>').find('.wav :radio').each(function () {
                if (tid == 3)
                    this.checked = selval;
                else
                    this.checked = false;

            });
            validatemake();
        }
        function rdb_change(ctl) {
            if (ctl.checked == true) {
                $(ctl).closest('tr').find(':radio').each(function () {
                    if (ctl != this) {
                        this.checked = false;
                    }
                }); 
            }
            validatemake();
        }
        function rdb_changecomparison(ctl) {
            if (ctl.checked == true) {
                var id = ctl.id;
                for (var i = 0; i < 5; i++)
                    if (id + "_" + [i].checked == true)
                        document.getElementById("Buttonmake1").style.display = 'block';
                    else
                        document.getElementById("Buttonmake1").style.display = 'none';
            }
        }
        function afterpost(msg) {
           
            $('#makecomplete_pop').dialog('close');
            altbox(msg);

        }
    </script>
    
    <div>

         <asp:UpdatePanel ID="upd" runat="server" >
       <ContentTemplate>
       <asp:HiddenField ID="hfd_user" runat="server" Value="0"/>
        <div style="text-align: center">
         <br />
        <div style="font-family:Calibri;font-size:10pt">Select Application Type &nbsp; <asp:DropDownList ID="ddlpenapp" runat="server" style="width:200px" AutoPostBack="true" OnSelectedIndexChanged="ddlap_chng" ></asp:DropDownList> </div>
           <br />
             <table style="width:100%" class="spac" id="tablepersonrespnsible" runat="server">
                        <tr>
                            <td align="right" style="width:47%">
                                Person Responsible
                            </td>
                            <td align="left">
                                <asp:DropDownList ID="ddl_users" runat="server"></asp:DropDownList>&nbsp;&nbsp;&nbsp;
                                <asp:Button ID="btnnotify" runat="server" Text="Notify" OnClick="btnnotify_Click"/>
                            </td>
                           
                        </tr>
                    </table>
            <asp:GridView ID="grdchkitems_list" CssClass="gridmain" runat="server" AutoGenerateColumns="false" Width="90%" BorderWidth="1">
                <RowStyle CssClass="grditem" />
                <AlternatingRowStyle CssClass="grdalt" />
                <HeaderStyle CssClass="grdheadbg" />
                <Columns>

                    <asp:TemplateField HeaderText="">
                        <ItemTemplate>
                            <%# Eval("Checklistitem")%>
                            <%--  <asp:HiddenField ID="hfd_result" runat="server" Value='<%# Eval("Result") %>' />--%>
                            <asp:HiddenField ID="hfd_chkid" runat="server" Value='<%# Eval("app_chk_id").ToString() %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                    <HeaderTemplate>
                    <center>
                     <asp:CheckBox ID="rdlall1" runat="server" Text="&nbsp;Complete" onclick="javascript:return chekall(this,1)"/>
                    </center>
                    </HeaderTemplate>
                        <ItemTemplate>
                            <asp:RadioButton ID="rdb1" CssClass="cmp" Checked='<%# getrdb("1",Eval("Result").ToString()) %>'   onclick="javascript:rdb_change(this)" runat="server" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField >
                       <HeaderTemplate>
                    <center>
                     <asp:CheckBox ID="rdlall2" runat="server" Text="&nbsp;Incomplete" onclick="javascript:return chekall(this,2)"/>
                    </center>
                    </HeaderTemplate>
                        <ItemTemplate>
                            <asp:RadioButton ID="rdb2" CssClass="incmp" Checked='<%# getrdb("0",Eval("Result").ToString()) %>' onclick="javascript:rdb_change(this)" runat="server" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField >
                       <HeaderTemplate>
                    <center>
                     <asp:CheckBox ID="rdlall3" runat="server" Text="&nbsp;Waived" onclick="javascript:return chekall(this,3)"/>
                    </center>
                    </HeaderTemplate>
                        <ItemTemplate>
                            <asp:RadioButton ID="rdb3" CssClass="wav" Checked='<%# getrdb("2",Eval("Result").ToString()) %>' onclick="javascript:rdb_change(this)" runat="server" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField >
                      <HeaderTemplate>
                    <center>
                     <asp:CheckBox ID="rdlall4" runat="server" Text="&nbsp;N/A" onclick="javascript:return chekall(this,4)"/>
                    </center>
                    </HeaderTemplate>
                        <ItemTemplate>
                            <asp:RadioButton ID="rdb4" CssClass="nav" Checked='<%# getrdb("3",Eval("Result").ToString()) %>' onclick="javascript:rdb_change(this)" runat="server" />

                            <asp:HiddenField ID="hfdid1" runat="server" Value='<%# Eval("License_checklist_id") %>' />

                            <asp:HiddenField ID="hfdrequired" runat="server" Value='<%# Eval("Isrequired") %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>


            <br />
            <center>
                <table cellpadding="0" cellspacing="0" border="0" width="50%" align="center">
                <tr>
                    <td align="center" width="18%">
                        <div style="text-align: center; padding-right: 10px; margin-top: 0px">
                        <asp:Button ID="btn_save" runat="server" Text="Save" OnClick="Insert_Chkitems" />&nbsp;
                        <asp:Button ID="makecomplete" runat="server"  Text="Make Complete"  OnClick="Buttonmake1_click" />
                        
                            </div>
                    </td>


                </tr>
            </table>
            </center>
            
            <br />
        </div>
           </ContentTemplate>
             </asp:UpdatePanel>

        <div id='makecomplete_pop' class="popup" style="display: none;">
        <asp:UpdatePanel ID="upd1" runat="server">
        <ContentTemplate>
        
        
            <span class="title">License Number Information</span>
            <table align="center" cellpadding="5" cellspacing="5">

                <tr>
                    <td align="right" width="35%">License Number
                    </td>
                    <td align="left">
                        <asp:TextBox ID="txtlicno" ReadOnly="true" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td align="right">Issue Date</td>
                    <td align="left">
                        <asp:TextBox ID="txtissuedate" Width="100" ReadOnly="true"   runat="server"></asp:TextBox>
                    </td>
                </tr>

                <tr>
                    <td align="right">Expiration Date</td>
                    <td align="left">

                        <asp:TextBox ID="txtExpirationDate" CssClass="date" runat="server"></asp:TextBox>


                    </td>
                </tr>
                <tr>
                    <td align="center" colspan="2">
                        <asp:Button ID="btn_submit" runat="server" Text="Submit" OnClick="btnok_Click" />

                    </td>
                </tr>
            </table>
            </ContentTemplate>
        </asp:UpdatePanel>
        </div>

<script>
    function aftersave() {
        altbox('Saved Successfully.');
        validatemake();
    }
    function validatemake() {
        var trs = $('#' + '<%= grdchkitems_list.ClientID %>').find('tr');
        var cnt = trs.length;
        var chk = 0;
        for (var i = 1; i < trs.length; i++) {

            $(trs[i]).find(':radio').each(function () {
            
                if (this.checked && this.id.indexOf('rdb2') <0)
                    chk = chk + 1;
            });
        }
       
        cnt = cnt - 1;
        if (chk == cnt)
            $('#'+'<%= makecomplete.ClientID %>').attr("style" , "display:inline-block");
        else
            $('#' + '<%= makecomplete.ClientID %>').attr("style", "display:none");
    }
    validatemake();
</script>

    </div>
</asp:Content>
