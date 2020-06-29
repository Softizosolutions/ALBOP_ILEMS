using System;
using System.Data;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using System.Collections.Generic;
using System.Data.Linq;
using System.Data.SqlClient;
using Person_Details;

using ComplaintsLink;
using ComplaintsTabLinq;

namespace Licensing.Complaints
{
    public static class Utilities_ComplaintsTAB
    {
        public static List<GetComplaintsResult> GetComplaints( string RespType, int RespId)
        {
            return  ComplaintsTabLinq.ClsComplaints.GetComplaints(RespType, RespId);
            
        }
        public static int cmp_count( int RespId)
        {
            return  ComplaintsTabLinq.ClsComplaints.GetComplaints("0", RespId).ToList().Count;

        }
        public static List<USP_GetComplaintInfobyPersonidResult> Get_ComplaintInfo(int pid)
        {
            return ComplaintsLink.Complaints.getcomplaintinfo(pid);
        }
        public static ComplaintsTabLinq.TbL_Complaint GetComplaintsById(int CompId)
        {

            return ComplaintsTabLinq.ClsComplaints.GetComplaintDetailsForEdit(CompId);
        }
        public static List<USP_GetDocumentDetailsbyDoctypeResult> Get_DocumentDetailsbyDoctype(string doctype, string fromdate, string todate)
        {
            using (ComplaintsDataContext cdc = new ComplaintsDataContext())
            {
                if (todate == "")
                    todate = fromdate;
                return cdc.USP_GetDocumentDetailsbyDoctype(doctype, Convert.ToDateTime(fromdate), Convert.ToDateTime(todate)).ToList();
            }
        }
        public static List<ComplaintsLink.USP_Complaints_GetComplaintBusinessSearchResult> GetBusinessSearch(string businame,string owners,string fein,string dob,string licno,string cmpno,string complainant)
        {
            using (ComplaintsDataContext db = new ComplaintsDataContext())
            {
                return db.USP_Complaints_GetComplaintBusinessSearch(businame, owners, fein, dob, licno, cmpno, complainant).ToList();
            }
        }
        
        public static void BindDropdown(DropDownList ddlstate, int IdNum)
        {
            ddlstate.DataSource = ComplaintsTabLinq.ClsComplaints.Get_Lkp_tablesdata(IdNum);
            ddlstate.DataValueField = "Lkp_data_ID";
            ddlstate.DataTextField = "Values";
            ddlstate.DataBind();
            ddlstate.Items.Insert(0, new ListItem("Select", "-1"));
        }

        //public static ComplaintsTabLinq.TbL_Complaint UpdateComplaints(int CompId)
        //{

        //   // return ComplaintsTabLinq.(CompId);
        //}

    }
}