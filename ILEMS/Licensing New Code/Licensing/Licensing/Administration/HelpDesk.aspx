<%@ Page Title="" Language="C#" MasterPageFile="~/Master Page/frm.Master" AutoEventWireup="true" CodeBehind="HelpDesk.aspx.cs" Inherits="Licensing.HelpDesk" %>
<%@ Register Assembly="CKEditor.NET" Namespace="CKEditor.NET" TagPrefix="CKEditor" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">



    
      <script type="text/javascript">
          function Save_Validation() {
              var errormsg = validateform('frmhelp');
              var dlen = CKEDITOR.instances['ctl00_ContentPlaceHolder1_txtDescr'].getData().replace(/<[^>]*>/gi, '').length;
              if (dlen == 0)
                  errormsg = errormsg + '<li>Please enter Description</li>';
              if (errormsg != "") {
                  Msgbox(errormsg);
                  return false;
              }
              return true;
          }
          function afterpost(msg) {

              parent.closedesk(msg);

          }
          function showtypes() {
              var txtmsg = "Following is the description for each type:<br/> ";
              txtmsg += "<ul><li>Problem - any problem with respect to functionality in the page.</li><br/>";
              txtmsg = txtmsg + "<li>Question - any question you might have about the application in general.</li><br/>";
              txtmsg = txtmsg + "<li>User Error - user error on input or any aspect within the application.</li></ul>";
              Helpbox(txtmsg);
          }
    </script>
     
 
  <div class="cbody">
      
    <asp:UpdatePanel ID="upd1" runat="server">
        <ContentTemplate>
            <asp:HiddenField ID="hfdlic" runat="server" Value="0" />
            <asp:HiddenField ID="hfdimgdata" runat="server"  value="" />
               <asp:HiddenField ID="hfdcurl" runat="server"  value="" />
            <table align="center" class="spac" width="100%" id="frmhelp" cellpadding="5" cellspacing="5" >
                    <tr>
                        <td align="right" >Subject
                        </td>
                        <td align="left" colspan="5" >
                           <asp:TextBox ID="txtSubject" Columns="40" runat="server" placeholder="Subject"  class="required" error="Please enter subject." MaxLength="90" Width="500px"></asp:TextBox>
                        </td>
                   <td rowspan="5" colspan="3">
                       <img id="imgsrc" width="300px" height="200px" />
                   </td>
                    </tr>
                    <tr>
                        <td align="right" >First Name
                        </td>
                        <td align="left" colspan="5" >
                           <asp:TextBox ID="txtFirst" runat="server" MaxLength="90" Width="500px" placeholder="First Name"  class="required" error="Please enter your first name."></asp:TextBox>
                        </td>
                   
                    </tr>
                    <tr>
                        <td align="right" >Last Name
                        </td>
                        <td align="left" colspan="5" >
                           <asp:TextBox ID="txtLast" runat="server" MaxLength="90" Width="500px" placeholder="Last Name"  class="required" error="Please enter your last name."></asp:TextBox>
                        </td>
                   
                    </tr>
                    <tr>
                        <td align="right" >Email
                        </td>
                        <td align="left" colspan="5" >
                           <asp:TextBox ID="txtEmail" runat="server" MaxLength="90" Width="500px" placeholder="Email"  class="required" error="Please enter your email address."></asp:TextBox>
                        </td>
                   
                    </tr>
                    <tr>
                        <td align="right">Type 
                        </td>
                        <td align="left" style="width:50%;">
                            <asp:DropDownList ID="ddl_cattype" runat="server" class="required" error="Please select a category.">
                                <asp:ListItem Value="-1">Select Type</asp:ListItem>
                                <asp:ListItem Text="1">Problem</asp:ListItem>
                                <asp:ListItem Text="2">Question</asp:ListItem>
                                 <asp:ListItem Text="3">User Error</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                        <td align="left" colspan="4" >
                            <a href="javascript:showtypes();">?Help</a>
                        </td>                  
                    </tr>
                    <tr>
                        <td align="right" >Description
                        </td>
                        <td align="left" colspan="8" >
                                <CKEditor:CKEditorControl ID="txtDescr" 
                                        Toolbar="Bold|Italic|Underline|Strike|-|Subscript|Superscript|NumberedList|BulletedList|-|Outdent|Indent/Styles|Format|Font|FontSize|TextColor|BGColor|Table|JustifyLeft|JustifyCenter|JustifyRight/Link|Unlink|Anchor" 
                                        ToolbarStartupExpanded="true" Width="100%" runat="server" BasePath="~/ckeditor"> 
                                </CKEditor:CKEditorControl>
                        </td>
                    </tr>
<%--                    <tr>
                        <td align="right" >Description text
                        </td>
                        <td align="left" colspan="8"  >
                           <asp:TextBox ID="txtDescr" Columns="80" runat="server" placeholder="enter Description here" class="required" error="Please enter descr." Width="700px" Rows="10" TextMode="MultiLine" Height="200px">  </asp:TextBox>
                        </td>
                    </tr>--%>

                     <tr>
                        <td align="right" >Upload file
                        </td>
                        <td align="left" colspan="5" >
                          <asp:UpdatePanel runat="server" ID="updatepanel2">
                              <Triggers><asp:PostBackTrigger ControlID="btn_submit" /></Triggers>
                              <ContentTemplate>
                            <asp:FileUpload ID="FileUpload1" runat="server" /><i class="fa fa-paperclip"></i>&nbsp; Attach Document
                              </ContentTemplate>
                          </asp:UpdatePanel>
                        </td>
                   
                    </tr>
                 
                    <tr>
                        <td colspan="6" align="center">
                            <asp:Button ID="btn_submit" runat="server" Text="Submit" OnClick="btn_submit_Click"  OnClientClick="javascript:return Save_Validation();"/>&nbsp;&nbsp;&nbsp;
                            <asp:Button ID="btn_Clear" runat="server" Text="Clear" OnClick="btn_Clear_Click"  />
                        </td>
                    </tr>
                </table>

        </ContentTemplate>
    </asp:UpdatePanel>
       
        <asp:UpdatePanel ID="upd" runat="server">
        <ContentTemplate>
       
     <asp:HiddenField ID="hfdselid" runat="server" Value="0" />

    </ContentTemplate>
        </asp:UpdatePanel>
        </div>
       
    <script>
        $('#imgsrc').attr("src", parent.idata);
        $('#' + '<%= hfdimgdata.ClientID %>').val(parent.idata);
        $('#' + '<%= hfdcurl.ClientID %>').val(parent.curl);
    </script>
</asp:Content>
