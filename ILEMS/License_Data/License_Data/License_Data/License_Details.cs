using System;
using System.Collections;
using System.Configuration;
using System.Data;

using System.Linq;
using System.Web;
//using System.Web.Security;
//using System.Web.UI;
//using System.Web.UI.HtmlControls;
//using System.Web.UI.WebControls;
//using System.Web.UI.WebControls.WebParts;
using System.Text;
using System.Collections.Generic;
using System.Data.SqlClient;

namespace License_Data
{
   public static class License_Details
    {
      public static void Save_dispinfo(int dispid,string pid, string cmpno, string sdt, string edt, string comments, string isdisp, string crtby, string crtdt)
       {
           using (License_ConnectionDataContext ldb = new License_ConnectionDataContext())
           {
               tbl_DisciplineInfo obj = new tbl_DisciplineInfo();
               if (dispid != 0)
                   obj = ldb.tbl_DisciplineInfos.Where(c => c.Disp_Info_ID == dispid).SingleOrDefault();
               obj.Complaint_Number = cmpno;
               obj.Person_ID = pid;
               if(sdt!="")
               obj.Start_Date = Convert.ToDateTime(sdt);
               if(edt!="")
               obj.End_Date = Convert.ToDateTime(edt);
               obj.Comments = comments;
               obj.IS_Discipline = isdisp;
               if (dispid == 0)
               {
                   obj.CreatedBy = crtby;
                   obj.CreatedDate = Convert.ToDateTime( crtdt);
                   ldb.tbl_DisciplineInfos.InsertOnSubmit(obj);
               }
               else
               {
                   obj.ModifiedBy = crtby;
                   obj.ModifiedDate = Convert.ToDateTime(crtdt);
               }
               ldb.SubmitChanges();
           }
       }
       public static void Delete_dispinfo(int dispid)
       {
           using (License_ConnectionDataContext ldb = new License_ConnectionDataContext())
           {
               tbl_DisciplineInfo obj =  ldb.tbl_DisciplineInfos.Where(c => c.Disp_Info_ID == dispid).SingleOrDefault();
               ldb.tbl_DisciplineInfos.DeleteOnSubmit(obj);
               ldb.SubmitChanges();
           }
       }
       public static List<tbl_DisciplineInfo> GetDispinfo(string pid)
       {
           using (License_ConnectionDataContext ldb = new License_ConnectionDataContext())
           {
               return ldb.tbl_DisciplineInfos.Where(c => c.Person_ID == pid).ToList();
           }
       }

       public static List<USP_GetnamehistoryResult> Getnamehistory(string pid)
       {
           using (License_ConnectionDataContext db = new License_ConnectionDataContext())
           {
               return db.USP_Getnamehistory(pid).ToList();
           }

       }
       public static List<USP_GetaddresshistoryResult> Getaddresshistory(string pid)
       {
           using (License_ConnectionDataContext db = new License_ConnectionDataContext())
           {
               return db.USP_Getaddresshistory(pid).ToList();
           }

       }
        public static List<USP_Licensing_GetFeeDetailsResult> Get_LicFeeDetails(int ApID )
        {
            using (License_ConnectionDataContext db = new License_ConnectionDataContext())
            {
                return db.USP_Licensing_GetFeeDetails(ApID).ToList();
            }

        }
        public static string Create_reinstate(string licid, string crtby)
        {
            using (License_ConnectionDataContext db = new License_ConnectionDataContext())
            {
             USP_Create_reinstelicResult obj=   db.USP_Create_reinstelic(Convert.ToInt32(licid), crtby).SingleOrDefault();
             return obj.Column1.ToString();
            }
        }
        public static List<USP_GetsuperResult> Get_superres(int Pid)
        {
            using (License_ConnectionDataContext db = new License_ConnectionDataContext())
            {
                return db.USP_Getsuper(Pid).ToList();
            }
        }
        public static List<USP_Licensing_GetPayerNameResult> Get_PayerName(int PID)
        {
            using (License_ConnectionDataContext db = new License_ConnectionDataContext())
            {

                return db.USP_Licensing_GetPayerName(PID).ToList();
            }
        }

        public static List<tbl_PersonDetail> Get_PayerName1(int PID)
        {
            using (License_ConnectionDataContext db = new License_ConnectionDataContext())
            {
                return db.tbl_PersonDetails.Where(c => c.Person_ID  ==PID ).ToList();
            }
        }

        public static List<USP_Licensing_AmountOwedDataResult> Get_AmountOwedData(string str)
        {
            using (License_ConnectionDataContext db = new License_ConnectionDataContext())
            {

                return db.USP_Licensing_AmountOwedData(str).ToList();
            }
        }


        public static List<USP_Licensing_GetCheckItemsResult> Get_ChecklistData()
        {
            using (License_ConnectionDataContext db = new License_ConnectionDataContext())
            {

                return db.USP_Licensing_GetCheckItems().ToList();
            }
        }

        public static List<USP_Licensing_GetPersonNew_GetCheckItemsResult> Get_ChecklistDataBySelection(string lastname,string fname,string ssn,string dob,string pres)
        {
            using (License_ConnectionDataContext db = new License_ConnectionDataContext())
            {
                if (dob == "-1")
                {
                    return db.USP_Licensing_GetPersonNew_GetCheckItems(lastname, fname, ssn, "", pres).ToList();
                }
                else
                {
                    return db.USP_Licensing_GetPersonNew_GetCheckItems(lastname, fname, ssn, dob, pres).ToList();
                }
            }
        }

        public static List<USP_Licensing_GetBusinessNew_GetCheckItemsResult> Get_BusinessChecklist(string bname, string oname, string fein, string datestarted, string pnumber, string lictype)
        {
            using (License_ConnectionDataContext db = new License_ConnectionDataContext())
            {
                return db.USP_Licensing_GetBusinessNew_GetCheckItems(bname, oname, fein, datestarted, pnumber, lictype).ToList();
            }
        }

        public static int Delete_Checklist(int appid, string rejectreason)
        {
            using (License_ConnectionDataContext db = new License_ConnectionDataContext())
            {
                return db.USP_Licensing_RemoveApplicationchecklist(appid, rejectreason);

            }
        }

        public static int Edit_Checklist(int appid, int licetypeid)
        {
            using (License_ConnectionDataContext db = new License_ConnectionDataContext())
            {
                return db.USP_Licensing_ChecklistUpdateLicense(appid, licetypeid);

            }
        }

        

        #region EditDemographics
        public static List<tbl_PersonDetail> Get_EditDemographics_Data(int PID)
        {
            using (License_ConnectionDataContext db = new License_ConnectionDataContext())
            {
                return db.tbl_PersonDetails.Where(c => c.Person_ID == PID).ToList();
            }
        }

        public static List<tbl_Buyer> Edit_Buyer(string pid)
        {
            using (License_ConnectionDataContext db = new License_ConnectionDataContext())
            {
                return db.tbl_Buyers.Where(c => c.PersonID == pid).ToList();
            }
        }
        public static List<tbl_Distributor> Edit_Distributor(string pid)
        {
            using (License_ConnectionDataContext db = new License_ConnectionDataContext())
            {
                return db.tbl_Distributors.Where(c => c.PersonID == pid).ToList();
            }
        }
        public static List<tbl_Operation> Edit_Operation(string pid)
        {
            using (License_ConnectionDataContext db = new License_ConnectionDataContext())
            {
                return db.tbl_Operations.Where(c => c.PersonID == pid).ToList();
            }
        }
        public static List<tbl_TypeOperation> Edit_typeoperation(string pid)
        {
            using (License_ConnectionDataContext db = new License_ConnectionDataContext())
            {
                return db.tbl_TypeOperations.Where(c => c.PersonID == pid).ToList();
            }
        }
        public static List<tbl_USP> Edit_usp(string pid)
        {
            using (License_ConnectionDataContext db = new License_ConnectionDataContext())
            {
                return db.tbl_USPs.Where(c => c.PersonID == pid).ToList();
            }
        }
        public static List<tbl_person_law> Get_EditDemographics_PersonLaw(int PID)
        {
            using (License_ConnectionDataContext db = new License_ConnectionDataContext())
            {
                return db.tbl_person_laws.Where(c => c.personID == PID).ToList();
            }
        }

        public static List<tbl_lkp_us> Get_TrueUSList(string value)
        {
            using (License_ConnectionDataContext db = new License_ConnectionDataContext())
            {
                return db.tbl_lkp_us.Where(c => c.isus == true).ToList();
            }
        }
        public static List<tbl_lkp_us> Get_FlaseUSlist(string value)
        {
            using (License_ConnectionDataContext db = new License_ConnectionDataContext())
            {
                return db.tbl_lkp_us.Where(c => c.isus == false).ToList();
            }
        }
        public static USP_GetMailingAddressResult GetMailingAddress(int perid)
        {
            using (License_ConnectionDataContext lcdc = new License_ConnectionDataContext())
            {
                return lcdc.USP_GetMailingAddress(perid).SingleOrDefault();
            }
        }
        #region Person Insertion
        public static int EditDemographicsUpdate(int personid, string fname, string mname, string lname, string maidenname, string gender, string dob ,string ssn, string age, string address1, string address2, string city, string state, string country, string zip, string phtype, string phone, string altphtype, string altphone, string maritalstatus, string fax, string email, string isuscitizen, string status, string createdby, string createddate, string modifiedby, string modifieddate)
        {
            using (License_ConnectionDataContext pdetalinsert = new License_ConnectionDataContext())
            {
                tbl_PersonDetail persondetail;
                if (personid == 0)
                    persondetail = new tbl_PersonDetail();
                else
                    persondetail = pdetalinsert.tbl_PersonDetails.Where(c => c.Person_ID == personid).SingleOrDefault();
                persondetail.Person_ID = personid;
                persondetail.First_Name = fname;
                persondetail.Middle_Name = mname;
                persondetail.Last_Name = lname;
                persondetail.Madian_Name = maidenname;
                persondetail.Gender = gender;
                persondetail.DOB =Convert.ToDateTime( dob);
                persondetail.SSN = ssn;
                persondetail.Age = age;
                persondetail.Address1 = address1;
                persondetail.Address2 = address2;
                persondetail.City = city;
                persondetail.State = state;
                persondetail.County = country;
                persondetail.Zip = zip;
                persondetail.PhoneType = phtype;
                persondetail.Phone = phone;
                persondetail.Alternate_PhoneType = altphtype;
                persondetail.Alternate_Phone = altphone;
                persondetail.Martial_Status = maritalstatus;
                persondetail.Fax = fax;
                persondetail.Email = email;
                persondetail.IS_US_Citizen = isuscitizen;
                persondetail.Status = status;
                persondetail.Created_By = createdby;
                persondetail.Created_Date =Convert.ToDateTime( createddate);
                persondetail.Modified_By = modifiedby;
                persondetail.Modified_Date =Convert.ToDateTime( modifieddate);

                if (personid == 0)
                    pdetalinsert.tbl_PersonDetails.InsertOnSubmit(persondetail);
                pdetalinsert.SubmitChanges();
                return persondetail.Person_ID;
            }
        }
        #endregion
        #endregion

        #region Edit Demographics  Updation
        public static int Edit_USP(int uspid,string personid, string usp797, string usp795,string usp797date,string usp795date,string createdby)
        {
            using (License_ConnectionDataContext lcdc = new License_ConnectionDataContext())
            {
                tbl_USP usp;
                if (uspid == 0)
                    usp = new tbl_USP();
                else
                    usp = lcdc.tbl_USPs.Where(c => c.USPID == uspid).SingleOrDefault();
                usp.USPID = uspid;
                usp.PersonID = personid;
                usp.USP795 = usp795;
                usp.USP797 = usp797;
                if(usp797date!="")
                usp.Usp797Effective_Date = Convert.ToDateTime(usp797date);
                if(usp795date!="")
                usp.Usp795EffectiveDate = Convert.ToDateTime(usp795date);
                usp.Modifiedby = createdby;
                usp.ModifiedDate = Convert.ToDateTime(DateTime.Now.ToShortDateString());
                if (uspid == 0)
                    lcdc.tbl_USPs.InsertOnSubmit(usp);
                lcdc.SubmitChanges();
                return usp.USPID;
            }
        }
        public static int Edit_Buyers(int buyerid, string personid, string community, string hospital, string otherwhole, string physician, string veternaries, string others, string ifothers, string comments, string createdby)
        {
            using (License_ConnectionDataContext lcdc = new License_ConnectionDataContext())
            {
                tbl_Buyer buyer;
                if (buyerid == 0)
                    buyer = new tbl_Buyer();
                else
                    buyer = lcdc.tbl_Buyers.Where(c => c.BuyersID == buyerid).SingleOrDefault();
                buyer.BuyersID = buyerid;
                buyer.PersonID = personid;
                buyer.CommuntiyPharmacies = community;
                buyer.Hospitals = hospital;
                buyer.OtherWholesalers = otherwhole;
                buyer.Physicians_Or_Practioners = physician;
                buyer.Veterinarians = veternaries;
                buyer.Others = others;
                buyer.If_Others = ifothers;
                buyer.Comments = comments;
                buyer.Modifiedby = createdby;
                buyer.ModifiedDate = Convert.ToDateTime(DateTime.Now.ToShortDateString());
                if (buyerid == 0)
                    lcdc.tbl_Buyers.InsertOnSubmit(buyer);
                lcdc.SubmitChanges();
                return buyer.BuyersID;
            }
        }
        public static int Edit_distributor(int disid, string personid, string contrlsub, string prescription, string overthecounter, string overthecounterspecf, string precoursor, string medicinal, string others, string ifother, string comments, string createdby)
        {
            using (License_ConnectionDataContext lcdc = new License_ConnectionDataContext())
            {
                tbl_Distributor distributor;
                if (disid == 0)
                    distributor = new tbl_Distributor();
                else
                    distributor = lcdc.tbl_Distributors.Where(c => c.DistributedID == disid).SingleOrDefault();
                distributor.DistributedID = disid;
                distributor.PersonID = personid;
                distributor.Controlled_Substances = contrlsub;
                distributor.Prescription_Drugs = prescription;
                distributor.Over_the_Counter_Drugs = overthecounter;
                distributor.Please_Specify_Over_Counter_Drug = overthecounterspecf;
                distributor.Precursors_Chemicals = precoursor;
                distributor.Medicinal_Gases = medicinal;
                distributor.Others = others;
                distributor.IF_Other = ifother;
                distributor.Modifiedby = createdby;
                distributor.ModifiedDate = Convert.ToDateTime(DateTime.Now.ToShortDateString());
                if(disid==0)
                    lcdc.tbl_Distributors.InsertOnSubmit(distributor);
                lcdc.SubmitChanges();
                return distributor.DistributedID;
            }
        }
        public static int Edit_operations(int operationid, string personid, string monfri, string saturday, string sunday, string comments, string createdby)
        {
            using (License_ConnectionDataContext lcdc = new License_ConnectionDataContext())
            {
                tbl_Operation operation;
                if (operationid == 0)
                    operation = new tbl_Operation();
                else
                    operation = lcdc.tbl_Operations.Where(c => c.OperationsID == operationid).SingleOrDefault();
                operation.OperationsID = operationid;
                operation.PersonID = personid;
                operation.Monday_Friday = monfri;
                operation.Saturday = saturday;
                operation.Sunday = sunday;
                operation.Comments = comments;
                operation.Modifiedby = createdby;
                operation.ModifiedDate = Convert.ToDateTime(DateTime.Now.ToShortDateString());
                if (operationid == 0)
                    lcdc.tbl_Operations.InsertOnSubmit(operation);
                lcdc.SubmitChanges();
                return operation.OperationsID;
            }
        }
        public static int Edit_Typeoperations(int typeid, string personid, string fullservice, string manufacture, string repackage, string pharmacistname, string buyinggroup, string importexport, string distrcenter, string virtal, string sterile, string nonsterile, string other, string ifother, string comments, string createdby)
        {
            using (License_ConnectionDataContext lcdc = new License_ConnectionDataContext())
            {
                tbl_TypeOperation typeoperation;
                if (typeid == 0)
                    typeoperation = new tbl_TypeOperation();
                else
                    typeoperation = lcdc.tbl_TypeOperations.Where(c => c.TypeOperationID == typeid).SingleOrDefault();
                typeoperation.TypeOperationID = typeid;
                typeoperation.PersonID = personid;
                typeoperation.Full_Service = fullservice;
                typeoperation.Manufacturer = manufacture;
                typeoperation.Repackager = repackage;
                typeoperation.Pharmacist_Name = pharmacistname;
                typeoperation.Buying_Group = buyinggroup;
                typeoperation.Import_Export = importexport;
                typeoperation.Distribution_Center = distrcenter;
                typeoperation.Virtual = virtal;
                typeoperation.Sterile_Compounding = sterile;
                typeoperation.Non_Sterile = nonsterile;
                typeoperation.Other = other;
                typeoperation.IF_Other = ifother;
                typeoperation.Comments = comments;
                typeoperation.Modifiedby = createdby;
                typeoperation.ModifiedDate = Convert.ToDateTime(DateTime.Now.ToShortDateString());
                if (typeid == 0)
                    lcdc.tbl_TypeOperations.InsertOnSubmit(typeoperation);
                lcdc.SubmitChanges();
                return typeoperation.TypeOperationID;
            }
        }
        public static int Edit_ContactInfo(int personid, string phone, string altphtype, string fax, string email, string modifiedby, string modifieddate)
        {
            using (License_ConnectionDataContext pdetalinsert = new License_ConnectionDataContext())
            {
                tbl_PersonDetail persondetail;
                if (personid == 0)
                    persondetail = new tbl_PersonDetail();
                else
                    persondetail = pdetalinsert.tbl_PersonDetails.Where(c => c.Person_ID == personid).SingleOrDefault();
                if (persondetail.Phone != phone || persondetail.Alternate_PhoneType != altphtype || persondetail.Email!=email)
                {
                    tbl_Contact_History obj = new tbl_Contact_History();
                    obj.Person_ID = personid.ToString();
                    obj.Phone = persondetail.Phone;
                    obj.Alt_Phone = persondetail.Alternate_Phone;
                    obj.Email = persondetail.Email;
                    obj.CreatedBy = persondetail.Created_By;
                    obj.CreatedDate = persondetail.Created_Date;
                    obj.ModifiedBy = modifiedby;
                    obj.ModifiedDate = Convert.ToDateTime(modifieddate);
                    pdetalinsert.tbl_Contact_Histories.InsertOnSubmit(obj);
                }
                persondetail.Person_ID = personid;

                persondetail.Phone = phone;
                persondetail.Alternate_Phone = altphtype;
                persondetail.Fax = fax;
                persondetail.Email = email;
                persondetail.Modified_By = modifiedby;
                persondetail.Modified_Date = Convert.ToDateTime(modifieddate);

                if (personid == 0)
                    pdetalinsert.tbl_PersonDetails.InsertOnSubmit(persondetail);
                pdetalinsert.SubmitChanges();
                return persondetail.Person_ID;
            }
        }
        public static int Edit_PersonalInfo(int personid, string fname, string mname, string lname, string maidenname, string gender, string dob, string ssn, string age,string cpe ,string maritalstatus, string status, string modifiedby, string modifieddate,string ethincity,string triningcompleted)
        {
            using (License_ConnectionDataContext pdetalinsert = new License_ConnectionDataContext())
            {
                tbl_PersonDetail persondetail;
                if (personid == 0)
                    persondetail = new tbl_PersonDetail();
                else
                    persondetail = pdetalinsert.tbl_PersonDetails.Where(c => c.Person_ID == personid).SingleOrDefault();
                if (persondetail.First_Name != fname || persondetail.Middle_Name != mname || persondetail.Last_Name != lname || persondetail.DOB != Convert.ToDateTime(dob) || persondetail.SSN != ssn)
                {
                    tbl_Name_History obj = new tbl_Name_History();
                    obj.Person_ID = personid.ToString();
                    obj.First_Name =  persondetail.First_Name;
                    obj.Last_Name = persondetail.Last_Name;
                    obj.Middle_Name = persondetail.Middle_Name;
                    obj.DOB = persondetail.DOB;
                    obj.SSN = persondetail.SSN;
                     
                    obj.CreatedBy = persondetail.Created_By;
                    obj.CreatedDate = persondetail.Created_Date;
                    obj.ModifiedBy = modifiedby;
                    obj.ModifiedDate =Convert.ToDateTime( modifieddate);
                    pdetalinsert.tbl_Name_Histories.InsertOnSubmit(obj);
                    tbl_Licensing_Journal_Detail jour = new tbl_Licensing_Journal_Detail();
                    jour.Person_Id = personid;
                    jour.Journal_Type_Id = 573;
                    jour.Is_Alert = false;
                    jour.Isce = 0;
                    jour.Description = "Name Changed on " + DateTime.Now.ToShortDateString();
                    jour.Createdby = modifiedby;
                    jour.CreatedDate = Convert.ToDateTime(modifieddate);
                    pdetalinsert.tbl_Licensing_Journal_Details.InsertOnSubmit(jour);
                    
                }
                persondetail.Person_ID = personid;
                persondetail.First_Name = fname;
                persondetail.Middle_Name = mname;
                persondetail.Last_Name = lname;
                persondetail.Ethincity = ethincity;
                persondetail.Madian_Name = maidenname;
                persondetail.Gender = gender;
                persondetail.DOB = Convert.ToDateTime(dob);
                persondetail.SSN = ssn;
                persondetail.Age = age;
                persondetail.CPE = cpe;
                persondetail.Training_Completed = triningcompleted;
                persondetail.Martial_Status = maritalstatus;
                persondetail.Status = status;
                persondetail.Modified_By = modifiedby;
                persondetail.Modified_Date = Convert.ToDateTime(modifieddate);

                if (personid == 0)
                    pdetalinsert.tbl_PersonDetails.InsertOnSubmit(persondetail);
                pdetalinsert.SubmitChanges();
                return persondetail.Person_ID;
            }
        }
        public static int Edit_businessInfoold(int personid,string businessname,string ownersname, string dob, string fein,string dea, string modifiedby, string modifieddate,string skippayment)
        {
            using (License_ConnectionDataContext pdetalinsert = new License_ConnectionDataContext())
            {
                tbl_PersonDetail persondetail;
                if (personid == 0)
                    persondetail = new tbl_PersonDetail();
                else
                    persondetail = pdetalinsert.tbl_PersonDetails.Where(c => c.Person_ID == personid).SingleOrDefault();
                if (persondetail.Business != businessname || persondetail.FEIN != fein)
                {
                    tbl_Name_History obj = new tbl_Name_History();
                    obj.Person_ID = personid.ToString();
                   
                    obj.Last_Name = persondetail.Business;
                   
                    obj.SSN = persondetail.FEIN;
                    obj.CreatedBy = persondetail.Created_By;
                    obj.CreatedDate = persondetail.Created_Date;
                    obj.ModifiedBy = modifiedby;
                    obj.ModifiedDate = Convert.ToDateTime(modifieddate);
                    pdetalinsert.tbl_Name_Histories.InsertOnSubmit(obj);
                    tbl_Licensing_Journal_Detail jour = new tbl_Licensing_Journal_Detail();
                    jour.Person_Id = personid;
                    jour.Journal_Type_Id = 573;
                    jour.Is_Alert = false;
                    jour.Isce = 0;
                    jour.Description = "Name Changed on " + DateTime.Now.ToShortDateString();
                    jour.Createdby = modifiedby;
                    jour.CreatedDate = Convert.ToDateTime(modifieddate);
                    pdetalinsert.tbl_Licensing_Journal_Details.InsertOnSubmit(jour);

                }
                persondetail.Person_ID = personid;
                persondetail.Business = businessname;
                persondetail.Ownersifdiff = ownersname;
                if(dob!="")
                    persondetail.DOB = Convert.ToDateTime(dob);
                
                persondetail.FEIN = fein;
                persondetail.DEA = dea;
                persondetail.Modified_By = modifiedby;
                persondetail.Modified_Date = Convert.ToDateTime(modifieddate);
                persondetail.SkipPayment = skippayment;

                if (personid == 0)
                    pdetalinsert.tbl_PersonDetails.InsertOnSubmit(persondetail);
                pdetalinsert.SubmitChanges();
                return persondetail.Person_ID;
            }
        }
        public static int Edit_businessInfo(int personid, string businessname, string ownersname, string dob, string fein, string dea, string modifiedby, string modifieddate, string skippayment, string eprofile)
        {
            using (License_ConnectionDataContext pdetalinsert = new License_ConnectionDataContext())
            {
                tbl_PersonDetail persondetail;
                if (personid == 0)
                    persondetail = new tbl_PersonDetail();
                else
                    persondetail = pdetalinsert.tbl_PersonDetails.Where(c => c.Person_ID == personid).SingleOrDefault();
                if (persondetail.Business != businessname || persondetail.FEIN != fein)
                {
                    tbl_Name_History obj = new tbl_Name_History();
                    obj.Person_ID = personid.ToString();

                    obj.Last_Name = persondetail.Business;

                    obj.SSN = persondetail.FEIN;
                    obj.CreatedBy = persondetail.Created_By;
                    obj.CreatedDate = persondetail.Created_Date;
                    obj.ModifiedBy = modifiedby;
                    obj.ModifiedDate = Convert.ToDateTime(modifieddate);
                    pdetalinsert.tbl_Name_Histories.InsertOnSubmit(obj);
                    tbl_Licensing_Journal_Detail jour = new tbl_Licensing_Journal_Detail();
                    jour.Person_Id = personid;
                    jour.Journal_Type_Id = 573;
                    jour.Is_Alert = false;
                    jour.Isce = 0;
                    jour.Description = "Name Changed on " + DateTime.Now.ToShortDateString();
                    jour.Createdby = modifiedby;
                    jour.CreatedDate = Convert.ToDateTime(modifieddate);
                    pdetalinsert.tbl_Licensing_Journal_Details.InsertOnSubmit(jour);

                }
                persondetail.Person_ID = personid;
                persondetail.Business = businessname;
                persondetail.Ownersifdiff = ownersname;
                if (dob != "")
                    persondetail.DOB = Convert.ToDateTime(dob);

                persondetail.FEIN = fein;
                persondetail.DEA = dea;
                persondetail.Modified_By = modifiedby;
                persondetail.Modified_Date = Convert.ToDateTime(modifieddate);
                persondetail.SkipPayment = skippayment;
                persondetail.NABP_E_Profile_Number = eprofile;


                if (personid == 0)
                    pdetalinsert.tbl_PersonDetails.InsertOnSubmit(persondetail);
                pdetalinsert.SubmitChanges();
                return persondetail.Person_ID;
            }
        }

        public static int Edit_AddressInfo(int personid, string address1, string address2, string city, string state, string country, string zip, string modifiedby, string modifieddate)
        {
            using (License_ConnectionDataContext pdetalinsert = new License_ConnectionDataContext())
            {
                tbl_PersonDetail persondetail;
                if (personid == 0)
                    persondetail = new tbl_PersonDetail();
                else
                    persondetail = pdetalinsert.tbl_PersonDetails.Where(c => c.Person_ID == personid).SingleOrDefault();
                if (persondetail.Address1 != address1 || persondetail.Address2 != address2 || persondetail.City != city || persondetail.State != state || persondetail.County != country || persondetail.Zip != zip)
                {
                    tbl_Address_History obj = new tbl_Address_History();
                    obj.Address1 = persondetail.Address1;
                    obj.Address2 = persondetail.Address2;
                    obj.Person_ID = personid.ToString();
                    obj.City = persondetail.City;
                    obj.State = persondetail.State;
                    obj.County = persondetail.County;
                    obj.Zip = persondetail.Zip;
                    obj.CreatedBy = persondetail.Created_By;
                    obj.CreatedDate = persondetail.Created_Date;
                    obj.ModifiedBy = modifiedby;
                    obj.ModifiedDate = Convert.ToDateTime(modifieddate);
                    pdetalinsert.tbl_Address_Histories.InsertOnSubmit(obj);
                    tbl_Licensing_Journal_Detail jour = new tbl_Licensing_Journal_Detail();
                    jour.Person_Id = personid;
                    jour.Journal_Type_Id = 572;
                    jour.Is_Alert = false;
                    jour.Isce = 0;
                    jour.Description = "Address Changed on " + DateTime.Now.ToShortDateString();
                    jour.Createdby = modifiedby;
                    jour.CreatedDate = Convert.ToDateTime(modifieddate);
                    pdetalinsert.tbl_Licensing_Journal_Details.InsertOnSubmit(jour);
                    
                }
                persondetail.Person_ID = personid;

                persondetail.Address1 = address1;
                persondetail.Address2 = address2;
                persondetail.City = city;
                persondetail.State = state;
                persondetail.County = country;
                persondetail.Zip = zip;
                persondetail.Modified_By = modifiedby;
                persondetail.Modified_Date = Convert.ToDateTime(modifieddate);

                if (personid == 0)
                    pdetalinsert.tbl_PersonDetails.InsertOnSubmit(persondetail);
                pdetalinsert.SubmitChanges();
                return persondetail.Person_ID;
            }
        }
        public static int Edit_USCitizen(int personid, string isuscitizen,string citizenexpiratinondate, string modifiedby, string modifieddate)
        {
            using (License_ConnectionDataContext pdetalinsert = new License_ConnectionDataContext())
            {
                tbl_PersonDetail persondetail;
                if (personid == 0)
                    persondetail = new tbl_PersonDetail();
                else
                    persondetail = pdetalinsert.tbl_PersonDetails.Where(c => c.Person_ID == personid).SingleOrDefault();
                persondetail.Person_ID = personid;
                persondetail.IS_US_Citizen = isuscitizen;
                if (citizenexpiratinondate != "")
                    persondetail.Citizen_Expiration_Date = Convert.ToDateTime(citizenexpiratinondate);
                else
                    persondetail.Citizen_Expiration_Date = null;
            
                persondetail.Modified_By = modifiedby;
                persondetail.Modified_Date = Convert.ToDateTime(modifieddate);

                if (personid == 0)
                    pdetalinsert.tbl_PersonDetails.InsertOnSubmit(persondetail);
                pdetalinsert.SubmitChanges();
                return persondetail.Person_ID;
            }
        }

        public static int Insert_PersonLaw_Data(int citid, int personid, string lawfullid, string verifydate, string Seldocs, string createdby, string createddate)
        {
            using (License_ConnectionDataContext personlawinsert = new License_ConnectionDataContext())
            {
                tbl_person_law personlaw;
               
                    personlaw = personlawinsert.tbl_person_laws.Where(c => c.personID == personid).FirstOrDefault();
                    if (personlaw == null)
                    {
                        personlaw = new tbl_person_law();
                        citid = 0;
                    }
                    else
                        citid = 1;
                
             //   personlaw.citid = citid;
                personlaw.personID = personid;
                personlaw.lawful = lawfullid;
                if(verifydate!="")
                personlaw.verifydt = Convert.ToDateTime(verifydate);
                personlaw.seldocs = Seldocs;
                personlaw.Createdby = createdby;
                personlaw.Createddate = Convert.ToDateTime(createddate);


                if (citid == 0)
                    personlawinsert.tbl_person_laws.InsertOnSubmit(personlaw);
                personlawinsert.SubmitChanges();
                return personlaw.citid;
            }
        }
        public static void Insert_Update_MailingAddress(int mailingid, int perid, string address1, string address2, string city, string state, string county, string zip, string createdby)
        {
            using (License_ConnectionDataContext lcdc = new License_ConnectionDataContext())
            {
                tbl_Mailing_Address maddress;
                if (mailingid == 0)
                    maddress = new tbl_Mailing_Address();
                else
                    maddress = lcdc.tbl_Mailing_Addresses.Where(c => c.Mailing_Address_ID == mailingid).SingleOrDefault();
                maddress.Mailing_Address_ID = mailingid;
                maddress.Person_ID = perid;
                maddress.Address1 = address1;
                maddress.Address2 = address2;
                maddress.City = city;
                maddress.State = state;
                maddress.County = county;
                maddress.Zip = zip;
                if (mailingid == 0)
                {
                    maddress.Created_By = createdby;
                    maddress.Created_Date = Convert.ToDateTime(DateTime.Now.ToShortDateString());
                }
                else
                {
                    maddress.Modify_By = createdby;
                    maddress.Modify_Date = Convert.ToDateTime(DateTime.Now.ToShortDateString());
                }
                if (mailingid == 0)
                    lcdc.tbl_Mailing_Addresses.InsertOnSubmit(maddress);
                lcdc.SubmitChanges();

            }
        }
        #endregion


    }
}
