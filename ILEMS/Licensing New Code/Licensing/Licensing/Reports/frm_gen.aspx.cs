using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Text;

namespace Licensing.Reports
{
    public partial class frm_gen : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

                ddlviews.DataSource = Reportgenrator.Getallviews_frm();
                ddlviews.DataTextField = "view_name";
                ddlviews.DataValueField = "view_name";
                ddlviews.DataBind();
                ddlviews_changed(null, null);
               
           
            //Page.GetPostBackEventReference(btndel);
            }
        }
        protected void ddlviews_changed(object sender, EventArgs e)
        {
            ddlselectcolmns.DataSource = Reportgenrator.Getallcolumns(ddlviews.SelectedItem.Text);
            ddlselectcolmns.DataTextField = "COLUMN_NAME";
            ddlselectcolmns.DataValueField = "COLUMN_NAME";
            ddlselectcolmns.DataBind();
            ddlcols_change(null, null);
        }
        protected void ddlcols_change(object sender, EventArgs e)
        {
            if (ddlselectcolmns.SelectedIndex > -1)
            {

                txtcolumns.Text = ":%= Getval(" + '"' + ddlselectcolmns.SelectedValue + '"' + ") %:";
            }
            else
                txtcolumns.Text = "";
        }
        protected void btnclr_click(object sender, EventArgs e)
        {
            hfdselprnt.Value = "0";
            txtsummarycomplaint.Text = "";
            txtfilename.Text = "";
            hfdselprnt.Value = "0";
            txtpagewidth.Text = "8.5in";
            txtpageheight.Text = "11.0in";
            txtmrgtop.Text = "0.75in";
            txtmrgbotom.Text = "0.5in";
            txtmrgleft.Text = "1in";
            txtmrgrght.Text = "1in";
        }
        protected void btnedit_click(object sender, EventArgs e)
        {
            tbl_print obj = Reportgenrator.Get_printdetails(hfdselprnt.Value);
            string ftxt = File.ReadAllText(Server.MapPath("../Prints") + "//" + hfdselprnt.Value + ".aspx");
            int sind = ftxt.IndexOf("<div class=Section1>")+20;
            int lind = ftxt.LastIndexOf("</div>");
            txtsummarycomplaint.Text = ftxt.Substring(sind, lind - sind).Replace("<%=", ":%=").Replace("%>", "%:");
            txtfilename.Text = obj.fname;
            ScriptManager.RegisterStartupScript(Page, GetType(), "js", "afteredit()", true);
        }
        protected void btndel_click(object sender, EventArgs e)
        {
            Reportgenrator.Delete_print(Convert.ToInt32(hfdselprnt.Value));
            if (File.Exists(Server.MapPath("../Prints") + "//" + hfdselprnt.Value + ".aspx"))
                File.Delete(Server.MapPath("../Prints") + "//" + hfdselprnt.Value + ".aspx");
            btnclr_click(null, null);
            ScriptManager.RegisterStartupScript(Page,GetType(),"js","afterdel()",true);
        }
        protected void btn_save_click(object sender, EventArgs e)
        {
            string filepath = Reportgenrator.Insert_print(Convert.ToInt32(hfdselprnt.Value), ddlflds.SelectedValue, ddlviews.SelectedItem.Text, txtfilename.Text, ddlselectcolmns.Items[0].Text);


            if (File.Exists(Server.MapPath("../Prints") + "//" + filepath + ".aspx"))
                File.Delete(Server.MapPath("../Prints") + "//" + filepath + ".aspx");

            StringBuilder stb = new StringBuilder();
            stb.Append(File.ReadAllText(Server.MapPath("../Prints") + "//top.txt").ToString());
            stb.Append("@page Section1 ");
            stb.Append("{size:" + txtpagewidth.Text + " " + txtpageheight.Text + "; ");
            stb.Append("margin:" + txtmrgtop.Text + " " + txtmrgrght.Text + " " + txtmrgbotom.Text + " " + txtmrgleft.Text + ";} ");
            stb.Append("div.Section1 ");
            stb.Append("{page:Section1;} ");
            stb.Append("Table ");
            stb.Append("{ ");
            stb.Append("font-family:Arial; ");
            stb.Append("font-size:11pt; ");
            stb.Append("} ");

            stb.Append("--> ");
            stb.Append("</style> ");

            stb.Append("</head> ");

            stb.Append("<body lang=EN-US> ");

            stb.Append("<div class=Section1> ");
            string str = txtsummarycomplaint.Text;
            str = str.Replace(":%", "<%");
            str = str.Replace("%:", "%>");
            str = str.Replace("&quot;", Convert.ToString('"'));
            stb.Append(str);
            stb.Append("</div></body></html>");
            StreamWriter sw = File.CreateText(Server.MapPath("../Prints") + "//" + filepath + ".aspx");
            sw.Write(stb);
            sw.Close();
            btnclr_click(null, null);
            string js = "";
            js = "clr();";
            ScriptManager.RegisterStartupScript(Page, GetType(), "js1", js, true);
        }
    }
}