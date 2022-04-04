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
    public partial class Uniteye_Branş_Ekle : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        public class Kullanıcı_Liste
        {
            public string Branş_Id { get; set; }
            public string Branş_Txt { get; set; }
         


        }
        [System.Web.Services.WebMethod]
        public static string Branş_Listesi(string Şehir_Id)
        {
            var queryWithForJson = "use kasa  " +
                "select * from Branchs";

            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);
            conn.Open();
            cmd.Parameters.AddWithValue("@Kullanıcı_Ad", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());



            List<Kullanıcı_Liste> tablo_Doldur_Classes = new List<Kullanıcı_Liste>();


            var jsonResult = new StringBuilder();
            var reader = cmd.ExecuteReader();
            if (!reader.HasRows)
            {
                jsonResult.Append("[]");
            }
            else
            {
                while (reader.Read())
                {
                    var Tablo_Doldur_Class_ = new Kullanıcı_Liste
                    {
                        Branş_Id = reader.GetValue(0).ToString(),
                        Branş_Txt = reader.GetValue(1).ToString(),
                    

                    };
                    tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
                }
            }
            conn.Close();
            return JsonConvert.SerializeObject(tablo_Doldur_Classes);


        }
        [System.Web.Services.WebMethod]
        public static string Branşı_Ekle(string İl, string Brick, string Ünite_Adı, string Doktor_Liste_Brans)
        {
            var queryWithForJson = "use kasa  " +
                "if not exists(select * from Unite_Branş_Liste where Unite_Id=@Unite_Id and Branş_Id=@Branş_Id) " +
                "begin;" +
                "insert into Unite_Branş_Liste (Unite_Id,Branş_Id) " +
                "values(@Unite_Id,@Branş_Id) " +
                "end; " +
                "";

            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);
            conn.Open();
            cmd.Parameters.AddWithValue("@Kullanıcı_Ad", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());

            cmd.Parameters.AddWithValue("@Unite_Id", Ünite_Adı);
            cmd.Parameters.AddWithValue("@Branş_Id", Doktor_Liste_Brans);





            var jsonResult = new StringBuilder();
            var reader = cmd.ExecuteReader();
            if (!reader.HasRows)
            {
                jsonResult.Append("[]");
            }
            else
            {
                while (reader.Read())
                {

                }
            }
            conn.Close();
            return "1";


        }
    }
}