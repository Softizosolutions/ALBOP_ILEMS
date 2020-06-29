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
using OperationsLink;
using System.Collections.Generic;
namespace Licensing.Operations
{
    public partial class Addlog_paymentreciept : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            lbltransationdate.Text = DateTime.Now.ToString("MM/dd/yyyy");

            //OperationsLink.Operations.GetReceiptData(Request.QueryString[0].ToString());
            //lbl_receivedfrom.Text = (new System.Collections.Generic.Mscorlib_CollectionDebugView<OperationsLink.USP_Operations_GetAddlog_paymentreceiptResult>(OperationsLink.Operations.GetReceiptData(Request.QueryString[0].ToString()))).Items[0].From_Received;

            OperationsLink.tbl_Add_Log Obj = Utilities_Operations.Edit_ManageLogs(Convert.ToInt32(Request.QueryString[0].ToString()));

            lbl_receivedfrom.Text = Obj.From_Received;
            lbl_license.Text = Obj.SSN;
            lbl_amt.Text = Obj.Amount.ToString();
           // lbl_paymenttype.Text = Obj.PaymentType;
          //  lbl_received.Text = Obj.MailClerk;
            lbl_chknum.Text = Obj.CheckNumber;
            

            string strFeeType = Obj.Feetype;

            switch (strFeeType)
            {
                case "1":
                    lbl_feetype.Text = "Apprentice Renewal";
                    break;

                case "2":
                    lbl_feetype.Text = "Initial Apprentice";
                    break;

                case "3":
                    lbl_feetype.Text = "Journey man renewal";
                    break;
                case "4":
                    lbl_feetype.Text = "Journey man renewal";
                    break;
                case "5":
                    lbl_feetype.Text = "Replacement Card";
                    break;
                case "6":
                    lbl_feetype.Text = "Temporary Journeyman";
                    break;
                
                default:
                    lbl_feetype.Text = " ";
                    break;
            }




            lbl_receipt.Text = Obj.ReceiptNum;

            string strPaymentType = Obj.PaymentType;

            switch (strPaymentType)
            { 
                case "537":
                    lbl_paymenttype.Text = "Cash";
                break;
                
                case "538":
                     lbl_paymenttype.Text = "MO";
                     break;

                case "539":
                     lbl_paymenttype.Text = "CC";
                     break;
                case "540":
                     lbl_paymenttype.Text = "Business Check";
                     break;
                case "541":
                     lbl_paymenttype.Text = "Personal Check";
                     break;
                case "542":
                     lbl_paymenttype.Text = "Cahiers Check";
                     break;
                case "543":
                     lbl_paymenttype.Text = "No Money";
                     break;
                default:
                     lbl_paymenttype.Text = " ";
                     break;
            }
          
        }
    }
}