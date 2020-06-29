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
using System.Net;
using System.Text;

namespace Licensing.PersonLicensing
{
    public partial class CLnewapplication : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ddlpenapp.DataSource = Utilities_Licensing.Getpending_applications(Request.QueryString[0].ToString());
                ddlpenapp.DataTextField = "License_Type";
                ddlpenapp.DataValueField = "App_ID";
                ddlpenapp.DataBind();
                Complaints.utilities.Fill_Dropdown(ddl_users, "tbl_Login Order by LastName", "isnull(LastName,'')+', '+isnull(FirstName,'')", "loginID", " ", "Select");
                ddlap_chng(null, null);
                if (Session["Utype"].ToString() == "417")
                {
                    txtlicno.ReadOnly = false;
                    txtissuedate.ReadOnly = false;
                }
                
                List<Person_Details.tbl_PersonDetail> obj = Person_Details.Licensing_Details.GetPerson_Details(Convert.ToInt32(Request.QueryString[0].ToString()));
                if (obj[0].object_type != 1)
                    tablepersonrespnsible.Visible = true;
                else
                    tablepersonrespnsible.Visible = false;
            }
        }
        protected void ddlap_chng(object sender, EventArgs e)
        {
            BindChecklistItems();
            var personresp = Person_Details.Licensing_Details.GetPersonResp(Convert.ToInt32(ddlpenapp.SelectedValue));
            if (personresp != null)
            {
                hfd_user.Value = personresp.Person_Responsible;
                if (ddl_users.Items.FindByValue(personresp.Person_Responsible) != null)
                    ddl_users.Items.FindByValue(personresp.Person_Responsible).Selected = true;
            }
            ScriptManager.RegisterStartupScript(Page, GetType(), "js", "setheight()", true);
        }

        public Boolean getrdb(string cval, string dval)
        {
            if (cval == dval)
                return true;
            else
                return false;
        }

        private int rdb_check(GridViewRow gvr)
        {
            RadioButton rdb;
            for (int i = 1; i < 5; i++)
            {
                rdb = (RadioButton)gvr.FindControl("rdb" + i);
                if (rdb.Checked == true)
                {
                    if (i == 1)
                        return 1;
                    else
                        if (i == 2)
                            return 0;
                        else
                            return i - 1;
                }
            }
            return 0;
        }
        protected void Insert_Chkitems(object sender, EventArgs e)
        {
            GridViewRow gvr;
            for (int i = 0; i < grdchkitems_list.Rows.Count; i++)
            {
                gvr = grdchkitems_list.Rows[i];

                int applicchklistid = Convert.ToInt32(((HiddenField)gvr.FindControl("hfd_chkid")).Value);
                int chklistid = Convert.ToInt32(((HiddenField)gvr.FindControl("hfdid1")).Value);
                int appid = Convert.ToInt32(ddlpenapp.SelectedValue);
                // int insert_type = Convert.ToInt32(((HiddenField)gvr.FindControl("hfd_result")).Value);

                Utilities_Licensing.update_checkitems(applicchklistid, appid, chklistid.ToString(), rdb_check(gvr).ToString());


            }
            if (sender != null)
            {
                ScriptManager.RegisterStartupScript(Page, GetType(), "js", "aftersave()", true);
            }
        }
        protected void Buttonmake1_click(object sender, EventArgs e)
        {
            Insert_Chkitems(null, null);
            
            var products= Person_Details.Licensing_Details.Getlicnumber_creation(Convert.ToInt32(ddlpenapp.SelectedValue));
            txtlicno.Text = products[0].Lic_no;
            txtExpirationDate.Text = products[0].Expire_date;
            txtissuedate.Text = DateTime.Now.ToShortDateString();
            ScriptManager.RegisterStartupScript(this, GetType(), "js", "<script>Popup();</script>", false);
        }

        protected void btnok_Click(object sender, EventArgs e)
        {
            if (Utilities_Licensing.Checklicenseexxists(txtlicno.Text, Request.QueryString[0].ToString()))
            {
                int Application_ID = Convert.ToInt32(ddlpenapp.SelectedValue);
                string App_status_changed = DateTime.Now.ToShortDateString();
                string Issued_date = txtissuedate.Text;
                string Expired_date = txtExpirationDate.Text;
                int Make_complete = 1;
                string Licno = txtlicno.Text;

                Person_Details.Licensing_Details.Insert_Make_Complete(Application_ID, App_status_changed, Issued_date, Expired_date, Make_complete, Licno);
                ddlpenapp.DataSource = Utilities_Licensing.Getpending_applications(Request.QueryString[0].ToString());
                ddlpenapp.DataTextField = "License_Type";
                ddlpenapp.DataValueField = "App_ID";
                
                ddlpenapp.DataBind();
                if (ddlpenapp.Items.Count > 0)
                ddlap_chng(null, null);
                string js = "checkval("+ddlpenapp.Items.Count+")";
                ScriptManager.RegisterStartupScript(Page, GetType(), "scr", js, true);
            }
            else
            {

               var lic= Person_Details.Licensing_Details.Getlicnumber_creation(Convert.ToInt32(Request.QueryString[0].ToString()));
               txtlicno.Text = lic[0].Lic_no;
               txtExpirationDate.Text = lic[0].Expire_date;
                //txtlicno.Text = dt.Rows[0]["Lic_no"].ToString();
                //txtExpirationDate.Text = dt.Rows[0]["Expire_date"].ToString();

                altbox("Sorry! This license number has already been assigned.");
            }
        }
        private void BindChecklistItems()
        {
            grdchkitems_list.DataSource = Utilities_Licensing.Get_checklistitems(Convert.ToInt32(ddlpenapp.SelectedValue));
            grdchkitems_list.DataBind();
        }
        private void  altbox(string str)
        {
            string js = " afterpost('" + str + "');";
            ScriptManager.RegisterStartupScript(Page, GetType(), "scr", js, true);
        }
        protected void btnnotify_Click(object sender, EventArgs e)
        {
            string id = ""; string subject = "";
            Person_Details.Tbl_Login obj = Person_Details.Licensing_Details.GetUserEmail(Convert.ToInt32(ddl_users.SelectedValue));
            string FromEmail = obj.Email;
            Person_Details.USP_GetPersonDetailsByPIDResult perobj = Person_Details.Licensing_Details.Get_PersonDetailsByPersonID(Convert.ToInt32(Request.QueryString[0].ToString()));
            if (perobj != null)
            {
                
                if (hfd_user.Value != ddl_users.SelectedValue)
                {
                    if (Session["UID"].ToString() == "17" || Session["UID"].ToString() == "16")
                        subject = "Assigned for Inspection";
                    else
                        subject = "ATTN: Application Assigned -" + perobj.Full_Name;
                }
                else
                    subject = "ATTN: Application Assigned -" + perobj.Full_Name;
                id = Mail.SendMailWithMessage("", FromEmail+ ",ebraden@albop.com,pwright@albop.com", "", subject, "Pharmacy Name : " + perobj.Full_Name + "<br/>License Type : " + ddlpenapp.SelectedItem.Text + "<br/>Temp Number : " + Request.QueryString[0].ToString() + "<br/>Pharmacy Address : " + perobj.PharmacyAddress1 + "<br/>County : " + perobj.LkpCounty + "<br/>Phone Number : " + perobj.Phone);
                if (id != "-1")
                    altbox("Mail sent successfully.");
                else
                    altbox("Mail not sent successfully.");
                 
            }

            Utilities_Licensing.InsertPersonRespApplication(Convert.ToInt32(ddlpenapp.SelectedValue), ddl_users.SelectedValue);

        }
    }
}