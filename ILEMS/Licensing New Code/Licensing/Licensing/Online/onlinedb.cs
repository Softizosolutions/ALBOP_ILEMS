using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Licensing.Online
{
    public static class onlinedb
            {
                public static tbl_RenewalProcess Getrenewaldet(string ordid)
                {
                    using (OnlineDataContext ldb = new OnlineDataContext())
                    {
                        return ldb.tbl_RenewalProcesses.Where(c => c.OrderID == ordid).SingleOrDefault();
                    }
                }
                public static int Save_Renewalprocess(int processid, string orderid, string renewalstatus, string processdate, string comments, string createdby)
                {
                    using (OnlineDataContext lcdc = new OnlineDataContext())
                    {
                        tbl_RenewalProcess rp;

                        rp = lcdc.tbl_RenewalProcesses.Where(c => c.OrderID == orderid).SingleOrDefault();
                        if (rp == null)
                            rp = new tbl_RenewalProcess();

                        rp.OrderID = orderid;
                        rp.RenewalStatus = renewalstatus;
                        if(processdate!="")
                        rp.ProcessDate = Convert.ToDateTime(processdate);
                        rp.Comments = comments;
                        rp.Createdby = createdby;
                        rp.CreatedDate = Convert.ToDateTime(DateTime.Now.ToString());

                        if (rp.Process_ID == 0)
                            lcdc.tbl_RenewalProcesses.InsertOnSubmit(rp);
                        if (renewalstatus == "1113")
                        {
                            Tbl_Renewal app = lcdc.Tbl_Renewals.Where(c => c.Order_id == orderid).SingleOrDefault();
                            app.IsProcess = true;
                            Person_Details.Licensing_Details.manualrenewal(app.Lic_Id, createdby);
                        }
                        lcdc.SubmitChanges();
                        return rp.Process_ID;

                    }
                }
      
        public static List<USP_getRenewaldataResult> getrenewaldata(string sdt, string edt, string ltype, string isprocess,string licno)
        {
            using (OnlineDataContext odb = new OnlineDataContext())
            {
                if (sdt == "")
                    sdt = DateTime.Now.ToShortDateString();
                if (edt == "")
                    edt = DateTime.Now.ToShortDateString();
                return odb.USP_getRenewaldata(Convert.ToDateTime(sdt), Convert.ToDateTime(edt), Convert.ToInt32(ltype), Convert.ToInt32(isprocess),licno).ToList();
            }
        }
        public static List<Person_Details.USP_getRenewaldata2018Result> getrenewaldata2018(string sdt, string edt, string ltype, string isprocess, string licno)
        {
            using (Person_Details.Person_LicenseDataContext odb = new Person_Details.Person_LicenseDataContext())
            {
                if (sdt == "")
                    sdt = DateTime.Now.ToShortDateString();
                if (edt == "")
                    edt = DateTime.Now.ToShortDateString();
                return odb.USP_getRenewaldata2018(Convert.ToDateTime(sdt), Convert.ToDateTime(edt), Convert.ToInt32(ltype), Convert.ToInt32(isprocess), licno).ToList();
            }
        }

        public static void Update_OnlinePharmacistDetails(int id, string modifyby, string Comments, int isproc)
        {
            using (OnlineDataContext odc = new OnlineDataContext())
            {
                int isedit = 1;
                tbl_pharmacistprocess cmp = odc.tbl_pharmacistprocesses.Where(c => c.Renewalid == id).FirstOrDefault();
                if (cmp == null)
                {
                    isedit = 0;
                    cmp = new Online.tbl_pharmacistprocess();
                }
                cmp.Renewalid = id;
                cmp.isprocessed = isproc;
                cmp.proccessedby = modifyby;
                cmp.comments = Comments;
                cmp.processdate = Convert.ToDateTime(DateTime.Now.ToShortDateString());
                if (isedit == 0)
                    odc.tbl_pharmacistprocesses.InsertOnSubmit(cmp);
                odc.SubmitChanges();
            }
        }
        public static void Delete_OnlinePharmacistDetails(int id, string modifyby, int isproc)
        {
            using (OnlineDataContext odc = new OnlineDataContext())
            {
                int isedit = 1;
                tbl_pharmacistprocess cmp = odc.tbl_pharmacistprocesses.Where(c => c.Renewalid == id).FirstOrDefault();
                if (cmp == null)
                {
                    isedit = 0;
                    cmp = new Online.tbl_pharmacistprocess();
                }
                cmp.Renewalid = id;
                cmp.isprocessed = isproc;
                cmp.proccessedby = modifyby;

                cmp.processdate = Convert.ToDateTime(DateTime.Now.ToShortDateString());
                if (isedit == 0)
                    odc.tbl_pharmacistprocesses.InsertOnSubmit(cmp);
                odc.SubmitChanges();
            }
        }
       
        public static void Update_OnlineComplaintsDetails(int id,string modifyby,string Comments)
        {
            using (OnlineDataContext odc = new OnlineDataContext())
            {
                tbl_OnlineComplaint cmp = odc.tbl_OnlineComplaints.Where(c => c.OnlineComplaint_ID == id).FirstOrDefault();
                cmp.Processed = true;
                cmp.Modified_By = modifyby;
                cmp.Comments = Comments;
                cmp.Modified_Date = Convert.ToDateTime(DateTime.Now.ToShortDateString());
                if (id == 0)
                    odc.tbl_OnlineComplaints.InsertOnSubmit(cmp);
                                 odc.SubmitChanges();
            }
        }
        public static tbl_OnlineComplaint Editcomplaints(int id)        {            using (OnlineDataContext odc = new OnlineDataContext())            {                return odc.tbl_OnlineComplaints.Where(c => c.OnlineComplaint_ID == id).SingleOrDefault();            }        }

    }
}