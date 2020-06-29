using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using License_Data;
namespace Licensing.PersonLicensing
{
    public partial class EditDemographiceNew_Person : System.Web.UI.Page
    {

        string lawful1 = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //Utilities_Licensing.BindDropdown(ddl_suffix, 12);
                Utilities_Licensing.BindDropdown(ddl_gender, 18);
                Utilities_Licensing.BindDropdown(ddl_maritalstatus, 19);
                Utilities_Licensing.BindDropdown(ddl_state, 9);
                Utilities_Licensing.BindDropdown(ddl_county, 10);
                Utilities_Licensing.BindDropdown(ddlethincity, 62);
                Utilities_Licensing.BindDropdown(ddl_suffix, 12);
                //string name = Request.QueryString[0].ToString();
               // txtuser.Text =  Session["UserDetailname"].ToString();
               // lstdoc1.DataSource = Utilities_Licensing.Get_Values("tbl_lkp_us", "*", " isus=1");
                lstdoc1.DataTextField = "Item";
                lstdoc1.DataValueField = "chkid";
                lstdoc1.DataBind();
               // lstdoc2.DataSource = Utilities_Licensing.Get_Values("tbl_lkp_us", "*", " isus=0");
                lstdoc2.DataTextField = "Item";
                lstdoc2.DataValueField = "chkid";
                lstdoc2.DataBind();
                //string name = Request.QueryString[0].ToString();
                Bind_PersonDetails();
                hfdpid.Value = Request.QueryString[0].ToString();
                //txtverdt.Text = DateTime.Now.ToShortDateString();
            }
            //txtuser.Text = "admin";//Session["UserDetailname"].ToString();
        }

        public void Bind_PersonDetails()
        {


            List<License_Data.tbl_PersonDetail> lst = License_Data.License_Details.Get_EditDemographics_Data(Convert.ToInt32(Request.QueryString[0].ToString()));
            License_Data.tbl_PersonDetail obj = lst.Where(c => c.Person_ID == Convert.ToInt32(Request.QueryString[0].ToString())).SingleOrDefault();



           // DataTable dt = utilities_Person.EditDemographics(Convert.ToInt32(Request.QueryString[0].ToString()));
           // DataTable law_dt = utilities_Person.Get_Values1("tbl_person_law", "*", " personID=" + Request.QueryString[0].ToString());

           
                hfdpersonid.Value = Convert.ToInt32(obj.Person_ID).ToString();
            string trining = obj.Training_Completed;
            if (trining == "1")
            {
                chk_training.Checked = true;
            }
            else
                chk_training.Checked = false;


            txt_fname.Text = obj.First_Name;
                txt_mname.Text = obj.Middle_Name;
                txt_lname.Text = obj.Last_Name;
                //ddl_suffix.SelectedItem.Text = dt.Rows[0][""].ToString();
                txt_maidenname.Text = obj.Madian_Name;
                if (obj.Ethincity != null)
                    ddlethincity.SelectedValue = obj.Ethincity;
                string dob = Convert.ToDateTime(obj.DOB).ToString("MM/dd/yyyy");
                if (dob != "" && dob != "01/01/1900" && dob != "01/01/0001" && dob != null)
                    txt_dob.Text = Convert.ToDateTime(obj.DOB).ToString("MM/dd/yyyy");
                else
                    txt_dob.Text = "";
                
                txt_age.Text = obj.Age;
            try
            {
                txt_ssn.Text = Utilities_Licensing.SSN(obj.Person_ID.ToString());
            }
            catch(Exception ex)
            {
                txt_ssn.Text = ex.ToString();

            }
                txtcpe.Text = obj.CPE;
                string suffix = "";
                suffix = obj.Status;
                if (ddl_suffix.Items[0].Text != suffix)
                {
                    ddl_suffix.Items[0].Selected = false;
                    if (ddl_suffix.Items.FindByValue(suffix) != null)
                        ddl_suffix.Items.FindByValue(suffix).Selected = true;
                }
                string gender = "";
                gender = obj.Gender;
                if (ddl_gender.Items[0].Text != gender)
                {
                    ddl_gender.Items[0].Selected = false;
                    if (ddl_gender.Items.FindByValue(gender) != null)
                        ddl_gender.Items.FindByValue(gender).Selected = true;
                }
                //ddl_gender.SelectedItem.Text = dt.Rows[0]["Gender"].ToString();
                string maritalstatus = "";
                maritalstatus = obj.Martial_Status;
                if (ddl_maritalstatus.Items[0].Text != maritalstatus)
                {
                    ddl_maritalstatus.Items[0].Selected = false;
                    if (ddl_maritalstatus.Items.FindByText(maritalstatus) != null)
                        ddl_maritalstatus.Items.FindByText(maritalstatus).Selected = true;
                }
                //ddl_maritalstatus.SelectedItem.Text = dt.Rows[0]["Martial_Status"].ToString();
                //rdl_uscitizen.SelectedValue = dt.Rows[0]["IS_US_Citizen"].ToString();
                txt_phone.Text = obj.Phone;
                txt_altphone.Text = obj.Alternate_Phone;
                txt_email.Text =obj.Email;
                txt_fax.Text = obj.Fax;
                txt_address1.Text = obj.Address1;
                txt_address2.Text = obj.Address2;

                txt_city.Text =obj.City;
                string state = "";
                state = obj.State;
                if (ddl_state.Items[0].Text != state)
                {
                    ddl_state.Items[0].Selected = false;
                    if (ddl_state.Items.FindByValue(state) != null)
                        ddl_state.Items.FindByValue(state).Selected = true;
                }
                //ddl_state.SelectedItem.Text = dt.Rows[0]["State"].ToString();
                string county = "";
                county  =obj.County;
                if (ddl_county.Items[0].Text != county)
                {
                    ddl_county.Items[0].Selected = false;
                    if (ddl_county.Items.FindByValue(county) != null)
                        ddl_county.Items.FindByValue(county).Selected = true;
                }
                //ddl_county.SelectedItem.Text = dt.Rows[0]["County"].ToString();
                txt_zip.Text =obj.Zip;
                rdl_uscitizen.SelectedValue = obj.IS_US_Citizen;
              
                if (obj.IS_US_Citizen == "1")
                {
                    pnl1.Visible = true;
                    string citizen = Convert.ToDateTime(obj.Citizen_Expiration_Date).ToString("MM/dd/yyyy");
                    if (citizen != "01/01/0001" && citizen != "" && citizen != null && citizen != "01/01/1900")
                    {
                        txtcitizenexpirationdate.Text = Convert.ToDateTime(obj.Citizen_Expiration_Date).ToString("MM/dd/yyyy");
                    }
                    else
                        txtcitizenexpirationdate.Text = "";
                    
                }
                else
                {
                    pnl1.Visible = false;
                    txtcitizenexpirationdate.Text = "";
                }
                
                chk_usdata.Items.Clear();
                string uscitizen = rdl_uscitizen.SelectedValue;
                if (uscitizen == "0")
                {
                    List<tbl_lkp_us> temp = License_Details.Get_TrueUSList(uscitizen);
                    // DataTable temp = Utilities_Licensing.Get_Values("tbl_lkp_us where isus='1'", "chkid", "Item", "");

                    for (int i = 0; i < temp.Count; i++)
                    {
                        ListItem li = new ListItem();
                        li.Text = temp[i].Item.ToString();
                        li.Value = temp[i].chkid.ToString();
                        //ListItem li = new ListItem(temp.Rows[i][1].ToString(), temp.Rows[i][0].ToString());
                        chk_usdata.Items.Add(li);
                    }

                }
                else if(uscitizen=="1")
                {
                    List<tbl_lkp_us> temp1 = License_Details.Get_FlaseUSlist(uscitizen);
                    //DataTable temp = Utilities_Licensing.Get_Values("tbl_lkp_us where isus='0'", "chkid", "Item", "");

                    for (int i = 0; i < temp1.Count; i++)
                    {
                        ListItem list = new ListItem();
                        list.Text = temp1[i].Item.ToString();
                        list.Value = temp1[i].chkid.ToString();
                        //ListItem li = new ListItem(temp.Rows[i][1].ToString(), temp.Rows[i][0].ToString());
                        chk_usdata.Items.Add(list);
                    }
                }


                #region Insertion of Lawful Table Data

                List<License_Data.tbl_person_law> lst1 = License_Data.License_Details.Get_EditDemographics_PersonLaw(Convert.ToInt32(Request.QueryString[0].ToString()));


                DataTable law_dt = Utilities_Licensing.Get_Values1("tbl_person_law", "*", " personID=" + Request.QueryString[0].ToString());
                if (law_dt.Rows.Count > 0)
                {
                    txtuser.Text = law_dt.Rows[0]["Createdby"].ToString();
                    string verifydate = "";
                    verifydate = law_dt.Rows[0]["verifydt"].ToString();
                    if (verifydate != null && verifydate != "" && verifydate != "01/01/1900" && verifydate != "01/01/0001")
                        txtverdt.Text = Convert.ToDateTime(law_dt.Rows[0]["verifydt"]).ToString("MM/dd/yyyy");
                    else
                        txtverdt.Text = DateTime.Now.ToString("MM/dd/yyyy");
                    string lawful = law_dt.Rows[0]["lawful"].ToString();
                    string[] docs = law_dt.Rows[0]["seldocs"].ToString().Split(',');
                    if (rdl_uscitizen.SelectedValue == "Yes")
                    {

                        foreach (string dstr in docs)
                            if (chk_usdata.Items.FindByValue(dstr) != null)
                                chk_usdata.Items.FindByValue(dstr).Selected = true;
                        Page.RegisterStartupScript("js", "<script language='javascript'>lawfulchange(1)</script>");
                    }
                    else
                    {

                        foreach (string dstr in docs)
                            if (chk_usdata.Items.FindByValue(dstr) != null)
                                chk_usdata.Items.FindByValue(dstr).Selected = true;
                        Page.RegisterStartupScript("js", "<script language='javascript'>lawfulchange(0)</script>");
                    }
                    if (lawful == "1")

                        rdblawful.Items[0].Selected = true;

                    else
                        rdblawful.Items[1].Selected = true;
                    string js = "<script language='javascript'>lawfulchange1(" + rdl_uscitizen.SelectedValue + ");lawfulchange(" + rdblawful.SelectedValue + ");</script>";
                    Page.RegisterStartupScript("js", js);
                }
                else
                    txtverdt.Text = DateTime.Now.ToString("MM/dd/yyyy");

                if (rdblawful.Items[0].Selected.ToString() == "True")
                    lawful1 = "1";
                else
                    lawful1 = "0";


                #endregion
                
           
        }


   

        private void  altbox(string str)
        {
            string js = " afterpost('" + str + "');parent.rebind_genral();";
            ScriptManager.RegisterStartupScript(Page, GetType(), "scr", js, true);
          
        }

       
        protected void btn_address_Click(object sender, EventArgs e)
        {

            License_Data.License_Details.Edit_AddressInfo(Convert.ToInt32(Request.QueryString[0].ToString()), txt_address1.Text, txt_address2.Text, txt_city.Text, ddl_state.SelectedItem.Value, ddl_county.SelectedItem.Value, txt_zip.Text, Session["UID"].ToString(), DateTime.Now.ToShortDateString());
            altbox("Updated successfully.");

        }

        protected void btn_contact_Click(object sender, EventArgs e)
        {

            License_Data.License_Details.Edit_ContactInfo(Convert.ToInt32(Request.QueryString[0].ToString()), txt_phone.Text, txt_altphone.Text, txt_fax.Text, txt_email.Text, Session["UID"].ToString(), DateTime.Now.ToShortDateString());
            altbox("Updated successfully.");
        }

        protected void btn_personal_Click(object sender, EventArgs e)
        {
            List<Person_Details.tbl_PersonDetail> dt = Person_Details.Licensing_Details.GetSSN(txt_ssn.Text);
            string training = "";
            if (chk_training.Checked == true)
                training = "1";
            else
                training = "0";
            if (dt.Count > 0)
            {
                if (dt[0].Person_ID==Convert.ToInt32(hfdpid.Value))
                {
                    string dob = txt_dob.Text;
                    if (dob != "")
                    {
                        dob = txt_dob.Text;
                    }
                    else
                    {
                        dob = "01/01/1900";
                    }
                    License_Data.License_Details.Edit_PersonalInfo(Convert.ToInt32(Request.QueryString[0].ToString()), txt_fname.Text, txt_mname.Text, txt_lname.Text, txt_maidenname.Text, ddl_gender.SelectedItem.Value, dob, txt_ssn.Text,
         txt_age.Text, txtcpe.Text, ddl_maritalstatus.SelectedItem.Text, ddl_suffix.SelectedValue, Session["UID"].ToString(), DateTime.Now.ToShortDateString(), ddlethincity.SelectedValue,training);
                    altbox("Updated successfully.");
                }
                else
                {
                    string js = " altbox('This SSN already exists in the system.');Popup();";
                    ScriptManager.RegisterStartupScript(Page, GetType(), "scr", js, true);
                }
                
            }
            else
            {
                string dob = txt_dob.Text;
                if (dob != "")
                {
                    dob = txt_dob.Text;
                }
                else
                {
                    dob = "01/01/1900";
                }
                License_Data.License_Details.Edit_PersonalInfo(Convert.ToInt32(Request.QueryString[0].ToString()), txt_fname.Text, txt_mname.Text, txt_lname.Text, txt_maidenname.Text, ddl_gender.SelectedItem.Value, dob, txt_ssn.Text,
         txt_age.Text, txtcpe.Text, ddl_maritalstatus.SelectedItem.Text, ddl_suffix.SelectedValue, Session["UID"].ToString(), DateTime.Now.ToShortDateString(), ddlethincity.SelectedValue,training);
                altbox("Updated successfully.");
            }

        }

      
           
          protected void btn_uscitizen_Click(object sender, EventArgs e)
        {

            

            string chklist = "";

            for (int i = 0; i < chk_usdata.Items.Count; i++)
            {

                if (chk_usdata.Items[i].Selected == true)
                    chklist += chk_usdata.Items[i].Value + ",";

            }
            if (chklist != "")
                chklist = chklist.Substring(0, chklist.Length - 1);
            lawful1 = rdblawful.SelectedValue;

            License_Data.License_Details.Edit_USCitizen(Convert.ToInt32(Request.QueryString[0].ToString()), rdl_uscitizen.SelectedValue,txtcitizenexpirationdate.Text, Session["UID"].ToString(), DateTime.Now.ToShortDateString());
            License_Data.License_Details.Insert_PersonLaw_Data(0, Convert.ToInt32(Request.QueryString[0].ToString()), lawful1, txtverdt.Text, chklist, Session["Uname"].ToString(), DateTime.Now.ToShortDateString());
            altbox("Updated successfully.");
            Bind_PersonDetails();
        }

          protected void rdl_uscitizen_SelectedIndexChanged(object sender, EventArgs e)
          {
              string val = "";
              val = rdl_uscitizen.SelectedValue;
              chk_usdata.Items.Clear();

              if (val == "0")
              {
                  pnl1.Visible = false;
                  txtcitizenexpirationdate.Text = "";
                  List<tbl_lkp_us> temp = License_Details.Get_TrueUSList(val);
                  //DataTable temp = Utilities_Licensing.Get_Values("tbl_lkp_us where isus='1'", "chkid", "Item", "");

                  for (int i = 0; i < temp.Count; i++)
                  {
                      ListItem li = new ListItem();
                      li.Text = temp[i].Item.ToString();
                      li.Value = temp[i].chkid.ToString();
                      //ListItem li = new ListItem(temp.Rows[i][1].ToString(), temp.Rows[i][0].ToString());
                      chk_usdata.Items.Add(li);
                  }

              }
              else
              {
                  pnl1.Visible = true;
                  List<License_Data.tbl_PersonDetail> lst = License_Data.License_Details.Get_EditDemographics_Data(Convert.ToInt32(Request.QueryString[0].ToString()));
                  License_Data.tbl_PersonDetail obj = lst.Where(c => c.Person_ID == Convert.ToInt32(Request.QueryString[0].ToString())).SingleOrDefault();
                  string citizen = Convert.ToDateTime(obj.Citizen_Expiration_Date).ToString("MM/dd/yyyy");
                  if (citizen != "01/01/0001" && citizen != "" && citizen != null && citizen != "01/01/1900")
                  {
                      txtcitizenexpirationdate.Text = Convert.ToDateTime(obj.Citizen_Expiration_Date).ToString("MM/dd/yyyy");
                  }
                  else
                      txtcitizenexpirationdate.Text = "";

                  List<tbl_lkp_us> temp1 = License_Details.Get_FlaseUSlist(val);
                  //DataTable temp = Utilities_Licensing.Get_Values("tbl_lkp_us where isus='0'", "chkid", "Item", "");

                  for (int i = 0; i < temp1.Count; i++)
                  {
                      ListItem list = new ListItem();
                      list.Text = temp1[i].Item.ToString();
                      list.Value = temp1[i].chkid.ToString();
                      //ListItem li = new ListItem(temp.Rows[i][1].ToString(), temp.Rows[i][0].ToString());
                      chk_usdata.Items.Add(list);
                  }

              }
          }

    }


}

