using Newtonsoft.Json;
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

namespace deneme9
{
    public partial class Sınav_Detay : System.Web.UI.Page
    {
        public static string Kullanıcı_Adı = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["kullanici"] != null)
            {
                Kullanıcı_Adı = Session["Kullanici"].ToString();
                //Response.Write("Hoşgeldin " + Session["kullanici"]);
                SqlC.con.Close();
            }
            else
            {
                 
                SqlC.con.Close();
            }
        }
        public class Sınav_Bilgileri_
        {
            public string Soru_Sayısı { get; set; }
            public string Soru_Başı_Saniye { get; set; }



        }
        [System.Web.Services.WebMethod]
        public static string Soru_Suresi(string parametre)
        {

            var queryWithForJson = "Use Kasa " +
                "select top 1 Sınavlar_.Soru_Sayısı,Sınavlar_.Sınav_Suresi from Kullanıcının_Soruları  " +
                "inner join  Kullanıcının_Girecegi_Sınavlar  " +
                "on Kullanıcının_Soruları.Sınav_Id=Kullanıcının_Girecegi_Sınavlar.Kullanıcının_Girecegi_Sınav  and Kullanıcının_Girecegi_Sınavlar.Kullanıcı_Id=Kullanıcının_Soruları.Kullanıcı_ıd " +
                "inner join Sınavlar_ " +
                "on Kullanıcının_Girecegi_Sınavlar.Kullanıcının_Girecegi_Sınav=Sınavlar_.Sınav_Id " +
                "where Kullanıcının_Girecegi_Sınavlar.Sınavı_Baslattımı=1 and Kullanıcının_Soruları.Kullanıcı_ıd=(select KullanıcıID from Kullanıcı Where KullanıcıAD COLLATE Latin1_general_CS_AS =@Kullanıcı_Id) " +
                "order by Kullanıcının_Soruları_Id ";


            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);

            cmd.Parameters.AddWithValue("@Kullanıcı_Id", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());//@baslagıc_Tar//@bitis_tar


            conn.Open();

            List<Sınav_Bilgileri_> tablo_Doldur_Classes = new List<Sınav_Bilgileri_>();


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


                    var Tablo_Doldur_Class_ = new Sınav_Bilgileri_
                    {
                        Soru_Sayısı = reader.GetValue(0).ToString(),
                        Soru_Başı_Saniye = reader.GetValue(1).ToString(),

                    };
                    tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
                }
            }
            conn.Close();
            return JsonConvert.SerializeObject(tablo_Doldur_Classes);

        }

        public class Sureyi_Getir_Tablo
        {
            public string Sınav_Süresi { get; set; }
     

        }
        [System.Web.Services.WebMethod]
        public static string Sureyi_Getir_Parametreli(string Sınav_Id,string Sure)
        {


            var queryWithForJson = "Use Kasa " +
                "update Kullanıcının_Girecegi_Sınavlar set Kalan_Zaman=(dateadd(SECOND,-cast(@Sure as int),Kalan_Zaman)) where Kullanıcının_Girecegi_Sınav_Id= @Sınav_Id  " +
                "select DATEADD(SECOND,(DATEDIFF(SECOND, '1/1/1900', CONVERT(DATETIME, Kalan_Zaman))),GETDATE()) from Kullanıcının_Girecegi_Sınavlar where Kullanıcının_Girecegi_Sınav_Id= @Sınav_Id  ";


            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);

            cmd.Parameters.AddWithValue("@Sınav_Id", Sınav_Id);//@baslagıc_Tar//@bitis_tar
            cmd.Parameters.AddWithValue("@Sure", Sure);//@baslagıc_Tar//@bitis_tar

            conn.Open();

            List<Sureyi_Getir_Tablo> tablo_Doldur_Classes = new List<Sureyi_Getir_Tablo>();

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


                    var Tablo_Doldur_Class_ = new Sureyi_Getir_Tablo
                    {
                        Sınav_Süresi = reader.GetDateTime(0).ToString("yyyy/MM/dd HH:mm:ss"),
                    };
                    tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
                }
            }
            conn.Close();
            return JsonConvert.SerializeObject(tablo_Doldur_Classes);


        }
        [System.Web.Services.WebMethod]
        public static string Sureyi_Getir(string Sınav_Id)
        {


            var queryWithForJson = "Use Kasa " +
                "update Kullanıcının_Girecegi_Sınavlar set Kalan_Zaman=(dateadd(SECOND,-1,Kalan_Zaman)) where Kullanıcının_Girecegi_Sınav_Id= @Sınav_Id  " +
                "select DATEADD(SECOND,(DATEDIFF(SECOND, '1/1/1900', CONVERT(DATETIME, Kalan_Zaman))),GETDATE()) from Kullanıcının_Girecegi_Sınavlar where Kullanıcının_Girecegi_Sınav_Id= @Sınav_Id  ";


            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);

            cmd.Parameters.AddWithValue("@Sınav_Id", Sınav_Id);//@baslagıc_Tar//@bitis_tar


            conn.Open();

            List<Sureyi_Getir_Tablo> tablo_Doldur_Classes = new List<Sureyi_Getir_Tablo>();

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


                    var Tablo_Doldur_Class_ = new Sureyi_Getir_Tablo
                    {
                        Sınav_Süresi = reader.GetDateTime(0).ToString("yyyy/MM/dd HH:mm:ss"),
                    };
                    tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
                }
            }
            conn.Close();
            return JsonConvert.SerializeObject(tablo_Doldur_Classes);


        }

        public class Sınav_Tarih_Tablo
        {
            public string Sınav_Tar { get; set; }
            public string Sınav_Tar_Süresi { get; set; }
            public string Sınav_Id { get; set; }



        }
        [System.Web.Services.WebMethod]
        public static string Sınav_Tarihi(string parametre)
        {

            var queryWithForJson = "Use Kasa " +
                "select top 1 DATEADD(second,(Sınav_Suresi*Soru_Sayısı),Sınav_Tar),Kalan_Zaman,Kullanıcının_Girecegi_Sınav_Id from Kullanıcının_Soruları  " +
                "inner join  Kullanıcının_Girecegi_Sınavlar  " +
                "on Kullanıcının_Soruları.Sınav_Id=Kullanıcının_Girecegi_Sınavlar.Kullanıcının_Girecegi_Sınav  and Kullanıcının_Girecegi_Sınavlar.Kullanıcı_Id=Kullanıcının_Soruları.Kullanıcı_ıd " +
                "inner join Sınavlar_ " +
                "on Kullanıcının_Girecegi_Sınavlar.Kullanıcının_Girecegi_Sınav=Sınavlar_.Sınav_Id " +
                "where Kullanıcının_Girecegi_Sınavlar.Sınavı_Baslattımı=1 and Kullanıcının_Soruları.Kullanıcı_ıd=(select KullanıcıID from Kullanıcı Where KullanıcıAD COLLATE Latin1_general_CS_AS =@Kullanıcı_Id) " +
                "order by Kullanıcının_Soruları_Id ";


            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);

            cmd.Parameters.AddWithValue("@Kullanıcı_Id", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());//@baslagıc_Tar//@bitis_tar


            conn.Open();

            List<Sınav_Tarih_Tablo> tablo_Doldur_Classes = new List<Sınav_Tarih_Tablo>();

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


                    var Tablo_Doldur_Class_ = new Sınav_Tarih_Tablo
                    {
                        Sınav_Tar = reader.GetDateTime(0).ToString("yyyy/MM/dd HH:mm:ss"),
                        Sınav_Tar_Süresi = reader.GetValue(1).ToString(),
                        Sınav_Id = reader.GetValue(2).ToString()

                    };
                    tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
                }
            }
            conn.Close();
            return JsonConvert.SerializeObject(tablo_Doldur_Classes);


        }

        [System.Web.Services.WebMethod]
        public static string Sonraki_Soru(string parametre)
        {

            var queryWithForJson = "Use Kasa " +
                "declare @tablo table (id int Identity(1,1),Deneme int ,soru_ıd int,Bu_Sorudamı int,Kullanıcı_Soru_ID int,sınav_Id int)  " +
                " insert into @tablo select Kullanıcının_Soruları.Kullanıcı_ıd,Kullanıcının_Soruları.Soru_ıd,Bu_Sorudamı,Kullanıcının_Soruları.Kullanıcının_Soruları_Id,Kullanıcının_Girecegi_Sınavlar.Kullanıcının_Girecegi_Sınav_Id from Kullanıcının_Soruları   " +
                "inner join Kullanıcının_Girecegi_Sınavlar  " +
                " on Kullanıcının_Girecegi_Sınavlar.Kullanıcının_Girecegi_Sınav=Kullanıcının_Soruları.Sınav_Id  and Kullanıcının_Girecegi_Sınavlar.Kullanıcı_Id=Kullanıcının_Soruları.Kullanıcı_ıd " +
                "where Sınavı_Baslattımı=1 and Kullanıcının_Soruları.Kullanıcı_Id= (select KullanıcıID from Kullanıcı Where KullanıcıAD COLLATE Latin1_general_CS_AS =@Kullanıcı_Id)  " +
                "" +
                "if((select  id from @tablo where Kullanıcı_Soru_ID=@Gelen_Id)=(select id from @tablo where id=(select max(id) from @tablo))) " +
                "	begin " +
                "update Kullanıcının_Soruları set Kullanıcının_Soruları.Bu_Sorudamı=0,Kullanıcının_Soruları.Cevaplandımı=1, VerilenCevap_ıd= @Gelen_Cevap where Kullanıcının_Soruları.Kullanıcının_Soruları_Id=@Gelen_Id " +
                " update Kullanıcının_Girecegi_Sınavlar set Sınavı_Bittimi=1 where Kullanıcının_Girecegi_Sınav_Id=(select top 1 sınav_Id from @tablo) " +
                "select 2; " +
                "end " +
                "else " +
                "	begin " +
                "" +
                "update Kullanıcının_Soruları set Kullanıcının_Soruları.Bu_Sorudamı=0,Kullanıcının_Soruları.Cevaplandımı=1, VerilenCevap_ıd= @Gelen_Cevap where Kullanıcının_Soruları.Kullanıcının_Soruları_Id=@Gelen_Id " +
                " update Kullanıcının_Soruları set Kullanıcının_Soruları.Bu_Sorudamı=1 where Kullanıcının_Soruları.Kullanıcının_Soruları_Id=@Gelen_Id+1 " +
                "select 1;" +
                "end";

            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);

            string asdsad = FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString();

            cmd.Parameters.AddWithValue("@Gelen_Id", parametre.Split('-')[0]);//@baslagıc_Tar//@bitis_tar
            cmd.Parameters.AddWithValue("@Gelen_Cevap", parametre.Split('-')[1]);//@baslagıc_Tar//@bitis_tar
            cmd.Parameters.AddWithValue("@Kullanıcı_Id", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());//@baslagıc_Tar//@bitis_tar


            conn.Open();

            var reader = cmd.ExecuteReader();

            string a = "";

            while (reader.Read())
            {
                a += reader.GetValue(0);
            }

            conn.Close();
            return a;


        }
        [System.Web.Services.WebMethod]
        public static string Soru_Listesi(string parametre)
        {

            var queryWithForJson = "Use Kasa " +
                "select * from Kullanıcının_Soruları " +
                "inner join  Kullanıcının_Girecegi_Sınavlar " +
                "on Kullanıcının_Soruları.Sınav_Id=Kullanıcının_Girecegi_Sınavlar.Kullanıcının_Girecegi_Sınav and Kullanıcının_Girecegi_Sınavlar.Kullanıcı_Id=Kullanıcının_Soruları.Kullanıcı_ıd " +
                "where Kullanıcının_Girecegi_Sınavlar.Sınavı_Baslattımı=1 and Kullanıcının_Soruları.Kullanıcı_ıd=(select KullanıcıID from Kullanıcı Where KullanıcıAD COLLATE Latin1_general_CS_AS =@Kullanıcı_Id) " +
                "order by Kullanıcının_Soruları_Id";
            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);

            cmd.Parameters.AddWithValue("@Kullanıcı_Id", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());//@baslagıc_Tar//@bitis_tar


            conn.Open();

            var reader = cmd.ExecuteReader();

            string a = "";

            while (reader.Read())
            {
                a += reader.GetValue(5) + "!";
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
        public class Soru_Getir_Tablo
        {
            public string Simdiki_Soru_Id { get; set; }
            public string Soru_Id { get; set; }

            public string Soru_Sayısı { get; set; }
            public string Soru { get; set; }


            public string Sık { get; set; }
            public string Sık_Id { get; set; }
            
        }
        [System.Web.Services.WebMethod]
        public static string Soru_Getir(string parametre)
        {

            var queryWithForJson = "Use Kasa " +
                "declare @tablo table (id int Identity(1,1),Deneme int ,soru_ıd int) ;" +
                "insert into @tablo select Kullanıcının_Soruları.Kullanıcı_ıd,Kullanıcının_Soruları.Soru_ıd from Kullanıcının_Soruları  " +
                "inner join Kullanıcının_Girecegi_Sınavlar " +
                "on Kullanıcının_Girecegi_Sınavlar.Kullanıcının_Girecegi_Sınav=Kullanıcının_Soruları.Sınav_Id and Kullanıcının_Girecegi_Sınavlar.Kullanıcı_Id=Kullanıcının_Soruları.Kullanıcı_ıd " +
                "where Sınavı_Baslattımı=1 and Kullanıcının_Soruları.Kullanıcı_Id= (select KullanıcıID from Kullanıcı Where KullanıcıAD COLLATE Latin1_general_CS_AS =@Kullanıcı_Id) " +
                "" +
                "select (select id from @tablo where soru_ıd= Kullanıcının_Soruları.Soru_ıd ) as Kacıncı_Soru ,  Kullanıcının_Soruları_Id,Sorular.Soru_ıd,Soru_Kendisi,Sık_Id,Sık_txt from Kullanıcının_Soruları  " +
                " inner join Sorular " +
                " on Kullanıcının_Soruları.Soru_ıd=Sorular.Soru_Id " +
                " inner join Kullanıcının_Girecegi_Sınavlar " +
                "  on Kullanıcının_Girecegi_Sınavlar.Kullanıcının_Girecegi_Sınav=Sınav_Id " +
                " inner join Şıklar " +
                " on Şıklar.Soru_Id=Sorular.Soru_Id " +
                " where Kullanıcının_Soruları.Kullanıcı_ıd= (select KullanıcıID from Kullanıcı Where KullanıcıAD COLLATE Latin1_general_CS_AS =@Kullanıcı_Id) and Kullanıcının_Girecegi_Sınavlar.Kullanıcı_ıd= (select KullanıcıID from Kullanıcı Where KullanıcıAD COLLATE Latin1_general_CS_AS =@Kullanıcı_Id) and Sınavı_Baslattımı=1 and Bu_Sorudamı = 1 order by NEWID() ";


            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);

            cmd.Parameters.AddWithValue("@Kullanıcı_Id", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());//@baslagıc_Tar//@bitis_tar


            conn.Open();



            List<Soru_Getir_Tablo> tablo_Doldur_Classes = new List<Soru_Getir_Tablo>();

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


                    var Tablo_Doldur_Class_ = new Soru_Getir_Tablo
                    {
                        Soru_Sayısı = reader.GetValue(0).ToString(),
                        Simdiki_Soru_Id = reader.GetValue(1).ToString(),
                        Soru_Id = reader.GetValue(2).ToString(),
                        Soru = reader.GetValue(3).ToString(),
                        Sık_Id = reader.GetValue(4).ToString(),
                        Sık = reader.GetValue(5).ToString(),


                    };
                    tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
                }
            }
            conn.Close();
            return JsonConvert.SerializeObject(tablo_Doldur_Classes);


            //var reader = cmd.ExecuteReader();

            //string a = "";

            //while (reader.Read())
            //{
            //    a += reader.GetValue(0) + "-" + reader.GetValue(10) + "-" + reader.GetValue(25) + "-" + reader.GetValue(21) + "-" + reader.GetValue(1) + "-" + reader.GetValue(2) + "!";
            //}


            //if (a == "")
            //{
            //    conn.Close();
            //    return "hata";
            //}
            //else
            //{
            //    conn.Close();
            //    return a.Substring(0, a.Length - 1);
            //}

        }
    }
}