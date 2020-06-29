using Licensing.PersonLicensing;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Licensing.Administration
{
    public partial class ts : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                Utilities_Licensing.Fill_Dropdown(ddlemp, "Tbl_Login where isstatus='true'", "FirstName+' '+LastName", "loginID", "", "select User");
            }
        }
        private void set_buttons()
        {
            if (ddlweek.Items.Count == 0)
            {
                lnknext.Visible = false;
                lnkprev.Visible = false;

            }
            else
            if (ddlweek.SelectedIndex == 0)
            {
                lnkprev.Visible = true;
                lnknext.Visible = false;
            }
            else
                if (ddlweek.SelectedIndex == ddlweek.Items.Count - 1)
            {
                lnkprev.Visible = false;
                lnknext.Visible = true;
            }
            else
            {
                lnknext.Visible = true;
                lnkprev.Visible = true;
            }
        }
        protected void btnnxt_clic(object sender, EventArgs e)
        {
            ddlweek.SelectedIndex = ddlweek.SelectedIndex - 1;
            ddlweek_change(null, null);
        }
        protected void btnprev_clic(object sender, EventArgs e)
        {
            ddlweek.SelectedIndex = ddlweek.SelectedIndex + 1;
            ddlweek_change(null, null);
        }
        protected void btnsave_click(object sender, EventArgs e)
        {
            foreach (DataListItem gvr in dtls.Items)
            {
                string empid = ddlemp.SelectedValue;
                string dt = ((HiddenField)gvr.FindControl("hfddt")).Value;
                string wrk = ((TextBox)gvr.FindControl("txtwrk_hrs")).Text;
                string annual = ((TextBox)gvr.FindControl("txtannhual_hrs")).Text;
                string sick = ((TextBox)gvr.FindControl("txtsick_hrs")).Text;
                string hold = ((TextBox)gvr.FindControl("txthold_hrs")).Text;
                string comp = ((TextBox)gvr.FindControl("txtcomp_hrs")).Text;
                string oth = ((TextBox)gvr.FindControl("txtoth_hrs")).Text;
                string loc = ((TextBox)gvr.FindControl("txt_loc")).Text;
                Person_Details.Licensing_Details.save_ts(dt, empid, wrk, annual, sick, hold, comp, oth, loc);
            }
            ScriptManager.RegisterStartupScript(Page, GetType(), "js", "altbox('Time Sheet Saved.')", true);
            // Page.RegisterStartupScript("js", "<script language='javascript'>alert('Time Sheet Saved.');</script>");
        }
        protected void ddlweek_change(object sender,EventArgs e)
        {
            set_buttons();
            if (ddlweek.SelectedIndex > 0)
            {
               
                string[] vals = ddlweek.SelectedValue.Split('-');
                DataSet ds = Utilities_Licensing.Getweek_days(vals[0], vals[1], ddlemp.SelectedValue);

                dtls.DataSource = ds;
                dtls.DataBind();
                btnsave.Visible = true;
                btnapprove.Visible = true;
            }
            else
            {
                btnsave.Visible = false;
                btnapprove.Visible = false;
                dtls.DataSource = null;
                dtls.DataBind();
            }
        }
        protected void ddlemp_change(object sender,EventArgs e)
        {
            if (ddlemp.SelectedIndex > 0)
            {
                DataSet ds = Utilities_Licensing.Getweeks(ddlemp.SelectedValue);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    hfdsdt.Value = ds.Tables[0].Rows[0][0].ToString();
                    hfdedt.Value = ds.Tables[0].Rows[0][1].ToString();
                    ddlweek.DataSource = ds.Tables[1];
                    ddlweek.DataTextField = "ww";
                    ddlweek.DataValueField = "ww";
                    ddlweek.DataBind();
                    ddlweek.Items.Insert(0, new ListItem("--Select--", "-1"));
                }
            }
            else
            {

                ddlweek.Items.Clear();
                hfdsdt.Value = "";
                hfdedt.Value = "";
            }
            
        }
    }
}