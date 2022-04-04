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
    public partial class Siparis_Olustur : System.Web.UI.Page
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
        public class Gün_Tablo
        {
            public string Gün { get; set; }
            public string Pazarmı { get; set; }

            public string Kırmızımı { get; set; }
            public string Gun_Ay_Yıl { get; set; }
            public string Gun_Ay_Yıl_Gün { get; set; }
        }
        [System.Web.Services.WebMethod]
        public static string Gün_Say(string Gün)
        {
            DateTime DateNow = DateTime.Now;
            DateTime endDate = DateTime.Now;
            endDate = endDate.AddDays(Convert.ToInt32(Gün));

            List<Gün_Tablo> tablo_Doldur_Classes = new List<Gün_Tablo>();

            string Kırmızımı = "0";
            if (endDate <= DateNow)
            {
                Kırmızımı = "1";
            }
            //if (endDate.Month == DateNow.Month)
            //{
            //    Kırmızımı = "1";
            //}
            if (endDate.ToString("dddd") == "Pazar")
            {
                Kırmızımı = "1";
            }
            if (endDate.ToString("dddd") == "Cumartesi")
            {
                Kırmızımı = "1";
            }


            var Tablo_Doldur_Class_ = new Gün_Tablo
            {
                Gün = endDate.ToString("dd MMMM dddd yyyy"),
                Pazarmı= endDate.ToString("dddd"),
                Kırmızımı= Kırmızımı,
                Gun_Ay_Yıl= endDate.ToString("MM-yyyy"),
                Gun_Ay_Yıl_Gün= endDate.ToString("yyyy-MM-dd")
            };
            tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);



            return JsonConvert.SerializeObject(Tablo_Doldur_Class_);


        }
        public class Depo_Şehirleri_Tablo
        {
            public string Şehir_Ad   { get; set; }
            public string Şehir_Id { get; set; }
          
        }
        [System.Web.Services.WebMethod]
        public static string Depo_Şehirleri()
        {
            var queryWithForJson = "use kasa select CityName,CityID from Depo_Adı inner join City on CityID=Depo_İl group by CityID, CityName ";

            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);
            conn.Open();



            List<Depo_Şehirleri_Tablo> tablo_Doldur_Classes = new List<Depo_Şehirleri_Tablo>();


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
                    var Tablo_Doldur_Class_ = new Depo_Şehirleri_Tablo
                    {
                        Şehir_Ad = reader.GetValue(0).ToString(),
                        Şehir_Id = reader.GetValue(1).ToString(),
                    };
                    tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
                }
            }
            conn.Close();
            return JsonConvert.SerializeObject(tablo_Doldur_Classes);


        }
        public class Depo_Adları_Tablo
        {
            public string Depo_Adı   { get; set; }
            public string Depo_Id { get; set; }

        }
        [System.Web.Services.WebMethod]
        public static string Depo_Adları(string Şehir)
        {
            var queryWithForJson = "use kasa select Depo_Txt,Depo_Id from Depo_Adı inner join City on CityID=Depo_İl where Depo_İl=@Şehir ";

            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);
            cmd.Parameters.AddWithValue("@Şehir", Şehir);
            conn.Open();



            List<Depo_Adları_Tablo> tablo_Doldur_Classes = new List<Depo_Adları_Tablo>();


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
                    var Tablo_Doldur_Class_ = new Depo_Adları_Tablo
                    {
                        Depo_Adı = reader.GetValue(0).ToString(),
                        Depo_Id = reader.GetValue(1).ToString(),
                    };
                    tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
                }
            }
            conn.Close();
            return JsonConvert.SerializeObject(tablo_Doldur_Classes);


        }
        public class İlaçlar
        {
            public string İlaç_Id { get; set; }
            public string İlaç_Adı { get; set; }
            public string İlaçresim { get; set; }
            public string Guncel_ISF { get; set; }
            public string Guncel_DSF { get; set; }
            public string KDV_Guncel_PSF { get; set; }
        }
        [System.Web.Services.WebMethod]
        public static string Urunler(string Şehir_Id)
        {
            var queryWithForJson = "use kasa select Urun_Id,Urun_Adı,Urun_Resim,Guncel_ISF,Guncel_DSF,KDV_Guncel_PSF from Urunler where Silinmismi=0  ";

            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);
            conn.Open();



            List<İlaçlar> tablo_Doldur_Classes = new List<İlaçlar>();


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
                    var Tablo_Doldur_Class_ = new İlaçlar
                    {
                        İlaç_Id = reader.GetValue(0).ToString(),
                        İlaç_Adı = reader.GetValue(1).ToString(),
                        İlaçresim = reader.GetValue(2).ToString(),
                        Guncel_ISF = reader.GetValue(3).ToString(),
                        Guncel_DSF = reader.GetValue(4).ToString(),
                        KDV_Guncel_PSF = reader.GetValue(5).ToString(),


                    };
                    tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
                }
            }
            conn.Close();
            return JsonConvert.SerializeObject(tablo_Doldur_Classes);


        }
        public class Birim_Fiyat_Tablo
        {
            public string Birim_Fiyat { get; set; }
            public string Satış_Fiyatı_Toplam { get; set; }
            public string Birim_Fiyatı_Toplam { get; set; }

          
        }
        [System.Web.Services.WebMethod]
        public static string Birim_Fiyat_Hesapla(string Guncel_DSF, string Adet, string Mf_Adet)
        {

            


                double Birim_Fiyat_ = Convert.ToDouble((Convert.ToDouble(Guncel_DSF) * Convert.ToDouble(Adet))/(Convert.ToDouble(Adet) + Convert.ToDouble(Mf_Adet)));



                var Tablo_Doldur_Class_ = new Birim_Fiyat_Tablo
                {
                    Birim_Fiyat = Birim_Fiyat_.ToString("#.##"),
                    Birim_Fiyatı_Toplam = (Birim_Fiyat_ *(Convert.ToDouble(Adet)+Convert.ToDouble(Mf_Adet))).ToString("#.##"),
                    Satış_Fiyatı_Toplam = (Convert.ToDouble(Guncel_DSF) * (Convert.ToDouble(Adet) + Convert.ToDouble(Mf_Adet))).ToString("#.##"),

                };

            

                return JsonConvert.SerializeObject(Tablo_Doldur_Class_);



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
        public static string Siparişi_Kaydet(string Siparis_Array, string Eczane_Id,string Sipariş_Tar,string Depo_Id,string Lansman_Siparişimi)
        {
            var result = JsonConvert.DeserializeObject<Gün_Tablo>(Gün_Say(Sipariş_Tar));
            Takvim.Haftanın_Gunleri(result.Gun_Ay_Yıl);
            DateTime Gün = Convert.ToDateTime(result.Gun_Ay_Yıl_Gün);
            if (Gün.ToString("dddd")=="Pazar")
            {
               
                return "0";
            }
            if (Gün.ToString("dddd") == "Cumartesi")
            {
                
                return "0";
            }
            else
            {
                DataSet dataSet = JsonConvert.DeserializeObject<DataSet>(Siparis_Array);

                DataTable dataTable = dataSet.Tables["Deneme"];

                Console.WriteLine(dataTable.Rows.Count);




                var queryWithForJson = "" +
                    "declare @Giren_Id table(id int);" +
                    "insert into Sipariş_Genel (Tar,Eczane_Id,Olusturan_Kullanıcı,Depo_Id,Lansman_Siparişimi)  " +
                    "output inserted.Siparis_Genel_Id into @Giren_Id values(GETDATE(),@Eczane_ıd,(select KullanıcıID from Kullanıcı where KullanıcıAD COLLATE Latin1_general_CS_AS =@Kullanıcı_Ad),@Depo_Id,@Lansman_Siparişimi) " +

                    " insert into Siparis_Detay  select ilaç_id,Adet,Mf_Adet,(select * from @Giren_Id) from @myTableType " +

                    " insert into Ziyaret_Detay(Silinemez,Cins, Eczane_Id, Ziyaret_Durumu, Kullanıcı_Id, Ziy_Gnl_Id) values(1,1, @doktor_ıd, 0, (select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS  = @Kullanıcı),(select ID from Ziyaret_Genel where Ziyaret_Genel.Kullanıcı_ID = (select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS           = @Kullanıcı) and Ziy_Tar = @Ziytar)); update Ziyaret_Genel set Ziy_Edilecek_Eczane = Ziy_Edilecek_Eczane + 1 where Ziyaret_Genel.ID = (select ID from Ziyaret_Genel where Ziyaret_Genel.Kullanıcı_ID = (select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS           = @Kullanıcı) and Ziy_Tar = @Ziytar);   ";


                var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
                var cmd = new SqlCommand(queryWithForJson, conn);
                cmd.Parameters.AddWithValue("@Kullanıcı_Ad", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd.Parameters.AddWithValue("@Eczane_ıd", Eczane_Id);
                cmd.Parameters.AddWithValue("@Depo_Id", Depo_Id);

                cmd.Parameters.AddWithValue("@Ziytar", result.Gun_Ay_Yıl_Gün);
                cmd.Parameters.AddWithValue("@Kullanıcı", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd.Parameters.AddWithValue("@doktor_ıd", Eczane_Id);
                cmd.Parameters.AddWithValue("@Lansman_Siparişimi", Lansman_Siparişimi);



                SqlParameter tvpParam = cmd.Parameters.AddWithValue("@myTableType", dataTable);
                tvpParam.SqlDbType = SqlDbType.Structured;
                tvpParam.TypeName = "dbo.Sipariş_";

                conn.Open();

                var reader = cmd.ExecuteNonQuery();
                conn.Close();
                return "a";
            }






           
        
            
            
            
        }


    }
}