using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Person_Details;
using Licensing;
using OperationsLink;
namespace Licensing.Operations
{

    public partial class AddNewOperations : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                
                Utilities_Operations.BindDropdown(ddlpaymenttype, 30);
                Utilities_Operations.Fill_Dropdown(ddlsfeetype);
                Utilities_Operations.Fill_Login(ddlforward, "tbl_Login Order by LastName", "FirstName+' '+LastName", "loginID", " ", "Select");
                Utilities_Operations.Fill_Login(ddlmailclerk, "tbl_Login Order by LastName", "FirstName+' '+LastName", "loginID", " ", "Select");
            }
        }

        protected void btnaddlog_Click(object sender, EventArgs e)
        {
            string walkin = "";
            if (chk_walkin.Checked == true)
                walkin = "True";
            else
                walkin = "false";


            tbl_Add_Log ObjAddLog = new tbl_Add_Log();
            ObjAddLog.Add_log_ID = 0;
            ObjAddLog.Date_Received =Convert.ToDateTime( txtdatetreceive.Text);
            ObjAddLog.From_Received = txtaddlogfrom.Text;
            ObjAddLog.SSN = txtaddlogssn.Text;
            ObjAddLog.Forward_To = ddlforward.SelectedValue.ToString();
            ObjAddLog.MailClerk = ddlmailclerk.SelectedValue.ToString();
            ObjAddLog.SpecialEntries = txtspecialentry.Text;
            ObjAddLog.PaymentType = ddlpaymenttype.SelectedValue.ToString();
            if (txtamount.Text != "")
            {
                ObjAddLog.Amount = Convert.ToDecimal(txtamount.Text);
            }
            ObjAddLog.CheckNumber = txtchecknumber.Text;
            ObjAddLog.Walkin = walkin;
            ObjAddLog.Feetype = ddlsfeetype.SelectedValue.ToString();        
            OperationsLink.Operations.OperationsInsertValues(ObjAddLog, Session["Uname"].ToString());
           // Mail.SendMail(ddlforward.SelectedItem.Text, AdminLinq.Admin.Getemail(ddlforward.SelectedValue), "", "Log Entry", " This email is to alert you that a check or file is on its way to you.<br/> <b>Payer :</b>&nbsp; " + txtaddlogssn.Text + "<br/><b>Mail Clerk :</b> &nbsp;" + ddlmailclerk.SelectedItem.Text + "<br/> <b>Forward To :</b> &nbsp;" + ddlforward.SelectedItem.Text + "<br/> <b>Name/License # :</b> &nbsp;" + txtaddlogfrom.Text);
             altbox("Log added successfully.");

            Clear();
          
        }
        
        protected void btnaddlogClear_Click(object sender, EventArgs e)
        {
            Clear();
        }
        public void Clear()
        {
            txtdatetreceive.Text = "";
            txtaddlogfrom.Text = "";
            txtaddlogssn.Text = "";
            ddlforward.SelectedValue = "-1";
            ddlmailclerk.SelectedValue = "-1";
            ddlpaymenttype.SelectedValue = "-1";
            txtamount.Text = "";
            chk_walkin.Checked = false;
            ddlsfeetype.SelectedValue = "-1";
            txtspecialentry.Text = "";
            txtaddlogfrom.Focus();
        }

        private void  altbox(string str)
        {
            string js = " afterpost('" + str + "');";
            ScriptManager.RegisterStartupScript(Page, GetType(), "scr", js, true);
        }
    }
}