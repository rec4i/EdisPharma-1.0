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

    public partial class ddldeneme : System.Web.UI.Page
    {

        public string Reques = null;
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
            Reques = Request.QueryString["x"];
            if (Reques != null)
            {
                string gelen_yıl = Reques.Split('-')[0];
                string gelen_ay = Reques.Split('-')[1];

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
                        "use kasa declare @gün  int=1; " +
                        "declare @Ayın_Ilk_Gunu_parse date=cast(@Ayın_Ilk_Gunu as date); " +
                        "declare @Ayın_Son_Gunu_parse date=cast(@Ayın_Son_Gunu as date); " +
                        "declare @toplam nvarchar(max)=CAST(@gün as varchar)+'-'+CAST(@ay as varchar)+'-'+CAST(@yıl as varchar); " +
                        "declare @birleşim date= CAST(@toplam as date); " +
                        "declare @İd table (Id int); " +
                        "if exists(select * from Ziyaret_Onay where Kullanıcı_Id= (select KullanıcıID from Kullanıcı where KullanıcıAD COLLATE Latin1_general_CS_AS =@kullanıcı) and Bas_Tar=@Ayın_Ilk_Gunu and Bit_Tar=@Ayın_Son_Gunu) " +
                        "begin " +
                        "select * from Ziyaret_Genel where Kullanıcı_ID=(select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS =@kullanıcı) and Ziy_Tar between @Ayın_Ilk_Gunu_parse and @Ayın_Son_Gunu_parse; " +
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
                        "select * from Ziyaret_Genel where Kullanıcı_ID=(select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS =@kullanıcı) and Ziy_Tar between @Ayın_Ilk_Gunu_parse and @Ayın_Son_Gunu_parse; " +
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



                SqlDataAdapter sda11 = new SqlDataAdapter(cmd11);
                DataTable dt11 = new DataTable();
                sda11.Fill(dt11);
                Repeater1.DataSource = dt11;
                Repeater1.DataBind();
                SqlC.con.Close();

            }
            else
            {

                if (!this.IsPostBack)
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
                        "use kasa declare @gün  int=1; " +
                        "declare @Ayın_Ilk_Gunu_parse date=cast(@Ayın_Ilk_Gunu as date); " +
                        "declare @Ayın_Son_Gunu_parse date=cast(@Ayın_Son_Gunu as date); " +
                        "declare @toplam nvarchar(max)=CAST(@gün as varchar)+'-'+CAST(@ay as varchar)+'-'+CAST(@yıl as varchar); " +
                        "declare @birleşim date= CAST(@toplam as date); " +
                        "declare @İd table (Id int); " +
                        "if exists(select * from Ziyaret_Onay where Kullanıcı_Id= (select KullanıcıID from Kullanıcı where KullanıcıAD COLLATE Latin1_general_CS_AS =@kullanıcı) and Bas_Tar=@Ayın_Ilk_Gunu and Bit_Tar=@Ayın_Son_Gunu) " +
                        "begin " +
                        "select * from Ziyaret_Genel where Kullanıcı_ID=(select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS =@kullanıcı) and Ziy_Tar between @Ayın_Ilk_Gunu_parse and @Ayın_Son_Gunu_parse; " +
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
                        "select * from Ziyaret_Genel where Kullanıcı_ID=(select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS =@kullanıcı) and Ziy_Tar between @Ayın_Ilk_Gunu_parse and @Ayın_Son_Gunu_parse; " +
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
                    SqlDataAdapter sda11 = new SqlDataAdapter(cmd11);
                    DataTable dt11 = new DataTable();
                    sda11.Fill(dt11);
                    Repeater1.DataSource = dt11;
                    Repeater1.DataBind();
                    SqlC.con.Close();

                }
            }





        }

        public class Şehir_Getir_Tablo
        {
            public string Şehir_Id { get; set; }
            public string Şehir_Name { get; set; }

        }

        [System.Web.Services.WebMethod]
        public static string Şehir_Getir()
        {



            var queryWithForJson = "use kasa select CityID,CityName from City ";


            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);


            conn.Open();



            List<Şehir_Getir_Tablo> tablo_Doldur_Classes = new List<Şehir_Getir_Tablo>();
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
                    var Tablo_Doldur_Class_ = new Şehir_Getir_Tablo
                    {
                        Şehir_Id = reader.GetValue(0).ToString(),
                        Şehir_Name = reader.GetValue(1).ToString(),
                    };
                    tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
                }
            }
            conn.Close();
            return JsonConvert.SerializeObject(tablo_Doldur_Classes);


        }
        public class Brick_Getir_Tablo
        {
            public string Brick_Id { get; set; }
            public string Brick_Name { get; set; }

        }

        [System.Web.Services.WebMethod]
        public static string Brick_Getir(string Şehir_Id)
        {



            var queryWithForJson = "use kasa select TownID,TownName from Town where CityID=@1";


            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);
            cmd.Parameters.AddWithValue("@1", Şehir_Id);


            conn.Open();



            List<Brick_Getir_Tablo> tablo_Doldur_Classes = new List<Brick_Getir_Tablo>();
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
                    var Tablo_Doldur_Class_ = new Brick_Getir_Tablo
                    {
                        Brick_Id = reader.GetValue(0).ToString(),
                        Brick_Name = reader.GetValue(1).ToString(),
                    };
                    tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
                }
            }
            conn.Close();
            return JsonConvert.SerializeObject(tablo_Doldur_Classes);


        }

        public class Unite_Getir_Tablo
        {
            public string Unite_Id { get; set; }
            public string Unite_Name { get; set; }

        }

        [System.Web.Services.WebMethod]
        public static string Unite_Getir(string Brick_Id)
        {



            var queryWithForJson = "use kasa select Unite_ID,Unite_Txt from Unite where Brick__Id=@1";


            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);
            cmd.Parameters.AddWithValue("@1", Brick_Id);


            conn.Open();



            List<Unite_Getir_Tablo> tablo_Doldur_Classes = new List<Unite_Getir_Tablo>();
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
                    var Tablo_Doldur_Class_ = new Unite_Getir_Tablo
                    {
                        Unite_Id = reader.GetValue(0).ToString(),
                        Unite_Name = reader.GetValue(1).ToString(),
                    };
                    tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
                }
            }
            conn.Close();
            return JsonConvert.SerializeObject(tablo_Doldur_Classes);


        }

        public class Branş_Getir_Tablo
        {
            public string Branş_Id { get; set; }
            public string Branş_Name { get; set; }

        }

        [System.Web.Services.WebMethod]
        public static string Branş_Getir(string Unite_Id)
        {



            var queryWithForJson = "use kasa select Brans_ID,Brans_Txt from Unite_Branş_Liste   " +
                              "inner join Branchs  " +
                              " on Branchs.Brans_ID=Unite_Branş_Liste.Branş_Id " +
                              "" +
                              "where Unite_Id = @1";


            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);
            cmd.Parameters.AddWithValue("@1", Unite_Id);


            conn.Open();



            List<Branş_Getir_Tablo> tablo_Doldur_Classes = new List<Branş_Getir_Tablo>();
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
                    var Tablo_Doldur_Class_ = new Branş_Getir_Tablo
                    {
                        Branş_Id = reader.GetValue(0).ToString(),
                        Branş_Name = reader.GetValue(1).ToString(),
                    };
                    tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
                }
            }
            conn.Close();
            return JsonConvert.SerializeObject(tablo_Doldur_Classes);


        }

        public class Eczane_Getir_Tablo
        {
            public string Eczane_Id { get; set; }
            public string Eczane_Name { get; set; }
            public string Eczane_Frekans { get; set; }

        }

        [System.Web.Services.WebMethod]
        public static string Eczane_Getir(string Brick_Id, string Liste_Id)
        {



            var queryWithForJson = "" +
                               "select Eczane.Eczane_Id,Eczane_Adı,Frekans from Eczane_Liste " +
                               " inner join Eczane " +
                               "  on Eczane_liste.Eczane_Id=Eczane.Eczane_Id  " +
                               "  inner join Listeler " +
                               " on Eczane_Liste.Liste_Id=Listeler.Liste_Id " +
                               "  where Listeler.Liste_Id=@Liste_Id and Eczane.Eczane_Brick= @Brick and Kullanıcı_Id=(select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS              =@Kullanıcı_Adı) and Eczane_Liste.Silinmismi=0 order by Eczane_Adı asc" +
                               "";


            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);

            cmd.Parameters.AddWithValue("@Brick", Brick_Id);
            cmd.Parameters.AddWithValue("@Liste_Id", Liste_Id);
            cmd.Parameters.AddWithValue("@Kullanıcı_Adı", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());

            conn.Open();



            List<Eczane_Getir_Tablo> tablo_Doldur_Classes = new List<Eczane_Getir_Tablo>();
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
                    var Tablo_Doldur_Class_ = new Eczane_Getir_Tablo
                    {
                        Eczane_Id = reader.GetValue(0).ToString(),
                        Eczane_Name = reader.GetValue(1).ToString(),
                        Eczane_Frekans = reader.GetValue(2).ToString(),
                    };
                    tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
                }
            }
            conn.Close();
            return JsonConvert.SerializeObject(tablo_Doldur_Classes);


        }

        public class Doktor_Getir_Tablo
        {
            public string Doktor_Id { get; set; }
            public string Doktor_Name { get; set; }
            public string Doktor_Frekans { get; set; }

        }

        [System.Web.Services.WebMethod]
        public static string Doktor_Getir(string Branş_Id, string Liste_Id, string Unite_Id)
        {

            var queryWithForJson = "use kasa SELECT  Doktors.Doktor_Id, Doktor_Ad  ,Doktor_Liste.Frekans  FROM Doktor_Liste  " +
                  "INNER JOIN Listeler ON Doktor_Liste.Liste_Id=Listeler.Liste_Id INNER JOIN Doktors ON Doktor_Liste.Doktor_ıd=Doktors.Doktor_Id " +
                  "INNER JOIN Unite ON Doktors.Doktor_Unite_ID=Unite_ID INNER JOIN Town ON TownID=Unite.Brick__Id " +
                  "INNER JOIN City ON City.CityID=Town.CityID " +
                  "Where Listeler.Liste_Id= @Liste_Id and Listeler.cins = 0 and Doktor_Liste.Silinmismi=0 and  Doktor_Brans_Id=@Branş_Id and Doktor_Unite_ID=@Unite_Id order by  Doktor_Ad asc";



            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);

            cmd.Parameters.AddWithValue("@Branş_Id", Branş_Id);
            cmd.Parameters.AddWithValue("@Liste_Id", Liste_Id);
            cmd.Parameters.AddWithValue("@Unite_Id", Unite_Id);
            cmd.Parameters.AddWithValue("@Kullanıcı_Adı", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());

            conn.Open();



            List<Doktor_Getir_Tablo> tablo_Doldur_Classes = new List<Doktor_Getir_Tablo>();
            var jsonResult = new StringBuilder();
            var reader = cmd.ExecuteReader();
            if (!reader.HasRows)
            {
                var Tablo_Doldur_Class_ = new Doktor_Getir_Tablo
                {
                    Doktor_Id = "hata",
                    Doktor_Name = "Listede Doktor Bulunamadı",
                    Doktor_Frekans = "hata"
                };
                tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
            }
            else
            {
                while (reader.Read())
                {
                    var Tablo_Doldur_Class_ = new Doktor_Getir_Tablo
                    {
                        Doktor_Id = reader.GetValue(0).ToString(),
                        Doktor_Name = reader.GetValue(1).ToString(),
                        Doktor_Frekans = reader.GetValue(2).ToString(),
                    };
                    tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
                }
            }
            conn.Close();
            return JsonConvert.SerializeObject(tablo_Doldur_Classes);


        }

       
        [System.Web.Services.WebMethod]
        public static string Doktor_Getir_Listesiz(string Branş_Id, string Unite_Id)
        {

            var queryWithForJson = "use kasa  " +
                 
                  "select Doktor_Id,Doktor_Ad,0 from Doktors where  Doktor_Brans_Id=@Branş_Id and Doktor_Unite_ID=@Unite_Id " +
                  "" +
                  "";



            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);

            cmd.Parameters.AddWithValue("@Branş_Id", Branş_Id);
            cmd.Parameters.AddWithValue("@Unite_Id", Unite_Id);
            cmd.Parameters.AddWithValue("@Kullanıcı_Adı", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());

            conn.Open();



            List<Doktor_Getir_Tablo> tablo_Doldur_Classes = new List<Doktor_Getir_Tablo>();
            var jsonResult = new StringBuilder();
            var reader = cmd.ExecuteReader();
            if (!reader.HasRows)
            {
                var Tablo_Doldur_Class_ = new Doktor_Getir_Tablo
                {
                    Doktor_Id = "hata",
                    Doktor_Name = "Listede Doktor Bulunamadı",
                    Doktor_Frekans = "hata"
                };
                tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
            }
            else
            {
                while (reader.Read())
                {
                    var Tablo_Doldur_Class_ = new Doktor_Getir_Tablo
                    {
                        Doktor_Id = reader.GetValue(0).ToString(),
                        Doktor_Name = reader.GetValue(1).ToString(),
                        Doktor_Frekans = reader.GetValue(2).ToString(),
                    };
                    tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
                }
            }
            conn.Close();
            return JsonConvert.SerializeObject(tablo_Doldur_Classes);


        }


        [System.Web.Services.WebMethod]
        public static string Onay_Talep_Id(string parametre)
        {
            var queryWithForJson = "use kasa  select Ziyaret_Onay_Id from Ziyaret_Onay where Bas_Tar=@1 and Kullanıcı_Id=(select KullanıcıID from Kullanıcı where KullanıcıAD COLLATE Latin1_general_CS_AS =@Kullanıcı_Ad) ";
            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);

            cmd.Parameters.AddWithValue("@1", parametre);
            cmd.Parameters.AddWithValue("@Kullanıcı_Ad", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());

            conn.Open();

            var reader = cmd.ExecuteReader();

            string a = "";
            while (reader.Read())
            {
                a += reader.GetValue(0).ToString();
            }
            if (a == "")
            {
                conn.Close();
                return "0";
            }
            else
            {
                conn.Close();
                return a;
            }


        }


        public class Off_Günler_Tablo
        {
            public string Tarih { get; set; }

        }

        [System.Web.Services.WebMethod]
        public static string OFF_Gunler(string Ay, string Yıl)
        {



            DateTime yıl_ = DateTime.Now;



            string Bit_Tar = new DateTime(Convert.ToInt32(Yıl), Convert.ToInt32(Ay), DateTime.DaysInMonth(new DateTime(Convert.ToInt32(Yıl), Convert.ToInt32(Ay), 1).Year, new DateTime(Convert.ToInt32(Yıl), Convert.ToInt32(Ay), 1).Month)).ToString("yyyy-MM-dd");
            string Bas_Tar = new DateTime(Convert.ToInt32(Yıl), Convert.ToInt32(Ay), 1).ToString("yyyy-MM-dd");






            var queryWithForJson = " " +

 "declare @Günler_Ve_Farkları table(ID INT PRIMARY KEY  NOT NULL identity(1,1),Bas_Tar date,Bit_Tar date, Fark int) " +
"declare @While_İlk int=0; " +
"declare @While_İki int=0; " +
"declare @Gün int=0; " +
"" +
"declare @Off_Günler Table(Tarih Date); " +
"" +
"insert into @Günler_Ve_Farkları  " +
"" +
"select İzin_Bas_Tar,İzin_Bit_Tar,(datediff(day,İzin_Bas_Tar,İzin_Bit_Tar)+1) from Yıllık_İzin where  Kullanıcı_Id=(select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS   = @Kullanıcı_Id) and İzin_Bas_Tar between @Bas_Tar and @Bit_Tar  and İzin_Bit_Tar between @Bas_Tar and @Bit_Tar " +
"" +
"" +
"" +
"" +
"set @While_İlk=(select COUNT(*) from @Günler_Ve_Farkları)  " +
"" +
"while @While_İlk>0 " +
"begin  " +
"set @While_İki=(select Fark from @Günler_Ve_Farkları where ID=@While_İlk) " +
"set @Gün=@While_İki " +
"" +
"" +
"while @While_İki>0 " +
"begin " +
"" +

"" +
"if (select Fark from @Günler_Ve_Farkları where ID=@While_İlk)=1 " +
"begin " +
"insert into @Off_Günler(Tarih)  select Bit_Tar from @Günler_Ve_Farkları where ID=@While_İlk " +
"set @Gün=@Gün-1; " +
"set @While_İki=@While_İki-1; " +
"end " +
"else " +
"begin " +
"insert into @Off_Günler(Tarih) values(dateadd(day,-@Gün+1,(select Bit_Tar from @Günler_Ve_Farkları where ID=@While_İlk))) " +
"set @Gün=@Gün-1; " +
"set @While_İki=@While_İki-1; " +
"end " +
"" +
"end " +
"set @While_İlk=@While_İlk-1; " +

"end " +
"" +
"insert into @Off_Günler select  cast(year(getdate()) as nvarchar)+'-'+Özel_Gün_Ay_Gün from Özel_Günler where cast(year(getdate()) as nvarchar)+'-'+Özel_Gün_Ay_Gün between @Bas_Tar and @Bit_Tar " +
"" +
"" +
"select  DISTINCT Tarih from @Off_Günler where Tarih between @Bas_Tar and @Bit_Tar ";







            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);
            cmd.Parameters.AddWithValue("@Kullanıcı_Id", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
            cmd.Parameters.AddWithValue("@Bas_Tar", Bas_Tar);
            cmd.Parameters.AddWithValue("@Bit_Tar", Bit_Tar);



            conn.Open();
            List<Off_Günler_Tablo> tablo_Doldur_Classes = new List<Off_Günler_Tablo>();
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
                    var Tablo_Doldur_Class_ = new Off_Günler_Tablo
                    {
                        Tarih = reader.GetDateTime(0).ToString("yyyy-MM-dd"),
                    };
                    tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
                }
            }
            conn.Close();
            return JsonConvert.SerializeObject(tablo_Doldur_Classes);
        }



        public class Onay_Talebi_Hata_Tablo
        {
            public string Durum { get; set; }
            public string Tarih { get; set; }

        }

        [System.Web.Services.WebMethod]
        public static string Onay_Talebi_Gönder(string parametre)
        {



            var queryWithForJson = "use kasa  if((select Talep_Oluşturuldumu from Ziyaret_Onay where Ziyaret_Onay_Id=@1)=0) " +
                "begin; " +
                "" +
                "update Ziyaret_Onay set Talep_Oluşturuldumu = 1 where Ziyaret_Onay_Id=@1 " +
                "select 1,'1980-10-10'; " +
                "end; " +

                //"if (( select count(*) " +
                //" from Ziyaret_Genel  where  " +
                //" Ziyaret_Onay_Id=@1 and " +
                //" (case when ((select COUNT(*) from Ziyaret_Detay where Ziy_Gnl_Id=ID and Cins=1) <10 ) then 'true' else 'false' end)!= 'false'  " +
                //" and " +
                //" (case when ((select COUNT(*) from Ziyaret_Detay where Ziy_Gnl_Id=ID and Cins=0) <20 ) then 'true' else 'false' end)!='false'  " +
                //")>0)  " +
                //"begin  " +
                //"select Ziy_Tar,'4' " +
                //" from Ziyaret_Genel  where  " +
                //" Ziyaret_Onay_Id=@1 and " +
                //"(case when ((select COUNT(*) from Ziyaret_Detay where Ziy_Gnl_Id=ID and Cins=1) <10 ) then 'true' else 'false' end)!= 'false'  " +
                //"and " +
                //" (case when ((select COUNT(*) from Ziyaret_Detay where Ziy_Gnl_Id=ID and Cins=0) <20 ) then 'true' else 'false' end)!='false' " +
                //"end " +
                //"   else  " +
                //"begin " +
                //"update Ziyaret_Onay set Talep_Oluşturuldumu = 1 where Ziyaret_Onay_Id=@1 " +
                //"select 1,'1000-10-10'; " +
                //"end " +

                //"end; " +
                //"else " +
                //"begin; " +
                //"select 0,'1000-10-10'; " +
                //"end; " +
                "";




            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);
            cmd.Parameters.AddWithValue("@1", parametre);

            conn.Open();



            List<Onay_Talebi_Hata_Tablo> tablo_Doldur_Classes = new List<Onay_Talebi_Hata_Tablo>();
            var jsonResult = new StringBuilder();
            var reader = cmd.ExecuteReader();
            if (!reader.HasRows)
            {
                var Tablo_Doldur_Class_ = new Onay_Talebi_Hata_Tablo
                {
                    Durum = "2",
                    Tarih = "2021-02-01"
                };
                tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
            }
            else
            {
                while (reader.Read())
                {
                    var Tablo_Doldur_Class_ = new Onay_Talebi_Hata_Tablo
                    {
                        Durum = reader.GetValue(0).ToString(),
                        Tarih = reader.GetDateTime(1).ToString("dd / dddd / MMMM  yyyy"),


                    };
                    tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
                }
            }
            conn.Close();
            return JsonConvert.SerializeObject(tablo_Doldur_Classes);


        }


        [System.Web.Services.WebMethod]
        public static string Kaldır__(string parametre)
        {
            var queryWithForJson = "" +
                "if(( " +
                "select Onay_Durum from Ziyaret_Detay " +
                "inner join Ziyaret_Genel " +
                "on Ziyaret_Genel.ID=Ziyaret_Detay.Ziy_Gnl_Id " +
                "inner join Ziyaret_Onay " +
                "on Ziyaret_Genel.Ziyaret_Onay_Id=Ziyaret_Onay.Ziyaret_Onay_Id " +
                "where Ziyaret_Detay.Ziy_Dty_ID=@1 " +
                ")=0) " +
                "begin " +
                "delete from Ziyaret_Detay where Ziy_Dty_ID=@1 " +
                "end; " +
                "else  " +
                "begin " +
                "select 5; " +
                "end " +
                "";
            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);
            cmd.Parameters.AddWithValue("@1", parametre);
            conn.Open();

            var reader = cmd.ExecuteReader();
            string a = "";
            while (reader.Read())
            {
                a += reader.GetValue(0).ToString();
            }
            if (a == "")
            {
                conn.Close();
                return "0";
            }
            else
            {
                if (a == "5")
                {
                    conn.Close();
                    return "5";
                }
                else
                {
                    conn.Close();
                    return "1";
                }
            }

        }
        [System.Web.Services.WebMethod]//2021-02-1/40
        public static string Eczane_Frekans_Ara(string parametre)
        {
            string tarih = parametre.Split('/')[2];
            string liste = parametre.Split('/')[1];
            string kelime = parametre.Split('/')[0];


            var queryWithForJson = "select top 10 Eczane_Adı,CityName,TownName ,(select COUNT(*) from Ziyaret_Detay inner join Ziyaret_Genel on Ziy_Gnl_Id=Ziyaret_Genel.Id where Eczane_Id=Eczane.Eczane_Id and MONTH(Ziyaret_Genel.Ziy_Tar)=MONTH(@2))as Düzenlenen , Frekans from Eczane_Liste inner join Eczane on Eczane.Eczane_Id=Eczane_Liste.Eczane_Id inner join Town on TownID=Eczane.Eczane_Brick inner join City on Town.CityID=City.CityID where Eczane_Adı like ''+@1+'%' and Liste_Id=" + liste + " order by Düzenlenen asc";
            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);
            cmd.Parameters.AddWithValue("@2", tarih);
            cmd.Parameters.AddWithValue("@1", kelime);
            conn.Open();

            var reader = cmd.ExecuteReader();

            string a = "";



            while (reader.Read())
            {
                a += reader.GetValue(0).ToString() + "-" + reader.GetValue(1).ToString() + "-" + reader.GetValue(2).ToString() + "-" + reader.GetValue(3).ToString() + "-" + reader.GetValue(4).ToString() + "!";
            }
            if (a == "")
            {
                conn.Close();
                return " - - - - ";
            }
            else
            {
                a = a.Substring(0, a.Length - 1);
                conn.Close();
                return a;
            }




        }
        [System.Web.Services.WebMethod]//2021-02-1/40
        public static string Doktor_Frekans_Ara(string parametre)
        {
            string tarih = parametre.Split('/')[2];
            string liste = parametre.Split('/')[1];
            string kelime = parametre.Split('/')[0];


            var queryWithForJson = "select top 10 Doktor_Ad ,Unite_Txt,Doktor_Brans,(select COUNT(*) from Ziyaret_Detay inner join Ziyaret_Genel on Ziy_Gnl_Id=Ziyaret_Genel.Id  where Doktor_ıd=Doktors.Doktor_Id and MONTH(Ziyaret_Genel.Ziy_Tar)=MONTH(@2) )as Düzenlenen , Frekans from Doktor_Liste inner join Doktors on Doktors.Doktor_Id=Doktor_Liste.Doktor_ıd inner join Unite on Unite.Unite_ID=Doktors.Doktor_Unite_ID where Doktor_Ad like ''+@1+'%' and Liste_Id=" + liste + " order by Düzenlenen asc";
            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);
            cmd.Parameters.AddWithValue("@1", kelime);
            cmd.Parameters.AddWithValue("@2", tarih);
            conn.Open();

            var reader = cmd.ExecuteReader();

            string a = "";



            while (reader.Read())
            {
                a += reader.GetValue(0).ToString() + "-" + reader.GetValue(1).ToString() + "-" + reader.GetValue(2).ToString() + "-" + reader.GetValue(3).ToString() + "-" + reader.GetValue(4).ToString() + "!";
            }
            if (a == "")
            {
                conn.Close();
                return " - - - - ";
            }
            else
            {
                a = a.Substring(0, a.Length - 1);
                conn.Close();
                return a;
            }




        }
        [System.Web.Services.WebMethod]//2021-02-1/40
        public static string Eczane_Db_Yaz_4_hafta(string parametre)
        {//
            //
            string a = "";
            if (parametre.Split('/').Length == 3)
            {
                string Tar_1 = parametre.Split('/')[0];



                string Doktor_ID = parametre.Split('/')[parametre.Split('/').Length - 2];


                var queryWithForJson = "" +
                    " declare @kont_1 int = 0  " +
                    "declare @kont_5 int = 0  " +
                    "if(( " +
                    "select Onay_Durum from Ziyaret_Genel " +
                    "inner join Ziyaret_Onay " +
                    "on Ziyaret_Genel.Ziyaret_Onay_Id=Ziyaret_Onay.Ziyaret_Onay_Id " +
                    "where Ziy_Tar=@ziyretar_6 and Ziyaret_Genel.Kullanıcı_ID= (select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS = @kullanıcı_Kontrol_2) " +
                    ")=0) " +
                    "begin " +
                    "if  not exists (select * from Ziyaret_Detay inner join Ziyaret_Genel on Ziyaret_Detay.Ziy_Gnl_Id=Ziyaret_Genel.ID  where Ziyaret_Genel.Kullanıcı_ID=(select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS   = @kullanıcı_gelen_1) and Eczane_Id=@doktorıd_gelen_1 and Ziy_Tar=@Ziyaret_Tar_ılk) " +
                    " begin  " +
                    " set @kont_1=1;  " +
                    "print @kont_1  " +
                    " end " +
                    "if ((select COUNT(*) from Ziyaret_Detay  inner join Ziyaret_Genel on Ziyaret_Detay.Ziy_Gnl_Id=Ziyaret_Genel.ID where MONTH(Ziy_Tar) = MONTH(@gelenziyaret_1) and YEAR(Ziy_Tar)=YEAR(@gelenziyaret_2) and Ziyaret_Genel.Kullanıcı_ID= (select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS = @kullanıcı_Kontrol_2) and Eczane_Id=@Doktor_ID_kontrol_1)<((select Frekans from Eczane inner join Eczane_Liste on Eczane_Liste.Eczane_Id=Eczane.Eczane_Id inner join Listeler on Eczane_Liste.Liste_Id=Listeler.Liste_Id where Eczane_Liste.Silinmismi=0 and Listeler.Liste_Id= @Liste_ıd and Listeler.Kullanıcı_Id = (select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS    =@kullanıcı_Kontrol) and Eczane.Eczane_Id=@Doktor_ID_kontrol)))  " +
                    " begin " +
                    " set @kont_5=1; " +
                    " print @kont_5  " +
                    " end  " +
                    " if (@kont_1=1) and (@kont_5=1) " +
                    "begin  " +
                    "insert  into Ziyaret_Detay(Cins , Eczane_Id, Ziyaret_Durumu, Kullanıcı_Id, Ziy_Gnl_Id) values(1, @doktorıd_2, 0, (select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS   = @kullanıcı_2),(select ID from Ziyaret_Genel where Ziyaret_Genel.Kullanıcı_ID = (select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS   = @kullanıcı_7) and Ziy_Tar = @ziyretar_2)); " +
                    "update Ziyaret_Genel set Ziy_Edilecek_Eczane = Ziy_Edilecek_Eczane + 1 where Ziyaret_Genel.ID = (select ID from Ziyaret_Genel where Ziyaret_Genel.Kullanıcı_ID = (select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS       = @kullanıcı_11) and Ziy_Tar = @ziyretar_6);  " +
                    "select 2; " +
                    "end; " +
                    " end; " +
                    "else " +
                    "begin " +
                    "select 5; " +
                    "end; " +
                    "";


                var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
                var cmd = new SqlCommand(queryWithForJson, conn);



                cmd.Parameters.AddWithValue("@kullanıcı_gelen_1", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd.Parameters.AddWithValue("@doktorıd_gelen_1", Doktor_ID);//@kullanıcı
                cmd.Parameters.AddWithValue("@Ziyaret_Tar_ılk", Tar_1);
                cmd.Parameters.AddWithValue("@kullanıcı_gelen_2", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd.Parameters.AddWithValue("@doktorıd_gelen_2", Doktor_ID);



                cmd.Parameters.AddWithValue("@kullanıcı_Kontrol", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd.Parameters.AddWithValue("@Doktor_ID_kontrol", Doktor_ID);
                cmd.Parameters.AddWithValue("@gelenziyaret_1", Tar_1);
                cmd.Parameters.AddWithValue("@gelenziyaret_2", Tar_1);
                cmd.Parameters.AddWithValue("@kullanıcı_Kontrol_2", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd.Parameters.AddWithValue("@Doktor_ID_kontrol_1", Doktor_ID);
                cmd.Parameters.AddWithValue("@doktorıd_2", Doktor_ID);
                cmd.Parameters.AddWithValue("@kullanıcı_2", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd.Parameters.AddWithValue("@kullanıcı_7", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd.Parameters.AddWithValue("@ziyretar_2", Tar_1);
                cmd.Parameters.AddWithValue("@kullanıcı_11", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd.Parameters.AddWithValue("@ziyretar_6", Tar_1);
                cmd.Parameters.AddWithValue("@doktorıd_3", Doktor_ID);
                cmd.Parameters.AddWithValue("@kullanıcı_3", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd.Parameters.AddWithValue("@kullanıcı_8", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd.Parameters.AddWithValue("@Liste_ıd", parametre.Split('/')[parametre.Split('/').Length - 1]);









                conn.Open();

                var reader = cmd.ExecuteReader();


                while (reader.Read())
                {
                    a += reader.GetValue(0).ToString();
                }


                if (a == "")
                {
                    conn.Close();
                    return "0";
                }
                else
                {
                    if (a == "5")
                    {
                        conn.Close();
                        return "5";
                    }
                    else
                    {
                        conn.Close();
                        return "1";
                    }

                }
            }

            if (parametre.Split('/').Length == 5)
            {
                string Tar_1 = parametre.Split('/')[0];
                string Tar_2 = parametre.Split('/')[1];
                string Tar_3 = parametre.Split('/')[2];

                string Doktor_ID = parametre.Split('/')[parametre.Split('/').Length - 2];


                var queryWithForJson = " " +
                    "declare @kont_1 int = 0declare @kont_2 int = 0  declare @kont_3 int = 0 declare @kont_5 int = 0   " +
                    "if(( " +
                    "select Onay_Durum from Ziyaret_Genel " +
                    "inner join Ziyaret_Onay " +
                    "on Ziyaret_Genel.Ziyaret_Onay_Id=Ziyaret_Onay.Ziyaret_Onay_Id " +
                    "where Ziy_Tar=@ziyretar_6 and Ziyaret_Genel.Kullanıcı_ID= (select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS = @kullanıcı_Kontrol_2) " +
                    ")=0) " +
                    "begin " +
                    "if  not exists (select * from Ziyaret_Detay inner join Ziyaret_Genel on Ziyaret_Detay.Ziy_Gnl_Id=Ziyaret_Genel.ID  where Ziyaret_Genel.Kullanıcı_ID=(select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS              = @kullanıcı_gelen_1) and Eczane_Id=@doktorıd_gelen_1 and Ziy_Tar=@Ziyaret_Tar_ılk)  begin  set @kont_1=1;  print @kont_1 end  if not exists (select * from Ziyaret_Detay inner join Ziyaret_Genel on Ziyaret_Detay.Ziy_Gnl_Id=Ziyaret_Genel.ID  where Ziyaret_Genel.Kullanıcı_ID=(select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS              = @kullanıcı_gelen_2) and Eczane_Id=@doktorıd_gelen_2 and Ziy_Tar=@Ziyaret_Tar_ıkıncı) begin  set @kont_2=1; print @kont_2 end if ((select COUNT(*) from Ziyaret_Detay  inner join Ziyaret_Genel on Ziyaret_Detay.Ziy_Gnl_Id=Ziyaret_Genel.ID where MONTH(Ziy_Tar) = MONTH(@gelenziyaret_1) and YEAR(Ziy_Tar)=YEAR(@gelenziyaret_2) and Ziyaret_Genel.Kullanıcı_ID= (select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS              = @kullanıcı_Kontrol_2) and Eczane_Id=@Doktor_ID_kontrol_1)<((select Frekans from Eczane inner join Eczane_Liste on Eczane_Liste.Eczane_Id=Eczane.Eczane_Id inner join Listeler on Eczane_Liste.Liste_Id=Listeler.Liste_Id where Eczane_Liste.Silinmismi=0 and Listeler.Liste_Id= @Liste_ıd and Listeler.Kullanıcı_Id = (select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS              =@kullanıcı_Kontrol) and Eczane.Eczane_Id=@Doktor_ID_kontrol)))	begin set @kont_5=1;  print @kont_5  end  if (@kont_1=1)and (@kont_2=1) and (@kont_3=1)  and (@kont_5=1)   begin  insert into Ziyaret_Detay(Cins, Eczane_Id, Ziyaret_Durumu, Kullanıcı_Id, Ziy_Gnl_Id) values(1, @doktorıd_2, 0, (select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS              = @kullanıcı_2),(select ID from Ziyaret_Genel where Ziyaret_Genel.Kullanıcı_ID = (select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS              = @kullanıcı_7) and Ziy_Tar = @ziyretar_2)); update Ziyaret_Genel set Ziy_Edilecek_Eczane = Ziy_Edilecek_Eczane + 1 where Ziyaret_Genel.ID = (select ID from Ziyaret_Genel where Ziyaret_Genel.Kullanıcı_ID = (select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS              = @kullanıcı_11) and Ziy_Tar = @ziyretar_6); select 2;   insert into Ziyaret_Detay(Cins, Eczane_Id, Ziyaret_Durumu, Kullanıcı_Id, Ziy_Gnl_Id) values(1, @doktorıd_3, 0, (select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS              = @kullanıcı_3),(select ID from Ziyaret_Genel where Ziyaret_Genel.Kullanıcı_ID = (select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS              = @kullanıcı_8) and Ziy_Tar = @ziyretar_3)); update Ziyaret_Genel set Ziy_Edilecek_Eczane = Ziy_Edilecek_Eczane + 1 where Ziyaret_Genel.ID = (select ID from Ziyaret_Genel where Ziyaret_Genel.Kullanıcı_ID = (select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS              = @kullanıcı_12) and Ziy_Tar = @ziyretar_7); select 2;  insert into Ziyaret_Detay(Cins, Eczane_Id, Ziyaret_Durumu, Kullanıcı_Id, Ziy_Gnl_Id) values(1, @doktorıd_4, 0, (select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS              = @kullanıcı_4),(select ID from Ziyaret_Genel where Ziyaret_Genel.Kullanıcı_ID = (select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS              = @kullanıcı_9) and Ziy_Tar = @ziyretar_4)); update Ziyaret_Genel set Ziy_Edilecek_Eczane = Ziy_Edilecek_Eczane + 1 where Ziyaret_Genel.ID = (select ID from Ziyaret_Genel where Ziyaret_Genel.Kullanıcı_ID = (select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS              = @kullanıcı_13) and Ziy_Tar = @ziyretar_8); select 2;  " +
                    "end; " +
                    "end;" +
                   "else " +
                    "begin " +
                    "select 5; " +
                    "end; " +
                    "";


                var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
                var cmd = new SqlCommand(queryWithForJson, conn);



                cmd.Parameters.AddWithValue("@kullanıcı_gelen_1", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd.Parameters.AddWithValue("@doktorıd_gelen_1", Doktor_ID);//@kullanıcı
                cmd.Parameters.AddWithValue("@Ziyaret_Tar_ılk", Tar_1);
                cmd.Parameters.AddWithValue("@kullanıcı_gelen_2", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd.Parameters.AddWithValue("@doktorıd_gelen_2", Doktor_ID);
                cmd.Parameters.AddWithValue("@Ziyaret_Tar_ıkıncı", Tar_2);
                cmd.Parameters.AddWithValue("@kullanıcı_gelen_3", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd.Parameters.AddWithValue("@doktorıd_gelen_3", Doktor_ID);
                cmd.Parameters.AddWithValue("@Ziyaret_Tar_ucuncu", Tar_3);
                cmd.Parameters.AddWithValue("@kullanıcı_gelen_4", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());


                cmd.Parameters.AddWithValue("@kullanıcı_Kontrol", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd.Parameters.AddWithValue("@Doktor_ID_kontrol", Doktor_ID);
                cmd.Parameters.AddWithValue("@gelenziyaret_1", Tar_3);
                cmd.Parameters.AddWithValue("@gelenziyaret_2", Tar_3);
                cmd.Parameters.AddWithValue("@kullanıcı_Kontrol_2", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd.Parameters.AddWithValue("@Doktor_ID_kontrol_1", Doktor_ID);
                cmd.Parameters.AddWithValue("@doktorıd_2", Doktor_ID);
                cmd.Parameters.AddWithValue("@kullanıcı_2", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd.Parameters.AddWithValue("@kullanıcı_7", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd.Parameters.AddWithValue("@ziyretar_2", Tar_1);
                cmd.Parameters.AddWithValue("@kullanıcı_11", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd.Parameters.AddWithValue("@ziyretar_6", Tar_1);
                cmd.Parameters.AddWithValue("@doktorıd_3", Doktor_ID);
                cmd.Parameters.AddWithValue("@kullanıcı_3", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd.Parameters.AddWithValue("@kullanıcı_8", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd.Parameters.AddWithValue("@ziyretar_3", Tar_2);
                cmd.Parameters.AddWithValue("@kullanıcı_12", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd.Parameters.AddWithValue("@ziyretar_7", Tar_2);
                cmd.Parameters.AddWithValue("@doktorıd_4", Doktor_ID);
                cmd.Parameters.AddWithValue("@kullanıcı_4", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd.Parameters.AddWithValue("@kullanıcı_9", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd.Parameters.AddWithValue("@ziyretar_4", Tar_3);
                cmd.Parameters.AddWithValue("@kullanıcı_13", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd.Parameters.AddWithValue("@ziyretar_8", Tar_3);
                cmd.Parameters.AddWithValue("@doktorıd_5", Doktor_ID);
                cmd.Parameters.AddWithValue("@kullanıcı_6", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd.Parameters.AddWithValue("@kullanıcı_10", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd.Parameters.AddWithValue("@Liste_ıd", parametre.Split('/')[parametre.Split('/').Length - 1]);






                conn.Open();

                var reader = cmd.ExecuteReader();


                while (reader.Read())
                {
                    a += reader.GetValue(0).ToString();
                }


                if (a == "")
                {
                    conn.Close();
                    return "0";
                }
                else
                {
                    if (a == "5")
                    {
                        conn.Close();
                        return "5";
                    }
                    else
                    {
                        conn.Close();
                        return "1";
                    }
                }
            }

            if (parametre.Split('/').Length == 6)
            {
                string Tar_1 = parametre.Split('/')[2];
                string Tar_2 = parametre.Split('/')[1];
                string Tar_3 = parametre.Split('/')[3];
                string Tar_4 = parametre.Split('/')[0];
                string Doktor_ID = parametre.Split('/')[parametre.Split('/').Length - 2];

                var queryWithForJson = "declare @kont_1 int = 0 declare @kont_2 int = 0declare @kont_3 int = 0 declare @kont_4 int = 0 declare @kont_5 int = 0  " +
                    "if(( " +
                    "select Onay_Durum from Ziyaret_Genel " +
                    "inner join Ziyaret_Onay " +
                    "on Ziyaret_Genel.Ziyaret_Onay_Id=Ziyaret_Onay.Ziyaret_Onay_Id " +
                    "where Ziy_Tar=@ziyretar_6 and Ziyaret_Genel.Kullanıcı_ID= (select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS = @kullanıcı_Kontrol_2) " +
                    ")=0) " +
                    "begin " +
                    "if  not exists (select * from Ziyaret_Detay inner join Ziyaret_Genel on Ziyaret_Detay.Ziy_Gnl_Id=Ziyaret_Genel.ID  where Ziyaret_Genel.Kullanıcı_ID=(select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS              = @kullanıcı_gelen_1) and Eczane_Id=@doktorıd_gelen_1 and Ziy_Tar=@Ziyaret_Tar_ılk)  begin  set @kont_1=1;  print @kont_1;	end if not exists (select * from Ziyaret_Detay inner join Ziyaret_Genel on Ziyaret_Detay.Ziy_Gnl_Id=Ziyaret_Genel.ID  where Ziyaret_Genel.Kullanıcı_ID=(select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS              = @kullanıcı_gelen_2) and Eczane_Id=@doktorıd_gelen_2 and Ziy_Tar=@Ziyaret_Tar_ıkıncı) begin 	set @kont_2=1; print  @kont_2   end   if  not exists (select * from Ziyaret_Detay inner join Ziyaret_Genel on Ziyaret_Detay.Ziy_Gnl_Id=Ziyaret_Genel.ID  where Ziyaret_Genel.Kullanıcı_ID=(select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS              = @kullanıcı_gelen_3) and Eczane_Id=@doktorıd_gelen_3 and Ziy_Tar=@Ziyaret_Tar_ucuncu)   begin set @kont_3=1; print @kont_3 	end	 if not exists (select * from Ziyaret_Detay inner join Ziyaret_Genel on Ziyaret_Detay.Ziy_Gnl_Id=Ziyaret_Genel.ID  where Ziyaret_Genel.Kullanıcı_ID=(select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS              = @kullanıcı_gelen_4) and Eczane_Id=@doktorıd_gelen_4 and Ziy_Tar=@Ziyaret_Tar_dorduncu)   begin	   set @kont_4=1;  print @kont_4   end   if ((select COUNT(*) from Ziyaret_Detay  inner join Ziyaret_Genel on Ziyaret_Detay.Ziy_Gnl_Id=Ziyaret_Genel.ID where MONTH(Ziy_Tar) = MONTH(@gelenziyaret_1) and YEAR(Ziy_Tar)=YEAR(@gelenziyaret_2) and Ziyaret_Genel.Kullanıcı_ID= (select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS              = @kullanıcı_Kontrol_2) and Eczane_Id=@Doktor_ID_kontrol_1)<((select Frekans from Eczane inner join Eczane_Liste on Eczane_Liste.Eczane_Id=Eczane.Eczane_Id inner join Listeler on Eczane_Liste.Liste_Id=Listeler.Liste_Id where Eczane_Liste.Silinmismi=0 and Listeler.Liste_Id= @Liste_ıd and Listeler.Kullanıcı_Id = (select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS              =@kullanıcı_Kontrol) and Eczane.Eczane_Id=@Doktor_ID_kontrol)))  begin   set @kont_5=1;  print @kont_5 end 	if (@kont_1=1)and (@kont_2=1) and (@kont_3=1) and (@kont_4=1) and (@kont_5=1) 	begin 	insert into Ziyaret_Detay(Cins, Eczane_Id, Ziyaret_Durumu, Kullanıcı_Id, Ziy_Gnl_Id) values(1, @doktorıd_2, 0, (select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS              = @kullanıcı_2),(select ID from Ziyaret_Genel where Ziyaret_Genel.Kullanıcı_ID = (select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS              = @kullanıcı_7) and Ziy_Tar = @ziyretar_2)); update Ziyaret_Genel set Ziy_Edilecek_Eczane = Ziy_Edilecek_Eczane + 1 where Ziyaret_Genel.ID = (select ID from Ziyaret_Genel where Ziyaret_Genel.Kullanıcı_ID = (select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS           = @kullanıcı_11) and Ziy_Tar = @ziyretar_6); select 2;	insert into Ziyaret_Detay(Cins, Eczane_Id, Ziyaret_Durumu, Kullanıcı_Id, Ziy_Gnl_Id) values(1, @doktorıd_3, 0, (select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS           = @kullanıcı_3),(select ID from Ziyaret_Genel where Ziyaret_Genel.Kullanıcı_ID = (select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS           = @kullanıcı_8) and Ziy_Tar = @ziyretar_3)); update Ziyaret_Genel set Ziy_Edilecek_Eczane = Ziy_Edilecek_Eczane + 1 where Ziyaret_Genel.ID = (select ID from Ziyaret_Genel where Ziyaret_Genel.Kullanıcı_ID = (select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS           = @kullanıcı_12) and Ziy_Tar = @ziyretar_7); select 2;    insert into Ziyaret_Detay(Cins, Eczane_Id, Ziyaret_Durumu, Kullanıcı_Id, Ziy_Gnl_Id) values(1, @doktorıd_4, 0, (select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS           = @kullanıcı_4),(select ID from Ziyaret_Genel where Ziyaret_Genel.Kullanıcı_ID = (select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS           = @kullanıcı_9) and Ziy_Tar = @ziyretar_4)); update Ziyaret_Genel set Ziy_Edilecek_Eczane = Ziy_Edilecek_Eczane + 1 where Ziyaret_Genel.ID = (select ID from Ziyaret_Genel where Ziyaret_Genel.Kullanıcı_ID = (select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS           = @kullanıcı_13) and Ziy_Tar = @ziyretar_8); select 2;    insert into Ziyaret_Detay(Cins, Eczane_Id, Ziyaret_Durumu, Kullanıcı_Id, Ziy_Gnl_Id) values(1, @doktorıd_5, 0, (select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS           = @kullanıcı_6),(select ID from Ziyaret_Genel where Ziyaret_Genel.Kullanıcı_ID = (select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS           = @kullanıcı_10) and Ziy_Tar = @ziyretar_5)); update Ziyaret_Genel set Ziy_Edilecek_Eczane = Ziy_Edilecek_Eczane + 1 where Ziyaret_Genel.ID = (select ID from Ziyaret_Genel where Ziyaret_Genel.Kullanıcı_ID = (select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS           = @kullanıcı_14) and Ziy_Tar = @ziyretar_9);  " +
                    "select 2; " +
                    "end; " +
                    "end;" +
                    "else " +
                    "begin " +
                    "select 5; " +
                    "end; " +
                    "";


                var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
                var cmd = new SqlCommand(queryWithForJson, conn);



                cmd.Parameters.AddWithValue("@kullanıcı_gelen_1", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd.Parameters.AddWithValue("@doktorıd_gelen_1", Doktor_ID);//@kullanıcı
                cmd.Parameters.AddWithValue("@Ziyaret_Tar_ılk", Tar_1);
                cmd.Parameters.AddWithValue("@kullanıcı_gelen_2", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd.Parameters.AddWithValue("@doktorıd_gelen_2", Doktor_ID);
                cmd.Parameters.AddWithValue("@Ziyaret_Tar_ıkıncı", Tar_2);
                cmd.Parameters.AddWithValue("@kullanıcı_gelen_3", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd.Parameters.AddWithValue("@doktorıd_gelen_3", Doktor_ID);
                cmd.Parameters.AddWithValue("@Ziyaret_Tar_ucuncu", Tar_3);
                cmd.Parameters.AddWithValue("@kullanıcı_gelen_4", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd.Parameters.AddWithValue("@doktorıd_gelen_4", Doktor_ID);
                cmd.Parameters.AddWithValue("@Ziyaret_Tar_dorduncu", Tar_4);
                cmd.Parameters.AddWithValue("@kullanıcı_Kontrol", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd.Parameters.AddWithValue("@Doktor_ID_kontrol", Doktor_ID);
                cmd.Parameters.AddWithValue("@gelenziyaret_1", Tar_3);
                cmd.Parameters.AddWithValue("@gelenziyaret_2", Tar_3);
                cmd.Parameters.AddWithValue("@kullanıcı_Kontrol_2", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd.Parameters.AddWithValue("@Doktor_ID_kontrol_1", Doktor_ID);
                cmd.Parameters.AddWithValue("@doktorıd_2", Doktor_ID);
                cmd.Parameters.AddWithValue("@kullanıcı_2", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd.Parameters.AddWithValue("@kullanıcı_7", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd.Parameters.AddWithValue("@ziyretar_2", Tar_1);
                cmd.Parameters.AddWithValue("@kullanıcı_11", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd.Parameters.AddWithValue("@ziyretar_6", Tar_1);
                cmd.Parameters.AddWithValue("@doktorıd_3", Doktor_ID);
                cmd.Parameters.AddWithValue("@kullanıcı_3", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd.Parameters.AddWithValue("@kullanıcı_8", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd.Parameters.AddWithValue("@ziyretar_3", Tar_2);
                cmd.Parameters.AddWithValue("@kullanıcı_12", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd.Parameters.AddWithValue("@ziyretar_7", Tar_2);
                cmd.Parameters.AddWithValue("@doktorıd_4", Doktor_ID);
                cmd.Parameters.AddWithValue("@kullanıcı_4", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd.Parameters.AddWithValue("@kullanıcı_9", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd.Parameters.AddWithValue("@ziyretar_4", Tar_3);
                cmd.Parameters.AddWithValue("@kullanıcı_13", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd.Parameters.AddWithValue("@ziyretar_8", Tar_3);
                cmd.Parameters.AddWithValue("@doktorıd_5", Doktor_ID);
                cmd.Parameters.AddWithValue("@kullanıcı_6", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd.Parameters.AddWithValue("@kullanıcı_10", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd.Parameters.AddWithValue("@ziyretar_5", Tar_4);
                cmd.Parameters.AddWithValue("@kullanıcı_14", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd.Parameters.AddWithValue("@ziyretar_9", Tar_4);
                cmd.Parameters.AddWithValue("@Liste_ıd", parametre.Split('/')[parametre.Split('/').Length - 1]);




                conn.Open();

                var reader = cmd.ExecuteReader();


                while (reader.Read())
                {
                    a += reader.GetValue(0).ToString();
                }


                if (a == "")
                {
                    conn.Close();
                    return "0";
                }
                else
                {
                    if (a == "5")
                    {
                        conn.Close();
                        return "5";
                    }
                    else
                    {
                        conn.Close();
                        return "1";
                    }
                }

            }
            else
            {
                return "0";

            }



        }


        public class Gün_Kopyala_Tablo
        {
            public string Sipariş_Notu { get; set; }


        }
        [System.Web.Services.WebMethod]
        public static string Gün_Kopyala(string Kopyalanan_Gün_Id, string Yapıştırılacak_Gün_Id, string Gün)
        {



            var queryWithForJson = "if  ((  select Onay_Durum from Ziyaret_Onay where Bas_Tar=@1 and Kullanıcı_Id=(select KullanıcıID from Kullanıcı where KullanıcıAD COLLATE Latin1_general_CS_AS =@Kullanıcı_Ad) " +

            ")=1) " +
            "            begin ; " +
            "            select 0; " +
            "           end; " +
            "		   else " +
            "		   begin " +
            "" +
            "if  exists( " +
            "" +
            "select * " +
            "" +
            "from Ziyaret_Detay " +
            "" +
            "left join Ziyaret_Genel " +
            "on Ziyaret_Genel.ID=Ziy_Gnl_Id " +
            "" +
            "where ID= @Yapıştırılacak_Gün and Silinemez=0" +
            "" +
            "" +
            " ) " +
            "begin " +
            "" +
            "select 1 " +
            "end " +
            "else " +
            "begin " +
            "" +
            "" +
            "insert into Ziyaret_Detay " +
            "" +
            "" +
            "" +
            "select Ziyaret_Detay.Cins,Doktor_Id,Eczane_Id,Ziyaret_Notu,Ziyaret_Durumu,@Yapıştırılacak_Gün,Ziyaret_Detay.Kullanıcı_Id,Calısılan_Urun_1,Calısılan_Urun_2,Calısılan_Urun_3,(0) " +
            "" +
            "from Ziyaret_Detay " +
            "" +
            "left join Ziyaret_Genel " +
            "on Ziyaret_Genel.ID=Ziy_Gnl_Id " +
            "" +
            "where ID= @Kopyalanan_Gün " +
            "" +
            "end; " +
            "end; ";




            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);
            conn.Open();
            cmd.Parameters.AddWithValue("@Yapıştırılacak_Gün", Yapıştırılacak_Gün_Id);
            cmd.Parameters.AddWithValue("@Kopyalanan_Gün", Kopyalanan_Gün_Id);
            cmd.Parameters.AddWithValue("@1", Gün);
            cmd.Parameters.AddWithValue("@Kullanıcı_Ad", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());

            List<Gün_Kopyala_Tablo> tablo_Doldur_Classes = new List<Gün_Kopyala_Tablo>();


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
                    var Tablo_Doldur_Class_ = new Gün_Kopyala_Tablo
                    {
                        Sipariş_Notu = reader.GetValue(0).ToString(),

                    };
                    tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
                }
            }
            conn.Close();
            return JsonConvert.SerializeObject(tablo_Doldur_Classes);


        }

        [System.Web.Services.WebMethod]//2021-02-1/40
        public static string Eczane_Db_Yaz_2_hafta(string parametre)
        {//
            string a = "";
            if (parametre.Split('/').Length == 3)
            {
                string Tar_1 = parametre.Split('/')[0];



                string Doktor_ID = parametre.Split('/')[parametre.Split('/').Length - 2];

                ///var queryWithForJson = "declare @kont_1 int = 0 declare @kont_5 int = 0 if  not exists (select * from Ziyaret_Detay inner join Ziyaret_Genel on Ziyaret_Detay.Ziy_Gnl_Id=Ziyaret_Genel.ID  where Ziyaret_Genel.Kullanıcı_ID=(select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS           = @kullanıcı_gelen_1) and Eczane_Id=@doktorıd_gelen_1 and Ziy_Tar=@Ziyaret_Tar_ılk) begin set @kont_1=1; print @kont_1 end  if ((select COUNT(*) from Ziyaret_Detay  inner join Ziyaret_Genel on Ziyaret_Detay.Ziy_Gnl_Id=Ziyaret_Genel.ID where MONTH(Ziy_Tar) = MONTH(@gelenziyaret_1) and YEAR(Ziy_Tar)=YEAR(@gelenziyaret_2) and Ziyaret_Genel.Kullanıcı_ID= (select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS           = @kullanıcı_Kontrol_2) and Eczane_Id=@Doktor_ID_kontrol_1)<((select Frekans from Eczane inner join Eczane_Liste on Eczane_Liste.Eczane_Id=Eczane.Eczane_Id inner join Listeler on Eczane_Liste.Liste_Id=Listeler.Liste_Id where Listeler.Liste_Id= @Liste_ıd and Listeler.Kullanıcı_Id = (select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS           =@kullanıcı_Kontrol) and Eczane.Eczane_Id=@Doktor_ID_kontrol))) begin  set @kont_5=1; print @kont_5 end if (@kont_1=1) and (@kont_5=1)  begin insert  into Ziyaret_Detay(Cins, Eczane_Id, Ziyaret_Durumu, Kullanıcı_Id, Ziy_Gnl_Id) values(1, @doktorıd_2, 0, (select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS           = @kullanıcı_2),(select ID from Ziyaret_Genel where Ziyaret_Genel.Kullanıcı_ID = (select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS           = @kullanıcı_7) and Ziy_Tar = @ziyretar_2)); update Ziyaret_Genel set Ziy_Edilecek_Eczane = Ziy_Edilecek_Eczane + 1 where Ziyaret_Genel.ID = (select ID from Ziyaret_Genel where Ziyaret_Genel.Kullanıcı_ID = (select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS           = @kullanıcı_11) and Ziy_Tar = @ziyretar_6); select 2; end";

                var queryWithForJson = "" +
                    "declare @kont_1 int = 0 declare @kont_5 int = 0   " +
                    "if(( " +
                    "select Onay_Durum from Ziyaret_Genel " +
                    "inner join Ziyaret_Onay " +
                    "on Ziyaret_Genel.Ziyaret_Onay_Id=Ziyaret_Onay.Ziyaret_Onay_Id " +
                    "where Ziy_Tar=@ziyretar_6 and Ziyaret_Genel.Kullanıcı_ID= (select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS = @kullanıcı_Kontrol_2) " +
                    ")=0) " +
                    "begin " +
                    "if  not exists (select * from Ziyaret_Detay inner join Ziyaret_Genel on Ziyaret_Detay.Ziy_Gnl_Id=Ziyaret_Genel.ID  where Ziyaret_Genel.Kullanıcı_ID=(select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS           = @kullanıcı_gelen_1) and Eczane_Id=@doktorıd_gelen_1 and Ziy_Tar=@Ziyaret_Tar_ılk)  begin  set @kont_1=1;  print @kont_1 end  if ((select COUNT(*) from Ziyaret_Detay  inner join Ziyaret_Genel on Ziyaret_Detay.Ziy_Gnl_Id=Ziyaret_Genel.ID where MONTH(Ziy_Tar) = MONTH(@gelenziyaret_1) and YEAR(Ziy_Tar)=YEAR(@gelenziyaret_2) and Ziyaret_Genel.Kullanıcı_ID= (select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS           = @kullanıcı_Kontrol_2) and Eczane_Id=@Doktor_ID_kontrol_1)<((select Frekans from Eczane inner join Eczane_Liste on Eczane_Liste.Eczane_Id=Eczane.Eczane_Id inner join Listeler on Eczane_Liste.Liste_Id=Listeler.Liste_Id where Eczane_Liste.Silinmismi=0 and Listeler.Liste_Id= @Liste_ıd   and Listeler.Kullanıcı_Id = (select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS           =@kullanıcı_Kontrol) and Eczane.Eczane_Id=@Doktor_ID_kontrol))) begin set @kont_5=1;print @kont_5 end if (@kont_1=1) and (@kont_5=1)  begin insert into Ziyaret_Detay(Cins, Eczane_Id, Ziyaret_Durumu, Kullanıcı_Id, Ziy_Gnl_Id) values(1, @doktorıd_2, 0, (select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS           = @kullanıcı_2),(select ID from Ziyaret_Genel where Ziyaret_Genel.Kullanıcı_ID = (select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS           = @kullanıcı_7) and Ziy_Tar = @ziyretar_2)); update Ziyaret_Genel set Ziy_Edilecek_Eczane = Ziy_Edilecek_Eczane + 1 where Ziyaret_Genel.ID = (select ID from Ziyaret_Genel where Ziyaret_Genel.Kullanıcı_ID = (select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS           = @kullanıcı_11) and Ziy_Tar = @ziyretar_6);  " +
                    "select 2;  " +
                    "end;" +
                    "end;" +
                   "else " +
                    "begin " +
                    "select 5; " +
                    "end; " +
                    "";


                var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
                var cmd = new SqlCommand(queryWithForJson, conn);



                cmd.Parameters.AddWithValue("@kullanıcı_gelen_1", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd.Parameters.AddWithValue("@doktorıd_gelen_1", Doktor_ID);//@kullanıcı
                cmd.Parameters.AddWithValue("@Ziyaret_Tar_ılk", Tar_1);
                cmd.Parameters.AddWithValue("@kullanıcı_gelen_2", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd.Parameters.AddWithValue("@doktorıd_gelen_2", Doktor_ID);



                cmd.Parameters.AddWithValue("@kullanıcı_Kontrol", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd.Parameters.AddWithValue("@Doktor_ID_kontrol", Doktor_ID);
                cmd.Parameters.AddWithValue("@gelenziyaret_1", Tar_1);
                cmd.Parameters.AddWithValue("@gelenziyaret_2", Tar_1);
                cmd.Parameters.AddWithValue("@kullanıcı_Kontrol_2", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd.Parameters.AddWithValue("@Doktor_ID_kontrol_1", Doktor_ID);
                cmd.Parameters.AddWithValue("@doktorıd_2", Doktor_ID);
                cmd.Parameters.AddWithValue("@kullanıcı_2", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd.Parameters.AddWithValue("@kullanıcı_7", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd.Parameters.AddWithValue("@ziyretar_2", Tar_1);
                cmd.Parameters.AddWithValue("@kullanıcı_11", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd.Parameters.AddWithValue("@ziyretar_6", Tar_1);
                cmd.Parameters.AddWithValue("@doktorıd_3", Doktor_ID);
                cmd.Parameters.AddWithValue("@kullanıcı_3", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd.Parameters.AddWithValue("@kullanıcı_8", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());//@Liste_ıd
                cmd.Parameters.AddWithValue("@Liste_ıd", parametre.Split('/')[parametre.Split('/').Length - 1]);









                conn.Open();

                var reader = cmd.ExecuteReader();


                while (reader.Read())
                {
                    a += reader.GetValue(0).ToString();
                }


                if (a == "")
                {
                    conn.Close();
                    return "0";
                }
                else
                {
                    if (a == "5")
                    {
                        conn.Close();
                        return "5";
                    }
                    else
                    {
                        conn.Close();
                        return "1";
                    }
                }

            }
            if (parametre.Split('/').Length == 4)
            {
                string Tar_1 = parametre.Split('/')[0];
                string Tar_2 = parametre.Split('/')[1];


                string Doktor_ID = parametre.Split('/')[parametre.Split('/').Length - 2];


                var queryWithForJson = "" +
                    "declare @kont_1 int = 0 declare @kont_2 int = 0  declare @kont_5 int = 0  " +
                    "if(( " +
                    "select Onay_Durum from Ziyaret_Genel " +
                    "inner join Ziyaret_Onay " +
                    "on Ziyaret_Genel.Ziyaret_Onay_Id=Ziyaret_Onay.Ziyaret_Onay_Id " +
                    "where Ziy_Tar=@ziyretar_6 and Ziyaret_Genel.Kullanıcı_ID= (select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS = @kullanıcı_Kontrol_2) " +
                    ")=0) " +
                    "begin " +
                    "if  not exists (select * from Ziyaret_Detay inner join Ziyaret_Genel on Ziyaret_Detay.Ziy_Gnl_Id=Ziyaret_Genel.ID  where Ziyaret_Genel.Kullanıcı_ID=(select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS           = @kullanıcı_gelen_1) and Eczane_Id=@doktorıd_gelen_1 and Ziy_Tar=@Ziyaret_Tar_ılk)  begin  set @kont_1=1;  print @kont_1 end  if not exists (select * from Ziyaret_Detay inner join Ziyaret_Genel on Ziyaret_Detay.Ziy_Gnl_Id=Ziyaret_Genel.ID  where Ziyaret_Genel.Kullanıcı_ID=(select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS           = @kullanıcı_gelen_2) and Eczane_Id=@doktorıd_gelen_2 and Ziy_Tar=@Ziyaret_Tar_ıkıncı) begin  set @kont_2=1; print @kont_2 end  if ((select COUNT(*) from Ziyaret_Detay  inner join Ziyaret_Genel on Ziyaret_Detay.Ziy_Gnl_Id=Ziyaret_Genel.ID where MONTH(Ziy_Tar) = MONTH(@gelenziyaret_1) and YEAR(Ziy_Tar)=YEAR(@gelenziyaret_2) and Ziyaret_Genel.Kullanıcı_ID= (select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS           = @kullanıcı_Kontrol_2) and Eczane_Id=@Doktor_ID_kontrol_1)<((select Frekans from Eczane inner join Eczane_Liste on Eczane_Liste.Eczane_Id=Eczane.Eczane_Id inner join Listeler on Eczane_Liste.Liste_Id=Listeler.Liste_Id where Eczane_Liste.Silinmismi=0 and Listeler.Liste_Id= @Liste_ıd and Listeler.Kullanıcı_Id = (select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS           =@kullanıcı_Kontrol) and Eczane.Eczane_Id=@Doktor_ID_kontrol)))  begin set @kont_5=1; print @kont_5  end  if (@kont_1=1)and (@kont_2=1)   and (@kont_5=1)   begin  insert into Ziyaret_Detay(Cins, Eczane_Id, Ziyaret_Durumu, Kullanıcı_Id, Ziy_Gnl_Id) values(1, @doktorıd_2, 0, (select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS           = @kullanıcı_2),(select ID from Ziyaret_Genel where Ziyaret_Genel.Kullanıcı_ID = (select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS           = @kullanıcı_7) and Ziy_Tar = @ziyretar_2)); update Ziyaret_Genel set Ziy_Edilecek_Eczane = Ziy_Edilecek_Eczane + 1 where Ziyaret_Genel.ID = (select ID from Ziyaret_Genel where Ziyaret_Genel.Kullanıcı_ID = (select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS           = @kullanıcı_11) and Ziy_Tar = @ziyretar_6); select 2;  insert into Ziyaret_Detay(Cins, Eczane_Id, Ziyaret_Durumu, Kullanıcı_Id, Ziy_Gnl_Id) values(1, @doktorıd_3, 0, (select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS           = @kullanıcı_3),(select ID from Ziyaret_Genel where Ziyaret_Genel.Kullanıcı_ID = (select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS           = @kullanıcı_8) and Ziy_Tar = @ziyretar_3)); update Ziyaret_Genel set Ziy_Edilecek_Eczane = Ziy_Edilecek_Eczane + 1 where Ziyaret_Genel.ID = (select ID from Ziyaret_Genel where Ziyaret_Genel.Kullanıcı_ID = (select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS           = @kullanıcı_12) and Ziy_Tar = @ziyretar_7); " +
                    "select 2; " +
                    "end; " +
                    "end;" +
                   "else " +
                    "begin " +
                    "select 5; " +
                    "end; " +
                    "";


                var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
                var cmd = new SqlCommand(queryWithForJson, conn);



                cmd.Parameters.AddWithValue("@kullanıcı_gelen_1", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd.Parameters.AddWithValue("@doktorıd_gelen_1", Doktor_ID);//@kullanıcı
                cmd.Parameters.AddWithValue("@Ziyaret_Tar_ılk", Tar_1);
                cmd.Parameters.AddWithValue("@kullanıcı_gelen_2", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd.Parameters.AddWithValue("@doktorıd_gelen_2", Doktor_ID);
                cmd.Parameters.AddWithValue("@Ziyaret_Tar_ıkıncı", Tar_2);
                cmd.Parameters.AddWithValue("@kullanıcı_gelen_3", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd.Parameters.AddWithValue("@doktorıd_gelen_3", Doktor_ID);



                cmd.Parameters.AddWithValue("@kullanıcı_Kontrol", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd.Parameters.AddWithValue("@Doktor_ID_kontrol", Doktor_ID);
                cmd.Parameters.AddWithValue("@gelenziyaret_1", Tar_1);
                cmd.Parameters.AddWithValue("@gelenziyaret_2", Tar_1);
                cmd.Parameters.AddWithValue("@kullanıcı_Kontrol_2", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd.Parameters.AddWithValue("@Doktor_ID_kontrol_1", Doktor_ID);
                cmd.Parameters.AddWithValue("@doktorıd_2", Doktor_ID);
                cmd.Parameters.AddWithValue("@kullanıcı_2", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd.Parameters.AddWithValue("@kullanıcı_7", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd.Parameters.AddWithValue("@ziyretar_2", Tar_1);
                cmd.Parameters.AddWithValue("@kullanıcı_11", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd.Parameters.AddWithValue("@ziyretar_6", Tar_1);
                cmd.Parameters.AddWithValue("@doktorıd_3", Doktor_ID);
                cmd.Parameters.AddWithValue("@kullanıcı_3", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd.Parameters.AddWithValue("@kullanıcı_8", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd.Parameters.AddWithValue("@ziyretar_3", Tar_2);
                cmd.Parameters.AddWithValue("@kullanıcı_12", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd.Parameters.AddWithValue("@ziyretar_7", Tar_2);
                cmd.Parameters.AddWithValue("@doktorıd_4", Doktor_ID);
                cmd.Parameters.AddWithValue("@kullanıcı_4", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd.Parameters.AddWithValue("@kullanıcı_9", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd.Parameters.AddWithValue("@Liste_ıd", parametre.Split('/')[parametre.Split('/').Length - 1]);







                conn.Open();

                var reader = cmd.ExecuteReader();


                while (reader.Read())
                {
                    a += reader.GetValue(0).ToString();
                }
                conn.Close();

                if (a == "")
                {
                    conn.Close();
                    return "0";
                }
                else
                {
                    if (a == "5")
                    {
                        conn.Close();
                        return "5";
                    }
                    else
                    {
                        conn.Close();
                        return "1";
                    }
                }
            }
            else
            {
                return "0";
            }

        }




        [System.Web.Services.WebMethod]//2021-02-1/40
        public static string Doktor_Db_Yaz_2_hafta(string parametre)
        {//
            string a = "";
            if (parametre.Split('/').Length == 3)
            {
                string Tar_1 = parametre.Split('/')[0];



                string Doktor_ID = parametre.Split('/')[parametre.Split('/').Length - 2];


                var queryWithForJson = "" +
                    "declare @kont_1 int = 0 declare @kont_5 int = 0  " +
                    "if(( " +
                    "select Onay_Durum from Ziyaret_Genel " +
                    "inner join Ziyaret_Onay " +
                    "on Ziyaret_Genel.Ziyaret_Onay_Id=Ziyaret_Onay.Ziyaret_Onay_Id " +
                    "where Ziy_Tar=@ziyretar_6 and Ziyaret_Genel.Kullanıcı_ID= (select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS = @kullanıcı_Kontrol_2) " +
                    ")=0) " +
                    "begin " +
                    "if  not exists (select * from Ziyaret_Detay inner join Ziyaret_Genel on Ziyaret_Detay.Ziy_Gnl_Id=Ziyaret_Genel.ID  where Ziyaret_Genel.Kullanıcı_ID=(select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS           = @kullanıcı_gelen_1) and Doktor_Id=@doktorıd_gelen_1 and Ziy_Tar=@Ziyaret_Tar_ılk) begin  set @kont_1=1; print @kont_1 end if ((select COUNT(*) from Ziyaret_Detay  inner join Ziyaret_Genel on Ziyaret_Detay.Ziy_Gnl_Id=Ziyaret_Genel.ID where MONTH(Ziy_Tar) = MONTH(@gelenziyaret_1) and YEAR(Ziy_Tar)=YEAR(@gelenziyaret_2) and Ziyaret_Genel.Kullanıcı_ID= (select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS           = @kullanıcı_Kontrol_2) and Doktor_Id=@Doktor_ID_kontrol_1)<((select Doktor_Liste.Frekans from Doktors inner join Doktor_Liste on Doktor_Liste.Doktor_ıd=Doktors.Doktor_Id inner join Listeler on Doktor_Liste.Liste_Id=Listeler.Liste_Id where Listeler.Liste_Id= @Liste_ıd and Listeler.Kullanıcı_Id = (select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS           =@kullanıcı_Kontrol) and Doktors.Doktor_Id=@Doktor_ID_kontrol) ))begin set @kont_5=1; print @kont_5 end if (@kont_1=1) and (@kont_5=1)  begin insert into Ziyaret_Detay(Cins, Doktor_Id, Ziyaret_Durumu, Kullanıcı_Id, Ziy_Gnl_Id) values(0, @doktorıd_2, 0, (select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS           = @kullanıcı_2),(select ID from Ziyaret_Genel where Ziyaret_Genel.Kullanıcı_ID = (select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS           = @kullanıcı_7) and Ziy_Tar = @ziyretar_2)); update Ziyaret_Genel set Ziy_Edilecek_Doktor = Ziy_Edilecek_Doktor + 1 where Ziyaret_Genel.ID = (select ID from Ziyaret_Genel where Ziyaret_Genel.Kullanıcı_ID = (select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS           = @kullanıcı_11) and Ziy_Tar = @ziyretar_6); select 2;  " +
                    "end; " +
                    "end; " +
                    "else " +
                    "begin " +
                    "select 5; " +
                    "end; " +
                    "";


                var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
                var cmd = new SqlCommand(queryWithForJson, conn);



                cmd.Parameters.AddWithValue("@kullanıcı_gelen_1", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd.Parameters.AddWithValue("@doktorıd_gelen_1", Doktor_ID);//@kullanıcı
                cmd.Parameters.AddWithValue("@Ziyaret_Tar_ılk", Tar_1);
                cmd.Parameters.AddWithValue("@kullanıcı_gelen_2", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd.Parameters.AddWithValue("@doktorıd_gelen_2", Doktor_ID);



                cmd.Parameters.AddWithValue("@kullanıcı_Kontrol", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd.Parameters.AddWithValue("@Doktor_ID_kontrol", Doktor_ID);
                cmd.Parameters.AddWithValue("@gelenziyaret_1", Tar_1);
                cmd.Parameters.AddWithValue("@gelenziyaret_2", Tar_1);
                cmd.Parameters.AddWithValue("@kullanıcı_Kontrol_2", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd.Parameters.AddWithValue("@Doktor_ID_kontrol_1", Doktor_ID);
                cmd.Parameters.AddWithValue("@doktorıd_2", Doktor_ID);
                cmd.Parameters.AddWithValue("@kullanıcı_2", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd.Parameters.AddWithValue("@kullanıcı_7", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd.Parameters.AddWithValue("@ziyretar_2", Tar_1);
                cmd.Parameters.AddWithValue("@kullanıcı_11", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd.Parameters.AddWithValue("@ziyretar_6", Tar_1);
                cmd.Parameters.AddWithValue("@doktorıd_3", Doktor_ID);
                cmd.Parameters.AddWithValue("@kullanıcı_3", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd.Parameters.AddWithValue("@kullanıcı_8", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());//@Liste_ıd
                cmd.Parameters.AddWithValue("@Liste_ıd", parametre.Split('/')[parametre.Split('/').Length - 1]);









                conn.Open();

                var reader = cmd.ExecuteReader();


                while (reader.Read())
                {
                    a += reader.GetValue(0).ToString();
                }


                if (a == "")
                {
                    conn.Close();
                    return "0";
                }
                else
                {
                    if (a == "5")
                    {
                        conn.Close();
                        return "5";
                    }
                    else
                    {
                        conn.Close();
                        return "1";
                    }
                }

            }
            if (parametre.Split('/').Length == 4)
            {
                string Tar_1 = parametre.Split('/')[0];
                string Tar_2 = parametre.Split('/')[1];


                string Doktor_ID = parametre.Split('/')[parametre.Split('/').Length - 2];


                var queryWithForJson = "" +
                    "declare @kont_1 int = 0 declare @kont_2 int = 0  declare @kont_5 int = 0  " +
                    "if(( " +
                    "select Onay_Durum from Ziyaret_Genel " +
                    "inner join Ziyaret_Onay " +
                    "on Ziyaret_Genel.Ziyaret_Onay_Id=Ziyaret_Onay.Ziyaret_Onay_Id " +
                    "where Ziy_Tar=@ziyretar_6 and Ziyaret_Genel.Kullanıcı_ID= (select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS = @kullanıcı_Kontrol_2) " +
                    ")=0) " +
                    "begin " +
                    "if  not exists (select * from Ziyaret_Detay inner join Ziyaret_Genel on Ziyaret_Detay.Ziy_Gnl_Id=Ziyaret_Genel.ID  where Ziyaret_Genel.Kullanıcı_ID=(select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS           = @kullanıcı_gelen_1) and Doktor_Id=@doktorıd_gelen_1 and Ziy_Tar=@Ziyaret_Tar_ılk)begin   set @kont_1=1;  print @kont_1 end if not exists (select * from Ziyaret_Detay inner join Ziyaret_Genel on Ziyaret_Detay.Ziy_Gnl_Id=Ziyaret_Genel.ID  where Ziyaret_Genel.Kullanıcı_ID=(select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS           = @kullanıcı_gelen_2) and Doktor_Id=@doktorıd_gelen_2 and Ziy_Tar=@Ziyaret_Tar_ıkıncı) begin  set @kont_2=1; print @kont_2 end  if ((select COUNT(*) from Ziyaret_Detay  inner join Ziyaret_Genel on Ziyaret_Detay.Ziy_Gnl_Id=Ziyaret_Genel.ID where MONTH(Ziy_Tar) = MONTH(@gelenziyaret_1) and YEAR(Ziy_Tar)=YEAR(@gelenziyaret_2) and Ziyaret_Genel.Kullanıcı_ID= (select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS           = @kullanıcı_Kontrol_2) and Doktor_Id=@Doktor_ID_kontrol_1)<((select Doktor_Liste.Frekans from Doktors inner join Doktor_Liste on Doktor_Liste.Doktor_ıd=Doktors.Doktor_Id inner join Listeler on Doktor_Liste.Liste_Id=Listeler.Liste_Id where Listeler.Liste_Id= @Liste_ıd and Listeler.Kullanıcı_Id = (select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS           =@kullanıcı_Kontrol) and Doktors.Doktor_Id=@Doktor_ID_kontrol) )) begin set @kont_5=1; print @kont_5 end if (@kont_1=1)and (@kont_2=1)   and (@kont_5=1)  begin insert into Ziyaret_Detay(Cins, Doktor_Id, Ziyaret_Durumu, Kullanıcı_Id, Ziy_Gnl_Id) values(0, @doktorıd_2, 0, (select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS           = @kullanıcı_2),(select ID from Ziyaret_Genel where Ziyaret_Genel.Kullanıcı_ID = (select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS           = @kullanıcı_7) and Ziy_Tar = @ziyretar_2)); update Ziyaret_Genel set Ziy_Edilecek_Doktor = Ziy_Edilecek_Doktor + 1 where Ziyaret_Genel.ID = (select ID from Ziyaret_Genel where Ziyaret_Genel.Kullanıcı_ID = (select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS           = @kullanıcı_11) and Ziy_Tar = @ziyretar_6); select 2;  insert into Ziyaret_Detay(Cins, Doktor_Id, Ziyaret_Durumu, Kullanıcı_Id, Ziy_Gnl_Id) values(0, @doktorıd_3, 0, (select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS           = @kullanıcı_3),(select ID from Ziyaret_Genel where Ziyaret_Genel.Kullanıcı_ID = (select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS           = @kullanıcı_8) and Ziy_Tar = @ziyretar_3)); update Ziyaret_Genel set Ziy_Edilecek_Doktor = Ziy_Edilecek_Doktor + 1 where Ziyaret_Genel.ID = (select ID from Ziyaret_Genel where Ziyaret_Genel.Kullanıcı_ID = (select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS           = @kullanıcı_12) and Ziy_Tar = @ziyretar_7); select 2;      " +
                    "end;" +
                    "end;" +
                    "else " +
                    "begin " +
                    "select 5; " +
                    "end; " +
                    "";


                var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
                var cmd = new SqlCommand(queryWithForJson, conn);



                cmd.Parameters.AddWithValue("@kullanıcı_gelen_1", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd.Parameters.AddWithValue("@doktorıd_gelen_1", Doktor_ID);//@kullanıcı
                cmd.Parameters.AddWithValue("@Ziyaret_Tar_ılk", Tar_1);
                cmd.Parameters.AddWithValue("@kullanıcı_gelen_2", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd.Parameters.AddWithValue("@doktorıd_gelen_2", Doktor_ID);
                cmd.Parameters.AddWithValue("@Ziyaret_Tar_ıkıncı", Tar_2);
                cmd.Parameters.AddWithValue("@kullanıcı_gelen_3", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd.Parameters.AddWithValue("@doktorıd_gelen_3", Doktor_ID);



                cmd.Parameters.AddWithValue("@kullanıcı_Kontrol", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd.Parameters.AddWithValue("@Doktor_ID_kontrol", Doktor_ID);
                cmd.Parameters.AddWithValue("@gelenziyaret_1", Tar_1);
                cmd.Parameters.AddWithValue("@gelenziyaret_2", Tar_1);
                cmd.Parameters.AddWithValue("@kullanıcı_Kontrol_2", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd.Parameters.AddWithValue("@Doktor_ID_kontrol_1", Doktor_ID);
                cmd.Parameters.AddWithValue("@doktorıd_2", Doktor_ID);
                cmd.Parameters.AddWithValue("@kullanıcı_2", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd.Parameters.AddWithValue("@kullanıcı_7", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd.Parameters.AddWithValue("@ziyretar_2", Tar_1);
                cmd.Parameters.AddWithValue("@kullanıcı_11", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd.Parameters.AddWithValue("@ziyretar_6", Tar_1);
                cmd.Parameters.AddWithValue("@doktorıd_3", Doktor_ID);
                cmd.Parameters.AddWithValue("@kullanıcı_3", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd.Parameters.AddWithValue("@kullanıcı_8", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd.Parameters.AddWithValue("@ziyretar_3", Tar_2);
                cmd.Parameters.AddWithValue("@kullanıcı_12", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd.Parameters.AddWithValue("@ziyretar_7", Tar_2);
                cmd.Parameters.AddWithValue("@doktorıd_4", Doktor_ID);
                cmd.Parameters.AddWithValue("@kullanıcı_4", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd.Parameters.AddWithValue("@kullanıcı_9", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd.Parameters.AddWithValue("@Liste_ıd", parametre.Split('/')[parametre.Split('/').Length - 1]);







                conn.Open();

                var reader = cmd.ExecuteReader();


                while (reader.Read())
                {
                    a += reader.GetValue(0).ToString();
                }
                conn.Close();

                if (a == "")
                {
                    conn.Close();
                    return "0";
                }
                else
                {
                    if (a == "5")
                    {
                        conn.Close();
                        return "5";
                    }
                    else
                    {
                        conn.Close();
                        return "1";
                    }
                }
            }
            else
            {

                return "0";
            }

        }


        [System.Web.Services.WebMethod]//2021-02-1/40
        public static string Doktor_Db_Yaz_4_hafta(string parametre)
        {//
            //
            string a = "";
            if (parametre.Split('/').Length == 3)
            {
                string Tar_1 = parametre.Split('/')[0];



                string Doktor_ID = parametre.Split('/')[parametre.Split('/').Length - 2];


                var queryWithForJson = "" +
                    "declare @kont_1 int = 0 declare @kont_5 int = 0  " +
                    "if(( " +
                    "select Onay_Durum from Ziyaret_Genel " +
                    "inner join Ziyaret_Onay " +
                    "on Ziyaret_Genel.Ziyaret_Onay_Id=Ziyaret_Onay.Ziyaret_Onay_Id " +
                    "where Ziy_Tar=@ziyretar_6 and Ziyaret_Genel.Kullanıcı_ID= (select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS = @kullanıcı_Kontrol_2) " +
                    ")=0) " +
                    "begin " +
                    "if  not exists (select * from Ziyaret_Detay inner join Ziyaret_Genel on Ziyaret_Detay.Ziy_Gnl_Id=Ziyaret_Genel.ID  where Ziyaret_Genel.Kullanıcı_ID=(select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS           = @kullanıcı_gelen_1) and Doktor_Id=@doktorıd_gelen_1 and Ziy_Tar=@Ziyaret_Tar_ılk) begin  set @kont_1=1; print @kont_1 end if ((select COUNT(*) from Ziyaret_Detay  inner join Ziyaret_Genel on Ziyaret_Detay.Ziy_Gnl_Id=Ziyaret_Genel.ID where MONTH(Ziy_Tar) = MONTH(@gelenziyaret_1) and YEAR(Ziy_Tar)=YEAR(@gelenziyaret_2) and Ziyaret_Genel.Kullanıcı_ID= (select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS           = @kullanıcı_Kontrol_2) and Doktor_Id=@Doktor_ID_kontrol_1)<((select Doktor_Liste.Frekans from Doktors inner join Doktor_Liste on Doktor_Liste.Doktor_ıd=Doktors.Doktor_Id inner join Listeler on Doktor_Liste.Liste_Id=Listeler.Liste_Id where Listeler.Liste_Id= @Liste_ıd and Listeler.Kullanıcı_Id = (select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS           =@kullanıcı_Kontrol) and Doktors.Doktor_Id=@Doktor_ID_kontrol) ))begin set @kont_5=1; print @kont_5 end if (@kont_1=1) and (@kont_5=1)  begin insert into Ziyaret_Detay(Cins, Doktor_Id, Ziyaret_Durumu, Kullanıcı_Id, Ziy_Gnl_Id) values(0, @doktorıd_2, 0, (select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS           = @kullanıcı_2),(select ID from Ziyaret_Genel where Ziyaret_Genel.Kullanıcı_ID = (select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS           = @kullanıcı_7) and Ziy_Tar = @ziyretar_2)); update Ziyaret_Genel set Ziy_Edilecek_Doktor = Ziy_Edilecek_Doktor + 1 where Ziyaret_Genel.ID = (select ID from Ziyaret_Genel where Ziyaret_Genel.Kullanıcı_ID = (select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS           = @kullanıcı_11) and Ziy_Tar = @ziyretar_6); select 2; " +
                    "end; " +
                    "end;" +
                   "else " +
                    "begin " +
                    "select 5; " +
                    "end; " +
                    "";


                var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
                var cmd = new SqlCommand(queryWithForJson, conn);



                cmd.Parameters.AddWithValue("@kullanıcı_gelen_1", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd.Parameters.AddWithValue("@doktorıd_gelen_1", Doktor_ID);//@kullanıcı
                cmd.Parameters.AddWithValue("@Ziyaret_Tar_ılk", Tar_1);
                cmd.Parameters.AddWithValue("@kullanıcı_gelen_2", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd.Parameters.AddWithValue("@doktorıd_gelen_2", Doktor_ID);



                cmd.Parameters.AddWithValue("@kullanıcı_Kontrol", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd.Parameters.AddWithValue("@Doktor_ID_kontrol", Doktor_ID);
                cmd.Parameters.AddWithValue("@gelenziyaret_1", Tar_1);
                cmd.Parameters.AddWithValue("@gelenziyaret_2", Tar_1);
                cmd.Parameters.AddWithValue("@kullanıcı_Kontrol_2", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd.Parameters.AddWithValue("@Doktor_ID_kontrol_1", Doktor_ID);
                cmd.Parameters.AddWithValue("@doktorıd_2", Doktor_ID);
                cmd.Parameters.AddWithValue("@kullanıcı_2", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd.Parameters.AddWithValue("@kullanıcı_7", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd.Parameters.AddWithValue("@ziyretar_2", Tar_1);
                cmd.Parameters.AddWithValue("@kullanıcı_11", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd.Parameters.AddWithValue("@ziyretar_6", Tar_1);
                cmd.Parameters.AddWithValue("@doktorıd_3", Doktor_ID);
                cmd.Parameters.AddWithValue("@kullanıcı_3", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd.Parameters.AddWithValue("@kullanıcı_8", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd.Parameters.AddWithValue("@Liste_ıd", parametre.Split('/')[parametre.Split('/').Length - 1]);









                conn.Open();

                var reader = cmd.ExecuteReader();


                while (reader.Read())
                {
                    a += reader.GetValue(0).ToString();
                }


                if (a == "")
                {
                    conn.Close();
                    return "0";
                }
                else
                {
                    if (a == "5")
                    {
                        conn.Close();
                        return "5";
                    }
                    else
                    {
                        conn.Close();
                        return "1";
                    }
                }
            }

            if (parametre.Split('/').Length == 5)
            {
                string Tar_1 = parametre.Split('/')[0];
                string Tar_2 = parametre.Split('/')[1];
                string Tar_3 = parametre.Split('/')[2];

                string Doktor_ID = parametre.Split('/')[parametre.Split('/').Length - 2];


                var queryWithForJson = "" +
                    "declare @kont_1 int = 0 declare @kont_2 int = 0 declare @kont_3 int = 0 declare @kont_5 int = 0  " +
                    "if(( " +
                    "select Onay_Durum from Ziyaret_Genel " +
                    "inner join Ziyaret_Onay " +
                    "on Ziyaret_Genel.Ziyaret_Onay_Id=Ziyaret_Onay.Ziyaret_Onay_Id " +
                    "where Ziy_Tar=@ziyretar_6 and Ziyaret_Genel.Kullanıcı_ID= (select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS = @kullanıcı_Kontrol_2) " +
                    ")=0) " +
                    "begin " +
                    "if  not exists (select * from Ziyaret_Detay inner join Ziyaret_Genel on Ziyaret_Detay.Ziy_Gnl_Id=Ziyaret_Genel.ID  where Ziyaret_Genel.Kullanıcı_ID=(select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS           = @kullanıcı_gelen_1) and Doktor_Id=@doktorıd_gelen_1 and Ziy_Tar=@Ziyaret_Tar_ılk)begin   set @kont_1=1;  print @kont_1 end if not exists (select * from Ziyaret_Detay inner join Ziyaret_Genel on Ziyaret_Detay.Ziy_Gnl_Id=Ziyaret_Genel.ID  where Ziyaret_Genel.Kullanıcı_ID=(select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS           = @kullanıcı_gelen_2) and Doktor_Id=@doktorıd_gelen_2 and Ziy_Tar=@Ziyaret_Tar_ıkıncı) begin  set @kont_2=1; print @kont_2 end if  not exists (select * from Ziyaret_Detay inner join Ziyaret_Genel on Ziyaret_Detay.Ziy_Gnl_Id=Ziyaret_Genel.ID  where Ziyaret_Genel.Kullanıcı_ID=(select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS           = @kullanıcı_gelen_3) and Doktor_Id=@doktorıd_gelen_3 and Ziy_Tar=@Ziyaret_Tar_ucuncu)begin set @kont_3=1; print @kont_3 end if ((select COUNT(*) from Ziyaret_Detay  inner join Ziyaret_Genel on Ziyaret_Detay.Ziy_Gnl_Id=Ziyaret_Genel.ID where MONTH(Ziy_Tar) = MONTH(@gelenziyaret_1) and YEAR(Ziy_Tar)=YEAR(@gelenziyaret_2) and Ziyaret_Genel.Kullanıcı_ID= (select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS           = @kullanıcı_Kontrol_2) and Doktor_Id=@Doktor_ID_kontrol_1)<((select Doktor_Liste.Frekans from Doktors inner join Doktor_Liste on Doktor_Liste.Doktor_ıd=Doktors.Doktor_Id inner join Listeler on Doktor_Liste.Liste_Id=Listeler.Liste_Id where Listeler.Liste_Id= @Liste_ıd and Listeler.Kullanıcı_Id = (select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS           =@kullanıcı_Kontrol) and Doktors.Doktor_Id=@Doktor_ID_kontrol) )) begin set @kont_5=1; print @kont_5 end if (@kont_1=1)and (@kont_2=1) and (@kont_3=1)  and (@kont_5=1)  begin insert into Ziyaret_Detay(Cins, Doktor_Id, Ziyaret_Durumu, Kullanıcı_Id, Ziy_Gnl_Id) values(0, @doktorıd_2, 0, (select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS           = @kullanıcı_2),(select ID from Ziyaret_Genel where Ziyaret_Genel.Kullanıcı_ID = (select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS           = @kullanıcı_7) and Ziy_Tar = @ziyretar_2)); update Ziyaret_Genel set Ziy_Edilecek_Doktor = Ziy_Edilecek_Doktor + 1 where Ziyaret_Genel.ID = (select ID from Ziyaret_Genel where Ziyaret_Genel.Kullanıcı_ID = (select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS           = @kullanıcı_11) and Ziy_Tar = @ziyretar_6); select 2;  insert into Ziyaret_Detay(Cins, Doktor_Id, Ziyaret_Durumu, Kullanıcı_Id, Ziy_Gnl_Id) values(0, @doktorıd_3, 0, (select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS           = @kullanıcı_3),(select ID from Ziyaret_Genel where Ziyaret_Genel.Kullanıcı_ID = (select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS           = @kullanıcı_8) and Ziy_Tar = @ziyretar_3)); update Ziyaret_Genel set Ziy_Edilecek_Doktor = Ziy_Edilecek_Doktor + 1 where Ziyaret_Genel.ID = (select ID from Ziyaret_Genel where Ziyaret_Genel.Kullanıcı_ID = (select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS           = @kullanıcı_12) and Ziy_Tar = @ziyretar_7); select 2;    insert into Ziyaret_Detay(Cins, Doktor_Id, Ziyaret_Durumu, Kullanıcı_Id, Ziy_Gnl_Id) values(0, @doktorıd_4, 0, (select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS           = @kullanıcı_4),(select ID from Ziyaret_Genel where Ziyaret_Genel.Kullanıcı_ID = (select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS           = @kullanıcı_9) and Ziy_Tar = @ziyretar_4)); update Ziyaret_Genel set Ziy_Edilecek_Doktor = Ziy_Edilecek_Doktor + 1 where Ziyaret_Genel.ID = (select ID from Ziyaret_Genel where Ziyaret_Genel.Kullanıcı_ID = (select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS           = @kullanıcı_13) and Ziy_Tar = @ziyretar_8); select 2;   " +
                    "end; " +
                    "end;" +
                   "else " +
                    "begin " +
                    "select 5; " +
                    "end; " +
                    "";


                var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
                var cmd = new SqlCommand(queryWithForJson, conn);



                cmd.Parameters.AddWithValue("@kullanıcı_gelen_1", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd.Parameters.AddWithValue("@doktorıd_gelen_1", Doktor_ID);//@kullanıcı
                cmd.Parameters.AddWithValue("@Ziyaret_Tar_ılk", Tar_1);
                cmd.Parameters.AddWithValue("@kullanıcı_gelen_2", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd.Parameters.AddWithValue("@doktorıd_gelen_2", Doktor_ID);
                cmd.Parameters.AddWithValue("@Ziyaret_Tar_ıkıncı", Tar_2);
                cmd.Parameters.AddWithValue("@kullanıcı_gelen_3", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd.Parameters.AddWithValue("@doktorıd_gelen_3", Doktor_ID);
                cmd.Parameters.AddWithValue("@Ziyaret_Tar_ucuncu", Tar_3);
                cmd.Parameters.AddWithValue("@kullanıcı_gelen_4", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());


                cmd.Parameters.AddWithValue("@kullanıcı_Kontrol", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd.Parameters.AddWithValue("@Doktor_ID_kontrol", Doktor_ID);
                cmd.Parameters.AddWithValue("@gelenziyaret_1", Tar_3);
                cmd.Parameters.AddWithValue("@gelenziyaret_2", Tar_3);
                cmd.Parameters.AddWithValue("@kullanıcı_Kontrol_2", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd.Parameters.AddWithValue("@Doktor_ID_kontrol_1", Doktor_ID);
                cmd.Parameters.AddWithValue("@doktorıd_2", Doktor_ID);
                cmd.Parameters.AddWithValue("@kullanıcı_2", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd.Parameters.AddWithValue("@kullanıcı_7", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd.Parameters.AddWithValue("@ziyretar_2", Tar_1);
                cmd.Parameters.AddWithValue("@kullanıcı_11", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd.Parameters.AddWithValue("@ziyretar_6", Tar_1);
                cmd.Parameters.AddWithValue("@doktorıd_3", Doktor_ID);
                cmd.Parameters.AddWithValue("@kullanıcı_3", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd.Parameters.AddWithValue("@kullanıcı_8", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd.Parameters.AddWithValue("@ziyretar_3", Tar_2);
                cmd.Parameters.AddWithValue("@kullanıcı_12", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd.Parameters.AddWithValue("@ziyretar_7", Tar_2);
                cmd.Parameters.AddWithValue("@doktorıd_4", Doktor_ID);
                cmd.Parameters.AddWithValue("@kullanıcı_4", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd.Parameters.AddWithValue("@kullanıcı_9", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd.Parameters.AddWithValue("@ziyretar_4", Tar_3);
                cmd.Parameters.AddWithValue("@kullanıcı_13", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd.Parameters.AddWithValue("@ziyretar_8", Tar_3);
                cmd.Parameters.AddWithValue("@doktorıd_5", Doktor_ID);
                cmd.Parameters.AddWithValue("@kullanıcı_6", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd.Parameters.AddWithValue("@kullanıcı_10", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd.Parameters.AddWithValue("@Liste_ıd", parametre.Split('/')[parametre.Split('/').Length - 1]);






                conn.Open();

                var reader = cmd.ExecuteReader();


                while (reader.Read())
                {
                    a += reader.GetValue(0).ToString();
                }


                if (a == "")
                {
                    conn.Close();
                    return "0";
                }
                else
                {
                    if (a == "5")
                    {
                        conn.Close();
                        return "5";
                    }
                    else
                    {
                        conn.Close();
                        return "1";
                    }
                }
            }

            if (parametre.Split('/').Length == 6)
            {
                string Tar_1 = parametre.Split('/')[2];
                string Tar_2 = parametre.Split('/')[1];
                string Tar_3 = parametre.Split('/')[3];
                string Tar_4 = parametre.Split('/')[0];
                string Doktor_ID = parametre.Split('/')[parametre.Split('/').Length - 2];

                var queryWithForJson = "" +
                    "declare @kont_1 int = 0 declare @kont_2 int = 0 declare @kont_3 int = 0 declare @kont_4 int = 0 declare @kont_5 int = 0  " +
                    "if(( " +
                    "select Onay_Durum from Ziyaret_Genel " +
                    "inner join Ziyaret_Onay " +
                    "on Ziyaret_Genel.Ziyaret_Onay_Id=Ziyaret_Onay.Ziyaret_Onay_Id " +
                    "where Ziy_Tar=@ziyretar_6 and Ziyaret_Genel.Kullanıcı_ID= (select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS = @kullanıcı_Kontrol_2) " +
                    ")=0) " +
                    "begin " +
                    "if  not exists (select * from Ziyaret_Detay inner join Ziyaret_Genel on Ziyaret_Detay.Ziy_Gnl_Id=Ziyaret_Genel.ID  where Ziyaret_Genel.Kullanıcı_ID=(select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS           = @kullanıcı_gelen_1) and Doktor_Id=@doktorıd_gelen_1 and Ziy_Tar=@Ziyaret_Tar_ılk)  begin  set @kont_1=1; print @kont_1 end if not exists (select * from Ziyaret_Detay inner join Ziyaret_Genel on Ziyaret_Detay.Ziy_Gnl_Id=Ziyaret_Genel.ID  where Ziyaret_Genel.Kullanıcı_ID=(select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS           = @kullanıcı_gelen_2) and Doktor_Id=@doktorıd_gelen_2 and Ziy_Tar=@Ziyaret_Tar_ıkıncı) begin  set @kont_2=1; print @kont_2 end if  not exists (select * from Ziyaret_Detay inner join Ziyaret_Genel on Ziyaret_Detay.Ziy_Gnl_Id=Ziyaret_Genel.ID  where Ziyaret_Genel.Kullanıcı_ID=(select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS           = @kullanıcı_gelen_3) and Doktor_Id=@doktorıd_gelen_3 and Ziy_Tar=@Ziyaret_Tar_ucuncu) begin set @kont_3=1; print @kont_3 end if not exists (select * from Ziyaret_Detay inner join Ziyaret_Genel on Ziyaret_Detay.Ziy_Gnl_Id=Ziyaret_Genel.ID  where Ziyaret_Genel.Kullanıcı_ID=(select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS           = @kullanıcı_gelen_4) and Doktor_Id=@doktorıd_gelen_4 and Ziy_Tar=@Ziyaret_Tar_dorduncu)  begin set @kont_4=1; print @kont_4 end if ((select COUNT(*) from Ziyaret_Detay  inner join Ziyaret_Genel on Ziyaret_Detay.Ziy_Gnl_Id=Ziyaret_Genel.ID where MONTH(Ziy_Tar) = MONTH(@gelenziyaret_1) and YEAR(Ziy_Tar)=YEAR(@gelenziyaret_2) and Ziyaret_Genel.Kullanıcı_ID= (select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS           = @kullanıcı_Kontrol_2) and Doktor_Id=@Doktor_ID_kontrol_1)<((select Doktor_Liste.Frekans from Doktors inner join Doktor_Liste on Doktor_Liste.Doktor_ıd=Doktors.Doktor_Id inner join Listeler on Doktor_Liste.Liste_Id=Listeler.Liste_Id where Listeler.Liste_Id= @Liste_ıd and Listeler.Kullanıcı_Id = (select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS           =@kullanıcı_Kontrol) and Doktors.Doktor_Id=@Doktor_ID_kontrol) ))begin set @kont_5=1; print @kont_5 end if (@kont_1=1)and (@kont_2=1) and (@kont_3=1) and (@kont_4=1) and (@kont_5=1) begin insert into Ziyaret_Detay(Cins, Doktor_Id, Ziyaret_Durumu, Kullanıcı_Id, Ziy_Gnl_Id) values(0, @doktorıd_2, 0, (select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS           = @kullanıcı_2),(select ID from Ziyaret_Genel where Ziyaret_Genel.Kullanıcı_ID = (select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS           = @kullanıcı_7) and Ziy_Tar = @ziyretar_2)); update Ziyaret_Genel set Ziy_Edilecek_Doktor = Ziy_Edilecek_Doktor + 1 where Ziyaret_Genel.ID = (select ID from Ziyaret_Genel where Ziyaret_Genel.Kullanıcı_ID = (select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS           = @kullanıcı_11) and Ziy_Tar = @ziyretar_6); select 2;insert into Ziyaret_Detay(Cins, Doktor_Id, Ziyaret_Durumu, Kullanıcı_Id, Ziy_Gnl_Id) values(0, @doktorıd_3, 0, (select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS           = @kullanıcı_3),(select ID from Ziyaret_Genel where Ziyaret_Genel.Kullanıcı_ID = (select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS           = @kullanıcı_8) and Ziy_Tar = @ziyretar_3)); update Ziyaret_Genel set Ziy_Edilecek_Doktor = Ziy_Edilecek_Doktor + 1 where Ziyaret_Genel.ID = (select ID from Ziyaret_Genel where Ziyaret_Genel.Kullanıcı_ID = (select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS           = @kullanıcı_12) and Ziy_Tar = @ziyretar_7); select 2;    insert into Ziyaret_Detay(Cins, Doktor_Id, Ziyaret_Durumu, Kullanıcı_Id, Ziy_Gnl_Id) values(0, @doktorıd_4, 0, (select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS           = @kullanıcı_4),(select ID from Ziyaret_Genel where Ziyaret_Genel.Kullanıcı_ID = (select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS           = @kullanıcı_9) and Ziy_Tar = @ziyretar_4)); update Ziyaret_Genel set Ziy_Edilecek_Doktor = Ziy_Edilecek_Doktor + 1 where Ziyaret_Genel.ID = (select ID from Ziyaret_Genel where Ziyaret_Genel.Kullanıcı_ID = (select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS           = @kullanıcı_13) and Ziy_Tar = @ziyretar_8); select 2;    insert into Ziyaret_Detay(Cins, Doktor_Id, Ziyaret_Durumu, Kullanıcı_Id, Ziy_Gnl_Id) values(0, @doktorıd_5, 0, (select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS           = @kullanıcı_6),(select ID from Ziyaret_Genel where Ziyaret_Genel.Kullanıcı_ID = (select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS           = @kullanıcı_10) and Ziy_Tar = @ziyretar_5)); update Ziyaret_Genel set Ziy_Edilecek_Doktor = Ziy_Edilecek_Doktor + 1 where Ziyaret_Genel.ID = (select ID from Ziyaret_Genel where Ziyaret_Genel.Kullanıcı_ID = (select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS           = @kullanıcı_14) and Ziy_Tar = @ziyretar_9); select 2;  " +
                    "end; " +
                    "end; " +
                    "else " +
                    "begin " +
                    "select 5; " +
                    "end; " +
                    "";


                var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
                var cmd = new SqlCommand(queryWithForJson, conn);



                cmd.Parameters.AddWithValue("@kullanıcı_gelen_1", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd.Parameters.AddWithValue("@doktorıd_gelen_1", Doktor_ID);//@kullanıcı
                cmd.Parameters.AddWithValue("@Ziyaret_Tar_ılk", Tar_1);
                cmd.Parameters.AddWithValue("@kullanıcı_gelen_2", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd.Parameters.AddWithValue("@doktorıd_gelen_2", Doktor_ID);
                cmd.Parameters.AddWithValue("@Ziyaret_Tar_ıkıncı", Tar_2);
                cmd.Parameters.AddWithValue("@kullanıcı_gelen_3", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd.Parameters.AddWithValue("@doktorıd_gelen_3", Doktor_ID);
                cmd.Parameters.AddWithValue("@Ziyaret_Tar_ucuncu", Tar_3);
                cmd.Parameters.AddWithValue("@kullanıcı_gelen_4", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd.Parameters.AddWithValue("@doktorıd_gelen_4", Doktor_ID);
                cmd.Parameters.AddWithValue("@Ziyaret_Tar_dorduncu", Tar_4);
                cmd.Parameters.AddWithValue("@kullanıcı_Kontrol", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd.Parameters.AddWithValue("@Doktor_ID_kontrol", Doktor_ID);
                cmd.Parameters.AddWithValue("@gelenziyaret_1", Tar_3);
                cmd.Parameters.AddWithValue("@gelenziyaret_2", Tar_3);
                cmd.Parameters.AddWithValue("@kullanıcı_Kontrol_2", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd.Parameters.AddWithValue("@Doktor_ID_kontrol_1", Doktor_ID);
                cmd.Parameters.AddWithValue("@doktorıd_2", Doktor_ID);
                cmd.Parameters.AddWithValue("@kullanıcı_2", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd.Parameters.AddWithValue("@kullanıcı_7", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd.Parameters.AddWithValue("@ziyretar_2", Tar_1);
                cmd.Parameters.AddWithValue("@kullanıcı_11", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd.Parameters.AddWithValue("@ziyretar_6", Tar_1);
                cmd.Parameters.AddWithValue("@doktorıd_3", Doktor_ID);
                cmd.Parameters.AddWithValue("@kullanıcı_3", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd.Parameters.AddWithValue("@kullanıcı_8", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd.Parameters.AddWithValue("@ziyretar_3", Tar_2);
                cmd.Parameters.AddWithValue("@kullanıcı_12", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd.Parameters.AddWithValue("@ziyretar_7", Tar_2);
                cmd.Parameters.AddWithValue("@doktorıd_4", Doktor_ID);
                cmd.Parameters.AddWithValue("@kullanıcı_4", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd.Parameters.AddWithValue("@kullanıcı_9", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd.Parameters.AddWithValue("@ziyretar_4", Tar_3);
                cmd.Parameters.AddWithValue("@kullanıcı_13", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd.Parameters.AddWithValue("@ziyretar_8", Tar_3);
                cmd.Parameters.AddWithValue("@doktorıd_5", Doktor_ID);
                cmd.Parameters.AddWithValue("@kullanıcı_6", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd.Parameters.AddWithValue("@kullanıcı_10", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd.Parameters.AddWithValue("@ziyretar_5", Tar_4);
                cmd.Parameters.AddWithValue("@kullanıcı_14", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd.Parameters.AddWithValue("@ziyretar_9", Tar_4);
                cmd.Parameters.AddWithValue("@Liste_ıd", parametre.Split('/')[parametre.Split('/').Length - 1]);




                conn.Open();

                var reader = cmd.ExecuteReader();


                while (reader.Read())
                {
                    a += reader.GetValue(0).ToString();
                }


                if (a == "")
                {
                    conn.Close();
                    return "0";
                }
                else
                {
                    if (a == "5")
                    {
                        conn.Close();
                        return "5";
                    }
                    else
                    {
                        conn.Close();
                        return "1";
                    }
                }

            }
            else
            {
                return "0";

            }



        }
        [System.Web.Services.WebMethod]
        public static string Yeni_Liste_Olustur_Listeler_Eczane(string parametre)
        {
            //select * from listeler where Kullanıcı_Id=(select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS          ='recai') and cins = 0
            var queryWithForJson = "use kasa select * from listeler where Kullanıcı_Id=(select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS          ='" + FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString() + "') and cins = 1 ";
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
            //select * from listeler where Kullanıcı_Id=(select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS          ='recai') and cins = 0
            var queryWithForJson = "use kasa select * from listeler where Kullanıcı_Id=(select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS          ='" + FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString() + "') and cins = 0 ";
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


        }//select Eczane.Eczane_Adı,Ziyaret_Detay.Eczane_Id,TownName,Ziyaret_Detay.Ziyaret_Durumu,format(Ziy_Tar,'dd'),Ziyaret_Detay.Cins,Ziyaret_Genel.Kullanıcı_ID     from Ziyaret_Detay inner join Ziyaret_Genel on Ziyaret_Detay.Ziy_Gnl_Id=Ziyaret_Genel.ID inner join Eczane on Eczane.Eczane_Id=Ziyaret_Detay.Eczane_Id  INNER JOIN Town ON  Eczane.Eczane_Brick = Town.TownID where Ziyaret_Genel.Kullanıcı_ID = (select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS          =@Kullanıcı_Adı) and Ziyaret_Genel.Ziy_Tar between @baslagıc_Tar and @bitis_tar

        [System.Web.Services.WebMethod]
        public static string Tabloları_Doldur_Eczane(string parametre)
        {
            string gelen_yıl = parametre.Split('-')[0];
            string gelen_ay = parametre.Split('-')[1];


            DateTime tarih = new DateTime(Convert.ToInt32(gelen_yıl), Convert.ToInt32(gelen_ay), 1);
            DateTime tarih_son_gün = new DateTime(Convert.ToInt32(gelen_yıl), Convert.ToInt32(gelen_ay), 1);


            tarih_son_gün = new DateTime(tarih_son_gün.Year, tarih_son_gün.Month, 1);



            DateTime tarih_Bu_ayın_ilk_gunu = new DateTime(tarih.Year, tarih.Month, 1);



            var queryWithForJson = "select Eczane.Eczane_Adı,Ziyaret_Detay.Eczane_Id,TownName,CityName,Ziyaret_Detay.Ziyaret_Durumu,format(Ziy_Tar,'dd'),Ziyaret_Detay.Cins,Ziyaret_Genel.Kullanıcı_ID,Ziy_Dty_ID,isnull((select  Eczane_Tip.Eczane_Tip from Eczane_Tip where Eczane_Tip.Eczane_Tip_Id=Eczane.Eczane_Tip),'Belirtilmemiş'),Silinemez     from Ziyaret_Detay  " +
                "  inner join Ziyaret_Genel on Ziyaret_Detay.Ziy_Gnl_Id=Ziyaret_Genel.ID " +
                " inner join Eczane on Eczane.Eczane_Id=Ziyaret_Detay.Eczane_Id " +
             
                " INNER JOIN Town ON  Eczane.Eczane_Brick = Town.TownID " +
                " inner join City on Town.CityID=City.CityID " +
                " where Ziyaret_Genel.Kullanıcı_ID = (select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS              =@Kullanıcı_Adı) and Ziyaret_Genel.Ziy_Tar between @baslagıc_Tar and @bitis_tar";
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
                a += reader.GetValue(0).ToString() + "/" + reader.GetValue(1).ToString() + "/" + reader.GetValue(2).ToString() + "/" + reader.GetValue(3).ToString() + "/" + reader.GetValue(4).ToString() + "/" + reader.GetValue(5).ToString() + "/" + reader.GetValue(6).ToString() + "/" + reader.GetValue(7).ToString() + "/" + reader.GetValue(8).ToString() + "/" + reader.GetValue(9).ToString() + "/" + reader.GetValue(10).ToString() + "!";
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



        [System.Web.Services.WebMethod]
        public static string Tabloları_Doldur(string parametre)
        {
            string gelen_yıl = parametre.Split('-')[0];
            string gelen_ay = parametre.Split('-')[1];


            DateTime tarih = new DateTime(Convert.ToInt32(gelen_yıl), Convert.ToInt32(gelen_ay), 1);
            DateTime tarih_son_gün = new DateTime(Convert.ToInt32(gelen_yıl), Convert.ToInt32(gelen_ay), 1);


            tarih_son_gün = new DateTime(tarih_son_gün.Year, tarih_son_gün.Month, 1);



            DateTime tarih_Bu_ayın_ilk_gunu = new DateTime(tarih.Year, tarih.Month, 1);



            var queryWithForJson = "SELECT Doktors.Doktor_Ad, Ziyaret_Detay.Doktor_Id,Brans_Txt,Unite.Unite_Txt,TownName,Ziyaret_Detay.Ziyaret_Durumu,format(Ziy_Tar,'dd'),Ziyaret_Detay.Cins,Ziyaret_Genel.Kullanıcı_ID ,Ziy_Dty_ID FROM Ziyaret_Detay INNER JOIN Ziyaret_Genel ON Ziyaret_Detay.Ziy_Gnl_Id = Ziyaret_Genel.ID INNER JOIN Doktors ON  Doktors.Doktor_Id = Ziyaret_Detay.Doktor_Id INNER JOIN Unite ON  Doktors.Doktor_Unite_ID = Unite.Unite_ID INNER JOIN Town ON  Unite.Brick__Id = Town.TownID INNER JOIN Branchs ON  Doktors.Doktor_Brans_Id = .Branchs.Brans_ID where Ziyaret_Genel.Kullanıcı_ID = (select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS              =@Kullanıcı_Adı) and Ziyaret_Genel.Ziy_Tar between @baslagıc_Tar and @bitis_tar";
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
                a += reader.GetValue(0).ToString() + "/" + reader.GetValue(1).ToString() + "/" + reader.GetValue(2).ToString() + "/" + reader.GetValue(3).ToString() + "/" + reader.GetValue(4).ToString() + "/" + reader.GetValue(5).ToString() + "/" + reader.GetValue(6).ToString() + "/" + reader.GetValue(7).ToString() + "/" + reader.GetValue(8).ToString() + "/" + reader.GetValue(9).ToString() + "!";
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
        public static string Ayrıkmı(string gelen)
        {
            string gelen_yıl = gelen.Split('-')[2];
            string gelen_ay = gelen.Split('-')[1];
            string gelen_gün = gelen.Split('-')[0];



            DateTime tarih_son_gün = new DateTime(Convert.ToInt32(gelen_yıl), Convert.ToInt32(gelen_ay), 1);



            tarih_son_gün = new DateTime(tarih_son_gün.Year, tarih_son_gün.Month, 1);

            DateTime tarih = new DateTime(Convert.ToInt32(gelen_yıl), Convert.ToInt32(gelen_ay), 1);
            DateTime tarih_Öncekiayın_son_gunu = new DateTime(tarih.Year, tarih.Month, 1);
            DateTime tarih_Bu_ayın_ilk_gunu = new DateTime(tarih.Year, tarih.Month, 1);



            string b = "";


            int hafta = 1;


            for (int i = 0; i < Convert.ToInt32(tarih_son_gün.AddMonths(1).AddDays(-1).ToString("dd")); i++)
            {
                tarih = new DateTime(Convert.ToInt32(gelen_yıl), Convert.ToInt32(gelen_ay), i + 1);
                if (tarih.ToString("dddd") == "Cumartesi")
                {

                    continue;

                }
                if (tarih.ToString("dddd") == "Pazar")
                {
                    b += "/";
                    hafta++;
                }
                else
                {
                    b += tarih.ToString("d-M-yyyy") + "!";

                }


            }


            string[] c = new string[b.Split('/').Length];


            for (int i = 0; i < b.Split('/').Length; i++)
            {
                c[i] = b.Split('/')[i];
            }




            string gidecek = "";
            for (int i = 0; i < c.Length; i++)
            {
                if (c[i].Split('!').Length < 6)
                {
                    gidecek += c[i];
                }
            }
            if (gidecek != "")
            {
                gidecek = gidecek.Substring(0, gidecek.Length - 1);
            }
            Console.WriteLine(gidecek);
            string kontrol = "False";
            for (int i = 0; i < gidecek.Split('!').Length; i++)
            {
                if (gidecek.Split('!')[i] == gelen_gün + "-" + gelen_ay + "-" + gelen_yıl)
                {
                    kontrol = "True";
                }
            }
            return kontrol;


        }


        [System.Web.Services.WebMethod]
        public static string Frekans_modal_Doldurma(string parametre)
        {

            string gelen_yıl = parametre.Split('-')[0];
            string gelen_ay = parametre.Split('-')[1];



            DateTime tarih_son_gün = new DateTime(Convert.ToInt32(gelen_yıl), Convert.ToInt32(gelen_ay), 1);



            tarih_son_gün = new DateTime(tarih_son_gün.Year, tarih_son_gün.Month, 1);

            DateTime tarih = new DateTime(Convert.ToInt32(gelen_yıl), Convert.ToInt32(gelen_ay), 1);
            DateTime tarih_Öncekiayın_son_gunu = new DateTime(tarih.Year, tarih.Month, 1);
            DateTime tarih_Bu_ayın_ilk_gunu = new DateTime(tarih.Year, tarih.Month, 1);




            string b = "";
            string x = "";

            int hafta = 1;


            for (int i = 0; i < Convert.ToInt32(tarih_son_gün.AddMonths(1).AddDays(-1).ToString("dd")); i++)
            {
                tarih = new DateTime(Convert.ToInt32(gelen_yıl), Convert.ToInt32(gelen_ay), i + 1);
                if (tarih.ToString("dddd") == "Cumartesi")
                {

                    continue;

                }
                if (tarih.ToString("dddd") == "Pazar")
                {
                    x += "/";
                    hafta++;
                }
                else
                {
                    x += tarih.ToString("d M yyyy") + "-" + tarih.ToString("d MMMM dddd") + "-" + hafta + "!";

                }


            }
            x = x.Substring(0, x.Length - 2);


            string gidecek = "";


            if (x[0] == '/')
            {
                for (int i = 1; i < x.Length - 1; i++)
                {
                    b += x[i];
                }
            }
            else
            {
                b = x;
            }

            string[] c = new string[b.Split('/').Length];

            for (int i = 0; i < c.Length; i++)
            {
                c[i] = b.Split('/')[i].Substring(0, b.Split('/')[i].Length - 1);
            }
            for (int i = 0; i < c.Length; i++)
            {

                for (int j = 0; j < c[i].Split('!').Length; j++)
                {
                    if (c[i].Split('!').Length < 5)
                    {
                        c[i] = "0";
                    }
                    else
                    {
                        gidecek += c[i].Split('!')[j] + "*";
                    }
                }
                if (c[i].Split('!').Length >= 5)
                {
                    gidecek += "/";
                }

            }
            gidecek = gidecek.Substring(0, gidecek.Length - 2);
            return gidecek;
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






        [System.Web.Services.WebMethod]
        public static string Haftanın_Gunleri(string parametre)
        {

            int sayaç = 0;
            string a = "";

            for (int i = 1; i < 29; i++)
            {
                DateTime dt = new DateTime(2021, Convert.ToInt32(parametre), i);
                if (dt.DayOfWeek == DayOfWeek.Saturday || dt.DayOfWeek == DayOfWeek.Sunday)
                {

                    continue;
                }

                else
                {
                    if (sayaç == 5)
                    {
                        a += "!";
                        sayaç = 0;
                    }
                    sayaç = sayaç + 1;
                    a += dt.ToString("d MMMM dddd") + "-";

                }

            }

            return a.Substring(0, a.Length - 1);
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
                if (!reader.HasRows)
                {
                    conn.Close();

                    return a;
                }
                else
                {
                    while (reader.Read())
                    {
                        a += reader.GetValue(0).ToString() + "-" + reader.GetValue(6).ToString() + "!";
                    }
                    return a.Substring(0, a.Length - 1);
                }



            }
            if (Convert.ToInt32(parametre.Split('-')[0]) == 3)
            {

                var queryWithForJson = "use kasa select Brans_ID,Brans_Txt from Unite_Branş_Liste   " +
                    "inner join Branchs  " +
                    " on Branchs.Brans_ID=Unite_Branş_Liste.Branş_Id " +
                    "" +
                    "where Unite_Id = " + parametre.Split('-')[1];
                var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
                var cmd = new SqlCommand(queryWithForJson, conn);

                conn.Open();

                var reader = cmd.ExecuteReader();

                string b = "";




                if (!reader.HasRows)
                {
                    conn.Close();
                    return "hata-Uniteye Kayıtlı Branş Bulunamadı-hata";
                }
                else
                {
                    while (reader.Read())
                    {

                        b += reader.GetValue(0).ToString() + "-" + reader.GetValue(1).ToString().Trim() + "!";

                    }
                    conn.Close();
                    return b.Substring(0, b.Length - 1);
                }










            }
            if (Convert.ToInt32(parametre.Split('-')[0]) == 4)
            {
                try
                {


                    var queryWithForJson = "use kasa SELECT  Doktors.Doktor_Id, Doktor_Ad ,Doktor_Brans ,Unite_Txt,TownName,CityName,Doktor_Liste.Frekans,Doktor_Liste_Id  FROM Doktor_Liste  " +
                        "INNER JOIN Listeler ON Doktor_Liste.Liste_Id=Listeler.Liste_Id INNER JOIN Doktors ON Doktor_Liste.Doktor_ıd=Doktors.Doktor_Id " +
                        "INNER JOIN Unite ON Doktors.Doktor_Unite_ID=Unite_ID INNER JOIN Town ON TownID=Unite.Brick__Id " +
                        "INNER JOIN City ON City.CityID=Town.CityID " +
                        "Where Listeler.Liste_Id= " + parametre.Split('-')[2] + " and Listeler.cins = 0 and Doktor_Liste.Silinmismi=0 and  Doktor_Brans_Id=" + parametre.Split('-')[1];
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
                        return "hata-Listenize Kayıtlı Doktor Bulunamadı-hata";
                    }
                    else
                    {
                        conn.Close();
                        return a.Substring(0, a.Length - 1);
                    }
                }
                catch (Exception)
                {

                    return "hata-Listenize Kayıtlı Doktor Bulunamadı-hata";
                }





            }
            if (Convert.ToInt32(parametre.Split('-')[0]) == 5)
            {

                var queryWithForJson = "" +
                    "select Eczane.Eczane_Id,Frekans,Eczane_Adı from Eczane_Liste " +
                    " inner join Eczane " +
                    "  on Eczane_liste.Eczane_Id=Eczane.Eczane_Id  " +
                    "  inner join Listeler " +
                    " on Eczane_Liste.Liste_Id=Listeler.Liste_Id " +
                    "  where Listeler.Liste_Id=@Liste_Id and Eczane.Eczane_Brick= @Brick and Kullanıcı_Id=(select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS              =@Kullanıcı_Adı) and Eczane_Liste.Silinmismi=0" +
                    "";
                var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
                var cmd = new SqlCommand(queryWithForJson, conn);
                cmd.Parameters.AddWithValue("@Brick", parametre.Split('-')[1]);
                cmd.Parameters.AddWithValue("@Liste_Id", parametre.Split('-')[2]);
                cmd.Parameters.AddWithValue("@Kullanıcı_Adı", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                conn.Open();

                var reader = cmd.ExecuteReader();

                string a = "";

                if (!reader.HasRows)
                {
                    conn.Close();
                    return a;
                }
                else
                {
                    while (reader.Read())
                    {
                        a += reader.GetValue(0).ToString() + "-" + reader.GetValue(1).ToString() + "-" + reader.GetValue(2).ToString() + "!";
                    }
                    conn.Close();
                    return a.Substring(0, a.Length - 1);
                }





            }

            return "asd";

            //}


            //catch (Exception)
            //{
            //    return "Bir hata oluştu";

            //}
        }
        //public static string Return_Brans(string a) {




        //}

        [System.Web.Services.WebMethod]
        public static string Frekans_Gunleri(string parametre)
        {


            string gelen_yıl = parametre.Split('-')[0];
            string gelen_ay = parametre.Split('-')[1];



            DateTime tarih_son_gün = new DateTime(Convert.ToInt32(gelen_yıl), Convert.ToInt32(gelen_ay), 1);



            tarih_son_gün = new DateTime(tarih_son_gün.Year, tarih_son_gün.Month, 1);

            DateTime tarih = new DateTime(Convert.ToInt32(gelen_yıl), Convert.ToInt32(gelen_ay), 1);
            DateTime tarih_Öncekiayın_son_gunu = new DateTime(tarih.Year, tarih.Month, 1);
            DateTime tarih_Bu_ayın_ilk_gunu = new DateTime(tarih.Year, tarih.Month, 1);



            string b = "";


            int hafta = 1;


            for (int i = 0; i < Convert.ToInt32(tarih_son_gün.AddMonths(1).AddDays(-1).ToString("dd")); i++)
            {
                tarih = new DateTime(Convert.ToInt32(gelen_yıl), Convert.ToInt32(gelen_ay), i + 1);
                if (tarih.ToString("dddd") == "Cumartesi")
                {

                    continue;

                }
                if (tarih.ToString("dddd") == "Pazar")
                {
                    b += "/";
                    hafta++;
                }
                else
                {
                    b += tarih.ToString("d MMMM dddd") + "-" + hafta + "!";

                }


            }

            return b.Substring(0, b.Length - 1);
        }


    }

}