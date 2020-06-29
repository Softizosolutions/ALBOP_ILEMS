using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
 
using System.Data;


namespace Licensing.PersonLicensing
{
    public partial class Checklist : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
                Utilities_Licensing.Fill_Dropdown(ddlreasonforreject, "tbl_lkp_data", "[Values] disp", "Lkp_data_ID", " Lkp_tbl_ID=28", "Select Reason");
            Utilities_Licensing.Bind_LicenseTypes(ddl_Lictype);
            ddl_Lictype.Items.Insert(0, new ListItem("Select License Type", "-1"));
            Utilities_Licensing.Bind_login(ddlperres, "ALL");
            //Utilities_Licensing.Fill_Dropdown(ddlappstate, "tbl_LKP_State", "StateName", "StateId", "", "Select State");
            // Utilities_Licensing.Fill_Dropdown(ddlLicenseType, "tbl_License_Type", "Description", "Lic_type_id", "", "Select License Type");
            // Utilities_Licensing.Fill_Dropdown(ddlcountry, "tbl_LKP_County", "County", "County_Code", "", "Select Country");


        }

        

        


        public string alertst(string str)
        {
            if (str == "0")
                return "No";
            else
                return "Yes"; 
        }
        public string Format_ssn(string temp)
        {
            if (temp.Length == 9)
            {
                return temp.Substring(0, 3) + "-" + temp.Substring(3, 2) + "-" + temp.Substring(5, 4);
            }
            else
                return temp;
        }
        public string Overdue(string temp, string cdays)
        {
            if (temp != "" && cdays != "")
            {
                if (DateTime.Parse(temp).AddDays(Convert.ToInt32(cdays)) < DateTime.Now)
                {
                    return "Non-Issue";
                }
                else
                {
                    return "";
                }
            }
            else
                return "";
        }
        public string Format_Date(string dt)
        {
            try
            {
                return DateTime.Parse(dt).ToShortDateString();
            }
            catch
            {
                return "";
            }
        }
        public string Format_phone(string temp)
        {
            if (temp.Length == 10)
            {
                return "(" + temp.Substring(0, 3) + ")&nbsp;" + temp.Substring(3, 3) + "-" + temp.Substring(6, 4);
            }
            else
                return temp;
        }
        public string AppEdit(string Apid, string lictypeid)
        {
            string js = "popup1();";
            ScriptManager.RegisterStartupScript(Page, GetType(), "scr", js, true);

            return "javascript:return Showedit(" + Apid + "," + lictypeid + "')";
        }

        private int rdb_check(GridViewRow gvr)
        {
            RadioButton rdb;
            for (int i = 1; i < 5; i++)
            {
                rdb = (RadioButton)gvr.FindControl("rdb" + i);
                if (rdb.Checked == true)
                    return i;
            }
            return 0;
        }
        public string toup(string str)
        {
            string sr = str.ToUpper();
            return sr;
        }

        private void  altbox(string str)
        {
            string js = " altbox('" + str + "')";
            ScriptManager.RegisterStartupScript(Page, GetType(), "scr", js, true);
        }
     
        

        
        protected void btnOK_Click(object sender, EventArgs e)
        {
            //DateTime.Now.ToString("MM/dd/yyyy"), Session["UserDetailname"].ToString(), Session["UID"].ToString());
            License_Data.License_Details.Delete_Checklist(Convert.ToInt32(hfdselappid.Value), ddlreasonforreject.SelectedValue.ToString());
            hfdselappid.Value = "0";
            ddlreasonforreject.SelectedIndex = -1;


            ScriptManager.RegisterStartupScript(Page, GetType(), "js", " altbox('Application Successfully removed from Checklist.');bindchk();", true);
           
          
        }

       
      
    }
}