using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using OperationsLink;
namespace Licensing.Operations
{
    public partial class SearchOperations : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

                Utilities_Operations.Fill_Login(ddlsmailclerk, "tbl_Login Order by LastName", "FirstName+' '+LastName", "loginID", " ", "Select");           
                    Utilities_Operations.BindDropdown(ddlpaymenttype, 30);
                    Utilities_Operations.Fill_Dropdown(ddlfeetype);
                    Utilities_Operations.Fill_Login(ddlforward, "tbl_Login Order by LastName", "FirstName+' '+LastName", "loginID", " ", "Select");
                    Utilities_Operations.Fill_Login(ddlfrwd, "tbl_Login Order by LastName", "FirstName+' '+LastName", "loginID", " ", "Select");
                    Utilities_Operations.Fill_Login(ddlmailclerk, "tbl_Login Order by LastName", "FirstName+' '+LastName", "loginID", " ", "Select");
               
            }
        }

        public string openapp1(string Logid)
        {
            return "javascript:return Openapplication('" + Logid + "')";
        }

        protected void btnsearchlog_click(object sender, EventArgs e)
        {
            string walk="";

             if (chkswalkin.Checked == true)
               walk = "True";
           else
                 walk = "false";

       //     DataSet ds = utilities_Person.Get_Operations_Addlog(txtdatetreceive.Text.ToString().Trim(), txtfromsender.Text.ToString().Trim(), ddlsmailclerk.SelectedValue.ToString().ToString().Trim(), walk, txtslicense.Text.ToString().Trim());
            //grd_searclogdata.DataSource = OperationsLink.Operations.GetLogSearchData(txtdatetreceive.Text.ToString().Trim(), txtfromsender.Text.ToString().Trim(), ddlsmailclerk.SelectedValue.ToString().ToString().Trim(), walk, txtslicense.Text.ToString().Trim());
            //grd_searclogdata.DataBind();
        }
        protected void btnedit_click(object sender, EventArgs e)
        {
            string value = hfdselid.Value;
            OperationsLink.tbl_Add_Log Obj = Utilities_Operations.Edit_ManageLogs(Convert.ToInt32(value));
            hfdautoid.Value = Obj.Add_log_ID.ToString();
            txtdatetreceiveedit.Text = Convert.ToDateTime(Obj.Date_Received).ToString("MM/dd/yyyy"); 
            txtaddlogfrom.Text = Obj.From_Received;
            txtaddlogssn.Text = Obj.SSN;
            txtspecialentry.Text = Obj.SpecialEntries;
            txtamount.Text = Obj.Amount.ToString();

            string ddlforwardvalue = "";
            ddlforwardvalue = Obj.Forward_To;

            if (ddlforward.Items[0].Text != ddlforwardvalue)
            {
                ddlforward.Items[0].Selected = false;
                ddlforward.Items.FindByValue(ddlforwardvalue).Selected = true;
            }


            string MailClerkvalue = "";
            MailClerkvalue = Obj.MailClerk;

            if (ddlmailclerk.Items[0].Text != MailClerkvalue)
            {
                ddlmailclerk.Items[0].Selected = false;
                ddlmailclerk.Items.FindByValue(MailClerkvalue).Selected = true;
            }

            string Ckwalkin = "";
            Ckwalkin = Obj.Walkin;
            if (Obj.Walkin == "True")
                chk_walkin.Checked = true;
            else
                chk_walkin.Checked = false;


            string ddlPay = "";
            ddlPay = Obj.PaymentType;
            ddlpaymenttype.ClearSelection();

            if (ddlpaymenttype.Items[0].Text != ddlPay)
            {
                ddlpaymenttype.Items[0].Selected = false;
                ddlpaymenttype.Items.FindByValue(ddlPay).Selected = true;
            }



            if (ddlpaymenttype.Items.FindByValue(ddlPay).ToString() == "Cashier's Check" || ddlpaymenttype.Items.FindByValue(ddlPay).ToString() == "Business Check" || ddlpaymenttype.Items.FindByValue(ddlPay).ToString() == "Personal Check")
            {
                checknu.Style.Add(HtmlTextWriterStyle.Display, "block");
                lblcred.Text = "Check #";
                checknum.Style.Add(HtmlTextWriterStyle.Display, "block");
                txtchecknumber.Text = Obj.CheckNumber;

            }

            if (ddlpaymenttype.Items.FindByValue(ddlPay).ToString() == "Money Order")
            {
                checknu.Style.Add(HtmlTextWriterStyle.Display, "block");
                lblcred.Text = "Money Order #";
                checknum.Style.Add(HtmlTextWriterStyle.Display, "block");
                txtchecknumber.Text = Obj.CheckNumber;

            }

            if (Obj.Walkin == "True")
            {

                // string str = "document.getElementById('feetype').style.display='block';";
                string ddlFType = "";
                ddlFType = Obj.Feetype;
                ddlfeetype.ClearSelection();


                if (ddlfeetype.Items[0].Text != ddlFType)
                {
                    ddlfeetype.Items[0].Selected = false;
                    ddlfeetype.Items.FindByValue(ddlFType).Selected = true;
                }
            }

            //XXXXX

            string js = "Openapplication();";
            ScriptManager.RegisterStartupScript(Page, GetType(), "scr", js, true);
        }
        protected void btndel_click(object sender, EventArgs e)
        {

        }
        protected void btndel_click1(object sender, EventArgs e)
        {
            tbl_Add_Log ObjAddLog = new tbl_Add_Log();
            ObjAddLog.Add_log_ID = Convert.ToInt32(hfdselid.Value);

            OperationsLink.Operations.OperationsDelete(ObjAddLog);
            ScriptManager.RegisterStartupScript(Page, GetType(), "js", "Afterdel()", true);
        }


        protected void btnupdateaddlog_Click(object sender, EventArgs e)
        {

            string walkin = "";
            if (chk_walkin.Checked == true)
                walkin = "True";
            else
                walkin = "false";
         //   utilities_Person.Insert_addlogInfo("102", lbladdlogid.Text, txtdatetreceiveedit.Text, txtaddlogfrom.Text, txtaddlogssn.Text, ddlforward.SelectedValue.ToString(), ddlmailclerk.SelectedValue.ToString(), txtspecialentry.Text, ddlpaymenttype.SelectedValue, txtamount.Text, txtchecknumber.Text, walkin, ddlfeetype.SelectedValue.ToString());
          //  bindaddlog();

            tbl_Add_Log ObjAddLog = new tbl_Add_Log();
            ObjAddLog.Add_log_ID = Convert.ToInt32(hfdautoid.Value);
            ObjAddLog.Date_Received =Convert.ToDateTime( txtdatetreceiveedit.Text);
            ObjAddLog.From_Received = txtaddlogfrom.Text;
            ObjAddLog.SSN = txtaddlogssn.Text;
            ObjAddLog.Forward_To = ddlforward.SelectedValue.ToString();
            ObjAddLog.MailClerk = ddlmailclerk.SelectedValue.ToString();
            ObjAddLog.SpecialEntries = txtspecialentry.Text;
            ObjAddLog.PaymentType = ddlpaymenttype.SelectedValue.ToString();
            ObjAddLog.Amount = Convert.ToDecimal( txtamount.Text);
            ObjAddLog.CheckNumber = txtchecknumber.Text;
            ObjAddLog.Walkin = walkin;
            ObjAddLog.Feetype = ddlfeetype.SelectedValue.ToString();
            OperationsLink.Operations.OperationsUpdateValues(ObjAddLog,Session["Uname"].ToString());

            string js = "afterupdate();";
            ScriptManager.RegisterStartupScript(Page, GetType(), "scr", js, true);
            Clear();
           
         
        }

        protected void btnsearchogClear_Click(object sender, EventArgs e)
        {
            Clear();
        }
        public void Clear()
        {
            txtdatetreceive.Text = "";
            ddlsmailclerk.SelectedValue = "-1";
            txtslicense.Text = "";
            txtfromsender.Text = "";
            chkswalkin.Checked = false;
        }
        protected void btnaddlogcancel_Click(object sender, EventArgs e)
        {
            txtdatetreceiveedit.Text = "";
            txtaddlogfrom.Text = "";
            txtaddlogssn.Text = "";
            ddlforward.SelectedValue = "-1";
            ddlmailclerk.SelectedValue = "-1";
            txtspecialentry.Text = "";
            ddlpaymenttype.SelectedValue = "-1";
            txtamount.Text = "";
            txtchecknumber.Text = "";
            chk_walkin.Checked = false;
            ddlfeetype.SelectedValue = "-1";
        }
    }
}