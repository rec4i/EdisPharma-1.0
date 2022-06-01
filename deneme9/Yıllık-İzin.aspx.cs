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
    public partial class Yıllık_İzin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        public class Kullanıcı_Liste
        {
            public string Geçen_Yıldan_Devreden_İzin_Süresi { get; set; }
            public string İçinde_Bulunulan_Yılda_Hak_Kazanılan_İzin_Süresi { get; set; }
            public string Toplam_İzin_Süresi { get; set; }
            public string Toplam_İzinden_İçinde_Bulunulan_Yılda_Kullanılan_İzin_Süresi { get; set; }

            public string Toplam_İzinden_Kalan_Süre { get; set; }
            public string Kullanıcı_Ad_Soyad { get; set; }
            public string Kullanıcı_Unvan { get; set; }


        }
        [System.Web.Services.WebMethod]
        public static string Kullanıcı_Bilgileri(string Şehir_Id)
        {
          


            var queryWithForJson = "" +
"declare @kullanıcı_Id int =(select KullanıcıID from Kullanıcı where KullanıcıAD COLLATE Latin1_general_CS_AS =@1); " +
"             declare @Yıllık_İzin int =14; " +
"      " +
"             declare @Kullanıcı_İşe_Baslama_Tar date =(select İse_Baslama_Tar from Kullanıcı where KullanıcıID=@kullanıcı_Id) " +
"     " +
"             declare @Son_Dönem_Bitiş date = cast(datepart(YEAR,getdate())as nvarchar(50))+'-'+ " +
"       " +
"             cast(datepart(MONTH,@Kullanıcı_İşe_Baslama_Tar)as nvarchar(50)) +'-'+ " +
"        " +
"             cast(datepart(DAY,@Kullanıcı_İşe_Baslama_Tar)as nvarchar(50));  " +
"             set @Son_Dönem_Bitiş=DATEADD(year , 1,@Son_Dönem_Bitiş ); " +
"      " +
"             declare @Kullanıcı_Kaç_Yıl_Çalıştı int =datediff( DAY,@Kullanıcı_İşe_Baslama_Tar,getdate()); " +
"      " +
"             declare @Geçen_Yıldan_Devreden_İzin_Süresi int=0; " +
"             declare @İçinde_Bulunulan_Yılda_Hak_Kazanılan_İzin_Süresi int=0; " +
"             Declare @Toplam_İzin_Süresi int = 0; " +
"             declare @Toplam_İzinden_İçinde_Bulunulan_Yılda_Kullanılan_İzin_Süresi int = 0; " +
"     " +
"             if(@Kullanıcı_Kaç_Yıl_Çalıştı>=365) " +
"             begin;  " +
"             if (@Kullanıcı_Kaç_Yıl_Çalıştı>=730)  " +
"             begin;  " +
"              " +
"  " +
"             set @Geçen_Yıldan_Devreden_İzin_Süresi=@Yıllık_İzin-(select SUM(Süre) from Yıllık_İzin where Kullanıcı_Id=@kullanıcı_Id and  " +
"  " +
"             Olusturulma_Tar between DATEADD(YEAR , -2 , @Son_Dönem_Bitiş) and DATEADD(YEAR , -1 , @Son_Dönem_Bitiş) );  " +
"             end;  " +
"        " +
"             set @İçinde_Bulunulan_Yılda_Hak_Kazanılan_İzin_Süresi=@Yıllık_İzin; " +
"             set @Toplam_İzin_Süresi=@Geçen_Yıldan_Devreden_İzin_Süresi+@İçinde_Bulunulan_Yılda_Hak_Kazanılan_İzin_Süresi; " +
"              " +
"             set @Toplam_İzinden_İçinde_Bulunulan_Yılda_Kullanılan_İzin_Süresi = isnull((select SUM(Süre) from Yıllık_İzin where Kullanıcı_Id=@kullanıcı_Id and  " +
"              " +
"             Olusturulma_Tar between DATEADD(YEAR , -1 , @Son_Dönem_Bitiş) and @Son_Dönem_Bitiş ),0); " +
"             end; " +
"         " +
"             select " +
"			 @Geçen_Yıldan_Devreden_İzin_Süresi as Geçen_Yıldan_Devreden_İzin_Süresi," +
"			 @İçinde_Bulunulan_Yılda_Hak_Kazanılan_İzin_Süresi as İçinde_Bulunulan_Yılda_Hak_Kazanılan_İzin_Süresi," +
"			 @Toplam_İzin_Süresi as Toplam_İzin_Süresi," +
"			 @Toplam_İzinden_İçinde_Bulunulan_Yılda_Kullanılan_İzin_Süresi as Toplam_İzinden_İçinde_Bulunulan_Yılda_Kullanılan_İzin_Süresi," +
"			 (@Toplam_İzin_Süresi-@Toplam_İzinden_İçinde_Bulunulan_Yılda_Kullanılan_İzin_Süresi) " +
"             ,(select (AD +' '+ Soyad) from Kullanıcı where KullanıcıID=@kullanıcı_Id )  " +
"             ,(select (Grup_Tam_Ad+'('+Grup_Kısa_Ad+')') from Kullanıcı   " +
"             inner join Gruplar  " +
"                on Kullanıcı_Grup=Grup_Id  " +
"             where KullanıcıID=@kullanıcı_Id )  " +
"";




            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);
            conn.Open();
            cmd.Parameters.AddWithValue("@1", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());



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
                        Geçen_Yıldan_Devreden_İzin_Süresi = reader.GetValue(0).ToString(),
                        İçinde_Bulunulan_Yılda_Hak_Kazanılan_İzin_Süresi = reader.GetValue(1).ToString(),
                        Toplam_İzin_Süresi = reader.GetValue(2).ToString(),
                        Toplam_İzinden_İçinde_Bulunulan_Yılda_Kullanılan_İzin_Süresi = reader.GetValue(3).ToString(),
                        Toplam_İzinden_Kalan_Süre = reader.GetValue(4).ToString(),
                        Kullanıcı_Ad_Soyad = reader.GetValue(5).ToString(),
                        Kullanıcı_Unvan = reader.GetValue(6).ToString(),
                    };
                    tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
                }
            }
            conn.Close();
            return JsonConvert.SerializeObject(tablo_Doldur_Classes);


        }
        [System.Web.Services.WebMethod]
        public static string Talebi_Olustur(string Süresi_Gün, string Başlangıç_Tarih, string Bitiş_Tarhi, string Göreve_Başlayacağı_Tarih, string İzinde_Bulunacağı_Açık_Adres, string Yol_İzni, string Açıklama)
        {



            var queryWithForJson = "" +
                "insert into Yıllık_İzin( Süre ,Olusturulma_Tar,İzin_Bas_Tar,İzin_Bit_Tar ,Göreve_Baslayacagı_Tarih ,İzinde_Bulunacağı_Acık_Adres,Yol_İzni,Açıklama,Kullanıcı_Id)  " +
                "values(@Süre,GETDATE(),@İzin_Bas_Tar,@İzin_Bit_Tar,@Göreve_Baslayacagı_Tarih,@İzinde_Bulunacağı_Acık_Adres,@Yol_İzni,@Açıklama,(select KullanıcıID from Kullanıcı where KullanıcıAD COLLATE Latin1_general_CS_AS =@1)) " +
                "" +
                "" +
                "";
          


            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);
            conn.Open();
            cmd.Parameters.AddWithValue("@1", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
            cmd.Parameters.AddWithValue("@Süre", Süresi_Gün);
            cmd.Parameters.AddWithValue("@İzin_Bas_Tar", Başlangıç_Tarih);
            cmd.Parameters.AddWithValue("@İzin_Bit_Tar", Bitiş_Tarhi);
            cmd.Parameters.AddWithValue("@Göreve_Baslayacagı_Tarih", Göreve_Başlayacağı_Tarih);
            cmd.Parameters.AddWithValue("@İzinde_Bulunacağı_Acık_Adres", İzinde_Bulunacağı_Açık_Adres);
            cmd.Parameters.AddWithValue("@Yol_İzni", Yol_İzni);
            cmd.Parameters.AddWithValue("@Açıklama", Açıklama);
            cmd.ExecuteNonQuery();
            conn.Close();

            return "0";

        }
        public class İzin_Bilgileri_Tablo
        {
            public string AD { get; set; }
            public string Soyad { get; set; }
            public string Grup_Tam_Ad { get; set; }
            public string Süre { get; set; }
            public string İzin_Bas_Tar { get; set; }
            public string İzin_Bit_Tar { get; set; }
            public string Göreve_Baslayacagı_Tarih { get; set; }
            public string İzinde_Bulunacağı_Acık_Adres { get; set; }
            public string Yol_İzni { get; set; }
            public string Açıklama { get; set; }
            public string Olusturulma_Tar { get; set; }
            public string Araç_Plaka { get; set; }
            
        }
        

        [System.Web.Services.WebMethod]
        public static string İzin_Bilgileri(string İzin_Id)
        {
       

            var queryWithForJson = "select AD,Soyad,Grup_Tam_Ad,Süre,İzin_Bas_Tar,İzin_Bit_Tar,Göreve_Baslayacagı_Tarih,İzinde_Bulunacağı_Acık_Adres,Yol_İzni,Açıklama,Olusturulma_Tar,Araç_Plaka from Yıllık_İzin " +
            "inner join Kullanıcı " +   
            "on Kullanıcı_Id=Kullanıcı.KullanıcıID " +
            "inner join Gruplar " +
            "on Kullanıcı.Kullanıcı_Grup=Gruplar.Grup_Id " +
            "inner join Araçlar " +
            "on Kullanıcı.Araç_Id=Araçlar.Arac_Id " +
            "where İzin_Id=@1 ";


            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);
            cmd.Parameters.AddWithValue("@1", İzin_Id);
        


            List<İzin_Bilgileri_Tablo> tablo_Doldur_Classes = new List<İzin_Bilgileri_Tablo>();

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
                    var Tablo_Doldur_Class_ = new İzin_Bilgileri_Tablo
                    {
                        AD = reader.GetValue(0).ToString(),
                        Soyad = reader.GetValue(1).ToString(),
                        Grup_Tam_Ad = reader.GetValue(2).ToString(),
                        Süre = reader.GetValue(3).ToString(),
                        İzin_Bas_Tar = reader.GetDateTime(4).ToString("dd/MM/yyyy"),
                        İzin_Bit_Tar = reader.GetDateTime(5).ToString("dd/MM/yyyy"),
                        Göreve_Baslayacagı_Tarih = reader.GetDateTime(6).ToString("dd/MM/yyyy"),
                        İzinde_Bulunacağı_Acık_Adres = reader.GetValue(7).ToString(),
                        Yol_İzni = reader.GetValue(8).ToString(),
                        Açıklama = reader.GetValue(9).ToString(),
                        Olusturulma_Tar = reader.GetValue(10).ToString(),
                        Araç_Plaka = reader.GetValue(11).ToString(),
                    };
                    tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
                }
            }
            conn.Close();
            return JsonConvert.SerializeObject(tablo_Doldur_Classes);


        }
        public class Tablo_Doldur_Class
        {
            public string Süre { get; set; }
            public string Olusturulma_Tar { get; set; }
            public string İzin_Bas_Tar { get; set; }
            public string İzin_Bit_Tar { get; set; }
            public string Göreve_Baslayacagı_Tarih { get; set; }
            public string İzinde_Bulunacağı_Acık_Adres { get; set; }
            public string Yol_İzni { get; set; }
            public string Açıklama { get; set; }
            public string Onay_Durum { get; set; }
            public string Kargo_Durum { get; set; }
            public string İzin_Id { get; set; }

        }

        [System.Web.Services.WebMethod]
        public static string Tablo_Doldur(string Bas_Tar,string Bit_Tar)
        {
            //select * from listeler where Kullanıcı_Id=(select KullanıcıID from Kullanıcı where KullanıcıAD='recai') and cins = 0
            var queryWithForJson = "use kasa " +
                "select  Süre,Olusturulma_Tar,İzin_Bas_Tar,İzin_Bit_Tar,Göreve_Baslayacagı_Tarih,İzinde_Bulunacağı_Acık_Adres,Yol_İzni,Açıklama,Onay_Durum,İzin_Id,Kargo_Durum  " +
                "from Yıllık_İzin " +
                " where Olusturulma_Tar between @Bas_Tar and @Bit_Tar and Kullanıcı_Id=(select KullanıcıID from Kullanıcı where KullanıcıAD COLLATE Latin1_general_CS_AS =@1) " +
                "" +
                "";
          
            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);
            cmd.Parameters.AddWithValue("@1", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
            cmd.Parameters.AddWithValue("@Bas_Tar", Bas_Tar);
            cmd.Parameters.AddWithValue("@Bit_Tar", Bit_Tar);
  

            List<Tablo_Doldur_Class> tablo_Doldur_Classes = new List<Tablo_Doldur_Class>();

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
                    var Tablo_Doldur_Class_ = new Tablo_Doldur_Class
                    {
                        Süre = reader.GetValue(0).ToString(),
                        Olusturulma_Tar = reader.GetDateTime(1).ToString("dd/MM/yyyy"),
                        İzin_Bas_Tar = reader.GetDateTime(2).ToString("dd/MM/yyyy"),
                        İzin_Bit_Tar = reader.GetDateTime(3).ToString("dd/MM/yyyy"),
                        Göreve_Baslayacagı_Tarih = reader.GetDateTime(4).ToString("dd/MM/yyyy"),

                        İzinde_Bulunacağı_Acık_Adres = reader.GetValue(5).ToString(),
                        Yol_İzni = reader.GetValue(6).ToString(),
                        Açıklama = reader.GetValue(7).ToString(),
                        Onay_Durum = reader.GetValue(8).ToString(),
                        İzin_Id = reader.GetValue(9).ToString(),
                        Kargo_Durum = reader.GetValue(10).ToString(),
                        
                    };
                    tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
                }
            }
            conn.Close();
            return JsonConvert.SerializeObject(tablo_Doldur_Classes);


        }//Masrafı_Kaldır
    }
}