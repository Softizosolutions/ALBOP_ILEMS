using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AdminLinq
{
   public class Admin
    {
        #region Monthly Board Update
        public static List<tbl_monthlyboardupdate> Getmonthlyupdate()
        {
            using (AdminDataContext db = new AdminLinq.AdminDataContext())
            {
                return db.tbl_monthlyboardupdates.ToList();
            }
        }
        public static void Insert_monthlyupdate(string firstname, string lastname, string email)
        {
            using (AdminDataContext db = new AdminLinq.AdminDataContext())
            {
                tbl_monthlyboardupdate obj = new AdminLinq.tbl_monthlyboardupdate();
                obj.FirstName = firstname;
                obj.LastName = lastname;
                obj.Email = email;
                obj.Submission = DateTime.Now;
                db.tbl_monthlyboardupdates.InsertOnSubmit(obj);
                db.SubmitChanges();
            }
        }
        public static void Deletemonthlyupdate(int auid)
        {
            using (AdminDataContext db = new AdminLinq.AdminDataContext())
            {
                tbl_monthlyboardupdate obj = db.tbl_monthlyboardupdates.Where(c => c.auid == auid).FirstOrDefault();
                
                db.tbl_monthlyboardupdates.DeleteOnSubmit(obj);
                db.SubmitChanges();
            }
        }
        #endregion


        public static string Getemail(string uid)
       {
           using (AdminDataContext adb = new AdminDataContext())
           {
               Tbl_Login obj = adb.Tbl_Logins.Where(c => c.loginID == Convert.ToInt32(uid)).SingleOrDefault();
               if (obj != null)
                   if (obj.Email != "")
                       return obj.Email;

               return "";
           }
       }
       public static List<Tbl_Login> BindGrid_ManageUsers()
        {
            

            using (AdminDataContext db = new AdminDataContext())
            {
                return db.Tbl_Logins.ToList();

            
            }
        }


       public static Tbl_Login Edit_ManageUsers(int userid)
        {
            using (AdminDataContext db = new AdminDataContext())
            {
                return db.Tbl_Logins.Where(c => c.loginID == userid).SingleOrDefault();
            }
        }

        //public static int Insertion_ManageUsers(int userid, string fname, string lname, string middlename, string suffix, string isstatus, string isadmin, string Email, string username, string password, string ExpiryDate, string LastLogin, string isTemp, string Usertype)
        //{
        //    using (AdminDataContext manageusers = new AdminDataContext())
        //    {
        //        Tbl_User users;
        //        if (userid == 0)
        //            users = new Tbl_User();
        //        else
        //            users = manageusers.Tbl_Users.Where(c => c.User_ID == userid).SingleOrDefault();

        //        users.User_ID = userid;
        //        users.FirstName = fname;
        //        users.LastName = lname;
        //        users.MiddleName = middlename;
        //        users.Suffix = suffix;
        //        users.isstatus = isstatus;
        //        users.isadmin = isadmin;
        //        users.Email = Email;
        //        users.UserName = username;

        //        users.Password = password;
        //        users.ExpireDate = ExpiryDate;
        //        users.LastLogin = LastLogin;
        //        users.IsTemp = isTemp;
        //        users.UserType = Usertype;

        //        if (userid == 0)
        //            manageusers.Tbl_Users.InsertOnSubmit(users);
        //        manageusers.SubmitChanges();
        //        return users.User_ID;
        //    }
        //}

       public static int Insertion_ManageUsers(int userid, string fname, string lname, string middlename, string suffix, string isstatus, string isadmin, string Email, string username, string password, string ExpiryDate, string LastLogin, string isTemp, int Usertype)
       {
           using (AdminDataContext manageusers = new AdminDataContext())
           {
               Tbl_Login users;
               if (userid == 0)
                   users = new Tbl_Login();
               else
                   users = manageusers.Tbl_Logins.Where(c => c.loginID == userid).SingleOrDefault();

               users.loginID = userid;
               users.FirstName = fname;
               users.LastName = lname;
               users.MiddleName = middlename;
               users.Suffix = suffix;
               users.isstatus = isstatus;
               users.isadmin = isadmin;
               users.Email = Email;
               users.UserName = username;

               users.Password = password;
               users.ExpireDate = Convert.ToDateTime( ExpiryDate);
               users.LastLogin = LastLogin;
               users.IsTemp = isTemp;
               users.UserType = Usertype;

               if (userid == 0)
                   manageusers.Tbl_Logins.InsertOnSubmit(users);
               manageusers.SubmitChanges();
               return users.loginID;
           }
       }



        

        public static List<AdminLinq.tbl_lkp_License> Bind_LicenseLookupData()
        {
            AdminLinq.AdminDataContext pdb = new AdminLinq.AdminDataContext();
            return pdb.tbl_lkp_Licenses.OrderBy(c=>c.License_Type).ToList();


        }
        public static void Delete_LicenseLookupData(int lkpid)
        {
            AdminLinq.AdminDataContext pdb = new AdminLinq.AdminDataContext();
            AdminLinq.tbl_lkp_License obj = pdb.tbl_lkp_Licenses.Where(c => c.LicenseType_ID == lkpid).SingleOrDefault();
            pdb.tbl_lkp_Licenses.DeleteOnSubmit(obj);
            pdb.SubmitChanges();

        }


        public static int Insertion_LicenseLookup(int licid, string lictype, string licformat, string linkedlictype, string Exptype, string NumberforExp, string ExpDay, string ExpMonth, string Renewalstartday, string Renewalstartmonth, string RenewalEndDay, string RenewalEndMonth, string LicFee, string RenewalFee, string ReinstateFee, string LateRenewalFee, string isparentMust)
        {
          
            using (  AdminLinq.AdminDataContext pdetalinsert = new   AdminLinq.AdminDataContext())
            {
                tbl_lkp_License LicData;
                if (licid == 0)
                    LicData = new tbl_lkp_License();
                else
                    LicData = pdetalinsert.tbl_lkp_Licenses.Where(c => c.LicenseType_ID == licid).SingleOrDefault();

                LicData.LicenseType_ID = licid;
                LicData.License_Type = lictype;
                LicData.License_Format = licformat;
                LicData.Linked_LicenseType = linkedlictype;
                LicData.ExpType = Exptype;
                LicData.Numberfor_Exp = NumberforExp;
                LicData.Exp_Day = ExpDay;
                LicData.Exp_Month = ExpMonth;
                LicData.Renewal_Start_Day = Renewalstartday;
                LicData.Renewal_Start_Month = Renewalstartmonth;
                LicData.Renewal_End_Day = RenewalEndDay;
                LicData.Renewal_End_Month = RenewalEndMonth;
                LicData.License_Fee = LicFee;
                LicData.Renewal_Fee = RenewalFee;
                LicData.Reinstate_Fee = ReinstateFee;
                LicData.Late_Renewal_Fee = LateRenewalFee;
                LicData.Is_ParentLicmust = isparentMust;


                if (licid == 0)
                    pdetalinsert.tbl_lkp_Licenses.InsertOnSubmit(LicData);
                pdetalinsert.SubmitChanges();
                return LicData.LicenseType_ID;
            }
        }



        public static List<AdminLinq.tbl_lkp_LicenseCheckList> Bind_licenseCheckList(string licid, string action)
        {


            using (AdminDataContext pdb = new AdminDataContext())
            {

                return pdb.tbl_lkp_LicenseCheckLists.Where(c => c.License_Type_ID == licid).ToList();
            }
         


        }

        public static tbl_lkp_LicenseCheckList Edit_licChecklist(int licchecklistid)
        {
            using (AdminDataContext db = new AdminDataContext())
            {
                return db.tbl_lkp_LicenseCheckLists.Where(c => c.License_CheckList_ID == licchecklistid).SingleOrDefault();
            }
        }

        public static void Delete_licChecklist(int licchecklistid)
        {
            using (AdminDataContext db = new AdminDataContext())
            {
                tbl_lkp_LicenseCheckList obj = db.tbl_lkp_LicenseCheckLists.Where(c => c.License_CheckList_ID == licchecklistid).SingleOrDefault();
                db.tbl_lkp_LicenseCheckLists.DeleteOnSubmit(obj);
                db.SubmitChanges();
            }
        }



        public static int licChecklistInsert_Values(int licchecklistid, string lictype, string action, string checklist, string status, string ismandatory)
        {
            using (AdminDataContext pdetalinsert = new AdminDataContext())
            {
                tbl_lkp_LicenseCheckList checklistdetail;
                if (licchecklistid == 0)
                    checklistdetail = new tbl_lkp_LicenseCheckList();
                else
                    checklistdetail = pdetalinsert.tbl_lkp_LicenseCheckLists.Where(c => c.License_CheckList_ID == licchecklistid).SingleOrDefault();
                checklistdetail.License_CheckList_ID = licchecklistid;
                checklistdetail.License_Type_ID = lictype;
                checklistdetail.Action = action;
                checklistdetail.CheckList_ID = checklist;
                checklistdetail.Status = status;
                checklistdetail.Is_Mandatory = ismandatory;



                if (licchecklistid == 0)
                    pdetalinsert.tbl_lkp_LicenseCheckLists.InsertOnSubmit(checklistdetail);
                pdetalinsert.SubmitChanges();
                return checklistdetail.License_CheckList_ID;
            }
        }



        public static List<USP_Licensing_GetLicenseCheckListResult> getLicChecklist(int LicenseTypeID, int Action)
        {

            using (AdminDataContext pdb = new AdminDataContext())
            {

                return pdb.USP_Licensing_GetLicenseCheckList(LicenseTypeID, Action).ToList();
            }
        }

        #region Login Table
        public static List<Tbl_Login> Get_UserandPassword(string username, string password)
        {
            using (AdminDataContext db = new AdminDataContext())
            {
                return db.Tbl_Logins.Where(c => c.UserName == username && c.Password == password).ToList();
            }
        }
        public static List<Tbl_Login> Get_Username(string username)
        {
            using (AdminDataContext db = new AdminDataContext())
            {
                return db.Tbl_Logins.Where(c => c.UserName == username).ToList();
            }
        }
        public static List<Tbl_Login> Get_Password(int loginid)
        {
            using (AdminDataContext db = new AdminDataContext())
            {
                return db.Tbl_Logins.Where(c => c.loginID == loginid).ToList();
            }
        }
        public static void Update_Password(int loginid, string password)
        {
            using (AdminDataContext db = new AdminDataContext())
            {
                var query = from ac in db.Tbl_Logins where ac.loginID == loginid select ac;
                foreach (Tbl_Login ac in query)
                {
                    ac.Password = password;
                    ac.IsTemp = "0";
                }
                db.SubmitChanges();
            }
        }
        #endregion



    }
}
