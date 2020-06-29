using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using Person_Details;
using System.Web.Script.Serialization;

namespace Licensing
{
    /// <summary>
    /// Summary description for ALBOPWebstats
    /// </summary>
    [WebService(Namespace = "http://microsoft.com/webservices/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
     [System.Web.Script.Services.ScriptService]
    public class ALBOPWebstats : System.Web.Services.WebService
    {
        public ALBOPWebstats()
        {

        }
        public string Jsonhelper(Object obj)
        {
            JavaScriptSerializer json = new JavaScriptSerializer();
            return json.Serialize(obj);

        }
        [WebMethod]
        public string Webstats()
        {
            using (Person_LicenseDataContext pdc = new Person_LicenseDataContext())
            {
                return Jsonhelper(pdc.AlbopWebsitestats().ToList());
            }
        }
    }
}
