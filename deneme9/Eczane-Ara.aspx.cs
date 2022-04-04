using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json;

namespace deneme9
{
    public partial class Eczane_Ara : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["kullanici"] != null)
            {

                //Response.Write("Hoşgeldin " + Session["kullanici"]);
                SqlC.con.Close();
            }
            else
            {
                 
                SqlC.con.Close();
            }


        }
        public  class Eczane_Listesi_Class
        {
            public string Eczane_Id { get; set; }
            public string Eczane_Adı { get; set; }
            
        }
        [System.Web.Services.WebMethod]
        public static string Eczane_Adı_Listesi(string Eczane_Liste_Id,string Eczane_Brick_Id)
        {
            var queryWithForJson = "select Eczane_Adı,Eczane_Liste.Eczane_Id from Eczane_Liste " +
                "inner join Eczane " +
                "on Eczane_Liste.Eczane_Id=Eczane.Eczane_Id where Eczane_Liste.Liste_Id=@1 and Eczane.Eczane_Brick=@2  and Eczane_Liste.Silinmismi=0 and Eczane_Liste.Silinmismi=0 ";
             
            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);

            cmd.Parameters.AddWithValue("@1", Eczane_Liste_Id);
            cmd.Parameters.AddWithValue("@2", Eczane_Brick_Id);



            List<Eczane_Listesi_Class> tablo_Doldur_Classes = new List<Eczane_Listesi_Class>();

            conn.Open();

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
                    var Tablo_Doldur_Class_ = new Eczane_Listesi_Class
                    {
                        Eczane_Adı = reader.GetValue(0).ToString(),
                        Eczane_Id = reader.GetValue(1).ToString(),
                     
                    };
                    tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
                }
            }
            conn.Close();
            return JsonConvert.SerializeObject(tablo_Doldur_Classes);



        }
        [System.Web.Services.WebMethod]
        public static string Eczane_Adı_Listesi_Seçmesiz(string Eczane_Liste_Id, string Eczane_Brick_Id)
        {
            var queryWithForJson = "select Eczane_Adı,Eczane_Id from Eczane " +
                " " +
                " where  Eczane_Brick=@2  order by Eczane_Adı asc";

            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);

            cmd.Parameters.AddWithValue("@1", Eczane_Liste_Id);
            cmd.Parameters.AddWithValue("@2", Eczane_Brick_Id);



            List<Eczane_Listesi_Class> tablo_Doldur_Classes = new List<Eczane_Listesi_Class>();

            conn.Open();

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
                    var Tablo_Doldur_Class_ = new Eczane_Listesi_Class
                    {
                        Eczane_Adı = reader.GetValue(0).ToString(),
                        Eczane_Id = reader.GetValue(1).ToString(),

                    };
                    tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
                }
            }
            conn.Close();
            return JsonConvert.SerializeObject(tablo_Doldur_Classes);



        }

        public class Eczane_Listleri_
        {
            public string Liste_Id { get; set; }
            public string  Lİste_Adı { get; set; }
        }
        [System.Web.Services.WebMethod]
        public static string Eczane_Listeleri(string parametre)
        {
            //select * from listeler where Kullanıcı_Id=(select KullanıcıID from Kullanıcı where KullanıcıAD='recai') and cins = 0
            var queryWithForJson = "use kasa select Liste_Id,Liste_Ad from listeler where Kullanıcı_Id=(select KullanıcıID from Kullanıcı where KullanıcıAD COLLATE Latin1_general_CS_AS ='" + FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString() + "') and cins = 1 ";
            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);


            List<Eczane_Listleri_> tablo_Doldur_Classes = new List<Eczane_Listleri_>();

            conn.Open();

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
                    var Tablo_Doldur_Class_ = new Eczane_Listleri_
                    {
                        Liste_Id = reader.GetValue(0).ToString(),
                        Lİste_Adı = reader.GetValue(1).ToString(),

                    };
                    tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
                }
            }
            conn.Close();
            return JsonConvert.SerializeObject(tablo_Doldur_Classes);

          
        }

        public class Şehir
        {
            public string Şehir_Id { get; set; }
            public string Şehir_Adı { get; set; }
        }
        [System.Web.Services.WebMethod]
        public static string Şehir_Listesi(string parametre)
        {
            var queryWithForJson = "use kasa select CityID,CityName from city ";
            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);
            conn.Open();


           

            List<Şehir> tablo_Doldur_Classes = new List<Şehir>();


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
                    var Tablo_Doldur_Class_ = new Şehir
                    {
                        Şehir_Id = reader.GetValue(0).ToString(),
                        Şehir_Adı = reader.GetValue(1).ToString(),

                    };
                    tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
                }
            }
            conn.Close();
            return JsonConvert.SerializeObject(tablo_Doldur_Classes);


        }//
        public class Brick
        {
            public string Brick_Id { get; set; }
            public string Brick_Adı { get; set; }
        }
        [System.Web.Services.WebMethod]
        public static string Brick_Listesi(string Şehir_Id)
        {
            var queryWithForJson = "use kasa select* from Town where CityID = @1 ";

            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);
            cmd.Parameters.AddWithValue("@1", Şehir_Id);
            conn.Open();




            List<Brick> tablo_Doldur_Classes = new List<Brick>();


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
                    var Tablo_Doldur_Class_ = new Brick
                    {
                        Brick_Id = reader.GetValue(0).ToString(),
                        Brick_Adı = reader.GetValue(2).ToString(),

                    };
                    tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
                }
            }
            conn.Close();
            return JsonConvert.SerializeObject(tablo_Doldur_Classes);


        }
    }
}