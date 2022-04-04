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
    public partial class Tsm_Sipariş_Raporu : System.Web.UI.Page
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
                  "if((select Kullanıcı_Bogle from Kullanıcı where KullanıcıID=@Kullanıcı_Ad)=(select Kullanıcı_Bogle from Kullanıcı where KullanıcıAD COLLATE Latin1_general_CS_AS =@Gonderen_Kullanıcı )) " +
                  "begin; " +
                  "select DISTINCT CAST(tar as date) as Ziy_Tar  from Sipariş_Genel where Olusturan_Kullanıcı =@Kullanıcı_Ad and CAST(tar as date) between @Bas_Tar and @Bit_Tar  " +
                  "end;" +
                  "", SqlC.con);


                string a = FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString();
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

        //public class Birim_Fiyat_Tablo
        //{
        //    public string Birim_Fiyat { get; set; }
        //    public string Satış_Fiyatı_Toplam { get; set; }
        //    public string Birim_Fiyatı_Toplam { get; set; }


        //}
        //[System.Web.Services.WebMethod]
        //public static string Birim_Fiyat_Hesapla(string Guncel_DSF, string Adet, string Mf_Adet)
        //{




        //    double Birim_Fiyat_ = Convert.ToDouble((Convert.ToDouble(Guncel_DSF) * Convert.ToDouble(Adet)) / (Convert.ToDouble(Adet) + Convert.ToDouble(Mf_Adet)));



        //    var Tablo_Doldur_Class_ = new Birim_Fiyat_Tablo
        //    {
        //        Birim_Fiyat = Birim_Fiyat_.ToString("#.##"),
        //        Birim_Fiyatı_Toplam = (Birim_Fiyat_ * (Convert.ToDouble(Adet) + Convert.ToDouble(Mf_Adet))).ToString("#.##"),
        //        Satış_Fiyatı_Toplam = (Convert.ToDouble(Guncel_DSF) * (Convert.ToDouble(Adet) + Convert.ToDouble(Mf_Adet))).ToString("#.##"),

        //    };



        //    return JsonConvert.SerializeObject(Tablo_Doldur_Class_);



        //}

        public class Alerjen_Liste_Tablo
        {
            public string Id { get; set; }
            public string LastName { get; set; }

        }

        [System.Web.Services.WebMethod]
        public static string Sipariş_Durumu_Getir(string Harf)
        {
            if (FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString() == null)
            {
                return "DONT DO THİS AGAİN";
            }
            else
            {



                var queryWithForJson = "select İletim_Durum_Id,İletim_Durum from İletim_Durum where İletim_Durum like '%'+@Harf+'%' ";



                var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
                var cmd = new SqlCommand(queryWithForJson, conn);
                cmd.Parameters.AddWithValue("@Harf", Harf);
                conn.Open();



                List<Alerjen_Liste_Tablo> tablo_Doldur_Classes = new List<Alerjen_Liste_Tablo>();


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
                        var Tablo_Doldur_Class_ = new Alerjen_Liste_Tablo
                        {
                            Id = reader.GetValue(0).ToString(),
                            LastName = reader.GetValue(1).ToString(),

                        };
                        tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
                    }
                }
                conn.Close();
                return JsonConvert.SerializeObject(tablo_Doldur_Classes);
            }



        }

    

        [System.Web.Services.WebMethod]
        public static string Ürün_adı_Seç(string Harf)
        {
            if (FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString() == null)
            {
                return "DONT DO THİS AGAİN";
            }
            else
            {



                var queryWithForJson = "select Urun_Id,Urun_Adı from Urunler where Urun_Adı like '%'+@Harf+'%' ";



                var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
                var cmd = new SqlCommand(queryWithForJson, conn);
                cmd.Parameters.AddWithValue("@Harf", Harf);
                conn.Open();



                List<Alerjen_Liste_Tablo> tablo_Doldur_Classes = new List<Alerjen_Liste_Tablo>();


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
                        var Tablo_Doldur_Class_ = new Alerjen_Liste_Tablo
                        {
                            Id = reader.GetValue(0).ToString(),
                            LastName = reader.GetValue(1).ToString(),

                        };
                        tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
                    }
                }
                conn.Close();
                return JsonConvert.SerializeObject(tablo_Doldur_Classes);
            }



        }



        public class Birim_Fiyat__
        {
            public string Toplam { get; set; }
            public string Birim_Fiyat___ { get; set; }
            public string Satış_Fiyat { get; set; }
            public string Birim_Fiyat_Toplam { get; set; }
            public string Satış_Fiyat_Toplam { get; set; }
        }
        public static Birim_Fiyat__ Birim_Fiyat_(string Urun_Kar, string Urun_Fiyat, string Adet, string Mf_Adet)
        {

            double Urun_Fiyat_ = Convert.ToDouble(Urun_Fiyat);
            double Urun_Kar_ = Convert.ToDouble(Urun_Kar);
            double Adet_ = Convert.ToDouble(Adet);
            double Mf_Adet_ = Convert.ToDouble(Mf_Adet);



            double birimfiyat = (Convert.ToDouble(Urun_Fiyat_) / ((Convert.ToDouble(Urun_Kar_) / 100) + 1)) * (Convert.ToDouble(Adet_)) / (Convert.ToDouble(Mf_Adet_) + Convert.ToDouble(Adet_));

            string a = birimfiyat.ToString("#.##");

            var Tablo_Doldur_Class_ = new Birim_Fiyat__
            {
                Toplam = (Adet_ + Mf_Adet_).ToString(),
                Birim_Fiyat___ = a,
                Satış_Fiyat = Urun_Fiyat,
                Birim_Fiyat_Toplam = Convert.ToDouble(Convert.ToDouble(a) * Convert.ToDouble(Adet_ + Mf_Adet_)).ToString("#.#####"),
                Satış_Fiyat_Toplam = Convert.ToDouble(Convert.ToDouble(Urun_Fiyat_) * Convert.ToDouble(Adet_ + Mf_Adet_)).ToString("#.#####")

            };

            return Tablo_Doldur_Class_;



        }
        //public class Birim_Fiyat_Tablo
        //{
        //    public string Birim_Fiyat { get; set; }
        //    public string Satış_Fiyatı_Toplam { get; set; }
        //    public string Birim_Fiyatı_Toplam { get; set; }


        //}

        //[System.Web.Services.WebMethod]
        //public static Birim_Fiyat_Tablo Birim_Fiyat_Hesapla(string Guncel_DSF, string Adet, string Mf_Adet)
        //{




        //    double Birim_Fiyat_ = Convert.ToDouble((Convert.ToDouble(Guncel_DSF) * Convert.ToDouble(Adet)) / (Convert.ToDouble(Adet) + Convert.ToDouble(Mf_Adet)));



        //    var Tablo_Doldur_Class_ = new Birim_Fiyat_Tablo
        //    {
        //        Birim_Fiyat = Birim_Fiyat_.ToString("#.##"),
        //        Birim_Fiyatı_Toplam = (Birim_Fiyat_ * (Convert.ToDouble(Adet) + Convert.ToDouble(Mf_Adet))).ToString("#.##"),
        //        Satış_Fiyatı_Toplam = (Convert.ToDouble(Guncel_DSF) * (Convert.ToDouble(Adet) + Convert.ToDouble(Mf_Adet))).ToString("#.##"),

        //    };



        //    return Tablo_Doldur_Class_;



        //}

        public class Tabloları_Doldur_Doktor
        {
            public string Ziy_Tar { get; set; }
            public string Urun_Adı { get; set; }
            public string Adet { get; set; }
            public string Mf_Adet { get; set; }
            public string Toplam_Adet { get; set; }
            public string Birim_Fiyat { get; set; }
            public string Birim_Fiyat_Toplam { get; set; }
            public string Guncel_DSF { get; set; }
            public string Guncel_ISF { get; set; }
            public string KDV_Guncel_PSF { get; set; }
            public string Eczane_Adı { get; set; }
            public string Eczacı_Adı { get; set; }
            public string CityName { get; set; }
            public string TownName { get; set; }
            public string İletim_Durum { get; set; }
            public string Siparis_Detay_Id { get; set; }

            public string Genel_Birim_Fiyat_Toplam { get; set; }

            public string Adet_İSF { get; set; }
            public string Toplam_Adet_İSF { get; set; }

        }
        [System.Web.Services.WebMethod]
        public static string Tabloları_Doldur(string parametre,string İletim_Durum, string Ürün_Listesi)
        {

            DataSet İletim_Durum_dataset = JsonConvert.DeserializeObject<DataSet>(İletim_Durum);
            DataTable İletim_Durum_datatable = İletim_Durum_dataset.Tables["İletim_Durum__"];

            DataSet Ürün_Listesi_dataset = JsonConvert.DeserializeObject<DataSet>(Ürün_Listesi);
            DataTable Ürün_Listesi_datatable = Ürün_Listesi_dataset.Tables["Ürün_Listesi__"];

            string gelen_yıl = parametre.Split('*')[0];
            string gelen_ay = parametre.Split('*')[1];
            string Kullanıcı = parametre.Split('*')[2];
            var queryWithForJson = "" +
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
                ""  +
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

            "where Sipariş_Genel.Olusturan_Kullanıcı=@Kullanıcı_Adı  and Tar between @baslagıc_Tar and @bitis_tar " +
              
                "";
            //var queryWithForJson = "use kasa   " +
            //    "select  Tar,UrunADI,Adet,Mf_Adet,UrunKar_Yuzde,UrunFiyat,Eczane_Adı,TownName,CityName,Onay_Durum,Siparis_Detay.Siparis_Genel_Id  " +
            //    ",( " +
            //    "select Sum(cast(((UrunFiyat/((UrunKar_Yuzde/100)+1))*(Adet)/((Adet)+(Mf_Adet))) as decimal(14,2))*(Adet+Mf_Adet)) from Siparis_Detay " +
            //    "inner join Urunler2 " +
            //    "on Siparis_Detay.Urun_Id=Urunler2.UrunID " +
            //    "where Siparis_Detay.Siparis_Genel_Id=Sipariş_Genel.Siparis_Genel_Id " +
            //    ")as Genel_Birim_Fiyat_Toplam , " +
            //    " ( " +
            //    "select sum((Adet+Mf_Adet)*UrunFiyat) from Siparis_Detay " +
            //    "inner join Urunler2 " +
            //    "on Siparis_Detay.Urun_Id=Urunler2.UrunID " +
            //    "where Siparis_Detay.Siparis_Genel_Id=Sipariş_Genel.Siparis_Genel_Id " +
            //    ")as Genel_Normal_Fiyat_Toplam " +
            //    "from Siparis_Detay  " +
            //    "inner join Sipariş_Genel  " +
            //    " on Siparis_Detay.Siparis_Genel_Id=Sipariş_Genel.Siparis_Genel_Id  " +
            //    "inner join Urunler  " +
            //    "on Siparis_Detay.Urun_Id=Urunler.Urun_Id  " +
            //    "inner join Eczane   " +
            //    " on Sipariş_Genel.Eczane_Id=Eczane.Eczane_Id " +
            //    "inner join Town  " +
            //    "on Eczane.Eczane_Brick=Town.TownID  " +
            //    "inner join City  " +
            //    " on Town.CityID=City.CityID  " +
            //    "where Sipariş_Genel.Olusturan_Kullanıcı=@Kullanıcı_Adı and CAST(tar as date) between @baslagıc_Tar and @bitis_tar " +
            //    "" +

            //    "";


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
                        Adet_İSF= (Convert.ToDecimal(reader.GetValue(2)) * Convert.ToDecimal(reader.GetDecimal(8).ToString("0.##"))).ToString("0.##"),
                        Toplam_Adet_İSF= reader.GetDecimal(17).ToString("0.##")

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
        public static string Günlük_Satış_Verisi(string parametre, string İletim_Durum, string Ürün_Listesi)
        {

            DataSet İletim_Durum_dataset = JsonConvert.DeserializeObject<DataSet>(İletim_Durum);
            DataTable İletim_Durum_datatable = İletim_Durum_dataset.Tables["İletim_Durum__"];

            DataSet Ürün_Listesi_dataset = JsonConvert.DeserializeObject<DataSet>(Ürün_Listesi);
            DataTable Ürün_Listesi_datatable = Ürün_Listesi_dataset.Tables["Ürün_Listesi__"];

            string gelen_yıl = parametre.Split('*')[0];
            string gelen_ay = parametre.Split('*')[1];
            string Kullanıcı = parametre.Split('*')[2];
            var queryWithForJson = "" +
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
            "      where Sipariş_Genel.Olusturan_Kullanıcı=@Kullanıcı_Adı  and Tar between @baslagıc_Tar and @bitis_tar  group by Sipariş_Genel.Siparis_Genel_Id  " +
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


            string a = JsonConvert.SerializeObject( tablo_Doldur_Classes);

            conn.Close();
            return a;
            //return JsonConvert.SerializeObject(tablo_Doldur_Classes);


        }
        public class Farklı_Eczanelerin_Sayısı_Tablo
        {
            public string Eczane_Sayısı { get; set; }

        }
        [System.Web.Services.WebMethod]
        public static string Farklı_Eczanelerin_Sayısı(string parametre, string İletim_Durum, string Ürün_Listesi )
        {

            DataSet İletim_Durum_dataset = JsonConvert.DeserializeObject<DataSet>(İletim_Durum);
            DataTable İletim_Durum_datatable = İletim_Durum_dataset.Tables["İletim_Durum__"];

            DataSet Ürün_Listesi_dataset = JsonConvert.DeserializeObject<DataSet>(Ürün_Listesi);
            DataTable Ürün_Listesi_datatable = Ürün_Listesi_dataset.Tables["Ürün_Listesi__"];

            string gelen_yıl = parametre.Split('*')[0];
            string gelen_ay = parametre.Split('*')[1];
            string Kullanıcı = parametre.Split('*')[2];
            var queryWithForJson = "" +
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


                "  where Tar Between @Bas_Tar and @Bit_Tar and Olusturan_Kullanıcı=@Kullanıcı_Adı " +
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
        public static string Farklı_Eczanelerin_Sayısı_Ad_Getir(string parametre, string İletim_Durum, string Ürün_Listesi)
        {

            DataSet İletim_Durum_dataset = JsonConvert.DeserializeObject<DataSet>(İletim_Durum);
            DataTable İletim_Durum_datatable = İletim_Durum_dataset.Tables["İletim_Durum__"];

            DataSet Ürün_Listesi_dataset = JsonConvert.DeserializeObject<DataSet>(Ürün_Listesi);
            DataTable Ürün_Listesi_datatable = Ürün_Listesi_dataset.Tables["Ürün_Listesi__"];


            string gelen_yıl = parametre.Split('*')[0];
            string gelen_ay = parametre.Split('*')[1];
            string Kullanıcı = parametre.Split('*')[2];
            var queryWithForJson = "" +
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
                "    where Tar Between @Bas_Tar and @Bit_Tar and Olusturan_Kullanıcı=@Kullanıcı_Adı  group by Eczacı_Adı, Eczane_Adı,TownName,CityName order by sum(Adet*Guncel_ISF) desc" +
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
                        İlçe= reader.GetValue(2).ToString(),
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

        [System.Web.Services.WebMethod]
        public static string Günlük_Satış_Verisi_Toplam(string parametre, string İletim_Durum, string Ürün_Listesi)
        {

            DataSet İletim_Durum_dataset = JsonConvert.DeserializeObject<DataSet>(İletim_Durum);
            DataTable İletim_Durum_datatable = İletim_Durum_dataset.Tables["İletim_Durum__"];

            DataSet Ürün_Listesi_dataset = JsonConvert.DeserializeObject<DataSet>(Ürün_Listesi);
            DataTable Ürün_Listesi_datatable = Ürün_Listesi_dataset.Tables["Ürün_Listesi__"];


            string gelen_yıl = parametre.Split('*')[0];
            string gelen_ay = parametre.Split('*')[1];
            string Kullanıcı = parametre.Split('*')[2];
            var queryWithForJson = "" +
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
              "where Sipariş_Genel.Olusturan_Kullanıcı=@Kullanıcı_Adı  and Tar between @baslagıc_Tar and @bitis_tar   group by Sipariş_Genel.Siparis_Genel_Id  " +
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
                        Ziy_Tar ="1",
                        Tutar =  (reader.GetValue(0).ToString() == "" ? "0" : reader.GetDecimal(0).ToString("0.##")).ToString(), // reader.GetDecimal(0).ToString("0.##"),
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
        public class Çalışılan_Urun_Getir_Tablo
        {
            public string Adet { get; set; }
            public string Urun_Adı { get; set; }


        }
        [System.Web.Services.WebMethod]
        public static string Çalışılan_Urun_Getir(string parametre)


        {
            string gelen_yıl = parametre.Split('*')[0];
            string gelen_ay = parametre.Split('*')[1];
            string Kullanıcı = parametre.Split('*')[2];

            var queryWithForJson = "select COUNT(Ziyaret_Calışılan_Urunler.Calışılan_Urun_Id ),Urun_Adı from Ziyaret_Detay " +
            "" +
            "inner join Ziyaret_Genel " +
            "on Ziyaret_Detay.Ziy_Gnl_Id=Ziyaret_Genel.ID "  +
            "" +
            "inner join Ziyaret_Calışılan_Urunler " +
            "on Ziyaret_Detay.Ziy_Dty_ID=Ziyaret_Calışılan_Urunler.Ziyaret_Detay_Id " +
            "" +
            "inner join Urunler " +
            "on Urunler.Urun_Id=Ziyaret_Calışılan_Urunler.Calışılan_Urun_Id " +
            "" +
            "where Ziyaret_Genel.Kullanıcı_ID=@Kullanıcı_Adı  and Ziy_Tar between @baslagıc_Tar and @bitis_tar " +
            "" +
            "group by Urun_Adı ";






            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);
            conn.Open();
            cmd.Parameters.AddWithValue("@Kullanıcı_Adı", Kullanıcı);//@baslagıc_Tar//@bitis_tar
            cmd.Parameters.AddWithValue("@baslagıc_Tar", gelen_yıl);
            cmd.Parameters.AddWithValue("@bitis_tar", gelen_ay);


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

        public class Satılan_Urunler_Adet_Mf_Adet_Tablo
        {
            public string Mf_Adet { get; set; }
            public string Adet { get; set; }
            public string Urun_Adı { get; set; }


        }
        [System.Web.Services.WebMethod]
        public static string Satılan_Urunler_Adet_Mf_Adet(string parametre)


        {
            string gelen_yıl = parametre.Split('*')[0];
            string gelen_ay = parametre.Split('*')[1];
            string Kullanıcı = parametre.Split('*')[2];

            var queryWithForJson = "" +
                "select sum(Mf_Adet),sum(Adet),Urun_Adı from Siparis_Detay " +
                "" +
                "" +
                " inner join Sipariş_Genel " +
                "  on Siparis_Detay.Siparis_Genel_Id=Sipariş_Genel.Siparis_Genel_Id " +
                "inner join Urunler  " +
                "on Urunler.Urun_Id=Siparis_Detay.Urun_Id " +
                "" +
                       "where Sipariş_Genel.Olusturan_Kullanıcı=@Kullanıcı_Adı  and Tar between @baslagıc_Tar and @bitis_tar " +
                "" +
                "group by Urun_Adı " +
                "";






            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);
            conn.Open();
            cmd.Parameters.AddWithValue("@Kullanıcı_Adı", Kullanıcı);//@baslagıc_Tar//@bitis_tar
            cmd.Parameters.AddWithValue("@baslagıc_Tar", gelen_yıl);
            cmd.Parameters.AddWithValue("@bitis_tar", gelen_ay);


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

    }
}