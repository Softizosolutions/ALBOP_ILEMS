using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
namespace Licensing.PersonLicensing
{
    public partial class EditDemoGrphics_Business : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Utilities_Licensing.BindDropdown(ddl_state, 9);
                Utilities_Licensing.BindDropdown(ddl_county, 10);
                Utilities_Licensing.BindDropdown(ddl_mailingstate, 9);
                Utilities_Licensing.BindDropdown(ddl_mailingcounty, 10);
                Business_Details();
                Bind_Buyer();
                Bind_Distributor();
                Bind_Operations();
                Bind_Typeoperations();
                Bind_USP();
                Bind_MailingAddress();
            }
        }
        public void Business_Details()
        {
            List<License_Data.tbl_PersonDetail> lst = License_Data.License_Details.Get_EditDemographics_Data(Convert.ToInt32(Request.QueryString[0].ToString()));
            License_Data.tbl_PersonDetail obj = lst.Where(c => c.Person_ID == Convert.ToInt32(Request.QueryString[0].ToString())).SingleOrDefault();
            hfdpersonid.Value = Convert.ToInt32(obj.Person_ID).ToString();

            txt_businessname.Text = obj.Business;
            txt_ownername.Text = obj.Ownersifdiff;
            txt_fein.Text = obj.FEIN;
            txt_dea.Text = obj.DEA;
            string dob = Convert.ToDateTime(obj.DOB).ToString("MM/dd/yyyy");
            if (dob != null && dob != "01/01/0001" && dob != "" && dob != "01/01/1900")
                txt_datestarted.Text = Convert.ToDateTime(obj.DOB).ToString("MM/dd/yyyy");
            else
                txt_datestarted.Text = "";
            
            txt_phone.Text = obj.Phone;
            txt_altphone.Text = obj.Alternate_Phone;
            txt_fax.Text = obj.Fax;
            txt_email.Text = obj.Email;
            txt_address1.Text = obj.Address1;
            txt_address2.Text = obj.Address2;
            txt_city.Text = obj.City;
            txt_zip.Text = obj.Zip;

           
                if (obj.SkipPayment == "True")
                {
                    chk_skippayment.Checked = true;
                }
                else
                {
                chk_skippayment.Checked = false;
                }
            txt_eprofilenumber.Text = obj.NABP_E_Profile_Number;
            string state = "";
            state = obj.State;
            if (ddl_state.Items[0].Text != state)
            {
                ddl_state.Items[0].Selected = false;
                if (ddl_state.Items.FindByValue(state) != null)
                    ddl_state.Items.FindByValue(state).Selected = true;
            }
            string county = "";
            county = obj.County;
            if (ddl_county.Items[0].Text != county)
            {
                ddl_county.Items[0].Selected = false;
                if (ddl_county.Items.FindByValue(county) != null)
                    ddl_county.Items.FindByValue(county).Selected = true;
            }
        }
        public void Bind_MailingAddress()
        {
            License_Data.USP_GetMailingAddressResult obj = License_Data.License_Details.GetMailingAddress(Convert.ToInt32(Request.QueryString[0].ToString()));
            if (obj != null)
            {
                hfdmailingaddressid.Value = obj.Mailing_Address_ID.ToString();
                txt_mailingaddress1.Text = obj.Address1;
                txt_mailingaddress2.Text = obj.Address2;
                txt_mailingcity.Text = obj.City;
                txt_mailingzip.Text = obj.Zip;
                if (ddl_mailingstate.Items.FindByText(obj.Mailingstate) != null)
                    ddl_mailingstate.Items.FindByText(obj.Mailingstate).Selected = true;
                if (ddl_mailingcounty.Items.FindByText(obj.MailngCounty) != null)
                    ddl_mailingcounty.Items.FindByText(obj.MailngCounty).Selected = true;
            }
        }
        private void Bind_USP()
        {
            List<License_Data.tbl_USP> usp = License_Data.License_Details.Edit_usp(Request.QueryString[0].ToString());
            if (usp.Count > 0)
            {
                License_Data.tbl_USP us = usp.Where(c => c.PersonID == Request.QueryString[0].ToString()).FirstOrDefault();
                hfdusp.Value = us.USPID.ToString();
                hfdpersonid.Value = us.PersonID;
                string usp795 = us.USP795;
                if (usp795 == "1")
                {
                    chkusp795.Checked = true;
                }
                else
                    chkusp795.Checked = false;

                string usp797 = us.USP797;
                if (usp797 == "1")
                {
                    chkusp797.Checked = true;
                }
                else
                    chkusp797.Checked = false;

                string usp797effdate = Convert.ToDateTime(us.Usp795EffectiveDate).ToString("MM/dd/yyyy");
                if (usp797effdate != null && usp797effdate != "01/01/0001" && usp797effdate != "01/01/1900" && usp797effdate != "")
                    txtusp797effcetivedate.Text = Convert.ToDateTime(us.Usp797Effective_Date).ToString("MM/dd/yyyy");
                else
                    txtusp797effcetivedate.Text = "";

                string usp795effdate = Convert.ToDateTime(us.Usp795EffectiveDate).ToString("MM/dd/yyyy");
                if (usp795effdate != null && usp795effdate != "01/01/0001" && usp795effdate != "01/01/1900" && usp795effdate != "")
                    txtusp795effectivedate.Text = Convert.ToDateTime(us.Usp795EffectiveDate).ToString("MM/dd/yyyy");
                else
                    txtusp795effectivedate.Text = "";
                
                
            }
            else
            {

            }
        }
        private void Bind_Buyer()
        {
            List<License_Data.tbl_Buyer> buyer = License_Data.License_Details.Edit_Buyer(Request.QueryString[0].ToString());
            if (buyer.Count > 0)
            {
                License_Data.tbl_Buyer buy = buyer.Where(c => c.PersonID == Request.QueryString[0].ToString()).SingleOrDefault();
                hfdbuyer.Value = buy.BuyersID.ToString();
                hfdpersonid.Value = Convert.ToInt32(buy.PersonID).ToString();
                string community = buy.CommuntiyPharmacies;
                if (community == "1")
                {
                    Chk_communitypharma.Checked = true;
                }
                else
                    Chk_communitypharma.Checked = false;

                string hospitals = buy.Hospitals;
                if (hospitals == "1")
                {
                    Chk_hospitals.Checked = true;
                }
                else
                    Chk_hospitals.Checked = false;

                string wholesalers = buy.OtherWholesalers;
                if (wholesalers == "1")
                {
                    Chk_Otherwholesale.Checked = true;
                }
                else
                    Chk_Otherwholesale.Checked = false;

                string physician = buy.Physicians_Or_Practioners;
                if (physician == "1")
                {
                    Chk_phisician.Checked = true;
                }
                else
                    Chk_phisician.Checked = false;

                string veterinarians = buy.Veterinarians;
                if (veterinarians == "1")
                {
                    Chk_veterinarians.Checked = true;
                }
                else
                    Chk_veterinarians.Checked = false;

                string others = buy.Others;
                if (others == "1")
                {
                    Chk_Other.Checked = true;
                }
                else
                    Chk_Other.Checked = false;

                txt_otherspecify.Text = buy.If_Others;
                txt_comments.Text = buy.Comments;
            }
            else
            {
            }
        }

        private void Bind_Distributor()
        {
            List<License_Data.tbl_Distributor> distributor = License_Data.License_Details.Edit_Distributor(Request.QueryString[0].ToString());
            if (distributor.Count > 0)
            {
                License_Data.tbl_Distributor dist = distributor.Where(c => c.PersonID == Request.QueryString[0].ToString()).FirstOrDefault();
                hfddistributor.Value = dist.DistributedID.ToString();
                hfdpersonid.Value = dist.PersonID;

                string controlled = dist.Controlled_Substances;
                if (controlled == "1")
                    chk_controledsubstance.Checked = true;
                else
                    chk_controledsubstance.Checked = false;

                string prescription = dist.Prescription_Drugs;
                if (prescription == "1")
                    chk_presbdrugs.Checked = true;
                else
                    chk_presbdrugs.Checked = false;

                string over = dist.Over_the_Counter_Drugs;
                if (over == "1")
                    chk_overCounter.Checked = true;
                else
                    chk_overCounter.Checked = false;

                string precursor = dist.Precursors_Chemicals;
                if (precursor == "1")
                    chk_precursor.Checked = true;
                else
                    chk_precursor.Checked = false;

                string medicinal = dist.Medicinal_Gases;
                if (medicinal == "1")
                    chk_medicalgases.Checked = true;
                else
                    chk_medicalgases.Checked = false;

                string others = dist.Others;
                if (others == "1")
                    chk_other_dist.Checked = true;
                else
                    chk_other_dist.Checked = false;

                txt_precursorchemical.Text = dist.Please_Specify_Over_Counter_Drug;
                txt_ifotherspecify.Text = dist.IF_Other;
                txtdiscomments.Text = dist.Comments;
            }
            else
            {
            }
        }

        private void Bind_Operations()
        {
            List<License_Data.tbl_Operation> operations = License_Data.License_Details.Edit_Operation(Request.QueryString[0].ToString());
            if (operations.Count > 0)
            {
                License_Data.tbl_Operation oper = operations.Where(c => c.PersonID == Request.QueryString[0].ToString()).FirstOrDefault();
                hfdoperation.Value = oper.OperationsID.ToString();
                hfdpersonid.Value = oper.PersonID;

                txt_moday_friday.Text = oper.Monday_Friday;
                txt_saturday.Text = oper.Saturday;
                txt_sunday.Text = oper.Sunday;
                txt_comments_operations.Text = oper.Comments;
            }
            else
            {
            }
        }

        private void Bind_Typeoperations()
        {
            List<License_Data.tbl_TypeOperation> typeoperations = License_Data.License_Details.Edit_typeoperation(Request.QueryString[0].ToString());
            if (typeoperations.Count > 0)
            {
                License_Data.tbl_TypeOperation operation = typeoperations.Where(c => c.PersonID == Request.QueryString[0].ToString()).SingleOrDefault();
                hfdtypeoperation.Value = operation.TypeOperationID.ToString();
                hfdpersonid.Value = operation.PersonID;

                string fullservice = operation.Full_Service;
                if (fullservice == "1")
                    chk_fullservice.Checked = true;
                else
                    chk_fullservice.Checked = false;

                string manufacturer = operation.Manufacturer;
                if (manufacturer == "1")
                    chk_manufarer.Checked = true;
                else
                    chk_manufarer.Checked = false;

                string repackager = operation.Repackager;
                if (repackager == "1")
                    chk_repackager.Checked = true;
                else
                    chk_repackager.Checked = false;

                string buying = operation.Buying_Group;
                if (buying == "1")
                    chk_byinggroup.Checked = true;
                else
                    chk_byinggroup.Checked = false;

                string import = operation.Import_Export;
                if (import == "1")
                    chk_import_export.Checked = true;
                else
                    chk_import_export.Checked = false;

                string Distribution = operation.Distribution_Center;
                if (Distribution == "1")
                    chk_distributemulphar.Checked = true;
                else
                    chk_distributemulphar.Checked = false;

                string Virtual = operation.Virtual;
                if (Virtual == "1")
                    chk_virtual.Checked = true;
                else
                    chk_virtual.Checked = false;

                string sterile = operation.Sterile_Compounding;
                if (sterile == "1")
                    chk_streliecomp.Checked = true;
                else
                    chk_streliecomp.Checked = false;

                string nonsterile = operation.Non_Sterile;
                if (nonsterile == "1")
                    chk_nonsterilcomp.Checked = true;
                else
                    chk_nonsterilcomp.Checked = false;

                string other = operation.Other;
                if (other == "1")
                    chk_typeother.Checked = true;
                else
                    chk_typeother.Checked = false;

                txt_pharmacistname.Text = operation.Pharmacist_Name;
                txt_operationsotherspecify.Text = operation.IF_Other;
                txt_operationcomments.Text = operation.Comments;
            }
            else
            {
            }
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
        protected void btn_business_Click(object sender, EventArgs e)
        {
          
            License_Data.License_Details.Edit_businessInfo(Convert.ToInt32(Request.QueryString[0].ToString()),txt_businessname.Text,txt_ownername.Text,txt_datestarted.Text,txt_fein.Text,txt_dea.Text, Session["UID"].ToString(), DateTime.Now.ToShortDateString(),chk_skippayment.Checked.ToString(),txt_eprofilenumber.Text);
            altbox("Updated successfully.");
        }
        protected void btnuspsubmit_Click(object sender, EventArgs e)
        {
            string usp795 = "";
            if (chkusp795.Checked == true)
                usp795 = "1";
            else
                usp795 = "0";

            string usp797 = "";
            if (chkusp797.Checked == true)
                usp797 = "1";
            else
                usp797 = "0";
            if (hfdusp.Value == "0")
            {
                License_Data.License_Details.Edit_USP(Convert.ToInt32(hfdusp.Value), Request.QueryString[0].ToString(), usp797, usp795, txtusp797effcetivedate.Text, txtusp795effectivedate.Text,Session["UID"].ToString());
                altbox("Inserted successfully.");
            }
            else
            {
                License_Data.License_Details.Edit_USP(Convert.ToInt32(hfdusp.Value), Request.QueryString[0].ToString(), usp797, usp795, txtusp797effcetivedate.Text, txtusp795effectivedate.Text,Session["UID"].ToString());
                altbox("Updated successfully.");
            }
            Bind_USP();
        }
        protected void btnbuyers_Click(object sender, EventArgs e)
        {
            string community = "";
            if (Chk_communitypharma.Checked == true)
                community = "1";
            else
                community = "0";
            string hospitals = "";
            if (Chk_hospitals.Checked == true)
                hospitals = "1";
            else
                hospitals = "0";
            string otherwholesaler = "";
            if (Chk_Otherwholesale.Checked == true)
                otherwholesaler = "1";
            else
                otherwholesaler = "0";
            string physician = "";
            if (Chk_phisician.Checked == true)
                physician = "1";
            else
                physician = "0";
            string veternaried = "";
            if (Chk_veterinarians.Checked == true)
                veternaried = "1";
            else
                veternaried = "0";
            string others = "";
            if (Chk_Other.Checked == true)
                others = "1";
            else
                others = "0";
            if (hfdbuyer.Value == "0")
            {
                License_Data.License_Details.Edit_Buyers(Convert.ToInt32(hfdbuyer.Value), Request.QueryString[0].ToString(), community, hospitals, otherwholesaler, physician, veternaried, others, txt_otherspecify.Text, txt_comments.Text, Session["UID"].ToString());
                altbox("Inserted successfully.");
            }
            else
            {
                License_Data.License_Details.Edit_Buyers(Convert.ToInt32(hfdbuyer.Value), Request.QueryString[0].ToString(), community, hospitals, otherwholesaler, physician, veternaried, others, txt_otherspecify.Text, txt_comments.Text, Session["UID"].ToString());
                altbox("Updated successfully.");
            }
            Bind_Buyer();
        }
        protected void btndistributor_Click(object sender, EventArgs e)
        {
            string control = "";
            if(chk_controledsubstance.Checked==true)
            control="1";
            else
                control="0";
            string prescribe="";
            if(chk_presbdrugs.Checked==true)
                prescribe="1";
            else
                prescribe="0";
            string overthecounter = "";
            if (chk_overCounter.Checked == true)
                overthecounter = "1";
            else
                overthecounter = "0";
            string precursor = "";
            if (chk_precursor.Checked == true)
                precursor = "1";
            else
                precursor = "0";
            string medicine = "";
            if (chk_medicalgases.Checked == true)
                medicine = "1";
            else
                medicine = "0";
            string others = "";
            if (chk_other_dist.Checked == true)
                others = "1";
            else
                others = "0";
            if (hfddistributor.Value == "0")
            {
                License_Data.License_Details.Edit_distributor(Convert.ToInt32(hfddistributor.Value), Request.QueryString[0].ToString(), control, prescribe, overthecounter, txt_precursorchemical.Text, precursor, medicine, others, txt_ifotherspecify.Text, txtdiscomments.Text, Session["UID"].ToString());
                altbox("Inserted successfully.");
            }
            else
            {
                License_Data.License_Details.Edit_distributor(Convert.ToInt32(hfddistributor.Value), Request.QueryString[0].ToString(), control, prescribe, overthecounter, txt_precursorchemical.Text, precursor, medicine, others, txt_ifotherspecify.Text, txtdiscomments.Text, Session["UID"].ToString());
                altbox("Updated successfully.");
            }
            Bind_Distributor();
        }
        protected void btnoperations_Click(object sender, EventArgs e)
        {
            if (hfdoperation.Value == "0")
            {
                License_Data.License_Details.Edit_operations(Convert.ToInt32(hfdoperation.Value), Request.QueryString[0].ToString(), txt_moday_friday.Text, txt_saturday.Text, txt_sunday.Text, txt_comments_operations.Text, Session["UID"].ToString());
                altbox("Inserted successfully.");
            }
            else
            {
                License_Data.License_Details.Edit_operations(Convert.ToInt32(hfdoperation.Value), Request.QueryString[0].ToString(), txt_moday_friday.Text, txt_saturday.Text, txt_sunday.Text, txt_comments_operations.Text, Session["UID"].ToString());
                altbox("Updated successfully.");
            }
            Bind_Operations();
        }
        protected void btntypeoperations_Click(object sender, EventArgs e)
        {
            string fullservice = "";
            if (chk_fullservice.Checked == true)
                fullservice = "1";
            else
                fullservice = "0";
            string manufacture = "";
            if (chk_manufarer.Checked == true)
                manufacture = "1";
            else
                manufacture = "0";
            string repackage = "";
            if (chk_repackager.Checked == true)
                repackage = "1";
            else
                repackage = "0";
            string buying = "";
            if (chk_byinggroup.Checked == true)
                buying = "1";
            else
                buying = "0";
            string import = "";
            if (chk_import_export.Checked == true)
                import = "1";
            else
                import = "0";
            string distribution = "";
            if (chk_distributemulphar.Checked == true)
                distribution = "1";
            else
                distribution = "0";
            string virtal = "";
            if (chk_virtual.Checked == true)
                virtal = "1";
            else
                virtal = "0";
            string sterile = "";
            if (chk_streliecomp.Checked == true)
                sterile = "1";
            else
                sterile = "0";
            string nonsterile = "";
            if (chk_nonsterilcomp.Checked == true)
                nonsterile = "1";
            else
                nonsterile = "0";
            string other = "";
            if (chk_typeother.Checked == true)
                other = "1";
            else
                other = "0";
            if (hfdtypeoperation.Value == "0")
            {
                License_Data.License_Details.Edit_Typeoperations(Convert.ToInt32(hfdtypeoperation.Value), Request.QueryString[0].ToString(), fullservice, manufacture, repackage, txt_pharmacistname.Text, buying, import, distribution, virtal, sterile, nonsterile, other, txt_ifotherspecify.Text, txt_operationcomments.Text, Session["UID"].ToString());
                altbox("Inserted successfully.");
            }
            else
            {
                License_Data.License_Details.Edit_Typeoperations(Convert.ToInt32(hfdtypeoperation.Value), Request.QueryString[0].ToString(), fullservice, manufacture, repackage, txt_pharmacistname.Text, buying, import, distribution, virtal, sterile, nonsterile, other, txt_ifotherspecify.Text, txt_operationcomments.Text, Session["UID"].ToString());
                altbox("Updated successfully.");
            }
            Bind_Typeoperations();
        }
        private void altbox(string str)
        {
            string js = "afterpost('" + str + "');";
            ScriptManager.RegisterStartupScript(Page, GetType(), "scr", js, true);

        }
        protected void btn_mailingaddresssubmit_Click(object sender, EventArgs e)
        {
            if (hfdmailingaddressid.Value == "0")
            {
                License_Data.License_Details.Insert_Update_MailingAddress(0, Convert.ToInt32(Request.QueryString[0].ToString()), txt_mailingaddress1.Text, txt_mailingaddress2.Text, txt_mailingcity.Text, ddl_mailingstate.SelectedValue, ddl_mailingcounty.SelectedValue, txt_mailingzip.Text, Session["UID"].ToString());
                altbox("Record inserted successfully.");
                hfdmailingaddressid.Value = "0";
            }
            else
            {
                License_Data.License_Details.Insert_Update_MailingAddress(Convert.ToInt32(hfdmailingaddressid.Value), Convert.ToInt32(Request.QueryString[0].ToString()), txt_mailingaddress1.Text, txt_mailingaddress2.Text, txt_mailingcity.Text, ddl_mailingstate.SelectedValue, ddl_mailingcounty.SelectedValue, txt_mailingzip.Text, Session["UID"].ToString());
                altbox("Record updated successfully.");
                hfdmailingaddressid.Value = "0";
            }
        }
    }
}