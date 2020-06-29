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
using Licensing.Reports;
using System.Net.Http;

namespace Licensing.Prints
{
    public partial class Showprints : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {


                hfdid.Value = Request.QueryString[1].ToString();
                ddllst.DataSource = Reportgenrator.Get_printbytype(Request.QueryString[0].ToString());
                ddllst.DataTextField = "fname";
                ddllst.DataValueField = "PrintID";
                ddllst.DataBind();
                if (Request.QueryString.Count == 3)
                    hfdpid.Value = Request.QueryString[2].ToString();
            }
        }
        public string Getpid()
        {
            if (Request.QueryString.Count==3)
                return Request.QueryString[2].ToString();
            else
                return "";
        }
        protected void btnprint_click(object sender, EventArgs e)
        {
            string murl = Request.Url.AbsoluteUri;
            murl = murl.Substring(0, murl.LastIndexOf('/'));
            murl = System.Configuration.ConfigurationManager.AppSettings["pdfcreatehostname"].ToString();

            string url =murl+"Prints/"+ ddllst.SelectedValue + ".aspx?print=1&pgid=" + ddllst.SelectedValue + "&refid=" + hfdid.Value;

            if ((Request.QueryString[0].ToString() == "3" && ddllst.SelectedValue != "34" && Request.QueryString.Count == 3) || (Request.QueryString[0].ToString() == "4" && Request.QueryString.Count == 3))
                url = murl + "Prints/" + ddllst.SelectedValue + ".aspx?print=1&pgid=" + ddllst.SelectedValue + "&refid=" + hfdid.Value+ "&pid="+Request.QueryString[2].ToString();
            string shtml = apicall(url);


            Response.AppendHeader("Content-Type", "application/msword");
            Response.AppendHeader("Content-disposition", "attachment; filename=" + ddllst.SelectedItem.Text + ".doc");
            //shtml = shtml.Replace("Â", "");
            //shtml = shtml.Replace("â€™", "'");
            Response.Write(shtml);


            Response.End();



        }
        protected void btnprint_click1(object sender, EventArgs e)
        {
            string murl = Request.Url.AbsoluteUri;
            murl = murl.Substring(0, murl.LastIndexOf('/'));
            murl = System.Configuration.ConfigurationManager.AppSettings["pdfcreatehostname"].ToString();

            string url =murl+"Prints/"+ ddllst.SelectedValue + ".aspx?print=1&pgid=" + ddllst.SelectedValue + "&refid=" + hfdid.Value;

            if ((Request.QueryString[0].ToString() == "3" && ddllst.SelectedValue != "34" && Request.QueryString.Count == 3) || ( Request.QueryString[0].ToString() == "4" && Request.QueryString.Count==3))
                url = murl + "Prints/" + ddllst.SelectedValue + ".aspx?print=1&pgid=" + ddllst.SelectedValue + "&refid=" + hfdid.Value + "&pid=" + Request.QueryString[2].ToString();


            Genratepdftext(url, ddllst.SelectedItem.Text);

            //shtml = shtml.Replace("Â", "");
            //shtml = shtml.Replace("â€™", "'");




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
        public void Genratepdftext(string murl,string fname)
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
                string headerAndFooterHtmlUrl = thisPageURL.Substring(0, thisPageURL.LastIndexOf('/')) + "/header.htm";
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
                if (murl.Contains("39.aspx"))
                {
                    pdfobj.PdfDocumentOptions.LeftMargin = 60;
                    pdfobj.PdfDocumentOptions.RightMargin = 60;
                    pdfobj.PdfDocumentOptions.TopMargin = 60;
                    pdfobj.PdfDocumentOptions.BottomMargin = 60;
                }
                else
                {
                    pdfobj.PdfDocumentOptions.LeftMargin = 10;
                    pdfobj.PdfDocumentOptions.RightMargin = 10;
                }

                byte[] downloadBytes = pdfobj.GetPdfBytesFromUrl(murl);
                System.Web.HttpResponse response = System.Web.HttpContext.Current.Response;
                response.Clear();
                response.AddHeader("Content-Type", "binary/octet-stream");
                response.AddHeader("Content-Disposition", "attachment; filename="+fname+".pdf; size=" + downloadBytes.Length.ToString());
                
                response.BinaryWrite(downloadBytes);
                
            }
            catch (Exception EX)
            {
                //return "";
                throw EX;
            }
        }
        private static string apicall(string url)
        {
            try
            {
                System.Net.ServicePointManager.SecurityProtocol =
SecurityProtocolType.Tls | SecurityProtocolType.Tls11 | SecurityProtocolType.Tls12;
                HttpClient httpClient = new HttpClient();
              
                var response = httpClient.GetAsync(url).GetAwaiter().GetResult();

                if (response.IsSuccessStatusCode)
                {
                    var str = response.Content.ReadAsStringAsync().GetAwaiter().GetResult();
                    return str;
                }
                return "";
            }
            catch(Exception ex)
            {
                return ex.ToString();
            }
               
        }

    }
}