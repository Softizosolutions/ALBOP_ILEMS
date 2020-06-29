using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Licensing.PersonLicensing
{
    public partial class DeleteRecords : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btndel_click(object sender, EventArgs e)
        {
            Reports.Reportgenrator.DeleteRecord(hfdauid.Value, ddltype.SelectedValue, Session["Uname"].ToString());
            ScriptManager.RegisterStartupScript(Page, GetType(), "js", "Afterdel()", true);
        }
    }
}