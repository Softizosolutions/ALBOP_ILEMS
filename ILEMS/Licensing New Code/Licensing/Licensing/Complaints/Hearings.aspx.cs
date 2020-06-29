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

namespace Licensing.Complaints
{
    public partial class Hearings : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                hfdperid.Value = Request.QueryString[1].ToString();
                hfdcmpid.Value = Request.QueryString[0].ToString();
                PersonLicensing.Utilities_Licensing.BindDropdown(ddl_cabinet, 39);
                PersonLicensing.Utilities_Licensing.BindDropdown(ddl_folder, 40);
                PersonLicensing.Utilities_Licensing.BindDropdownForCRCandHearing(ddl_doctype, 67,2);
              //  PersonLicensing.Utilities_Licensing.BindDropdownForCRCandHearing(ddl_documenttype, 67, 2);
            }
        }
        protected void btn_submit_Click(object sender, EventArgs e)
        {
            string filename = "";

            if (hfdselid.Value == "0")
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
                pdd.Document_ID = Convert.ToInt32(hfdselid.Value);
                pdd.Person_ID = Convert.ToInt32(hfdperid.Value);
                pdd.cmpd = Convert.ToInt32(hfdcmpid.Value);


                string guid = Guid.NewGuid().ToString().Replace("-", string.Empty);
                guid = guid + DateTime.Now.ToShortDateString().Replace("/", string.Empty).Replace(":", string.Empty);
                string fext = Path.GetExtension(upddocument.PostedFile.FileName);
                if (upddocument.HasFile)
                {

                    string url = System.Configuration.ConfigurationManager.AppSettings["lmsdoclink"].ToString() + DateTime.Now.Year.ToString() + "/" + DateTime.Now.Month.ToString() + "/";
                    pdd.docpath = url + guid + fext;
                }
                pdd.Cabinet_ID = Convert.ToInt32(ddl_cabinet.SelectedValue);
                pdd.Folder_ID = Convert.ToInt32(ddl_folder.SelectedValue);
                pdd.Document_Date = Convert.ToDateTime(txt_date.Text);
                pdd.DocType = Convert.ToInt32(ddl_doctype.SelectedValue);
                pdd.Description = filename;
                pdd.CRCandHearing = "5";
                pdd.Comments = txtdoccomments.Text;
                pdd.Approval_Needed = Convert.ToBoolean(approval);
                pdd.Created_By = Session["UID"].ToString();
                pdd.Created_Date = Convert.ToDateTime(DateTime.Now.ToShortDateString());
                int docid = Person_Details.Licensing_Details.InsertDocument(pdd);
                if (upddocument.HasFile)
                {
                    if (!Directory.Exists(System.Configuration.ConfigurationManager.AppSettings["docpath"].ToString() + "\\" + DateTime.Now.Year.ToString()))
                        Directory.CreateDirectory(System.Configuration.ConfigurationManager.AppSettings["docpath"].ToString() + "\\" + DateTime.Now.Year.ToString());
                    if (!Directory.Exists(System.Configuration.ConfigurationManager.AppSettings["docpath"].ToString() + "\\" + DateTime.Now.Year.ToString() + "\\" + DateTime.Now.Month.ToString()))
                        Directory.CreateDirectory(System.Configuration.ConfigurationManager.AppSettings["docpath"].ToString() + "\\" + DateTime.Now.Year.ToString() + "\\" + DateTime.Now.Month.ToString());

                    upddocument.SaveAs(System.Configuration.ConfigurationManager.AppSettings["docpath"].ToString() + "\\" + DateTime.Now.Year.ToString() + "\\" + DateTime.Now.Month.ToString() + "\\" + guid + fext);
                }
                List<USP_GetLicandCmpDetailsResult> obj = Person_Details.Licensing_Details.GetLicandCmpDetails(Request.QueryString[1].ToString(), docid, "", Convert.ToInt32(Request.QueryString[0].ToString()));
                if (obj.Count > 0)
                {
                    if (ddl_doctype.SelectedValue == "1399")
                    {
                         
                        Mail.SendMail("", "pwright@albop.com;canderson@albop.com;RCoker@albop.com;vlalex@bellsouth.net;datkisson@wardcooperlaw.com;wpassmore@albop.com;EBraden@albop.com", "", "Document Upload", "A new document has been Uploaded By : " + obj[0].CreatedBy + " For Licensee’s Name : " + obj[0].Full_Name + "<br/>Case # : " + obj[0].Case_No + "<br/>License # : " + obj[0].Lic_No + "<br/>Document Type :" + ddl_doctype.SelectedItem.Text + "<br/>Filename :" + upddocument.PostedFile.FileName);
                    }
                    else
                    {
                         
                        Mail.SendMail("", "pwright@albop.com;canderson@albop.com;RCoker@albop.com;vlalex@bellsouth.net;datkisson@wardcooperlaw.com;wpassmore@albop.com;EBraden@albop.com", "", "Document Upload", "A new document has been Uploaded By : " + obj[0].CreatedBy + " For Licensee’s Name : " + obj[0].Full_Name + "<br/>Case # : " + obj[0].Case_No + "<br/>License # : " + obj[0].Lic_No + "<br/>Document Type :" + ddl_doctype.SelectedItem.Text + "<br/>Filename :" + upddocument.PostedFile.FileName);
                    }
                }
                altbox("Record inserted successfully.");
                Clear();
            }

        }
        protected void btn_submit1_Click(object sender, EventArgs e)
        {
            if (hfdselid.Value != "0")
            {
                PersonLicensing.Utilities_Licensing.Updatedocumentcomments(Convert.ToInt32(hfdselid.Value), txt_com.Text, "");
                altbox("Record updated successfully.");
                Page.RegisterStartupScript("js", "<script>sa5.process();</script>");
            }
            hfdselid.Value = "0";
        }
        protected void btnedit_click(object sender, EventArgs e)
        {
            string value = hfdselid.Value;
            tbl_Person_Document_Detail pdd = PersonLicensing.Utilities_Licensing.EditDocument(Convert.ToInt32(value));
            hfdselid.Value = pdd.Document_ID.ToString();
            txt_com.Text = pdd.Comments;


            string js = "Popup();";
            ScriptManager.RegisterStartupScript(Page, GetType(), "scr", js, true);
        }
        protected void btndel_click(object sender, EventArgs e)
        {
            string value = hfdselid.Value;
            tbl_Person_Document_Detail obj = new tbl_Person_Document_Detail();
            obj.Document_ID = Convert.ToInt32(value);
            Person_Details.Licensing_Details.DeleteDocument(obj);
            hfdselid.Value = "0";
            altbox("Record deleted successfully.");
            Page.RegisterStartupScript("js", "<script>sa5.process();</script>");
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


        private void Clear()
        {
            ddl_cabinet.SelectedValue = "-1";
            ddl_folder.SelectedValue = "-1";
            ddl_doctype.SelectedValue = "-1";
            txt_date.Text = "";
            txtdoccomments.Text = "";
            chk_approval.Checked = false;
            hfdselid.Value = "0";
        }



        private void altbox(string str)
        {
            string js = " afterpost('" + str + "');";
            ScriptManager.RegisterStartupScript(Page, GetType(), "scr", js, true);
        }

        protected void btnhearingdocedit_Click(object sender, EventArgs e)
        {
            ComplaintsLink.tbl_Complaints_Hearing_Document obj = ComplaintsLink.Complaints.GetHearingDocForEdit(Convert.ToInt32(hfdhearingdocid.Value));
            if (obj != null)
            {
                txt_documentduedate.Text = Convert.ToDateTime(obj.Document_Due_Date).ToString("MM/dd/yyyy");
                if (obj.Document_Received == "Yes")
                    chkdocumentreceived.Checked = true;
                else
                    chkdocumentreceived.Checked = false;
                //ddl_documenttype.ClearSelection();
                //if (ddl_documenttype.Items.FindByValue(obj.Document_Type) != null)
                //    ddl_documenttype.Items.FindByValue(obj.Document_Type).Selected = true;
                txt_documentype.Text = obj.Document_Type;
                string js = "HearingPopup();";
                ScriptManager.RegisterStartupScript(Page, GetType(), "scr", js, true);
            }
        }

        protected void btnhearingdocdelete_Click(object sender, EventArgs e)
        {
            ComplaintsLink.Complaints.DeleteFormalHearingdoc(Convert.ToInt32(hfdhearingdocid.Value));
            hfdhearingdocid.Value = "0";
            altbox("Record deleted successfully.");
        }

        protected void btnhearingdoc_Click(object sender, EventArgs e)
        {
            string docreceived = ""; DateTime duedate; DateTime todaysdate; int days;

            duedate = Convert.ToDateTime(txt_documentduedate.Text);
            todaysdate = Convert.ToDateTime(DateTime.Now.ToShortDateString());
            days = (duedate - todaysdate).Days;
            if (chkdocumentreceived.Checked)
                docreceived = "Yes";
            else
                docreceived = "No";
            if (hfdhearingdocid.Value == "0")
            {
                ComplaintsLink.Complaints.Insert_HearingDocument(0, Convert.ToInt32(Request.QueryString[0].ToString()), Convert.ToInt32(Request.QueryString[1].ToString()), txt_documentduedate.Text, docreceived, Session["UID"].ToString(),txt_documentype.Text);
                altbox("Record inserted successfully.");
                Clear_HearingDoc();
            }
            else
            {
                ComplaintsLink.Complaints.Insert_HearingDocument(Convert.ToInt32(hfdhearingdocid.Value), Convert.ToInt32(Request.QueryString[0].ToString()), Convert.ToInt32(Request.QueryString[1].ToString()), txt_documentduedate.Text, docreceived, Session["UID"].ToString(),txt_documentype.Text);
                altbox("Record updated successfully.");
                Clear_HearingDoc();
            }
            if (days < 0 && !chkdocumentreceived.Checked)
            {
                ComplaintsLink.USP_GetNameandLicenseforHearingResult obj = ComplaintsLink.Complaints.GetNameandLicense(Convert.ToInt32(Request.QueryString[0].ToString()), Convert.ToInt32(Request.QueryString[1].ToString()));
                if (obj != null) 
                Mail.SendMail("", "Gokul@igovsolution.com;satish@igovsolution.com", "", "Compliance Documents Past Due", "Name : " + obj.Name + "<br/>License # : " + obj.License + "<br/>Complaint # : " + obj.Complaint_Number);
            }
        }
        private void Clear_HearingDoc()
        {
            hfdhearingdocid.Value = "0";
            txt_documentduedate.Text = "";
            chkdocumentreceived.Checked = false;
        }

        protected void btndownloadall_ServerClick(object sender, EventArgs e)
        {
            string ZipfileName = "";
            ComplaintsTabLinq.TbL_Complaint obj = ComplaintsTabLinq.ClsComplaints.Get_ComplaintNumber(Convert.ToInt32(hfdcmpid.Value));
            if (obj != null)
                ZipfileName = "Hearing Documents For - " + obj.Complaint_Number + ".Zip";
            else
                ZipfileName = "MyZipFiles.Zip";
            Response.ContentType = "application/zip";
            Response.AddHeader("Content-Disposition", "filename=" + ZipfileName);
            byte[] buffer = new byte[4098];
            ZipOutputStream ZipOutStream = new ZipOutputStream(Response.OutputStream);
            ZipOutStream.SetLevel(3);
            try
            {
                List<USP_GetAllDocumentsDownloadHearingResult> Getdocuments = Person_Details.Licensing_Details.GetAlldocumentsDownloadHearing(Convert.ToInt32(hfdcmpid.Value), Convert.ToInt32(hfdperid.Value));
                foreach (var i in Getdocuments.ToList())
                {
                    string docmonth = ""; string docpath = "";
                    string docyear = i.docpath.Substring(39, 4);
                    if (Convert.ToDateTime(i.Document_Date).Month < 10)
                    {
                        docmonth = i.docpath.Substring(44, 1);
                        docpath = i.docpath.Substring(46);
                    }
                    else
                    {
                        docmonth = i.docpath.Substring(44, 2);
                        docpath = i.docpath.Substring(47);
                    }


                    string filepath = System.Configuration.ConfigurationManager.AppSettings["docpath"].ToString() + "\\" + docyear + "\\" + docmonth + "\\" + docpath;
                    Stream fs = File.OpenRead(filepath);
                    ZipEntry zipentry = new ZipEntry(ZipEntry.CleanName(i.Description));
                    zipentry.Size = fs.Length;
                    ZipOutStream.PutNextEntry(zipentry);
                    int count = fs.Read(buffer, 0, buffer.Length);
                    while (count > 0)
                    {
                        ZipOutStream.Write(buffer, 0, count);
                        count = fs.Read(buffer, 0, buffer.Length);
                        if (!Response.IsClientConnected)
                        {
                            break;
                        }
                        Response.Flush();
                    }
                    fs.Close();
                }
                ZipOutStream.Close();
                Response.Flush();
                Response.End();
            }
            catch (Exception ex)
            {
                throw ex;
            }

        }
    }
}