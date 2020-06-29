using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net;
using System.IO;
using Licensing.Reports;
using ExpertPdf.HtmlToPdf;
using System.Net.Http;

namespace Licensing.Prints
{
    public partial class Showcrt : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {


                hfdid.Value = Request.QueryString[1].ToString();

                ddllst.Items.Add(new ListItem("Pharmacist License", "p1"));
                ddllst.Items.Add(new ListItem("Pharmacy Technician License", "p2"));
                ddllst.Items.Add(new ListItem("Institutonal Pharmacy", "p3"));
                //ddllst.Items.Add(new ListItem("Mail Order Pharmacy", "p4"));
                ddllst.Items.Add(new ListItem("MFG/WHSEE/DIST", "p5"));
                ddllst.Items.Add(new ListItem("NON Resident Pharmacy", "p6"));
                ddllst.Items.Add(new ListItem("Precursor Chemical License", "p8"));
                ddllst.Items.Add(new ListItem("Retail Medical Oxygen License", "p9"));              
                ddllst.Items.Add(new ListItem("Pharmacy Application", "p7"));
                ddllst.Items.Add(new ListItem("Intern License", "p11"));
                ddllst.Items.Add(new ListItem("Consultant", "p12"));
                ddllst.Items.Add(new ListItem("Nuclear Pharmacist", "p13"));
                ddllst.Items.Add(new ListItem("Nuclear Pharmacy", "p14"));
                ddllst.Items.Add(new ListItem("Parenteral Facility", "p15"));
                ddllst.Items.Add(new ListItem("Parenteral Pharmacist", "p16"));
                ddllst.Items.Add(new ListItem("Pharmacy Services", "p10"));
                ddllst.Items.Add(new ListItem("Preceptor", "p17"));
                ddllst.Items.Add(new ListItem("Mail Label", "-1"));
                ddllst.Items.Add(new ListItem("NEW BUSINESS CERTIFICATE ALBOP", "NEW BUSINESS CERTIFICATE ALBOP"));
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