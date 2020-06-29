using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Licensing.Complaints
{
    public partial class Complaint_Documnets : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                hfdcompid.Value = Request.QueryString[0].ToString();
                hfdpid.Value = Request.QueryString[1].ToString();
            }
        }
    }
}