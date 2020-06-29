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

namespace Licensing.PersonLicensing
{
    public partial class Payment : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                hfdpid.Value = Request.QueryString[0].ToString();
                PaymentHistory_Details(Convert.ToInt32(hfdpid.Value));
                VoidHistory_Details(Convert.ToInt32(hfdpid.Value));
                AuditHistory_Details(Convert.ToInt32(hfdpid.Value));
            }
        }

        public void PaymentHistory_Details(int perid)
        {
          
             grd_Paymenthistory.DataSource = Person_Details.Licensing_Details.Get_PaymentHistory(perid);
            grd_Paymenthistory.DataBind();
        }
        public void VoidHistory_Details(int perid)
        {

            grdtabsVoidHistory1.DataSource = Person_Details.Licensing_Details.Get_VoidHistory(perid);
            grdtabsVoidHistory1.DataBind();
        }


        public void AuditHistory_Details(int perid)
        {

            grdtabsAuditHistory1.DataSource = Person_Details.Licensing_Details.Get_AuditHistory(perid);
            grdtabsAuditHistory1.DataBind();
        }

    }
}