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
    public partial class Numune_Talebi_Yeni : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public class Koli_Başlık_Getir_Tablo
        {
            public string ID     { get; set; }
            public string Koli_Ad { get; set; }

        }

        [System.Web.Services.WebMethod]
        public static string Koli_Ad_Getir()
        {



            var queryWithForJson = "use kasa select  ID,Koli_Adı from NT_Koliler where Silinmişmi=0";


            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);


            conn.Open();



            List<Koli_Başlık_Getir_Tablo> tablo_Doldur_Classes = new List<Koli_Başlık_Getir_Tablo>();
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
                    var Tablo_Doldur_Class_ = new Koli_Başlık_Getir_Tablo
                    {
                        ID = reader.GetValue(0).ToString(),
                        Koli_Ad = reader.GetValue(1).ToString(),
                    };
                    tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
                }
            }
            conn.Close();
            return JsonConvert.SerializeObject(tablo_Doldur_Classes);


        }

        public class Koli_Urun_Getir_Tablo
        {
            public string ID { get; set; }
            public string Koli_ID { get; set; }
            public string Urun_Ad { get; set; }

        }

        [System.Web.Services.WebMethod]
        public static string Koli_Urun_Getir()
        {



            var queryWithForJson = "use kasa select ID,Koli_ID,Urun_Adı from NT_Koli_İçi where Silinmişmi = 0";


            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);


            conn.Open();



            List<Koli_Urun_Getir_Tablo> tablo_Doldur_Classes = new List<Koli_Urun_Getir_Tablo>();
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
                    var Tablo_Doldur_Class_ = new Koli_Urun_Getir_Tablo
                    {
                        ID = reader.GetValue(0).ToString(),
                        Koli_ID = reader.GetValue(1).ToString(),
                        Urun_Ad = reader.GetValue(2).ToString(),
                    };
                    tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
                }
            }
            conn.Close();
            return JsonConvert.SerializeObject(tablo_Doldur_Classes);


        }

        public class Talepteki_Urunleri_Getir_Tablo
        {
            public string Urun_Ad { get; set; }

        }

        [System.Web.Services.WebMethod]
        public static string Talepteki_Urunleri_Getir(string Talep_Genel_Id)
        {



            var queryWithForJson = "use kasa " +
                " select Urun_Adı from NT_Talep_Detay " +
                " inner join NT_Koli_İçi " +
                " on Urun_ID=NT_Koli_İçi.ID " +
                "" +
                "where NT_Talep_Genel_ID=@Talep_Genel_ID  ";


            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);

            cmd.Parameters.AddWithValue("@Talep_Genel_ID", Talep_Genel_Id);
            conn.Open();



            List<Talepteki_Urunleri_Getir_Tablo> tablo_Doldur_Classes = new List<Talepteki_Urunleri_Getir_Tablo>();
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
                    var Tablo_Doldur_Class_ = new Talepteki_Urunleri_Getir_Tablo
                    {
                        Urun_Ad = reader.GetValue(0).ToString(),
                    };
                    tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
                }
            }
            conn.Close();
            return JsonConvert.SerializeObject(tablo_Doldur_Classes);


        }

        public class Talep_Sil_tablo
        {
            public string Durum { get; set; }

        }

        [System.Web.Services.WebMethod]
        public static string Talep_Sil(string Talep_Genel_Id)
        {



            var queryWithForJson = "use kasa" +
                " update NT_Talep_Genel set Silinmişmi=1 where ID=@Talep_Genel_ID " +
                " ";
             


            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);

            cmd.Parameters.AddWithValue("@Talep_Genel_ID", Talep_Genel_Id);
            conn.Open();



            List<Talep_Sil_tablo> tablo_Doldur_Classes = new List<Talep_Sil_tablo>();
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
                    var Tablo_Doldur_Class_ = new Talep_Sil_tablo
                    {
                        Durum = reader.GetValue(0).ToString(),
                    };
                    tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
                }
            }
            conn.Close();
            return JsonConvert.SerializeObject(tablo_Doldur_Classes);


        }

        public class Talep_Oluştur_Table
        {
            public string Durum { get; set; }

        }

        [System.Web.Services.WebMethod]
        public static string Talep_Oluştur(string Urunler, string İl,string İlçe,string İletişim_Tel,string Teslimat_Adresi,string Alıcı_Adı_Soyadı, string Kullanıcı_Notu)

        {



            DataSet Urunler_Dataset = JsonConvert.DeserializeObject<DataSet>(Urunler);
            DataTable Urunler_Datatable = Urunler_Dataset.Tables["Urun_Liste"];


        



            var queryWithForJson = "" +
            "declare @İnserted_ID table(ID int) " +
            "" +
            "insert into NT_Talep_Genel (Oluşturulma_Tarihi,Kullanıcı_ID,Durum,İletişim_Tel,Teslimat_İl,Teslimat_İlçe,Teslimat_Adresi,Alıcı_Adı_Soyadı,Kullanıcı_Notu)  " +
            "output inserted.ID into @İnserted_ID " +
            "values(GETDATE(),(select KullanıcıID from Kullanıcı where KullanıcıAD COLLATE Latin1_general_CS_AS=@Kullanıcı_ID),0,@İletişim_Tel,@Teslimat_İl,@Teslimat_İlçe,@Teslimat_Adresi,@Alıcı_Adı_Soyadı,@Kullanıcı_Notu) " +
            "" +
            "insert into NT_Talep_Detay(NT_Talep_Genel_ID,Urun_ID) select (select ID from @İnserted_ID),Urun_ID_ from @Urun_Liste " +
            "" +
            "select 1 ;" +
            "";
         




            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);
            cmd.Parameters.AddWithValue("@İletişim_Tel", İletişim_Tel);
            cmd.Parameters.AddWithValue("@Teslimat_İl", İl);
            cmd.Parameters.AddWithValue("@Teslimat_İlçe", İlçe);
            cmd.Parameters.AddWithValue("@Teslimat_Adresi", Teslimat_Adresi);
            cmd.Parameters.AddWithValue("@Alıcı_Adı_Soyadı", Alıcı_Adı_Soyadı);
            cmd.Parameters.AddWithValue("@Kullanıcı_Notu", Kullanıcı_Notu);
            
            cmd.Parameters.AddWithValue("@Kullanıcı_ID", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());



            SqlParameter tvpParam1 = cmd.Parameters.AddWithValue("@Urun_Liste", Urunler_Datatable);
            tvpParam1.SqlDbType = SqlDbType.Structured;
            tvpParam1.TypeName = "dbo.NT_Urun_Type";





            List<Talep_Oluştur_Table> tablo_Doldur_Classes = new List<Talep_Oluştur_Table>();

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
                    var Tablo_Doldur_Class_ = new Talep_Oluştur_Table
                    {
                        Durum = reader.GetValue(0).ToString(),

                    };
                    tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
                }
            }
            conn.Close();
            return JsonConvert.SerializeObject(tablo_Doldur_Classes);




        }//Masrafı_Kaldır

        public class Talep_Liste_Doldur_Tablo
        {
            public string Oluşturulma_Tarihi { get; set; }
            public string Kullanıcı_Ad_Soyad { get; set; }
            public string Alıcı_Adı_Soyadı { get; set; }
            public string İl { get; set; }
            public string İlçe { get; set; }
            public string Teslimat_Adresi { get; set; }
            public string Durum { get; set; }
            public string Genel_ID { get; set; }
            public string Kullanıcı_Notu { get; set; }
            public string Merkez_Notu { get; set; }
            public string Kargo_Takip_No { get; set; }
            
        }

        [System.Web.Services.WebMethod]
        public static string Talep_Liste_Doldur()

        {





            var queryWithForJson = "" +
                "select Oluşturulma_Tarihi,(AD+' '+Soyad) ,Alıcı_Adı_Soyadı,CityName,TownName,Teslimat_Adresi,Durum,ID,Kullanıcı_Notu,Merkez_Notu,Kargo_Takip_No from NT_Talep_Genel " +
                "" +
                "inner join Kullanıcı " +
                "on Kullanıcı_ID=Kullanıcı.KullanıcıID " +
                "" +
                "inner join City " +
                "on CityID=Teslimat_İl " +
                "" +
                "inner join Town " +
                "on TownID=Teslimat_İlçe " +
                "" +
                "where Kullanıcı_ID=(select KullanıcıID from Kullanıcı where KullanıcıAD COLLATE Latin1_general_CS_AS=@Kullanıcı_ID) and Silinmişmi=0 " +
                "" +
                "";





            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);


            cmd.Parameters.AddWithValue("@Kullanıcı_ID", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());









            List<Talep_Liste_Doldur_Tablo> tablo_Doldur_Classes = new List<Talep_Liste_Doldur_Tablo>();

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
                    var Tablo_Doldur_Class_ = new Talep_Liste_Doldur_Tablo
                    {
                        Oluşturulma_Tarihi = reader.GetValue(0).ToString(),
                        Kullanıcı_Ad_Soyad = reader.GetValue(1).ToString(),
                        Alıcı_Adı_Soyadı = reader.GetValue(2).ToString(),
                        İl = reader.GetValue(3).ToString(),
                        İlçe = reader.GetValue(4).ToString(),
                        Teslimat_Adresi = reader.GetValue(5).ToString(),
                        Durum = reader.GetValue(6).ToString(),
                        Genel_ID = reader.GetValue(7).ToString(),
                        Kullanıcı_Notu = reader.GetValue(8).ToString(),
                        Merkez_Notu = reader.GetValue(9).ToString(),
                        Kargo_Takip_No = reader.GetValue(10).ToString(),
                    };
                    tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
                }
            }
            conn.Close();
            return JsonConvert.SerializeObject(tablo_Doldur_Classes);




        }//Masrafı_Kaldır

    }
}