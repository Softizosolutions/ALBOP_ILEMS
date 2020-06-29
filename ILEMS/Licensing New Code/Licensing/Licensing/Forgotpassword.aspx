<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Forgotpassword.aspx.cs" Inherits="Licensing.Forgotpassword" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head id="Head1" runat="server">
    <meta charset="UTF-8" />
    <link href="Styles/style.css" rel="stylesheet" />
     <link href="Styles/css/font-awesome.css" rel="stylesheet" />
    <link href="Styles/css/font-awesome.min.css" rel="stylesheet" />
    <title>Forgot Password</title>
      <style type="text/css">
         .user { position: relative; }
.user input { text-indent: 20px;}
.user .fa-user { 
  position: absolute;
  top: 13px;
  left: 7px;
  font-size: 23px;
}
          </style>
</head>
<body>



    <div style="height: 80px"></div>
    <div id="login">


        <div style="text-align: center">
            <h1>Regulatory Licensing<br />
                &
                <br />
                Enforcement Management</h1>
        </div>
        <form id="form1" runat="server">

            <span>Enter your username in the box below and click submit. A temporary password with your username will be sent to the email address on file. If you don't receive an email contact your system administrator.</span>
            <div style="height: 30px"></div>
            <div class="user">
                  <span class="fa fa-user"></span>
            <input type="text" id="username" placeholder="UserName"  runat="server"/>
            </div>
            <div></div>
            <div></div>

            <asp:Button ID="btnsubmit" runat="server" Text="Submit" OnClick="btnsubmit_Click" Height="50px" Width="100%"/>

            <footer class="clearfix">
                <div style="text-align: center">
                    <asp:Label ID="lblerr" runat="server" Style="font-size: 11pt; color: rgb(217, 5, 0);"></asp:Label>
                </div>
                <p style="text-align: center">
                    <asp:LinkButton ID="lnkforgot" runat="server" Text="Back to Login" OnClick="bck_lgn_Click"></asp:LinkButton>
                </p>

            </footer>


        </form>

    </div>
</body>
</html>
