using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ExpertPdf.HtmlToPdf;
using System.Drawing;
using System.Text;

namespace Licensing.Prints
{
    public partial class PrintRocExcel : System.Web.UI.Page
    {
        decimal total = 0; int noftrnas = 0; string sdt; string edt;
        private string subhead()
        {
            if (Request.QueryString[3].ToString() == "2")
                return "Manual ";
            else
                if (Request.QueryString[3].ToString() == "1")
                return "Online ";
            else
                return "All ";

        }
        protected void Page_Load(object sender, EventArgs e)
        {
            sdt = Request.QueryString[0].ToString();
            edt = Request.QueryString[1].ToString();
            if (edt == "")
                edt = sdt.ToString();
            StringBuilder stb = new StringBuilder();
            List<Reports.USP_Getroc_detailsResult> lstdet_main= Reports.Reportgenrator.GetROCDetails(Convert.ToInt32(Request.QueryString[3].ToString()), Convert.ToDateTime(sdt), 1, Convert.ToDateTime(edt));
            stb.Append("<html><head> <link href='../Styles/product.css' rel='stylesheet' type='text/css' /> <style>  table.print-friendly tr td, table.print-friendly tr   {     height:20px;    } </style> </head><body>");
            if (edt == sdt)
                stb.Append("<h2 style='color:#1c5e80;' align='center'>" + subhead() + "Transactions for " + sdt + "</h2>");
            else
                stb.Append("<h2 style='color:#1c5e80;' align='center'>" + subhead() + "Transactions for " + sdt + " and " + edt + "</h2>");
            lstdet_main = Reports.Reportgenrator.GetROCDetails(Convert.ToInt32(Request.QueryString[3].ToString()), Convert.ToDateTime(sdt), 1, Convert.ToDateTime(edt));


            stb.Append("<table width='98%' border='1' cellspacing='0' bordercolor='#000' class='grdmain' cellpadding='5' align='center' class='print-friendly'>");
            stb.Append("<tr style='background:#1c5e80;color:white'><td width='50px'>Sr No</td><td align='center'>Name</td><td align='center'>License #</td><td align='center'>Fee Type</td><td align='center' >Amount</td><td align='center'>Check #</td></tr>");
            List<Reports.USP_Getroc_detailsResult> lstdet = lstdet_main.OrderBy(c => c.Fee_type).ToList();
            noftrnas = lstdet.Count;
            for (int i = 1; i <= lstdet.Count; i++)
            {
                //if (i % 21 == 0)
                //{
                //    stb.Append("</table>");
                //    stb.Append("<div style='page-break-before:always' />");

                //    stb.Append("<table width='98%' border='1' cellspacing='0' bordercolor='#000' class='grdmain' cellpadding='5' align='center' class='print-friendly'>");
                //    stb.Append("<tr style='background:#1c5e80;color:white'><td width='50px'>Sr No</td><td align='center'>Name</td><td align='center'>License #</td><td align='center'>Fee Type</td><td align='center' >Amount</td><td align='center'>Check #</td></tr>");

                //}
                stb.Append("<tr><td align='center'>" + i.ToString() + "</td><td align='center'>" + lstdet[i - 1].Pname + "&nbsp;</td><td align='center'>" + lstdet[i - 1].licno + "&nbsp;</td><td align='center'>" + lstdet[i - 1].Fee_type + "&nbsp;</td><td align='right'>$" + lstdet[i - 1].Amount.ToString("0.00") + "&nbsp;</td><td align='center'>" + lstdet[i - 1].CheckNumber + "</td></tr>");
                total += lstdet[i - 1].Amount;

            }
            stb.Append("<tr><td align='center'>&nbsp;</td><td align='center'>&nbsp;</td><td align='center'>&nbsp;</td><td align='right'>Total :&nbsp;</td><td align='right'>$" + total.ToString("0.00") + "&nbsp;</td><td align='center'></td></tr>");
            stb.Append("</table>");
            stb.Append(" </body></html>");
            Response.Clear();
            Response.AppendHeader("Content-Type", "application/vnd.ms-excel");
            Response.AppendHeader("Content-disposition", "attachment; filename=Roc.xls");
            Response.Write(stb);
            Response.Flush();
            Response.End();
        }
    }
}