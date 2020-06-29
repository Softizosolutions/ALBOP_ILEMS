using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Licensing
{
    public partial class Createmobtnlh : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                
                    string fname = Request.Form["fname"];
                    string lname = Request.Form["lname"];
                    string pemail = Request.Form["pemail"];
                    //string url =   Request.Form["purl"];
                    AdminLinq.Admin.Insert_monthlyupdate(fname, lname, pemail);
                   // Response.Redirect(url);
                
            }
        }
    }
}