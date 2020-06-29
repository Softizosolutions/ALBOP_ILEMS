using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;
using Person_Details;

namespace Licensing
{
    public partial class Albopwebsitestats : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            using(Person_LicenseDataContext db = new Person_LicenseDataContext())
            {
                JavaScriptSerializer json = new JavaScriptSerializer();
                Response.Clear();
                Response.ContentType="application/json;charset=utf-8";
                Response.Write(json.Serialize(db.AlbopWebsitestats().ToList()));
                Response.End();
            }
        }
    }
}