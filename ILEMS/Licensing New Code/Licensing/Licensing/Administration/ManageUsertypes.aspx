<%@ Page Language="C#" MasterPageFile="~/Administration/Admin.Master" AutoEventWireup="true" CodeBehind="ManageUsertypes.aspx.cs" Inherits="Licensing.Administration.ManageUsertypes" %>

<asp:Content ID="cnt" ContentPlaceHolderID="cntmain" runat="server">
    <script type="text/javascript">
        function afterpost(msg) {

            altbox(msg);

        }
    </script>

    <div class="cpanel">
        <div class="head">
            Manage User Types
        </div>
        <div class="body">
            <asp:UpdatePanel ID="upd" runat="server">
                <ContentTemplate>

                    <table style="margin-left: auto; margin-right: auto; margin-bottom: 10px" class="spac">
                        <tr>
                            <td>Select User Type &nbsp;
                                <asp:DropDownList ID="ddl_usetype" runat="server" AutoPostBack="true" OnSelectedIndexChanged="Bind_lst"></asp:DropDownList>
                                <asp:Button ID="btnsave" runat="server" Visible="false" Text="Save" OnClick="btnsave_cick" />
                            </td>
                        </tr>
                    </table>
                    <asp:DataList ID="ddlmusers" Width="90%" runat="server" Style="margin-left: auto; margin-right: auto" CellPadding="0" CellSpacing="0">
                        <ItemTemplate>
                            <div class="grdheadbg" style="padding: 10px" id='<%# Eval("Menucsid").ToString() %>'><%# Eval("Menu_Name").ToString()%></div>
                            <asp:HiddenField ID="hfdmid" runat="server" Value='<%# Eval("Menu_ID").ToString() %>' />

                            <asp:DataList ID="ddlsub" Width="100%" CssClass="gridmain1" runat="server" DataSource='<%# Bindsub(Eval("Menu_ID").ToString()) %>'>
                                <ItemTemplate>
                                    <asp:CheckBox ID="chbslst" Checked='<%# Eval("selval") %>' Style="cursor: pointer" runat="server" Text='<%# "&nbsp;"+ Eval("Sub_Menu_Name").ToString() %>' />
                                    <asp:HiddenField ID="hfdmid" runat="server" Value='<%# Eval("Menu_ID").ToString() %>' />

                                    <asp:HiddenField ID="hfdsid" runat="server" Value='<%# Eval("Sub_Menu_ID").ToString() %>' />
                                    <asp:HiddenField ID="hfdauid" runat="server" Value='<%# Eval("auid").ToString() %>' />

                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Left" />
                            </asp:DataList>

                        </ItemTemplate>
                        <ItemStyle VerticalAlign="Top" />
                    </asp:DataList>
                    <div style="width: 90%; margin-left: auto; margin-right: auto; margin-top: 10px">
                        <div id="headgrd" runat="server" visible="false" class="grdheadbg" style="text-align: center">&nbsp;&nbsp;Select Tabs To Access </div>

                        <asp:DataList ID="ddltabinfo" runat="server" CssClass="grditem" Width="100%" CellPadding="0" CellSpacing="0" BorderWidth="1" BorderColor="Black">
                            <ItemTemplate>
                                <table border="1" cellpadding="0" cellspacing="0" width="100%">
                                    <tr>
                                        <td colspan="2" align="center" style="background: #c6ecff">
                                            <b><%# "&nbsp;"+ Eval("tabname").ToString() %></b>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center">
                                            <asp:CheckBox ID="chbsel" Checked='<%# Eval("selval") %>' runat="server" Text="Read" />
                                        </td>
                                        <td align="center">
                                            <asp:CheckBox ID="chbwrite" Checked='<%# Eval("Iswrite") %>' runat="server" Text="Write" />
                                        </td>

                                    </tr>
                                    <tr>
                                        <td align="center" colspan="2">
                                            <asp:CheckBox id="chbdelete" Checked='<%#Eval("Isdelete") %>' runat="server" Text="Delete" />
                                        </td>
                                    </tr>
                                </table>

                                <asp:HiddenField ID="hfdtabid" runat="server" Value='<%# Eval("tabid").ToString() %>' />
                                <asp:HiddenField ID="hfdauid" runat="server" Value='<%# Eval("auid").ToString() %>' />

                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" Height="20px" VerticalAlign="Middle" />
                        </asp:DataList>
                    </div>

                    <div style="width: 90%; margin-left: auto; margin-right: auto; margin-top: 10px">
                        <div id="headdoc" runat="server" visible="false" class="grdheadbg" style="text-align: center">&nbsp;&nbsp;  </div>

                        <asp:DataList ID="dtdoclst" runat="server" CssClass="grditem" Width="100%" CellPadding="0" CellSpacing="0" BorderWidth="1" BorderColor="Black" RepeatColumns="4">
                            <ItemTemplate>
                                <asp:CheckBox ID="chbsel" Checked='<%# Eval("selval") %>' runat="server" Text='<%# "&nbsp;"+ Eval("doctype").ToString() %>' />
                                <asp:HiddenField ID="hfddocid" runat="server" Value='<%# Eval("Lkp_data_ID").ToString() %>' />
                                <asp:HiddenField ID="hfdauid" runat="server" Value='<%# Eval("auid").ToString() %>' />

                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" Height="20px" VerticalAlign="Middle" />
                        </asp:DataList>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </div>
</asp:Content>
