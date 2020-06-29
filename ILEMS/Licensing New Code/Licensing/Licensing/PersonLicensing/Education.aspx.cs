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

namespace Licensing.PersonLicensing
{
    public partial class Education : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                hfdperid.Value = Request.QueryString[0].ToString();
                Utilities_Licensing.BindLicType(ddl_licensetype, Convert.ToInt32(hfdperid.Value));
                Utilities_Licensing.BindDropdown(ddl_degree, 26);
                Utilities_Licensing.BindDropdown(ddl_examtype, 54);
                Utilities_Licensing.BindLicType(ddllictype, Convert.ToInt32(hfdperid.Value));
                Utilities_Licensing.BindDropdown(ddl_Eligibletype, 69);

                // Utilities_Licensing.BindGridEducation(grdeducation, Convert.ToInt32(hfdperid.Value));
            }
        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {

            if (hfdeduid.Value == "0")
            {

                TBL_Licensing_Education tld = new TBL_Licensing_Education();
                tld.Education_ID = Convert.ToInt32(hfdeduid.Value);
                tld.Person_ID = Convert.ToInt32(hfdperid.Value);
                
                tld.Degree_ID = Convert.ToInt32(ddl_degree.SelectedValue);
                tld.College = txtcollege.Text.ToString();
                if (start_date.Text != "")
                    tld.Start_dt = Convert.ToDateTime(start_date.Text);
                else
                    tld.Start_dt = Convert.ToDateTime("01/01/1900");
                if (expected_date.Text != "")
                    tld.End_dt = Convert.ToDateTime(expected_date.Text);
                else
                    tld.End_dt = Convert.ToDateTime("01 / 01 / 1900");
                if (txt_graduationdate.Text != "")
                    tld.DateOfGraduation = Convert.ToDateTime(txt_graduationdate.Text);
                else
                    tld.DateOfGraduation = Convert.ToDateTime("01 / 01 / 1900");
                
                tld.Traditional_hrs = traditional_hours.Text.ToString();
                tld.Total_hrs = total_hours.Text.ToString();
                tld.modifiedby =  Session["UID"].ToString();
                tld.modifieddt = Convert.ToDateTime(DateTime.Now.ToShortDateString());
                tld.createdby =  Session["UID"].ToString();
                tld.createddt = Convert.ToDateTime(DateTime.Now.ToShortDateString());
                Person_Details.Licensing_Details.Insert_Education(tld);
                 altbox("Record inserted successfully.");
                
                Clear();
            }
            else
            {
                TBL_Licensing_Education tld = new TBL_Licensing_Education();
                tld.Education_ID = Convert.ToInt32(hfdeduid.Value);
                tld.Person_ID = Convert.ToInt32(hfdperid.Value);
               tld.Degree_ID = Convert.ToInt32(ddl_degree.SelectedValue);
                tld.College = txtcollege.Text.ToString();
                if (start_date.Text != "")
                    tld.Start_dt = Convert.ToDateTime(start_date.Text);
                else
                    tld.Start_dt = Convert.ToDateTime("01 / 01 / 1900");
                if (expected_date.Text != "")
                    tld.End_dt = Convert.ToDateTime(expected_date.Text);
                else
                    tld.End_dt = Convert.ToDateTime("01 / 01 / 1900");
                if (txt_graduationdate.Text != "")
                    tld.DateOfGraduation = Convert.ToDateTime(txt_graduationdate.Text);
                else
                    tld.DateOfGraduation = Convert.ToDateTime("01 / 01 / 1900");
                tld.Traditional_hrs = traditional_hours.Text.ToString();
                tld.Total_hrs = total_hours.Text.ToString();
                tld.modifiedby = Session["UID"].ToString();
                tld.modifieddt = Convert.ToDateTime(DateTime.Now.ToShortDateString());
               
                Person_Details.Licensing_Details.Update_Education(tld);
                   altbox("Record updated successfully.");
               
                Clear();

            }

        }
        
        protected void btnedit_click(object sender, EventArgs e)
        {
            string value = hfdselid.Value;
            TBL_Licensing_Education obj = Utilities_Licensing.EditEducation(Convert.ToInt32(value));
            hfdeduid.Value = obj.Education_ID.ToString();
           
            //ddl_licensetype.SelectedValue = obj.App_ID.ToString();
            string degree = "";
            degree = obj.Degree_ID.ToString();
            if (ddl_degree.Items[0].Text != degree)
            {
                ddl_degree.Items[0].Selected = false;
                if (ddl_degree.Items.FindByValue(degree) != null)
                    ddl_degree.Items.FindByValue(degree).Selected = true;
            }
            //ddl_degree.SelectedValue = obj.Degree_ID.ToString();
            txtcollege.Text = obj.College;
            if (Convert.ToDateTime(obj.Start_dt).ToString("MM/dd/yyyy") == "01/01/1900" || Convert.ToDateTime(obj.Start_dt).ToString("MM/dd/yyyy") == "01/01/0001")
                start_date.Text="";
            else
                start_date.Text = Convert.ToDateTime(obj.Start_dt).ToString("MM/dd/yyyy");

            if (Convert.ToDateTime(obj.End_dt).ToString("MM/dd/yyyy") == "01/01/1900" || Convert.ToDateTime(obj.End_dt).ToString("MM/dd/yyyy") == "01/01/0001")
                expected_date.Text="";
            else
                expected_date.Text = Convert.ToDateTime(obj.End_dt).ToString("MM/dd/yyyy");

            if (Convert.ToDateTime(obj.DateOfGraduation).ToString("MM/dd/yyyy") == "01/01/1900" || Convert.ToDateTime(obj.DateOfGraduation).ToString("MM/dd/yyyy") == "01/01/0001")
                txt_graduationdate.Text = "";
            else
                txt_graduationdate.Text = Convert.ToDateTime(obj.DateOfGraduation).ToString("MM/dd/yyyy");
            
            
            traditional_hours.Text = obj.Traditional_hrs;
            total_hours.Text = obj.Total_hrs;
            string js = "Popup();";
            ScriptManager.RegisterStartupScript(Page, GetType(), "scr", js, true);
        }
         protected void btndel_click(object sender, EventArgs e)
        {
            string value = hfdselid.Value;
            TBL_Licensing_Education obj = new TBL_Licensing_Education();
            obj.Education_ID = Convert.ToInt32(value);
            Person_Details.Licensing_Details.Delete_Education(obj);
             altbox("Record deleted successfully.");
          }
          public void Clear()
        {
            ddl_degree.SelectedIndex = -1;
            txtcollege.Text = "";
            start_date.Text = "";
            expected_date.Text = "";

            txt_graduationdate.Text = "";
            traditional_hours.Text = "";
            total_hours.Text = "";
            hfdeduid.Value = "";
        }
        private void  altbox(string str)
        {
            string js = " afterpost('" + str + "');";
            ScriptManager.RegisterStartupScript(Page, GetType(), "scr", js, true);
        }
        #region ExamDetails Insert,Edit,Delete

        protected void btndel1_click(object sender, EventArgs e)
        {
            string value = hfd_examid.Value;
            tbl_examdetail obj = new tbl_examdetail();
            obj.exam_id = Convert.ToInt32(value);
            Person_Details.Licensing_Details.Delete_ExamData(obj);
            Page.RegisterStartupScript("js", "<script>exam.process();</script>");
            altbox("Record deleted successfully.");


        }
        protected void btnedit1_click(object sender, EventArgs e)
        {
            string value = hfd_examid.Value;
            Person_Details.tbl_examdetail obj = Utilities_Licensing.EditExam(Convert.ToInt32(value));
            hfd_examid.Value = obj.exam_id.ToString();
            if(obj.Inter_Score!="" || obj.Inter_Score!=null)
            txt_Inter_Score.Text = obj.Inter_Score;
            if(Convert.ToDateTime(obj.NPLEX_DT).ToString("MM/dd/yyyy")!="01/01/1900")
            txt_NPLEXDT.Text = Convert.ToDateTime(obj.NPLEX_DT).ToString("MM/dd/yyyy");
            txt_nplexscr.Text = obj.NPLEX_SCR;
            if(Convert.ToDateTime(obj.MPJE_DT).ToString("MM/dd/yyyy")!="01/01/1900")
            txt_MPJEdate.Text = Convert.ToDateTime(obj.MPJE_DT).ToString("MM/dd/yyyy");
            txt_MPJE_SCR.Text = obj.MPJE_SCR;

            string examtype = "";
            examtype = obj.exam_type.ToString();
            ddl_examtype.ClearSelection();
                if (ddl_examtype.Items.FindByValue(examtype) != null)
                    ddl_examtype.Items.FindByValue(examtype).Selected = true; 

            string js = "Popup1();";
            ScriptManager.RegisterStartupScript(Page, GetType(), "scr", js, true);
        }

        protected void btn_examsubmit_Click(object sender, EventArgs e)
        {
            hfdperid.Value = Request.QueryString[0].ToString();
            
                if (hfd_examid.Value == "0")
                {


                    Person_Details.Licensing_Details.Insert_ExamDetails(101, 0, hfdperid.Value, ddllictype.SelectedValue.ToString(), ddl_examtype.SelectedValue.ToString(), txt_NPLEXDT.Text, txt_nplexscr.Text, txt_MPJEdate.Text, txt_MPJE_SCR.Text, txt_Inter_Score.Text, Session["UID"].ToString(), DateTime.Now.ToShortDateString(), Session["UID"].ToString(), "");

                    Page.RegisterStartupScript("js", "<script>exam.process();</script>");
                    altbox("Record inserted successfully.");
                    Clear_Exam();
                }

                else
                {

                    Person_Details.Licensing_Details.Update_Exam(102, Convert.ToInt32(hfd_examid.Value), hfdperid.Value, ddllictype.SelectedValue.ToString(), ddl_examtype.SelectedValue.ToString(), txt_NPLEXDT.Text, txt_nplexscr.Text, txt_MPJEdate.Text, txt_MPJE_SCR.Text, txt_Inter_Score.Text, Session["UID"].ToString(), "", Session["UID"].ToString(), DateTime.Now.ToShortDateString());

                    Page.RegisterStartupScript("js", "<script>exam.process();</script>");
                    altbox("Record updated successfully.");
                    Clear_Exam();
                }
           

        }

        private void Clear_Exam()
        {
            ddllictype.SelectedValue = "-1";
            txt_NPLEXDT.Text = "";
            txt_nplexscr.Text = "";
            ddl_examtype.SelectedValue = "-1";
            txt_MPJEdate.Text = "";
            txt_MPJE_SCR.Text = "";
            txt_Inter_Score.Text = "";
        }

        #endregion

        protected void btnexameligibleedit_Click(object sender, EventArgs e)
        {
            string value = hfd_Eligible_id.Value;
            Person_Details.Tbl_Exam_Eligible obj = Person_Details.Licensing_Details.Edit_Eligibility(Convert.ToInt32(value));
            hfd_Eligible_id.Value = obj.Exam_EligibleID.ToString();

            if (Convert.ToDateTime(obj.EligibleDate).ToString("MM/dd/yyyy") != "01/01/1900")
                txt_EligibleDate.Text = Convert.ToDateTime(obj.EligibleDate).ToString("MM/dd/yyyy");

            string eligible_type = "";
            eligible_type = obj.ExamType.ToString();
            if (ddl_Eligibletype.Items[0].Text != eligible_type)
            {
                ddl_Eligibletype.Items[0].Selected = false;
                if (ddl_Eligibletype.Items.FindByValue(eligible_type) != null)
                    ddl_Eligibletype.Items.FindByValue(eligible_type).Selected = true;
            }

            string js = "Popup2();";
            ScriptManager.RegisterStartupScript(Page, GetType(), "scr", js, true);
            

        }

        protected void btnexameligibledelete_Click(object sender, EventArgs e)
        {
            string value = hfd_Eligible_id.Value;
            Person_Details.Licensing_Details.Delete_Eligibility(Convert.ToInt32(value));
            altbox("Record Deleted successfully.");

        }

        protected void btnexameligiblesbmit_Click(object sender, EventArgs e)
        {
            if (hfd_Eligible_id.Value == "0")
            {

                Person_Details.Licensing_Details.insertEligible(0, hfdperid.Value, ddl_Eligibletype.SelectedValue, txt_EligibleDate.Text, Session["UID"].ToString());
                altbox("Record Inserted successfully.");
                Clear_eligible_Exam();
            }
            else
            {
                Person_Details.Licensing_Details.insertEligible(Convert.ToInt32(hfd_Eligible_id.Value), hfdperid.Value, ddl_Eligibletype.SelectedValue, txt_EligibleDate.Text, Session["UID"].ToString());
                altbox("Record updated successfully.");
                Clear_eligible_Exam();
            }

        }
        public void Clear_eligible_Exam()
        {
            hfd_Eligible_id.Value = "0";
            txt_EligibleDate.Text = "";
            ddl_Eligibletype.SelectedIndex = -1;
        }

    }
}