using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Licensing.Master_Page
{
    public partial class frm : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["iswrite"] != null)
                    hfdwrite.Value = Request.QueryString["iswrite"].ToString();
                if (Request.QueryString["isdel"] != null)
                    hfddel.Value = Request.QueryString["isdel"].ToString();
            }
        }
    }
}