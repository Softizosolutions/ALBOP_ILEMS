using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ExpertPdf.HtmlToPdf;
using System.Drawing;
using System.Text;
namespace Licensing.Prints
{
    public partial class print_roc : System.Web.UI.Page
    {
        decimal total = 0; int noftrnas = 0; string sdt; string edt;
        private string subhead()
        {
            if (Request.QueryString[3].ToString() == "2")
                return "Manual ";
            else
                if (Request.QueryString[3].ToString() == "1")
                return "Online ";
            else
                return "All ";

        }
        protected void Page_Load(object sender, EventArgs e)
        {
            sdt = Request.QueryString[0].ToString();
            edt = Request.QueryString[1].ToString();
            if (edt == "")
                edt = sdt.ToString();
            StringBuilder stb = new StringBuilder();
            List<Reports.USP_GetrocResult> lst = Reports.Reportgenrator.GetROC(Convert.ToInt32(Request.QueryString[3].ToString()), Convert.ToDateTime(sdt), Convert.ToDateTime(edt));
            List<Reports.USP_Getroc_detailsResult> lstdet_main;
            stb.Append("<html><head> <link href='../Styles/product.css' rel='stylesheet' type='text/css' /> <style>  table.print-friendly tr td, table.print-friendly tr   {     height:20px;    } </style> </head><body>");
            if (edt == sdt)
                stb.Append("<h2 style='color:#1c5e80;' align='center'>" + subhead() + "Transactions for " + sdt + "</h2>");
            else
                stb.Append("<h2 style='color:#1c5e80;' align='center'>" + subhead() + "Transactions for " + sdt + " and " + edt + "</h2>");
            if (Request.QueryString["type"].ToString() == "0")
            {
                stb.Append("<table width='90%' border='1' cellspacing='0' bordercolor='#000' class='grdmain' cellpadding='5' align='center'>");
                stb.Append("<tr style='background:#1c5e80;color:white'><td align='center'>Fee Code</td><td align='center'>Fee Type</td><td align='right'>Amount</td></tr>");
                foreach (Reports.USP_GetrocResult obj in lst)
                {
                    stb.Append("<tr><td align='center'>" + obj.code + "&nbsp;</td><td align='center'>" + obj.Fee_type + "</td><td align='right'>$" + obj.Amount.ToString("0.00") + "&nbsp;</td></tr>");
                    total += obj.Amount;
                    noftrnas += Convert.ToInt32(obj.nof);
                }
                stb.Append("<tr style='background:#1c5e80;color:white'><td>&nbsp;</td><td align='center'>Total # of Transactions:&nbsp;" + noftrnas + "&nbsp;</td><td align='right'>Total Amount: $" + total.ToString("0.00") + "</td></tr>");

                stb.Append("<table>");
            }
            else
            {
                lstdet_main = Reports.Reportgenrator.GetROCDetails(Convert.ToInt32(Request.QueryString[3].ToString()), Convert.ToDateTime(sdt), 1, Convert.ToDateTime(edt));


                stb.Append("<table width='98%' border='1' cellspacing='0' bordercolor='#000' class='grdmain' cellpadding='5' align='center' class='print-friendly'>");
                stb.Append("<tr style='background:#1c5e80;color:white'><td width='50px'>Sr No</td><td align='center'>Name</td><td align='center'>License #</td><td align='center'>Fee Type</td><td align='center' >Amount</td><td align='center'>Check #</td></tr>");
                List<Reports.USP_Getroc_detailsResult> lstdet = lstdet_main.OrderBy(c => c.Fee_type).ToList();
                noftrnas = lstdet.Count;
                for (int i = 1; i <= lstdet.Count; i++)
                {
                    if (i % 21 == 0)
                    {
                        stb.Append("</table>");
                        stb.Append("<div style='page-break-before:always' />");

                        stb.Append("<table width='98%' border='1' cellspacing='0' bordercolor='#000' class='grdmain' cellpadding='5' align='center' class='print-friendly'>");
                        stb.Append("<tr style='background:#1c5e80;color:white'><td width='50px'>Sr No</td><td align='center'>Name</td><td align='center'>License #</td><td align='center'>Fee Type</td><td align='center' >Amount</td><td align='center'>Check #</td></tr>");

                    }
                    stb.Append("<tr><td align='center'>" + i.ToString() + "</td><td align='center'>" + lstdet[i - 1].Pname + "&nbsp;</td><td align='center'>" + lstdet[i - 1].licno + "&nbsp;</td><td align='center'>" + lstdet[i - 1].Fee_type + "&nbsp;</td><td align='right'>$" + lstdet[i - 1].Amount.ToString("0.00") + "&nbsp;</td><td align='center'>"+lstdet[i-1].CheckNumber+"</td></tr>");
                    total += lstdet[i - 1].Amount;

                }
                stb.Append("</table>");


            }
            stb.Append(" </body></html>");
            Genratepdftext(stb.ToString(), "ROC");
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
            if(edt==sdt)
                pdfConverter.PdfFooterOptions.FooterText = "Transaction On : " + sdt + "    Total # Transactions : " + noftrnas + "      Total Amount : $" + total.ToString("0.00");
            else
                pdfConverter.PdfFooterOptions.FooterText = "Transaction On : " + sdt + "  and " + edt + "    Total # Transactions : " + noftrnas + "      Total Amount : $" + total.ToString("0.00");
            
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
                thisPageURL = thisPageURL.Substring(0, thisPageURL.LastIndexOf('?'));
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
                pdfobj.PdfDocumentOptions.LeftMargin = 10;
                pdfobj.PdfDocumentOptions.RightMargin = 10;
                byte[] downloadBytes = pdfobj.GetPdfBytesFromHtmlString(ptext);
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