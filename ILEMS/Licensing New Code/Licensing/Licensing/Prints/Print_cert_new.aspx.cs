using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ExpertPdf.HtmlToPdf;
using System.Drawing;
using iTextSharp.text.pdf;
using System.IO;
using System.Threading;
using Microsoft.ApplicationBlocks.Data;
using System.Data;

namespace Licensing.Prints
{
    public partial class Print_cert_new : System.Web.UI.Page
    {
        public DataTable Getdata()
        {
            return SqlHelper.ExecuteDataset(System.Configuration.ConfigurationManager.AppSettings["Licensing_Con"].ToString(), "USP_getcertdetails", new object[] { Request.QueryString[1].ToString(), Request.QueryString[0].ToString(), Request.QueryString[2].ToString() }).Tables[0];
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                PersonLicensing.Utilities_Licensing.GetCertficateJournal(Request.QueryString["refid"], Request.QueryString["pname"].ToString(), Session["UID"].ToString());
            }
            catch
            {

            }
            pdf_bindig(Request.QueryString["pname"].ToString());
        }
        public byte[] MergePdfForms(System.Collections.Generic.List<byte[]> files)
        {
            if (files.Count > 1)
            {
                using (System.IO.MemoryStream msOutput = new System.IO.MemoryStream())
                {
                    iTextSharp.text.Document doc = new iTextSharp.text.Document();

                    using (iTextSharp.text.pdf.PdfSmartCopy pCopy = new iTextSharp.text.pdf.PdfSmartCopy(doc, msOutput) { PdfVersion = iTextSharp.text.pdf.PdfWriter.VERSION_1_7 })
                    {
                        doc.Open();
                        foreach (byte[] oFile in files)
                        {
                            using (iTextSharp.text.pdf.PdfReader pdfFile = new iTextSharp.text.pdf.PdfReader(oFile))
                            {
                                for (int i = 1; i <= pdfFile.NumberOfPages; i++)
                                {
                                    pCopy.AddPage(pCopy.GetImportedPage(pdfFile, i));
                                    pCopy.FreeReader(pdfFile);
                                }
                            }
                        }
                    }


                    return msOutput.ToArray();
                }
            }
            else if (files.Count == 1)
            {
                return new System.IO.MemoryStream(files[0]).ToArray();
            }

            return null;
        }
        private void pdf_bindig(string fname)
        {

            string pdfTemplate = Server.MapPath("Certificatees") + "//" + fname + ".pdf"; //@"E:\Work\IGOV\Certificates and Letters\AA Wall Certificate.pdf";

            List<byte[]> downloadBytes = new List<byte[]>();
            DataTable dt = Getdata();
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                PdfReader pdfReader = new PdfReader(pdfTemplate);

                using (MemoryStream output = new MemoryStream())
                {
                    PdfStamper pdfStamper = new PdfStamper(pdfReader, output);


                    AcroFields pdfFormFields = pdfStamper.AcroFields;

                    // set form pdfFormFields

                    // The first worksheet and W-4 form
                    //  pdfFormFields.SetField("LICENSE_NUMBER", "100001 - "+i.ToString());
                    //  pdfFormFields.SetField("NAME", "K V V SATISH");
                    //  pdfFormFields.SetField("LICENSE_ISSUED_DATE_FORMATTED", "10/10/2010");

                    //pdfFormFields.SetField("Name", dt.Rows[i]["oname"].ToString());
                    //pdfFormFields.SetField("Licno", dt.Rows[i]["Lic_no"].ToString());
                    //pdfFormFields.SetField("issuedt", dt.Rows[i]["issudt"].ToString());
                    //pdfFormFields.SetField("expdt", dt.Rows[i]["expdt"].ToString());

                    // pdfFormFields.SetField("Crt_No", dt.Rows[i]["Crt_no"].ToString());
                    pdfFormFields.SetField("Name", dt.Rows[i]["oname"].ToString());
                    pdfFormFields.SetField("Name1", dt.Rows[i]["oname1"].ToString());
                    pdfFormFields.SetField("Business", "VOID");
                    // pdfFormFields.SetField("NamelicB", dt.Rows[i]["License_Type"].ToString().Replace("Apprentice ", ""));
                    // pdfFormFields.SetField("grant_to", dt.Rows[i]["oname"].ToString());
                    string LicType = dt.Rows[i]["LicenseType_ID"].ToString();

                    if (dt.Rows[i]["LicenseType_ID"].ToString() == "1" || dt.Rows[i]["LicenseType_ID"].ToString() == "2" || dt.Rows[i]["LicenseType_ID"].ToString() == "3")
                    {
                        //if (dt.Rows[i]["LicenseType_ID"].ToString() == "2")
                        //{
                            pdfFormFields.SetField("License#2", dt.Rows[i]["Lic_no"].ToString());
                            pdfFormFields.SetField("ExpDate2", dt.Rows[i]["expdt"].ToString());
                        //}
                        
                        if (dt.Rows[i]["LicenseType_ID"].ToString() == "2" && dt.Rows[i]["CS"].ToString() != "0")
                        {
                            pdfFormFields.SetField("VoidName", dt.Rows[i]["oname"].ToString());
                            pdfFormFields.SetField("Fee1", "$100");
                            pdfFormFields.SetField("License#1", dt.Rows[i]["Lic_no"].ToString());
                            pdfFormFields.SetField("ExpDate1", dt.Rows[i]["expdt"].ToString());
                            pdfFormFields.SetField("Schedule1", dt.Rows[i]["Schedules"].ToString());
                            pdfFormFields.SetField("BusinessActivity1", dt.Rows[i]["License_Type"].ToString());
                            pdfFormFields.SetField("DateIssued1", dt.Rows[i]["csissue"].ToString());
                        }
                        else
                        {
                            pdfFormFields.SetField("VoidName", "VOID");
                            pdfFormFields.SetField("Fee1", "VOID");
                            pdfFormFields.SetField("License#1", "VOID");
                            pdfFormFields.SetField("ExpDate1", "VOID");
                            pdfFormFields.SetField("Schedule1", "VOID");
                            pdfFormFields.SetField("BusinessActivity1", "VOID");
                            pdfFormFields.SetField("DateIssued1", "VOID");
                        }

                    }
                    else
                    {
                        pdfFormFields.SetField("Fee", "$$$$");

                    }

                    //if (dt.Rows[i]["License_Type_ID"].ToString() == "5" || dt.Rows[i]["License_Type_ID"].ToString() == "6" || dt.Rows[i]["License_Type_ID"].ToString() == "7" || dt.Rows[i]["License_Type_ID"].ToString() == "8")
                    //{
                    //    pdfFormFields.SetField("Lice_num", "No Permanent License No");
                    //    pdfFormFields.SetField("Lictype2", dt.Rows[i]["License_Type"].ToString().Replace("Apprentice ", ""));

                    //}
                    //else
                    //{
                    //    pdfFormFields.SetField("Lice_num", dt.Rows[i]["Lic_no"].ToString());
                    //    pdfFormFields.SetField("Lictype2", dt.Rows[i]["License_Type"].ToString().Replace("Apprentice ", "") + " # " + dt.Rows[i]["Lic_no"].ToString());
                    //}
                    // pdfFormFields.SetField("Day", Convert.ToDateTime(dt.Rows[i]["issudt"]).ToString("dd"));
                    //pdfFormFields.SetField("Month", Convert.ToDateTime(dt.Rows[i]["issudt"]).ToString("MMMMMMMMM"));
                    pdfFormFields.SetField("ExpYear", Convert.ToDateTime(dt.Rows[i]["expdt"]).ToString("yyyy"));
                    // pdfFormFields.SetField("Executivedirector", "Charles M Perine");
                    // pdfFormFields.SetField("Chair", "MARK N CRADDOCK");
                    // pdfFormFields.SetField("Name2", "MARK N CRADDOCK");
                    //  pdfFormFields.SetField("Year1", Convert.ToDateTime(dt.Rows[i]["expdt"]).ToString("yyyy"));
                    // if (dt.Rows[i]["License_Type_ID"].ToString() == "8" || dt.Rows[i]["License_Type_ID"].ToString() == "7")
                    //    pdfFormFields.SetField("Year1", Convert.ToString(dt.Rows[i]["expdt"]));
                    //   else
                    //      pdfFormFields.SetField("Year1", Convert.ToDateTime(dt.Rows[i]["expdt"]).ToString("yyyy"));

                    //  pdfFormFields.SetField("Nohead", dt.Rows[i]["Crt_no"].ToString());
                    pdfFormFields.SetField("ExpDate", dt.Rows[i]["expdt"].ToString());
                    pdfFormFields.SetField("License#", dt.Rows[i]["Lic_no"].ToString());
                    if (dt.Rows[i]["LicenseType_ID"].ToString() == "13")
                    {

                        pdfFormFields.SetField("LicenseType", dt.Rows[i]["licese_pharamacy"].ToString());

                    }
                    else
                    {
                        pdfFormFields.SetField("LicenseType", dt.Rows[i]["License_Type"].ToString());
                    }
                    pdfFormFields.SetField("MailingAddress", dt.Rows[i]["MailAddress1"].ToString() + "\n" + dt.Rows[i]["MailCity"].ToString() + ", " + dt.Rows[i]["MailState"].ToString() + " " + dt.Rows[i]["MailZip"].ToString());
                    pdfFormFields.SetField("PhysicalAddress", dt.Rows[i]["Address1"].ToString() + "\n" + dt.Rows[i]["City"].ToString() + ", " + dt.Rows[i]["state"].ToString() + " " + dt.Rows[i]["Zip"].ToString());
                    pdfFormFields.SetField("Schedule", dt.Rows[i]["Schedules"].ToString());
                    pdfFormFields.SetField("BusinessActivity", dt.Rows[i]["License_Type"].ToString());
                    pdfFormFields.SetField("DateIssued", dt.Rows[i]["issudt"].ToString());
                    pdfFormFields.SetField("IssuedDate", dt.Rows[i]["IssueDate"].ToString());
                    //*7795 comments//
                    pdfFormFields.SetField("SUP", dt.Rows[i]["sup"].ToString().Replace("&nbsp", ""));
                    pdfFormFields.SetField("SUP_License#", dt.Rows[i]["LicenseNumber"].ToString().Replace("&nbsp", ""));
                    pdfFormFields.SetField("Exp_Month_Year", dt.Rows[i]["Exp_Mnt_Yr"].ToString());
                    pdfFormFields.SetField("Specialty1", dt.Rows[i]["Specialty"].ToString());
                    if (dt.Rows[i]["CS"].ToString() != "0")
                    {
                        pdfFormFields.SetField("License#2", dt.Rows[i]["Lic_no"].ToString());
                        pdfFormFields.SetField("BusinessActivity2", dt.Rows[i]["License_Type"].ToString());
                        pdfFormFields.SetField("Schedule2", dt.Rows[i]["Schedules"].ToString());
                        pdfFormFields.SetField("CS_Issued", dt.Rows[i]["csissue"].ToString());
                        pdfFormFields.SetField("CS_Exp", dt.Rows[i]["csexp"].ToString());
                        pdfFormFields.SetField("VoidName2", dt.Rows[i]["oname"].ToString() + "\n" + dt.Rows[i]["MailAddress1"].ToString() + "\n" + dt.Rows[i]["MailCity"].ToString() + ", " + dt.Rows[i]["MailState"].ToString() + " " + dt.Rows[i]["MailZip"].ToString());

                    }
                    else
                    {
                        pdfFormFields.SetField("VoidName2", "VOID");
                        pdfFormFields.SetField("License#2", "VOID");
                        pdfFormFields.SetField("CS_Issued", "VOID");
                        pdfFormFields.SetField("CS_Exp", "VOID");
                        pdfFormFields.SetField("Schedule2", "VOID");
                        pdfFormFields.SetField("BusinessActivity2", "VOID");
                    }
                    //***7795 Comments  ****//
                    //pdfFormFields.SetField("ExecutiveSecretary", "Charles M Perine");
                    // pdfFormFields.SetField("Chair", "MARK N CRADDOCK");
                    // pdfFormFields.SetField("Year", Convert.ToDateTime(dt.Rows[i]["expdt"]).ToString("yyyy"));

                    // pdfFormFields.SetField("Director", dt.Rows[i]["mdir"].ToString());
                    // pdfFormFields.SetField("Emblember", dt.Rows[i]["memb"].ToString());
                    // pdfFormFields.SetField("Authority", dt.Rows[i]["FEIN"].ToString());
                    // pdfFormFields.SetField("ManagingCremationist", dt.Rows[i]["ManagingCremationist"].ToString());
                    // report by reading values from completed PDF

                    // flatten the form to remove editting options, set it to false
                    // to leave the form open to subsequent manual edits
                    pdfStamper.FormFlattening = true;

                    // close the pdf
                    pdfStamper.Close();
                    downloadBytes.Add(output.ToArray());


                }
            }
            System.Web.HttpResponse response = System.Web.HttpContext.Current.Response;

            Context.Response.Clear();
            // response.Flush();
            Context.Response.AddHeader("Content-Type", "application/pdf");
            Context.Response.AddHeader("Content-Disposition", "attachment; filename=" + fname + ".pdf; ");

            Context.Response.BinaryWrite(MergePdfForms(downloadBytes));

            Context.Response.End();
            Context.Response.Close();

            //  response.End();
        }
    }
}