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
    public partial class Meteryal_Talebi_Onay : System.Web.UI.Page
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
        [System.Web.Services.WebMethod]
        public static string Onay_Durumu_Güncelle(string Sipariş_Id, string islem)
        {
            var queryWithForJson = "" +
                "update Materyal_Talep_Genel set Onay_Durumu = @1 where Materyal_Talep_Genel.Materyal_Talep_Genel_Id=@2 " +
                "";


            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);
            conn.Open();
            cmd.Parameters.AddWithValue("@1", islem);
            cmd.Parameters.AddWithValue("@2", Sipariş_Id);






            var reader = cmd.ExecuteNonQuery();

            conn.Close();
            return "0";
        }
        [System.Web.Services.WebMethod]
        public static string Sipariş_İptal_Talep(string Sipariş_Id)
        {
            var queryWithForJson = "if not exists (select * from Sipariş_İptal_Talep where Sipariş_Id=@1) " +
                "begin " +
                "insert into Sipariş_İptal_Talep (Sipariş_Id,Talebi_Olusturan_Kullanıcı,Olusturulma_Tar) values (@1,(select KullanıcıID from Kullanıcı where KullanıcıAD COLLATE Latin1_general_CS_AS =@Kullanıcı_Ad),GETDATE()) " +
                "end";

            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);
            conn.Open();
            cmd.Parameters.AddWithValue("@Kullanıcı_Ad", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
            cmd.Parameters.AddWithValue("@1", Sipariş_Id);






            var reader = cmd.ExecuteNonQuery();

            conn.Close();
            return "0";
        }
        public class Sipariş_Genel_Liste
        {
            public string Kullanıcı_Ad { get; set; }
            public string Tar { get; set; }
            public string Onay_Durum { get; set; }
            public string Materyal_Talep_Genel_Id { get; set; }
    

        }
        [System.Web.Services.WebMethod]
        public static string Tablo_Verisi(string Tar_1, string Tar_2)
        {
            var queryWithForJson = "select AD,Soyad,Oluşturulma_Tar,Onay_Durumu,Materyal_Talep_Genel_Id from Materyal_Talep_Genel  " +
                "inner join Kullanıcı " +
                "on Kullanıcı.KullanıcıID=Materyal_Talep_Genel.Kullanıcı_Id " +
                "where CAST(Oluşturulma_Tar as date) between @tar_1 and @tar_2  order by Oluşturulma_Tar asc ";

            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);
            conn.Open();

            cmd.Parameters.AddWithValue("@tar_1", Tar_1 + " " + "00:00:00.000");
            cmd.Parameters.AddWithValue("@tar_2", Tar_2 + " " + "23:59:59.999");



            List<Sipariş_Genel_Liste> tablo_Doldur_Classes = new List<Sipariş_Genel_Liste>();


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
                    var Tablo_Doldur_Class_ = new Sipariş_Genel_Liste
                    {
                        Kullanıcı_Ad = reader.GetValue(0).ToString()+ " "+ reader.GetValue(1).ToString(),
                        Tar = reader.GetDateTime(2).ToString("dd.MM.yyyy"),
                        Onay_Durum = reader.GetValue(3).ToString(),
                        Materyal_Talep_Genel_Id = reader.GetValue(4).ToString(),
                

                    };
                    tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
                }
            }
            conn.Close();
            return JsonConvert.SerializeObject(tablo_Doldur_Classes);


        }
        
        [System.Web.Services.WebMethod]
        public static string Tablo_Verisi_Red(string Tar_1, string Tar_2)
        {
            var queryWithForJson = "select AD,Soyad,Oluşturulma_Tar,Onay_Durumu,Materyal_Talep_Genel_Id from Materyal_Talep_Genel  " +
                "inner join Kullanıcı " +
                "on Kullanıcı.KullanıcıID=Materyal_Talep_Genel.Kullanıcı_Id " +

                "where CAST(Oluşturulma_Tar as date) between @tar_1 and @tar_2 and Onay_Durumu = 2 order by Oluşturulma_Tar asc ";

            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);
            conn.Open();
            cmd.Parameters.AddWithValue("@tar_1", Tar_1 + " " + "00:00:00.000");
            cmd.Parameters.AddWithValue("@tar_2", Tar_2 + " " + "23:59:59.999");



            List<Sipariş_Genel_Liste> tablo_Doldur_Classes = new List<Sipariş_Genel_Liste>();


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
                    var Tablo_Doldur_Class_ = new Sipariş_Genel_Liste
                    {
                        Kullanıcı_Ad = reader.GetValue(0).ToString() + " " + reader.GetValue(1).ToString(),
                        Tar = reader.GetDateTime(2).ToString("dd.MM.yyyy"),
                        Onay_Durum = reader.GetValue(3).ToString(),
                        Materyal_Talep_Genel_Id = reader.GetValue(4).ToString(),

                    };
                    tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
                }
            }
            conn.Close();
            return JsonConvert.SerializeObject(tablo_Doldur_Classes);


        }
        [System.Web.Services.WebMethod]
        public static string Tablo_Verisi_Onaylanan(string Tar_1, string Tar_2)
        {
            var queryWithForJson = "" +
                "select AD,Soyad,Oluşturulma_Tar,Onay_Durumu,Materyal_Talep_Genel_Id from Materyal_Talep_Genel  " +
                "inner join Kullanıcı " +
                "on Kullanıcı.KullanıcıID=Materyal_Talep_Genel.Kullanıcı_Id " +

                "where CAST(Oluşturulma_Tar as date) between @tar_1 and @tar_2 and Onay_Durumu = 1 order by Oluşturulma_Tar asc ";

            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);
            conn.Open();

            cmd.Parameters.AddWithValue("@tar_1", Tar_1 + " " + "00:00:00.000");
            cmd.Parameters.AddWithValue("@tar_2", Tar_2 + " " + "23:59:59.999");



            List<Sipariş_Genel_Liste> tablo_Doldur_Classes = new List<Sipariş_Genel_Liste>();


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
                    var Tablo_Doldur_Class_ = new Sipariş_Genel_Liste
                    {
                        Kullanıcı_Ad = reader.GetValue(0).ToString() + " " + reader.GetValue(1).ToString(),
                        Tar = reader.GetDateTime(2).ToString("dd/MM/yyyy"),
                        Onay_Durum = reader.GetValue(3).ToString(),
                        Materyal_Talep_Genel_Id = reader.GetValue(4).ToString(),

                    };
                    tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
                }
            }
            conn.Close();
            return JsonConvert.SerializeObject(tablo_Doldur_Classes);


        }
        public class Sipariş_Detay_Liste
        {
            public string Materyal_Talep_Detay_Id { get; set; }
            public string Materyal_Talep_Genel_Id { get; set; }
            public string Materyal_Talebi_Tip_txt { get; set; }
            public string Urun { get; set; }
            public string Adet { get; set; }
  

        }
        [System.Web.Services.WebMethod]
        public static string Sipariş_Detay(string Sipariş_ıd)
        {
            var queryWithForJson = "" +
                "select Materyal_Talep_Detay_Id,Materyal_Talep_Genel_Id,Materyal_Talebi_Tip_txt,( " +
                "case  " +
                "when Cins=0 then(select UrunADI from Urunler2 where UrunID=Urun_Id) " +
                "when Cins=1 then(select UrunADI from Urunler2 where UrunID=Urun_Id) " +
                "when Cins=2 then(select Promosyon_Txt from Promosyon where Promosyon_Id=Urun_Id) " +
                "end " +
                ")as Urun ,Adet from Materyal_Talep_Detay  " +
                "inner join Materyal_Talep_Tip " +
                "on Materyal_Talep_Tip.Materyal_Talebi_Tip_Id=Cins+1 " +
                "" +

                "where Materyal_Talep_Genel_Id = @1";

            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);
            conn.Open();
            cmd.Parameters.AddWithValue("@1", Sipariş_ıd);




            List<Sipariş_Detay_Liste> tablo_Doldur_Classes = new List<Sipariş_Detay_Liste>();


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
                    

                    var Tablo_Doldur_Class_ = new Sipariş_Detay_Liste
                    {
                        Materyal_Talep_Detay_Id = reader.GetValue(0).ToString(),
                        Materyal_Talep_Genel_Id = reader.GetValue(1).ToString(),
                        Materyal_Talebi_Tip_txt = reader.GetValue(2).ToString(),
                        Urun = reader.GetValue(3).ToString(),
                        Adet = reader.GetValue(4).ToString()


                    };
                    tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
                }
            }
            conn.Close();
            return JsonConvert.SerializeObject(tablo_Doldur_Classes);


        }
        [System.Web.Services.WebMethod]
        public static string Kullanıcı_Adı_Soyadı(string parametre)
        {
            var queryWithForJson = "(select AD,Soyad from Kullanıcı where KullanıcıAD COLLATE Latin1_general_CS_AS ='" + FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString() + "') ";
            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);


            conn.Open();

            var reader = cmd.ExecuteReader();

            string a = "";
            while (reader.Read())
            {
                a += reader.GetValue(0).ToString() + " " + reader.GetValue(1).ToString() + "!";
            }
            if (a == "")
            {
                conn.Close();

                return "0-Hiç Veri Bulunamadı Lütfen";
            }
            else
            {
                conn.Close();

                return a.Substring(0, a.Length - 1);

            }


        }//Numune_Talebi_Kaldır
        public class Birim_Fiyat__
        {
            public string Toplam { get; set; }
            public string Birim_Fiyat___ { get; set; }
            public string Satış_Fiyat { get; set; }
            public string Birim_Fiyat_Toplam { get; set; }
            public string Satış_Fiyat_Toplam { get; set; }
        }
        public static Birim_Fiyat__ Birim_Fiyat_(string Urun_Kar, string Urun_Fiyat, string Adet, string Mf_Adet)
        {

            double Urun_Fiyat_ = Convert.ToDouble(Urun_Fiyat);
            double Urun_Kar_ = Convert.ToDouble(Urun_Kar);
            double Adet_ = Convert.ToDouble(Adet);
            double Mf_Adet_ = Convert.ToDouble(Mf_Adet);



            double birimfiyat = (Convert.ToDouble(Urun_Fiyat_) / ((Convert.ToDouble(Urun_Kar_) / 100) + 1)) * (Convert.ToDouble(Adet_)) / (Convert.ToDouble(Mf_Adet_) + Convert.ToDouble(Adet_));

            string a = birimfiyat.ToString("#.##");

            var Tablo_Doldur_Class_ = new Birim_Fiyat__
            {
                Toplam = (Adet_ + Mf_Adet_).ToString(),
                Birim_Fiyat___ = a,
                Satış_Fiyat = Urun_Fiyat,
                Birim_Fiyat_Toplam = Convert.ToDouble(Convert.ToDouble(a) * Convert.ToDouble(Adet_ + Mf_Adet_)).ToString("#.#####"),
                Satış_Fiyat_Toplam = Convert.ToDouble(Convert.ToDouble(Urun_Fiyat_) * Convert.ToDouble(Adet_ + Mf_Adet_)).ToString("#.#####")

            };

            return Tablo_Doldur_Class_;



        }
    }
}