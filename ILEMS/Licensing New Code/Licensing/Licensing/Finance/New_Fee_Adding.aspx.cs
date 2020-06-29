using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Licensing.Finance
{
    public partial class New_Fee_Adding : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            NewFee_Bind();
        }


        public void NewFee_Bind()
        {
            //grd_newfee.DataSource = Accounting_Data.Accounting_Details.NewFee_Bind();
            //grd_newfee.DataBind();

        }
        protected void btn_submit_Click(object sender, EventArgs e)
        {
            if (hfdsubonjid.Value == "0")
            {
                Accounting_Data.Accounting_Details.Insert_Subobjdata(Convert.ToInt32(hfdsubonjid.Value), txt_code.Text, txt_desc.Text, txt_amount.Text, txt_fulldesc.Text,ddlobjtype.SelectedValue);
                 altbox("Record inserted successfully.");
                Clear();
                
            }
            else
            {
                Accounting_Data.Accounting_Details.Insert_Subobjdata(Convert.ToInt32(hfdsubonjid.Value), txt_code.Text, txt_desc.Text, txt_amount.Text, txt_fulldesc.Text,ddlobjtype.SelectedValue);
                 altbox("Record updated successfully.");
                Clear();
              
            }
            //NewFee_Bind();
        }
        protected void btn_clear_Click(object sender, EventArgs e)
        {
            Clear();
        }
        public void Clear()
        {
            txt_amount.Text = "";
            txt_code.Text = "";
            txt_desc.Text = "";
            txt_fulldesc.Text = "";
            ddlobjtype.SelectedIndex = -1;


        }

        protected void btnedit_click(object sender, EventArgs e)
        {
            string value = hfdselid.Value;
            Accounting_Data.tbl_lkp_subobj obj = Accounting_Data.Accounting_Details.Edit_SubObj(Convert.ToInt32(value));
            hfdsubonjid.Value = obj.Subobj_Id.ToString();
            txt_code.Text = obj.Subobj_code;
            txt_desc.Text = obj.Description;
            txt_amount.Text = obj.Amount.ToString();
            txt_fulldesc.Text = obj.Full_Description;
            ddlobjtype.SelectedValue = obj.Rev_obj_Id.ToString();
        }
        protected void btndel_click(object sender, EventArgs e)
        {
            string value = hfdselid.Value;
            Accounting_Data.Accounting_Details.DeleteSubobj(Convert.ToInt32(value));
           
             altbox("Record deleted successfully.");
        }
        private void  altbox(string str)
        {
            string js = " afterpost('" + str + "');";
            ScriptManager.RegisterStartupScript(Page, GetType(), "scr", js, true);
        }
    }
}