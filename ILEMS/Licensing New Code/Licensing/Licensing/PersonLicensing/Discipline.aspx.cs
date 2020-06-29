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
using iTextSharp;
using ICSharpCode.SharpZipLib.Zip;

namespace Licensing.PersonLicensing
{
    public partial class Discipline : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                hfdperid.Value = Request.QueryString[0].ToString();
                Utilities_Licensing.BindDropdown(ddl_State_Of_Discipline, 9);
            }
        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {
            string docpath = "";


            string guid = Guid.NewGuid().ToString().Replace("-", string.Empty);
            guid = guid + DateTime.Now.ToShortDateString().Replace("/", string.Empty).Replace(":", string.Empty);
            string fext = Path.GetExtension(upddocument.PostedFile.FileName);
            if (upddocument.HasFile)
            {

                string url = System.Configuration.ConfigurationManager.AppSettings["lmsdoclink"].ToString() + DateTime.Now.Year.ToString() + "/" + DateTime.Now.Month.ToString() + "/";
                docpath = url + guid + fext;
            }
            // int docid = Person_Details.Licensing_Details.InsertWellnessDocument(Convert.ToInt32(hfddocid.Value), hfdperid.Value, ddl_doctype.SelectedValue, docpath, filename, txtdoccomments.Text, Session["UID"].ToString(), Convert.ToDateTime(DateTime.Now.ToShortDateString()));
            if (upddocument.HasFile)
            {
                if (!Directory.Exists(System.Configuration.ConfigurationManager.AppSettings["docpath"].ToString() + "\\" + DateTime.Now.Year.ToString()))
                    Directory.CreateDirectory(System.Configuration.ConfigurationManager.AppSettings["docpath"].ToString() + "\\" + DateTime.Now.Year.ToString());
                if (!Directory.Exists(System.Configuration.ConfigurationManager.AppSettings["docpath"].ToString() + "\\" + DateTime.Now.Year.ToString() + "\\" + DateTime.Now.Month.ToString()))
                    Directory.CreateDirectory(System.Configuration.ConfigurationManager.AppSettings["docpath"].ToString() + "\\" + DateTime.Now.Year.ToString() + "\\" + DateTime.Now.Month.ToString());

                upddocument.SaveAs(System.Configuration.ConfigurationManager.AppSettings["docpath"].ToString() + "\\" + DateTime.Now.Year.ToString() + "\\" + DateTime.Now.Month.ToString() + "\\" + guid + fext);
            }
            if (hfdselid.Value == "0")
            {
                Person_Details.Licensing_Details.InsertDiscipline(0, Convert.ToInt32(hfdperid.Value),
                txt_License_Number.Text,
                txt_Case_Number.Text,
                txt_Start_Date.Text,
                txt_End_Date.Text,
                ddl_State_Of_Discipline.SelectedValue,
                txt_Brief_Synopsis.Text,
                txt_Reviewer_comments.Text,
                docpath,
                Session["UID"].ToString()
                );
                altbox("Record inserted successfully.");
            }
            else
            {
                Person_Details.Licensing_Details.UpdateDisciplineDocument(Convert.ToInt32(hfdselid.Value), Convert.ToInt32(hfdperid.Value), txt_License_Number.Text, txt_Case_Number.Text, txt_Start_Date.Text, txt_End_Date.Text, ddl_State_Of_Discipline.SelectedValue, txt_Brief_Synopsis.Text, docpath, txt_Reviewer_comments.Text, Session["UID"].ToString());
                altbox("Record updated successfully.");
            }
            ClearValues();
        }
        public void ClearValues()
        {
            txt_Brief_Synopsis.Text = "";
            txt_Case_Number.Text = "";
            txt_End_Date.Text = "";
            txt_License_Number.Text = "";
            txt_Reviewer_comments.Text = "";
            txt_Start_Date.Text = "";
            ddl_State_Of_Discipline.SelectedValue = "-1";
            hfdselid.Value = "0";
        }
        protected void btnedit_Click(object sender, EventArgs e)
        {
            Person_Details.Discipline Disp = Person_Details.Licensing_Details.Edit_Discpline(Convert.ToInt32(hfdselid.Value));
            if (Disp != null)
            {
                txt_Brief_Synopsis.Text = Disp.BriefSynopsis;
                txt_Case_Number.Text = Disp.CaseNumber;
                if (Disp.EndDate != null)
                    txt_End_Date.Text = Convert.ToDateTime(Disp.EndDate).ToString("MM/dd/yyyy");
                txt_License_Number.Text = Disp.LicenseNumber;
                txt_Reviewer_comments.Text = Disp.ReviewerComment;
                if (Disp.StartDate != null)
                    txt_Start_Date.Text = Convert.ToDateTime(Disp.StartDate).ToString("MM/dd/yyyy");
                ddl_State_Of_Discipline.ClearSelection();
                if (ddl_State_Of_Discipline.Items.FindByValue(Disp.StateOfDiscipline) != null)
                    ddl_State_Of_Discipline.Items.FindByValue(Disp.StateOfDiscipline).Selected = true;
                string js = "Popup();";
                ScriptManager.RegisterStartupScript(Page, GetType(), "scr", js, true);
            }
        }

        protected void btndel_Click(object sender, EventArgs e)
        {
            Person_Details.Licensing_Details.Delete_Discpline(Convert.ToInt32(hfdselid.Value));
            altbox("Record deleted successfully.");
            hfdselid.Value = "0";
        }
        private void altbox(string str)
        {
            string js = " afterpost('" + str + "');";
            ScriptManager.RegisterStartupScript(Page, GetType(), "scr", js, true);
        }
    }
}