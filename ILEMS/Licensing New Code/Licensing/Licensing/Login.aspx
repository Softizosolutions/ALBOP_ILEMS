<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Licensing.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head id="Head1" runat="server">
    <meta charset="UTF-8" />
    <link href="Styles/style.css" rel="stylesheet" />
    <link href="Styles/css/font-awesome.css" rel="stylesheet" />
    <link href="Styles/css/font-awesome.min.css" rel="stylesheet" />
    <title>Login Form Test</title>
     <style type="text/css">
         .user { position: relative; }
.user input { text-indent: 20px;}
.user .fa-user { 
  position: absolute;
  top: 13px;
  left: 7px;
  font-size: 23px;
}
 .pass { position: relative; }
.pass input { text-indent: 20px;}
.pass .fa-lock { 
  position: absolute;
  top: 15px;
  left: 7px;
  font-size: 23px;
}
     </style>
      <script type="text/javascript">
          function Login_Validation() {
              if (document.getElementById("username").value == "") {
                  alert("Please Enter the UserName.");
                  document.getElementById("username").focus()
                  return false;
              }
              if (document.getElementById("password").value == "") {
                  alert("Please Enter the Password");
                  document.getElementById("password").focus()
                  return false;
              }
              return true;
          }
    </script>
</head>
<body>



    <div style="height: 80px"></div>
    <div id="login">
        

        <div style="text-align: center">
            <h1>Regulatory Licensing
            <br />
                &
                <br />
                Enforcement Management 1</h1>
        </div>
        <form id="form1" runat="server">
            <div class="user">
                  <span class="fa fa-user"></span>
            <input type="text" id="username" placeholder="UserName"  runat="server"/>
            </div>
           <div class="pass">
               <span class="fa fa-lock"></span>
                <input type="password" id="password"  placeholder="Password" runat="server" />
           </div>
           
            	<asp:Button ID="btnsubmit" runat="server" Text="Login" OnClick="btnlogin_click" Height="50px" Width="100%" />
           
        <%--    <input type="submit" value="Log in" />--%>
            
         
              <footer class="clearfix">
              <div style="text-align:center">
                <asp:Label ID="lblMsg" runat="server" style="font-size:11pt;color:rgb(217, 5, 0);"></asp:Label>
           </div>
          <p style="text-align:center"><span class="info">?</span>
              <asp:LinkButton ID="lnkforgot" runat="server" Text="Forgot Password" OnClick="lnkforgot_Click"></asp:LinkButton>
             </p>
                
        </footer>
      
        <div style="position:relative;z-index:0;font-size:7pt;text-align:center;width:100%">Copyrights © 2015 & All Rights Reserved by iGovSolutions, LLC.</div>
        </form>

    </div>
</body>
</html>

