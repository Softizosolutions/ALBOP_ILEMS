using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Licensing.PersonLicensing
{
    public partial class BatchProcess : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                ddlcert.Items.Add(new ListItem("Select", "-1"));
                ddlcert.Items.Add(new ListItem("Consultant", "p12"));
                ddlcert.Items.Add(new ListItem("Nuclear Pharmacist", "p13"));
                ddlcert.Items.Add(new ListItem("Nuclear Pharmacy", "p14"));
                ddlcert.Items.Add(new ListItem("Parenteral Facility", "p15"));
                ddlcert.Items.Add(new ListItem("Parenteral Pharmacist", "p16"));
                ddlcert.Items.Add(new ListItem("Preceptor", "p17"));
                  Utilities_Licensing.Bind_LicenseTypes(ddllictype);
                ddllictype.Items.Insert(0, new ListItem("Select License Type", "-1"));
                ddltypehide.DataSource = Utilities_Licensing.Getprintid();
                ddltypehide.DataTextField = "Print_ID";
                ddltypehide.DataValueField = "LicenseType_ID";
                ddltypehide.DataBind();
            }
        }
        protected void btnupd_click(object sender, EventArgs e)
        {
            string selids = hfdselids.Value;
            Utilities_Licensing.updateprints(selids);
            ScriptManager.RegisterStartupScript(Page, GetType(), "js", " batprint.process();", true);

        }
    }
}