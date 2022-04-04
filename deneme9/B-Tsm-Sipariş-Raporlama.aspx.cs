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
    public partial class B_Tsm_Sipariş_Raporlama : System.Web.UI.Page
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
            string Reques = null;
            Reques = Request.QueryString["x"];
            Reques = Request.QueryString["y"];
            Reques = Request.QueryString["z"];
            if (Reques != null)
            {
                string Bas_Tar = Request.QueryString["x"];
                string Bit_Tar = Request.QueryString["y"];
                string TSM = Request.QueryString["z"];


                //---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
                SqlCommand cmd11 = new SqlCommand(" " +
                  "use kasa   " +
         
       
                  "select DISTINCT CAST(tar as date) as Ziy_Tar  from Sipariş_Genel where Olusturan_Kullanıcı =@Kullanıcı_Ad and CAST(Tar as date) between @Bas_Tar and @Bit_Tar  " +
      
                  "", SqlC.con);



                cmd11.Parameters.AddWithValue("@Kullanıcı_Ad", TSM);
                cmd11.Parameters.AddWithValue("@Gonderen_Kullanıcı", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd11.Parameters.AddWithValue("@Bas_Tar", Bas_Tar+" "+"00:00:00.000");
                cmd11.Parameters.AddWithValue("@Bit_Tar", Bit_Tar +" "+ "23:59:59.999");

                SqlDataAdapter sda11 = new SqlDataAdapter(cmd11);
                DataTable dt11 = new DataTable();
                sda11.Fill(dt11);
                Repeater1.DataSource = dt11;
                Repeater1.DataBind();
                SqlC.con.Close();

            }

        }


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
        public class Tabloları_Doldur_Doktor
        {
            public string Ziy_Tar { get; set; }
            public string Urun_Adı { get; set; }
            public string Adet { get; set; }
            public string Mf_Adet { get; set; }
            public string UrunKar_Yuzde { get; set; }
            public string Urun_Fiyat { get; set; }
            public string Eczane_Adı { get; set; }
            public string Brick { get; set; }
            public string Şehir { get; set; }
            public string Onay_Durum { get; set; }
            public string Birim_Fiyat { get; set; }
            public string Toplam { get; set; }
            public string Birim_Fiyat_Toplam { get; set; }
            public string Normal_Toplam { get; set; }
            public string Sipariş_Genel_Id { get; set; }
            public string Genel_Birim_Fiyat_Toplam { get; set; }
            public string Genel_Normal_Fiyat_Toplam { get; set; }

        }
        [System.Web.Services.WebMethod]
        public static string Tabloları_Doldur(string parametre)

        {
            string gelen_yıl = parametre.Split('*')[0];
            string gelen_ay = parametre.Split('*')[1];
            string Kullanıcı = parametre.Split('*')[2];
            var queryWithForJson = "use kasa   " +
                "select  Tar,UrunADI,Adet,Mf_Adet,UrunKar_Yuzde,UrunFiyat,Eczane_Adı,TownName,CityName,Onay_Durum,Siparis_Detay.Siparis_Genel_Id  " +
                ",( " +
                "select Sum(cast(((UrunFiyat/((UrunKar_Yuzde/100)+1))*(Adet)/((Adet)+(Mf_Adet))) as decimal(14,2))*(Adet+Mf_Adet)) from Siparis_Detay " +
                "inner join Urunler2 " +
                "on Siparis_Detay.Urun_Id=Urunler2.UrunID " +
                "where Siparis_Detay.Siparis_Genel_Id=Sipariş_Genel.Siparis_Genel_Id " +
                ")as Genel_Birim_Fiyat_Toplam , " +
                " ( " +
                "select sum((Adet+Mf_Adet)*UrunFiyat) from Siparis_Detay " +
                "inner join Urunler2 " +
                "on Siparis_Detay.Urun_Id=Urunler2.UrunID " +
                "where Siparis_Detay.Siparis_Genel_Id=Sipariş_Genel.Siparis_Genel_Id " +
                ")as Genel_Normal_Fiyat_Toplam " +
                "from Siparis_Detay  " +
                "inner join Sipariş_Genel  " +
                " on Siparis_Detay.Siparis_Genel_Id=Sipariş_Genel.Siparis_Genel_Id  " +
                "inner join Urunler2  " +
                "on Siparis_Detay.Urun_Id=Urunler2.UrunID  " +
                "inner join Eczane   " +
                " on Sipariş_Genel.Eczane_Id=Eczane.Eczane_Id " +
                "inner join Town  " +
                "on Eczane.Eczane_Brick=Town.TownID  " +
                "inner join City  " +
                " on Town.CityID=City.CityID  " +
                "where Sipariş_Genel.Olusturan_Kullanıcı=@Kullanıcı_Adı and CAST(Tar as date) between @baslagıc_Tar and @bitis_tar " +
                "" +

                "";


            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);
            conn.Open();
            cmd.Parameters.AddWithValue("@Kullanıcı_Adı", Kullanıcı);//@baslagıc_Tar//@bitis_tar
            cmd.Parameters.AddWithValue("@baslagıc_Tar", gelen_yıl + " " + "00:00:00.000");
            cmd.Parameters.AddWithValue("@bitis_tar", gelen_ay + " " + "23:59:59.999");



            List<Tabloları_Doldur_Doktor> tablo_Doldur_Classes = new List<Tabloları_Doldur_Doktor>();


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
                    var Birim_Fiyatlar = Birim_Fiyat_(reader.GetValue(4).ToString(), reader.GetValue(5).ToString(), reader.GetValue(2).ToString(), reader.GetValue(3).ToString());

                    var Tablo_Doldur_Class_ = new Tabloları_Doldur_Doktor
                    {
                        Ziy_Tar = reader.GetDateTime(0).ToString("yyyy-MM-dd"),
                        Urun_Adı = reader.GetValue(1).ToString(),
                        Adet = reader.GetValue(2).ToString(),
                        Mf_Adet = reader.GetValue(3).ToString(),
                        UrunKar_Yuzde = reader.GetValue(4).ToString(),
                        Urun_Fiyat = reader.GetValue(5).ToString(),
                        Eczane_Adı = reader.GetValue(6).ToString(),
                        Brick = reader.GetValue(7).ToString(),
                        Şehir = reader.GetValue(8).ToString(),
                        Onay_Durum = reader.GetValue(9).ToString(),

                        Birim_Fiyat = Birim_Fiyatlar.Birim_Fiyat___,
                        Toplam = Birim_Fiyatlar.Toplam,
                        Birim_Fiyat_Toplam = Birim_Fiyatlar.Satış_Fiyat_Toplam,
                        Normal_Toplam = Birim_Fiyatlar.Birim_Fiyat_Toplam,
                        Sipariş_Genel_Id = reader.GetValue(10).ToString(),
                        Genel_Birim_Fiyat_Toplam = reader.GetValue(11).ToString(),
                        Genel_Normal_Fiyat_Toplam = reader.GetValue(12).ToString(),
                    };
                    tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
                }
            }


            //  IEnumerable < Ziy_Onay_Tablo > tablo_Doldur_Classes_ = from x in tablo_Doldur_Classes where x.Ad == "10" select x;


            string a = JsonConvert.SerializeObject(from item in tablo_Doldur_Classes group item by item.Sipariş_Genel_Id);

            conn.Close();
            return a;


        }

        [System.Web.Services.WebMethod]
        public static string Ziyaret_Edilecekler(string parametre)
        {

            string gelen_yıl = parametre.Split('-')[0];
            string gelen_ay = parametre.Split('-')[1];


            DateTime tarih = new DateTime(Convert.ToInt32(gelen_yıl), Convert.ToInt32(gelen_ay), 1);
            DateTime tarih_son_gün = new DateTime(Convert.ToInt32(gelen_yıl), Convert.ToInt32(gelen_ay), 1);


            tarih_son_gün = new DateTime(tarih_son_gün.Year, tarih_son_gün.Month, 1);



            DateTime tarih_Bu_ayın_ilk_gunu = new DateTime(tarih.Year, tarih.Month, 1);



            var queryWithForJson = " SELECT format(Ziy_Tar,'dd'),(select count(*) from Ziyaret_Detay where Ziy_Gnl_ID=ID and Cins=1)as Ziyaret_Edilecek_Eczane,(select count(*) from Ziyaret_Detay where Ziy_Gnl_ID=ID and Cins=0)as Ziyaret_Edilecek_Doktor FROM Ziyaret_Genel   where Ziyaret_Genel.Kullanıcı_ID = (select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS              =@Kullanıcı_Adı) and Ziyaret_Genel.Ziy_Tar between @baslagıc_Tar and @bitis_tar";
            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);

            cmd.Parameters.AddWithValue("@Kullanıcı_Adı", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());//@baslagıc_Tar//@bitis_tar
            cmd.Parameters.AddWithValue("@baslagıc_Tar", Convert.ToString(tarih_Bu_ayın_ilk_gunu.ToString("yyyy-MM-dd")));
            cmd.Parameters.AddWithValue("@bitis_tar", Convert.ToString(tarih_son_gün.AddMonths(1).AddDays(-1).ToString("yyyy-MM-dd")));

            conn.Open();

            var reader = cmd.ExecuteReader();

            string a = "";
            while (reader.Read())
            {
                a += reader.GetValue(0).ToString() + "/" + reader.GetValue(1).ToString() + "/" + reader.GetValue(2).ToString() + "!";
            }


            if (a == "")

            {
                conn.Close();
                return "hata";
            }
            else
            {
                conn.Close();
                return a.Substring(0, a.Length - 1);
            }

        }
        public class Kullanıcı_Liste
        {
            public string Ad { get; set; }
            public string Soyad { get; set; }
            public string Kullanıcı_ID { get; set; }


        }
        [System.Web.Services.WebMethod]
        public static string Kullanıcı_Listesi(string Şehir_Id)
        {
            var queryWithForJson = "use kasa  " +
                "select AD,Soyad,KullanıcıID from Kullanıcı where Kullanıcı_Bogle=(select Kullanıcı_Bogle from Kullanıcı Where KullanıcıAD=@Kullanıcı_Ad) and Kullanıcı.Kullanıcı_Grup=4";

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
                        Ad = reader.GetValue(0).ToString(),
                        Soyad = reader.GetValue(1).ToString(),
                        Kullanıcı_ID = reader.GetValue(2).ToString(),



                    };
                    tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
                }
            }
            conn.Close();
            return JsonConvert.SerializeObject(tablo_Doldur_Classes);


        }

        public class Genel_Sorgu
        {
            public string Ziy_Tar { get; set; }
            public string Ziy_Tar_Str { get; set; }
            public string Cins { get; set; }
            public string Doktor_Ad { get; set; }
            public string Brans_Txt { get; set; }
            public string Unite_Txt { get; set; }
            public string TownName { get; set; }
            public string Eczane_Adı { get; set; }
            public string CityName { get; set; }
            public string Ziyaret_Durumu { get; set; }
            public string Urun_1 { get; set; }
            public string Urun_2 { get; set; }
            public string Urun_3 { get; set; }
            public string Ziyaret_Notu { get; set; }

        }

        [System.Web.Services.WebMethod]
        public static string Gun_Doldur(string Bas_Tar, string Bit_Tar, string TSM)
        {
            var queryWithForJson = "use kasa   " +
                "select Ziyaret_Genel.Ziy_Tar,Ziyaret_Detay.Cins,Doktor_Ad,Brans_Txt,Unite_Txt,TownName,Eczane_Adı,CityName, " +
                 "(select UrunADI from Urunler2 where UrunID=Calısılan_Urun_1), " +
                 "(select UrunADI from Urunler2 where UrunID=Calısılan_Urun_1), " +
                  "(select UrunADI from Urunler2 where UrunID=Calısılan_Urun_1), Ziyaret_Notu ,Ziyaret_Durumu    " +
                " from Ziyaret_Detay  " +
                "full join Ziyaret_Genel " +
                "on Ziyaret_Detay.Ziy_Gnl_Id=Ziyaret_Genel.ID " +
                "inner join Ziyaret_Onay " +
                "on Ziyaret_Genel.Ziyaret_Onay_Id=Ziyaret_Onay.Ziyaret_Onay_Id " +
                "full join Doktors " +
                "on Ziyaret_Detay.Doktor_Id=Doktors.Doktor_Id " +
                "full join Branchs " +
                "on Branchs.Brans_ID=Doktors.Doktor_Brans_Id " +
                "full join Unite " +
                "on Unite.Unite_ID=Doktors.Doktor_Unite_ID " +
                "full join Eczane " +
                "   on Ziyaret_Detay.Eczane_Id=Eczane.Eczane_Id  " +
                "full join Town " +
                "on Eczane.Eczane_Brick=Town.TownID or Unite.Brick__Id=TownID " +
                "full join City " +
                "on Town.CityID=City.CityID " +
                "where Ziyaret_Genel.Kullanıcı_ID=@Kullanıcı_Ad and Ziy_Tar between @Bas_Tar and @Bit_Tar " +
                "";


            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);
            conn.Open();
            cmd.Parameters.AddWithValue("@Kullanıcı_Ad", TSM);
            cmd.Parameters.AddWithValue("@Bas_Tar", Bas_Tar);
            cmd.Parameters.AddWithValue("@Bit_Tar", Bit_Tar);



            List<Genel_Sorgu> Genel_Sorgu_ = new List<Genel_Sorgu>();


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
                    var Genel_Sorgu__ = new Genel_Sorgu
                    {
                        Ziy_Tar = reader.GetDateTime(0).ToString("d-MM-yyyy"),
                        Ziy_Tar_Str = reader.GetDateTime(0).ToString("dddd/MMMM/yyyy"),
                        Cins = reader.GetValue(1).ToString(),
                        Doktor_Ad = reader.GetValue(2).ToString(),
                        Brans_Txt = reader.GetValue(3).ToString(),
                        Unite_Txt = reader.GetValue(4).ToString(),
                        TownName = reader.GetValue(5).ToString(),
                        Eczane_Adı = reader.GetValue(6).ToString(),
                        CityName = reader.GetValue(7).ToString(),
                        Urun_1 = reader.GetValue(8).ToString(),
                        Urun_2 = reader.GetValue(9).ToString(),
                        Urun_3 = reader.GetValue(10).ToString(),
                        Ziyaret_Notu = reader.GetValue(11).ToString(),
                        Ziyaret_Durumu = reader.GetValue(12).ToString(),


                    };
                    Genel_Sorgu_.Add(Genel_Sorgu__);
                }
            }




            string a = JsonConvert.SerializeObject(from item in Genel_Sorgu_ group item by item.Ziy_Tar);

            conn.Close();
            return a;


        }
    }
}