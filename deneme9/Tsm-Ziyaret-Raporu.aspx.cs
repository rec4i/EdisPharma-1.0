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
    public partial class Tsm_Ziyaret_Raporu : System.Web.UI.Page
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
                  "if((select Kullanıcı_Bogle from Kullanıcı where KullanıcıID= @Kullanıcı_Ad)=(select Kullanıcı_Bogle from Kullanıcı where KullanıcıAD COLLATE Latin1_general_CS_AS =@Gonderen_Kullanıcı )) " +
                  "begin; " +
                   "select DISTINCT  Ziy_Tar from Ziyaret_Genel where Kullanıcı_ID=@Kullanıcı_Ad  and Ziy_Tar between @Bas_Tar and @Bit_Tar  " +
                    "end;" +
                        "", SqlC.con);



                cmd11.Parameters.AddWithValue("@Kullanıcı_Ad", TSM);
                cmd11.Parameters.AddWithValue("@Gonderen_Kullanıcı", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd11.Parameters.AddWithValue("@Bas_Tar", Bas_Tar);
                cmd11.Parameters.AddWithValue("@Bit_Tar", Bit_Tar);

                SqlDataAdapter sda11 = new SqlDataAdapter(cmd11);
                DataTable dt11 = new DataTable();
                sda11.Fill(dt11);
                Repeater1.DataSource = dt11;
                Repeater1.DataBind();
                SqlC.con.Close();

            }

        }
        public class Ziy_Onay_Tablo
        {
            public string Eczane_Adı { get; set; }
            public string Eczane_Id { get; set; }
            public string Brick { get; set; }
            public string Şehir { get; set; }
            public string Ziyaret_Durumu { get; set; }
            public string Gun { get; set; }
            public string Cins { get; set; }
            public string Ziyaret_Detay_Id { get; set; }
            public string Çalışılan_Urunler { get; set; }
        
            public string Ziyaret_Notu { get; set; }


        }
        [System.Web.Services.WebMethod]
        public static string Tabloları_Doldur_Eczane(string parametre)

        {
            string gelen_yıl = parametre.Split('*')[0];
            string gelen_ay = parametre.Split('*')[1];
            string Kullanıcı = parametre.Split('*')[2];
            var queryWithForJson = "use kasa   " +
                "select Eczane.Eczane_Adı,Ziyaret_Detay.Eczane_Id,TownName,CityName,Ziyaret_Detay.Ziyaret_Durumu,format(Ziy_Tar,'dd'),Ziyaret_Detay.Cins,Ziyaret_Genel.Kullanıcı_ID,Ziy_Dty_ID, " +
                       "  isnull((select replace(STUFF((select ';'+Urun_Adı from Ziyaret_Calışılan_Urunler inner join Urunler on Urun_Id=Calışılan_Urun_Id where Ziyaret_Calışılan_Urunler.Ziyaret_Detay_Id=Ziy_Dty_ID FOR XML PATH('') ),1,1,''),'&#x0D;','') from Ziyaret_Calışılan_Urunler where Ziyaret_Detay_Id=Ziyaret_Detay.Ziy_Dty_ID group by Ziyaret_Detay_Id),'Ürün Çalışılmamış')as yarraq, " +
                "Ziyaret_Notu     " +
                "from Ziyaret_Detay  " +
                "inner join Ziyaret_Genel  " +
                "on Ziyaret_Detay.Ziy_Gnl_Id=Ziyaret_Genel.ID  " +
                "inner join Eczane  " +
                "on Eczane.Eczane_Id=Ziyaret_Detay.Eczane_Id   " +
                "INNER JOIN Town  " +
                "ON  Eczane.Eczane_Brick = Town.TownID  " +
                "inner join City  " +
                "on Town.CityID=City.CityID  " +
                "where Ziyaret_Genel.Kullanıcı_ID = (select KullanıcıID from Kullanıcı where   KullanıcıID    =@Kullanıcı_Adı) and Ziyaret_Genel.Ziy_Tar between @baslagıc_Tar and @bitis_tar " +
                "";


            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);
            conn.Open();
            cmd.Parameters.AddWithValue("@Kullanıcı_Adı", Kullanıcı);//@baslagıc_Tar//@bitis_tar
            cmd.Parameters.AddWithValue("@baslagıc_Tar", gelen_yıl);
            cmd.Parameters.AddWithValue("@bitis_tar", gelen_ay);



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
                        Eczane_Adı = reader.GetValue(0).ToString(),
                        Eczane_Id = reader.GetValue(1).ToString(),
                        Brick = reader.GetValue(2).ToString(),
                        Şehir = reader.GetValue(3).ToString(),
                        Ziyaret_Durumu = reader.GetValue(4).ToString(),
                        Gun = reader.GetValue(5).ToString(),
                        Cins = reader.GetValue(6).ToString(),
                        Ziyaret_Detay_Id = reader.GetValue(7).ToString(),
                        Çalışılan_Urunler = reader.GetValue(9).ToString(),
                       
                        Ziyaret_Notu = reader.GetValue(10).ToString(),



                    };
                    tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
                }
            }


            //  IEnumerable < Ziy_Onay_Tablo > tablo_Doldur_Classes_ = from x in tablo_Doldur_Classes where x.Ad == "10" select x;


            conn.Close();
            return JsonConvert.SerializeObject(tablo_Doldur_Classes);


        }
        public class Tabloları_Doldur_Doktor
        {
            public string Doktor_Ad { get; set; }
            public string Doktor_Id { get; set; }
            public string Brans { get; set; }
            public string Unite { get; set; }
            public string Brick { get; set; }
            public string Ziyaret_Durumu { get; set; }
            public string Gun { get; set; }
            public string Cins { get; set; }
            public string Ziyaret_Detay_ıd { get; set; }
            public string Çalışılan_Urunler { get; set; }
      
            public string Ziyaret_Notu { get; set; }


        }
        [System.Web.Services.WebMethod]
        public static string Tabloları_Doldur(string parametre)

        {


            string gelen_yıl = parametre.Split('*')[0];
            string gelen_ay = parametre.Split('*')[1];
            string Kullanıcı = parametre.Split('*')[2];
            var queryWithForJson = "SELECT Doktors.Doktor_Ad, Ziyaret_Detay.Doktor_Id,Brans_Txt,Unite.Unite_Txt,TownName,Ziyaret_Detay.Ziyaret_Durumu,format(Ziy_Tar,'dd'),Ziyaret_Detay.Cins,Ziyaret_Genel.Kullanıcı_ID ,Ziy_Dty_ID,  " +
                "  isnull((select replace(STUFF((select ';'+Urun_Adı from Ziyaret_Calışılan_Urunler inner join Urunler on Urun_Id=Calışılan_Urun_Id where Ziyaret_Calışılan_Urunler.Ziyaret_Detay_Id=Ziy_Dty_ID FOR XML PATH('') ),1,1,''),'&#x0D;','') from Ziyaret_Calışılan_Urunler where Ziyaret_Detay_Id=Ziyaret_Detay.Ziy_Dty_ID group by Ziyaret_Detay_Id),'Ürün Çalışılmamış')as yarraq, " +

"                Ziyaret_Notu " +
"                FROM Ziyaret_Detay " +
"                INNER JOIN Ziyaret_Genel  " +
"                ON Ziyaret_Detay.Ziy_Gnl_Id = Ziyaret_Genel.ID  " +
"                INNER JOIN Doktors " +
"                ON  Doktors.Doktor_Id = Ziyaret_Detay.Doktor_Id  " +
"                INNER JOIN Unite  " +
"                ON  Doktors.Doktor_Unite_ID = Unite.Unite_ID  " +
"                INNER JOIN Town " +
"                ON  Unite.Brick__Id = Town.TownID " +
"                INNER JOIN Branchs " +
"                ON  Doktors.Doktor_Brans_Id = .Branchs.Brans_ID " +
"                where Ziyaret_Genel.Kullanıcı_ID = (select KullanıcıID from Kullanıcı where   KullanıcıID    =@Kullanıcı_Adı) and Ziyaret_Genel.Ziy_Tar between @baslagıc_Tar and @bitis_tar";


            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);
            conn.Open();
            cmd.Parameters.AddWithValue("@Kullanıcı_Adı", Kullanıcı);//@baslagıc_Tar//@bitis_tar
            cmd.Parameters.AddWithValue("@baslagıc_Tar", gelen_yıl);
            cmd.Parameters.AddWithValue("@bitis_tar", gelen_ay);



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
                    var Tablo_Doldur_Class_ = new Tabloları_Doldur_Doktor
                    {
                        Doktor_Ad = reader.GetValue(0).ToString(),
                        Doktor_Id = reader.GetValue(1).ToString(),
                        Brans = reader.GetValue(2).ToString(),
                        Unite = reader.GetValue(3).ToString(),
                        Brick = reader.GetValue(4).ToString(),
                        Ziyaret_Durumu = reader.GetValue(5).ToString(),
                        Gun = reader.GetValue(6).ToString(),
                        Cins = reader.GetValue(7).ToString(),
                        Ziyaret_Detay_ıd = reader.GetValue(8).ToString(),
                        Çalışılan_Urunler = reader.GetValue(10).ToString(),
                        Ziyaret_Notu = reader.GetValue(11).ToString(),



                    };
                    tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
                }
            }


            //  IEnumerable < Ziy_Onay_Tablo > tablo_Doldur_Classes_ = from x in tablo_Doldur_Classes where x.Ad == "10" select x;


            conn.Close();
            return JsonConvert.SerializeObject(tablo_Doldur_Classes);


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

        public class Tabloları_Doldur_Doktor_Grafik_Tablo
        {
            public string Adet { get; set; }
            public string Urun_Adı { get; set; }
        }

        [System.Web.Services.WebMethod]
        public static string Tabloları_Doldur_Doktor_Grafik(string parametre)
        {


            string gelen_yıl = parametre.Split('*')[0];
            string gelen_ay = parametre.Split('*')[1];
            string Kullanıcı = parametre.Split('*')[2];

   var queryWithForJson = "select COUNT(*),Urun_Adı from Ziyaret_Calışılan_Urunler " +
"" +
"inner join Ziyaret_Detay " +
"on Ziyaret_Calışılan_Urunler.Ziyaret_Detay_Id=Ziy_Dty_ID " +
"" +
"inner join Ziyaret_Genel " +
"on Ziyaret_Genel.ID=Ziyaret_Detay.Ziy_Gnl_Id " +
"" +
"inner join Urunler " +
"on Ziyaret_Calışılan_Urunler.Calışılan_Urun_Id=Urun_Id  " +
"" +
"" +
"where Ziyaret_Detay.Cins=0  and Ziy_Tar between @baslagıc_Tar and @bitis_tar and Ziyaret_Detay.Kullanıcı_ID=@Kullanıcı_Adı group by Ziyaret_Calışılan_Urunler.Calışılan_Urun_Id , Urun_Adı";


            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);
            conn.Open();
            cmd.Parameters.AddWithValue("@Kullanıcı_Adı", Kullanıcı);//@baslagıc_Tar//@bitis_tar
            cmd.Parameters.AddWithValue("@baslagıc_Tar", gelen_yıl);
            cmd.Parameters.AddWithValue("@bitis_tar", gelen_ay);



            List<Tabloları_Doldur_Doktor_Grafik_Tablo> tablo_Doldur_Classes = new List<Tabloları_Doldur_Doktor_Grafik_Tablo>();


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
                    var Tablo_Doldur_Class_ = new Tabloları_Doldur_Doktor_Grafik_Tablo
                    {
                        Adet = reader.GetValue(0).ToString(),
                        Urun_Adı = reader.GetValue(1).ToString(),
                    };
                    tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
                }
            }

            conn.Close();
            return JsonConvert.SerializeObject(tablo_Doldur_Classes);

        }


        [System.Web.Services.WebMethod]
        public static string Tabloları_Doldur_Eczane_Grafik(string parametre)
        {


            string gelen_yıl = parametre.Split('*')[0];
            string gelen_ay = parametre.Split('*')[1];
            string Kullanıcı = parametre.Split('*')[2];

            var queryWithForJson = "select COUNT(*),Urun_Adı from Ziyaret_Calışılan_Urunler " +
         "" +
         "inner join Ziyaret_Detay " +
         "on Ziyaret_Calışılan_Urunler.Ziyaret_Detay_Id=Ziy_Dty_ID " +
         "" +
         "inner join Ziyaret_Genel " +
         "on Ziyaret_Genel.ID=Ziyaret_Detay.Ziy_Gnl_Id " +
         "" +
         "inner join Urunler " +
         "on Ziyaret_Calışılan_Urunler.Calışılan_Urun_Id=Urun_Id  " +
         "" +
         "" +
         "where Ziyaret_Detay.Cins=1  and Ziy_Tar between @baslagıc_Tar and @bitis_tar and Ziyaret_Detay.Kullanıcı_ID=@Kullanıcı_Adı group by Ziyaret_Calışılan_Urunler.Calışılan_Urun_Id , Urun_Adı";


            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);
            conn.Open();
            cmd.Parameters.AddWithValue("@Kullanıcı_Adı", Kullanıcı);//@baslagıc_Tar//@bitis_tar
            cmd.Parameters.AddWithValue("@baslagıc_Tar", gelen_yıl);
            cmd.Parameters.AddWithValue("@bitis_tar", gelen_ay);



            List<Tabloları_Doldur_Doktor_Grafik_Tablo> tablo_Doldur_Classes = new List<Tabloları_Doldur_Doktor_Grafik_Tablo>();


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
                    var Tablo_Doldur_Class_ = new Tabloları_Doldur_Doktor_Grafik_Tablo
                    {
                        Adet = reader.GetValue(0).ToString(),
                        Urun_Adı = reader.GetValue(1).ToString(),
                    };
                    tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
                }
            }

            conn.Close();
            return JsonConvert.SerializeObject(tablo_Doldur_Classes);

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