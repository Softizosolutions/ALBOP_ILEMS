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
using Person_Details;
using System.IO;
using System.Collections.Generic;

namespace Licensing.PersonLicensing
{
    public partial class Fee : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                hfdpid.Value = Request.QueryString[0].ToString();
                Utilities_Licensing.BindDropdown(ddl_paymenttype, 30);
              
               
            }
        }


        public void Payer_Name()
        {
            string str = "C";
            //string pid = Request.QueryString[0].ToString();
            //if (Request.QueryString[1].ToString() != str)
            //{

            

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

        protected void btn_receptdata_Click(object sender, EventArgs e)
        {

            //  txt_payer.Text = "NAME";

            List<USP_Licensing_GetPayerNameResult> name = Licensing_Details.Get_PayerName(Convert.ToInt32(hfdpid.Value));
            txt_payer.Text = name[0].PayerName;
            txt_datepaid.Text = DateTime.Now.ToString("MM/dd/yyyy");
            dlistAmtOwed.DataSource = Person_Details.Licensing_Details.Get_AmountOwedData(hfdselfeeids.Value);
            dlistAmtOwed.DataBind();

            ScriptManager.RegisterStartupScript(this,GetType(),"js", "<script>Popup();</script>",false);
        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {
            TBL_Accounting_Receipt tar = new TBL_Accounting_Receipt();
            tar.Receipt_ID = Convert.ToInt32(hfdreceipt.Value);
            tar.Receiptnum = "0";
            tar.PayeerName = txt_payer.Text;
              tar.DatePaid = Convert.ToDateTime(txt_datepaid.Text);
            tar.PaymentType = ddl_paymenttype.SelectedValue;
            tar.Checknum = txtchknumber.Text;
            tar.CCHolderName = txt_payer.Text;
            tar.CCDigits = txtcreditcardnumber.Text;
            tar.IsVoid = Convert.ToBoolean(0);
            tar.VoidReason_ID = 0;
            
            tar.ISReReceipt = Convert.ToBoolean(0) ;
            tar.ReReceiptFrom = "";
            tar.Receiptnum = "";
            tar.Batchnum = "";
            tar.Modifyby = 1;
            tar.Modifydate = Convert.ToDateTime(DateTime.Now.ToShortDateString());
            object obj= Person_Details.Licensing_Details.InsertSelected_Receipt(tar);


            foreach (DataListItem li in dlistAmtOwed.Items)
            {
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
                
                Person_Details.Licensing_Details.Insert_FeeReceipt(tard,tafd);

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
            string js = " altbox('Sucessfully Saved.');sa5.process();$('#btn_receptdata_pop').dialog('close');";
            ScriptManager.RegisterStartupScript(Page, GetType(), "scr", js, true);
         
        }
    }
}