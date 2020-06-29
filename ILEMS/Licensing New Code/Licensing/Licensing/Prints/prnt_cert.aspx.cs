using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ExpertPdf.HtmlToPdf;
using System.Drawing;

namespace Licensing.Prints
{
    public partial class prnt_cert : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string murl = Request.QueryString["pname"].ToString()+".aspx?refid=" +Request.QueryString["refid"].ToString();
            if (Request.UrlReferrer != null)
            {
                if (Request.UrlReferrer.ToString().Contains("RenewalProcess.aspx"))
                {
                    murl += "&issudt=01/01/2018";
                }
            }
            string url = Request.Url.AbsoluteUri;
            url = url.Substring(0, url.LastIndexOf('/') );
            url = url.Substring(0, url.LastIndexOf('/')+1);
            murl = murl + "&pdesc=" + pname().Replace("_"," ") + "&user=" + Session["UID"].ToString();
            Genratepdftext(url + "Certificates/" + murl);
            

        }
        public string pname()
        {
         
            string pname = Request.QueryString["pname"].ToString();
            switch (pname)
            {
                case "p1":
                    return "Pharmacist_License";
                case "p2":
                    return "Pharmacy_Technician_License";
                case "p3":
                    return "Institutonal_Pharmacy";
                //case "p4":
                //    return "Mail_Order_Pharmacy";
                case "p5":
                    return "MFG/WHSEE/DIST";
                case "p6":
                    return "NON_Resident_Pharmacy";
                case "p8":
                    return "Precursor_Chemical_License";
                case "p9":
                    return "Retail_Medical_Oxygen_License";
                case "p7":
                    return "Pharmacy_Application";               
                case "p11":
                    return "Intern_License";
                case "p12":
                    return "Consultant";
                case "p13":
                    return "Nuclear_Pharmacist";
                case "p14":
                    return "Nuclear_Pharmacy";
                case "p15":
                    return "Parenteral_Facility";
                case "p16":
                    return "Parenteral_Pharmacist";
                case "p17":
                    return "Preceptor";
                case "p20":
                    return "Pharmacy_Technicial_Renewal";
                case "p10":
                    return "Pharmacy_Services_Permit";
            }
            return "";
        }
        public void Genratepdftext(string url)
        {
            try
            {
               
               
                string temp_path = "";

                PdfConverter pdfobj = new PdfConverter();
                string temp1 = "";
                pdfobj.LicenseKey = "eVJIWUtLWUtZTFdJWUpIV0hLV0BAQEA=";
                pdfobj.PdfDocumentOptions.ShowHeader = false;
                pdfobj.PdfDocumentOptions.ShowFooter = false;
                  pdfobj.PdfDocumentInfo.AuthorName = "Cyber Best Technologies";
                pdfobj.PdfDocumentInfo.Title = "Pharmacy Board";
                pdfobj.PdfDocumentInfo.Subject = "Certificate";
                if (Convert.ToInt32(Request.QueryString[0].ToString().Substring(1)) < 11 || Convert.ToInt32(Request.QueryString[0].ToString().Substring(1)) > 19)
                {
                    float width = (8.50f / 1.0f) * 72f;
                    float height = (11 / 1.0f) * 72f;
                    pdfobj.PdfDocumentOptions.AutoSizePdfPage = false;
                    pdfobj.PdfDocumentOptions.PdfPageSize = PdfPageSize.Custom;
                    pdfobj.PdfDocumentOptions.CustomPdfPageSize = new SizeF(width, height);
                    pdfobj.PdfDocumentOptions.PdfPageOrientation = PDFPageOrientation.Portrait;
                }
                else
                {
                    float width = (11f / 1.0f) * 72f;
                    float height = (8.50f / 1.0f) * 72f;
                    pdfobj.PdfDocumentOptions.AutoSizePdfPage = false;
                    pdfobj.PdfDocumentOptions.PdfPageSize = PdfPageSize.Custom;
                    pdfobj.PdfDocumentOptions.CustomPdfPageSize = new SizeF(width, height);
                    
                    pdfobj.PdfDocumentOptions.PdfPageOrientation = PDFPageOrientation.Landscape;
                     
               
                }
                //pdfobj.PdfDocumentInfo.Keywords = "HTML, PDF,Converter";
                pdfobj.PdfDocumentInfo.CreatedDate = DateTime.Now;
              
                byte[] downloadBytes = pdfobj.GetPdfBytesFromUrl(url);
                System.Web.HttpResponse response = System.Web.HttpContext.Current.Response;

                response.Clear();
               // response.Flush();
                response.AddHeader("Content-Type", "binary/octet-stream");
                response.AddHeader("Content-Disposition", "attachment; filename=" + pname()+ ".pdf; size=" + downloadBytes.Length.ToString());
               
                response.BinaryWrite(downloadBytes);
                PersonLicensing.Utilities_Licensing.GetCertficateJournal(Request.QueryString["refid"], pname().Replace("_", " "), Session["UID"].ToString());
                //   response.Flush();
               // response.End();
            }
            catch (Exception EX)
            {
                //return "";
                throw EX;
            }
        }
    }
}