<%@ WebHandler Language="C#" Class="fileupload1" %>

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.IO;

public class fileupload1 : IHttpHandler {

    public void ProcessRequest(HttpContext context)
    {
        HttpFileCollection files = context.Request.Files;
        string filepaths = string.Empty;string filename = string.Empty;
        int i = 0;
        string ofname = "";
        foreach (string f in files.AllKeys)
        {
            ofname = files[f].FileName;
            //System.Configuration.ConfigurationManager.AppSettings["tempfiles"].ToString()
            filename = Guid.NewGuid().ToString().Replace("-", string.Empty) + Path.GetExtension(files[f].FileName);
            if(!Directory.Exists(System.Configuration.ConfigurationManager.AppSettings["docpath"].ToString()+"\\"+DateTime.Now.Year.ToString()))
                Directory.CreateDirectory(System.Configuration.ConfigurationManager.AppSettings["docpath"].ToString()+"\\"+DateTime.Now.Year.ToString());
            if (!Directory.Exists(System.Configuration.ConfigurationManager.AppSettings["docpath"].ToString() + "\\" + DateTime.Now.Year.ToString() + "\\" + DateTime.Now.Month.ToString()))
                Directory.CreateDirectory(System.Configuration.ConfigurationManager.AppSettings["docpath"].ToString() + "\\" + DateTime.Now.Year.ToString() + "\\" + DateTime.Now.Month.ToString());
            string filepath = (System.Configuration.ConfigurationManager.AppSettings["docpath"].ToString() + "\\" + DateTime.Now.Year.ToString() + "\\" + DateTime.Now.Month.ToString()+"\\" +filename); i++;
            files[f].SaveAs(filepath);
            filepaths += filepath;
            if (i != 1 && i != (files.Count - 1))
                filepaths += ',';
        }
        context.Response.ContentType = "text/plain";
        context.Response.Write(filename+"~"+ofname);
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}