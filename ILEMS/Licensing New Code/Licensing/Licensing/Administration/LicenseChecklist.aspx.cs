using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Licensing.Administration
{
    public partial class LicenseChecklist : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            

            if (!IsPostBack)
            {
                //utilities_Person.BindDropdownlicchecklist(ddl_checklist, 10, "Active");


                 adminUtilities.Bind_LicenseTypes(ddl_lictypedata);    
                Complaints.utilities.BindDropdown(ddl_actiondata, 21);

                string chkStatus = "";

                  Complaints.utilities.BindDropdown(ddl_checklist, 15);

              

            }

        }


        private void test()
        {
            //test method
        }

    protected void btn_submit_Click(object sender, EventArgs e)
    {
        if (hfd_chkid.Value == "0")
        {
            string ismandatory = "";
            if (chk_mandatory.Checked == true)
                ismandatory = "True";
            else
                ismandatory = "False";

            adminUtilities.licchecklist_Save(Convert.ToInt32(hfd_chkid.Value), ddl_lictypedata.SelectedItem.Value, ddl_actiondata.SelectedItem.Value, ddl_checklist.SelectedItem.Value, ddlstatus.SelectedValue.ToString(), ismandatory);

            Clear();
             altbox("Record inserted successfully.");
        }
        else
        {
            string ismandatory = "";
            if (chk_mandatory.Checked == true)
                ismandatory = "True";
            else
                ismandatory = "False";

            adminUtilities.licchecklist_Save(Convert.ToInt32(hfd_chkid.Value), ddl_lictypedata.SelectedItem.Value, ddl_actiondata.SelectedItem.Value, ddl_checklist.SelectedItem.Value, ddlstatus.SelectedValue.ToString(), ismandatory);

            Clear();
             altbox("Record updated successfully.");
        }

       
        //adminUtilities.Bind_grid_licenseCheckList(grd_checklist, ddl_lictypedata.SelectedValue, ddl_actiondata.SelectedValue);

    }
    protected void btnedit_click(object sender, EventArgs e)
    {
        string Value = hfdselid.Value;



        AdminLinq.tbl_lkp_LicenseCheckList obj = adminUtilities.Edit_licenseCheckListItems(Convert.ToInt32(Value));
        hfd_chkid.Value = obj.License_CheckList_ID.ToString();
        string lictype = "";
        lictype = obj.License_Type_ID;

        string checklist = "";
        checklist = obj.CheckList_ID;


        ddl_checklist.SelectedValue = checklist;


        string Ismandatory = "";
        Ismandatory = obj.Is_Mandatory;
        if (obj.Is_Mandatory == "True")
            chk_mandatory.Checked = true;
        else
            chk_mandatory.Checked = false;


        string status = "";
        status = obj.Status;


        ddlstatus.SelectedValue = status;

        string js = "popup();";
        ScriptManager.RegisterStartupScript(Page, GetType(), "scr", js, true);
    }
    protected void btndel_click(object sender, EventArgs e)
    {

        string Value = hfdselid.Value;
        adminUtilities.Delete_licenseCheckListItems(Convert.ToInt32(Value));
        
         altbox("Record deleted successfully.");
    }
    protected void btn_Clear_Click(object sender, EventArgs e)
    {
        Clear();
    }

    #region Clear
    public void Clear()
    {
        ddl_checklist.SelectedValue = "-1";
        //ddl_lictypedata.SelectedValue = "-1";
        //ddl_actiondata.SelectedValue = "-1";
        ddlstatus.SelectedValue = "-1";
        chk_mandatory.Checked = false;
        hfd_chkid.Value = "0";
    }
    #endregion



    private void  altbox(string str)
    {
        string js = "afterpost('" + str + "');";
        ScriptManager.RegisterStartupScript(Page, GetType(), "scr", js, true);
    }

    


    }












    
}