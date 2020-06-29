<%@ Page Language="C#" MasterPageFile="~/Administration/Admin.Master" AutoEventWireup="true" CodeBehind="Manage_users.aspx.cs" Inherits="Licensing.Administration.manageusers" %>
<asp:Content ID="cnt" ContentPlaceHolderID="cntmain" runat="server">
   
  
       <script type="text/javascript">

       
           var dataIn = '';
           var sa5 = new sagrid();
           sa5.url = "../WCFGrid/GridService.svc/ManageUsers";
        
           sa5.primarykeyval = "loginID";
           sa5.bindid = "grdusers";
           sa5.cols = [new dcol("First Name", "FirstName"), new dcol("Last Name", "LastName"), new dcol("User Name", "UserName"), new dcol("Last Login", "LastLogin"), new dcol("Active", "isstatus"), new dcol("Email", "Email"), new dcol("Expiry Date", "ExpireDate"), new dcol("Edit", "", "", "1", "1", "edit_lkp", "fa fa-pencil-square-o grdicon"), new dcol("Delete", "", "", "1", "1", "Delete_lkp", "fa fa-trash-o grdicon")];
           sa5.objname = "sa5";
           sa5.data = dataIn;
           sa5.process();
           function edit_lkp(sender, keyval) {
            
               document.getElementById('<%= hfdselid.ClientID %>').value = keyval;
               document.getElementById('<%= btnedit.ClientID %>').click();
           }
           function cnffnres(result) {
           if(result=='true')
               document.getElementById('<%= btndel.ClientID %>').click();
           }

           function Delete_lkp(sender, keyval) {
               document.getElementById('<%= hfdselid.ClientID %>').value = keyval;
               cnfbox(" Are you sure do you want to delete this record?", "cnffnres");
           }

           function afterpost(msg) {
               sa5.process();
               $('#btnnew_pop').dialog('close');
               altbox(msg);
              
           }
      </script>


    <script type="text/javascript">
        function Save_Validation() 
        {
            var errormsg = validateform('frmfld');
            if (errormsg != "") {
                Msgbox(errormsg);
                return false;
            }
            if (document.getElementById('<%=txt_email.ClientID%>').value != document.getElementById('<%=txt_confirmEmail.ClientID%>').value) {
                altbox("Email and confirmation email is not same.");
                document.getElementById('<%=txt_confirmEmail.ClientID%>').focus()
                return false;
            }
            if (document.getElementById('<%=txt_password.ClientID%>').value != document.getElementById('<%=txt_confirmpassword.ClientID%>').value) {
                altbox("Password and confirm password is not same.");
                document.getElementById('<%=txt_confirmpassword.ClientID%>').focus()
                return false;
            }
             var pswd = document.getElementById('<%=txt_password.ClientID%>').value;
            if (pswd.length < 8) {
                altbox("Password length should be minimum 8 charachters.");
                return false;
            }
            else
                if (!pswd.match(/[A-Z]/)) {
                    altbox("Password Must contain at least one (1) uppercase character.");
                    return false;
                } else
                    if (!pswd.match(/[a-z]/)) {
                        altbox("Password Must contain at least one (1) lowercase character.");
                        return false;
                    } else
                        if (!pswd.match(/([0-9])/) && !pswd.match(/([!,%,&,@,#,$,^,*,?,_,~])/)) {
                            altbox("Password Must contain at least one (1) number or symbol character.");
                            return false;
                        }
                        else
                            if (pswd.match(/([a-z])\1/) || pswd.match(/([0-9])\1/)) {
                                altbox("Password Must not repeat any character sequentially.");
                                return false;
                            }
                            else
                                if (pswd.toUpperCase().indexOf(fname) != -1 || (pswd.toUpperCase().indexOf(mname) != -1 && mname != '') || pswd.toUpperCase().indexOf(lname) != -1) {
                                    altbox("Password cannot contain the users name. (first, middle, last names).");
                                    return false;
                                }
            return true; 
        }
             
    </script>
 <script type="text/javascript" language"javascript">
     function clear_exam()
     {
            document.getElementById('<%= txt_Firstname.ClientID %>').value = '';
             document.getElementById('<%= hfdautoid.ClientID %>').value = '0';
        document.getElementById('<%= txt_middlename.ClientID %>').value = '';
        document.getElementById('<%= txt_Lastname.ClientID %>').value = '';
        document.getElementById('<%= ddl_suffix.ClientID %>').value = '-1';
        document.getElementById('<%= txt_email.ClientID %>').value = '';
        document.getElementById('<%= chk_active.ClientID %>').checked = false;
        document.getElementById('<%= txt_confirmEmail.ClientID %>').value = '';
        document.getElementById('<%= txt_expdate.ClientID %>').value = '';
        document.getElementById('<%= txt_username.ClientID %>').value = '';
        document.getElementById('<%= ddl_usetype.ClientID %>').value = '-1';
        
        return false;
 }


     function popup()
     {


         $(function () { $('#btnnew_pop').dialog({title:"Edit User Information"}); $('#btnnew_pop').dialog("open"); });
        
     }

   
 </script>



 <asp:UpdatePanel ID="upd" runat="server" >
 <ContentTemplate>
 
  <asp:HiddenField ID="hfdselid" runat="server" Value="0" />
   <asp:Button ID="btnedit" runat="server" style="display:none" OnClick="btnedit_click" />
     <asp:Button ID="btndel" runat="server" style="display:none" OnClick="btndel_click" />
  </ContentTemplate>
 </asp:UpdatePanel>
    
      
 <div class="cpanel">
 <div class="head">
       Manage Users 
       <a  id="btnnew" class="poptrg" onclick="javascript:return clear_exam();">New user</a>
        
 
       </div>
      
      <div class="body">
            

<div id="grdusers"></div>
      </div>
 
 </div>

    




   
           <div id='btnnew_pop' class="popup" style="display: none;">
   <span class="title">New User Information</span>
 <asp:UpdatePanel ID="upd1" runat="server">
       <ContentTemplate>

         <table width="100%" id="frmfld">
                            <tr>
                                <td align="right">
                                    First Name
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txt_Firstname" runat="server" CssClass="required" placeholder="First Name" error="Please enter first name."></asp:TextBox>
                                      <asp:HiddenField ID="hfdautoid" runat="server" Value="0" />
                                </td>
                                <td align="right" >
                                    Middle Name
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txt_middlename" runat="server" placeholder="Middle Name"  ></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                   Last Name
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txt_Lastname" runat="server" CssClass="required" placeholder="Last Name" error="Please enter last name."></asp:TextBox>
                                </td>
                                <td align="right">
                                    Suffix
                                </td>
                                <td align="left">
                                    <asp:DropDownList ID="ddl_suffix" runat="server" >
                                
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                  Email
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txt_email" runat="server" CssClass="required email" placeholder="Email" error="Please enter email."></asp:TextBox>
                                </td>
                               
                                <td align="right">
                                Confirm Email
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txt_confirmEmail" runat="server" CssClass="required confirmemail" placeholder="Confirm Email" error="Please enter confirm email."></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                             <td align="right">
                                    Status
                                </td>
                                <td align="left">
                                    <asp:CheckBox ID="chk_active" runat="server" Text="Active" Checked="false" />
                                </td>
                               
                                 <td align="right">
                                    Expiration Date
                                </td>
                                <td align="left">
                                   <asp:TextBox ID="txt_expdate" runat="server" class="date"></asp:TextBox>
                                </td>
                            </tr>
                         <tr>
                                <td align="right">
                                 User Name
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txt_username" runat="server" CssClass="required" placeholder="User Name" error="Please enter user name."></asp:TextBox>
                                </td>
                                
                                  <td align="right" >
                                    User Type
                                </td>
                                <td align="left" >
                                    <asp:DropDownList ID="ddl_usetype" runat="server"   CssClass="required" error="Please select user type.">
                                   
                                    
                                    </asp:DropDownList>
                                </td>
                               
                               
                               
                            </tr>
                       <tr>
                                <td align="right" >
                                    Password
                                </td>
                                <td align="left" >
                                   <asp:TextBox ID="txt_password" runat="server" TextMode="Password" CssClass="required" placeholder="Password" error="Please enter password."></asp:TextBox>
                                </td>
                              
                                <td align="right">
                                    Confirm Password
                                </td>
                                   <td align="left" >
                                       <asp:TextBox ID="txt_confirmpassword" runat="server" TextMode="Password" CssClass="required" placeholder="Confirm Password" error="Please enter confirm password."></asp:TextBox>
                                   </td>
                               </tr>
                               
                               
                           
                            <tr>
                               
                                <td colspan="4" align="center">
                                <asp:Button ID="btn_submit" runat="server" Text="Submit" OnClick="btn_submit_Click" OnClientClick="javascript:return Save_Validation();"/>
                              &nbsp; &nbsp; &nbsp;
                                    <asp:Button ID="btn_Clear" runat="server" Text="Clear" OnClick="btn_Clear_Click" />
                                   
                                </td>
                            </tr>
                        </table>

   </ContentTemplate>
   </asp:UpdatePanel>

   </div>
    

           
           
</asp:Content>