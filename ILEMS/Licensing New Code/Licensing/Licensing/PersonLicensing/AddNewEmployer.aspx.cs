using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Licensing.PersonLicensing
{
    public partial class AddNewEmployer : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Utilities_Licensing.BindDropdown(ddlcounty, 10);
                Utilities_Licensing.BindDropdown(ddlstate, 9);
                Utilities_Licensing.Bind_LicenseTypes_Business(ddllictype);
                Utilities_Licensing.BindDropdown(ddllicstatus, 14);
            }
        }
        protected void btnsubmit_click(object sender, EventArgs e)
        {
            hfdrelid.Value = Request.QueryString[0].ToString();
            Person_Details.Licensing_Details.Insert_haspharmacyempDetails(0, hfdpid.Value, hfdrelid.Value, "Current", DateTime.Now.ToShortDateString(), DateTime.Now.ToShortDateString(), Session["UID"].ToString(), Session["UID"].ToString());
            altbox("Record inserted successfully.");
        }
        private void altbox(string str)
        {
            string js = " afterpost('" + str + "');";
            ScriptManager.RegisterStartupScript(Page, GetType(), "scr", js, true);
        }
    }
}