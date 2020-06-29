using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ExpertPdf.HtmlToPdf;
using System.Drawing;
using System.Net;
using System.IO;
using Person_Details;
using Licensing;
using OperationsLink;
using ComplaintsTabLinq;

using Licensing.Complaints;

namespace Licensing.PersonLicensing
{
    public partial class ComplaintInvestigation : System.Web.UI.Page
    {
        string comid = "1";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                hfdcomid.Value = Request.QueryString[0].ToString(); // comid;
                comid = hfdcomid.Value;
                BindComplaintSummary();

                utilities.BindDropdown(ddlVoilations, 44);
                BindRelevantHistory();
                Bindinvestigations();
                BindinvestigativeViolations();

            }
            comid = hfdcomid.Value;
          

        }
        public void Genratepdftext(string text, string fname)
        {
            try
            {
                string temp_path = "";

                PdfConverter pdfConverter_Transcrpit = new PdfConverter();
                string temp1 = "";
                pdfConverter_Transcrpit.LicenseKey = "eVJIWUtLWUtZTFdJWUpIV0hLV0BAQEA=";
                pdfConverter_Transcrpit.SavePdfFromHtmlStringToFile(text,fname);
              
            }
            catch (Exception EX)
            {
                //return "";
                throw EX;
            }
        }
        protected void btnsendoc_click(object sender, EventArgs e)
        {
            string approval = "";
            
                approval = "false";
            tbl_Person_Document_Detail pdd = new tbl_Person_Document_Detail();
           
                pdd.Person_ID = Convert.ToInt32(Request.QueryString[1].ToString());
                pdd.cmpd = Convert.ToInt32(Request.QueryString[0].ToString());

           
            string guid = Guid.NewGuid().ToString().Replace("-", string.Empty);
            guid = guid + DateTime.Now.ToShortDateString().Replace("/", string.Empty).Replace(":", string.Empty);
            string fext = ".pdf";
            if (txtcomplaint.Text != "")
            {

                string url = System.Configuration.ConfigurationManager.AppSettings["lmsdoclink"].ToString() + DateTime.Now.Year.ToString() + "/" + DateTime.Now.Month.ToString() + "/";
                pdd.docpath = url + guid + fext;
            }
            pdd.Cabinet_ID =1071;
            pdd.Folder_ID =1089;
            pdd.Document_Date = DateTime.Now;
            pdd.DocType =1142;
            pdd.Description = "Investigation Report";
            pdd.Comments = "";
            pdd.Approval_Needed = Convert.ToBoolean(approval);
            pdd.Modified_By = Convert.ToInt32(Session["UID"].ToString());
            pdd.Modified_Date = Convert.ToDateTime(DateTime.Now.ToShortDateString());
            int docid = Person_Details.Licensing_Details.InsertDocument(pdd);
            if (txtcomplaint.Text != "")
            {
                if (!Directory.Exists(System.Configuration.ConfigurationManager.AppSettings["docpath"].ToString() + "\\" + DateTime.Now.Year.ToString()))
                    Directory.CreateDirectory(System.Configuration.ConfigurationManager.AppSettings["docpath"].ToString() + "\\" + DateTime.Now.Year.ToString());
                if (!Directory.Exists(System.Configuration.ConfigurationManager.AppSettings["docpath"].ToString() + "\\" + DateTime.Now.Year.ToString() + "\\" + DateTime.Now.Month.ToString()))
                    Directory.CreateDirectory(System.Configuration.ConfigurationManager.AppSettings["docpath"].ToString() + "\\" + DateTime.Now.Year.ToString() + "\\" + DateTime.Now.Month.ToString());

                var ilink = System.Configuration.ConfigurationManager.AppSettings["lmslink"].ToString();
                Genratepdftext(txtcomplaint.Text.Replace("../Prints", ilink+"/Prints"), System.Configuration.ConfigurationManager.AppSettings["docpath"].ToString() + "\\" + DateTime.Now.Year.ToString() + "\\" + DateTime.Now.Month.ToString() + "\\" + guid + fext);
            }
             altbox("Document Uploaded successfully.");
        }
        private void altbox(string str)
        {
            string js = " altbox('" + str + "');";
            ScriptManager.RegisterStartupScript(Page, GetType(), "scr", js, true);
        }
        public void BindComplaintSummary() 
        {
          
            using (ComplaintsTabLinq.ComplaintsTabDataContext db = new ComplaintsTabLinq.ComplaintsTabDataContext())
            {
               
              
               var obj = db.TbL_Complaints_Summaries.Where(i => i.Cmpid ==Convert.ToInt16( comid)).SingleOrDefault();
               if (obj != null)
               {
                   btndocs.Visible = true;
                   txtcomplaint.Text = obj.SummaryArea.ToString();
                   hfd_sumcomp.Value = obj.SummaryComplaintID.ToString();
               }
            }

        }


        public void BindRelevantHistory()
        {

            using (ComplaintsTabLinq.ComplaintsTabDataContext db = new ComplaintsTabLinq.ComplaintsTabDataContext())
            {


                var obj = db.TbL_Complaints_Relevants.Where(i => i.Cmpid == comid).SingleOrDefault();
                if (obj != null)
                {

                    txtRelevantHistory.Text = obj.RelevantArea.ToString();
                    hfd_relev.Value = obj.RelevantHistoryID.ToString();
                }
            }

        }

        public void Bindinvestigations()
        {

            using (ComplaintsTabLinq.ComplaintsTabDataContext db = new ComplaintsTabLinq.ComplaintsTabDataContext())
            {


                var obj = db.TbL_Complaints_Investigatiors.Where(i => i.Cmp_Id ==Convert.ToInt16( comid)).SingleOrDefault();
                if (obj != null)
                {
                   
                    txtinvestigation.Text = obj.InvestigationComments.ToString();
                    hfd_invid.Value = obj.Cmp_Investigation_Id.ToString();
                   
                        if(obj.IsDrugDivisionChart.ToString()=="True")
                        {
                            chkDrugDiversion.Checked = true;
                        }
                    else
                        {
                            chkDrugDiversion.Checked = false;
                        
                        }

                        if (obj.IsPrescriptionProfileChart.ToString() == "True")
                        {

                            chkPriscriptionprofile.Checked = true;
                        }
                        else
                        {
                            chkPriscriptionprofile.Checked = false;

                        }
                }
            }

        }

        public void BindinvestigativeViolations()
        {

            using (ComplaintsTabLinq.ComplaintsTabDataContext db = new ComplaintsTabLinq.ComplaintsTabDataContext())
            {


                var obj = db.TbL_Complaints_Conclusions.Where(i => i.Cmpid == Convert.ToInt16(comid)).SingleOrDefault();
                if (obj != null)
                {

                    txtinvconclusion.Text = obj.ConclusionArea.ToString();
                    hfd_concl.Value = obj.ConclusionID.ToString();
                    ddlVoilations.SelectedValue = obj.ConclusionViolationID;
                }
            }

        }


        protected void btnAddSummary_Click(object sender, EventArgs e)
        {

            TbL_Complaints_Summary ObjtblCompSummary = new TbL_Complaints_Summary();
            ObjtblCompSummary.Cmpid = Convert.ToInt16(comid);
            ObjtblCompSummary.SummaryArea = txtcomplaint.Text;
            ObjtblCompSummary.CreateUser = 1;

            if (hfd_sumcomp.Value == "")
            {
                ObjtblCompSummary.SummaryComplaintID = 0;
                ObjtblCompSummary.CreatedDate = DateTime.Now;
                ComplaintsTabLinq.ClsComplaints.SummaryInsertValues(ObjtblCompSummary);
                string js = " altbox('Summary added successfully.');";
                ScriptManager.RegisterStartupScript(Page, GetType(), "scr", js, true);
            }
            else
            {
                ObjtblCompSummary.SummaryComplaintID = Convert.ToInt16(hfd_sumcomp.Value);
                ObjtblCompSummary.CreatedDate = DateTime.Now;
                ObjtblCompSummary.ModifiedBy = 1;
                ComplaintsTabLinq.ClsComplaints.SummarysUpdateValues(ObjtblCompSummary);
                string js = " altbox('Summary updated successfully.');";
                ScriptManager.RegisterStartupScript(Page, GetType(), "scr", js, true);
            }
            BindComplaintSummary();
         
           
        }

        protected void btnRelevantHistory_Click(object sender, EventArgs e)
        {
            TbL_Complaints_Relevant obj = new TbL_Complaints_Relevant();
            obj.Cmpid =comid;
            obj.RelevantArea = txtRelevantHistory.Text.Trim();
            obj.CreatedUser = 1;



            if (hfd_relev.Value == "")
            {
                obj.RelevantHistoryID = 0;
                obj.CreatedDate = DateTime.Now;
                ComplaintsTabLinq.ClsComplaints.InsertUpdateDeleteRelevantHistory(obj);
                string js = " altbox('Relevant history added successfully.');";
                ScriptManager.RegisterStartupScript(Page, GetType(), "scr", js, true);
            }
            else
            {
                obj.RelevantHistoryID = Convert.ToInt16(hfd_sumcomp.Value);
                obj.CreatedDate = DateTime.Now;
                obj.ModifiedBy = 1;
                ComplaintsTabLinq.ClsComplaints.InsertUpdateDeleteRelevantHistory(obj);
                string js = " altbox('Relevant history updated successfully.');";
                ScriptManager.RegisterStartupScript(Page, GetType(), "scr", js, true);
            }

            BindRelevantHistory();

        }


        protected void btnInvestigationFindings_Click(object sender, EventArgs e)
        {

            TbL_Complaints_Investigatior obj = new TbL_Complaints_Investigatior();
            obj.Cmp_Id = Convert.ToInt16(comid);
            obj.InvestigationComments = txtinvestigation.Text.Trim();
            obj.Create_User = 1;
            obj.IsDrugDivisionChart = chkDrugDiversion.Checked.ToString();
            obj.IsPrescriptionProfileChart = chkPriscriptionprofile.Checked.ToString();


            if (hfd_invid.Value == "")
            {
                obj.Cmp_Investigation_Id = 0;
                obj.Create_Date = DateTime.Now;           

                ComplaintsTabLinq.ClsComplaints.InsertUpdateDeleteInvestigator(obj);
                string js = " altbox('Investigation findings added successfully.');";
                ScriptManager.RegisterStartupScript(Page, GetType(), "scr", js, true);
            }
            else
            {
                obj.Cmp_Investigation_Id = Convert.ToInt16(hfd_invid.Value);
                obj.Create_Date = DateTime.Now;
                obj.Modified_By = 1;
                ComplaintsTabLinq.ClsComplaints.InsertUpdateDeleteInvestigator(obj);
                string js = " altbox('Investigation findings updated successfully.');";
                ScriptManager.RegisterStartupScript(Page, GetType(), "scr", js, true);
            }
            Bindinvestigations();

        }

        protected void btnDrugDiversion_Click(object sender, EventArgs e)
        {

        }

        protected void btnINvestiativeVoilations_Click(object sender, EventArgs e)
        {

            TbL_Complaints_Conclusion obj = new TbL_Complaints_Conclusion();
            obj.Cmpid = Convert.ToInt16(comid);
            obj.ConclusionArea = txtinvconclusion.Text.Trim();
            obj.CreatedUser = 1;
            obj.ConclusionViolationID = ddlVoilations.SelectedValue;



            if (hfd_concl.Value == "")
            {
                obj.ConclusionID = 0;
                obj.CreateDate = DateTime.Now;

                ComplaintsTabLinq.ClsComplaints.InsertUpdateDeleteConclusion(obj);
                string js = " altbox('Investigative voilations added successfully.');";
                ScriptManager.RegisterStartupScript(Page, GetType(), "scr", js, true);
            }
            else
            {
                obj.ConclusionID = Convert.ToInt16(hfd_concl.Value);
                obj.CreateDate = DateTime.Now;
                obj.modifiedBy = 1;
                ComplaintsTabLinq.ClsComplaints.InsertUpdateDeleteConclusion(obj);
                string js = " altbox('Investigative voilations updated successfully.');";
                ScriptManager.RegisterStartupScript(Page, GetType(), "scr", js, true);
            }
            Bindinvestigations();

        }

        protected void btnprint_Click(object sender, EventArgs e)
        {
            string murl = Request.Url.AbsoluteUri;
            murl = murl.Substring(0, murl.LastIndexOf('/'));
            murl = murl.Substring(0, murl.LastIndexOf('/') + 1);
            string url = murl + "Prints/28_0.aspx?print=1&pgid=28&refid=" + hfdcomid.Value + "&dt=1";
            Genratepdftext1(url, "InvestigativeReportTemplate");
        }
        private void AddFooter(PdfConverter pdfConverter)
        {
            // string thisPageURL = HttpContext.Current.Request.Url.AbsoluteUri;
            // string headerAndFooterHtmlUrl = thisPageURL.Substring(0, thisPageURL.LastIndexOf('/')) + "/HeaderAndFooterHtml.htm";

            //enable footer
            pdfConverter.PdfDocumentOptions.ShowFooter = true;
            // set the footer height in points
            pdfConverter.PdfFooterOptions.FooterHeight = 25;
            //write the page number
            //  pdfConverter.PdfFooterOptions.TextArea = new TextArea(0, 30, "This is Record ((&p-1)*40); of (&P*40); ",
            //  new System.Drawing.Font(new System.Drawing.FontFamily("Times New Roman"), 10, System.Drawing.GraphicsUnit.Point));
            // pdfConverter.PdfFooterOptions.TextArea.EmbedTextFont = true;
            //   pdfConverter.PdfFooterOptions.TextArea.TextAlign = HorizontalTextAlign.Center;
            // set the footer HTML area

            pdfConverter.PdfFooterOptions.FooterText = "";
            pdfConverter.PdfFooterOptions.PageNumberTextFontSize = 7;
            //  pdfConverter.PdfFooterOptions.HtmlToPdfArea.EmbedFonts = cbEmbedFonts.Checked;
        }
        public void Genratepdftext1(string murl, string fname)
        {
            try
            {
                string temp_path = "";

                PdfConverter pdfobj = new PdfConverter();
                string temp1 = "";
                pdfobj.LicenseKey = "eVJIWUtLWUtZTFdJWUpIV0hLV0BAQEA=";
                pdfobj.PdfDocumentOptions.ShowHeader = false;
                pdfobj.PdfDocumentOptions.ShowFooter = false;
                string thisPageURL = HttpContext.Current.Request.Url.AbsoluteUri;
                thisPageURL = thisPageURL.Substring(0, thisPageURL.LastIndexOf('/'));
                string headerAndFooterHtmlUrl = thisPageURL.Substring(0, thisPageURL.LastIndexOf('/') + 1) + "Prints/header.htm";
                pdfobj.PdfHeaderOptions.HtmlToPdfArea = new HtmlToPdfArea(headerAndFooterHtmlUrl);

                //enable header
                AddFooter(pdfobj);
                // set the header height in points
                pdfobj.PdfHeaderOptions.DrawHeaderLine = true;
                pdfobj.PdfHeaderOptions.HeaderHeight = 150;
                pdfobj.PdfHeaderOptions.HeaderText = "";
                pdfobj.PdfHeaderOptions.HeaderSubtitleText = "";
                pdfobj.PdfDocumentOptions.EmbedFonts = true;
                pdfobj.PdfDocumentInfo.AuthorName = "Cyber Best Technologies";
                pdfobj.PdfDocumentInfo.Title = "Pharmacy Board";
                pdfobj.PdfDocumentInfo.Subject = "Print LMS Forms";
                //pdfobj.PdfDocumentInfo.Keywords = "HTML, PDF,Converter";
                pdfobj.PdfDocumentInfo.CreatedDate = DateTime.Now;
                float width = (8.50f / 1.0f) * 72f;
                float height = (11 / 1.0f) * 72f;
                pdfobj.PdfDocumentOptions.AutoSizePdfPage = false;
                pdfobj.PdfDocumentOptions.PdfPageSize = PdfPageSize.Custom;
                pdfobj.PdfDocumentOptions.CustomPdfPageSize = new SizeF(width, height);
                pdfobj.PdfDocumentOptions.PdfPageOrientation = PDFPageOrientation.Portrait;
                pdfobj.PdfDocumentOptions.LeftMargin = 10;
                pdfobj.PdfDocumentOptions.RightMargin = 10;
                byte[] downloadBytes = pdfobj.GetPdfBytesFromHtmlStream(GenerateStreamFromString(txtcomplaint.Text), System.Text.Encoding.Default);
                System.Web.HttpResponse response = System.Web.HttpContext.Current.Response;
                response.Clear();
                response.AddHeader("Content-Type", "binary/octet-stream");
                response.AddHeader("Content-Disposition", "attachment; filename=" + fname + ".pdf; size=" + downloadBytes.Length.ToString());

                response.BinaryWrite(downloadBytes);

            }
            catch (Exception EX)
            {
                //return "";
                throw EX;
            }
        }
        public Stream GenerateStreamFromString(string s)
        {
            MemoryStream stream = new MemoryStream();
            StreamWriter writer = new StreamWriter(stream);
            writer.Write(s);
            writer.Flush();
            stream.Position = 0;
            return stream;
        }
    }
}