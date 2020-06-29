using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Licensing.PersonLicensing
{
    public partial class Merge : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btnsubmit_Click(object sender, EventArgs e)
        {
            Utilities_Licensing.UpdateRecords(txtfrom.Text, txtto.Text);
            string js = "altbox('Records updated successfully.');";
            ScriptManager.RegisterStartupScript(Page, GetType(), "scr", js, true);
            txtfrom.Text = "";
            txtto.Text = "";
        }
    }
}