using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Person_Details;


namespace Licensing.PersonLicensing
{
    public partial class PyamentHist_Print : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {


            if (!IsPostBack)
            {
                hfd_orderid.Value = Request.QueryString[0].ToString();
                List<USP_Get_Print_FinancePaymentHistoryResult> print = Licensing_Details.Get_Print_PaymentHistory(hfd_orderid.Value);
                lbl_Name.Text = print[0].Name;
                lbl_License.Text = print[0].Lic_no;
                lbl_orderid.Text = print[0].Receiptnum;
                lbl_amountpaid.Text = print[0].AmountPaid;
                lbl_datepaid.Text = print[0].DatePaid.ToString();
                lbl_payment_type.Text = print[0].Values;
                lbl_check_no.Text = print[0].Checknum;
                lblfeetype.Text = print[0].Fee_Type;
                if (print[0].Values == "Credit Card")
                {
                    checklbl.Visible = false;
                    chkno.Visible = false;
                    lbltransactionamount.Visible = true;
                    if (print[0].OnlineRenewalPID!=null)
                    {
                        cardnumber.Visible = true;
                        totalamount.Visible = true;
                        lblcardnumber.Visible = false;
                    }
                    else
                    {
                        cardnumber.Visible = true;
                        totalamount.Visible = true;
                        lblcardnumber.Visible = false;
                    }
                    //if (print[0].OnlineRenewalPID != null)
                    //{
                     //   lblcardnumber.Text = print[0].Onlinerenewalcardnumber;
                        lbltransactionamount.Text = print[0].Onlinerenewaltransactionfee;
                        lbltotalamount.Text = print[0].Onlinerenewaltotalamount;
                    //}
                }
                else
                {
                    //   chkno.Visible = true;
                    // checklbl.Visible = true;
                    lbltransactionamount.Visible = true;
                    cardnumber.Visible = false;
                    totalamount.Visible = true;
                }
            }

        }
    }
}