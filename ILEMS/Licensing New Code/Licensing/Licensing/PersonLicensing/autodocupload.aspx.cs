using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Person_Details;
using ExpertPdf.HtmlToPdf;

namespace Licensing.PersonLicensing
{
    public partial class autodocupload : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string rnd = Guid.NewGuid().ToString().Replace("-", string.Empty);
                string path=Server.MapPath("Person_Document")+"//" + rnd + ".pdf";
                tbl_Person_Document_Detail pdd = new tbl_Person_Document_Detail();
                pdd.Document_ID =0;
                pdd.Person_ID = Convert.ToInt32(Request.QueryString["pid"].ToString());
                pdd.Cabinet_ID = Convert.ToInt32(Request.QueryString["cabid"].ToString());
                pdd.Folder_ID = Convert.ToInt32(Request.QueryString["fldid"].ToString());
                pdd.Document_Date = DateTime.Now;
                pdd.DocType = Convert.ToInt32(Request.QueryString["doctype"].ToString());
                pdd.Description = Request.QueryString["docdesc"].ToString();
                pdd.docpath = System.Configuration.ConfigurationManager.AppSettings["lmsdoclink"].ToString()+rnd+".pdf";
                pdd.Approval_Needed = Convert.ToBoolean(1);
                pdd.Modified_By = Convert.ToInt32("-1");
                pdd.Modified_Date = Convert.ToDateTime(DateTime.Now.ToShortDateString());
                int docid = Person_Details.Licensing_Details.InsertDocument(pdd);

                Transcript_Request(System.Configuration.ConfigurationManager.AppSettings["onlinetechnicianrenewal"].ToString() + "?ordid=" + Request.QueryString["ordid"].ToString()+"&noprint=0", path);
            }
        }
        public string Transcript_Request(string str_Url, string path)
        {
            try
            {
               
                PdfConverter pdfConverter_Transcrpit = new PdfConverter();
               
                pdfConverter_Transcrpit.LicenseKey = "eVJIWUtLWUtZTFdJWUpIV0hLV0BAQEA=";
                 pdfConverter_Transcrpit.SavePdfFromUrlToFile(str_Url, path);
                return path;
            }
            catch (Exception EX)
            {
                //return "";
                throw EX;
            }

        }
    }
}