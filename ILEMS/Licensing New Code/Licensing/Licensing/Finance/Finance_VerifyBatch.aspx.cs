using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Licensing.Finance
{
    public partial class Finance_VerifyBatch : System.Web.UI.Page
    {

        string sdate;
        string edate;

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        #region Small Functions
        public string toup(string str)
        {
            string sr = str.ToUpper();
            return sr;
        }
        public string amount(string amount)
        {
            if (amount != "")
            {

                return "$" + amount;
            }
            else
                return "";
        }
        public string filter_date(string str)
        {
            try
            {
                if (str != "")
                {
                    return DateTime.Parse(str).ToString("MM/dd/yyyy");
                }
                return "NA";
            }
            catch { return "NA"; }
        }
        public string verify(string str)
        {
            if (str == "504" || str == "500" || str == "502")
            {
                return "No";
            }
            return "Yes";

        }

        #endregion
        #region CODE Functions


        //protected void btnVerifyBatchOK_Click(object sender, EventArgs e)
        //{

        //   // utilities_Person.Updatebatchdetails(hfdbatchno.Value, 503, DateTime.Now.ToString("MM/dd/yyyy"));

        //    Finance_Data.TBL_Finance_BatchVerifyDetail list = new Finance_Data.TBL_Finance_BatchVerifyDetail();
        //    list.batch_ID = Accounting_Utilities.Getbatchid(hfdselbatch.Value);
        //    list.cash = txtcash.Text;
        //    list.checks = txtchecks.Text;
        //    list.MoneyOrder = txtmoneyorders.Text;
        //    list.CreditCards = txtcreditcard.Text;
        //    Finance_Data.Finance_Details.Insert_FinaceBatchVerifyDetails(list);
        //    Accounting_Utilities.verifybatch(hfdselbatch.Value, "1");
        //    Clear();
        //    ScriptManager.RegisterStartupScript(Page, GetType(), "js", "afterverify()", true);
        //}

        public void Clear()
        {
            txtcash.Text = "0";
            txtchecks.Text = "0";
            txtmoneyorders.Text = "0";
            txtcreditcard.Text = "0";
        }

         protected void btn_Search_Click(object sender, EventArgs e)
        {
           bind();
        }
        public void bind()
        {
           

        }
        #endregion

        protected void btn_Clear_Click(object sender, EventArgs e)
        {
            txtstartdate.Text = "";
            Txtenddate.Text = "";
        }



    }
}