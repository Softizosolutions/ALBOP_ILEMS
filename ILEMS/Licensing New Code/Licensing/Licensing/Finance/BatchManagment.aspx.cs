using System;
using System.Collections;
using System.Collections.Generic;
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


namespace Licensing.Finance
{
    public partial class BatchManagment : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Accounting_Utilities.BindDropdown(ddlbatchstatus, 20);
                // Accounting_Utilities.BindDropdown(ddluser, 16);
                Accounting_Utilities.Fill_Dropdown(ddluser, "tbl_Login Order by UserName", "UserName", "loginID", "", "ALL");
                
              
            }
            txtCreatedTo.Attributes.Add("onblur", "javascript:checkdates()");

        }

        #region  Small Functions
        public string amount(string amount)
        {
            if (amount != "")
            {

                return "$" + amount;
            }
            else
                return "";
        }
        public string toup(string str)
        {
            string sr = str.ToUpper();
            return sr;
        }
        public string verify(string str)
        {
            if (str == "4" || str == "6" || str == "2")
            {
                return "No";
            }
            return "Yes";
        }
        public string filter_date(string str)
        {
            try
            {
                if
                    (str != "")
                {
                    return DateTime.Parse(str).ToString("MM/dd/yyyy");
                }
                return "NA";
            }
            catch { return "NA"; }
        }
        #endregion



        #region Clear
        protected void Clear()
        {
            ddluser.SelectedValue = "-1";
            txtBatch.Text = "";
            txtreceipt.Text = "";
            ddlbatchstatus.SelectedValue = "-1";
            txtCreatedFrom.Text = "";
            txtCreatedTo.Text = "";
        }
        #endregion 

        #region Code Functions
        protected void batch_close(object sender, EventArgs e)
        {
            Accounting_Utilities.Closebatch(hfdselbatch.Value);
            hfdselbatch.Value = "";
            ScriptManager.RegisterStartupScript(Page, GetType(), "js", "afterclose()", true);
        }
       

        protected void btnbatchsearch_Click(object sender, EventArgs e)
        {
            if (ddluser.SelectedItem.Value == "-1")
            {

                ddluser.SelectedItem.Value = "";
            }

            if (ddlbatchstatus.SelectedItem.Text == "-1" && ddlbatchstatus.SelectedItem.Text =="--Select--")
            {

                ddlbatchstatus.SelectedItem.Text = "";
            }

                
           
          
        }
        public string Print_Link()
        {
            return "javascript:CallPrint()";


        }
        protected void btnCloseBatch_Click(object sender, EventArgs e)
        {
            try
            {

                //Accounting_Data.Accounting_Details.Updatebatchdetails(hfdbatchno.Value.ToString(), 504, DateTime.Now.ToString("MM/dd/yyyy"));
               
                List<Accounting_Data.USP_Accounting_GetFinancialBatchResultsResult> lst = Accounting_Data.Accounting_Details.GetFinancialAccountBatchResults(ddluser.SelectedItem.Value, txtBatch.Text, txtreceipt.Text, ddlbatchstatus.SelectedValue, txtCreatedFrom.Text, txtCreatedTo.Text).ToList();

               

           Accounting_Data.USP_Accounting_GetFinancialBatchResultsResult obj=lst.Where(c=>c.Batchnum==txtBatch.Text).SingleOrDefault();
           
            }
            catch
            {
            }
        }
        

        }
        
        #endregion
}

