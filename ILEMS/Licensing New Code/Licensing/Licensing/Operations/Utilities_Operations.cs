using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using System.Data.SqlClient;

using Microsoft.ApplicationBlocks.Data;
using Person_Details;
using OperationsLink;


namespace Licensing.Operations
{
    public static class Utilities_Operations
    {
        public  static List<USP_getloghistoryResult> Getloghistory(string logid)
        {
            using (OperationsLink.OperationsDataContext odc = new OperationsDataContext())
            {
                return odc.USP_getloghistory(logid).ToList();
            }
        }
        public static List<OperationsLink.tbl_Add_Log> Get_CheckandAmount(string chkno)
        {
            using (OperationsLink.OperationsDataContext odc = new OperationsDataContext())
            {
                return odc.tbl_Add_Logs.Where(c => c.CheckNumber == chkno).ToList();
            }
        }
        public static List<USP_GetBalanceAmountInChecksResult> GetBalanceAmount(string chkno)
        {
            using (OperationsDataContext odc = new OperationsDataContext())
            {
                return odc.USP_GetBalanceAmountInChecks(chkno).ToList();
            }
        }
        public static void BindDropdownPayment(DropDownList ddlPaymentType,int iNum)
        {
         //   ddlPaymentType.DataSource = Masters.Masters.Get_Lkp_tablesdata(iNum);
          //  ddlPaymentType.DataValueField = "Lkp_data_ID";
           // ddlPaymentType.DataTextField = "Values";
          //  ddlPaymentType.DataBind();
          //  ddlPaymentType.Items.Insert(0, new ListItem("--Select--", "-1"));
        }
        public static Boolean validatecheck(string chkno)
        {
            using (OperationsLink.OperationsDataContext opd = new OperationsDataContext())
            {
                List<OperationsLink.tbl_Add_Log> log = opd.tbl_Add_Logs.Where(c => c.CheckNumber == chkno).ToList();
                if (log.Count > 0)
                    return false;
                else
                    return true;
            }
        }
        public static void BindDropdown(DropDownList ddlstate, int IdNum)
        {
            ddlstate.DataSource = OperationsLink.Operations.Get_Lkp_tablesdata(IdNum);
            ddlstate.DataValueField = "Lkp_data_ID";
            ddlstate.DataTextField = "Values";
            ddlstate.DataBind();
            ddlstate.Items.Insert(0, new ListItem("Select", "-1"));
        }
        public static void Fill_Dropdown(DropDownList ddlstate)
        {
            ddlstate.DataSource = OperationsLink.Operations.Get_Lkp_subobj();
            ddlstate.DataValueField = "Subobj_Id";
            ddlstate.DataTextField = "Description";
            ddlstate.DataBind();
            ddlstate.Items.Insert(0, new ListItem("Select", "-1"));
        }

       


        public static int Insert_addlogInfo(string flag, int addlogid, string datereceived, string from, string ssn, string forwardto, string mailclerk, string specialentries, string paymenttype, string amount, string checknumber, string walkin, string feetype)
        {
           int i=10;
          // OperationsLink.Operations.OperationsInsertValues();


           return i ;
        }

        public static tbl_Add_Log Edit_ManageLogs(int logid)
        {

            return OperationsLink.Operations.Edit_ManageLogs(logid);
        }

        public static void Bind_grid(GridView grd)
        {

            grd.DataSource = OperationsLink.Operations.GetData();

            grd.DataBind();

        }
        public static void Fill_Login(System.Web.UI.WebControls.DropDownList ddl, string Table_name, string Disp_col, string Val_col, string Condition, string Default)
        {
            try
            {
                DataTable dt = Get_Values(Table_name, Disp_col, Val_col, Condition);
                ddl.Items.Clear();
                System.Web.UI.WebControls.ListItem li;
                if (Default != "")
                {
                    li = new System.Web.UI.WebControls.ListItem(Default, "-1");
                    ddl.Items.Add(li);
                }


                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    li = new System.Web.UI.WebControls.ListItem(dt.Rows[i][0].ToString(), dt.Rows[i][1].ToString());
                    ddl.Items.Add(li);
                }
            }
            catch
            {
            }
        }

        public static DataTable Get_Values(string Table_name, string Dis_col, string Val_col, string Condition)
        {
            //SqlConnection uti_con;
            SqlConnection uti_con = new SqlConnection(System.Configuration.ConfigurationSettings.AppSettings["Licensing_Con"].ToString());
            try
            {
                object[] obj = { Table_name, Dis_col + "," + Val_col, Condition };
                if (uti_con.State == ConnectionState.Closed)
                    uti_con.Open();
                SqlCommand cmd = new SqlCommand("USP_GetValues", uti_con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@tname", SqlDbType.VarChar).Value = obj[0];
                cmd.Parameters.Add("@col_name", SqlDbType.NVarChar).Value = obj[1];
                cmd.Parameters.Add("@cond", SqlDbType.VarChar).Value = obj[2];
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataSet ds = new DataSet();
                da.Fill(ds, "temp");
                //SqlHelper.ExecuteDataset(uti_con, "USP_GetValues", obj);
                if (ds.Tables.Count > 0)
                    return ds.Tables[0];
                else
                    return null;
            }
            catch (Exception ex)
            {
                return null;
            }
        }

       

    }
}