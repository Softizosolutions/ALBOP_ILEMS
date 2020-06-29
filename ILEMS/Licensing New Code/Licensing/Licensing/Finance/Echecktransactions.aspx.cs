using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Licensing.Finance
{
    public partial class Echecktransactions : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            hfdtdt.Value = DateTime.Now.ToString("MM/dd/yyyy");
          //grd_div.InnerHtml=  Bpayment.Getallcharges("2019-09-27", "2019-09-29", "");
        }
    }
}