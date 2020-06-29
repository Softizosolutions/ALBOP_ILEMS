using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using ExpertPdf.HtmlToPdf;
using System.IO;
using System.Web.UI.HtmlControls;
using System;
using System.Linq;

namespace Licensing.Reports
{
    public partial class view_rpt : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ddlrpt.DataSource = Reportgenrator.Getrpt("select rptname,rptid from tbl_rpt_details  where rpttype like 'R' order by rptname");
                ddlrpt.DataTextField = "rptname";
                ddlrpt.DataValueField = "rptid";
                ddlrpt.DataBind();
                if (ddlrpt.SelectedIndex != -1)
                    ddlrpt_change(null, null);

                chklicensetypes.DataSource = Reportgenrator.GetLicensetype();
                chklicensetypes.DataTextField = "License_Type";
                chklicensetypes.DataValueField = "LicenseType_ID";
                chklicensetypes.DataBind();

                ddl_county.DataSource = Person_Details.Licensing_Details.Get_Lkp_tablesdata(10);
                ddl_county.DataValueField = "Lkp_data_ID";
                ddl_county.DataTextField = "Values";
                ddl_county.DataBind();
                ddl_county.Items.Insert(0, new ListItem("All", "-1"));
                var items = from ListItem li in ddl_county.Items
                            where li.Text.Contains("All")
                            select li;
                foreach (ListItem li in items)
                    li.Selected = true;
            }
        }
        protected void ddlrpt_change(object sender, EventArgs e)
        {
            if (ddlrpt.SelectedValue != "22")
            {
                chklicensetypes.Visible = false;
                btngenerate.Visible = false;
                lblcounty.Visible = false;
                ddl_county.Visible = false;
                DataSet ds = Reportgenrator.Getrpt("select * from  tbl_rpt_details where rptid=" + ddlrpt.SelectedValue);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    hfdquery.Value = ds.Tables[0].Rows[0]["query"].ToString();
                    hfdfltrs.Value = ds.Tables[0].Rows[0]["fltrs"].ToString();
                    hfdcols.Value = ds.Tables[0].Rows[0]["ordby"].ToString();
                }
                ScriptManager.RegisterStartupScript(Page, GetType(), "js", "afterbind()", true);
            }
            else
            {
                lblcounty.Visible = true;
                ddl_county.Visible = true;
                chklicensetypes.Visible = true;
                btngenerate.Visible = true;
                ScriptManager.RegisterStartupScript(Page, GetType(), "js", "HideDivandResultPanel()", true);
            }
        }
        protected void btngenerate_Click(object sender, EventArgs e)
        {
            string lictypes = ""; string county = "";
            for (int i = 0; i <= chklicensetypes.Items.Count - 1; i++)
            {
                if (chklicensetypes.Items[i].Selected)
                {
                    if (lictypes == "")
                    {
                        lictypes = chklicensetypes.Items[i].Value;
                    }
                    else
                    {
                        lictypes += "," + chklicensetypes.Items[i].Value;
                    }
                }
            }
            for (int i = 0; i < ddl_county.Items.Count - 1; i++)
            {
                if (ddl_county.Items[i].Selected)
                {
                    if (county == "")
                        county = ddl_county.Items[i].Value;
                    else
                        county += "," + ddl_county.Items[i].Value;
                }
            }

            string js = "GetExcelDocumentLink('" + lictypes + "','" + county + "')";
            ScriptManager.RegisterStartupScript(Page, GetType(), "scr", js, true);

        }
    }
}