using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;

namespace Licensing.Complaints
{
    public partial class Complaints_Prosecution : System.Web.UI.Page
    {



        int comid = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            hfdrelatedcompid.Value = Request.QueryString[0].ToString();
            hfdParticipantstatus.Value = Request.QueryString["status"].ToString();
            comid = Convert.ToInt32(hfdrelatedcompid.Value);
            hfd_pid.Value = Request.QueryString[1].ToString();
            if (!IsPostBack)
            {
                BindDrpDownLists();
                Bind_Facts();
                Bindconlaw();
               // bind_consentoffer();
               // bind_formalhearing();
                bind_resolution();
               // bind_violation();
            }
        }


        private void Bindadmincomp()
        {

        }
        


        public string toup3(string str)
        {
            string sr = str.ToUpper();
            if (sr.Length > 15)
                return sr.Substring(0, 15);
            else
                return sr;

        }
        public string phone(string str)
        {
            if (str.Length == 10)
            {
                return "(" + str.Substring(0, 3) + ")&nbsp;" + str.Substring(3, 3) + "-" + str.Substring(6, 4);
            }
            return str;
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
        public string toup(string str)
        {
            string sr = str.ToUpper();
            return sr;
        }
        public string hear(string str)
        {
            if (str == "1")
                return "Yes";
            else
                return "No";

        }

       



        public void bind_charges()
        {
            //DataSet ds = obj_chrg.Get_comp_Charges(Convert.ToInt32(comid));
            //grdcharges.DataSource = ds;
            //grdcharges.DataBind();
        }



        protected void grdcharges_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
           // grdcharges.PageIndex = e.NewPageIndex;
           // bind_charges();
        }

        protected void btnchargesubmit_Click(object sender, EventArgs e)
        {

        }
        protected void btnchargeupdate_Click(object sender, EventArgs e)
        {

        }

        protected void ddlcharges_SelectedIndexChanged(object sender, EventArgs e)
        {

        }


        public void BindDrpDownLists()
        {

            using (ComplaintsLink.ComplaintsDataContext db = new ComplaintsLink.ComplaintsDataContext())
            {

                ddladmcodes.Items.Clear();

                ddladmcodes.DataSource = db.tbl_LKP_Complaints_AdministrativeCodes.ToList();
                ddladmcodes.DataValueField = "Administrative_Code_ID";
                ddladmcodes.DataTextField = "AdministrativeCode";
                ddladmcodes.DataBind();
                //ddladmcodes.Items.Insert(0, new ListItem("--Select--", "-1"));


                for (int i = 0; i < ddladmcodes.Items.Count; i++)
                {
                    ListItem li = new ListItem(ddladmcodes.Items[i].Text, ddladmcodes.Items[i].Value);
                    li.Attributes.Add("onclick", "javascript:addtextarea(this)");
                    chk_administarativecode.Items.Add(li);

                }

                ddladmcodes.Items.Clear();

                ddladmcodes.DataSource = db.tbl_LKP_Complaints_AdministrativeCodes.ToList();
                ddladmcodes.DataValueField = "Administrative_Code_ID";
                ddladmcodes.DataTextField = "TextArea";
                ddladmcodes.DataBind();
                //ddladmcodes.Items.Insert(0, new ListItem("--Select--", "-1"));

                //------------------------


                utilities objutilities = new utilities();


                
               // ddlNewHearingloc.Items.Insert(0, new ListItem("--Select--", "-1"));



               



                


          

                utilities.BindDropdown(ddlboardaction, 33);
              //  ddlboardaction.Items.Insert(0, new ListItem("--Select--", "-1"));


                utilities.BindDropdown(ddlchooseoffer, 43);
               // ddlchooseoffer.Items.Insert(0, new ListItem("--Select--", "-1"));

           


                utilities.BindDropdown(ddlresoultion, 32);
               // ddlresoultion.Items.Insert(0, new ListItem("--Select--", "-1"));
             

                utilities.BindDropdown(ddlviolations, 44);
           



                for (int i = 0; i < ddlviolations.Items.Count; i++)
                {
                    ListItem li = new ListItem(ddlviolations.Items[i].Text, ddlviolations.Items[i].Value);
                    //li.Attributes.Add("onclick", "javascript:addtextarea(this)");
                    chbvilation.Items.Add(li);

                }

                DropDownList drp = new DropDownList();
                utilities.BindDropdown(drp, 45);

             
                chbcourse.Items.Clear();

                for (int i = 0; i < drp.Items.Count; i++)
                {
                    ListItem li = new ListItem(drp.Items[i].Text, drp.Items[i].Value);
                    chbcourse.Items.Add(li);
                }


            }


        }


        #region Formal Hearing


        protected void btnhearingsubmit_Click(object sender, EventArgs e)
        {
            string time = "";
            if (rdblisttime.Items[0].Selected == true)
                time = "AM";
            else
                time = "PM";
            string hrs = ddlhearingHours.SelectedValue.ToString();
            if (hrs == "-1")
                hrs = "00";
            string mnts = ddlHearingMinutes.SelectedValue.ToString();
            if (mnts == "-1")
                mnts = "00";
            ComplaintsLink.Complaints.Complaint_FormalHearing_InsertValues(0, comid,Convert.ToInt32(Request.QueryString[1].ToString()), txthearingdate.Text, hrs + ":" + mnts + " " + time, chkrespondent.SelectedValue, chktbd.Checked, Convert.ToInt32(Session["UID"]),chksetteld.Checked,chkignore.Checked,txthcount.Text);
            altbox("Record inserted successfully.");
            ddlhearingHours.SelectedValue = "-1";
            ddlHearingMinutes.SelectedValue = "-1";
            txthcount.Text = "";
            chktbd.Checked = false;
            for (int i = 0; i < chkrespondent.Items.Count; i++)
            {
                chkrespondent.Items[i].Selected = false;
            }
            hfd_forhearing.Value = "0";
        }
        protected void btnhearingupdate_Click(object sender, EventArgs e)
        {
            string time = "";
            if (rdblisttime.Items[0].Selected == true)
                time = "AM";
            else
                time = "PM";
            string hrs = ddlhearingHours.SelectedValue.ToString();
            if (hrs == "-1")
                hrs = "00";
            string mnts = ddlHearingMinutes.SelectedValue.ToString();
            if (mnts == "-1")
                mnts = "00";
            ComplaintsLink.Complaints.Complaint_FormalHearing_InsertValues(Convert.ToInt32(hfd_forhearing.Value), comid,Convert.ToInt32(Request.QueryString[1].ToString()), txthearingdate.Text, hrs + ":" + mnts + " " + time, chkrespondent.SelectedValue, chktbd.Checked, Convert.ToInt32(Session["UID"]),chksetteld.Checked,chkignore.Checked,txthcount.Text);
            altbox("Record updated successfully.");
            ddlhearingHours.SelectedValue = "-1";
            ddlHearingMinutes.SelectedValue = "-1";
            chktbd.Checked = false;
            for (int i = 0; i < chkrespondent.Items.Count; i++)
            {
                chkrespondent.Items[i].Selected = false;
            }
            hfd_forhearing.Value = "0";
        }
        private void altbox(string str)
        {
            string js = " afterpost('" + str + "');";
            ScriptManager.RegisterStartupScript(Page, GetType(), "scr", js, true);
        }
        protected void btnhearingdelete_Click(object sender, EventArgs e)
        {
            ComplaintsLink.Complaints.Delete_ComplaintsFormalHearing(Convert.ToInt32(hfd_forhearing.Value));
            altbox("Record deleted successfully");
            hfd_forhearing.Value = "0";
        }

        #endregion

        #region COMPLAINT RESOLUTION & ACTION

        protected void btnresolutionsubmit_Click(object sender, EventArgs e)
        {
            ComplaintsLink.TbL_Complaints_Resolution obj = new ComplaintsLink.TbL_Complaints_Resolution();

            try
            {

                obj.Resolution_ID = 0;
                obj.Cmp_ID = comid;
                obj.Person_ID = hfd_pid.Value;
                obj.Resoutions = Convert.ToInt16(ddlresoultion.SelectedValue);
                obj.DateofResolution = Convert.ToDateTime(txtdateresolution.Text);
                obj.BoardAction = Convert.ToInt16(ddlboardaction.SelectedValue);
                if (txtdateaction.Text != "")
                    obj.DateofAction = Convert.ToDateTime(txtdateaction.Text);

                obj.ModifiedBy = Convert.ToInt32(Session["UID"].ToString());
                obj.ModifiedDate = DateTime.Now;//.ToString("MM/dd/yyyy");
                int k = ComplaintsLink.Complaints.Complaint_Resolution_InsertValues(obj, 101);
                string js = " altbox('Record added successfully.');";
                ScriptManager.RegisterStartupScript(Page, GetType(), "scr", js, true);
                ddlresoultion.SelectedIndex = 0;
                txtdateresolution.Text = "";
                ddlboardaction.SelectedIndex = 0;
                txtdateaction.Text = "";
            }
            catch
            {

            }

            bind_resolution();
        }

        protected void btnresolutionupdate_Click(object sender, EventArgs e)
        {
            using (ComplaintsLink.ComplaintsDataContext cdc = new ComplaintsLink.ComplaintsDataContext())
            {
                ComplaintsLink.TbL_Complaints_Resolution obj = new ComplaintsLink.TbL_Complaints_Resolution();

                try
                {

                    obj.Resolution_ID = Convert.ToInt16(hfd_resolution.Value.ToString());
                    obj.Cmp_ID = comid;
                    obj.Person_ID = hfd_pid.Value;
                    obj = cdc.TbL_Complaints_Resolutions.Where(c => c.Resolution_ID == Convert.ToInt32(hfd_resolution.Value)).SingleOrDefault();
                    if (obj.Resoutions != Convert.ToInt32(ddlresoultion.SelectedValue) || obj.DateofResolution != Convert.ToDateTime(txtdateresolution.Text))
                    {

                        ComplaintsLink.tbl_Complaints_Resolution_History cmpreshistory = new ComplaintsLink.tbl_Complaints_Resolution_History();
                        cmpreshistory.Resolution_ID = Convert.ToInt32(hfd_resolution.Value);
                        cmpreshistory.Cmp_ID = comid;
                        cmpreshistory.Person_ID = hfd_pid.Value;
                        cmpreshistory.Old_Resolutions = ddlresoultion.SelectedValue;
                        if (txtdateresolution.Text == "")
                            cmpreshistory.Old_Date_Of_Resolution = null;
                        else
                            cmpreshistory.Old_Date_Of_Resolution = Convert.ToDateTime(txtdateresolution.Text);
                        cmpreshistory.Old_BoardAction = ddlboardaction.SelectedValue;
                        if (txtdateaction.Text != "")
                            cmpreshistory.Old_BoardAction_Date = Convert.ToDateTime(txtdateaction.Text);
                        cmpreshistory.Created_By = Session["UID"].ToString();
                        cmpreshistory.Created_Date = Convert.ToDateTime(DateTime.Now.ToShortDateString());
                        cdc.tbl_Complaints_Resolution_Histories.InsertOnSubmit(cmpreshistory);
                        cdc.SubmitChanges();


                    }
                    obj.Resoutions = Convert.ToInt16(ddlresoultion.SelectedValue);
                    if (txtdateresolution.Text == "")
                        obj.DateofResolution = Convert.ToDateTime("01/01/1900");
                    else
                        obj.DateofResolution = Convert.ToDateTime(txtdateresolution.Text);
                    obj.BoardAction = Convert.ToInt16(ddlboardaction.SelectedValue);
                    if (txtdateaction.Text != "")
                        obj.DateofAction = Convert.ToDateTime(txtdateaction.Text);
                    obj.ModifiedBy = Convert.ToInt32(Session["UID"].ToString());
                    obj.ModifiedDate = DateTime.Now;//.ToString("MM/dd/yyyy");

                    int k = ComplaintsLink.Complaints.Complaint_Resolution_InsertValues(obj, 102);
                    string js = " altbox('Record updated successfully.');";
                    ScriptManager.RegisterStartupScript(Page, GetType(), "scr", js, true);
                    ddlresoultion.SelectedIndex = 0;
                    txtdateresolution.Text = "";
                    ddlboardaction.SelectedIndex = 0;
                    txtdateaction.Text = "";
                }
                catch
                {

                }
            }


            bind_resolution();

        }

        public void bind_resolution()
        {
            using (ComplaintsLink.ComplaintsDataContext db = new ComplaintsLink.ComplaintsDataContext())
            {
                var obj = db.TbL_Complaints_Resolutions.Where(i => i.Cmp_ID == comid && i.Person_ID == Request.QueryString["pid"].ToString()).FirstOrDefault();
                //var obj = db.USP_Complaint_GetFindingOfFacts(comid);

                var k = db.TbL_Complaints_Resolutions.Where(i => i.Cmp_ID == comid && i.Person_ID == Request.QueryString["pid"].ToString()).ToList();

                if (k.Count > 0)
                {
                    if (obj.Resoutions.ToString() == "-1")
                        lbl_GetResolution.Text = "";
                    else
                        lbl_GetResolution.Text = ddlresoultion.Items.FindByValue(obj.Resoutions.ToString()).Text;// obj.Resoutions.ToString();

                    string boardofaction = obj.BoardAction.ToString();
                    if (boardofaction != "-1")
                        lbl_getboardaction.Text = ddlboardaction.Items.FindByValue(obj.BoardAction.ToString()).Text;
                    else
                        lbl_getboardaction.Text = "";

                    if (Convert.ToDateTime(obj.DateofResolution).ToString("MM/dd/yyyy") == Convert.ToDateTime("01/01/1900").ToString("MM/dd/yyyy"))
                        lbl_Getresolutiondate.Text = "";
                    else
                        lbl_Getresolutiondate.Text = filter_date(Convert.ToString(obj.DateofResolution));

                    string dateofaction = obj.DateofAction.ToString();
                    if (dateofaction != "01/01/1900 12:00:00" && dateofaction != "01/01/0001 12:00:00" && dateofaction != "" && dateofaction != null && dateofaction != "01/01/1900" && dateofaction != "01/01/0001")
                    {
                        lbl_getboardactionDate.Text = filter_date(dateofaction);
                    }
                    else
                    {
                        lbl_getboardactionDate.Text = "";
                    }

                    hfd_resolution.Value = obj.Resolution_ID.ToString();

                    ddlresoultion.ClearSelection();
                    ddlboardaction.ClearSelection();

                    ddlresoultion.SelectedValue = obj.Resoutions.ToString();
                    ddlboardaction.SelectedValue = obj.BoardAction.ToString();
                    if (Convert.ToDateTime(obj.DateofResolution).ToString("MM/dd/yyyy") == Convert.ToDateTime("01/01/1900").ToString("MM/dd/yyyy"))
                        txtdateresolution.Text = "";
                    else
                        txtdateresolution.Text = filter_date(Convert.ToString(obj.DateofResolution));
                    string dateaction = obj.DateofAction.ToString();
                    if (dateofaction != "01/01/1900 12:00:00" && dateofaction != "01/01/0001 12:00:00" && dateofaction != "" && dateofaction != null && dateofaction != "01/01/1900" && dateofaction != "01/01/0001")
                    {
                        txtdateaction.Text = filter_date(dateofaction);
                    }
                    else
                    {
                        txtdateaction.Text = "";
                    }
                    // txtdateaction.Text = filter_date(Convert.ToString(obj.DateofAction));

                    btnresolutionsubmit.Visible = false;
                    btnresolutionupdate.Visible = true;
                }
                else
                {
                    btnresolutionsubmit.Visible = true;
                    btnresolutionupdate.Visible = false;
                }

            }

        }


        #endregion





        protected void ddladministrationcode_SelectedIndexChanged(object sender, EventArgs e)
        {


        }



        #region Voilation

        public void bind_violation()
        {
            // grdviolation.DataSource = ComplaintsLink.Complaints.getComplaint_Violation(comid);
            //grdviolation.DataBind();

        }

        protected void btnviolationsubmit_Click(object sender, EventArgs e)
        {


            ComplaintsLink.TbL_Complaints_Violation obj = new ComplaintsLink.TbL_Complaints_Violation();

            try
            {

                foreach (ListItem li in chbvilation.Items)
                {
                    if (li.Selected == true)
                    {

                        obj.Violation_ID = 0;
                        obj.Cmp_ID = comid;
                        obj.Violations = Convert.ToInt16(li.Value);
                        obj.DateAdded = Convert.ToDateTime(DateTime.Now.ToShortDateString());//.ToString("MM/dd/yyyy");
                        obj.EnteredBy = Session["UID"].ToString();
                        obj.ModifiedBy = Convert.ToInt32(Session["UID"].ToString());
                        obj.ModifiedDate = Convert.ToDateTime(DateTime.Now.ToShortDateString());//.ToString("MM/dd/yyyy");
                        if (chk_publicinfo.Checked == true)
                        {
                            obj.Public_Info = "True";
                        }
                        else
                            obj.Public_Info = "False";

                        int k = ComplaintsLink.Complaints.Complaint_Violation_InsertValues(obj, 101);
                        li.Selected = false;
                    }
                }




            }

            catch
            {

            }






        }
        protected void btnviolationupdate_Click(object sender, EventArgs e)
        {


            ComplaintsLink.TbL_Complaints_Violation obj = new ComplaintsLink.TbL_Complaints_Violation();

            try
            {

                obj.Violation_ID = Convert.ToInt16(hfd_violation.Value.ToString());
                obj.Cmp_ID = comid;
                obj.Violations = Convert.ToInt16(ddlviolations.SelectedValue);
                obj.DateAdded = Convert.ToDateTime(DateTime.Now.ToShortDateString());
                // obj.EnteredBy = "Admin";
                obj.ModifiedBy = Convert.ToInt32(Session["UID"].ToString());
                obj.ModifiedDate = DateTime.Now;//.ToString("MM/dd/yyyy");
                if (chk_publicinfo.Checked == true)
                {
                    obj.Public_Info = "True";
                }
                else
                    obj.Public_Info = "False";

                int k = ComplaintsLink.Complaints.Complaint_Violation_InsertValues(obj, 102);




            }

            catch
            {

            }


        }

        protected void grdviolation_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            // grdviolation.PageIndex = e.NewPageIndex;
            //bind_violation();
        }



        #endregion





        #region Consent Order


        public void bind_consentoffer()
        {
           // grdconsentoffer.DataSource = ComplaintsLink.Complaints.getComplaint_ConsentOffer(comid);
            //grdconsentoffer.DataBind();

          


        }

        protected void grdconsentoffer_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
           // grdconsentoffer.PageIndex = e.NewPageIndex;
           // bind_consentoffer();
        }
        protected void btnconsentsubmit_Click(object sender, EventArgs e)
        {
            ComplaintsLink.Tbl_Complaints_ConsentOffer obj = new ComplaintsLink.Tbl_Complaints_ConsentOffer();


            try
            {

                obj.ConsentOffer_ID = 0;
                obj.Cmp_Id = comid;
                obj.ChooseOffer = ddlchooseoffer.SelectedValue.ToString();
                obj.FineAmount = txtfineAmount.Text;

                if (chkprobation.Checked == true)
                {
                    obj.IsProationTillCondition = true;
                    obj.ProbationLength = "";
                }
                else
                {
                    obj.IsProationTillCondition = false;
                    obj.ProbationLength = txtprobationdays.Text;
                }

                if (chksuspension.Checked == true)
                {
                    obj.IsSuspensionTillCondition = true;
                    obj.SuspensionLength = "";
                }
                else
                {
                    obj.IsSuspensionTillCondition = false;

                    obj.SuspensionLength = txtsuspensiondays.Text;
                }
                obj.Offer_date = txtoffdate.Text;
                obj.Due_date = txtduedate.Text;
                string temp = "";
                for (int i = 0; i < chbcourse.Items.Count; i++)
                {
                    if (chbcourse.Items[i].Selected == true)
                        temp += chbcourse.Items[i].Value + ",";
                }
                if (temp != "")
                    obj.SelectCourses = temp.Substring(0, temp.Length - 1);
                else
                    obj.SelectCourses = "";
                obj.modifiedby = 2;//
                obj.modifieddate = DateTime.Now;//.ToString("MM/dd/yyyy");

                int k = ComplaintsLink.Complaints.Complaint_ConsentOffer_InsertValues(obj, 101);

                bind_consentoffer();
            }
            catch
            {

            }

        }
        protected void btnconsentsupdate_Click(object sender, EventArgs e)
        {
            ComplaintsLink.Tbl_Complaints_ConsentOffer obj = new ComplaintsLink.Tbl_Complaints_ConsentOffer();


            try
            {



                obj.ConsentOffer_ID = Convert.ToInt16(hfd_consent.Value.ToString());
                obj.Cmp_Id = comid;
                obj.ChooseOffer = ddlchooseoffer.SelectedValue.ToString();
                obj.FineAmount = txtfineAmount.Text;


                if (chkprobation.Checked == true)
                {
                    obj.IsProationTillCondition = true;
                    obj.ProbationLength = "";
                }
                else
                {
                    obj.IsProationTillCondition = false;
                    obj.ProbationLength = txtprobationdays.Text;
                }

                if (chksuspension.Checked == true)
                {
                    obj.IsSuspensionTillCondition = true;
                    obj.SuspensionLength = "";
                }
                else
                {
                    obj.IsSuspensionTillCondition = false;

                    obj.SuspensionLength = txtsuspensiondays.Text;
                }
                obj.Offer_date = txtoffdate.Text;
                obj.Due_date = txtduedate.Text;
                string temp = "";
                for (int i = 0; i < chbcourse.Items.Count; i++)
                {
                    if (chbcourse.Items[i].Selected == true)
                        temp += chbcourse.Items[i].Value + ",";
                }
                if (temp != "")
                    obj.SelectCourses = temp.Substring(0, temp.Length - 1);
                else
                    obj.SelectCourses = "";
                obj.modifiedby = 2;//
                obj.modifieddate = DateTime.Now;//.ToString("MM/dd/yyyy");

                int k = ComplaintsLink.Complaints.Complaint_ConsentOffer_InsertValues(obj, 102);

                bind_consentoffer();
            }
            catch
            {

            }
        }


        #endregion


        #region Finding of Facts
        protected void btnfindingfacts_Click(object sender, EventArgs e)
        {



            ComplaintsLink.TbL_Complaints_FindingOfFact obj = new ComplaintsLink.TbL_Complaints_FindingOfFact();


            try
            {

                obj.Cmp_FindfactsId = Convert.ToInt16(lblfactid.Text);
                obj.FindingOfFact = txtfindingoffacts.Text;
                obj.Cmpid = comid;

                obj.CreateUser = 2;
                obj.CreatedDate = DateTime.Now;// ToString("MM/dd/yyyy");



                if (lblfactid.Text == "0")
                {
                    int i = ComplaintsLink.Complaints.Complaint_FindingOfFacts_InsertValues(obj, 101);
                }

                else
                {
                    int j = ComplaintsLink.Complaints.Complaint_FindingOfFacts_InsertValues(obj, 102);
                }

                Bind_Facts();
            }
            catch
            {

            }





        }

        public void Bind_Facts()
        {
            using (ComplaintsLink.ComplaintsDataContext db = new ComplaintsLink.ComplaintsDataContext())
            {


                //var obj = db.USP_Complaint_GetFindingOfFacts(comid);

                System.Data.Linq.ISingleResult<ComplaintsLink.USP_Complaint_GetFindingOfFactsResult> result = db.USP_Complaint_GetFindingOfFacts(comid);

                foreach (ComplaintsLink.USP_Complaint_GetFindingOfFactsResult li in result)
                {

                    lblfactid.Text = li.Cmp_FindfactsId.ToString();
                    txtfindingoffacts.Text = li.FindingOfFact.ToString();

                }


            }

        }
        protected void btnfindingfactscancel_Click(object sender, EventArgs e)
        {

            txtfindingoffacts.Text = "";

        }



        #endregion


        #region Conclusion of Law

        protected void btn_conclusion_Click(object sender, EventArgs e)
        {


            ComplaintsLink.TbL_Complaints_ConclusionOfLaw obj = new ComplaintsLink.TbL_Complaints_ConclusionOfLaw();

            obj.ConclusionLaw_Id = Convert.ToInt16(hfdconlaw.Value);
            obj.Cmp_Id = comid.ToString();
            string temp = "";
            for (int i = 0; i < chk_administarativecode.Items.Count; i++)
            {
                if (chk_administarativecode.Items[i].Selected == true)
                    temp += chk_administarativecode.Items[i].Value + ",";
            }
            if (temp != "")
                obj.ConclusionLawcode = temp.Substring(0, temp.Length - 1);
            else
                obj.ConclusionLawcode = "";

            obj.ConclusionText = txtsummaryconclusionoflaw.Text;
            obj.ModifiedBy = 2;
            obj.ModifiedDate = DateTime.Now;// ToString("MM/dd/yyyy");



            if (hfdconlaw.Value == "0")
            {
                int i = ComplaintsLink.Complaints.Complaint_ConclusionOfLaw_InsertValues(obj, 101);
            }

            else
            {
                int j = ComplaintsLink.Complaints.Complaint_ConclusionOfLaw_InsertValues(obj, 102);
            }



            Bindconlaw();



        }

        protected void btn_conlawclear(object sender, EventArgs e)
        {
            foreach (ListItem li in chk_administarativecode.Items)
                li.Selected = false;
            txtsummaryconclusionoflaw.Text = "";
            //ModalPopupExtender5.Show();
        }

        private void Bindconlaw()
        {

            using (ComplaintsLink.ComplaintsDataContext db = new ComplaintsLink.ComplaintsDataContext())
            {


                var obj = db.TbL_Complaints_ConclusionOfLaws.Where(i => i.Cmp_Id == comid.ToString()).SingleOrDefault();
                //var obj = db.USP_Complaint_GetFindingOfFacts(comid);

                System.Data.Linq.ISingleResult<ComplaintsLink.USP_Complaint_GetFindingOfFactsResult> result = db.USP_Complaint_GetFindingOfFacts(comid);

               

                chk_administarativecode.ClearSelection();



                foreach (ListItem lin in chk_administarativecode.Items)
                {

                    lin.Attributes.Add("onclick", "javascript:addtextarea(this)");
                }


                if (obj != null)
                {

                    hfdconlaw.Value = obj.ConclusionLaw_Id.ToString();

                    string[] temp = obj.ConclusionLawcode.Split(',');
                    txtsummaryconclusionoflaw.Text = obj.ConclusionText;


                    //for (int i = 0; i < temp.Length; i++)
                   // {

                        //chk_administarativecode.Items.FindByValue(temp[i].ToString()).Selected = true;
                        // chk_administarativecode.Items.FindByValue(temp[i].ToString()).Attributes.Add("onclick", "javascript:addtextarea(this)");

                        // chk_administarativecode.Items[Convert.ToInt16(temp[i].ToString())].Selected = true;

                  //  }

                }



            }

        }

        #endregion




        private void Bind_drp(DropDownList ddl, string tname, string cols, string con)
        {

        }
        private void Init_bind()
        {

        }
        protected void btndescSubmit_Click(object sender, EventArgs e)
        {

        }


        protected void btnjornalok_Click(object sender, EventArgs e)
        {

        }

        protected void btnupdatejournal_Click(object sender, EventArgs e)
        {


        }




        protected void btnadmincodesave_click(object sender, EventArgs e)
        {

        }






























    }
}