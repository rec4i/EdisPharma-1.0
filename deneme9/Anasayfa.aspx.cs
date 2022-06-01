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
    public partial class Anasayfa : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        [System.Web.Services.WebMethod]
        public static string Araç_Kilometre_Güncelle(string Kilometre)
        {


            var queryWithForJson = "update Araçlar set Araç_Km=@Kilometre where Arac_Id=(select Araç_Id from Kullanıcı where KullanıcıAD COLLATE Latin1_general_CS_AS =@Kullanıcı_Id)  " +
                "insert into Araç_Kilometre_Takip(Araç_Id,Araç_Kilometre,Güncelleme_Tar) values ((select Araç_Id from Kullanıcı where KullanıcıAD COLLATE Latin1_general_CS_AS =@Kullanıcı_Id),@Kilometre,GETDATE()) ";


            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);
            conn.Open();
            cmd.Parameters.AddWithValue("@Kullanıcı_Id", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
            cmd.Parameters.AddWithValue("@Kilometre", Kilometre);



            List<Araç_Kilometre_Girilsinmi_Tablo> tablo_Doldur_Classes = new List<Araç_Kilometre_Girilsinmi_Tablo>();


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
                    var Tablo_Doldur_Class_ = new Araç_Kilometre_Girilsinmi_Tablo
                    {

                        Girilsinmi = reader.GetValue(0).ToString(),

                    };
                    tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
                }
            }

            conn.Close();
            return JsonConvert.SerializeObject(tablo_Doldur_Classes);


        }

        public class Araç_Kilometre_Girilsinmi_Tablo
        {
            public string Girilsinmi { get; set; }
          

        }
        [System.Web.Services.WebMethod]
        public static string Araç_Kilometre_Girilsinmi()
        {

    
            var queryWithForJson =
 "declare @Bu_Gün date =getdate() " +
"" +
"declare @Bu_Haftanın_Günü int=(SELECT DATEPART(dw,@Bu_Gün)) " +
"" +
"" +
"declare @Girilecekmi int=1; " +
"" +
"print @Bu_Haftanın_Günü " +
"" +
"" +
"if  exists(select * from Araç_Kilometre_Takip where Güncelleme_Tar=@Bu_Gün and Araç_Id=(select Araç_Id from Kullanıcı where KullanıcıAD COLLATE Latin1_general_CS_AS =@Kullanıcı_Id) ) " +
"begin " +
"set @Girilecekmi=0; " +
"end " +
"else " +
"begin " +
"while @Bu_Haftanın_Günü != 2 " +
"begin " +
"" +
"" +
"" +
"" +
"set @Bu_Gün=(dateadd(day,-1,@Bu_Gün)) " +
"set @Bu_Haftanın_Günü =(SELECT DATEPART(dw,@Bu_Gün)) " +
"if  exists(select * from Araç_Kilometre_Takip where Güncelleme_Tar=@Bu_Gün and Araç_Id=(select Araç_Id from Kullanıcı where KullanıcıAD COLLATE Latin1_general_CS_AS =@Kullanıcı_Id) ) " +
"begin " +
"set @Girilecekmi=0; " +
"end " +
"" +
"end " +
"end " +
"" +
"select @Girilecekmi ";


            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);
            conn.Open();
            cmd.Parameters.AddWithValue("@Kullanıcı_Id", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());



            List<Araç_Kilometre_Girilsinmi_Tablo> tablo_Doldur_Classes = new List<Araç_Kilometre_Girilsinmi_Tablo>();


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
                    var Tablo_Doldur_Class_ = new Araç_Kilometre_Girilsinmi_Tablo
                    {

                        Girilsinmi = reader.GetValue(0).ToString(),

                    };
                    tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
                }
            }

            conn.Close();
            return JsonConvert.SerializeObject(tablo_Doldur_Classes);


        }

        [System.Web.Services.WebMethod]
        public static string Siparişi_Değerlendirmeye_Gönder(string Gorusme_Sonucu, string Sipariş_Id)
        {
            var queryWithForJson = "use kasa   " +
                "update Sipariş_Genel set Görüsme_Sonucu= Görüsme_Sonucu+'  |-|   '+ @Görüsme_Sonucu_Text , Bm_Ye_Gönderildimi=1 where Siparis_Genel_Id=@Siparis_Genel_Id" +
                "";

            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);
            cmd.Parameters.AddWithValue("@Görüsme_Sonucu_Text", Gorusme_Sonucu);
            cmd.Parameters.AddWithValue("@Siparis_Genel_Id", Sipariş_Id);

            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();

            return "a";


        }
        [System.Web.Services.WebMethod]
        public static string Bildirim_Görüldü_Yap(string Gorusme_Sonucu)
        {
            var queryWithForJson = "use kasa   " +
                "update Bildirim set Görüldümü=1 where Kullanıcı_Id=(select KullanıcıID from Kullanıcı where KullanıcıAD COLLATE Latin1_general_CS_AS =@1) " +
                "";

            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);
            cmd.Parameters.AddWithValue("@1", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());


            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();

            return "a";


        }

        public class Bastakiler
        {
            public string Siparis_Sayısı { get; set; }
            public string Eczane { get; set; }
            public string Doktor { get; set; }

        }

  
       



        [System.Web.Services.WebMethod]
        public static string Bastakileri_Doldur(string parametre)
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
          
                "declare @Ayın_Ilk_Gunu_parse date=cast(@Ayın_Ilk_Gunu as date);  " +
                "declare @Ayın_Son_Gunu_parse date=cast(@Ayın_Son_Gunu as date);  " +
                "" +
                "declare @Tablo table (siparis_ int , Eczane int , Doktor int); " +
                "insert into @Tablo values(( " +
                " select COUNT(*) from Siparis_Detay " +
                "inner join Sipariş_Genel " +
                "on Siparis_Detay.Siparis_Genel_Id=Sipariş_Genel.Siparis_Genel_Id " +
                "where Onay_Durum= 1 and Tar between @Ayın_Ilk_Gunu  and @Ayın_Son_Gunu and Olusturan_Kullanıcı=(select KullanıcıID from Kullanıcı where KullanıcıAD COLLATE Latin1_general_CS_AS =@kullanıcı) " +
                "),( " +
                "select COUNT(*) from Ziyaret_Detay  " +
                "inner join Ziyaret_Genel " +
                "on Ziyaret_Detay.Ziy_Gnl_Id=Ziyaret_Genel.ID " +
                "where Ziyaret_Genel.Kullanıcı_ID=(select KullanıcıID from Kullanıcı where KullanıcıAD COLLATE Latin1_general_CS_AS =@kullanıcı) and Ziy_Tar between @Ayın_Ilk_Gunu and @Ayın_Son_Gunu and Ziyaret_Detay.Ziyaret_Durumu=1 and Ziyaret_Detay.Cins=0 " +
                "),( " +
                "select COUNT(*) from Ziyaret_Detay " +
                " inner join Ziyaret_Genel " +
                " on Ziyaret_Detay.Ziy_Gnl_Id=Ziyaret_Genel.ID " +
                "where Ziyaret_Genel.Kullanıcı_ID=(select KullanıcıID from Kullanıcı where KullanıcıAD COLLATE Latin1_general_CS_AS =@kullanıcı) and Ziy_Tar between @Ayın_Ilk_Gunu and @Ayın_Son_Gunu and Ziyaret_Detay.Ziyaret_Durumu=1 and Ziyaret_Detay.Cins=0 " +
                ")) " +
                "select * from @Tablo " +
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
            cmd11.Parameters.AddWithValue("@kullanıcı", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());


            List<Bastakiler> tablo_Doldur_Classes = new List<Bastakiler>();

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
                    var Tablo_Doldur_Class_ = new Bastakiler
                    {
                        Siparis_Sayısı = reader.GetValue(0).ToString(),
                        Eczane = reader.GetValue(1).ToString(),
                        Doktor = reader.GetValue(1).ToString()


                    };
                    tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
                }
            }
            SqlC.con.Close();
            return JsonConvert.SerializeObject(tablo_Doldur_Classes);



        }//Masrafı_Kaldır
        [System.Web.Services.WebMethod]
        public static string Haftanın_Gunleri(string parametre)
        {

            string gelen_yıl = parametre.Split('-')[1];
            string gelen_ay = parametre.Split('-')[0];

            DateTime tarih = new DateTime(Convert.ToInt32(gelen_yıl), Convert.ToInt32(gelen_ay), 1);
            DateTime tarih_son_gün = new DateTime(Convert.ToInt32(gelen_yıl), Convert.ToInt32(gelen_ay), 1);



            tarih_son_gün = new DateTime(tarih_son_gün.Year, tarih_son_gün.Month, 1);


            DateTime tarih_Öncekiayın_son_gunu = new DateTime(tarih.Year, tarih.Month, 1);
            DateTime tarih_Bu_ayın_ilk_gunu = new DateTime(tarih.Year, tarih.Month, 1);


            SqlCommand cmd11 = new SqlCommand(" " +
                      "use kasa declare @gün  int=1; " +
                      "declare @Ayın_Ilk_Gunu_parse date=cast(@Ayın_Ilk_Gunu as date); " +
                      "declare @Ayın_Son_Gunu_parse date=cast(@Ayın_Son_Gunu as date); " +
                      "declare @toplam nvarchar(max)=CAST(@gün as varchar)+'-'+CAST(@ay as varchar)+'-'+CAST(@yıl as varchar); " +
                      "declare @birleşim date= CAST(@toplam as date); " +
                      "declare @İd table (Id int); " +
                      "if exists(select * from Ziyaret_Onay where Kullanıcı_Id= (select KullanıcıID from Kullanıcı where KullanıcıAD COLLATE Latin1_general_CS_AS =@kullanıcı) and Bas_Tar=@Ayın_Ilk_Gunu and Bit_Tar=@Ayın_Son_Gunu) " +
                      "begin " +
                      "select CONVERT (varchar(10), Ziyaret_Genel.Ziy_Tar, 104)as 'ziyaret tar',Ziyaret_Genel.ID ,Kullanıcı_ID,Ziy_ID,Ziy_Edilen_Eczane,Ziy_Edilen_Doktor,(select count(*) from Ziyaret_Detay where Ziy_Gnl_ID=ID and Cins=1)as Ziyaret_Edilecek_Eczane,(select count(*) from Ziyaret_Detay where Ziy_Gnl_ID=ID and Cins=0)as Ziyaret_Edilecek_Doktor,(select COUNT(*) from Ziyaret_Detay  where ID=Ziy_Gnl_Id and Cins=0 and Ziyaret_Durumu=1) as ziyaret_edilen_Eczane,(select COUNT(*) from Ziyaret_Detay  where ID=Ziy_Gnl_Id and Cins=1 and Ziyaret_Durumu=1) as ziyaret_edilen_Doktor  from Ziyaret_Genel where Kullanıcı_ID=(select KullanıcıID from Kullanıcı where KullanıcıAD COLLATE Latin1_general_CS_AS =@kullanıcı) and Ziy_Tar between @Ayın_Ilk_Gunu and @Ayın_Son_Gunu;  " +
                      "end; " +
                      "else " +
                      " begin " +
                      "insert into Ziyaret_Onay (Bas_Tar,Bit_Tar,Kullanıcı_Id) output inserted.Ziyaret_Onay_Id into @İd values (@Ayın_Ilk_Gunu,@Ayın_Son_Gunu,(select KullanıcıID from Kullanıcı where KullanıcıAD COLLATE Latin1_general_CS_AS =@kullanıcı)) " +
                      "WHILE @gün < @Ayın_Son_Günü_tek+1  " +
                      "BEGIN   " +
                      "set @toplam=CAST(@yıl as varchar)+'-'+CAST(@ay as varchar)+'-'+CAST(@gün as varchar);  " +
                      "set @birleşim=CAST(@toplam as date);   " +
                      "INSERT INTO Ziyaret_Genel (Ziy_Tar,Kullanıcı_ID,Ziyaret_Onay_Id) values (@birleşim,(select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS =@kullanıcı),(select * from @İd));  " +
                      "SET @gün = @gün + 1;  " +
                      "print @toplam; " +
                      "END; " +
                      "select CONVERT (varchar(10), Ziyaret_Genel.Ziy_Tar, 104)as 'ziyaret tar',Ziyaret_Genel.ID ,Kullanıcı_ID,Ziy_ID,Ziy_Edilen_Eczane,Ziy_Edilen_Doktor,(select count(*) from Ziyaret_Detay where Ziy_Gnl_ID=ID and Cins=1)as Ziyaret_Edilecek_Eczane,(select count(*) from Ziyaret_Detay where Ziy_Gnl_ID=ID and Cins=0)as Ziyaret_Edilecek_Doktor,(select COUNT(*) from Ziyaret_Detay  where ID=Ziy_Gnl_Id and Cins=0 and Ziyaret_Durumu=1) as ziyaret_edilen_Eczane,(select COUNT(*) from Ziyaret_Detay  where ID=Ziy_Gnl_Id and Cins=1 and Ziyaret_Durumu=1) as ziyaret_edilen_Doktor  from Ziyaret_Genel where Kullanıcı_ID=(select KullanıcıID from Kullanıcı where KullanıcıAD COLLATE Latin1_general_CS_AS =@kullanıcı) and Ziy_Tar between @Ayın_Ilk_Gunu and @Ayın_Son_Gunu;  " +
                      "end " +

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
            cmd11.Parameters.AddWithValue("@kullanıcı", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());

            SqlC.con.Open();

            var reader = cmd11.ExecuteReader();//47 block

            string a = "";
            string b = "";
            while (reader.Read())//0-tar , 1-id , 2-Kullanıcı_ıd , 3-Ziy_Id , 4-Ziy_Edilen_Eczane , 5- Ziy_Edilen_Doktor , 6-Ziy_Edilecek_Eczane , 7- Ziy_Edilecek_Doktor 
            {
                a += reader.GetValue(0).ToString() + "-" + reader.GetValue(1).ToString() + "-" + reader.GetValue(2).ToString() + "-" + reader.GetValue(3).ToString() + "-" + reader.GetValue(4).ToString() + "-" + reader.GetValue(5).ToString() + "-" + reader.GetValue(6).ToString() + "-" + reader.GetValue(7).ToString() + "-" + reader.GetValue(8).ToString() + "-" + reader.GetValue(9).ToString() + "!";
            }

            //a.Split('!')[0].Split('-')[0].Split('.')[1] = birinci günün ayı

            SqlC.con.Close();







            if (tarih_Bu_ayın_ilk_gunu.ToString("dddd") == "Pazartesi")
            {
                for (int i = 0; i < 42; i++)
                {
                    if (i > ((Convert.ToInt32(tarih_son_gün.AddMonths(1).AddDays(-1).ToString("dd"))) - 1))
                    {
                        b += "empty" + "!";
                    }
                    else
                    {
                        b += a.Split('!')[i] + "-" + "1" + "!";

                    }
                }
            }
            else
            {
                //Console.WriteLine(tarih_Öncekiayın_son_gunu.AddDays(-1).ToString("dddd"));// gelen aydan önceki ayın son günü string
                int sayaç = 1;
                int Bu_Ayın_Gün_Sayısı = ((Convert.ToInt32(tarih_son_gün.AddMonths(1).AddDays(-1).ToString("dd"))));
                int Gün_sayaç = 0;
                while (true)
                {
                    if (tarih_Öncekiayın_son_gunu.AddDays(-sayaç).ToString("dddd") != "Pazartesi")
                    {   
                        sayaç++;
                    }
                    else
                    {
                        break;
                    }
                }
                for (int i = 0; i < 42; i++)
                {
                    if (i < sayaç)
                    {
                        b += "empty" + "!";

                        continue;
                    }
                    if (i - sayaç > ((Convert.ToInt32(tarih_son_gün.AddMonths(1).AddDays(-1).ToString("dd"))) - 1))
                    {
                        b += "empty" + "!";
                    }
                    else
                    {
                        if (Gün_sayaç < Bu_Ayın_Gün_Sayısı)
                        {
                            b += a.Split('!')[Gün_sayaç] + "-" + "1" + "!";
                            Gün_sayaç++;
                        }


                    }
                }


            }

            return b.Substring(0, b.Length - 1);
        }

        public class Kota_Detay_Tablo
        {
            public string Urun_Adı { get; set; }
            public string Adet { get; set; }
            public string Hedef { get; set; }
            public string Tamamlanan { get; set; }
            public string Yüzde { get; set; }


        }
        [System.Web.Services.WebMethod]
        public static string Kota_Detay(string Tarih_)
        {
            string Tarih = DateTime.Now.ToString("yyyy-MM-01");

            Haftanın_Gunleri(Tarih.Split('-')[1] + "-" + Tarih.Split('-')[0]);





            var queryWithForJson = "declare @Kullanıcı_Id int= (select KullanıcıID from Kullanıcı where KullanıcıAD COLLATE Latin1_general_CS_AS =@kullanıcı)" +
                "select (Urun_Adı),(Adet),(Guncel_DSF*Adet),(cast(ISNULL(( " +
"" +
"select (((SUM(Siparis_Detay.Adet)*Guncel_DSF)/(SUM(Siparis_Detay.Adet)+SUM(Siparis_Detay.Mf_Adet)))*(SUM(Siparis_Detay.Adet)+SUM(Siparis_Detay.Mf_Adet))) from Siparis_Detay " +
"" +
"inner join Sipariş_Genel " +
"on Siparis_Detay.Siparis_Genel_Id=Sipariş_Genel.Siparis_Genel_Id " +
"" +
"where Sipariş_Genel.Olusturan_Kullanıcı=Kota_Genel.Kullanıcı_Id and Siparis_Detay.Urun_Id=Kota_Detay.Urun_Id and Sipariş_Genel.Tar between Ziyaret_Onay.Bas_Tar and Ziyaret_Onay.Bit_Tar " +
"" +
"),0)as decimal(10,2)))as Tamamlanan,(cast(ISNULL(( case when( " +
"" +
"((select (((SUM(Siparis_Detay.Adet)*Guncel_DSF)/(SUM(Siparis_Detay.Adet)+SUM(Siparis_Detay.Mf_Adet)))*(SUM(Siparis_Detay.Adet)+SUM(Siparis_Detay.Mf_Adet))) from Siparis_Detay " +
"" +
"inner join Sipariş_Genel " +
"on Siparis_Detay.Siparis_Genel_Id=Sipariş_Genel.Siparis_Genel_Id " +
"" +
"where Sipariş_Genel.Olusturan_Kullanıcı=Kota_Genel.Kullanıcı_Id and Siparis_Detay.Urun_Id=Kota_Detay.Urun_Id and Sipariş_Genel.Tar between Ziyaret_Onay.Bas_Tar and Ziyaret_Onay.Bit_Tar " +
")*100)/(Guncel_DSF*Adet) )>=100 then 100 else " +
"" +
"((select (((SUM(Siparis_Detay.Adet)*Guncel_DSF)/(SUM(Siparis_Detay.Adet)+SUM(Siparis_Detay.Mf_Adet)))*(SUM(Siparis_Detay.Adet)+SUM(Siparis_Detay.Mf_Adet))) from Siparis_Detay " +
"" +
"inner join Sipariş_Genel " +
"on Siparis_Detay.Siparis_Genel_Id=Sipariş_Genel.Siparis_Genel_Id " +
"" +
"where Sipariş_Genel.Olusturan_Kullanıcı=Kota_Genel.Kullanıcı_Id and Siparis_Detay.Urun_Id=Kota_Detay.Urun_Id and Sipariş_Genel.Tar between Ziyaret_Onay.Bas_Tar and Ziyaret_Onay.Bit_Tar " +
")*100)/(Guncel_DSF*Adet) " +
"" +
"" +
" end " +
"" +
"),0)as decimal(10,2)))as Yuzde " +
"" +
" from Kota_Detay " +
"" +
"inner join Kota_Genel " +
"on Kota_Detay.Kota_Genel_Id=Kota_Genel.Kota_Genel_Id " +
"" +
"inner join Urunler " +
"on Kota_Detay.Urun_Id=Urunler.Urun_Id " +
"" +
"inner join Ziyaret_Onay " +
"on Ziyaret_Onay.Ziyaret_Onay_Id=Kota_Genel.Sipariş_Onay_Id " +
"" +
"" +
"where Ziyaret_Onay.Kullanıcı_Id=@Kullanıcı_Id and  Ziyaret_Onay.Bas_Tar=@Bas_Tar ";



            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);
            cmd.Parameters.AddWithValue("@kullanıcı", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
            cmd.Parameters.AddWithValue("@Bas_Tar", Tarih);




            conn.Open();

            List<Kota_Detay_Tablo> tablo_Doldur_Classes = new List<Kota_Detay_Tablo>();


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


                    var Tablo_Doldur_Class_ = new Kota_Detay_Tablo
                    {
                        Urun_Adı = reader.GetValue(0).ToString(),
                        Adet = reader.GetValue(1).ToString(),
                        Hedef = reader.GetValue(2).ToString(),
                        Tamamlanan = reader.GetValue(3).ToString(),
                        Yüzde = reader.GetValue(4).ToString(),
                    };
                    tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
                }
            }
            conn.Close();
            return JsonConvert.SerializeObject(tablo_Doldur_Classes);





        }

        public class Eczane_Sipariş_İptal_Genel_Sorgu_Tablo
        {
            public string Eczane_Adı { get; set; }
            public string Onay_Durum { get; set; }
            public string İletim_Durum { get; set; }
            public string CityName { get; set; }
            public string TownName { get; set; }
            public string Eczane_Telefon { get; set; }
            public string Eposta { get; set; }
            public string Siparis_Genel_Id { get; set; }
            public string Tar { get; set; }
            public string Onaylanmadıya_Düştümü { get; set; }
            public string Sipariş_Tekrar_Gönderlidimi { get; set; }
        }
        [System.Web.Services.WebMethod]
        public static string Eczane_Sipariş_İptal_Genel_Sorgu(string Sipariş_Id)
        {

            var queryWithForJson = "use kasa   " +
              "select Eczane_Adı,Onay_Durum,İletim_Durum,CityName,TownName,Eczane_Telefon,Eposta,Tar,Siparis_Genel_Id,Onaylanmadıya_Düştümü,Sipariş_Tekrar_Gönderlidimi  from Sipariş_Genel " +

              "inner join Eczane " +
              "on Sipariş_Genel.Eczane_Id=Eczane.Eczane_Id " +
              "inner join Town " +
              "on TownID=Eczane.Eczane_Brick " +
              "inner join City " +
              "on Eczane.Eczane_Il=City.CityID " +

              "where Olusturan_Kullanıcı=(select KullanıcıID from Kullanıcı where KullanıcıAD COLLATE Latin1_general_CS_AS =@1) " +
              " and İletim_Durum=5 and BM_Onayladımı=0 and Bm_Ye_Gönderildimi=0";

            

            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);
            conn.Open();
            cmd.Parameters.AddWithValue("@1", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString()); 



            List<Eczane_Sipariş_İptal_Genel_Sorgu_Tablo> tablo_Doldur_Classes = new List<Eczane_Sipariş_İptal_Genel_Sorgu_Tablo>();


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
                    var Tablo_Doldur_Class_ = new Eczane_Sipariş_İptal_Genel_Sorgu_Tablo
                    {
                        Eczane_Adı = reader.GetValue(0).ToString(),
                        Onay_Durum = reader.GetValue(1).ToString(),
                        İletim_Durum = reader.GetValue(2).ToString(),
                        CityName = reader.GetValue(3).ToString(),
                        TownName = reader.GetValue(4).ToString(),
                        Eczane_Telefon = reader.GetValue(5).ToString(),
                        Eposta = reader.GetValue(6).ToString(),
                        Siparis_Genel_Id = reader.GetValue(8).ToString(),
                        Tar = reader.GetDateTime(7).ToString("dd/MM/yyyy HH:mm"),
                        Onaylanmadıya_Düştümü = reader.GetValue(9).ToString(),
                        Sipariş_Tekrar_Gönderlidimi = reader.GetValue(10).ToString(),

                    };
                    tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
                }
            }


            //  IEnumerable < Ziy_Onay_Tablo > tablo_Doldur_Classes_ = from x in tablo_Doldur_Classes where x.Ad == "10" select x;


            conn.Close();
            return JsonConvert.SerializeObject(tablo_Doldur_Classes);


        }

        public class Bildirim_Tablo
        {
            public string Bildirim_İçeriği { get; set; }
            public string Bildirim_Türü { get; set; }
            public string Görüldümü { get; set; }

        }
        [System.Web.Services.WebMethod]
        public static string Bildirim(string Sınav_Id)
        {

            var queryWithForJson = "use kasa   " +
                "select top 100 Bildirim_İçeriği,Bildirim_Türü,Görüldümü from Bildirim where " +
                "Kullanıcı_Id=(select KullanıcıID from Kullanıcı where KullanıcıAD COLLATE Latin1_general_CS_AS =@1) order by Bildirim_Tar asc ";

            
            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);
            conn.Open();
            cmd.Parameters.AddWithValue("@1", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());



            List<Bildirim_Tablo> tablo_Doldur_Classes = new List<Bildirim_Tablo>();


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
                    var Tablo_Doldur_Class_ = new Bildirim_Tablo
                    {

                        Bildirim_İçeriği = reader.GetValue(0).ToString(),
                        Bildirim_Türü = reader.GetValue(1).ToString(),
                        Görüldümü = reader.GetValue(2).ToString(),
                        

                    };
                    tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
                }
            }


           


            conn.Close();
            return JsonConvert.SerializeObject(tablo_Doldur_Classes);


        }

        public class Sınav_Detay_Tablo_
        {
            public string Sınav_Tar { get; set; }
            public string Sınav_Suresi { get; set; }
            public string Soru_Sayısı { get; set; }
            public string Sınav_Ortalama_Notu { get; set; }

        }
        [System.Web.Services.WebMethod]
        public static string Sınav_Detay_Getir(string Sınav_Id)
        {

            var queryWithForJson = "use kasa   " +
                "select Sınav_Tar,Sınav_Suresi,Soru_Sayısı, cast( " +
                "(select AVG(ISNULL( Sınav_Sonucu ,0)) from Kullanıcının_Girecegi_Sınavlar " +
                "inner join Kullanıcı " +
                "on Kullanıcının_Girecegi_Sınavlar.Kullanıcı_Id=Kullanıcı.KullanıcıID " +
                " where Kullanıcının_Girecegi_Sınav= (select top 1 Sınav_Id from Sınavlar_ where Açıklandımı=1  order by Sınav_Id desc)) " +
                " as decimal(14,2)) as Sınav_Ortalama_Notu from Sınavlar_ where Sınav_Id=(select top 1 Sınav_Id from Sınavlar_ where Açıklandımı=1  order by Sınav_Id desc) " +


                "";

            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);
            conn.Open();
            cmd.Parameters.AddWithValue("@Sınav_Id", Sınav_Id);



            List<Sınav_Detay_Tablo_> tablo_Doldur_Classes = new List<Sınav_Detay_Tablo_>();


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
                    var Tablo_Doldur_Class_ = new Sınav_Detay_Tablo_
                    {
                        Sınav_Tar = reader.GetDateTime(0).ToString("dd/MM/yyyy HH:mm"),
                        Sınav_Suresi = reader.GetValue(1).ToString(),
                        Soru_Sayısı = reader.GetValue(2).ToString(),
                        Sınav_Ortalama_Notu = reader.GetValue(3).ToString(),

                    };
                    tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
                }
            }


            //  IEnumerable < Ziy_Onay_Tablo > tablo_Doldur_Classes_ = from x in tablo_Doldur_Classes where x.Ad == "10" select x;


            conn.Close();
            return JsonConvert.SerializeObject(tablo_Doldur_Classes);


        }

        public class Sınav_Detay_Tablo
        {
            public string KullanıcıID { get; set; }
            public string AD { get; set; }
            public string Soyad { get; set; }
            public string Dogru_Sayısı { get; set; }
            public string Yanlış_Sayısı { get; set; }
            public string Boş_Soru_Sayısı { get; set; }
            public string Sınav_Sonucu { get; set; }

        }
        [System.Web.Services.WebMethod]
        public static string Sınav_Detay(string Sınav_Id)
        {
            var queryWithForJson = "use kasa   " +
                "select KullanıcıID,AD,Soyad, ISNULL( Dogru_Sayısı ,'0'),ISNULL( Yanlış_Sayısı ,'0'),ISNULL( Boş_Soru_Sayısı ,'0'),ISNULL( Sınav_Sonucu ,'0') from Kullanıcının_Girecegi_Sınavlar " +
                "inner join Kullanıcı " +
                "on Kullanıcının_Girecegi_Sınavlar.Kullanıcı_Id=Kullanıcı.KullanıcıID " +
                " where Kullanıcının_Girecegi_Sınav=(select top 1 Sınav_Id from Sınavlar_ where Açıklandımı=1  order by Sınav_Id desc) order by Sınav_Sonucu desc " +
                "" +
                "";

            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);
            conn.Open();
            cmd.Parameters.AddWithValue("@Sınav_Id", Sınav_Id);



            List<Sınav_Detay_Tablo> tablo_Doldur_Classes = new List<Sınav_Detay_Tablo>();


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
                    var Tablo_Doldur_Class_ = new Sınav_Detay_Tablo
                    {
                        KullanıcıID = reader.GetValue(0).ToString(),
                        AD = reader.GetValue(1).ToString(),
                        Soyad = reader.GetValue(2).ToString(),
                        Dogru_Sayısı = reader.GetValue(3).ToString(),
                        Yanlış_Sayısı = reader.GetValue(4).ToString(),
                        Boş_Soru_Sayısı = reader.GetValue(5).ToString(),
                        Sınav_Sonucu = reader.GetValue(6).ToString()
                    };
                    tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
                }
            }





            conn.Close();
            return JsonConvert.SerializeObject(tablo_Doldur_Classes);


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
            public string Eczane_Tip { get; set; }


        }

        [System.Web.Services.WebMethod]
        public static string Ziyaret_Tablosu(string parametre)
        {
            DateTime bu_gun =  DateTime.Now;
            //select * from listeler where Kullanıcı_Id=(select KullanıcıID from Kullanıcı where KullanıcıAD='recai') and cins = 0
            var queryWithForJson = "use kasa " +
                "select  Ziy_Dty_ID,Ziy_Gnl_Id,Ziyaret_Detay.Cins,Doktor_Ad,Eczane_Adı,Ziyaret_Durumu,Brans_Txt,TownName,Unite_Txt ,Eczane_Tip.Eczane_Tip from Ziyaret_Detay  " +
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
                "	full join Eczane_Tip  " +
                " 	on Eczane.Eczane_Tip=Eczane_Tip.Eczane_Tip_Id " +
                "" +
                "" +
                "where Ziyaret_Genel.Ziy_Tar =@Bu_gun and Ziyaret_Detay.Kullanıcı_Id=(select KullanıcıID from Kullanıcı where KullanıcıAD COLLATE Latin1_general_CS_AS =@1)" +
                "";
            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);

            string a = bu_gun.ToString("yyyy-MM-dd");

            cmd.Parameters.AddWithValue("@1", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
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
                        Unite_Txt = reader.GetValue(8).ToString(),
                        Eczane_Tip = reader.GetValue(9).ToString()

                    };
                    tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
                }
            }
            conn.Close();
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
                "declare @Tablo table(Edilen int , Bekleyen int , Edilmeyen int); " +
                "declare @Dedilen int=(select count(*) from Ziyaret_Detay " +
                "inner join Ziyaret_Genel " +
                "on Ziyaret_Detay.Ziy_Gnl_Id=Ziyaret_Genel.ID " +
                "where Ziy_Tar=@Bu_gun and Ziyaret_Genel.Kullanıcı_ID=(select KullanıcıID from Kullanıcı where KullanıcıAD COLLATE Latin1_general_CS_AS =@1) and Ziyaret_Detay.Cins=0 and Ziyaret_Durumu=1) " +
                "declare @DBekleyen int=(select count(*) from Ziyaret_Detay  " +
                "inner join Ziyaret_Genel " +
                "on Ziyaret_Detay.Ziy_Gnl_Id=Ziyaret_Genel.ID " +
                "where Ziy_Tar=@Bu_gun and Ziyaret_Genel.Kullanıcı_ID=(select KullanıcıID from Kullanıcı where KullanıcıAD COLLATE Latin1_general_CS_AS =@1) and Ziyaret_Detay.Cins=0 and Ziyaret_Durumu=0) " +
                "declare @DEdilmeyen int=(select count(*) from Ziyaret_Detay  " +
                "inner join Ziyaret_Genel " +
                "on Ziyaret_Detay.Ziy_Gnl_Id=Ziyaret_Genel.ID " +
                "where Ziy_Tar=@Bu_gun and Ziyaret_Genel.Kullanıcı_ID=(select KullanıcıID from Kullanıcı where KullanıcıAD COLLATE Latin1_general_CS_AS =@1) and Ziyaret_Detay.Cins=0 and Ziyaret_Durumu=2) " +
                "declare @Eedilen int=(select count(*) from Ziyaret_Detay  " +
                "inner join Ziyaret_Genel " +
                "on Ziyaret_Detay.Ziy_Gnl_Id=Ziyaret_Genel.ID " +
                "where Ziy_Tar=@Bu_gun and Ziyaret_Genel.Kullanıcı_ID=(select KullanıcıID from Kullanıcı where KullanıcıAD COLLATE Latin1_general_CS_AS =@1) and Ziyaret_Detay.Cins=1 and Ziyaret_Durumu=1) " +
                "declare @EBekleyen int=(select count(*) from Ziyaret_Detay  " +
                "inner join Ziyaret_Genel " +
                "on Ziyaret_Detay.Ziy_Gnl_Id=Ziyaret_Genel.ID " +
                "where Ziy_Tar=@Bu_gun and Ziyaret_Genel.Kullanıcı_ID=(select KullanıcıID from Kullanıcı where KullanıcıAD COLLATE Latin1_general_CS_AS =@1) and Ziyaret_Detay.Cins=1 and Ziyaret_Durumu=0) " +
                "declare @EEdilmeyen int=(select count(*) from Ziyaret_Detay  " +
                "inner join Ziyaret_Genel " +
                "on Ziyaret_Detay.Ziy_Gnl_Id=Ziyaret_Genel.ID " +
                "where Ziy_Tar=@Bu_gun and Ziyaret_Genel.Kullanıcı_ID=(select KullanıcıID from Kullanıcı where KullanıcıAD COLLATE Latin1_general_CS_AS =@1) and Ziyaret_Detay.Cins=1 and Ziyaret_Durumu=2) " +
                "insert into @Tablo (Edilen,Bekleyen,Edilmeyen) values (@Dedilen,@DBekleyen,@DEdilmeyen) " +
                "insert into @Tablo (Edilen,Bekleyen,Edilmeyen) values (@Eedilen,@EBekleyen,@EEdilmeyen) " +
                "select * from @Tablo " +
                "" +
             
                "";
            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);

            string a = bu_gun.ToString("yyyy-MM-dd");

            cmd.Parameters.AddWithValue("@1", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
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
                "where Sipariş_Genel.Olusturan_Kullanıcı=(select KullanıcıID from Kullanıcı where KullanıcıAD COLLATE Latin1_general_CS_AS =@kullanıcı) and CAST(Tar as date)=@toplam  and Sipariş_Genel.Onay_Durum=1 " +
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
            cmd11.Parameters.AddWithValue("@kullanıcı", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());


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
                "where Sipariş_Genel.Olusturan_Kullanıcı=(select KullanıcıID from Kullanıcı where KullanıcıAD COLLATE Latin1_general_CS_AS =@kullanıcı) and CAST(Tar as date)=@toplam  and Sipariş_Genel.Onay_Durum=1  " +
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
            cmd11.Parameters.AddWithValue("@kullanıcı", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());


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
    }
    
}