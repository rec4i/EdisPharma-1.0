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
    public partial class Ziyaret_Planı : System.Web.UI.Page
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
            try
            {

                if (Request.QueryString["x"] != null)
                {
                    string gelen_yıl = Request.QueryString["x"].Split('-')[0];
                    string gelen_ay = Request.QueryString["x"].Split('-')[1];

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
                            "select * from Ziyaret_Genel where Kullanıcı_ID=(select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS =@kullanıcı) and Ziy_Tar  between @Ayın_Ilk_Gunu_parse and @Ayın_Son_Gunu_parse; " +
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
            catch (Exception)
            {
                Response.Redirect("/default.aspx");
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

        public class Günler_Ve_Haftaları
        {
            public string Hafta { get; set; }
            public string Gün { get; set; }

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





            string x = "";

            int hafta = 1;

            List<Günler_Ve_Haftaları> Haftalar_VE_Günleri_List = new List<Günler_Ve_Haftaları>();

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
                    var Günler_Ve_Haftaları = new Günler_Ve_Haftaları
                    {
                        Hafta = hafta.ToString(),
                        Gün = tarih.ToString("d MM yyyy")
                    };

                    Haftalar_VE_Günleri_List.Add(Günler_Ve_Haftaları);
                }


            }



            var resurlt = from denme in Haftalar_VE_Günleri_List group denme by denme.Hafta into egroup orderby egroup.Key select egroup;

            return JsonConvert.SerializeObject(resurlt);
        }
        [System.Web.Services.WebMethod]
        public static string Doktor_Ziyaret_Oluştur_Tekli(string Doktor_Listesi, string Ziyaret_Id)
        {

            try
            {
                DataSet dataSet = JsonConvert.DeserializeObject<DataSet>(Doktor_Listesi);

                DataTable dataTable = dataSet.Tables["Deneme"];







                var queryWithForJson = " " +
                "" +
                "" +
                "" +
                "declare @a int= 0 ;" +
                "declare @Kullanıcı_Id_K int=(select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS   = @Kullanıcı_Id) " +
                "" +
                "" +
                //--Kontrol Kısımı(o günde başka o doktor eklenmişmi diye kontrol ediliyor)
                "if  exists(select * from Ziyaret_Detay where Ziy_Gnl_Id in (select ID  from Ziyaret_Genel where ID = (@Ziyaret_Id) and Doktor_Id in (select  Doktor_Id_ from @Doktor_Listesi) )) " +
                "begin ; " +
                "select 0; " +
                "end; " +
                "else " +
                "begin; " +
                "" +
                "" +
                "" +
                //-- Ekleme Kısmı (Bütün günleri tek tek ekliyor)
                "insert  into Ziyaret_Detay(Cins , Doktor_Id, Ziyaret_Durumu, Kullanıcı_Id, Ziy_Gnl_Id) " +
                "select 0,Doktor_Id_,0,(@Kullanıcı_Id_K),(@Ziyaret_Id) from @Doktor_Listesi " +
                "select 1; " +
                "end; ";



                var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
                var cmd = new SqlCommand(queryWithForJson, conn);
                cmd.Parameters.AddWithValue("@Kullanıcı_Id", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd.Parameters.AddWithValue("@Ziyaret_Id", Ziyaret_Id);

                SqlParameter tvpParam = cmd.Parameters.AddWithValue("@Doktor_Listesi", dataTable);
                tvpParam.SqlDbType = SqlDbType.Structured;
                tvpParam.TypeName = "dbo.Doktor_Ziyaret_Tablosu";

                conn.Open();
                List<Durum_Kont> tablo_Doldur_Classes = new List<Durum_Kont>();
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
                        var Tablo_Doldur_Class_ = new Durum_Kont
                        {
                            Durum = reader.GetValue(0).ToString(),
                        };
                        tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
                    }
                }
                conn.Close();
                return JsonConvert.SerializeObject(tablo_Doldur_Classes);
            }
            catch (Exception ex)
            {
                List<Durum_Kont> tablo_Doldur_Classes_ = new List<Durum_Kont>();

                var Tablo_Doldur_Class_ = new Durum_Kont
                {
                    Durum = ex.ToString(),
                };
                tablo_Doldur_Classes_.Add(Tablo_Doldur_Class_);
                return JsonConvert.SerializeObject(tablo_Doldur_Classes_);

            }

          
        }


        public class Durum_Kont
        {
            public string Durum { get; set; }

        }
        [System.Web.Services.WebMethod]
        public static string Ziyaret_Sil(string Tarih,string Cins)
        {





            var queryWithForJson = "delete from Ziyaret_Detay where Ziy_Dty_ID in( select Ziy_Dty_ID from Ziyaret_Detay inner join Ziyaret_Genel on Ziy_Gnl_Id=Ziyaret_Genel.ID where Ziyaret_Detay.Cins=@Cins and Silinemez=0 and Ziy_Tar=@Ziy_Tar and Ziyaret_Genel.Kullanıcı_ID=(select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS   = @Kullanıcı_Id))";






            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);
            cmd.Parameters.AddWithValue("@Kullanıcı_Id", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
            cmd.Parameters.AddWithValue("@Ziy_Tar", Tarih);
            cmd.Parameters.AddWithValue("@Cins", Cins);


            conn.Open();
            List<Durum_Kont> tablo_Doldur_Classes = new List<Durum_Kont>();
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
                    var Tablo_Doldur_Class_ = new Durum_Kont
                    {
                        Durum = reader.GetValue(0).ToString(),
                    };
                    tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
                }
            }
            conn.Close();
            return JsonConvert.SerializeObject(tablo_Doldur_Classes);
        }
        [System.Web.Services.WebMethod]
        public static string Eczane_Ziyaret_Oluştur_Liste(string Liste_Id, string Tarih)
        {







            var queryWithForJson =
                "declare @Kullanıcı_Id_K int=(select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS   = @Kullanıcı_Id) " +
                  "" +
                  "" +
                "declare @Eczane_Listesi table( Eczane_Id_ int, Ziy_Tar_ date) " +
                 "insert into @Eczane_Listesi  (Eczane_Id_, Ziy_Tar_)  (select Eczane_Liste.Eczane_Id,@Ziy_Tar__ from Eczane_Liste inner join Listeler on Eczane_Liste.Liste_Id=Listeler.Liste_Id where Listeler.Liste_Id=@Liste_Id and Silinmismi=0 )" +

                  "if  exists(select * from Ziyaret_Detay where Ziyaret_Detay.Kullanıcı_Id=@Kullanıcı_Id_K and Ziy_Gnl_Id in (select ID  from Ziyaret_Genel where Ziy_Tar in(select Ziy_Tar_ from @Eczane_Listesi) and Eczane_Id in (select  Eczane_Id_ from @Eczane_Listesi) )) " +
                  "begin ;" +
                  "select 0; " +
                  "end; " +
                  "else " +
                  "begin; " +
                  "" +
                  "" +
                  "" +
                  "insert  into Ziyaret_Detay(Cins , Eczane_Id, Ziyaret_Durumu, Kullanıcı_Id, Ziy_Gnl_Id) " +
                  "select 1,Eczane_Id_,0,(@Kullanıcı_Id_K),(select ID  from Ziyaret_Genel where Ziy_Tar=Ziy_Tar_ and Kullanıcı_ID=@Kullanıcı_Id_K) from @Eczane_Listesi " +
                  "" +
                  "select 1; " +
                  "" +
                  "end; ";




            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);
            cmd.Parameters.AddWithValue("@Kullanıcı_Id", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
            cmd.Parameters.AddWithValue("@Ziy_Tar__", Tarih);
            cmd.Parameters.AddWithValue("@Liste_Id", Liste_Id);



            conn.Open();
            List<Durum_Kont> tablo_Doldur_Classes = new List<Durum_Kont>();
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
                    var Tablo_Doldur_Class_ = new Durum_Kont
                    {
                        Durum = reader.GetValue(0).ToString(),
                    };
                    tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
                }
            }
            conn.Close();
            return JsonConvert.SerializeObject(tablo_Doldur_Classes);
        }

        [System.Web.Services.WebMethod]
        public static string Doktor_Ziyaret_Oluştur_Liste(string Liste_Id, string Tarih)
        {









            var queryWithForJson = " " +
            "" +
            "" +
            "" +
            "declare @a int= 0 ;" +
            "declare @Kullanıcı_Id_K int=(select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS   = @Kullanıcı_Id) " +
            "declare @Doktor_Listesi table( Doktor_Id_ int, Ziy_Tar_ date) " +
            "insert into @Doktor_Listesi  (Doktor_Id_, Ziy_Tar_)  (select Doktor_Liste.Doktor_ıd,@Ziy_Tar__ from Doktor_Liste inner join Listeler on Doktor_Liste.Liste_Id=Listeler.Liste_Id where Listeler.Liste_Id=@Liste_Id and Silinmismi=0 )" +

            "if  exists(select * from Ziyaret_Detay where Ziyaret_Detay.Kullanıcı_Id=@Kullanıcı_Id_K and Ziy_Gnl_Id in (select ID  from Ziyaret_Genel where Ziy_Tar in(select Ziy_Tar_ from @Doktor_Listesi) and Doktor_Id in (select  Doktor_Id_ from @Doktor_Listesi) )) " +
            "begin ; " +
            "select 0; " +
            "end; " +
            "else " +
            "begin; " +
            "" +
            "" +
            "" +

            "insert  into Ziyaret_Detay(Cins , Doktor_Id, Ziyaret_Durumu, Kullanıcı_Id, Ziy_Gnl_Id) " +
            "select 0,Doktor_Id_,0,(@Kullanıcı_Id_K),(select ID  from Ziyaret_Genel where Ziy_Tar=Ziy_Tar_ and Kullanıcı_ID=@Kullanıcı_Id_K) from @Doktor_Listesi " +
            "select 1; " +
            "end; ";



            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);
            cmd.Parameters.AddWithValue("@Kullanıcı_Id", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
            cmd.Parameters.AddWithValue("@Ziy_Tar__", Tarih);
            cmd.Parameters.AddWithValue("@Liste_Id", Liste_Id);


            conn.Open();
            List<Durum_Kont> tablo_Doldur_Classes = new List<Durum_Kont>();
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
                    var Tablo_Doldur_Class_ = new Durum_Kont
                    {
                        Durum = reader.GetValue(0).ToString(),
                    };
                    tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
                }
            }
            conn.Close();
            return JsonConvert.SerializeObject(tablo_Doldur_Classes);
        }

        [System.Web.Services.WebMethod]
        public static string Doktor_Ziyaret_Oluştur(string Doktor_Listesi,string Sadece)
        {
            
                DataSet dataSet = JsonConvert.DeserializeObject<DataSet>(Doktor_Listesi);

                DataTable dataTable = dataSet.Tables["Deneme"];

             






                var queryWithForJson = " " +
                "" +
                "" +
                "" +
                "declare @a int= 0 ;" +
                "declare @Kullanıcı_Id_K int=(select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS   = @Kullanıcı_Id) " +
                "" +
                "" +

                " if  exists(select * from Ziyaret_Detay where Ziyaret_Detay.Kullanıcı_Id=@Kullanıcı_Id_K and Ziy_Gnl_Id in (select ID  from Ziyaret_Genel where ID in(select Ziy_Tar_ from @Doktor_Listesi) and Doktor_Id in (select  Doktor_Id_ from @Doktor_Listesi) )) " +
                "begin ; " +
                "select 0; " +
                "end; " +
                "else " +
                "begin; " +
                "" +
                "" +
                "if (@Sadece=0) " +
                "begin;" +
                
                "insert  into Ziyaret_Detay(Cins , Doktor_Id, Ziyaret_Durumu, Kullanıcı_Id, Ziy_Gnl_Id) " +
                "select 0,Doktor_Id_,0,(@Kullanıcı_Id_K),(Ziy_Tar_) from @Doktor_Listesi " +
                "select 1; " +
                "end;" +
                "else " +
                "begin;" +
                "if((  " +
                " select Onay_Durum from Ziyaret_Genel  " +
                " inner join Ziyaret_Onay  " +
                "on Ziyaret_Genel.Ziyaret_Onay_Id=Ziyaret_Onay.Ziyaret_Onay_Id  " +
                "where Ziyaret_Genel.ID=(select top 1 Ziy_Tar_ from @Doktor_Listesi)  " +
                " )=0) " +
                "begin ;" +
                 "insert  into Ziyaret_Detay(Cins , Doktor_Id, Ziyaret_Durumu, Kullanıcı_Id, Ziy_Gnl_Id) " +
                "select 0,Doktor_Id_,0,(@Kullanıcı_Id_K),(Ziy_Tar_) from @Doktor_Listesi " +
                "select 1; " +
                "end;" +
                " else " +
                "begin;" +
                "select 2;" +
                  "end;" +
                "end; " +
                " end;";



                var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
                var cmd = new SqlCommand(queryWithForJson, conn);
                cmd.Parameters.AddWithValue("@Kullanıcı_Id", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());

                cmd.Parameters.AddWithValue("@Sadece", Sadece);
                SqlParameter tvpParam = cmd.Parameters.AddWithValue("@Doktor_Listesi", dataTable);
                tvpParam.SqlDbType = SqlDbType.Structured;
                tvpParam.TypeName = "dbo.Doktor_Ziyaret_Tablosu";

                conn.Open();
                List<Durum_Kont> tablo_Doldur_Classes = new List<Durum_Kont>();
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
                        var Tablo_Doldur_Class_ = new Durum_Kont
                        {
                            Durum = reader.GetValue(0).ToString(),
                        };
                        tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
                    }
                }
                conn.Close();
                return JsonConvert.SerializeObject(tablo_Doldur_Classes);

            //}
            //catch (Exception ex)
            //{
            //    List<Durum_Kont> tablo_Doldur_Classes = new List<Durum_Kont>();
            //    var Tablo_Doldur_Class_ = new Durum_Kont
            //    {
            //        Durum = ex.ToString(),
            //    };
            //    tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
            //    return JsonConvert.SerializeObject(tablo_Doldur_Classes);
            //}
            
           
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
        public static string Eczane_Ziyaret_Oluştur(string Eczane_Listesi,string Sadece)
        {

            DataSet dataSet = JsonConvert.DeserializeObject<DataSet>(Eczane_Listesi);

            DataTable dataTable = dataSet.Tables["Deneme"];

            Console.WriteLine(dataTable.Rows.Count);



            var queryWithForJson = " " +
            "" +
            "" +
            "" +
            "declare @a int= 0 ;" +
            "declare @Kullanıcı_Id_K int=(select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS   = @Kullanıcı_Id) " +
            "" +
            "" +

            " if  exists(select * from Ziyaret_Detay where Ziyaret_Detay.Kullanıcı_Id=@Kullanıcı_Id_K and Ziy_Gnl_Id in (select ID  from Ziyaret_Genel where ID in(select Ziy_Tar_ from @Eczane_Listesi) and Eczane_Id in (select  Eczane_Id_ from @Eczane_Listesi) )) " +
            "begin ; " +
            "select 0; " +
            "end; " +
            "else " +
            "begin; " +
            "" +
            "" +
            "if (@Sadece=0) " +
            "begin;" +

            "insert  into Ziyaret_Detay(Cins , Eczane_Id, Ziyaret_Durumu, Kullanıcı_Id, Ziy_Gnl_Id) " +
            "select 1,Eczane_Id_,0,(@Kullanıcı_Id_K),(Ziy_Tar_) from @Eczane_Listesi " +
            "select 1; " +
            "end;" +
            "else " +
            "begin;" +
            "if((  " +
            " select Onay_Durum from Ziyaret_Genel  " +
            " inner join Ziyaret_Onay  " +
            "on Ziyaret_Genel.Ziyaret_Onay_Id=Ziyaret_Onay.Ziyaret_Onay_Id  " +
            "where Ziyaret_Genel.ID=(select top 1 Ziy_Tar_ from @Eczane_Listesi)  " +
            " )=0) " +
            "begin ;" +
             "insert  into Ziyaret_Detay(Cins , Eczane_Id, Ziyaret_Durumu, Kullanıcı_Id, Ziy_Gnl_Id) " +
            "select 1,Eczane_Id_,0,(@Kullanıcı_Id_K),(Ziy_Tar_) from @Eczane_Listesi " +
            "select 1; " +
            "end;" +
            " else " +
            "begin;" +
            "select 2;" +
              "end;" +
            "end; " +
            " end;";


            //var queryWithForJsona =
            //    "declare @Kullanıcı_Id_K int=(select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS   = @Kullanıcı_Id) " +
            //      "" +
            //      "" +
            //      "if  exists(select * from Ziyaret_Detay where Ziyaret_Detay.Kullanıcı_Id=@Kullanıcı_Id_K and Ziy_Gnl_Id in (select ID  from Ziyaret_Genel where Ziy_Tar in(select Ziy_Tar_ from @Eczane_Listesi) and Eczane_Id in (select  Eczane_Id_ from @Eczane_Listesi) )) " +
            //      "begin ;" +
            //      "select 0; " +
            //      "end; " +
            //      "else " +
            //      "begin; " +
            //      "" +
            //      "" +
            //      "" +
            //      "insert  into Ziyaret_Detay(Cins , Eczane_Id, Ziyaret_Durumu, Kullanıcı_Id, Ziy_Gnl_Id) " +
            //      "select 1,Eczane_Id_,0,(@Kullanıcı_Id_K),(select ID  from Ziyaret_Genel where Ziy_Tar=Ziy_Tar_ and Kullanıcı_ID=@Kullanıcı_Id_K) from @Eczane_Listesi " +
            //      "" +
            //      "select 1; " +
            //      "" +
            //      "end; ";




            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);
            cmd.Parameters.AddWithValue("@Kullanıcı_Id", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
            cmd.Parameters.AddWithValue("@Sadece", Sadece);

            SqlParameter tvpParam = cmd.Parameters.AddWithValue("@Eczane_Listesi", dataTable);
            tvpParam.SqlDbType = SqlDbType.Structured;
            tvpParam.TypeName = "dbo.Eczane_Ziyaret_Tablosu";

            conn.Open();
            List<Durum_Kont> tablo_Doldur_Classes = new List<Durum_Kont>();
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
                    var Tablo_Doldur_Class_ = new Durum_Kont
                    {
                        Durum = reader.GetValue(0).ToString(),
                    };
                    tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
                }
            }
            conn.Close();
            return JsonConvert.SerializeObject(tablo_Doldur_Classes);
        }
    }
}