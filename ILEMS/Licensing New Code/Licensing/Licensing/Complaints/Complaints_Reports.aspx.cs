using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Licensing.Reports;

namespace Licensing.Complaints
{
    public partial class Complaints_Reports : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ddlrpt.DataSource = Reportgenrator.Getrpt("select rptname,rptid from tbl_rpt_details  where rpttype like 'C' order by rptname");
                ddlrpt.DataTextField = "rptname";
                ddlrpt.DataValueField = "rptid";
                ddlrpt.DataBind();
                if (ddlrpt.SelectedIndex != -1)
                    ddlrpt_change(null, null);
                chk_lictypes.DataSource = Reportgenrator.GetLicensetype();
                chk_lictypes.DataTextField = "License_Type";
                chk_lictypes.DataValueField = "LicenseType_ID";
                chk_lictypes.DataBind();
                CheckBoxList_SelectedIndexChanged1(null, null);
            }
        }
        protected void ddlrpt_change(object sender, EventArgs e)
        {
          //  if (ddlrpt.SelectedValue == "24")
           // {
             //   ScriptManager.RegisterStartupScript(Page, GetType(), "js", "ComplaintsDataBind()", true);
         //   }
            //else if (ddlrpt.SelectedValue == "25")
            //{
            //    ScriptManager.RegisterStartupScript(Page, GetType(), "js", "ComplaintsDataBind1()", true);
            //}
           // else
          //  {
                DataSet ds = Reportgenrator.Getrpt("select * from  tbl_rpt_details where rptid=" + ddlrpt.SelectedValue);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    hfdquery.Value = ds.Tables[0].Rows[0]["query"].ToString();
                    hfdfltrs.Value = ds.Tables[0].Rows[0]["fltrs"].ToString();
                    hfdcols.Value = ds.Tables[0].Rows[0]["ordby"].ToString();
                }
                ScriptManager.RegisterStartupScript(Page, GetType(), "js", "afterbind()", true);
            //}
        }

        protected void btngenerate_Click(object sender, EventArgs e)
        {

        }

        protected void btngenerate_Click1(object sender, EventArgs e)
        {
            string lictypes = "";
            for (int i = 0; i <= chk_lictypes.Items.Count - 1; i++)
            {
                if (chk_lictypes.Items[i].Selected)
                {
                    if (lictypes == "")
                    {
                        lictypes = chk_lictypes.Items[i].Value;
                    }
                    else
                    {
                        lictypes += "," + chk_lictypes.Items[i].Value;
                    }
                }
            }
            string js = "BindData('" + lictypes + "')";
            ScriptManager.RegisterStartupScript(Page, GetType(), "scr", js, true);
        }
        protected void CheckBoxList_SelectedIndexChanged1(object sender, EventArgs e)
        {
            for (int i = 0; i < chk_lictypes.Items.Count; i++)
            {
                if (!chk_lictypes.Items[i].Selected)
                {
                    chk_lictypes.Items[i].Selected = true;
                }
            }
        }
    }
}