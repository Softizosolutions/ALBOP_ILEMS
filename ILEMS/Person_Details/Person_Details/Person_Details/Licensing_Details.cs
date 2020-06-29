using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Person_Details;
using System.Data;
using System.Data.SqlClient;
using System.Web;

namespace Person_Details
{
    
    public static class Licensing_Details
    {
        public static List<USP_GetPharmacistdataResult> GetonlinePharmacist(string sdt, string edt)
        {
            using (Person_LicenseDataContext plc = new Person_LicenseDataContext())
            {
                return plc.USP_GetPharmacistdata(sdt, edt).ToList();
            }
        }
        public static List<USPGetDisciplinaryFindingFilesResult> GetDisciplinaryFindingFiles()
        {
            using (Person_LicenseDataContext plc = new Person_LicenseDataContext())
            {
                return plc.USPGetDisciplinaryFindingFiles().ToList();
            }
        }
        public static int InsertDisciplinaryFiles(TblDisciplinaryFinding data)
        {
            using (Person_LicenseDataContext plc = new Person_LicenseDataContext())
            {
                plc.TblDisciplinaryFindings.InsertOnSubmit(data);
                plc.SubmitChanges();
                return data.DisciplinaryFindingsID;
            }
        }
        public static List<Tbl_Login> Get_License1()
        {
            using (Person_LicenseDataContext db = new Person_LicenseDataContext())
            {
                return db.Tbl_Logins.OrderBy(c => c.loginID).ToList();
            }
        }
        #region Ce Audit 
        public static int insert_Ceaudit(int ceauditId, string personid, string year, string datesent, string datereceved, string livehours, string nonlivehours, string status, string comment, string createdby, string modified,string feepaid)

        {
            using (Person_LicenseDataContext ce = new Person_LicenseDataContext())
            {
                Tbl_CeAudit ceaudit;
                if (ceauditId == 0)
                    ceaudit = new Tbl_CeAudit();
                else
                    ceaudit = ce.Tbl_CeAudits.Where(c => c.CeAuditID == ceauditId).SingleOrDefault();

                ceaudit.CeAuditID = ceauditId;
                ceaudit.Personid = personid;
                ceaudit.Year = year;
                ceaudit.DateSent = datesent;
                ceaudit.DateReceived = datereceved;
                ceaudit.LiveHours = livehours;
                ceaudit.Non_live_hours = nonlivehours;
                ceaudit.Status = status;
                ceaudit.Comments = comment;
                ceaudit.ModifiedBy = modified;
                ceaudit.CreatedBy = createdby;
                ceaudit.FeePaid = feepaid;
                ceaudit.CreadteDate = Convert.ToDateTime(DateTime.Now.ToShortDateString());
                ceaudit.ModifiedDate = Convert.ToDateTime(DateTime.Now.ToShortDateString());
                if (ceauditId == 0)
                    ce.Tbl_CeAudits.InsertOnSubmit(ceaudit);
                ce.SubmitChanges();

                return ceaudit.CeAuditID;
            }
        }


        public static Tbl_CeAudit Edit_ceaudit(int cerid)
        {
            using (Person_LicenseDataContext pconsubedit = new Person_LicenseDataContext())
            {
                return pconsubedit.Tbl_CeAudits.Where(c => c.CeAuditID == cerid).SingleOrDefault();
            }
        }

        public static void Delete_ceaudit(int cerid)
        {
            using (Person_LicenseDataContext pconsubdelete = new Person_LicenseDataContext())
            {
                Tbl_CeAudit obj = pconsubdelete.Tbl_CeAudits.Where(c => c.CeAuditID == cerid).SingleOrDefault();
                pconsubdelete.Tbl_CeAudits.DeleteOnSubmit(obj);
                pconsubdelete.SubmitChanges();
            }
        }


        public static List<USP_GetCeAuditdetailsResult> bindceaudit(int personid)
        {
            using (Person_LicenseDataContext db = new Person_LicenseDataContext())
            {
                return db.USP_GetCeAuditdetails(personid).ToList();
            }
        }

        #endregion
        public static List<USP_getrenewalcontactResult> Getrenewalcontact(string appid)
        {
            using (Person_LicenseDataContext db = new Person_Details.Person_LicenseDataContext())
            {
                return db.USP_getrenewalcontact(appid).ToList();
            }
        }
        public static void save_ts(string dt, string empid, string wrk, string annual, string sick, string hold, string comp, string oth, string loc)
        {
            using (Person_LicenseDataContext db = new Person_LicenseDataContext())
            {
                Boolean isnew = true;
                tbl_emp_t o = new tbl_emp_t();

                o = db.tbl_emp_ts.Where(c => c.ts_dt == dt && c.emp_id == Convert.ToInt32(empid)).FirstOrDefault();
                if (o == null)
                    o = new tbl_emp_t();
                else
                    isnew = false;
                o.ts_dt = dt;
                o.emp_id = Convert.ToInt32(empid);
                o.wrk_hrs = Convert.ToDecimal(wrk);
                o.annhual_hrs = Convert.ToDecimal(annual);
                o.sick_hrs = sick;
                o.hold_hrs = Convert.ToDecimal(hold);
                o.comp_hrs = Convert.ToDecimal(comp);
                o.oth_hrs = Convert.ToDecimal(oth);
                o.Location_wrk = loc;
                o.Is_approve = false;
                if (isnew)
                    db.tbl_emp_ts.InsertOnSubmit(o);
                db.SubmitChanges();
            }
        }
        public static tbl_Application GetSchedule(int appid)
        {
            using(Person_LicenseDataContext pldc=new Person_LicenseDataContext())
            {
                return pldc.tbl_Applications.Where(c => c.App_ID == appid).FirstOrDefault();
            }
        }
        public static void manualrenewal(string licid, string user)
        {
            using (Person_LicenseDataContext pdb = new Person_LicenseDataContext())
            {
                pdb.USP_manual_process(Convert.ToInt32(licid), user);
            }
        }
        public static List<usp_getlicensedetailsResult> get_PersonsData1(int personid, string objtype)
        {
            using (Person_LicenseDataContext db = new Person_LicenseDataContext())
            {
                return db.usp_getlicensedetails(personid, objtype).ToList();
            }
        }
        public static List<USP_GetdoctypesResult> Getdoctypes(string utype)
        {
            using (Person_LicenseDataContext pdb = new Person_LicenseDataContext())
            {
                return pdb.USP_Getdoctypes(utype).ToList();
            }
        }
        public static void Delete_fee(string feeid)
        {
            using (Person_LicenseDataContext pdb = new Person_LicenseDataContext())
            {
                TBL_Accounting_FeeDetail obj = pdb.TBL_Accounting_FeeDetails.Where(c => c.FeeID == Convert.ToInt32(feeid)).SingleOrDefault();
                pdb.TBL_Accounting_FeeDetails.DeleteOnSubmit(obj);
                pdb.SubmitChanges();
            }
        }
        public static List<USP_GetHasPharmacyEmployeeResult> GetHasPharmacyEmp(int pid)
        {
            using (Person_LicenseDataContext pdb = new Person_LicenseDataContext())
            {
                return pdb.USP_GetHasPharmacyEmployee(pid).ToList();
            }
        }
        public static List<USP_GetCitizenshipDetailsResult> GetCitizenshipDetails(int ltype)
        {
            using (Person_LicenseDataContext pdb = new Person_LicenseDataContext())
            {
                return pdb.USP_GetCitizenshipDetails(ltype).ToList();
            }
        }
        public static List<USP_ShowalertResult> Getalerts(int pid)
        {
            using (Person_LicenseDataContext pdd = new Person_LicenseDataContext())
            {
                return pdd.USP_Showalert(pid).ToList();
            }
        }
        public static void Insert_alertrelease(string jurid, string crtuser)
        {
            using (Person_LicenseDataContext pdd = new Person_LicenseDataContext())
            {
                Tbl_Person_JournalAlertHistory obj = new Tbl_Person_JournalAlertHistory();
                obj.jur_id = Convert.ToInt32(jurid);
                obj.alert_releasedby = Convert.ToInt32(crtuser);
                obj.alert_released = DateTime.Now;
                pdd.Tbl_Person_JournalAlertHistories.InsertOnSubmit(obj);
                tbl_Licensing_Journal_Detail jobj = pdd.tbl_Licensing_Journal_Details.Where(c => c.Journal_Id == Convert.ToInt32( jurid)).SingleOrDefault();
                jobj.Is_Alert = false;
                
                pdd.SubmitChanges();
            }
        }



        #region Speciality


        public static List<USP_BindGridPersonDocumnetSpecialityResult> Get_DocumentSpecialityDetails(int personid)
        {
            using (Person_LicenseDataContext plc = new Person_LicenseDataContext())
            {
                return plc.USP_BindGridPersonDocumnetSpeciality(personid).ToList();
            }
        }



        public static int InsertDocumentspeciality(tbl_Speciality_Document_Detail documnet)
        {
            using (Person_LicenseDataContext plc = new Person_LicenseDataContext())
            {
                plc.tbl_Speciality_Document_Details.InsertOnSubmit(documnet);
                plc.SubmitChanges();
                return documnet.Document_ID;
            }
        }



        public static void DeleteDocumentSpeciality(int id)
        {
            using (Person_LicenseDataContext db = new Person_LicenseDataContext())
            {
                tbl_Speciality_Document_Detail obj = db.tbl_Speciality_Document_Details.Where(c => c.Document_ID == id).SingleOrDefault();
                db.tbl_Speciality_Document_Details.DeleteOnSubmit(obj);

                db.SubmitChanges();
            }
        }



        public static tbl_Speciality_Document_Detail Edit_SpecailityInspection(int id)
        {
            using (Person_LicenseDataContext pdc = new Person_LicenseDataContext())
            {
                return pdc.tbl_Speciality_Document_Details.Where(c => c.Document_ID == id).SingleOrDefault();
            }
        }


        public static Speciality Getspeciality(int personid)
        {
            using (Person_LicenseDataContext db = new Person_LicenseDataContext())
            {
                return db.Specialities.Where(c => c.PersonID == personid).SingleOrDefault();
            }
        }
        public static List<Speciality> Get_speciality(int personid)
        {
            using (Person_LicenseDataContext db = new Person_LicenseDataContext())
            {
                return db.Specialities.Where(c => c.PersonID == personid).ToList();
            }
        }
        public static int Insertspeciality(int SpecialityID, int PersonID, string Specialties, string drugcollecter, string Parenteral, string Nuclear, string RemoteOrderEntry, string NonPharmacyKeyHolder, string createdby)
        {

            using (Person_LicenseDataContext ins = new Person_LicenseDataContext())
            {
                Speciality d;
                if (SpecialityID == 0)
                    d = new Speciality();
                else
                    d = ins.Specialities.Where(c => c.SpecialityID == SpecialityID).SingleOrDefault();
                d.DrugCollector = Convert.ToBoolean(Convert.ToInt32(drugcollecter));
                d.Parenteral = Convert.ToBoolean(Convert.ToInt32(Parenteral));
                d.Nuclear = Convert.ToBoolean(Convert.ToInt32(Nuclear));
                d.RemoteOrderEntry = Convert.ToBoolean(Convert.ToInt32(RemoteOrderEntry));
                d.NonPharmacyKeyHolder = Convert.ToBoolean(Convert.ToInt32(NonPharmacyKeyHolder));
                d.PersonID = PersonID;

                d.CreatedBy = createdby;
                d.CreatedDate = Convert.ToDateTime(DateTime.Now.ToShortDateString());
                if (SpecialityID == 0)
                    ins.Specialities.InsertOnSubmit(d);
                ins.SubmitChanges();
                return d.SpecialityID;
            }
        }
        #endregion
        public static List<tbl_PersonDetail> GetPerson_Details(int personid)
        {
            using (Person_LicenseDataContext pdd = new Person_LicenseDataContext())
            {
                return pdd.tbl_PersonDetails.Where(c => c.Person_ID == personid).ToList();
            }
        }
        public static List<tbl_PersonDetail> GetSSN(string ssn)
        {
            using (Person_LicenseDataContext pdb = new Person_LicenseDataContext())
            {
                return pdb.tbl_PersonDetails.Where(c => c.SSN == ssn).ToList();
            }
        }
        public static List<tbl_PersonDetail> GetFEIN(string fein)
        {
            using (Person_LicenseDataContext pdb = new Person_LicenseDataContext())
            {
                return pdb.tbl_PersonDetails.Where(c => c.FEIN==fein).ToList();
            }
        }
        public static Tbl_Login GetUserEmail(int logind)
        {
            using (Person_LicenseDataContext pldc = new Person_LicenseDataContext())
            {
                return pldc.Tbl_Logins.Where(c => c.loginID == logind).SingleOrDefault();
            }
        }
        public static USP_GetPersonDetailsByPIDResult Get_PersonDetailsByPersonID(int personid)
        {
            using (Person_LicenseDataContext pldc = new Person_LicenseDataContext())
            {
                return pldc.USP_GetPersonDetailsByPID(personid).SingleOrDefault();
            }
        }
        public static List<USP_GetpersonSearchResult> getpersonserch(string lname, string fname, string ssn, string dob, string phonenunm, string phonetype, string licno, string lictype, string licstatus, string email,string addr,string county,string state,string zip,string cs,string city,string stype)
        {

            if (phonetype == "Select Phone Type")

                phonetype = "";


            if (lictype == "--Select--")

                lictype = "";


            if (licstatus == "--Select--")

                licstatus = "";
            if (stype == "1")
                stype = "%";
            else
                stype = "";
            using (Person_LicenseDataContext pdb = new Person_LicenseDataContext())
            {
                return pdb.USP_GetpersonSearch(lname, fname, ssn, dob, phonenunm, phonetype, licno, lictype, licstatus, addr, county, state, zip, email, Convert.ToBoolean(cs), city, stype).ToList();
            }
        }
        public static List<USP_GetBusinessSearchResult> getbusinesssearch(string lname, string fname, string ssn, string dob, string phonenunm, string phonetype, string licno, string lictype, string licstatus, string address, string county, string state, string zip, string email, string cert, string cs, string usp797, string usp795, string city, string stype)
        {

            if (phonetype == "Select Phone Type")

                phonetype = "";


            if (lictype == "--Select--")

                lictype = "";


            if (licstatus == "--Select--")

                licstatus = "";
            if (stype == "1")
                stype = "%";
            else
                stype = "";
            using (Person_LicenseDataContext pdb = new Person_LicenseDataContext())
            {

                return pdb.USP_GetBusinessSearch(lname, fname, ssn, dob, phonenunm, phonetype, licno, lictype, licstatus, address, county, state, zip, email, cert, Convert.ToBoolean(cs), usp795, usp797, city, stype).ToList();
            }
        }
        public static List<USP_GetLicenseinfobypersonidResult> Get_Person_licenseInfo(string pid)
        {
            using (Person_LicenseDataContext pdd = new Person_LicenseDataContext())
            {
                return pdd.USP_GetLicenseinfobypersonid(Convert.ToInt32(pid)).ToList();
            }
        }
        public static List<USP_Licensing_PersonGetCheckItemsResult> Get_Checklistitem(string lname, string fname, string ssn, string dob, string phoneno, string phonetype)
        {
            if (phonetype == "Select Phone Type")
                phonetype = "";
            using (Person_LicenseDataContext plc = new Person_LicenseDataContext())
            {
                return plc.USP_Licensing_PersonGetCheckItems(lname, fname, ssn, dob, phoneno, phonetype).ToList();
            }
        }
        #region Skippayment
        public static tbl_PersonDetail skippayment(int personid)
        {
            using (Person_LicenseDataContext db = new Person_LicenseDataContext())
            {
                return db.tbl_PersonDetails.Where(c => c.Person_ID == personid).SingleOrDefault();
            }
        }
        #endregion
        public static int Insert_Values(int personid, string fname, string mname, string lname, string maidenname, string gender, string dob, string ssn, string age, string address1, string address2, string city, string state, string country, string zip, string phtype, string phone, string altphtype, string altphone, string maritalstatus, string fax, string email, string isuscitizen, string status, string createdby, string createddate, string modifiedby, string modifieddate,string citizenexpdate,string cpenumber,string ethincity)
        {
            using (Person_LicenseDataContext pdetalinsert = new Person_LicenseDataContext())
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
                if(dob!="")
                    persondetail.DOB = Convert.ToDateTime(dob);
                
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
                persondetail.Modified_Date = Convert.ToDateTime(modifieddate);
                persondetail.object_type = 1;
                if(citizenexpdate!="")
                persondetail.Citizen_Expiration_Date = Convert.ToDateTime(citizenexpdate);
                persondetail.CPE = cpenumber;
                persondetail.Ethincity = ethincity;
                if (personid == 0)
                    pdetalinsert.tbl_PersonDetails.InsertOnSubmit(persondetail);
                pdetalinsert.SubmitChanges();
                return persondetail.Person_ID;
            }
        }
        public static int Insert_Business_Values(int personid, string bname, string oname, string datestarted,string btype ,string fein, string address1, string address2, string city, string state, string country, string zip, string phtype, string phone, string altphtype, string altphone, string fax, string email,string dea ,string status, string createdby, string createddate, string modifiedby, string modifieddate)
        {
            using (Person_LicenseDataContext pdetalinsert = new Person_LicenseDataContext())
            {
                tbl_PersonDetail persondetail;
                if (personid == 0)
                    persondetail = new tbl_PersonDetail();
                else
                    persondetail = pdetalinsert.tbl_PersonDetails.Where(c => c.Person_ID == personid).SingleOrDefault();
                persondetail.Person_ID = personid;
                persondetail.Business = bname;
                persondetail.Ownersifdiff = oname;
                if (datestarted != "")
                    persondetail.DOB = Convert.ToDateTime(datestarted);
                persondetail.FEIN = fein;
                persondetail.Business_Type = btype;
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
                persondetail.Fax = fax;
                persondetail.Email = email;
                persondetail.Status = status;
                persondetail.DEA = dea;
                persondetail.Created_By = createdby;
                persondetail.Created_Date = Convert.ToDateTime(createddate);
                persondetail.Modified_By = modifiedby;
                persondetail.Modified_Date = Convert.ToDateTime(modifieddate);
                persondetail.object_type = 2;
                if (personid == 0)
                    pdetalinsert.tbl_PersonDetails.InsertOnSubmit(persondetail);
                pdetalinsert.SubmitChanges();
                return persondetail.Person_ID;
            }
        }
        public static tbl_PersonDetail get_PersonsData(int personid)
        {
            using (Person_LicenseDataContext db = new Person_LicenseDataContext())
            {
                return db.tbl_PersonDetails.Where(c => c.Person_ID == personid).SingleOrDefault();
            }


        }
       
        #region master_tables
        public static List<tbl_lkp_table> Get_Lkp_tables()
        {
            using (Person_LicenseDataContext db = new Person_LicenseDataContext())
            {
                return db.tbl_lkp_tables.OrderBy(c => c.Lkp_table_name).ToList();
            }
        }
        public static List<tbl_lkp_data> Get_Lkp_tablesdata(int tbllkpid)
        {
            using (Person_LicenseDataContext db = new Person_LicenseDataContext())
            {
                return db.tbl_lkp_datas.Where(c => c.Lkp_tbl_ID == tbllkpid).OrderBy(c=>c.Values).ToList();
            }
        }
        public static List<tbl_lkp_data> Get_Lkp_tablesdata1(int tbllkpid)
        {
            using (Person_LicenseDataContext db = new Person_LicenseDataContext())
            {
                return db.tbl_lkp_datas.Where(c => c.Lkp_tbl_ID == tbllkpid).ToList();
            }
        }
        public static List<tbl_Lkp_status_change_Reason> Fill_Dropdown()
        {
            using (Person_LicenseDataContext db = new Person_LicenseDataContext())
            {
                return db.tbl_Lkp_status_change_Reasons.OrderBy(c => c.Description).ToList();
            }
        }
        public static List<tbl_lkp_License> Get_License()
        {
            using (Person_LicenseDataContext db = new Person_LicenseDataContext())
            {
                return db.tbl_lkp_Licenses.OrderBy(c=>c.License_Type).ToList();
            }
        }
        public static List<tbl_lkp_subobj> Get_subobjValues()
        {
            using (Person_LicenseDataContext db = new Person_LicenseDataContext())
            {
                return db.tbl_lkp_subobjs.Where(c => c.Subobj_code != "").OrderBy(c => c.Description).ToList();
            }
        }
        public static tbl_lkp_subobj FeeAmountofSubobj(int subobjid)
        {
            using (Person_LicenseDataContext db = new Person_LicenseDataContext())
            {
                return db.tbl_lkp_subobjs.Where(c => c.Subobj_Id == subobjid).SingleOrDefault();
            }
        }
        #endregion

        #region Employement insert update delete
        public static void InsertEmployer(TBL_Licensing_Employer employer)
        {
            using (Person_LicenseDataContext plc = new Person_LicenseDataContext())
            {
                plc.Usp_Employer(101, employer.Employer_Id, employer.App_Id.ToString(), employer.Person_ID.ToString(), employer.Employer_Type.ToString(), employer.Employer_Name.ToString(), employer.Address.ToString(), employer.City.ToString(), employer.State.ToString(), employer.Zip.ToString(), employer.County.ToString(), employer.isprocess.ToString(), employer.createdby, employer.createddt);
                plc.SubmitChanges();
            }
        }
        public static void UpdateEmployer(TBL_Licensing_Employer employer)
        {
            using (Person_LicenseDataContext plc = new Person_LicenseDataContext())
            {
                plc.Usp_Employer(102, employer.Employer_Id, employer.App_Id.ToString(), employer.Person_ID.ToString(), employer.Employer_Type.ToString(), employer.Employer_Name.ToString(), employer.Address.ToString(), employer.City.ToString(), employer.State.ToString(), employer.Zip.ToString(), employer.County.ToString(), employer.isprocess.ToString(), employer.createdby, employer.createddt);
                plc.SubmitChanges();
            }
        }
        public static List<USP_BindEmployerDataResult> BindGrid_Employer(int personid)
        {
            using (Person_LicenseDataContext db = new Person_LicenseDataContext())
            {
                return db.USP_BindEmployerData(personid).ToList();
            }
        }
        public static TBL_Licensing_Employer Edit_Employer(int empid)
        {
            using (Person_LicenseDataContext db = new Person_LicenseDataContext())
            {
                return db.TBL_Licensing_Employers.Where(c => c.Employer_Id == empid).SingleOrDefault();
            }
        }
        public static void Delete_Employer(TBL_Licensing_Employer obj)
        {
            using (Person_LicenseDataContext db = new Person_LicenseDataContext())
            {
                db.Usp_Employer(103, obj.Employer_Id, null, null, null, null, null, null, null, null, null, null, null, null);
                db.SubmitChanges();
            }
        }
        #endregion

        #region otherstatelic insert,update,delete
        public static void insertotherstatelic(tbl_otherstatelicense license)
        {
            using (Person_LicenseDataContext lic = new Person_LicenseDataContext())
            {
                lic.usp_Otherstatelicense(101, license.Osl_ID, license.Per_ID.Value, license.Status.ToString(), license.Licno.ToString(), Convert.ToDateTime(license.Date_Received),null, license.isothers.ToString(), license.states.ToString(), license.createdby.ToString(), Convert.ToDateTime(license.createddt));
                lic.SubmitChanges();
            }

        }
        public static void updateotherstatelic(tbl_otherstatelicense license)
        {
            using (Person_LicenseDataContext lic = new Person_LicenseDataContext())
            {
                lic.usp_Otherstatelicense(102, license.Osl_ID, license.Per_ID.Value, license.Status.ToString(), license.Licno.ToString(), Convert.ToDateTime(license.Date_Received), null, license.isothers.ToString(), license.states.ToString(), license.createdby.ToString(), Convert.ToDateTime(license.createddt));
                lic.SubmitChanges();
            }
        }
        public static List<USP_GetotherstatelicenseResult> BindGrid_otherstatelicense(string pid)
        {
            using (Person_LicenseDataContext db = new Person_LicenseDataContext())
            {
                return db.USP_Getotherstatelicense(pid).ToList();
            }
        }
        public static tbl_otherstatelicense Edit_otherstatelicense(int OslID)
        {
            using (Person_LicenseDataContext db = new Person_LicenseDataContext())
            {
                return db.tbl_otherstatelicenses.Where(c => c.Osl_ID == OslID).SingleOrDefault();
            }
        }
        public static void Delete_otherstatelicense(tbl_otherstatelicense obj)
        {
            using (Person_LicenseDataContext db = new Person_LicenseDataContext())
            {
                db.usp_Otherstatelicense(103, obj.Osl_ID, null, null, null, null, null, null, null, null, null);
                db.SubmitChanges();
            }
        }
        #endregion
        
        //public static void DeleteEmployer(TBL_Licensing_Employer employerdelete)
        //{
        //    using (Person_LicenseDataContext plc = new Person_LicenseDataContext())
        //    {
        //        plc.Usp_Employer(103, employerdelete.Employer_Id);
        //    }
        //}
        #region Document Tab Insert,Update,Delete
        public static tbl_Person_Document_Detail Edit_Document(int empid)
        {
            using (Person_LicenseDataContext db = new Person_LicenseDataContext())
            {
                return db.tbl_Person_Document_Details.Where(c => c.Document_ID == empid).SingleOrDefault();
            }
        }
        public static int InsertDocument(tbl_Person_Document_Detail documnet)
        {
            using (Person_LicenseDataContext plc = new Person_LicenseDataContext())
            {
                plc.tbl_Person_Document_Details.InsertOnSubmit(documnet);
                 plc.SubmitChanges();
                return  documnet.Document_ID;
            }
        }

        public static List<USP_BindGridPersonDocumnetResult> Get_DocumentDetails(int personid,string utype)
        {
            using (Person_LicenseDataContext plc = new Person_LicenseDataContext())
            {
                return plc.USP_BindGridPersonDocumnet(personid,utype).ToList();
            }
        }
        public static List<USP_BindGridPersonRenewalDocumnetResult> Get_RenewalDocumentDetails(int personid, string utype)
        {
            using (Person_LicenseDataContext plc = new Person_LicenseDataContext())
            {
                return plc.USP_BindGridPersonRenewalDocumnet(personid, utype).ToList();
            }
        }
        public static void UpdateDocument(tbl_Person_Document_Detail documnet)
        {
            using (Person_LicenseDataContext plc = new Person_LicenseDataContext())
            {
                plc.USP_PersonDocumentDetails(102, documnet.Document_ID, documnet.Person_ID, documnet.Cabinet_ID, documnet.Folder_ID, Convert.ToDateTime(documnet.Document_Date), documnet.DocType, documnet.Description.ToString(), Convert.ToInt32(documnet.Approval_Needed), documnet.Modified_By, Convert.ToDateTime(documnet.Modified_Date));
                plc.SubmitChanges();
            }
        }
        public static void DeleteDocument(tbl_Person_Document_Detail obj)
        {
            using (Person_LicenseDataContext db = new Person_LicenseDataContext())
            {
                db.USP_PersonDocumentDetails(103, obj.Document_ID, null, null, null,null, null, "", null, null, null);
                db.SubmitChanges();
            }
        }
        #endregion

        #region Journal Tab Insert,Update,Delete
        public static tbl_Licensing_Journal_Detail Edit_Journal(int empid)
        {
            using (Person_LicenseDataContext pd = new Person_LicenseDataContext())
            {
                return pd.tbl_Licensing_Journal_Details.Where(c => c.Journal_Id == empid).SingleOrDefault();
            }
        }
        public static void InsertJournal(tbl_Licensing_Journal_Detail pjd)
        {
            using (Person_LicenseDataContext pld = new Person_LicenseDataContext())
            {
                 pld.USP_Licensing_PersonJournalDetails(101,pjd.Journal_Id, pjd.Person_Id, pjd.Journal_Type_Id, Convert.ToInt32(pjd.Is_Alert), pjd.Description.ToString(),pjd.Isce,pjd.Createdby,pjd.CreatedDate);
                pld.SubmitChanges();
            }
        }
        public static List<USP_Licensing_GetJournalValuesResult> Get_JournalValues(int personid)
        {
            using (Person_LicenseDataContext pld = new Person_LicenseDataContext())
            {
                return pld.USP_Licensing_GetJournalValues(personid).ToList();
            }
        }
        public static void UpdateJournal(tbl_Licensing_Journal_Detail pjd)
        {
            using (Person_LicenseDataContext pld = new Person_LicenseDataContext())
            {
                pld.USP_Licensing_PersonJournalDetails(102, pjd.Journal_Id, pjd.Person_Id, pjd.Journal_Type_Id, Convert.ToInt32(pjd.Is_Alert), pjd.Description.ToString(),pjd.Isce,pjd.Createdby,pjd.CreatedDate);
                pld.SubmitChanges();
            }
        }

        public static void DeleteJournal(tbl_Licensing_Journal_Detail obj)
        {
            using (Person_LicenseDataContext db = new Person_LicenseDataContext())
            {
                db.USP_Licensing_PersonJournalDetails(103, obj.Journal_Id, null, null, null, "",null,"",null);
                db.SubmitChanges();
            }
        }
        #endregion

        #region Education Insert,Update,Delete
        public static TBL_Licensing_Education Edit_Education(int empid)
        {
            using (Person_LicenseDataContext pd = new Person_LicenseDataContext())
            {
                return pd.TBL_Licensing_Educations.Where(c => c.Education_ID == empid).SingleOrDefault();
            }
        }
        public static void Insert_Education(TBL_Licensing_Education education)
        {
            using (Person_LicenseDataContext db = new Person_LicenseDataContext())
            {
                db.USP_Licensing_Insertion_EducationDetails(101, education.Education_ID, education.Person_ID, education.App_ID, education.Degree_ID, education.College, Convert.ToDateTime(education.Start_dt), Convert.ToDateTime(education.End_dt), Convert.ToDateTime(education.DateOfGraduation), education.Traditional_hrs, education.Total_hrs, education.createdby, Convert.ToDateTime(education.createddt));

            }
        }

        public static List<USP_Licensing_GetEducationResult> GetEducation(int personid)
        {
            using (Person_LicenseDataContext db = new Person_LicenseDataContext())
            {
                return db.USP_Licensing_GetEducation(personid.ToString()).ToList();
            }
        }
        public static List<USP_GetLicenseTypeResult> BindLicensetype(int personid)
        {
            using (Person_LicenseDataContext pdd = new Person_LicenseDataContext())
            {
                return pdd.USP_GetLicenseType(personid).ToList();
            }
        }
        public static List<USP_GetMaxLicenseTypeResult> BindMaxLicenseType(int personid)
        {
            using(Person_LicenseDataContext pldc=new Person_LicenseDataContext())
            {
                return pldc.USP_GetMaxLicenseType(personid).ToList();
            }
        }
        public static void Delete_Education(TBL_Licensing_Education education)
        {
            using (Person_LicenseDataContext plc = new Person_LicenseDataContext())
            {
                plc.USP_Licensing_Insertion_EducationDetails(103, education.Education_ID, null, null, null, null, null, null, null, null, null, null, null);
                plc.SubmitChanges();
            }
        }
        public static void Update_Education(TBL_Licensing_Education education)
        {
            using (Person_LicenseDataContext db = new Person_LicenseDataContext())
            {
                db.USP_Licensing_Insertion_EducationDetails(102, education.Education_ID, education.Person_ID, education.App_ID, education.Degree_ID, education.College, Convert.ToDateTime(education.Start_dt), Convert.ToDateTime(education.End_dt), Convert.ToDateTime(education.DateOfGraduation), education.Traditional_hrs, education.Total_hrs, education.modifiedby, Convert.ToDateTime(education.modifieddt));
                db.SubmitChanges();
            }
        }



        #endregion

        #region Certifications Insert,Update,Delete
        public static tbl_Certification Edit_Certifications(int certid)
        {
            using (Person_LicenseDataContext pd = new Person_LicenseDataContext())
            {
                return pd.tbl_Certifications.Where(c => c.Cert_id == certid).SingleOrDefault();
            }
        }
        public static void Insert_Certifications(tbl_Certification certi)
        {
            using (Person_LicenseDataContext db = new Person_LicenseDataContext())
            {
                db.USP_Licensing_Insert_Certifications(101, Convert.ToInt32(certi.Cert_id), Convert.ToInt32(certi.Cert_Type), Convert.ToInt32(certi.Person_id), Convert.ToInt32(certi.status), certi.Certno, Convert.ToDateTime(certi.Effective_dt), Convert.ToDateTime(certi.Expiry_dt), Convert.ToDateTime(certi.Orginal_Date), certi.Comments, certi.createdby, Convert.ToDateTime(certi.createddt));

            }
        }



        public static void Delete_Certifications(tbl_Certification certi)
        {
            using (Person_LicenseDataContext plc = new Person_LicenseDataContext())
            {
                plc.USP_Licensing_Insert_Certifications(103, certi.Cert_id, null, null, null, null, null, null, null, null,null,null);
                plc.SubmitChanges();
            }
        }
        public static void Update_Certifications(tbl_Certification certi)
        {
            using (Person_LicenseDataContext db = new Person_LicenseDataContext())
            {
                db.USP_Licensing_Insert_Certifications(102, Convert.ToInt32(certi.Cert_id), Convert.ToInt32(certi.Cert_Type), Convert.ToInt32(certi.Person_id), Convert.ToInt32(certi.status), certi.Certno, Convert.ToDateTime(certi.Effective_dt), Convert.ToDateTime(certi.Expiry_dt), Convert.ToDateTime(certi.Orginal_Date), certi.Comments, certi.modifiedby, Convert.ToDateTime(certi.modifieddt));
                db.SubmitChanges();
            }
        }



        #endregion

        #region Exam insert update delete Edit
        public static void Insert_ExamDetails(int flag, int examid, string personid, string lictype, string examtype, string NPLEXDT, string nplexscr, string MPJEdate, string MPJE_SCR, string Inter_Score, string createdby, string createddate, string modifiedby, string modifieddate)
        {
            using (Person_LicenseDataContext db = new Person_LicenseDataContext())
            {
                db.USP_Exam_Edit_Delete(101, examid, personid, lictype, examtype, NPLEXDT, nplexscr, MPJEdate, MPJE_SCR, Inter_Score, createdby, createddate, modifiedby, modifieddate);
                db.SubmitChanges();
            }


        }

        public static void Update_Exam(int flag, int examid, string personid, string lictype, string examtype, string NPLEXDT, string nplexscr, string MPJEdate, string MPJE_SCR, string Inter_Score, string createdby, string createddate, string modifiedby, string modifieddate)
        {
            using (Person_LicenseDataContext pld = new Person_LicenseDataContext())
            {
                pld.USP_Exam_Edit_Delete(102, examid, personid, lictype, examtype, NPLEXDT, nplexscr, MPJEdate, MPJE_SCR, Inter_Score, createdby, createddate, modifiedby, modifieddate);
                pld.SubmitChanges();
            }
        }
        public static tbl_examdetail Edit_ExamData(int examid)
        {
            using (Person_LicenseDataContext db = new Person_LicenseDataContext())
            {
                return db.tbl_examdetails.Where(c => c.exam_id == examid).SingleOrDefault();
            }
        }
        public static void Delete_ExamData(tbl_examdetail obj)
        {
            using (Person_LicenseDataContext db = new Person_LicenseDataContext())
            {
                db.USP_Exam_Edit_Delete(103, obj.exam_id, "", "", "", "", "", "", "", "", "", "", "", "");
                db.SubmitChanges();
            }
        }


        #endregion

       
        #region Application Insertion
        public static void Insert_Application(int personid, string lictype,Boolean CS,int OS)
        {
            using (Person_LicenseDataContext pld = new Person_LicenseDataContext())
            {
                pld.USP_InsertApplication(personid, Convert.ToInt32(lictype),CS,OS);
                pld.SubmitChanges();
            }
        }
        public static List<tbl_Application> GetLicenseforpersonandbusiness(int personid, string licensetypeid)
        {
            using (Person_LicenseDataContext pdb = new Person_LicenseDataContext())
            {
                return pdb.tbl_Applications.Where(c => c.Person_ID == personid && c.License_Type_ID == licensetypeid && c.App_Status != "671" && c.App_Status != "513").ToList();
            }
        }
        public static tbl_Application GetPersonResp(int appid)
        {
            using (Person_LicenseDataContext pldc = new Person_LicenseDataContext())
            {
                return pldc.tbl_Applications.Where(c => c.App_ID == appid).SingleOrDefault();
            }
        }
        #endregion
        public static List<USP_GetNewLicnoResult> Getlicnumber_creation(int appid)
        {
            using (Person_LicenseDataContext plc = new Person_LicenseDataContext())
            {
                return plc.USP_GetNewLicno(appid).ToList();


            }
        }

         public static void Insert_Make_Complete(int appid, string statuschange, string issuedate, string expiredate, int makecomplete, string licno)
              {
                  using (Person_LicenseDataContext db = new Person_LicenseDataContext())
                  {
                      db.USP_GetUIMakeComplete(appid, statuschange, issuedate, expiredate,Convert.ToBoolean(makecomplete), licno);
                      db.SubmitChanges();
                  }
              }
         public static List<USP_Licensing_DetailsResult> GetLicensing_Details(int pid)
         {
             using (Person_LicenseDataContext plc = new Person_LicenseDataContext())
             {
                 return plc.USP_Licensing_Details(pid).ToList();
             }
         }

        #region Licensing Tab
         public static void Update_LicenseHistory(int licid, int newstatus, string newexpdate, int statuschange, int modifiedbt, string modifieddate)
         {
             using (Person_LicenseDataContext db = new Person_LicenseDataContext())
             {
                
                 db.USP_licensestatuschange(licid, newstatus, Convert.ToDateTime(newexpdate), statuschange, modifiedbt, Convert.ToDateTime(modifieddate));
                 db.SubmitChanges();
             }
         }
         public static List<USP_GetLicensehistorychangeResult> GetStatusHistory(int licid)
         {
             using (Person_LicenseDataContext db = new Person_LicenseDataContext())
             {
                 return db.USP_GetLicensehistorychange(licid).ToList();
             }
         }
        #endregion

         #region FinanceTab
         public static void InsertFinance(TBL_Accounting_FeeDetail fee)
         {
             using (Person_LicenseDataContext pld = new Person_LicenseDataContext())
             {
                 pld.USP_Licensing_FeeDetails(101,fee.FeeID,fee.Person_ID,fee.Application_ID,Convert.ToInt32(fee.Isverification),fee.Sub_org_Id,fee.SubOrgAmount.ToString() ,fee.DueDate,fee.Status,fee.modifiedby,fee.modifieddate,fee.Create_User,fee.Create_Date,fee.Is_RecurringFee,fee.Recurring_Days);
                 pld.SubmitChanges();
             }
         }

         public static List<USP_Licensing_GetFeeDetailsResult> Get_FeedetailsData(int appid)
         {
             using (Person_LicenseDataContext plc = new Person_LicenseDataContext())
             {
                 return plc.USP_Licensing_GetFeeDetails(appid).ToList();


             }
         }
        public static USP_Licensing_GetEditFeeDetailsResult GetEditFeeDetails(int personid,int feeid)
        {
            using(Person_LicenseDataContext pldc=new Person_LicenseDataContext())
            {
                return pldc.USP_Licensing_GetEditFeeDetails(personid, feeid).SingleOrDefault();
            }
        }

         public static List<USP_Licensing_GetPayerNameResult> Get_PayerName(int person_id)
         {
             using (Person_LicenseDataContext plc = new Person_LicenseDataContext())
             {
                 return plc.USP_Licensing_GetPayerName(person_id).ToList();


             }
         }

         public static List<USP_Licensing_AmountOwedDataResult> Get_AmountOwedData(string str)
         {
             using (Person_LicenseDataContext plc = new Person_LicenseDataContext())
             {
                 return plc.USP_Licensing_AmountOwedData(str).ToList();


             }

         }
         public static List<USP_Get_FinancePaymentHistoryDetailsResult> Get_PaymentHistory(int personid)
         {
             using (Person_LicenseDataContext plc = new Person_LicenseDataContext())
             {
                 return plc.USP_Get_FinancePaymentHistoryDetails(personid).ToList();


             }
         }

         public static List<USP_Licensing_GetFinanceVoidHistoryDetailsResult> Get_VoidHistory(int personid)
         {
             using (Person_LicenseDataContext plc = new Person_LicenseDataContext())
             {
                 return plc.USP_Licensing_GetFinanceVoidHistoryDetails(personid).ToList();


             }
         }
         public static List<USP_Finance_Get_FeeAuditHistoryDetailsResult> Get_AuditHistory(int personid)
         {
             using (Person_LicenseDataContext plc = new Person_LicenseDataContext())
             {
                 return plc.USP_Finance_Get_FeeAuditHistoryDetails(personid).ToList();


             }
         }
         public static int InsertSelected_Receipt(TBL_Accounting_Receipt ar)
         {
             using (Person_LicenseDataContext db = new Person_LicenseDataContext())
             {
                 int? latid = 0;
               USP_Licensing_ReceiptSelected_InsertionResult obj=  db.USP_Licensing_ReceiptSelected_Insertion(101, ar.Receipt_ID, ar.Receiptnum, ar.PayeerName,-1, Convert.ToDateTime(ar.DatePaid), ar.PaymentType.ToString(), ar.Checknum, ar.CCHolderName, ar.CCDigits, Convert.ToInt32(ar.IsVoid), ar.VoidReason_ID, Convert.ToInt32(ar.ISReReceipt), ar.ReReceiptFrom, ar.ReReceiptTo, ar.Batchnum, ar.Modifyby, Convert.ToDateTime(ar.Modifydate), ref latid).SingleOrDefault();
                 db.SubmitChanges();
                 return Convert.ToInt32( obj.Column1);
             }
         }
         public static List<USP_getpendingapplicationsResult> Getpending(string pid)
         {
             using(Person_LicenseDataContext db=new Person_LicenseDataContext())
             {
                 return db.USP_getpendingapplications(Convert.ToInt32(pid)).ToList();
             }
         }
         public static void Insert_FeeReceipt(TBL_Accounting_ReceiptDetail tbrd,TBL_Accounting_FeeDetail tafd)
         {
             using (Person_LicenseDataContext db = new Person_LicenseDataContext())
             {
                
                 db.USP_Licensing_ReceiptDetails(101,tbrd.ReceiptdetailsID,tbrd.ReceiptID,tbrd.Fee_ID,tbrd.Amount.ToString(),tbrd.ModifiedBY,tbrd.ModifiedDate,tafd.Status);
                 db.SubmitChanges();
             }
         }
         public static void Insert_feeaudit(TBL_Licensing_FeeAuditHistory feeaudit)
         {
             using (Person_LicenseDataContext pld = new Person_LicenseDataContext())
             {
                 pld.USP_Licensing_FeeAuditHistory(101, feeaudit.FeeAudit_Id, feeaudit.Fee_Type_Id, feeaudit.Amount.ToString(), feeaudit.TypeofAction, feeaudit.Datepaid, Convert.ToInt32(feeaudit.Modifiedby), Convert.ToDateTime(feeaudit.ModifiedDate), Convert.ToInt32(feeaudit.Create_User), Convert.ToDateTime(feeaudit.Create_Date));
                 pld.SubmitChanges();
             }
         }
         #endregion
        #region PersonAlertHistory
         public static List<USP_GetPersonAlert_DataResult> Person_AlertData(int perid)
         {
             using (Person_LicenseDataContext db = new Person_LicenseDataContext())
             {
                return db.USP_GetPersonAlert_Data(perid).ToList();
             }
         }
         public static int Updatealerthistory(int journalid,string modifyby,string modifydate)
         {
             using (Person_LicenseDataContext db = new Person_LicenseDataContext())
             {
                 db.USP_Journalalertrelease(journalid, modifyby, modifydate);
                 db.SubmitChanges();
                 return journalid;
             }
         }
        #endregion

        #region Contact Details
         public static int Insert_ContactDetails(int contactid,string personid,int contactype,string relid,string comments,string status,string stdate,string enddate,string createdby,string modifiedby,string percentage)
         {
             using (Person_LicenseDataContext pcontact = new Person_LicenseDataContext())
             {
                 tbl_Person_contact pcontactdetails;
                 if (contactid == 0)
                     pcontactdetails = new tbl_Person_contact();
                 else
                     pcontactdetails = pcontact.tbl_Person_contacts.Where(c => c.contact_id == contactid).SingleOrDefault();
                 if (contactype == 3 && contactid == 0)
                 {
                     List<tbl_Person_contact> lst = pcontact.tbl_Person_contacts.Where(c => c.Person_Id == personid && c.Contact_type == 3).ToList();
                     foreach (tbl_Person_contact b in lst)
                         b.Status = "Terminated";

                 }
                 pcontactdetails.contact_id = contactid;
                 pcontactdetails.Person_Id = personid;
                 pcontactdetails.Contact_type = contactype;
                 pcontactdetails.Relt_id = relid;
                 pcontactdetails.Comments = comments;
                 pcontactdetails.Status = status;
                 pcontactdetails.Start_dt = Convert.ToDateTime(stdate);
                 if(enddate!="")
                    pcontactdetails.End_dt = Convert.ToDateTime(enddate);
                pcontactdetails.Createdby = createdby;
                 pcontactdetails.Modifiedby = modifiedby;
                pcontactdetails.Percentage = percentage;
                 pcontactdetails.Createddt = Convert.ToDateTime(DateTime.Now.ToShortDateString());
                 pcontactdetails.Modifieddt = Convert.ToDateTime(DateTime.Now.ToShortDateString());
                 if (contactid == 0)
                     pcontact.tbl_Person_contacts.InsertOnSubmit(pcontactdetails);
                 pcontact.SubmitChanges();
                 return pcontactdetails.contact_id;
             }
         }

         public static int Insert_haspharmacyempDetails(int hasid, string personid, string relid, string status, string stdate, string enddate, string createdby, string modifiedby)
         {
             using (Person_LicenseDataContext phasemp = new Person_LicenseDataContext())
             {
                 tbl_has_pharmacyemp phaspharmacy;
                 if (hasid == 0)
                     phaspharmacy = new tbl_has_pharmacyemp();
                 else
                     phaspharmacy = phasemp.tbl_has_pharmacyemps.Where(c => c.has_emp_id == hasid).SingleOrDefault();
                 phaspharmacy.has_emp_id = hasid;
                 phaspharmacy.Person_id = personid;
                 phaspharmacy.relt_id = relid;
                 phaspharmacy.Status = status;
                 phaspharmacy.start_dt = Convert.ToDateTime(stdate);
                 phaspharmacy.End_dt = Convert.ToDateTime(enddate);
                 phaspharmacy.Createdby = createdby;
                 phaspharmacy.Modifiedby = modifiedby;
                 phaspharmacy.Createdt = Convert.ToDateTime(stdate);
                 phaspharmacy.Modifieddt = Convert.ToDateTime(enddate);
                 if (hasid == 0)
                     phasemp.tbl_has_pharmacyemps.InsertOnSubmit(phaspharmacy);
                 phasemp.SubmitChanges();
                 return phaspharmacy.has_emp_id;
             }
         }
        #endregion

         #region Controlled Substances


         public static int Controlled_Substances(int cerid, int pid, string certtype, string status1,  string effectdate, string expdate, string createdby, string createddate, string modifiedby, string modifieddate,int appid)
         {

             using (Person_LicenseDataContext pconsubinsert = new Person_LicenseDataContext())
             {
                 tbl_Certification cert;
                 if (cerid == 0)
                     cert = new tbl_Certification();
                 else
                     cert = pconsubinsert.tbl_Certifications.Where(c => c.Cert_id == cerid).SingleOrDefault();

                 cert.Cert_id = cerid;
                 cert.Person_id = pid;
                cert.App_ID = appid;
                 cert.Cert_Type = certtype;
                 cert.status = status1;
                 cert.Effective_dt = Convert.ToDateTime(effectdate);
                 cert.Expiry_dt = Convert.ToDateTime(expdate);
                 cert.createdby = createdby;
                 cert.createddt = Convert.ToDateTime(createddate);
                 cert.modifiedby = modifiedby;
                 cert.modifieddt = Convert.ToDateTime(modifieddate);


                 if (cerid == 0)
                     pconsubinsert.tbl_Certifications.InsertOnSubmit(cert);
                 pconsubinsert.SubmitChanges();
                 return cert.Cert_id;
             }
         }





         public static tbl_Certification Edit_Controlled_Substances(int cerid)
         {
             using (Person_LicenseDataContext pconsubedit = new Person_LicenseDataContext())
             {
                 return pconsubedit.tbl_Certifications.Where(c => c.Cert_id == cerid).SingleOrDefault();
             }
         }

         public static void Delete_Controlled_Substances(int cerid)
         {
             using (Person_LicenseDataContext pconsubdelete = new Person_LicenseDataContext())
             {
                 tbl_Certification obj = pconsubdelete.tbl_Certifications.Where(c => c.Cert_id == cerid).SingleOrDefault();
                 pconsubdelete.tbl_Certifications.DeleteOnSubmit(obj);
                 pconsubdelete.SubmitChanges();
             }
         }


         #endregion

        #region Inspection Details
         public static int Save_EditInformation(int insid, int pid,string instype, string insstatus, string insdate, string insscope, string staff,string description, string createdby)
         {

             using (Person_LicenseDataContext pldc = new Person_LicenseDataContext())
             {
                 tbl_Inspection_Journal insj;
                 if (insid == 0)
                     insj = new tbl_Inspection_Journal();
                 else
                     insj = pldc.tbl_Inspection_Journals.Where(c => c.Inspection_JournalID == insid).SingleOrDefault();

                 insj.Inspection_JournalID = insid;
                 insj.Inspection_Type = instype;
                 insj.PersonID = pid.ToString();
                 insj.Inspection_Status = insstatus;
                 insj.Inspection_Date = Convert.ToDateTime(insdate);
                 insj.Inspection_Scope = insscope;
                 insj.StaffAssigned = staff;
                 insj.Description = description;
                 insj.ModifiedBy = createdby;
                 insj.ModifiedDate = Convert.ToDateTime(DateTime.Now.ToShortDateString());

                 if (insid == 0)
                     pldc.tbl_Inspection_Journals.InsertOnSubmit(insj);
                 pldc.SubmitChanges();
                 return insj.Inspection_JournalID;
             }
         }
         public static List<tbl_lkp_InspectionStatus> Get_InspectionStatus()
         {
             using (Person_LicenseDataContext db = new Person_LicenseDataContext())
             {
                 return db.tbl_lkp_InspectionStatus.OrderBy(c => c.Status).ToList();
             }
         }
         public static List<USP_GetInspectionJournalResult> Get_InspectionJournal(int pid)
         {
             using (Person_LicenseDataContext pdb = new Person_LicenseDataContext())
             {
                 return pdb.USP_GetInspectionJournal(pid).ToList();
             }
         }
         public static tbl_Inspection_Journal Edit_Inspection(int insid)
         {
             using (Person_LicenseDataContext pdc = new Person_LicenseDataContext())
             {
                 return pdc.tbl_Inspection_Journals.Where(c => c.Inspection_JournalID == insid).SingleOrDefault();
             }
         }
         public static void Delete_Inspection(int insid)
         {
             using (Person_LicenseDataContext pdc = new Person_LicenseDataContext())
             {
                 tbl_Inspection_Journal insj = pdc.tbl_Inspection_Journals.Where(c => c.Inspection_JournalID == insid).SingleOrDefault();
                 pdc.tbl_Inspection_Journals.DeleteOnSubmit(insj);
                 pdc.SubmitChanges();
             }
         }
        
        #endregion

         #region  Inspection Journal

         public static int Inspection_Journal(int jornalid, int pid, string journaltype, string comments, string createdby, string createddate, string modifiedby, string modifieddate)
         {

             using (Person_LicenseDataContext inspjournalinsert = new Person_LicenseDataContext())
             {
                 tbl_Inspection_JournalDetail inspjournal;
                 if (jornalid == 0)
                     inspjournal = new tbl_Inspection_JournalDetail();
                 else
                     inspjournal = inspjournalinsert.tbl_Inspection_JournalDetails.Where(c => c.InspectionJournal_ID == jornalid).SingleOrDefault();

                 inspjournal.InspectionJournal_ID = jornalid;
                 inspjournal.Person_id = pid;
                 inspjournal.JournalType = journaltype;
                 inspjournal.Comments = comments;
                 inspjournal.CreateBy = Convert.ToInt32(createdby);
                 inspjournal.CreatedDate = Convert.ToDateTime(createddate);
                 inspjournal.ModifiedBy = Convert.ToInt32(modifiedby);
                 inspjournal.ModifiedDate = Convert.ToDateTime(modifieddate);


                 if (jornalid == 0)
                     inspjournalinsert.tbl_Inspection_JournalDetails.InsertOnSubmit(inspjournal);
                 inspjournalinsert.SubmitChanges();
                 return inspjournal.InspectionJournal_ID;
             }
         }





         public static tbl_Inspection_JournalDetail Edit_Inspection_JournalDetail(int jornalid)
         {
             using (Person_LicenseDataContext inspjournaledit = new Person_LicenseDataContext())
             {
                 return inspjournaledit.tbl_Inspection_JournalDetails.Where(c => c.InspectionJournal_ID == jornalid).SingleOrDefault();
             }
         }

         public static void Delete_Inspection_JournalDetail(int jornalid)
         {
             using (Person_LicenseDataContext inspjournaldelete = new Person_LicenseDataContext())
             {
                 tbl_Inspection_JournalDetail obj = inspjournaldelete.tbl_Inspection_JournalDetails.Where(c => c.InspectionJournal_ID == jornalid).SingleOrDefault();
                 inspjournaldelete.tbl_Inspection_JournalDetails.DeleteOnSubmit(obj);
                 inspjournaldelete.SubmitChanges();
             }
         }
         public static List<USP_GetInspectionJournalValuesResult> GetinspectionDetails(int jid)
         {
             using (Person_LicenseDataContext plc = new Person_LicenseDataContext())
             {
                 return plc.USP_GetInspectionJournalValues(jid).ToList();
             }
         }
        #endregion

        #region WellnessDocument
        public static int InsertWellnessDocument(int wellid, string perid, string doctype, string docpath, string filename, string comments, string createdby, DateTime createddate)
        {
            using (Person_LicenseDataContext plc = new Person_LicenseDataContext())
            {
                plc.USP_WellnessDocument(101, wellid, perid, filename, doctype, docpath, comments, createdby, createddate);
                plc.SubmitChanges();
                return wellid;
            }
        }
        public static void DeleteWellnessDocument(int wellid)
        {
            using (Person_LicenseDataContext plc = new Person_LicenseDataContext())
            {
                plc.USP_WellnessDocument(102, wellid, null, null, null, null, null, null, null);
                plc.SubmitChanges();
            }
        }
        public static List<USP_WellnessDocumentResult> GetWellnessDocument(string perid)
        {
            using (Person_LicenseDataContext pldc = new Person_LicenseDataContext())
            {
                return pldc.USP_WellnessDocument(103, null, perid, null, null, null, null, null, null).ToList();
            }
        }
        public static tbl_Person_wellness_Document GetAllWellnessDocument(string perid)
        {
            using(Person_LicenseDataContext pldc=new Person_LicenseDataContext())
            {
                return pldc.tbl_Person_wellness_Documents.Where(c => c.Person_ID == perid).FirstOrDefault();
            }
        }
        #endregion
        #region UpdateLicensetype
        public static bool? Update_Applicationlicensetype(string licno, string lictype, string newlictype, string createby)
        {
            using (Person_LicenseDataContext odc = new Person_LicenseDataContext())
            {
                bool? update = false;
                odc.USP_UpdateApplicationLicnesetype(licno, lictype, newlictype, createby, ref update);
                return update;
            }
        }
        #endregion
        #region total Amount
        public static List<USP_GetROCTotalAmountResult> GetRocTotalAmount(DateTime sdate, DateTime edate, int type, int feetype)
        {
            using (Person_LicenseDataContext pldc = new Person_LicenseDataContext())
            {
                return pldc.USP_GetROCTotalAmount(sdate, edate, feetype, type).ToList();
            }
        }
        public static List<USP_GetAllDocumentsDownloadResult> GetAlldocumentsDownload(int cmpid)
        {
            using (Person_LicenseDataContext pldc = new Person_LicenseDataContext())
            {
                return pldc.USP_GetAllDocumentsDownload(cmpid).ToList();
            }
        }
        #endregion
        #region PrintPaymentHistory
        public static List<USP_Get_Print_FinancePaymentHistoryResult> Get_Print_PaymentHistory(string personid)
        {
            using (Person_LicenseDataContext print = new Person_LicenseDataContext())
            {
                var i = print.USP_Get_Print_FinancePaymentHistory(personid).ToList();
                return i;

            }
        }
        #endregion
        #region ContactSearch
        public static List<USP_GetContactSearchResult> GetContactSearch(string contacttype, string fname, string lname, string dob, string ssn, string phone, string address, string city, string state, string county, string zip, string email, string sop)
        {
            if (sop == "1")
                sop = "%";
            else
                sop = "";
            using (Person_LicenseDataContext pldc = new Person_LicenseDataContext())
            {
                return pldc.USP_GetContactSearch(contacttype, fname, lname, ssn, dob, phone, address, city, state, county, zip, email, sop).ToList();
            }
        }
        #endregion
        #region Mail Sending When document upload
        public static List<USP_GetLicandCmpDetailsResult> GetLicandCmpDetails(string personid, int docid, string lictype, int cmpid)
        {
            using (Person_LicenseDataContext pldc = new Person_LicenseDataContext())
            {
                return pldc.USP_GetLicandCmpDetails(personid, docid, lictype, cmpid).ToList();
            }
        }
        #endregion
        #region Online Complaints
        public static List<USP_GetOnlineComplaintsDetailsResult> GetOnlineComplaints(string startdate, string enddate)
        {
            using (Person_LicenseDataContext pldc = new Person_LicenseDataContext())
            {
                return pldc.USP_GetOnlineComplaintsDetails(startdate, enddate).ToList();
            }
        }
        #endregion

        #region Exam_Eligible Code

        public static int insertEligible(int examid, string personid, string examtype, string examdate, string createdby)
        {
            using (Person_LicenseDataContext lcd = new Person_LicenseDataContext())
            {
                Tbl_Exam_Eligible elig;
                if (examid == 0)
                    elig = new Tbl_Exam_Eligible();
                else
                    elig = lcd.Tbl_Exam_Eligibles.Where(a => a.Exam_EligibleID == examid).FirstOrDefault();
                elig.PersonID = personid;
                elig.ExamType = examtype;
                if (examdate != "")
                    elig.EligibleDate = Convert.ToDateTime(examdate);
                else
                    elig.EligibleDate = null;


                if (examid == 0)
                {
                    elig.CreatedBy = createdby;
                    elig.CreatedDate = Convert.ToDateTime(DateTime.Now.ToShortDateString());

                }
                else
                {
                    elig.ModifiedBy = createdby;
                    elig.ModifiedDate = Convert.ToDateTime(DateTime.Now.ToShortDateString());

                }

                if (examid == 0)

                    //adc.tbl_EmployeeDetails.InsertOnSubmit(emp);
                    //adc.SubmitChanges();
                    //return emp.Employe_ID;


                    lcd.Tbl_Exam_Eligibles.InsertOnSubmit(elig);
                lcd.SubmitChanges();
                return elig.Exam_EligibleID;


            }

        }
        public static List<USP_Exam_EligibleResult> binddetails(string pid)
        {
            using (Person_LicenseDataContext lcd = new Person_LicenseDataContext())
            {
                return lcd.USP_Exam_Eligible(pid).ToList();
            }
        }



        public static void Delete_Eligibility(int ExamEligibleid)
        {
            using (Person_LicenseDataContext lcd = new Person_LicenseDataContext())
            {
                Tbl_Exam_Eligible obj = lcd.Tbl_Exam_Eligibles.Where(c => c.Exam_EligibleID == ExamEligibleid).SingleOrDefault();
                lcd.Tbl_Exam_Eligibles.DeleteOnSubmit(obj);
                lcd.SubmitChanges();
            }
        }


        public static Tbl_Exam_Eligible Edit_Eligibility(int ExamEligibleid)
        {
            using (Person_LicenseDataContext lcd = new Person_LicenseDataContext())
            {
                return lcd.Tbl_Exam_Eligibles.Where(c => c.Exam_EligibleID == ExamEligibleid).SingleOrDefault();
            }
        }


        #endregion
        public static List<USP_GetAllDocumentsDownloadHearingResult> GetAlldocumentsDownloadHearing(int cmpid, int persid)
        {
            using (Person_LicenseDataContext pldc = new Person_LicenseDataContext())
            {
                return pldc.USP_GetAllDocumentsDownloadHearing(cmpid, persid).ToList();
            }
        }
        public static List<USP_GetAllDocumentsDownloadCRCResult> GetAlldocumentsDownloadCRC(int cmpid, int persid)
        {
            using (Person_LicenseDataContext pldc = new Person_LicenseDataContext())
            {
                return pldc.USP_GetAllDocumentsDownloadCRC(cmpid, persid).ToList();
            }
        }
        public static List<USP_GetWellnessDocumentsResult> GetAllWellnessDocuments(int pid)
        {
            using(Person_LicenseDataContext pldc=new Person_LicenseDataContext())
            {
                return pldc.USP_GetWellnessDocuments(pid).ToList();
            }
        }

        public static List<USP_GetInterviewReportResult> GetInterviewReport(string fromdate,string todate)
        {
            using(Person_LicenseDataContext pldc=new Person_LicenseDataContext())
            {
                return pldc.USP_GetInterviewReport(Convert.ToDateTime(fromdate), Convert.ToDateTime(todate)).ToList();
            }
        }

        #region InterviewDetails
        public static int InsertInterviewDetails(int auid, int personid, int appid, int complaintid, string interviewdate, string isappear, string createdby)
        {
            using (Person_LicenseDataContext pd = new Person_LicenseDataContext())
            {
                tbl_Interview_Report p;
                if (auid == 0)
                    p = new tbl_Interview_Report();
                else
                    p = pd.tbl_Interview_Reports.Where(c => c.Auid == auid).SingleOrDefault();
                p.PID = personid;
                p.App_Id = appid;
                p.Cmp_Id = complaintid;
                if (interviewdate != "")
                    p.Interview_Date = Convert.ToDateTime(interviewdate);
                else
                    p.Interview_Date = null;
                p.IS_Appear = isappear;

                if (auid == 0)
                {
                    p.Created_By = createdby;
                    p.Created_Date = Convert.ToDateTime(DateTime.Now.ToShortDateString());
                }
                else
                {
                    p.Modified_By = createdby;
                    p.Modified_Date = Convert.ToDateTime(DateTime.Now.ToShortDateString());
                }

                if (auid == 0)
                    pd.tbl_Interview_Reports.InsertOnSubmit(p);
                pd.SubmitChanges();
                return p.Auid;

            }


        }

        public static List<USP_GetInterviewDetailsResult> GetPersonInterview(int personid)
        {
            using (Person_LicenseDataContext db = new Person_LicenseDataContext())
            {
                return db.USP_GetInterviewDetails(personid).ToList();
            }
        }
        public static tbl_Interview_Report GetInterviewDetails(int auid)
        {
            using (Person_LicenseDataContext pldc = new Person_LicenseDataContext())
            {
                return pldc.tbl_Interview_Reports.Where(c => c.Auid == auid).FirstOrDefault();
            }
        }
        public static void DeleteInterviewDetails(int auid)
        {
            using (Person_LicenseDataContext pldc = new Person_LicenseDataContext())
            {
                tbl_Interview_Report interview = pldc.tbl_Interview_Reports.Where(c => c.Auid == auid).FirstOrDefault();
                pldc.tbl_Interview_Reports.DeleteOnSubmit(interview);
                pldc.SubmitChanges();
            }
        }
        #endregion
        #region  Discipline
        public static int InsertDiscipline
            (
            int DisciplineID,
            int PersonID,
            string LicenseNumber,
            string CaseNumber,
            string StartDate,
            string EndDate,
            string StateOfDiscipline,
            string BriefSynopsis,
            string ReviewerComment,
            string DocumentPatha,
            string createdby)
        {

            using (Person_LicenseDataContext ins = new Person_LicenseDataContext())
            {
                Discipline d;
                if (DisciplineID == 0)
                    d = new Discipline();
                else
                    d = ins.Disciplines.Where(c => c.DisciplineID == DisciplineID).SingleOrDefault();
                d.DisciplineID = DisciplineID;
                d.PersonID = PersonID;
                d.LicenseNumber = LicenseNumber;
                d.CaseNumber = CaseNumber;
                if (StartDate != "")
                    d.StartDate = Convert.ToDateTime(StartDate);
                else
                    d.StartDate = null;
                if (EndDate != "")
                    d.EndDate = Convert.ToDateTime(EndDate);
                else
                    d.EndDate = null;
                d.StateOfDiscipline = StateOfDiscipline;
                d.BriefSynopsis = BriefSynopsis;
                d.ReviewerComment = ReviewerComment;
                d.DocumentPath = DocumentPatha;
                d.CreatedBy = createdby;
                d.CreatedDate = Convert.ToDateTime(DateTime.Now.ToShortDateString());
                if (DisciplineID == 0)
                    ins.Disciplines.InsertOnSubmit(d);
                ins.SubmitChanges();
                return d.DisciplineID;
            }
        }
        public static Discipline Get_Discpline(int PersonID)
        {
            using (Person_LicenseDataContext db = new Person_LicenseDataContext())
            {
                return db.Disciplines.Where(c => c.PersonID == PersonID).SingleOrDefault();
            }


        }
        public static List<USP_GetDisciplineResult> Get_DocumentDisciline(int personid)
        {
            using (Person_LicenseDataContext plc = new Person_LicenseDataContext())
            {
                return plc.USP_GetDiscipline(personid).ToList();
            }
        }
        public static void Delete_Discpline(int DisciplineID)
        {
            using (Person_LicenseDataContext pldc = new Person_LicenseDataContext())
            {
                Discipline Disciplines = pldc.Disciplines.Where(c => c.DisciplineID == DisciplineID).FirstOrDefault();
                pldc.Disciplines.DeleteOnSubmit(Disciplines);
                pldc.SubmitChanges();
            }
        }
        public static Discipline Edit_Discpline(int dispid)
        {
            using (Person_LicenseDataContext pd = new Person_LicenseDataContext())
            {
                return pd.Disciplines.Where(c => c.DisciplineID == dispid).FirstOrDefault();
            }
        }
        public static void UpdateDisciplineDocument(int dispid, int personid, string licnumber, string casenmber, string startdate, string enddate, string stateofdiscipline, string brief, string docpath, string comments, string modifiedby)
        {
            using (Person_LicenseDataContext pldc = new Person_LicenseDataContext())
            {
                if (startdate == "")
                    startdate = null;
                if (enddate == "")
                    enddate = null;
                pldc.USP_DisciplineUpdateDocuments(dispid, personid, licnumber, casenmber, startdate, enddate, stateofdiscipline, brief, docpath, comments, modifiedby);
            }
        }
        #endregion

        #region  CsInventroy
        public static int InsertCsInventory(int csinventoryID, int PersonID, string csinventoryDate, string createdby)
        {

            using (Person_LicenseDataContext ins = new Person_LicenseDataContext())
            {
                tbl_CSinventory d;
                if (csinventoryID == 0)
                    d = new tbl_CSinventory();
                else
                    d = ins.tbl_CSinventories.Where(c => c.CSInventoryID == csinventoryID).SingleOrDefault();
                d.CSInventoryID = csinventoryID;
                d.PersonID = PersonID;

                if (csinventoryDate != "")
                    d.InventoryDate = Convert.ToDateTime(csinventoryDate);
                else
                    d.InventoryDate = null;


                d.CreatedBy = createdby;
                d.CreatedDate = Convert.ToDateTime(DateTime.Now.ToShortDateString());
                if (csinventoryID == 0)
                    ins.tbl_CSinventories.InsertOnSubmit(d);
                ins.SubmitChanges();
                return d.CSInventoryID;
            }
        }
        //public static Discipline Get_Discpline(int PersonID)
        //{
        //    using (Person_LicenseDataContext db = new Person_LicenseDataContext())
        //    {
        //        return db.Disciplines.Where(c => c.PersonID == PersonID).SingleOrDefault();
        //    }


        // }
        public static List<usp_csinventoryResult> Get_csinventory(int personid)
        {
            using (Person_LicenseDataContext plc = new Person_LicenseDataContext())
            {
                return plc.usp_csinventory(personid).Where(c => c.PersonID == personid).ToList();
            }
        }

        public static void Delete_csinvetory(int csinvetoryid)
        {
            using (Person_LicenseDataContext pldc = new Person_LicenseDataContext())
            {
                tbl_CSinventory Disciplines = pldc.tbl_CSinventories.Where(c => c.CSInventoryID == csinvetoryid).FirstOrDefault();
                pldc.tbl_CSinventories.DeleteOnSubmit(Disciplines);
                pldc.SubmitChanges();
            }
        }
        public static tbl_CSinventory Edit_CSinventory(int csinventorypid)
        {
            using (Person_LicenseDataContext pd = new Person_LicenseDataContext())
            {
                return pd.tbl_CSinventories.Where(c => c.CSInventoryID == csinventorypid).FirstOrDefault();
            }
        }
       
        #endregion
    }
}
