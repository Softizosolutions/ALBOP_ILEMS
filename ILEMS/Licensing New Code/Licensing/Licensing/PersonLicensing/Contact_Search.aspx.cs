using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Licensing.PersonLicensing
{
    public partial class Contact_Search : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Utilities_Licensing.BindDropdown(ddlstate, 9);
                Utilities_Licensing.BindDropdown(ddlcounty, 10);
            }
        }
    }
}