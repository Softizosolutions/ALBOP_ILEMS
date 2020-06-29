using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Microsoft.ApplicationBlocks;
using Microsoft.ApplicationBlocks.Data;
namespace Licensing.Certificates
{
    
    public partial class p1 : System.Web.UI.Page
    {
        public DataTable Getdata()
        {
            return SqlHelper.ExecuteDataset(System.Configuration.ConfigurationManager.AppSettings["Licensing_Con"].ToString(), "USP_getcertdetails", new object[] { Request.QueryString[0].ToString(), Request.QueryString[1].ToString(), Request.QueryString[2].ToString() }).Tables[0];
        }
        public string Checkcount(string pid,string qid)
        {
            try {
               string cnt= SqlHelper.ExecuteScalar(System.Configuration.ConfigurationManager.AppSettings["Licensing_Con"].ToString(), CommandType.Text, "select count(*) from Pharmacy_Online.dbo.tbl_profile_options where option_id='" + qid + "' and Question_Type='2' and answer='0' and person_id=" + pid).ToString();
                if (cnt == "0")
                    return "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
                else
                    return "/ Parenteral";
            }
            catch
            {
                return "                  ";
            }

        }
        int cnt = 0,cur=0;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                DataTable dt = Getdata();
                if (Request.QueryString["issudt"] != null)
                {
                    foreach (DataRow dr in dt.Rows)
                        dr["issudt"] = Request.QueryString["issudt"].ToString();
                }
                cnt = dt.Rows.Count;
                dtlst.DataSource = dt;
                dtlst.DataBind();
            }
           
        }
        public string renyear()
        {
            if (DateTime.Now.Month > 7 && DateTime.Now.Month < 13)
                return "01/01/" + Convert.ToString(DateTime.Now.Year + 1);
            else
                return "01/01/" + Convert.ToString(DateTime.Now.Year);
        }
        public string GetLictype_pharmacy(string lictypeid,string perid)
        {
            string lictype = "";
            switch(lictypeid)
            {
                case "9":
                    lictype = lictype + Checkcount(perid,"508");
                    break;
                case "10":
                    lictype = lictype + Checkcount(perid, "509");
                    break;
                case "11":
                    lictype = lictype + Checkcount(perid, "510");
                    break;
                case "12":
                    lictype = lictype + Checkcount(perid, "511");
                    break;
                case "13":
                    lictype = lictype + Checkcount(perid, "512");
                    break;

            }
            return lictype;
        }
        public string Getlicshort(string ltypeid)
        {
            switch (ltypeid)
            {
                case "Manufacturer":
                    return "MFG";
                case "Manufacturer Oxygen":
                    return "MFG-Oxy";
                case "Manufacturer Virtual":
                    return "MFG-Vet";
                case "Wholesale Distributor":
                    return "WSD";
                case "Wholesaler Precursor":
                    return "WSD-Prec";
                case "Wholesaler Virtual":
                    return "WSD-Vir";
                case "Wholesaler Oxygen":
                    return "WSD-Oxy";
                case "Third Party Logistics":
                    return "3PL";
                case "Repackager Precursor":
                    return "Rpck-Prec";
                case "Repackager":
                    return "Rpck";
                case "Manufacturer Precursor":
                    return "MGF-Prec";
                case "Wholesaler Reverse Distributor":
                    return "Rev WSD";
                case "Private Label Distributor":
                    return "PLD";
                default:
                    return "";
            }

        }
        public string iscs(string val)
        {
            if (val == "0")
                return "style='display:none'";
            else
                return "style='display:block'";
        }
        public string Schedule(string val)
        {
            if (val != "")
                return val.Replace(',', ' ').Replace("AL State specific Controlled Substances", "State Specific");
            else
                return val;
        }
        public string isnotcs(string val)
        {
            if (val != "0")
                return "style='display:none'";
            else
                return "style='display:block'";
        }
        public string islst()
        {
            cur++;
            if (cur != cnt)
            {
                return "<div style='page-break-before:always;'></div>";
            }
            else
                return "";
        }
         
    }
}