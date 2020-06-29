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
using Person_Details;

namespace Licensing.PersonLicensing
{
    public partial class Business_Details : System.Web.UI.Page
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
                List<Person_Details.usp_getlicensedetailsResult> obj = Person_Details.Licensing_Details.get_PersonsData1(Convert.ToInt32(pid), "2,3");
                string objtype = "";
                objtype = obj[0].object_type.ToString();
                
                lbl_name.Text = obj[0].Name;
                
                lblnmhead.Text = lbl_name.Text.ToUpper();
                lbl_name.Attributes.Add("onClick", "return open_edit(" + pid + ");");
                lbl_ssn.Text = obj[0].FEIN;
                lbl_address.Text = obj[0].Address2;
                lbl_dob.Text = filter_date(obj[0].DOB.ToString());
                lbl_phone.Text = obj[0].Phone;
                lbl_email.Text = obj[0].Email;
                lbl_email.NavigateUrl = "mailto:" + obj[0].Email;
                lbl_eprofile.Text = obj[0].NABPEProfileNumber;
                lbl_addr1.Text = obj[0].Address1;
                lbl_city.Text = obj[0].City;
                lbl_fax.Text = obj[0].Fax;
                lbl_altphone.Text = obj[0].AltPhone;
                lbl_zip.Text = obj[0].stateZip;
                lbl_deanumber.Text = obj[0].DEA;
                lbl_licnum.Text = obj[0].Licno;
                skippayment.Text = obj[0].SkipPayment;

                 Speciality obj1 = Person_Details.Licensing_Details.Getspeciality(Convert.ToInt32(hfdpid.Value));
                
                if (obj1 != null)
                {
                    if (obj1.DrugCollector == Convert.ToBoolean(1))
                    {
                        lbldrugcolltr.Text = "true";
                    }
                    else
                    {
                        lbldrugcolltr.Text = "false";
                    }
                }
                else
                    lbldrugcolltr.Text = "";
                try
                {
                    lbllastinvdt.Text = Utilities_Licensing.maxinvdt(hfdpid.Value);
                }
                catch
                {

                }
                if (obj.Count > 0)
                {
                    for(int i = 0; i < obj.Count; i++)
                    {
                        if (obj[i].License_Type_ID == "10" || obj[i].License_Type_ID == "11" || obj[i].License_Type_ID == "12" || obj[i].License_Type_ID == "13")
                        {
                            supervisor.Visible = true;
                            supervisorlic.Visible = true;
                            lblsupervisingpharmacist.Text = obj[0].SupervisingPharmacist;
                        }
                        else
                        {
                            supervisor.Visible = true;
                            supervisorlic.Visible = true;
                        }
                    }
                }
                
                //lbl_cpenumber.Text = obj.CPE;
                string lis = "";

                List<Pending_application> pending = getpendingapplications(Convert.ToInt32(pid));
                if (pending.Count > 0)
                    lis += "<li  onclick=javascript:loaddiv(this,'../PersonLicensing/CLnewapplication.aspx?apid=" + pid + "')> <i class='fa fa-th-list'></i>Pending Checklists </li>";
                string utype = Session["Utype"].ToString();
                int tabcount = 0;
                if (pending.Count > 0)
                    tabcount = 1;
                string selcmpno = "0";
                if (Request.QueryString["selcmpno"] != null)
                    selcmpno = Request.QueryString["selcmpno"].ToString();

                
                //if(objtype == "1")
                List<Reports.USP_Gettabs2displayResult> tlst = Reports.Reportgenrator.Gettabs(utype).Where(c => c.tabid < 11 || c.tabid == 18 || c.tabid == 19 || c.tabid == 20 || c.tabid==21).ToList();
                


                foreach (Reports.USP_Gettabs2displayResult t in tlst)
                { 
                    if (t.tabid < 6 && t.tabid != 2 && t.tabid != 8)
                        tabcount++;
                    if (t.tabid != 2 && t.tabid != 8 )
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

            }

            List<License_Data.tbl_USP> usp = License_Data.License_Details.Edit_usp(Request.QueryString[0].ToString());
            if (usp.Count > 0)
            {
                License_Data.tbl_USP us = usp.Where(c => c.PersonID == Request.QueryString[0].ToString()).FirstOrDefault();
                hfdpid.Value = us.PersonID;

                string usp795 = us.USP795;
                if (usp795 == "1")
                {
                    lbl_usp795.Text = "Yes";
                }
                else
                {
                    lbl_usp795.Text = "No";
                }

                string usp797 = us.USP797;
                if (usp797 == "1")
                {
                    lbl_usp797.Text = "Yes";
                }
                else
                {
                    lbl_usp797.Text = "No";
                }
            }


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
                return "";
            }
            catch { return ""; }
        }
    }
}