using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using AdminLinq;
using System.Security.Permissions;

namespace Licensing
{
    public partial class HelpDesk : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

             if (!IsPostBack) 
            {
                int myloginID = Convert.ToInt32( Session["UID"].ToString() );
                using (AdminDataContext db = new AdminDataContext())
                {
                    Tbl_Login obj = db.Tbl_Logins.Where(c => c.loginID == myloginID).SingleOrDefault();
                    txtFirst.Text = obj.FirstName.ToString();
                    txtLast.Text = obj.LastName.ToString();
                    txtEmail.Text = obj.Email.ToString();
                }
            }



        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {

                if (txtEmail.Text != "")
                {
                string   imgName = "";
             
                    string strSubj = txtSubject.Text;
                    string path="", path1;
              
                    string strDesc = "A new ticket was submitted by: " + txtFirst.Text + " " + txtLast.Text + " ";
                strDesc += "on " + DateTime.Now + ".<br/><br/>";
                strDesc += "Type Selected: " + ddl_cattype.SelectedItem.Text + ".<br/><br/>";
                strDesc += "Page URL : " + hfdcurl.Value + ".<br/><br/>";
                strDesc += "Description of the ticket stated below:<br/><br/>" + txtDescr.Text;

                    string strFile = "";

                Stream istream = null;
                if (hfdimgdata.Value!="")
                {
                    
                   
                    byte[] imgByteArray = Convert.FromBase64String(hfdimgdata.Value.Replace("data:image/png;base64,",""));
                      istream = new MemoryStream(imgByteArray);
                   
                }
                if (FileUpload1.PostedFile.FileName != "")
                    {
                        
                        Mail.SendDeskMail( strSubj, strDesc, FileUpload1.PostedFile.InputStream, FileUpload1.FileName, istream);
                        
                    }
                    else
                    {
                        Mail.SendDeskMail( strSubj, strDesc,null,"", istream);
                    }
                //send the email with any attachment to teamworks help desk ticketing system
                //delet the file from temp folder
                //FileUpload1.Dispose();
                //using (System.IO.FileStream stream = System.IO.File.Open(path1, System.IO.FileMode.Open))
                //{

                //}

                }
                else
                {
                    //blerr.Text = "The answer you entered is wrong.";
                }
                altbox("Your request was submitted Successfully");
                Clear();
        }

        protected void btn_Clear_Click(object sender, EventArgs e)
        {
            Clear();
        }

        public List<Tbl_Login> logged_user(string username)
        {
            return AdminLinq.Admin.Get_Username(username);
        }

    
        #region Clear
        public void Clear()
        {
            //hfdlic.Value = "0";
            //txt_laterenewalfee.SelectedValue = "-1";
            ddl_cattype.SelectedValue = "-1";
            txtSubject.Text = "";
            txtFirst.Text = "";
            txtLast.Text = "";
            txtEmail.Text = "";
            txtDescr.Text = "";

          
          
        }
        #endregion




       private void  altbox(string str)
       {
           string js = "afterpost('" + str + "');";
           ScriptManager.RegisterStartupScript(Page, GetType(), "scr", js, true);
       }





    }
}