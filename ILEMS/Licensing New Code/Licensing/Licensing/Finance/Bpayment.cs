using Microsoft.ApplicationBlocks.Data;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Security.Cryptography;
using System.Text;
using System.Web;

namespace Licensing.Finance
{
    public class ACHresults
    {
        public string charge_id { get; set; }
        public string comment { get; set; }
        public DateTime charge_timestamp { get; set; }
        public string total_amount { get; set; }
        public string method { get; set; }
        public string account_number { get; set; }
        public string card_number { get; set; }
        public string result_code { get; set; }
        public string result_text { get; set; }
        public string username { get; set; }

    }
    public static class Bpayment
    {
        #region Private Members
        private static string HOSTNAME = System.Configuration.ConfigurationManager.AppSettings["PaymentHost"].ToString();
        private static string username = System.Configuration.ConfigurationManager.AppSettings["PaymentUser"].ToString();
        private static string Password = System.Configuration.ConfigurationManager.AppSettings["PaymentKEY"].ToString();
        private static string accountid = System.Configuration.ConfigurationManager.AppSettings["PaymentAccount"].ToString();
        private static string merchant_id = System.Configuration.ConfigurationManager.AppSettings["PaymentMerchent"].ToString();

        public static string getpname(this DataTable dt, string transnos)
        {
            try
            {
                if (dt.Select("ACHrefno='" + transnos + "'").Length > 0)
                    return dt.Select("ACHrefno='" + transnos + "'")[0]["name"].ToString();
                else
                    return "";
            }
            catch
            {
                return "";
            }
        }
        public static DataTable Getpnamebysnos(string transnos)
        {
            try
            {

                return SqlHelper.ExecuteDataset(System.Configuration.ConfigurationManager.AppSettings["Licensing_Con"].ToString(), "USP_getnamebytran", new object[] { transnos }).Tables[0];

            }
            catch
            {
                return null;
            }
        }
        private static class EndPoints
        {
            public static string Gettoken = "services/oauth2/token";
            public static string Charge = "charges";
            public static string Chargedetails = "charges/{0}";
            public static string Chargetoken = "tokens";
            public static string Void = "charges/{0}/void";
            public static string Refund = "refunds";
        }
        #endregion

        #region Private Methods
        private static string Base64Encode(string plainText)
        {
            var plainTextBytes = System.Text.Encoding.UTF8.GetBytes(plainText);
            return System.Convert.ToBase64String(plainTextBytes);
        }
        private static string Getaccesstoken()
        {
            try
            {
                HttpClient httpClient = new HttpClient
                {
                    BaseAddress = new Uri(HOSTNAME)
                };
                ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls12;
                httpClient.DefaultRequestHeaders.Add("Authorization", "Basic " + Base64Encode(username + ":" + Password));
                var content = new FormUrlEncodedContent(new[]
                {
              new KeyValuePair<string, string>("grant_type", "client_credentials")
            });
                var response = httpClient.PostAsync(EndPoints.Gettoken, content).GetAwaiter().GetResult();

                if (response.IsSuccessStatusCode)
                {
                    var str = response.Content.ReadAsStringAsync().GetAwaiter().GetResult();
                    JObject bobj = JObject.Parse(str);
                    return bobj["access_token"].ToString();
                }
            }
            catch (Exception ex)
            {

            }
            return "";
        }
        public static string Getallcharges(string sdt,string edt, string charge_type,string page_num,string pagesize,out string reccount)
        {
            charge_type = "bank_account";
            var token = Getaccesstoken();
            HttpClient httpClient = new HttpClient
            {
                BaseAddress = new Uri(HOSTNAME)
            };
            reccount = "0";
            httpClient.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            httpClient.DefaultRequestHeaders.Add("Authorization", "Bearer " + token);
        
            var response = httpClient.GetAsync(string.Format(HOSTNAME+ "/charges?merchant_id={1}&start_date={2}&end_date={3}&record_count=true&page_number=" + page_num+"&page_size="+pagesize, username, merchant_id, Convert.ToDateTime( sdt).ToString("yyyy-MM-dd"), Convert.ToDateTime(edt).ToString("yyyy-MM-dd"), charge_type)).GetAwaiter().GetResult();
            if (response.IsSuccessStatusCode)
            {
                var str = response.Content.ReadAsStringAsync().GetAwaiter().GetResult();
                JObject bobj = JObject.Parse(str);
                reccount = bobj.First.First["item_count"].ToString();
                return bobj["items"].ToString();
            }
            else
                return   response.Content.ReadAsStringAsync().GetAwaiter().GetResult();
        }
      
         
     
        private static void Charge(JObject Postvals, out string Status, out string Refno)
        {
            Status = ""; Refno = "";
            var token = Getaccesstoken();
            HttpClient httpClient = new HttpClient
            {
                BaseAddress = new Uri(HOSTNAME)
            };
            httpClient.DefaultRequestHeaders.Add("Authorization", "Bearer " + token);
            var content = new StringContent(Postvals.ToString(), Encoding.UTF8, "application/json");
            var response = httpClient.PostAsync(EndPoints.Charge, content).GetAwaiter().GetResult();
            if (response.IsSuccessStatusCode)
            {
                var str = response.Content.ReadAsStringAsync().GetAwaiter().GetResult();
                JObject bobj = JObject.Parse(str);
                Status = "Approved";
                Refno = bobj["charge_id"].ToString();
            }
            else
                Status = response.Content.ReadAsStringAsync().GetAwaiter().GetResult();
        }
        private static string Chargetoken(JObject Postvals)
        {
            Postvals["token_expiration_date"] = DateTime.Now.AddYears(1).ToString("yyyy-MM-dd");
            var token = Getaccesstoken();
            HttpClient httpClient = new HttpClient
            {
                BaseAddress = new Uri(HOSTNAME)
            };
            httpClient.DefaultRequestHeaders.Add("Authorization", "Bearer " + token);
            var content = new StringContent(Postvals.ToString(), Encoding.UTF8, "application/json");
            var response = httpClient.PostAsync(EndPoints.Chargetoken, content).GetAwaiter().GetResult();
            if (response.IsSuccessStatusCode)
            {
                var str = response.Content.ReadAsStringAsync().GetAwaiter().GetResult();
                return str;
            }
            else
                return response.Content.ReadAsStringAsync().GetAwaiter().GetResult();
        }
        public static string GetTokendetails(string chargetokenid)
        {
            var token = Getaccesstoken();
            HttpClient httpClient = new HttpClient
            {
                BaseAddress = new Uri(HOSTNAME)
            };
            httpClient.DefaultRequestHeaders.Add("Authorization", "Bearer " + token);

            var response = httpClient.GetAsync(string.Format(EndPoints.Chargetoken + "/{0}", chargetokenid)).GetAwaiter().GetResult();
            if (response.IsSuccessStatusCode)
            {
                var str = response.Content.ReadAsStringAsync().GetAwaiter().GetResult();
                return str;
            }
            else
                return response.Content.ReadAsStringAsync().GetAwaiter().GetResult();
        }
        public static string Chargedetails(string chargeid)
        {
            var token = Getaccesstoken();
            HttpClient httpClient = new HttpClient
            {
                BaseAddress = new Uri(HOSTNAME)
            };

            httpClient.DefaultRequestHeaders.Add("Authorization", "Bearer " + token);
            var content = new StringContent("", Encoding.UTF8, "application/json");
            var response = httpClient.GetAsync(string.Format(EndPoints.Chargedetails, chargeid)).GetAwaiter().GetResult();
            if (response.IsSuccessStatusCode)
            {
                var str = response.Content.ReadAsStringAsync().GetAwaiter().GetResult();
                return str;
            }
            else
                return response.Content.ReadAsStringAsync().GetAwaiter().GetResult();
        }

        private static string Void(string Chargeid)
        {
            var token = Getaccesstoken();
            HttpClient httpClient = new HttpClient
            {
                BaseAddress = new Uri(HOSTNAME)
            };
            httpClient.DefaultRequestHeaders.Add("Authorization", "Bearer " + token);

            var response = httpClient.PostAsync(string.Format(EndPoints.Void, Chargeid), null).GetAwaiter().GetResult();
            if (response.IsSuccessStatusCode)
            {
                var str = response.Content.ReadAsStringAsync().GetAwaiter().GetResult();
                return str;
            }
            else
                return "API Error";
        }
        private static string Refund(JObject Postvals)
        {
            var token = Getaccesstoken();
            HttpClient httpClient = new HttpClient
            {
                BaseAddress = new Uri(HOSTNAME)
            };
            httpClient.DefaultRequestHeaders.Add("Authorization", "Bearer " + token);
            var content = new StringContent(Postvals.ToString(), Encoding.UTF8, "application/json");
            var response = httpClient.PostAsync(EndPoints.Refund, content).GetAwaiter().GetResult();
            if (response.IsSuccessStatusCode)
            {
                var str = response.Content.ReadAsStringAsync().GetAwaiter().GetResult();
                return str;
            }
            else
                return "API Error";
        }
        #endregion

        #region Public Methods
        
         public static string Createtoken(string nameoncard, string cardno, string expdt, string cvv, string zip)
        {
            #region Parameter Assignment
            JObject jsonObject = new JObject();

            JObject ccontact = new JObject();
            ccontact["first_name"] = nameoncard;
            ccontact["last_name"] = nameoncard;
            ccontact["postal_code"] = zip;
            jsonObject["account_id"] = accountid;
            jsonObject["reason"] = "recurring";
            jsonObject["method"] = "card";
            jsonObject["card_number"] = cardno;
            jsonObject["contact"] = ccontact;
            jsonObject["expiration_date"] = expdt;
            jsonObject["cvv"] = cvv;


            #endregion


            return Chargetoken(jsonObject);
        }
        public static string Createtoken(string accno, string routingno, string name, string zip)
        {
            #region Parameter Assignment
            JObject jsonObject = new JObject();

            JObject ccontact = new JObject();
            ccontact["first_name"] = name;
            ccontact["last_name"] = name;
            ccontact["postal_code"] = zip;

            jsonObject["account_id"] = accountid;
            jsonObject["reason"] = "recurring";
            jsonObject["method"] = "bank_account";
            jsonObject["type"] = "checking";
            jsonObject["account_number"] = accno;
            jsonObject["routing_number"] = routingno;
            jsonObject["contact"] = ccontact;


            #endregion


            return Chargetoken(jsonObject);
        }
        private static string Generate(int Length)
        {
            /* Alternative method
            Random random = new Random();
            return MD5Hash(random.Next(0,1000).ToString());
            */

            if (Length < 5)
            {
                Length = 5;
            }

            Random random = new Random();
            string password = MD5Hash(random.Next().ToString()).Substring(0, 10);
            string newPass = "";

            // Uppercase at random
            random = new Random();
            for (int i = 0; i < password.Length; i++)
            {
                if (random.Next(0, 2) == 1)
                    newPass += password.Substring(i, 1).ToUpper();
                else
                    newPass += password.Substring(i, 1);
            }

            return newPass;
        }
        private static string MD5Hash(string Data)
        {
            MD5 md5 = new MD5CryptoServiceProvider();
            byte[] hash = md5.ComputeHash(Encoding.ASCII.GetBytes(Data));

            StringBuilder stringBuilder = new StringBuilder();
            foreach (byte b in hash)
            {
                stringBuilder.AppendFormat("{0:x2}", b);
            }
            return stringBuilder.ToString();
        }
        public static string getPayID(string ConfNo)
        {
            try
            {
                Object Obj1 = SqlHelper.ExecuteScalar(System.Configuration.ConfigurationManager.AppSettings["online"].ToString(), CommandType.Text, "select Paymentid from tbl_Payments where confcode='" + ConfNo + "'");
                return Obj1.ToString();
            }
            catch
            {
                return "";
            }

        }
          private static string getrefnos(string payID, string colname)
        {
            Object Obj1 = SqlHelper.ExecuteScalar(System.Configuration.ConfigurationManager.AppSettings["online"].ToString(), CommandType.Text, "select " + colname + " from tbl_Payments where Paymentid='" + payID + "'");
            return Obj1.ToString();
        }
        public static string Voidpayment(string ConfNo)
        {
            string payID = getPayID(ConfNo);
            string Chargeid = getrefnos(payID, "Refno1");

            Void(Chargeid);
            SqlHelper.ExecuteScalar(System.Configuration.ConfigurationManager.AppSettings["online"].ToString(), CommandType.Text, "update  tbl_Payments set status='Void' where Paymentid='" + payID + "'");

            return "Void Completed";
        }
        public static string Refundpayment(string Chargeid, decimal amount)
        {
            JObject jsonObject = new JObject();

            jsonObject["original_charge_id"] = Chargeid;
            jsonObject["total_amount"] = amount;
            return Refund(jsonObject);
        }
        #endregion
    }
}