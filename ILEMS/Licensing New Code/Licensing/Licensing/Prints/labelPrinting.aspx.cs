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

namespace Licensing.Prints
{
    public partial class labelPrinting : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            DataTable dt = new DataTable();
            if (Request.QueryString.Count == 1)
                dt = PersonLicensing.Utilities_Licensing.Getlabelsbyid(Request.QueryString[0].ToString());
            else
                dt = PersonLicensing.Utilities_Licensing.Getlabels(Request.QueryString[0].ToString(), Request.QueryString[1].ToString(), Request.QueryString[2].ToString(), Request.QueryString[3].ToString(), Request.QueryString[4].ToString());
            // IEnumerable list = Enumerable.Range(1, dt.Rows.Count/30);
            //  dtllst.DataSource = dt;
            //  dtllst.DataBind();
            int rem = dt.Rows.Count % 3;
            int div = dt.Rows.Count / 30 + 1;
            if (rem > 0)
            {
                for (int i = 3 - rem; i > 0; i--)
                {
                    DataRow dr = dt.NewRow();
                    foreach (DataColumn dc in dt.Columns)
                        dr[dc.ColumnName] = "";
                    dt.Rows.Add(dr);
                }
            }
            StringBuilder stb = new StringBuilder();
            #region style
            stb.Append("<html  xmlns:o='urn:schemas-microsoft-com:office:office'  xmlns:w='urn:schemas-microsoft-com:office:word'  xmlns='http://www.w3.org/TR/REC-html40'><head> <!--[if gte mso 9]> <xml>  <w:WordDocument>   <w:View>Print</w:View>   <w:Zoom>90</w:Zoom>    <w:DoNotOptimizeForBrowser/>     </w:WordDocument>     </xml>      <![endif]-->");
        
            stb.Append("            <style>");
            stb.Append("<!--");
            stb.Append("/* Font Definitions */");
            stb.Append("@font-face");
            stb.Append("{font-family:Arial;");
            stb.Append("panose-1:2 11 6 4 3 5 4 4 2 4;");
            stb.Append("mso-font-charset:0;");
            stb.Append("mso-generic-font-family:Arial;");
            stb.Append("mso-font-pitch:variable;");
            stb.Append("mso-font-signature:-520081665 -1073717157 41 0 66047 0;}");
            stb.Append("@font-face");
            stb.Append("{font-family:Arial;");
            stb.Append("panose-1:2 11 6 4 3 5 4 4 2 4;");
            stb.Append("mso-font-charset:0;");
            stb.Append("mso-generic-font-family:Arial;");
            stb.Append("mso-font-pitch:variable;");
            stb.Append("mso-font-signature:-1593833729 1073750107 16 0 415 0;}");
            stb.Append("/* Style Definitions */");
            stb.Append("p.MsoNormal, li.MsoNormal, div.MsoNormal");
            stb.Append("{mso-style-unhide:no;");
            stb.Append("mso-style-qformat:yes;");
            stb.Append("mso-style-parent:");
            stb.Append("margin:0in;");
            stb.Append("margin-bottom:.0001pt;");
            stb.Append("mso-pagination:widow-orphan;");
            stb.Append("font-size:9.0pt;");
            stb.Append("mso-bidi-font-size:12.0pt;");
            stb.Append("font-family:Arial,sans-serif);");
            stb.Append("mso-fareast-font-family:Arial;");
            stb.Append("mso-bidi-font-family:Arial;");
            stb.Append("mso-ansi-language:EN-US;");
            stb.Append("mso-fareast-language:EN-US;}");
            stb.Append("p.MsoAcetate, li.MsoAcetate, div.MsoAcetate");
            stb.Append("{mso-style-noshow:yes;");
            stb.Append("mso-style-unhide:no;");
            stb.Append("margin:0in;");
            stb.Append("margin-bottom:.0001pt;");
            stb.Append("mso-pagination:widow-orphan;");
            stb.Append("font-size:8.0pt;");
            stb.Append("font-family:Arial,sans-serif;");
            stb.Append("mso-fareast-font-family:Arial;");
            stb.Append("mso-ansi-language:EN-US;");
            stb.Append("mso-fareast-language:EN-US;}");
            stb.Append("p.Name, li.Name, div.Name");
            stb.Append("{mso-style-name:Name;");
            stb.Append("mso-style-unhide:no;");
            stb.Append("margin-top:0in;");
            stb.Append("margin-right:.2in;");
            stb.Append("margin-bottom:0in;");
            stb.Append("margin-left:.2in;text-transform:capitalize;");
            stb.Append("margin-bottom:.0001pt;");
            stb.Append("mso-pagination:widow-orphan;");
            stb.Append("font-size:8.0pt;");
            stb.Append("mso-bidi-font-size:8.0pt;");
            stb.Append("font-family:Arial,sans-serif;");
            stb.Append("mso-fareast-font-family:Arial;");
            stb.Append("mso-bidi-font-family:Arial;");
            stb.Append("mso-ansi-language:EN-US;");
            stb.Append("mso-fareast-language:EN-US;");

            stb.Append("mso-bidi-font-weight:normal;}");
            stb.Append("p.Address, li.Address, div.Address");
            stb.Append("{mso-style-name:Address;");
            stb.Append("mso-style-unhide:no;");
            stb.Append("mso-style-parent:Name;");
            stb.Append("margin-top:0in;");
            stb.Append("margin-right:.2in;");
            stb.Append("margin-bottom:0in;");
            stb.Append("margin-left:.2in;text-transform:capitalize;");
            stb.Append("margin-bottom:.0001pt;");
            stb.Append("mso-pagination:widow-orphan;");
            stb.Append("font-size:8.0pt;");
            stb.Append("mso-bidi-font-size:8.0pt;");
            stb.Append("font-family:Arial,sans-serif;");
            stb.Append("mso-fareast-font-family:Arial;");
            stb.Append("mso-bidi-font-family:Arial;");
            stb.Append("mso-ansi-language:EN-US;");
            stb.Append("mso-fareast-language:EN-US;}");
            stb.Append(".MsoChpDefault");
            stb.Append("{mso-style-type:export-only;");
            stb.Append("mso-default-props:yes;");
            stb.Append("font-size:10.0pt;");
            stb.Append("mso-ansi-font-size:10.0pt;");
            stb.Append("mso-bidi-font-size:10.0pt;}");
            stb.Append("@page WordSection1");
            stb.Append("{size:8.5in 11.0in;");
            stb.Append("	margin:.5in 13.6pt 0in 13.6pt;");
            stb.Append("mso-header-margin:.5in;");
            stb.Append("mso-footer-margin:.5in;");
            stb.Append("mso-paper-source:4;}");
            stb.Append("div.WordSection1");
            stb.Append("{page:WordSection1;}");
            stb.Append("</style>");
            stb.Append("</head>");
            stb.Append("<body>");
            #endregion
            for (int page = 0; page < div; page++)
            {
                stb.Append(" <div class=WordSection1>");

                stb.Append(" <table  border=0 cellspacing=0 cellpadding=0 ");
                // stb.Append(" mso-border-insidev:.5pt solid windowtext'>");
                for (int data = page * 30; data < ((page * 30) + 30) && data < dt.Rows.Count; data += 3)
                {
                    stb.Append(" <tr style='height:1.0in'>");
                    stb.Append(" <td width=252 style='width:189.0pt;padding:0in .55pt 0in .55pt;height:1.0in'>");
                    stb.Append(" <p class=Name><span lang=EN-US>" + dt.Rows[data]["Name"].ToString().ToUpper() + "</span></p>");

                    if (dt.Rows[data]["Addr_line1"].ToString() != dt.Rows[data]["Addr_line2"].ToString() && dt.Rows[data]["Addr_line2"].ToString().Trim() != "")
                        stb.Append(" <p class=Address><span lang=EN-US>" + dt.Rows[data]["Addr_line1"].ToString().ToUpper() + "<br>" + dt.Rows[data]["Addr_line2"].ToString().ToUpper() + "</span></p>");
                    else
                        stb.Append(" <p class=Address><span lang=EN-US>" + dt.Rows[data]["Addr_line1"].ToString().ToUpper() + "</span></p>");

                    //stb.Append(" <p class=Address><span lang=EN-US>" + dt.Rows[data]["Addr_line2"].ToString() + "</span></p>");
                    stb.Append(" <p class=Address><span lang=EN-US>" + dt.Rows[data]["Addr_city"].ToString().ToUpper() + dt.Rows[data]["Addr_state"].ToString().ToUpper() + "<span");
                    stb.Append(" style='mso-spacerun:yes'>&nbsp;</span>" + dt.Rows[data]["Addr_zipcode"].ToString() + "</span></p>");
                    stb.Append(" </td>");
                    stb.Append(" <td width=12 style='width:9.0pt;");

                    stb.Append(" padding:0in .75pt 0in .75pt;height:1.0in'>");
                    stb.Append(" <p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>");
                    stb.Append(" </td>");
                    stb.Append(" <td width=252 style='width:189.0pt;");
                    stb.Append(" padding:0in .55pt 0in .55pt;height:1.0in'>");
                    stb.Append(" <p class=Name><span lang=EN-US>" + dt.Rows[data + 1]["Name"].ToString().ToUpper() + "</span></p>");
                    if (dt.Rows[data + 1]["Addr_line1"].ToString() != dt.Rows[data + 1]["Addr_line2"].ToString() && dt.Rows[data + 1]["Addr_line2"].ToString().Trim() != "")
                        stb.Append(" <p class=Address><span lang=EN-US>" + dt.Rows[data + 1]["Addr_line1"].ToString().ToUpper() + "<br>" + dt.Rows[data + 1]["Addr_line2"].ToString().ToUpper() + "</span></p>");
                    else
                        stb.Append(" <p class=Address><span lang=EN-US>" + dt.Rows[data + 1]["Addr_line1"].ToString().ToUpper() + "</span></p>");
                    //stb.Append(" <p class=Address><span lang=EN-US>" + dt.Rows[data + 1]["Addr_line2"].ToString() + "</span></p>");
                    stb.Append(" <p class=Address><span lang=EN-US>" + dt.Rows[data + 1]["Addr_city"].ToString().ToUpper() + dt.Rows[data + 1]["Addr_state"].ToString().ToUpper() + "<span");
                    stb.Append(" style='mso-spacerun:yes'>&nbsp;</span>" + dt.Rows[data + 1]["Addr_zipcode"].ToString() + "</span></p>");
                    stb.Append(" </td>");
                    stb.Append(" <td width=12 style='width:9.0pt;");
                    stb.Append(" padding:0in .55pt 0in .55pt;height:1.0in'>");
                    stb.Append(" <p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>");
                    stb.Append(" </td>");
                    stb.Append(" <td width=252 style='width:189.0pt;");
                    stb.Append(" padding:0in .55pt 0in .55pt;height:1.0in'>");
                    stb.Append(" <p class=Name><span lang=EN-US>" + dt.Rows[data + 2]["Name"].ToString().ToUpper() + "</span></p>");
                    if (dt.Rows[data + 2]["Addr_line1"].ToString() != dt.Rows[data + 2]["Addr_line2"].ToString() && dt.Rows[data + 2]["Addr_line2"].ToString().Trim() != "")
                        stb.Append(" <p class=Address><span lang=EN-US>" + dt.Rows[data + 2]["Addr_line1"].ToString().ToUpper() + "<br>" + dt.Rows[data + 2]["Addr_line2"].ToString().ToUpper() + "</span></p>");
                    else
                        stb.Append(" <p class=Address><span lang=EN-US>" + dt.Rows[data + 2]["Addr_line1"].ToString().ToUpper() + "</span></p>");
                    // stb.Append(" <p class=Address><span lang=EN-US>" + dt.Rows[data + 2]["Addr_line2"].ToString() + "</span></p>");
                    stb.Append(" <p class=Address><span lang=EN-US>" + dt.Rows[data + 2]["Addr_city"].ToString().ToUpper() + dt.Rows[data + 2]["Addr_state"].ToString().ToUpper() + "<span");
                    stb.Append(" style='mso-spacerun:yes'>&nbsp;</span>" + dt.Rows[data + 2]["Addr_zipcode"].ToString() + "</span></p>");
                    stb.Append(" </td>");
                    stb.Append(" </tr>");
                }
                stb.Append("</table>");
                stb.Append(" <p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>");
                stb.Append(" </div>");
            }
            stb.Append("</body>");
            stb.Append("</html>");
            // Response.Write(stb.ToString());
            // stb.Append("<br><br><table  style='margin-left:20px;margin-bottom:80px;table-layout:fixed' cellspacing='0' border='1' bordercolor='#000000' cellpadding='0'>");
            // for (int i = 1; i <=dt.Rows.Count; i++)
            // {
            //     if (i % 3 == 1)
            //         stb.Append("<tr>");


            //     if (i % 3 == 0)
            //     {
            //         stb.Append("<td valign='top' width='320px' height='120px'>"+getformat(dt.Rows[i-1])+"</td>");
            //         stb.Append("</tr>");
            //     }
            //     else
            //     {
            //         stb.Append("<td valign='top' width='320px' height='120px'>"+getformat(dt.Rows[i-1])+"</td><td width='20px'>&nbsp;&nbsp;</td>");
            //     }

            //     if (i != 0 && i % 30 == 0)
            //     {
            //         stb.Append("</table>");
            //         stb.Append("<div  style='page-break-before:always'><br><br><br></div>");
            //         stb.Append("<table  style='margin-left:20px;margin-bottom:80px;table-layout:fixed' cellspacing='0' border='1'  bordercolor='#000000' cellpadding='0'>");

            //     }
            // }
            // stb.Append("</table>");
            //// for(int i=0;i<10;i++)
            // //    stb.Append("<tr><td valign='top' width='390px' height='150px'>1</td><td width='20px'>&nbsp;&nbsp;</td><td valign='top'  width='390px' height='150px'>2</td><td width='20px'>&nbsp;&nbsp;</td><td valign='top' width='390px' height='150px'>3</td></tr>");

            // //  Response.Write(stb.ToString()); 
            PDFGenerator pdf = new PDFGenerator();
            pdf.Genratewordtext(stb.ToString(), "Maillabels");
        }
        public string getformat(DataRow dr)
        {
            string str = "";
            str = dr["Name"].ToString().ToUpper() + "<br>";
            str += dr["Addr_line1"].ToString().ToUpper() + "<br>";
            str += dr["Addr_city"].ToString() + " " + dr["Addr_state"].ToString() + " " + dr["Addr_zipcode"].ToString();
            return str;
        }
        public string getline2(string line2)
        {
            if (line2 != "")
                return "<br>" + line2;
            return "";
        }

    }
}