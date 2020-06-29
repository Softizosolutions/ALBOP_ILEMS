using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OperationsLink
{
    public class Operations
    {

        public static List<tbl_Add_Log> Get_Lkp_tables()
        {
            using (OperationsDataContext db = new OperationsDataContext())
            {
                return db.tbl_Add_Logs.ToList();
            }
        }

        public static List<tbl_lkp_subobj> Get_Lkp_subobj()
        {
            using (OperationsDataContext db = new OperationsDataContext())
            {
                return db.tbl_lkp_subobjs.OrderBy(c => c.Description).ToList();
            }
        }

        public static List<Tbl_Login> Get_Lkp_Loginobj()
        {
            using (OperationsDataContext db = new OperationsDataContext())
            {
                return db.Tbl_Logins.OrderBy(c=>c.FirstName).ToList();
            }
        }
        public static void OperationsInsertValues(tbl_Add_Log  AddLog,string uname)
        {
            using (OperationsDataContext dbInsert = new OperationsDataContext())
            {
                
                dbInsert.USP_OperationsAddlog(101,Convert.ToInt32( AddLog.Add_log_ID), AddLog.Date_Received.ToString(), AddLog.From_Received, AddLog.SSN, AddLog.Forward_To, AddLog.MailClerk, AddLog.SpecialEntries, AddLog.PaymentType, AddLog.Amount.ToString(), AddLog.CheckNumber,AddLog.Walkin, AddLog.Feetype,uname);
                dbInsert.SubmitChanges();
            }
        }

        public static void OperationsUpdateValues(tbl_Add_Log AddLog,string uname)
        {
            using (OperationsDataContext dbUpdate = new OperationsDataContext())
            {

                dbUpdate.USP_OperationsAddlog(102, Convert.ToInt32(AddLog.Add_log_ID), AddLog.Date_Received.ToString(), AddLog.From_Received, AddLog.SSN, AddLog.Forward_To, AddLog.MailClerk, AddLog.SpecialEntries, AddLog.PaymentType, AddLog.Amount.ToString(), AddLog.CheckNumber, AddLog.Walkin, AddLog.Feetype,uname);
                dbUpdate.SubmitChanges();
            }
        }

        public static tbl_Add_Log Edit_ManageLogs(int logid)
        {
            using (OperationsDataContext db = new OperationsDataContext())
            {
                return db.tbl_Add_Logs.Where(c => c.Add_log_ID == logid).SingleOrDefault();
            }
        }




        public static List<Usp_Operations_get_addlogResult> GetLogSearchData(string date, string fromdate,string frwd, string mailclerk, string walkin, string licno,string checkno)
        {
            using (OperationsDataContext db = new OperationsDataContext())
            {
                return db.Usp_Operations_get_addlog(date, fromdate,frwd, mailclerk, walkin, licno,checkno).ToList();
               
            }
        }

        public static void OperationsDelete(tbl_Add_Log AddLog)
        {
            using (OperationsDataContext dbUpdate = new OperationsDataContext())
            {

                dbUpdate.USP_OperationsAddlog(103, Convert.ToInt32(AddLog.Add_log_ID), null, null, null, null, null, null, null, null, null, null, null,null);
                dbUpdate.SubmitChanges();
            }
        }
        public static List<tbl_lkp_data> Get_Lkp_tablesdata(int tbllkpid)
        {
            using (OperationsDataContext db = new OperationsDataContext())
            {
                return db.tbl_lkp_datas.Where(c => c.Lkp_tbl_ID == tbllkpid).OrderBy(c=>c.Values).ToList();
            }
        }

        public static List<Usp_Operations_getDataResult> GetData()
        {
            using (OperationsDataContext db = new OperationsDataContext())
            {
                return db.Usp_Operations_getData().ToList();

            }
        }


    }

}
