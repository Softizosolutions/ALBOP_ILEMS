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
    public partial class Documents : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                hfdperid.Value = Request.QueryString[0].ToString();
                List<tbl_lkp_data> cablst = Person_Details.Licensing_Details.Get_Lkp_tablesdata(39);

                if (Request.QueryString["type"] == null)
                {
                    hfdutype.Value = "1";
                    cablst = cablst.Where(c => c.Lkp_data_ID != 1071 && c.Lkp_data_ID != 1072 && c.Lkp_data_ID != 1075 && c.Lkp_data_ID != 1076 && c.Lkp_data_ID != 1077 && c.Lkp_data_ID != 1085).ToList();
                    Utilities_Licensing.BindDropdown(ddl_doctype, 41);
                    btndownloadall.Visible = false;
                    chklictypes.Visible = true;
                    Utilities_Licensing.BindLicType(ddl_lictypeedit, Convert.ToInt32(hfdperid.Value));
                }
                else
                {
                    hfdutype.Value = Request.QueryString["type"].ToString();
                    if (hfdutype.Value == "2")
                    {
                        cablst = cablst.Where(c => c.Lkp_data_ID == 1071 || c.Lkp_data_ID == 1072).ToList();
                        Utilities_Licensing.BindDropdown(ddl_doctype, 57);
                        btndownloadall.Visible = true;
                        chklictypes.Visible = false;
                        Utilities_Licensing.BindLicType(ddl_lictypeedit, Convert.ToInt32(Request.QueryString[1].ToString()));
                    }
                }
                //BindDocumnetDetails();
                // Utilities_Licensing.BindDropdown(ddl_cabinet, 39);
                if (hfdutype.Value == "1")
                    lictype.Visible = true;
                else
                    lictype.Visible = false;
                ddl_cabinet.DataSource = cablst;
                ddl_cabinet.DataValueField = "Lkp_data_ID";
                ddl_cabinet.DataTextField = "Values";
                ddl_cabinet.DataBind();
                ddl_cabinet.Items.Insert(0, new ListItem("Select", "-1"));
                Utilities_Licensing.BindDropdown(ddl_folder, 40);
                Utilities_Licensing.BindLicType(ddl_licensetype, Convert.ToInt32(hfdperid.Value));
                foreach (ListItem li in ddl_doctype.Items)
                    ddl_doctypeedit.Items.Add(li);
                Utilities_Licensing.BindLicenseTypeByPersonID(chklictypes, Convert.ToInt32(hfdperid.Value));
                foreach (ListItem li in chklictypes.Items)
                {
                    li.Attributes.Add("App_ID", li.Value);
                }
                txt_date.Text = DateTime.Now.ToShortDateString();
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
                if (hfdutype.Value == "1")
                    pdd.Person_ID = Convert.ToInt32(hfdperid.Value);
                else
                {
                    pdd.Person_ID = Convert.ToInt32(Request.QueryString[1].ToString());
                    pdd.cmpd = Convert.ToInt32(hfdperid.Value);

                }
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
                pdd.License_Type = Convert.ToInt32(ddl_licensetype.SelectedValue);
                pdd.Comments = txtdoccomments.Text;
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
                if (hfdutype.Value == "1" && ddl_doctype.SelectedValue == "1389")
                {
                    List<USP_GetLicandCmpDetailsResult> obj = Person_Details.Licensing_Details.GetLicandCmpDetails(Request.QueryString[0].ToString(), docid, ddl_licensetype.SelectedValue, 0);
                    if (obj.Count > 0)
                        Mail.SendMail("", "datkisson@wardcooperlaw.com", "", "Supportive Documents Upload", "Uploaded By : " + obj[0].UploadedBy + "<br/>Licensee’s Name : " + obj[0].Full_Name + "<br/>Case # : " + obj[0].Case_No + "<br/>License # : " + obj[0].Lic_No);
                }
                else if (hfdutype.Value == "2" && ddl_doctype.SelectedValue == "1390")
                {
                    List<USP_GetLicandCmpDetailsResult> obj = Person_Details.Licensing_Details.GetLicandCmpDetails(Request.QueryString[1].ToString(), docid, ddl_licensetype.SelectedValue, Convert.ToInt32(Request.QueryString[0].ToString()));
                    if (obj.Count > 0)
                        Mail.SendMail("", "datkisson@wardcooperlaw.com", "", "Supportive Documents Upload", "Uploaded By : " + obj[0].UploadedBy + "<br/>Licensee’s Name : " + obj[0].Full_Name + "<br/>Case # : " + obj[0].Case_No + "<br/>License # : " + obj[0].Lic_No);
                }
                altbox("Record inserted successfully.");
                Clear();
            }

        }
        protected void btn_submit1_Click(object sender, EventArgs e)
        {
            if (hfddocid.Value != "0")
            {
                Utilities_Licensing.Updatedocumentcomments(Convert.ToInt32(hfddocid.Value), txt_com.Text, ddl_lictypeedit.SelectedValue,ddl_doctypeedit.SelectedValue);
                altbox("Record updated successfully.");
                Page.RegisterStartupScript("js", "<script>sa5.process();</script>");
            }
        }
        protected void btnedit_click(object sender, EventArgs e)
        {
            string value = hfdselid.Value;
            tbl_Person_Document_Detail pdd = Utilities_Licensing.EditDocument(Convert.ToInt32(value));
            hfddocid.Value = pdd.Document_ID.ToString();
            txt_com.Text = pdd.Comments;
            ddl_lictypeedit.ClearSelection();
            if (ddl_lictypeedit.Items.FindByValue(pdd.License_Type.ToString()) != null)
                ddl_lictypeedit.Items.FindByValue(pdd.License_Type.ToString()).Selected = true;
            ddl_doctypeedit.ClearSelection();
            if (ddl_doctypeedit.Items.FindByValue(pdd.DocType.ToString()) != null)
                ddl_doctypeedit.Items.FindByValue(pdd.DocType.ToString()).Selected = true;

            string js = "Popup();";
            ScriptManager.RegisterStartupScript(Page, GetType(), "scr", js, true);
        }
        protected void btndel_click(object sender, EventArgs e)
        {
            string value = hfdselid.Value;
            tbl_Person_Document_Detail obj = new tbl_Person_Document_Detail();
            obj.Document_ID = Convert.ToInt32(value);
            Person_Details.Licensing_Details.DeleteDocument(obj);
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
        //private void BindDocumnetDetails()
        //{
        //    grddocumnet.DataSource = Person_Details.Licensing_Details.Get_DocumentDetails(Convert.ToInt32(hfdperid.Value));
        //    grddocumnet.DataBind();
        //}


        private void Clear()
        {
            ddl_cabinet.SelectedValue = "-1";
            ddl_folder.SelectedValue = "-1";
            ddl_doctype.SelectedValue = "-1";
            txt_date.Text = "";
            txtdoccomments.Text = "";
            chk_approval.Checked = false;
        }



        private void altbox(string str)
        {
            string js = " afterpost('" + str + "');";
            ScriptManager.RegisterStartupScript(Page, GetType(), "scr", js, true);
        }

        protected void btndownloadall_ServerClick(object sender, EventArgs e)
        {
            string ZipfileName = "";
            ComplaintsTabLinq.TbL_Complaint obj = ComplaintsTabLinq.ClsComplaints.Get_ComplaintNumber(Convert.ToInt32(hfdperid.Value));
            if (obj != null)
                ZipfileName = "Case Documents For - " + obj.Complaint_Number + ".Zip";
            else
                ZipfileName = "MyZipFiles.Zip";
            Response.ContentType = "application/zip";
            Response.AddHeader("Content-Disposition", "filename=" + ZipfileName);
            byte[] buffer = new byte[4098];
            ZipOutputStream ZipOutStream = new ZipOutputStream(Response.OutputStream);
            ZipOutStream.SetLevel(3);
            try
            {
                List<USP_GetAllDocumentsDownloadResult> Getdocuments = Person_Details.Licensing_Details.GetAlldocumentsDownload(Convert.ToInt32(hfdperid.Value));
                foreach (var i in Getdocuments.ToList())
                {
                    string docmonth = "";string docpath = "";
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