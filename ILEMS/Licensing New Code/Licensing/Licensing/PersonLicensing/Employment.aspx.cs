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
    public partial class Employment : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                hfdpid.Value = Request.QueryString[0].ToString();
                Person_Details.tbl_PersonDetail objtype = Person_Details.Licensing_Details.get_PersonsData(Convert.ToInt32(hfdpid.Value));
                hfdobjtype.Value = objtype.object_type.ToString();
                if (hfdobjtype.Value == "1")
                    haspharmacy.Attributes.Add("style", "display:none");
                else
                {
                    employee.Attributes.Add("style", "display:none");
                    supervisor.Attributes.Add("style", "display:none");
                    //exam.Attributes.Add("style", "display:none");
                    outofstate.Attributes.Add("style", "display:none");
                    otherstate.Attributes.Add("style", "display:none");
                }
                Utilities_Licensing.BindDropdown(ddlstate, 9);
                Utilities_Licensing.BindDropdown(ddlcounty, 10);
               
                btnadd.Attributes.Add("onClick", "return open_edit(" + hfdpid.Value + ");");
                btnaddemployer.Attributes.Add("onClick", "return Open_employer(" + hfdpid.Value + ");");
                //Utilities_Licensing.BindGridEmployer(grdemployee, Convert.ToInt32(hfdpid.Value));
            }
        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {
            if (hfdemployeeid.Value == "0")
            {
                //Utilities_Licensing.Insert_Employer(Convert.ToInt32(hfdpid.Value), 1, 2, txt_employeetype.Text.ToString(), txt_Name.Text.ToString(), txt_address.Text.ToString(), txt_city.Text.ToString(), ddlstate.SelectedItem.Text, txt_zip.Text.ToString(), ddlcounty.SelectedItem.Text, "1");
                //Utilities_Licensing.BindGridEmployer(grdemployee);
                Person_Details.TBL_Licensing_Employer objemployer = new Person_Details.TBL_Licensing_Employer();
                objemployer.Employer_Id = 0;
                objemployer.App_Id = "2";
                objemployer.Person_ID = hfdpid.Value;
                objemployer.Employer_Type = txt_employeetype.Text.ToString();
                objemployer.Employer_Name = txt_Name.Text.ToString();
                objemployer.Address = txt_address.Text.ToString();
                objemployer.City = txt_city.Text.ToString();
                objemployer.State = ddlstate.SelectedValue.ToString();
                objemployer.County = ddlcounty.SelectedValue.ToString();
                objemployer.Zip = txt_zip.Text.ToString();
                objemployer.isprocess = true;
                objemployer.createdby = Convert.ToString(Session["UID"]);
                objemployer.createddt = Convert.ToDateTime(DateTime.Now.ToShortDateString());
                objemployer.modifiedby = Convert.ToString(Session["UID"]);
                objemployer.modifieddt = Convert.ToDateTime(DateTime.Now.ToShortDateString());
                Person_Details.Licensing_Details.InsertEmployer(objemployer);

                //Utilities_Licensing.BindGridEmployer(grdemployee, Convert.ToInt32(hfdpid.Value));
                Page.RegisterStartupScript("js", "<script>sa5.process();</script>");
                altbox("Record inserted successfully.");
                Clear();

            }


            else
            {
                Person_Details.TBL_Licensing_Employer objemployer = new Person_Details.TBL_Licensing_Employer();
                objemployer.Employer_Id = Convert.ToInt32(hfdemployeeid.Value);
                objemployer.App_Id = "2";
                objemployer.Person_ID = hfdpid.Value;
                objemployer.Employer_Type = txt_employeetype.Text.ToString();
                objemployer.Employer_Name = txt_Name.Text.ToString();
                objemployer.Address = txt_address.Text.ToString();
                objemployer.City = txt_city.Text.ToString();
                objemployer.State = ddlstate.SelectedValue.ToString();
                objemployer.County = ddlcounty.SelectedValue.ToString();
                objemployer.Zip = txt_zip.Text.ToString();
                objemployer.isprocess = true;
                objemployer.createdby = Convert.ToString(Session["UID"]);
                objemployer.createddt = Convert.ToDateTime(DateTime.Now.ToShortDateString());
                objemployer.modifiedby = Convert.ToString(Session["UID"]);
                objemployer.modifieddt = Convert.ToDateTime(DateTime.Now.ToShortDateString());
                Person_Details.Licensing_Details.UpdateEmployer(objemployer);

                //Utilities_Licensing.BindGridEmployer(grdemployee, Convert.ToInt32(hfdpid.Value));
                Page.RegisterStartupScript("js", "<script>sa5.process();</script>");
                altbox("Record updated successfully.");
                Clear();

            }
        }

        protected void btn_clear_Click(object sender, EventArgs e)
        {
            Clear();
        }
        protected void btndeleteemp_Click(object sender, EventArgs e)
        {
            using (Person_LicenseDataContext pldc = new Person_LicenseDataContext())
            {
                tbl_has_pharmacyemp obj = pldc.tbl_has_pharmacyemps.Where(c => c.has_emp_id == Convert.ToInt32(hfdselid.Value)).SingleOrDefault();
                pldc.tbl_has_pharmacyemps.DeleteOnSubmit(obj);
                pldc.SubmitChanges();
                altbox("Record deleted successfully.");
                hfdselid.Value = "0";
            }
        }
        private void Clear()
        {
            ddlstate.SelectedIndex = 0;
            txt_address.Text = "";
            txt_city.Text = "";
            ddlcounty.SelectedIndex = 0;
            txt_Name.Text = "";
            txt_zip.Text = "";
            txt_employeetype.Text = "";
        }
        protected void btnedit_click(object sender, EventArgs e)
        {
            string value = hfdselid.Value;
            Person_Details.TBL_Licensing_Employer obj = Utilities_Licensing.EditEmployer(Convert.ToInt32(value));
            hfdemployeeid.Value = obj.Employer_Id.ToString();
            txt_Name.Text = obj.Employer_Name;
            txt_employeetype.Text = obj.Employer_Type;
            txt_address.Text = obj.Address;
            string state = "";
            state = obj.State.ToString();
            if (ddlstate.Items[0].Text != state)
            {
                ddlstate.Items[0].Selected = false;
                if (ddlstate.Items.FindByValue(state) != null)
                    ddlstate.Items.FindByValue(state).Selected = true;
            }
            string county = "";
            county = obj.County.ToString();
            if (ddlcounty.Items[0].Text != county)
            {
                ddlcounty.Items[0].Selected = false;
                if (ddlcounty.Items.FindByValue(county) != null)
                    ddlcounty.Items.FindByValue(county).Selected = true;
            }
            //ddlstate.SelectedValue = obj.State;
            //ddlcounty.SelectedValue = obj.County;
            txt_city.Text = obj.City;
            txt_zip.Text = obj.Zip;
            string js = "Popup();";
            ScriptManager.RegisterStartupScript(Page, GetType(), "scr", js, true);
        }
        protected void btndel_click(object sender, EventArgs e)
        {
            string value = hfdselid.Value;
            TBL_Licensing_Employer obj = new TBL_Licensing_Employer();
            obj.Employer_Id = Convert.ToInt32(value);
            Person_Details.Licensing_Details.Delete_Employer(obj);
            Page.RegisterStartupScript("js", "<script>sa5.process();</script>");
             altbox("Record deleted successfully.");
        }


        private void  altbox(string str)
        {
            string js = " afterpost('" + str + "');";
            ScriptManager.RegisterStartupScript(Page, GetType(), "scr", js, true);
        }

        protected void btnhas_click(object sender, EventArgs e)
        {
            Utilities_Licensing.Update_Haspharmacystatus(Convert.ToInt32(hfdselid.Value),Session["UID"].ToString());
            altbox("Record updated successfully.");
        }

        

        #region otherstatelicense insert,edit, delete

        protected void btn_licsubmit_Click(object sender, EventArgs e)
        {

            {
                if (hfdstateid.Value == "0")
                {
                    //Utilities_Licensing.Insert_Employer(Convert.ToInt32(hfdpid.Value), 1, 2, txt_employeetype.Text.ToString(), txt_Name.Text.ToString(), txt_address.Text.ToString(), txt_city.Text.ToString(), ddlstate.SelectedItem.Text, txt_zip.Text.ToString(), ddlcounty.SelectedItem.Text, "1");
                    //Utilities_Licensing.BindGridEmployer(grdemployee);
                    Person_Details.tbl_otherstatelicense objotherstatelic = new Person_Details.tbl_otherstatelicense();
                    objotherstatelic.Osl_ID = 0;
                    objotherstatelic.Per_ID = Convert.ToInt32(hfdpid.Value);
                    objotherstatelic.Status = ddlstatus.SelectedItem.Text;
                    objotherstatelic.Licno = Txt_licnum.Text.ToString();
                    if (Txt_datereceived.Text != "")
                        objotherstatelic.Date_Received = Convert.ToDateTime(Txt_datereceived.Text);
                    else
                        objotherstatelic.Date_Received = Convert.ToDateTime("01 / 01 / 1900");
                   
                    
                    objotherstatelic.states = Txt_state.Text;
                    objotherstatelic.createdby = Convert.ToString(Session["UID"]);
                    objotherstatelic.createddt = Convert.ToDateTime(DateTime.Now.ToShortDateString());
                    objotherstatelic.modifiedby = Convert.ToString(Session["UID"]);
                    objotherstatelic.modifieddt = Convert.ToDateTime(DateTime.Now.ToShortDateString());


                    bool Otherstatelicense;

                    if (Chk_otherstatelic.Checked == true)

                        Otherstatelicense = true;


                    else
                        Otherstatelicense = false;

                    objotherstatelic.isothers = Otherstatelicense;

                    Person_Details.Licensing_Details.insertotherstatelic(objotherstatelic);

                    //Utilities_Licensing.BindGridEmployer(grdemployee, Convert.ToInt32(hfdpid.Value));
                    Page.RegisterStartupScript("js", "<script>osl.process();</script>");
                    altbox("Record inserted successfully.");
                    licClear();

                }


                else
                {
                    Person_Details.tbl_otherstatelicense objotherstatelic = new Person_Details.tbl_otherstatelicense();

                    objotherstatelic.Osl_ID = Convert.ToInt32(hfdstateid.Value);
                    objotherstatelic.Per_ID = Convert.ToInt32(hfdpid.Value);
                    objotherstatelic.Status = ddlstatus.SelectedItem.Text;
                    objotherstatelic.Licno = Txt_licnum.Text.ToString();
                    if (Txt_datereceived.Text != "")
                        objotherstatelic.Date_Received = Convert.ToDateTime(Txt_datereceived.Text);
                    else
                        objotherstatelic.Date_Received = Convert.ToDateTime("01 / 01 / 1900");
                    
                    objotherstatelic.states = Txt_state.Text;
                    objotherstatelic.createdby = Convert.ToString(Session["UID"]);
                    objotherstatelic.createddt = Convert.ToDateTime(DateTime.Now.ToShortDateString());
                    objotherstatelic.modifiedby = Convert.ToString(Session["UID"]);
                    objotherstatelic.modifieddt = Convert.ToDateTime(DateTime.Now.ToShortDateString());
                    bool Otherstatelicense;

                    if (Chk_otherstatelic.Checked == true)

                        Otherstatelicense = true;


                    else
                        Otherstatelicense = false;

                    objotherstatelic.isothers = Otherstatelicense;
                    Person_Details.Licensing_Details.updateotherstatelic(objotherstatelic);

                    //Utilities_Licensing.BindGridEmployer(grdemployee, Convert.ToInt32(hfdpid.Value));
                    Page.RegisterStartupScript("js", "<script>osl.process();</script>");
                    altbox("Record updated successfully.");
                    licClear();

                }
            }
        }


        protected void btn_licclear_Click(object sender, EventArgs e)
        {
            licClear();
        }
        private void licClear()
        {
            Txt_licnum.Text = "";
            Txt_state.Text = "";
            Txt_datereceived.Text = "";
            
            Chk_otherstatelic.Checked = false;
            ddlstatus.SelectedValue = "-1";
        }

        protected void buttonedit_click(object sender, EventArgs e)
        {
            string value = hfdstateid.Value;
            Person_Details.tbl_otherstatelicense obj = Licensing_Details.Edit_otherstatelicense(Convert.ToInt32(value));
            hfdstateid.Value = obj.Osl_ID.ToString();
            Txt_licnum.Text = obj.Licno;
            string status = "";
            status = obj.Status.ToString();
            if (ddlstatus.Items[0].Text != status)
            {
                ddlstatus.Items[0].Selected = false;
                if (ddlstatus.Items.FindByText(status) != null)
                    ddlstatus.Items.FindByText(status).Selected = true;
            }
            if (obj.Date_Received == Convert.ToDateTime("01/01/1900"))
                Txt_datereceived.Text = "";
            else
                Txt_datereceived.Text = Convert.ToDateTime(obj.Date_Received).ToString("MM/dd/yyyy");

            
            
            //string isparent = obj.Is_ParentLicmust;
            //if (isparent == "True")
            //    chk_parentidmust.Checked = true;
            //else
            //    chk_parentidmust.Checked = false;
            string Otherstatelicense = obj.isothers.ToString();
            if (Otherstatelicense == "True")
                Chk_otherstatelic.Checked = true;
            else
                Chk_otherstatelic.Checked = false;
            Txt_state.Text = obj.states;
            string js = "Popup2();";
            ScriptManager.RegisterStartupScript(Page, GetType(), "scr", js, true);
        }
        protected void buttondelete_click(object sender, EventArgs e)
        {
            string value = hfdstateid.Value;
            tbl_otherstatelicense obj = new tbl_otherstatelicense();
            obj.Osl_ID = Convert.ToInt32(value);
            Person_Details.Licensing_Details.Delete_otherstatelicense(obj);
            Page.RegisterStartupScript("js", "<script>osl.process();</script>");
            altbox("Record deleted successfully.");
        }
        #endregion
    }
}