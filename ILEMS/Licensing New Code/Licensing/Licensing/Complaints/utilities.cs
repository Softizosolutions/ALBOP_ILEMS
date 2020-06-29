using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using System.Data.SqlClient;

using Microsoft.ApplicationBlocks.Data;



namespace Licensing.Complaints
{
    public class utilities
    {



        public static void BindDropdown_Mstaertables(DropDownList ddl)
        {

            ddl.DataSource = ComplaintsLink.Complaints.Get_Lkp_tables();

            ddl.DataValueField = "Lkp_tbl_ID";

            ddl.DataTextField = "Lkp_table_name";

            ddl.DataBind();

            ddl.Items.Insert(0, new ListItem("Select Lookup Table", "-1"));

        }
        public static void Bind_LicenseTypes(DropDownList ddllicense)
        {
            ddllicense.DataSource = Person_Details.Licensing_Details.Get_License();
            ddllicense.DataValueField = "LicenseType_ID";
            ddllicense.DataTextField = "License_Type";
            ddllicense.DataBind();
            ddllicense.Items.Insert(0, new ListItem("Select License Type", "-1"));
        }
        public static void Bind_LicenseTypes_individual(DropDownList ddllicense)
        {
            ddllicense.DataSource = Person_Details.Licensing_Details.Get_License().Where(c => c.LicenseType_ID == 1 || c.LicenseType_ID == 2 || c.LicenseType_ID == 3);
            ddllicense.DataValueField = "LicenseType_ID";
            ddllicense.DataTextField = "License_Type";
            ddllicense.DataBind();
            ddllicense.Items.Insert(0, new ListItem("Select License Type", "-1"));
        }
        public static void Bind_LicenseTypes_Business(DropDownList ddllicense)
        {
            ddllicense.DataSource = Person_Details.Licensing_Details.Get_License().Where(c => c.LicenseType_ID != 1 && c.LicenseType_ID != 2 && c.LicenseType_ID != 3);
            ddllicense.DataValueField = "LicenseType_ID";
            ddllicense.DataTextField = "License_Type";
            ddllicense.DataBind();
            ddllicense.Items.Insert(0, new ListItem("Select License Type", "-1"));
        }
        public static void Bind_grid_Masterdata(GridView grd, string seltblid)
        {

            grd.DataSource = ComplaintsLink.Complaints.Get_Lkp_tablesdata(Convert.ToInt32(seltblid));

            grd.DataBind();

        }

        public static ComplaintsLink.tbl_lkp_data Get_Masterdata(string auid)
        {
            
            return ComplaintsLink.Complaints.Get_valuebyid(Convert.ToInt32(auid));

        }

        
        public static int Save_Masters(string dataid, string tblid, string orgid, string val)
        {

            return ComplaintsLink.Complaints.Save_Mastervalues(Convert.ToInt32(dataid), Convert.ToInt32(tblid), Convert.ToInt32(orgid), val);

        }

        public static void Delete_Masters(string dataid)
        {

            ComplaintsLink.Complaints.Delete_Mastervalues(Convert.ToInt32(dataid));

        }

        public static void BindDropdown(DropDownList ddlstate, int IdNum)
        {


            ddlstate.DataSource = ComplaintsLink.Complaints.Get_Lkp_tablesdata(IdNum);
            ddlstate.DataValueField = "Lkp_data_ID";
            ddlstate.DataTextField = "Values";
            ddlstate.DataBind();
            ddlstate.Items.Insert(0, new ListItem("Select", "-1"));
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
        public static DataTable Getrespondents(string cmpid)
        {
            return SqlHelper.ExecuteDataset(System.Configuration.ConfigurationSettings.AppSettings["Licensing_Con"].ToString(), "dbo.USP_Getrespondents", new object[]{cmpid}).Tables[0];
                
        }

        public static DataSet Getcomplaintssearch_Info(string lname, string fname, string ssn, string dob, string licno, string cmpnumber)
        {
            //SqlConnection Lic_con = new SqlConnection(System.Configuration.ConfigurationSettings.AppSettings["ABN_Con"].ToString());
            try
            {

                object[] obj = { lname, fname, ssn, dob, licno, cmpnumber };
                //if (Lic_con.State == ConnectionState.Closed)
                //    Lic_con.Open();
                //DataSet ds = SqlHelper.ExecuteDataset(System.Configuration.ConfigurationSettings.AppSettings["Licensing_Con"].ToString(), "dbo.USP_Complaints_GetComplaintSearch", obj);//
                DataSet ds = SqlHelper.ExecuteDataset(System.Configuration.ConfigurationSettings.AppSettings["Licensing_Con"].ToString(), "dbo.USP_GetComplaintSearch", obj);//
                return ds;
            }
            catch
            {
                return null;
            }
            finally
            {
                //Lic_con.Close();
            }
        }




      

    

      


    }
}