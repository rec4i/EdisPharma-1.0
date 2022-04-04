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
  
    
    public partial class Masraf_Girisi : System.Web.UI.Page
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
        public static string Masraf_Ekle(string Doktor_Id, string Masraf_Turu, string Tarih, string Kdv_Oranı, string Belge_Turu, string Toplam_Tutar, string Sirket_Unavnı, string Acıklama)
        {
            //select * from listeler where Kullanıcı_Id=(select KullanıcıID from Kullanıcı where KullanıcıAD='recai') and cins = 0
            var queryWithForJson = "use kasa " +
                "insert into Masraflar(Doktor_Id,Masraf_Turu,Tarih,Kdv_Oranı,Belge_Turu,Toplam_Tutar,Kdv_Tutarı,Kdv_Haric_Tutar,Sirket_Unvani,Açıklama,Kullanıcı_Id)  " +

                "values(@Doktor_Id,@Masraf_Turu,@Tarih,@Kdv_Oranı,@Belge_Turu,@Toplam_Tutar,@Kdv_Tutarı,@Kdv_Haric_Tutar,@Sirket_Unvani,@Açıklama,(select KullanıcıID from Kullanıcı where KullanıcıAD COLLATE Latin1_general_CS_AS ='" + FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString() + "'))";
            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);

            decimal Kdv_Tutarı_ = Convert.ToDecimal(Toplam_Tutar) * Convert.ToDecimal(Kdv_Oranı) / 100;
            decimal Kdc_Haric_Tutuar_ = Convert.ToDecimal(Toplam_Tutar) - Kdv_Tutarı_;
            cmd.Parameters.AddWithValue("@Doktor_Id", Doktor_Id);
            cmd.Parameters.AddWithValue("@Masraf_Turu", Masraf_Turu);
            cmd.Parameters.AddWithValue("@Tarih", Convert.ToDateTime(Tarih));
            cmd.Parameters.AddWithValue("@Kdv_Oranı", Kdv_Oranı);
            cmd.Parameters.AddWithValue("@Belge_Turu", Belge_Turu);

            cmd.Parameters.AddWithValue("@Toplam_Tutar", Toplam_Tutar);
            cmd.Parameters.AddWithValue("@Kdv_Tutarı", Kdv_Tutarı_);
            cmd.Parameters.AddWithValue("@Kdv_Haric_Tutar", Kdc_Haric_Tutuar_);

            cmd.Parameters.AddWithValue("@Sirket_Unvani", Sirket_Unavnı);
            cmd.Parameters.AddWithValue("@Açıklama", Acıklama);
            


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
        public class Tablo_Doldur_Class
        {
            public string Doktor_Ad { get; set; }
            public string Tur_Txt { get; set; }
            public string Belge_Tur_Txt { get; set; }
            public string Sirket_Unvanı { get; set; }
            public string Açıklama { get; set; }
            public string Kdv_Tutarı { get; set; }
            public string Kdv_Haric_Tutar { get; set; }
            public string Toplam_Tutar { get; set; }
            public string Tarih { get; set; }
            public string Kdv_Oranı { get; set; }
            public string Masraf_Id { get; set; }

        }

        [System.Web.Services.WebMethod]
        public static string Tablo_Doldur(string parametre)
        {
            //select * from listeler where Kullanıcı_Id=(select KullanıcıID from Kullanıcı where KullanıcıAD='recai') and cins = 0
            var queryWithForJson = "use kasa " +
                "select Doktor_Ad,Masraf_Tur.Tur_Txt,Belge_Tur.Belge_Tur_Txt,Sirket_Unvani,Açıklama,Kdv_Tutarı,Kdv_Haric_Tutar,Toplam_Tutar,Tarih,Kdv_Oranı,Masraf_Id from Masraflar " +
                "inner join Doktors  " +
                " on Masraflar.Doktor_Id= Doktors.Doktor_Id " +
                "inner join Masraf_Tur " +
                "on Masraflar.Masraf_Turu=Masraf_Tur.Masraf_Tur_Id " +
                " inner join Belge_Tur " +
                "on Masraflar.Belge_Turu=Belge_Tur.Belge_Tur_Id " +
                "where Tarih between @1 and @2 and Kullanıcı_Id= (select KullanıcıID from Kullanıcı where KullanıcıAD COLLATE Latin1_general_CS_AS ='" + FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString() + "') ";
            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);
            cmd.Parameters.AddWithValue("@1", parametre.Split('!')[0]);
            cmd.Parameters.AddWithValue("@2", parametre.Split('!')[1]);

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
                        Doktor_Ad = reader.GetValue(0).ToString(),
                        Tur_Txt = reader.GetValue(1).ToString(),
                        Belge_Tur_Txt = reader.GetValue(2).ToString(),
                        Sirket_Unvanı = reader.GetValue(3).ToString(),
                        Açıklama = reader.GetValue(4).ToString(),

                        Kdv_Tutarı = reader.GetValue(5).ToString(),
                        Kdv_Haric_Tutar = reader.GetValue(6).ToString(),
                        Toplam_Tutar = reader.GetValue(7).ToString(),
                        Tarih = reader.GetDateTime(8).ToString("dd-MM-yyyy"),
                        Kdv_Oranı = "%"+reader.GetValue(9).ToString(),
                        Masraf_Id= reader.GetValue(10).ToString()
                    };
                    tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
                }
            }
            conn.Close();
            return JsonConvert.SerializeObject(tablo_Doldur_Classes);


        }//Masrafı_Kaldır
        [System.Web.Services.WebMethod]
        public static string Masrafı_Kaldır(string parametre)
        {
            var queryWithForJson = "delete Masraflar where Masraf_Id=@1";
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


        }
        [System.Web.Services.WebMethod]
        public static string Masraf_Turu(string parametre)
        {
            var queryWithForJson = "use kasa select * from Masraf_Tur ";
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
        public static string Belge_Turu(string parametre)
        {
            var queryWithForJson = "use kasa select * from Belge_Tur ";
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
                conn.Close();
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