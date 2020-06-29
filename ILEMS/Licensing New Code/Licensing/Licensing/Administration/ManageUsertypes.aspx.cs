using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Licensing.Administration
{
    public partial class ManageUsertypes : System.Web.UI.Page
    {
        public List<Reports.USP_GetsublistResult> Bindsub(string mid)
        {
            return Reports.Reportgenrator.Getsubmenu( mid,ddl_usetype.SelectedValue);
        }
        protected void btnsave_cick(object sender, EventArgs e)
        {
            string utype = ddl_usetype.SelectedValue;
            
            foreach(DataListItem li in ddltabinfo.Items)
            {
                string tabid = ((HiddenField)li.FindControl("hfdtabid")).Value;
                string auid = ((HiddenField)li.FindControl("hfdauid")).Value;
                Boolean selval = ((CheckBox)li.FindControl("chbsel")).Checked;
                Boolean iswrite = ((CheckBox)li.FindControl("chbwrite")).Checked;
                Boolean isdel = ((CheckBox)li.FindControl("chbdelete")).Checked;
                Reports.Reportgenrator.Insert_tabinfo(Convert.ToInt32(auid), utype, Convert.ToInt32(tabid), selval, iswrite, isdel, Session["UID"].ToString());

            }
            foreach (DataListItem li in dtdoclst.Items)
            {
                string tabid = ((HiddenField)li.FindControl("hfddocid")).Value;
                string auid = ((HiddenField)li.FindControl("hfdauid")).Value;
                Boolean selval = ((CheckBox)li.FindControl("chbsel")).Checked;
                Reports.Reportgenrator.Insert_docinfo(Convert.ToInt32(auid), utype, Convert.ToInt32(tabid), selval, Session["UID"].ToString());

            }
            foreach (DataListItem li in ddlmusers.Items)
            {
                DataList sdtl = (DataList)li.FindControl("ddlsub");
                foreach (DataListItem sli in sdtl.Items)
                {
                    string mid = ((HiddenField)sli.FindControl("hfdmid")).Value;
                    string sid = ((HiddenField)sli.FindControl("hfdsid")).Value;
                    string auid = ((HiddenField)sli.FindControl("hfdauid")).Value;
                    Boolean selval = ((CheckBox)sli.FindControl("chbslst")).Checked;
                    Reports.Reportgenrator.Insert_pageinfo(Convert.ToInt32(auid), utype, Convert.ToInt32(mid), Convert.ToInt32(sid), selval, Session["UID"].ToString());

                }

            }
            Bind_lst(null,null);
             altbox("Information saved.");
        }
        protected void Bind_lst(object sender, EventArgs e)
        {
            if (ddl_usetype.SelectedValue != "-1")
            {
                List<Reports.tbl_Menu> lst = Reports.Reportgenrator.GetMenus();
                ddlmusers.RepeatColumns = lst.Count;
                ddlmusers.DataSource = lst;
                ddlmusers.DataBind();
                List<Reports.USP_gettabinfoResult> lst1 = Reports.Reportgenrator.Gettabinfo(ddl_usetype.SelectedValue);

                ddltabinfo.RepeatColumns = 5;
                ddltabinfo.DataSource = lst1;
                ddltabinfo.DataBind();
               
                btnsave.Visible = true;
                headgrd.Visible = true;
                headdoc.Visible = true;
            }
            else
            {
                ddlmusers.DataSource = null;
                ddlmusers.DataBind();
                ddltabinfo.DataSource = null;
                ddltabinfo.DataBind();
                btnsave.Visible = false;
                headgrd.Visible = false;
                headdoc.Visible = false;
                dtdoclst.DataSource = null;
                dtdoclst.DataBind();
               }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
               
                Licensing.Complaints.utilities.BindDropdown(ddl_usetype, 16);
                
            }
        }
        private void  altbox(string str)
        {
            string js = "afterpost('" + str + "');";
            ScriptManager.RegisterStartupScript(Page, GetType(), "scr", js, true);
        }
    }
}