using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Licensing.PersonLicensing
{
    public partial class audithistory : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

                hfdpid.Value = Request.QueryString[0].ToString();

            }
        }
    }
}