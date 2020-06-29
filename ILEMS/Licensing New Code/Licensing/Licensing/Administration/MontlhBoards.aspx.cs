using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Licensing.Administration
{
    public partial class MontlhBoards : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btndel_click(object sender,EventArgs e)
        {
            AdminLinq.Admin.Deletemonthlyupdate(Convert.ToInt32(hfdselid.Value));
            ScriptManager.RegisterStartupScript(Page, GetType(), "js", "afterpost('Information deleted.')", true);
        }
    }
}