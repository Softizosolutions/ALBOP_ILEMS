using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using ExpertPdf.HtmlToPdf;

using System.IO;
using System.Net;
using System;
using System.Net.Http;

namespace Licensing.Prints
{
    public class PDFGenerator
    {
        public PDFGenerator()
        {
            //
            // TODO: Add constructor logic here
            //
        }
        public string Transcript_Request(string str_Url, string path)
        {
            try
            {
                string temp_path = "";

                PdfConverter pdfConverter_Transcrpit = new PdfConverter();
                string temp1 = "";
                pdfConverter_Transcrpit.LicenseKey = "eVJIWUtLWUtZTFdJWUpIV0hLV0BAQEA=";
                //path = path + "\\pdfs\\" + "Transcript" + HttpContext.Current.Session["Datetime"].ToString() + HttpContext.Current.Session.SessionID + ".pdf";
                pdfConverter_Transcrpit.SavePdfFromUrlToFile(str_Url, path);
                return path;
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
            catch (Exception ex)
            {
                return ex.ToString();
            }

        }
        public void Genrateword(string str_Url, string filename)
        {
            try
            {
                string temp_path = "";

                string shtml = apicall(str_Url);
                string strFileName = filename + ".doc";
                System.Web.HttpResponse response = System.Web.HttpContext.Current.Response;
                response.Clear();
                response.AppendHeader("Content-Type", "application/msword");

                response.AppendHeader("Content-disposition", "attachment; filename=" + strFileName);
                response.Write(shtml);
                response.End();

            }
            catch (Exception EX)
            {
                //return "";
                throw EX;
            }

        }
        public void Genratewordtext(string str_text, string filename)
        {
            try
            {
                string temp_path = "";


                string strFileName = filename + ".doc";
                System.Web.HttpResponse response = System.Web.HttpContext.Current.Response;
                response.Clear();
                response.AppendHeader("Content-Type", "application/msword");

                response.AppendHeader("Content-disposition", "attachment; filename=" + strFileName);
                response.Write(str_text);
                response.End();

            }
            catch (Exception EX)
            {
                //return "";
                throw EX;
            }

        }
        public void Genratepdftext(string text, string fname)
        {
            try
            {
                string temp_path = "";

                PdfConverter pdfConverter_Transcrpit = new PdfConverter();
                string temp1 = "";
                pdfConverter_Transcrpit.LicenseKey = "eVJIWUtLWUtZTFdJWUpIV0hLV0BAQEA=";
                byte[] downloadBytes = pdfConverter_Transcrpit.GetPdfBytesFromHtmlString(text);
                System.Web.HttpResponse response = System.Web.HttpContext.Current.Response;
                response.Clear();
                response.AddHeader("Content-Type", "binary/octet-stream");
                response.AddHeader("Content-Disposition", "attachment; filename=" + fname + ".pdf" + "; size=" + downloadBytes.Length.ToString());
                response.Flush();
                response.BinaryWrite(downloadBytes);
                response.Flush();
                response.End();
            }
            catch (Exception EX)
            {
                //return "";
                throw EX;
            }
        }
        public void Genratepdf(string str_Url, string filename)
        {
            try
            {
                string temp_path = "";

                PdfConverter pdfConverter_Transcrpit = new PdfConverter();
                string temp1 = "";
                pdfConverter_Transcrpit.LicenseKey = "eVJIWUtLWUtZTFdJWUpIV0hLV0BAQEA=";
                byte[] downloadBytes = pdfConverter_Transcrpit.GetPdfFromUrlBytes(str_Url);
                System.Web.HttpResponse response = System.Web.HttpContext.Current.Response;
                response.Clear();
                response.AddHeader("Content-Type", "binary/octet-stream");
                response.AddHeader("Content-Disposition", "attachment; filename=" + filename + ".pdf" + "; size=" + downloadBytes.Length.ToString());
                response.Flush();
                response.BinaryWrite(downloadBytes);
                response.Flush();
                response.End();
            }
            catch (Exception EX)
            {
                //return "";
                throw EX;
            }


        }
        public void Genratewordpdf(string str_Url, string filename)
        {
            try
            {
                string temp_path = "";

                string shtml = apicall(str_Url);
                string strFileName = filename + ".doc";
                System.Web.HttpResponse response = System.Web.HttpContext.Current.Response;
                response.Clear();
                response.AddHeader("Content-Type", "binary/octet-stream");
                response.AddHeader("Content-Disposition", "attachment; filename=" + filename + ".pdf" + "; ");
                response.Write(shtml);
                response.End();

            }
            catch (Exception EX)
            {
                //return "";
                throw EX;
            }

        }
        public void Genratepdf1(string str_Url, string filename)
        {
            try
            {
                string temp_path = "";

                PdfConverter pdfConverter_Transcrpit = new PdfConverter();
                string temp1 = "";
                pdfConverter_Transcrpit.LicenseKey = "eVJIWUtLWUtZTFdJWUpIV0hLV0BAQEA=";

                PdfDocumentOptions docopt = new PdfDocumentOptions();
                pdfConverter_Transcrpit.PageWidth = 1100;
                pdfConverter_Transcrpit.PageHeight = 500;
                byte[] downloadBytes = pdfConverter_Transcrpit.GetPdfFromUrlBytes(str_Url);
                pdfConverter_Transcrpit.SavePdfFromUrlToFile(str_Url, "D:\\LMS2.0Final\\LMS\\ABN\\pdfs\\test1.pdf");
                System.Web.HttpResponse response = System.Web.HttpContext.Current.Response;
                response.Clear();
                response.AddHeader("Content-Type", "binary/octet-stream");
                response.AddHeader("Content-Disposition", "attachment; filename=" + filename + ".pdf" + "; size=" + downloadBytes.Length.ToString());
                response.Flush();
                response.BinaryWrite(downloadBytes);
                response.Flush();
                response.End();
            }
            catch (Exception EX)
            {
                //return "";
                throw EX;
            }

        }

    }
}