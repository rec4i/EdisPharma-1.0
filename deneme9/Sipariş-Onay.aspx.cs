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
    public partial class Sipariş_Onay : System.Web.UI.Page
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
        public static string Onay_Durumu_Güncelle(string Sipariş_Id, string islem, string İletim_Durmu, string Sipariş_Nou)
        {
            var queryWithForJson = " " +
                "if (@3=5) " +
                "begin " +
                "update Sipariş_Genel set Onay_Durum = @1 ,Sipariş_Notu=@Sipariş_Notu, İletim_Durum=@3, Onaylanmadıya_Düştümü=1 where Sipariş_Genel.Siparis_Genel_Id=@2 " +
                "insert into Bildirim(Bildirim_İçeriği,Bildirim_Türü,Kullanıcı_Id) " +
                " values('Onaylanmayan Sipariş',1, " +
               " (select Olusturan_Kullanıcı from Sipariş_Genel where Siparis_Genel_Id=@2) )" +
                "  " +
    " insert into Bildirim(Bildirim_İçeriği,Bildirim_Türü,Kullanıcı_Id) " +
    "" +
    "  select  'Onaylanmayan Sipariş',1,KullanıcıID from Kullanıcı where Kullanıcı_Bogle=(select Kullanıcı_Bogle from Kullanıcı where KullanıcıID=(select Olusturan_Kullanıcı from Sipariş_Genel where Siparis_Genel_Id=@2)) and Kullanıcı_Grup=2  " +

            "" +
                "end " +
                "else " +
                "begin " +
                "" +
                "update Sipariş_Genel set Onay_Durum = @1 , İletim_Durum=@3 ,Sipariş_Notu=@Sipariş_Notu where Sipariş_Genel.Siparis_Genel_Id=@2 " +
                "end " +
                "";


            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);
            conn.Open();
            cmd.Parameters.AddWithValue("@1", islem);
            cmd.Parameters.AddWithValue("@2", Sipariş_Id);
            cmd.Parameters.AddWithValue("@3", İletim_Durmu);
            cmd.Parameters.AddWithValue("@Sipariş_Notu", Sipariş_Nou);





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
            public string Eczacı_Adı { get; set; }
            public string Düzenlendimi { get; set; }
            public string Sorugdaki_Sayı { get; set; }
            public string Toplam_Sayı { get; set; }
            public string Lansman_Siparişi { get; set; }


        }
        [System.Web.Services.WebMethod]
        public static string Tablo_Verisi(string Tar_1, string Tar_2)
        {
            var queryWithForJson = "select Eczane_Adı,CityName,TownName,Tar,Onay_Durum,Siparis_Genel_Id,Kullanıcı.AD,Kullanıcı.Soyad,İletim_Durum,Onaylanmadıya_Düştümü,Sipariş_Tekrar_Gönderlidimi,Depo_Adı.Depo_Txt,Eczacı_Adı,Düzenlendimi from Sipariş_Genel " +
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
                "where  Tar between @tar_1 and @tar_2 order by Tar asc ";

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
                        Eczacı_Adı = reader.GetValue(12).ToString(),
                        Düzenlendimi = reader.GetValue(13).ToString(),



                    };
                    tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
                }
            }
            conn.Close();
            return JsonConvert.SerializeObject(tablo_Doldur_Classes);


        }
        [System.Web.Services.WebMethod]
        public static string Tablo_Verisi_Pagenatrion(string Tar_1, string Tar_2, string offset, string limit, string search, string sort, string order, string İletim_Durumu)
        {
            var queryWithForJson = "" +
        " if (@İletim_Durum = 0)" +
        " begin;" +
        "" +
        " select Eczane_Adı,CityName,TownName,Tar,Onay_Durum,Siparis_Genel_Id,Kullanıcı.AD,Kullanıcı.Soyad,İletim_Durum,Onaylanmadıya_Düştümü,Sipariş_Tekrar_Gönderlidimi,Depo_Adı.Depo_Txt,Eczacı_Adı,Düzenlendimi " +
        "" +
        ",(" +
        "" +
        "" +
                "  select COUNT(*)  from Sipariş_Genel       " +
"                          inner join Eczane       " +
"                          on Sipariş_Genel.Eczane_Id=Eczane.Eczane_Id       " +
"                          inner join City       " +
"                          on Eczane.Eczane_Il=City.CityID       " +
"                          inner join Town       " +
"                          on Eczane.Eczane_Brick=Town.TownID       " +
"                           inner join Kullanıcı       " +
"            " +
"                          on Sipariş_Genel.Olusturan_Kullanıcı = Kullanıcı.KullanıcıID       " +
"                              inner join Depo_Adı       " +
"                            on Sipariş_Genel.Depo_Id=Depo_Adı.Depo_Id       " +
   "                 where  Tar between @tar_1 and @tar_2 and " +
   "" +
   "( Eczane_Adı like '%' +@search +'%' or Kullanıcı.AD like '%' +@search +'%' or  Kullanıcı.Soyad like '%' +@search +'%' or " +
        "" +
        "Kullanıcı.AD +' '+  Kullanıcı.Soyad like '%' +@search +'%' or " +
        "Depo_Adı.Depo_Txt like '%' +@search +'%' " +
        "" +
        ") " +
        "" +
        "				 and İletim_Durum in (select İletim_Durum_Id from İletim_Durum)" +
        "" +
        ")," +
        "(select count(*) from Sipariş_Genel )" +
        "" +
        "" +
        ",Lansman_Siparişimi from Sipariş_Genel    " +
        "                  inner join Eczane    " +
        "                 on Sipariş_Genel.Eczane_Id=Eczane.Eczane_Id    " +
        "                 inner join City    " +
        "                 on Eczane.Eczane_Il=City.CityID    " +
        "                 inner join Town    " +
        "                 on Eczane.Eczane_Brick=Town.TownID    " +
        "                  inner join Kullanıcı    " +
        "" +
        "                 on Sipariş_Genel.Olusturan_Kullanıcı = Kullanıcı.KullanıcıID    " +
        "                     inner join Depo_Adı    " +
        "                   on Sipariş_Genel.Depo_Id=Depo_Adı.Depo_Id    " +
        "                 where  Tar between @tar_1 and @tar_2 and " +
        "" +
        "( Eczane_Adı like '%' +@search +'%' or Kullanıcı.AD like '%' +@search +'%' or  Kullanıcı.Soyad like '%' +@search +'%' or " +
        "" +
        "Kullanıcı.AD +' '+  Kullanıcı.Soyad like '%' +@search +'%' or " +
        "Depo_Adı.Depo_Txt like '%' +@search +'%' " +
        "" +
        ") " +
        "" +
        "				 and İletim_Durum in (select İletim_Durum_Id from İletim_Durum)" +
        "				 " +
        "				 " +
        "				 order by Tar asc  OFFSET cast( @Offset as int) ROWS FETCH NEXT cast( @limit as int) ROWS ONLY ;" +
        "" +
        "end;" +
        "else " +
        "begin ;" +
        " select Eczane_Adı,CityName,TownName,Tar,Onay_Durum,Siparis_Genel_Id,Kullanıcı.AD,Kullanıcı.Soyad,İletim_Durum,Onaylanmadıya_Düştümü,Sipariş_Tekrar_Gönderlidimi,Depo_Adı.Depo_Txt,Eczacı_Adı,Düzenlendimi" +
        "" +
        ",(" +
        "" +
        "  select COUNT(*)  from Sipariş_Genel       " +
"                          inner join Eczane       " +
"                          on Sipariş_Genel.Eczane_Id=Eczane.Eczane_Id       " +
"                          inner join City       " +
"                          on Eczane.Eczane_Il=City.CityID       " +
"                          inner join Town       " +
"                          on Eczane.Eczane_Brick=Town.TownID       " +
"                           inner join Kullanıcı       " +
"            " +
"                          on Sipariş_Genel.Olusturan_Kullanıcı = Kullanıcı.KullanıcıID       " +
"                              inner join Depo_Adı       " +
"                            on Sipariş_Genel.Depo_Id=Depo_Adı.Depo_Id       " +
"                          where  Tar between @tar_1 and @tar_2 and " +
  "( Eczane_Adı like '%' +@search +'%' or Kullanıcı.AD like '%' +@search +'%' or  Kullanıcı.Soyad like '%' +@search +'%' or " +
        "" +
        "Kullanıcı.AD +' '+  Kullanıcı.Soyad like '%' +@search +'%' or " +
        "Depo_Adı.Depo_Txt like '%' +@search +'%' " +
        "" +
        ") " +
"   " +
  "				 and İletim_Durum in (@İletim_Durum)" +
        "" +
        ")," +
        "" +
        "(select count(*) from Sipariş_Genel ),Lansman_Siparişimi" +
        "" +
        "" +

        " from Sipariş_Genel    " +
        "                 inner join Eczane    " +
        "                 on Sipariş_Genel.Eczane_Id=Eczane.Eczane_Id    " +
        "                 inner join City    " +
        "                 on Eczane.Eczane_Il=City.CityID    " +
        "                 inner join Town    " +
        "                 on Eczane.Eczane_Brick=Town.TownID    " +
        "                  inner join Kullanıcı    " +
        "" +
        "                 on Sipariş_Genel.Olusturan_Kullanıcı = Kullanıcı.KullanıcıID    " +
        "                     inner join Depo_Adı    " +
        "                   on Sipariş_Genel.Depo_Id=Depo_Adı.Depo_Id    " +
        "                 where  Tar between @tar_1 and @tar_2 and " +
        "" +
          "( Eczane_Adı like '%' +@search +'%' or Kullanıcı.AD like '%' +@search +'%' or  Kullanıcı.Soyad like '%' +@search +'%' or " +
        "" +
        "Kullanıcı.AD +' '+  Kullanıcı.Soyad like '%' +@search +'%' or " +
        "Depo_Adı.Depo_Txt like '%' +@search +'%' " +
        "" +
        ") " +
        "" +
        "				 and İletim_Durum in (@İletim_Durum)" +
        "				 " +
        "				 " +
        "				 order by Tar asc  OFFSET cast( @Offset as int) ROWS FETCH NEXT cast( @limit as int) ROWS ONLY ;" +
        "" +
        "end;" +
        "";

            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);
            conn.Open();

            cmd.Parameters.AddWithValue("@tar_1", Tar_1 + " " + "00:00:00.000");
            cmd.Parameters.AddWithValue("@tar_2", Tar_2 + " " + "23:59:59.999");

            cmd.Parameters.AddWithValue("@İletim_Durum", İletim_Durumu);
            cmd.Parameters.AddWithValue("@Offset", offset);
            cmd.Parameters.AddWithValue("@limit", limit);
            cmd.Parameters.AddWithValue("@search", search == "undefined" ? "" : search);


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
                        Eczacı_Adı = reader.GetValue(12).ToString(),
                        Düzenlendimi = reader.GetValue(13).ToString(),
                        Sorugdaki_Sayı = reader.GetValue(14).ToString(),
                        Toplam_Sayı = reader.GetValue(15).ToString(),
                        Lansman_Siparişi = reader.GetValue(16).ToString(),



                    };
                    tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
                }
            }
            conn.Close();
            return JsonConvert.SerializeObject(tablo_Doldur_Classes);


        }
        public class Sipariş_Notu_Getir_Tablo
        {
            public string Sipariş_Notu { get; set; }


        }
        [System.Web.Services.WebMethod]
        public static string Sipariş_Notu_Getir(string Sipariş_Id)
        {
            var queryWithForJson = "select Sipariş_Notu from Sipariş_Genel Where Siparis_Genel_Id=@Sipariş_Genel_Id ";


            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);
            conn.Open();
            cmd.Parameters.AddWithValue("@Sipariş_Genel_Id", Sipariş_Id);


            List<Sipariş_Notu_Getir_Tablo> tablo_Doldur_Classes = new List<Sipariş_Notu_Getir_Tablo>();


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
                    var Tablo_Doldur_Class_ = new Sipariş_Notu_Getir_Tablo
                    {
                        Sipariş_Notu = reader.GetValue(0).ToString(),

                    };
                    tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
                }
            }
            conn.Close();
            return JsonConvert.SerializeObject(tablo_Doldur_Classes);


        }
        public class Sipariş_Detay_Düzenle_tablo
        {
            public string Urun_Adı { get; set; }
            public string Adet { get; set; }
            public string Mf_Adet { get; set; }
            public int Toplam { get; set; }
            public string Birim_Fiyat { get; set; }
            public string Satış_Fiyat { get; set; }
            public string Birim_Fiyat_Toplam { get; set; }
            public string Normal_Toplam { get; set; }
            public string Sipariş_Detay_Id { get; set; }

        }
        [System.Web.Services.WebMethod]
        public static string Sipariş_Detay_Düzenle(string Sipariş_Detay_Id, string Sipariş_Genel_Id, string Adet, string Mf_adet)
        {
            var queryWithForJson = "update Siparis_Detay set Adet=@Adet ,Mf_Adet=@Mf_Adet where Siparis_Detay_Id= @Sipariş_Detay_ID  " +

                " update Sipariş_Genel set Düzenlendimi=1 where Siparis_Genel_Id=@Sipariş_Genel_ID ";

            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);
            conn.Open();
            cmd.Parameters.AddWithValue("@Adet", Adet);
            cmd.Parameters.AddWithValue("@Mf_Adet", Mf_adet);
            cmd.Parameters.AddWithValue("@Sipariş_Detay_ID", Sipariş_Detay_Id);
            cmd.Parameters.AddWithValue("@Sipariş_Genel_ID", Sipariş_Genel_Id);



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
                        Kullanıcı_Ad_Soyad = reader.GetValue(6).ToString() + " " + reader.GetValue(7).ToString()

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
            public string Sipariş_Detay_Id { get; set; }

        }
        [System.Web.Services.WebMethod]
        public static string Tablo_Verisi_Red(string Tar_1, string Tar_2)
        {
            var queryWithForJson = "select Eczane_Adı,CityName,TownName,Tar,Onay_Durum,Siparis_Genel_Id,AD,Soyad from Sipariş_Genel " +
                "inner join Eczane " +
                "on Sipariş_Genel.Eczane_Id=Eczane.Eczane_Id " +
                "inner join City " +
                "on Eczane.Eczane_Il=City.CityID " +
                "inner join Town " +
                "on Eczane.Eczane_Brick=Town.TownID " +
                    "inner join Kullanıcı  " +
                "on Sipariş_Genel.Olusturan_Kullanıcı=Kullanıcı.KullanıcıID " +
                "where   Tar between @tar_1 and @tar_2 and Onay_Durum = 2 order by Tar asc ";

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
                        Eczane_Adı = reader.GetValue(0).ToString(),
                        CityName = reader.GetValue(1).ToString(),
                        TownName = reader.GetValue(2).ToString(),
                        Tar = reader.GetDateTime(3).ToString("dd.MM.yyyy"),
                        Onay_Durum = reader.GetValue(4).ToString(),
                        Siparis_Genel_Id = reader.GetValue(5).ToString(),
                        Kullanıcı_Ad_Soyad = reader.GetValue(6).ToString() + " " + reader.GetValue(7).ToString()

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
            var queryWithForJson = "select Eczane_Adı,CityName,TownName,Tar,Onay_Durum,Siparis_Genel_Id,Ad,Soyad from Sipariş_Genel " +
                "inner join Eczane " +
                "on Sipariş_Genel.Eczane_Id=Eczane.Eczane_Id " +
                "inner join City " +
                "on Eczane.Eczane_Il=City.CityID " +
                "inner join Town " +
                "on Eczane.Eczane_Brick=Town.TownID " +
                        "inner join Kullanıcı  " +
                "on Sipariş_Genel.Olusturan_Kullanıcı=Kullanıcı.KullanıcıID " +
                "where Tar between @tar_1 and @tar_2 and Onay_Durum = 1 order by Tar asc ";

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
                        Eczane_Adı = reader.GetValue(0).ToString(),
                        CityName = reader.GetValue(1).ToString(),
                        TownName = reader.GetValue(2).ToString(),
                        Tar = reader.GetDateTime(3).ToString("dd.MM.yyyy"),
                        Onay_Durum = reader.GetValue(4).ToString(),
                        Siparis_Genel_Id = reader.GetValue(5).ToString(),
                        Kullanıcı_Ad_Soyad = reader.GetValue(6).ToString() + " " + reader.GetValue(7).ToString()

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
        [System.Web.Services.WebMethod]
        public static string Sipariş_Detay(string Sipariş_ıd)
        {
            var queryWithForJson = "" +
                "select Urun_Adı,Adet,Mf_Adet,Guncel_DSF,Siparis_Detay_Id from Siparis_Detay  " +
                "inner join Urunler " +
                "     on Urunler.Urun_Id=Siparis_Detay.Urun_Id   " +
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
                    var Birim_Fiyatlar = Birim_Fiyat_Hesapla(reader.GetValue(3).ToString(), reader.GetValue(1).ToString(), reader.GetValue(2).ToString());

                    var Tablo_Doldur_Class_ = new Sipariş_Detay_Liste
                    {
                        Urun_Adı = reader.GetValue(0).ToString(),
                        Adet = reader.GetValue(1).ToString(),
                        Mf_Adet = reader.GetValue(2).ToString(),
                        Toplam = Convert.ToInt32(reader.GetValue(1).ToString()) + Convert.ToInt32(reader.GetValue(2).ToString()),
                        Birim_Fiyat = Birim_Fiyatlar.Birim_Fiyat,
                        Satış_Fiyat = reader.GetValue(3).ToString(),
                        Birim_Fiyat_Toplam = Birim_Fiyatlar.Birim_Fiyatı_Toplam,
                        Normal_Toplam = Birim_Fiyatlar.Satış_Fiyatı_Toplam,
                        Sipariş_Detay_Id = reader.GetValue(4).ToString()

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