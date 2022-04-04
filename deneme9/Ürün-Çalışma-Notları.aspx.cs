using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace deneme9
{
    public partial class Ürün_Çalışma_Notları : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public class Tabloları_Doldur_Doktor
        {
            public string Urun_Dosya_Link { get; set; }
            public string Urun_Resim { get; set; }
            public string Urun_Adı { get; set; }


        }
        [System.Web.Services.WebMethod]
        public static string Urun_Calısma_Notları(string parametre)

        {

            var queryWithForJson = "" +
                "select Urun_Dosya_Link,Urun_Resim,Urun_Adı from Urun_Çalışma_Dosya inner join Urunler on Urun_Çalışma_Dosya.Urun_Id=Urunler.Urun_Id where Silinmismi=0  " +

            " ";




            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);
            conn.Open();




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
                        Urun_Dosya_Link = reader.GetValue(0).ToString(),
                        Urun_Resim = reader.GetValue(1).ToString(),
                        Urun_Adı = reader.GetValue(2).ToString(),
                    };
                    tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
                }
            }


            //  IEnumerable < Ziy_Onay_Tablo > tablo_Doldur_Classes_ = from x in tablo_Doldur_Classes where x.Ad == "10" select x;


            string a = JsonConvert.SerializeObject(tablo_Doldur_Classes);

            conn.Close();
            return a;


        }
        public class Sunum_Başlık_Tablo
        {
            public string ID { get; set; }
            public string Sunum_Başlık { get; set; }

        }
        [System.Web.Services.WebMethod]
        public static string Sunum_Başlık()

        {

            var queryWithForJson = "" +
                " select ID,Sunum_Başlık from Sunum_Başlık  " +

            " ";




            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);
            conn.Open();




            List<Sunum_Başlık_Tablo> tablo_Doldur_Classes = new List<Sunum_Başlık_Tablo>();


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


                    var Tablo_Doldur_Class_ = new Sunum_Başlık_Tablo
                    {
                        ID = reader.GetValue(0).ToString(),
                        Sunum_Başlık = reader.GetValue(1).ToString(),
                    };
                    tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
                }
            }


            //  IEnumerable < Ziy_Onay_Tablo > tablo_Doldur_Classes_ = from x in tablo_Doldur_Classes where x.Ad == "10" select x;


            string a = JsonConvert.SerializeObject(tablo_Doldur_Classes);

            conn.Close();
            return a;


        }
        public class Sunum_İçerik_Tablo
        {
            public string Sunum_Başlık_Id { get; set; }
            public string Urun_Adı { get; set; }
            public string Urun_Pdf_Link { get; set; }
            public string Urun_Resim { get; set; }

        }
        [System.Web.Services.WebMethod]
        public static string Sunum_İçerik()

        {

            var queryWithForJson = "" +
                "select Sunum_Başlık_Id,Urun_Adı,Urun_Pdf_Link,Urun_Resim from Sunum_Kesişim " +
                "" +
                "inner join Sunum_İçerik " +
                "on Sunum_Kesişim.Sunum_İçerik_Id=Sunum_İçerik.ID " +
                "" +
                "inner join Urunler " +
                "on Sunum_İçerik.Urun_ID=Urunler.Urun_Id " +
                "";




            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);
            conn.Open();




            List<Sunum_İçerik_Tablo> tablo_Doldur_Classes = new List<Sunum_İçerik_Tablo>();


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


                    var Tablo_Doldur_Class_ = new Sunum_İçerik_Tablo
                    {
                        Sunum_Başlık_Id = reader.GetValue(0).ToString(),
                        Urun_Adı = reader.GetValue(1).ToString(),
                        Urun_Pdf_Link = reader.GetValue(2).ToString(),
                        Urun_Resim = reader.GetValue(3).ToString(),
                    };
                    tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
                }
            }


            //  IEnumerable < Ziy_Onay_Tablo > tablo_Doldur_Classes_ = from x in tablo_Doldur_Classes where x.Ad == "10" select x;


            string a = JsonConvert.SerializeObject(tablo_Doldur_Classes);

            conn.Close();
            return a;


        }
    }
}