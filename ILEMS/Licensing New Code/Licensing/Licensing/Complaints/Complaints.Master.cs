﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Licensing.Complaints
{
    public partial class Complaints : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UID"] == null)
            {
                Response.Redirect("../login.aspx");
            }
            
        }
    }
}