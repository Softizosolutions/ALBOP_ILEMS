using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
namespace Licensing.Finance
{
    public partial class Print_ConsumerInvoice : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            DataSet ds = Accounting_Utilities.GetInvoiceprint(Request.QueryString[0].ToString());
            if (ds.Tables[0].Rows.Count > 0)
            {
                DataRow dr = ds.Tables[0].Rows[0];
                lblbillto.Text = dr["Billto"].ToString();
                lblinvno.Text = dr["InvoiceNumber"].ToString();
                lbllicno.Text = dr["Indicator"].ToString();
                lbladdr.Text = dr["Address1"].ToString() + " , " + dr["Address2"].ToString() + " ,<br>" + dr["City"].ToString() + " " + dr["State"].ToString() + " " + dr["Zip"].ToString()+".";
            }
            grd.DataSource = ds.Tables[1];
            grd.DataBind();
        }
    }
}