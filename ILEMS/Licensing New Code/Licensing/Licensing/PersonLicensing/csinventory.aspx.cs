using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Licensing.PersonLicensing
{
    public partial class csinventory : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                hfdperid.Value = Request.QueryString[0].ToString();
                //Utilities_Licensing.BindDropdown(ddl_State_Of_Discipline, 9);
            }
        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {

            if (hfdselid.Value == "0")
            {
             Person_Details.Licensing_Details.InsertCsInventory(0, Convert.ToInt32(hfdperid.Value),txt_Inventory_Date.Text,Session["UID"].ToString());
                altbox("Record inserted successfully.");
            }
            else
            {
                Person_Details.Licensing_Details.InsertCsInventory(Convert.ToInt32(hfdselid.Value), Convert.ToInt32(hfdperid.Value), txt_Inventory_Date.Text,  Session["UID"].ToString());
                altbox("Record updated successfully.");
            }
            ClearValues();
        }
        public void ClearValues()
        {

            txt_Inventory_Date.Text = "";
           
            hfdselid.Value = "0";
        }
        protected void btnedit_Click(object sender, EventArgs e)
        {
            Person_Details.tbl_CSinventory Disp = Person_Details.Licensing_Details.Edit_CSinventory(Convert.ToInt32(hfdselid.Value));
            if (Disp != null)
            { 
                if (Disp.InventoryDate != null)
                    txt_Inventory_Date.Text = Convert.ToDateTime(Disp.InventoryDate).ToString("MM/dd/yyyy");
                string js = "Popup();";
                ScriptManager.RegisterStartupScript(Page, GetType(), "scr", js, true);
            }
        }

        protected void btndel_Click(object sender, EventArgs e)
        {
            Person_Details.Licensing_Details.Delete_csinvetory(Convert.ToInt32(hfdselid.Value));
            altbox("Record deleted successfully.");
            hfdselid.Value = "0";
        }
        private void altbox(string str)
        {
            string js = " afterpost('" + str + "');";
            ScriptManager.RegisterStartupScript(Page, GetType(), "scr", js, true);
        }
    }
}