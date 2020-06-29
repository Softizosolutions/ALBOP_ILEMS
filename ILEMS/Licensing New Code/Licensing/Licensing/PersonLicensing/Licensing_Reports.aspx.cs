using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Licensing.Reports;

namespace Licensing.PersonLicensing
{
    public partial class Licensing_Reports : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ddlrpt.DataSource = Reportgenrator.Getrpt("select rptname,rptid from tbl_rpt_details  where rpttype like 'L' order by rptname");
                ddlrpt.DataTextField = "rptname";
                ddlrpt.DataValueField = "rptid";
                ddlrpt.DataBind();
                if (ddlrpt.SelectedIndex != -1)
                    ddlrpt_change(null, null);
            }
        }
        protected void ddlrpt_change(object sender, EventArgs e)
        {
            DataSet ds = Reportgenrator.Getrpt("select * from  tbl_rpt_details where rptid=" + ddlrpt.SelectedValue);
            if (ds.Tables[0].Rows.Count > 0)
            {
                hfdquery.Value = ds.Tables[0].Rows[0]["query"].ToString();
                hfdfltrs.Value = ds.Tables[0].Rows[0]["fltrs"].ToString();
                hfdcols.Value = ds.Tables[0].Rows[0]["ordby"].ToString();
            }
            ScriptManager.RegisterStartupScript(Page, GetType(), "js", "afterbind()", true);
        }
    }
}