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
    public partial class Eczane_Bazlı_Sipariş_Raporu : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        public class Ziyaret_Edilen_Eczaneler_Tablo
        {
            public string Unite_Id { get; set; }
            public string Unite_Text { get; set; }


        }

        [System.Web.Services.WebMethod]
        public static string Ziyaret_Edilen_Eczaneler()
        {



            var queryWithForJson = "select  Eczane_Adı,Ziyaret_Detay.Eczane_Id from Ziyaret_Detay " +
            "" +
            "inner join Eczane " +
            "on Ziyaret_Detay.Eczane_Id=Eczane.Eczane_Id " +
            "" +
            "where Cins=1 and Kullanıcı_Id=(select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS = @Kullanıcı_Id)  group by Eczane_Adı,Ziyaret_Detay.Eczane_Id";









            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);
            cmd.Parameters.AddWithValue("@Kullanıcı_Id", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
 
            conn.Open();



            List<Ziyaret_Edilen_Eczaneler_Tablo> tablo_Doldur_Classes = new List<Ziyaret_Edilen_Eczaneler_Tablo>();
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


                    var Tablo_Doldur_Class_ = new Ziyaret_Edilen_Eczaneler_Tablo
                    {
                        Unite_Text = reader.GetValue(0).ToString(),
                        Unite_Id = reader.GetValue(1).ToString(),


                    };
                    tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
                }
            }
            conn.Close();
            return JsonConvert.SerializeObject(tablo_Doldur_Classes);


        }
        public class Ünite_Çevresi_Eczaneler_İlaç_Bazlı_Tablo
        {
            public string Urun_Adı { get; set; }
            public string Adet { get; set; }
            public string Mf_Adet { get; set; }
            public string Toplam { get; set; }
            public string Güncel_Dsf { get; set; }
            public string Birim_Fiyat { get; set; }
            public string Satış_Fiyatı_Toplam { get; set; }
            public string Birim_Fiyatı_Toplam { get; set; }

        }

        [System.Web.Services.WebMethod]
        public static string Ünite_Çevresi_Eczaneler_İlaç_Bazlı(string Eczane_Id, string Bas_Tar, string Bit_Tar)
        {



            var queryWithForJson = "select sum(Adet),sum(Mf_Adet),Urun_Adı,Urunler.Urun_Id,Guncel_DSF from Urunler " +
            "" +
            "inner join Siparis_Detay " +
            "on Siparis_Detay.Urun_Id=Urunler.Urun_Id " +
            "" +
            "inner join Sipariş_Genel " +
            "on Sipariş_Genel.Siparis_Genel_Id=Siparis_Detay.Siparis_Genel_Id " +
            "" +
            "where Sipariş_Genel.Eczane_Id=@Eczane_Id  and Sipariş_Genel.Tar between @Bas_Tar and @Bit_Tar " +
            "" +
            "group by Urunler.Urun_Adı,Urunler.Urun_Id,Urunler.Guncel_DSF ";




            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);
            cmd.Parameters.AddWithValue("@Eczane_Id", Eczane_Id);
            cmd.Parameters.AddWithValue("@Bas_Tar", Bas_Tar);
            cmd.Parameters.AddWithValue("@Bit_Tar", Bit_Tar);
            conn.Open();



            List<Ünite_Çevresi_Eczaneler_İlaç_Bazlı_Tablo> tablo_Doldur_Classes = new List<Ünite_Çevresi_Eczaneler_İlaç_Bazlı_Tablo>();
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

                    var Fiyat = Birim_Fiyat_Hesapla(reader.GetValue(4).ToString(), reader.GetValue(0).ToString(), reader.GetValue(1).ToString());
                    var Tablo_Doldur_Class_ = new Ünite_Çevresi_Eczaneler_İlaç_Bazlı_Tablo
                    {
                        Urun_Adı = reader.GetValue(2).ToString(),
                        Adet = reader.GetValue(0).ToString(),
                        Mf_Adet = reader.GetValue(1).ToString(),
                        Güncel_Dsf = reader.GetValue(4).ToString(),
                        Toplam = Convert.ToString(Convert.ToInt32(reader.GetValue(0).ToString()) + Convert.ToInt32(reader.GetValue(1).ToString())),
                        Birim_Fiyat = Fiyat.Birim_Fiyat,
                        Satış_Fiyatı_Toplam = Fiyat.Satış_Fiyatı_Toplam,
                        Birim_Fiyatı_Toplam = Fiyat.Birim_Fiyatı_Toplam,

                    };
                    tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
                }
            }
            conn.Close();
            return JsonConvert.SerializeObject(tablo_Doldur_Classes);


        }
        public class Birim_Fiyat_Tablo
        {
            public string Birim_Fiyat { get; set; }
            public string Satış_Fiyatı_Toplam { get; set; }
            public string Birim_Fiyatı_Toplam { get; set; }


        }
        [System.Web.Services.WebMethod]
        public static Birim_Fiyat_Tablo Birim_Fiyat_Hesapla(string Guncel_DSF, string Adet, string Mf_Adet)
        {




            double Birim_Fiyat_ = Convert.ToDouble((Convert.ToDouble(Guncel_DSF) * Convert.ToDouble(Adet)) / (Convert.ToDouble(Adet) + Convert.ToDouble(Mf_Adet)));



            var Tablo_Doldur_Class_ = new Birim_Fiyat_Tablo
            {
                Birim_Fiyat = Birim_Fiyat_.ToString("#.##"),
                Birim_Fiyatı_Toplam = (Birim_Fiyat_ * (Convert.ToDouble(Adet) + Convert.ToDouble(Mf_Adet))).ToString("#.##"),
                Satış_Fiyatı_Toplam = (Convert.ToDouble(Guncel_DSF) * (Convert.ToDouble(Adet) + Convert.ToDouble(Mf_Adet))).ToString("#.##"),

            };



            return Tablo_Doldur_Class_;



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

        }
        [System.Web.Services.WebMethod]
        public static string Sipariş_Bazlı_Rapor(string Eczane_Id,string Tar_1, string Tar_2)
        {
            var queryWithForJson = "select Eczane_Adı,CityName,TownName,Tar,Onay_Durum,Siparis_Genel_Id,Kullanıcı.AD,Kullanıcı.Soyad,İletim_Durum,Onaylanmadıya_Düştümü,Sipariş_Tekrar_Gönderlidimi from Sipariş_Genel " +
                "inner join Eczane " +
                "on Sipariş_Genel.Eczane_Id=Eczane.Eczane_Id " +
                "inner join City " +
                "on Eczane.Eczane_Il=City.CityID " +
                "inner join Town " +
                "on Eczane.Eczane_Brick=Town.TownID " +
                 "inner join Kullanıcı " +
                "on Sipariş_Genel.Olusturan_Kullanıcı = Kullanıcı.KullanıcıID " +
                "where  Tar between @tar_1 and @tar_2 and Sipariş_Genel.Eczane_Id=@Eczane_Id order by Tar asc ";

            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);
            conn.Open();

            cmd.Parameters.AddWithValue("@tar_1", Tar_1 + " " + "00:00:00.000");
            cmd.Parameters.AddWithValue("@tar_2", Tar_2 + " " + "23:59:59.999");
            cmd.Parameters.AddWithValue("@Eczane_Id", Eczane_Id);



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



                    };
                    tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
                }
            }
            conn.Close();
            return JsonConvert.SerializeObject(tablo_Doldur_Classes);


        }
    }
}