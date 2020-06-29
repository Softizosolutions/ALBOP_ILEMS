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
    public partial class Journal : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                hfdpid.Value = Request.QueryString[0].ToString();
             
                Utilities_Licensing.BindDropdown(ddlJournalType, 6);
                hfdisce.Value ="0";
            }
        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {
            if (hfdjournalid.Value == "0")
            {
                string isalert;
                if (ChkjournalAlert.Checked == true)
                    isalert = "true";
                else
                    isalert = "false";
                tbl_Licensing_Journal_Detail pjd = new tbl_Licensing_Journal_Detail();
                pjd.Journal_Id = Convert.ToInt32(hfdjournalid.Value);
                pjd.Person_Id = Convert.ToInt32(hfdpid.Value);
                pjd.Journal_Type_Id = Convert.ToInt32(ddlJournalType.SelectedValue);
                pjd.Is_Alert = Convert.ToBoolean(isalert);
                pjd.Description = txtjournaltype.Text.ToString();
                pjd.Isce = Convert.ToInt32(hfdisce.Value);
                pjd.Createdby = Session["UID"].ToString();
                pjd.CreatedDate = Convert.ToDateTime(DateTime.Now.ToShortDateString());
                Person_Details.Licensing_Details.InsertJournal(pjd);
                 altbox("Record inserted successfully.");
            }
            else
            {
                string isalert;
                if (ChkjournalAlert.Checked == true)
                    isalert = "true";
                else
                    isalert = "false";
                tbl_Licensing_Journal_Detail pjd = new tbl_Licensing_Journal_Detail();
                pjd.Journal_Id = Convert.ToInt32(hfdjournalid.Value);
                pjd.Person_Id = Convert.ToInt32(hfdpid.Value);
                pjd.Journal_Type_Id = Convert.ToInt32(ddlJournalType.SelectedValue);
                pjd.Is_Alert = Convert.ToBoolean(isalert);
                pjd.Description = txtjournaltype.Text.ToString();
                pjd.Isce = Convert.ToInt32(hfdisce.Value);
                pjd.Createdby = Session["UID"].ToString();
                pjd.CreatedDate = Convert.ToDateTime(DateTime.Now.ToShortDateString());
                Person_Details.Licensing_Details.UpdateJournal(pjd);
                 altbox("Record updated successfully.");

            }
            Clear();
        }

        protected void btn_clear_Click(object sender, EventArgs e)
        {
            Clear();
        }
      
        protected void btnedit_click(object sender, EventArgs e)
        {
            string value = hfdselid.Value;
            tbl_Licensing_Journal_Detail obj = Utilities_Licensing.EditJournal(Convert.ToInt32(value));
            hfdjournalid.Value = obj.Journal_Id.ToString();
            string journal = "";
            journal = obj.Journal_Type_Id.ToString();
            if (ddlJournalType.Items[0].Text != journal)
            {
                ddlJournalType.Items[0].Selected = false;
                if (ddlJournalType.Items.FindByValue(journal) != null)
                    ddlJournalType.Items.FindByValue(journal).Selected = true;
            }
            //ddlJournalType.SelectedValue = obj.Journal_Type_ID.ToString();
            string isalerts = obj.Is_Alert.ToString();
            if (isalerts == "True")
            {
                ChkjournalAlert.Checked = true;
            }
            else
                ChkjournalAlert.Checked = false;
            txtjournaltype.Text = obj.Description;
            Page.RegisterStartupScript(  "scr", "<script>Popup();</script>" );
        }
        protected void btndel_click(object sender, EventArgs e)
        {
            string value = hfdselid.Value;
            tbl_Licensing_Journal_Detail obj = new tbl_Licensing_Journal_Detail();
            obj.Journal_Id = Convert.ToInt32(value);
            Person_Details.Licensing_Details.DeleteJournal(obj);
            
             altbox("Record deleted successfully.");
        }
        
        private void Clear()
        {
            ddlJournalType.SelectedValue = "-1";
            txtjournaltype.Text = "";
            ChkjournalAlert.Checked = false;
            hfdjournalid.Value = "0";
            hfdselid.Value = "0";
        }
       



        private void  altbox(string str)
        {
            string js = " altbox('" + str + "');sa5.process();parent.chkalrt();";
            ScriptManager.RegisterStartupScript(Page, GetType(), "scr", js, true);
        }
    }
}