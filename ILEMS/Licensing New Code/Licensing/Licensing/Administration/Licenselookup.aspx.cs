using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using AdminLinq;

namespace Licensing.Administration
{
    public partial class Licenselookup : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

             if (!IsPostBack)
            {
                LoadDateDropdowns();


                adminUtilities.Bind_LicenseTypes(ddl_linkedlictype);
            }



        }








      

        protected void btn_submit_Click(object sender, EventArgs e)
        {
            if (hfdlic.Value == "0")
            {

                string isparentmust = "";
                if (chk_parentidmust.Checked == true)
                    isparentmust = "True";
                else
                    isparentmust = "False";
                AdminLinq.Admin.Insertion_LicenseLookup(Convert.ToInt32(hfdlic.Value), txtlictype.Text, txt_licformat.Text, ddl_linkedlictype.SelectedValue.ToString(), ddl_Exptype.SelectedValue.ToString(), txt_noforexpiry.Text, ddl_expday.SelectedValue.ToString(), ddl_expmonth.SelectedValue.ToString(), ddlrenewalstartday.SelectedItem.Text, ddlrenewalstartmonth.SelectedItem.Text, ddlrenewalendday.SelectedItem.Text, ddlrenewalendmonth.SelectedItem.Text, txt_licfee.Text, txt_renewalfee.Text, txt_reinstatefee.Text, txt_laterenewalfee.Text, isparentmust);
               altbox("Record Inserted Successfully");
              Clear();
            }
            else
            {
                string isparentmust = "";
                if (chk_parentidmust.Checked == true)
                    isparentmust = "True";
                else
                    isparentmust = "False";
                AdminLinq.Admin.Insertion_LicenseLookup(Convert.ToInt32(hfdlic.Value), txtlictype.Text, txt_licformat.Text, ddl_linkedlictype.SelectedValue.ToString(), ddl_Exptype.SelectedValue.ToString(), txt_noforexpiry.Text, ddl_expday.SelectedValue.ToString(), ddl_expmonth.SelectedValue.ToString(), ddlrenewalstartday.SelectedItem.Text, ddlrenewalstartmonth.SelectedItem.Text, ddlrenewalendday.SelectedItem.Text, ddlrenewalendmonth.SelectedItem.Text, txt_licfee.Text, txt_renewalfee.Text, txt_reinstatefee.Text, txt_laterenewalfee.Text, isparentmust);
              
               
                 altbox("Record Updated Successfully");
                Clear();
            }
        }
        protected void btnedit_click(object sender, EventArgs e)
        {
            string value = hfdselid.Value;
            tbl_lkp_License obj= adminUtilities.Edit_LicenseLookup(Convert.ToInt32(value));
            hfdlic.Value = obj.LicenseType_ID.ToString();
            txtlictype.Text = obj.License_Type;
            txt_licformat.Text = obj.License_Format;
            txt_noforexpiry.Text = obj.Numberfor_Exp;
            txt_renewalfee.Text = obj.Renewal_Fee;
            txt_licfee.Text = obj.License_Fee;
            txt_laterenewalfee.Text = obj.Late_Renewal_Fee;
            txt_reinstatefee.Text = obj.Reinstate_Fee;
            string lkdlic = obj.Linked_LicenseType;
            if (ddl_linkedlictype.Items[0].Text != lkdlic)
            {
                ddl_linkedlictype.Items[0].Selected = false;
                if (ddl_linkedlictype.Items.FindByText(lkdlic) != null)
                    ddl_linkedlictype.Items.FindByText(lkdlic).Selected = true;
            }
            string exptype = obj.ExpType;
            if (ddl_Exptype.Items[0].Text != exptype)
            {
                ddl_Exptype.Items[0].Selected = false;
                if (ddl_Exptype.Items.FindByText(exptype) != null)
                    ddl_Exptype.Items.FindByText(exptype).Selected = true;
            }
            string expday = obj.Exp_Day;
            if (ddl_expday.Items[0].Text != expday)
            {
                ddl_expday.Items[0].Selected = false;
                if (ddl_expday.Items.FindByText(expday) != null)
                    ddl_expday.Items.FindByText(expday).Selected = true;
            }
            string expmonth = obj.Exp_Month;
            if (ddl_expmonth.Items[0].Text != expmonth)
            {
                ddl_expmonth.Items[0].Selected = false;
                if (ddl_expmonth.Items.FindByText(expmonth) != null)
                    ddl_expmonth.Items.FindByText(expmonth).Selected = true;
            }
            string restartday = obj.Renewal_Start_Day;
            if (ddlrenewalstartday.Items[0].Text != restartday)
            {
                ddlrenewalstartday.Items[0].Selected = false;
                if (ddlrenewalstartday.Items.FindByText(restartday) != null)
                    ddlrenewalstartday.Items.FindByText(restartday).Selected = true;
            }
            string restartmonth = obj.Renewal_Start_Month;
            if (ddlrenewalstartmonth.Items[0].Text != restartmonth)
            {
                ddlrenewalstartmonth.Items[0].Selected = false;
                if (ddlrenewalstartmonth.Items.FindByText(restartmonth) != null)
                    ddlrenewalstartmonth.Items.FindByText(restartmonth).Selected = true;
            }
            string reendday = obj.Renewal_End_Day;
            if (ddlrenewalendday.Items[0].Text != reendday)
            {
                ddlrenewalendday.Items[0].Selected = false;
                if (ddlrenewalendday.Items.FindByText(reendday) != null)
                    ddlrenewalendday.Items.FindByText(reendday).Selected = true;
            }
            string reendmonth = obj.Renewal_End_Month;
            if (ddlrenewalendmonth.Items[0].Text != reendmonth)
            {
                ddlrenewalendmonth.Items[0].Selected = false;
                if (ddlrenewalendmonth.Items.FindByText(reendmonth) != null)
                    ddlrenewalendmonth.Items.FindByText(reendmonth).Selected = true;
            }
            string isparent = obj.Is_ParentLicmust;
            if (isparent == "True")
                chk_parentidmust.Checked = true;
            else
                chk_parentidmust.Checked = false;
        }
        protected void btndel_click(object sender, EventArgs e)
        {

            string Value = hfdselid.Value;
            AdminLinq.Admin.Delete_LicenseLookupData(Convert.ToInt32(Value));
            
             altbox("Record Deleted Successfully");
        }
        protected void btn_Clear_Click(object sender, EventArgs e)
        {
            Clear();
        }
        protected void LoadDateDropdowns()
        {
            var months = from i in Enumerable.Range(1, 12)
                         select new ListItem()
                         {
                             Text = new DateTime(1900, i, 1).ToString("MMMM"),
                             Value = new DateTime(1900, i, 1).ToString("MMMM")
                         };

            var days = from i in Enumerable.Range(1, 31)
                       select new ListItem()
                       {
                           Text = i.ToString(),
                           Value = i.ToString()
                       };

            //var years = from i in Enumerable.Range(DateTime.Now.Year - 5, 5)
            //            orderby i descending
            //            select new ListItem()
            //            {
            //                Text = i.ToString(),
            //                Value = i.ToString()
            //            };

            // add the months to the dropdown
            months.ToList().ForEach(i => ddl_expmonth.Items.Add(i));
            months.ToList().ForEach(i => ddlrenewalstartmonth.Items.Add(i));
            months.ToList().ForEach(i => ddlrenewalendmonth.Items.Add(i));
            // add the days to the dropd
            days.ToList().ForEach(i => ddl_expday.Items.Add(i));
            days.ToList().ForEach(i => ddlrenewalendday.Items.Add(i));
            days.ToList().ForEach(i => ddlrenewalstartday.Items.Add(i));
            // add the years to the dropdown
            //years.ToList().ForEach(i => ddlManufactureYear.Items.Add(i));
        }

        #region Clear
       public void Clear()
        {
            hfdlic.Value = "0";
            txt_laterenewalfee.Text = "";
            txt_licfee.Text = "";
            txt_licformat.Text = "";
            txt_noforexpiry.Text = "";
            txt_reinstatefee.Text = "";
            txt_renewalfee.Text = "";
            txtlictype.Text = "";
            ddl_expday.SelectedValue = null;
            ddl_expmonth.SelectedValue = null;
            ddl_Exptype.SelectedValue = null;
            ddl_linkedlictype.SelectedValue = null;
            ddlrenewalendday.SelectedValue = null;
            ddlrenewalendmonth.SelectedValue = null;
            ddlrenewalstartday.SelectedValue = null;
            ddlrenewalstartmonth.SelectedValue = null;
            chk_parentidmust.Checked = false;
          
        }
        #endregion




       private void  altbox(string str)
       {
           string js = "afterpost('" + str + "');";
           ScriptManager.RegisterStartupScript(Page, GetType(), "scr", js, true);
       }





    }
}