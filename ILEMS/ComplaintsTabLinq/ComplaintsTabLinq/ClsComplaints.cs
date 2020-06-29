using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ComplaintsTabLinq
{
    public class ClsComplaints
    {
        public static List<GetComplaintsResult> GetComplaints(string RespType, int RespId)
        {
            using (ComplaintsTabDataContext dbCon = new ComplaintsTabDataContext())
            {
                return dbCon.GetComplaints(RespType, RespId).ToList();

            }
        }
        public static TbL_Complaint Get_ComplaintNumber(int cmpid)
        {
            using (ComplaintsTabDataContext ctdc = new ComplaintsTabDataContext())
            {
                return ctdc.TbL_Complaints.Where(c => c.Complaint_ID == cmpid).SingleOrDefault();
            }
        }
        public static List<USP_GetPersonHisResult> Get_Personhis(string cmpid)
        {
            using (ComplaintsTabDataContext dbCon = new ComplaintsTabDataContext())
            {
                return dbCon.USP_GetPersonHis(cmpid).ToList();

            }
        }
        public static TbL_Complaint GetComplaintDetailsForEdit(int CompId)
        {
            using (ComplaintsTabDataContext db = new ComplaintsTabDataContext())
            {
                return db.TbL_Complaints.Where(c => c.Complaint_ID == CompId).SingleOrDefault();
            }
        }

        public static List<tbl_lkp_data> Get_Lkp_tablesdata(int tbllkpid)
        {
            using (ComplaintsTabDataContext db = new ComplaintsTabDataContext())
            {
                return db.tbl_lkp_datas.Where(c => c.Lkp_tbl_ID == tbllkpid).OrderBy(c=>c.Values).ToList();
            }
        }

        public static void CompaintsUpdateValues(TbL_Complaint ObjCompUpdate)
        {
            using (ComplaintsTabDataContext dbUpdate = new ComplaintsTabDataContext())
            {
                TbL_Complaint obj = ObjCompUpdate;
                dbUpdate.SubmitChanges();
            }
        }


        public static void SummaryInsertValues(TbL_Complaints_Summary ObjtblCompSummary)
        {
          using (ComplaintsTabDataContext dbInsertSummary = new ComplaintsTabDataContext())
            {

                dbInsertSummary.USP_ComplaintsSummary(101, Convert.ToInt32(ObjtblCompSummary.SummaryComplaintID), Convert.ToInt32(ObjtblCompSummary.Cmpid), ObjtblCompSummary.SummaryArea, ObjtblCompSummary.CreateUser, ObjtblCompSummary.CreatedDate);
               dbInsertSummary.SubmitChanges();
            }
        }

        public static void SummarysUpdateValues(TbL_Complaints_Summary ObjtblComp)
        {
           using (ComplaintsTabDataContext dbUpdateSummary = new ComplaintsTabDataContext())
            {

               dbUpdateSummary.USP_ComplaintsSummary(102, Convert.ToInt32(ObjtblComp.SummaryComplaintID), Convert.ToInt32(ObjtblComp.Cmpid), ObjtblComp.SummaryArea, ObjtblComp.CreateUser, ObjtblComp.CreatedDate);
               dbUpdateSummary.SubmitChanges();
            }
        }

        public static void InsertUpdateDeleteRelevantHistory(TbL_Complaints_Relevant objtblCompRelevant)
        {
            using (ComplaintsTabDataContext dbInsertRelevant = new ComplaintsTabDataContext())
            {
                if (objtblCompRelevant.RelevantHistoryID == 0)
                {
                    dbInsertRelevant.USP_Complaints_TbL_Complaints_RelevantIUD(101, objtblCompRelevant.RelevantHistoryID, Convert.ToInt16(objtblCompRelevant.Cmpid), objtblCompRelevant.RelevantArea, objtblCompRelevant.CreatedUser, objtblCompRelevant.CreatedDate);
                }
                else
                {
                    dbInsertRelevant.USP_Complaints_TbL_Complaints_RelevantIUD(102, objtblCompRelevant.RelevantHistoryID, Convert.ToInt16(objtblCompRelevant.Cmpid), objtblCompRelevant.RelevantArea, objtblCompRelevant.CreatedUser, objtblCompRelevant.CreatedDate);

                }
                dbInsertRelevant.SubmitChanges();
            }
        }


        public static void InsertUpdateDeleteConclusion(TbL_Complaints_Conclusion objtblConclusion)
        {
            using (ComplaintsTabDataContext dbInsertConclus = new ComplaintsTabDataContext())
            {
                if (objtblConclusion.ConclusionID == 0)
                {
                    dbInsertConclus.USP_Complaints_ConclusionDetailsIUD(101, objtblConclusion.ConclusionID, objtblConclusion.Cmpid, objtblConclusion.ConclusionViolationID, objtblConclusion.ConclusionArea, objtblConclusion.CreatedUser, objtblConclusion.CreateDate);
                }
                else
                {

                    dbInsertConclus.USP_Complaints_ConclusionDetailsIUD(102, objtblConclusion.ConclusionID, objtblConclusion.Cmpid, objtblConclusion.ConclusionViolationID, objtblConclusion.ConclusionArea, objtblConclusion.CreatedUser, objtblConclusion.CreateDate);
                }
                dbInsertConclus.SubmitChanges();
            }
        }

        public static void InsertUpdateDeleteInvestigator(TbL_Complaints_Investigatior objtblInvest)
        {
            using (ComplaintsTabDataContext dbInsertInvest = new ComplaintsTabDataContext())
            {
                if (objtblInvest.Cmp_Investigation_Id == 0)
                {
                    dbInsertInvest.USP_Complaints_InvestigatiorDetailsIUD(101, objtblInvest.Cmp_Investigation_Id, objtblInvest.Cmp_Id, "", "",
                        objtblInvest.Create_Date.ToString(), objtblInvest.IsDrugDivisionChart, objtblInvest.IsPrescriptionProfileChart, objtblInvest.InvestigationComments, objtblInvest.Modified_By, objtblInvest.Modified_Date);
                }
                else
                {

                    dbInsertInvest.USP_Complaints_InvestigatiorDetailsIUD(102, objtblInvest.Cmp_Investigation_Id, objtblInvest.Cmp_Id, "", "",
                        objtblInvest.Create_Date.ToString(), objtblInvest.IsDrugDivisionChart, objtblInvest.IsPrescriptionProfileChart, objtblInvest.InvestigationComments, objtblInvest.Modified_By, objtblInvest.Modified_Date);
                }
                dbInsertInvest.SubmitChanges();
            }
        }
    }
}
