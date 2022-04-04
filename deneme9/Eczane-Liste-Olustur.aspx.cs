using Microsoft.AspNetCore.Authorization;
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
    public partial class Eczane_Liste_Olustur : System.Web.UI.Page
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
        public static string Eczane_Liste_Ad_Değiştir(string Liste_Id,string Liste_Yeni_Ad)
        {

            var queryWithForJson = "update  Listeler set Liste_Ad=@Liste_Yeni_Ad where Liste_Id=@Liste_Id";

            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);
            cmd.Parameters.AddWithValue("@Liste_Id", Liste_Id);
            cmd.Parameters.AddWithValue("@Liste_Yeni_Ad", Liste_Yeni_Ad);
            conn.Open();

            var reader = cmd.ExecuteReader();

            string a = "";
            while (reader.Read())
            {
                a += reader.GetValue(0).ToString();
            }
            if (a == "")
            {
                return "0";
            }
            else
            {
                return a;
            }


        }
        [System.Web.Services.WebMethod]
        public static string Eczane_Liste_Ad_Sil(string Liste_Id)
        {

            var queryWithForJson = "delete from listeler where Liste_Id=@Liste_Id";

            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);
            cmd.Parameters.AddWithValue("@Liste_Id", Liste_Id);
            conn.Open();

            var reader = cmd.ExecuteReader();

            string a = "";
            while (reader.Read())
            {
                a += reader.GetValue(0).ToString();
            }
            if (a == "")
            {
                return "0";
            }
            else
            {
                return a;
            }


        }


        public class Eczane_Listesi_Class
        {
            public string Eczane { get; set; }
            public string Eczane_Tip { get; set; }

            public string TownName { get; set; }
            public string CityName { get; set; }
            
            public string Eczane_Id { get; set; }
            public string Frekans { get; set; }
        }

        [System.Web.Services.WebMethod]
        public static string Yeni_Liste_Olustur_Listeler_Tablo(string Liste_Id)
        {



            var queryWithForJson = "select Eczane_Adı,Eczane_Tip.Eczane_Tip,TownName,CityName,Eczane_Liste.Eczane_Liste_ıd,Eczane_Liste.Frekans from Eczane_Liste " +
                " inner join Eczane " +
                "on Eczane_liste.Eczane_Id=Eczane.Eczane_Id  " +
                "inner join Listeler " +
                "on Eczane_Liste.Liste_Id=Listeler.Liste_Id " +
                "inner join Town " +
                "on Eczane.Eczane_Brick=TownID " +
                " inner join City  " +
                "on Town.CityID=City.CityID " +
                " inner join Eczane_Tip " +
                "on Eczane.Eczane_Tip=Eczane_Tip.Eczane_Tip_Id " +
                "" +
                "" +
                "" +

               "  Where Listeler.Liste_Id=  @1  and Listeler.cins = 1 and Eczane_Liste.Silinmismi=0 ";




            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);
            cmd.Parameters.AddWithValue("@1", Liste_Id);
            conn.Open();



            List<Eczane_Listesi_Class> tablo_Doldur_Classes = new List<Eczane_Listesi_Class>();
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
                    var Tablo_Doldur_Class_ = new Eczane_Listesi_Class
                    {
                        Eczane = reader.GetValue(0).ToString(),
                        Eczane_Tip = reader.GetValue(1).ToString(),
                        TownName = reader.GetValue(2).ToString(),
                        CityName = reader.GetValue(3).ToString(),
                        Eczane_Id = reader.GetValue(4).ToString(),
                        Frekans = reader.GetValue(5).ToString(),

                    };
                    tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
                }
            }
            conn.Close();
            return JsonConvert.SerializeObject(tablo_Doldur_Classes);


        }

        public class Geçmiş_Sorgu_Tablo
        {
            public string Doktor_Id { get; set; }
            public string Doktor_Ad { get; set; }
          
            public string CityName { get; set; }
            public string TownName { get; set; }
            public string Eczacı_Adı { get; set; }

        }

        [System.Web.Services.WebMethod]
        public static string Doktor_Listele(string Şehir, string Semt)

        {

       

            DataSet Şehir_Dataset = JsonConvert.DeserializeObject<DataSet>(Şehir);
            DataTable Şehir_Datatable = Şehir_Dataset.Tables["Şehir_Liste"];


            DataSet Semt_Dataset = JsonConvert.DeserializeObject<DataSet>(Semt);
            DataTable Semt_Datatable = Semt_Dataset.Tables["Semt_Liste"];

        

            var queryWithForJson = "" +

            "declare @Max int=2147483647; " +
            "declare @Min int=0; " +



            " select top 1000 Eczane_Id , Eczane_Adı,CityName,TownName,Eczacı_Adı from Eczane  " +
            "" +
          
            " inner join Town  " +
            "  on Eczane_Brick=Town.TownID " +
            " inner join City " +
            "  on Eczane_Il=City.CityID " +
        
            "" +

            "" +

            " inner join @Geçmiş_Sorgu_Şehir_table " +
            " on (select(case when (Şehir_ is  null) then CityName else Şehir_  end))=City.CityName " +

            " inner join @Geçmiş_Sorgu_Semt_table " +
            " on (select(case when (Semt is  null) then TownName else Semt  end))=Town.TownName " +
           
            "";




            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);






            SqlParameter tvpParam1 = cmd.Parameters.AddWithValue("@Geçmiş_Sorgu_Şehir_table", Şehir_Datatable);
            tvpParam1.SqlDbType = SqlDbType.Structured;
            tvpParam1.TypeName = "dbo.Geçmiş_Sorgu_Şehir";

            SqlParameter tvpParam2 = cmd.Parameters.AddWithValue("@Geçmiş_Sorgu_Semt_table", Semt_Datatable);
            tvpParam2.SqlDbType = SqlDbType.Structured;
            tvpParam2.TypeName = "dbo.Geçmiş_Sorgu_Semt";


        

            List<Geçmiş_Sorgu_Tablo> tablo_Doldur_Classes = new List<Geçmiş_Sorgu_Tablo>();

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
                    var Tablo_Doldur_Class_ = new Geçmiş_Sorgu_Tablo
                    {
                        Doktor_Id = reader.GetValue(0).ToString(),
                        Doktor_Ad = reader.GetValue(1).ToString(),
                      
                        CityName = reader.GetValue(2).ToString(),
                        TownName = reader.GetValue(3).ToString(),
                        Eczacı_Adı = reader.GetValue(4).ToString(),

                    };
                    tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
                }
            }
            conn.Close();
            return JsonConvert.SerializeObject(tablo_Doldur_Classes);




        }//Masrafı_Kaldır
        [System.Web.Services.WebMethod]
        public static string Doktor_Listele_With_List(string Şehir, string Semt,string Liste_Id)

        {



            DataSet Şehir_Dataset = JsonConvert.DeserializeObject<DataSet>(Şehir);
            DataTable Şehir_Datatable = Şehir_Dataset.Tables["Şehir_Liste"];


            DataSet Semt_Dataset = JsonConvert.DeserializeObject<DataSet>(Semt);
            DataTable Semt_Datatable = Semt_Dataset.Tables["Semt_Liste"];



            var queryWithForJson = "" +

            "declare @Max int=2147483647; " +
            "declare @Min int=0; " +



            " select top 1000 Eczane_Liste.Eczane_Id , Eczane_Adı,CityName,TownName from Eczane_Liste  " +
            "" +
            "  inner join Eczane on Eczane_Liste.Eczane_Id=Eczane.Eczane_Id " +

            " inner join Town  " +
            "  on Eczane_Brick=Town.TownID " +
            " inner join City " +
            "  on Eczane_Il=City.CityID " +

            "" +

            "" +

            " inner join @Geçmiş_Sorgu_Şehir_table " +
            " on (select(case when (Şehir_ is  null) then CityName else Şehir_  end))=City.CityName " +

            " inner join @Geçmiş_Sorgu_Semt_table " +
            " on (select(case when (Semt is  null) then TownName else Semt  end))=Town.TownName " +

            "where Liste_Id=@Liste_Id";




            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);
            cmd.Parameters.AddWithValue("@Liste_Id", Liste_Id);






            SqlParameter tvpParam1 = cmd.Parameters.AddWithValue("@Geçmiş_Sorgu_Şehir_table", Şehir_Datatable);
            tvpParam1.SqlDbType = SqlDbType.Structured;
            tvpParam1.TypeName = "dbo.Geçmiş_Sorgu_Şehir";

            SqlParameter tvpParam2 = cmd.Parameters.AddWithValue("@Geçmiş_Sorgu_Semt_table", Semt_Datatable);
            tvpParam2.SqlDbType = SqlDbType.Structured;
            tvpParam2.TypeName = "dbo.Geçmiş_Sorgu_Semt";




            List<Geçmiş_Sorgu_Tablo> tablo_Doldur_Classes = new List<Geçmiş_Sorgu_Tablo>();

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
                    var Tablo_Doldur_Class_ = new Geçmiş_Sorgu_Tablo
                    {
                        Doktor_Id = reader.GetValue(0).ToString(),
                        Doktor_Ad = reader.GetValue(1).ToString(),

                        CityName = reader.GetValue(2).ToString(),
                        TownName = reader.GetValue(3).ToString(),

                    };
                    tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
                }
            }
            conn.Close();
            return JsonConvert.SerializeObject(tablo_Doldur_Classes);




        }//Masrafı_Kaldır



        [System.Web.Services.WebMethod]
        public static string Eczaneyi_Listeden_Kaldır(string parametre)
        {
            if (parametre.Split('-')[0] != "undefined")
            {
                var queryWithForJson = "use kasa update Eczane_Liste set Silinmismi=1 where Eczane_Liste_ıd=@1";

                var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
                var cmd = new SqlCommand(queryWithForJson, conn);
                cmd.Parameters.AddWithValue("@1", parametre.Split('-')[0]);
                conn.Open();

                cmd.ExecuteNonQuery();
                conn.Close();
                return "1";
               

            }
            else
            {
                return "0";
            }



        }

      

        [System.Web.Services.WebMethod]
        public static string Yeni_Liste_Olustur_Liste_Ekle(string parametre)
        {

            var queryWithForJson = "use kasa INSERT INTO Listeler (Liste_Ad, Kullanıcı_Id, cins) OUTPUT INSERTED.Liste_Id VALUES ('" + parametre.Split('-')[0] + "',(select KullanıcıID from Kullanıcı where KullanıcıAD COLLATE Latin1_general_CS_AS ='" + FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString() + "'),1)";

            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);
            conn.Open();

            var reader = cmd.ExecuteReader();

            string a = "";
            while (reader.Read())
            {
                a += reader.GetValue(0).ToString();
            }
            if (a == "")
            {
                return "0-Liste Oluşturlamadı";
            }
            else
            {
                return a;
            }


        }

        [System.Web.Services.WebMethod]
        public static string Eczane_Liste_Ekle_btn(string parametre)
        {
            //doktor frekans liste

            string Liste_ıd = parametre.Split('-')[2];

            string Eczane_Id = parametre.Split('-')[0];

            string Frekans = parametre.Split('-')[1];

         

            var queryWithForJson1 = "use kasa IF  EXISTS(select * from Eczane where Eczane_Tip IS NULL and Eczane_Id=@Eczane_Id) " +
                "Begin;" +
                "Select 1 ;" +
                "End;" +
                "else " +
                "begin;" +
                "" +
                "IF Not EXISTS( SELECT * FROM Eczane_Liste WHERE Liste_Id=@Liste_Id  AND Eczane_Id=@Eczane_Id And Silinmismi=0) " +
                "BEGIN INSERT INTO Eczane_Liste (Liste_Id, Eczane_ıd, Frekans) output Inserted.Eczane_Liste_Id " +
                "VALUES (@Liste_Id,@Eczane_Id ,@Frekans)  END ;end;";



            var conn1 = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd1 = new SqlCommand(queryWithForJson1, conn1);
            cmd1.Parameters.AddWithValue("@Liste_Id", Liste_ıd);
            cmd1.Parameters.AddWithValue("@Eczane_Id", Eczane_Id);
            cmd1.Parameters.AddWithValue("@Frekans", Frekans);
            conn1.Open();
            var reader = cmd1.ExecuteReader();

            string a = "";
            while (reader.Read())
            {
                a += reader.GetValue(0).ToString();
            }
            conn1.Close();
            if (a == "")
            {
                return "0";
            }
            else
            {
                return a;
            }


        }
        public class Eczane_Listele_Tablo
        {
            public string Eczane_Id { get; set; }
            public string Eczane_Adı { get; set; }
            public string Eczane_Adres { get; set; }
            public string Eczane_Telefon { get; set; }


        }
        [System.Web.Services.WebMethod]
        public static string Eczane_Listele(string parametre)
        {
            var queryWithForJson = "use kasa select Eczane_Id,Eczane_Adı,Eczane_Adres,Eczane_Telefon from Eczane where Silinmismi=0 and Eczane_Brick = " + parametre.Split('-')[0];



            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);

            cmd.Parameters.AddWithValue("@Kullanıcı_Adı", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
            conn.Open();



            List<Eczane_Listele_Tablo> tablo_Doldur_Classes = new List<Eczane_Listele_Tablo>();
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
                    var Tablo_Doldur_Class_ = new Eczane_Listele_Tablo
                    {
                        Eczane_Id = reader.GetValue(0).ToString(),
                        Eczane_Adı = reader.GetValue(1).ToString(),
                        Eczane_Adres = reader.GetValue(2).ToString(),
                        Eczane_Telefon = reader.GetValue(3).ToString(),
                    };
                    tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
                }
            }
            conn.Close();
            return JsonConvert.SerializeObject(tablo_Doldur_Classes);


        }

       
        public class Listeler
        {
            public string Liste_Id { get; set; }
            public string Liste_Ad { get; set; }

        }

        [System.Web.Services.WebMethod]
        public static string Yeni_Liste_Olustur_Listeler(string Liste_Adı)
        {



            var queryWithForJson = "use kasa select * from listeler " +
                "where " +
                "Kullanıcı_Id=(select KullanıcıID from Kullanıcı where KullanıcıAD COLLATE Latin1_general_CS_AS =@Kullanıcı_Adı) " +
                "and " +
                "cins = 1 ";




            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);

            cmd.Parameters.AddWithValue("@Kullanıcı_Adı", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
            conn.Open();



            List<Listeler> tablo_Doldur_Classes = new List<Listeler>();
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
                    var Tablo_Doldur_Class_ = new Listeler
                    {
                        Liste_Id = reader.GetValue(0).ToString(),
                        Liste_Ad = reader.GetValue(1).ToString(),
                    };
                    tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
                }
            }
            conn.Close();
            return JsonConvert.SerializeObject(tablo_Doldur_Classes);


        }
        public class Eczane_Bilgi_Tablo
        {
            public string Eczane_Id { get; set; }
            public string Eczane_Adı { get; set; }
            public string Eczane_Brick { get; set; }
            public string Eczane_İl { get; set; }
            public string Eczane_Adres { get; set; }
            public string Eczane_Telefon { get; set; }
            public string Eczane_Tip { get; set; }
            public string Gln_No { get; set; }
            public string Eposta { get; set; }
            public string Eczane_Il_Id { get; set; }
            public string Eczane_Brick_Id { get; set; }

        }

        [System.Web.Services.WebMethod]
        public static string Eczane_Bilgisi_Getir(string Eczane_Id)
        {



            var queryWithForJson = "select Eczane_Id,Eczane_Adı,TownName,CityName,Eczane_Adres,Eczane_Telefon,Eczane_Tip.Eczane_Tip,GLN_No,Eposta,Eczane_Il,Eczane_Brick from Eczane " +
            "" +
            "inner join Town " +
            "on Eczane_Brick=TownID " +
            "" +
            "inner join City " +
            "on Eczane_Il=City.CityID " +
            "" +
            "full join Eczane_Tip " +
            "on Eczane.Eczane_Tip=Eczane_Tip.Eczane_Tip_Id " +
            "" +
            "where Eczane_Id = @Eczane_Id";

            


            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);

            cmd.Parameters.AddWithValue("@Eczane_Id", Eczane_Id);
            conn.Open();



            List<Eczane_Bilgi_Tablo> tablo_Doldur_Classes = new List<Eczane_Bilgi_Tablo>();
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
                    var Tablo_Doldur_Class_ = new Eczane_Bilgi_Tablo
                    {
                        Eczane_Id = reader.GetValue(0).ToString(),
                        Eczane_Adı = reader.GetValue(1).ToString(),
                        Eczane_Brick = reader.GetValue(2).ToString(),
                        Eczane_İl = reader.GetValue(3).ToString(),
                        Eczane_Adres = reader.GetValue(4).ToString(),
                        Eczane_Telefon = reader.GetValue(5).ToString(),
                        Eczane_Tip = reader.GetValue(6).ToString(),
                        Gln_No = reader.GetValue(7).ToString(),
                        Eposta = reader.GetValue(8).ToString(),
                        Eczane_Il_Id = reader.GetValue(9).ToString(),
                        Eczane_Brick_Id = reader.GetValue(10).ToString(),

                    };
                    tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
                }
            }
            conn.Close();
            return JsonConvert.SerializeObject(tablo_Doldur_Classes);


        }

        [System.Web.Services.WebMethod]
        public static string Eczane_Düzenle_Gonder(string Eczane_Id, string Yerine_Ad, string Yerine_Brick, string Yerine_İl, string Yerine_Adres,

            string Yerine_Telefon, string Yerine_Tip, string Yerine_Gln, string Yerine_Eposta)
        {



            var queryWithForJson = "update Eczane set Eczane_Tip=@Yerine_Tip where Eczane_Id=@Eczane_Id ";






           var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);

            cmd.Parameters.AddWithValue("@Eczane_Id", Eczane_Id);
            cmd.Parameters.AddWithValue("@Yerine_Ad", Yerine_Ad);
            cmd.Parameters.AddWithValue("@Yerine_Brick", Yerine_Brick);
            cmd.Parameters.AddWithValue("@Yerine_İl", Yerine_İl);
            cmd.Parameters.AddWithValue("@Yerine_Adres", Yerine_Adres);
            cmd.Parameters.AddWithValue("@Yerine_Telefon", Yerine_Telefon);
            cmd.Parameters.AddWithValue("@Yerine_Tip", Yerine_Tip);
            cmd.Parameters.AddWithValue("@Yerine_Gln", Yerine_Gln);
            cmd.Parameters.AddWithValue("@Yerine_Eposta", Yerine_Eposta);


            conn.Open();



            List<Onay_Durum> tablo_Doldur_Classes = new List<Onay_Durum>();
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
                    var Tablo_Doldur_Class_ = new Onay_Durum
                    {
                        Sonuç = reader.GetValue(0).ToString(),

                    };
                    tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
                }
            }
            conn.Close();
            return JsonConvert.SerializeObject(tablo_Doldur_Classes);


        }
        public class Onay_Durum
        {
            public string Sonuç { get; set; }

        }
        [System.Web.Services.WebMethod]
        public static string Eczane_Düzenle_Talep_Gonder(string Eczane_Id, string Yerine_Ad, string Yerine_Brick, string Yerine_İl, string Yerine_Adres, 

            string Yerine_Telefon, string Yerine_Tip, string Yerine_Gln, string Yerine_Eposta)
        {

        



            var queryWithForJson = "if not EXISTS(select Düzenlenecek_Eczane_Id from Eczane_Düzenle_Talep where Düzenlenecek_Eczane_Id=@Eczane_Id )begin insert into " +
        
            "Eczane_Düzenle_Talep(Düzenlenecek_Eczane_Id,Yerine_Ad,Yerine_Brick,Yerine_İl,Yerine_Adres,Yerine_Telefon,Yerine_Tip,Yerine_Gln,Yerine_Eposta,Onay_Durum) " +
          
            "values(@Eczane_Id,@Yerine_Ad,@Yerine_Brick,@Yerine_İl,@Yerine_Adres,@Yerine_Telefon,@Yerine_Tip,@Yerine_Gln,@Yerine_Eposta,0) end; " +
            "else " +
            "begin " +
            "select 1 " +
            "end;";






            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);

            cmd.Parameters.AddWithValue("@Eczane_Id", Eczane_Id);
            cmd.Parameters.AddWithValue("@Yerine_Ad", Yerine_Ad);
            cmd.Parameters.AddWithValue("@Yerine_Brick", Yerine_Brick);
            cmd.Parameters.AddWithValue("@Yerine_İl", Yerine_İl);
            cmd.Parameters.AddWithValue("@Yerine_Adres", Yerine_Adres);
            cmd.Parameters.AddWithValue("@Yerine_Telefon", Yerine_Telefon);
            cmd.Parameters.AddWithValue("@Yerine_Tip", Yerine_Tip);
            cmd.Parameters.AddWithValue("@Yerine_Gln", Yerine_Gln);
            cmd.Parameters.AddWithValue("@Yerine_Eposta", Yerine_Eposta);


            conn.Open();



            List<Onay_Durum> tablo_Doldur_Classes = new List<Onay_Durum>();
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
                    var Tablo_Doldur_Class_ = new Onay_Durum
                    {
                        Sonuç = reader.GetValue(0).ToString(),

                    };
                    tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
                }
            }
            conn.Close();
            return JsonConvert.SerializeObject(tablo_Doldur_Classes);


        }


    }
}