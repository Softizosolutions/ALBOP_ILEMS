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
using System.IO;
using Accounting_Data;


namespace Licensing.Finance
{
    public partial class Consumer_Invoice : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

                Accounting_Utilities.Fill_Dropdown(ddlfeetype, "tbl_lkp_subobj Order by Description", "Description", "Subobj_Id", "", "Select Fee Type");
                Accounting_Utilities.BindDropdown(ddlrecstate, 9);
            }
        }
 
    protected void ddlfeetype_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlfeetype.SelectedValue != "-1")
            {
                // mdpnewvoice.Show();
                Accounting_Data.Accounting_Details.RetriveAmountSubOrg(Convert.ToInt32(ddlfeetype.SelectedValue.ToString()));               
                List<Accounting_Data.tbl_lkp_subobj> li = Accounting_Data.Accounting_Details.RetriveAmountSubOrg(Convert.ToInt32(ddlfeetype.SelectedValue.ToString()));
                Accounting_Data.tbl_lkp_subobj obj = li.Where(c => c.Subobj_Id == Convert.ToInt32(ddlfeetype.SelectedValue.ToString())).SingleOrDefault();
                 txtnewinvoceamt.Text = obj.Amount.ToString();
                 //hfdoamount.Value = dt.Rows[0]["Amount"].ToString();
            }

    }
    protected void btnnewinvoceOK_Click(object sender, EventArgs e)       

    {
      
       Accounting_Data.TBL_Accounting_ConsumerInvoice Inv = new Accounting_Data.TBL_Accounting_ConsumerInvoice();
       Inv.Billto = txtconsumerinvoicename.Text;
        Inv.Address1 = txtconsumeraddress1.Text;
       Inv.Address2 = txtconsumeraddress2.Text;
        Inv.City=txtreccity.Text;
        Inv.State= ddlrecstate.SelectedValue;
        Inv.Zip= txtreczip.Text;
        Inv.Indicator= txtsubscriber.Text;
       int latid= Accounting_Data.Accounting_Details.Insert_ConsumerInvoice(Inv);
       Fill_invoice(latid.ToString());
        Clear();
        Page.RegisterStartupScript("js", "<script>aftersave(" + latid.ToString() + ");</script>");
      //  ScriptManager.RegisterStartupScript(Page, GetType(), "js", "aftersave(" + latid .ToString()+ ")", true);
    }
    private void Fill_invoice(string invid)
    {

        string[] selrws = hfdsellines.Value.Split('^');
        foreach (string temp in selrws)
        {
            string[] cols = temp.Split('~');
            Accounting_Data.TBL_Accounting_Consumer_InvoiceFee Fee = new TBL_Accounting_Consumer_InvoiceFee();
            Fee.Cons_Invoice_Id = Convert.ToInt32(invid);
            Fee.FeeTypeId = Convert.ToInt32(cols[0]);
            Fee.Amount =Convert.ToDecimal( cols[1]);
            Fee.DueDate =Convert.ToDateTime( cols[2]);
            Accounting_Data.Accounting_Details.Insert_ConsumerInvoiceFeeData(Fee);
        }


    }

    protected void btnconsumercancel_Click(object sender, EventArgs e)
    {
        Clear();
    }
    public void Clear()
    {
        hfdsellines.Value = "";
        ddlrecstate.SelectedIndex = -1;
        txtconsumerinvoicename.Text = "";
        txtconsumeraddress1.Text = "";
        txtconsumeraddress2.Text = "";
        txtnewinvoceamt.Text = "";
        txtduedt.Text = "";
        txtsubscriber.Text = "";
        ddlfeetype.SelectedIndex = -1;
        txtreczip.Text = "";
        txtreccity.Text = "";
    }
}

}
