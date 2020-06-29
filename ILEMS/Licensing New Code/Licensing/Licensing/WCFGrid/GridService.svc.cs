using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Activation;
using System.ServiceModel.Web;
using System.Text;
using System.Web.Script.Serialization;

namespace Licensing.WCFGrid
{
    #region autogrid
    public static class JsonHelper
    {
        public static string ToJson(this object obj)
        {
            var serializer = new JavaScriptSerializer();
            return serializer.Serialize(obj);
        }
        
        public static string ToJson(this object obj, int recursionDepth)
        {
            var serializer = new JavaScriptSerializer();
            serializer.RecursionLimit = recursionDepth;
            return serializer.Serialize(obj);
        }
    }
    public class Jsonhelper
    {
        public string Response;
        public int reccount;
        public string Error;
    }
    [DataContract]
    public class searchfltr
    {
        [DataMember]
        public string dbfield { get; set; }
        [DataMember]
        public string searchtxt { get; set; }
    }
    #endregion
    [ServiceContract(Namespace = "")]
    [AspNetCompatibilityRequirements(RequirementsMode = AspNetCompatibilityRequirementsMode.Allowed)]
    public class GridService
    {
        // To use HTTP GET, add [WebGet] attribute. (Default ResponseFormat is WebMessageFormat.Json)
        // To create an operation that returns XML,
        //     add [WebGet(ResponseFormat=WebMessageFormat.Xml)],
        //     and include the following line in the operation body:
        //         WebOperationContext.Current.OutgoingResponse.ContentType = "text/xml";

        [OperationContract]
        [WebInvoke(Method = "POST",
BodyStyle = WebMessageBodyStyle.WrappedRequest,
RequestFormat = WebMessageFormat.Json,
ResponseFormat = WebMessageFormat.Json)]
        public string processduplicaterequest(string renid, string proc, string cmnt)
        {
            try
            {
                PersonLicensing.Utilities_Licensing.Insertduplicateprocssrequest(renid, proc, cmnt);
                return "";
            }
            catch
            {
                return "error";
            }
        }
        [OperationContract]
        [WebInvoke(Method = "POST",
BodyStyle = WebMessageBodyStyle.WrappedRequest,
RequestFormat = WebMessageFormat.Json,
ResponseFormat = WebMessageFormat.Json)]
        public string GetonlinePharmacists(string sdt, string edt, int pageSize, int page, string sortby, string sortexp, List<searchfltr> sdata)
        {
            Jsonhelper obj = new Jsonhelper();
            try
            {

                var resset = Person_Details.Licensing_Details.GetonlinePharmacist(sdt, edt);
                foreach (searchfltr s in sdata)
                {
                    var slf = typeof(Person_Details.USP_GetPharmacistdataResult).GetProperty(s.dbfield);
                    resset = resset.Where(c => slf.GetValue(c, null).ToString().ToUpper().Contains(s.searchtxt.ToUpper())).ToList();

                }
                if (sortby != "")
                {
                    var pi = typeof(Person_Details.USP_GetPharmacistdataResult).GetProperty(sortby);
                    if (sortexp == "asc")
                        resset = resset.OrderBy(c => pi.GetValue(c, null)).ToList();
                    else
                        resset = resset.OrderByDescending(c => pi.GetValue(c, null)).ToList();
                }
                var total = resset.Count();
                var skip = pageSize * (page - 1);
                var canPage = skip < total;
                obj.Response = resset.Skip(skip).Take(pageSize).ToList().ToJson();
                obj.reccount = total;
            }
            catch (Exception ex)
            {
                obj.Error = ex.ToJson();
            }
            return obj.ToJson();

        }

        [OperationContract]
        [WebInvoke(Method = "POST",
BodyStyle = WebMessageBodyStyle.WrappedRequest,
RequestFormat = WebMessageFormat.Json,
ResponseFormat = WebMessageFormat.Json)]
        public string BindUploadDisciplinaryFiles(int pageSize, int page, string sortby, string sortexp, List<searchfltr> sdata)
        {
            Jsonhelper obj = new Jsonhelper();
            try
            {

                var resset = Person_Details.Licensing_Details.GetDisciplinaryFindingFiles();
                foreach (searchfltr s in sdata)
                {
                    var slf = typeof(Person_Details.USPGetDisciplinaryFindingFilesResult).GetProperty(s.dbfield);
                    resset = resset.Where(c => slf.GetValue(c, null).ToString().ToUpper().Contains(s.searchtxt.ToUpper())).ToList();

                }
                if (sortby != "")
                {
                    var pi = typeof(Person_Details.USPGetDisciplinaryFindingFilesResult).GetProperty(sortby);
                    if (sortexp == "asc")
                        resset = resset.OrderBy(c => pi.GetValue(c, null)).ToList();
                    else
                        resset = resset.OrderByDescending(c => pi.GetValue(c, null)).ToList();
                }
                var total = resset.Count();
                var skip = pageSize * (page - 1);
                var canPage = skip < total;
                obj.Response = resset.Skip(skip).Take(pageSize).ToList().ToJson();
                obj.reccount = total;
            }
            catch (Exception ex)
            {
                obj.Error = ex.ToJson();
            }
            return obj.ToJson();

        }

        [OperationContract]
        [WebInvoke(Method = "POST",
BodyStyle = WebMessageBodyStyle.WrappedRequest,
RequestFormat = WebMessageFormat.Json,
ResponseFormat = WebMessageFormat.Json)]
        public string Bindceaudit(int pid, int pageSize, int page, string sortby, string sortexp, List<searchfltr> sdata)
        {
            Jsonhelper obj = new Jsonhelper();
            try
            {

                var resset = Person_Details.Licensing_Details.bindceaudit(pid);

                foreach (searchfltr s in sdata)
                {
                    var slf = typeof(Person_Details.USP_GetCeAuditdetailsResult).GetProperty(s.dbfield);
                    resset = resset.Where(c => slf.GetValue(c, null).ToString().ToUpper().Contains(s.searchtxt.ToUpper())).ToList();

                }
                if (sortby != "")
                {
                    var pi = typeof(Person_Details.USP_GetCeAuditdetailsResult).GetProperty(sortby);
                    if (sortexp == "asc")
                        resset = resset.OrderBy(c => pi.GetValue(c, null)).ToList();
                    else
                        resset = resset.OrderByDescending(c => pi.GetValue(c, null)).ToList();
                }
                var total = resset.Count();
                var skip = pageSize * (page - 1);
                var canPage = skip < total;
                obj.Response = resset.Skip(skip).Take(pageSize).ToList().ToJson();
                obj.reccount = total;
            }
            catch (Exception ex)
            {
                obj.Error = ex.ToJson();
            }
            return obj.ToJson();

        }

        [OperationContract]
        [WebInvoke(Method = "POST",
      BodyStyle = WebMessageBodyStyle.WrappedRequest,
      RequestFormat = WebMessageFormat.Json,
      ResponseFormat = WebMessageFormat.Json)]
        public string updaterenewalprint(string orderids)
        {
            try
            {
                PersonLicensing.Utilities_Licensing.updateprint(orderids);
                return "";
            }
            catch(Exception ex)
            {
                return ex.ToString();
            }
        }

        [OperationContract]
        [WebInvoke(Method = "POST",
BodyStyle = WebMessageBodyStyle.WrappedRequest,
RequestFormat = WebMessageFormat.Json,
ResponseFormat = WebMessageFormat.Json)]
        public string GetRenewalContact(string appid, int pageSize, int page, string sortby, string sortexp, List<searchfltr> sdata)
        {
            Jsonhelper obj = new Jsonhelper();
            try
            {

                var resset = Person_Details.Licensing_Details.Getrenewalcontact(appid);

                foreach (searchfltr s in sdata)
                {
                    var slf = typeof(Person_Details.USP_getrenewalcontactResult).GetProperty(s.dbfield);
                    resset = resset.Where(c => slf.GetValue(c, null).ToString().ToUpper().Contains(s.searchtxt.ToUpper())).ToList();

                }
                if (sortby != "")
                {
                    if (sortby != "License_No")
                    {
                        var pi = typeof(Person_Details.USP_getrenewalcontactResult).GetProperty(sortby);
                        if (sortexp == "asc")
                            resset = resset.OrderBy(c => pi.GetValue(c, null)).ToList();
                        else
                            resset = resset.OrderByDescending(c => pi.GetValue(c, null)).ToList();
                    }
                    else
                    {
                        var pi = typeof(Person_Details.USP_getrenewalcontactResult).GetProperty(sortby);
                        if (sortexp == "asc")
                            resset = resset.OrderBy(c => Convert.ToInt32(pi.GetValue(c, null).ToString().Replace("T", "").Replace("D", "").Replace("S", ""))).ToList();
                        else
                            resset = resset.OrderByDescending(c => Convert.ToInt32(pi.GetValue(c, null).ToString().Replace("T", "").Replace("D", "").Replace("S", ""))).ToList();
                    }
                }
                var total = resset.Count();
                var skip = pageSize * (page - 1);
                var canPage = skip < total;
                obj.Response = resset.Skip(skip).Take(pageSize).ToList().ToJson();
                obj.reccount = total;
            }
            catch (Exception ex)
            {
                obj.Error = ex.ToJson();
            }
            return obj.ToJson();

        }

        [OperationContract]
        [WebInvoke(Method = "POST",
BodyStyle = WebMessageBodyStyle.WrappedRequest,
RequestFormat = WebMessageFormat.Json,
ResponseFormat = WebMessageFormat.Json)]
        public string Getaddloghistory(string logid, int pageSize, int page, string sortby, string sortexp, List<searchfltr> sdata)
        {
            Jsonhelper obj = new Jsonhelper();
            try
            {

                var resset = Operations.Utilities_Operations.Getloghistory(logid);

                foreach (searchfltr s in sdata)
                {
                    var slf = typeof(OperationsLink.USP_getloghistoryResult).GetProperty(s.dbfield);
                    resset = resset.Where(c => slf.GetValue(c, null).ToString().ToUpper().Contains(s.searchtxt.ToUpper())).ToList();

                }
                if (sortby != "")
                {
                  
                        var pi = typeof(OperationsLink.USP_getloghistoryResult).GetProperty(sortby);
                        if (sortexp == "asc")
                            resset = resset.OrderBy(c => pi.GetValue(c, null)).ToList();
                        else
                            resset = resset.OrderByDescending(c => pi.GetValue(c, null)).ToList();
                   
                }
                var total = resset.Count();
                var skip = pageSize * (page - 1);
                var canPage = skip < total;
                obj.Response = resset.ToList().ToJson();
                obj.reccount = total;
            }
            catch (Exception ex)
            {
                obj.Error = ex.ToJson();
            }
            return obj.ToJson();

        }

        [OperationContract]
        [WebInvoke(Method = "POST",
BodyStyle = WebMessageBodyStyle.WrappedRequest,
RequestFormat = WebMessageFormat.Json,
ResponseFormat = WebMessageFormat.Json)]
        public string Getmonthlyupdates(int pageSize, int page, string sortby, string sortexp, List<searchfltr> sdata)
        {
            Jsonhelper obj = new Jsonhelper();
            try
            {

                var resset = AdminLinq.Admin.Getmonthlyupdate();

                foreach (searchfltr s in sdata)
                {
                    var slf = typeof(AdminLinq.tbl_monthlyboardupdate).GetProperty(s.dbfield);
                    resset = resset.Where(c => slf.GetValue(c, null).ToString().ToUpper().Contains(s.searchtxt.ToUpper())).ToList();

                }
                if (sortby != "")
                {
                    
                        var pi = typeof(AdminLinq.tbl_monthlyboardupdate).GetProperty(sortby);
                        if (sortexp == "asc")
                            resset = resset.OrderBy(c => pi.GetValue(c, null)).ToList();
                        else
                            resset = resset.OrderByDescending(c => pi.GetValue(c, null)).ToList();
                    
                }
                var total = resset.Count();
                var skip = pageSize * (page - 1);
                var canPage = skip < total;
                obj.Response = resset.Skip(skip).Take(pageSize).ToList().ToJson();
                obj.reccount = total;
            }
            catch (Exception ex)
            {
                obj.Error = ex.ToJson();
            }
            return obj.ToJson();

        }

        [OperationContract]
        [WebInvoke(Method = "POST",
BodyStyle = WebMessageBodyStyle.WrappedRequest,
RequestFormat = WebMessageFormat.Json,
ResponseFormat = WebMessageFormat.Json)]
        public string Getrenewaldata(string sdt,string edt,string ltype,string isprocess,string licno, int pageSize, int page, string sortby, string sortexp, List<searchfltr> sdata)
        {
            Jsonhelper obj = new Jsonhelper();
            try
            {

                var resset = Online.onlinedb.getrenewaldata(sdt, edt, ltype, isprocess, licno);

                foreach (searchfltr s in sdata)
                {
                    var slf = typeof(Online.USP_getRenewaldataResult).GetProperty(s.dbfield);
                    resset = resset.Where(c => slf.GetValue(c, null).ToString().ToUpper().Contains(s.searchtxt.ToUpper())).ToList();

                }
                if (sortby != "")
                {
                    if (sortby != "License_No")
                    {
                        var pi = typeof(Online.USP_getRenewaldataResult).GetProperty(sortby);
                        if (sortexp == "asc")
                            resset = resset.OrderBy(c => pi.GetValue(c, null)).ToList();
                        else
                            resset = resset.OrderByDescending(c => pi.GetValue(c, null)).ToList();
                    }
                    else
                    {
                        var pi = typeof(Online.USP_getRenewaldataResult).GetProperty(sortby);
                        if (sortexp == "asc")
                            resset = resset.OrderBy(c =>Convert.ToInt32( pi.GetValue(c, null).ToString().Replace("T","").Replace("D","").Replace("S",""))).ToList();
                        else
                            resset = resset.OrderByDescending(c => Convert.ToInt32(pi.GetValue(c, null).ToString().Replace("T", "").Replace("D", "").Replace("S", ""))).ToList();
                    }
                }
                var total = resset.Count();
                var skip = pageSize * (page - 1);
                var canPage = skip < total;
                obj.Response = resset.Skip(skip).Take(pageSize).ToList().ToJson();
                obj.reccount = total;
            }
            catch (Exception ex)
            {
                obj.Error = ex.ToJson();
            }
            return obj.ToJson();

        }
        [OperationContract]
        [WebInvoke(Method = "POST",
BodyStyle = WebMessageBodyStyle.WrappedRequest,
RequestFormat = WebMessageFormat.Json,
ResponseFormat = WebMessageFormat.Json)]
        public string Getrenewaldata2018(string sdt, string edt, string ltype, string isprocess, string licno, int pageSize, int page, string sortby, string sortexp, List<searchfltr> sdata)
        {
            Jsonhelper obj = new Jsonhelper();
            try
            {

                var resset = Online.onlinedb.getrenewaldata2018(sdt, edt, ltype, isprocess, licno);

                foreach (searchfltr s in sdata)
                {
                    var slf = typeof(Person_Details.USP_getRenewaldata2018Result).GetProperty(s.dbfield);
                    resset = resset.Where(c => slf.GetValue(c, null).ToString().ToUpper().Contains(s.searchtxt.ToUpper())).ToList();

                }
                if (sortby != "")
                {
                    if (sortby != "License_No")
                    {
                        var pi = typeof(Person_Details.USP_getRenewaldata2018Result).GetProperty(sortby);
                        if (sortexp == "asc")
                            resset = resset.OrderBy(c => pi.GetValue(c, null)).ToList();
                        else
                            resset = resset.OrderByDescending(c => pi.GetValue(c, null)).ToList();
                    }
                    else
                    {
                        var pi = typeof(Person_Details.USP_getRenewaldata2018Result).GetProperty(sortby);
                        if (sortexp == "asc")
                            resset = resset.OrderBy(c => Convert.ToInt32(pi.GetValue(c, null).ToString().Replace("T", "").Replace("D", "").Replace("S", ""))).ToList();
                        else
                            resset = resset.OrderByDescending(c => Convert.ToInt32(pi.GetValue(c, null).ToString().Replace("T", "").Replace("D", "").Replace("S", ""))).ToList();
                    }
                }
                var total = resset.Count();
                var skip = pageSize * (page - 1);
                var canPage = skip < total;
                obj.Response = resset.Skip(skip).Take(pageSize).ToList().ToJson();
                obj.reccount = total;
            }
            catch (Exception ex)
            {
                obj.Error = ex.ToJson();
            }
            return obj.ToJson();

        }

        [OperationContract]
        [WebInvoke(Method = "POST",
BodyStyle = WebMessageBodyStyle.WrappedRequest,
RequestFormat = WebMessageFormat.Json,
ResponseFormat = WebMessageFormat.Json)]
        public string BindPersonRenewalDocument(int pid, string utype, int pageSize, int page, string sortby, string sortexp, List<searchfltr> sdata)
        {
            Jsonhelper obj = new Jsonhelper();
            try
            {

                var resset = Person_Details.Licensing_Details.Get_RenewalDocumentDetails(pid, utype);
                if (utype == "1")
                {
                    List<Person_Details.USP_BindGridPersonRenewalDocumnetResult> dresult = new List<Person_Details.USP_BindGridPersonRenewalDocumnetResult>();
                   
                }

                foreach (searchfltr s in sdata)
                {
                    var slf = typeof(Person_Details.USP_BindGridPersonRenewalDocumnetResult).GetProperty(s.dbfield);
                    resset = resset.Where(c => slf.GetValue(c, null).ToString().ToUpper().Contains(s.searchtxt.ToUpper())).ToList();

                }
                if (sortby != "")
                {
                    var pi = typeof(Person_Details.USP_BindGridPersonRenewalDocumnetResult).GetProperty(sortby);
                    if (sortexp == "asc")
                        resset = resset.OrderBy(c => pi.GetValue(c, null)).ToList();
                    else
                        resset = resset.OrderByDescending(c => pi.GetValue(c, null)).ToList();
                }
                var total = resset.Count();
                var skip = pageSize * (page - 1);
                var canPage = skip < total;
                obj.Response = resset.Skip(skip).Take(pageSize).ToList().ToJson();
                obj.reccount = total;
            }
            catch (Exception ex)
            {
                obj.Error = ex.ToJson();
            }
            return obj.ToJson();

        }





        [OperationContract]
        [WebInvoke(Method = "POST",
BodyStyle = WebMessageBodyStyle.WrappedRequest,
RequestFormat = WebMessageFormat.Json,
ResponseFormat = WebMessageFormat.Json)]
        public string BindPersonSpecialityDocument(int pid, int pageSize, int page, string sortby, string sortexp, List<searchfltr> sdata)
        {
            Jsonhelper obj = new Jsonhelper();
            try
            {

                var resset = Person_Details.Licensing_Details.Get_DocumentSpecialityDetails(pid);


                List<Person_Details.USP_BindGridPersonDocumnetSpecialityResult> dresult = new List<Person_Details.USP_BindGridPersonDocumnetSpecialityResult>();





                foreach (searchfltr s in sdata)
                {
                    var slf = typeof(Person_Details.USP_BindGridPersonDocumnetSpecialityResult).GetProperty(s.dbfield);
                    resset = resset.Where(c => slf.GetValue(c, null).ToString().ToUpper().Contains(s.searchtxt.ToUpper())).ToList();

                }
                if (sortby != "")
                {
                    var pi = typeof(Person_Details.USP_BindGridPersonDocumnetSpecialityResult).GetProperty(sortby);
                    if (sortexp == "asc")
                        resset = resset.OrderBy(c => pi.GetValue(c, null)).ToList();
                    else
                        resset = resset.OrderByDescending(c => pi.GetValue(c, null)).ToList();
                }
                var total = resset.Count();
                var skip = pageSize * (page - 1);
                var canPage = skip < total;
                obj.Response = resset.Skip(skip).Take(pageSize).ToList().ToJson();
                obj.reccount = total;
            }
            catch (Exception ex)
            {
                obj.Error = ex.ToJson();
            }
            return obj.ToJson();

        }




        [OperationContract]
        [WebInvoke(Method = "POST",
BodyStyle = WebMessageBodyStyle.WrappedRequest,
RequestFormat = WebMessageFormat.Json,
ResponseFormat = WebMessageFormat.Json)]
        public string insertGrid(string pid, int pageSize, int page, string sortby, string sortexp, List<searchfltr> sdata)
        {
            Jsonhelper obj = new Jsonhelper();
            try
            {

                var resset = Person_Details.Licensing_Details.binddetails(pid);

                foreach (searchfltr s in sdata)
                {
                    var slf = typeof(Person_Details.USP_Exam_EligibleResult).GetProperty(s.dbfield);
                    resset = resset.Where(c => slf.GetValue(c, null).ToString().ToUpper().Contains(s.searchtxt.ToUpper())).ToList();

                }
                if (sortby != "")
                {
                    var pi = typeof(Person_Details.USP_Exam_EligibleResult).GetProperty(sortby);
                    if (sortexp == "asc")
                        resset = resset.OrderBy(c => pi.GetValue(c, null)).ToList();
                    else
                        resset = resset.OrderByDescending(c => pi.GetValue(c, null)).ToList();
                }
                var total = resset.Count();
                var skip = pageSize * (page - 1);
                var canPage = skip < total;
                obj.Response = resset.Skip(skip).Take(pageSize).ToList().ToJson();
                obj.reccount = total;
            }
            catch (Exception ex)
            {
                obj.Error = ex.ToJson();
            }
            return obj.ToJson();

        }

        [OperationContract]
        [WebInvoke(Method = "POST",
BodyStyle = WebMessageBodyStyle.WrappedRequest,
RequestFormat = WebMessageFormat.Json,
ResponseFormat = WebMessageFormat.Json)]
        public string GetDisplanraryInfo(string Pid, int pageSize, int page, string sortby, string sortexp, List<searchfltr> sdata)
        {
            Jsonhelper obj = new Jsonhelper();
            try
            {

                var resset = License_Data.License_Details.GetDispinfo(Pid);

                foreach (searchfltr s in sdata)
                {
                    var slf = typeof(License_Data.tbl_DisciplineInfo).GetProperty(s.dbfield);
                    resset = resset.Where(c => slf.GetValue(c, null).ToString().ToUpper().Contains(s.searchtxt.ToUpper())).ToList();

                }
                if (sortby != "")
                {
                    var pi = typeof(License_Data.tbl_DisciplineInfo).GetProperty(sortby);
                    if (sortexp == "asc")
                        resset = resset.OrderBy(c => pi.GetValue(c, null)).ToList();
                    else
                        resset = resset.OrderByDescending(c => pi.GetValue(c, null)).ToList();
                }
                var total = resset.Count();
                var skip = pageSize * (page - 1);
                var canPage = skip < total;
                obj.Response = resset.Skip(skip).Take(pageSize).ToList().ToJson();
                obj.reccount = total;
            }
            catch (Exception ex)
            {
                obj.Error = ex.ToJson();
            }
            return obj.ToJson();

        }
        
        [OperationContract]
        [WebInvoke(Method = "POST",
BodyStyle = WebMessageBodyStyle.WrappedRequest,
RequestFormat = WebMessageFormat.Json,
ResponseFormat = WebMessageFormat.Json)]
        public string Getcmppersonhis(string cmpid, int pageSize, int page, string sortby, string sortexp, List<searchfltr> sdata)
        {
            Jsonhelper obj = new Jsonhelper();
            try
            {

                var resset = ComplaintsTabLinq.ClsComplaints.Get_Personhis(cmpid);

                foreach (searchfltr s in sdata)
                {
                    var slf = typeof(ComplaintsTabLinq.USP_GetPersonHisResult).GetProperty(s.dbfield);
                    resset = resset.Where(c => slf.GetValue(c, null).ToString().ToUpper().Contains(s.searchtxt.ToUpper())).ToList();

                }
                if (sortby != "")
                {
                    var pi = typeof(ComplaintsTabLinq.USP_GetPersonHisResult).GetProperty(sortby);
                    if (sortexp == "asc")
                        resset = resset.OrderBy(c => pi.GetValue(c, null)).ToList();
                    else
                        resset = resset.OrderByDescending(c => pi.GetValue(c, null)).ToList();
                }
                var total = resset.Count();
                var skip = pageSize * (page - 1);
                var canPage = skip < total;
                obj.Response = resset.Skip(skip).Take(pageSize).ToList().ToJson();
                obj.reccount = total;
            }
            catch (Exception ex)
            {
                obj.Error = ex.ToJson();
            }
            return obj.ToJson();

        }
        [OperationContract]
        [WebInvoke(Method = "POST",
BodyStyle = WebMessageBodyStyle.WrappedRequest,
RequestFormat = WebMessageFormat.Json,
ResponseFormat = WebMessageFormat.Json)]
        public string GetCitizenship(int ltype, int pageSize, int page, string sortby, string sortexp, List<searchfltr> sdata)
        {
            Jsonhelper obj = new Jsonhelper();
            try
            {

                var resset = Person_Details.Licensing_Details.GetCitizenshipDetails(ltype);

                foreach (searchfltr s in sdata)
                {
                    var slf = typeof(Person_Details.USP_GetCitizenshipDetailsResult).GetProperty(s.dbfield);
                    resset = resset.Where(c => slf.GetValue(c, null).ToString().ToUpper().Contains(s.searchtxt.ToUpper())).ToList();

                }
                if (sortby != "")
                {
                    var pi = typeof(Person_Details.USP_GetCitizenshipDetailsResult).GetProperty(sortby);
                    if (sortexp == "asc")
                        resset = resset.OrderBy(c => pi.GetValue(c, null)).ToList();
                    else
                        resset = resset.OrderByDescending(c => pi.GetValue(c, null)).ToList();
                }
                var total = resset.Count();
                var skip = pageSize * (page - 1);
                var canPage = skip < total;
                obj.Response = resset.Skip(skip).Take(pageSize).ToList().ToJson();
                obj.reccount = total;
            }
            catch (Exception ex)
            {
                obj.Error = ex.ToJson();
            }
            return obj.ToJson();

        }
        [OperationContract]
        [WebInvoke(Method = "POST",
BodyStyle = WebMessageBodyStyle.WrappedRequest,
RequestFormat = WebMessageFormat.Json,
ResponseFormat = WebMessageFormat.Json)]
        public string BindInspectionjournal(int pid, int pageSize, int page, string sortby, string sortexp, List<searchfltr> sdata)
        {
            Jsonhelper obj = new Jsonhelper();
            try
            {

                var resset = Person_Details.Licensing_Details.GetinspectionDetails(pid);

                foreach (searchfltr s in sdata)
                {
                    var slf = typeof(Person_Details.USP_GetInspectionJournalValuesResult).GetProperty(s.dbfield);
                    resset = resset.Where(c => slf.GetValue(c, null).ToString().ToUpper().Contains(s.searchtxt.ToUpper())).ToList();

                }
                if (sortby != "")
                {
                    var pi = typeof(Person_Details.USP_GetInspectionJournalValuesResult).GetProperty(sortby);
                    if (sortexp == "asc")
                        resset = resset.OrderBy(c => pi.GetValue(c, null)).ToList();
                    else
                        resset = resset.OrderByDescending(c => pi.GetValue(c, null)).ToList();
                }
                var total = resset.Count();
                var skip = pageSize * (page - 1);
                var canPage = skip < total;
                obj.Response = resset.Skip(skip).Take(pageSize).ToList().ToJson();
                obj.reccount = total;
            }
            catch (Exception ex)
            {
                obj.Error = ex.ToJson();
            }
            return obj.ToJson();

        }
        [OperationContract]
        [WebInvoke(Method = "POST",
BodyStyle = WebMessageBodyStyle.WrappedRequest,
RequestFormat = WebMessageFormat.Json,
ResponseFormat = WebMessageFormat.Json)]
        public string Getnamehistory( string pid, int pageSize, int page, string sortby, string sortexp, List<searchfltr> sdata)
        {
            Jsonhelper obj = new Jsonhelper();
            try
            {

                var resset = License_Data.License_Details.Getnamehistory(pid);

                foreach (searchfltr s in sdata)
                {
                    var slf = typeof(License_Data.USP_GetnamehistoryResult).GetProperty(s.dbfield);
                    resset = resset.Where(c => slf.GetValue(c, null).ToString().ToUpper().Contains(s.searchtxt.ToUpper())).ToList();

                }
                if (sortby != "")
                {
                    var pi = typeof(License_Data.USP_GetnamehistoryResult).GetProperty(sortby);
                    if (sortexp == "asc")
                        resset = resset.OrderBy(c => pi.GetValue(c, null)).ToList();
                    else
                        resset = resset.OrderByDescending(c => pi.GetValue(c, null)).ToList();
                }
                var total = resset.Count();
                var skip = pageSize * (page - 1);
                var canPage = skip < total;
                obj.Response = resset.Skip(skip).Take(pageSize).ToList().ToJson();
                obj.reccount = total;
            }
            catch (Exception ex)
            {
                obj.Error = ex.ToJson();
            }
            return obj.ToJson();

        }
        [OperationContract]
        [WebInvoke(Method = "POST",
BodyStyle = WebMessageBodyStyle.WrappedRequest,
RequestFormat = WebMessageFormat.Json,
ResponseFormat = WebMessageFormat.Json)]
        public string Getaddresshistory(string pid, int pageSize, int page, string sortby, string sortexp, List<searchfltr> sdata)
        {
            Jsonhelper obj = new Jsonhelper();
            try
            {

                var resset = License_Data.License_Details.Getaddresshistory(pid);

                foreach (searchfltr s in sdata)
                {
                    var slf = typeof(License_Data.USP_GetaddresshistoryResult).GetProperty(s.dbfield);
                    resset = resset.Where(c => slf.GetValue(c, null).ToString().ToUpper().Contains(s.searchtxt.ToUpper())).ToList();

                }
                if (sortby != "")
                {
                    var pi = typeof(License_Data.USP_GetaddresshistoryResult).GetProperty(sortby);
                    if (sortexp == "asc")
                        resset = resset.OrderBy(c => pi.GetValue(c, null)).ToList();
                    else
                        resset = resset.OrderByDescending(c => pi.GetValue(c, null)).ToList();
                }
                var total = resset.Count();
                var skip = pageSize * (page - 1);
                var canPage = skip < total;
                obj.Response = resset.Skip(skip).Take(pageSize).ToList().ToJson();
                obj.reccount = total;
            }
            catch (Exception ex)
            {
                obj.Error = ex.ToJson();
            }
            return obj.ToJson();

        }
        
        [OperationContract]
        [WebInvoke(Method = "POST",
BodyStyle = WebMessageBodyStyle.WrappedRequest,
RequestFormat = WebMessageFormat.Json,
ResponseFormat = WebMessageFormat.Json)]
        public string GetComplaints(string resptype, string respid, string responseid, int pageSize, int page, string sortby, string sortexp, List<searchfltr> sdata)
        {
            Jsonhelper obj = new Jsonhelper();
            try
            {

                var resset = ComplaintsTabLinq.ClsComplaints.GetComplaints("0",Convert.ToInt32( respid));
                if (responseid != "0")
                    resset = ComplaintsTabLinq.ClsComplaints.GetComplaints(responseid, Convert.ToInt32(respid));

                foreach (searchfltr s in sdata)
                {
                    var slf = typeof(ComplaintsTabLinq.GetComplaintsResult).GetProperty(s.dbfield);
                    resset = resset.Where(c => slf.GetValue(c, null).ToString().ToUpper().Contains(s.searchtxt.ToUpper())).ToList();

                }
                if (sortby != "")
                {
                    var pi = typeof(ComplaintsTabLinq.GetComplaintsResult).GetProperty(sortby);
                    if (sortexp == "asc")
                        resset = resset.OrderBy(c => pi.GetValue(c, null)).ToList();
                    else
                        resset = resset.OrderByDescending(c => pi.GetValue(c, null)).ToList();
                }
                var total = resset.Count();
                var skip = pageSize * (page - 1);
                var canPage = skip < total;
                obj.Response = resset.Skip(skip).Take(pageSize).ToList().ToJson();
                obj.reccount = total;
            }
            catch (Exception ex)
            {
                obj.Error = ex.ToJson();
            }
            return obj.ToJson();

        }
        [OperationContract]
        [WebInvoke(Method = "POST",
BodyStyle = WebMessageBodyStyle.WrappedRequest,
RequestFormat = WebMessageFormat.Json,
ResponseFormat = WebMessageFormat.Json)]
        public string Getpersonsearchforcontact(string lname, string fname, string ssn, string dob, string pnumber, string ptype, string licno, string lictype, string email, string licstatus, string address, string county, string state, string zip, string csub, string city, string resptype, string respid, int pageSize, int page, string sortby, string sortexp, List<searchfltr> sdata)
        {
            Jsonhelper obj = new Jsonhelper();
            try
            {
                if (zip != "")
                {
                    if (zip.Substring(zip.Length - 1, 1) == "-")
                        zip = zip.Substring(0, zip.Length - 1);
                }
                var resset = Person_Details.Licensing_Details.getpersonserch(lname, fname, ssn, dob, pnumber, ptype, licno, lictype, licstatus, email, address, county, state, zip,csub,city,resptype);

                foreach (searchfltr s in sdata)
                {
                    var slf = typeof(Person_Details.USP_GetpersonSearchResult).GetProperty(s.dbfield);
                    resset = resset.Where(c => slf.GetValue(c, null).ToString().ToUpper().Contains(s.searchtxt.ToUpper())).ToList();

                }
                if (sortby != "")
                {
                    var pi = typeof(Person_Details.USP_GetpersonSearchResult).GetProperty(sortby);
                    if (sortexp == "asc")
                        resset = resset.OrderBy(c => pi.GetValue(c, null)).ToList();
                    else
                        resset = resset.OrderByDescending(c => pi.GetValue(c, null)).ToList();
                }
                var total = resset.Count();
                var skip = pageSize * (page - 1);
                var canPage = skip < total;
                obj.Response = resset.Skip(skip).Take(pageSize).ToList().ToJson();
                obj.reccount = total;
            }
            catch (Exception ex)
            {
                obj.Error = ex.ToJson();
            }
            return obj.ToJson();

        }
        [OperationContract]
        [WebInvoke(Method = "POST",
BodyStyle = WebMessageBodyStyle.WrappedRequest,
RequestFormat = WebMessageFormat.Json,
ResponseFormat = WebMessageFormat.Json)]
        public string Getbusinessearchforcontact(string lname, string fname, string ssn, string dob, string pnumber, string ptype, string licno, string lictype, string licstatus, string address, string city, string county, string state, string zip, string email, string cert, string csub, string usp797, string usp795, string resptype, string respid, int pageSize, int page, string sortby, string sortexp, List<searchfltr> sdata)
        {
            Jsonhelper obj = new Jsonhelper();
            try
            {
                if (zip != "")
                {
                    if (zip.Substring(zip.Length - 1, 1) == "-")
                        zip = zip.Substring(0, zip.Length - 1);
                }
                var resset = Person_Details.Licensing_Details.getbusinesssearch(lname, fname, ssn, dob, pnumber, ptype, licno, lictype, licstatus, address, county, state, zip, email, cert,csub,usp797,usp795,city,resptype);

                foreach (searchfltr s in sdata)
                {
                    var slf = typeof(Person_Details.USP_GetBusinessSearchResult).GetProperty(s.dbfield);
                    resset = resset.Where(c => slf.GetValue(c, null).ToString().ToUpper().Contains(s.searchtxt.ToUpper())).ToList();

                }
                if (sortby != "")
                {
                    var pi = typeof(Person_Details.USP_GetBusinessSearchResult).GetProperty(sortby);
                    if (sortexp == "asc")
                        resset = resset.OrderBy(c => pi.GetValue(c, null)).ToList();
                    else
                        resset = resset.OrderByDescending(c => pi.GetValue(c, null)).ToList();
                }
                var total = resset.Count();
                var skip = pageSize * (page - 1);
                var canPage = skip < total;
                obj.Response = resset.Skip(skip).Take(pageSize).ToList().ToJson();
                obj.reccount = total;
            }
            catch (Exception ex)
            {
                obj.Error = ex.ToJson();
            }
            return obj.ToJson();

        }
        [OperationContract]
        [WebInvoke(Method = "POST",
BodyStyle = WebMessageBodyStyle.WrappedRequest,
RequestFormat = WebMessageFormat.Json,
ResponseFormat = WebMessageFormat.Json)]
        public string Complaintsearch(string lastname, string firstname, string ssn, string dob, string licnum, string cmpnumber, string complainant, int pageSize, int page, string sortby, string sortexp, List<searchfltr> sdata)
        {
            Jsonhelper obj = new Jsonhelper();
            try
            {

                var resset = ComplaintsLink.Complaints.getpersonserch(lastname, firstname, ssn, dob, licnum, cmpnumber,complainant);

                foreach (searchfltr s in sdata)
                {
                    var slf = typeof(ComplaintsLink.USP_Complaints_GetComplaintSearchResult).GetProperty(s.dbfield);
                    resset = resset.Where(c => slf.GetValue(c, null).ToString().ToUpper().Contains(s.searchtxt.ToUpper())).ToList();

                }
                if (sortby != "")
                {
                    var pi = typeof(ComplaintsLink.USP_Complaints_GetComplaintSearchResult).GetProperty(sortby);
                    if (sortexp == "asc")
                        resset = resset.OrderBy(c => pi.GetValue(c, null)).ToList();
                    else
                        resset = resset.OrderByDescending(c => pi.GetValue(c, null)).ToList();
                }
                var total = resset.Count();
                var skip = pageSize * (page - 1);
                var canPage = skip < total;
                obj.Response = resset.Skip(skip).Take(pageSize).ToList().ToJson();
                obj.reccount = total;
            }
            catch (Exception ex)
            {
                obj.Error = ex.ToJson();
            }
            return obj.ToJson();

        }
        [OperationContract]
        [WebInvoke(Method = "POST",
BodyStyle = WebMessageBodyStyle.WrappedRequest,
RequestFormat = WebMessageFormat.Json,
ResponseFormat = WebMessageFormat.Json)]
        public string Complaintbusinesssearch(string lastname, string firstname, string ssn, string dob, string licnum, string cmpnumber, string complainant, int pageSize, int page, string sortby, string sortexp, List<searchfltr> sdata)
        {
            Jsonhelper obj = new Jsonhelper();
            try
            {

                var resset = Complaints.Utilities_ComplaintsTAB.GetBusinessSearch(lastname, firstname, ssn, dob, licnum, cmpnumber,complainant);

                foreach (searchfltr s in sdata)
                {
                    var slf = typeof(ComplaintsLink.USP_Complaints_GetComplaintBusinessSearchResult).GetProperty(s.dbfield);
                    resset = resset.Where(c => slf.GetValue(c, null).ToString().ToUpper().Contains(s.searchtxt.ToUpper())).ToList();

                }
                if (sortby != "")
                {
                    var pi = typeof(ComplaintsLink.USP_Complaints_GetComplaintBusinessSearchResult).GetProperty(sortby);
                    if (sortexp == "asc")
                        resset = resset.OrderBy(c => pi.GetValue(c, null)).ToList();
                    else
                        resset = resset.OrderByDescending(c => pi.GetValue(c, null)).ToList();
                }
                var total = resset.Count();
                var skip = pageSize * (page - 1);
                var canPage = skip < total;
                obj.Response = resset.Skip(skip).Take(pageSize).ToList().ToJson();
                obj.reccount = total;
            }
            catch (Exception ex)
            {
                obj.Error = ex.ToJson();
            }
            return obj.ToJson();

        }
        [OperationContract]
        [WebInvoke(Method = "POST",
BodyStyle = WebMessageBodyStyle.WrappedRequest,
RequestFormat = WebMessageFormat.Json,
ResponseFormat = WebMessageFormat.Json)]
        public string BindPerson_License(int pid, int pageSize, int page, string sortby, string sortexp, List<searchfltr> sdata)
        {
            Jsonhelper obj = new Jsonhelper();
            try
            {

                var resset = Person_Details.Licensing_Details.GetLicensing_Details(pid);

                foreach (searchfltr s in sdata)
                {
                    var slf = typeof(Person_Details.USP_Licensing_DetailsResult).GetProperty(s.dbfield);
                    resset = resset.Where(c => slf.GetValue(c, null).ToString().ToUpper().Contains(s.searchtxt.ToUpper())).ToList();

                }
                if (sortby != "")
                {
                    var pi = typeof(Person_Details.USP_Licensing_DetailsResult).GetProperty(sortby);
                    if (sortexp == "asc")
                        resset = resset.OrderBy(c => pi.GetValue(c, null)).ToList();
                    else
                        resset = resset.OrderByDescending(c => pi.GetValue(c, null)).ToList();
                }
                var total = resset.Count();
                var skip = pageSize * (page - 1);
                var canPage = skip < total;
                obj.Response = resset.Skip(skip).Take(pageSize).ToList().ToJson();
                obj.reccount = total;
            }
            catch (Exception ex)
            {
                obj.Error = ex.ToJson();
            }
            return obj.ToJson();

        }
        [OperationContract]
        [WebInvoke(Method = "POST",
BodyStyle = WebMessageBodyStyle.WrappedRequest,
RequestFormat = WebMessageFormat.Json,
ResponseFormat = WebMessageFormat.Json)]
        public string ManageUsers(int pageSize, int page, string sortby, string sortexp, List<searchfltr> sdata)
        {
            Jsonhelper obj = new Jsonhelper();
            try
            {

                var resset = AdminLinq.Admin.BindGrid_ManageUsers();

                foreach (searchfltr s in sdata)
                {
                    var slf = typeof(AdminLinq.Tbl_Login).GetProperty(s.dbfield);
                    resset = resset.Where(c => slf.GetValue(c, null).ToString().ToUpper().Contains(s.searchtxt.ToUpper())).ToList();

                }
                if (sortby != "")
                {
                    var pi = typeof(AdminLinq.Tbl_Login).GetProperty(sortby);
                    if (sortexp == "asc")
                        resset = resset.OrderBy(c => pi.GetValue(c, null)).ToList();
                    else
                        resset = resset.OrderByDescending(c => pi.GetValue(c, null)).ToList();
                }
                var total = resset.Count();
                var skip = pageSize * (page - 1);
                var canPage = skip < total;
                obj.Response = resset.Skip(skip).Take(pageSize).ToList().ToJson();
                obj.reccount = total;
            }
            catch (Exception ex)
            {
                obj.Error = ex.ToJson();
            }
            return obj.ToJson();

        }
        [OperationContract]
        [WebInvoke(Method = "POST",
BodyStyle = WebMessageBodyStyle.WrappedRequest,
RequestFormat = WebMessageFormat.Json,
ResponseFormat = WebMessageFormat.Json)]
        public string LicenseLookup(int pageSize, int page, string sortby, string sortexp, List<searchfltr> sdata)
        {
            Jsonhelper obj = new Jsonhelper();
            try
            {

                var resset = AdminLinq.Admin.Bind_LicenseLookupData();

                foreach (searchfltr s in sdata)
                {
                    var slf = typeof(AdminLinq.tbl_lkp_License).GetProperty(s.dbfield);
                    resset = resset.Where(c => slf.GetValue(c, null).ToString().ToUpper().Contains(s.searchtxt.ToUpper())).ToList();

                }
                if (sortby != "")
                {
                    var pi = typeof(AdminLinq.tbl_lkp_License).GetProperty(sortby);
                    if (sortexp == "asc")
                        resset = resset.OrderBy(c => pi.GetValue(c, null)).ToList();
                    else
                        resset = resset.OrderByDescending(c => pi.GetValue(c, null)).ToList();
                }
                var total = resset.Count();
                var skip = pageSize * (page - 1);
                var canPage = skip < total;
                obj.Response = resset.Skip(skip).Take(pageSize).ToList().ToJson();
                obj.reccount = total;
            }
            catch (Exception ex)
            {
                obj.Error = ex.ToJson();
            }
            return obj.ToJson();

        }
        [OperationContract]
        [WebInvoke(Method = "POST",
BodyStyle = WebMessageBodyStyle.WrappedRequest,
RequestFormat = WebMessageFormat.Json,
ResponseFormat = WebMessageFormat.Json)]
        public string ManageLookup(string sval,int pageSize, int page, string sortby, string sortexp, List<searchfltr> sdata)
        {
            Jsonhelper obj = new Jsonhelper();
            try
            {

                var resset = ComplaintsLink.Complaints.Get_Lkp_tablesdata(Convert.ToInt32(sval));

                foreach (searchfltr s in sdata)
                {
                    var slf = typeof(ComplaintsLink.tbl_lkp_data).GetProperty(s.dbfield);
                    resset = resset.Where(c => slf.GetValue(c, null).ToString().ToUpper().Contains(s.searchtxt.ToUpper())).ToList();

                }
                if (sortby != "")
                {
                    var pi = typeof(ComplaintsLink.tbl_lkp_data).GetProperty(sortby);
                    if (sortexp == "asc")
                        resset = resset.OrderBy(c => pi.GetValue(c, null)).ToList();
                    else
                        resset = resset.OrderByDescending(c => pi.GetValue(c, null)).ToList();
                }
                var total = resset.Count();
                var skip = pageSize * (page - 1);
                var canPage = skip < total;
                obj.Response = resset.Skip(skip).Take(pageSize).ToList().ToJson();
                obj.reccount = total;
            }
            catch (Exception ex)
            {
                obj.Error = ex.ToJson();
            }
            return obj.ToJson();

        }
        [OperationContract]
        [WebInvoke(Method = "POST",
BodyStyle = WebMessageBodyStyle.WrappedRequest,
RequestFormat = WebMessageFormat.Json,
ResponseFormat = WebMessageFormat.Json)]
        public string BindLicenseChecklist(string sval,string sval2, int pageSize, int page, string sortby, string sortexp, List<searchfltr> sdata)
        {
            Jsonhelper obj = new Jsonhelper();
            try
            {

                var resset = AdminLinq.Admin.getLicChecklist(Convert.ToInt16(sval), Convert.ToInt16(sval2));

                foreach (searchfltr s in sdata)
                {
                    var slf = typeof(AdminLinq.USP_Licensing_GetLicenseCheckListResult).GetProperty(s.dbfield);
                    resset = resset.Where(c => slf.GetValue(c, null).ToString().ToUpper().Contains(s.searchtxt.ToUpper())).ToList();

                }
                if (sortby != "")
                {
                    var pi = typeof(AdminLinq.USP_Licensing_GetLicenseCheckListResult).GetProperty(sortby);
                    if (sortexp == "asc")
                        resset = resset.OrderBy(c => pi.GetValue(c, null)).ToList();
                    else
                        resset = resset.OrderByDescending(c => pi.GetValue(c, null)).ToList();
                }
                var total = resset.Count();
                var skip = pageSize * (page - 1);
                var canPage = skip < total;
                obj.Response = resset.Skip(skip).Take(pageSize).ToList().ToJson();
                obj.reccount = total;
            }
            catch (Exception ex)
            {
                obj.Error = ex.ToJson();
            }
            return obj.ToJson();

        }
        [OperationContract]
        [WebInvoke(Method = "POST",
BodyStyle = WebMessageBodyStyle.WrappedRequest,
RequestFormat = WebMessageFormat.Json,
ResponseFormat = WebMessageFormat.Json)]
        public string Bindcomplaintsparticipants(string sval, int pageSize, int page, string sortby, string sortexp, List<searchfltr> sdata)
        {
            Jsonhelper obj = new Jsonhelper();
            try
            {

                var resset =   ComplaintsLink.Complaints.getComplaint_Service(Convert.ToInt32(sval),1);

                foreach (searchfltr s in sdata)
                {
                    var slf = typeof(ComplaintsLink.USP_GetComplaint_ServiceResult).GetProperty(s.dbfield);
                    resset = resset.Where(c => slf.GetValue(c, null).ToString().ToUpper().Contains(s.searchtxt.ToUpper())).ToList();

                }
                if (sortby != "")
                {
                    var pi = typeof(ComplaintsLink.USP_GetComplaint_ServiceResult).GetProperty(sortby);
                    if (sortexp == "asc")
                        resset = resset.OrderBy(c => pi.GetValue(c, null)).ToList();
                    else
                        resset = resset.OrderByDescending(c => pi.GetValue(c, null)).ToList();
                }
                var total = resset.Count();
                var skip = pageSize * (page - 1);
                var canPage = skip < total;
                obj.Response = resset.Skip(skip).Take(pageSize).ToList().ToJson();
                obj.reccount = total;
            }
            catch (Exception ex)
            {
                obj.Error = ex.ToJson();
            }
            return obj.ToJson();

        }
        #region Person Details Pages
        [OperationContract]
        [WebInvoke(Method = "POST",
BodyStyle = WebMessageBodyStyle.WrappedRequest,
RequestFormat = WebMessageFormat.Json,
ResponseFormat = WebMessageFormat.Json)]
        public string BindPersonChecklist(string lastname,string fname,string ssn,string dob, string pres, int pageSize, int page, string sortby, string sortexp, List<searchfltr> sdata)
        {
            Jsonhelper obj = new Jsonhelper();
            try
            {

                var resset = License_Data.License_Details.Get_ChecklistDataBySelection(lastname, fname, ssn, dob,pres);

                foreach (searchfltr s in sdata)
                {
                    var slf = typeof(License_Data.USP_Licensing_GetPersonNew_GetCheckItemsResult).GetProperty(s.dbfield);
                    resset = resset.Where(c => slf.GetValue(c, null).ToString().ToUpper().Contains(s.searchtxt.ToUpper())).ToList();

                }
                if (sortby != "")
                {
                    var pi = typeof(License_Data.USP_Licensing_GetPersonNew_GetCheckItemsResult).GetProperty(sortby);
                    if (sortexp == "asc")
                        resset = resset.OrderBy(c => pi.GetValue(c, null)).ToList();
                    else
                        resset = resset.OrderByDescending(c => pi.GetValue(c, null)).ToList();
                }
                var total = resset.Count();
                var skip = pageSize * (page - 1);
                var canPage = skip < total;
                obj.Response = resset.Skip(skip).Take(pageSize).ToList().ToJson();
                obj.reccount = total;
            }
            catch (Exception ex)
            {
                obj.Error = ex.ToJson();
            }
            return obj.ToJson();

        }
        [OperationContract]
        [WebInvoke(Method = "POST",
BodyStyle = WebMessageBodyStyle.WrappedRequest,
RequestFormat = WebMessageFormat.Json,
ResponseFormat = WebMessageFormat.Json)]
        public string BindBusinessChecklist(string lastname, string fname, string ssn, string dob,string pnumber,string lictype, int pageSize, int page, string sortby, string sortexp, List<searchfltr> sdata)
        {
            Jsonhelper obj = new Jsonhelper();
            try
            {

                var resset = License_Data.License_Details.Get_BusinessChecklist(lastname, fname, ssn, dob, pnumber, lictype);

                foreach (searchfltr s in sdata)
                {
                    var slf = typeof(License_Data.USP_Licensing_GetBusinessNew_GetCheckItemsResult).GetProperty(s.dbfield);
                    resset = resset.Where(c => slf.GetValue(c, null).ToString().ToUpper().Contains(s.searchtxt.ToUpper())).ToList();

                }
                if (sortby != "")
                {
                    var pi = typeof(License_Data.USP_Licensing_GetBusinessNew_GetCheckItemsResult).GetProperty(sortby);
                    if (sortexp == "asc")
                        resset = resset.OrderBy(c => pi.GetValue(c, null)).ToList();
                    else
                        resset = resset.OrderByDescending(c => pi.GetValue(c, null)).ToList();
                }
                var total = resset.Count();
                var skip = pageSize * (page - 1);
                var canPage = skip < total;
                obj.Response = resset.Skip(skip).Take(pageSize).ToList().ToJson();
                obj.reccount = total;
            }
            catch (Exception ex)
            {
                obj.Error = ex.ToJson();
            }
            return obj.ToJson();

        }
        [OperationContract]
        [WebInvoke(Method = "POST",
BodyStyle = WebMessageBodyStyle.WrappedRequest,
RequestFormat = WebMessageFormat.Json,
ResponseFormat = WebMessageFormat.Json)]
        public string BindPersonDocument(int pid,string utype, string appid, int pageSize, int page, string sortby, string sortexp, List<searchfltr> sdata)
        {
            Jsonhelper obj = new Jsonhelper();
            try
            {

                var resset = Person_Details.Licensing_Details.Get_DocumentDetails(pid, utype);
                if (utype == "1" && appid != "")
                {
                    List<Person_Details.USP_BindGridPersonDocumnetResult> dresult = new List<Person_Details.USP_BindGridPersonDocumnetResult>();
                    string[] apf = appid.Split(',');
                    foreach (string t in apf)
                        if (t.Trim() != "")
                            dresult.AddRange(resset.Where(c => c.LicenseTypeAppID == Convert.ToInt32(t)).ToList());
                    resset = dresult;
                }

                foreach (searchfltr s in sdata)
                {
                    var slf = typeof(Person_Details.USP_BindGridPersonDocumnetResult).GetProperty(s.dbfield);
                    resset = resset.Where(c => slf.GetValue(c, null).ToString().ToUpper().Contains(s.searchtxt.ToUpper())).ToList();

                }
                if (sortby != "")
                {
                    var pi = typeof(Person_Details.USP_BindGridPersonDocumnetResult).GetProperty(sortby);
                    if (sortexp == "asc")
                        resset = resset.OrderBy(c => pi.GetValue(c, null)).ToList();
                    else
                        resset = resset.OrderByDescending(c => pi.GetValue(c, null)).ToList();
                }
                var total = resset.Count();
                var skip = pageSize * (page - 1);
                var canPage = skip < total;
                obj.Response = resset.Skip(skip).Take(pageSize).ToList().ToJson();
                obj.reccount = total;
            }
            catch (Exception ex)
            {
                obj.Error = ex.ToJson();
            }
            return obj.ToJson();

        }
        [OperationContract]
        [WebInvoke(Method = "POST",
BodyStyle = WebMessageBodyStyle.WrappedRequest,
RequestFormat = WebMessageFormat.Json,
ResponseFormat = WebMessageFormat.Json)]
        public string GetContactSearch(string contacttype, string lname, string fname, string ssn, string dob, string pnumber, string email, string address, string county, string state, string zip, string city, string resptype, string respid, int pageSize, int page, string sortby, string sortexp, List<searchfltr> sdata)
        {
            Jsonhelper obj = new Jsonhelper();
            try
            {
                if (zip != "")
                {
                    if (zip.Substring(zip.Length - 1, 1) == "-")
                        zip = zip.Substring(0, zip.Length - 1);
                }
                var resset = Person_Details.Licensing_Details.GetContactSearch(contacttype, fname, lname, dob, ssn, pnumber, address, city, county, state, zip, city, resptype);

                foreach (searchfltr s in sdata)
                {
                    var slf = typeof(Person_Details.USP_GetContactSearchResult).GetProperty(s.dbfield);
                    resset = resset.Where(c => slf.GetValue(c, null).ToString().ToUpper().Contains(s.searchtxt.ToUpper())).ToList();

                }
                if (sortby != "")
                {
                    var pi = typeof(Person_Details.USP_GetContactSearchResult).GetProperty(sortby);
                    if (sortexp == "asc")
                        resset = resset.OrderBy(c => pi.GetValue(c, null)).ToList();
                    else
                        resset = resset.OrderByDescending(c => pi.GetValue(c, null)).ToList();
                }
                var total = resset.Count();
                var skip = pageSize * (page - 1);
                var canPage = skip < total;
                obj.Response = resset.Skip(skip).Take(pageSize).ToList().ToJson();
                obj.reccount = total;
            }
            catch (Exception ex)
            {
                obj.Error = ex.ToJson();
            }
            return obj.ToJson();

        }
        [OperationContract]
        [WebInvoke(Method = "POST",
BodyStyle = WebMessageBodyStyle.WrappedRequest,
RequestFormat = WebMessageFormat.Json,
ResponseFormat = WebMessageFormat.Json)]
        public string BindPersonwellnessDocument(string pid, int pageSize, int page, string sortby, string sortexp, List<searchfltr> sdata)
        {
            Jsonhelper obj = new Jsonhelper();
            try
            {

                var resset = Person_Details.Licensing_Details.GetWellnessDocument(pid);

                foreach (searchfltr s in sdata)
                {
                    var slf = typeof(Person_Details.USP_WellnessDocumentResult).GetProperty(s.dbfield);
                    resset = resset.Where(c => slf.GetValue(c, null).ToString().ToUpper().Contains(s.searchtxt.ToUpper())).ToList();

                }
                if (sortby != "")
                {
                    var pi = typeof(Person_Details.USP_WellnessDocumentResult).GetProperty(sortby);
                    if (sortexp == "asc")
                        resset = resset.OrderBy(c => pi.GetValue(c, null)).ToList();
                    else
                        resset = resset.OrderByDescending(c => pi.GetValue(c, null)).ToList();
                }
                var total = resset.Count();
                var skip = pageSize * (page - 1);
                var canPage = skip < total;
                obj.Response = resset.Skip(skip).Take(pageSize).ToList().ToJson();
                obj.reccount = total;
            }
            catch (Exception ex)
            {
                obj.Error = ex.ToJson();
            }
            return obj.ToJson();

        }
        [OperationContract]
        [WebInvoke(Method = "POST",
BodyStyle = WebMessageBodyStyle.WrappedRequest,
RequestFormat = WebMessageFormat.Json,
ResponseFormat = WebMessageFormat.Json)]
        public string BindPersonEducation(int pid, int pageSize, int page, string sortby, string sortexp, List<searchfltr> sdata)
        {
            Jsonhelper obj = new Jsonhelper();
            try
            {

                var resset = Person_Details.Licensing_Details.GetEducation(pid);

                foreach (searchfltr s in sdata)
                {
                    var slf = typeof(Person_Details.USP_Licensing_GetEducationResult).GetProperty(s.dbfield);
                    resset = resset.Where(c => slf.GetValue(c, null).ToString().ToUpper().Contains(s.searchtxt.ToUpper())).ToList();

                }
                if (sortby != "")
                {
                    var pi = typeof(Person_Details.USP_Licensing_GetEducationResult).GetProperty(sortby);
                    if (sortexp == "asc")
                        resset = resset.OrderBy(c => pi.GetValue(c, null)).ToList();
                    else
                        resset = resset.OrderByDescending(c => pi.GetValue(c, null)).ToList();
                }
                var total = resset.Count();
                var skip = pageSize * (page - 1);
                var canPage = skip < total;
                obj.Response = resset.Skip(skip).Take(pageSize).ToList().ToJson();
                obj.reccount = total;
            }
            catch (Exception ex)
            {
                obj.Error = ex.ToJson();
            }
            return obj.ToJson();

        }
        [OperationContract]
        [WebInvoke(Method = "POST",
BodyStyle = WebMessageBodyStyle.WrappedRequest,
RequestFormat = WebMessageFormat.Json,
ResponseFormat = WebMessageFormat.Json)]
        public string BindPersonEmployment(int pid, int pageSize, int page, string sortby, string sortexp, List<searchfltr> sdata)
        {
            Jsonhelper obj = new Jsonhelper();
            try
            {

                var resset = Person_Details.Licensing_Details.BindGrid_Employer(pid);

                foreach (searchfltr s in sdata)
                {
                    var slf = typeof(Person_Details.USP_BindEmployerDataResult).GetProperty(s.dbfield);
                    resset = resset.Where(c => slf.GetValue(c, null).ToString().ToUpper().Contains(s.searchtxt.ToUpper())).ToList();

                }
                if (sortby != "")
                {
                    var pi = typeof(Person_Details.USP_BindEmployerDataResult).GetProperty(sortby);
                    if (sortexp == "asc")
                        resset = resset.OrderBy(c => pi.GetValue(c, null)).ToList();
                    else
                        resset = resset.OrderByDescending(c => pi.GetValue(c, null)).ToList();
                }
                var total = resset.Count();
                var skip = pageSize * (page - 1);
                var canPage = skip < total;
                obj.Response = resset.Skip(skip).Take(pageSize).ToList().ToJson();
                obj.reccount = total;
            }
            catch (Exception ex)
            {
                obj.Error = ex.ToJson();
            }
            return obj.ToJson();

        }
        [OperationContract]
        [WebInvoke(Method = "POST",
BodyStyle = WebMessageBodyStyle.WrappedRequest,
RequestFormat = WebMessageFormat.Json,
ResponseFormat = WebMessageFormat.Json)]
        public string BindPersonexamdetails(string pid, int pageSize, int page, string sortby, string sortexp, List<searchfltr> sdata)
        {
            Jsonhelper obj = new Jsonhelper();
            try
            {

                var resset = PersonLicensing.Utilities_Licensing.GetExamDetails(pid);

                foreach (searchfltr s in sdata)
                {
                    var slf = typeof(License_Data.USP_GetexamdetailsResult).GetProperty(s.dbfield);
                    resset = resset.Where(c => slf.GetValue(c, null).ToString().ToUpper().Contains(s.searchtxt.ToUpper())).ToList();

                }
                if (sortby != "")
                {
                    var pi = typeof(License_Data.USP_GetexamdetailsResult).GetProperty(sortby);
                    if (sortexp == "asc")
                        resset = resset.OrderBy(c => pi.GetValue(c, null)).ToList();
                    else
                        resset = resset.OrderByDescending(c => pi.GetValue(c, null)).ToList();
                }
                var total = resset.Count();
                var skip = pageSize * (page - 1);
                var canPage = skip < total;
                obj.Response = resset.Skip(skip).Take(pageSize).ToList().ToJson();
                obj.reccount = total;
            }
            catch (Exception ex)
            {
                obj.Error = ex.ToJson();
            }
            return obj.ToJson();

        }
        [OperationContract]
        [WebInvoke(Method = "POST",
BodyStyle = WebMessageBodyStyle.WrappedRequest,
RequestFormat = WebMessageFormat.Json,
ResponseFormat = WebMessageFormat.Json)]
        public string BindPersonotherstatelic(string pid, int pageSize, int page, string sortby, string sortexp, List<searchfltr> sdata)
        {
            Jsonhelper obj = new Jsonhelper();
            try
            {

                var resset = PersonLicensing.Utilities_Licensing.Getotherstatelic(pid);

                foreach (searchfltr s in sdata)
                {
                    var slf = typeof(License_Data.USP_GetotherstatelicenseResult).GetProperty(s.dbfield);
                    resset = resset.Where(c => slf.GetValue(c, null).ToString().ToUpper().Contains(s.searchtxt.ToUpper())).ToList();

                }
                if (sortby != "")
                {
                    var pi = typeof(License_Data.USP_GetotherstatelicenseResult).GetProperty(sortby);
                    if (sortexp == "asc")
                        resset = resset.OrderBy(c => pi.GetValue(c, null)).ToList();
                    else
                        resset = resset.OrderByDescending(c => pi.GetValue(c, null)).ToList();
                }
                var total = resset.Count();
                var skip = pageSize * (page - 1);
                var canPage = skip < total;
                obj.Response = resset.Skip(skip).Take(pageSize).ToList().ToJson();
                obj.reccount = total;
            }
            catch (Exception ex)
            {
                obj.Error = ex.ToJson();
            }
            return obj.ToJson();

        }
        [OperationContract]
        [WebInvoke(Method = "POST",
BodyStyle = WebMessageBodyStyle.WrappedRequest,
RequestFormat = WebMessageFormat.Json,
ResponseFormat = WebMessageFormat.Json)]
        public string BindHasPharmacy(int pid, int pageSize, int page, string sortby, string sortexp, List<searchfltr> sdata)
        {
            Jsonhelper obj = new Jsonhelper();
            try
            {

                var resset = PersonLicensing.Utilities_Licensing.GetHasPharmacy(pid);

                foreach (searchfltr s in sdata)
                {
                    var slf = typeof(License_Data.USP_GetpharmacyempResult).GetProperty(s.dbfield);
                    resset = resset.Where(c => slf.GetValue(c, null).ToString().ToUpper().Contains(s.searchtxt.ToUpper())).ToList();

                }
                if (sortby != "")
                {
                    var pi = typeof(License_Data.USP_GetpharmacyempResult).GetProperty(sortby);
                    if (sortexp == "asc")
                        resset = resset.OrderBy(c => pi.GetValue(c, null)).ToList();
                    else
                        resset = resset.OrderByDescending(c => pi.GetValue(c, null)).ToList();
                }
                var total = resset.Count();
                var skip = pageSize * (page - 1);
                var canPage = skip < total;
                obj.Response = resset.Skip(skip).Take(pageSize).ToList().ToJson();
                obj.reccount = total;
            }
            catch (Exception ex)
            {
                obj.Error = ex.ToJson();
            }
            return obj.ToJson();

        }
        [OperationContract]
        [WebInvoke(Method = "POST",
BodyStyle = WebMessageBodyStyle.WrappedRequest,
RequestFormat = WebMessageFormat.Json,
ResponseFormat = WebMessageFormat.Json)]
        public string BindLicenseinfo(int pid, int pageSize, int page, string sortby, string sortexp, List<searchfltr> sdata)
        {
            Jsonhelper obj = new Jsonhelper();
            try
            {

                var resset = PersonLicensing.Utilities_Licensing.Get_Person_licenseInfo(pid.ToString());

                foreach (searchfltr s in sdata)
                {
                    var slf = typeof(Person_Details.USP_GetLicenseinfobypersonidResult).GetProperty(s.dbfield);
                    resset = resset.Where(c => slf.GetValue(c, null).ToString().ToUpper().Contains(s.searchtxt.ToUpper())).ToList();

                }
                if (sortby != "")
                {
                    var pi = typeof(Person_Details.USP_GetLicenseinfobypersonidResult).GetProperty(sortby);
                    if (sortexp == "asc")
                        resset = resset.OrderBy(c => pi.GetValue(c, null)).ToList();
                    else
                        resset = resset.OrderByDescending(c => pi.GetValue(c, null)).ToList();
                }
                var total = resset.Count();
               
                obj.Response = resset.ToList().ToJson();
                obj.reccount = total;
            }
            catch (Exception ex)
            {
                obj.Error = ex.ToJson();
            }
            return obj.ToJson();

        }
        [OperationContract]
        [WebInvoke(Method = "POST",
BodyStyle = WebMessageBodyStyle.WrappedRequest,
RequestFormat = WebMessageFormat.Json,
ResponseFormat = WebMessageFormat.Json)]
        public string BindComplaintInfo(int pid, int pageSize, int page, string sortby, string sortexp, List<searchfltr> sdata)
        {
            Jsonhelper obj = new Jsonhelper();
            try
            {

                var resset = Complaints.Utilities_ComplaintsTAB.Get_ComplaintInfo(pid);

                foreach (searchfltr s in sdata)
                {
                    var slf = typeof(ComplaintsLink.USP_GetComplaintInfobyPersonidResult).GetProperty(s.dbfield);
                    resset = resset.Where(c => slf.GetValue(c, null).ToString().ToUpper().Contains(s.searchtxt.ToUpper())).ToList();

                }
                if (sortby != "")
                {
                    var pi = typeof(ComplaintsLink.USP_GetComplaintInfobyPersonidResult).GetProperty(sortby);
                    if (sortexp == "asc")
                        resset = resset.OrderBy(c => pi.GetValue(c, null)).ToList();
                    else
                        resset = resset.OrderByDescending(c => pi.GetValue(c, null)).ToList();
                }
                var total = resset.Count();

                obj.Response = resset.ToList().ToJson();
                obj.reccount = total;
            }
            catch (Exception ex)
            {
                obj.Error = ex.ToJson();
            }
            return obj.ToJson();

        }
        [OperationContract]
        [WebInvoke(Method = "POST",
BodyStyle = WebMessageBodyStyle.WrappedRequest,
RequestFormat = WebMessageFormat.Json,
ResponseFormat = WebMessageFormat.Json)]
        public string GetHasEmployer(int pid, int pageSize, int page, string sortby, string sortexp, List<searchfltr> sdata)
        {
            Jsonhelper obj = new Jsonhelper();
            try
            {

                var resset = Person_Details.Licensing_Details.GetHasPharmacyEmp(pid);

                foreach (searchfltr s in sdata)
                {
                    var slf = typeof(Person_Details.USP_GetHasPharmacyEmployeeResult).GetProperty(s.dbfield);
                    resset = resset.Where(c => slf.GetValue(c, null).ToString().ToUpper().Contains(s.searchtxt.ToUpper())).ToList();

                }
                if (sortby != "")
                {
                    var pi = typeof(Person_Details.USP_GetHasPharmacyEmployeeResult).GetProperty(sortby);
                    if (sortexp == "asc")
                        resset = resset.OrderBy(c => pi.GetValue(c, null)).ToList();
                    else
                        resset = resset.OrderByDescending(c => pi.GetValue(c, null)).ToList();
                }
                var total = resset.Count();
                var skip = pageSize * (page - 1);
                var canPage = skip < total;
                obj.Response = resset.Skip(skip).Take(pageSize).ToList().ToJson();
                obj.reccount = total;
            }
            catch (Exception ex)
            {
                obj.Error = ex.ToJson();
            }
            return obj.ToJson();

        }
        [OperationContract]
        [WebInvoke(Method = "POST",
BodyStyle = WebMessageBodyStyle.WrappedRequest,
RequestFormat = WebMessageFormat.Json,
ResponseFormat = WebMessageFormat.Json)]
        public string GetSUpervisor(int pid, int pageSize, int page, string sortby, string sortexp, List<searchfltr> sdata)
        {
            Jsonhelper obj = new Jsonhelper();
            try
            {

                var resset = License_Data.License_Details.Get_superres(pid);

                foreach (searchfltr s in sdata)
                {
                    var slf = typeof(License_Data.USP_GetsuperResult).GetProperty(s.dbfield);
                    resset = resset.Where(c => slf.GetValue(c, null).ToString().ToUpper().Contains(s.searchtxt.ToUpper())).ToList();

                }
                if (sortby != "")
                {
                    var pi = typeof(License_Data.USP_GetsuperResult).GetProperty(sortby);
                    if (sortexp == "asc")
                        resset = resset.OrderBy(c => pi.GetValue(c, null)).ToList();
                    else
                        resset = resset.OrderByDescending(c => pi.GetValue(c, null)).ToList();
                }
                var total = resset.Count();
                var skip = pageSize * (page - 1);
                var canPage = skip < total;
                obj.Response = resset.Skip(skip).Take(pageSize).ToList().ToJson();
                obj.reccount = total;
            }
            catch (Exception ex)
            {
                obj.Error = ex.ToJson();
            }
            return obj.ToJson();

        }
        
        [OperationContract]
        [WebInvoke(Method = "POST",
BodyStyle = WebMessageBodyStyle.WrappedRequest,
RequestFormat = WebMessageFormat.Json,
ResponseFormat = WebMessageFormat.Json)]
        public string Bindcontacts(int objid, int pid, int pageSize, int page, string sortby, string sortexp, List<searchfltr> sdata)
        {
            Jsonhelper obj = new Jsonhelper();
            try
            {

                var resset = PersonLicensing.Utilities_Licensing.GetContacts(objid, pid);

                foreach (searchfltr s in sdata)
                {
                    var slf = typeof(License_Data.USP_GetcontactsResult).GetProperty(s.dbfield);
                    resset = resset.Where(c => slf.GetValue(c, null).ToString().ToUpper().Contains(s.searchtxt.ToUpper())).ToList();

                }
                if (sortby != "")
                {
                    var pi = typeof(License_Data.USP_GetcontactsResult).GetProperty(sortby);
                    if (sortexp == "asc")
                        resset = resset.OrderBy(c => pi.GetValue(c, null)).ToList();
                    else
                        resset = resset.OrderByDescending(c => pi.GetValue(c, null)).ToList();
                }
                var total = resset.Count();
                var skip = pageSize * (page - 1);
                var canPage = skip < total;
                obj.Response = resset.Skip(skip).Take(pageSize).ToList().ToJson();
                obj.reccount = total;
            }
            catch (Exception ex)
            {
                obj.Error = ex.ToJson();
            }
            return obj.ToJson();

        }
        [OperationContract]
        [WebInvoke(Method = "POST",
BodyStyle = WebMessageBodyStyle.WrappedRequest,
RequestFormat = WebMessageFormat.Json,
ResponseFormat = WebMessageFormat.Json)]
        public string BindInspectionDetails(int pid, int pageSize, int page, string sortby, string sortexp, List<searchfltr> sdata)
        {
            Jsonhelper obj = new Jsonhelper();
            try
            {

                var resset = Person_Details.Licensing_Details.Get_InspectionJournal(pid);

                foreach (searchfltr s in sdata)
                {
                    var slf = typeof(Person_Details.USP_GetInspectionJournalResult).GetProperty(s.dbfield);
                    resset = resset.Where(c => slf.GetValue(c, null).ToString().ToUpper().Contains(s.searchtxt.ToUpper())).ToList();

                }
                if (sortby != "")
                {
                    var pi = typeof(Person_Details.USP_GetInspectionJournalResult).GetProperty(sortby);
                    if (sortexp == "asc")
                        resset = resset.OrderBy(c => pi.GetValue(c, null)).ToList();
                    else
                        resset = resset.OrderByDescending(c => pi.GetValue(c, null)).ToList();
                }
                var total = resset.Count();
                var skip = pageSize * (page - 1);
                var canPage = skip < total;
                obj.Response = resset.Skip(skip).Take(pageSize).ToList().ToJson();
                obj.reccount = total;
            }
            catch (Exception ex)
            {
                obj.Error = ex.ToJson();
            }
            return obj.ToJson();

        }
        [OperationContract]
        [WebInvoke(Method = "POST",
BodyStyle = WebMessageBodyStyle.WrappedRequest,
RequestFormat = WebMessageFormat.Json,
ResponseFormat = WebMessageFormat.Json)]
        public string Bindcontrolledsubstances(string pid,string appid, int pageSize, int page, string sortby, string sortexp, List<searchfltr> sdata)
        {
            Jsonhelper obj = new Jsonhelper();
            try
            {

                var resset = PersonLicensing.Utilities_Licensing.Getcontrolledsubstances(pid);
                if (appid != "")
                {
                    List<License_Data.USP_Getcertifications_substancesResult> dresult = new List<License_Data.USP_Getcertifications_substancesResult>();
                    string[] apf = appid.Split(',');
                    foreach (string t in apf)
                        if (t.Trim() != "")
                            dresult.AddRange(resset.Where(c => c.App_ID == Convert.ToInt32(t)).ToList());
                    resset = dresult;
                }
                foreach (searchfltr s in sdata)
                {
                    var slf = typeof(License_Data.USP_Getcertifications_substancesResult).GetProperty(s.dbfield);
                    resset = resset.Where(c => slf.GetValue(c, null).ToString().ToUpper().Contains(s.searchtxt.ToUpper())).ToList();

                }
                if (sortby != "")
                {
                    var pi = typeof(License_Data.USP_Getcertifications_substancesResult).GetProperty(sortby);
                    if (sortexp == "asc")
                        resset = resset.OrderBy(c => pi.GetValue(c, null)).ToList();
                    else
                        resset = resset.OrderByDescending(c => pi.GetValue(c, null)).ToList();
                }
                var total = resset.Count();
                var skip = pageSize * (page - 1);
                var canPage = skip < total;
                obj.Response = resset.Skip(skip).Take(pageSize).ToList().ToJson();
                obj.reccount = total;
            }
            catch (Exception ex)
            {
                obj.Error = ex.ToJson();
            }
            return obj.ToJson();

        }
        [OperationContract]
        [WebInvoke(Method = "POST",
BodyStyle = WebMessageBodyStyle.WrappedRequest,
RequestFormat = WebMessageFormat.Json,
ResponseFormat = WebMessageFormat.Json)]
        public string BindMailorders(string pid, int pageSize, int page, string sortby, string sortexp, List<searchfltr> sdata)
        {
            Jsonhelper obj = new Jsonhelper();
            try
            {

                var resset = PersonLicensing.Utilities_Licensing.GetMailOrders(pid);

                foreach (searchfltr s in sdata)
                {
                    var slf = typeof(License_Data.USP_Getcertifications_MailorderResult).GetProperty(s.dbfield);
                    resset = resset.Where(c => slf.GetValue(c, null).ToString().ToUpper().Contains(s.searchtxt.ToUpper())).ToList();

                }
                if (sortby != "")
                {
                    var pi = typeof(License_Data.USP_Getcertifications_MailorderResult).GetProperty(sortby);
                    if (sortexp == "asc")
                        resset = resset.OrderBy(c => pi.GetValue(c, null)).ToList();
                    else
                        resset = resset.OrderByDescending(c => pi.GetValue(c, null)).ToList();
                }
                var total = resset.Count();
                var skip = pageSize * (page - 1);
                var canPage = skip < total;
                obj.Response = resset.Skip(skip).Take(pageSize).ToList().ToJson();
                obj.reccount = total;
            }
            catch (Exception ex)
            {
                obj.Error = ex.ToJson();
            }
            return obj.ToJson();

        }
       
        [OperationContract]
        [WebInvoke(Method = "POST",
BodyStyle = WebMessageBodyStyle.WrappedRequest,
RequestFormat = WebMessageFormat.Json,
ResponseFormat = WebMessageFormat.Json)]
        public string BindPersonFeeDetails(int pid, int pageSize, int page, string sortby, string sortexp, List<searchfltr> sdata)
        {
            Jsonhelper obj = new Jsonhelper();
            try
            {

                var resset = Person_Details.Licensing_Details.Get_FeedetailsData(pid);

                foreach (searchfltr s in sdata)
                {
                    var slf = typeof(Person_Details.USP_Licensing_GetFeeDetailsResult).GetProperty(s.dbfield);
                    resset = resset.Where(c => slf.GetValue(c, null).ToString().ToUpper().Contains(s.searchtxt.ToUpper())).ToList();

                }
                if (sortby != "")
                {
                    var pi = typeof(Person_Details.USP_Licensing_GetFeeDetailsResult).GetProperty(sortby);
                    if (sortexp == "asc")
                        resset = resset.OrderBy(c => pi.GetValue(c, null)).ToList();
                    else
                        resset = resset.OrderByDescending(c => pi.GetValue(c, null)).ToList();
                }
                var total = resset.Count();
                var skip = pageSize * (page - 1);
                var canPage = skip < total;
                obj.Response = resset.Skip(skip).Take(pageSize).ToList().ToJson();
                obj.reccount = total;
            }
            catch (Exception ex)
            {
                obj.Error = ex.ToJson();
            }
            return obj.ToJson();

        }
        [OperationContract]
        [WebInvoke(Method = "POST",
BodyStyle = WebMessageBodyStyle.WrappedRequest,
RequestFormat = WebMessageFormat.Json,
ResponseFormat = WebMessageFormat.Json)]
        public string BindPersonjournal(int pid, int pageSize, int page, string sortby, string sortexp, List<searchfltr> sdata)
        {
            Jsonhelper obj = new Jsonhelper();
            try
            {

                var resset = Person_Details.Licensing_Details.Get_JournalValues(pid);

                foreach (searchfltr s in sdata)
                {
                    var slf = typeof(Person_Details.USP_Licensing_GetJournalValuesResult).GetProperty(s.dbfield);
                    resset = resset.Where(c => slf.GetValue(c, null).ToString().ToUpper().Contains(s.searchtxt.ToUpper())).ToList();

                }
                if (sortby != "")
                {
                    var pi = typeof(Person_Details.USP_Licensing_GetJournalValuesResult).GetProperty(sortby);
                    if (sortexp == "asc")
                        resset = resset.OrderBy(c => pi.GetValue(c, null)).ToList();
                    else
                        resset = resset.OrderByDescending(c => pi.GetValue(c, null)).ToList();
                }
                var total = resset.Count();
                var skip = pageSize * (page - 1);
                var canPage = skip < total;
                obj.Response = resset.Skip(skip).Take(pageSize).ToList().ToJson();
                obj.reccount = total;
            }
            catch (Exception ex)
            {
                obj.Error = ex.ToJson();
            }
            return obj.ToJson();

        }
        [OperationContract]
        [WebInvoke(Method = "POST",
BodyStyle = WebMessageBodyStyle.WrappedRequest,
RequestFormat = WebMessageFormat.Json,
ResponseFormat = WebMessageFormat.Json)]
        public string BindPersonpayment(int pid, int pageSize, int page, string sortby, string sortexp, List<searchfltr> sdata)
        {
            Jsonhelper obj = new Jsonhelper();
            try
            {

                var resset = Person_Details.Licensing_Details.Get_PaymentHistory(pid);

                foreach (searchfltr s in sdata)
                {
                    var slf = typeof(Person_Details.USP_Get_FinancePaymentHistoryDetailsResult).GetProperty(s.dbfield);
                    resset = resset.Where(c => slf.GetValue(c, null).ToString().ToUpper().Contains(s.searchtxt.ToUpper())).ToList();

                }
                if (sortby != "")
                {
                    var pi = typeof(Person_Details.USP_Get_FinancePaymentHistoryDetailsResult).GetProperty(sortby);
                    if (sortexp == "asc")
                        resset = resset.OrderBy(c => pi.GetValue(c, null)).ToList();
                    else
                        resset = resset.OrderByDescending(c => pi.GetValue(c, null)).ToList();
                }
                var total = resset.Count();
                var skip = pageSize * (page - 1);
                var canPage = skip < total;
                obj.Response = resset.Skip(skip).Take(pageSize).ToList().ToJson();
                obj.reccount = total;
            }
            catch (Exception ex)
            {
                obj.Error = ex.ToJson();
            }
            return obj.ToJson();

        }
        [OperationContract]
        [WebInvoke(Method = "POST",
BodyStyle = WebMessageBodyStyle.WrappedRequest,
RequestFormat = WebMessageFormat.Json,
ResponseFormat = WebMessageFormat.Json)]
        public string BindPersonpaymentvoid(int pid, int pageSize, int page, string sortby, string sortexp, List<searchfltr> sdata)
        {
            Jsonhelper obj = new Jsonhelper();
            try
            {

                var resset = Person_Details.Licensing_Details.Get_VoidHistory(pid);

                foreach (searchfltr s in sdata)
                {
                    var slf = typeof(Person_Details.USP_Licensing_GetFinanceVoidHistoryDetailsResult).GetProperty(s.dbfield);
                    resset = resset.Where(c => slf.GetValue(c, null).ToString().ToUpper().Contains(s.searchtxt.ToUpper())).ToList();

                }
                if (sortby != "")
                {
                    var pi = typeof(Person_Details.USP_Licensing_GetFinanceVoidHistoryDetailsResult).GetProperty(sortby);
                    if (sortexp == "asc")
                        resset = resset.OrderBy(c => pi.GetValue(c, null)).ToList();
                    else
                        resset = resset.OrderByDescending(c => pi.GetValue(c, null)).ToList();
                }
                var total = resset.Count();
                var skip = pageSize * (page - 1);
                var canPage = skip < total;
                obj.Response = resset.Skip(skip).Take(pageSize).ToList().ToJson();
                obj.reccount = total;
            }
            catch (Exception ex)
            {
                obj.Error = ex.ToJson();
            }
            return obj.ToJson();

        }
        [OperationContract]
        [WebInvoke(Method = "POST",
BodyStyle = WebMessageBodyStyle.WrappedRequest,
RequestFormat = WebMessageFormat.Json,
ResponseFormat = WebMessageFormat.Json)]
        public string BindPersonpaymentaudit(int pid, int pageSize, int page, string sortby, string sortexp, List<searchfltr> sdata)
        {
            Jsonhelper obj = new Jsonhelper();
            try
            {

                var resset = Person_Details.Licensing_Details.Get_AuditHistory(pid);

                foreach (searchfltr s in sdata)
                {
                    var slf = typeof(Person_Details.USP_Finance_Get_FeeAuditHistoryDetailsResult).GetProperty(s.dbfield);
                    resset = resset.Where(c => slf.GetValue(c, null).ToString().ToUpper().Contains(s.searchtxt.ToUpper())).ToList();

                }
                if (sortby != "")
                {
                    var pi = typeof(Person_Details.USP_Finance_Get_FeeAuditHistoryDetailsResult).GetProperty(sortby);
                    if (sortexp == "asc")
                        resset = resset.OrderBy(c => pi.GetValue(c, null)).ToList();
                    else
                        resset = resset.OrderByDescending(c => pi.GetValue(c, null)).ToList();
                }
                var total = resset.Count();
                var skip = pageSize * (page - 1);
                var canPage = skip < total;
                obj.Response = resset.Skip(skip).Take(pageSize).ToList().ToJson();
                obj.reccount = total;
            }
            catch (Exception ex)
            {
                obj.Error = ex.ToJson();
            }
            return obj.ToJson();

        }
        [OperationContract]
        [WebInvoke(Method = "POST",
BodyStyle = WebMessageBodyStyle.WrappedRequest,
RequestFormat = WebMessageFormat.Json,
ResponseFormat = WebMessageFormat.Json)]
        public string BindPersonpaymenthistory(int pid, int pageSize, int page, string sortby, string sortexp, List<searchfltr> sdata)
        {
            Jsonhelper obj = new Jsonhelper();
            try
            {

                var resset = Person_Details.Licensing_Details.Get_PaymentHistory(pid);

                foreach (searchfltr s in sdata)
                {
                    var slf = typeof(Person_Details.USP_Get_FinancePaymentHistoryDetailsResult).GetProperty(s.dbfield);
                    resset = resset.Where(c => slf.GetValue(c, null).ToString().ToUpper().Contains(s.searchtxt.ToUpper())).ToList();

                }
                if (sortby != "")
                {
                    var pi = typeof(Person_Details.USP_Get_FinancePaymentHistoryDetailsResult).GetProperty(sortby);
                    if (sortexp == "asc")
                        resset = resset.OrderBy(c => pi.GetValue(c, null)).ToList();
                    else
                        resset = resset.OrderByDescending(c => pi.GetValue(c, null)).ToList();
                }
                var total = resset.Count();
                var skip = pageSize * (page - 1);
                var canPage = skip < total;
                obj.Response = resset.Skip(skip).Take(pageSize).ToList().ToJson();
                obj.reccount = total;
            }
            catch (Exception ex)
            {
                obj.Error = ex.ToJson();
            }
            return obj.ToJson();

        }
        [OperationContract]
        [WebInvoke(Method = "POST",
BodyStyle = WebMessageBodyStyle.WrappedRequest,
RequestFormat = WebMessageFormat.Json,
ResponseFormat = WebMessageFormat.Json)]
        public string BindPersonpaymentvoidhistory(int pid, int pageSize, int page, string sortby, string sortexp, List<searchfltr> sdata)
        {
            Jsonhelper obj = new Jsonhelper();
            try
            {

                var resset = Person_Details.Licensing_Details.Get_VoidHistory(pid);

                foreach (searchfltr s in sdata)
                {
                    var slf = typeof(Person_Details.USP_Licensing_GetFinanceVoidHistoryDetailsResult).GetProperty(s.dbfield);
                    resset = resset.Where(c => slf.GetValue(c, null).ToString().ToUpper().Contains(s.searchtxt.ToUpper())).ToList();

                }
                if (sortby != "")
                {
                    var pi = typeof(Person_Details.USP_Licensing_GetFinanceVoidHistoryDetailsResult).GetProperty(sortby);
                    if (sortexp == "asc")
                        resset = resset.OrderBy(c => pi.GetValue(c, null)).ToList();
                    else
                        resset = resset.OrderByDescending(c => pi.GetValue(c, null)).ToList();
                }
                var total = resset.Count();
                var skip = pageSize * (page - 1);
                var canPage = skip < total;
                obj.Response = resset.Skip(skip).Take(pageSize).ToList().ToJson();
                obj.reccount = total;
            }
            catch (Exception ex)
            {
                obj.Error = ex.ToJson();
            }
            return obj.ToJson();

        }
        [OperationContract]
        [WebInvoke(Method = "POST",
BodyStyle = WebMessageBodyStyle.WrappedRequest,
RequestFormat = WebMessageFormat.Json,
ResponseFormat = WebMessageFormat.Json)]
        public string BindPersonpaymentaudithistory(int pid, int pageSize, int page, string sortby, string sortexp, List<searchfltr> sdata)
        {
            Jsonhelper obj = new Jsonhelper();
            try
            {

                var resset = Person_Details.Licensing_Details.Get_AuditHistory(pid);

                foreach (searchfltr s in sdata)
                {
                    var slf = typeof(Person_Details.USP_Finance_Get_FeeAuditHistoryDetailsResult).GetProperty(s.dbfield);
                    resset = resset.Where(c => slf.GetValue(c, null).ToString().ToUpper().Contains(s.searchtxt.ToUpper())).ToList();

                }
                if (sortby != "")
                {
                    var pi = typeof(Person_Details.USP_Finance_Get_FeeAuditHistoryDetailsResult).GetProperty(sortby);
                    if (sortexp == "asc")
                        resset = resset.OrderBy(c => pi.GetValue(c, null)).ToList();
                    else
                        resset = resset.OrderByDescending(c => pi.GetValue(c, null)).ToList();
                }
                var total = resset.Count();
                var skip = pageSize * (page - 1);
                var canPage = skip < total;
                obj.Response = resset.Skip(skip).Take(pageSize).ToList().ToJson();
                obj.reccount = total;
            }
            catch (Exception ex)
            {
                obj.Error = ex.ToJson();
            }
            return obj.ToJson();

        }
        [OperationContract]
        [WebInvoke(Method = "POST",
BodyStyle = WebMessageBodyStyle.WrappedRequest,
RequestFormat = WebMessageFormat.Json,
ResponseFormat = WebMessageFormat.Json)]
        public string BindPersonLicensingData(int pid, int pageSize, int page, string sortby, string sortexp, List<searchfltr> sdata)
        {
            Jsonhelper obj = new Jsonhelper();
            try
            {

                var resset = Person_Details.Licensing_Details.GetLicensing_Details(pid);

                foreach (searchfltr s in sdata)
                {
                    var slf = typeof(Person_Details.USP_Licensing_DetailsResult).GetProperty(s.dbfield);
                    resset = resset.Where(c => slf.GetValue(c, null).ToString().ToUpper().Contains(s.searchtxt.ToUpper())).ToList();

                }
                if (sortby != "")
                {
                    var pi = typeof(Person_Details.USP_Licensing_DetailsResult).GetProperty(sortby);
                    if (sortexp == "asc")
                        resset = resset.OrderBy(c => pi.GetValue(c, null)).ToList();
                    else
                        resset = resset.OrderByDescending(c => pi.GetValue(c, null)).ToList();
                }
                var total = resset.Count();
                var skip = pageSize * (page - 1);
                var canPage = skip < total;
                obj.Response = resset.Skip(skip).Take(pageSize).ToList().ToJson();
                obj.reccount = total;
            }
            catch (Exception ex)
            {
                obj.Error = ex.ToJson();
            }
            return obj.ToJson();

        }
        [OperationContract]
        [WebInvoke(Method = "POST",
BodyStyle = WebMessageBodyStyle.WrappedRequest,
RequestFormat = WebMessageFormat.Json,
ResponseFormat = WebMessageFormat.Json)]
        public string BindPersonAlert(int pid, int pageSize, int page, string sortby, string sortexp, List<searchfltr> sdata)
        {
            Jsonhelper obj = new Jsonhelper();
            try
            {

                var resset = Person_Details.Licensing_Details.Getalerts(pid);

                foreach (searchfltr s in sdata)
                {
                    var slf = typeof(Person_Details.USP_ShowalertResult).GetProperty(s.dbfield);
                    resset = resset.Where(c => slf.GetValue(c, null).ToString().ToUpper().Contains(s.searchtxt.ToUpper())).ToList();

                }
                if (sortby != "")
                {
                    var pi = typeof(Person_Details.USP_ShowalertResult).GetProperty(sortby);
                    if (sortexp == "asc")
                        resset = resset.OrderBy(c => pi.GetValue(c, null)).ToList();
                    else
                        resset = resset.OrderByDescending(c => pi.GetValue(c, null)).ToList();
                }
                var total = resset.Count();
                var skip = pageSize * (page - 1);
                var canPage = skip < total;
                obj.Response = resset.Skip(skip).Take(pageSize).ToList().ToJson();
                obj.reccount = total;
            }
            catch (Exception ex)
            {
                obj.Error = ex.ToJson();
            }
            return obj.ToJson();

        }

        [OperationContract]
        [WebInvoke(Method = "POST",
BodyStyle = WebMessageBodyStyle.WrappedRequest,
RequestFormat = WebMessageFormat.Json,
ResponseFormat = WebMessageFormat.Json)]
        public string BindLicense_Renewals(string licid, int pageSize, int page, string sortby, string sortexp, List<searchfltr> sdata)
        {
            Jsonhelper obj = new Jsonhelper();
            try
            {

                var resset = PersonLicensing.Utilities_Licensing.Getlicrenewals(licid);

                foreach (searchfltr s in sdata)
                {
                    var slf = typeof(License_Data.USP_Get_LicrenewalsResult).GetProperty(s.dbfield);
                    resset = resset.Where(c => slf.GetValue(c, null).ToString().ToUpper().Contains(s.searchtxt.ToUpper())).ToList();

                }
                if (sortby != "")
                {
                    var pi = typeof(License_Data.USP_Get_LicrenewalsResult).GetProperty(sortby);
                    if (sortexp == "asc")
                        resset = resset.OrderBy(c => pi.GetValue(c, null)).ToList();
                    else
                        resset = resset.OrderByDescending(c => pi.GetValue(c, null)).ToList();
                }
                var total = resset.Count();
                var skip = pageSize * (page - 1);
                var canPage = skip < total;
                obj.Response = resset.Skip(skip).Take(pageSize).ToList().ToJson();
                obj.reccount = total;
            }
            catch (Exception ex)
            {
                obj.Error = ex.ToJson();
            }
            return obj.ToJson();

        }
        [OperationContract]
        [WebInvoke(Method = "POST",
BodyStyle = WebMessageBodyStyle.WrappedRequest,
RequestFormat = WebMessageFormat.Json,
ResponseFormat = WebMessageFormat.Json)]
        public string Bindperson_Certification(string pid, int pageSize, int page, string sortby, string sortexp, List<searchfltr> sdata)
        {
            Jsonhelper obj = new Jsonhelper();
            try
            {

                var resset = PersonLicensing.Utilities_Licensing.Getcertifications(pid);

                foreach (searchfltr s in sdata)
                {
                    var slf = typeof(License_Data.USP_GetcertificationsResult).GetProperty(s.dbfield);
                    resset = resset.Where(c => slf.GetValue(c, null).ToString().ToUpper().Contains(s.searchtxt.ToUpper())).ToList();

                }
                if (sortby != "")
                {
                    var pi = typeof(License_Data.USP_GetcertificationsResult).GetProperty(sortby);
                    if (sortexp == "asc")
                        resset = resset.OrderBy(c => pi.GetValue(c, null)).ToList();
                    else
                        resset = resset.OrderByDescending(c => pi.GetValue(c, null)).ToList();
                }
                var total = resset.Count();
                var skip = pageSize * (page - 1);
                var canPage = skip < total;
                obj.Response = resset.Skip(skip).Take(pageSize).ToList().ToJson();
                obj.reccount = total;
            }
            catch (Exception ex)
            {
                obj.Error = ex.ToJson();
            }
            return obj.ToJson();

        }
       
        [OperationContract]
        [WebInvoke(Method = "POST",
BodyStyle = WebMessageBodyStyle.WrappedRequest,
RequestFormat = WebMessageFormat.Json,
ResponseFormat = WebMessageFormat.Json)]
        public string BindPersonAlerthistory(int pid, int pageSize, int page, string sortby, string sortexp, List<searchfltr> sdata)
        {
            Jsonhelper obj = new Jsonhelper();
            try
            {

                var resset = Person_Details.Licensing_Details.Person_AlertData(pid);

                foreach (searchfltr s in sdata)
                {
                    var slf = typeof(Person_Details.USP_GetPersonAlert_DataResult).GetProperty(s.dbfield);
                    resset = resset.Where(c => slf.GetValue(c, null).ToString().ToUpper().Contains(s.searchtxt.ToUpper())).ToList();

                }
                if (sortby != "")
                {
                    var pi = typeof(Person_Details.USP_GetPersonAlert_DataResult).GetProperty(sortby);
                    if (sortexp == "asc")
                        resset = resset.OrderBy(c => pi.GetValue(c, null)).ToList();
                    else
                        resset = resset.OrderByDescending(c => pi.GetValue(c, null)).ToList();
                }
                var total = resset.Count();
                var skip = pageSize * (page - 1);
                var canPage = skip < total;
                obj.Response = resset.Skip(skip).Take(pageSize).ToList().ToJson();
                obj.reccount = total;
            }
            catch (Exception ex)
            {
                obj.Error = ex.ToJson();
            }
            return obj.ToJson();

        }
        [OperationContract]
        [WebInvoke(Method = "POST",
BodyStyle = WebMessageBodyStyle.WrappedRequest,
RequestFormat = WebMessageFormat.Json,
ResponseFormat = WebMessageFormat.Json)]
        public string LicensingHistoryChange(int licid, int pageSize, int page, string sortby, string sortexp, List<searchfltr> sdata)
        {
            Jsonhelper obj = new Jsonhelper();
            try
            {

                var resset = Person_Details.Licensing_Details.GetStatusHistory(licid);

                foreach (searchfltr s in sdata)
                {
                    var slf = typeof(Person_Details.USP_GetLicensehistorychangeResult).GetProperty(s.dbfield);
                    resset = resset.Where(c => slf.GetValue(c, null).ToString().ToUpper().Contains(s.searchtxt.ToUpper())).ToList();

                }
                if (sortby != "")
                {
                    var pi = typeof(Person_Details.USP_GetLicensehistorychangeResult).GetProperty(sortby);
                    if (sortexp == "asc")
                        resset = resset.OrderBy(c => pi.GetValue(c, null)).ToList();
                    else
                        resset = resset.OrderByDescending(c => pi.GetValue(c, null)).ToList();
                }
                var total = resset.Count();
                var skip = pageSize * (page - 1);
                var canPage = skip < total;
                obj.Response = resset.Skip(skip).Take(pageSize).ToList().ToJson();
                obj.reccount = total;
            }
            catch (Exception ex)
            {
                obj.Error = ex.ToJson();
            }
            return obj.ToJson();

        }
        #endregion

        #region Accounting and Finance
        [OperationContract]
        [WebInvoke(Method = "POST",
BodyStyle = WebMessageBodyStyle.WrappedRequest,
RequestFormat = WebMessageFormat.Json,
ResponseFormat = WebMessageFormat.Json)]
        public string BindBatchManagement(string user,string batch,string receipt,string bstatus,string createdfrom,string createdto, int pageSize, int page, string sortby, string sortexp, List<searchfltr> sdata)
        {
            Jsonhelper obj = new Jsonhelper();
            try
            {

                var resset = Accounting_Data.Accounting_Details.GetFinancialAccountBatchResults(user,batch,receipt,bstatus,createdfrom,createdto);

                foreach (searchfltr s in sdata)
                {
                    var slf = typeof(Accounting_Data.USP_Accounting_GetFinancialBatchResultsResult).GetProperty(s.dbfield);
                    resset = resset.Where(c => slf.GetValue(c, null).ToString().ToUpper().Contains(s.searchtxt.ToUpper())).ToList();

                }
                if (sortby != "")
                {
                    var pi = typeof(Accounting_Data.USP_Accounting_GetFinancialBatchResultsResult).GetProperty(sortby);
                    if (sortexp == "asc")
                        resset = resset.OrderBy(c => pi.GetValue(c, null)).ToList();
                    else
                        resset = resset.OrderByDescending(c => pi.GetValue(c, null)).ToList();
                }
                var total = resset.Count();
                var skip = pageSize * (page - 1);
                var canPage = skip < total;
                obj.Response = resset.Skip(skip).Take(pageSize).ToList().ToJson();
                obj.reccount = total;
            }
            catch (Exception ex)
            {
                obj.Error = ex.ToJson();
            }
            return obj.ToJson();

        }
        [OperationContract]
        [WebInvoke(Method = "POST",
BodyStyle = WebMessageBodyStyle.WrappedRequest,
RequestFormat = WebMessageFormat.Json,
ResponseFormat = WebMessageFormat.Json)]
        public string BindBatchTransaction(string batchno, string sortby, string sortexp, List<searchfltr> sdata)
        {
            Jsonhelper obj = new Jsonhelper();
            try
            {

                var resset = Accounting_Data.Accounting_Details.GetFinancialAccountBatchTransforBatchNoResults(batchno);

                foreach (searchfltr s in sdata)
                {
                    var slf = typeof(Accounting_Data.USP_Accounting_GetFinancialBatchTransforBatchNoResultsResult).GetProperty(s.dbfield);
                    resset = resset.Where(c => slf.GetValue(c, null).ToString().ToUpper().Contains(s.searchtxt.ToUpper())).ToList();

                }
                if (sortby != "")
                {
                    var pi = typeof(Accounting_Data.USP_Accounting_GetFinancialBatchTransforBatchNoResultsResult).GetProperty(sortby);
                    if (sortexp == "asc")
                        resset = resset.OrderBy(c => pi.GetValue(c, null)).ToList();
                    else
                        resset = resset.OrderByDescending(c => pi.GetValue(c, null)).ToList();
                }
                var total = resset.Count();
               
                obj.Response = resset.ToList().ToJson();
                obj.reccount = total;
            }
            catch (Exception ex)
            {
                obj.Error = ex.ToJson();
            }
            return obj.ToJson();

        }
        [OperationContract]
        [WebInvoke(Method = "POST",
BodyStyle = WebMessageBodyStyle.WrappedRequest,
RequestFormat = WebMessageFormat.Json,
ResponseFormat = WebMessageFormat.Json)]
        public string Bindverifybatch(string batchno, int pageSize, int page, string sortby, string sortexp, List<searchfltr> sdata)
        {
            Jsonhelper obj = new Jsonhelper();
            try
            {

                var resset = Accounting_Data.Accounting_Details.GetFinancialAccountBatchTransforBatchNoResults(batchno);

                foreach (searchfltr s in sdata)
                {
                    var slf = typeof(Accounting_Data.USP_Accounting_GetFinancialBatchTransforBatchNoResultsResult).GetProperty(s.dbfield);
                    resset = resset.Where(c => slf.GetValue(c, null).ToString().ToUpper().Contains(s.searchtxt.ToUpper())).ToList();

                }
                if (sortby != "")
                {
                    var pi = typeof(Accounting_Data.USP_Accounting_GetFinancialBatchTransforBatchNoResultsResult).GetProperty(sortby);
                    if (sortexp == "asc")
                        resset = resset.OrderBy(c => pi.GetValue(c, null)).ToList();
                    else
                        resset = resset.OrderByDescending(c => pi.GetValue(c, null)).ToList();
                }
                var total = resset.Count();
                var skip = pageSize * (page - 1);
                var canPage = skip < total;
                obj.Response = resset.Skip(skip).Take(pageSize).ToList().ToJson();
                obj.reccount = total;
            }
            catch (Exception ex)
            {
                obj.Error = ex.ToJson();
            }
            return obj.ToJson();

        }
        
        [OperationContract]
        [WebInvoke(Method = "POST",
BodyStyle = WebMessageBodyStyle.WrappedRequest,
RequestFormat = WebMessageFormat.Json,
ResponseFormat = WebMessageFormat.Json)]
        public string Bindsearchoperations(string date, string fromsender,string frwd, string smilclerk, string walk, string license,string checkormo, int pageSize, int page, string sortby, string sortexp, List<searchfltr> sdata)
        {
            Jsonhelper obj = new Jsonhelper();
            try
            {

                var resset = OperationsLink.Operations.GetLogSearchData(date,fromsender,frwd,smilclerk,walk,license,checkormo);
                

                foreach (searchfltr s in sdata)
                {
                    var slf = typeof(OperationsLink.Usp_Operations_get_addlogResult).GetProperty(s.dbfield);
                    resset = resset.Where(c => slf.GetValue(c, null).ToString().ToUpper().Contains(s.searchtxt.ToUpper())).ToList();

                }
                if (sortby != "")
                {
                    var pi = typeof(OperationsLink.Usp_Operations_get_addlogResult).GetProperty(sortby);
                    if (sortexp == "asc")
                        resset = resset.OrderBy(c => pi.GetValue(c, null)).ToList();
                    else
                        resset = resset.OrderByDescending(c => pi.GetValue(c, null)).ToList();
                }
                var total = resset.Count();
                var skip = pageSize * (page - 1);
                var canPage = skip < total;
                obj.Response = resset.Skip(skip).Take(pageSize).ToList().ToJson();
                obj.reccount = total;
            }
            catch (Exception ex)
            {
                obj.Error = ex.ToJson();
            }
            return obj.ToJson();

        }
        [OperationContract]
        [WebInvoke(Method = "POST",
BodyStyle = WebMessageBodyStyle.WrappedRequest,
RequestFormat = WebMessageFormat.Json,
ResponseFormat = WebMessageFormat.Json)]
        public string BindNewFeeAdd(int pageSize, int page, string sortby, string sortexp, List<searchfltr> sdata)
        {
            Jsonhelper obj = new Jsonhelper();
            try
            {

                var resset = Accounting_Data.Accounting_Details.NewFee_Bind().Where(c=>c.Subobj_code!="");

                foreach (searchfltr s in sdata)
                {
                    var slf = typeof(Accounting_Data.tbl_lkp_subobj).GetProperty(s.dbfield);
                    resset = resset.Where(c => slf.GetValue(c, null).ToString().ToUpper().Contains(s.searchtxt.ToUpper())).ToList();

                }
                if (sortby != "")
                {
                    var pi = typeof(Accounting_Data.tbl_lkp_subobj).GetProperty(sortby);
                    if (sortexp == "asc")
                        resset = resset.OrderBy(c => pi.GetValue(c, null)).ToList();
                    else
                        resset = resset.OrderByDescending(c => pi.GetValue(c, null)).ToList();
                }
                var total = resset.Count();
                var skip = pageSize * (page - 1);
                var canPage = skip < total;
                obj.Response = resset.Skip(skip).Take(pageSize).ToList().ToJson();
                obj.reccount = total;
            }
            catch (Exception ex)
            {
                obj.Error = ex.ToJson();
            }
            return obj.ToJson();

        }
        #endregion
        // Add more operations here and mark them with [OperationContract]
        #region Complaints Tab

        [OperationContract]
        [WebInvoke(Method = "POST",
BodyStyle = WebMessageBodyStyle.WrappedRequest,
RequestFormat = WebMessageFormat.Json,
ResponseFormat = WebMessageFormat.Json)]
        public string BindDcoumentsDetails(string doctype, string fromdate, string todate, int pageSize, int page, string sortby, string sortexp, List<searchfltr> sdata)
        {
            Jsonhelper obj = new Jsonhelper();
            try
            {

                var resset = Complaints.Utilities_ComplaintsTAB.Get_DocumentDetailsbyDoctype(doctype, fromdate, todate);

                foreach (searchfltr s in sdata)
                {
                    var slf = typeof(ComplaintsLink.USP_GetDocumentDetailsbyDoctypeResult).GetProperty(s.dbfield);
                    resset = resset.Where(c => slf.GetValue(c, null).ToString().ToUpper().Contains(s.searchtxt.ToUpper())).ToList();

                }
                if (sortby != "")
                {
                    var pi = typeof(ComplaintsLink.USP_GetDocumentDetailsbyDoctypeResult).GetProperty(sortby);
                    if (sortexp == "asc")
                        resset = resset.OrderBy(c => pi.GetValue(c, null)).ToList();
                    else
                        resset = resset.OrderByDescending(c => pi.GetValue(c, null)).ToList();
                }
                var total = resset.Count();

                obj.Response = resset.ToList().ToJson();
                obj.reccount = total;
            }
            catch (Exception ex)
            {
                obj.Error = ex.ToJson();
            }
            return obj.ToJson();

        }
        [OperationContract]
        [WebInvoke(Method = "POST",
BodyStyle = WebMessageBodyStyle.WrappedRequest,
RequestFormat = WebMessageFormat.Json,
ResponseFormat = WebMessageFormat.Json)]
        public string BindParticipateGeneral(int comid, int pageSize, int page, string sortby, string sortexp, List<searchfltr> sdata)
        {
            Jsonhelper obj = new Jsonhelper();
            try
            {

                var resset = ComplaintsLink.Complaints.getComplaint_Participant(comid);

                foreach (searchfltr s in sdata)
                {
                    var slf = typeof(ComplaintsLink.USP_GetComplaint_ParticipantResult).GetProperty(s.dbfield);
                    resset = resset.Where(c => slf.GetValue(c, null).ToString().ToUpper().Contains(s.searchtxt.ToUpper())).ToList();

                }
                if (sortby != "")
                {
                    var pi = typeof(ComplaintsLink.USP_GetComplaint_ParticipantResult).GetProperty(sortby);
                    if (sortexp == "asc")
                        resset = resset.OrderBy(c => pi.GetValue(c, null)).ToList();
                    else
                        resset = resset.OrderByDescending(c => pi.GetValue(c, null)).ToList();
                }
                var total = resset.Count();
                var skip = pageSize * (page - 1);
                var canPage = skip < total;
                obj.Response = resset.Skip(skip).Take(pageSize).ToList().ToJson();
                obj.reccount = total;
            }
            catch (Exception ex)
            {
                obj.Error = ex.ToJson();
            }
            return obj.ToJson();

        }


        [OperationContract]
        [WebInvoke(Method = "POST",
BodyStyle = WebMessageBodyStyle.WrappedRequest,
RequestFormat = WebMessageFormat.Json,
ResponseFormat = WebMessageFormat.Json)]
        public string BindParticipantservice(int comid, int partid, int pageSize, int page, string sortby, string sortexp, List<searchfltr> sdata)
        {
            Jsonhelper obj = new Jsonhelper();
            try
            {

                var resset = ComplaintsLink.Complaints.getComplaint_Service(comid, partid);

                foreach (searchfltr s in sdata)
                {
                    var slf = typeof(ComplaintsLink.USP_GetComplaint_ServiceResult).GetProperty(s.dbfield);
                    resset = resset.Where(c => slf.GetValue(c, null).ToString().ToUpper().Contains(s.searchtxt.ToUpper())).ToList();

                }
                if (sortby != "")
                {
                    var pi = typeof(ComplaintsLink.USP_GetComplaint_ServiceResult).GetProperty(sortby);
                    if (sortexp == "asc")
                        resset = resset.OrderBy(c => pi.GetValue(c, null)).ToList();
                    else
                        resset = resset.OrderByDescending(c => pi.GetValue(c, null)).ToList();
                }
                var total = resset.Count();
                var skip = pageSize * (page - 1);
                var canPage = skip < total;
                obj.Response = resset.Skip(skip).Take(pageSize).ToList().ToJson();
                obj.reccount = total;
            }
            catch (Exception ex)
            {
                obj.Error = ex.ToJson();
            }
            return obj.ToJson();

        }

        [OperationContract]
        [WebInvoke(Method = "POST",
BodyStyle = WebMessageBodyStyle.WrappedRequest,
RequestFormat = WebMessageFormat.Json,
ResponseFormat = WebMessageFormat.Json)]
        public string BindAttorney(int comid, int partid, int pageSize, int page, string sortby, string sortexp, List<searchfltr> sdata)
        {
            Jsonhelper obj = new Jsonhelper();
            try
            {

                var resset = ComplaintsLink.Complaints.getComplaint_Attorney(comid, partid);

                foreach (searchfltr s in sdata)
                {
                    var slf = typeof(ComplaintsLink.USP_GetComplaintAttorneyResult).GetProperty(s.dbfield);
                    resset = resset.Where(c => slf.GetValue(c, null).ToString().ToUpper().Contains(s.searchtxt.ToUpper())).ToList();

                }
                if (sortby != "")
                {
                    var pi = typeof(ComplaintsLink.USP_GetComplaintAttorneyResult).GetProperty(sortby);
                    if (sortexp == "asc")
                        resset = resset.OrderBy(c => pi.GetValue(c, null)).ToList();
                    else
                        resset = resset.OrderByDescending(c => pi.GetValue(c, null)).ToList();
                }
                var total = resset.Count();
                var skip = pageSize * (page - 1);
                var canPage = skip < total;
                obj.Response = resset.Skip(skip).Take(pageSize).ToList().ToJson();
                obj.reccount = total;
            }
            catch (Exception ex)
            {
                obj.Error = ex.ToJson();
            }
            return obj.ToJson();

        }



        [OperationContract]
        [WebInvoke(Method = "POST",
BodyStyle = WebMessageBodyStyle.WrappedRequest,
RequestFormat = WebMessageFormat.Json,
ResponseFormat = WebMessageFormat.Json)]
        public string BindEvents(int comid, int partid, int pageSize, int page, string sortby, string sortexp, List<searchfltr> sdata)
        {
            Jsonhelper obj = new Jsonhelper();
            try
            {

                var resset = ComplaintsLink.Complaints.getComplaint_Events(comid, partid);

                foreach (searchfltr s in sdata)
                {
                    var slf = typeof(ComplaintsLink.USP_GetComplaintEventsResult).GetProperty(s.dbfield);
                    resset = resset.Where(c => slf.GetValue(c, null).ToString().ToUpper().Contains(s.searchtxt.ToUpper())).ToList();

                }
                if (sortby != "")
                {
                    var pi = typeof(ComplaintsLink.USP_GetComplaintEventsResult).GetProperty(sortby);
                    if (sortexp == "asc")
                        resset = resset.OrderBy(c => pi.GetValue(c, null)).ToList();
                    else
                        resset = resset.OrderByDescending(c => pi.GetValue(c, null)).ToList();
                }
                var total = resset.Count();
                var skip = pageSize * (page - 1);
                var canPage = skip < total;
                obj.Response = resset.Skip(skip).Take(pageSize).ToList().ToJson();
                obj.reccount = total;
            }
            catch (Exception ex)
            {
                obj.Error = ex.ToJson();
            }
            return obj.ToJson();

        }


        [OperationContract]
        [WebInvoke(Method = "POST",
BodyStyle = WebMessageBodyStyle.WrappedRequest,
RequestFormat = WebMessageFormat.Json,
ResponseFormat = WebMessageFormat.Json)]
        public string BindJournal(int comid, int partid, int pageSize, int page, string sortby, string sortexp, List<searchfltr> sdata)
        {
            Jsonhelper obj = new Jsonhelper();
            try
            {

                var resset = ComplaintsLink.Complaints.getComplaint_Journals(comid, partid);

                foreach (searchfltr s in sdata)
                {
                    var slf = typeof(ComplaintsLink.USP_GetCompliantJournalEditResult).GetProperty(s.dbfield);
                    resset = resset.Where(c => slf.GetValue(c, null).ToString().ToUpper().Contains(s.searchtxt.ToUpper())).ToList();

                }
                if (sortby != "")
                {
                    var pi = typeof(ComplaintsLink.USP_GetCompliantJournalEditResult).GetProperty(sortby);
                    if (sortexp == "asc")
                        resset = resset.OrderBy(c => pi.GetValue(c, null)).ToList();
                    else
                        resset = resset.OrderByDescending(c => pi.GetValue(c, null)).ToList();
                }
                var total = resset.Count();
                var skip = pageSize * (page - 1);
                var canPage = skip < total;
                obj.Response = resset.Skip(skip).Take(pageSize).ToList().ToJson();
                obj.reccount = total;
            }
            catch (Exception ex)
            {
                obj.Error = ex.ToJson();
            }
            return obj.ToJson();

        }


        [OperationContract]
        [WebInvoke(Method = "POST",
BodyStyle = WebMessageBodyStyle.WrappedRequest,
RequestFormat = WebMessageFormat.Json,
ResponseFormat = WebMessageFormat.Json)]
        public string GroupCases(string comid, string cmpnumber)
        {
            return PersonLicensing.Utilities_Licensing.Groupcases(comid, cmpnumber);
        }
        [OperationContract]
        [WebInvoke(Method = "POST",
BodyStyle = WebMessageBodyStyle.WrappedRequest,
RequestFormat = WebMessageFormat.Json,
ResponseFormat = WebMessageFormat.Json)]
        public string ungroupCases(string auid)
        {
            return PersonLicensing.Utilities_Licensing.UnGroupcases(auid);
        }

        [OperationContract]
        [WebInvoke(Method = "POST",
BodyStyle = WebMessageBodyStyle.WrappedRequest,
RequestFormat = WebMessageFormat.Json,
ResponseFormat = WebMessageFormat.Json)]
        public string BindCompanionCases(int comid, int pageSize, int page, string sortby, string sortexp, List<searchfltr> sdata)
        {
            Jsonhelper obj = new Jsonhelper();
            try
            {

                var resset = ComplaintsLink.Complaints.getComplaint_CompanionCases(comid);

                foreach (searchfltr s in sdata)
                {
                    var slf = typeof(ComplaintsLink.USP_GetComplaintCompanionCasesResult).GetProperty(s.dbfield);
                    resset = resset.Where(c => slf.GetValue(c, null).ToString().ToUpper().Contains(s.searchtxt.ToUpper())).ToList();

                }
                if (sortby != "")
                {
                    var pi = typeof(ComplaintsLink.USP_GetComplaintCompanionCasesResult).GetProperty(sortby);
                    if (sortexp == "asc")
                        resset = resset.OrderBy(c => pi.GetValue(c, null)).ToList();
                    else
                        resset = resset.OrderByDescending(c => pi.GetValue(c, null)).ToList();
                }
                var total = resset.Count();
                var skip = pageSize * (page - 1);
                var canPage = skip < total;
                obj.Response = resset.Skip(skip).Take(pageSize).ToList().ToJson();
                obj.reccount = total;
            }
            catch (Exception ex)
            {
                obj.Error = ex.ToJson();
            }
            return obj.ToJson();

        }





        #region Prosecution Sub Tab




        [OperationContract]
        [WebInvoke(Method = "POST",
BodyStyle = WebMessageBodyStyle.WrappedRequest,
RequestFormat = WebMessageFormat.Json,
ResponseFormat = WebMessageFormat.Json)]
        public string BindConsentoffer(int comid, int pageSize, int page, string sortby, string sortexp, List<searchfltr> sdata)
        {
            Jsonhelper obj = new Jsonhelper();
            try
            {

                var resset = ComplaintsLink.Complaints.getComplaint_ConsentOffer(comid);

                foreach (searchfltr s in sdata)
                {
                    var slf = typeof(ComplaintsLink.USP_Complaint_GetConsentOfferResult).GetProperty(s.dbfield);
                    resset = resset.Where(c => slf.GetValue(c, null).ToString().ToUpper().Contains(s.searchtxt.ToUpper())).ToList();

                }
                if (sortby != "")
                {
                    var pi = typeof(ComplaintsLink.USP_Complaint_GetConsentOfferResult).GetProperty(sortby);
                    if (sortexp == "asc")
                        resset = resset.OrderBy(c => pi.GetValue(c, null)).ToList();
                    else
                        resset = resset.OrderByDescending(c => pi.GetValue(c, null)).ToList();
                }
                var total = resset.Count();
                var skip = pageSize * (page - 1);
                var canPage = skip < total;
                obj.Response = resset.Skip(skip).Take(pageSize).ToList().ToJson();
                obj.reccount = total;
            }
            catch (Exception ex)
            {
                obj.Error = ex.ToJson();
            }
            return obj.ToJson();

        }

        [OperationContract]
        [WebInvoke(Method = "POST",
BodyStyle = WebMessageBodyStyle.WrappedRequest,
RequestFormat = WebMessageFormat.Json,
ResponseFormat = WebMessageFormat.Json)]
        public string BindResolutionHistory(string pid, int pageSize, int page, string sortby, string sortexp, List<searchfltr> sdata)
        {
            Jsonhelper obj = new Jsonhelper();
            try
            {

                var resset = ComplaintsLink.Complaints.GetResolutionHistory(pid);

                foreach (searchfltr s in sdata)
                {
                    var slf = typeof(ComplaintsLink.USP_GetResolutionhistoryResult).GetProperty(s.dbfield);
                    resset = resset.Where(c => slf.GetValue(c, null).ToString().ToUpper().Contains(s.searchtxt.ToUpper())).ToList();

                }
                if (sortby != "")
                {
                    var pi = typeof(ComplaintsLink.USP_GetResolutionhistoryResult).GetProperty(sortby);
                    if (sortexp == "asc")
                        resset = resset.OrderBy(c => pi.GetValue(c, null)).ToList();
                    else
                        resset = resset.OrderByDescending(c => pi.GetValue(c, null)).ToList();
                }
                var total = resset.Count();
                var skip = pageSize * (page - 1);
                var canPage = skip < total;
                obj.Response = resset.Skip(skip).Take(pageSize).ToList().ToJson();
                obj.reccount = total;
            }
            catch (Exception ex)
            {
                obj.Error = ex.ToJson();
            }
            return obj.ToJson();

        }


        [OperationContract]
        [WebInvoke(Method = "POST",
BodyStyle = WebMessageBodyStyle.WrappedRequest,
RequestFormat = WebMessageFormat.Json,
ResponseFormat = WebMessageFormat.Json)]
        public string BindFormalHearing(int comid,int pid, int pageSize, int page, string sortby, string sortexp, List<searchfltr> sdata)
        {
            Jsonhelper obj = new Jsonhelper();
            try
            {

                var resset = ComplaintsLink.Complaints.getComplaint_FormalHearing(comid);
                if (pid != 0)
                    resset = resset.Where(c => c.Person_ID == pid).ToList();

                foreach (searchfltr s in sdata)
                {
                    var slf = typeof(ComplaintsLink.USP_Complaint_GetFormalHearingResult).GetProperty(s.dbfield);
                    resset = resset.Where(c => slf.GetValue(c, null).ToString().ToUpper().Contains(s.searchtxt.ToUpper())).ToList();

                }
                if (sortby != "")
                {
                    var pi = typeof(ComplaintsLink.USP_Complaint_GetFormalHearingResult).GetProperty(sortby);
                    if (sortexp == "asc")
                        resset = resset.OrderBy(c => pi.GetValue(c, null)).ToList();
                    else
                        resset = resset.OrderByDescending(c => pi.GetValue(c, null)).ToList();
                }
                var total = resset.Count();
                var skip = pageSize * (page - 1);
                var canPage = skip < total;
                obj.Response = resset.Skip(skip).Take(pageSize).ToList().ToJson();
                obj.reccount = total;
            }
            catch (Exception ex)
            {
                obj.Error = ex.ToJson();
            }
            return obj.ToJson();

        }



        [OperationContract]
        [WebInvoke(Method = "POST",
BodyStyle = WebMessageBodyStyle.WrappedRequest,
RequestFormat = WebMessageFormat.Json,
ResponseFormat = WebMessageFormat.Json)]
        public string BindViolation(int comid, int pageSize, int page, string sortby, string sortexp, List<searchfltr> sdata)
        {
            Jsonhelper obj = new Jsonhelper();
            try
            {

                var resset = ComplaintsLink.Complaints.getComplaint_Violation(comid);

                foreach (searchfltr s in sdata)
                {
                    var slf = typeof(ComplaintsLink.USP_Complaint_GetViolationsResult).GetProperty(s.dbfield);
                    resset = resset.Where(c => slf.GetValue(c, null).ToString().ToUpper().Contains(s.searchtxt.ToUpper())).ToList();

                }
                if (sortby != "")
                {
                    var pi = typeof(ComplaintsLink.USP_Complaint_GetViolationsResult).GetProperty(sortby);
                    if (sortexp == "asc")
                        resset = resset.OrderBy(c => pi.GetValue(c, null)).ToList();
                    else
                        resset = resset.OrderByDescending(c => pi.GetValue(c, null)).ToList();
                }
                var total = resset.Count();
                var skip = pageSize * (page - 1);
                var canPage = skip < total;
                obj.Response = resset.Skip(skip).Take(pageSize).ToList().ToJson();
                obj.reccount = total;
            }
            catch (Exception ex)
            {
                obj.Error = ex.ToJson();
            }
            return obj.ToJson();

        }



        [OperationContract]
        [WebInvoke(Method = "POST",
BodyStyle = WebMessageBodyStyle.WrappedRequest,
RequestFormat = WebMessageFormat.Json,
ResponseFormat = WebMessageFormat.Json)]
        public string BindDiscline(int pid, int pageSize, int page, string sortby, string sortexp, List<searchfltr> sdata)
        {
            Jsonhelper obj = new Jsonhelper();
            try
            {

                var resset = Person_Details.Licensing_Details.Get_DocumentDisciline(pid);


                foreach (searchfltr s in sdata)
                {
                    var slf = typeof(Person_Details.USP_GetDisciplineResult).GetProperty(s.dbfield);
                    resset = resset.Where(c => slf.GetValue(c, null).ToString().ToUpper().Contains(s.searchtxt.ToUpper())).ToList();

                }
                if (sortby != "")
                {
                    var pi = typeof(Person_Details.USP_GetDisciplineResult).GetProperty(sortby);
                    if (sortexp == "asc")
                        resset = resset.OrderBy(c => pi.GetValue(c, null)).ToList();
                    else
                        resset = resset.OrderByDescending(c => pi.GetValue(c, null)).ToList();
                }
                var total = resset.Count();
                var skip = pageSize * (page - 1);
                var canPage = skip < total;
                obj.Response = resset.Skip(skip).Take(pageSize).ToList().ToJson();
                obj.reccount = total;
            }
            catch (Exception ex)
            {
                obj.Error = ex.ToJson();
            }
            return obj.ToJson();
        }








        #endregion
















            #endregion

            #region ComplaintsFormalHearing
        [OperationContract]
        [WebInvoke(Method = "POST",
BodyStyle = WebMessageBodyStyle.WrappedRequest,
RequestFormat = WebMessageFormat.Json,
ResponseFormat = WebMessageFormat.Json)]
        public string BindComplaintsFormalHearing(string fromdate, string todate, int pageSize, int page, string sortby, string sortexp, List<searchfltr> sdata)
        {
            Jsonhelper obj = new Jsonhelper();
            try
            {
                
                if (todate == "")
                    todate = fromdate;
                var resset = ComplaintsLink.Complaints.GetComplaintsFormalHearingReport(fromdate, todate).Where(c=>c.tdb!=true).ToList();

                foreach (searchfltr s in sdata)
                {
                    var slf = typeof(ComplaintsLink.USP_GetComplaintsFormalHearingReportResult).GetProperty(s.dbfield);
                    resset = resset.Where(c => slf.GetValue(c, null).ToString().ToUpper().Contains(s.searchtxt.ToUpper())).ToList();

                }
                if (sortby != "")
                {
                    var pi = typeof(ComplaintsLink.USP_GetComplaintsFormalHearingReportResult).GetProperty(sortby);
                    if (sortexp == "asc")
                        resset = resset.OrderBy(c => pi.GetValue(c, null)).ToList();
                    else
                        resset = resset.OrderByDescending(c => pi.GetValue(c, null)).ToList();
                }
                var total = resset.Count();
                var skip = pageSize * (page - 1);
                var canPage = skip < total;
                obj.Response = resset.Skip(skip).Take(pageSize).ToList().ToJson();
                obj.reccount = total;
            }
            catch (Exception ex)
            {
                obj.Error = ex.ToJson();
            }
            return obj.ToJson();

        }
        [OperationContract]
        [WebInvoke(Method = "POST",
BodyStyle = WebMessageBodyStyle.WrappedRequest,
RequestFormat = WebMessageFormat.Json,
ResponseFormat = WebMessageFormat.Json)]
        public string Bindinterview(int personid, int pageSize, int page, string sortby, string sortexp, List<searchfltr> sdata)
        {
            Jsonhelper obj = new Jsonhelper();
            try
            {

                var resset = Person_Details.Licensing_Details.GetPersonInterview(personid);

                foreach (searchfltr s in sdata)
                {
                    var slf = typeof(Person_Details.tbl_Interview_Report).GetProperty(s.dbfield);
                    resset = resset.Where(c => slf.GetValue(c, null).ToString().ToUpper().Contains(s.searchtxt.ToUpper())).ToList();

                }
                if (sortby != "")
                {
                    var pi = typeof(Person_Details.tbl_Interview_Report).GetProperty(sortby);
                    if (sortexp == "asc")
                        resset = resset.OrderBy(c => pi.GetValue(c, null)).ToList();
                    else
                        resset = resset.OrderByDescending(c => pi.GetValue(c, null)).ToList();
                }
                var total = resset.Count();
                var skip = pageSize * (page - 1);
                var canPage = skip < total;
                obj.Response = resset.Skip(skip).Take(pageSize).ToList().ToJson();
                obj.reccount = total;
            }
            catch (Exception ex)
            {
                obj.Error = ex.ToJson();
            }
            return obj.ToJson();

        }
        [OperationContract]
        [WebInvoke(Method = "POST",
BodyStyle = WebMessageBodyStyle.WrappedRequest,
RequestFormat = WebMessageFormat.Json,
ResponseFormat = WebMessageFormat.Json)]
        public string BindInterviewReport(string fromdate, string todate, int pageSize, int page, string sortby, string sortexp, List<searchfltr> sdata)
        {
            Jsonhelper obj = new Jsonhelper();
            try
            {
                if (todate == "")
                    todate = fromdate;
                var resset = Person_Details.Licensing_Details.GetInterviewReport(fromdate, todate).ToList();

                foreach (searchfltr s in sdata)
                {
                    var slf = typeof(Person_Details.USP_GetInterviewReportResult).GetProperty(s.dbfield);
                    resset = resset.Where(c => slf.GetValue(c, null).ToString().ToUpper().Contains(s.searchtxt.ToUpper())).ToList();

                }
                if (sortby != "")
                {
                    var pi = typeof(Person_Details.USP_GetInterviewReportResult).GetProperty(sortby);
                    if (sortexp == "asc")
                        resset = resset.OrderBy(c => pi.GetValue(c, null)).ToList();
                    else
                        resset = resset.OrderByDescending(c => pi.GetValue(c, null)).ToList();
                }
                var total = resset.Count();
                var skip = pageSize * (page - 1);
                var canPage = skip < total;
                obj.Response = resset.Skip(skip).Take(pageSize).ToList().ToJson();
                obj.reccount = total;
            }
            catch (Exception ex)
            {
                obj.Error = ex.ToJson();
            }
            return obj.ToJson();

        }
        [OperationContract]
        [WebInvoke(Method = "POST",
BodyStyle = WebMessageBodyStyle.WrappedRequest,
RequestFormat = WebMessageFormat.Json,
ResponseFormat = WebMessageFormat.Json)]
        public string GetOnlineComplaints(string sdt, string edt, int pageSize, int page, string sortby, string sortexp, List<searchfltr> sdata)
        {
            Jsonhelper obj = new Jsonhelper();
            try
            {
                if (edt == "")
                    edt = sdt;
                var resset = Person_Details.Licensing_Details.GetOnlineComplaints(sdt, edt);

                foreach (searchfltr s in sdata)
                {
                    var slf = typeof(Person_Details.USP_GetOnlineComplaintsDetailsResult).GetProperty(s.dbfield);
                    resset = resset.Where(c => slf.GetValue(c, null).ToString().ToUpper().Contains(s.searchtxt.ToUpper())).ToList();

                }
                if (sortby != "")
                {
                    if (sortby != "License_No")
                    {
                        var pi = typeof(Person_Details.USP_GetOnlineComplaintsDetailsResult).GetProperty(sortby);
                        if (sortexp == "asc")
                            resset = resset.OrderBy(c => pi.GetValue(c, null)).ToList();
                        else
                            resset = resset.OrderByDescending(c => pi.GetValue(c, null)).ToList();
                    }
                    else
                    {
                        var pi = typeof(Online.USP_getRenewaldataResult).GetProperty(sortby);
                        if (sortexp == "asc")
                            resset = resset.OrderBy(c => Convert.ToInt32(pi.GetValue(c, null).ToString().Replace("T", "").Replace("D", "").Replace("S", ""))).ToList();
                        else
                            resset = resset.OrderByDescending(c => Convert.ToInt32(pi.GetValue(c, null).ToString().Replace("T", "").Replace("D", "").Replace("S", ""))).ToList();
                    }
                }
                var total = resset.Count();
                var skip = pageSize * (page - 1);
                var canPage = skip < total;
                obj.Response = resset.Skip(skip).Take(pageSize).ToList().ToJson();
                obj.reccount = total;
            }
            catch (Exception ex)
            {
                obj.Error = ex.ToJson();
            }
            return obj.ToJson();

        }
        [OperationContract]
        [WebInvoke(Method = "POST",
BodyStyle = WebMessageBodyStyle.WrappedRequest,
RequestFormat = WebMessageFormat.Json,
ResponseFormat = WebMessageFormat.Json)]
        public string BindPersonHearingDoc(string cmpid, string pid, string appid, int pageSize, int page, string sortby, string sortexp, List<searchfltr> sdata)
        {
            Jsonhelper obj = new Jsonhelper();
            try
            {

                var resset = ComplaintsLink.Complaints.GetComplaintsHearingDocument(Convert.ToInt32(cmpid), Convert.ToInt32(pid));


                foreach (searchfltr s in sdata)
                {
                    var slf = typeof(ComplaintsLink.USP_GetComplaintsHearingDocumentResult).GetProperty(s.dbfield);
                    resset = resset.Where(c => slf.GetValue(c, null).ToString().ToUpper().Contains(s.searchtxt.ToUpper())).ToList();

                }
                if (sortby != "")
                {
                    var pi = typeof(ComplaintsLink.USP_GetComplaintsHearingDocumentResult).GetProperty(sortby);
                    if (sortexp == "asc")
                        resset = resset.OrderBy(c => pi.GetValue(c, null)).ToList();
                    else
                        resset = resset.OrderByDescending(c => pi.GetValue(c, null)).ToList();
                }
                var total = resset.Count();
                var skip = pageSize * (page - 1);
                var canPage = skip < total;
                obj.Response = resset.Skip(skip).Take(pageSize).ToList().ToJson();
                obj.reccount = total;
            }
            catch (Exception ex)
            {
                obj.Error = ex.ToJson();
            }
            return obj.ToJson();

        }
        #endregion
        #region CS Inventory
        [OperationContract]
        [WebInvoke(Method = "POST",
BodyStyle = WebMessageBodyStyle.WrappedRequest,
RequestFormat = WebMessageFormat.Json,
ResponseFormat = WebMessageFormat.Json)]
        public string Bindcsinventory(int pid, int pageSize, int page, string sortby, string sortexp, List<searchfltr> sdata)
        {
            Jsonhelper obj = new Jsonhelper();
            try
            {

                var resset = Person_Details.Licensing_Details.Get_csinventory(pid);


                foreach (searchfltr s in sdata)
                {
                    var slf = typeof(Person_Details.usp_csinventoryResult).GetProperty(s.dbfield);
                    resset = resset.Where(c => slf.GetValue(c, null).ToString().ToUpper().Contains(s.searchtxt.ToUpper())).ToList();

                }
                if (sortby != "")
                {
                    var pi = typeof(Person_Details.usp_csinventoryResult).GetProperty(sortby);
                    if (sortexp == "asc")
                        resset = resset.OrderBy(c => pi.GetValue(c, null)).ToList();
                    else
                        resset = resset.OrderByDescending(c => pi.GetValue(c, null)).ToList();
                }
                var total = resset.Count();
                var skip = pageSize * (page - 1);
                var canPage = skip < total;
                obj.Response = resset.Skip(skip).Take(pageSize).ToList().ToJson();
                obj.reccount = total;
            }
            catch (Exception ex)
            {
                obj.Error = ex.ToJson();
            }
            return obj.ToJson();
        }

        #endregion
    }
}
