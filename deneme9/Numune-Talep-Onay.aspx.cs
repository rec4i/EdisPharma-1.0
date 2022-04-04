using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json;
namespace deneme9
{
    public partial class Numune_Talep_Onay : System.Web.UI.Page
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
        public class Sipariş_Genel_Liste
        {
            public string Ad_Soyad { get; set; }
            public string Doktor_Ad { get; set; }
            public string Tarih { get; set; }
            public string UrunADI { get; set; }
            public string Adet { get; set; }
            public string Numune_Talebi_Id { get; set; }
            public string Onay_Durum { get; set; }
 

        }
        [System.Web.Services.WebMethod]
        public static string Tablo_Verisi(string Tar_1, string Tar_2)
        {
            var queryWithForJson = "" +
                "select AD,Soyad,Doktor_Ad,Tarih,UrunADI,Adet,Numune_Talebi_Id,Onay_Durum from Numune_Talebi " +
                "inner join Kullanıcı " +
                "on Kullanıcı.KullanıcıID=Numune_Talebi.Kullanıcı_Id " +
                "inner join Doktors " +
                "on Doktors.Doktor_Id=Numune_Talebi.Doktor_Id " +
                "inner join Urunler2 " +
                "on Numune_Talebi.İlaç_Id=Urunler2.UrunID " +
                "where  Tarih between @tar_1 and @tar_2 order by Tarih asc ";

            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);
            conn.Open();

            cmd.Parameters.AddWithValue("@tar_1", Tar_1 + " " + "00:00:00.000");
            cmd.Parameters.AddWithValue("@tar_2", Tar_2 + " " + "23:59:59.999");



            List<Sipariş_Genel_Liste> tablo_Doldur_Classes = new List<Sipariş_Genel_Liste>();


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
                    var Tablo_Doldur_Class_ = new Sipariş_Genel_Liste
                    {
                        Ad_Soyad = reader.GetValue(0).ToString()+" "+ reader.GetValue(1).ToString(),
                        Doktor_Ad = reader.GetValue(2).ToString(),
                        Tarih = reader.GetDateTime(3).ToString("dd/MM/yyyy"),
                        UrunADI = reader.GetValue(4).ToString(),
                        Adet = reader.GetValue(5).ToString(),
                        Numune_Talebi_Id = reader.GetValue(6).ToString(),
                        Onay_Durum = reader.GetValue(7).ToString()

                    };
                    tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
                }
            }
            conn.Close();
            return JsonConvert.SerializeObject(tablo_Doldur_Classes);


        }
        [System.Web.Services.WebMethod]
        public static string Onay_Durumu_Güncelle(string Sipariş_Id, string islem)
        {
            var queryWithForJson = "" +
                "update Numune_Talebi set Onay_Durum = @1 where Numune_Talebi.Numune_Talebi_Id=@2 " +
                "";


            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);
            conn.Open();
            cmd.Parameters.AddWithValue("@1", islem);
            cmd.Parameters.AddWithValue("@2", Sipariş_Id);






            var reader = cmd.ExecuteNonQuery();

            conn.Close();
            return "0";
        }
    }
}