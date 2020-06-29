using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ComplaintsLink;
using System.Data;
using Person_Details;

namespace Licensing.Complaints
{
    public partial class ComplaintSearch : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
            BindDropBox();
        }

        
        public void BindDropBox()
        {
            if (!IsPostBack)
            {
                
                utilities objutilities = new utilities();


                utilities.BindDropdown(ddl_source, 5);
              utilities.BindDropdown(ddl_category, 4);

                utilities.BindDropdown(ddl_gender, 18);
                utilities.BindDropdown(ddl_suffix, 12);

                utilities.BindDropdown(ddl_state, 9);
                utilities.BindDropdown(ddl_county, 10);
                utilities.BindDropdown(ddlethincity, 62);
                utilities.BindDropdown(ddl_mstatus, 19);
                utilities.Fill_Dropdown(ddl_personresp, "tbl_Login where UserType in (417,416,1136,1323,1391) Order by LastName", "isnull(LastName,'')+', '+isnull(FirstName,'')", "loginID", " ", "Select");
              utilities.Fill_Dropdown(ddl_investigater, "tbl_Login where UserType in (417,416) Order by LastName", "isnull(LastName,'')+', '+isnull(FirstName,'')", "loginID", " ", "Select");
                utilities.Fill_Dropdown(ddl_investigater1, "tbl_Login where UserType in (417,416) Order by LastName", "isnull(LastName,'')+', '+isnull(FirstName,'')", "loginID", " ", "Select");
                
                ddl_investigater1.Items.Add(new ListItem("Closed Files", "-2"));
                ddl_personresp.Items.Add(new ListItem("Closed Files", "-2"));
              ddl_investigater.Items.Add(new ListItem("Closed Files", "-2"));
              
             }
        
        }

       

        public string openapp1(string pid)
        {    


            return "javascript:return Openapplication('" + pid + "')";

        }



      

        protected void btn_clear_Click(object sender, EventArgs e)
        {
            ddl_source.SelectedValue = "-1";
            ddl_category.SelectedValue = "-1";
            txt_daterec.Text = "";
            txt_dateassigned.Text = "";
            txt_dateinRec.Text = "";
            ddl_investigater1.SelectedValue = "-1";
            ddl_personresp.SelectedValue = "-1";
            txtcomplainant.Text = "";
            ddl_investigater.SelectedValue = "-1";
        }
        protected void btn_search_click(object sender, EventArgs e)
        { 
            
        }
        protected void btn_submit_click(object sender, EventArgs e)
        {

            string complaintnumber = "";
            DateTime dt = System.DateTime.Now;
            string year = dt.Year.ToString();


            if (ddl_source.SelectedValue == "1257" || ddl_source.SelectedValue == "1038" || ddl_source.SelectedValue == "1039" || ddl_source.SelectedValue == "1040" || ddl_source.SelectedValue == "1041" || ddl_source.SelectedValue == "1417" || ddl_source.SelectedValue == "1419")
                complaintnumber = year.Substring(2) + "-L-";
            else if (ddl_source.SelectedValue == "1259")
                complaintnumber = year.Substring(2) + "-F-";
            else
                complaintnumber = year.Substring(2) + "-";


            string temp = "";

            TbL_Complaint objtblComplaint = new TbL_Complaint();           
          

       

                    objtblComplaint.Complaint_ID = 0;
                    objtblComplaint.Respondent_type = "1";
                    objtblComplaint.Respondent_ID = Convert.ToInt32(hfdpid.Value);
                    objtblComplaint.Complaint_Number =  complaintnumber;
                    objtblComplaint.Source_Id = ddl_source.SelectedValue.ToString();

                    objtblComplaint.Category_Id = ddl_category.SelectedValue.ToString();
            if (txt_daterec.Text != "")
                objtblComplaint.DateReceived = Convert.ToDateTime(txt_daterec.Text.ToString());
            else
                objtblComplaint.DateReceived = null;

                    //if(txt_datedocketed.Text!="")
                    //objtblComplaint.DateDocketed = txt_datedocketed.Text.ToString();

                    objtblComplaint.Address1 = "";
                    objtblComplaint.Address2 = "";

                    objtblComplaint.City = "";
                    objtblComplaint.State = "";
                    objtblComplaint.Zip = "";
                    objtblComplaint.PersonResponcible_ID = ddl_personresp.SelectedValue.ToString();
                    objtblComplaint.ComplaintType = "1";

                    objtblComplaint.InvestiGator_ID = ddl_investigater.SelectedValue.ToString();
            objtblComplaint.SecondInvestigatiorID = ddl_investigater1.SelectedValue.ToString();
            if (txt_dateassigned.Text.Length > 0)
                        objtblComplaint.DateInvestigatorAssigned = Convert.ToDateTime(txt_dateassigned.Text.ToString());

                    if (txt_dateinRec.Text.Length > 0)
                        objtblComplaint.DateInvestigatorReceived = Convert.ToDateTime(txt_dateinRec.Text.ToString());

                    objtblComplaint.Consultant = "0";
                    objtblComplaint.CompanionCase_ID = "0";

                    objtblComplaint.Compainant = txtcomplainant.Text;//Convert.ToInt16(ddl_complainant.SelectedValue.ToString());

                    objtblComplaint.Complaint_Status = "885";
                    objtblComplaint.check_number = temp;
            objtblComplaint.Create_User = Convert.ToInt32(Session["UID"].ToString());
            objtblComplaint.Create_Date = Convert.ToDateTime(DateTime.Now.ToShortDateString());

            ComplaintsLink.Complaints.ComplaintInsertValues(objtblComplaint);

                    GetComplaintNumber();

                
            Response.Redirect("../PersonLicensing/PersonDetails.aspx?pid=" + hfdpid.Value+"&iscmp=1");

        }



        protected void btn_clear_click(object sender, EventArgs e)
        {
          
        }


        protected void GetComplaintNumber()
        {
            using (ComplaintsTabLinq.ComplaintsTabDataContext cdc = new ComplaintsTabLinq.ComplaintsTabDataContext())
            {
                string cmpnumber = ""; string respondent="";
                ComplaintsTabLinq.TbL_Complaint cmp = cdc.TbL_Complaints.OrderByDescending(c => c.Complaint_ID).First();
                cmpnumber = cmp.Complaint_Number;

                using (Person_Details.Person_LicenseDataContext plc = new Person_Details.Person_LicenseDataContext())
                {
                    Person_Details.tbl_PersonDetail obj = new Person_Details.tbl_PersonDetail();
                    obj = plc.tbl_PersonDetails.Where(c => c.Person_ID == cmp.Respondent_ID).SingleOrDefault();
                    if (obj.object_type != 1)
                        respondent = obj.Business;
                    else
                        respondent = obj.First_Name + ' ' + obj.Middle_Name + ' ' + obj.Last_Name;
                }
                if (ddl_source.SelectedValue == "1257" || ddl_source.SelectedValue == "1038" || ddl_source.SelectedValue == "1039" || ddl_source.SelectedValue == "1040" || ddl_source.SelectedValue == "1041" || ddl_source.SelectedValue=="1259"|| ddl_source.SelectedValue == "1417" || ddl_source.SelectedValue == "1419")
                {
                    Mail.SendMail("", System.Configuration.ConfigurationManager.AppSettings["cmpcreated"].ToString(), "", "Case  Created ", "A case has been created with the number  : " + cmpnumber + "<br/><br/>Respondent  : " + respondent);
                }
                else
                {
                    Mail.SendMail("", System.Configuration.ConfigurationManager.AppSettings["cmpcreated1"].ToString(), "", "Case  Created ", "A case has been created with the number  : " + cmpnumber + "<br/><br/>Respondent  : " + respondent);
                }
            }
        }





        public void Clear()
        {
            hfdpid.Value = "0";
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



        protected void btnsave_Click(object sender, EventArgs e)
        {
            int pid = Licensing_Details.Insert_Values(Convert.ToInt32(hfdpid.Value), txtfname.Text.ToString(), txtmname.Text.ToString(), txtlname.Text.ToString(), txtmaidenname.Text.ToString(), ddl_gender.SelectedValue, txtdob.Text.ToString(), txtssn.Text.ToString(), txtage.Text.ToString(), txtaddress1.Text.ToString(), txtaddress2.Text.ToString(), txtcity.Text.ToString(), ddl_state.SelectedValue, ddl_county.SelectedValue, txtzip.Text.ToString(), ddl_phone.SelectedItem.Text, txtphone.Text.ToString(), ddl_altphone.SelectedItem.Text, txtaltphone.Text.ToString(), ddl_mstatus.SelectedItem.Text, txtfax.Text.ToString(), txtemail.Text.ToString(), rdl_uscitizen.SelectedValue, ddl_suffix.SelectedValue, Session["UID"].ToString(), DateTime.Now.ToString(), Session["UID"].ToString(), DateTime.Now.ToString(), txtcitizenexpdate.Text, txtcpenumber.Text, ddlethincity.SelectedValue);
            ScriptManager.RegisterStartupScript(Page, GetType(), "js", " bindautogrd('" + pid + "' ,'" + txtfname.Text.ToString() + "','" + txtlname.Text.ToString() + "','" + txtssn.Text + "')", true);
            Clear();
        }










    }
}