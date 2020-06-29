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
using System.Linq;
using System.Collections.Generic;
using System.IO;
using System.Net;
using System.Text;
using ComplaintsTabLinq;
using Licensing.Complaints;

namespace Licensing.PersonLicensing
{
    public partial class complaints : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string lis = "";
               // lis = lis + "<li   onclick=javascript:loaddiv(this,'../Complaints/ComplaintGeneral.aspx')><i class='fa fa-server'></i> General </li><li  onclick=javascript:loaddiv(this,'../Complaints/ComplaintInvestigation.aspx')><i class='fa fa-ticket'></i>  Investigation </li>";
               // lis = lis + "<li  onclick=javascript:loaddiv(this,'../Complaints/Complaints_Prosecution.aspx')><i class='fa fa-university'></i>  Prosecution </li><li  onclick=javascript:loaddiv(this,'../PersonLicensing/Documents.aspx')><i class='fa fa-sticky-note'></i>  Documents </li>";

                string utype = Session["Utype"].ToString();
                string uid = Session["UID"].ToString();
                string[] hideinv = System.Configuration.ConfigurationManager.AppSettings["hideinvestigation"].ToString().Split(',');
                string[] showonly = System.Configuration.ConfigurationManager.AppSettings["showonlycases"].ToString().Split(',');
                List<Reports.USP_Gettabs2displayResult> tlst = Reports.Reportgenrator.Gettabs(utype).Where(c => c.tabid > 10 && c.tabid != 17 && c.tabid != 18&&c.tabid!=19 & c.tabid < 19).ToList();
                foreach (Reports.USP_Gettabs2displayResult t in tlst)
                {

                    if ((t.tabid == 12 && !hideinv.Contains(uid)) || t.tabid != 12)
                    {
                        lis += "<li  onclick=javascript:loaddiv(this,'" + t.tablink + "','" + t.write + "','" + t.del + "')> <i class='fa " + t.Class + "'></i><span id='cnum'></span><span>" + t.tabname.Replace("Complaints ", string.Empty) + "</span> </li>";
                    }
                }
                if (showonly.Contains(uid))
                {
                    hfdpresid.Value = uid;
                }
                hfdselcmpno.Value = Request.QueryString["selcmpno"].ToString();
 
                tabs.InnerHtml = lis;
                hfdRespondentId.Value = Request.QueryString[0].ToString();
                // Utilities_ComplaintsTAB.BindGridComplaints(grdComplaintResults, "1",Convert.ToInt32(Request.QueryString[0].ToString()));
                // grdComplaintResults.DataSource = ComplaintsTabLinq.ClsComplaints.GetComplaints("1", 29);
                // grdComplaintResults.DataBind();
                Utilities_ComplaintsTAB.BindDropdown(ddlcompsource, 5);
                Utilities_ComplaintsTAB.BindDropdown(ddlcompcategory, 4);
                //utilities.Fill_Dropdown(ddlcompresposible, "tbl_Login Order by LastName", "LastName+' '+FirstName", "loginID", " ", "Select");

                utilities.Fill_Dropdown(ddlcompresposible, "tbl_Login where UserType in (417,416,1136,1323,1391) Order by LastName", "isnull(LastName,'')+', '+isnull(FirstName,'')", "loginID", " ", "Select");
                utilities.Fill_Dropdown(ddlcompinvestigate, "tbl_Login where UserType in (417,416) Order by LastName", "isnull(LastName,'')+', '+isnull(FirstName,'')", "loginID", " ", "Select");
                utilities.Fill_Dropdown(ddlcompinvestigate2, "tbl_Login where UserType in (417,416) Order by LastName", "isnull(LastName,'')+', '+isnull(FirstName,'')", "loginID", " ", "Select");
                ddlcompinvestigate2.Items.Add(new ListItem("Closed Files", "-2"));
                ddlcompresposible.Items.Add(new ListItem("Closed Files", "-2"));
                ddlcompinvestigate.Items.Add(new ListItem("Closed Files", "-2"));
                Utilities_ComplaintsTAB.BindDropdown(ddlcompstatus, 55);
               // Utilities_ComplaintsTAB.BindDropdown(ddlNurseConsultant, 27);
                Utilities_ComplaintsTAB.BindDropdown(ddlcompstate, 9);

                Utilities_ComplaintsTAB.BindDropdown(ddlcompsource1, 5);
                Utilities_ComplaintsTAB.BindDropdown(ddlcompcategory1, 4);
                utilities.Fill_Dropdown(ddlcompresposible1, "tbl_Login where UserType in (417,416,1136,1323,1391) Order by LastName", "LastName+' '+FirstName", "loginID", " ", "Select");
                utilities.Fill_Dropdown(ddlcompinvestigate1, "tbl_Login where UserType in (417,416) Order by LastName", "LastName+' '+FirstName", "loginID", " ", "Select");
                ddlcompresposible1.Items.Add(new ListItem("Closed Files", "-2"));
                ddlcompinvestigate1.Items.Add(new ListItem("Closed Files", "-2"));
                Utilities_ComplaintsTAB.BindDropdown(ddlNurseConsultant1, 27);
                Utilities_ComplaintsTAB.BindDropdown(ddlcompstate1, 9);
                
            }

        }
        private void clearcomp()
        {
            hfdautoid.Value = "0";
            hfdcompNum.Value = "";
            hfdRespondentType.Value = "1";
            hfdRespondentId.Value = "0";
            hfdcompanioncaseidoutparm.Value = "0";
             ddlcompsource.SelectedIndex = -1;
              ddlcompcategory.SelectedIndex = -1;
             ddlcompstatus.SelectedIndex = -1;
             txtcompdaterecive.Text = "";
            // txtcomodocketed.Text = "";
             txtcomplainant.Text = "";
             txtcompadd1.Text = "";
             txtcompadd2.Text = "";
             txtcompcity.Text = "";
             txtcompzip.Text = "";
             ddlcompresposible.SelectedIndex = -1;
             ddlcompinvestigate.SelectedIndex = -1;
                 ddlcompstate.SelectedIndex = -1;
                 txtInvestigateAssigned.Text = "";
                 txtInvestigatorReceived.Text = "";
            ddlcompinvestigate2.SelectedIndex = -1;
        }

            protected void btnedit_click(object sender, EventArgs e)
            {
                clearcomp();
                string Value = hfdselid.Value;
                ComplaintsTabLinq.TbL_Complaint ObjComplaint = Utilities_ComplaintsTAB.GetComplaintsById(Convert.ToInt32(Value));
                hfdautoid.Value = ObjComplaint.Complaint_ID.ToString();
                hfdcompNum.Value = Convert.ToString(ObjComplaint.Complaint_Number);
                hfdRespondentType.Value = ObjComplaint.Respondent_type;
                hfdRespondentId.Value = Convert.ToString(ObjComplaint.Respondent_ID);
                hfdcompanioncaseidoutparm.Value = ObjComplaint.CompanionCase_ID.ToString();
                string source = ObjComplaint.Source_Id;
                ddlcompsource.SelectedIndex = -1;
                    if (ddlcompsource.Items.FindByValue(source) != null)
                        ddlcompsource.Items.FindByValue(source).Selected = true;
               
                string category = ObjComplaint.Category_Id;
                ddlcompcategory.SelectedIndex = -1;
                    if (ddlcompcategory.Items.FindByValue(category) != null)
                        ddlcompcategory.Items.FindByValue(category).Selected = true;
                
                string status = ObjComplaint.Complaint_Status;
                ddlcompstatus.SelectedIndex = -1;
                    if (ddlcompstatus.Items.FindByValue(status) != null)
                        ddlcompstatus.Items.FindByValue(status).Selected = true;

                    string datereceived = Convert.ToDateTime(ObjComplaint.DateReceived).ToString("MM/dd/yyyy");
                    if (datereceived != null && datereceived != "01/01/0001" && datereceived != "01/01/1900" && datereceived != "")
                        txtcompdaterecive.Text = Convert.ToDateTime(ObjComplaint.DateReceived).ToString("MM/dd/yyyy");
                    else
                        txtcompdaterecive.Text = "";
               
                //txtcompdaterecive.Text = ObjComplaint.DateReceived.ToString();
                //txtcomodocketed.Text = ObjComplaint.DateDocketed.ToString();
                //if (ObjComplaint.DateDocketed != null)
                //txtcomodocketed.Text = Convert.ToDateTime(ObjComplaint.DateDocketed).ToString("MM/dd/yyyy");
                txtcomplainant.Text = ObjComplaint.Compainant;
                txtcompadd1.Text = ObjComplaint.Address1;
                txtcompadd2.Text = ObjComplaint.Address2;
                txtcompcity.Text = ObjComplaint.City;
                txtcompzip.Text = ObjComplaint.Zip;
                string personres = ObjComplaint.PersonResponcible_ID;
                ddlcompresposible.SelectedIndex = -1;
                    if (ddlcompresposible.Items.FindByValue(personres) != null)
                        ddlcompresposible.Items.FindByValue(personres).Selected = true;
                    hfdpers.Value = ObjComplaint.PersonResponcible_ID;
            ddlcompinvestigate2.SelectedIndex = -1;
            if (ddlcompinvestigate2.Items.FindByValue(ObjComplaint.SecondInvestigatiorID) != null)
                ddlcompinvestigate2.Items.FindByValue(ObjComplaint.SecondInvestigatiorID).Selected = true;

            string investigator = ObjComplaint.InvestiGator_ID;
                ddlcompinvestigate.SelectedIndex = -1;
                 if (ddlcompinvestigate.Items.FindByValue(investigator) != null)
                        ddlcompinvestigate.Items.FindByValue(investigator).Selected = true;
                 
                string cmptype = ObjComplaint.ComplaintType;
                if (ddlcompstate.Items.FindByValue(ObjComplaint.State) != null)
                {
                    ddlcompstate.SelectedIndex = -1;
                    ddlcompstate.Items.FindByValue(ObjComplaint.State).Selected = true;
                }

                string dateinvestigation = Convert.ToDateTime(ObjComplaint.DateInvestigatorAssigned).ToString("MM/dd/yyyy");
                if (dateinvestigation != "01/01/1900" && dateinvestigation != "01/01/0001" && dateinvestigation != "" && dateinvestigation != null)
                {
                    txtInvestigateAssigned.Text = Convert.ToDateTime(dateinvestigation).ToString("MM/dd/yyyy");
                }
                else
                    txtInvestigateAssigned.Text = "";

                string dateinvsrec = Convert.ToDateTime(ObjComplaint.DateInvestigatorReceived).ToString("MM/dd/yyyy");
                if (dateinvsrec != "01/01/1900" && dateinvsrec != "01/01/0001" && dateinvsrec != "" && dateinvsrec != null)
                {
                    txtInvestigatorReceived.Text = Convert.ToDateTime(dateinvsrec).ToString("MM/dd/yyyy");
                }
                else
                    txtInvestigatorReceived.Text = "";

                string dateinvscmp=Convert.ToDateTime(ObjComplaint.DateInvestigationComplete).ToString("MM/dd/yyyy");
                if (dateinvscmp != "01/01/1900" && dateinvscmp != "01/01/0001" && dateinvscmp != "" && dateinvscmp != null)
                {
                    txtdateinvgcomplete.Text = Convert.ToDateTime(dateinvscmp).ToString("MM/dd/yyyy");
                }
                else
                    txtdateinvgcomplete.Text = "";
                //if (Convert.ToDateTime(ObjComplaint.DateInvestigatorAssigned).ToString("MM/dd/yyyy") != "01/01/1900")
                //txtInvestigateAssigned.Text = Convert.ToDateTime(ObjComplaint.DateInvestigatorAssigned).ToString("MM/dd/yyyy");
                //if (Convert.ToDateTime(ObjComplaint.DateInvestigatorReceived).ToString("MM/dd/yyyy") != "01/01/1900")
               //txtInvestigatorReceived.Text = Convert.ToDateTime(ObjComplaint.DateInvestigatorReceived).ToString("MM/dd/yyyy");
               // if (Convert.ToDateTime(ObjComplaint.DateInvestigationComplete).ToString("MM/dd/yyyy") != "01/01/1900")
                // txtdateinvgcomplete.Text = Convert.ToDateTime(ObjComplaint.DateInvestigationComplete).ToString("MM/dd/yyyy");
                try
                {
               
                }
                catch (Exception)
                {

                }
                string js = "Openapplication();";
                ScriptManager.RegisterStartupScript(Page, GetType(), "scr", js, true);
            }

private string  altbox(char p)
{
 	throw new NotImplementedException();
}
        public string openapp1(string Logid)
        {
            return "javascript:return Openapplication('" + Logid + "')";
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
        public string compstatus(string status)
        {
            if (status == "1")
            {

                return "Open";
            }
            else
                return "Close";
        }
        public string toup(string str)
        {
            string sr = str.ToUpper();
            return sr;
        }
        public string openapp2(string pid)
        {


            return "javascript:return Openapplication2('" + pid + "')";

        }

        protected void btnupdateComplaint_Click(object sender, EventArgs e)
        {
            string person = "";
            string caseno = "";
            string prvres = "";
            string curres = "";
            string pstatus = "";
            string cstatus = "";
            using (ComplaintsTabLinq.ComplaintsTabDataContext cdb = new ComplaintsTabDataContext())
            {
                ComplaintsTabLinq.TbL_Complaint objcom = cdb.TbL_Complaints.Where(c=>c.Complaint_ID==Convert.ToInt32(hfdautoid.Value)).SingleOrDefault();
                pstatus = objcom.Complaint_Status;
                cstatus = ddlcompstatus.SelectedValue;
                prvres = objcom.PersonResponcible_ID;
                curres = ddlcompresposible.SelectedValue;
                objcom.Respondent_type = hfdRespondentType.Value.ToString() == "1" ? "1" : "2";
                objcom.Respondent_ID = Convert.ToInt32(hfdRespondentId.Value);
                objcom.Source_Id = ddlcompsource.SelectedValue.ToString();
                objcom.Category_Id = ddlcompcategory.SelectedValue.ToString();
                if (txtcompdaterecive.Text != "")
                    objcom.DateReceived = Convert.ToDateTime(txtcompdaterecive.Text);
                else
                    objcom.DateReceived = Convert.ToDateTime("01/01/1900");
                //if (txtcomodocketed.Text != "")
                //    objcom.DateDocketed = Convert.ToDateTime(txtcomodocketed.Text);
                //else
                //    objcom.DateDocketed = Convert.ToDateTime("01/01/1900");
               
                objcom.Address1 = txtcompadd1.Text;
                objcom.Address2 = txtcompadd2.Text;
                objcom.City = txtcompcity.Text;
                //objcom.State = ddlcompstate.SelectedValue.ToString();
                objcom.Zip = txtcompzip.Text;
                objcom.PersonResponcible_ID = ddlcompresposible.SelectedValue.ToString();
                caseno = objcom.Complaint_Number;
                objcom.State = ddlcompstate.SelectedValue;
                if (txtdateinvgcomplete.Text != "")
                    objcom.DateInvestigationComplete = Convert.ToDateTime(txtdateinvgcomplete.Text);
                else
                    objcom.DateInvestigationComplete = Convert.ToDateTime("01/01/1900");
               
                objcom.ComplaintType = "1";

                objcom.InvestiGator_ID = ddlcompinvestigate.SelectedValue.ToString();
                objcom.SecondInvestigatiorID = ddlcompinvestigate2.SelectedValue.ToString();
                objcom.Compainant = txtcomplainant.Text;
                if (txtInvestigateAssigned.Text != "")
                    objcom.DateInvestigatorAssigned = Convert.ToDateTime(txtInvestigateAssigned.Text);
                else
                    objcom.DateInvestigatorAssigned = Convert.ToDateTime("01/01/1900");
                if (txtInvestigatorReceived.Text != "")
                    objcom.DateInvestigatorReceived = Convert.ToDateTime(txtInvestigatorReceived.Text);
                else
                    objcom.DateInvestigatorReceived = Convert.ToDateTime("01/01/1900");
                //  objcom.Consultant = ddlNurseConsultant.SelectedValue.ToString();                   
                objcom.Complaint_Status = ddlcompstatus.SelectedValue.ToString();
                objcom.modifiedby =Convert.ToInt32( Session["UID"].ToString()); 
                objcom.modifieddate = Convert.ToDateTime(System.DateTime.Now.ToString("MM/dd/yyyy"));
                if (prvres != curres)
                {
                    ComplaintsTabLinq.tbl_Personresponsible_History his = new tbl_Personresponsible_History();
                    his.Complaint_id = objcom.Complaint_ID;
                    his.Old_person = Convert.ToInt32(prvres);
                    his.New_Person = Convert.ToInt32(curres);
                    his.Changedby =Convert.ToInt32( Session["UID"].ToString());
                    his.Changeddt = DateTime.Now;
                   cdb.tbl_Personresponsible_Histories.InsertOnSubmit(his);

                }
                if (pstatus != cstatus)
                {
                    ComplaintsTabLinq.tbl_ComplaintStatusChanged_History cmpstatushis = new tbl_ComplaintStatusChanged_History();
                    cmpstatushis.Complaint_ID = objcom.Complaint_ID;
                    cmpstatushis.Complaint_Number = objcom.Complaint_Number;
                    cmpstatushis.Person_ID = objcom.Respondent_ID;
                    cmpstatushis.Old_Status = pstatus;
                    cmpstatushis.New_Status = cstatus;
                    cmpstatushis.Date_Status_Changed = Convert.ToDateTime(DateTime.Now.ToShortDateString());
                    cmpstatushis.Modify_By = Session["UID"].ToString();
                    cmpstatushis.Modify_Date = Convert.ToDateTime(DateTime.Now.ToShortDateString());
                    cdb.tbl_ComplaintStatusChanged_Histories.InsertOnSubmit(cmpstatushis);
                }
                cdb.SubmitChanges();
            }
            if (prvres != curres&& ddlcompstatus.SelectedValue!="1049")
            {
                prvres=  AdminLinq.Admin.Getemail(prvres);
                //prvres = prvres + ";" + "pwright@albop.com";
                curres = AdminLinq.Admin.Getemail(curres);
                DataTable dt = new DataTable();
                dt = Utilities_Licensing.GetNameandLicno(Convert.ToInt32(hfdautoid.Value));
                string st = @"<table cellspacing='0' width='100%' >
                              <tr>
                              <td style='text-align:left;' colspan='3'><b>This Email is to notify you that a case has been assigned to you.</b><br/><br/></td>
                              </tr>";
                foreach (DataRow dr in dt.Rows)
                {
                    st = st + @"<tr>
                                <td style='text-align: left;'><b>Respondent :</b></td>  
                                <td style='text-align:left;'>" + dr["Name"].ToString() + "</td></tr>";
                    st = st + @"<tr>
                                <td style='text-align: left;'><b>License Type :</b></td>  
                                <td style='text-align:left;'>" + dr["License_Type"].ToString() + "</td></tr>";    
                    st = st + @"<tr>
                                <td style='text-align: left;'><b>License # :</b></td>  
                                <td style='text-align:left;'>" + dr["Lic_no"].ToString() + "</td></tr>";
                    st = st + @"<tr>
                            <td style='text-align:left;'><b>License Status :</b></td>
                            <td style='text-align:left;'>" + dr["LicenseStatus"].ToString() + "</td></tr>";
                }
                if (chkattachdoc.Checked == true)
                {
                    DataSet ds = Utilities_Licensing.GetDocumentPath(hfdautoid.Value);
                    string docpath = ds.Tables[0].Rows[0]["docpath"].ToString();
                    string comments = ds.Tables[0].Rows[0]["Comments"].ToString();
                    if (docpath.ToString() != "")
                    {
                            st = st + @"<tr><td colspan='2'>&nbsp;</td></tr><tr>
                                <td colspan='2' style='text-align:left;'><a href=" + docpath + " style='text-decoration:none;' target='blank'>Download Initial Complaint Document</a></td></tr>";
                    }
                    if (comments != "" && comments != null)
                    {
                        st = st + @"<tr><td colspan='2'>&nbsp;</td></tr><tr>
<td style='text-align:left;'>Comments :</td><td style='text-align:left'>" + comments + "</td></tr>";
                    }
                    
                }
                st = st + "</table>";

                if (ddlcompsource.SelectedValue == "1257" || ddlcompsource.SelectedValue == "1038" || ddlcompsource.SelectedValue == "1039" || ddlcompsource.SelectedValue == "1040" || ddlcompsource.SelectedValue == "1041"||ddlcompsource.SelectedValue=="1259")
                {
                     Mail.SendMail(ddlcompresposible.SelectedItem.Text, curres, prvres, "Case Assigned : " + caseno, st);
                }
                else
                {
                       
                  prvres = prvres + ";" + "pwright@albop.com" + ";" + "ebraden@albop.com" + ";" + "rcoker@albop.com" ;
                    Mail.SendMail(ddlcompresposible.SelectedItem.Text, curres, prvres, "Case Assigned : " + caseno, st);
                }
               
                
            }
            if (pstatus != "1049" && cstatus == "1049")
            {
                if (ddlcompsource.SelectedValue == "1257" || ddlcompsource.SelectedValue == "1038" || ddlcompsource.SelectedValue == "1039" || ddlcompsource.SelectedValue == "1040" || ddlcompsource.SelectedValue == "1041" || ddlcompsource.SelectedValue=="1259")
                {
                    DataTable dt = new DataTable();
                    dt = Utilities_Licensing.GetNameandLicno(Convert.ToInt32(hfdautoid.Value));
                    string st = @"<table cellspacing='0' width='100%' >
                              <tr>
                              <td style='text-align:left;' colspan='3'><b>This Email is to notify you that a case :" + caseno + "  Has Been Closed. </b><br/><br/></td></tr>";
                    foreach (DataRow dr in dt.Rows)
                    {
                        st = st + @"<tr>
                                <td style='text-align: left;'><b>Respondent :</b></td>  
                                <td style='text-align:left;'>" + dr["Name"].ToString() + "</td></tr>";
                        st = st + @"<tr>
                                <td style='text-align: left;'><b>License Type :</b></td>  
                                <td style='text-align:left;'>" + dr["License_Type"].ToString() + "</td></tr>";
                        st = st + @"<tr>
                                <td style='text-align: left;'><b>License # :</b></td>  
                                <td style='text-align:left;'>" + dr["Lic_no"].ToString() + "</td></tr>";
                    }
                    st = st + "</table>";

                    Mail.SendMail("", System.Configuration.ConfigurationManager.AppSettings["cmpclose"].ToString(), "", "Case  Closed ", st);
           
                }
                else
                {
                    DataTable dt = new DataTable();
                    dt = Utilities_Licensing.GetNameandLicno(Convert.ToInt32(hfdautoid.Value));
                    string st = @"<table cellspacing='0' width='100%' >
                              <tr>
                              <td style='text-align:left;' colspan='3'><b>This Email is to notify you that a case :" + caseno + "  Has Been Closed. </b><br/><br/></td></tr>";
                    foreach (DataRow dr in dt.Rows)
                    {
                        st = st + @"<tr>
                                <td style='text-align: left;'><b>Respondent :</b></td>  
                                <td style='text-align:left;'>" + dr["Name"].ToString() + "</td></tr>";
                        st = st + @"<tr>
                                <td style='text-align: left;'><b>License Type :</b></td>  
                                <td style='text-align:left;'>" + dr["License_Type"].ToString() + "</td></tr>";
                        st = st + @"<tr>
                                <td style='text-align: left;'><b>License # :</b></td>  
                                <td style='text-align:left;'>" + dr["Lic_no"].ToString() + "</td></tr>";
                    }
                    st = st + "</table>";

                    Mail.SendMail("", System.Configuration.ConfigurationManager.AppSettings["cmpclose1"].ToString(), "", "Case  Closed ", st);
                }
            }
            string js = " altbox('Complaints updated successfully.');";
            ScriptManager.RegisterStartupScript(Page, GetType(), "scr", js, true);
        }
        protected void btnNotify_Investigators_Click(object sender, EventArgs e)
        {
            string secondinvestigator = "", emails = "";

           // investigator = AdminLinq.Admin.Getemail(ddlcompinvestigate.SelectedValue);
            secondinvestigator = AdminLinq.Admin.Getemail(ddlcompinvestigate2.SelectedValue);
            string firstinv = "";
            firstinv = AdminLinq.Admin.Getemail(ddlcompinvestigate.SelectedValue);
            emails = secondinvestigator;
            
            DataTable dt = new DataTable();
            dt = Utilities_Licensing.GetNameandLicno(Convert.ToInt32(hfdautoid.Value));
            int i=Mail.SendMail1("", emails, "EBraden@albop.com;PWright@albop.com;rcoker@albop.com;wpassmore@albop.com", "Investigation assigned", "You have been assigned to assist " + firstinv + " with this investigation.<br/><br/>Case # : " + Request.QueryString[1].ToString() + "<br/><br/>Respondent Name : " + dt.Rows[0]["Name"].ToString());
            if (i==1)
            {
                string js = " altbox('Mail sent successfully.');";
                ScriptManager.RegisterStartupScript(Page, GetType(), "scr", js, true);
            }
            else
            {
                string js = " altbox('Mail not sent.');";
                ScriptManager.RegisterStartupScript(Page, GetType(), "scr", js, true);
            }
        }
    }
}