using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using System.Collections.Generic;
using System.IO;
using Person_Details;
namespace Licensing.PersonLicensing
{
    public partial class HasPharmacyEmp : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Utilities_Licensing.Bind_LicenseTypes_individual(ddl_lictype);
                Utilities_Licensing.BindDropdown(ddl_licstatus, 14);
                Utilities_Licensing.BindDropdown(ddl_county, 10);
                Utilities_Licensing.BindDropdown(ddl_state, 9);
            }
        }
        protected void btnsubmit_click(object sender, EventArgs e)
        {
            hfdpid.Value = Request.QueryString[0].ToString();
            Person_Details.Licensing_Details.Insert_haspharmacyempDetails(Convert.ToInt32(haspid.Value), hfdpid.Value, hfdrelid.Value, "Current", DateTime.Now.ToShortDateString(), DateTime.Now.ToShortDateString(), Session["UID"].ToString(), Session["UID"].ToString());
            altbox("Record inserted successfully.");
            Clear();
        }
        private void Clear()
        {
            hfdrelid.Value = "0";
            haspid.Value = "0";
        }
        private void altbox(string str)
        {
            string js = " afterpost('" + str + "');";
            ScriptManager.RegisterStartupScript(Page, GetType(), "scr", js, true);
        }
    }
}