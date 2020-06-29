using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Licensing.Administration
{
    public partial class UpdateRespondent : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btnsubmit_Click(object sender, EventArgs e)
        {
            PersonLicensing.Utilities_Licensing.UpdateRespondentIDS(txt_complaintnmber.Text, Convert.ToInt32(txt_newrespondentid.Text));
            string js = "AfterUpdate();";
            ScriptManager.RegisterStartupScript(Page, GetType(), "scr", js, true);
        }

    }
}