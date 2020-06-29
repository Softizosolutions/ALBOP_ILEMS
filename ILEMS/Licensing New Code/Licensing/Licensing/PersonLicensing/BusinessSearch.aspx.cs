using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using System.Collections.Generic;
using Person_Details;

namespace Licensing.PersonLicensing
{
    public partial class BusinessSearch : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Utilities_Licensing.Bind_LicenseTypes_Business(ddl_lictype);
                Utilities_Licensing.Bind_LicenseTypes_Business(ddl_applictype);
                Utilities_Licensing.BindDropdown(ddl_licstatus, 14);
                Utilities_Licensing.BindDropdown(ddl_county, 10);
                Utilities_Licensing.BindDropdown(ddl_state, 9);
                Utilities_Licensing.BindDropdown(ddlbusinesstype, 56);
                Utilities_Licensing.BindDropdown(ddlcounty, 10);
                Utilities_Licensing.BindDropdown(ddlstate, 9);
            }
        }
        protected void btnreinstate_click(object sender, EventArgs e)
        {
            string pid = License_Data.License_Details.Create_reinstate(hfdsellicid.Value, Session["UID"].ToString());
            ScriptManager.RegisterStartupScript(Page, GetType(), "js", " window.location.href='./PersonDetails.aspx?pid=" + pid + "'", true);


        }
        protected void btnsearch_Click(object sender, EventArgs e)
        {
            //grd_Businessdata.PageIndex = 0;
            //Utilities_Licensing.getbusinesssearch(grd_Businessdata, txt_businessname.Text, txt_ownersname.Text, txt_fein.Text, txt_datestarted.Text, txt_phonenum.Text, ddl_Phonetype.SelectedItem.ToString(), txt_licnumber.Text, ddl_lictype.SelectedItem.Value, ddl_licstatus.SelectedItem.Value, txt_address.Text, ddlcounty.SelectedValue, ddlstate.SelectedValue, txt_zip.Text, txt_email.Text);
            //Search_Clear();
        }
        public string filter_date(string str)
        {
            try
            {
                if (str == "1/1/1900 12:00:00 AM")
                {
                    return "NA";
                }
                else
                {
                    return DateTime.Parse(str).ToString("MM/dd/yyyy");
                }
            }
            catch { return "NA"; }
        }
        public string openapp1(string pid, string nm)
        {
            return "javascript:return openapplication('" + pid + "','" + nm.Replace("'", "`") + "')";

        }
        public List<Person_Details.USP_GetLicenseinfobypersonidResult> Getlic(string pid)
        {
            return Utilities_Licensing.Get_Person_licenseInfo(pid);
        }

        protected void btnapplication_Click(object sender, EventArgs e)
        {
            List<tbl_Application> ds = Person_Details.Licensing_Details.GetLicenseforpersonandbusiness(Convert.ToInt32(hfd_perid.Value), ddl_applictype.SelectedValue);
            //if (ds.Count > 0)
            //{
            //    string js = " altbox('This permit type already exists for this profile.');";
            //    ScriptManager.RegisterStartupScript(Page, GetType(), "scr", js, true);
            //    ddl_applictype.SelectedValue = "-1";
            //}
            //else
            //{
                Person_Details.Licensing_Details.Insert_Application(Convert.ToInt32(hfd_perid.Value), ddl_applictype.SelectedValue, chkcontrolledsubstance.Checked,0);
                Response.Redirect("./Business_Details.aspx?pid=" + hfd_perid.Value);
            //}
        }

        protected void btnsave_Click(object sender, EventArgs e)
        {
          
            int pid = Utilities_Licensing.Insert_Business_Details(Convert.ToInt32(hfdpersonid.Value), txtbusinessname.Text, txtownersname.Text, txtstartdate.Text, ddlbusinesstype.SelectedValue, txtfein.Text, txtaddress1.Text, txtaddress2.Text, txtcity.Text, ddl_state.SelectedValue, ddl_county.SelectedValue, txtzip.Text, ddl_Phonetype.SelectedValue, txtphone.Text, ddl_altphone.SelectedValue, txtaltphone.Text, txtfax.Text, txtemail.Text, txtdea.Text, ddlstatus.SelectedValue, Session["UID"].ToString(), DateTime.Now.ToShortDateString(), Session["UID"].ToString(), DateTime.Now.ToShortDateString());

            //ScriptManager.RegisterStartupScript(Page, GetType(), "js", " bindautogrd('" + txtfein.Text + "','" + txtbusinessname.Text + "','" + txtownersname.Text + "','" + txt_datestarted.Text + "','" + txtphone.Text + "','" + txtcity.Text + "','" + ddlstate.SelectedValue + "','" + ddlcounty.SelectedValue + "','" + txtzip.Text + "','" + txtemail.Text + "')", true);
            ScriptManager.RegisterStartupScript(Page, GetType(), "js", " Select_buslkp1('" + pid+ "','" + txtbusinessname.Text.Replace("'","") + "')", true);
            Clear();
            //List<tbl_PersonDetail> dt = Person_Details.Licensing_Details.GetFEIN(txtfein.Text);
            //if (dt.Count > 0)
            //{
            //    string js = " altbox('This FEIN already exists in the system.');";
            //    ScriptManager.RegisterStartupScript(Page, GetType(), "scr", js, true);   
            //}
            //else
            //{
                
            //}
        }
        public void Clear()
        {
            hfdpersonid.Value = "0";
            txtbusinessname.Text = "";
            txtownersname.Text = "";
            txtfein.Text = "";
            txtstartdate.Text = "";
            txtenddate.Text = "";
            ddlbusinesstype.SelectedValue = "-1";
            ddlstatus.SelectedValue = "-1";
            txtaddress1.Text = "";
            txtaddress2.Text = "";
            txtcity.Text = "";
            ddl_state.SelectedValue = "-1";
            ddl_county.SelectedValue = "-1";
            txtzip.Text = "";
            ddl_phone.SelectedValue = "-1";
            txtphone.Text = "";
            ddl_altphone.SelectedValue = "-1";
            txtaltphone.Text = "";
            txtfax.Text = "";
            txtemail.Text = "";
            txtdea.Text = "";
        }

        public void Search_Clear()
        {
            txt_businessname.Text = "";
            txt_ownersname.Text = "";
            txt_fein.Text = "";
            txt_datestarted.Text = "";
            txt_phonenum.Text = "";
            ddl_Phonetype.SelectedValue = "-1";
            txt_licnumber.Text = "";
            ddl_lictype.SelectedValue = "-1";
            ddl_licstatus.SelectedValue = "-1";
            txt_email.Text = "";
            txt_zip.Text = "";
            ddlstate.SelectedValue = "-1";
            ddlcounty.SelectedValue = "-1";
            txt_address.Text = "";
        }
    }
}