using Person_Details;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Licensing.PersonLicensing
{
    public partial class CE_Audit : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindDropdown();
                Utilities_Licensing.BindDropdown(ddl_status, 71);
                hfdpid.Value = Request.QueryString[0].ToString();

                txt_datesent.Text = "06/14/2019";
                ddl_year.SelectedValue = "2018";



            }
        }
       public  void BindDropdown()

        {
            for (int i = -1; i <= 2; i++)
            {
                string date = DateTime.Now.AddYears(i).ToString("yyyy");
                ddl_year.Items.Add(date);

            }
        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {

            if (hfdceauditid.Value == "0")
            {
                Person_Details.Licensing_Details.insert_Ceaudit(0, hfdpid.Value, ddl_year.SelectedValue, txt_datesent.Text, txt_datereceived.Text, txt_live_hours.Text, txt_Non_live_hours.Text, ddl_status.SelectedValue, txt_comment.Text, Convert.ToString(Session["UID"]), "", ddl_feepaid.SelectedValue);
                Page.RegisterStartupScript("js", "<script>sa5.process();</script>");
                altbox("Record inserted successfully.");
                Clear();
                txt_datesent.Text = "06/14/2019";
            }
            else
            {
                Person_Details.Licensing_Details.insert_Ceaudit(Convert.ToInt32(hfdceauditid.Value), hfdpid.Value, ddl_year.SelectedValue, txt_datesent.Text, txt_datereceived.Text, txt_live_hours.Text, txt_Non_live_hours.Text, ddl_status.SelectedValue, txt_comment.Text, "", Convert.ToString(Session["UID"]), ddl_feepaid.SelectedValue);
                Page.RegisterStartupScript("js", "<script>sa5.process();</script>");
                altbox("Record update successfully.");
                txt_datesent.Text = "06/14/2019";
                Clear();
            }
            hfdceauditid.Value = "0";
        }
        private void Clear()
        {
          //  ddl_year.SelectedIndex = 0;
            ddl_status.SelectedIndex = 0;
            txt_datereceived.Text = "";
           // txt_datesent.Text = "";
    
            txt_comment.Text = "";
            txt_live_hours.Text = "";
            txt_Non_live_hours.Text = "";
        }

        protected void btnedit_Click(object sender, EventArgs e)
        {
            string value = hfdselid.Value;
            Person_Details.Tbl_CeAudit obj = Utilities_Licensing.Editceaudit(value);
            hfdceauditid.Value = obj.CeAuditID.ToString();
            txt_datesent.Text = obj.DateSent;
            txt_datereceived.Text = obj.DateReceived;
            txt_live_hours.Text = obj.LiveHours;
            string status = "";
            status = obj.Status.ToString();
            if (ddl_status.Items[0].Text != status)
            {
                ddl_status.Items[0].Selected = false;
                if (ddl_status.Items.FindByValue(status) != null)
                    ddl_status.Items.FindByValue(status).Selected = true;
            }
           ddl_year.SelectedValue = obj.Year;
            txt_comment.Text = obj.Comments;
            ddl_feepaid.SelectedValue = obj.FeePaid;
            txt_Non_live_hours.Text = obj.Non_live_hours;
            string js = "Popup();";
            ScriptManager.RegisterStartupScript(Page, GetType(), "scr", js, true);
        }
        

        protected void btndel_Click(object sender, EventArgs e)
        {
            string value = hfdselid.Value;
            Tbl_CeAudit obj = new Tbl_CeAudit();
            obj.CeAuditID = Convert.ToInt32(value);
            value = Convert.ToString(obj.CeAuditID);
           Utilities_Licensing.Delete_ce_audit(value);
            Page.RegisterStartupScript("js", "<script>sa5.process();</script>");
            altbox("Record deleted successfully.");
        }
        private void altbox(string str)
        {
            string js = "afterpost('" + str + "');";
            ScriptManager.RegisterStartupScript(Page, GetType(), "scr", js, true);
        }
    }
}