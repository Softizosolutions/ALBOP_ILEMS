using System;
using System.Data;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using System.Collections.Generic;
using System.Data.Linq;
using System.Data.SqlClient;
using System.IO;
using Microsoft.ApplicationBlocks.Data;
using System.Collections;
using AdminLinq;

namespace Licensing.Administration
{
    public class adminUtilities
    {




        public static void UpdatePassword(string uname, string pwd)
        {
            SqlHelper.ExecuteNonQuery(System.Configuration.ConfigurationManager.AppSettings["Licensing_Con"].ToString(), CommandType.Text, "update Tbl_Login set Password='" + pwd + "',IsTemp=1 where UserName='" + uname+"'");
        }



        #region Manage Users Isertion Edit And Binding
        public static int Insertion_ManageUsers(int userid, string fname, string lname, string middlename, string suffix, string isstatus, string isadmin, string Email, string username, string password, string ExpiryDate, string LastLogin, string isTemp, int Usertype)
        {
            return AdminLinq.Admin.Insertion_ManageUsers(userid, fname, lname, middlename, suffix, isstatus, isadmin, Email, username, password, ExpiryDate, LastLogin, isTemp, Usertype);
        }



        //public static Tbl_User Edit_ManageUsers(int userid)
        //{

        //    return AdminLinq.Admin.Edit_ManageUsers(userid);

        //}

        public static Tbl_Login Edit_ManageUsers(int userid)
        {

            return AdminLinq.Admin.Edit_ManageUsers(userid);

        }


        public static void Bind_grid_ManageUsers(GridView grd)
        {

            grd.DataSource = AdminLinq.Admin.BindGrid_ManageUsers();

            grd.DataBind();

        }

        #endregion


        public static void Bind_LicenseTypes(DropDownList ddl)
        {


            ddl.DataSource = AdminLinq.Admin.Bind_LicenseLookupData();
            ddl.DataTextField = "License_Type";
            ddl.DataValueField = "LicenseType_ID";
            ddl.DataBind();
            ddl.Items.Insert(0, new ListItem("Select License Type", "-1"));

            
         

           
        }

        public static tbl_lkp_License Edit_LicenseLookup(int licid)
        {
            using (AdminDataContext adb = new AdminDataContext())
            {
                return adb.tbl_lkp_Licenses.Where(c => c.LicenseType_ID == licid).SingleOrDefault();
            }
        }
        public static void Bind_grid_licenseCheckList(GridView grd, string licid, string action)
        {


            grd.DataSource = AdminLinq.Admin.getLicChecklist(Convert.ToInt16(licid), Convert.ToInt16(action));

           grd.DataBind();           

        }

        public static void Delete_licenseCheckListItems(int licChkID)
        {
            AdminLinq.Admin.Delete_licChecklist(Convert.ToInt32(licChkID));

        }

        public static tbl_lkp_LicenseCheckList Edit_licenseCheckListItems(int licchkID)
        {
            return  AdminLinq.Admin.Edit_licChecklist(Convert.ToInt32(licchkID));
        }



        public static int licchecklist_Save(int licchecklistid, string lictype, string action, string checklist, string status, string ismandatory)
        {

            return AdminLinq.Admin.licChecklistInsert_Values(licchecklistid, lictype, action, checklist, status, ismandatory);

        }


    }
}