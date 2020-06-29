using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;

namespace Licensing.PersonLicensing
{
    public partial class fddownload : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            casefilesdownload(Request.QueryString[0].ToString(), Request.QueryString[1].ToString());
        }
        private void casefilesdownload( string docid,string fname)
        {
            FileStream fs = new FileStream(Server.MapPath("Person_Document") + "\\" +    docid + ".frm", FileMode.Open, FileAccess.Read, FileShare.ReadWrite);
            Response.Clear();
            Response.ClearContent();
            Response.ClearHeaders();
            //To forcefully download, even for Excel, PDF files, regardless of your IE's settings which may allow to open the files right in the browser.
            Response.ContentType = "application/octet-stream";
            Response.AddHeader("Content-Disposition", "attachment;filename=" + fname);

            long bytesToGo;
            int bytesRead;
            Byte[] buffer = new byte[1048576];    //1 MB buffer, you may want to use whatever fits your environment

            bytesToGo = fs.Length;

            while (bytesToGo > 0)
            {
                if (Response.IsClientConnected)
                {
                    bytesRead = fs.Read(buffer, 0, 1048576);
                    Response.OutputStream.Write(buffer, 0, bytesRead);
                    Response.Flush();
                    bytesToGo -= bytesRead;
                }
                else
                {
                    bytesToGo = -1;
                }
            }
            fs.Close();
            Response.Flush();
            Response.End();
        }
     
    }
}