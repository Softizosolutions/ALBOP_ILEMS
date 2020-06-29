<%@ Page Title="" Language="C#" MasterPageFile="~/Master Page/frm.Master" AutoEventWireup="true" CodeBehind="Complaints_Investigation.aspx.cs" Inherits="Licensing.Complaints.Complaints_Investigation" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">




     <div  id="cntwin1" style="width:98%;margin-left:auto;margin-right:auto;">
   
               
                                            
           
                                         <asp:Button ID="Button26" runat="server" Text="Print Investigation Summary" />
                                  
                                         <fieldset id="fieldset3" runat="server">
                                             <legend>Summary Of Complaint</legend>
                                             <table style="width:100%;">
                                                 <tr>
                                                     <td align="center">
                                                        <%-- <CKEditor:CKEditorControl ID="txtstatementcharges" ToolbarStartupExpanded="false" runat="server"   Height="200" Width="80%" BasePath="~/ckeditor"> </CKEditor:CKEditorControl>--%>
                                                         <asp:TextBox ID="txtcomplaint" runat="server" TextMode="MultiLine" Height="200" Width="80%"></asp:TextBox>
                                                     </td>
                                                 </tr>
                                                 <tr><td>&nbsp;</td></tr>
                                                 <tr>
                                                     <td style="text-align:center;">
                                                      <asp:Button ID="Button27" runat="server" Text="Submit" />&nbsp;&nbsp;
                                                         <asp:Button ID="Button28" runat="server" Text="Clear" />
                                                     </td>
                                                 </tr>
                                             </table>
                                         </fieldset>
                                    
         
         </div>
         












</asp:Content>
