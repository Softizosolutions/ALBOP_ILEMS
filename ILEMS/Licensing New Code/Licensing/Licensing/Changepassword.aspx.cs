using System;
using System.Configuration;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Net.Mail;
using AdminLinq;

namespace Licensing
{
    public partial class Changepassword : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UID"] == null)
            {
                Response.Redirect("Login.aspx");
            }
        }
        protected void btnlogin_click(object sender, EventArgs e)
        {
            int loginid = Convert.ToInt32(Session["UID"]);
                 List<Tbl_Login> password = GetPassword(loginid);
                 string pass = password[0].Password;
                 string email = password[0].Email;
                 string utype = Session["Utype"].ToString();
                 string currentpassword = FormsAuthentication.HashPasswordForStoringInConfigFile(currpassword.Value, "SHA1");
                 if (pass == currentpassword)
                 {
                     string pwd = FormsAuthentication.HashPasswordForStoringInConfigFile(newpassword.Value, "SHA1");
                     AdminLinq.Admin.Update_Password(loginid, pwd);
                     lblMsg.Text = "Password Changed Sucessfully";
                     Mail.SendMail("", email, "", "Your iLEMS Registration", "Dear " + password[0].FirstName + ' ' + password[0].MiddleName + ' ' + password[0].LastName + ",<br/><br/>Thank you for changing your iLEMS password. Here are your login details: <br/><br/>UserName = "+password[0].UserName+"<br/><br/>Password = "+newpassword.Value+"");
                     Clear();
                     List<Reports.USP_Getlink2displayResult> lst = Reports.Reportgenrator.Getlinks(utype);
                     if (lst.Count > 0)
                         Response.Redirect(lst[0].lnk.Substring(1));
                     else
                         Page.RegisterStartupScript("js", "<script>alert('You Don't Have Access to any page please contact Administrator.');</script>");
                      
                 }
                 else
                 {
                     lblMsg.Text = "Please Enter the Correct Current Pasword";
                 }
        }

        protected void btn_clear_Click(object sender, EventArgs e)
        {
            Clear();
        }
        
        private void  altbox(string str)
        {
            string js = " altbox('" + str + "');parent.rebind_genral();";
            ScriptManager.RegisterStartupScript(Page, GetType(), "scr", js, true);
        }
        protected void lnkforgot_Click(object sender, EventArgs e)
        {
            Response.Redirect("Login.aspx");
        }
        public List<Tbl_Login> GetPassword(int loginid)
        {
            return AdminLinq.Admin.Get_Password(loginid);
        }
        public void Clear()
        {
            currpassword.Value = "";
            newpassword.Value = "";
            cnfnewpassword.Value = "";
        }
    }
    
}