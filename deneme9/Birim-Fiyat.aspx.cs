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
    public partial class Birim_Fiyat : System.Web.UI.Page
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
        public class Numune_Tablo
        {
            public string Performans { get; set; }
            public string Ziy_Bekeleyen_Dok { get; set; }
            public string Ziy_Edilen_Dok { get; set; }
            public string Ziy_Edilemeyen_Dok { get; set; }
            public string Ziy_Bekeleyen_Ecz { get; set; }
            public string Ziy_Edilen_Ecz { get; set; }
            public string Ziy_Edilemeyen_Ecz { get; set; }
            public string Bu_Gun_Ziy_Toplam { get; set; }
            public string Bu_Gun_Sip_Toplam { get; set; }
            public string Ad { get; set; }
            public string Soyad { get; set; }
            public string Grup_Tam_Ad { get; set; }
            public string Grup_Kısa_Ad { get; set; }
            public string Kullanıcı_Profil_Photo { get; set; }
            public string Kullanıcı_Id { get; set; }


        }
        [System.Web.Services.WebMethod]
        public static string Tablo_Doldur(string parametre)
        {

            var queryWithForJson = "use kasa " +

                "declare @Bu_Gun date= getdate(); " +
                "select  " +
                "cast( " +
                "(( " +
                "(nullif(( " +
                "select count(*) from Ziyaret_Detay  " +
                "inner join Ziyaret_Genel " +
                "on Ziyaret_Detay.Ziy_Gnl_Id=Ziyaret_Genel.ID " +
                "where Ziyaret_Detay.Kullanıcı_Id=Kullanıcı.KullanıcıID and Ziy_Tar between @Bas_Tar and @Bu_Gun and Ziyaret_Durumu=0),0) " +
                "+ " +
                "(nullif(( " +
                " select count(*) from Ziyaret_Detay  " +
                "inner join Ziyaret_Genel " +
                "on Ziyaret_Detay.Ziy_Gnl_Id=Ziyaret_Genel.ID " +
                "where Ziyaret_Detay.Kullanıcı_Id=Kullanıcı.KullanıcıID and Ziy_Tar between @Bas_Tar and @Bu_Gun and Ziyaret_Durumu=2),0) " +
                ") " +
                ")) " +
                "/ " +
                "(cast((cast(( " +
                "nullif(( " +
                " select count(*) from Ziyaret_Detay " +
                "inner join Ziyaret_Genel " +
                "on Ziyaret_Detay.Ziy_Gnl_Id=Ziyaret_Genel.ID " +
                "where Ziyaret_Detay.Kullanıcı_Id=Kullanıcı.KullanıcıID and Ziy_Tar between @Bas_Tar and @Bu_Gun),0) " +
                ") as decimal(14,2)))as decimal(14,2)))*100)as decimal(14,2) " +
                ")as Performans,( " +
                "select count(*) from Ziyaret_Detay " +
                "inner join Ziyaret_Genel " +
                "on Ziyaret_Detay.Ziy_Gnl_Id=Ziyaret_Genel.ID " +
                "where Ziyaret_Detay.Kullanıcı_Id=Kullanıcı.KullanıcıID and Ziy_Tar = @Bu_Gun and Ziyaret_Detay.Cins=0 and Ziyaret_Durumu=0 " +
                ") as Ziy_Bekleyen_Dok,( " +
                "select count(*) from Ziyaret_Detay " +
                "inner join Ziyaret_Genel " +
                "on Ziyaret_Detay.Ziy_Gnl_Id=Ziyaret_Genel.ID " +
                "where Ziyaret_Detay.Kullanıcı_Id=Kullanıcı.KullanıcıID and Ziy_Tar = @Bu_Gun and Ziyaret_Detay.Cins=0 and Ziyaret_Durumu=1 " +
                ")as Ziy_Edilen_Dok, ( " +
                "select count(*) from Ziyaret_Detay " +
                "inner join Ziyaret_Genel " +
                "on Ziyaret_Detay.Ziy_Gnl_Id=Ziyaret_Genel.ID " +
                "where Ziyaret_Detay.Kullanıcı_Id=Kullanıcı.KullanıcıID and Ziy_Tar = @Bu_Gun and Ziyaret_Detay.Cins=0 and Ziyaret_Durumu=2 " +
                ") as Ziy_Edilemeyen_Dok,( " +
                "select count(*) from Ziyaret_Detay " +
                "inner join Ziyaret_Genel " +
                "on Ziyaret_Detay.Ziy_Gnl_Id=Ziyaret_Genel.ID " +
                "where Ziyaret_Detay.Kullanıcı_Id=Kullanıcı.KullanıcıID and Ziy_Tar = @Bu_Gun and Ziyaret_Detay.Cins=1 and Ziyaret_Durumu=0 " +
                ") as Ziy_Bekleyen_Ecz,( " +
                "select count(*) from Ziyaret_Detay " +
                "inner join Ziyaret_Genel " +
                "on Ziyaret_Detay.Ziy_Gnl_Id=Ziyaret_Genel.ID " +
                "where Ziyaret_Detay.Kullanıcı_Id=Kullanıcı.KullanıcıID and Ziy_Tar = @Bu_Gun and Ziyaret_Detay.Cins=1 and Ziyaret_Durumu=1 " +
                ")as Ziy_Edilen_Ecz, ( " +
                "select count(*) from Ziyaret_Detay " +
                "inner join Ziyaret_Genel " +
                "on Ziyaret_Detay.Ziy_Gnl_Id=Ziyaret_Genel.ID " +
                "where Ziyaret_Detay.Kullanıcı_Id=Kullanıcı.KullanıcıID and Ziy_Tar = @Bu_Gun and Ziyaret_Detay.Cins=1 and Ziyaret_Durumu=2 " +
                ") as Ziy_Edilemeyen_Ecz,( " +
                "select count(*) from Ziyaret_Detay " +
                "inner join Ziyaret_Genel " +
                "on Ziyaret_Detay.Ziy_Gnl_Id=Ziyaret_Genel.ID " +
                "where Ziyaret_Detay.Kullanıcı_Id=Kullanıcı.KullanıcıID and Ziy_Tar = @Bu_Gun " +
                ")as Bugün_Ziyaret_Top, " +
                "( " +
                "select count(*) from Sipariş_Genel where Olusturan_Kullanıcı=Kullanıcı.KullanıcıID and cast(tar as date )= @Bu_Gun " +
                ")as Bugün_Sipariş_Top,AD,Soyad,Grup_Tam_Ad,Grup_Tam_Ad,Kullanıcı.Kullanıcı_Profil_Photo,Kullanıcı.KullanıcıID " +
                " from Kullanıcı  " +
                " inner join Gruplar  " +
                "on Kullanıcı.Kullanıcı_Grup=Grup_Id " +
                " where Kullanıcı_Bogle=(select Kullanıcı_Bogle from Kullanıcı where KullanıcıAD='recai')  order by Performans asc " +
                "" +
                "" +
                "" +
                "";
            DateTime Bu_Ayın_ılk_Gunu = DateTime.Now;
            DateTime Bu_Ayın_ılk_Gunu_ = new DateTime(Convert.ToInt32(Bu_Ayın_ılk_Gunu.Year), Convert.ToInt32(Bu_Ayın_ılk_Gunu.Month), 1);
            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);
            cmd.Parameters.AddWithValue("@Normal_Kullanıcı", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
            cmd.Parameters.AddWithValue("@Bas_Tar", Bu_Ayın_ılk_Gunu_.ToString("yyyy-MM-dd"));


            List<Numune_Tablo> tablo_Doldur_Classes = new List<Numune_Tablo>();

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
                    var Tablo_Doldur_Class_ = new Numune_Tablo
                    {
                        Performans = reader.GetValue(0).ToString(),

                        Ziy_Bekeleyen_Dok = reader.GetValue(1).ToString(),
                        Ziy_Edilen_Dok = reader.GetValue(2).ToString(),
                        Ziy_Edilemeyen_Dok = reader.GetValue(3).ToString(),


                        Ziy_Bekeleyen_Ecz = reader.GetValue(4).ToString(),
                        Ziy_Edilen_Ecz = reader.GetValue(5).ToString(),
                        Ziy_Edilemeyen_Ecz = reader.GetValue(6).ToString(),

                        Bu_Gun_Ziy_Toplam = reader.GetValue(7).ToString(),
                        Bu_Gun_Sip_Toplam = reader.GetValue(8).ToString(),


                        Ad = reader.GetValue(9).ToString(),
                        Soyad = reader.GetValue(10).ToString(),
                        Grup_Tam_Ad = reader.GetValue(11).ToString(),
                        Grup_Kısa_Ad = reader.GetValue(12).ToString(),
                        Kullanıcı_Profil_Photo = reader.GetValue(13).ToString(),
                        Kullanıcı_Id = reader.GetValue(14).ToString(),


                    };
                    tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
                }
            }
            return JsonConvert.SerializeObject(tablo_Doldur_Classes);


        }//Masrafı_Kaldır

        public class Grup_Id_Tablo
        {
            public string Grup_Id { get; set; }


        }
        [System.Web.Services.WebMethod]
        public static string Kullanıcı_Grup(string parametre)
        {

            var queryWithForJson = "use kasa   " +
                "select Kullanıcı_Grup from Kullanıcı where KullanıcıAD=@1" +

                "";

            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);
            conn.Open();
            cmd.Parameters.AddWithValue("@1", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());



            List<Grup_Id_Tablo> tablo_Doldur_Classes = new List<Grup_Id_Tablo>();


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
                    var Tablo_Doldur_Class_ = new Grup_Id_Tablo
                    {
                        Grup_Id = reader.GetValue(0).ToString(),
                    };
                    tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
                }
            }

            conn.Close();
            return JsonConvert.SerializeObject(tablo_Doldur_Classes);


        }
        public class Birim_Fiyat__
        {
            public string Toplam { get; set; }
            public string Birim_Fiyat___ { get; set; }
            public string Satış_Fiyat { get; set; }
            public string Birim_Fiyat_Toplam { get; set; }
            public string Satış_Fiyat_Toplam { get; set; }
        }
        [System.Web.Services.WebMethod]
        public static string Birim_Fiyat_(string Urun_Kar, string Urun_Fiyat, string Adet, string Mf_Adet)
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
                Satış_Fiyat_Toplam= Convert.ToDouble(Convert.ToDouble(Urun_Fiyat_) * Convert.ToDouble(Adet_ + Mf_Adet_)).ToString("#.#####")

            };

            return JsonConvert.SerializeObject(Tablo_Doldur_Class_);


        }
        public class İlaçlar
        {
            public string İlaç_Id { get; set; }
            public string İlaç_Adı { get; set; }
            public string İlaçresim { get; set; }
            public string Guncel_ISF { get; set; }
            public string Guncel_DSF { get; set; }
            public string KDV_Guncel_PSF { get; set; }
        }
        [System.Web.Services.WebMethod]
        public static string Urunler(string Şehir_Id)
        {
            var queryWithForJson = "use kasa select Urun_Id,Urun_Adı,Urun_Resim,Guncel_ISF,Guncel_DSF,KDV_Guncel_PSF from Urunler where Silinmismi=0  ";

            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);
            conn.Open();



            List<İlaçlar> tablo_Doldur_Classes = new List<İlaçlar>();


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
                    var Tablo_Doldur_Class_ = new İlaçlar
                    {
                        İlaç_Id = reader.GetValue(0).ToString(),
                        İlaç_Adı = reader.GetValue(1).ToString(),
                        İlaçresim = reader.GetValue(2).ToString(),
                        Guncel_ISF = reader.GetValue(3).ToString(),
                        Guncel_DSF = reader.GetValue(4).ToString(),
                        KDV_Guncel_PSF = reader.GetValue(5).ToString(),



                    };
                    tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
                }
            }
            conn.Close();
            return JsonConvert.SerializeObject(tablo_Doldur_Classes);


        }
    }
}