using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using System.Collections.Generic;
using System.IO;
using Person_Details;

namespace Licensing
{
    public partial class PersonDetails : System.Web.UI.Page
    {
        protected void btnrel_click(object sender, EventArgs e)
        {
            Licensing_Details.Insert_alertrelease(hfdaltid.Value, Session["UID"].ToString());
            ScriptManager.RegisterStartupScript(Page, GetType(), "js", "chkalrt();clsalrt();", true);
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
               

                string pid = Request.QueryString[0].ToString();
                hfdpid.Value = pid;
                List<Person_Details.usp_getlicensedetailsResult> obj = Person_Details.Licensing_Details.get_PersonsData1(Convert.ToInt32(pid), "1");

                lbl_name.Text = obj[0].Name;
                lblnmhead.Text = lbl_name.Text.ToUpper();
                lbl_name.Attributes.Add("onClick", "return open_edit(" + pid + ");");
                lbl_ssn.Text = obj[0].SSN;
                lbl_address.Text = obj[0].Address2;
                lbl_dob.Text = filter_date(obj[0].DOB.ToString());
                lbl_phone.Text = obj[0].Phone;
                lbl_email.Text = obj[0].Email;
                lbl_email.NavigateUrl = "mailto:" + obj[0].Email;
                lbl_age.Text = obj[0].Age;
                lbl_addr1.Text = obj[0].Address1;
                lbl_city.Text = obj[0].City;
                lbl_licnum.Text = obj[0].Licno;
                // string state="";                
                lbl_zip.Text = obj[0].stateZip;
                //lbl_deanumber.Text = obj.DEA;
                lbl_cpenumber.Text = obj[0].CPE;
                lbl_altpone.Text = obj[0].AltPhone;
                if (obj[0].AllDocumentsReceived == true)
                {
                    lbllicnnumber.Attributes.Add("Style", "Color:red");
                    lbl_licnum.Attributes.Add("Style", "Color:red");
                }
                string lis = "";
                string selcmpno = "0";
                if (Request.QueryString["selcmpno"] != null)
                    selcmpno = Request.QueryString["selcmpno"].ToString();

                List<Pending_application> pending = getpendingapplications(Convert.ToInt32(pid));
                if (pending.Count > 0)
                    lis += "<li  onclick=javascript:loaddiv(this,'../PersonLicensing/CLnewapplication.aspx?apid=" + pid + "')> <i class='fa fa-th-list'></i>Pending Checklists </li>";
                string utype = Session["Utype"].ToString();

                int tabcount = 0;
                if (pending.Count > 0)
                    tabcount = 1;
                List<Reports.USP_Gettabs2displayResult> tlst = Reports.Reportgenrator.Gettabs(utype).Where(c => c.tabid < 11 || c.tabid == 17||c.tabid==18||c.tabid==19 || c.tabid == 22).ToList();
                foreach (Reports.USP_Gettabs2displayResult t in tlst)
                {
                    if (t.tabid < 6)
                        tabcount++;
                    if (t.tabid != 9 && t.tabid != 10)
                    {
                        if (t.tabid != 6)
                            lis += "<li  onclick=javascript:loaddiv(this,'" + t.tablink + "?pid=" + pid + "&iswrite=" + t.write + "&isdel=" + t.del + "')> <i class='fa " + t.Class + "'></i>" + t.tabname + " </li>";
                        else
                              if (Complaints.Utilities_ComplaintsTAB.cmp_count(Convert.ToInt32(pid)) > 0)
                            lis += "<li  onclick=javascript:loaddiv(this,'" + t.tablink + "?pid=" + pid + "&selcmpno=" + selcmpno + "&iswrite=" + t.write + "&isdel=" + t.del + "')> <i class='fa " + t.Class + "'></i>" + t.tabname + " </li>";

                    }
                }

                if (Request.QueryString["iscmp"] != null)
                {
                    hfdiscmp.Value = tabcount.ToString();
                }
                tabs.InnerHtml = lis;
                if (Session["UID"].ToString() == "9" || Session["UID"].ToString() == "10" || Session["UID"].ToString() == "13" || Session["UID"].ToString() == "29" || Session["UID"].ToString() == "31" || Session["UID"].ToString() == "16" || Session["UID"].ToString() == "17")
                {
                    DataTable chdt = PersonLicensing.Utilities_Licensing.Getcheckerdata(lbl_ssn.Text);
                    if (chdt != null)
                    {
                        if (chdt.Rows.Count > 0)
                        {
                            btnchecker.Visible = true;
                            btnchecker.Attributes.Add("onclick", "javascript:return openchk(0+ ',' + 0)");
                            // btnchecker.Attributes.Add("onclick", "javascript:return openchk('" + chdt.Rows[0]["object_id"].ToString() + "','" + chdt.Rows[0]["report_id"].ToString() + "')");
                        }
                    }
                }
            }

            #region Insertion of Lawful Table Data
 

            DataTable law_dt  =  PersonLicensing.Utilities_Licensing.Get_Values1("tbl_person_law", "*", " personID=" + Request.QueryString[0].ToString());
            if (law_dt.Rows.Count > 0)
            {
                 
                string lawful = law_dt.Rows[0]["lawful"].ToString();
               
                 
                 
              
                    if (lawful == "1")
                { 
                    lbl_rdblawful.Text = "Yes";
                }
                else
                {
                    lbl_rdblawful.Text = "No";
                }

            }
             


            #endregion

        }
        public static List<Pending_application> getpendingapplications(int pid)
        {
            using (Person_LicenseDataContext db = new Person_LicenseDataContext())
            {
                return (from app in db.tbl_Applications
                        join lc in db.tbl_lkp_Licenses on Convert.ToInt32(app.License_Type_ID) equals lc.LicenseType_ID
                        where app.Person_ID == pid && app.App_Status == "511"
                        select new Pending_application() { License_Type = lc.License_Type, App_ID = app.App_ID }).ToList();


                //   return db.tbl_Applications.Where(c => c.Person_ID == pid && c.App_Status == "511").ToList();
            }
        }
        public class Pending_application
        {
            public string License_Type { get; set; }
            public int App_ID { get; set; }
        }

        public string filter_date(string str)
        {
            try
            {
                if (str != "")
                {
                    return DateTime.Parse(str).ToString("MM/dd/yyyy");
                }
                return "NA";
            }
            catch { return "NA"; }
        }
      
    }
}