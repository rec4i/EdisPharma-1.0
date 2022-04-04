using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.AspNetCore.Authorization;
using Newtonsoft.Json;

namespace deneme9
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        [Authorize]
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        
        [System.Web.Services.WebMethod]
        public static string Kullanıcı_Adı_Soyadı(string parametre)
        {
            var queryWithForJson = "update Kullanıcı set Kullanıcı_Profil_Photo=@2 where KullanıcıID=2 ";
            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);
            cmd.Parameters.AddWithValue("@2", parametre);

            conn.Open();

            cmd.ExecuteNonQuery();
            conn.Close();


            return "";


        }
    }
}