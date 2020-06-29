using ExpertPdf.HtmlToPdf;
using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace Licensing.Prints
{
    public partial class Excel_Emails : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            DataTable dt = new DataTable();
            dt = PersonLicensing.Utilities_Licensing.GetEmailsByLicenseTypes(Request.QueryString[0].ToString(), Request.QueryString[1].ToString());
            Excel.ToExcel(dt, "Emails_Report.xls", this.Response, "Emails Report");
        }
    }
}