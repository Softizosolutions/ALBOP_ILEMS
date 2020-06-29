<%@ Page Language="C#" MasterPageFile="~/Administration/Admin.Master" AutoEventWireup="true" CodeBehind="ts.aspx.cs" Inherits="Licensing.Administration.ts" %>
<asp:Content ID="cnt" ContentPlaceHolderID="cntmain" runat="server">
   <div class="cpanel">
 <div class="head">
      Time Sheet Details
      
       </div>
      
      <div class="body">
          <asp:UpdatePanel ID="updemp" runat="server">
              <ContentTemplate>

                  <asp:HiddenField ID="hfdsdt" runat="server" />
                  <asp:HiddenField ID="hfdedt" runat="server" />
             <table class="spac" width="90%" align="center">
                 <tr>
                     <td align="right">Select Employee : </td>
                     <td align="left">
                         <asp:DropDownList ID="ddlemp" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlemp_change"></asp:DropDownList>
                     </td>
                     <td align="right">
                         Select Week :
                     </td>
                     <td align="left">
                          <table>
                                        <tr>
                                            <td>
                                                <asp:DropDownList ID="ddlweek" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlweek_change"></asp:DropDownList>

                                            </td>
                                            <td>
                                                <asp:LinkButton ID="lnkprev" runat="server" Visible="false" OnClick="btnprev_clic" CssClass="fa fa-arrow-left"></asp:LinkButton>

                                            </td>
                                            <td>
                                                <asp:LinkButton ID="lnknext" runat="server" Visible="false" OnClick="btnnxt_clic" CssClass="fa fa-arrow-right"></asp:LinkButton>


                                            </td>
                                            
                                        </tr>
                                    </table>
                      
                     </td>
                 </tr>
             </table>
                  <br />
                   <asp:DataList ID="dtls" runat="server" RepeatColumns="7" Width="90%" Style="margin-left: auto; margin-right: auto" RepeatDirection="Horizontal">
                                <ItemTemplate>
                                    <table width="100%" class="gridmain">
                                        <tr>

                                            <td class="grdheadbg">
                                                <%# Eval("weekname")%>
                                            </td>
                                        </tr>
                                        <tr>

                                            <td class="grdalt">
                                                <%# Eval("seldt") %>
                                            </td>
                                        </tr>
                                        <tr>

                                            <td class="grditem" align="center">Working HRS :
                                                             <asp:TextBox ID="txtwrk_hrs" Width="90%" runat="server" Style="margin: 5px;" CssClass="decimal" Text='<%# Eval("wrk_hrs").ToString() %>'></asp:TextBox>
                                                 <asp:HiddenField ID="hfddt" runat="server" Value='<%# Eval("seldt").ToString() %>' />
                                              
                                            </td>
                                        </tr>
                                        <tr>

                                            <td class="grditem" align="center">Annual HRS :
                                                             <asp:TextBox ID="txtannhual_hrs" Width="90%" runat="server" Style="margin: 5px;" CssClass="decimal" Text='<%# Eval("annhual_hrs").ToString() %>'></asp:TextBox>
                                                
                                            </td>
                                        </tr>
                                         <tr>

                                            <td class="grditem" align="center">Sick HRS :
                                                             <asp:TextBox ID="txtsick_hrs" Width="90%" runat="server" Style="margin: 5px;" CssClass="decimal" Text='<%# Eval("sick_hrs").ToString() %>'></asp:TextBox>
                                                
                                            </td>
                                        </tr>
                                         <tr>

                                            <td class="grditem" align="center">Holiday HRS :
                                                             <asp:TextBox ID="txthold_hrs" Width="90%" runat="server" Style="margin: 5px;" CssClass="decimal" Text='<%# Eval("hold_hrs").ToString() %>'></asp:TextBox>
                                                 
                                            </td>
                                        </tr>
                                         <tr>

                                            <td class="grditem" align="center">Comp HRS :
                                                             <asp:TextBox ID="txtcomp_hrs" Width="90%" runat="server" Style="margin: 5px;" CssClass="decimal" Text='<%# Eval("comp_hrs").ToString() %>'></asp:TextBox>
                                              
                                            </td>
                                        </tr>
                                         <tr>

                                            <td class="grditem" align="center">Other HRS :
                                                             <asp:TextBox ID="txtoth_hrs" Width="90%" runat="server" Style="margin: 5px;" CssClass="decimal" Text='<%# Eval("oth_hrs").ToString() %>'></asp:TextBox>
                                               
                                            </td>
                                        </tr>
                                         <tr>

                                            <td class="grditem" align="center">Location :
                                                             <asp:TextBox ID="txt_loc" Width="90%" runat="server" Style="margin: 5px;"   Text='<%# Eval("Location_wrk").ToString() %>'></asp:TextBox>
                                               
                                            </td>
                                        </tr>

                                    </table>


                                </ItemTemplate>
                            </asp:DataList>
                  <br />
                  <center>
                      <asp:Button ID="btnsave" runat="server" Text="Save Time Sheet" Visible="false" OnClick="btnsave_click" />
                        <asp:Button ID="btnapprove" runat="server" Text="Approve Time Sheet" Visible="false"  />
                  </center>
                  </ContentTemplate>
          </asp:UpdatePanel>
      </div>
 
 </div>
  
</asp:Content>