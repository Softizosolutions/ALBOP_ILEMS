using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ComplaintsLink;
using Licensing.Complaints;
namespace Licensing.Dashboard
{
    public partial class Dashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
                utilities.Fill_Dropdown(ddlperres, "tbl_Login Order by LastName", "LastName+' '+FirstName", "loginID", " ", "Select Person Responsible");
             
        }
    }
}