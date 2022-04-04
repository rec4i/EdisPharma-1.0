using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json;

namespace deneme9
{
    public partial class Sınav_Sonuc : System.Web.UI.Page
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
                " where Kullanıcının_Girecegi_Sınav=@Sınav_Id order by Sınav_Sonucu desc " +
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
                " where Kullanıcının_Girecegi_Sınav= @Sınav_Id) " +
                " as decimal(14,2)) as Sınav_Ortalama_Notu from Sınavlar_ where Sınav_Id=@Sınav_Id " +
     

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
        public class Ziy_Onay_Tablo
        {
            public string Sınav_Id { get; set; }
            public string Sınav_Tar { get; set; }
            public string Sınav_Adı { get; set; }
            public string Sınav_Suresi { get; set; }
            public string Soru_Sayısı { get; set; }
            public string Açıklandımı { get; set; }
            public string Sınav_Hesaplandımı { get; set; }

        }
        [System.Web.Services.WebMethod]
        public static string Ziy_Onay_Tablo_Doldur(string Bas_Tar, string Bit_Tar)
        {
            var queryWithForJson = "use kasa   " +
                "select Sınav_Id,Sınav_Tar,Sınav_Adı,Sınav_Suresi,Soru_Sayısı,Açıklandımı,Sınav_Hesaplandımı  from Sınavlar_   " +
                "where cast(Sınav_Tar as date) between @Bas_Tar and @Bit_Tar " +
             

                "";

            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);
            conn.Open();
            cmd.Parameters.AddWithValue("@Bas_Tar", Bas_Tar);
            cmd.Parameters.AddWithValue("@Bit_Tar", Bit_Tar);



            List<Ziy_Onay_Tablo> tablo_Doldur_Classes = new List<Ziy_Onay_Tablo>();


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
                    var Tablo_Doldur_Class_ = new Ziy_Onay_Tablo
                    {
                        Sınav_Id = reader.GetValue(0).ToString(),
                        Sınav_Tar = reader.GetDateTime(1).ToString("dd/MM/yyyy HH:mm"),
                        Sınav_Adı = reader.GetValue(2).ToString(),
                        Sınav_Suresi = reader.GetValue(3).ToString(),
                        Soru_Sayısı = reader.GetValue(4).ToString(),
                        Açıklandımı = reader.GetValue(5).ToString(),
                        Sınav_Hesaplandımı = reader.GetValue(6).ToString()
                    };
                    tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
                }
            }


            //  IEnumerable < Ziy_Onay_Tablo > tablo_Doldur_Classes_ = from x in tablo_Doldur_Classes where x.Ad == "10" select x;


            conn.Close();
            return JsonConvert.SerializeObject(tablo_Doldur_Classes);


        }
        [System.Web.Services.WebMethod]
        public static string Hesapla(string Sınav_Id)
        {

            var queryWithForJson = "use kasa   " +
                "declare @Tablo_Girecek table(Kullanıcı_Sınavı_Id int , Dogru_Sayısı int , Yanlıs_Sayısı int , Bos_Soru_Sayısı int ,Sınav_Sonucu decimal(14,2)) " +
                "insert into @Tablo_Girecek(Kullanıcı_Sınavı_Id,Dogru_Sayısı,Yanlıs_Sayısı,Bos_Soru_Sayısı,Sınav_Sonucu) " +
                "select Kullanıcının_Girecegi_Sınav_Id, " +
                "(select sum(numbers) " +
                "from " +
                "( " +
                " SELECT CAST( " +
                "CASE " +
                "WHEN VerilenCevap_ıd = (select Sık_Id from Şıklar inner join Sorular on Şıklar.Soru_Id=Sorular.Soru_Id where Sorular.Soru_Id=Kullanıcının_Soruları.Soru_ıd and Dogrumu=1)  " +
                "   THEN 1 " +
                "  ELSE 0 " +
                "END AS int) as numbers  " +
                "FROM Kullanıcının_Soruları where Kullanıcının_Gireceği_Sınavlar_Id=Kullanıcının_Girecegi_Sınavlar.Kullanıcının_Girecegi_Sınav_Id " +
                ") src)as Dogru_Sayısı_ , " +
                "(select sum(numbers) " +
                "from " +
                "( " +
                " SELECT CAST( " +
                "CASE " +
                "WHEN VerilenCevap_ıd != (select Sık_Id from Şıklar inner join Sorular on Şıklar.Soru_Id=Sorular.Soru_Id where Sorular.Soru_Id=Kullanıcının_Soruları.Soru_ıd and Dogrumu=1)  and VerilenCevap_ıd!=0 " +
                "THEN 1 " +
                " ELSE 0 " +
                "END AS int) as numbers  " +
                "FROM Kullanıcının_Soruları where Kullanıcının_Gireceği_Sınavlar_Id=Kullanıcının_Girecegi_Sınavlar.Kullanıcının_Girecegi_Sınav_Id " +
                ") src)as Yanlıs_Sayısı_ , " +
                "(select count(*) from Kullanıcının_Soruları where Kullanıcının_Soruları.Kullanıcının_Gireceği_Sınavlar_Id=Kullanıcının_Girecegi_Sınavlar.Kullanıcının_Girecegi_Sınav_Id and VerilenCevap_ıd=0) as Boş_Soru_Sayısı_, " +
                "((select sum(numbers) " +
                "from " +
                "( " +
                " SELECT CAST( " +
                " CASE " +
                " WHEN VerilenCevap_ıd = (select Sık_Id from Şıklar inner join Sorular on Şıklar.Soru_Id=Sorular.Soru_Id where Sorular.Soru_Id=Kullanıcının_Soruları.Soru_ıd and Dogrumu=1)  " +
                " THEN 1 " +
                "  ELSE 0 " +
                "END AS int) as numbers  " +
                "FROM Kullanıcının_Soruları where Kullanıcının_Gireceği_Sınavlar_Id=Kullanıcının_Girecegi_Sınavlar.Kullanıcının_Girecegi_Sınav_Id " +
                ") src)*(cast(100/Soru_Sayısı as decimal(14,2))))as Sınav_Sonucu " +
                " from Kullanıcının_Girecegi_Sınavlar  " +
                " inner join Sınavlar_ " +
                " on Kullanıcının_Girecegi_Sınav=Sınavlar_.Sınav_Id " +
                "where Kullanıcının_Girecegi_Sınav=@Sınav_Id " +
                "update Sınavlar_ set Sınav_Hesaplandımı=1 where Sınav_Id=@Sınav_Id " +
                "UPDATE " +
                "Kullanıcının_Girecegi_Sınavlar " +
                "SET " +
                "  Kullanıcının_Girecegi_Sınavlar.Dogru_Sayısı = Tablo_Girecek.Dogru_Sayısı, " +
                "    Kullanıcının_Girecegi_Sınavlar.Yanlış_Sayısı = Tablo_Girecek.Yanlıs_Sayısı, " +
                "Kullanıcının_Girecegi_Sınavlar.Boş_Soru_Sayısı = Tablo_Girecek.Bos_Soru_Sayısı, " +
                "Kullanıcının_Girecegi_Sınavlar.Sınav_Sonucu = Tablo_Girecek.Sınav_Sonucu " +
                "FROM " +
                "  Kullanıcının_Girecegi_Sınavlar AS Kullanıcının_Girecegi_Sınavlar " +
                "INNER JOIN @Tablo_Girecek AS Tablo_Girecek " +
                "ON Kullanıcının_Girecegi_Sınavlar.Kullanıcının_Girecegi_Sınav_Id = Tablo_Girecek.Kullanıcı_Sınavı_Id " +
                "" +
        

                "";

            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);
            conn.Open();
            cmd.Parameters.AddWithValue("@Sınav_Id", Sınav_Id);

            cmd.ExecuteNonQuery();


            conn.Close();
            return "1";


        }
        [System.Web.Services.WebMethod]
        public static string Açıkla(string Sınav_Id)
        {
            Hesapla(Sınav_Id);
            var queryWithForJson = "use kasa  " +
                "update Sınavlar_ set Açıklandımı=1 where Sınav_Id=@Sınav_Id ";
        

            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);
            conn.Open();
            cmd.Parameters.AddWithValue("@Sınav_Id", Sınav_Id);

            cmd.ExecuteNonQuery();


            conn.Close();
            return "1";


        }
    }
}