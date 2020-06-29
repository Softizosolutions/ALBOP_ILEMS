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
    public partial class Inspection : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                hfdpid.Value = Request.QueryString[0].ToString();
                Utilities_Licensing.BindDropdown(ddl_instype, 61);
                Utilities_Licensing.BindDropdown(ddlJournalType, 6);
                    hfdutype.Value = "3";
                    List<tbl_lkp_data> cablst = Person_Details.Licensing_Details.Get_Lkp_tablesdata(39);
                    cablst = cablst.Where(c => c.Lkp_data_ID == 1075 || c.Lkp_data_ID == 1076 || c.Lkp_data_ID == 1077 || c.Lkp_data_ID == 1085).ToList();
                    ddl_cabinet.DataSource = cablst;
                    ddl_cabinet.DataValueField = "Lkp_data_ID";
                    ddl_cabinet.DataTextField = "Values";
                    ddl_cabinet.DataBind();
                    ddl_cabinet.Items.Insert(0, new ListItem("Select", "-1"));
                    Utilities_Licensing.BindDropdown(ddlstatus,59);
                Utilities_Licensing.Fill_Dropdown(ddlstaff, "tbl_Login where UserType in (417,416) Order by LastName", "LastName+' '+FirstName", "loginID", " ", "Select");
                
                Utilities_Licensing.BindDropdown(ddl_folder, 40);
                Utilities_Licensing.BindDropdown(ddl_doctype , 58);
            }
        }
        protected void btnsubmit_Click(object sender, EventArgs e)
        {
            if (hfdselid.Value != "0")
            {
                Person_Details.Licensing_Details.Save_EditInformation(Convert.ToInt32(hfdinsid.Value), Convert.ToInt32(hfdpid.Value), ddl_instype.SelectedValue, ddlstatus.SelectedValue, txtinspectiondate.Text, txtinsscope.Text, ddlstaff.SelectedValue, txtdescription.Text, Session["UID"].ToString());
                altbox("Record updated successfully.");
                ClearJournal();
            }
            else
            {
                Person_Details.Licensing_Details.Save_EditInformation(Convert.ToInt32(hfdinsid.Value), Convert.ToInt32(hfdpid.Value), ddl_instype.SelectedValue, ddlstatus.SelectedValue, txtinspectiondate.Text, txtinsscope.Text, ddlstaff.SelectedValue, txtdescription.Text, Session["UID"].ToString());
                altbox("Record inserted successfully.");
                ClearJournal();
            }
        }
        protected void btn_submit_Click(object sender, EventArgs e)
        {
            string filename = "";

            if (hfddocid.Value == "0")
            {
                if (upddocument.HasFile)
                {
                    filename = upddocument.PostedFile.FileName;
                }
                string approval = "";
                if (chk_approval.Checked == true)
                    approval = "true";
                else
                    approval = "false";
                tbl_Person_Document_Detail pdd = new tbl_Person_Document_Detail();
                pdd.Document_ID = Convert.ToInt32(hfddocid.Value);
                string guid = Guid.NewGuid().ToString().Replace("-", string.Empty);
                guid = guid + DateTime.Now.ToShortDateString().Replace("/", string.Empty).Replace(":", string.Empty);
                string fext = Path.GetExtension(upddocument.PostedFile.FileName);
                if (upddocument.HasFile)
                {

                    string url = System.Configuration.ConfigurationManager.AppSettings["lmsdoclink"].ToString() + DateTime.Now.Year.ToString() + "/" + DateTime.Now.Month.ToString() + "/";
                    pdd.docpath = url + guid + fext;
                
                }
                pdd.Person_ID = Convert.ToInt32(hfdpid.Value);
                pdd.Cabinet_ID = Convert.ToInt32(ddl_cabinet.SelectedValue);
                pdd.Folder_ID = Convert.ToInt32(ddl_folder.SelectedValue);
                pdd.Document_Date = Convert.ToDateTime(txt_date.Text);
                pdd.DocType = Convert.ToInt32(ddl_doctype.SelectedValue);
                pdd.Description = filename;
                pdd.Approval_Needed = Convert.ToBoolean(approval);
                pdd.Modified_By = Convert.ToInt32(Session["UID"].ToString());
                pdd.Modified_Date = Convert.ToDateTime(DateTime.Now.ToShortDateString());
                int docid = Person_Details.Licensing_Details.InsertDocument(pdd);
                if (upddocument.HasFile)
                {
                    if (!Directory.Exists(System.Configuration.ConfigurationManager.AppSettings["docpath"].ToString() + "\\" + DateTime.Now.Year.ToString()))
                        Directory.CreateDirectory(System.Configuration.ConfigurationManager.AppSettings["docpath"].ToString() + "\\" + DateTime.Now.Year.ToString());
                    if (!Directory.Exists(System.Configuration.ConfigurationManager.AppSettings["docpath"].ToString() + "\\" + DateTime.Now.Year.ToString() + "\\" + DateTime.Now.Month.ToString()))
                        Directory.CreateDirectory(System.Configuration.ConfigurationManager.AppSettings["docpath"].ToString() + "\\" + DateTime.Now.Year.ToString() + "\\" + DateTime.Now.Month.ToString());

                    upddocument.SaveAs(System.Configuration.ConfigurationManager.AppSettings["docpath"].ToString() + "\\" + DateTime.Now.Year.ToString() + "\\" + DateTime.Now.Month.ToString() + "\\" + guid + fext);
                }
                altbox("Record inserted successfully.");
              
            }
        }
        protected void btnedit_click(object sender, EventArgs e)
        {
            string value = hfdinsid.Value;
            tbl_Inspection_Journal inspection = Person_Details.Licensing_Details.Edit_Inspection(Convert.ToInt32(value));
            hfdselid.Value = inspection.Inspection_JournalID.ToString();
            string instype = "";
            instype = inspection.Inspection_Type;
            ddl_instype.SelectedIndex = -1;
            if (ddl_instype.Items.FindByValue(instype) != null)
                ddl_instype.Items.FindByValue(instype).Selected = true;
            string status = "";
            status = inspection.Inspection_Status;
            ddlstatus.SelectedIndex = -1;
                if (ddlstatus.Items.FindByValue(status) != null)
                    ddlstatus.Items.FindByValue(status).Selected = true;
                string insdate = "";
                insdate = Convert.ToDateTime(inspection.Inspection_Date).ToString("MM/dd/yyyy");
                if (insdate != "01/01/1900" && insdate != null && insdate != "" && insdate != "01/01/0001")
                {
                    txtinspectiondate.Text = insdate;
                }
                else
                {
                    txtinspectiondate.Text = "";
                }
            // if(inspection.Inspection_Date!=Convert.ToDateTime("01/01/1900"))
            //txtinspectiondate.Text = Convert.ToDateTime(inspection.Inspection_Date).ToString("MM/dd/yyyy");
            txtdescription.Text = inspection.Description;
            txtinsscope.Text = inspection.Inspection_Scope;
            string staff = "";
            staff = inspection.StaffAssigned;
            ddlstaff.SelectedIndex = -1;
                if (ddlstaff.Items.FindByValue(staff) != null)
                    ddlstaff.Items.FindByValue(staff).Selected = true;
            

            string js = "Popup();";
            ScriptManager.RegisterStartupScript(Page, GetType(), "scr", js, true);
        }
        protected void btndel_click(object sender, EventArgs e)
        {
            string value = hfdinsid.Value;
            tbl_Person_Document_Detail obj = new tbl_Person_Document_Detail();
            obj.Document_ID = Convert.ToInt32(value);
            Person_Details.Licensing_Details.DeleteDocument(obj);
            altbox("Record deleted successfully.");
            hfdinsid.Value = "0";
        }
        #region Inspection Journal

        protected void btn_addinspectionjournal_Click(object sender, EventArgs e)
        {
            if (hfdinsjournal.Value == "0")
            {
                Utilities_Licensing.Save_Inspection_JournalDetails(Convert.ToInt32(hfdinsjournal.Value), Convert.ToInt32(hfdpid.Value), ddlJournalType.SelectedValue, txt_journalcomments.Text.ToString(), Session["UID"].ToString(), DateTime.Now.ToString(), Session["UID"].ToString(), DateTime.Now.ToString());
                altbox("Record inserted successfully.");
                Clearjournalvalues();

            }
            else
            {
                Utilities_Licensing.Save_Inspection_JournalDetails(Convert.ToInt32(hfdinsjournal.Value), Convert.ToInt32(hfdpid.Value), ddlJournalType.SelectedValue, txt_journalcomments.Text.ToString(), Session["UID"].ToString(), DateTime.Now.ToString(), Session["UID"].ToString(), DateTime.Now.ToString());
                altbox("Record updated successfully.");
                Clearjournalvalues();

            }

        }
        protected void btneditjournal_click(object sender, EventArgs e)
        {
            string Value = hfdinsjournal.Value;

            Person_Details.tbl_Inspection_JournalDetail obj = Utilities_Licensing.EditInspection_JournalDetails(Value);
            ddlJournalType.SelectedValue = obj.JournalType;
            txt_journalcomments.Text = obj.Comments;
            string js = "Popup2();";
            ScriptManager.RegisterStartupScript(Page, GetType(), "scr", js, true);
        }
        protected void btndeljournal_click(object sender, EventArgs e)
        {
            string Value = hfdinsjournal.Value;
            Utilities_Licensing.DeleteInspection_JournalDetails(Value);
            altbox("Record deleted successfully.");
            hfdinsjournal.Value = "0";
        }


        public void Clearjournalvalues()
        {
            ddlJournalType.SelectedIndex = -1;
            txt_journalcomments.Text = "";
            hfdinsjournal.Value = "";
        }
        #endregion

        private void altbox(string str)
        {
            string js = " afterpost('" + str + "');";
            ScriptManager.RegisterStartupScript(Page, GetType(), "scr", js, true);
        }
        private void ClearJournal()
        {
            hfdselid.Value = "0";
            hfdinsid.Value = "0";
            ddl_instype.SelectedIndex = -1;
            ddlstatus.SelectedIndex = -1;
            txtinspectiondate.Text = "";
            txtinsscope.Text = "";
            ddlstaff.SelectedIndex = -1;
            txtdescription.Text = "";
        }

        protected void btndelinsp_Click(object sender, EventArgs e)
        {
            string value = hfdinsid.Value;
            Person_Details.Licensing_Details.Delete_Inspection(Convert.ToInt32(value));
            altbox("Record deleted successfully.");
            hfdinsid.Value = "0";
        }
    }
}