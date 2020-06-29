using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Person_Details;

namespace Licensing.Finance
{
    public partial class Finance_ReportofCollections : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblamount.Visible = false;
                lbltotalamount.Visible = false;
            }
        }

        protected void btn_generate_Click(object sender, EventArgs e)
        {
            string edate = "";
            lblamount.Visible = true;
            lbltotalamount.Visible = true;
            if (txt_enddate.Text == "")
                edate = txt_startdate.Text;
            else
                edate = txt_enddate.Text;

            List<USP_GetROCTotalAmountResult> RocTotalAmount = Licensing_Details.GetRocTotalAmount(Convert.ToDateTime(txt_startdate.Text), Convert.ToDateTime(edate), Convert.ToInt32(rdblst.SelectedValue), 1);
            if (RocTotalAmount[0].TotalAmount != null)
                lbltotalamount.Text = RocTotalAmount[0].TotalAmount;

            string js = "BindRocData();";
            ScriptManager.RegisterStartupScript(Page, GetType(), "scr", js, true);
        }
    }
}