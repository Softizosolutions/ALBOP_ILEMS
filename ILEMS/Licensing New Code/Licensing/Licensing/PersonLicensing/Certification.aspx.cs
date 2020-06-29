using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using System.Collections.Generic;
using System.IO;
using Person_Details;

namespace Licensing.PersonLicensing
{
    public partial class Certification : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                hfdperid.Value = Request.QueryString[0].ToString();
                Utilities_Licensing.BindDropdown(ddl_certification_type, 52);
                Utilities_Licensing.BindDropdown(ddl_status, 53);
            }
        }








        protected void btn_submit_Click(object sender, EventArgs e)
        {
            if (hfdcerti_id.Value == "0")
            {

                tbl_Certification ctf = new tbl_Certification();
                ctf.Cert_id = Convert.ToInt32(hfdcerti_id.Value);
                ctf.Cert_Type = ddl_certification_type.SelectedValue;
                ctf.Person_id = Convert.ToInt32(hfdperid.Value);
                ctf.status = ddl_status.SelectedValue;
                ctf.Certno = "";
                ctf.Effective_dt = Convert.ToDateTime(effective_date.Text.ToString());
                ctf.Expiry_dt = Convert.ToDateTime(exp_date.Text.ToString());
                ctf.Orginal_Date = Convert.ToDateTime(txt_orginaldate.Text);
                ctf.Comments = txt_comments.Text;
                ctf.modifiedby = Session["UID"].ToString();
                ctf.modifieddt = Convert.ToDateTime(DateTime.Now.ToShortDateString());
                ctf.createdby = Session["UID"].ToString();
                ctf.createddt = Convert.ToDateTime(DateTime.Now.ToShortDateString());
                Person_Details.Licensing_Details.Insert_Certifications(ctf);
                altbox("Record inserted successfully.");

                Clear();
            }
            else
            {
                tbl_Certification ctf = new tbl_Certification();
                ctf.Cert_id = Convert.ToInt32(hfdcerti_id.Value);
                ctf.Cert_Type = ddl_certification_type.SelectedValue;
                ctf.Person_id = Convert.ToInt32(hfdperid.Value);
                ctf.status = ddl_status.SelectedValue;
                ctf.Certno = "";
                ctf.Effective_dt = Convert.ToDateTime(effective_date.Text.ToString());
                ctf.Expiry_dt = Convert.ToDateTime(exp_date.Text.ToString());
                ctf.Orginal_Date = Convert.ToDateTime(txt_orginaldate.Text);
                ctf.Comments = txt_comments.Text;
                ctf.modifiedby = Session["UID"].ToString();
                ctf.modifieddt = Convert.ToDateTime(DateTime.Now.ToShortDateString());
                
                Person_Details.Licensing_Details.Update_Certifications(ctf);
                altbox("Record updated successfully.");

                Clear();


            }
        }


        protected void btnedit_click(object sender, EventArgs e)
        {

            string Value = hfdselid.Value;





            Person_Details.tbl_Certification obj = Utilities_Licensing.EditCertification(Convert.ToInt32(Value));


            hfdcerti_id.Value = obj.Cert_id.ToString();

            string certificationtype = "";
            certificationtype = obj.Cert_Type;
            ddl_certification_type.SelectedValue = certificationtype;

            hfdperid.Value = obj.Person_id.ToString();

            string status = "";
            status = obj.status;
            ddl_status.SelectedValue = status;

            if (obj.Effective_dt == null)
                effective_date.Text = "";
            else
                effective_date.Text = Convert.ToDateTime(obj.Effective_dt).ToString("MM/dd/yyyy");

            if (obj.Expiry_dt == null)
                exp_date.Text = "";
            else
                exp_date.Text = Convert.ToDateTime(obj.Expiry_dt).ToString("MM/dd/yyyy");

            if (obj.Orginal_Date == null)
                txt_orginaldate.Text = "";
            else
                txt_orginaldate.Text = Convert.ToDateTime(obj.Orginal_Date).ToString("MM/dd/yyyy");
            
            
            txt_comments.Text = obj.Comments;

            string js = "Popup();";
            ScriptManager.RegisterStartupScript(Page, GetType(), "scr", js, true);
        }
        protected void btndel_click(object sender, EventArgs e)
        {
            string value = hfdselid.Value;
            tbl_Certification obj = new tbl_Certification();
            obj.Cert_id = Convert.ToInt32(value);
            Person_Details.Licensing_Details.Delete_Certifications(obj);
            altbox("Record deleted successfully.");
        }
        public void Clear()
        {
            ddl_certification_type.SelectedIndex = -1;
            ddl_status.SelectedIndex = -1;
          
            effective_date.Text = "";
            exp_date.Text = "";
            txt_orginaldate.Text = "";
            txt_comments.Text = "";

            hfdcerti_id.Value = "";
        }
        private void altbox(string str)
        {
            string js = " afterpost('" + str + "');";
            ScriptManager.RegisterStartupScript(Page, GetType(), "scr", js, true);
        }

    }
}
      
 

 
        