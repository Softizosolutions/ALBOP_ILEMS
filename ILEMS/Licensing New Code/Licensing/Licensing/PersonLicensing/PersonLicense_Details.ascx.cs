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
using System.IO;
using Person_Details;


namespace Licensing.PersonLicensing
{
    public partial class PersonLicense_Details : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
            
        }

        public void fill_data(string appid, string licid, string licno, string lictypeid)
        {
            hfd_Appid.Value = appid;
            hfd_licid.Value = licid;
            hfdlicno.Value = licno;
            hfdlictypeid.Value = lictypeid;
            //Bind();
            // Bind_audit();
        }


        public string format(string str)
        {
            try
            {
                if (str != "" && str!="01/01/1900" && str!=null)
                {
                    return DateTime.Parse(str).ToString("MM/dd/yyyy");
                }
                return "";
            }
            catch { return ""; }
        }

        public void fill_data(USP_Licensing_DetailsResult dr)
        {
            hfd_ltypeid.Value = dr.License_Type.ToString();
            string issuedate = "";
            issuedate = Convert.ToDateTime(dr.Issued_Date).ToString("MM/dd/yyyy");
            if (issuedate != "01/01/1900" && issuedate != null && issuedate != "" && issuedate != "01/01/0001")
            {
                lbllicence_issuedate.Text = issuedate;
            }
            else
            {
                lbllicence_issuedate.Text = "";
            }

            string appdate = "";
            appdate = Convert.ToDateTime(dr.App_Date).ToString("MM/dd/yyyy");
            if (appdate != "01/01/1900" && appdate != null && appdate != "" && appdate != "01/01/0001")
            {
                lbl_Appldate.Text = appdate;
            }
            else
            {
                lbl_Appldate.Text = "";
            }

            string statusdate = "";
            statusdate = Convert.ToDateTime(dr.Status_Change_Date).ToString("MM/dd/yyyy");
            if (statusdate != "01/01/1900" && statusdate != null && statusdate != "" && statusdate != "01/01/0001")
            {
                lblcicstatuschannge.Text = statusdate;
            }
            else
            {
                lblcicstatuschannge.Text = "";
            }
            //lblcicstatuschannge.Text = format(dr.Status_Change_Date.ToString()); 
            // txtenddate.Text = format(dr["Expired_Date"].ToString());
            //txtstdate.Text = format(dr["Issued_Date"].ToString());

            //  txtfrmstate.Text = dr["State"].ToString();
            // txtoutofstate.Text = dr["County"].ToString();
            //   txtmandatorycedt.Text = format(dr["Mandatory_cedate"].ToString());
            //Label1.Text = dr["State"].ToString();
            //Label2.Text = dr["County"].ToString();
            //   lbllicenceCount.Text = dr["Reprintcount"].ToString();
            //  lbllicencelastreprint.Text = dr["Last_Reprint_date"].ToString();

            string licexpdate = "";
            licexpdate = Convert.ToDateTime(dr.Expired_Date).ToString("MM/dd/yyyy");
            if (licexpdate != "01/01/1900" && licexpdate != null && licexpdate != "" && licexpdate != "01/01/0001")
            {
                lbllicexpdate.Text = licexpdate;
            }
            else
            {
                lbllicexpdate.Text = "";
            }


            //txtexpirationdate.Text = format(dr["Expired_Date"].ToString());
            //lbllicjournal.Text = "NA";
            //lbllicstartdate.Text = "NA";
            lbllicstatus.Text = dr.License_status.ToString();
            if (lbllicstatus.Text == "Removed")
            {
                //trreason.Attributes.Add("Style", "display:block");
                pnlreason.Visible = true;
                if (dr.Reason_Name != null)
                    lblreason.Text = dr.Reason_Name.ToString();
            }
            else
            {
                pnlreason.Visible = false;
                //trreason.Attributes.Add("Style", "display:none");
            }
            string renewaldate = "";
            renewaldate = Convert.ToDateTime(dr.Last_Renewal_Date).ToString("MM/dd/yyyy");
            if (renewaldate != "01/01/1900" && renewaldate != null && renewaldate != "" && renewaldate != "01/01/0001")
            {
                lbllastrenewdt.Text = renewaldate;
            }
            else
            {
                lbllastrenewdt.Text = "";
            }

            //lblrenewandt.Text = format(dr["Last_Renewal_Date"].ToString());
            fill_data(dr.App_Id.ToString(), dr.License_ID.ToString(), dr.Lic_no.ToString(), dr.License_Type_ID.ToString());
            if (dr.License_ID.ToString() == "" || dr.License_ID.ToString() == "0")
            {
                btn_changestatus.Attributes.Add("onclick", "javascript:return chngestatusapp(this);");
                btnstatushistory.Visible = false;
                // btnstatushistory.Attributes.Add("onclick", "javascript:return statushistoryapp(this);");
            }
            else
            {
                btn_changestatus.Attributes.Add("onclick", "javascript:return chngestatus(this);");
                btnstatushistory.Attributes.Add("onclick", "javascript:return statushistory(this);");
            }
            if (dr.object_type != 1&&(Session["UID"].ToString()=="9"|| Session["UID"].ToString() == "31"||Session["UID"].ToString()=="37"||Session["UID"].ToString()=="48" || Session["UID"].ToString() == "43"))
            {
                btn_changelictype.Attributes.Add("onclick", "javascript:return ChangeLicensetype(this);");
                btn_changelictype.Visible = true;
            }
            else
                btn_changelictype.Visible = false;
        }
    }
}