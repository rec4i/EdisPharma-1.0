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
    public partial class B_Anasayfa : System.Web.UI.Page
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
        public class Ciro_Tablo
        {
            public string Gun { get; set; }
            public string Ciro { get; set; }

        }

        [System.Web.Services.WebMethod]
        public static string Ciro_Tablo_Doldur(string parametre)
        {
            DateTime yıl_ = DateTime.Now;




            string gelen_yıl = yıl_.ToString("yyyyy");
            string gelen_ay = yıl_.ToString("MM");

            DateTime tarih = new DateTime(Convert.ToInt32(gelen_yıl), Convert.ToInt32(gelen_ay), 1);
            DateTime tarih_son_gün = new DateTime(Convert.ToInt32(gelen_yıl), Convert.ToInt32(gelen_ay), 1);



            tarih_son_gün = new DateTime(tarih_son_gün.Year, tarih_son_gün.Month, 1);


            DateTime tarih_Öncekiayın_son_gunu = new DateTime(tarih.Year, tarih.Month, 1);
            DateTime tarih_Bu_ayın_ilk_gunu = new DateTime(tarih.Year, tarih.Month, 1);




            Console.WriteLine(tarih_Bu_ayın_ilk_gunu.ToString("yyyy-MM-dd"));//gelen ayın ilk günü gün.ay.yıl
            Console.WriteLine(tarih_son_gün.AddMonths(1).AddDays(-1).ToString("yyyy-MM-dd"));//gelen ayın son günü  gün.ay.yıl
            Console.WriteLine(tarih_Bu_ayın_ilk_gunu.ToString("dddd"));// bu ayın ilk günü string
            Console.WriteLine(tarih_Öncekiayın_son_gunu.AddDays(-1).ToString("dddd"));// gelen aydan önceki ayın son günü string



            //---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

            SqlCommand cmd11 = new SqlCommand(" " +
                "declare @gün  int=1;  " +
                "declare @Ayın_Ilk_Gunu_parse date=cast(@Ayın_Ilk_Gunu as date);  " +
                "declare @Ayın_Son_Gunu_parse date=cast(@Ayın_Son_Gunu as date);  " +
                "declare @toplam nvarchar(max)=CAST(@gün as varchar)+'-'+CAST(@ay as varchar)+'-'+CAST(@yıl as varchar);  " +
                "declare @birleşim date= CAST(@toplam as date);  " +
                "declare @İd table (Id int); " +
                "declare @tablo table (Gun int , Toplam_Adet Decimal(14,2));  " +
                " WHILE @gün < @Ayın_Son_Günü_tek  +1 " +
                " BEGIN  " +
                "set @toplam=CAST(@yıl as varchar)+'-'+CAST(@ay as varchar)+'-'+CAST(@gün as varchar);  " +
                " set @birleşim=CAST(@toplam as date);  " +
                "SET @gün = @gün + 1; " +
                " print @toplam;  " +
                "insert into @tablo(Gun,Toplam_Adet) values((@gün-1), " +
                "( " +
                "select isnull(sum(x),0) from(" +
                "select isnull(((select UrunFiyat from Urunler2 where Siparis_Detay.Urun_Id=Urunler2.UrunID)/(((select UrunKar_Yuzde from Urunler2 where Siparis_Detay.Urun_Id=Urunler2.UrunID)/100)+1)*(Adet)/(Mf_Adet+Adet))*(Adet+Mf_Adet),0) as x from Siparis_Detay " +
                "inner join Sipariş_Genel " +
                "on Siparis_Detay.Siparis_Genel_Id=Sipariş_Genel.Siparis_Genel_Id " +
                                "				inner join Kullanıcı " +
"				on Sipariş_Genel.Olusturan_Kullanıcı=Kullanıcı.KullanıcıID " +
                "where Kullanıcı.Kullanıcı_Bogle =@kullanıcı   and CAST(Tar as date)=@toplam  and Sipariş_Genel.Onay_Durum=1 " +
                ")as x " +
                " ) " +
                " ) " +
                " END;  " +
                "select * from @tablo " +
                "", SqlC.con);

            string a_1 = Convert.ToString(Convert.ToInt32(Convert.ToString(tarih_son_gün.AddMonths(1).AddDays(-1).ToString("dd"))));
            string a_2 = Convert.ToString(Convert.ToInt32(Convert.ToString(gelen_ay)));
            string a_3 = Convert.ToString(Convert.ToInt32(Convert.ToInt32(gelen_yıl)));
            string a_4 = Convert.ToString(tarih_Bu_ayın_ilk_gunu.ToString("yyyy-MM-dd"));
            string a_5 = Convert.ToString(tarih_son_gün.AddMonths(1).AddDays(-1).ToString("yyyy-MM-dd"));


            cmd11.Parameters.AddWithValue("@Ayın_Son_Günü_tek", a_1);
            cmd11.Parameters.AddWithValue("@ay", a_2);
            cmd11.Parameters.AddWithValue("@yıl", a_3);//@kullanıcı
            cmd11.Parameters.AddWithValue("@Ayın_Ilk_Gunu", a_4);
            cmd11.Parameters.AddWithValue("@Ayın_Son_Gunu", a_5);
            cmd11.Parameters.AddWithValue("@kullanıcı", parametre);


            List<Ciro_Tablo> tablo_Doldur_Classes = new List<Ciro_Tablo>();

            SqlC.con.Open();

            var jsonResult = new StringBuilder();
            var reader = cmd11.ExecuteReader();
            if (!reader.HasRows)
            {
                jsonResult.Append("[]");
            }
            else
            {
                while (reader.Read())
                {
                    var Tablo_Doldur_Class_ = new Ciro_Tablo
                    {
                        Gun = reader.GetValue(0).ToString(),
                        Ciro = reader.GetValue(1).ToString()

                    };
                    tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
                }
            }
            SqlC.con.Close();
            return JsonConvert.SerializeObject(tablo_Doldur_Classes);



        }//Masrafı_Kaldır
        public class Adet_Tablo
        {
            public string Gun { get; set; }
            public string Adet { get; set; }

        }

        [System.Web.Services.WebMethod]
        public static string Adet_Tablo_Doldur(string parametre)
        {
            DateTime yıl_ = DateTime.Now;




            string gelen_yıl = yıl_.ToString("yyyyy");
            string gelen_ay = yıl_.ToString("MM");

            DateTime tarih = new DateTime(Convert.ToInt32(gelen_yıl), Convert.ToInt32(gelen_ay), 1);
            DateTime tarih_son_gün = new DateTime(Convert.ToInt32(gelen_yıl), Convert.ToInt32(gelen_ay), 1);



            tarih_son_gün = new DateTime(tarih_son_gün.Year, tarih_son_gün.Month, 1);


            DateTime tarih_Öncekiayın_son_gunu = new DateTime(tarih.Year, tarih.Month, 1);
            DateTime tarih_Bu_ayın_ilk_gunu = new DateTime(tarih.Year, tarih.Month, 1);




            Console.WriteLine(tarih_Bu_ayın_ilk_gunu.ToString("yyyy-MM-dd"));//gelen ayın ilk günü gün.ay.yıl
            Console.WriteLine(tarih_son_gün.AddMonths(1).AddDays(-1).ToString("yyyy-MM-dd"));//gelen ayın son günü  gün.ay.yıl
            Console.WriteLine(tarih_Bu_ayın_ilk_gunu.ToString("dddd"));// bu ayın ilk günü string
            Console.WriteLine(tarih_Öncekiayın_son_gunu.AddDays(-1).ToString("dddd"));// gelen aydan önceki ayın son günü string



            //---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

            SqlCommand cmd11 = new SqlCommand(" " +
                "declare @gün  int=1;  " +
                "declare @Ayın_Ilk_Gunu_parse date=cast(@Ayın_Ilk_Gunu as date);  " +
                "declare @Ayın_Son_Gunu_parse date=cast(@Ayın_Son_Gunu as date);  " +
                "declare @toplam nvarchar(max)=CAST(@gün as varchar)+'-'+CAST(@ay as varchar)+'-'+CAST(@yıl as varchar);  " +
                "declare @birleşim date= CAST(@toplam as date);  " +
                "declare @İd table (Id int); " +
                "declare @tablo table (Gun int , Toplam_Adet int); " +
                " WHILE @gün < @Ayın_Son_Günü_tek  +1 " +
                " BEGIN  " +
                "set @toplam=CAST(@yıl as varchar)+'-'+CAST(@ay as varchar)+'-'+CAST(@gün as varchar);  " +
                " set @birleşim=CAST(@toplam as date);  " +
                "SET @gün = @gün + 1; " +
                " print @toplam;  " +
                "insert into @tablo(Gun,Toplam_Adet) values((@gün-1), " +
                "( " +
                "select ISNULL(SUM(Mf_Adet+Siparis_Detay.Adet), 0 )   from Siparis_Detay " +
                "inner join Sipariş_Genel " +
                "on Siparis_Detay.Siparis_Genel_Id=Sipariş_Genel.Siparis_Genel_Id " +
                "				inner join Kullanıcı " +
"				on Sipariş_Genel.Olusturan_Kullanıcı=Kullanıcı.KullanıcıID " +
                "where Kullanıcı.Kullanıcı_Bogle=@kullanıcı and CAST(Tar as date)=@toplam  and Sipariş_Genel.Onay_Durum=1  " +
                " ) " +
                " ) " +
                " END;  " +
                "select * from @tablo " +
                "" +


                "", SqlC.con);

            string a_1 = Convert.ToString(Convert.ToInt32(Convert.ToString(tarih_son_gün.AddMonths(1).AddDays(-1).ToString("dd"))));
            string a_2 = Convert.ToString(Convert.ToInt32(Convert.ToString(gelen_ay)));
            string a_3 = Convert.ToString(Convert.ToInt32(Convert.ToInt32(gelen_yıl)));
            string a_4 = Convert.ToString(tarih_Bu_ayın_ilk_gunu.ToString("yyyy-MM-dd"));
            string a_5 = Convert.ToString(tarih_son_gün.AddMonths(1).AddDays(-1).ToString("yyyy-MM-dd"));


            cmd11.Parameters.AddWithValue("@Ayın_Son_Günü_tek", a_1);
            cmd11.Parameters.AddWithValue("@ay", a_2);
            cmd11.Parameters.AddWithValue("@yıl", a_3);//@kullanıcı
            cmd11.Parameters.AddWithValue("@Ayın_Ilk_Gunu", a_4);
            cmd11.Parameters.AddWithValue("@Ayın_Son_Gunu", a_5);
            cmd11.Parameters.AddWithValue("@kullanıcı", parametre);


            List<Adet_Tablo> tablo_Doldur_Classes = new List<Adet_Tablo>();

            SqlC.con.Open();

            var jsonResult = new StringBuilder();
            var reader = cmd11.ExecuteReader();
            if (!reader.HasRows)
            {
                jsonResult.Append("[]");
            }
            else
            {
                while (reader.Read())
                {
                    var Tablo_Doldur_Class_ = new Adet_Tablo
                    {
                        Gun = reader.GetValue(0).ToString(),
                        Adet = reader.GetValue(1).ToString()

                    };
                    tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
                }
            }
            SqlC.con.Close();
            return JsonConvert.SerializeObject(tablo_Doldur_Classes);



        }//Masrafı_Kaldır
        public class Ziyaret_Grafik
        {
            public string Edilen { get; set; }
            public string Bekleyen { get; set; }
            public string Edilmeyen { get; set; }
        }

        [System.Web.Services.WebMethod]
        public static string Ziyaret_Grafik_Doldur(string parametre)
        {
            DateTime bu_gun = DateTime.Now;
            //select * from listeler where Kullanıcı_Id=(select KullanıcıID from Kullanıcı where KullanıcıAD='recai') and cins = 0
            var queryWithForJson = "use kasa " +
          "declare @Tablo table(Edilen int , Bekleyen int , Edilmeyen int);" +
"                declare @Dedilen int=(select count(*) from Ziyaret_Detay " +
"                inner join Ziyaret_Genel " +
"                on Ziyaret_Detay.Ziy_Gnl_Id=Ziyaret_Genel.ID" +
"				inner join Kullanıcı" +
"				on Ziyaret_Genel.Kullanıcı_ID=Kullanıcı.KullanıcıID" +
"                where Ziy_Tar=@Bu_gun and Kullanıcı.Kullanıcı_Bogle =@1 and Ziyaret_Detay.Cins=0 and Ziyaret_Durumu=1) " +
"                declare @DBekleyen int=(select count(*) from Ziyaret_Detay  " +
"                inner join Ziyaret_Genel " +
"                on Ziyaret_Detay.Ziy_Gnl_Id=Ziyaret_Genel.ID " +
"				inner join Kullanıcı" +
"				on Ziyaret_Genel.Kullanıcı_ID=Kullanıcı.KullanıcıID" +
"                where Ziy_Tar=@Bu_gun and Kullanıcı.Kullanıcı_Bogle =@1 and Ziyaret_Detay.Cins=0 and Ziyaret_Durumu=0) " +
"                declare @DEdilmeyen int=(select count(*) from Ziyaret_Detay " +
"                inner join Ziyaret_Genel " +
"                on Ziyaret_Detay.Ziy_Gnl_Id=Ziyaret_Genel.ID " +
"				inner join Kullanıcı" +
"				on Ziyaret_Genel.Kullanıcı_ID=Kullanıcı.KullanıcıID" +
"                where Ziy_Tar=@Bu_gun and Kullanıcı.Kullanıcı_Bogle =@1 and Ziyaret_Detay.Cins=0 and Ziyaret_Durumu=2) " +
"                declare @Eedilen int=(select count(*) from Ziyaret_Detay  " +
"                inner join Ziyaret_Genel " +
"                on Ziyaret_Detay.Ziy_Gnl_Id=Ziyaret_Genel.ID " +
"				inner join Kullanıcı" +
"				on Ziyaret_Genel.Kullanıcı_ID=Kullanıcı.KullanıcıID" +
"                where Ziy_Tar=@Bu_gun and Kullanıcı.Kullanıcı_Bogle=@1 and Ziyaret_Detay.Cins=1 and Ziyaret_Durumu=1) " +
"                declare @EBekleyen int=(select count(*) from Ziyaret_Detay  " +
"                inner join Ziyaret_Genel " +
"                on Ziyaret_Detay.Ziy_Gnl_Id=Ziyaret_Genel.ID " +
"				inner join Kullanıcı" +
"				on Ziyaret_Genel.Kullanıcı_ID=Kullanıcı.KullanıcıID" +
"               where Ziy_Tar=@Bu_gun and Kullanıcı.Kullanıcı_Bogle=@1 and Ziyaret_Detay.Cins=1 and Ziyaret_Durumu=0) " +
"                declare @EEdilmeyen int=(select count(*) from Ziyaret_Detay " +
"                inner join Ziyaret_Genel " +
"                on Ziyaret_Detay.Ziy_Gnl_Id=Ziyaret_Genel.ID " +
"				inner join Kullanıcı" +
"				on Ziyaret_Genel.Kullanıcı_ID=Kullanıcı.KullanıcıID" +
"                where Ziy_Tar=@Bu_gun and Kullanıcı.Kullanıcı_Bogle=@1 and Ziyaret_Detay.Cins=1 and Ziyaret_Durumu=2) " +
"                insert into @Tablo (Edilen,Bekleyen,Edilmeyen) values (@Dedilen,@DBekleyen,@DEdilmeyen) " +
"                insert into @Tablo (Edilen,Bekleyen,Edilmeyen) values (@Eedilen,@EBekleyen,@EEdilmeyen) " +
"                select * from @Tablo";


            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);

            string a = bu_gun.ToString("yyyy-MM-dd");

            cmd.Parameters.AddWithValue("@1", parametre);
            cmd.Parameters.AddWithValue("@Bu_gun", a);


            List<Ziyaret_Grafik> tablo_Doldur_Classes = new List<Ziyaret_Grafik>();

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
                    var Tablo_Doldur_Class_ = new Ziyaret_Grafik
                    {
                        Edilen = reader.GetValue(0).ToString(),
                        Bekleyen = reader.GetValue(1).ToString(),
                        Edilmeyen = reader.GetValue(2).ToString()
                    };
                    tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
                }
            }
            conn.Close();
            return JsonConvert.SerializeObject(tablo_Doldur_Classes);



        }//Masrafı_Kaldır
        [System.Web.Services.WebMethod]
        public static string Tablo_Doldur_deneme(string parametre)
        {
            return JsonConvert.SerializeObject("[{0:0},{0:0}]");
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
                ")as Bugün_Sipariş_Top,AD,Soyad,Grup_Tam_Ad,Grup_Kısa_Ad,Kullanıcı.Kullanıcı_Profil_Photo,Kullanıcı.KullanıcıID " +
                " from Kullanıcı  " +
                " inner join Gruplar  " +
                "on Kullanıcı.Kullanıcı_Grup=Grup_Id " +
                " where Kullanıcı_Bogle=@Normal_Kullanıcı and Kullanıcı.Kullanıcı_Grup=4   order by Performans asc " +
                "" +
                "" +
                "" +
                "";
            DateTime Bu_Ayın_ılk_Gunu = DateTime.Now;
            DateTime Bu_Ayın_ılk_Gunu_ = new DateTime(Convert.ToInt32(Bu_Ayın_ılk_Gunu.Year), Convert.ToInt32(Bu_Ayın_ılk_Gunu.Month), 1);
            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);
            cmd.Parameters.AddWithValue("@Normal_Kullanıcı", parametre);
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
            string a = JsonConvert.SerializeObject(tablo_Doldur_Classes);
            return a;


        }
        public class Ziyaret_Tablo
        {
            public string Ziy_Dty_ID { get; set; }
            public string Ziy_Gnl_Id { get; set; }
            public string Ziyaret_Detay_cins { get; set; }
            public string Doktor_Ad { get; set; }
            public string Eczane_Adı { get; set; }
            public string Ziyaret_Durumu { get; set; }
            public string Brans_Txt { get; set; }
            public string TownName { get; set; }
            public string Unite_Txt { get; set; }


        }

        [System.Web.Services.WebMethod]
        public static string Ziyaret_Tablosu(string parametre)
        {
            DateTime bu_gun = DateTime.Now;
            //select * from listeler where Kullanıcı_Id=(select KullanıcıID from Kullanıcı where KullanıcıAD='recai') and cins = 0
            var queryWithForJson = "use kasa " +
                "select  Ziy_Dty_ID,Ziy_Gnl_Id,Ziyaret_Detay.Cins,Doktor_Ad,Eczane_Adı,Ziyaret_Durumu,Brans_Txt,TownName,Unite_Txt from Ziyaret_Detay  " +
                "inner join Ziyaret_Genel " +
                "on Ziyaret_Detay.Ziy_Gnl_Id=Ziyaret_Genel.ID " +
                "full  join Eczane " +
                "on Ziyaret_Detay.Eczane_Id=Eczane.Eczane_Id " +
                "full join Doktors " +
                "on Ziyaret_Detay.Doktor_Id=Doktors.Doktor_Id " +
                "full join Unite " +
                "on Doktor_Unite_ID=Unite_ID " +
                "full join Branchs " +
                " on Doktors.Doktor_Brans_Id=Branchs.Brans_ID " +
                "full join Town " +
                "on Eczane.Eczane_Brick= Town.TownID or Unite.Brick__Id=Town.TownID " +

                "where Ziyaret_Genel.Ziy_Tar =@Bu_gun and Ziyaret_Detay.Kullanıcı_Id=@1 " +
                "";
            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);

            string a = bu_gun.ToString("yyyy-MM-dd");

            cmd.Parameters.AddWithValue("@1", parametre);
            cmd.Parameters.AddWithValue("@Bu_gun", a);


            List<Ziyaret_Tablo> tablo_Doldur_Classes = new List<Ziyaret_Tablo>();

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
                    var Tablo_Doldur_Class_ = new Ziyaret_Tablo
                    {
                        Ziy_Dty_ID = reader.GetValue(0).ToString(),
                        Ziy_Gnl_Id = reader.GetValue(1).ToString(),
                        Ziyaret_Detay_cins = reader.GetValue(2).ToString(),
                        Doktor_Ad = reader.GetValue(3).ToString(),
                        Eczane_Adı = reader.GetValue(4).ToString(),
                        Ziyaret_Durumu = reader.GetValue(5).ToString(),
                        Brans_Txt = reader.GetValue(6).ToString(),
                        TownName = reader.GetValue(7).ToString(),
                        Unite_Txt = reader.GetValue(8).ToString()

                    };
                    tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
                }
            }
            conn.Close();
            return JsonConvert.SerializeObject(tablo_Doldur_Classes);



        }//Masrafı_Kaldır
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
                "select AD,Soyad,KullanıcıID from Kullanıcı where Kullanıcı_Bogle=(select Kullanıcı_Bogle from Kullanıcı Where KullanıcıAD=@Kullanıcı_Ad)";

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
    }
}