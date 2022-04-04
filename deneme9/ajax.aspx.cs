using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace deneme9
{
    public partial class ajax : System.Web.UI.Page
    {
       
        [System.Web.Services.WebMethod]
        public static string OrnekPost(string parametre)
        {
            return parametre ;
        }
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        
    }
}