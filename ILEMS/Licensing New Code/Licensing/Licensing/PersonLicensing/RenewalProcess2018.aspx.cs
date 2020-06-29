using Licensing.PersonLicensing;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Licensing
{
    public partial class RenewalProcess2018 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Utilities_Licensing.Bind_LicenseTypes(ddlrenewaltype);
                ddlrenewaltype.Items.Insert(0, new ListItem("Select License Type", "-1"));
                Utilities_Licensing.BindDropdown(ddlrenewalstatus, 60);
                Utilities_Licensing.BindPrintpages(ddl_Printpages); 
                var rlink= System.Configuration.ConfigurationManager.AppSettings["renewallink"].ToString();
                hfdurl.Value = rlink+"\\Renewal\\Renewalprint.aspx";// System.Configuration.ConfigurationManager.AppSettings["onlinetechnicianrenewal"].ToString();
            }
        }
        protected void btnupdateprint_click(object sender, EventArgs e)
        {
            try
            {
                Utilities_Licensing.updateprint(hfdselorderid.Value);
                hfdselorderid.Value = "";
            }
            catch(Exception ex)
            {
                Response.Write(ex.ToString());
            }
        }
        protected void btnsubmit_Click(object sender, EventArgs e)
        {
            string[] svals = hfdorderid.Value.Split(',');
            foreach(string t in svals)
            Utilities_Licensing.processrenewal2018(t, ddlrenewalstatus.SelectedValue, txtrenewaldate.Text, txtcomments.Text, Session["UID"].ToString());
             
            altbox("Record inserted successfully.");

        }
        private void altbox(string str)
        {
            string js = " afterpost('" + str + "');";
            ScriptManager.RegisterStartupScript(Page, GetType(), "scr", js, true);
        }
    }
}