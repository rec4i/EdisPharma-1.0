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
    public partial class Numune_Talebi : System.Web.UI.Page
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
        public static string İlaç_Listesi(string parametre)
        {
            //select * from listeler where Kullanıcı_Id=(select KullanıcıID from Kullanıcı where KullanıcıAD='recai') and cins = 0
            var queryWithForJson = "use kasa select UrunID,UrunADI from Urunler2 ";
            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);


            conn.Open();

            var reader = cmd.ExecuteReader();

            string a = "";
            while (reader.Read())
            {
                a += reader.GetValue(0).ToString() + "-" + reader.GetValue(1).ToString() + "!";
            }
            if (a == "")
            {
                conn.Close();
                return "0-Hiç Liste Bulunamadı Lütfen Yeni Liste Oluşturunuz";
            }
            else
            {
                conn.Close();
                return a.Substring(0, a.Length - 1);
            }


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
        [System.Web.Services.WebMethod]
        public static string Numune_Talebi_Kaldır(string parametre)
        {
            var queryWithForJson = "delete Numune_Talebi where Numune_Talebi_Id=@1";
            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);

            cmd.Parameters.AddWithValue("@1", parametre);
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

                return "";

            }


        }
        [System.Web.Services.WebMethod]
        public static string Talep_Oluştur(string Doktor_Id, string Tarih,string İlaç_Adı, string Adet)//tarihi Sql de verdim sıkıntı çıkmasın
        {
            var queryWithForJson = "use kasa " +
                "insert into Numune_Talebi (Doktor_Id,Tarih,İlaç_Id,Adet,Kullanıcı_Id)   " +

                "values(@Doktor_Id,@Tarih,@İlaç_Id,@Adet,(select KullanıcıID from Kullanıcı where KullanıcıAD COLLATE Latin1_general_CS_AS ='" + FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString() + "'))";
            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);

            cmd.Parameters.AddWithValue("@Doktor_Id", Doktor_Id);
            cmd.Parameters.AddWithValue("@Tarih", Tarih);
            cmd.Parameters.AddWithValue("@İlaç_Id", İlaç_Adı);
            cmd.Parameters.AddWithValue("@Adet", Adet);




            conn.Open();

            var reader = cmd.ExecuteReader();

            string a = "";
            while (reader.Read())
            {
                a += reader.GetValue(0).ToString() + "-" + reader.GetValue(1).ToString() + "!";
            }
            if (a == "")
            {
                return "0-Hiç Liste Bulunamadı Lütfen Yeni Liste Oluşturunuz";
            }
            else
            {
                return a.Substring(0, a.Length - 1);
            }


        }
        public class Numune_Tablo
        {
            public string Numune_Talebi_Id { get; set; }
            public string Doktor_Ad { get; set; }
            public string Tarih { get; set; }
            public string UrunADI { get; set; }
            public string Adet { get; set; }

        }
        [System.Web.Services.WebMethod]
        public static string Tablo_Doldur(string parametre)
        {
            //select * from listeler where Kullanıcı_Id=(select KullanıcıID from Kullanıcı where KullanıcıAD='recai') and cins = 0
            var queryWithForJson = "use kasa " +
                "select Numune_Talebi_Id,Doktor_Ad,Tarih,UrunADI,Adet from Numune_Talebi " +
                "inner join Doktors " +
                "on Doktors.Doktor_Id=Numune_Talebi.Doktor_Id " +
                "inner join Urunler2 " +
                "on Numune_Talebi.İlaç_Id=Urunler2.UrunID " +
                "where Tarih between @1 and @2 and Kullanıcı_Id= (select KullanıcıID from Kullanıcı where KullanıcıAD COLLATE Latin1_general_CS_AS ='" + FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString() + "') ";
            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);
            cmd.Parameters.AddWithValue("@1", parametre.Split('!')[0]);
            cmd.Parameters.AddWithValue("@2", parametre.Split('!')[1]);

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
                        Numune_Talebi_Id = reader.GetValue(0).ToString(),
                        
                        Doktor_Ad = reader.GetValue(1).ToString(),
                        Tarih = reader.GetDateTime(2).ToString("dd-MM-yyyy"),
                        UrunADI = reader.GetValue(3).ToString(),
                        Adet = reader.GetValue(4).ToString(),

                    };
                    tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
                }
            }
            return JsonConvert.SerializeObject(tablo_Doldur_Classes);


        }//Masrafı_Kaldır
        [System.Web.Services.WebMethod]
        public static string Yeni_Liste_Olustur_Listeler(string parametre)
        {
            //select * from listeler where Kullanıcı_Id=(select KullanıcıID from Kullanıcı where KullanıcıAD='recai') and cins = 0
            var queryWithForJson = "use kasa select * from listeler where Kullanıcı_Id=(select KullanıcıID from Kullanıcı where KullanıcıAD COLLATE Latin1_general_CS_AS ='" + FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString() + "') and cins = 0 ";
            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);


            conn.Open();

            var reader = cmd.ExecuteReader();

            string a = "";
            while (reader.Read())
            {
                a += reader.GetValue(0).ToString() + "-" + reader.GetValue(1).ToString() + "!";
            }
            if (a == "")
            {
                return "0-Hiç Liste Bulunamadı Lütfen Yeni Liste Oluşturunuz";
            }
            else
            {
                return a.Substring(0, a.Length - 1);
            }


        }
        [System.Web.Services.WebMethod]
        public static string OrnekPost(string parametre)
        {


            //try
            //{
            if (Convert.ToInt32(parametre.Split('-')[0]) == 0)
            {
                var queryWithForJson = "use kasa select * from city ";
                var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
                var cmd = new SqlCommand(queryWithForJson, conn);
                conn.Open();

                var reader = cmd.ExecuteReader();

                string a = "";
                while (reader.Read())
                {
                    a += reader.GetValue(0).ToString() + "-" + reader.GetValue(2).ToString() + "!";
                }
                return a.Substring(0, a.Length - 1);
            }
            //pediatri , kbb, kadın doğum , ortopedi, üroloji,yeni doğan ,acil
            if (Convert.ToInt32(parametre.Split('-')[0]) == 1)
            {

                var queryWithForJson = "use kasa select* from Town where CityID =  " + parametre.Split('-')[1];
                var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
                var cmd = new SqlCommand(queryWithForJson, conn);
                conn.Open();

                var reader = cmd.ExecuteReader();

                string a = "";

                while (reader.Read())
                {
                    a += reader.GetValue(0).ToString() + "-" + reader.GetValue(2).ToString() + "!";
                }
                conn.Close();

                return a.Substring(0, a.Length - 1);


            }
            if (Convert.ToInt32(parametre.Split('-')[0]) == 2)
            {

                var queryWithForJson = "use kasa select* from Unite where Brick__Id= " + parametre.Split('-')[1];
                var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
                var cmd = new SqlCommand(queryWithForJson, conn);
                conn.Open();

                var reader = cmd.ExecuteReader();

                string a = "";

                while (reader.Read())
                {
                    a += reader.GetValue(0).ToString() + "-" + reader.GetValue(2).ToString() + "!";
                }
                conn.Close();

                return a.Substring(0, a.Length - 1);


            }
            if (Convert.ToInt32(parametre.Split('-')[0]) == 3)
            {

                var queryWithForJson = "use kasa select * from unite where Unite_ID = " + parametre.Split('-')[1];
                var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
                var cmd = new SqlCommand(queryWithForJson, conn);
                conn.Close();
                conn.Open();

                var reader = cmd.ExecuteReader();

                string a = "";

                while (reader.Read())
                {
                    a += reader.GetValue(3).ToString();
                }
                conn.Close();


                var queryWithForJson1 = "use kasa select * from Branchs";
                var conn1 = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
                var cmd1 = new SqlCommand(queryWithForJson1, conn1);

                conn1.Open();

                var reader1 = cmd1.ExecuteReader();

                int x = 0;
                string b = "";

                while (reader1.Read())
                {

                    if (a.Split('-')[x] == reader1.GetValue(0).ToString())
                    {
                        if (a.Split('-').Length - 1 != x)
                        {
                            b += reader1.GetValue(0).ToString() + "-" + reader1.GetValue(1).ToString().Trim() + "!";
                            x++;
                        }
                        else
                        {
                            b += reader1.GetValue(0).ToString() + "-" + reader1.GetValue(1).ToString().Trim() + "!";
                            continue;

                        }



                    }

                }

                reader1.Close();
                conn1.Close();
                return b.Substring(0, b.Length - 1);







            }
            if (Convert.ToInt32(parametre.Split('-')[0]) == 4)
            {

                var queryWithForJson = "use kasa SELECT  Doktors.Doktor_Id, Doktor_Ad ,Doktor_Brans ,Unite_Txt,TownName,CityName,Doktor_Liste.Frekans,Doktor_Liste_Id  FROM Doktor_Liste  INNER JOIN Listeler ON Doktor_Liste.Liste_Id=Listeler.Liste_Id INNER JOIN Doktors ON Doktor_Liste.Doktor_ıd=Doktors.Doktor_Id INNER JOIN Unite ON Doktors.Doktor_Unite_ID=Unite_ID INNER JOIN Town ON TownID=Unite.Brick__Id INNER JOIN City ON City.CityID=Town.CityID Where Listeler.Liste_Id= " + parametre.Split('-')[2] + " and Listeler.cins = 0 and Doktor_Brans_Id=" + parametre.Split('-')[1];
                var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
                var cmd = new SqlCommand(queryWithForJson, conn);
                conn.Open();

                var reader = cmd.ExecuteReader();

                string a = "";



                while (reader.Read())
                {
                    a += reader.GetValue(0).ToString() + "-" + reader.GetValue(1).ToString() + "-" + reader.GetValue(6).ToString() + "!";
                }
                if (a == "")
                {
                    conn.Close();
                    return "hata-hata-hata";
                }
                else
                {
                    conn.Close();
                    return a.Substring(0, a.Length - 1);
                }




            }
            if (Convert.ToInt32(parametre.Split('-')[0]) == 5)
            {

                var queryWithForJson = "select Eczane.Eczane_Id,Frekans,Eczane_Adı from Eczane_Liste inner join Eczane on Eczane_liste.Eczane_Id=Eczane.Eczane_Id Where Eczane.Eczane_Brick=" + parametre.Split('-')[1];
                var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
                var cmd = new SqlCommand(queryWithForJson, conn);
                conn.Open();

                var reader = cmd.ExecuteReader();

                string a = "";



                while (reader.Read())
                {
                    a += reader.GetValue(0).ToString() + "-" + reader.GetValue(1).ToString() + "-" + reader.GetValue(2).ToString() + "!";
                }
                conn.Close();
                return a.Substring(0, a.Length - 1);



            }

            return "asd";

            //}


            //catch (Exception)
            //{
            //    return "Bir hata oluştu";

            //}
        }
    }
}