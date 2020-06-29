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
using System.IO;
using Person_Details;
using Microsoft.ApplicationBlocks.Data;
using System.Collections;
namespace Licensing.PersonLicensing
{
    public static class Utilities_Licensing
    {
        public static void Insertduplicateprocssrequest(string renid, string proc, string comments)
        {
            SqlHelper.ExecuteNonQuery(System.Configuration.ConfigurationManager.AppSettings["Licensing_Con"].ToString(), "USP_insertduplicaterequestprocess", new object[] { renid, proc, comments, HttpContext.Current.Session["UID"].ToString() });

        }
        public static void Bind_login(DropDownList ddllogin, string defaultva)
        {
            ddllogin.DataSource = Person_Details.Licensing_Details.Get_License1();
            ddllogin.DataValueField = "loginID";
            ddllogin.DataTextField = "UserName";
            ddllogin.DataBind();
            ddllogin.Items.Insert(0, new ListItem(defaultva, "-2"));
        }
        public static Tbl_CeAudit Editceaudit(string cerid)
        {
            return Person_Details.Licensing_Details.Edit_ceaudit(Convert.ToInt32(cerid));
        }
        public static void Delete_ce_audit(string cerid)
        {

            Person_Details.Licensing_Details.Delete_ceaudit(Convert.ToInt32(cerid));

        }

        public static void Deleteonlinecmp(string cmpid)
        {
            try
            {
                  SqlHelper.ExecuteNonQuery(System.Configuration.ConfigurationManager.AppSettings["Online"].ToString(), "USP_deleteoninecmp", new object[] {cmpid });
            }
            catch
            {
                
            }
        }
        public static void updateprint(string orderid)
        {
            try
            {
                SqlHelper.ExecuteNonQuery(System.Configuration.ConfigurationManager.AppSettings["Online"].ToString(), "USP_updateprint", new object[] { orderid });
            }
            catch
            {

            }
        }
        public static string Groupcases(string Mcmpid,string scmpno)
        {
            try
            {
                return SqlHelper.ExecuteScalar(System.Configuration.ConfigurationManager.AppSettings["Licensing_Con"].ToString(), "USP_insertreltcmps",new object[] {Mcmpid,scmpno}).ToString();
            }
            catch
            {
                return "";
            }
        }
        public static string UnGroupcases(string auid)
        {
            try
            {
                return SqlHelper.ExecuteScalar(System.Configuration.ConfigurationManager.AppSettings["Licensing_Con"].ToString(), CommandType.Text, "delete from tbl_reltcomplaints where auid=" + auid).ToString();
            }
            catch
            {
                return "";
            }
        }
        public static DataTable Getcheckerdata(string ssn)
        {
            try
            {
                return SqlHelper.ExecuteDataset(System.Configuration.ConfigurationManager.AppSettings["Licensing_Con"].ToString(), CommandType.Text, "select * from  tbl_kmh where dbo.FNC_DECRIPTION_PW(essn)='" + ssn + "' ").Tables[0];
            }
            catch
            {
                return null;
            }
        }
        public static void processrenewal2018(string ordid,string rstatus,string prcdt,string cmnt,string user)
        {
            try
            {
                SqlHelper.ExecuteNonQuery(System.Configuration.ConfigurationManager.AppSettings["Licensing_Con"].ToString(), "USP_Renewalprocess2018", new object[] { ordid, rstatus, prcdt, cmnt, user });
            }
            catch
            {
            }
                
        }
        public static string maxinvdt(string personid)
        {
           return  SqlHelper.ExecuteScalar(System.Configuration.ConfigurationManager.AppSettings["Licensing_Con"].ToString(), CommandType.Text, " select convert(varchar, max(InventoryDate),101) from tbl_CSinventory where PersonID = " + personid).ToString();
        }
        public static string checkSSN(string SSN)
        {
            return SqlHelper.ExecuteScalar(System.Configuration.ConfigurationManager.AppSettings["Licensing_Con"].ToString(), "USP_checkssn",new object[] { SSN }).ToString();
        }
        public static string SSN(string pid)
        {
            return SqlHelper.ExecuteScalar(System.Configuration.ConfigurationManager.AppSettings["Licensing_Con"].ToString(), CommandType.Text, "select dbo.FNC_DECRIPTION_PW(ESSN) from tbl_PersonDetails where Person_ID="+pid).ToString();
        }


        public static void UpdateRespondentIDS(string cmpnumber, int topersonid)
        {
            SqlHelper.ExecuteNonQuery(System.Configuration.ConfigurationManager.AppSettings["Licensing_Con"].ToString(), "USP_UpdateRespondentIDS", new object[] { cmpnumber, topersonid }).ToString();
        }

        public static DataTable GetNameandLicNumber(int pid)
        {
            return SqlHelper.ExecuteDataset(System.Configuration.ConfigurationManager.AppSettings["Licensing_Con"].ToString(), "USPGetNameAndLicNumber", new object[] { pid }).Tables[0];
        }
        public static void UpdateDuedateinFinance(int feeid, string suborgamount,Boolean isrecurring,string recurringdays, DateTime duedate)
        {
            SqlHelper.ExecuteNonQuery(System.Configuration.ConfigurationManager.AppSettings["Licensing_Con"].ToString(), CommandType.Text, "update TBL_Accounting_FeeDetails set  SubOrgAmount='" + suborgamount + "',Is_RecurringFee='" + isrecurring + "',Recurring_Days='" + recurringdays + "',DueDate='" + duedate + "' where FeeID=" + feeid);
        }
        public static void Updatedocumentcomments(int docid, string comments,string lictype,string doctype)
        {
            SqlHelper.ExecuteNonQuery(System.Configuration.ConfigurationManager.AppSettings["Licensing_Con"].ToString(), CommandType.Text, "update tbl_Person_Document_Details set Comments='" + comments.Replace("'", "`") + "',License_Type='" + lictype + "',DocType='"+doctype+"'  where Document_ID=" + docid);
        }
        public static void Updatedocumentcomments(int docid, string comments, string lictype)
        {
            SqlHelper.ExecuteNonQuery(System.Configuration.ConfigurationManager.AppSettings["Licensing_Con"].ToString(), CommandType.Text, "update tbl_Person_Document_Details set  Comments='" + comments.Replace("'","`") + "',License_Type='" + lictype + "'  where Document_ID=" + docid);
        }
        public static void Updateappstatu(string appid, string status, string sdt)
        {
            SqlHelper.ExecuteNonQuery(System.Configuration.ConfigurationManager.AppSettings["Licensing_Con"].ToString(), CommandType.Text, "update tbl_Application set App_Status='" + status + "',Status_Change_Date='" + sdt + "' where App_ID=" + appid);
        }
        public static void UpdateRecords(string from, string to)
        {
            SqlHelper.ExecuteNonQuery(System.Configuration.ConfigurationManager.AppSettings["Licensing_Con"].ToString(), "USP_MergeRecords", new object[] { from, to });
        }
        public static DataTable Getlabelsbyid(string apids)
        {
            return SqlHelper.ExecuteDataset(System.Configuration.ConfigurationManager.AppSettings["Licensing_Con"].ToString(), "USP_Getlabelsbyids", new object[] { apids }).Tables[0];
        }
        public static DataTable GetNameandLicno(int pid)
        {
            return SqlHelper.ExecuteDataset(System.Configuration.ConfigurationManager.AppSettings["Licensing_Con"].ToString(), "USP_GetNameandLicno", new object[] { pid }).Tables[0];
        }
        public static DataTable GetEmailsByLicenseTypes(string lictype,string county)
        {
            return SqlHelper.ExecuteDataset(System.Configuration.ConfigurationManager.AppSettings["Licensing_Con"].ToString(), "USP_GetEmailsbyLicensetypes", new object[] { lictype,county }).Tables[0];
        }
        public static void GetCertficateJournal(string apid, string desc, string user)
        {
            SqlHelper.ExecuteNonQuery(System.Configuration.ConfigurationManager.AppSettings["Licensing_Con"].ToString(), "USP_CertificateJournal", new object[] { apid, desc, user });
        }
         public static DataTable Getlabels(string sdt,string edt,string ltype,string licno,string cert)
        {
            if (sdt == "")
                sdt = DateTime.Now.ToShortDateString();
            if (edt == "")
                edt = DateTime.Now.ToShortDateString();

            return SqlHelper.ExecuteDataset(System.Configuration.ConfigurationManager.AppSettings["Licensing_Con"].ToString(), "USP_Getlabels2", new object[] { sdt, edt, ltype, licno, cert }).Tables[0];
        }
         public static DataTable GetPDMPDetails()
         {

             return SqlHelper.ExecuteDataset(System.Configuration.ConfigurationManager.AppSettings["Licensing_Con"].ToString(), "USP_GetPDMP").Tables[0];
         }
         public static void Updatecontrolledsubstance(int pid, int status)
         {
             SqlHelper.ExecuteNonQuery(System.Configuration.ConfigurationManager.AppSettings["Licensing_Con"].ToString(), CommandType.Text, "update  tbl_Certifications set status=(case when '"+status+"'=801 then 820 when '"+status+"'=811 then 831 when '"+status+"'=807 then 826 end) where Person_id='" + pid + "' and Cert_Type=816 and Cert_id in (SELECT MAX(Cert_id) FROM tbl_Certifications where Person_id='" + pid + "' and Cert_Type=816 )");
         }

         public static void UpdateUpdateMailorderpermits(int pid, int status)
         {
             SqlHelper.ExecuteNonQuery(System.Configuration.ConfigurationManager.AppSettings["Licensing_Con"].ToString(), CommandType.Text, "update  tbl_Certifications set status=(case when '" + status + "'=801 then 820 when '" + status + "'=811 then 831 when '" + status + "'=807 then 826 end) where Person_id='" + pid + "' and Cert_Type=1043 and Cert_id in (SELECT MAX(Cert_id) FROM tbl_Certifications where Person_id='" + pid + "' and Cert_Type=1043 )");
         }
        public static void Insertmailored(string pid, string status, string sdt, string edt,string notnew,string createdby)
        {
            SqlHelper.ExecuteNonQuery(System.Configuration.ConfigurationManager.AppSettings["Licensing_Con"].ToString(), "USP_insertMailord", new object[]{pid,status,sdt,edt,notnew,createdby});
            
        }
        public static void UpdateMailorder(int mailid,string status,string effectivedate,string expirydate,string modifyby,string modifydate)
        {
            SqlHelper.ExecuteNonQuery(System.Configuration.ConfigurationManager.AppSettings["Licensing_Con"].ToString(), CommandType.Text, "update tbl_Certifications set status='" + status + "',Effective_dt='" + effectivedate + "',Expiry_dt='" + expirydate + "',modifiedby='" + modifyby + "',modifieddt='" + modifydate + "' where Cert_id='" + mailid + "'");
        }
        public static void updateprints(string sleids)
        {
            SqlHelper.ExecuteNonQuery(System.Configuration.ConfigurationManager.AppSettings["Licensing_Con"].ToString(), CommandType.Text, "update tbl_Batch_Prints set Is_Print=1 where Is_Print=0 and App_ID in (" + sleids+")");
        }
        public static DataSet Getprintid()
        {
            return SqlHelper.ExecuteDataset(System.Configuration.ConfigurationManager.AppSettings["Licensing_Con"].ToString(), CommandType.Text, "select * from tbl_Auto_Data");
        }

        public static DataSet GetSupervisorStartDate(int contactid)
        {
            return SqlHelper.ExecuteDataset(System.Configuration.ConfigurationManager.AppSettings["Licensing_Con"].ToString(), CommandType.Text, "select Start_dt,End_dt,Comments,Percentage,Contact_type from tbl_Person_contacts where contact_id=" + contactid);
        }
        public static DataSet GetDocumentPath(string cmpid)
        {
            return SqlHelper.ExecuteDataset(System.Configuration.ConfigurationManager.AppSettings["Licensing_Con"].ToString(), CommandType.Text, "select * from tbl_Person_Document_Details where DocType=1137 and cmpd=" + cmpid);
        }

        public static DataSet GetContacttype(int contactid)
        {
            return SqlHelper.ExecuteDataset(System.Configuration.ConfigurationManager.AppSettings["Licensing_Con"].ToString(), CommandType.Text, "select * from tbl_Person_contacts where contact_id=" + contactid);
        }
        public static void UpdateSupervisorStartdate(int contactid, DateTime startdate, DateTime enddate, string comment, string modifyby, string contactype)
        {
            SqlHelper.ExecuteNonQuery(System.Configuration.ConfigurationManager.AppSettings["Licensing_Con"].ToString(), CommandType.Text, "update  tbl_Person_contacts set Start_dt='" + startdate + "',End_dt='" + enddate + "',Comments='" + comment + "',Modifiedby='" + modifyby + "',Modifieddt='" + Convert.ToDateTime(DateTime.Now.ToShortDateString()) + "' where contact_id=" + contactid + " and Contact_type=" + contactype);
        }
        public static void UpdateContactComment(int contactid, string comments, string modifyby, string contactype, string percntge)
        {

            SqlHelper.ExecuteNonQuery(System.Configuration.ConfigurationManager.AppSettings["Licensing_Con"].ToString(), CommandType.Text, "update tbl_Person_contacts set Comments='" + comments.Replace("'","`") + "',Modifiedby='" + modifyby + "',Modifieddt='" + Convert.ToDateTime(DateTime.Now.ToShortDateString()) + "',Percentage='" + percntge + "'where contact_id='" + contactid + "' and Contact_type='" + contactype + "'");
        }
        public static void InsertPersonRespApplication(int appid, string personresp)
        {
            SqlHelper.ExecuteNonQuery(System.Configuration.ConfigurationManager.AppSettings["Licensing_Con"].ToString(), CommandType.Text, "update tbl_application set Person_Responsible='" + personresp + "' where App_ID=" + appid);
        }
        public static TBL_Licensing_Education EditEducation(int empid)
        {
            return Person_Details.Licensing_Details.Edit_Education(Convert.ToInt32(empid));
        }
        #region Exam Edit Code
        public static tbl_examdetail EditExam(int examid)
        {
            return Person_Details.Licensing_Details.Edit_ExamData(Convert.ToInt32(examid));

        }


        #endregion
        public static tbl_Certification EditCertification(int certid)
        {
            return Person_Details.Licensing_Details.Edit_Certifications(Convert.ToInt32(certid));
        }

        public static List<USP_getpendingapplicationsResult> Getpending_applications(string pid)
        {
           return  Person_Details.Licensing_Details.Getpending(pid);
        }
        public static List<License_Data.USP_Get_LicrenewalsResult> Getlicrenewals(string licid)
        {
            using (License_Data.License_ConnectionDataContext ldb = new License_Data.License_ConnectionDataContext())
            {
                return ldb.USP_Get_Licrenewals(licid).ToList();
            }
        }
        public static List<License_Data.USP_GetexamdetailsResult> GetExamDetails(string pid)
        {
            using (License_Data.License_ConnectionDataContext db = new License_Data.License_ConnectionDataContext())
            {
                return db.USP_Getexamdetails(pid).ToList();
            }
        }
        public static List<License_Data.USP_GetpharmacyempResult> GetHasPharmacy(int pid)
        {
            using (License_Data.License_ConnectionDataContext db = new License_Data.License_ConnectionDataContext())
            {
                return db.USP_Getpharmacyemp(pid).ToList();
            }
        }
        public static List<License_Data.USP_GetcontactsResult> GetContacts(int objid, int pid)
        {
            using (License_Data.License_ConnectionDataContext db = new License_Data.License_ConnectionDataContext())
            {
                return db.USP_Getcontacts(objid, pid).ToList();
            }
        }
        public static List<License_Data.USP_GetotherstatelicenseResult> Getotherstatelic(string pid)
        {
            using (License_Data.License_ConnectionDataContext db = new License_Data.License_ConnectionDataContext())
            {
                return db.USP_Getotherstatelicense(pid).ToList();
            }
        }
        public static List<License_Data.USP_Getcertifications_substancesResult> Getcontrolledsubstances(string pid)
        {
            using (License_Data.License_ConnectionDataContext db = new License_Data.License_ConnectionDataContext())
            {
                return db.USP_Getcertifications_substances(pid).ToList();
            }
        }
        public static List<License_Data.USP_Getcertifications_MailorderResult> GetMailOrders(string pid)
        {
            using (License_Data.License_ConnectionDataContext db = new License_Data.License_ConnectionDataContext())
            {
                return db.USP_Getcertifications_Mailorder(pid).ToList();
            }
        }
        public static List<License_Data.USP_GetcertificationsResult> Getcertifications(string pid)
        {
            using (License_Data.License_ConnectionDataContext ldb = new License_Data.License_ConnectionDataContext())
            {
                return ldb.USP_Getcertifications(pid).ToList();
            }
        }
        public static tbl_Certification EditControlled_Substances(string cerid)
        {
            return Person_Details.Licensing_Details.Edit_Controlled_Substances(Convert.ToInt32(cerid));
        }



        public static void Updatedocumentspeciality(int docid, string doctype, string date)
        {
            SqlHelper.ExecuteNonQuery(System.Configuration.ConfigurationManager.AppSettings["Licensing_Con"].ToString(), CommandType.Text, "update tbl_Speciality_Document_Details set DocType='" + doctype + "',Document_Date='" + date + "'  where Document_ID=" + docid);
        }

        public static int Save_Controlled_Substances(int cerid, int pid, string certtype, string status1,  string effectdate, string expdate, string createdby, string createddate, string modifiedby, string modifieddate,int appid)
        {
            return Person_Details.Licensing_Details.Controlled_Substances(Convert.ToInt32(cerid), Convert.ToInt32(pid), certtype, status1, effectdate, expdate, createdby, createddate, modifiedby, modifieddate, appid);


        }

        public static void DeleteControlled_Substances(string cerid)
        {

            Person_Details.Licensing_Details.Delete_Controlled_Substances(Convert.ToInt32(cerid));

        }
        public static void BindInspectionStatus(DropDownList ddlins)
        {
            ddlins.DataSource = Person_Details.Licensing_Details.Get_InspectionStatus();
            ddlins.DataValueField = "Inspection_StatusID";
            ddlins.DataTextField = "Status";
            ddlins.DataBind();
            ddlins.Items.Insert(0, new ListItem("Select Status", "-1"));
        }
        public static void BindPrintpages(DropDownList ddlprintpages)
        {
            using (Person_Details.Person_LicenseDataContext pldc = new Person_LicenseDataContext())
            {
                ddlprintpages.DataSource = (from ac in pldc.tbl_lkp_Licenses
                                            join pl in pldc.tbl_Auto_Datas on ac.LicenseType_ID equals pl.LicenseType_ID
                                            select new { ac.LicenseType_ID, pl.Print_ID }).ToList();
                ddlprintpages.DataValueField = "LicenseType_ID";
                ddlprintpages.DataTextField = "Print_ID";
                ddlprintpages.DataBind();
            }
        }
        public static void BindDropdown(DropDownList ddlstate, int IdNum)
        {
            List<tbl_lkp_data> lst = Person_Details.Licensing_Details.Get_Lkp_tablesdata(IdNum).Where(c=>c.Lkp_data_ID != 539).ToList();
            if (IdNum == 41 || IdNum == 57 || IdNum == 58)
            {
                lst = lst.Where(c => c.Values.StartsWith("Correspondence") == false && c.Values.StartsWith("Entity") == false && c.Values.StartsWith("History") == false && c.Values.Contains("(Document)") == false && c.Values.Contains("(Forms)") == false).ToList();
            }
            if (IdNum == 10)
            {
                lst = lst.OrderByDescending(c => c.Lkp_data_ID == 1052).ToList();
            }
            ddlstate.DataSource = lst;
            ddlstate.DataValueField = "Lkp_data_ID";
            ddlstate.DataTextField = "Values";
            ddlstate.DataBind();
            ddlstate.Items.Insert(0, new ListItem("Select", "-1"));

        }
        public static void BindCheckboxlist(CheckBoxList chk,int idnum)
        {
            chk.DataSource = Person_Details.Licensing_Details.Get_Lkp_tablesdata(idnum);
            chk.DataValueField = "Lkp_data_ID";
            chk.DataTextField = "Values";
            chk.DataBind();
        }
        public static void BindCheckboxlist1(CheckBoxList chk, int idnum)
        {
            chk.DataSource = Person_Details.Licensing_Details.Get_Lkp_tablesdata1(idnum);
            chk.DataValueField = "Lkp_data_ID";
            chk.DataTextField = "Values";
            chk.DataBind();
        }
        public static void BindDropdownForCRCandHearing(DropDownList ddlstate, int IdNum, int type)
        {
            List<tbl_lkp_data> lst = Person_Details.Licensing_Details.Get_Lkp_tablesdata(IdNum);
            if (type == 1)
                lst = lst.Where(c => c.Lkp_data_ID.Equals(1391) || c.Lkp_data_ID.Equals(1392) || c.Lkp_data_ID.Equals(1393) || c.Lkp_data_ID.Equals(1394) || c.Lkp_data_ID.Equals(1395) || c.Lkp_data_ID.Equals(1396) || c.Lkp_data_ID.Equals(1439)).ToList();
            else if (type == 2)
                lst = lst.Where(c => c.Lkp_data_ID > 1396).ToList();
            ddlstate.DataSource = lst;
            ddlstate.DataValueField = "Lkp_data_ID";
            ddlstate.DataTextField = "Values";
            ddlstate.DataBind();
            ddlstate.Items.Insert(0, new ListItem("Select", "-1"));

        }
        public static void BindStatusChange(DropDownList ddlstatus)
        {
            ddlstatus.DataSource = Person_Details.Licensing_Details.Fill_Dropdown();
            ddlstatus.DataValueField = "Lic_Status_reason_id";
            ddlstatus.DataTextField = "Description";
            ddlstatus.DataBind();
            ddlstatus.Items.Insert(0, new ListItem("Select Reason", "-1"));
        }
        public static void Bind_LicenseTypes(DropDownList ddllicense)
        {
            ddllicense.DataSource = Person_Details.Licensing_Details.Get_License();
            ddllicense.DataValueField = "LicenseType_ID";
            ddllicense.DataTextField = "License_Type";
            ddllicense.DataBind();
            
        }
        public static void Bind_LicenseTypes_individual(DropDownList ddllicense)
        {
            ddllicense.DataSource = Person_Details.Licensing_Details.Get_License().Where(c=>c.LicenseType_ID ==1 || c.LicenseType_ID==2 || c.LicenseType_ID==3);
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
        public static void BindLicenseTypeByPersonID(CheckBoxList chkltype, int idnum)
        {
            chkltype.DataSource = Person_Details.Licensing_Details.BindLicensetype(idnum);
            chkltype.DataValueField = "App_ID";
            chkltype.DataTextField = "License_Type";
            chkltype.DataBind();
        }
        public static DataSet Getweek_days(string sdt, string edt, string empid)
        {
            DataSet ds = SqlHelper.ExecuteDataset(System.Configuration.ConfigurationSettings.AppSettings["Licensing_Con"].ToString(), "USP_Getdaysbyweek", new object[] { sdt, edt, empid });
            return ds;
        }
        public static DataSet Getweeks(string loginid)
        {
            DataSet ds = SqlHelper.ExecuteDataset(System.Configuration.ConfigurationSettings.AppSettings["Licensing_Con"].ToString(), "USP_Getweeksbyuser", new object[] { loginid });
            return ds;
        }
        public static void Fill_Dropdown(System.Web.UI.WebControls.DropDownList ddl, string Table_name, string Disp_col, string Val_col,string Condition, string Default)
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
        public static DataTable Get_Values1(string Table_name, string cols, string Condition)
        {
            SqlConnection uti_con1 = new SqlConnection(System.Configuration.ConfigurationSettings.AppSettings["Licensing_Con"].ToString());
            try
            {
                object[] obj = { Table_name, cols, Condition };
                SqlCommand cmd = new SqlCommand("USP_GetValues", uti_con1);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@tname", SqlDbType.VarChar).Value = obj[0];
                cmd.Parameters.Add("@col_name", SqlDbType.NVarChar).Value = obj[1];
                cmd.Parameters.Add("@cond", SqlDbType.VarChar).Value = obj[2];
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataSet ds = new DataSet();
                //SqlHelper.ExecuteDataset(uti_con, "USP_GetValues", obj);
                da.Fill(ds, "temp");
                if (ds.Tables.Count > 0)
                    return ds.Tables[0];
                else
                    return null;
            }
            catch
            {
                return null;
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
            finally
            {
                uti_con.Close();
            }
        }

        #region  Inspection Journal

        public static tbl_Inspection_JournalDetail EditInspection_JournalDetails(string journalid)
        {
            return Person_Details.Licensing_Details.Edit_Inspection_JournalDetail(Convert.ToInt32(journalid));
        }



        public static int Save_Inspection_JournalDetails(int jornalid, int pid, string journaltype, string comments, string createdby, string createddate, string modifiedby, string modifieddate)
        {
            return Person_Details.Licensing_Details.Inspection_Journal(Convert.ToInt32(jornalid), Convert.ToInt32(pid), journaltype, comments, createdby, createddate, modifiedby, modifieddate);


        }

        public static void DeleteInspection_JournalDetails(string journalid)
        {

            Person_Details.Licensing_Details.Delete_Inspection_JournalDetail(Convert.ToInt32(journalid));

        }

        #endregion
       
        public static List<USP_GetLicenseinfobypersonidResult> Get_Person_licenseInfo(string pid)
        {
         return Person_Details.Licensing_Details.Get_Person_licenseInfo(pid);
        }

        public static void getchecklistitems(GridView grd, string lname, string fname, string ssn, string dob, string phoneno, string phonetype)
        {
            grd.DataSource = Person_Details.Licensing_Details.Get_Checklistitem(lname, fname, ssn, dob, phoneno, phonetype);
            grd.DataBind();
        }

        #region Employer


        public static int Insert_Person_Detail(int personid, string fname, string mname, string lname, string maidenname, string gender, string dob, string ssn, string age, string address1, string address2, string city, string state, string country, string zip, string phtype, string phone, string altphtype, string altphone, string maritalstatus, string fax, string email, string isuscitizen, string status, string createdby, string createddate, string modifiedby, string modifieddate,string citizenexpdate,string cpe,string ethincity)
        {
            return Person_Details.Licensing_Details.Insert_Values(personid, fname, mname, lname, maidenname, gender, dob, ssn, age, address1, address2, city, state, country, zip, phtype, phone, altphtype, altphone, maritalstatus, fax, email, isuscitizen, status, createdby, createddate, modifiedby, modifieddate, citizenexpdate,cpe,ethincity);
        }
        public static int Insert_Business_Details(int personid,string bname, string oname, string datestarted,string btype ,string fein, string address1, string address2, string city, string state, string country, string zip, string phtype, string phone, string altphtype, string altphone, string fax, string email,string dea ,string status, string createdby, string createddate, string modifiedby, string modifieddate)
        {
            return Person_Details.Licensing_Details.Insert_Business_Values(personid,bname,oname,datestarted,btype,fein,address1,address2,city,state,country,zip,phtype,phone,altphtype,altphone,fax,email,dea,status,createdby,createddate,modifiedby,modifieddate);
        }
        public static void BindGridEmployer(GridView grd,int personid)
        {

            grd.DataSource = Person_Details.Licensing_Details.BindGrid_Employer(personid);
            grd.DataBind();
        }
        public static TBL_Licensing_Employer EditEmployer(int empid)
        {
            return Person_Details.Licensing_Details.Edit_Employer(Convert.ToInt32(empid));

        }
       
        public static tbl_Person_Document_Detail EditDocument(int empid)
        {
            return Person_Details.Licensing_Details.Edit_Document(Convert.ToInt32(empid));
        }
        public static tbl_Licensing_Journal_Detail EditJournal(int empid)
        {
            return Person_Details.Licensing_Details.Edit_Journal(Convert.ToInt32(empid));
        }
      

        public static void BindLicType(DropDownList ddlusertype, int idnum)
        {
            ddlusertype.DataSource = Person_Details.Licensing_Details.BindLicensetype(idnum);
            ddlusertype.DataValueField = "App_ID";
            ddlusertype.DataTextField = "License_Type";
            ddlusertype.DataBind();
            ddlusertype.Items.Insert(0, new ListItem("Select License Type", "-1"));
        }
        public static void BindMaxLicenseType(DropDownList ddlmaxlictype,int idnum)
        {
            ddlmaxlictype.DataSource = Person_Details.Licensing_Details.BindMaxLicenseType(idnum);
            ddlmaxlictype.DataValueField = "App_ID";
            ddlmaxlictype.DataTextField = "LicenseType";
            ddlmaxlictype.DataBind();
            ddlmaxlictype.Items.Insert(0, new ListItem("Select License Type", "-1"));
        }
        public static void BindSubobjvalues(DropDownList ddlfee,string pid)
        {
            int revobjid = 1;
            using (Person_Details.Person_LicenseDataContext ldb = new Person_Details.Person_LicenseDataContext())
            {
                tbl_PersonDetail per = ldb.tbl_PersonDetails.Where(c => c.Person_ID ==Convert.ToInt32( pid)).SingleOrDefault();
                if (per.object_type != 1)
                    revobjid = 2;
            }
            if(revobjid==1)
            ddlfee.DataSource = Person_Details.Licensing_Details.Get_subobjValues().Where(c=>c.Rev_obj_Id==1);
            else
                ddlfee.DataSource = Person_Details.Licensing_Details.Get_subobjValues().Where(c => c.Rev_obj_Id == 2);
            ddlfee.DataValueField = "Subobj_Id";
            ddlfee.DataTextField = "Description";
            ddlfee.DataBind();
            ddlfee.Items.Insert(0, new ListItem("Select Fee Type", "-1"));
        }
        public static void BindGridEducation(GridView grd, int personid)
        {

            grd.DataSource = Person_Details.Licensing_Details.GetEducation(personid);
            grd.DataBind();
        }
        public static tbl_lkp_subobj Feeamount_RetriveAmountSubOrg(int subobjid)
        {
            return Person_Details.Licensing_Details.FeeAmountofSubobj(Convert.ToInt32(subobjid));
        }
        #endregion

        public static List<Pending_application> getpendingapplications(int pid)
        {
            using (Person_LicenseDataContext db = new Person_LicenseDataContext())
            {
                return (from app in db.tbl_Applications
                        join lc in db.tbl_lkp_Licenses on Convert.ToInt32(app.License_Type_ID) equals lc.LicenseType_ID
                        where app.Person_ID == pid && app.App_Status == "511"
                        select new Pending_application() { License_Type = lc.License_Type, App_ID = app.App_ID }).ToList();


                //   return db.tbl_Applications.Where(c => c.Person_ID == pid && c.App_Status == "511").ToList();
            }
        }
        public static List<BusinessName> GetPersonandBusiness(string relationid, int contacttype)
        {
            using (Person_LicenseDataContext pdb = new Person_LicenseDataContext())
            {
                var name = from person in pdb.tbl_PersonDetails
                           join license in pdb.tbl_licenses on person.Person_ID equals license.Person_ID
                           join contact in pdb.tbl_Person_contacts on person.Person_ID equals Convert.ToInt32(contact.Person_Id)
                           where contact.Relt_id == relationid && contact.Contact_type == contacttype && contact.Status == "Current"
                           select new BusinessName() { busin = person.Business, licno = license.Lic_no };
                return name.ToList();
            }
        }
        public static List<BusinessName> GetPersonandBusinessLicense(string relationid)
        {
            using (Person_LicenseDataContext pdb = new Person_LicenseDataContext())
            {
                var licensestatus = from person in pdb.tbl_PersonDetails
                                    join license in pdb.tbl_licenses on person.Person_ID equals license.Person_ID
                                    where license.Person_ID == Convert.ToInt32(relationid)
                                    select new BusinessName() { licstatus = license.Lic_status };
                return licensestatus.ToList();
            }
        }
        public static void update_checkitems(int applicchkid, int appid, string licensechecklistid, string result)
        {
            using (Person_LicenseDataContext db = new Person_LicenseDataContext())
            {
                var query = from ac in db.TBL_Licensing_Application_Checklists where ac.App_checklist_ID == applicchkid select ac;
                foreach (TBL_Licensing_Application_Checklist ac in query)
                {
                    ac.App_ID = appid;
                    ac.License_checklist_ID = Convert.ToInt32(licensechecklistid);
                    ac.Result = result;
                    ac.Change_Date = Convert.ToDateTime(DateTime.Now.ToShortDateString());
                }
                db.SubmitChanges();
            }
        }
        public static void Update_Haspharmacystatus(int hasid)
        {
            using (Person_LicenseDataContext pd = new Person_LicenseDataContext())
            {
                var query = from ac in pd.tbl_has_pharmacyemps where ac.has_emp_id == hasid select ac;
                foreach (tbl_has_pharmacyemp ac in query)
                {
                    ac.Status = "Previous";
                    ac.Modifiedby = HttpContext.Current.Session["UID"].ToString();
                    ac.Modifieddt = Convert.ToDateTime(DateTime.Now.ToShortDateString());
                }
                pd.SubmitChanges();
            }
        }
        public static void Update_Haspharmacystatus(int hasid,string uid)
        {
            using (Person_LicenseDataContext pd = new Person_LicenseDataContext())
            {
                var query = from ac in pd.tbl_has_pharmacyemps where ac.has_emp_id == hasid select ac;
                foreach (tbl_has_pharmacyemp ac in query)
                {
                    ac.Status = "Previous";
                    ac.Modifiedby = uid;
                    ac.Modifieddt = Convert.ToDateTime(DateTime.Now.ToShortDateString());
                }
                pd.SubmitChanges();
            }
        }
        public static void Update_ContactStatus(int contactid)
        {
            using (Person_LicenseDataContext pd = new Person_LicenseDataContext())
            {
                var query = from ac in pd.tbl_Person_contacts where ac.contact_id == contactid select ac;
                foreach (tbl_Person_contact ac in query)
                {
                    ac.Status = "Terminated";
                    ac.End_dt = DateTime.Now;
                    ac.Modifiedby = HttpContext.Current.Session["UID"].ToString();
                    ac.Modifieddt = Convert.ToDateTime(DateTime.Now.ToShortDateString());
                }
                pd.SubmitChanges();
            }
        }
        public class Pending_application
        {
            public string License_Type { get; set; }
            public int App_ID { get; set; }
        }
        public static List<ChecklistPending> Get_checklistitems(int app_id)
        {
            using (Person_LicenseDataContext db  = new Person_LicenseDataContext())
            {
                var resuts = from ac in db.TBL_Licensing_Application_Checklists
                             join lchk in db.tbl_lkp_LicenseCheckLists on Convert.ToInt32(ac.License_checklist_ID) equals lchk.License_CheckList_ID
                             join chk in db.tbl_lkp_datas on Convert.ToInt32(lchk.CheckList_ID) equals chk.Lkp_data_ID
                             where ac.App_ID == app_id
                             select new ChecklistPending() { app_chk_id = ac.App_checklist_ID, License_checklist_id = Convert.ToInt32(ac.License_checklist_ID), Checklistitem = chk.Values, Isrequired = lchk.Is_Mandatory, Result = ac.Result };
                return resuts.ToList();
            }
        }
          public static Boolean Checklicenseexxists(string licno, string perid)
        {
             string query = "select count(*) from tbl_license where Person_ID!=" + perid + " and  Lic_no='" + licno + "' ";
            object obj= SqlHelper.ExecuteScalar(System.Configuration.ConfigurationSettings.AppSettings["Licensing_Con"].ToString(), CommandType.Text, query);
               if (Convert.ToInt32(obj) == 0)
                return true;
             else
                return false;
        }
          public class ChecklistPending
          {
              public int app_chk_id { get; set; }

              public int License_checklist_id { get; set; }
              public string Checklistitem { get; set; }
              public string Isrequired { get; set; }
              public string Result { get; set; }
          }
          public class BusinessName
          {
              public string busin { get; set; }
            public string licstatus { get; set; }

            public string licno { get; set; }
          }
    }
}