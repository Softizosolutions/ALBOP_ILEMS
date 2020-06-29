using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Net.Mail;
using System.IO;

namespace Licensing
{
    public static class Mail
    {
        public static void SendMail(  string sToName, string sToEmail, string ccemails, string sHeader, string sMessage)
        {

            SmtpClient smtpClient = new SmtpClient();
            MailMessage message = new MailMessage();

            try
            {
                if (sToEmail == "")
                    sToEmail = System.Configuration.ConfigurationManager.AppSettings["Defaultemail"].ToString();

              string   sFromEmail = System.Configuration.ConfigurationManager.AppSettings["Fromemail"].ToString();
                MailAddress fromAddress = new MailAddress(sFromEmail, "");

                message.From = fromAddress;
              
                string[] strcc1 = sToEmail.Split(';');
                foreach (string str in strcc1)
                    if (str != "")
                        message.To.Add(str);
                message.Subject = sHeader;
                
                string[] strcc = ccemails.Split(';');
                foreach (string str in strcc)
                    if (str != "")
                        message.CC.Add(str);

                
                message.IsBodyHtml = true;
                 
                message.Body = sMessage;

                if (System.Configuration.ConfigurationManager.AppSettings["issendmail"].ToString() == "1")
                    smtpClient.Send(message);
                 
            }
            catch (Exception ex)
            {
                System.IO.File.WriteAllText(@"F:\1\albopmail.txt", ex.ToString());
               
            }

        }

        public static int SendMail1(string sToName, string sToEmail, string ccemails, string sHeader, string sMessage)
        {

            SmtpClient smtpClient = new SmtpClient();
            MailMessage message = new MailMessage();

            try
            {
                if (sToEmail == "")
                    sToEmail = System.Configuration.ConfigurationManager.AppSettings["Defaultemail"].ToString();

                string sFromEmail = System.Configuration.ConfigurationManager.AppSettings["Fromemail"].ToString();
                MailAddress fromAddress = new MailAddress(sFromEmail, "");

                message.From = fromAddress;

                string[] strcc1 = sToEmail.Split(';');
                foreach (string str in strcc1)
                    if (str != "")
                        message.To.Add(str);
                message.Subject = sHeader;

                string[] strcc = ccemails.Split(';');
                foreach (string str in strcc)
                    if (str != "")
                        message.CC.Add(str);


                message.IsBodyHtml = true;

                message.Body = sMessage;

                if (System.Configuration.ConfigurationManager.AppSettings["issendmail"].ToString() == "1")
                    smtpClient.Send(message);

                return 1;
            }
            catch (Exception ex)
            {
                return -1;
                 
            }

        }
        public static string SendMailWithMessage(string sToName, string sToEmail, string ccemails, string sHeader, string sMessage)
        {

            SmtpClient smtpClient = new SmtpClient();
            MailMessage message = new MailMessage();

            try
            {
                if (sToEmail == "")
                    sToEmail = System.Configuration.ConfigurationManager.AppSettings["Defaultemail"].ToString();

                string sFromEmail = System.Configuration.ConfigurationManager.AppSettings["Fromemail"].ToString();
                MailAddress fromAddress = new MailAddress(sFromEmail, "");

                message.From = fromAddress;

                string[] strcc1 = sToEmail.Split(';');
                foreach (string str in strcc1)
                    if (str != "")
                        message.To.Add(str);
                message.Subject = sHeader;

                string[] strcc = ccemails.Split(';');
                foreach (string str in strcc)
                    if (str != "")
                        message.CC.Add(str);


                message.IsBodyHtml = true;

                message.Body = sMessage;

                if (System.Configuration.ConfigurationManager.AppSettings["issendmail"].ToString() == "1")
                    smtpClient.Send(message);

                return "1";

            }
            catch (Exception ex)
            {
                return "-1";
                 
            }

        }
        public static void SendDeskMail(string sHeader, string sMessage, Stream Attachment,string filename, Stream screenfile)
        {

            SmtpClient smtpClient = new SmtpClient();
            MailMessage message = new MailMessage();

            try
            {
               
                 string   sToEmail = System.Configuration.ConfigurationManager.AppSettings["Helpdesktoemail"].ToString();

                string sFromEmail = System.Configuration.ConfigurationManager.AppSettings["Fromemail"].ToString();
                MailAddress fromAddress = new MailAddress(sFromEmail, "");

                message.From = fromAddress;

                string[] strcc1 = sToEmail.Split(';');
                foreach (string str in strcc1)
                    if (str != "")
                        message.To.Add(str);
                message.Subject = sHeader;
                string ccemails= System.Configuration.ConfigurationManager.AppSettings["HelpdeskCC"].ToString();
                string[] strcc = ccemails.Split(';');
                foreach (string str in strcc)
                    if (str != "")
                        message.CC.Add(str);
                string bccemails = System.Configuration.ConfigurationManager.AppSettings["HelpdeskBCC"].ToString();
                string[] strbcc = ccemails.Split(';');
                foreach (string str in strbcc)
                    if (str != "")
                        message.Bcc.Add(str);

                message.IsBodyHtml = true;

                message.Body = sMessage;
                if (Attachment != null)
                {
                   
                    message.Attachments.Add(new Attachment(Attachment, filename));
                     
                }
                if (screenfile != null)
                {
                    
                    message.Attachments.Add(new Attachment(screenfile,"Screen.png"));
                    
                }

                if (System.Configuration.ConfigurationManager.AppSettings["issendmail"].ToString() == "1")
                    smtpClient.Send(message);

            }
            catch (Exception ex)
            {
                 
            }

        }

    }
}