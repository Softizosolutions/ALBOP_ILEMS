<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="test.ascx.cs" Inherits="Licensing.PersonLicensing.test" %>
 <table style="width: 100%;">
                <tr>
                    <td align="right">
                        <div style="text-align: right; padding-right: 10px; margin-top: -20px">
                            <input type="button" id="btnnew" value="Add New" class="poptrg" />
                        </div>
                        <div id='btnnew_pop' class="popup" style="display: none;">
                            <span class="title">Add New Document</span>
                            <table align="center" cellpadding="5" cellspacing="5">

                                <tr>
                                    <td align="right" width="35%">Cabinet :
                                    </td>
                                    <td align="left">
                                        <asp:DropDownList ID="ddl_cabinet" runat="server" class="required">
                                        </asp:DropDownList>
                                        <asp:HiddenField ID="hfd_docid" runat="server" Value="0" />
                                        <asp:HiddenField ID="hfdpid" runat="server" Value="0" />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">Folder :
                                    </td>
                                    <td align="left">
                                        <asp:DropDownList ID="ddl_folder" runat="server" class="required">
                                        </asp:DropDownList>

                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">Upload :
                                    </td>
                                    <td align="left">
                                        <asp:FileUpload ID="upddocument" runat="server" class="required"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">Date :
                                    </td>
                                    <td align="left">
                                       <asp:TextBox ID="txt_date" runat="server" class="required date"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">Doc Type :
                                    </td>
                                    <td align="left">
                                        <asp:DropDownList ID="ddl_doctype" runat="server" class="required">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">Notes :
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="txt_notes" runat="server" TextMode="MultiLine" class="required"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center" colspan="2"><asp:CheckBox ID="chk_approval" runat="server" Text="Approval Needed" />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center" colspan="2">
                                        <asp:Button ID="btn_submit" runat="server" Text="Submit"   />
                                        <asp:Button ID="btn_clear" runat="server" Text="Button"   />
                                    </td>
                                </tr>
                             </table>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td align="center">
                        <asp:GridView ID="grddocumnet" runat="server" AutoGenerateColumns="false" Width="90%" CssClass="gridmain" >
                            <RowStyle CssClass="grditem" />
                            <AlternatingRowStyle CssClass="grdalt" />
                            <HeaderStyle CssClass="grdheadbg" />
                            <Columns>
                                <asp:TemplateField HeaderText="Date">
                                    <ItemTemplate>
                                        <asp:HiddenField ID="hfddocid" runat="server" Value='<%# Eval("Document_ID").ToString() %>' />
                                        <asp:Label ID="lbldate" runat="server" Text='<%#  (Eval("Document_Date").ToString()) %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Document Type">
                                    <ItemTemplate>
                                        <asp:Label ID="lbldoctype" runat="server" Text='<%#Eval("Values").ToString() %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Notes">
                                    <ItemTemplate>
                                        <asp:Label ID="lblnotes" runat="server" Text='<%#Eval("Description").ToString() %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="User">
                                    <ItemTemplate>
                                        <asp:Label ID="lbluser" runat="server" Text='<%#Eval("UserName").ToString() %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Edit" HeaderStyle-Width="50px" ItemStyle-Width="50px">
                                    <ItemTemplate>
                                        <asp:Button ID="btnedit" runat="server" Text="&#xf044;" CommandName="Edit" Class="grdicon" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Delete" HeaderStyle-Width="50px" ItemStyle-Width="50px">
                                    <ItemTemplate>
                                        <asp:Button ID="btndelete" runat="server" Text="Delete" CommandName="Delete" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </td>
                </tr>
            </table>