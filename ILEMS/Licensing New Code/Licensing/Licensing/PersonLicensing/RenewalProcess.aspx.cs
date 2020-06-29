using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Licensing.PersonLicensing
{
    public partial class RenewalProcess : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Utilities_Licensing.Bind_LicenseTypes(ddlrenewaltype);
                ddlrenewaltype.Items.Insert(0, new ListItem("Select License Type", "-1"));
                Utilities_Licensing.BindDropdown(ddlrenewalstatus, 60);
                Utilities_Licensing.BindPrintpages(ddl_Printpages);
                hfdurl.Value = System.Configuration.ConfigurationManager.AppSettings["onlinetechnicianrenewal"].ToString();
            }
        }
         
        protected void btnsubmit_Click(object sender, EventArgs e)
        {
            
                Online.onlinedb.Save_Renewalprocess(0, hfdorderid.Value, ddlrenewalstatus.SelectedValue, txtrenewaldate.Text, txtcomments.Text, Session["UID"].ToString());
                altbox("Record inserted successfully.");
            
        }
        private void altbox(string str)
        {
            string js = " afterpost('" + str + "');";
            ScriptManager.RegisterStartupScript(Page, GetType(), "scr", js, true);
        }
    }
}