using System;
using System.Collections;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Web;
using System.Web.SessionState;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Web.Security;

namespace Licensing
{
    public partial class LogOff : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Session.RemoveAll();
            Session.Abandon();
            Session.Clear();
            FormsAuthentication.SignOut();
            Response.Redirect("Login.aspx"); 
        }
    }
}