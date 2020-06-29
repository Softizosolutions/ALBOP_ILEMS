<%@ WebHandler Language="C#" Class="Handler" %>

using System;
using System.Web;

public class Handler : IHttpHandler {
 
    public bool IsReusable {
        get {
            return false;
        }
    }
    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "application/force-download";
        context.Response.AddHeader("content-disposition", "filename=priceorder.csv");
        context.Response.Write(context.Request.Form["exporttable"]);
    }
}