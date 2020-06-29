using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;

namespace Licensing.Complaints
{
    public partial class ComplaintGeneral : System.Web.UI.Page
    {



        int comid = 0;
        int partid = 0;


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                hfdcomid.Value = Request.QueryString[0].ToString();


                btnaddpartnew.Attributes.Add("onClick", "return open_NewAddPerson(" + hfdcomid.Value + ");");
                
            }
            comid = Convert.ToInt32(hfdcomid.Value);
            partid = Convert.ToInt32(hfdpartid.Value);
           
            //hdnevents

            if (!IsPostBack)
            {
               BindDrpDownLists();
              

              // bind_participant();
               //  bind_service();
              // bind_attorney();
                // bind_events();
               //  Bind_Journal();

              //  Bind_Companioncases();
       

      




            }

        }





        public void BindDrpDownLists()
        {

            using (ComplaintsLink.ComplaintsDataContext db = new ComplaintsLink.ComplaintsDataContext())
            {


                //ddlrequester.DataSource = db.tbl_lkp_Complaints_requestors.ToList();//id=51
                //ddlrequester.DataValueField = "reques_id";
                //ddlrequester.DataTextField = "Description";
                //ddlrequester.DataBind();
                //ddlrequester.Items.Insert(0, new ListItem("--Select--", "-1"));

               
                utilities.BindDropdown(ddlrequester, 51);

                //ddlparticipantRole.DataSource = db.tbl_lkp_participant_roles.ToList();//id=46
                //ddlparticipantRole.DataValueField = "Role_ID";
                //ddlparticipantRole.DataTextField = "Description";
                //ddlparticipantRole.DataBind();
                //ddlparticipantRole.Items.Insert(0, new ListItem("--Select--", "-1"));

                


                //ddlservicecountry.DataSource = db.tbl_LKP_Counties.ToList();//id=6
                //ddlservicecountry.DataValueField = "County";
                //ddlservicecountry.DataTextField = "County";
                //ddlservicecountry.DataBind();
                //ddlservicecountry.Items.Insert(0, new ListItem("Select County", "-1"));

                utilities.BindDropdown(ddlservicecountry, 6);


                //ddlJournalType.DataSource = db.tbl_Lkp_Complaints_JournalTypes.OrderBy(c => c.Description).ToList();//id=3
                //ddlJournalType.DataValueField = "Journal_Type_Id";
                //ddlJournalType.DataTextField = "Description";
                //ddlJournalType.DataBind();
                //ddlJournalType.Items.Insert(0, new ListItem("Select Journal", "-1"));

                utilities.BindDropdown(ddlJournalType, 6);


                //ddlserdocument.DataSource = db.tbl_LKP_ServiceDocumentTypes.OrderBy(c => c.ServiceDocumentType).ToList();//id 47
                //ddlserdocument.DataValueField = "ServDocTypeId";
                //ddlserdocument.DataTextField = "ServiceDocumentType";
                //ddlserdocument.DataBind();
                //ddlserdocument.Items.Insert(0, new ListItem("--Select--", "-1"));

                utilities.BindDropdown(ddlserdocument, 47);

                //ddlserdocument.DataSource = db.tbl_LKP_Complaints_ServiceReasons.OrderBy(c => c.ser).ToList();

                //ddlservicetype.DataSource = db.tbl_LKP_Complaints_ServiceTypes.ToList();//id 48
                //ddlservicetype.DataValueField = "CmpServiceType";
                //ddlservicetype.DataTextField = "ServiceType";
                //ddlservicetype.DataBind();
                //ddlservicetype.Items.Insert(0, new ListItem("Select Service Type", "-1"));

                utilities.BindDropdown(ddlservicetype, 48);

                //ddlservicereason.DataSource = db.tbl_LKP_Complaints_ServiceReasons.ToList();//id =49 
                //ddlservicereason.DataValueField = "ServiceReasonId";
                //ddlservicereason.DataTextField = "ServiceReason";
                //ddlservicereason.DataBind();
                //ddlservicereason.Items.Insert(0, new ListItem("Select Service Reason", "-1"));

                utilities.BindDropdown(ddlservicereason, 49);

                //ddleventtype.DataSource = db.tbl_LKPEventTypes.ToList();//id=50
                //ddleventtype.DataValueField = "EventType_ID";
                //ddleventtype.DataTextField = "EventType";
                //ddleventtype.DataBind();
                //ddleventtype.Items.Insert(0, new ListItem("Select EventType", "-1"));

                utilities.BindDropdown(ddleventtype, 50);

                ddleventresponseperson.DataSource = db.Tbl_Logins.ToList();
                ddleventresponseperson.DataTextField = "FirstName";
                ddleventresponseperson.DataValueField = "LastName";
                ddleventresponseperson.DataBind();

              

                string[] Name = new string[ddleventresponseperson.Items.Count];


                for (int i = 0; i <= ddleventresponseperson.Items.Count - 1; i++)
                {

                    Name[i] = ddleventresponseperson.Items[i].Text + " " + ddleventresponseperson.Items[i].Value;

                    // Name[i].Insert(i, ddleventresponseperson.Items[i].Text + " " + ddleventresponseperson.Items[i].Value);

                }

                for (int i = 0; i <= ddleventresponseperson.Items.Count - 1; i++)
                {

                    ddleventresponseperson.Items[i].Text = Name[i].ToString();

                }

                ddleventresponseperson.Items.Clear();
                ddleventresponseperson.DataSource = db.Tbl_Logins.ToList();

                ddleventresponseperson.DataTextField = "FirstName";
                ddleventresponseperson.DataValueField = "loginID";
                ddleventresponseperson.DataBind();

                for (int i = 0; i <= ddleventresponseperson.Items.Count - 1; i++)
                {

                    ddleventresponseperson.Items[i].Text = Name[i].ToString();

                }


                ddleventresponseperson.Items.Insert(0, new ListItem("Select Responsible Person", "-1"));


            }


        }


        #region General Section


       
       


        protected void grdParticipateGeneral_RowEditing(object sender, GridViewEditEventArgs e)
        {
           

        }

        protected void grdParticipateGeneral_Rowbound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
               

            }
        }
        protected void grdParticipateGeneral_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
           // grdParticipateGeneral.PageIndex = e.NewPageIndex;
           // bind_participant();
        }



        public void bind_participant()
        {

                  
            //grdParticipateGeneral.DataSource = ComplaintsLink.Complaints.getComplaint_Participant(comid); 
           // grdParticipateGeneral.DataBind();
        }

        public void bind_service()
        {
          
           // grdparticipantservice.DataSource = ComplaintsLink.Complaints.getComplaint_Service(comid,partid);
           // grdparticipantservice.DataBind();
        }

        public void bind_attorney()
        {

          //  grdAttorney.DataSource = ComplaintsLink.Complaints.getComplaint_Attorney(comid, partid);
          //  grdAttorney.DataBind();
        }

        public void bind_events()
        {
           
            //grdCompEvents.DataSource = ComplaintsLink.Complaints.getComplaint_Events(comid, partid);
            //grdCompEvents.DataBind();

        }






       



        #endregion


        #region Service Section

        protected void grdparticipantservice_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
           
        }

        protected void btnservicesubmit_Click(object sender, EventArgs e)
        {

            ComplaintsLink.TbL_Complaints_Service obj = new ComplaintsLink.TbL_Complaints_Service();
           
            obj.Cmp_Service_Id = 0;
            obj.Complaint_Id = comid;
            obj.Cmp_Paticipant_Id = partid;// hfdselarid.Value;
            obj.DocumentType = ddlserdocument.SelectedValue.ToString();
            obj.Service_Type_ID = ddlservicetype.SelectedValue.ToString();
            //if (rbleffectuated.SelectedValue.ToString() == "0")
            //{
            //    obj.Iseffectuated1 = "0";
            //}
            //else
            //{
            //    obj.Iseffectuated1 = "1";
            //}
            obj.Is_Effectuated = rbleffectuated.SelectedValue.ToString();


            if (txtnoticedate.Text.Length > 0)
            {

                obj.NoticeDate = Convert.ToDateTime(txtnoticedate.Text);
            }
            if (txtserveddate.Text.Length > 0)
            {

                obj.ServedDate = Convert.ToDateTime(txtserveddate.Text);
            }
            if (txtdeliverydate.Text.Length > 0)
            {

                obj.DeliveryDate = Convert.ToDateTime(txtdeliverydate.Text);
            }
            if (txtreturndate.Text.Length > 0)
            {

                obj.ReturnDate = Convert.ToDateTime(txtreturndate.Text);
            }
            if (txtsingleattempteddate.Text.Length > 0)
            {

                obj.AttemptedDate = Convert.ToDateTime(txtsingleattempteddate.Text);
            }

            obj.Reason = ddlservicereason.SelectedValue.ToString();
            obj.Comments = txtservicecomments.Text;
            obj.County = ddlservicecountry.SelectedValue.ToString();
            obj.TrackingNo = txttracking.Text;
            obj.Requester = ddlrequester.SelectedValue.ToString();
            obj.Mailnumber = txtcetifiedmailnumber.Text;
            if (txtDateMailed.Text.Length > 0)
            {

                obj.MailedDate = Convert.ToDateTime(txtDateMailed.Text);
            }
            if (chknotsatis.Checked == true)
                obj.NotSatisfied = "Yes";
            else
                obj.NotSatisfied = "No";
            if (chkundeliverable.Checked == true)
                obj.Undeliverable = "Yes";
            else
                obj.Undeliverable = "No";

            obj.Is_Service_Archieved = rdbservicearchieved.SelectedValue.ToString();
            obj.Is_Service_Delivered = rdbdelivered.SelectedValue.ToString();
            if (chkservicesatified.Checked == true)
                obj.Service_Satisfied = "Yes";
            else
                obj.Service_Satisfied = "No";

            obj.ModifiedBy = 2;// Session["UID"].ToString();

            obj.ModifiedDate = DateTime.Now;//.ToString("MM/dd/yyyy");

          

            int k = ComplaintsLink.Complaints.Complaint_Service_InsertValues(obj);

             ComplaintsLink.TbL_Complaints_Service_AttemptedDate obj1 = new ComplaintsLink.TbL_Complaints_Service_AttemptedDate();

            for (int i = 0; i < ddlattempteddate.Items.Count; i++)
            {

                obj1.Cmp_Attempdate_Id = 0;
                obj1.Cmp_Service_Id = k;
                obj1.Complaint_Id = comid;
                obj1.AttemptedDate = Convert.ToDateTime( ddlattempteddate.Items[i].Value.ToString());
                obj1.Is_default = true;

                obj1.Create_User = 2;// Session["UID"].ToString();
                obj1.Create_Date = DateTime.Now;//

                int j = ComplaintsLink.Complaints.Complaint_ServiceAttemptedDate_InsertValues(obj1);
            }




          

           // bind_service();




           
        }

        protected void btnservicesupdate_Click(object sender, EventArgs e)
        {



            ComplaintsLink.TbL_Complaints_Service obj = new ComplaintsLink.TbL_Complaints_Service();

            obj.Cmp_Service_Id = Convert.ToInt16(hfd_service.Value.ToString());


            obj.Complaint_Id = comid;
            obj.Cmp_Paticipant_Id = partid;// hfdselarid.Value;
            obj.DocumentType = ddlserdocument.SelectedValue.ToString();
            obj.Service_Type_ID = ddlservicetype.SelectedValue.ToString();
            //if (rbleffectuated.SelectedValue.ToString() == "0")
            //{
            //    obj.Iseffectuated1 = "0";
            //}
            //else
            //{
            //    obj.Iseffectuated1 = "1";
            //}
            obj.Is_Effectuated = rbleffectuated.SelectedValue.ToString();
            if (txtnoticedate.Text.Length > 0)
            {

                obj.NoticeDate = Convert.ToDateTime(txtnoticedate.Text);
            }
            if (txtserveddate.Text.Length > 0)
            {

                obj.ServedDate = Convert.ToDateTime(txtserveddate.Text);
            }
            if (txtdeliverydate.Text.Length > 0)
            {

                obj.DeliveryDate = Convert.ToDateTime(txtdeliverydate.Text);
            }
            if (txtreturndate.Text.Length > 0)
            {

                obj.ReturnDate = Convert.ToDateTime(txtreturndate.Text);
            }
            if (txtsingleattempteddate.Text.Length > 0)
            {

                obj.AttemptedDate = Convert.ToDateTime(txtsingleattempteddate.Text);
            }

            obj.Reason = ddlservicereason.SelectedValue.ToString();
            obj.Comments = txtservicecomments.Text;
            obj.County = ddlservicecountry.SelectedValue.ToString();
            obj.TrackingNo = txttracking.Text;
            obj.Requester = ddlrequester.SelectedValue.ToString();
            obj.Mailnumber = txtcetifiedmailnumber.Text;
            if (txtDateMailed.Text.Length > 0)
            {

                obj.MailedDate = Convert.ToDateTime(txtDateMailed.Text);
            }
            if (chknotsatis.Checked == true)
                obj.NotSatisfied = "Yes";
            else
                obj.NotSatisfied = "No";
            if (chkundeliverable.Checked == true)
                obj.Undeliverable = "Yes";
            else
                obj.Undeliverable = "No";

            obj.Is_Service_Archieved = rdbservicearchieved.SelectedValue.ToString();
            obj.Is_Service_Delivered = rdbdelivered.SelectedValue.ToString();
            if (chkservicesatified.Checked == true)
                obj.Service_Satisfied = "Yes";
            else
                obj.Service_Satisfied = "No";

            obj.ModifiedBy = 2;// Session["UID"].ToString();

            obj.ModifiedDate = DateTime.Now;//.ToString("MM/dd/yyyy");



            int k = ComplaintsLink.Complaints.Complaint_Service_InsertValues(obj);

            ComplaintsLink.TbL_Complaints_Service_AttemptedDate obj1 = new ComplaintsLink.TbL_Complaints_Service_AttemptedDate();

            for (int i = 0; i < ddlattempteddate.Items.Count; i++)
            {

                obj1.Cmp_Attempdate_Id = 0;
                obj1.Cmp_Service_Id = Convert.ToInt16(hfd_service.Value.ToString());
                obj1.Complaint_Id = comid;
                obj1.AttemptedDate = Convert.ToDateTime(ddlattempteddate.Items[i].Value.ToString());
                obj1.Is_default = true;

                obj1.Create_User = 2;// Session["UID"].ToString();
                obj1.Create_Date = DateTime.Now;//

                int j = ComplaintsLink.Complaints.Complaint_ServiceAttemptedDate_InsertValues(obj1);
            }






           // bind_service();



            
        }


        #endregion


        #region Attoreny


        protected void btnattorneysubmit_Click(object sender, EventArgs e)
        {
            ComplaintsLink.TbL_Complaints_Attorney obj = new ComplaintsLink.TbL_Complaints_Attorney();

            obj.cmp_ParticipantID = partid;
            obj.ComplaintId = comid;
            obj.ModifiedBy = 2;
            obj.ModifiedDate = System.DateTime.Now;
            obj.Status = ddlattorneystatus.SelectedValue.ToString(); ;
            obj.Name = txtattorneyname.Text.Trim();
            obj.State = txtattorneyState.Text.Trim();
            obj.City = txtattroneyCity.Text.Trim();
            obj.Address = txtattorneyAddress.Text.Trim();



          int i=  ComplaintsLink.Complaints.Complaint_Attorney_InsertValues(obj, 101);    
            


           // bind_attorney();
           





        }
        protected void btnattorneyupdate_Click(object sender, EventArgs e)
        {
            ComplaintsLink.TbL_Complaints_Attorney obj = new ComplaintsLink.TbL_Complaints_Attorney();

            obj.Cmp_Attoerney_Id = Convert.ToInt16(hfd_att.Value);
            obj.cmp_ParticipantID = partid;
            obj.ComplaintId = comid;
            obj.ModifiedBy = 2;
            obj.ModifiedDate = System.DateTime.Now;
            obj.Status = ddlattorneystatus.SelectedValue.ToString(); ;
            obj.Name = txtattorneyname.Text.Trim();
            obj.State = txtattorneyState.Text.Trim();
            obj.City = txtattroneyCity.Text.Trim();
            obj.Address = txtattorneyAddress.Text.Trim();



            int i = ComplaintsLink.Complaints.Complaint_Attorney_InsertValues(obj, 102);



           // bind_attorney();
           
        }

        protected void grdAttorney_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            //grdAttorney.PageIndex = e.NewPageIndex;
           // bind_attorney();
           
        }

        #endregion


        #region Events

        protected void grdCompEvents_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
           // grdCompEvents.PageIndex = e.NewPageIndex;
           // bind_events();
        }



        protected void btneventremove_Click(object sender, EventArgs e)
        {

            ComplaintsLink.TbL_Complaints_Event obj = new ComplaintsLink.TbL_Complaints_Event();
            obj.CompEventId = Convert.ToInt16(hdnevents.Value.ToString());
            //obj.Cmp_Id = 0;


            if (obj.CompEventId > 0)
            {
                int j = ComplaintsLink.Complaints.Complaint_Events_InsertValues(obj);
               // bind_events();
            }
        }


        protected void grdCompEvents_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            ComplaintsLink.TbL_Complaints_Event obj = new ComplaintsLink.TbL_Complaints_Event();
            obj.CompEventId = Convert.ToInt16(hdnevents.Value.ToString());
            //obj.Cmp_Id = 0;


            if (obj.CompEventId > 0)
            {
                int j = ComplaintsLink.Complaints.Complaint_Events_InsertValues(obj);
                //bind_events();
            }

        }

        protected void btnEventsInsert_Click(object sender, EventArgs e)
        {
            ComplaintsLink.TbL_Complaints_Event obj = new ComplaintsLink.TbL_Complaints_Event();


            string repids = "";
            foreach (ListItem li in chbeventresperson.Items)
            {
                if (li.Selected == true)
                {
                    repids += li.Value.ToString() + ",";
                    li.Selected = false;
                }
            }
           
            //repids = repids.Substring(0, repids.Length - 1);



            string time = "";
           // obj.Flag = "101";
            obj.CompEventId = 0;
            obj.Cmp_Id = comid;
            obj.EventDate = Convert.ToDateTime( txteventdate.Text);
            if (rdbevent.Items[0].Selected == true)
                time = "AM";
            else
                time = "PM";

            // string[] hrs = ddlhearingHours.SelectedItem.Text.ToString().Split(':');
            // string[] mnts = ddlHearingMinutes.SelectedItem.Text.ToString().Split('.');

            obj.EventTime = ddleventhrs.SelectedItem.Text.ToString() + ":" + ddleventmnts.SelectedItem.Text.ToString() + " " + time;
            obj.EventType = ddleventtype.SelectedValue.ToString();
            obj.EventResPerson = ddleventresponseperson.SelectedValue;// repids;


            if (rbtnEmailrem.SelectedIndex != null)
            {
                int str = rbtnEmailrem.SelectedIndex;
                obj.EventRem = rbtnEmailrem.Items[str].Text;
            }

            //string str = chkeventsemailrem.SelectedIndex.ToString();
            //if (str == "0")
            //    obj.EventRem = chkeventsemailrem.Items[0].Text;
            //else
            //    if (str == "1")
            //        obj.EventRem = chkeventsemailrem.Items[1].Text;
            //    else
            //        if (str == "2")
            //            obj.EventRem = chkeventsemailrem.Items[2].Text;
            //        else
            //            if (str == "3")
            //                obj.EventRem = chkeventsemailrem.Items[3].Text;



            obj.Comments = txtEventsComments.Text;

            obj.ModifiedBy = 2;// Session["UID"].ToString();

            obj.ModifiedDate = DateTime.Now;//.ToString("MM/dd/yyyy");

            obj.Participant_ID = partid;// hfdselarid.Value;

            int j = ComplaintsLink.Complaints.Complaint_Events_InsertValues(obj);

           // bind_events();

        }
        protected void btnEventsUpdate_Click(object sender, EventArgs e)
        {


            ComplaintsLink.TbL_Complaints_Event obj = new ComplaintsLink.TbL_Complaints_Event();


            string repids = "";
            foreach (ListItem li in chbeventresperson.Items)
            {
                if (li.Selected == true)
                {
                    repids += li.Value.ToString() + ",";
                    li.Selected = false;
                }
            }

           // repids = repids.Substring(0, repids.Length - 1);
            string time = "";
            // obj.Flag = "101";

            obj.CompEventId = Convert.ToInt16(hdnevents.Value.ToString());

            obj.Cmp_Id = comid;

            obj.EventDate = Convert.ToDateTime(txteventdate.Text);
            if (rdbevent.Items[0].Selected == true)
                time = "AM";
            else
                time = "PM";

            // string[] hrs = ddlhearingHours.SelectedItem.Text.ToString().Split(':');
            // string[] mnts = ddlHearingMinutes.SelectedItem.Text.ToString().Split('.');

            obj.EventTime = ddleventhrs.SelectedItem.Text.ToString() + ":" + ddleventmnts.SelectedItem.Text.ToString() + " " + time;
            obj.EventType = ddleventtype.SelectedValue.ToString();
            obj.EventResPerson = ddleventresponseperson.SelectedValue;// repids;



            if (rbtnEmailrem.SelectedIndex != null)
            {
                int str = rbtnEmailrem.SelectedIndex;
                obj.EventRem = rbtnEmailrem.Items[str].Text;
            }
         

            //if (str == "0")
            //    obj.EventRem = chkeventsemailrem.Items[0].Text;
            //else
            //    if (str == "1")
            //        obj.EventRem = chkeventsemailrem.Items[1].Text;
            //    else
            //        if (str == "2")
            //            obj.EventRem = chkeventsemailrem.Items[2].Text;
            //        else
            //            if (str == "3")
            //                obj.EventRem = chkeventsemailrem.Items[3].Text;


            obj.Comments = txtEventsComments.Text;

            obj.ModifiedBy = 2;// Session["UID"].ToString();

            obj.ModifiedDate = DateTime.Now;//.ToString("MM/dd/yyyy");

            obj.Participant_ID = partid;// hfdselarid.Value;

            int j = ComplaintsLink.Complaints.Complaint_Events_InsertValues(obj);

           // bind_events();
           
        }

        #endregion



        #region Journal Section
        protected void btnhfd_delparid_click(object sender, EventArgs e)
        {
            using (ComplaintsLink.ComplaintsDataContext cdb = new ComplaintsLink.ComplaintsDataContext())
            {
                ComplaintsLink.TbL_Complaints_Participant obj = cdb.TbL_Complaints_Participants.Where(c => c.Cmp_Paticipant_ID == Convert.ToInt32(hfd_delparid.Value)).SingleOrDefault();
                cdb.TbL_Complaints_Participants.DeleteOnSubmit(obj);
                cdb.SubmitChanges();
            }
            Page.RegisterStartupScript("js", "<script>altbox('Record deleted successfully.');parent.sa5.process()</script>");
        }
        protected void btnjornalok_Click(object sender, EventArgs e)
        {


            ComplaintsLink.TbL_Complaints_Journal obj = new ComplaintsLink.TbL_Complaints_Journal();        

            obj.Journal_ID=0;
            obj.Cmp_ID = comid;
            obj.participantId = partid;
            obj.JournalType = ddlJournalType.SelectedValue;
            obj.Comments = txtjournaltype.Text.Trim();
            obj.ModifiedBy=Convert.ToInt32(Session["UID"].ToString());
            obj.ModifiedDate = System.DateTime.Now;

            int i = ComplaintsLink.Complaints.Complaint_Journal_InsertValues(obj,101);
           // Bind_Journal();

        }


        protected void btnupdatejournal_Click(object sender, EventArgs e)
        {
            ComplaintsLink.TbL_Complaints_Journal obj = new ComplaintsLink.TbL_Complaints_Journal();

            obj.Journal_ID = Convert.ToInt16(hfd_jouid.Value);
            obj.Cmp_ID = comid;
            obj.participantId = partid;
            obj.JournalType = ddlJournalType.SelectedValue;
            obj.Comments = txtjournaltype.Text.Trim();
            obj.ModifiedBy = Convert.ToInt32(Session["UID"].ToString());
            obj.ModifiedDate = System.DateTime.Now;

            int i = ComplaintsLink.Complaints.Complaint_Journal_InsertValues(obj, 102);
            Bind_Journal();

        }
        private void Bind_Journal()
        {

           // grdnursejournal.DataSource = ComplaintsLink.Complaints.getComplaint_Journals(comid, partid);
           // grdnursejournal.DataBind();
        }



        protected void grdnursejournal_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            //grdnursejournal.PageIndex = e.NewPageIndex;
            //Bind_Journal();
        }

        protected void grdnursejournal_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {

          

        }

        protected void btnJournalremove_Click(object sender, EventArgs e)
        {
            ComplaintsLink.TbL_Complaints_Journal obj = new ComplaintsLink.TbL_Complaints_Journal();

            obj.Journal_ID = Convert.ToInt16(hfd_jouid.Value);
            obj.Cmp_ID = comid;
            obj.participantId = partid;
            obj.JournalType = "1";//dummy value
            obj.Comments = txtjournaltype.Text.Trim();
            obj.ModifiedBy = 2;
            obj.ModifiedDate = System.DateTime.Now;

            int i = ComplaintsLink.Complaints.Complaint_Journal_InsertValues(obj, 103);
            //Bind_Journal();
        }






        #endregion

        #region Companion Cases

        protected void grdCompanionCases_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            //grdCompanionCases.PageIndex = e.NewPageIndex;
           // Bind_Companioncases();
        }


        private void Bind_Companioncases()
        {

           // grdCompanionCases.DataSource = ComplaintsLink.Complaints.getComplaint_CompanionCases(comid);
            //grdCompanionCases.DataBind();
        }


        #endregion


        public string display_eventresperson(string ids)
        {
            string[] temp = ids.Split(',');
            string retval = "";
            foreach (string t in temp)
            {
                try
                {
                    retval += ddleventresponseperson.Items.FindByValue(t).Text + ",";
                }
                catch
                {
                    return "";
                }
            }
            return retval.Substring(0, retval.Length - 1);
        }
        public string toup1(string str)
        {
            if (str == "-1")
            {
                return " ";
            }
            else
            {
                string sr = str.ToUpper();
                return sr;
            }
        }

        public string toup3(string str)
        {
            if (str != "" || str != null)
            {
                string sr = str.ToUpper();
                if (sr.Length > 15)
                    return sr.Substring(0, 15);
                else
                {

                    return "";
                }
            }
            else
            {
                return "";
            }

        }
        public string phone(string str)
        {
            if (str.Length == 10)
            {
                return str.Substring(0, 3) + "-" + str.Substring(3, 3) + "-" + str.Substring(6, 4);
            }
            return str;
        }
        public string filter_date(string str)
        {
            try
            {
                if (str != "" || str!=null)
                {
                    return DateTime.Parse(str).ToString("MM/dd/yyyy");
                }
                return "NA";
            }
            catch { return "NA"; }
        }
        public string toup(string str)
        {
             string sr="";
            try
            {
                if (str != "" || str != null)
                {
                     sr = str.ToUpper();
                    
                }
                return sr;
            }
            catch (Exception ex)
            {
                return "";
            }
            
           
        }
        public string hear(string str)
        {
            if (str == "1")
                return "Yes";
            else
                return "No";



        }

        public string attstatus(string str)
        {
            if (str == "1")
                return "Active";
            else
                return "InActive";

        }
     

















    }
}