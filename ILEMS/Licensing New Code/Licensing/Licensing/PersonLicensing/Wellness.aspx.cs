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
using System.Web.Script.Serialization;

namespace Licensing.PersonLicensing
{
    public partial class Wellness : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                hfdperid.Value = Request.QueryString[0].ToString();
                Utilities_Licensing.BindDropdown(ddl_doctype, 64);
                tbl_Person_wellness_Document wellness = Person_Details.Licensing_Details.GetAllWellnessDocument(hfdperid.Value);
                if (wellness != null)
                {
                    chkalldocumentsreceived.Checked = Convert.ToBoolean(wellness.AllDocumentsReceived);
                }
                
            }
        }
        protected void btn_submit_Click(object sender, EventArgs e)
        {
            string filename = ""; string docpath = "";
            string licensename = ""; string licno = "";
            using (Person_Details.Person_LicenseDataContext pldc = new Person_LicenseDataContext())
            {
                tbl_PersonDetail obj = new tbl_PersonDetail();
                obj = pldc.tbl_PersonDetails.Where(c => c.Person_ID == Convert.ToInt32(hfdperid.Value)).SingleOrDefault();
                licensename = obj.First_Name + ' ' + obj.Middle_Name + ' ' + obj.Last_Name;

                tbl_license lic = pldc.tbl_licenses.Where(c => c.Person_ID == Convert.ToInt32(hfdperid.Value)).FirstOrDefault();
                if (lic != null)
                {
                    tbl_license lic1 = pldc.tbl_licenses.Where(c => c.Person_ID == Convert.ToInt32(hfdperid.Value)).OrderByDescending(c => c.License_ID).First();
                    licno = lic1.Lic_no;
                }
            }


            JavaScriptSerializer js = new JavaScriptSerializer();
            var docdata = js.Deserialize<List<string>>(hfddocument.Value);
            foreach (string t in docdata)
            {
                string[] fdata = t.Split('~');
                string url = System.Configuration.ConfigurationManager.AppSettings["lmsdoclink"].ToString() + DateTime.Now.Year.ToString() + "/" + DateTime.Now.Month.ToString() + "/"+ fdata[0];

                int docid = Person_Details.Licensing_Details.InsertWellnessDocument(Convert.ToInt32(hfddocid.Value), hfdperid.Value, ddl_doctype.SelectedValue, url, fdata[1], txtdoccomments.Text, Session["UID"].ToString(), Convert.ToDateTime(DateTime.Now.ToShortDateString()));
                
            }
            
            altbox("Record inserted successfully.");
            Clear();

        }
        protected void btndel_click(object sender, EventArgs e)
        {
            string value = hfdselid.Value;
            Person_Details.Licensing_Details.DeleteWellnessDocument(Convert.ToInt32(value));
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
            ddl_doctype.SelectedValue = "-1";
            txtdoccomments.Text = "";
            chkalldocumentsreceived.Checked = false;
        }
        private void altbox(string str)
        {
            string js = " afterpost('" + str + "');";
            ScriptManager.RegisterStartupScript(Page, GetType(), "scr", js, true);
        }

        protected void btndownloadall_ServerClick(object sender, EventArgs e)
        {
            string ZipfileName = "";
            if(hfdperid.Value!="0")
                ZipfileName = "Wellness Documents For - " + hfdperid.Value + ".Zip";
            else
                ZipfileName = "MyZipFiles.Zip";
            Response.ContentType = "application/zip";
            Response.AddHeader("Content-Disposition", "filename=" + ZipfileName);
            byte[] buffer = new byte[4098];
            ZipOutputStream ZipOutStream = new ZipOutputStream(Response.OutputStream);
            ZipOutStream.SetLevel(3);
            try
            {
                List<USP_GetWellnessDocumentsResult> Getdocuments = Person_Details.Licensing_Details.GetAllWellnessDocuments(Convert.ToInt32(hfdperid.Value));
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
                    ZipEntry zipentry = new ZipEntry(ZipEntry.CleanName(i.Filename));
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

        protected void btnsubmitall_Click(object sender, EventArgs e)
        {
            string licensename = ""; string licno = "";
            using (Person_Details.Person_LicenseDataContext pldc = new Person_LicenseDataContext())
            {
                tbl_PersonDetail obj = new tbl_PersonDetail();
                obj = pldc.tbl_PersonDetails.Where(c => c.Person_ID == Convert.ToInt32(hfdperid.Value)).SingleOrDefault();
                licensename = obj.First_Name + ' ' + obj.Middle_Name + ' ' + obj.Last_Name;

                tbl_license lic = pldc.tbl_licenses.Where(c => c.Person_ID == Convert.ToInt32(hfdperid.Value)).FirstOrDefault();
                if (lic != null)
                {
                    tbl_license lic1= pldc.tbl_licenses.Where(c => c.Person_ID == Convert.ToInt32(hfdperid.Value)).OrderByDescending(c => c.License_ID).First();
                    licno = lic1.Lic_no;
                }

                var query = pldc.tbl_Person_wellness_Documents.Where(c => c.Person_ID == hfdperid.Value).ToList();
                if (query.Count!=0)
                {
                    foreach (tbl_Person_wellness_Document ac in query)
                    {
                        ac.AllDocumentsReceived = chkalldocumentsreceived.Checked;
                        ac.Modified_By = Session["UID"].ToString();
                        ac.Modified_Date = Convert.ToDateTime(DateTime.Now.ToShortDateString());
                    }
                    pldc.SubmitChanges();
                    if (chkalldocumentsreceived.Checked)
                        Mail.SendMail("", "pwright@albop.com;rcoker@albop.com;wpassmore@albop.com;datkisson@wardcooperlaw.com;Ebraden@albop.com", "", "Wellness Docs Marked Complete", "Name : " + licensename + "</br>License #:  : " + licno);
                }
                else
                {
                    string js = " altbox('No documents found.');";
                    ScriptManager.RegisterStartupScript(Page, GetType(), "scr", js, true);
                    chkalldocumentsreceived.Checked = false;
                }
            }

            
                 
        }
    }
}