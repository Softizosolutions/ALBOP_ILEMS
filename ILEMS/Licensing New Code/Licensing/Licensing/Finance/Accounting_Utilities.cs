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
using Accounting_Data;
using Microsoft.ApplicationBlocks.Data;
using System.Data.SqlClient;



namespace Licensing.Finance
{
    public class Accounting_Utilities
    {
        
        public static void BindDropdown(DropDownList ddlstate, int IdNum)
        {
            ddlstate.DataSource = Accounting_Data.Accounting_Details.Get_Lkp_tablesdata(IdNum);
            ddlstate.DataValueField = "Lkp_data_ID";
            ddlstate.DataTextField = "Values";
            ddlstate.DataBind();
            ddlstate.Items.Insert(0, new ListItem("Select", "-1"));
        }
        public static int Getbatchid(string batchno)
        {
            try
            {
                string query="select Batch_ID from TBL_Accounting_BatchDetails where Batchnum='"+batchno+"'";

                object obj = SqlHelper.ExecuteScalar(System.Configuration.ConfigurationSettings.AppSettings["Licensing_Con"].ToString(), CommandType.Text, query);
                return Convert.ToInt32(obj);
            }
            catch
            {
                return 0;
            }
        }
        public static void Closebatch(string batchno)
        {
            try
            {
                string query = "update TBL_Accounting_BatchDetails set BatchStatus='504',ClosedDate='"+DateTime.Now.ToString()+"' where Batchnum='" + batchno + "'";
                SqlHelper.ExecuteNonQuery(System.Configuration.ConfigurationSettings.AppSettings["Licensing_Con"].ToString(), CommandType.Text, query);

            }
            catch
            {
            }
        }
        public static DataSet GetInvoiceprint(string invid)
        {
            try
            {
                return SqlHelper.ExecuteDataset(System.Configuration.ConfigurationSettings.AppSettings["Licensing_Con"].ToString(), "usp_consumerInvoicerpt", new object[] { invid });
            }
            catch
            {
                return null;
            }
        }
        public static void Voidtransaction(string recid,string voidreason)
        {
            try
            {
                SqlHelper.ExecuteNonQuery(System.Configuration.ConfigurationSettings.AppSettings["Licensing_Con"].ToString(), "USP_voidTransaction", new object[]{recid,voidreason});

            }
            catch
            {
            }
        }
        public static void verifybatch(string batchno,string verfyby)
        {
            try
            {
                string query = "update TBL_Accounting_BatchDetails set BatchStatus='503',verified_by='" + verfyby + "' where Batchnum='" + batchno + "'";
                SqlHelper.ExecuteNonQuery(System.Configuration.ConfigurationSettings.AppSettings["Licensing_Con"].ToString(), CommandType.Text, query);

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
        public static void Fill_Dropdown(System.Web.UI.WebControls.DropDownList ddl, string Table_name, string Disp_col, string Val_col, string Condition, string Default)
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


      
    }
}