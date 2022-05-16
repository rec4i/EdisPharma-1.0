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
using static deneme9.Tsm_Sipariş_Raporu;

namespace deneme9
{
    public partial class Sipariş_Rapor_KMY : System.Web.UI.Page
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

            Reques = Request.QueryString["Tsm"];
            Reques = Request.QueryString["Bolge"];

            if (Reques != null)
            {
                string Bas_Tar = Request.QueryString["x"];
                string Bit_Tar = Request.QueryString["y"];
                string TSM = Request.QueryString["z"];

                string Kullanıcı_Listesi = Request.QueryString["Tsm"];
                string Bölge_Listesi = Request.QueryString["Bolge"];


                var Kullanıcı_Düzenlenmiş = "{Kullanıcı_Listesi__:" + Kullanıcı_Listesi + "}";
                var Bölge_Düzenlenmiş = "{Bölge_Listesi__:" + Bölge_Listesi + "}";


                DataSet Kullanıcı_Listesi_dataset = JsonConvert.DeserializeObject<DataSet>(Kullanıcı_Düzenlenmiş);
                DataTable Kullanıcı_Listesi_datatable = Kullanıcı_Listesi_dataset.Tables["Kullanıcı_Listesi__"];

                DataSet Bölge_Listesi_dataset = JsonConvert.DeserializeObject<DataSet>(Bölge_Düzenlenmiş);
                DataTable Bölge_Listesi_datatable = Bölge_Listesi_dataset.Tables["Bölge_Listesi__"];


                //---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
                SqlCommand cmd11 = new SqlCommand(" " +
                  "use kasa  " +
                  "" +
                  "" +
                     "" +
                "  declare @Tüm_Kullanıcılar table(Id int)  " +
                "" +
                " insert into @Tüm_Kullanıcılar select * from @Kullanıcı_Table    " +
                "  insert into @Tüm_Kullanıcılar select KullanıcıID from Kullanıcı where Kullanıcı_Bogle in(select * from @Bölge_Table)  " +
                "" +
                  "" +
                  " " +

                  "select DISTINCT CAST(tar as date) as Ziy_Tar  from Sipariş_Genel where Olusturan_Kullanıcı in ( select  * from  @Tüm_Kullanıcılar) and CAST(tar as date) between @Bas_Tar and @Bit_Tar  " +
                  "", SqlC.con);


                string a = FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString();
                cmd11.Parameters.AddWithValue("@Kullanıcı_Ad", TSM);
                cmd11.Parameters.AddWithValue("@Gonderen_Kullanıcı", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd11.Parameters.AddWithValue("@Bas_Tar", Bas_Tar);
                cmd11.Parameters.AddWithValue("@Bit_Tar", Bit_Tar);


                SqlParameter tvpParam3 = cmd11.Parameters.AddWithValue("@Bölge_Table", Bölge_Listesi_datatable);
                tvpParam3.SqlDbType = SqlDbType.Structured;
                tvpParam3.TypeName = "dbo.Geçmiş_Sorgu_Semt";



                SqlParameter tvpParam4 = cmd11.Parameters.AddWithValue("@Kullanıcı_Table", Kullanıcı_Listesi_datatable);
                tvpParam4.SqlDbType = SqlDbType.Structured;
                tvpParam4.TypeName = "dbo.Geçmiş_Sorgu_Semt";





                SqlDataAdapter sda11 = new SqlDataAdapter(cmd11);
                DataTable dt11 = new DataTable();
                sda11.Fill(dt11);
                Repeater1.DataSource = dt11;
                Repeater1.DataBind();
                SqlC.con.Close();

            }

        }
        //public class Kullanıcı_Liste
        //{
        //    public string Ad { get; set; }
        //    public string Soyad { get; set; }
        //    public string Kullanıcı_ID { get; set; }


        //}
        [System.Web.Services.WebMethod]
        public static string Kullanıcı_Listesi_Searcy(string Harf)
        {
            var queryWithForJson = "use kasa  " +
                "select AD,Soyad,KullanıcıID from Kullanıcı where Kullanıcı.Kullanıcı_Grup=4 and   Kullanıcı.Kullanıcı_Bogle!=0 and AD+' '+Soyad like '%'+@Harf+'%'  ";

            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);
            conn.Open();
            cmd.Parameters.AddWithValue("@Kullanıcı_Ad", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
            cmd.Parameters.AddWithValue("@Harf", Harf);



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
        class Bolgeler
        {
            public string Bolge_Id { get; set; }
            public string Bolge_Ad { get; set; }

        }

        [System.Web.Services.WebMethod]
        public static string Bölge_Listesi_Searcy(string Harf)
        {
            var queryWithForJson = "use kasa  " +
                "select Bolge_Id,Bolge_Ad from Bolgeler where Bolge_Ad like '%'+@Harf+'%' ";

            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);
            conn.Open();
            cmd.Parameters.AddWithValue("@Kullanıcı_Ad", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
            cmd.Parameters.AddWithValue("@Harf", Harf);



            List<Bolgeler> tablo_Doldur_Classes = new List<Bolgeler>();


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
                    var Tablo_Doldur_Class_ = new Bolgeler
                    {
                        Bolge_Id = reader.GetValue(0).ToString(),
                        Bolge_Ad = reader.GetValue(1).ToString(),


                    };
                    tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
                }
            }
            conn.Close();
            return JsonConvert.SerializeObject(tablo_Doldur_Classes);


        }
        [System.Web.Services.WebMethod]
        public static string Kullanıcı_Listesi(string Şehir_Id)
        {
            var queryWithForJson = "use kasa  " +
                "select AD,Soyad,KullanıcıID from Kullanıcı where Kullanıcı.Kullanıcı_Grup=4 and   Kullanıcı.Kullanıcı_Bogle!=0 ";

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

        [System.Web.Services.WebMethod]
        public static string Tabloları_Doldur(string parametre, string İletim_Durum, string Ürün_Listesi, string Bölge_Listesi, string Kullanıcı_Listesi)
        {

            DataSet İletim_Durum_dataset = JsonConvert.DeserializeObject<DataSet>(İletim_Durum);
            DataTable İletim_Durum_datatable = İletim_Durum_dataset.Tables["İletim_Durum__"];

            DataSet Ürün_Listesi_dataset = JsonConvert.DeserializeObject<DataSet>(Ürün_Listesi);
            DataTable Ürün_Listesi_datatable = Ürün_Listesi_dataset.Tables["Ürün_Listesi__"];


            DataSet Kullanıcı_Listesi_dataset = JsonConvert.DeserializeObject<DataSet>(Kullanıcı_Listesi);
            DataTable Kullanıcı_Listesi_datatable = Kullanıcı_Listesi_dataset.Tables["Kullanıcı_Listesi__"];

            DataSet Bölge_Listesi_dataset = JsonConvert.DeserializeObject<DataSet>(Bölge_Listesi);
            DataTable Bölge_Listesi_datatable = Bölge_Listesi_dataset.Tables["Bölge_Listesi__"];



            string gelen_yıl = parametre.Split('*')[0];
            string gelen_ay = parametre.Split('*')[1];
            string Kullanıcı = parametre.Split('*')[2];
            var queryWithForJson = "" +
                "" +
                "" +
                "  declare @Tüm_Kullanıcılar table(Id int)  " +
                "" +
                " insert into @Tüm_Kullanıcılar select * from @Kullanıcı_Table    " +
                "  insert into @Tüm_Kullanıcılar select KullanıcıID from Kullanıcı where Kullanıcı_Bogle in(select * from @Bölge_Table)  " +
                "" +
                "" +
                " select  " +
                "                cast(Tar as date),  " +
                "				" +
                "                Urun_Adı ,  " +
                "                Adet, " +
                "                Mf_Adet, " +
                "                (Adet+Mf_Adet) as Toplam_Adet, " +
                "                ((Adet*Guncel_DSF)/((case when (Adet+Mf_Adet) = 0 then 1 else (Adet+Mf_Adet) end)))as Birim_Fiyat, " +
                "                ((Adet*Guncel_DSF)/((case when (Adet+Mf_Adet) = 0 then 1 else (Adet+Mf_Adet) end))*(Adet+Mf_Adet))as Birim_Fiyat_Toplam, " +
                "                Guncel_DSF, " +
                "                Guncel_ISF, " +
                "                KDV_Guncel_PSF, " +
                "                Eczane_Adı, " +
                "                Eczacı_Adı, " +
                "                CityName,  " +
                "                 TownName , " +
                "                 İletim_Durum ," +
                "                Sipariş_Genel.Siparis_Genel_Id  , " +
                "" +
                "                 ( select sum((Adet*Guncel_DSF)/((case when (Adet+Mf_Adet) = 0 then 1 else (Adet+Mf_Adet) end))*(Adet+Mf_Adet))  from Siparis_Detay  " +
                "                inner join Urunler " +
                "                 on Siparis_Detay.Urun_Id=Urunler.Urun_Id  " +
                "" +
                    " inner join @Urun_table " +
                    " on (select(case when (Semt is  null) then Urunler.Urun_Id else Semt  end))=Urunler.Urun_Id " +
                "" +
                "                where  Siparis_Detay.Siparis_Genel_Id=Sipariş_Genel.Siparis_Genel_Id " +
                "" +
                "" +

                "" +
                "), " +
                "" +

                "" +
                "" +
                "				 ( select sum((Adet*Guncel_ISF))  from Siparis_Detay  " +
                "                inner join Urunler " +
                "                 on Siparis_Detay.Urun_Id=Urunler.Urun_Id  " +
                "" +
                   " inner join @Urun_table " +
                    " on (select(case when (Semt is  null) then Urunler.Urun_Id else Semt  end))=Urunler.Urun_Id " +
                "" +
                "                where  Siparis_Detay.Siparis_Genel_Id=Sipariş_Genel.Siparis_Genel_Id " +
                "" +
                "" +

                ") " +
                "" +
                "" +
                "		  " +
                "                from Siparis_Detay " +
                "                inner join Sipariş_Genel " +
                "                on Siparis_Detay.Siparis_Genel_Id=Sipariş_Genel.Siparis_Genel_Id " +
                "                inner join Eczane " +
                "                on Sipariş_Genel.Eczane_Id=Eczane.Eczane_Id " +
                "                inner join Urunler " +
                "                on Siparis_Detay.Urun_Id=Urunler.Urun_Id " +
                "                inner join City  " +
                "                on Eczane.Eczane_Il=CityID " +
                "                inner join Town " +
                "                on Eczane.Eczane_Brick=TownID " +
                  " inner join @İletim_table " +
                    " on (select(case when (Şehir_ is  null) then İletim_Durum else Şehir_  end))=İletim_Durum " +

                     " inner join @Urun_table " +
                    " on (select(case when (Semt is  null) then Urunler.Urun_Id else Semt  end))=Urunler.Urun_Id " +

                    "where Sipariş_Genel.Olusturan_Kullanıcı in ( select  * from  @Tüm_Kullanıcılar)  and Tar between @baslagıc_Tar and @bitis_tar " +

                "";


            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);
            conn.Open();
            cmd.Parameters.AddWithValue("@Kullanıcı_Adı", Kullanıcı);//@baslagıc_Tar//@bitis_tar
            cmd.Parameters.AddWithValue("@baslagıc_Tar", gelen_yıl);
            cmd.Parameters.AddWithValue("@bitis_tar", gelen_ay);

            SqlParameter tvpParam1 = cmd.Parameters.AddWithValue("@İletim_table", İletim_Durum_datatable);
            tvpParam1.SqlDbType = SqlDbType.Structured;
            tvpParam1.TypeName = "dbo.Geçmiş_Sorgu_Şehir";


            SqlParameter tvpParam2 = cmd.Parameters.AddWithValue("@Urun_table", Ürün_Listesi_datatable);
            tvpParam2.SqlDbType = SqlDbType.Structured;
            tvpParam2.TypeName = "dbo.Geçmiş_Sorgu_Semt";


            SqlParameter tvpParam3 = cmd.Parameters.AddWithValue("@Bölge_Table", Bölge_Listesi_datatable);
            tvpParam3.SqlDbType = SqlDbType.Structured;
            tvpParam3.TypeName = "dbo.Geçmiş_Sorgu_Semt";



            SqlParameter tvpParam4 = cmd.Parameters.AddWithValue("@Kullanıcı_Table", Kullanıcı_Listesi_datatable);
            tvpParam4.SqlDbType = SqlDbType.Structured;
            tvpParam4.TypeName = "dbo.Geçmiş_Sorgu_Semt";

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
                        Ziy_Tar = reader.GetDateTime(0).ToString("yyyy-MM-dd"),
                        Urun_Adı = reader.GetValue(1).ToString(),
                        Adet = reader.GetValue(2).ToString(),
                        Mf_Adet = reader.GetValue(3).ToString(),
                        Toplam_Adet = reader.GetValue(4).ToString(),
                        Birim_Fiyat = reader.GetDecimal(5).ToString("0.##"),
                        Birim_Fiyat_Toplam = reader.GetDecimal(6).ToString("0.##"),
                        Guncel_DSF = reader.GetDecimal(7).ToString("0.##"),
                        Guncel_ISF = reader.GetDecimal(8).ToString("0.##"),
                        KDV_Guncel_PSF = reader.GetDecimal(9).ToString("0.##"),
                        Eczane_Adı = reader.GetValue(10).ToString(),
                        Eczacı_Adı = reader.GetValue(11).ToString(),
                        CityName = reader.GetValue(12).ToString(),
                        TownName = reader.GetValue(13).ToString(),
                        İletim_Durum = reader.GetValue(14).ToString(),
                        Siparis_Detay_Id = reader.GetValue(15).ToString(),
                        Genel_Birim_Fiyat_Toplam = reader.GetDecimal(16).ToString("0.##"),
                        Adet_İSF = (Convert.ToDecimal(reader.GetValue(2)) * Convert.ToDecimal(reader.GetDecimal(8).ToString("0.##"))).ToString("0.##"),
                        Toplam_Adet_İSF = reader.GetDecimal(17).ToString("0.##")

                    };
                    tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
                }
            }


            //  IEnumerable < Ziy_Onay_Tablo > tablo_Doldur_Classes_ = from x in tablo_Doldur_Classes where x.Ad == "10" select x;


            string a = JsonConvert.SerializeObject(from item in tablo_Doldur_Classes group item by item.Siparis_Detay_Id);

            conn.Close();
            return a;
            //return JsonConvert.SerializeObject(tablo_Doldur_Classes);


        }


        public class Günlük_Satış_Veris_Tablo
        {
            public string Ziy_Tar { get; set; }
            public string Tutar { get; set; }

        }
        [System.Web.Services.WebMethod]
        public static string Günlük_Satış_Verisi(string parametre, string İletim_Durum, string Ürün_Listesi, string Bölge_Listesi, string Kullanıcı_Listesi)
        {



            DataSet İletim_Durum_dataset = JsonConvert.DeserializeObject<DataSet>(İletim_Durum);
            DataTable İletim_Durum_datatable = İletim_Durum_dataset.Tables["İletim_Durum__"];

            DataSet Ürün_Listesi_dataset = JsonConvert.DeserializeObject<DataSet>(Ürün_Listesi);
            DataTable Ürün_Listesi_datatable = Ürün_Listesi_dataset.Tables["Ürün_Listesi__"];


            DataSet Kullanıcı_Listesi_dataset = JsonConvert.DeserializeObject<DataSet>(Kullanıcı_Listesi);
            DataTable Kullanıcı_Listesi_datatable = Kullanıcı_Listesi_dataset.Tables["Kullanıcı_Listesi__"];

            DataSet Bölge_Listesi_dataset = JsonConvert.DeserializeObject<DataSet>(Bölge_Listesi);
            DataTable Bölge_Listesi_datatable = Bölge_Listesi_dataset.Tables["Bölge_Listesi__"];

            string gelen_yıl = parametre.Split('*')[0];
            string gelen_ay = parametre.Split('*')[1];
            string Kullanıcı = parametre.Split('*')[2];
            var queryWithForJson = "" +
                "" +
                "" +
                 "  declare @Tüm_Kullanıcılar table(Id int)  " +
                "" +
                " insert into @Tüm_Kullanıcılar select * from @Kullanıcı_Table    " +
                "  insert into @Tüm_Kullanıcılar select KullanıcıID from Kullanıcı where Kullanıcı_Bogle in(select * from @Bölge_Table)  " +
                "" +
                "" +
                "" +
            " declare @Günlük_Satış_Verisi table( Sipariş_Genel_ID_ bigint, Tutar decimal(15,5))  " +
            "" +
            "  declare @Günlük_Satış_Verisi_ table( Tar date, Tutar decimal(15,5))  " +
            "            " +
            "                 insert into @Günlük_Satış_Verisi   " +
            "                 select  " +
            "                                 Sipariş_Genel.Siparis_Genel_Id , " +
            "             " +
            "               " +
            "               				 ( select sum((Adet*Guncel_ISF))  from Siparis_Detay   " +
            "                               inner join Urunler  " +
            "                                on Siparis_Detay.Urun_Id=Urunler.Urun_Id   " +
            "" +
              " inner join @Urun_table " +
                    " on (select(case when (Semt is  null) then Urunler.Urun_Id else Semt  end))=Urunler.Urun_Id " +
            "" +
            "                               where  Siparis_Detay.Siparis_Genel_Id=Sipariş_Genel.Siparis_Genel_Id ) as deneme  " +
            "               		  " +
            "                               from Siparis_Detay  " +
            "                               inner join Sipariş_Genel  " +
            "                             on Siparis_Detay.Siparis_Genel_Id=Sipariş_Genel.Siparis_Genel_Id    " +

               " inner join @İletim_table " +
                    " on (select(case when (Şehir_ is  null) then İletim_Durum else Şehir_  end))=İletim_Durum " +

                     " inner join @Urun_table " +
                    " on (select(case when (Semt is  null) then Urun_Id else Semt  end))=Urun_Id " +

            "            " +
            "      where Sipariş_Genel.Olusturan_Kullanıcı in (select * from @Tüm_Kullanıcılar)  and Tar between @baslagıc_Tar and @bitis_tar  group by Sipariş_Genel.Siparis_Genel_Id  " +
            "             " +
            "               insert into @Günlük_Satış_Verisi_  " +
            "" +
            "                select  (select cast(Tar as date) from Sipariş_Genel where Sipariş_Genel.Siparis_Genel_Id=Sipariş_Genel_ID_),Tutar from @Günlük_Satış_Verisi   " +
            "" +
            "" +
            "" +
            "" +
            "				select Tar,SUM(Tutar)  from @Günlük_Satış_Verisi_ group by Tar " +
            "";



            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);
            conn.Open();
            cmd.Parameters.AddWithValue("@Kullanıcı_Adı", Kullanıcı);//@baslagıc_Tar//@bitis_tar
            cmd.Parameters.AddWithValue("@baslagıc_Tar", gelen_yıl);
            cmd.Parameters.AddWithValue("@bitis_tar", gelen_ay);


            SqlParameter tvpParam1 = cmd.Parameters.AddWithValue("@İletim_table", İletim_Durum_datatable);
            tvpParam1.SqlDbType = SqlDbType.Structured;
            tvpParam1.TypeName = "dbo.Geçmiş_Sorgu_Şehir";


            SqlParameter tvpParam2 = cmd.Parameters.AddWithValue("@Urun_table", Ürün_Listesi_datatable);
            tvpParam2.SqlDbType = SqlDbType.Structured;
            tvpParam2.TypeName = "dbo.Geçmiş_Sorgu_Semt";



            SqlParameter tvpParam3 = cmd.Parameters.AddWithValue("@Bölge_Table", Bölge_Listesi_datatable);
            tvpParam3.SqlDbType = SqlDbType.Structured;
            tvpParam3.TypeName = "dbo.Geçmiş_Sorgu_Semt";



            SqlParameter tvpParam4 = cmd.Parameters.AddWithValue("@Kullanıcı_Table", Kullanıcı_Listesi_datatable);
            tvpParam4.SqlDbType = SqlDbType.Structured;
            tvpParam4.TypeName = "dbo.Geçmiş_Sorgu_Semt";

            List<Günlük_Satış_Veris_Tablo> tablo_Doldur_Classes = new List<Günlük_Satış_Veris_Tablo>();


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

                    var Tablo_Doldur_Class_ = new Günlük_Satış_Veris_Tablo
                    {
                        Ziy_Tar = reader.GetDateTime(0).ToString("yyyy-MM-dd"),
                        Tutar = reader.GetDecimal(1).ToString("0.##"),
                    };
                    tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
                }
            }


            //  IEnumerable < Ziy_Onay_Tablo > tablo_Doldur_Classes_ = from x in tablo_Doldur_Classes where x.Ad == "10" select x;


            string a = JsonConvert.SerializeObject(tablo_Doldur_Classes);

            conn.Close();
            return a;
            //return JsonConvert.SerializeObject(tablo_Doldur_Classes);


        }



        [System.Web.Services.WebMethod]
        public static string Günlük_Satış_Verisi_Toplam(string parametre, string İletim_Durum, string Ürün_Listesi, string Bölge_Listesi, string Kullanıcı_Listesi)
        {

            DataSet İletim_Durum_dataset = JsonConvert.DeserializeObject<DataSet>(İletim_Durum);
            DataTable İletim_Durum_datatable = İletim_Durum_dataset.Tables["İletim_Durum__"];

            DataSet Ürün_Listesi_dataset = JsonConvert.DeserializeObject<DataSet>(Ürün_Listesi);
            DataTable Ürün_Listesi_datatable = Ürün_Listesi_dataset.Tables["Ürün_Listesi__"];


            DataSet Kullanıcı_Listesi_dataset = JsonConvert.DeserializeObject<DataSet>(Kullanıcı_Listesi);
            DataTable Kullanıcı_Listesi_datatable = Kullanıcı_Listesi_dataset.Tables["Kullanıcı_Listesi__"];

            DataSet Bölge_Listesi_dataset = JsonConvert.DeserializeObject<DataSet>(Bölge_Listesi);
            DataTable Bölge_Listesi_datatable = Bölge_Listesi_dataset.Tables["Bölge_Listesi__"];


            string gelen_yıl = parametre.Split('*')[0];
            string gelen_ay = parametre.Split('*')[1];
            string Kullanıcı = parametre.Split('*')[2];
            var queryWithForJson = "" +
                "" +
                  "  declare @Tüm_Kullanıcılar table(Id int)  " +
                "" +
                " insert into @Tüm_Kullanıcılar select * from @Kullanıcı_Table    " +
                "  insert into @Tüm_Kullanıcılar select KullanıcıID from Kullanıcı where Kullanıcı_Bogle in(select * from @Bölge_Table)  " +
                "" +
                "" +
                "" +
                " declare @Günlük_Satış_Verisi table( Tar int  , Tutar decimal(15,5)) " +
                " " +
                " insert into @Günlük_Satış_Verisi  " +
                " select  " +
                "                 Sipariş_Genel.Siparis_Genel_Id, " +
                "			" +
                "" +
                "				 ( select sum((Adet*Guncel_ISF))  from Siparis_Detay  " +
                "                inner join Urunler " +
                "                 on Siparis_Detay.Urun_Id=Urunler.Urun_Id  " +
                "" +
                  " inner join @Urun_table " +
                    " on (select(case when (Semt is  null) then Urunler.Urun_Id else Semt  end))=Urunler.Urun_Id " +
                "" +
                "                where  Siparis_Detay.Siparis_Genel_Id=Sipariş_Genel.Siparis_Genel_Id ) as deneme " +
                "		  " +
                "                from Siparis_Detay " +
                "                inner join Sipariş_Genel " +
                "                on Siparis_Detay.Siparis_Genel_Id=Sipariş_Genel.Siparis_Genel_Id " +
                "             " +

                   " inner join @İletim_table " +
                    " on (select(case when (Şehir_ is  null) then İletim_Durum else Şehir_  end))=İletim_Durum " +

                     " inner join @Urun_table " +
                    " on (select(case when (Semt is  null) then Urun_Id else Semt  end))=Urun_Id " +

                "             " +
              "where Sipariş_Genel.Olusturan_Kullanıcı in (select * from @Tüm_Kullanıcılar)  and Tar between @baslagıc_Tar and @bitis_tar   group by Sipariş_Genel.Siparis_Genel_Id  " +
                "" +
                "" +
                "" +
                "select  sum(Tutar) from @Günlük_Satış_Verisi  " +
                "";



            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);
            conn.Open();
            cmd.Parameters.AddWithValue("@Kullanıcı_Adı", Kullanıcı);//@baslagıc_Tar//@bitis_tar
            cmd.Parameters.AddWithValue("@baslagıc_Tar", gelen_yıl);
            cmd.Parameters.AddWithValue("@bitis_tar", gelen_ay);


            SqlParameter tvpParam1 = cmd.Parameters.AddWithValue("@İletim_table", İletim_Durum_datatable);
            tvpParam1.SqlDbType = SqlDbType.Structured;
            tvpParam1.TypeName = "dbo.Geçmiş_Sorgu_Şehir";


            SqlParameter tvpParam2 = cmd.Parameters.AddWithValue("@Urun_table", Ürün_Listesi_datatable);
            tvpParam2.SqlDbType = SqlDbType.Structured;
            tvpParam2.TypeName = "dbo.Geçmiş_Sorgu_Semt";




            SqlParameter tvpParam3 = cmd.Parameters.AddWithValue("@Bölge_Table", Bölge_Listesi_datatable);
            tvpParam3.SqlDbType = SqlDbType.Structured;
            tvpParam3.TypeName = "dbo.Geçmiş_Sorgu_Semt";



            SqlParameter tvpParam4 = cmd.Parameters.AddWithValue("@Kullanıcı_Table", Kullanıcı_Listesi_datatable);
            tvpParam4.SqlDbType = SqlDbType.Structured;
            tvpParam4.TypeName = "dbo.Geçmiş_Sorgu_Semt";




            List<Günlük_Satış_Veris_Tablo> tablo_Doldur_Classes = new List<Günlük_Satış_Veris_Tablo>();


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

                    var Tablo_Doldur_Class_ = new Günlük_Satış_Veris_Tablo
                    {
                        Ziy_Tar = "1",
                        Tutar = (reader.GetValue(0).ToString() == "" ? "0" : reader.GetDecimal(0).ToString("0.##")).ToString(), // reader.GetDecimal(0).ToString("0.##"),
                    };
                    tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
                }
            }


            //  IEnumerable < Ziy_Onay_Tablo > tablo_Doldur_Classes_ = from x in tablo_Doldur_Classes where x.Ad == "10" select x;


            string a = JsonConvert.SerializeObject(tablo_Doldur_Classes);

            conn.Close();
            return a;
            //return JsonConvert.SerializeObject(tablo_Doldur_Classes);


        }


        public class Çalışılan_Urun_Getir_Tablo
        {
            public string Adet { get; set; }
            public string Urun_Adı { get; set; }


        }
        [System.Web.Services.WebMethod]
        public static string Çalışılan_Urun_Getir(string parametre, string Bölge_Listesi, string Kullanıcı_Listesi)


        {
            DataSet Kullanıcı_Listesi_dataset = JsonConvert.DeserializeObject<DataSet>(Kullanıcı_Listesi);
            DataTable Kullanıcı_Listesi_datatable = Kullanıcı_Listesi_dataset.Tables["Kullanıcı_Listesi__"];

            DataSet Bölge_Listesi_dataset = JsonConvert.DeserializeObject<DataSet>(Bölge_Listesi);
            DataTable Bölge_Listesi_datatable = Bölge_Listesi_dataset.Tables["Bölge_Listesi__"];





            string gelen_yıl = parametre.Split('*')[0];
            string gelen_ay = parametre.Split('*')[1];
            string Kullanıcı = parametre.Split('*')[2];

            var queryWithForJson = "" +
                "" +
                               "  declare @Tüm_Kullanıcılar table(Id int)  " +
                "" +
                " insert into @Tüm_Kullanıcılar select * from @Kullanıcı_Table    " +
                "  insert into @Tüm_Kullanıcılar select KullanıcıID from Kullanıcı where Kullanıcı_Bogle in(select * from @Bölge_Table)  " +
                "" +
                "" +
                "" +
                "" +
                "select COUNT(Ziyaret_Calışılan_Urunler.Calışılan_Urun_Id ),Urun_Adı from Ziyaret_Detay " +
            "" +
            "" +
            "inner join Ziyaret_Genel " +
            "on Ziyaret_Detay.Ziy_Gnl_Id=Ziyaret_Genel.ID " +
            "" +
            "inner join Ziyaret_Calışılan_Urunler " +
            "on Ziyaret_Detay.Ziy_Dty_ID=Ziyaret_Calışılan_Urunler.Ziyaret_Detay_Id " +
            "" +
            "inner join Urunler " +
            "on Urunler.Urun_Id=Ziyaret_Calışılan_Urunler.Calışılan_Urun_Id " +
            "" +
            "where Ziyaret_Genel.Kullanıcı_ID in (select *  from @Tüm_Kullanıcılar )  and Ziy_Tar between @baslagıc_Tar and @bitis_tar " +
            "" +
            "group by Urun_Adı ";






            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);
            conn.Open();
            cmd.Parameters.AddWithValue("@Kullanıcı_Adı", Kullanıcı);//@baslagıc_Tar//@bitis_tar
            cmd.Parameters.AddWithValue("@baslagıc_Tar", gelen_yıl);
            cmd.Parameters.AddWithValue("@bitis_tar", gelen_ay);



            SqlParameter tvpParam3 = cmd.Parameters.AddWithValue("@Bölge_Table", Bölge_Listesi_datatable);
            tvpParam3.SqlDbType = SqlDbType.Structured;
            tvpParam3.TypeName = "dbo.Geçmiş_Sorgu_Semt";



            SqlParameter tvpParam4 = cmd.Parameters.AddWithValue("@Kullanıcı_Table", Kullanıcı_Listesi_datatable);
            tvpParam4.SqlDbType = SqlDbType.Structured;
            tvpParam4.TypeName = "dbo.Geçmiş_Sorgu_Semt";


            List<Çalışılan_Urun_Getir_Tablo> tablo_Doldur_Classes = new List<Çalışılan_Urun_Getir_Tablo>();


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
                    var Tablo_Doldur_Class_ = new Çalışılan_Urun_Getir_Tablo
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



        public class Farklı_Eczanelerin_Sayısı_Tablo
        {
            public string Eczane_Sayısı { get; set; }

        }
        [System.Web.Services.WebMethod]
        public static string Farklı_Eczanelerin_Sayısı(string parametre, string İletim_Durum, string Ürün_Listesi, string Bölge_Listesi, string Kullanıcı_Listesi)
        {

            DataSet İletim_Durum_dataset = JsonConvert.DeserializeObject<DataSet>(İletim_Durum);
            DataTable İletim_Durum_datatable = İletim_Durum_dataset.Tables["İletim_Durum__"];

            DataSet Ürün_Listesi_dataset = JsonConvert.DeserializeObject<DataSet>(Ürün_Listesi);
            DataTable Ürün_Listesi_datatable = Ürün_Listesi_dataset.Tables["Ürün_Listesi__"];


            DataSet Kullanıcı_Listesi_dataset = JsonConvert.DeserializeObject<DataSet>(Kullanıcı_Listesi);
            DataTable Kullanıcı_Listesi_datatable = Kullanıcı_Listesi_dataset.Tables["Kullanıcı_Listesi__"];

            DataSet Bölge_Listesi_dataset = JsonConvert.DeserializeObject<DataSet>(Bölge_Listesi);
            DataTable Bölge_Listesi_datatable = Bölge_Listesi_dataset.Tables["Bölge_Listesi__"];





            string gelen_yıl = parametre.Split('*')[0];
            string gelen_ay = parametre.Split('*')[1];
            string Kullanıcı = parametre.Split('*')[2];
            var queryWithForJson = "" +
                "" +
                                    "  declare @Tüm_Kullanıcılar table(Id int)  " +
                "" +
                " insert into @Tüm_Kullanıcılar select * from @Kullanıcı_Table    " +
                "  insert into @Tüm_Kullanıcılar select KullanıcıID from Kullanıcı where Kullanıcı_Bogle in(select * from @Bölge_Table)  " +
                "" +
                "" +
                "" +
                "" +
                "select COUNT(DISTINCT  Eczane_Id) from Sipariş_Genel " +
                "" +
                " inner join Siparis_Detay" +
                " on Siparis_Detay.Siparis_Genel_Id=Sipariş_Genel.Siparis_Genel_Id  " +

                            "                               inner join Urunler  " +
            "                                on Siparis_Detay.Urun_Id=Urunler.Urun_Id   " +
                "" +

                       " inner join @İletim_table " +
                    " on (select(case when (Şehir_ is  null) then İletim_Durum else Şehir_  end))=İletim_Durum " +



                     " inner join @Urun_table " +
                    " on (select(case when (Semt is  null) then Siparis_Detay.Urun_Id else Semt  end))=Siparis_Detay.Urun_Id " +


                "  where Tar Between @Bas_Tar and @Bit_Tar and Olusturan_Kullanıcı in (select *  from @Tüm_Kullanıcılar )  " +
                "" +

            "";



            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);
            conn.Open();
            cmd.Parameters.AddWithValue("@Kullanıcı_Adı", Kullanıcı);//@baslagıc_Tar//@bitis_tar
            cmd.Parameters.AddWithValue("@Bas_Tar", gelen_yıl);
            cmd.Parameters.AddWithValue("@Bit_Tar", gelen_ay);

            SqlParameter tvpParam1 = cmd.Parameters.AddWithValue("@İletim_table", İletim_Durum_datatable);
            tvpParam1.SqlDbType = SqlDbType.Structured;
            tvpParam1.TypeName = "dbo.Geçmiş_Sorgu_Şehir";


            SqlParameter tvpParam2 = cmd.Parameters.AddWithValue("@Urun_table", Ürün_Listesi_datatable);
            tvpParam2.SqlDbType = SqlDbType.Structured;
            tvpParam2.TypeName = "dbo.Geçmiş_Sorgu_Semt";




            SqlParameter tvpParam3 = cmd.Parameters.AddWithValue("@Bölge_Table", Bölge_Listesi_datatable);
            tvpParam3.SqlDbType = SqlDbType.Structured;
            tvpParam3.TypeName = "dbo.Geçmiş_Sorgu_Semt";



            SqlParameter tvpParam4 = cmd.Parameters.AddWithValue("@Kullanıcı_Table", Kullanıcı_Listesi_datatable);
            tvpParam4.SqlDbType = SqlDbType.Structured;
            tvpParam4.TypeName = "dbo.Geçmiş_Sorgu_Semt";

            List<Farklı_Eczanelerin_Sayısı_Tablo> tablo_Doldur_Classes = new List<Farklı_Eczanelerin_Sayısı_Tablo>();


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

                    var Tablo_Doldur_Class_ = new Farklı_Eczanelerin_Sayısı_Tablo
                    {
                        Eczane_Sayısı = reader.GetValue(0).ToString(),
                    };
                    tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
                }
            }


            //  IEnumerable < Ziy_Onay_Tablo > tablo_Doldur_Classes_ = from x in tablo_Doldur_Classes where x.Ad == "10" select x;


            string a = JsonConvert.SerializeObject(tablo_Doldur_Classes);

            conn.Close();
            return a;
            //return JsonConvert.SerializeObject(tablo_Doldur_Classes);


        }




        public class Farklı_Eczanelerin_Sayısı_Ad_Getir_Tablo
        {
            public string Eczane_Adı { get; set; }
            public string Eczane_Tarihi { get; set; }
            public string İl { get; set; }
            public string İlçe { get; set; }
            public string Tutar { get; set; }
        }

        [System.Web.Services.WebMethod]
        public static string Farklı_Eczanelerin_Sayısı_Ad_Getir(string parametre, string İletim_Durum, string Ürün_Listesi, string Bölge_Listesi, string Kullanıcı_Listesi)
        {

            DataSet İletim_Durum_dataset = JsonConvert.DeserializeObject<DataSet>(İletim_Durum);
            DataTable İletim_Durum_datatable = İletim_Durum_dataset.Tables["İletim_Durum__"];

            DataSet Ürün_Listesi_dataset = JsonConvert.DeserializeObject<DataSet>(Ürün_Listesi);
            DataTable Ürün_Listesi_datatable = Ürün_Listesi_dataset.Tables["Ürün_Listesi__"];


            DataSet Kullanıcı_Listesi_dataset = JsonConvert.DeserializeObject<DataSet>(Kullanıcı_Listesi);
            DataTable Kullanıcı_Listesi_datatable = Kullanıcı_Listesi_dataset.Tables["Kullanıcı_Listesi__"];

            DataSet Bölge_Listesi_dataset = JsonConvert.DeserializeObject<DataSet>(Bölge_Listesi);
            DataTable Bölge_Listesi_datatable = Bölge_Listesi_dataset.Tables["Bölge_Listesi__"];


            string gelen_yıl = parametre.Split('*')[0];
            string gelen_ay = parametre.Split('*')[1];
            string Kullanıcı = parametre.Split('*')[2];
            var queryWithForJson = "" +

                "" +
                "" +
                "" +
                                      "  declare @Tüm_Kullanıcılar table(Id int)  " +
                "" +
                " insert into @Tüm_Kullanıcılar select * from @Kullanıcı_Table    " +
                "  insert into @Tüm_Kullanıcılar select KullanıcıID from Kullanıcı where Kullanıcı_Bogle in(select * from @Bölge_Table)  " +
                "" +
                "" +
                "" +
                "" +
                "select   Eczane_Adı,Eczacı_Adı,TownName,CityName,sum(Adet*Guncel_ISF)" +
                "	" +
                "	from Sipariş_Genel      " +
                "    inner join Eczane    " +
                "    on Eczane.Eczane_Id=Sipariş_Genel.Eczane_Id    " +
                "" +
                "	inner join Siparis_Detay" +
                "	on Sipariş_Genel.Siparis_Genel_Id=Siparis_Detay.Siparis_Genel_Id" +
                "" +
                "	inner join Urunler " +
                "	on Urunler.Urun_Id=Siparis_Detay.Urun_Id" +
                "" +
                "	inner join City " +
                "	on CityID=Eczane.Eczane_Il" +
                "" +
                "	inner join Town" +
                "	on TownID=Eczane.Eczane_Brick" +


                        " inner join @İletim_table " +
                    " on (select(case when (Şehir_ is  null) then İletim_Durum else Şehir_  end))=İletim_Durum " +



                     " inner join @Urun_table " +
                    " on (select(case when (Semt is  null) then Siparis_Detay.Urun_Id else Semt  end))=Siparis_Detay.Urun_Id " +
                "" +
                "" +
                "" +
                "    where Tar Between @Bas_Tar and @Bit_Tar and Olusturan_Kullanıcı in (select * from @Tüm_Kullanıcılar) group by Eczacı_Adı, Eczane_Adı,TownName,CityName order by sum(Adet*Guncel_ISF) desc" +
                "";



            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);
            conn.Open();
            cmd.Parameters.AddWithValue("@Kullanıcı_Adı", Kullanıcı);//@baslagıc_Tar//@bitis_tar
            cmd.Parameters.AddWithValue("@Bas_Tar", gelen_yıl);
            cmd.Parameters.AddWithValue("@Bit_Tar", gelen_ay);


            SqlParameter tvpParam1 = cmd.Parameters.AddWithValue("@İletim_table", İletim_Durum_datatable);
            tvpParam1.SqlDbType = SqlDbType.Structured;
            tvpParam1.TypeName = "dbo.Geçmiş_Sorgu_Şehir";


            SqlParameter tvpParam2 = cmd.Parameters.AddWithValue("@Urun_table", Ürün_Listesi_datatable);
            tvpParam2.SqlDbType = SqlDbType.Structured;
            tvpParam2.TypeName = "dbo.Geçmiş_Sorgu_Semt";


            SqlParameter tvpParam3 = cmd.Parameters.AddWithValue("@Bölge_Table", Bölge_Listesi_datatable);
            tvpParam3.SqlDbType = SqlDbType.Structured;
            tvpParam3.TypeName = "dbo.Geçmiş_Sorgu_Semt";



            SqlParameter tvpParam4 = cmd.Parameters.AddWithValue("@Kullanıcı_Table", Kullanıcı_Listesi_datatable);
            tvpParam4.SqlDbType = SqlDbType.Structured;
            tvpParam4.TypeName = "dbo.Geçmiş_Sorgu_Semt";


            List<Farklı_Eczanelerin_Sayısı_Ad_Getir_Tablo> tablo_Doldur_Classes = new List<Farklı_Eczanelerin_Sayısı_Ad_Getir_Tablo>();


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

                    var Tablo_Doldur_Class_ = new Farklı_Eczanelerin_Sayısı_Ad_Getir_Tablo
                    {
                        Eczane_Adı = reader.GetValue(0).ToString(),
                        Eczane_Tarihi = reader.GetValue(1).ToString(),
                        İlçe = reader.GetValue(2).ToString(),
                        İl = reader.GetValue(3).ToString(),
                        Tutar = reader.GetValue(4).ToString(),
                    };
                    tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
                }
            }


            //  IEnumerable < Ziy_Onay_Tablo > tablo_Doldur_Classes_ = from x in tablo_Doldur_Classes where x.Ad == "10" select x;


            string a = JsonConvert.SerializeObject(tablo_Doldur_Classes);

            conn.Close();
            return a;
            //return JsonConvert.SerializeObject(tablo_Doldur_Classes);


        }
        public class Satılan_Urunler_Adet_Mf_Adet_Tablo
        {
            public string Mf_Adet { get; set; }
            public string Adet { get; set; }
            public string Urun_Adı { get; set; }


        }
        [System.Web.Services.WebMethod]
        public static string Satılan_Urunler_Adet_Mf_Adet(string parametre, string İletim_Durum, string Ürün_Listesi, string Bölge_Listesi, string Kullanıcı_Listesi)


        {

            DataSet İletim_Durum_dataset = JsonConvert.DeserializeObject<DataSet>(İletim_Durum);
            DataTable İletim_Durum_datatable = İletim_Durum_dataset.Tables["İletim_Durum__"];

            DataSet Ürün_Listesi_dataset = JsonConvert.DeserializeObject<DataSet>(Ürün_Listesi);
            DataTable Ürün_Listesi_datatable = Ürün_Listesi_dataset.Tables["Ürün_Listesi__"];


            DataSet Kullanıcı_Listesi_dataset = JsonConvert.DeserializeObject<DataSet>(Kullanıcı_Listesi);
            DataTable Kullanıcı_Listesi_datatable = Kullanıcı_Listesi_dataset.Tables["Kullanıcı_Listesi__"];

            DataSet Bölge_Listesi_dataset = JsonConvert.DeserializeObject<DataSet>(Bölge_Listesi);
            DataTable Bölge_Listesi_datatable = Bölge_Listesi_dataset.Tables["Bölge_Listesi__"];


            string gelen_yıl = parametre.Split('*')[0];
            string gelen_ay = parametre.Split('*')[1];
            string Kullanıcı = parametre.Split('*')[2];

            var queryWithForJson = "" +
                "" +
                                                  "  declare @Tüm_Kullanıcılar table(Id int)  " +
                "" +
                " insert into @Tüm_Kullanıcılar select * from @Kullanıcı_Table    " +
                "  insert into @Tüm_Kullanıcılar select KullanıcıID from Kullanıcı where Kullanıcı_Bogle in(select * from @Bölge_Table)  " +
                "" +
                "" +
                       "  select sum(Mf_Adet),sum(Adet),Urun_Adı from Siparis_Detay    " +
        "                    " +
        "                    " +
        "                  inner join Sipariş_Genel    " +
        "                   on Siparis_Detay.Siparis_Genel_Id=Sipariş_Genel.Siparis_Genel_Id    " +
        "                 inner join Urunler     " +
        "                 on Urunler.Urun_Id=Siparis_Detay.Urun_Id    " +
        "" +
        " inner join @İletim_table " +
        " on (select(case when (Şehir_ is  null) then İletim_Durum else Şehir_  end))=İletim_Durum " +
           " inner join @Urun_table " +
                    " on (select(case when (Semt is  null) then Siparis_Detay.Urun_Id else Semt  end))=Siparis_Detay.Urun_Id " +
        "                    " +
        "                        where Sipariş_Genel.Olusturan_Kullanıcı in (select * from @Tüm_Kullanıcılar) and Tar between @baslagıc_Tar and @bitis_tar     " +
        "					 " +
        "                 group by Urun_Adı    " +
        "";






            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);
            conn.Open();
            cmd.Parameters.AddWithValue("@Kullanıcı_Adı", Kullanıcı);//@baslagıc_Tar//@bitis_tar
            cmd.Parameters.AddWithValue("@baslagıc_Tar", gelen_yıl);
            cmd.Parameters.AddWithValue("@bitis_tar", gelen_ay);



            SqlParameter tvpParam1 = cmd.Parameters.AddWithValue("@İletim_table", İletim_Durum_datatable);
            tvpParam1.SqlDbType = SqlDbType.Structured;
            tvpParam1.TypeName = "dbo.Geçmiş_Sorgu_Şehir";


            SqlParameter tvpParam2 = cmd.Parameters.AddWithValue("@Urun_table", Ürün_Listesi_datatable);
            tvpParam2.SqlDbType = SqlDbType.Structured;
            tvpParam2.TypeName = "dbo.Geçmiş_Sorgu_Semt";


            SqlParameter tvpParam3 = cmd.Parameters.AddWithValue("@Bölge_Table", Bölge_Listesi_datatable);
            tvpParam3.SqlDbType = SqlDbType.Structured;
            tvpParam3.TypeName = "dbo.Geçmiş_Sorgu_Semt";



            SqlParameter tvpParam4 = cmd.Parameters.AddWithValue("@Kullanıcı_Table", Kullanıcı_Listesi_datatable);
            tvpParam4.SqlDbType = SqlDbType.Structured;
            tvpParam4.TypeName = "dbo.Geçmiş_Sorgu_Semt";


            List<Satılan_Urunler_Adet_Mf_Adet_Tablo> tablo_Doldur_Classes = new List<Satılan_Urunler_Adet_Mf_Adet_Tablo>();


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
                    var Tablo_Doldur_Class_ = new Satılan_Urunler_Adet_Mf_Adet_Tablo
                    {
                        Mf_Adet = reader.GetValue(0).ToString(),
                        Adet = reader.GetValue(1).ToString(),
                        Urun_Adı = reader.GetValue(2).ToString(),
                    };
                    tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
                }
            }
            conn.Close();
            return JsonConvert.SerializeObject(tablo_Doldur_Classes);


        }
    }

}