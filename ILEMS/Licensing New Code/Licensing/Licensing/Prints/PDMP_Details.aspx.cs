using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using System.Linq;
using System.Collections.Generic;
using System.IO;
using System.Net;
using System.Text;
namespace Licensing.Prints
{
    public partial class PDMP_Details : System.Web.UI.Page
    {
        private int i = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            BindPDMPDetails();
        }
        public string Chknewpg()
        {
            i++;
            if (i % 30 == 0)
            {
                return "</td> </tr></table><div class='newpg'></div><table  cellspacing='0' rules='all' border='1' id='grdpdmp' style='width:95%;border-collapse:collapse;'><tr class='grdheadbg'><td>License #</td><td>Business</td><td>DEA</td><td>Address1</td><td>Address2</td><td>City</td><td>State</td><td>Zip</td><td>Monday_Friday</td><td>Saturday</td><td>Sunday";
            }
         
            return "";
        }
        private void BindPDMPDetails()
        {
            DataTable dt = new DataTable();
            dt = PersonLicensing.Utilities_Licensing.GetPDMPDetails();
            if (dt.Rows.Count > 0)
            {
                grdpdmp.DataSource = dt;
                grdpdmp.DataBind();
            }
        }
    }
}