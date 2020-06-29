using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;
using System.Security.Cryptography;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using System.Web.Security;
using AdminLinq;

namespace Licensing
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btnlogin_click(object sender, EventArgs e)
        {
            string pass = FormsAuthentication.HashPasswordForStoringInConfigFile(password.Value.Trim(), "SHA1");
            List<Tbl_Login> odvLogin = Authenticateuser(username.Value, pass);

            if (odvLogin.Count > 0)
            {
                Session["UID"] = odvLogin[0].loginID;
                Session["Utype"] = odvLogin[0].UserType;
                Session["Uname"] = odvLogin[0].LastName + " " + odvLogin[0].FirstName;
                Session["UEmail"] = odvLogin[0].Email;
                string utype = Session["Utype"].ToString();
                if (odvLogin[0].IsTemp == "1")
                {
                    Response.Redirect("Changepassword.aspx");
                }
                else
                {
                    List<Reports.USP_Getlink2displayResult> lst = Reports.Reportgenrator.Getlinks(utype);
                    if (lst.Count > 0)
                        Response.Redirect(lst[0].lnk.Substring(1));
                    else
                        Page.RegisterStartupScript("js", "<script>alert('You Don't Have Access to any page please contact Administrator.');</script>");
                }
            }
            else
            {
                lblMsg.Text = "Invalid Username/Password";
            }
        }
        public List<Tbl_Login> Authenticateuser(string username, string password)
        {
            return AdminLinq.Admin.Get_UserandPassword(username, password);
        }
        private void testmethod()
        {
            //test method anil
        }

        protected void lnkforgot_Click(object sender, EventArgs e)
        {
            Response.Redirect("Forgotpassword.aspx");
        }
        private void alert(string str)
        {
            string js = "alert('" + str + "');parent.rebind_genral();";
            ScriptManager.RegisterStartupScript(Page, GetType(), "scr", js, true);
            //test
        }
    }
}