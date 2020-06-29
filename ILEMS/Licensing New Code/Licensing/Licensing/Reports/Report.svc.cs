using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Activation;
using System.ServiceModel.Web;
using System.Web.Script.Serialization;
using Microsoft.ApplicationBlocks.Data;
using System.Data;
using Newtonsoft.Json;
using System.Text;
namespace Licensing.Reports
{
    #region autogrid
    
    public static class JsonHelper
    {
        public static string ToJson(this object obj)
        {
            try
            {
                var serializer = new JavaScriptSerializer();
                return serializer.Serialize(obj);
            }
            catch(Exception ex)
            {
                return ex.ToString();
            }
        }

        public static string ToJson(this object obj, int recursionDepth)
        {
            try
            { 
            var serializer = new JavaScriptSerializer();
            serializer.RecursionLimit = recursionDepth;
            return serializer.Serialize(obj);
            }
            catch (Exception ex)
            {
                return ex.ToString();
            }
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
    public class Report
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
        public void DoWork()
        {
            // Add your operation implementation here
            return;
        }
        [OperationContract]
        [WebInvoke(Method = "POST",
BodyStyle = WebMessageBodyStyle.WrappedRequest,
RequestFormat = WebMessageFormat.Json,
ResponseFormat = WebMessageFormat.Json)]
        public string Runquery(string query)
        {
            Jsonhelper obj = new Jsonhelper();
            try
            {
                DataTable dt = SqlHelper.ExecuteDataset(System.Configuration.ConfigurationManager.AppSettings["Licensing_Con"].ToString(), CommandType.Text, query).Tables[0];
                DataView dv = dt.DefaultView;
               
                
                List<Dictionary<string, object>> rows = new List<Dictionary<string, object>>();
                Dictionary<string, object> row;
                for (int i = 0; i < dv.Count  ; i++)
                {
                    row = new Dictionary<string, object>();
                    foreach (DataColumn col in dt.Columns)
                    {
                        row.Add(col.ColumnName, dv[i][col.ColumnName]);
                    }
                    rows.Add(row);
                }

                obj.Response = rows.ToJson();
                obj.reccount = 0;
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
        public string GetOnlineACH(string sdt, string edt, int pageSize, int page, string sortby, string sortexp, List<searchfltr> sdata)
        {
            Jsonhelper obj = new Jsonhelper();
            string reccount = "0";
            try
            {
                if (edt == "")
                    edt = Convert.ToDateTime(sdt).AddDays(0).ToString("MM/dd/yyyy");
                else
                    edt = Convert.ToDateTime(edt).AddDays(0).ToString("MM/dd/yyyy");
                var res = Finance.Bpayment.Getallcharges(sdt, edt, "", page.ToString(), pageSize.ToString(), out reccount);
                var resset = JsonConvert.DeserializeObject<List<Finance.ACHresults>>(res);

                resset = resset.ToList();
                resset = resset.Where(c => c.total_amount != "0").ToList();
                //foreach (searchfltr s in sdata)
                //{
                //    var slf = typeof(Finance.ACHresults).GetProperty(s.dbfield);
                //    resset = resset.Where(c => slf.GetValue(c, null).ToString().ToUpper().Contains(s.searchtxt.ToUpper())).ToList();

                //}
                if (sortby != "")
                {
                    var pi = typeof(Finance.ACHresults).GetProperty(sortby);
                    if (sortexp == "asc")
                        resset = resset.OrderBy(c => pi.GetValue(c, null)).ToList();
                    else
                        resset = resset.OrderByDescending(c => pi.GetValue(c, null)).ToList();
                }
                var total = Convert.ToInt32(reccount);

                string trannos = "";
                foreach (Finance.ACHresults o in resset)
                    trannos = trannos + o.charge_id + ",";
                if (trannos != "")
                {
                    trannos = trannos.Substring(0, trannos.Length - 1);
                    System.Data.DataTable dt = Finance.Bpayment.Getpnamebysnos(trannos);
                    resset.ForEach(c => c.username = Finance.Bpayment.getpname(dt, c.charge_id));
                }
                resset.ForEach(c => c.total_amount = "$" + Convert.ToDecimal(c.total_amount).ToString("0.00"));
                obj.Response = resset.ToJson();
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
        public string GetInspectioninside(string sdt, string edt,string type, int pageSize, int page, string sortby, string sortexp, List<searchfltr> sdata)
        {
            Jsonhelper obj = new Jsonhelper();
            try
            {

                var resset = Reports.Reportgenrator.GetinspectionInside(sdt, edt,type);


                foreach (searchfltr s in sdata)
                {
                    var slf = typeof(Reports.USP_GetinspectioninsideResult).GetProperty(s.dbfield);
                    resset = resset.Where(c => slf.GetValue(c, null).ToString().ToUpper().Contains(s.searchtxt.ToUpper())).ToList();

                }
                if (sortby != "")
                {
                    var pi = typeof(Reports.USP_GetinspectioninsideResult).GetProperty(sortby);
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
        public string Getdellst(string refid, int type, int pageSize, int page, string sortby, string sortexp, List<searchfltr> sdata)
        {
            Jsonhelper obj = new Jsonhelper();
            try
            {

                var resset = Reports.Reportgenrator.Getdellst(refid,type);


                foreach (searchfltr s in sdata)
                {
                    var slf = typeof(Reports.USP_getdellistResult).GetProperty(s.dbfield);
                    resset = resset.Where(c => slf.GetValue(c, null).ToString().ToUpper().Contains(s.searchtxt.ToUpper())).ToList();

                }
                if (sortby != "")
                {
                    var pi = typeof(Reports.USP_getdellistResult).GetProperty(sortby);
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
        public string GetApplications(string sdt,string edt,int pageSize, int page, string sortby, string sortexp, List<searchfltr> sdata)
        {
            Jsonhelper obj = new Jsonhelper();
            try
            {

                var resset=  Reports.Reportgenrator.Getapplications(Convert.ToDateTime(sdt), Convert.ToDateTime(edt));


                foreach (searchfltr s in sdata)
                {
                    var slf = typeof(Reports.USP_applicationtypecountResult).GetProperty(s.dbfield);
                    resset = resset.Where(c => slf.GetValue(c, null).ToString().ToUpper().Contains(s.searchtxt.ToUpper())).ToList();

                }
                if (sortby != "")
                {
                    var pi = typeof(Reports.USP_applicationtypecountResult).GetProperty(sortby);
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
         public string GetBatchPrints(string pid, string sdt,string edt,string licno,string cert, int pageSize, int page, string sortby, string sortexp, List<searchfltr> sdata)
         {
             Jsonhelper obj = new Jsonhelper();
             try
             {
                 if (edt == "")
                     edt = sdt;

                 var resset = Reports.Reportgenrator.GetBatchPrints(pid,sdt,edt,licno,cert);


                 foreach (searchfltr s in sdata)
                 {
                     var slf = typeof(Reports.USP_GetbatchcertResult).GetProperty(s.dbfield);
                     resset = resset.Where(c => slf.GetValue(c, null).ToString().ToUpper().Contains(s.searchtxt.ToUpper())).ToList();

                 }
                 if (sortby != "")
                 {
                     var pi = typeof(Reports.USP_GetbatchcertResult).GetProperty(sortby);
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
         public string GetLicenseCount(string sdt, string edt, int pageSize, int page, string sortby, string sortexp, List<searchfltr> sdata)
         {
             Jsonhelper obj = new Jsonhelper();
             try
             {

                 var resset = Reports.Reportgenrator.Getlicenseissue(Convert.ToDateTime(sdt), Convert.ToDateTime(edt));


                 foreach (searchfltr s in sdata)
                 {
                     var slf = typeof(Reports.USP_LicenseIssueCountResult).GetProperty(s.dbfield);
                     resset = resset.Where(c => slf.GetValue(c, null).ToString().ToUpper().Contains(s.searchtxt.ToUpper())).ToList();

                 }
                 if (sortby != "")
                 {
                     var pi = typeof(Reports.USP_LicenseIssueCountResult).GetProperty(sortby);
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
         public string GetComplaintbycategory(string sdt, string edt, int pageSize, int page, string sortby, string sortexp, List<searchfltr> sdata)
         {
             Jsonhelper obj = new Jsonhelper();
             try
             {

                 var resset = Reports.Reportgenrator.getcomplaintsbycategory(Convert.ToDateTime(sdt), Convert.ToDateTime(edt));


                 foreach (searchfltr s in sdata)
                 {
                     var slf = typeof(Reports.USP_ComplaintByCategoryResult).GetProperty(s.dbfield);
                     resset = resset.Where(c => slf.GetValue(c, null).ToString().ToUpper().Contains(s.searchtxt.ToUpper())).ToList();

                 }
                 if (sortby != "")
                 {
                     var pi = typeof(Reports.USP_ComplaintByCategoryResult).GetProperty(sortby);
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
         public string Getfeetypecount(string sdt, string edt, int pageSize, int page, string sortby, string sortexp, List<searchfltr> sdata)
         {
             Jsonhelper obj = new Jsonhelper();
             try
             {

                 var resset = Reports.Reportgenrator.Getfeetype(Convert.ToDateTime(sdt), Convert.ToDateTime(edt));


                 foreach (searchfltr s in sdata)
                 {
                     var slf = typeof(Reports.USP_FeeTypeCollectResult).GetProperty(s.dbfield);
                     resset = resset.Where(c => slf.GetValue(c, null).ToString().ToUpper().Contains(s.searchtxt.ToUpper())).ToList();

                 }
                 if (sortby != "")
                 {
                     var pi = typeof(Reports.USP_FeeTypeCollectResult).GetProperty(sortby);
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
         public string GetBoardAction(string sdt, string edt, int pageSize, int page, string sortby, string sortexp, List<searchfltr> sdata)
         {
             Jsonhelper obj = new Jsonhelper();
             try
             {

                 var resset = Reports.Reportgenrator.getboardaction(Convert.ToDateTime(sdt), Convert.ToDateTime(edt));


                 foreach (searchfltr s in sdata)
                 {
                     var slf = typeof(Reports.USP_getboardactionResult).GetProperty(s.dbfield);
                     resset = resset.Where(c => slf.GetValue(c, null).ToString().ToUpper().Contains(s.searchtxt.ToUpper())).ToList();

                 }
                 if (sortby != "")
                 {
                     var pi = typeof(Reports.USP_getboardactionResult).GetProperty(sortby);
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
         public string GetResolveDays(string sdt, string edt, int pageSize, int page, string sortby, string sortexp, List<searchfltr> sdata)
         {
             Jsonhelper obj = new Jsonhelper();
             try
             {

                 var resset = Reports.Reportgenrator.Getresolvedays(Convert.ToDateTime(sdt), Convert.ToDateTime(edt));
                 
                 foreach (searchfltr s in sdata)
                 {
                     var slf = typeof(Reports.USP_getresoleddaysResult).GetProperty(s.dbfield);
                     resset = resset.Where(c => slf.GetValue(c, null).ToString().ToUpper().Contains(s.searchtxt.ToUpper())).ToList();

                 }
                 if (sortby != "")
                 {
                     var pi = typeof(Reports.USP_getresoleddaysResult).GetProperty(sortby);
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
         public string GetResolution(string sdt, string edt, int pageSize, int page, string sortby, string sortexp, List<searchfltr> sdata)
         {
             Jsonhelper obj = new Jsonhelper();
             try
             {

                 var resset = Reports.Reportgenrator.GetResolution(Convert.ToDateTime(sdt), Convert.ToDateTime(edt));
                 

                 foreach (searchfltr s in sdata)
                 {
                     var slf = typeof(Reports.USP_getrsolutionResult).GetProperty(s.dbfield);
                     resset = resset.Where(c => slf.GetValue(c, null).ToString().ToUpper().Contains(s.searchtxt.ToUpper())).ToList();

                 }
                 if (sortby != "")
                 {
                     var pi = typeof(Reports.USP_getrsolutionResult).GetProperty(sortby);
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
        public string GetROC(int type, string sdt, string edt, int pageSize, int page, string sortby, string sortexp, List<searchfltr> sdata)
        {
            Jsonhelper obj = new Jsonhelper();
            try
            {

                if (edt == "")
                    edt = sdt.ToString();
                var resset = Reports.Reportgenrator.GetROC(type, Convert.ToDateTime(sdt), Convert.ToDateTime(edt));


                foreach (searchfltr s in sdata)
                {
                    var slf = typeof(Reports.USP_GetrocResult).GetProperty(s.dbfield);
                    resset = resset.Where(c => slf.GetValue(c, null).ToString().ToUpper().Contains(s.searchtxt.ToUpper())).ToList();

                }
                if (sortby != "")
                {
                    var pi = typeof(Reports.USP_GetrocResult).GetProperty(sortby);
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
        public string GetROCDetails(int type, string sdt, string edt, int id, string paytype, string dr, string dp, int pageSize, int page, string sortby, string sortexp, List<searchfltr> sdata)
        {
            Jsonhelper obj = new Jsonhelper();
            try
            {
                if (edt == "")
                    edt = sdt.ToString();
                var resset = Reports.Reportgenrator.GetROCDetails(type, Convert.ToDateTime(sdt), id, Convert.ToDateTime(edt));
                if (type == 2)
                {
                    resset = resset.Where(c => c.Methodofpayment == paytype && c.DateReceived == dr && c.DatePosted == dp).ToList();
                }
                if (id != 1)
                    resset = resset.Where(c => c.Sub_org_Id == id).ToList();

                foreach (searchfltr s in sdata)
                {
                    var slf = typeof(Reports.USP_Getroc_detailsResult).GetProperty(s.dbfield);
                    resset = resset.Where(c => slf.GetValue(c, null).ToString().ToUpper().Contains(s.searchtxt.ToUpper())).ToList();

                }
                if (sortby != "")
                {
                    var pi = typeof(Reports.USP_Getroc_detailsResult).GetProperty(sortby);
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
        public string GetComplaintDateReceived1(string sdt, string edt, string lictype, string usp797, string usp795, int pageSize, int page, string sortby, string sortexp, List<searchfltr> sdata)
        {
            Jsonhelper obj = new Jsonhelper();
            try
            {
                if (edt == "")
                    edt = sdt.ToString();
                var resset = Reports.Reportgenrator.GetComplaintsDateReceived1(Convert.ToDateTime(sdt), Convert.ToDateTime(edt), lictype, usp795, usp797);


                foreach (searchfltr s in sdata)
                {
                    var slf = typeof(Reports.USP_GetLicensingComplaintsResult).GetProperty(s.dbfield);
                    resset = resset.Where(c => slf.GetValue(c, null).ToString().ToUpper().Contains(s.searchtxt.ToUpper())).ToList();

                }
                if (sortby != "")
                {
                    var pi = typeof(Reports.USP_GetLicensingComplaintsResult).GetProperty(sortby);
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
        public string GetComplaintDateReceived(string sdt, string edt,string lictype,string usp797,string usp795, int pageSize, int page, string sortby, string sortexp, List<searchfltr> sdata)
        {
            Jsonhelper obj = new Jsonhelper();
            try
            {
                if (edt == "")
                    edt = sdt.ToString();
                var resset = Reports.Reportgenrator.GetComplaintsDateReceived(Convert.ToDateTime(sdt),Convert.ToDateTime(edt),lictype,usp795,usp797);
               

                foreach (searchfltr s in sdata)
                {
                    var slf = typeof(Reports.USP_GetComplaintDateReceivedResult).GetProperty(s.dbfield);
                    resset = resset.Where(c => slf.GetValue(c, null).ToString().ToUpper().Contains(s.searchtxt.ToUpper())).ToList();

                }
                if (sortby != "")
                {
                    var pi = typeof(Reports.USP_GetComplaintDateReceivedResult).GetProperty(sortby);
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
        public string GetComplaintsbycategory( int pageSize, int page, string sortby, string sortexp, List<searchfltr> sdata)
        {
            Jsonhelper obj = new Jsonhelper();
            try
            {

                var resset = Reports.Reportgenrator.Getcmpbycategory();


                foreach (searchfltr s in sdata)
                {
                    var slf = typeof(Reports.VW_dash_cmpbycategory).GetProperty(s.dbfield);
                    resset = resset.Where(c => slf.GetValue(c, null).ToString().ToUpper().Contains(s.searchtxt.ToUpper())).ToList();

                }
                if (sortby != "")
                {
                    var pi = typeof(Reports.VW_dash_cmpbycategory).GetProperty(sortby);
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
        public string Getprintsbytype(int ptype,int pageSize, int page, string sortby, string sortexp, List<searchfltr> sdata)
        {
            Jsonhelper obj = new Jsonhelper();
            try
            {

                var resset = Reports.Reportgenrator.getprintsbytype(ptype);


                foreach (searchfltr s in sdata)
                {
                    var slf = typeof(Reports.tbl_print).GetProperty(s.dbfield);
                    resset = resset.Where(c => slf.GetValue(c, null).ToString().ToUpper().Contains(s.searchtxt.ToUpper())).ToList();

                }
                if (sortby != "")
                {
                    var pi = typeof(Reports.tbl_print).GetProperty(sortby);
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
        public string Getallrpts( int pageSize, int page, string sortby, string sortexp, List<searchfltr> sdata)
        {
            Jsonhelper obj = new Jsonhelper();
            try
            {

                var resset = Reports.Reportgenrator.getallreports();


                foreach (searchfltr s in sdata)
                {
                    var slf = typeof(Reports.tbl_rpt_detail).GetProperty(s.dbfield);
                    resset = resset.Where(c => slf.GetValue(c, null).ToString().ToUpper().Contains(s.searchtxt.ToUpper())).ToList();

                }
                if (sortby != "")
                {
                    var pi = typeof(Reports.tbl_rpt_detail).GetProperty(sortby);
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
        public string BindMyFiles(string perres,int pageSize, int page, string sortby, string sortexp, List<searchfltr> sdata)
        {
            Jsonhelper obj = new Jsonhelper();
            try
            {

                var resset = Reports.Reportgenrator.GetMyFiles();
                if (perres != "-1")
                    resset = resset.Where(c => c.PersonResponcible_ID == perres).ToList();

                foreach (searchfltr s in sdata)
                {
                    var slf = typeof(Reports.VW_dash_myfile).GetProperty(s.dbfield);
                    resset = resset.Where(c => slf.GetValue(c, null).ToString().ToUpper().Contains(s.searchtxt.ToUpper())).ToList();

                }
                if (sortby != "")
                {
                    var pi = typeof(Reports.VW_dash_myfile).GetProperty(sortby);
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
        public string BindOutStandingFee(int pageSize, int page, string sortby, string sortexp, List<searchfltr> sdata)
        {
            Jsonhelper obj = new Jsonhelper();
            try
            {

                var resset = Reports.Reportgenrator.GetOutStandingFee();


                foreach (searchfltr s in sdata)
                {
                    var slf = typeof(Reports.VW_dash_outstandingfee).GetProperty(s.dbfield);
                    resset = resset.Where(c => slf.GetValue(c, null).ToString().ToUpper().Contains(s.searchtxt.ToUpper())).ToList();

                }
                if (sortby != "")
                {
                    var pi = typeof(Reports.VW_dash_outstandingfee).GetProperty(sortby);
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
        public string BindOutStandingFeeFine(int pageSize, int page, string sortby, string sortexp, List<searchfltr> sdata)
        {
            Jsonhelper obj = new Jsonhelper();
            try
            {

                var resset = Reports.Reportgenrator.GetOutStandingFeeFines();


                foreach (searchfltr s in sdata)
                {
                    var slf = typeof(Reports.VW_dash_outstandingfeefine).GetProperty(s.dbfield);
                    resset = resset.Where(c => slf.GetValue(c, null).ToString().ToUpper().Contains(s.searchtxt.ToUpper())).ToList();

                }
                if (sortby != "")
                {
                    var pi = typeof(Reports.VW_dash_outstandingfeefine).GetProperty(sortby);
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
        public string Bindlicissuecount(int pageSize, int page, string sortby, string sortexp, List<searchfltr> sdata)
        {
            Jsonhelper obj = new Jsonhelper();
            try
            {

                var resset = Reports.Reportgenrator.Getlicissuecount();


                foreach (searchfltr s in sdata)
                {
                    var slf = typeof(Reports.VW_dash_licenseissuecount).GetProperty(s.dbfield);
                    resset = resset.Where(c => slf.GetValue(c, null).ToString().ToUpper().Contains(s.searchtxt.ToUpper())).ToList();

                }
                if (sortby != "")
                {
                    var pi = typeof(Reports.VW_dash_licenseissuecount).GetProperty(sortby);
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
        public string BindFeeTypeCollect(int pageSize, int page, string sortby, string sortexp, List<searchfltr> sdata)
        {
            Jsonhelper obj = new Jsonhelper();
            try
            {

                var resset = Reports.Reportgenrator.Getfeetypecollect();


                foreach (searchfltr s in sdata)
                {
                    var slf = typeof(Reports.VW_dash_feetypecollect).GetProperty(s.dbfield);
                    resset = resset.Where(c => slf.GetValue(c, null).ToString().ToUpper().Contains(s.searchtxt.ToUpper())).ToList();

                }
                if (sortby != "")
                {
                    var pi = typeof(Reports.VW_dash_feetypecollect).GetProperty(sortby);
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
     public string Runreportquery(string query, int pageSize, int page, string sortby, string sortexp, List<searchfltr> sdata)
    {
        Jsonhelper obj = new Jsonhelper();
        try
        {
            DataTable dt= SqlHelper.ExecuteDataset(System.Configuration.ConfigurationManager.AppSettings["Licensing_Con"].ToString(), CommandType.Text, query.Replace("&gt;",">").Replace("&lt;","<")).Tables[0];
            DataView dv = dt.DefaultView;
            foreach (searchfltr s in sdata)
            {
                dv.RowFilter = s.dbfield + " like '" + s.searchtxt + "%'";
            }
            if(sortby!="")
            dv.Sort = sortby + " " + sortexp;
            var total = dv.Count;
            var skip = pageSize * (page - 1);
            var canPage = skip < total;
            List<Dictionary<string, object>> rows = new List<Dictionary<string, object>>();
                Dictionary<string, object> row;
                for (int i = skip; i < skip+pageSize && dv.Count > i; i++)
            {
                row = new Dictionary<string, object>();
                foreach (DataColumn col in dt.Columns)
                {
                    row.Add(col.ColumnName, dv[i][col.ColumnName]);
                }
                rows.Add(row);
            }
            
            obj.Response = rows.ToJson();
            obj.reccount = total;
        }
        catch (Exception ex)
        {
            obj.Error = ex.ToJson();
        }
        return obj.ToJson();
    }
        // Add more operations here and mark them with [OperationContract]
    }
}
