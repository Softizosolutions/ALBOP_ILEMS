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
using System.Data.SqlClient;
using Person_Details;

namespace Licensing.PersonLicensing
{
    public partial class Contacts : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                hfdpid.Value = Request.QueryString[0].ToString();
                btnaddnew.Attributes.Add("onClick", "return open_NewAddPerson(" + hfdpid.Value + ");");
            }
        }

        protected void btncontact_Click(object sender, EventArgs e)
        {
            Utilities_Licensing.Update_ContactStatus(Convert.ToInt32(hfdselid.Value));
            altbox("Record updated successfully.");
        }
        protected void btnowner_Click(object sender, EventArgs e)
        {
            Utilities_Licensing.Update_ContactStatus(Convert.ToInt32(hfdselid.Value));
            altbox("Record updated successfully.");
        }
        protected void btnsupervisor_Click(object sender, EventArgs e)
        {
            Utilities_Licensing.Update_ContactStatus(Convert.ToInt32(hfdselid.Value));
            altbox("Record updated successfully.");
        }
        protected void btnsupplier_Click(object sender, EventArgs e)
        {
            Utilities_Licensing.Update_ContactStatus(Convert.ToInt32(hfdselid.Value));
            altbox("Record updated successfully.");
        }
        private void altbox(string str)
        {
            string js = " afterpost('" + str + "');";
            ScriptManager.RegisterStartupScript(Page, GetType(), "scr", js, true);
        }


        protected void btnedit_Click(object sender, EventArgs e)
        {
            string value = hfdeditid.Value;
            DataSet ds = Utilities_Licensing.GetSupervisorStartDate(Convert.ToInt32(value));
            string startdate = ""; string enddate = "";
            startdate = ds.Tables[0].Rows[0]["Start_dt"].ToString();
            enddate = ds.Tables[0].Rows[0]["End_dt"].ToString();

            if (startdate == "")
                startdate = "01/01/0001";
            if (Convert.ToDateTime(startdate).ToString("MM/dd/yyyy") == "01/01/1900" || Convert.ToDateTime(startdate).ToString("MM/dd/yyyy") == "01/01/0001" || startdate == "" || startdate == null)
            {
                txt_startdate.Text = "";
            }
            else
                txt_startdate.Text = Convert.ToDateTime(startdate).ToString("MM/dd/yyyy");

            if (enddate == "")
                enddate = "01/01/0001";
            if (Convert.ToDateTime(enddate).ToString("MM/dd/yyyy") == "01/01/1900" || Convert.ToDateTime(enddate).ToString("MM/dd/yyyy") == "01/01/0001" || enddate == "" || enddate == null)
            {
                txt_enddate.Text = "";
            }
            else
                txt_enddate.Text = Convert.ToDateTime(enddate).ToString("MM/dd/yyyy");

            string js = "Popup();";
            ScriptManager.RegisterStartupScript(Page, GetType(), "scr", js, true);
        }



        protected void btnsubmit_Click(object sender, EventArgs e)
        {
            string startdate = ""; string enddate = "";
            if (txt_startdate.Text != "")
                startdate = txt_startdate.Text;
            else
                startdate = "01/01/1900";

            if (txt_enddate.Text != "")
                enddate = txt_enddate.Text;
            else
                enddate = "01/01/1900";
            Utilities_Licensing.UpdateSupervisorStartdate(Convert.ToInt32(hfdeditid.Value), Convert.ToDateTime(startdate), Convert.ToDateTime(enddate), txt_comments.Text, Session["UID"].ToString(), "3");
            txt_startdate.Text = "";
            txt_enddate.Text = "";
            hfdeditid.Value = "0";
            altbox("Record updated successfully.");
        }
        protected void btnclear_Click(object sender, EventArgs e)
        {
            txt_startdate.Text = "";
            txt_enddate.Text = "";
            txt_comments.Text = "";
        }

        
        protected void btncommentsubmit_Click(object sender, EventArgs e)
        {
            DataSet ds = new DataSet();
            ds = Utilities_Licensing.GetContacttype(Convert.ToInt32(hfdeditid.Value));
            if (ds.Tables[0].Rows.Count > 0)
                hfdcontacttype.Value = ds.Tables[0].Rows[0]["Contact_type"].ToString();
            Utilities_Licensing.UpdateContactComment(Convert.ToInt32(hfdeditid.Value), txtcomment.Text, Session["UID"].ToString(), hfdcontacttype.Value, txtPercentage.Text);
            txtcomment.Text = "";
            txtPercentage.Text = "";
            hfdeditid.Value = "0";
            altbox("Record updated successfully.");
        }

        protected void btneditcomment_Click(object sender, EventArgs e)
        {
            string value = hfdeditid.Value;
            DataSet ds = Utilities_Licensing.GetSupervisorStartDate(Convert.ToInt32(value));
            txtcomment.Text = ds.Tables[0].Rows[0]["Comments"].ToString();
            txtPercentage.Text = ds.Tables[0].Rows[0]["Percentage"].ToString();
            if (ds.Tables[0].Rows[0]["Contact_type"].ToString() == "2")
                ownerdisp.Visible = true;
            else
                ownerdisp.Visible = false;
            string js = "EditComments();";
            ScriptManager.RegisterStartupScript(Page, GetType(), "scr", js, true);
        }

        protected void btndeletecontact_Click(object sender, EventArgs e)
        {
            using (Person_LicenseDataContext pldc = new Person_LicenseDataContext())
            {
                tbl_Person_contact obj = pldc.tbl_Person_contacts.Where(c => c.contact_id == Convert.ToInt32(hfdselid.Value)).SingleOrDefault();
                pldc.tbl_Person_contacts.DeleteOnSubmit(obj);
                pldc.SubmitChanges();
                altbox("Record deleted successfully.");
                hfdselid.Value = "0";
            }
        }
    }
}