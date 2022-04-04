using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace deneme9
{
    public partial class Unite_Ekle : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
       
        [System.Web.Services.WebMethod]
        public static string Unite_Ekle_Yeni(string İl, string Brick, string Ünite_Adı)
        {
            var queryWithForJson = "use kasa  " +
                "insert into Unite(İl_Id,Brick__Id,Unite_Txt) " +
                "values (@İl_ıd,@Brick,@Ünite_Adı)" +
                "";

            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);
            conn.Open();
            cmd.Parameters.AddWithValue("@Kullanıcı_Ad", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());


            cmd.Parameters.AddWithValue("@İl_ıd", İl);
            cmd.Parameters.AddWithValue("@Brick", Brick);
            cmd.Parameters.AddWithValue("@Ünite_Adı", Ünite_Adı);


            




            var jsonResult = new StringBuilder();
            var reader = cmd.ExecuteReader();
            if (!reader.HasRows)
            {

                jsonResult.Append("[]");
                conn.Close();

                return "0";

            }
            else
            {
                conn.Close();
                return "1";
            }
          
           


        }
    }
}