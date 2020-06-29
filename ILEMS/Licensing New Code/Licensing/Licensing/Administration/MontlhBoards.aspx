<%@ Page Language="C#" MasterPageFile="~/Administration/Admin.Master" AutoEventWireup="true" CodeBehind="MontlhBoards.aspx.cs" Inherits="Licensing.Administration.MontlhBoards" %>
<asp:Content ID="cnt" ContentPlaceHolderID="cntmain" runat="server">
   
    <script type="text/javascript">

       
           var dataIn = '';
           var sa5 = new sagrid();
           sa5.url = "../WCFGrid/GridService.svc/Getmonthlyupdates";
        
           sa5.primarykeyval = "auid";
           sa5.bindid = "grd";
           sa5.cols = [new dcol("First Name", "FirstName"), new dcol("Last Name", "LastName"), new dcol("Email", "Email"), new dcol("Submission Date", "Submission"), new dcol("Delete", "", "", "1", "1", "Delete_lkp", "fa fa-trash-o grdicon")];
           sa5.objname = "sa5";
           sa5.data = dataIn;
           sa5.process();
          
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
              
               altbox(msg);
              
           }
      </script>


    
  



 <asp:UpdatePanel ID="upd" runat="server" >
 <ContentTemplate>
 
  <asp:HiddenField ID="hfdselid" runat="server" Value="0" />
  
     <asp:Button ID="btndel" runat="server" style="display:none" OnClick="btndel_click" />
  </ContentTemplate>
 </asp:UpdatePanel>
    
      
 <div class="cpanel">
 <div class="head">
       Monthly Board Update
       
 
       </div>
      
      <div class="body">
            

<div id="grd"></div>
      </div>
 
 </div>

    




   
         
    </asp:Content>