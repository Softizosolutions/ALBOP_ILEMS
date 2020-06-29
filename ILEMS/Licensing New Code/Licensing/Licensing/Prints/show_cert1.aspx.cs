using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using Licensing.Reports;
using ExpertPdf.HtmlToPdf;
using Licensing.PersonLicensing;
using System.Net;
using System.Net.Http;

namespace Licensing.Prints
{
    public partial class show_cert1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {


                hfdid.Value = Request.QueryString[1].ToString();
                foreach (string fname in Directory.GetFiles(Server.MapPath("Certificatees")))
                {
                    FileInfo fi = new FileInfo(fname);
                    ddllst.Items.Add(new ListItem(fi.Name.Replace(".pdf", ""), fi.Name.Replace(".pdf", "")));
                }
                // Utilities_Licensing.Bind_LicenseTypes(ddllst);

            }
        }
        protected void btnprint_click(object sender, EventArgs e)
        {
            string url = ddllst.SelectedValue + ".aspx?print=1&pgid=" + ddllst.SelectedValue + "&refid=" + hfdid.Value;
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
            string url = ddllst.SelectedValue + ".aspx?print=1&pgid=" + ddllst.SelectedValue + "&refid=" + hfdid.Value;


            PDFGenerator obj = new PDFGenerator();
            obj.Genratepdf(System.Configuration.ConfigurationManager.AppSettings["pdfcreatehostname"].ToString() + "Certificates/" + url, ddllst.SelectedItem.Text + ".pdf");

            //shtml = shtml.Replace("Â", "");
            //shtml = shtml.Replace("â€™", "'");




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
    }
}