using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Licensing.PersonLicensing
{
    public partial class Paymenthistory : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
               
                hfdpid.Value = Request.QueryString[0].ToString();
                Utilities_Licensing.BindDropdown(ddlvoidres, 31);
            }
        }
        protected void void_trans(object sender, EventArgs e)
        {
            Licensing.Finance.Accounting_Utilities.Voidtransaction(hfdselrecid.Value, ddlvoidres.SelectedValue);
            ddlvoidres.SelectedValue = "-1";
            ScriptManager.RegisterStartupScript(Page, GetType(), "js", "aftervoid()", true);
        }
       
    }
}