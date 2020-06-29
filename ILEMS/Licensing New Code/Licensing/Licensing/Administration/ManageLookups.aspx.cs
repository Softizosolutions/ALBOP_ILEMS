using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Licensing.Administration
{
    public partial class ManageLookups : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
               
                Licensing.Complaints.utilities.BindDropdown_Mstaertables(ddl_suffix);




            }

        }



        protected void btnedit_click(object sender, EventArgs e)
        {
            string Value = hfdselid.Value;


            ComplaintsLink.tbl_lkp_data obj = Licensing.Complaints.utilities.Get_Masterdata(Value);
            hfdauid.Value = obj.Lkp_data_ID.ToString();
            txtvalue.Text = obj.Values;


            string js = "popup();";
            ScriptManager.RegisterStartupScript(Page, GetType(), "scr", js, true);
        }
        protected void btndel_click(object sender, EventArgs e)
        {
            string Value = hfdselid.Value;

            Licensing.Complaints.utilities.Delete_Masters(Value);
           
             altbox("Record deleted successfully.");
        }

      


       
        protected void btn_submit_click(object sender, EventArgs e)
        {
            if (hfdauid.Value == "0")
            {
                Licensing.Complaints.utilities.Save_Masters(hfdauid.Value, ddl_suffix.SelectedValue, "1", txtvalue.Text);
                txtvalue.Text = "";
                hfdauid.Value = "0";
               
                 altbox("Record inserted successfully.");
            }
            else
            {
                Licensing.Complaints.utilities.Save_Masters(hfdauid.Value, ddl_suffix.SelectedValue, "1", txtvalue.Text);
                txtvalue.Text = "";
                hfdauid.Value = "0";
                
                 altbox("Record updated successfully.");
            }
          
        }

        protected void grd_RowEditing(object sender, GridViewEditEventArgs e)
        {

            //ModalPopupExtender.Show();


           

        }
        protected void btn_update_click(object sender, EventArgs e)
        {

            Licensing.Complaints.utilities.Save_Masters(hfdauid.Value, ddl_suffix.SelectedValue, "1", txtvalue.Text);
            txtvalue.Text = "";
            hfdauid.Value = hfdauid.Value;
            
             altbox("Record updated successfully.");

        }



        private void  altbox(string str)
        {
            string js = "afterpost('" + str + "');";
            ScriptManager.RegisterStartupScript(Page, GetType(), "scr", js, true);
        }

        protected void btn_back_Click(object sender, EventArgs e)
        {
            txtvalue.Text = "";
        }




    }




}