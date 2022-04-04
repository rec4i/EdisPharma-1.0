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
    public partial class Unite_Bazlı_Sipariş_Raporu : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public class Ziyaret_Edilen_Üniteler_Tablo
        {
            public string Unite_Id { get; set; }
            public string Unite_Text { get; set; }
      

        }

        [System.Web.Services.WebMethod]
        public static string Ziyaret_Edilen_Üniteler()
        {



            var queryWithForJson = "select Unite_Txt,Unite_ID from Ziyaret_Detay " +
            "" +
            "inner join Doktors " +
            "on Ziyaret_Detay.Doktor_Id=Doktors.Doktor_Id " +
            "" +
            "inner join Unite " +
            "on Doktors.Doktor_Unite_ID=Unite.Unite_ID " +
            "" +
            " where Kullanıcı_Id=(select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS = @Kullanıcı_Id) and Cins=0 group by Unite_Txt,Unite_ID ";


      




            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);
            cmd.Parameters.AddWithValue("@Kullanıcı_Id", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
        
            conn.Open();



            List<Ziyaret_Edilen_Üniteler_Tablo> tablo_Doldur_Classes = new List<Ziyaret_Edilen_Üniteler_Tablo>();
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

                   
                    var Tablo_Doldur_Class_ = new Ziyaret_Edilen_Üniteler_Tablo
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

        public class Unite_Çevresindeki_Eczaneler_Tablo
        {
            public string Eczane_Adı { get; set; }
            public string TownName { get; set; }
            public string CityName { get; set; }
            public string Eczane_Adres { get; set; }
            public string Eczane_Telefon { get; set; }
            public string Adet { get; set; }
            public string Mf_Adet { get; set; }
            public string Toplam { get; set; }
            public string Eczane_Id { get; set; }

        }

        [System.Web.Services.WebMethod]
        public static string Unite_Cevresindeki_Eczaneler(string Unite_Id, string Bas_Tar, string Bit_Tar) 
        {

            var queryWithForJson = "select Eczane_Adı,TownName,CityName,Eczane_Adres,Eczane_Telefon ," +
"" +
" (select count(*) from Sipariş_Genel where Sipariş_Genel.Eczane_Id=Eczane.Eczane_Id)" +
"" +
"  ,isnull((select sum(Adet) from Siparis_Detay where Siparis_Detay.Siparis_Genel_Id in (select Siparis_Genel_Id from Sipariş_Genel where Sipariş_Genel.Eczane_Id=Eczane.Eczane_Id and Tar between @Bas_Tar and @Bit_Tar)),0)" +
" ,isnull((select sum(Mf_Adet) from Siparis_Detay where Siparis_Detay.Siparis_Genel_Id in (select Siparis_Genel_Id from Sipariş_Genel where Sipariş_Genel.Eczane_Id=Eczane.Eczane_Id and Tar between @Bas_Tar and @Bit_Tar)),0)" +
" ,Eczane_Id " +
" " +
" from Eczane " +
"      " +
"            inner join City " +
"            on Eczane_Il=CityID " +
"            " +
"            inner join Town " +
"            on Eczane_Brick=TownID " +
"     " +
"            where Eczane_Id in (select Ünite_Etrafı_Eczane.Eczane_Id  from Ünite_Etrafı_Eczane where Unite_Id=@Unite_Id)";


       





            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);
            cmd.Parameters.AddWithValue("@Unite_Id", Unite_Id);
            cmd.Parameters.AddWithValue("@Bas_Tar", Bas_Tar);
            cmd.Parameters.AddWithValue("@Bit_Tar", Bit_Tar);
            conn.Open();



            List<Unite_Çevresindeki_Eczaneler_Tablo> tablo_Doldur_Classes = new List<Unite_Çevresindeki_Eczaneler_Tablo>();
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
                    var Tablo_Doldur_Class_ = new Unite_Çevresindeki_Eczaneler_Tablo
                    {
                        Eczane_Adı = reader.GetValue(0).ToString(),
                        TownName = reader.GetValue(1).ToString(),
                        CityName = reader.GetValue(2).ToString(),
                        Eczane_Adres = reader.GetValue(3).ToString(),
                        Eczane_Telefon = reader.GetValue(4).ToString(),
                        Adet = reader.GetValue(6).ToString(),
                        Mf_Adet = reader.GetValue(7).ToString(),
                        Toplam =  Convert.ToString(Convert.ToInt32(reader.GetValue(6).ToString()) + Convert.ToInt32(reader.GetValue(7).ToString())),
                        Eczane_Id = reader.GetValue(8).ToString(),
                        
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
        public static string Ünite_Çevresi_Eczaneler_İlaç_Bazlı(string Unite_Id, string Bas_Tar, string Bit_Tar)
        {



            var queryWithForJson = "select sum(Adet),sum(Mf_Adet),Urun_Adı,Urunler.Urun_Id,Guncel_DSF from Urunler " +
            "" +
            "inner join Siparis_Detay " +
            "on Siparis_Detay.Urun_Id=Urunler.Urun_Id " +
            "" +
            "inner join Sipariş_Genel " +
            "on Sipariş_Genel.Siparis_Genel_Id=Siparis_Detay.Siparis_Genel_Id " +
            "" +
            "where Sipariş_Genel.Eczane_Id in (select Ünite_Etrafı_Eczane.Eczane_Id  from Ünite_Etrafı_Eczane where Unite_Id=@Unite_Id) and Sipariş_Genel.Tar between @Bas_Tar and @Bit_Tar " +
            "" +
            "group by Urunler.Urun_Adı,Urunler.Urun_Id,Urunler.Guncel_DSF ";




            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);
            cmd.Parameters.AddWithValue("@Unite_Id", Unite_Id);
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
    }
}