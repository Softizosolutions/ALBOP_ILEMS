using System;
using System.Web.UI;
using Person_Details;
using System.IO;


namespace Licensing.PersonLicensing
{
    public partial class Specialties : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
                if (!IsPostBack)
            {


                 Utilities_Licensing.BindDropdown(ddl_doctype , 70); 
                    Utilities_Licensing.BindDropdown(ddl_Doctypeedit, 70);
                hfdperid.Value = Request.QueryString[0].ToString();
                Speciality obj = Person_Details.Licensing_Details.Getspeciality(Convert.ToInt32(hfdperid.Value));
                if (obj != null)

                {
                    if (obj.DrugCollector == Convert.ToBoolean(1))
                    {
                        drugcollect.Checked = true;
                    }
                    else
                    {
                        drugcollect.Checked = false;
                    }
                    if (obj.Parenteral == Convert.ToBoolean(1))
                    {
                        txtparent.Checked = true;
                    }
                    else
                    {
                        txtparent.Checked = false;
                    }
                    if (obj.Nuclear == Convert.ToBoolean(1))
                    {
                        txtnuclear.Checked = true;
                    }
                    else
                    {
                        txtnuclear.Checked = false;
                    }
                    if (obj.RemoteOrderEntry == Convert.ToBoolean(1))
                    {
                        txtremorder.Checked = true;
                    }
                    else
                    {
                        txtremorder.Checked = false;
                    }
                    if (obj.NonPharmacyKeyHolder == Convert.ToBoolean(1))
                    {
                        txtnonpharmacy.Checked = true;
                    }
                    else
                    {
                        txtnonpharmacy.Checked = false;
                    }
                }

                else
                {
                    hfd_chkid.Value = "0";

                }
            }
            
            

        }


        protected void btn_submit_Click1(object sender, EventArgs e)
        {
            string chk1, chk2, chk3, chk4, chk5;
            if (drugcollect.Checked == true)
            {
                chk1 = "1";

            }
            else
            { 
                chk1 = "0";
        }
            if (txtparent.Checked == true)
            {
                chk2 = "1";

            }
            else
            {
                chk2 = "0";
            }
            if (txtnuclear.Checked == true)
            {
                chk3 = "1";

            }
            else
            {
                chk3 = "0";
            }
            if (txtremorder.Checked == true)
            {
                chk4 = "1";

            }
            else
            {
                chk4 = "0";
            }
            if (txtnonpharmacy.Checked == true)
            {
                chk5 = "1";

            }
            else
            {
                chk5 = "0";
            }
           Speciality obj = Person_Details.Licensing_Details.Getspeciality(Convert.ToInt32(hfdperid.Value));
            if(obj== null)
            {
                Person_Details.Licensing_Details.Insertspeciality(0, Convert.ToInt32(hfdperid.Value), "", chk1, chk2, chk3, chk4, chk5, Session["UID"].ToString());
                altbox("Checked successfully.");
            }

            else
            {
                Person_Details.Licensing_Details.Insertspeciality(obj.SpecialityID, Convert.ToInt32(hfdperid.Value), "", chk1, chk2, chk3, chk4, chk5, Session["UID"].ToString());
                altbox(" Updated successfully.");
            }
           


            //ClearValues();

        }

        private void altbox(string str)
        {
            string js = "afterpost('" + str + "');";
            ScriptManager.RegisterStartupScript(Page, GetType(), "scr", js, true);
        }
        private void altbox1(string str)
        {
            string js = "afterpost1('" + str + "');";
            ScriptManager.RegisterStartupScript(Page, GetType(), "scr", js, true);
        }


        protected void btn_upload_Click(object sender, EventArgs e)
        {
            string filename = "";

            if (hfddocid.Value == "0")
            {
                if (upddocument.HasFile)
                {
                    filename = upddocument.PostedFile.FileName;
                }
           
                tbl_Speciality_Document_Detail pdd = new tbl_Speciality_Document_Detail();
                pdd.Document_ID = Convert.ToInt32(hfddocid.Value);
                string guid = Guid.NewGuid().ToString().Replace("-", string.Empty);
                guid = guid + DateTime.Now.ToShortDateString().Replace("/", string.Empty).Replace(":", string.Empty);
                string fext = Path.GetExtension(upddocument.PostedFile.FileName);
                if (upddocument.HasFile)
                {
                    string url = System.Configuration.ConfigurationManager.AppSettings["lmsdoclink"].ToString() + DateTime.Now.Year.ToString() + "/" + DateTime.Now.Month.ToString() + "/";
                    pdd.docpath = url + guid + fext;
                }
                pdd.Person_ID = Convert.ToInt32(hfdperid.Value);
             
                pdd.Document_Date = Convert.ToDateTime(txt_date.Text);
                pdd.DocType = Convert.ToInt32(ddl_doctype.SelectedValue);
                pdd.Description = filename;
        
                pdd.Modified_By = Convert.ToInt32(Session["UID"].ToString());
                pdd.Modified_Date = Convert.ToDateTime(DateTime.Now.ToShortDateString());
                int docid = Person_Details.Licensing_Details.InsertDocumentspeciality(pdd);
                if (upddocument.HasFile)
                {
                    if (!Directory.Exists(System.Configuration.ConfigurationManager.AppSettings["docpath"].ToString() + "\\" + DateTime.Now.Year.ToString()))
                        Directory.CreateDirectory(System.Configuration.ConfigurationManager.AppSettings["docpath"].ToString() + "\\" + DateTime.Now.Year.ToString());
                    if (!Directory.Exists(System.Configuration.ConfigurationManager.AppSettings["docpath"].ToString() + "\\" + DateTime.Now.Year.ToString() + "\\" + DateTime.Now.Month.ToString()))
                        Directory.CreateDirectory(System.Configuration.ConfigurationManager.AppSettings["docpath"].ToString() + "\\" + DateTime.Now.Year.ToString() + "\\" + DateTime.Now.Month.ToString());

                    upddocument.SaveAs(System.Configuration.ConfigurationManager.AppSettings["docpath"].ToString() + "\\" + DateTime.Now.Year.ToString() + "\\" + DateTime.Now.Month.ToString() + "\\" + guid + fext);
                }
                altbox1("Record inserted successfully.");

            }


        }

        protected void btndel_Click(object sender, EventArgs e)
        {
            string value = hfdinsid.Value;
            tbl_Speciality_Document_Detail obj = new tbl_Speciality_Document_Detail();
            obj.Document_ID = Convert.ToInt32(value);
            Person_Details.Licensing_Details.DeleteDocumentSpeciality(obj.Document_ID);
            altbox1("Record deleted successfully.");
            hfdinsid.Value = "0";
        }

        protected void btnedit_Click(object sender, EventArgs e)
        {
            string value = hfdinsid.Value;
            tbl_Speciality_Document_Detail obj = Person_Details.Licensing_Details.Edit_SpecailityInspection(Convert.ToInt32(value));

            hfddocid.Value = obj.Document_ID.ToString();


            if (ddl_Doctypeedit.Items.FindByValue(obj.DocType.ToString()) != null)
                ddl_Doctypeedit.Items.FindByValue(obj.DocType.ToString()).Selected = true;



            txt_editDate.Text = Convert.ToDateTime(obj.Document_Date).ToString("MM/dd/yyyy");
        
        

            string js = "Popup();";
            ScriptManager.RegisterStartupScript(Page, GetType(), "scr", js, true);
        }

        protected void btn_submit1_Click(object sender, EventArgs e)
        {
            if (hfddocid.Value != "0")
            {
                Utilities_Licensing.Updatedocumentspeciality(Convert.ToInt32(hfddocid.Value), ddl_Doctypeedit.SelectedValue, txt_editDate.Text);
                altbox1("Record updated successfully.");
                Page.RegisterStartupScript("js", "<script>sa5.process();</script>");
            }
        }
    }
    }
