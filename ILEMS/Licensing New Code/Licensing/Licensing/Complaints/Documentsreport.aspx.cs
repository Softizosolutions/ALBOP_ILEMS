using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Licensing.Complaints
{
    public partial class Documentsreport : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Utilities_ComplaintsTAB.BindDropdown(ddl_doctype, 57);
            }
        }
    }
}