using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Licensing.Reports;

namespace Licensing.Prints
{
    public partial class Vw_Print : System.Web.UI.Page
    {
        DataRow dr;
        protected void Page_Load(object sender, EventArgs e)
        {
            var count = Request.QueryString.Count;
            if (!IsPostBack)
            {
                string pid = "0";

                if (Request.QueryString["pid"] != null)
                    pid = Request.QueryString["pid"].ToString();

                if (Request.QueryString.Count == 3 ||(Request.QueryString.Count == 4 && pid == "0"))
                {
                    tbl_print obj = Reportgenrator.Get_printbyid(Request.QueryString[1].ToString());
                    string query = "select * from [" + obj.Vwname + "] where [" + obj.fltrcol + "]='" + Request.QueryString[2].ToString() + "'";
                    DataSet ds = Reportgenrator.Getrpt(query);
                    if (ds.Tables[0].Rows.Count > 0)
                        dr = ds.Tables[0].Rows[0];



                }
                else
                if (pid != "0")
                {
                    tbl_print obj = Reportgenrator.Get_printbyid(Request.QueryString[1].ToString());
                    string query = "select * from [" + obj.Vwname + "] where [" + obj.fltrcol + "]='" + Request.QueryString[2].ToString() + "' and perid=" + Request.QueryString["pid"].ToString();
                    DataSet ds = Reportgenrator.Getrpt(query);
                    if (ds.Tables[0].Rows.Count > 0)
                        dr = ds.Tables[0].Rows[0];



                }
                else
           if (Request.QueryString.Count == 4 )
                {
                    tbl_print obj = Reportgenrator.Get_printbyid(Request.QueryString[1].ToString());
                    string query = "select * from [" + obj.Vwname + "] where [" + obj.fltrcol + "]='" + Request.QueryString[2].ToString() + "'";
                    DataSet ds = Reportgenrator.Getrpt(query);
                    if (ds.Tables[0].Rows.Count > 0)
                        dr = ds.Tables[0].Rows[0];
                    DataList dtl = (DataList)this.Page.FindControl("dtlstresp");
                    dtl.DataSource = Getrespondents();
                    dtl.DataBind();

                }
               

            }
        }
        public DataTable Getrespondents()
        {
            return Licensing.Complaints.utilities.Getrespondents(Request.QueryString[2].ToString());
        }
        public string Getval(string col)
        {
            if (dr != null)
                return dr[col].ToString();
            else
                return "";
        }
    }
}