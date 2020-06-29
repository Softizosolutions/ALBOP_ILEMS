using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Licensing.Complaints
{
    public partial class OnlineComplaints : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                hfdurl.Value = System.Configuration.ConfigurationManager.AppSettings["onlinecomplaintslink"].ToString();
        }
        protected void btndel_click(object sender,EventArgs e)
        {
            PersonLicensing.Utilities_Licensing.Deleteonlinecmp(hfdselid.Value);
            hfdselid.Value = "0";
            altbox("Deleted successfully.");
        }
        //protected void btn_submit_Click(object sender, EventArgs e)
        //{
        //    Online.onlinedb.Update_OnlineComplaintsDetails(Convert.ToInt32(hfdorderid.Value),Session["UID"].ToString());
        //    altbox("Processed successfully.");
        //}
        protected void btnedit_Click(object sender, EventArgs e)
        {
            string value = hfdselid.Value;
            Online.tbl_OnlineComplaint obj = Online.onlinedb.Editcomplaints(Convert.ToInt32(value));
            hfdselid.Value = obj.OnlineComplaint_ID.ToString();
            obj.Processed = true;
            txtcomments.Text = obj.Comments;

            string js = "popup();";
            ScriptManager.RegisterStartupScript(Page, GetType(), "scr", js, true);


        }

        private void clear()
        {
            txtcomments.Text = "";
        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {
            if (hfdselid.Value == "0")
            {
                Online.onlinedb.Update_OnlineComplaintsDetails(0, Session["UID"].ToString(), txtcomments.Text);
                altbox("Record Inserted successfully.");
                clear();
            }
            else
            {
                Online.onlinedb.Update_OnlineComplaintsDetails(Convert.ToInt32(hfdselid.Value), Session["UID"].ToString(), txtcomments.Text);
                altbox("Record saved successfully.");
                clear();
            }
            hfdselid.Value = "0";
        }
        private void altbox(string str)
        {
            string js = " afterpost('" + str + "');";
            ScriptManager.RegisterStartupScript(Page, GetType(), "scr", js, true);
        }
    }
}