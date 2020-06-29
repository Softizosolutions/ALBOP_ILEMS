using Person_Details;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
namespace Licensing
{
    public partial class albopdisp : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            var resset = Person_Details.Licensing_Details.GetDisciplinaryFindingFiles();
            StringBuilder stb = new StringBuilder();
            foreach(USPGetDisciplinaryFindingFilesResult r in resset)
            {
                stb.Append("<p><b>"+r.Filename+"&nbsp;</b><a href='"+r.DocumentPath+"' target='_blank'><i class='fa fa-file-pdf-o' style='color:red'></i></a>        </p> ");
                stb.AppendLine();

            }
            Response.Write(stb.ToString());
        }
    }
}