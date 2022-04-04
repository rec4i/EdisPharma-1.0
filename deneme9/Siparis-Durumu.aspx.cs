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
    public partial class Siparis_Durumu : System.Web.UI.Page
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
            public string Eczane_Adı { get; set; }
            public string CityName { get; set; }
            public string TownName { get; set; }
            public string Tar { get; set; }
            public string Onay_Durum { get; set; }
            public string Siparis_Genel_Id { get; set; }
            public string Kullanıcı_Ad_Soyad { get; set; }
            public string İletim_Durum { get; set; }
            public string Onaylanmadıya_Düştümü { get; set; }
            public string Sipariş_Tekrar_Gönderlidimi { get; set; }
            public string Depo { get; set; }

        }
        [System.Web.Services.WebMethod]
        public static string Tablo_Verisi(string Tar_1, string Tar_2)
        {
            var queryWithForJson = "select Eczane_Adı,CityName,TownName,Tar,Onay_Durum,Siparis_Genel_Id,Kullanıcı.AD,Kullanıcı.Soyad,İletim_Durum,Onaylanmadıya_Düştümü,Sipariş_Tekrar_Gönderlidimi,Depo_Adı.Depo_Txt from Sipariş_Genel " +
                " inner join Eczane " +
                "on Sipariş_Genel.Eczane_Id=Eczane.Eczane_Id " +
                "inner join City " +
                "on Eczane.Eczane_Il=City.CityID " +
                "inner join Town " +
                "on Eczane.Eczane_Brick=Town.TownID " +
                 "inner join Kullanıcı " +

                "on Sipariş_Genel.Olusturan_Kullanıcı = Kullanıcı.KullanıcıID " +
                   " inner join Depo_Adı " +
                 " on Sipariş_Genel.Depo_Id=Depo_Adı.Depo_Id " +
                "where  Tar between @tar_1 and @tar_2 and Sipariş_Genel.Olusturan_Kullanıcı=(select KullanıcıID from Kullanıcı where KullanıcıAD COLLATE Latin1_general_CS_AS =@Kullanıcı_Ad)  order by Tar asc ";

            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);
            conn.Open();
            cmd.Parameters.AddWithValue("@Kullanıcı_Ad", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
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
                        Eczane_Adı = reader.GetValue(0).ToString(),
                        CityName = reader.GetValue(1).ToString(),
                        TownName = reader.GetValue(2).ToString(),
                        Tar = reader.GetDateTime(3).ToString("dd.MM.yyyy"),
                        Onay_Durum = reader.GetValue(4).ToString(),
                        Siparis_Genel_Id = reader.GetValue(5).ToString(),
                        Kullanıcı_Ad_Soyad = reader.GetValue(6).ToString() + " " + reader.GetValue(7).ToString(),
                        İletim_Durum = reader.GetValue(8).ToString(),
                        Onaylanmadıya_Düştümü = reader.GetValue(9).ToString(),
                        Sipariş_Tekrar_Gönderlidimi = reader.GetValue(10).ToString(),
                        Depo = reader.GetValue(11).ToString(),



                    };
                    tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
                }
            }
            conn.Close();
            return JsonConvert.SerializeObject(tablo_Doldur_Classes);


        }

       
        public class Sipariş_Detay_Liste
        {
            public string Urun_Adı { get; set; }
            public string Adet { get; set; }
            public string Mf_Adet { get; set; }
            public int Toplam { get; set; }
            public string Birim_Fiyat { get; set; }
            public string Satış_Fiyat { get; set; }
            public string Birim_Fiyat_Toplam { get; set; }
            public string Normal_Toplam { get; set; }

        }
        [System.Web.Services.WebMethod]
        public static string Tablo_Verisi_Red(string Tar_1, string Tar_2)
        {
            var queryWithForJson = "select Eczane_Adı,CityName,TownName,Tar,Onay_Durum,Siparis_Genel_Id from Sipariş_Genel " +
                "inner join Eczane " +
                "on Sipariş_Genel.Eczane_Id=Eczane.Eczane_Id " +
                "inner join City " +
                "on Eczane.Eczane_Il=City.CityID " +
                "inner join Town " +
                "on Eczane.Eczane_Brick=Town.TownID " +
                "where Sipariş_Genel.Olusturan_Kullanıcı=(select KullanıcıID from Kullanıcı where KullanıcıAD COLLATE Latin1_general_CS_AS =@Kullanıcı_Ad) and Tar between @tar_1 and @tar_2 and Onay_Durum = 2 order by Tar asc ";

            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);
            conn.Open();
            cmd.Parameters.AddWithValue("@Kullanıcı_Ad", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
            cmd.Parameters.AddWithValue("@tar_1", Tar_1);
            cmd.Parameters.AddWithValue("@tar_2", Tar_2);



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
                        Eczane_Adı = reader.GetValue(0).ToString(),
                        CityName = reader.GetValue(1).ToString(),
                        TownName = reader.GetValue(2).ToString(),
                        Tar = reader.GetDateTime(3).ToString("dd.MM.yyyy"),
                        Onay_Durum = reader.GetValue(4).ToString(),
                        Siparis_Genel_Id = reader.GetValue(5).ToString()

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
            var queryWithForJson = "select Eczane_Adı,CityName,TownName,Tar,Onay_Durum,Siparis_Genel_Id from Sipariş_Genel " +
                "inner join Eczane " +
                "on Sipariş_Genel.Eczane_Id=Eczane.Eczane_Id " +
                "inner join City " +
                "on Eczane.Eczane_Il=City.CityID " +
                "inner join Town " +
                "on Eczane.Eczane_Brick=Town.TownID " +
                "where Sipariş_Genel.Olusturan_Kullanıcı=(select KullanıcıID from Kullanıcı where KullanıcıAD COLLATE Latin1_general_CS_AS =@Kullanıcı_Ad) and Tar between @tar_1 and @tar_2 and Onay_Durum = 1 order by Tar asc ";

            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);
            conn.Open();
            cmd.Parameters.AddWithValue("@Kullanıcı_Ad", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
            cmd.Parameters.AddWithValue("@tar_1", Tar_1);
            cmd.Parameters.AddWithValue("@tar_2", Tar_2);



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
                        Eczane_Adı = reader.GetValue(0).ToString(),
                        CityName = reader.GetValue(1).ToString(),
                        TownName = reader.GetValue(2).ToString(),
                        Tar = reader.GetDateTime(3).ToString("dd.MM.yyyy"),
                        Onay_Durum = reader.GetValue(4).ToString(),
                        Siparis_Genel_Id = reader.GetValue(5).ToString()

                    };
                    tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
                }
            }
            conn.Close();
            return JsonConvert.SerializeObject(tablo_Doldur_Classes);


        }

        [System.Web.Services.WebMethod]
        public static string Sipariş_Detay(string Sipariş_ıd)
        {
            var queryWithForJson = "" +
                "select UrunADI,Adet,Mf_Adet,UrunFiyat,UrunKar_Yuzde from Siparis_Detay  " +
                "inner join Urunler2 " +
                "on Urunler2.UrunID=Siparis_Detay.Urun_Id " +
                "where Siparis_Genel_Id = @1";

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
                    var Birim_Fiyatlar = Birim_Fiyat_(reader.GetValue(4).ToString(), reader.GetValue(3).ToString(), reader.GetValue(1).ToString(), reader.GetValue(2).ToString());

                    var Tablo_Doldur_Class_ = new Sipariş_Detay_Liste
                    {
                        Urun_Adı = reader.GetValue(0).ToString(),
                        Adet = reader.GetValue(1).ToString(),
                        Mf_Adet = reader.GetValue(2).ToString(),
                        Toplam = Convert.ToInt32(reader.GetValue(1).ToString()) + Convert.ToInt32(reader.GetValue(2).ToString()),
                        Birim_Fiyat = Birim_Fiyatlar.Birim_Fiyat___,
                        Satış_Fiyat = Birim_Fiyatlar.Satış_Fiyat,
                        Birim_Fiyat_Toplam = Birim_Fiyatlar.Birim_Fiyat_Toplam,
                        Normal_Toplam=Birim_Fiyatlar.Satış_Fiyat_Toplam

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