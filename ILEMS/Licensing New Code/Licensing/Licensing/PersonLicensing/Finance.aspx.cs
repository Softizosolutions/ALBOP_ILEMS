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
using Person_Details;

namespace Licensing.PersonLicensing
{
    public partial class Finance : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                hfdpid.Value = Request.QueryString[0].ToString();
                hfdutype.Value = Session["Utype"].ToString();
                Utilities_Licensing.BindLicType(ddl_lictype, Convert.ToInt32(hfdpid.Value));
                Utilities_Licensing.BindSubobjvalues(ddl_feetype, hfdpid.Value);
                Utilities_Licensing.BindDropdown(ddl_paymenttype, 30);
                Utilities_Licensing.BindDropdown(ddlvoidres, 31);
                ddl_days.DataSource = Enumerable.Range(1, 15);
                ddl_days.DataBind();
                ddl_days.Items.Insert(0, new ListItem("Day", "-1"));
                ddl_edit_days.DataSource = Enumerable.Range(1, 15);
                ddl_edit_days.DataBind();
                ddl_edit_days.Items.Insert(0, new ListItem("Day", "-1"));
            }
        }

        #region Small Functions

        public string filter_date(string str)
        {
            try
            {
                if (str != "")
                {
                    return DateTime.Parse(str).ToString("MM/dd/yyyy");
                }
                return " ";
            }
            catch { return " "; }
        }

        public string Feestatus(string str)
        {
            try
            {
                if (str != "")
                {
                    return DateTime.Parse(str).ToString("MM/dd/yyyy");
                }
                return " ";
            }
            catch { return " "; }
        }
        public string feebalance(string tot, string feepaid)
        {

            decimal feebal;
            if (tot == "")
                tot = "0";
            if (feepaid == "")
                feepaid = "0";
            feebal = Convert.ToDecimal(tot) - Convert.ToDecimal(feepaid);
            return feebal.ToString();
        }

        public decimal feebalance1(string tot, string feepaid)
        {

            decimal feebal;
            if (tot == "")
                tot = "0";
            if (feepaid == "")
                feepaid = "0";
            feebal = Convert.ToDecimal(tot) - Convert.ToDecimal(feepaid);
            return feebal;
        }

        public Boolean chkboxenable(string tot, string feepaid)
        {

            decimal feebal;
            if (tot == "")
                tot = "0";
            if (feepaid == "")
                feepaid = "0";
            feebal = Convert.ToDecimal(tot) - Convert.ToDecimal(feepaid);
            if (feebal == 0)
                return false;
            else
                return true;
        }
        #endregion

        protected void ddl_feetype_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddl_feetype.SelectedItem.Text == "Copies Of Documents")
                fnneew.Visible = true;
            else
                fnneew.Visible = false;
            if (ddl_feetype.SelectedValue == "130" || ddl_feetype.SelectedValue == "135")
                recurring.Visible = true;
            else
                recurring.Visible = false;
            tbl_lkp_subobj obj = Utilities_Licensing.Feeamount_RetriveAmountSubOrg(Convert.ToInt32(ddl_feetype.SelectedValue));
            txt_Amount.Text = obj.Amount.ToString();
            hfdoamount.Value = obj.Amount.ToString();
            if (obj.Amount == 0)
            {
                txt_Amount.Enabled = true;
                txt_Duedate.Text = DateTime.Now.ToString("MM/dd/yyyy");
            }
            else
            {
                txt_Amount.Enabled = false;
                txt_Duedate.Text = DateTime.Now.ToString("MM/dd/yyyy");
            }
            
        }

        protected void btnsave_Click(object sender, EventArgs e)
    {
      
        string ScholarAmount1 = "";
        ScholarAmount1 = Convert.ToString(Convert.ToDecimal(txt_Amount.Text) - Convert.ToDecimal(hfdoamount.Value));

        TBL_Accounting_FeeDetail fd = new TBL_Accounting_FeeDetail();
        fd.FeeID= Convert.ToInt32(hfd_feeid.Value);
        fd.Person_ID = Convert.ToInt32(hfdpid.Value);
        fd.Application_ID = Convert.ToInt32(ddl_lictype.SelectedValue.ToString());
        fd.Isverification = true;
        fd.Sub_org_Id= Convert.ToInt32(ddl_feetype.SelectedValue.ToString());
        fd.SubOrgAmount = Convert.ToDecimal(txt_Amount.Text);
            fd.Is_RecurringFee = chkrecuringfee.Checked;
            fd.Recurring_Days = ddl_days.SelectedItem.Text;
            if (txt_Duedate.Text != "")
                fd.DueDate = Convert.ToDateTime(txt_Duedate.Text);
            else
                fd.DueDate = Convert.ToDateTime("01/01/1900");
            fd.Status = 1;
        fd.modifiedby = Convert.ToInt32(Session["UID"].ToString());
        fd.modifieddate = Convert.ToDateTime(DateTime.Now.ToShortDateString());
        fd.Create_User =Convert.ToInt32( Session["UID"].ToString());
        fd.Create_Date = Convert.ToDateTime(DateTime.Now.ToShortDateString());
        
       Person_Details.Licensing_Details.InsertFinance(fd);
        altbox("Sucessfully saved.");
        clear();  
           }

        protected void clear()
        {
            hfd_feeid.Value = "0";
            hfdoamount.Value = "0";
            txt_Amount.Text = "";
            ddl_lictype.SelectedValue = "-1";
            ddl_feetype.SelectedValue = "-1";
            txt_Duedate.Text = "";
        }
        protected void btn_receptdata_Click(object sender, EventArgs e)
        {

            //  txt_payer.Text = "NAME";

            List<USP_Licensing_GetPayerNameResult> name = Licensing_Details.Get_PayerName(Convert.ToInt32(hfdpid.Value));
            txt_payer.Text = name[0].PayerName;
            txt_datepaid.Text = DateTime.Now.ToString("MM/dd/yyyy");
            dlistAmtOwed.DataSource = Person_Details.Licensing_Details.Get_AmountOwedData(hfdselfeeids.Value);
            dlistAmtOwed.DataBind();

            ScriptManager.RegisterStartupScript(this, GetType(), "js", "<script>Popup();</script>", false);
        }
        protected void btndel_click(object sender, EventArgs e)
        {
            Person_Details.Licensing_Details.Delete_fee(hfdselid.Value);
            altbox("Selected Fee Details Deleted.");
        }
        protected void btn_submit_Click(object sender, EventArgs e)
        {
            decimal amount = 0;
            foreach (DataListItem dl in dlistAmtOwed.Items)
            {
                amount = (amount) + Convert.ToDecimal(((TextBox)dl.FindControl("txtamnt")).Text);
            }
            if (txtchknumber.Text.Trim() != "")
            {
                List<OperationsLink.tbl_Add_Log> obj = Operations.Utilities_Operations.Get_CheckandAmount(txtchknumber.Text);
                List<OperationsLink.USP_GetBalanceAmountInChecksResult> obj1 = Operations.Utilities_Operations.GetBalanceAmount(txtchknumber.Text);
                if (obj.Count <= 0)
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "js", "<script> recp_error();</script>", false);
                    return;
                }
                else
                {
                    //  if (amount > obj[0].Amount||amount > obj1[0].BalanceAmount)
                    if (amount > obj[0].Amount)
                    {
                        ScriptManager.RegisterStartupScript(this, GetType(), "js", "<script> recp_error1();</script>", false);
                        return;
                    }
                    if (obj.Select(c=>c.PaymentType== ddl_paymenttype.SelectedValue).ToList().Count==0)
                    {
                        ScriptManager.RegisterStartupScript(this, GetType(), "js", "<script> recp_error();</script>", false);
                        return;
                    }
                }
            }
            //if (txtchknumber.Text.Trim() != "")
            //{
            //    if (Operations.Utilities_Operations.validatecheck(txtchknumber.Text))
            //    {
            //        ScriptManager.RegisterStartupScript(this, GetType(), "js", "<script> recp_error();</script>", false);
            //        return;
            //    }
            //}
            foreach (DataListItem li in dlistAmtOwed.Items)
            {
            TBL_Accounting_Receipt tar = new TBL_Accounting_Receipt();
            tar.Receipt_ID = Convert.ToInt32(hfdreceipt.Value);
            tar.Receiptnum = "0";
            tar.PayeerName = txt_payer.Text;
            tar.DatePaid = Convert.ToDateTime(txt_datepaid.Text);
            tar.PaymentType = ddl_paymenttype.SelectedValue;
                if (ddl_paymenttype.SelectedValue == "538")
                    tar.Checknum = txtmorderno.Text;
                else
                    tar.Checknum = txtchknumber.Text;

                tar.CCHolderName = txt_payer.Text;
            tar.CCDigits = txtcreditcardnumber.Text;
            tar.IsVoid = Convert.ToBoolean(0);
            tar.VoidReason_ID = 0;

            tar.ISReReceipt = Convert.ToBoolean(0);
            tar.ReReceiptFrom = "";
            tar.Receiptnum = "";
            tar.Batchnum = "";
            tar.Modifyby = Convert.ToInt32(Session["UID"].ToString());
            tar.Modifydate = Convert.ToDateTime(DateTime.Now.ToShortDateString());
            object obj = Person_Details.Licensing_Details.InsertSelected_Receipt(tar);


           
                string dlistamt = ((HiddenField)li.FindControl("hfdtot")).Value;
                string txtamt = ((TextBox)li.FindControl("txtamnt")).Text;
                string feeid = ((HiddenField)li.FindControl("hfddlistfeeid")).Value;
                string status = "3";
                if (Convert.ToDecimal(dlistamt) == Convert.ToDecimal(txtamt))
                    status = "2";
                else
                    status = "3";
                TBL_Accounting_ReceiptDetail tard = new TBL_Accounting_ReceiptDetail();
                tard.ReceiptdetailsID = Convert.ToInt32(hfdrecdetail.Value);
                tard.ReceiptID = Convert.ToInt32(obj);
                tard.Fee_ID = Convert.ToInt32(feeid);
                tard.Amount = Convert.ToDecimal(txtamt);
                tard.ModifiedBY = 1;
                tard.ModifiedDate = Convert.ToDateTime(DateTime.Now.ToShortDateString());

                TBL_Accounting_FeeDetail tafd = new TBL_Accounting_FeeDetail();
                tafd.Status = Convert.ToInt32(status);
                Person_Details.Licensing_Details.Insert_FeeReceipt(tard, tafd);

                TBL_Licensing_FeeAuditHistory feeaudit = new TBL_Licensing_FeeAuditHistory();
                feeaudit.FeeAudit_Id = 0;
                feeaudit.Fee_Type_Id = Convert.ToInt32(feeid.ToString());
                feeaudit.Amount = Convert.ToDecimal(txtamt);
                feeaudit.TypeofAction = "Insert";
                feeaudit.Datepaid = Convert.ToDateTime(DateTime.Now.ToShortDateString());
                feeaudit.Modifiedby = 1;
                feeaudit.ModifiedDate = Convert.ToDateTime(DateTime.Now.ToShortDateString());
                feeaudit.Create_User = 1;
                feeaudit.Create_Date = Convert.ToDateTime(DateTime.Now.ToShortDateString());

                Person_Details.Licensing_Details.Insert_feeaudit(feeaudit);
            }
             altbox("Sucessfully saved.");

        }
        private void  altbox(string str)
        {
            string js = " afterpost('" + str + "');";
            ScriptManager.RegisterStartupScript(Page, GetType(), "scr", js, true);
        }
        protected void void_trans(object sender, EventArgs e)
        {
            Licensing.Finance.Accounting_Utilities.Voidtransaction(hfdselrecid.Value, ddlvoidres.SelectedValue);
            ddlvoidres.SelectedValue = "-1";
              altbox("Void transaction completed.");
        }
        protected void btnduedatesubmit_Click(object sender, EventArgs e)
        {
            DateTime duedate;
            if (txtDueDate.Text != "")
                duedate = Convert.ToDateTime(txtDueDate.Text);
            else
                duedate = Convert.ToDateTime("01/01/1900");
            Utilities_Licensing.UpdateDuedateinFinance(Convert.ToInt32(hfdduedateid.Value), txt_edit_amount.Text, chk_edit_recurringfee.Checked, ddl_edit_days.SelectedItem.Text, duedate);
            altbox("Record updated successfully.");
            hfdduedateid.Value = "0";
        }

        protected void btnfeeedit_Click(object sender, EventArgs e)
        {
            USP_Licensing_GetEditFeeDetailsResult obj = Person_Details.Licensing_Details.GetEditFeeDetails(Convert.ToInt32(hfdpid.Value), Convert.ToInt32(hfdduedateid.Value));
            if (obj != null)
            {
                txt_edit_amount.Text = obj.tot.ToString();
                if (Convert.ToDateTime(obj.DueDate).ToString("MM/dd/yyyy") == "01/01/1900" || Convert.ToDateTime(obj.DueDate).ToString("MM/dd/yyyy") == "01/01/0001")
                    txtDueDate.Text = "";
                else
                    txtDueDate.Text = Convert.ToDateTime(obj.DueDate).ToString("MM/dd/yyyy");
                if (obj.Recurring_Fee==false)
                {
                    isrecurringfee.Visible = false;
                    chk_edit_recurringfee.Checked = false;
                }
                else
                {
                    isrecurringfee.Visible = true;
                    chk_edit_recurringfee.Checked = true;
                }
                if (obj.Recurring_Fee == true)
                {
                    isrecurringdays.Visible = true;
                    if (ddl_edit_days.Items.FindByText(obj.Recurring_Days) != null)
                        ddl_edit_days.Items.FindByText(obj.Recurring_Days).Selected = true;
                }
                else
                    isrecurringdays.Visible = false;

                string js = "Fee_EditPopup();";
                ScriptManager.RegisterStartupScript(Page, GetType(), "scr", js, true);
            }
        }
    }
}