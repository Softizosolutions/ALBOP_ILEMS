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
    public partial class AddNewContact : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindDropdowns();
            }
        }
        private void BindDropdowns()
        {
            Utilities_Licensing.Bind_LicenseTypes_individual(ddl_lictype);
            Utilities_Licensing.BindDropdown(ddl_licstatus, 14);
            Utilities_Licensing.BindDropdown(ddlcounty, 10);
            Utilities_Licensing.BindDropdown(ddlstate, 9);
            Utilities_Licensing.Bind_LicenseTypes_Business(ddllictype);
            Utilities_Licensing.BindDropdown(ddllicstatus, 14);
            Utilities_Licensing.BindDropdown(ddl_county, 10);
            Utilities_Licensing.BindDropdown(ddl_state, 9);
            Utilities_Licensing.BindDropdown(ddlpersonstate, 9);
            Utilities_Licensing.BindDropdown(ddlpersoncounty, 10);
            Utilities_Licensing.BindDropdown(ddlpersonsuffix, 12);
            Utilities_Licensing.BindDropdown(ddlpersongender, 18);
            Utilities_Licensing.BindDropdown(ddlpersonmstatus, 19);
            Utilities_Licensing.BindDropdown(ddlbusinesscounty, 10);
            Utilities_Licensing.BindDropdown(ddlbusinessstate, 9);
            Utilities_Licensing.BindDropdown(ddlbusinesstype, 56);
            Utilities_Licensing.BindDropdown(ddlethincity, 62);
        }
        protected void btnsubmit_Click(object sender, EventArgs e)
        {
            try
            {
                hfdpid.Value = Request.QueryString[0].ToString();
                int contacttype = Convert.ToInt32(ddlcontacttype.SelectedValue);
                var query = Utilities_Licensing.GetPersonandBusiness(hfdrelid.Value, contacttype);
                var queryforstatus = Utilities_Licensing.GetPersonandBusinessLicense(hfdrelid.Value);
                string Name = "";
                string address = "";
                string email = "";
                string licensestatus = "-1";
                if (queryforstatus.Count > 0)
                {
                    if (queryforstatus[0].licstatus != null)
                        licensestatus = queryforstatus[0].licstatus;
                }
                if (query.Count > 0 && (contacttype == 3 || contacttype == 5))
                {
                    string business = query[0].busin;
                    string licno = query[0].licno;
                    string contact = ddlcontacttype.SelectedValue;
                    string comments = txtcomment.Text;
                    string js = "Confirmation('" + business.Replace("'", "`") + "','" + licno + "','" + contact + "','" + comments + "');";
                    ScriptManager.RegisterStartupScript(Page, GetType(), "scr", js, true);
                }
                else
                {
                    if (contacttype == 3 && licensestatus == "808")
                    {
                        string contact = ddlcontacttype.SelectedValue;
                        string comments = txtcomment.Text;

                        string js = "Warning('" + contact + "','" + comments + "');";
                        ScriptManager.RegisterStartupScript(Page, GetType(), "scr", js, true);
                    }
                    else
                    {

                        Person_Details.Licensing_Details.Insert_ContactDetails(Convert.ToInt32(hfdcontactid.Value), hfdpid.Value, Convert.ToInt32(ddlcontacttype.SelectedValue), hfdrelid.Value, txtcomment.Text.ToString(), "Current", DateTime.Now.ToShortDateString(), "", Session["UID"].ToString(), Session["UID"].ToString(), txt_percentage.Text);
                        altbox("Record inserted successfully.");
                         Clear();
                    }
                }

                if (contacttype == 3)
                {
                    using (Person_Details.Person_LicenseDataContext plc = new Person_Details.Person_LicenseDataContext())
                    {
                        Person_Details.tbl_PersonDetail obj = new Person_Details.tbl_PersonDetail();
                        obj = plc.tbl_PersonDetails.Where(c => c.Person_ID == Convert.ToInt32(hfdrelid.Value)).SingleOrDefault();
                        //if (obj.object_type != 1)
                        //    Name = obj.Business;
                        //else
                        //    Name = obj.First_Name + ' ' + obj.Middle_Name + ' ' + obj.Last_Name;
                        //address = obj.Address1;
                        email = obj.Email;
                        Person_Details.tbl_PersonDetail objq = new Person_Details.tbl_PersonDetail();
                        objq = plc.tbl_PersonDetails.Where(c => c.Person_ID == Convert.ToInt32(hfdpid.Value)).SingleOrDefault();
                        if (objq.object_type != 1)
                            Name = objq.Business;
                        else
                            Name = objq.First_Name + ' ' + objq.Middle_Name + ' ' + objq.Last_Name;
                        address = objq.Address1;
                    }

                    DataTable dt = new DataTable();

                    dt = Utilities_Licensing.GetNameandLicNumber(Convert.ToInt32(hfdpid.Value));
                    string st = @"<table cellspacing='0'  >
                              <tr>
                              <td style='text-align:left;' colspan='3'><b>This email is to alert you that you have been identified as the supervising pharmacist of this pharmacy:</b><br/><br/></td>
                              </tr>
                              <tr>
                              <td style='text-align: left;width:130px'><b>Pharmacy Name:</b></td><td style='text-align:middle;'>" + Name +
                                  "</td></tr><tr><td style='text-align:left;width:130px'><b>Pharmacy Address:</b></td><td style='text-align:middle;'>" + address + "</td>";
                    //if (dt.Rows[0]["object_type"].ToString() == "1")
                    //    st = st + @"</tr><tr><td style='text-align:left;width:130px'><b>Respondent :</b></td><td style='text-align:middle;'>" + Convert.ToInt32(hfdpid.Value) + "' target='_blank' >" + Name + "</a></td></tr>";
                    //else
                    //    st = st + @"</tr><tr><td style='text-align:left;width:130px'><b>Respondent :</b></td><td style='text-align:middle;'>" + Convert.ToInt32(hfdpid.Value) + "' target='_blank' >" + Name + "</a></td></tr>";
                    foreach (DataRow dr in dt.Rows)
                    {

                        st = st + @"<tr>
                             <td style='text-align: left;width:130px'><b>License Type :</b></td>  
                             <td style='text-align:middle;'>" + dr["License_Type"].ToString() + "</td></tr>";
                        st = st + @"<tr>
                            <td style='text-align:left;width:130px'><b>License Status :</b></td>
                            <td style='text-align:middle;'>" + dr["LicenseStatus"].ToString() + "</td></tr>";
                        st = st + @"<tr>
                            <td style='text-align:left;width:130px'><b>License # :</b></td>
                            <td style='text-align:middle;'>" + dr["Lic_no"].ToString() + "</td></tr>";
                    }
                    st = st + @"<tr style='margin-top:10px;'>
                              <td style='text-align:left;' colspan='3'></b><br/><br/><b>If you believe this is in error, please email tking@albop.com </td>
                              </tr>";
                    st = st + "</table>";
                    
                    if (email != null && email != "")
                        Mail.SendMail("", email, "", "Supervising Pharmacist", st);
                }

              
            }
            catch(Exception ex)
            {
                Response.Write(ex.ToString());
            }
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
            int pid = Utilities_Licensing.Insert_Person_Detail(0, txtpersonfname.Text.ToString(), txtpersonmname.Text.ToString(), txtpersonlname.Text.ToString(), txtpersonmaidenname.Text.ToString(), ddlpersongender.SelectedValue, txtpersondob.Text.ToString(), txtpersonssn.Text.ToString(), txtpersonage.Text.ToString(), txtpersonaddress1.Text.ToString(), txtpersonaddress2.Text.ToString(), txtpersoncity.Text.ToString(), ddlpersonstate.SelectedValue, ddlpersoncounty.SelectedValue, txtpersonzip.Text.ToString(), ddlpersonphone.SelectedItem.Text, txtpersonphone.Text.ToString(), ddlpersonaltphone.SelectedItem.Text, txtpersonaltphone.Text.ToString(), ddlpersonmstatus.SelectedItem.Text, txtpersonfax.Text.ToString(), txtpersonemail.Text.ToString(), rdlpersonuscitizen.SelectedValue, ddlpersonsuffix.SelectedValue, Session["UID"].ToString(), DateTime.Now.ToString(), Session["UID"].ToString(), DateTime.Now.ToString(), txtpersoncitizenexpdate.Text, txtpersoncpenumber.Text,ddlethincity.SelectedValue);
            ScriptManager.RegisterStartupScript(Page, GetType(), "js", " InsertContact('" + pid + "')", true);
            PersonClear();
        }
        protected void btnbusinesssave_Click(object sender, EventArgs e)
        {
            int pid = Utilities_Licensing.Insert_Business_Details(0, txtbusiness.Text, txtbusinessownersname.Text, txtbusinessstartdate.Text, ddlbusinesstype.SelectedValue, txtbusinessfein.Text, txtbusinessaddress1.Text, txtbusinessaddress2.Text, txtbusinesscity.Text, ddlbusinessstate.SelectedValue, ddlbusinesscounty.SelectedValue, txtbusinesszip.Text, ddlbusinessphone.SelectedValue, txtbusinessphone.Text, ddlbusinessaltphone.SelectedValue, txtbusinessaltphone.Text, txtbusinessfax.Text, txtbusinessemail.Text, txtbusinessdea.Text, ddlbusinessstatus.SelectedValue, Session["UID"].ToString(), DateTime.Now.ToShortDateString(), Session["UID"].ToString(), DateTime.Now.ToShortDateString());
            ScriptManager.RegisterStartupScript(Page, GetType(), "js", " InsertContact('" + pid + "')", true);
            BusinessClear();
        }
        protected void btndel_Click(object sender, EventArgs e)
        {
            hfdpid.Value = Request.QueryString[0].ToString();
            Person_Details.Licensing_Details.Insert_ContactDetails(Convert.ToInt32(hfdcontactid.Value), hfdpid.Value, Convert.ToInt32(hfdcontact.Value), hfdrelid.Value, hfdcomment.Value, "Current", DateTime.Now.ToShortDateString(), "", Session["UID"].ToString(), Session["UID"].ToString(),txt_percentage.Text);
            altbox("Record inserted successfully.");
            Clear();
        }
        private void Clear()
        {
            hfdrelid.Value = "0";
            hfdcontactid.Value = "0";
            hfdcontact.Value = "0";
            hfdcomment.Value = "0";
            txtcomment.Text = "";
            ddlcontacttype.SelectedValue = "-1";
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
        private void altbox(string str)
        {
            string js = " afterpost('" + str + "');";
            ScriptManager.RegisterStartupScript(Page, GetType(), "scr", js, true);
        }
    }
}