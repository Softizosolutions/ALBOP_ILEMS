using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Licensing.Master_Page
{
    public partial class Main : System.Web.UI.MasterPage
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
                    menu.InnerHtml = menu.InnerHtml + "  <li id='"+obj.Menucsid+"' class='treeview'>    <a href='#'>";
                    menu.InnerHtml = menu.InnerHtml +"<i class='fa  "+obj.Mclass+"'></i> <span>"+obj.Menu_Name+"</span> <i class='fa fa-angle-left pull-right'></i></a>";
                    menu.InnerHtml = menu.InnerHtml + Getsublink(utype,obj.Menu_ID) + "</li>";
                }
            }
        }
        public string Getsublink(string utype,int mid)
        {
            string sublst = "   <ul class='treeview-menu'>";
            List<Reports.USP_Getsublink2displayResult> slst = Reports.Reportgenrator.Getsublinks(utype, mid.ToString());
            foreach (Reports.USP_Getsublink2displayResult obj in slst)
            {
                 sublst = sublst + "  <li><a href='"+obj.lnk+"'><i class='fa fa-circle-o'></i>"+obj.Sub_Menu_Name+"</a></li>";
            }
            sublst = sublst + "</ul>";
            return sublst;
        }
    }
}