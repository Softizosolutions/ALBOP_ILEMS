using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Licensing.PersonLicensing
{
    public partial class Person : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["iscmp"] != null)
                hfdcmp.Value = "1";
            if (Session["UID"] == null)
            {
                Response.Redirect("../login.aspx");
              
            }
            
        }
    }
}