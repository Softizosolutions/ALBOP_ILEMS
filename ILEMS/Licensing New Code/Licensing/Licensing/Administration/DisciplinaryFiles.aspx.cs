using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using Person_Details;
using iTextSharp;
using ICSharpCode.SharpZipLib.Zip;
using AdminLinq;

namespace Licensing.Administration
{
    public partial class DisciplinaryFiles : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {

            }

        }

        protected void btnUpload_Click(object sender, EventArgs e)
        {
            string filename = "";

            if (hfddocid.Value == "0")
            {
                if (upddocument.HasFile)
                {
                    filename = upddocument.PostedFile.FileName;
                }
                Person_Details.TblDisciplinaryFinding pdd = new Person_Details.TblDisciplinaryFinding();
                string guid = Guid.NewGuid().ToString().Replace("-", string.Empty);
                guid = guid + DateTime.Now.ToShortDateString().Replace("/", string.Empty).Replace(":", string.Empty);
                string fext = Path.GetExtension(upddocument.PostedFile.FileName);
                if (upddocument.HasFile)
                {

                    string url = System.Configuration.ConfigurationManager.AppSettings["lmsdoclink"].ToString() + DateTime.Now.Year.ToString() + "/" + DateTime.Now.Month.ToString() + "/";
                    pdd.DocumentPath = url + guid + fext;
                    pdd.Filename = txtFileName.Text;
                    pdd.CreatedBy =  Session["UID"].ToString();
                    pdd.CreatedDate = Convert.ToDateTime(DateTime.Now.ToShortDateString());
                }
                 
                 Person_Details.Licensing_Details.InsertDisciplinaryFiles(pdd);
                txtFileName.Text = "";
                if (upddocument.HasFile)
                {
                    if (!Directory.Exists(System.Configuration.ConfigurationManager.AppSettings["docpath"].ToString() + "\\" + DateTime.Now.Year.ToString()))
                        Directory.CreateDirectory(System.Configuration.ConfigurationManager.AppSettings["docpath"].ToString() + "\\" + DateTime.Now.Year.ToString());
                    if (!Directory.Exists(System.Configuration.ConfigurationManager.AppSettings["docpath"].ToString() + "\\" + DateTime.Now.Year.ToString() + "\\" + DateTime.Now.Month.ToString()))
                        Directory.CreateDirectory(System.Configuration.ConfigurationManager.AppSettings["docpath"].ToString() + "\\" + DateTime.Now.Year.ToString() + "\\" + DateTime.Now.Month.ToString());

                    upddocument.SaveAs(System.Configuration.ConfigurationManager.AppSettings["docpath"].ToString() + "\\" + DateTime.Now.Year.ToString() + "\\" + DateTime.Now.Month.ToString() + "\\" + guid + fext);
                }
                 
                 
            }
             

        }
        protected void btndel_click(object sender, EventArgs e)
        {
            string Value = hfddocid.Value;
            DeleteFile(Convert.ToInt32(Value));

            altbox("Record deleted successfully.");
        }
        private void altbox(string str)
        {
            string js = " afterpost('" + str + "');";
            ScriptManager.RegisterStartupScript(Page, GetType(), "scr", js, true);
        }

        public static void DeleteFile(int docid)
        {
            using (Person_LicenseDataContext plc = new Person_LicenseDataContext())
            {
                Person_Details.TblDisciplinaryFinding obj = plc.TblDisciplinaryFindings.Where(c => c.DisciplinaryFindingsID == docid).SingleOrDefault();
                plc.TblDisciplinaryFindings.DeleteOnSubmit(obj);
                plc.SubmitChanges();
            }
        }
    }
}