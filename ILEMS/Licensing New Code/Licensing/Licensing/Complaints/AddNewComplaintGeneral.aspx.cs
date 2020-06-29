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
using System.IO;
using Person_Details;
using Licensing.PersonLicensing;

namespace Licensing.Complaints
{
    public partial class AddNewComplaintGeneral : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindDropDowns();
            }
        }
        private void BindDropDowns()
        {
            utilities.Bind_LicenseTypes_individual(ddl_lictype);
            utilities.BindDropdown(ddl_licstatus, 14);
            utilities.BindDropdown(ddlcounty, 10);
            utilities.BindDropdown(ddlstate, 9);
            utilities.Bind_LicenseTypes_Business(ddllictype);
            utilities.BindDropdown(ddllicstatus, 14);
            utilities.BindDropdown(ddlparticipantRole, 46);
            utilities.BindDropdown(ddl_county, 10);
            utilities.BindDropdown(ddl_state, 9);
            utilities.BindDropdown(ddlpersonstate, 9);
            utilities.BindDropdown(ddlpersoncounty, 10);
            utilities.BindDropdown(ddlpersonsuffix, 12);
            utilities.BindDropdown(ddlpersongender, 18);
            utilities.BindDropdown(ddlpersonmstatus, 19);
            utilities.BindDropdown(ddlbusinesscounty, 10);
            utilities.BindDropdown(ddlbusinessstate, 9);
            utilities.BindDropdown(ddlbusinesstype, 56);
            utilities.BindDropdown(ddlethincity, 62);
        }

        protected void btnsubmit_Click(object sender, EventArgs e)
        {
            hfdcmpid.Value = Request.QueryString[0].ToString();
            ComplaintsLink.Complaints.Insert_Complaint_Participant(Convert.ToInt32(hfdcmpgenid.Value), Convert.ToInt32(hfdcmpid.Value), hfdcmppartid.Value, Convert.ToInt32(hfdpid.Value), ddlparticipantRole.SelectedValue.ToString(), Convert.ToInt32(Session["UID"]), Convert.ToInt32(Session["UID"]), DateTime.Now.ToShortDateString(), DateTime.Now.ToShortDateString());
            altbox("Record inserted successfully.");
            Clear();
        }
        protected void btnpersonsave_Click(object sender, EventArgs e)
        {
            if (txtpersonssn.Text != "")
            {
                // List<tbl_PersonDetail> dt = Person_Details.Licensing_Details.GetSSN(txtpersonssn.Text);
                string cnt = Utilities_Licensing.checkSSN(txtpersonssn.Text);
                if (cnt != "0")
                {
                    string js = " altbox('This SSN already exists in the system.');";
                    ScriptManager.RegisterStartupScript(Page, GetType(), "scr", js, true);
                }
                else
                {
                    PersonInsertion();

                }
            }
            else
            {
                PersonInsertion();
            }
            
        }
        private void PersonInsertion()
        {
            int pid = PersonLicensing.Utilities_Licensing.Insert_Person_Detail(0, txtpersonfname.Text.ToString(), txtpersonmname.Text.ToString(), txtpersonlname.Text.ToString(), txtpersonmaidenname.Text.ToString(), ddlpersongender.SelectedValue, txtpersondob.Text.ToString(), txtpersonssn.Text.ToString(), txtpersonage.Text.ToString(), txtpersonaddress1.Text.ToString(), txtpersonaddress2.Text.ToString(), txtpersoncity.Text.ToString(), ddlpersonstate.SelectedValue, ddlpersoncounty.SelectedValue, txtpersonzip.Text.ToString(), ddlpersonphone.SelectedItem.Text, txtpersonphone.Text.ToString(), ddlpersonaltphone.SelectedItem.Text, txtpersonaltphone.Text.ToString(), ddlpersonmstatus.SelectedItem.Text, txtpersonfax.Text.ToString(), txtpersonemail.Text.ToString(), rdlpersonuscitizen.SelectedValue, ddlpersonsuffix.SelectedValue, Session["UID"].ToString(), DateTime.Now.ToString(), Session["UID"].ToString(), DateTime.Now.ToString(), txtpersoncitizenexpdate.Text, txtpersoncpenumber.Text,ddlethincity.SelectedValue);
            ScriptManager.RegisterStartupScript(Page, GetType(), "js", " InsertContact('" + pid + "')", true);
            PersonClear();
        }
        protected void btnbusinesssave_Click(object sender, EventArgs e)
        {
            int pid = PersonLicensing.Utilities_Licensing.Insert_Business_Details(0, txtbusiness.Text, txtbusinessownersname.Text, txtbusinessstartdate.Text, ddlbusinesstype.SelectedValue, txtbusinessfein.Text, txtbusinessaddress1.Text, txtbusinessaddress2.Text, txtbusinesscity.Text, ddlbusinessstate.SelectedValue, ddlbusinesscounty.SelectedValue, txtbusinesszip.Text, ddlbusinessphone.SelectedValue, txtbusinessphone.Text, ddlbusinessaltphone.SelectedValue, txtbusinessaltphone.Text, txtbusinessfax.Text, txtbusinessemail.Text, txtbusinessdea.Text, ddlbusinessstatus.SelectedValue, Session["UID"].ToString(), DateTime.Now.ToShortDateString(), Session["UID"].ToString(), DateTime.Now.ToShortDateString());
            ScriptManager.RegisterStartupScript(Page, GetType(), "js", " InsertContact('" + pid + "')", true);
            BusinessClear();
        }
        public void PersonClear()
        {
            txtpersonfname.Text = "";
            txtpersonmname.Text = "";
            txtpersonlname.Text = "";
            ddlpersongender.SelectedValue = "-1";
            txtpersonmaidenname.Text = "";
            txtpersondob.Text = "";
            txtpersonssn.Text = "";
            txtpersonage.Text = "";
            txtpersonaddress1.Text = "";
            txtpersonaddress2.Text = "";
            txtpersoncity.Text = "";
            ddlpersonstate.SelectedValue = "-1";
            ddlpersoncounty.SelectedValue = "-1";
            txtpersonzip.Text = "";
            ddlpersonphone.SelectedValue = "-1";
            txtpersonphone.Text = "";
            ddlpersonaltphone.SelectedValue = "-1";
            txtpersonaltphone.Text = "";
            ddlpersonmstatus.SelectedValue = "-1";
            txtpersonfax.Text = "";
            txtpersonemail.Text = "";
            ddlpersonsuffix.SelectedValue = "-1";
            txtpersoncitizenexpdate.Text = "";
            txtpersoncpenumber.Text = "";
        }
        public void BusinessClear()
        {
            txtbusinessname.Text = "";
            txtbusinessownersname.Text = "";
            txtbusinessfein.Text = "";
            txtbusinessstartdate.Text = "";
            txtbusinessenddate.Text = "";
            ddlbusinesstype.SelectedValue = "-1";
            ddlbusinessstatus.SelectedValue = "-1";
            txtbusinessaddress1.Text = "";
            txtbusinessaddress2.Text = "";
            txtbusinesscity.Text = "";
            ddlbusinessstate.SelectedValue = "-1";
            ddlbusinesscounty.SelectedValue = "-1";
            txtbusinesszip.Text = "";
            ddlbusinessphone.SelectedValue = "-1";
            txtbusinessphone.Text = "";
            ddlbusinessaltphone.SelectedValue = "-1";
            txtbusinessaltphone.Text = "";
            txtbusinessfax.Text = "";
            txtbusinessemail.Text = "";
            txtbusinessdea.Text = "";
        }
        private void Clear()
        {
            hfdpid.Value = "0";
            hfdcmppartid.Value = "0";
            hfdcmpgenid.Value = "0";
        }
        private void altbox(string str)
        {
            string js = " afterpost('" + str + "');";
            ScriptManager.RegisterStartupScript(Page, GetType(), "scr", js, true);
        }
    }
}