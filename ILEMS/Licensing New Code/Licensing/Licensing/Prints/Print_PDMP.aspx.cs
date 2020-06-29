using ExpertPdf.HtmlToPdf;
using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace Licensing.Prints
{
    public partial class Print_PDMP : System.Web.UI.Page
    {
       
        protected void Page_Load(object sender, EventArgs e)
        {
             string url = Request.Url.AbsoluteUri;
            url = url.Substring(0, url.LastIndexOf('/') );
            url = url.Substring(0, url.LastIndexOf('/')+1);
            url = url + "Prints/PDMP_Details.aspx";
            DataTable dt = new DataTable();
            dt = PersonLicensing.Utilities_Licensing.GetPDMPDetails();
            if(Request.QueryString[0].ToString()=="2")
            Excel.ToExcel(dt, "PDMP_Report.xls", this.Response, "PDMP Report");
            else
            Genratepdftext(url.ToString(), "PDMP");
        }
        private void AddFooter(PdfConverter pdfConverter)
        {
            // string thisPageURL = HttpContext.Current.Request.Url.AbsoluteUri;
            // string headerAndFooterHtmlUrl = thisPageURL.Substring(0, thisPageURL.LastIndexOf('/')) + "/HeaderAndFooterHtml.htm";

            //enable footer
            pdfConverter.PdfDocumentOptions.ShowFooter = true;
            // set the footer height in points
            pdfConverter.PdfFooterOptions.FooterHeight = 30;
            //write the page number
            //  pdfConverter.PdfFooterOptions.TextArea = new TextArea(0, 30, "This is Record ((&p-1)*40); of (&P*40); ",
            //  new System.Drawing.Font(new System.Drawing.FontFamily("Times New Roman"), 10, System.Drawing.GraphicsUnit.Point));
            // pdfConverter.PdfFooterOptions.TextArea.EmbedTextFont = true;
            //   pdfConverter.PdfFooterOptions.TextArea.TextAlign = HorizontalTextAlign.Center;
            // set the footer HTML area

            pdfConverter.PdfFooterOptions.FooterText = "";//"Transaction On : " + Request.QueryString[0].ToString() + "      Total # Transactions : " + noftrnas + "      Total Amount : $" + total.ToString("0.00");
            pdfConverter.PdfFooterOptions.PageNumberTextFontSize = 7;
            //  pdfConverter.PdfFooterOptions.HtmlToPdfArea.EmbedFonts = cbEmbedFonts.Checked;
        }
        public void Genratepdftext(string ptext, string fname)
        {
            try
            {
                string temp_path = "";

                PdfConverter pdfobj = new PdfConverter();
                string temp1 = "";
                pdfobj.LicenseKey = "eVJIWUtLWUtZTFdJWUpIV0hLV0BAQEA=";
                pdfobj.PdfDocumentOptions.ShowHeader = true;
                pdfobj.PdfDocumentOptions.ShowFooter = true;
                string thisPageURL = HttpContext.Current.Request.Url.AbsoluteUri;
                //thisPageURL = thisPageURL.Substring(0, thisPageURL.LastIndexOf('/'));
                string headerAndFooterHtmlUrl = thisPageURL.Substring(0, thisPageURL.LastIndexOf('/')) + "/header.htm";
                pdfobj.PdfHeaderOptions.HtmlToPdfArea = new HtmlToPdfArea(headerAndFooterHtmlUrl);

                //enable header
                AddFooter(pdfobj);
                // set the header height in points
                pdfobj.PdfHeaderOptions.DrawHeaderLine = true;
                pdfobj.PdfHeaderOptions.HeaderHeight = 120;
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
                byte[] downloadBytes = pdfobj.GetPdfBytesFromUrl(ptext);
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
    }
}