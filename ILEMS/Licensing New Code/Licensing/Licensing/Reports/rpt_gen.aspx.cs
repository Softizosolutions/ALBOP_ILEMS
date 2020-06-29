using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Web.UI.HtmlControls;
using ExpertPdf.HtmlToPdf;

namespace Licensing.Reports
{
    public partial class rpt_gen : System.Web.UI.Page
    {
        protected void btndel_click(object sender, EventArgs e)
        {
            Reportgenrator.Delete_rpt(Convert.ToInt32(hfdsel.Value));
           
            ScriptManager.RegisterStartupScript(Page, GetType(), "js", "afterdel()", true);
       
        }
        
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
               // dtlst.DataSource = Reportgenrator.Getalltables().OrderBy(c => c.TABLE_NAME);
               // dtlst.DataBind();
                dtlst1.DataSource = Reportgenrator.Getallviews();
                dtlst1.DataBind();

            }
        }

       
        #region grid binding
        
      
        public DataSet binddrp(string oths)
        {
            string[] cls = oths.Split(',');
            if (cls.Length == 3)
            {
                string query = "select " + cls[1] + " as disp," + cls[2] + " as val from " + cls[0] + " order by disp";
                DataSet ds = Reportgenrator.Getrpt(query);
                DataRow dr = ds.Tables[0].NewRow();
                dr[0] = "All";
                dr[1] = "0";
                ds.Tables[0].Rows.InsertAt(dr, 0);
                ds.AcceptChanges();
                return ds;
            }
            return null;
        }
       
        protected void btnrpt_save(object sender, EventArgs e)
        {
            hfdrptid.Value = Reportgenrator.Save_rpt(hfdrptid.Value, txtrpt.Text, hfdquery.Value, hfdfltrs.Value, hfdcols.Value);
          //  ScriptManager.RegisterStartupScript(Page, GetType(), "js", "aftersave()", true);
            Page.RegisterStartupScript("js", "<script>aftersave();</script>");
        }
        public string getdrptxtfld(string oths, int slindex)
        {
            string[] cols = oths.Split(',');

            return cols[slindex];
            return "";
        }
        public Boolean getdisp(string selval, string cmpval)
        {
            if (selval == cmpval)
                return true;
            else
                return false;
        }
        
        #endregion
        protected void chb_chnage(object sender, EventArgs e)
        {
            CheckBox chb = (CheckBox)sender;
            string js = "";
            string cols = "";
            if (chb.Checked)
            {
                List<USP_getallcolumnsResult> obj = Reportgenrator.Getallcolumns(chb.ToolTip);
                for (int i = 0; i < obj.Count; i++)
                    cols += obj[i].COLUMN_NAME + "~" + obj[i].DATA_TYPE + "~" + obj[i].CHARACTER_MAXIMUM_LENGTH.ToString() + "^";
                if (cols.Length > 0)
                    cols = cols.Substring(0, cols.Length - 1);

                js = "createtable('" + chb.ToolTip + "','" + cols + "');";
                ddlmtables.Items.Add(new ListItem(chb.ToolTip));
            }
            else
            {
                js = "removetable('" + chb.ToolTip + "');";
                ddlmtables.Items.Remove(ddlmtables.Items.FindByText(chb.ToolTip));
            }
            ScriptManager.RegisterStartupScript(Page, GetType(), "js", js, true);

        }
        public string shorttxt(string str)
        {
            if (str.Length > 25)
            {
                return str.Substring(0, 25)+"..";
            }
            else
                return str;
        }
       
    }
}