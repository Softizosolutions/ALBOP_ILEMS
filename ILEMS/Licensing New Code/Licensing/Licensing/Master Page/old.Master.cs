using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Licensing.Master_Page
{
    public partial class old : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UID"] == null)
            {
                Response.Redirect("../login.aspx");
            }

            if (!IsPostBack)
            {
                ldluname.Text = Session["Uname"].ToString();
                string utype = Session["Utype"].ToString();
                List<Reports.USP_Getlink2displayResult> lst = Reports.Reportgenrator.Getlinks(utype);
                foreach (Reports.USP_Getlink2displayResult obj in lst)
                {
                    menu.InnerHtml = menu.InnerHtml + "<div  id='" + obj.Menucsid + "'><a href='" + obj.lnk + "'>" + obj.Menu_Name + "</a> </div>";
                }
            }


        }
    }
}