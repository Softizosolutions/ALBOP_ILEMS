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

namespace Licensing.PersonLicensing
{
    public partial class Person_License : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

                hfdperid.Value = Request.QueryString[0].ToString();
                Utilities_Licensing.BindDropdown(ddl_status1, 53);
                Utilities_Licensing.BindDropdown(ddlnewappstatus, 24);
                Utilities_Licensing.BindDropdown(ddlappreason, 28);
                Utilities_Licensing.BindDropdown(ddlmailorderstatus, 53);
                Utilities_Licensing.BindCheckboxlist1(chkschedules, 68);
                Utilities_Licensing.Bind_LicenseTypes_Business(ddl_buslictypes);
                Utilities_Licensing.BindLicType(ddllictype, Convert.ToInt32(hfdperid.Value));
                Utilities_Licensing.BindLicType(ddl_licensetype, Convert.ToInt32(hfdperid.Value));
                Utilities_Licensing.BindLicType(ddl_schedulelicensetype, Convert.ToInt32(hfdperid.Value));
                Person_Details.tbl_PersonDetail objtype = Person_Details.Licensing_Details.get_PersonsData(Convert.ToInt32(hfdperid.Value));
                hfdobjtype.Value = objtype.object_type.ToString();
                //if(hfdobjtype.Value=="1")
                //mailorder.Attributes.Add("style","display:none");
                    Utilities_Licensing.BindDropdown(ddlnewstatus, 14);
                txtDateOfChange.Text = DateTime.Now.ToShortDateString();
                txtappdt.Text = DateTime.Now.ToShortDateString();
                Utilities_Licensing.BindStatusChange(ddlReason);
             ddlcmp.DataSource=   ComplaintsTabLinq.ClsComplaints.GetComplaints("0",Convert.ToInt32( hfdperid.Value));
             ddlcmp.DataTextField = "Complaint_Number";
             ddlcmp.DataValueField = "Complaint_Number";
             ddlcmp.DataBind();
             ddlcmp.Items.Insert(0, new ListItem("", ""));
                //BindLicenseData();
                Utilities_Licensing.BindLicenseTypeByPersonID(chklictypes, Convert.ToInt32(hfdperid.Value));
                foreach (ListItem li in chklictypes.Items)
                {
                    li.Attributes.Add("App_ID", li.Value);
                }
                
            }
        }
        protected void btnsave_disp(object sender, EventArgs e)
        {
            string disp = "Yes";
            if (chbdisp.Checked == false)
                disp = "No";
            License_Data.License_Details.Save_dispinfo(Convert.ToInt32(hfdauid_disp.Value), hfdperid.Value,ddlcmp.SelectedValue, txtdispsdt.Text, txtdispenddt.Text, txtdispcmnt.Text, disp, Session["UID"].ToString(), DateTime.Now.ToShortDateString());
            ScriptManager.RegisterStartupScript(Page, GetType(), "js", "altbox('Information Saved Successfully.');afterdisp();", true);
        }
        protected void btndel_disp_click(object sender, EventArgs e)
        {
            License_Data.License_Details.Delete_dispinfo(Convert.ToInt32(hfdauid_disp.Value));
            ScriptManager.RegisterStartupScript(Page, GetType(), "js", "altbox('Information Deleted Successfully.');afterdisp();", true);
            hfdauid_disp.Value = "0";
        }
        protected void btncancel1_Click(object sender, EventArgs e)
        {
            txtExpiration_Date.Text = "";
            txtDateOfChange.Text = DateTime.Now.ToShortDateString();
            ddlReason.SelectedIndex = -1;
            ddlnewstatus.SelectedIndex = -1;
            hfd_licid.Value = "0";
        }

        protected void Update_License(object sender, EventArgs e)
        {

            
            Person_Details.Licensing_Details.Update_LicenseHistory(Convert.ToInt32(hfd_licid.Value), Convert.ToInt32(ddlnewstatus.SelectedValue), txtExpiration_Date.Text.ToString(), Convert.ToInt32(ddlReason.SelectedValue),Convert.ToInt32( Session["UID"].ToString()), DateTime.Now.ToShortDateString());

            btncancel1_Click(null, null);

            ScriptManager.RegisterStartupScript(Page, GetType(), "js", "afterchang()", true);
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
        public string Filter_Reason(string str)
        {
            try
            {
                if (str != "")
                {
                    return str.ToString();
                }
                return "NA";
            }
            catch
            {
                return "NA";
            }
        }

        protected void btnedit1_click(object sender, EventArgs e)
        {
            string Value = hfdcerti_id1.Value;

            Person_Details.tbl_Certification obj = Utilities_Licensing.EditControlled_Substances(Value);
            string status = "";
            status = obj.status.ToString();
            if (ddl_status1.Items[0].Text != status)
            {
                ddl_status1.Items[0].Selected = false;
                if (ddl_status1.Items.FindByValue(status) != null)
                    ddl_status1.Items.FindByValue(status).Selected = true;
            }
            ddl_licensetype.SelectedIndex = -1;
            if (ddl_licensetype.Items.FindByValue(obj.App_ID.ToString()) != null)
                ddl_licensetype.Items.FindByValue(obj.App_ID.ToString()).Selected = true;
            effective_date1.Text = Convert.ToDateTime(obj.Effective_dt).ToString("MM/dd/yyyy");
            exp_date1.Text = Convert.ToDateTime(obj.Expiry_dt).ToString("MM/dd/yyyy");


            string js = "Popup1();";
            ScriptManager.RegisterStartupScript(Page, GetType(), "scr", js, true);
        }
        protected void btndel1_click(object sender, EventArgs e)
        {
            string Value = hfdcerti_id1.Value;

            Utilities_Licensing.DeleteControlled_Substances(Value);


            altbox("Record deleted successfully.");
        }






        public void Clear1()
        {
            ddl_status1.SelectedIndex = -1;

            effective_date1.Text = "";
            exp_date1.Text = "";


            hfdcerti_id1.Value = "";
        }

        protected void btn_addcontrolsubstances_Click(object sender, EventArgs e)
        {
            if (hfdcerti_id1.Value == "0")
            {
                Utilities_Licensing.Save_Controlled_Substances(Convert.ToInt32(hfdcerti_id1.Value), Convert.ToInt32(hfdperid.Value), "816", ddl_status1.SelectedValue, effective_date1.Text.ToString(), exp_date1.Text.ToString(), Session["UID"].ToString(), DateTime.Now.ToString(), Session["UID"].ToString(), DateTime.Now.ToString(),Convert.ToInt32(ddl_licensetype.SelectedValue));

                altbox("Record inserted successfully." );
                Clear1();
            }
            else
            {
                Utilities_Licensing.Save_Controlled_Substances(Convert.ToInt32(hfdcerti_id1.Value), Convert.ToInt32(hfdperid.Value), "816", ddl_status1.SelectedValue, effective_date1.Text.ToString(), exp_date1.Text.ToString(), Session["UID"].ToString(), DateTime.Now.ToString(), Session["UID"].ToString(), DateTime.Now.ToString(),Convert.ToInt32(ddl_licensetype.SelectedValue));

                altbox("Record updated successfully.");
                Clear1();
            }

        }
        protected void btnmailordersubmit_Click(object sender, EventArgs e)
        {
            if (hfdmailid.Value == "0")
            {
                string notnew = "";
                if (chknotnew.Checked == false)
                    notnew = "No";
                else
                    notnew = "Yes";

                Utilities_Licensing.Insertmailored(hfdperid.Value, ddlmailorderstatus.SelectedValue, txteffectivedate.Text, txtexpirydate.Text, notnew, Session["UID"].ToString());
                altbox("Record inserted successfully.");

                ddlmailorderstatus.SelectedIndex = -1;
                hfdmailid.Value = "0";
                txteffectivedate.Text = "";
                txtexpirydate.Text = "";
                chknotnew.Checked = false;
            }
            else
            {
                Utilities_Licensing.UpdateMailorder(Convert.ToInt32(hfdmailid.Value), ddlmailorderstatus.SelectedValue, txteffectivedate.Text.ToString(), txtexpirydate.Text.ToString(), Session["UID"].ToString(), DateTime.Now.ToString());
                altbox("Record updated successfully.");

                ddlmailorderstatus.SelectedIndex = -1;
                hfdmailid.Value = "0";
                txteffectivedate.Text = "";
                txtexpirydate.Text = "";
                chknotnew.Checked = false;
            }
        }
        //private void BindLicenseData()
        //{
        //    grdverification_list.DataSource = Person_Details.Licensing_Details.GetLicensing_Details(Convert.ToInt32(hfdperid.Value));
        //    grdverification_list.DataBind();
        //}
        protected void update_appsattus(object sender, EventArgs e)
        {
            Utilities_Licensing.Updateappstatu(hfd_appid.Value, ddlnewappstatus.SelectedValue, txtappdt.Text);
            ScriptManager.RegisterStartupScript(Page, GetType(), "js", "afterchang()", true);
        
        }
        protected void lic_Tabs_Init(object sender, EventArgs e)
        {
            try
            {

                var tabs = Person_Details.Licensing_Details.GetLicensing_Details(Convert.ToInt32(Request.QueryString[0].ToString()));
              
                AjaxControlToolkit.TabPanel temp_panel;
                Control ctr;
                foreach (USP_Licensing_DetailsResult dr in tabs)
                {
                    //if (dr["License_status"].ToString() != "Failed Examination" && dr["License_status"].ToString().Trim() != "")
                    //{
                    temp_panel = new AjaxControlToolkit.TabPanel();
                    temp_panel.EnableViewState = true;
                    ctr = new Control();
                    ctr = this.LoadControl("./PersonLicense_Details.ascx");
                    ctr.EnableViewState = true;
                    ((PersonLicense_Details)ctr).fill_data(dr);
                    //((Nurse_Details)ctr).fill_data(Request.QueryString[0].ToString());
                    if (dr.Lic_no.ToString() != string.Empty)
                        temp_panel.HeaderText = dr.Lic_no.ToString() + " - " + dr.License_Type.ToString().Replace("Temporary", "Temp");
                    else
                        temp_panel.HeaderText = dr.License_Type.ToString().Replace("Temporary", "Temp");
                    temp_panel.Controls.Add(ctr);

                    lic_Tabs.Tabs.Add(temp_panel);
                    // }

                }
                if (lic_Tabs.Tabs.Count > 0)
                    lic_Tabs.ActiveTabIndex = 0;
            }
            catch
            {
            }
        }
        private void altbox(string str)
        {
            string js = " afterpost('" + str + "');";
            ScriptManager.RegisterStartupScript(Page, GetType(), "scr", js, true);
        }
        protected void btnedit2_Click(object sender, EventArgs e)
        {
            string value = hfdmailid.Value;
            Person_Details.tbl_Certification obj = Utilities_Licensing.EditControlled_Substances(value);
            string status = "";
            status = obj.status.ToString();
            if (ddlmailorderstatus.Items[0].Text != status)
            {
                ddlmailorderstatus.Items[0].Selected = false;
                if (ddlmailorderstatus.Items.FindByValue(status) != null)
                    ddlmailorderstatus.Items.FindByValue(status).Selected = true;
            }
            string effectivedate = "";
            effectivedate = Convert.ToDateTime(obj.Effective_dt).ToString("MM/dd/yyyy");

            if (effectivedate != null && effectivedate != "01/01/1900" && effectivedate != "01/01/0001" && effectivedate != "")
            {
                txteffectivedate.Text = effectivedate;
            }
            else
            {
                txteffectivedate.Text = "";
            }
            string expirydate = "";
            expirydate = Convert.ToDateTime(obj.Expiry_dt).ToString("MM/dd/yyyy");

            if (expirydate != null && expirydate != "01/01/1900" && expirydate != "01/01/0001" && expirydate != "")
            {
                txtexpirydate.Text = expirydate;
            }
            else
            {
                txtexpirydate.Text = "";
            }

            chknotnew.Checked = true;

            string js = "Popup();";
            ScriptManager.RegisterStartupScript(Page, GetType(), "scr", js, true);
        }
        protected void btnchangelictypesave_Click(object sender, EventArgs e)
        {
            bool? result = Person_Details.Licensing_Details.Update_Applicationlicensetype(hfdselappid.Value, hfdlicensetype.Value, ddl_buslictypes.SelectedValue, Session["UID"].ToString());
            if (result == true)
            {
                altboxforlicensetypechange("License Type updated successfully.");
            }
            else
                altboxforlicensetypechange("License Type not updated.");
        }
        private void altboxforlicensetypechange(string str)
        {
            string js = " afterlicensetypechange('" + str + "');";
            ScriptManager.RegisterStartupScript(Page, GetType(), "scr", js, true);
        }

        protected void btnschedulesubmit_Click(object sender, EventArgs e)
        {
            using (Person_Details.Person_LicenseDataContext pldc = new Person_LicenseDataContext())
            {
                string schedule = "";
                tbl_Application app = pldc.tbl_Applications.Where(c => c.App_ID == Convert.ToInt32(ddl_schedulelicensetype.SelectedValue)).FirstOrDefault();


                for (int i = 0; i <= chkschedules.Items.Count - 1; i++)
                {
                    if (chkschedules.Items[i].Selected)
                    {
                        if (schedule == "")
                        {
                            schedule = chkschedules.Items[i].Text;
                        }
                        else
                        {
                            schedule += "," + chkschedules.Items[i].Text;
                        }
                    }
                }
                app.Schedule = schedule;
                pldc.SubmitChanges();
                altbox("Record inserted successfully.");
            }
        }

        protected void ddl_licensetype_SelectedIndexChanged(object sender, EventArgs e)
        {
            Person_Details.tbl_Application app = Person_Details.Licensing_Details.GetSchedule(Convert.ToInt32(ddl_schedulelicensetype.SelectedValue));
            if (app != null && app.Schedule != null)
            {
                string[] result = app.Schedule.ToString().Split(',');
                foreach (ListItem li in chkschedules.Items)
                {
                    foreach (string str in result)
                    {
                        if (li.Text == str)
                        {
                            li.Selected = true;
                        }
                    }
                }
            }
            else {
                for (int items = 0; items < chkschedules.Items.Count; items++)
                {
                    chkschedules.ClearSelection();
                }
            }
        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {

            if (hfdauid.Value == "0")
            {


                Person_Details.Licensing_Details.InsertInterviewDetails(0, Convert.ToInt32(hfdperid.Value), Convert.ToInt32(ddllictype.SelectedValue), -1, txt_date.Text, rdblawful.SelectedValue, Session["UID"].ToString());
                altbox("Record inserted successfully.");

                Clear();
            }
            else
            {
                Person_Details.Licensing_Details.InsertInterviewDetails(Convert.ToInt32(hfdauid.Value), Convert.ToInt32(hfdperid.Value), Convert.ToInt32(ddllictype.SelectedValue), -1, txt_date.Text, rdblawful.SelectedValue, Session["UID"].ToString());
                altbox("Record updated successfully.");

                Clear();
            }
        }

        public void Clear()
        {
            ddllictype.SelectedIndex = -1;
            txt_date.Text = "";
            rdblawful.Text = "";
            hfdauid.Value = "0";
        }
        protected void btninterviewedit_Click(object sender, EventArgs e)
        {
            tbl_Interview_Report obj = Licensing_Details.GetInterviewDetails(Convert.ToInt32(hfdauid.Value));
            if (obj != null)
            {
                ddllictype.ClearSelection();
                if (ddllictype.Items.FindByValue(obj.App_Id.ToString()) != null)
                    ddllictype.Items.FindByValue(obj.App_Id.ToString()).Selected = true;
                if (obj.Interview_Date != null)
                    txt_date.Text = Convert.ToDateTime(obj.Interview_Date).ToString("MM/dd/yyyy");
                rdblawful.ClearSelection();
                if (rdblawful.Items.FindByValue(obj.IS_Appear.ToString()) != null)
                    rdblawful.Items.FindByValue(obj.IS_Appear.ToString()).Selected = true;

            }
            string js = "Popup2();";
            ScriptManager.RegisterStartupScript(Page, GetType(), "scr", js, true);
        }

        protected void btninterviewdel_Click(object sender, EventArgs e)
        {
            Licensing_Details.DeleteInterviewDetails(Convert.ToInt32(hfdauid.Value));
            altbox("Record deleted successfully.");
        }
    }
}