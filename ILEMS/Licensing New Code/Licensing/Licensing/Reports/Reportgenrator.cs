using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Microsoft.ApplicationBlocks.Data;
using System.Data;
namespace Licensing.Reports
{
    public class Reportgenrator
    {
        public static List<USP_getdellistResult> Getdellst(string refid,int type)
        {
            using (ReportToolDataContext rdb = new ReportToolDataContext())
            {
                return rdb.USP_getdellist(refid,type).ToList();
            }
        }
        public static List<VW_lkp_license_type> GetLicensetype()
        {
            using (ReportToolDataContext rtdc = new ReportToolDataContext())
            {
                return rtdc.VW_lkp_license_types.ToList();
            }
        }
        public static List<USP_GetinspectioninsideResult> GetinspectionInside(string sdt, string edt, string type)
        {
            using (ReportToolDataContext rdb = new ReportToolDataContext())
            {
                if (edt == "")
                    edt = sdt;
                return rdb.USP_Getinspectioninside(Convert.ToDateTime(sdt), Convert.ToDateTime(edt), type).ToList();
            }
        }
        public static List<USP_Getlink2displayResult> Getlinks(string utype)
        {
            using (ReportToolDataContext rdb = new ReportToolDataContext())
            {
                return rdb.USP_Getlink2display(utype).ToList();
            }
        }
        public static List<USP_Getsublink2displayResult> Getsublinks(string utype, string mid)
        {
            using (ReportToolDataContext rdb = new ReportToolDataContext())
            {
                return rdb.USP_Getsublink2display(utype,Convert.ToInt32(mid)).ToList();
            }
        }
        public static List<USP_Gettabs2displayResult> Gettabs(string utype)
        {
            using (ReportToolDataContext rdb = new ReportToolDataContext())
            {
                return rdb.USP_Gettabs2display(utype).ToList();
            }
        }
        public static List<USP_GetbatchcertResult> GetBatchPrints(string pid, string sdate,string edate,string licno,string certid)
        {
            using (ReportToolDataContext rtdc = new ReportToolDataContext())
            {
                if (sdate == "")
                    sdate = DateTime.Now.ToShortDateString();
                if(edate=="")
                    edate = DateTime.Now.ToShortDateString();
                return rtdc.USP_Getbatchcert(pid, Convert.ToDateTime(sdate), Convert.ToDateTime(edate),licno,certid).ToList();
            }
        }
        public static List<tbl_tabinfo> Gettabs()
        {
            using (ReportToolDataContext rdb = new ReportToolDataContext())
            {
                return rdb.tbl_tabinfos.ToList();
            }
        }
        public static List<USP_GetsublistResult> Getsubmenu(string menuid, string utype)
        {
            using (ReportToolDataContext rdb = new ReportToolDataContext())
            {
               return rdb.USP_Getsublist(Convert.ToInt32(menuid), utype).ToList();
            }
        }
        public static List<USP_GetPDMPResult> GetPDMPDetails()
        {
            using (ReportToolDataContext rdb = new ReportToolDataContext())
            {
                return rdb.USP_GetPDMP().ToList();
            }
        }
        public static List<USP_gettabinfoResult> Gettabinfo(string utype)
        {
            using (ReportToolDataContext rdb = new ReportToolDataContext())
            {
                return rdb.USP_gettabinfo(utype).ToList();
            }
        }
        public static List<USP_getdocinfoResult> Getdocnfo(string utype)
        {
            using (ReportToolDataContext rdb = new ReportToolDataContext())
            {
                return rdb.USP_getdocinfo(utype).ToList();
            }
        }
        public static void Insert_pageinfo(int auid, string utype, int mid,int sid, Boolean selval, string uid)
        {
            using (ReportToolDataContext rdb = new ReportToolDataContext())
            {
                tbl_User_Privillege obj = new tbl_User_Privillege();
                if (auid != 0)
                    obj = rdb.tbl_User_Privilleges.Where(c => c.Uprv_id == auid).SingleOrDefault();
                obj.Usertype = utype;
                obj.Menuid = mid;
                obj.Submenuid = sid;
                obj.Isselect = selval;
                if (auid == 0)
                {
                    obj.createdby = uid;
                    obj.createddt = DateTime.Now;
                    rdb.tbl_User_Privilleges.InsertOnSubmit(obj);
                }
                else
                {
                    obj.modifiedby = uid;
                    obj.modifieddt = DateTime.Now;
                }
                rdb.SubmitChanges();
            }
        }
        public static void Insert_docinfo(int auid, string utype, int docid, Boolean selval, string uid)
        {
            using (ReportToolDataContext rdb = new ReportToolDataContext())
            {
                tbl_user_doc obj = new tbl_user_doc();
                if (auid != 0)
                    obj = rdb.tbl_user_docs.Where(c => c.udoc_id == auid).SingleOrDefault();
                obj.Usertype = utype;
                obj.docid = docid;
                obj.Isselect = selval;
                if (auid == 0)
                {
                    obj.createdby = uid;
                    obj.createddt = DateTime.Now;
                    rdb.tbl_user_docs.InsertOnSubmit(obj);
                }
                else
                {
                    obj.modifiedby = uid;
                    obj.modifieddt = DateTime.Now;
                }
                rdb.SubmitChanges();
            }
        }
        public static void Insert_tabinfo(int auid, string utype, int tabid, Boolean selval, Boolean iswrite, Boolean isdel, string uid)
        {
            using (ReportToolDataContext rdb = new ReportToolDataContext())
            {
                tbl_user_tab obj = new tbl_user_tab();
                if (auid != 0)
                    obj = rdb.tbl_user_tabs.Where(c => c.utab_id == auid).SingleOrDefault();
                obj.Usertype = utype;
                obj.tabid = tabid;
                obj.Isselect = selval;
                obj.Iswrite = iswrite;
                obj.Isdelete = isdel;
                if (auid == 0)
                {
                    obj.createdby = uid;
                    obj.createddt = DateTime.Now;
                    rdb.tbl_user_tabs.InsertOnSubmit(obj);
                }
                else
                {
                    obj.modifiedby = uid;
                    obj.modifieddt = DateTime.Now;
                }
                rdb.SubmitChanges();
            }
        }
        public static List<tbl_Menu> GetMenus()
        {
            using (ReportToolDataContext rdb = new ReportToolDataContext())
            {
                return rdb.tbl_Menus.ToList();
            }
        }
        public static List<tbl_Sub_Menu> GetsubmenuMenus(string mid)
        {
            using (ReportToolDataContext rdb = new ReportToolDataContext())
            {
                return rdb.tbl_Sub_Menus.Where(c=>c.Menu_ID==Convert.ToInt32(mid)).ToList();
            }
        }
        public static List<USP_LicenseIssueCountResult> Getlicenseissue(DateTime sdt, DateTime edt)
        {
            using (ReportToolDataContext rdb = new ReportToolDataContext())
            {
                return rdb.USP_LicenseIssueCount(sdt, edt).ToList();
            }
        }
        public static List<USP_applicationtypecountResult> Getapplications(DateTime sdt, DateTime edt)
        {
            using (ReportToolDataContext rdb = new ReportToolDataContext())
            {
                return rdb.USP_applicationtypecount(sdt, edt).ToList();
            }
        }
        public static List<USP_ComplaintByCategoryResult> getcomplaintsbycategory(DateTime sdt, DateTime edt)
        {
            using (ReportToolDataContext rdb = new ReportToolDataContext())
            {
                return rdb.USP_ComplaintByCategory(sdt, edt).ToList();
            }
        }
        public static List<USP_GetrocResult> GetROC(int type, DateTime sdt, DateTime edt)
        {
            using (ReportToolDataContext rdb = new ReportToolDataContext())
            {
                return rdb.USP_Getroc(type, sdt, edt).ToList();
            }
        }
        public static List<USP_Getroc_detailsResult> GetROCDetails(int type, DateTime sdt, int id, DateTime edt)
        {
            using (ReportToolDataContext rdb = new ReportToolDataContext())
            {
                return rdb.USP_Getroc_details(type, sdt, id, edt).ToList();
            }
        }
        public static List<USP_FeeTypeCollectResult> Getfeetype(DateTime sdt, DateTime edt)
        {
            using (ReportToolDataContext rdb = new ReportToolDataContext())
            {
                return rdb.USP_FeeTypeCollect(sdt, edt).ToList();
            }
        }
        public static List<USP_getboardactionResult> getboardaction(DateTime sdt, DateTime edt)
        {
            using (ReportToolDataContext rdb = new ReportToolDataContext())
            {
                return rdb.USP_getboardaction(sdt, edt).ToList();
            }
        }
        public static List<USP_getresoleddaysResult> Getresolvedays(DateTime sdt, DateTime edt)
        {
            using (ReportToolDataContext rdb = new ReportToolDataContext())
            {
                return rdb.USP_getresoleddays(sdt, edt).ToList();
            }
        }
        public static List<USP_getrsolutionResult> GetResolution(DateTime sdt, DateTime edt)
        {
            using (ReportToolDataContext rdb = new ReportToolDataContext())
            {
                return rdb.USP_getrsolution(sdt, edt).ToList();
            }
        }
        public static void Delete_print(int printid)
        {
            using (ReportToolDataContext rdb = new ReportToolDataContext())
            {
                tbl_print obj = rdb.tbl_prints.Where(c => c.PrintID == printid).SingleOrDefault();
                rdb.tbl_prints.DeleteOnSubmit(obj);
                rdb.SubmitChanges();
            }
        }
        public static void Delete_rpt(int rptid)
        {
            using (ReportToolDataContext rdb = new ReportToolDataContext())
            {
                tbl_rpt_detail obj = rdb.tbl_rpt_details.Where(c => c.rptid == rptid).SingleOrDefault();
                rdb.tbl_rpt_details.DeleteOnSubmit(obj);
                rdb.SubmitChanges();
            }
        }
        public static List<tbl_rpt_detail> getallreports()
        {
            using (ReportToolDataContext rdb = new ReportToolDataContext())
            {
                return rdb.tbl_rpt_details.ToList();
            }
        }
        public static List<tbl_print> getprintsbytype(int fld)
        {
            using (ReportToolDataContext rdb = new ReportToolDataContext())
            {
                return rdb.tbl_prints.Where(c=>c.Folder==fld).ToList();
            }
        }
        public static List<VW_dash_cmpbycategory> Getcmpbycategory()
        {
            using (ReportToolDataContext rdb = new ReportToolDataContext())
            {
                return rdb.VW_dash_cmpbycategories.ToList();
            }
        }
        public static List<VW_dash_myfile> GetMyFiles()
        {
            using (ReportToolDataContext rdb = new ReportToolDataContext())
            {
                return rdb.VW_dash_myfiles.ToList();
            }
        }
        public static List<VW_dash_outstandingfee> GetOutStandingFee()
        {
            using (ReportToolDataContext rdb = new ReportToolDataContext())
            {
                return rdb.VW_dash_outstandingfees.ToList();
            }
        }
        public static List<VW_dash_outstandingfeefine> GetOutStandingFeeFines()
        {
            using (ReportToolDataContext rdb = new Reports.ReportToolDataContext())
            {
                return rdb.VW_dash_outstandingfeefines.ToList();
            }
        }
        public static List<VW_dash_licenseissuecount> Getlicissuecount()
        {
            using (ReportToolDataContext rdb = new ReportToolDataContext())
            {
                return rdb.VW_dash_licenseissuecounts.ToList();
            }
        }
        public static List<VW_dash_feetypecollect> Getfeetypecollect()
        {
            using (ReportToolDataContext rdb = new ReportToolDataContext())
            {
                return rdb.VW_dash_feetypecollects.ToList();
            }
        }
        public static tbl_print Get_printbyid(string id)
        {
            using (ReportToolDataContext rdb = new ReportToolDataContext())
            {
                return rdb.tbl_prints.Where(c => c.PrintID == Convert.ToInt32(id)).SingleOrDefault();
            }
        }

        public static string Save_rpt(string rptid, string rptname, string query, string fltrs, string ordby)
        {
            return SqlHelper.ExecuteScalar(System.Configuration.ConfigurationManager.AppSettings["Licensing_Con"].ToString(), "USP_Insert_rpt", new object[] { rptid, rptname, query, fltrs, ordby }).ToString();
        }
        public static int Getrptcount(string query)
        {
            return Convert.ToInt32(SqlHelper.ExecuteScalar(System.Configuration.ConfigurationManager.AppSettings["Licensing_Con"].ToString(), CommandType.Text, query));
        }
        public static void DeleteRecord(string refid, string type,string user)
        {
            
         SqlHelper.ExecuteNonQuery(System.Configuration.ConfigurationManager.AppSettings["Licensing_Con"].ToString(), "USP_Deleterecord", new object[]{refid,type,user});
       
        }

        public static DataSet Getrpt(string query)
        {
            return SqlHelper.ExecuteDataset(System.Configuration.ConfigurationManager.AppSettings["Licensing_Con"].ToString(), CommandType.Text, query);
        }
        public static List<vw_alltable> Getalltables()
        {
            using (ReportToolDataContext rdb = new ReportToolDataContext())
            {
                return rdb.vw_alltables.ToList();
            }
        }

        public static tbl_print Get_printdetails(string prntid)
        {
            using (ReportToolDataContext rdb = new ReportToolDataContext())
            {
                return rdb.tbl_prints.Where(c => c.PrintID == Convert.ToInt32(prntid)).SingleOrDefault();
            }
        }
        public static List<tbl_print> Get_printbytype(string type)
        {
            using (ReportToolDataContext rdb = new ReportToolDataContext())
            {
                return rdb.tbl_prints.Where(c => c.Folder == Convert.ToInt32(type)).ToList();
            }
        }
        public static List<vw_allview> Getallviews()
        {
            using (ReportToolDataContext rdb = new ReportToolDataContext())
            {
                return rdb.vw_allviews.Where(c=>c.view_name.Contains("rpt") || c.view_name.Contains("lkp") ).ToList();
            }
        }
        public static List<vw_allview> Getallviews_frm()
        {
            using (ReportToolDataContext rdb = new ReportToolDataContext())
            {
                return rdb.vw_allviews.Where(c => c.view_name.Contains("print")).ToList();
            }
        }
        public static List<USP_getallcolumnsResult> Getallcolumns(string obj)
        {
            using (ReportToolDataContext rdb = new ReportToolDataContext())
            {
                return rdb.USP_getallcolumns(obj).ToList();
            }
        }
        public static string Insert_print(int pid, string fltype, string vwname, string fname, string fltcond)
        {
            using (ReportToolDataContext rdb = new ReportToolDataContext())
            {
                tbl_print obj = new tbl_print();
                if (pid != 0)
                    obj = rdb.tbl_prints.Where(c => c.PrintID == pid).SingleOrDefault();
                obj.Folder = Convert.ToInt32(fltype);
                obj.Vwname = vwname;
                obj.fname = fname;
                obj.fltrcol = fltcond;
                if (pid == 0)
                rdb.tbl_prints.InsertOnSubmit(obj);
                rdb.SubmitChanges();
                return obj.PrintID.ToString();
            }
            
        }
        public static List<USP_GetComplaintDateReceivedResult> GetComplaintsDateReceived(DateTime fromdate,DateTime todate,string lictype,string usp795,string usp797)
        {
            using(ReportToolDataContext rdb=new ReportToolDataContext())
            {
                return rdb.USP_GetComplaintDateReceived(fromdate, todate, lictype, usp797, usp795).ToList();
            }
        }
        public static List<USP_GetLicensingComplaintsResult> GetComplaintsDateReceived1(DateTime fromdate, DateTime todate, string lictype, string usp795, string usp797)
        {
            using (ReportToolDataContext rdb = new ReportToolDataContext())
            {
                return rdb.USP_GetLicensingComplaints(fromdate, todate, lictype, usp797, usp795).ToList();
            }
        }

    }
}