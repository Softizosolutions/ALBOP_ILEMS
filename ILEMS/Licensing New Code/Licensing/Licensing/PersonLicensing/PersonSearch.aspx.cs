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
    public partial class PersonSearch : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Utilities_Licensing.BindDropdown(ddl_county, 10);
                Utilities_Licensing.BindDropdown(ddl_state, 9);
                Utilities_Licensing.BindDropdown(ddl_suffix, 12);
                Utilities_Licensing.BindDropdown(ddl_gender, 18);
                Utilities_Licensing.BindDropdown(ddl_mstatus, 19);
                Utilities_Licensing.Bind_LicenseTypes_individual(ddl_lictype);
                Utilities_Licensing.BindDropdown(ddl_licstatus, 14);
                Utilities_Licensing.Bind_LicenseTypes_individual(ddl_applictype);
                Utilities_Licensing.BindDropdown(ddlcounty, 10);
                Utilities_Licensing.BindDropdown(ddlstate, 9);
                Utilities_Licensing.BindDropdown(ddlethincity, 62);
            }
        }

        protected void btnsearch_Click(object sender, EventArgs e)
        {
            //grd_Persondata.PageIndex = 0;
            //Utilities_Licensing.getpersonserch(grd_Persondata, txt_Lastname.Text, txt_Firstname.Text, txt_ssn.Text, txt_dob.Text, txt_phonenum.Text, ddl_Phonetype.SelectedItem.ToString(), txt_licnumber.Text, ddl_lictype.SelectedItem.Value, ddl_licstatus.SelectedItem.Value, txt_email.Text);
           // Search_Clear();
        }

        public string openapp1(string pid, string nm)
        {
            return "javascript:return openapplication('" + pid + "','" + nm.Replace("'", "`") + "')";

        }

        public string filter_date(string str)
        {
            try
            {
                if (str != "")
                {
                    return DateTime.Parse(str).ToString("MM/dd/yyyy");
                }
                return "NA";
            }
            catch { return "NA"; }
        }
      
      
        public List<Person_Details.USP_GetLicenseinfobypersonidResult> Getlic(string pid)
        {
            return Utilities_Licensing.Get_Person_licenseInfo(pid);
        }
        protected void btnreinstate_click(object sender, EventArgs e)
        {
            string pid=License_Data.License_Details.Create_reinstate(hfdsellicid.Value, Session["UID"].ToString());
            ScriptManager.RegisterStartupScript(Page, GetType(), "js", "window.location.href='./PersonDetails.aspx?pid=" + pid + "'", true);
              

        }
        protected void btnsave_Click(object sender, EventArgs e)
        {
            //  List<tbl_PersonDetail> dt = Person_Details.Licensing_Details.GetSSN(txtssn.Text);
            string cnt = Utilities_Licensing.checkSSN(txtssn.Text);
            if (cnt!="0")
            {
                string js = " altbox('This SSN already exists in the system.');Popup();";
                ScriptManager.RegisterStartupScript(Page, GetType(), "scr", js, true);   
            }
            else
            {
                int pid = Utilities_Licensing.Insert_Person_Detail(Convert.ToInt32(hfdpersonid.Value), txtfname.Text.ToString(), txtmname.Text.ToString(), txtlname.Text.ToString(), txtmaidenname.Text.ToString(), ddl_gender.SelectedValue, txtdob.Text.ToString(), txtssn.Text.ToString(), txtage.Text.ToString(), txtaddress1.Text.ToString(), txtaddress2.Text.ToString(), txtcity.Text.ToString(), ddl_state.SelectedValue, ddl_county.SelectedValue, txtzip.Text.ToString(), ddl_phone.SelectedItem.Text, txtphone.Text.ToString(), ddl_altphone.SelectedItem.Text, txtaltphone.Text.ToString(), ddl_mstatus.SelectedItem.Text, txtfax.Text.ToString(), txtemail.Text.ToString(), rdl_uscitizen.SelectedValue, ddl_suffix.SelectedValue, Session["UID"].ToString(), DateTime.Now.ToString(), Session["UID"].ToString(), DateTime.Now.ToString(), txtcitizenexpdate.Text,txtcpenumber.Text,ddlethincity.SelectedValue);
                ScriptManager.RegisterStartupScript(Page, GetType(), "js", " bindautogrd('" + txtssn.Text + "')", true);
                Clear();
            }
        }
        public void age()
        {
            DateTime birthdate = Convert.ToDateTime(txtdob.Text);
            txtage.Text = Convert.ToString(DateTime.Today.Year - birthdate.Date.Year);
        }

        protected void btnapplication_Click(object sender, EventArgs e)
        {
            List<tbl_Application> ds = Person_Details.Licensing_Details.GetLicenseforpersonandbusiness(Convert.ToInt32(hfd_perid.Value), ddl_applictype.SelectedValue);
            if (ds.Count > 0)
            {
                string js = " altbox('This license type already exists for this profile.');";
                ScriptManager.RegisterStartupScript(Page, GetType(), "scr", js, true);
                ddl_applictype.SelectedValue = "-1";
            }
            else
            {
                int os = 0;
                if (rdbstate.Items[0].Selected)
                    os = 1;
                if (rdbstate.Items[1].Selected)
                    os = 2;
                Person_Details.Licensing_Details.Insert_Application(Convert.ToInt32(hfd_perid.Value), ddl_applictype.SelectedValue, chkcontrolledsubstance.Checked, os);
                Response.Redirect("./PersonDetails.aspx?pid=" + hfd_perid.Value);
            }
        }
        public void Clear()
        {
            hfdpersonid.Value = "0";
            txtfname.Text = "";
            txtmname.Text = "";
            txtlname.Text = "";
            ddl_gender.SelectedValue = "-1";
            txtmaidenname.Text = "";
            txtdob.Text = "";
            txtssn.Text = "";
            txtage.Text = "";
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
            ddl_mstatus.SelectedValue = "-1";
            txtfax.Text = "";
            txtemail.Text = "";
            ddl_suffix.SelectedValue = "-1";
            txtcitizenexpdate.Text = "";
            txtcpenumber.Text = "";
        }

        protected void btnsearchclear_Click(object sender, EventArgs e)
        {
            Search_Clear();
        }

        protected void btnclear_Click(object sender, EventArgs e)
        {
            Clear();
        }
        private void Search_Clear()
        {
            txt_Lastname.Text = "";
            txt_Firstname.Text = "";
            txt_ssn.Text = "";
            txt_dob.Text = "";
            txt_phonenum.Text = "";
            ddl_Phonetype.SelectedValue = "-1";
            txt_licnumber.Text = "";
            ddl_lictype.SelectedValue = "-1";
            ddl_licstatus.SelectedValue = "-1";
            txt_email.Text = "";
        }
    }
}