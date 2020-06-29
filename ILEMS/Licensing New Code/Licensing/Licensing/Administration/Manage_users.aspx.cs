using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Security.Cryptography;
using System.Web.Security;
using AdminLinq;

namespace Licensing.Administration
{
    public partial class manageusers : System.Web.UI.Page
    {


        private static int DEFAULT_MIN_PASSWORD_LENGTH = 8;

        private static int DEFAULT_MAX_PASSWORD_LENGTH = 10;

        private static string PASSWORD_CHARS_LCASE = "abcdefgijkmnopqrstwxyz";

        private static string PASSWORD_CHARS_UCASE = "ABCDEFGHJKLMNPQRSTWXYZ";

        private static string PASSWORD_CHARS_NUMERIC = "23456789";

        private static string PASSWORD_CHARS_SPECIAL = "*$_&";


        protected void Page_Load(object sender, EventArgs e)
        {
            BindDropBox();
        }

         
       private void testmethod()
        {
            //test method
        }

        public void BindDropBox()
        {
            if (!IsPostBack)
            {
               

                //password.Attributes.Add("style", "display:block");
                // valuelength.Attributes.Add("style", "display:block");
                
                Licensing.Complaints.utilities.BindDropdown(ddl_suffix, 12);
                 Licensing.Complaints.utilities.BindDropdown(ddl_usetype, 16);
                

            }

        }
        protected void btnedit_click(object sender, EventArgs e)
        {
            //password.Attributes.Add("style", "display:none");
            //valuelength.Attributes.Add("style", "display:none");
            
            string Value = hfdselid.Value;


            AdminLinq.Tbl_Login obj = adminUtilities.Edit_ManageUsers(Convert.ToInt32(Value));


            hfdautoid.Value = obj.loginID.ToString();
            txt_Firstname.Text = obj.FirstName;
            txt_Lastname.Text = obj.LastName;
            txt_middlename.Text = obj.MiddleName;

            txt_email.Text = obj.Email;

            string isstatus = "";
            isstatus = obj.isstatus;
            if (obj.isstatus == "True")
                chk_active.Checked = true;
            else
                chk_active.Checked = false;
            //if (chk_active.Checked = true)
            //    obj.isstatus = "True";
            //else
            //    obj.isstatus = "False";
            txt_expdate.Text =Convert.ToDateTime(obj.ExpireDate).ToShortDateString();
            txt_username.Text = obj.UserName;

            string usertypevalue = "";
            usertypevalue = obj.UserType.ToString();
            string suffex = "";
            suffex = obj.Suffix;

            ddl_suffix.ClearSelection();
            ddl_usetype.ClearSelection();

            if (ddl_suffix.Items[0].Text != suffex)
            {
                ddl_suffix.Items[0].Selected = false;
                if (ddl_suffix.Items.FindByText(suffex) != null)
                ddl_suffix.Items.FindByText(suffex).Selected = true;

            }

            if (ddl_usetype.Items[0].Text != usertypevalue)
            {
                ddl_usetype.Items[0].Selected = false;
                if (ddl_usetype.Items.FindByValue(usertypevalue) != null)
                ddl_usetype.Items.FindByValue(usertypevalue).Selected = true;
            }

            //ddl_usetype.SelectedValue = usertypevalue.ToString();

            // ddl_usetype.Items.FindByText(usertypevalue).Selected = true;



            string js = "popup();";
            ScriptManager.RegisterStartupScript(Page, GetType(), "scr", js, true);

        }
        protected void btndel_click(object sender, EventArgs e)
        {
            string Value = hfdselid.Value;
            DeleteUsers(Convert.ToInt32(Value));
           
             altbox("Record deleted successfully.");
        }
        protected void btn_Clear_Click(object sender, EventArgs e)
        {
            Clear();
        }

        public static void DeleteUsers(int loginid)
        {
            using (AdminDataContext db = new AdminDataContext())
            {
                Tbl_Login obj = db.Tbl_Logins.Where(c => c.loginID == loginid).SingleOrDefault();
                db.Tbl_Logins.DeleteOnSubmit(obj);
                db.SubmitChanges();
            }
        }

        protected void grd_pagechange(object sender, GridViewPageEventArgs e)
        {
           
        }

        #region To get Temporary password
        public static string Generate(int minLength, int maxLength)
        {

            // Make sure that input parameters are valid.
            if (minLength <= 0 || maxLength <= 0 || minLength > maxLength)
                return null;
            // Create a local array containing supported password characters
            // grouped by types. You can remove character groups from this
            // array, but doing so will weaken the password strength.
            char[][] charGroups = new char[][]

        {
            PASSWORD_CHARS_LCASE.ToCharArray(),
            PASSWORD_CHARS_UCASE.ToCharArray(),
            PASSWORD_CHARS_NUMERIC.ToCharArray(),
            PASSWORD_CHARS_SPECIAL.ToCharArray()
        };
            // Use this array to track the number of unused characters in each

            // character group.
            int[] charsLeftInGroup = new int[charGroups.Length];
            // Initially, all characters in each group are not used.

            for (int i = 0; i < charsLeftInGroup.Length; i++)
                charsLeftInGroup[i] = charGroups[i].Length;
            // Use this array to track (iterate through) unused character groups.

            int[] leftGroupsOrder = new int[charGroups.Length];
            // Initially, all character groups are not used.

            for (int i = 0; i < leftGroupsOrder.Length; i++)
                leftGroupsOrder[i] = i;
            byte[] randomBytes = new byte[4];
            // Generate 4 random bytes.
            RNGCryptoServiceProvider rng = new RNGCryptoServiceProvider();
            rng.GetBytes(randomBytes);
            // Convert 4 bytes into a 32-bit integer value.

            int seed = (randomBytes[0] & 0x7f) << 24 |

                        randomBytes[1] << 16 |

                        randomBytes[2] << 8 |

                        randomBytes[3];
            // Now, this is real randomization.

            Random random = new Random(seed);
            // This array will hold password characters.

            char[] password = null;

            // Allocate appropriate memory for the password.

            if (minLength < maxLength)

                password = new char[random.Next(minLength, maxLength + 1)];

            else

                password = new char[minLength];

            // Index of the next character to be added to password.

            int nextCharIdx;

            // Index of the next character group to be processed.

            int nextGroupIdx;

            // Index which will be used to track not processed character groups.

            int nextLeftGroupsOrderIdx;
            // Index of the last non-processed character in a group.

            int lastCharIdx;
            // Index of the last non-processed group.
            int lastLeftGroupsOrderIdx = leftGroupsOrder.Length - 1;
            // Generate password characters one at a time.
            for (int i = 0; i < password.Length; i++)
            {

                if (lastLeftGroupsOrderIdx == 0)

                    nextLeftGroupsOrderIdx = 0;
                else

                    nextLeftGroupsOrderIdx = random.Next(0, lastLeftGroupsOrderIdx);
                nextGroupIdx = leftGroupsOrder[nextLeftGroupsOrderIdx];

                // Get the index of the last unprocessed characters in this group.

                lastCharIdx = charsLeftInGroup[nextGroupIdx] - 1;
                if (lastCharIdx == 0)
                    nextCharIdx = 0;

                else

                    nextCharIdx = random.Next(0, lastCharIdx + 1);
                // Add this character to the password.

                password[i] = charGroups[nextGroupIdx][nextCharIdx];
                // If we processed the last character in this group, start over.

                if (lastCharIdx == 0)
                    charsLeftInGroup[nextGroupIdx] = charGroups[nextGroupIdx].Length;

                // There are more unprocessed characters left.

                else
                {

                    if (lastCharIdx != nextCharIdx)
                    {

                        char temp = charGroups[nextGroupIdx][lastCharIdx];
                        charGroups[nextGroupIdx][lastCharIdx] = charGroups[nextGroupIdx][nextCharIdx];
                        charGroups[nextGroupIdx][nextCharIdx] = temp;
                    }
                    charsLeftInGroup[nextGroupIdx]--;
                }



                // If we processed the last group, start all over.

                if (lastLeftGroupsOrderIdx == 0)

                    lastLeftGroupsOrderIdx = leftGroupsOrder.Length - 1;

                // There are more unprocessed groups left.

                else
                {

                    if (lastLeftGroupsOrderIdx != nextLeftGroupsOrderIdx)
                    {

                        int temp = leftGroupsOrder[lastLeftGroupsOrderIdx];

                        leftGroupsOrder[lastLeftGroupsOrderIdx] = leftGroupsOrder[nextLeftGroupsOrderIdx];

                        leftGroupsOrder[nextLeftGroupsOrderIdx] = temp;

                    }

                    // Decrement the number of unprocessed groups.

                    lastLeftGroupsOrderIdx--;

                }

            }

            // Convert password characters into a string and return the result.

            return new string(password);

        }
        #endregion

        protected void btn_submit_Click(object sender, EventArgs e)
        {
            if (hfdautoid.Value == "0")
            {
                string pass = FormsAuthentication.HashPasswordForStoringInConfigFile(txt_password.Text.ToString().Trim(), "SHA1");
                string status = "";
                if (chk_active.Checked == true)
                    status = "True";
                else
                    status = "False";
                adminUtilities.Insertion_ManageUsers(Convert.ToInt32(hfdautoid.Value), txt_Firstname.Text, txt_Lastname.Text, txt_middlename.Text, ddl_suffix.SelectedItem.Text, status, "1", txt_email.Text, txt_username.Text, pass, txt_expdate.Text, DateTime.Now.ToShortDateString(), "0", Convert.ToInt16(ddl_usetype.SelectedValue));
                Clear();
                //password.Attributes.Add("style", "display:block");
               
                 altbox("Record inserted successfully.");
            }
            else
            {
                string pass = FormsAuthentication.HashPasswordForStoringInConfigFile(txt_password.Text.ToString().Trim(), "SHA1");
                string status = "";
                if (chk_active.Checked == true)
                    status = "True";
                else
                    status = "False";
                adminUtilities.Insertion_ManageUsers(Convert.ToInt32(hfdautoid.Value), txt_Firstname.Text, txt_Lastname.Text, txt_middlename.Text, ddl_suffix.SelectedItem.Text, status, "1", txt_email.Text, txt_username.Text, pass, txt_expdate.Text, DateTime.Now.ToShortDateString(), "0", Convert.ToInt16(ddl_usetype.SelectedValue));
                Clear();
                //password.Attributes.Add("style", "display:block");
               
                 altbox("Record updated successfully.");
            }
        }

         


        protected void grd_manageusers_RowEditing(object sender, GridViewEditEventArgs e)
        {

        

        }

       public void Clear()
        {
            txt_confirmEmail.Text = "";
            txt_email.Text = "";
            txt_expdate.Text = "";
            txt_Firstname.Text = "";
            txt_Lastname.Text = "";
            txt_middlename.Text = "";
            txt_password.Text = "";
            txt_username.Text = "";
            ddl_suffix.SelectedValue = "-1";
            chk_active.Checked = false;
            ddl_usetype.SelectedValue = "-1";
            hfdautoid.Value = "0";
        }

       private void  altbox(string str)
       {
           string js = " afterpost('" + str + "');";
           ScriptManager.RegisterStartupScript(Page, GetType(), "scr", js, true);
       }
    }




}