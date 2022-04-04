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
    public partial class Eczane_Ekle_Cikar : System.Web.UI.Page
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
        public class Doktor_Liste_Tablo
        {
            public string Eczane_Tip_Id { get; set; }
            public string Eczane_Tip_Text { get; set; }

        }

        [System.Web.Services.WebMethod]
        public static string Eczane_Tip(string Liste_Adı)
        {



            var queryWithForJson = " " +
                "select * from Eczane_Tip" +
                " ";




            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);
            cmd.Parameters.AddWithValue("@Liste_Adı", Liste_Adı);
            cmd.Parameters.AddWithValue("@Kullanıcı_Adı", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
            conn.Open();



            List<Doktor_Liste_Tablo> tablo_Doldur_Classes = new List<Doktor_Liste_Tablo>();
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
                    var Tablo_Doldur_Class_ = new Doktor_Liste_Tablo
                    {
                        Eczane_Tip_Id = reader.GetValue(0).ToString(),
                        Eczane_Tip_Text = reader.GetValue(1).ToString(),
                        

                    };
                    tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
                }
            }
            conn.Close();
            return JsonConvert.SerializeObject(tablo_Doldur_Classes);


        }
        [System.Web.Services.WebMethod]
        public static string Zamanlı_Giriş_Deneme(string parametre)
        {
            DateTime Şimdiki_zaman = DateTime.Now;



            return Convert.ToString(Şimdiki_zaman.ToString());
        }
        [System.Web.Services.WebMethod]
        public static void Eczane_Ekle(string ad, string Brick, string Il, string Adres, string Telefon, string Eczane_Tip)
        {



            var queryWithForJson = "insert into Eczane (Eczane_Adı,Eczane_Brick,Eczane_Il,Eczane_Adres,Eczane_Telefon,Eczane_Tip) " +
                "values (@Eczane_adı,@Eczane_Brick,@Eczane_ıl,@Eczane_Adres,@Eczane_Telefon,@Eczane_Tip) ";
            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);
            cmd.Parameters.AddWithValue("@Eczane_adı", ad);
            cmd.Parameters.AddWithValue("@Eczane_Brick", Brick);
            cmd.Parameters.AddWithValue("@Eczane_ıl", Il);
            cmd.Parameters.AddWithValue("@Eczane_Adres", Adres);
            cmd.Parameters.AddWithValue("@Eczane_Telefon", Telefon);
            cmd.Parameters.AddWithValue("@Eczane_Tip", Eczane_Tip);
            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();


        }
        public class Eczane_Liste
        {
            public string Eczane_Id { get; set; }
            public string Eczane_Adı { get; set; }
            public string Eczane_Adres { get; set; }
            public string Eczane_Telefon { get; set; }
            public string Eczane_Tip { get; set; }

        }

        [System.Web.Services.WebMethod]
        public static string Eczane_Listele_detay(string Eczane_Id)
        {



            var queryWithForJson = "use kasa  select Eczane_Id,Eczane_Adı,Eczane_Adres,Eczane_Telefon,Eczane_Tip.Eczane_Tip from Eczane " +
                "inner join Eczane_Tip " +
                "on Eczane.Eczane_Tip=Eczane_Tip.Eczane_Tip_Id" +
                " where Eczane_Id =@1" +
    
                " ";





            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);
            cmd.Parameters.AddWithValue("@1", Eczane_Id);

            conn.Open();



            List<Eczane_Liste> tablo_Doldur_Classes = new List<Eczane_Liste>();
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
                    var Tablo_Doldur_Class_ = new Eczane_Liste
                    {
                        Eczane_Id = reader.GetValue(0).ToString(),
                        Eczane_Adı = reader.GetValue(1).ToString(),
                        Eczane_Adres = reader.GetValue(2).ToString(),
                        Eczane_Telefon = reader.GetValue(3).ToString(),
                        Eczane_Tip = reader.GetValue(4).ToString(),


                    };
                    tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
                }
            }
            conn.Close();
            return JsonConvert.SerializeObject(tablo_Doldur_Classes);


        }
        [System.Web.Services.WebMethod]
        public static string Eczane_Listele(string parametre)
        {
            var queryWithForJson = "use kasa select Eczane_Id,Eczane_Adı,Eczane_Adres,Eczane_Telefon from Eczane where  Silinmismi=0 and Eczane_Brick = " + parametre.Split('-')[0];
            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);
            conn.Open();

            var reader = cmd.ExecuteReader();

            string a = "";
            if (!reader.HasRows)
            {
                return a;
            }
            else
            {
                while (reader.Read())
                {
                    a += reader.GetValue(0).ToString() + "-" + reader.GetValue(1).ToString() + "-" + reader.GetValue(2).ToString() + "-" + reader.GetValue(3).ToString() + "!";
                }
                return a.Substring(0, a.Length - 1);
            }
  

        }

        [System.Web.Services.WebMethod]
        public static string Eczane_Çıkar_Button(string parametre)
        {
            var queryWithForJson = "use kasa " +
                " update Eczane_Liste set Silinmismi=1 where Eczane_Id= @Eczane_Id " +
                "" +
                "UPDATE Eczane set Silinmismi=1 where Eczane_Id=@Eczane_Id " +
                "";
            
            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);
            conn.Open();
            cmd.Parameters.AddWithValue("@Eczane_Id", parametre);
            cmd.ExecuteNonQuery();
            conn.Close();
            return "1";

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

                var queryWithForJson = "select * from Eczane where Eczane_Brick=" + parametre.Split('-')[1];
                var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
                var cmd = new SqlCommand(queryWithForJson, conn);
                conn.Open();

                var reader = cmd.ExecuteReader();

                string a = "";



                while (reader.Read())
                {
                    a += reader.GetValue(0).ToString() + "-" + reader.GetValue(1).ToString() + "-" + reader.GetValue(4).ToString() + "!";
                }
                conn.Close();
                return a.Substring(0, a.Length - 1);



            }

            return "HATA!!";

           
        }

    }
}