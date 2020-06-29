using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
 

namespace ComplaintsLink
{
   public class Complaints
    {
       

        #region master_tables


       public static List<tbl_lkp_table> Get_Lkp_tables()
        {
            using (ComplaintsDataContext db = new ComplaintsDataContext())
            {
               

                return db.tbl_lkp_tables.OrderBy(c => c.Lkp_table_name).ToList();
            }
        }






        #endregion


        #region Complaint Insertion
        public static void ComplaintInsertValues(TbL_Complaint complaint)
        {
            using (ComplaintsDataContext dbInsert = new ComplaintsDataContext())
            {

                string cmpnumber = "";
                dbInsert.USP_Licensing_Complaints(101, complaint.Complaint_ID, complaint.Respondent_type, complaint.Respondent_ID, complaint.Complaint_Number,
                   Convert.ToInt16(complaint.Source_Id), Convert.ToInt16(complaint.Category_Id), complaint.DateReceived.ToString(), complaint.DateDocketed.ToString(), complaint.Address1, complaint.Address2,
                    complaint.City, complaint.State, complaint.Zip, Convert.ToInt16(complaint.PersonResponcible_ID), complaint.ComplaintType, Convert.ToInt16(complaint.InvestiGator_ID), complaint.SecondInvestigatiorID,
                    complaint.DateInvestigatorAssigned, complaint.DateInvestigatorReceived, complaint.Consultant, complaint.CompanionCase_ID, complaint.Compainant, complaint.Complaint_Status,
                    complaint.check_number, complaint.Create_User, complaint.Create_Date, ref cmpnumber);

                dbInsert.SubmitChanges();



            }
        }


        public static List<USP_GetComplaintInfobyPersonidResult> getcomplaintinfo(int personid)
        {
            using (ComplaintsDataContext pdb = new ComplaintsDataContext())
            {
                return pdb.USP_GetComplaintInfobyPersonid(personid).ToList();
            }
        }

        public static List<USP_Complaints_GetComplaintSearchResult> getpersonserch(string lname, string fname, string ssn, string dob, string licno, string complaint_Number, string complainant)
        {


            using (ComplaintsDataContext pdb = new ComplaintsDataContext())
            {

                return pdb.USP_Complaints_GetComplaintSearch(lname, fname, ssn, dob, licno, complaint_Number, complainant).ToList();
            }
        }

        public static List<USP_Licensing_GetComplaintDetailsForEditResult> getComplaints(int compid)
        {


            using (ComplaintsDataContext pdb = new ComplaintsDataContext())
            {

                return pdb.USP_Licensing_GetComplaintDetailsForEdit(compid).ToList();
               
            }
        }


        #endregion


        #region Complaint Participant

        public static int Insert_Complaint_Participant(int cmpgenid, int cmpid, string parttype, int partid, string roleid, int modifyby, int createby, string modifydate, string createdate)
        {
            using (ComplaintsDataContext cd = new ComplaintsDataContext())
            {
                TbL_Complaints_Participant cp;
                if (cmpgenid == 0)
                    cp = new TbL_Complaints_Participant();
                else
                    cp = cd.TbL_Complaints_Participants.Where(c => c.Cmp_Paticipant_ID == cmpgenid).SingleOrDefault();
                cp.Cmp_Paticipant_ID = cmpgenid;
                cp.Complaint_ID = cmpid;
                cp.Participant_Type = parttype;
                cp.Participant_ID = partid;
                cp.Role_ID = roleid;
                cp.modifiedBy = modifyby;
                cp.modifiedDate = Convert.ToDateTime(modifydate);
                cp.Create_User = createby;
                cp.Create_Date = Convert.ToDateTime(createdate);
                if (cmpgenid == 0)
                    cd.TbL_Complaints_Participants.InsertOnSubmit(cp);
                cd.SubmitChanges();
                return cp.Cmp_Paticipant_ID;
            }
        }

        public static int Complaint_Participant_InsertValues(TbL_Complaints_Participant participant,int flag)
        {
            int? i=0;
            using (ComplaintsDataContext dbInsert = new ComplaintsDataContext())
            {
                dbInsert.USP_Complaints_PaticipantDetailsIUD(flag, participant.Cmp_Paticipant_ID, participant.Complaint_ID, participant.Participant_Type, participant.Participant_ID,
                    participant.Role_ID, participant.IsExpected, participant.modifiedBy, participant.modifiedDate,participant.Name,participant.Address,participant.City,participant.State, ref i );
                dbInsert.SubmitChanges();
                return  i.Value;
            }
        }

        public static List<USP_GetComplaint_ParticipantResult> getComplaint_Participant(int compID)
        {
            using (ComplaintsDataContext pdb = new ComplaintsDataContext())
            {
                return pdb.USP_GetComplaint_Participant(compID).ToList();
            }

        }

        #endregion

        #region Complaint Service

       
        public static int Complaint_Service_InsertValues(TbL_Complaints_Service service)
        {
            int? i = 0;
            using (ComplaintsDataContext dbInsert = new ComplaintsDataContext())
            {

                if (service.Cmp_Service_Id > 0)
                {

                    dbInsert.USP_Complaints_PaticipantServiceDetailsIUD_(102, service.Cmp_Service_Id, service.Complaint_Id, service.Cmp_Paticipant_Id,
                        service.DocumentType, service.Service_Type_ID, service.Is_Effectuated, service.NoticeDate.ToString(), service.ServedDate.ToString(), service.DeliveryDate.ToString(),
                        service.ReturnDate.ToString(), service.AttemptedDate.ToString(), service.Reason, service.Comments, service.County, service.TrackingNo, service.Requester,
                        service.Mailnumber, service.MailedDate.ToString(), service.NotSatisfied, service.Undeliverable, service.Is_Service_Archieved, service.Is_Service_Delivered,
                        service.Service_Satisfied, service.ModifiedBy, service.ModifiedDate, ref i);
                }
                else
                {

                    dbInsert.USP_Complaints_PaticipantServiceDetailsIUD_(101, service.Cmp_Service_Id, service.Complaint_Id, service.Cmp_Paticipant_Id,
                           service.DocumentType, service.Service_Type_ID, service.Is_Effectuated, service.NoticeDate.ToString(), service.ServedDate.ToString(), service.DeliveryDate.ToString(),
                           service.ReturnDate.ToString(), service.AttemptedDate.ToString(), service.Reason, service.Comments, service.County, service.TrackingNo, service.Requester,
                           service.Mailnumber, service.MailedDate.ToString(), service.NotSatisfied, service.Undeliverable, service.Is_Service_Archieved, service.Is_Service_Delivered,
                           service.Service_Satisfied, service.ModifiedBy, service.ModifiedDate, ref i);
                }

                dbInsert.SubmitChanges();
                return i.Value;
            }
        }
        public static int Complaint_ServiceAttemptedDate_InsertValues(TbL_Complaints_Service_AttemptedDate attemptedDate)
        {
            int? i = 0;
            int Is_default=0;
            if(attemptedDate.Is_default==true)
            {
            
            Is_default=1;
            }
            using (ComplaintsDataContext dbInsert = new ComplaintsDataContext())
            {
                if (attemptedDate.Cmp_Attempdate_Id > 0)
                {
                    dbInsert.USP_Complaints_Service_AttemDateIUD(101, attemptedDate.Cmp_Attempdate_Id, attemptedDate.Cmp_Service_Id, attemptedDate.Complaint_Id,
                        attemptedDate.AttemptedDate, Is_default, attemptedDate.ModifiedBy, attemptedDate.ModifiedDate);
                }
                else
                {
                    dbInsert.USP_Complaints_Service_AttemDateIUD(102, attemptedDate.Cmp_Attempdate_Id, attemptedDate.Cmp_Service_Id, attemptedDate.Complaint_Id,
                           attemptedDate.AttemptedDate, Is_default, attemptedDate.ModifiedBy, attemptedDate.ModifiedDate);
                
                }
                    dbInsert.SubmitChanges();
               
                return i.Value;
            }




        }

        public static List<USP_GetComplaint_ServiceResult> getComplaint_Service(int compID,int partID)
        {
            using (ComplaintsDataContext pdb = new ComplaintsDataContext())
            {

                return pdb.USP_GetComplaint_Service(compID, partID).ToList();
            }

        }


        #endregion


        #region Attorney section

        public static int Complaint_Attorney_InsertValues(TbL_Complaints_Attorney attorney,int flag)
        {
            int i = 0;
            using (ComplaintsDataContext dbInsert = new ComplaintsDataContext())
            {

                i = dbInsert.USP_Cmp_PaticipantAttorneyDetailsIUD(flag, attorney.Cmp_Attoerney_Id, attorney.cmp_ParticipantID, attorney.ComplaintId, attorney.Attorney_ID, attorney.Status,
                    attorney.ModifiedBy, attorney.ModifiedDate, attorney.Name, attorney.Address, attorney.City, attorney.State);


              return i;
            }
        }

        public static List<USP_GetComplaintAttorneyResult> getComplaint_Attorney(int compID,int partID)
        {
            using (ComplaintsDataContext pdb = new ComplaintsDataContext())
            {

                return pdb.USP_GetComplaintAttorney(compID, partID).ToList();
            }

        }


        #endregion



        #region Events section



        public static int Complaint_Events_InsertValues(TbL_Complaints_Event events)
        {
            int i = 0;
            using (ComplaintsDataContext dbInsert = new ComplaintsDataContext())
            {
                if (events.CompEventId > 0 &&   events.Cmp_Id == null)
                {
                     i = dbInsert.USP_Complaints_EventsDetailsIUD(103, events.CompEventId, events.Cmp_Id, events.EventDate, events.EventTime, events.EventType,
                        events.EventResPerson, events.EventRem, events.Comments, events.ModifiedBy, events.ModifiedDate, events.Participant_ID.ToString());

                  
                }
                else if (events.CompEventId > 0 && events.Cmp_Id>0)
                {

                     i = dbInsert.USP_Complaints_EventsDetailsIUD(102, events.CompEventId, events.Cmp_Id, events.EventDate, events.EventTime, events.EventType,
                        events.EventResPerson, events.EventRem, events.Comments, events.ModifiedBy, events.ModifiedDate, events.Participant_ID.ToString());
                }
                else
                {
                    i = dbInsert.USP_Complaints_EventsDetailsIUD(101, events.CompEventId, events.Cmp_Id, events.EventDate, events.EventTime, events.EventType,
                           events.EventResPerson, events.EventRem, events.Comments, events.ModifiedBy, events.ModifiedDate, events.Participant_ID.ToString());
                
                }


                return i;
            }
        }

        public static List< USP_GetComplaintEventsResult> getComplaint_Events(int compID,int partID)
        {
            using (ComplaintsDataContext pdb = new ComplaintsDataContext())
            {

                return pdb.USP_GetComplaintEvents(compID, partID).ToList();
            }

        }


        #endregion



        #region Journal Section



        public static int Complaint_Journal_InsertValues(TbL_Complaints_Journal journal,int flag)
        {
            int i = 0;
            using (ComplaintsDataContext dbInsert = new ComplaintsDataContext())
            {

                i = dbInsert.USP_Complaints_JournalIUD(flag, journal.Journal_ID, journal.Cmp_ID, journal.participantId, Convert.ToUInt16(journal.JournalType),
                    journal.Comments, journal.ModifiedBy, journal.ModifiedDate);

                
                return i;
            }
        }

        public static List<USP_GetCompliantJournalEditResult> getComplaint_Journals(int compID, int jouID)
        {
            using (ComplaintsDataContext pdb = new ComplaintsDataContext())
            {

                return pdb.USP_GetCompliantJournalEdit(compID, jouID).ToList();
            }

        }


        #endregion



        #region Companion Section

        public static List<USP_GetComplaintCompanionCasesResult> getComplaint_CompanionCases(int compID)
        {
            using (ComplaintsDataContext pdb = new ComplaintsDataContext())
            {

                return pdb.USP_GetComplaintCompanionCases(compID).ToList();
            }

        }

        #endregion



        #region Prosecution Tab

        #region FINDING OF FACTS


        public static int Complaint_FindingOfFacts_InsertValues(TbL_Complaints_FindingOfFact facts, int flag)
        {
            int i = 0;
            using (ComplaintsDataContext dbInsert = new ComplaintsDataContext())
            {

                i = dbInsert.USP_Complaints_tbl_FindingFactsDetailsIUD(flag, facts.Cmp_FindfactsId, facts.Cmpid, facts.FindingOfFact, facts.CreateUser, facts.CreatedDate);
                return i;
            }
        }

        public static List<USP_Complaint_GetFindingOfFactsResult> getComplaint_FindingOfFacts(int compID, int jouID)
        {
            using (ComplaintsDataContext pdb = new ComplaintsDataContext())
            {

                return pdb.USP_Complaint_GetFindingOfFacts(compID).ToList();
            }

        }




        #endregion

        #region CONCLUSION OF LAW

        public static int Complaint_ConclusionOfLaw_InsertValues(TbL_Complaints_ConclusionOfLaw tbl, int flag)
        {
            int i = 0;
            using (ComplaintsDataContext dbInsert = new ComplaintsDataContext())
            {

                i = dbInsert.USP_Complaints_ConclusionOflaw_IUD(flag, tbl.ConclusionLaw_Id,Convert.ToInt16( tbl.Cmp_Id), tbl.ConclusionLawcode, tbl.ConclusionText, tbl.ModifiedBy, tbl.ModifiedDate);
                return i;
            }
        }

      


        #endregion

        #region CONSENT ORDER



        public static int Complaint_ConsentOffer_InsertValues(Tbl_Complaints_ConsentOffer tblconsent, int flag)
        {
            int i = 0;
            using (ComplaintsDataContext dbInsert = new ComplaintsDataContext())
            {

                i = dbInsert.USP_Complaints_ConsentOfferDetailsIUD(flag, tblconsent.ConsentOffer_ID, tblconsent.Cmp_Id, tblconsent.ChooseOffer, tblconsent.FineAmount,
                    tblconsent.ProbationLength, tblconsent.IsProationTillCondition, tblconsent.SuspensionLength, tblconsent.IsSuspensionTillCondition, tblconsent.SelectCourses,
                    tblconsent.Offer_date, tblconsent.Due_date, tblconsent.modifiedby, tblconsent.modifieddate);
                return i;
            }
        }

        public static List<USP_Complaint_GetConsentOfferResult> getComplaint_ConsentOffer(int compID)
        {
            using (ComplaintsDataContext pdb = new ComplaintsDataContext())
            {

                return pdb.USP_Complaint_GetConsentOffer(compID).ToList();
            }

        }



        #endregion

        #region FORMAL HEARING

        public static int Complaint_FormalHearing_InsertValues(int hearingid, int cmpid, int perid, string hearingdate, string hearingtime, string isrepondent, bool tbd, int createdby, bool setteld, bool ignore, string count)
        {

            using (ComplaintsDataContext dbInsert = new ComplaintsDataContext())
            {

                TbL_Complaints_FormalHearing cmphearing;
                if (hearingid == 0)
                    cmphearing = new TbL_Complaints_FormalHearing();
                else
                    cmphearing = dbInsert.TbL_Complaints_FormalHearings.Where(c => c.Hearing_Id == hearingid).SingleOrDefault();
                cmphearing.Hearing_Id = hearingid;
                cmphearing.Cmp_Id = cmpid;
                cmphearing.Person_ID = perid;
                if (hearingdate != "")
                    cmphearing.HearingDate = Convert.ToDateTime(hearingdate.ToString());
                cmphearing.HearingTime = hearingtime;
                cmphearing.IsRespondent = isrepondent;
                cmphearing.Hearing_Status = 0;
                cmphearing.IsContinued = true;
                cmphearing.HearingLocation = count;
                cmphearing.TBD = tbd;
                cmphearing.Settled = setteld;
                cmphearing.Ignore = ignore;
                if (hearingid == 0)
                {
                    cmphearing.Create_User = createdby;
                    cmphearing.Create_Date = DateTime.Now;
                }
                else
                {
                    cmphearing.ModifiedBy = createdby;
                    cmphearing.ModifiedDate = DateTime.Now;
                }
                if (hearingid == 0)
                    dbInsert.TbL_Complaints_FormalHearings.InsertOnSubmit(cmphearing);
                dbInsert.SubmitChanges();
                return cmphearing.Hearing_Id;
            }
        }

        public static List<USP_Complaint_GetFormalHearingResult> getComplaint_FormalHearing(int compID)
        {
            using (ComplaintsDataContext pdb = new ComplaintsDataContext())
            {

                return pdb.USP_Complaint_GetFormalHearing(compID).ToList();
            }

        }
        public static void Delete_ComplaintsFormalHearing(int hearingid)
        {
            using (ComplaintsDataContext cdc = new ComplaintsDataContext())
            {
                TbL_Complaints_FormalHearing cmphearing = cdc.TbL_Complaints_FormalHearings.Where(c => c.Hearing_Id == hearingid).SingleOrDefault();
                cdc.TbL_Complaints_FormalHearings.DeleteOnSubmit(cmphearing);
                cdc.SubmitChanges();

            }
        }

        public static int Insert_HearingDocument(int hearingid, int cmpid, int personid, string duedate, string receiveddoc, string createdby,string doctype)
        {
            using (ComplaintsDataContext cdc = new ComplaintsDataContext())
            {
                tbl_Complaints_Hearing_Document hearing;
                if (hearingid == 0)
                    hearing = new tbl_Complaints_Hearing_Document();
                else
                    hearing = cdc.tbl_Complaints_Hearing_Documents.Where(c => c.Hearing_Document_ID == hearingid).SingleOrDefault();
                hearing.Hearing_Document_ID = hearingid;
                hearing.Cmp_ID = cmpid;
                hearing.Person_ID = personid;
                if (duedate != "")
                    hearing.Document_Due_Date = Convert.ToDateTime(duedate);
                hearing.Document_Received = receiveddoc;
                hearing.Document_Type = doctype;
                if (hearingid == 0)
                {
                    hearing.Created_By = createdby;
                    hearing.Created_Date = Convert.ToDateTime(DateTime.Now.ToShortDateString());
                }
                else
                {
                    hearing.Modified_By = createdby;
                    hearing.Modified_Date = Convert.ToDateTime(DateTime.Now.ToShortDateString());
                }
                if (hearingid == 0)
                    cdc.tbl_Complaints_Hearing_Documents.InsertOnSubmit(hearing);
                cdc.SubmitChanges();
                return hearing.Hearing_Document_ID;

            }
        }
        public static tbl_Complaints_Hearing_Document GetHearingDocForEdit(int hearingid)
        {
            using (ComplaintsDataContext cdc = new ComplaintsDataContext())
            {
                return cdc.tbl_Complaints_Hearing_Documents.Where(c => c.Hearing_Document_ID == hearingid).SingleOrDefault();
            }
        }
        public static List<tbl_Complaints_Hearing_Document> GetHearingdocGrid(int cmpid, int personid)
        {
            using (ComplaintsDataContext cdc = new ComplaintsDataContext())
            {
                return cdc.tbl_Complaints_Hearing_Documents.Where(c => c.Cmp_ID == cmpid && c.Person_ID == personid).ToList();
            }
        }
        public static List<USP_GetComplaintsHearingDocumentResult> GetComplaintsHearingDocument(int cmpid,int perid)
        {
            using(ComplaintsDataContext cdc=new ComplaintsDataContext())
            {
                return cdc.USP_GetComplaintsHearingDocument(cmpid, perid).ToList();
            }
        }
        public static List<tbl_Complaints_Hearing_Document> GetFormalHearingDoc()
        {
            using (ComplaintsDataContext cdc = new ComplaintsDataContext())
            {
                return cdc.tbl_Complaints_Hearing_Documents.ToList();
            }
        }
        public static void DeleteFormalHearingdoc(int hearingid)
        {
            using (ComplaintsDataContext cdc = new ComplaintsDataContext())
            {
                tbl_Complaints_Hearing_Document obj = cdc.tbl_Complaints_Hearing_Documents.Where(c => c.Hearing_Document_ID == hearingid).SingleOrDefault();
                cdc.tbl_Complaints_Hearing_Documents.DeleteOnSubmit(obj);
                cdc.SubmitChanges();
            }
        }
        public static USP_GetNameandLicenseforHearingResult GetNameandLicense(int cmpid, int personid)
        {
            using (ComplaintsDataContext cdc = new ComplaintsDataContext())
            {
                return cdc.USP_GetNameandLicenseforHearing(cmpid, personid).FirstOrDefault();
            }
        }


        #endregion

        #region COMPLAINT RESOLUTION & ACTION


        public static int Complaint_Resolution_InsertValues(TbL_Complaints_Resolution tblRes, int flag)
        {
            int i = 0;
            using (ComplaintsDataContext dbInsert = new ComplaintsDataContext())
            {

                i = dbInsert.USP_Complaints_TbL_Complaints_ResolutionsIUD(flag, tblRes.Resolution_ID, tblRes.Cmp_ID,tblRes.Person_ID, tblRes.Resoutions.ToString(),Convert.ToDateTime( tblRes.DateofResolution).ToShortDateString(),
                    tblRes.BoardAction.ToString(),tblRes.DateofAction.ToString(), tblRes.ModifiedBy, tblRes.ModifiedDate);
                return i;
            }
        }
        public static List<USP_GetResolutionhistoryResult> GetResolutionHistory(string pid)
        {
            using (ComplaintsDataContext cdc = new ComplaintsDataContext())
            {
                return cdc.USP_GetResolutionhistory(pid).ToList();
            }
        }
        public static List<USP_Complaint_GetResolutionResult> getComplaint_Resolution(int compID)
        {
            using (ComplaintsDataContext pdb = new ComplaintsDataContext())
            {

                return pdb.USP_Complaint_GetResolution(compID).ToList();
            }

        }




        #endregion

        #region VIOLATION


        public static int Complaint_Violation_InsertValues(TbL_Complaints_Violation tblVol, int flag)
        {
            int i = 0;
            using (ComplaintsDataContext dbInsert = new ComplaintsDataContext())
            {

                i = dbInsert.USP_Complaints_TbL_Complaints_ViolationsIUD(flag, tblVol.Violation_ID, tblVol.Cmp_ID, tblVol.Violations, tblVol.DateAdded.ToString(), tblVol.EnteredBy,
                    tblVol.ModifiedBy, tblVol.ModifiedDate, tblVol.Public_Info);

                return i;
            }
        }

        public static List<USP_Complaint_GetViolationsResult> getComplaint_Violation(int compID)
        {
            using (ComplaintsDataContext pdb = new ComplaintsDataContext())
            {

                return pdb.USP_Complaint_GetViolations(compID).ToList();
            }

        }





        #endregion


        #endregion






        public static List<tbl_lkp_data> Get_Lkp_tablesdata(int tbllkpid)
        {
            using (ComplaintsDataContext db = new ComplaintsDataContext())
            {

                return db.tbl_lkp_datas.Where(c => c.Lkp_tbl_ID == tbllkpid).OrderBy(c=>c.Values).ToList();
            }
        }



        public static tbl_lkp_data Get_valuebyid(int dataid)
        {
            using (ComplaintsDataContext db = new ComplaintsDataContext())
            {
                return db.tbl_lkp_datas.Where(c => c.Lkp_data_ID == dataid).SingleOrDefault();
            }
        }


        public static int Save_Mastervalues(int dataid, int tableid, int orgid, string value)
        {
            using (ComplaintsDataContext db = new ComplaintsDataContext())
            {
                tbl_lkp_data obj_tbl_lkp_data;
                if (dataid == 0)
                    obj_tbl_lkp_data = new tbl_lkp_data();
                else
                    obj_tbl_lkp_data = db.tbl_lkp_datas.Where(c => c.Lkp_data_ID == dataid).SingleOrDefault();
                obj_tbl_lkp_data.Lkp_tbl_ID = tableid;
                obj_tbl_lkp_data.Org_ID = orgid;
                obj_tbl_lkp_data.Values = value;

                if (dataid == 0)
                    db.tbl_lkp_datas.InsertOnSubmit(obj_tbl_lkp_data);

                db.SubmitChanges();
                return obj_tbl_lkp_data.Lkp_data_ID;
            }
        }
        public static void Delete_Mastervalues(int dataid)
        {
            using (ComplaintsDataContext db = new ComplaintsDataContext())
            {
                tbl_lkp_data obj = db.tbl_lkp_datas.Where(c => c.Lkp_data_ID == dataid).SingleOrDefault();
                db.tbl_lkp_datas.DeleteOnSubmit(obj);
                db.SubmitChanges();
            }
        }

        #region ComplaintsFormalHearingReport
        public static List<USP_GetComplaintsFormalHearingReportResult> GetComplaintsFormalHearingReport(string fromdate, string todate)
        {
            using (ComplaintsDataContext cdc = new ComplaintsDataContext())
            {
                return cdc.USP_GetComplaintsFormalHearingReport(Convert.ToDateTime(fromdate), Convert.ToDateTime(todate)).ToList();
            }
        }
        #endregion

    }
}
