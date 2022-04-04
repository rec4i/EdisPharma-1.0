using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace deneme9
{
    public partial class Onaylanmayan_Sipariş : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        public class Eczane_Sipariş_İptal_Genel_Sorgu_Tablo
        {
            public string Eczane_Adı { get; set; }
            public string Onay_Durum { get; set; }
            public string İletim_Durum { get; set; }
            public string CityName { get; set; }
            public string TownName { get; set; }
            public string Eczane_Telefon { get; set; }
            public string Eposta { get; set; }
            public string Siparis_Genel_Id { get; set; }
            public string Tar { get; set; }
            public string Onaylanmadıya_Düştümü { get; set; }
            public string Sipariş_Tekrar_Gönderlidimi { get; set; }
            public string Görüsme_Sonucu { get; set; }
            public string Ad_Soyad { get; set; }
            public string Bm_Ye_Gönderildimi { get; set; }
        }
        [System.Web.Services.WebMethod]
        public static string Eczane_Sipariş_İptal_Genel_Sorgu(string Sipariş_Id)
        {

            var queryWithForJson = "use kasa   " +
              "select Eczane_Adı,Onay_Durum,İletim_Durum,CityName,TownName,Eczane_Telefon,Eposta,Tar,Siparis_Genel_Id,Onaylanmadıya_Düştümü,Sipariş_Tekrar_Gönderlidimi,Görüsme_Sonucu,AD,Soyad,Bm_Ye_Gönderildimi  from Sipariş_Genel " +

              "inner join Eczane " +
              "on Sipariş_Genel.Eczane_Id=Eczane.Eczane_Id " +
              "inner join Town " +
              "on TownID=Eczane.Eczane_Brick " +
              "inner join City " +
              "on Eczane.Eczane_Il=City.CityID " +
              "inner join Kullanıcı " +
              " on  Olusturan_Kullanıcı=KullanıcıID " +

              "where Kullanıcı.Kullanıcı_Bogle=(select Kullanıcı_Bogle from Kullanıcı where KullanıcıAD COLLATE Latin1_general_CS_AS =@1) " +
              " and İletim_Durum=5";



            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);
            conn.Open();
            cmd.Parameters.AddWithValue("@1", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());



            List<Eczane_Sipariş_İptal_Genel_Sorgu_Tablo> tablo_Doldur_Classes = new List<Eczane_Sipariş_İptal_Genel_Sorgu_Tablo>();


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
                    var Tablo_Doldur_Class_ = new Eczane_Sipariş_İptal_Genel_Sorgu_Tablo
                    {
                        Eczane_Adı = reader.GetValue(0).ToString(),
                        Onay_Durum = reader.GetValue(1).ToString(),
                        İletim_Durum = reader.GetValue(2).ToString(),
                        CityName = reader.GetValue(3).ToString(),
                        TownName = reader.GetValue(4).ToString(),
                        Eczane_Telefon = reader.GetValue(5).ToString(),
                        Eposta = reader.GetValue(6).ToString(),
                        Siparis_Genel_Id = reader.GetValue(8).ToString(),
                        Tar = reader.GetDateTime(7).ToString("dd/MM/yyyy HH:mm"),
                        Onaylanmadıya_Düştümü = reader.GetValue(9).ToString(),
                        Sipariş_Tekrar_Gönderlidimi = reader.GetValue(10).ToString(),
                        Görüsme_Sonucu = reader.GetValue(11).ToString(),
                        Ad_Soyad = reader.GetValue(12).ToString()+" "+ reader.GetValue(13).ToString(),
                        Bm_Ye_Gönderildimi = reader.GetValue(14).ToString(),
                        
                    };
                    tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
                }
            }


            //  IEnumerable < Ziy_Onay_Tablo > tablo_Doldur_Classes_ = from x in tablo_Doldur_Classes where x.Ad == "10" select x;


            conn.Close();
            return JsonConvert.SerializeObject(tablo_Doldur_Classes);


        }

        [System.Web.Services.WebMethod]
        public static string Tekrar_Sipariş_Görüşmesi_İste(string sipariş_Id)
        {

            var queryWithForJson = "use kasa   " +

              " update Sipariş_Genel set Bm_Ye_Gönderildimi=0 where Siparis_Genel_Id=@1 ";



            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);
            conn.Open();
            cmd.Parameters.AddWithValue("@1", sipariş_Id);


            cmd.ExecuteNonQuery();
         


            conn.Close();
            return "sad";


        }
        [System.Web.Services.WebMethod]
        public static string Siparişi_Tekrar_Oluştur(string sipariş_Id)
        {

            var queryWithForJson = "use kasa   " +

              " update Sipariş_Genel set Sipariş_Tekrar_Gönderlidimi=1,Onay_Durum=0,İletim_Durum=6 where Siparis_Genel_Id=@1 ";



            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);
            conn.Open();
            cmd.Parameters.AddWithValue("@1", sipariş_Id);


            cmd.ExecuteNonQuery();



            conn.Close();
            return "sad";


        }
        [System.Web.Services.WebMethod]
        public static string Siparişi_İptal_Et(string sipariş_Id)
        {

            var queryWithForJson = "use kasa   " +

              " update Sipariş_Genel set Sipariş_İptal_Edildimi=1,İletim_Durum=7 where Siparis_Genel_Id=@1 ";



            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);
            conn.Open();
            cmd.Parameters.AddWithValue("@1", sipariş_Id);


            cmd.ExecuteNonQuery();



            conn.Close();
            return "sad";


        }
    }
}