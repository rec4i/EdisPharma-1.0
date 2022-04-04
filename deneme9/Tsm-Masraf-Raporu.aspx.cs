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
    public partial class Tsm_Masraf_Raporu : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        [System.Web.Services.WebMethod]
        public static string Kullanıcı_Adı_Soyadı(string parametre)
        {
            var queryWithForJson = "(select AD,Soyad from Kullanıcı where KullanıcıID=@1) ";
            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);

            cmd.Parameters.AddWithValue("@1", parametre);
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


        }
        public class Tablo_Doldur_Class
        {
            public string Doktor_Ad { get; set; }
            public string Tur_Txt { get; set; }
            public string Belge_Tur_Txt { get; set; }
            public string Sirket_Unvanı { get; set; }
            public string Açıklama { get; set; }
            public string Kdv_Tutarı { get; set; }
            public string Kdv_Haric_Tutar { get; set; }
            public string Toplam_Tutar { get; set; }
            public string Tarih { get; set; }
            public string Kdv_Oranı { get; set; }
            public string Masraf_Id { get; set; }

        }



        [System.Web.Services.WebMethod]
        public static string Tablo_Doldur(string parametre)
        {
            //select * from listeler where Kullanıcı_Id=(select KullanıcıID from Kullanıcı where KullanıcıAD='recai') and cins = 0
            var queryWithForJson = "use kasa " +
                "select Doktor_Ad,Masraf_Tur.Tur_Txt,Belge_Tur.Belge_Tur_Txt,Sirket_Unvani,Açıklama,Kdv_Tutarı,Kdv_Haric_Tutar,Toplam_Tutar,Tarih,Kdv_Oranı,Masraf_Id from Masraflar " +
                "inner join Doktors  " +
                " on Masraflar.Doktor_Id= Doktors.Doktor_Id " +
                "inner join Masraf_Tur " +
                "on Masraflar.Masraf_Turu=Masraf_Tur.Masraf_Tur_Id " +
                " inner join Belge_Tur " +
                "on Masraflar.Belge_Turu=Belge_Tur.Belge_Tur_Id " +
                "where Tarih between @1 and @2 and Kullanıcı_Id= (select KullanıcıID from Kullanıcı where KullanıcıID=@3 ) ";
            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);
            cmd.Parameters.AddWithValue("@1", parametre.Split('!')[0]);
            cmd.Parameters.AddWithValue("@2", parametre.Split('!')[1]);
            cmd.Parameters.AddWithValue("@3", parametre.Split('!')[2]);

            List<Tablo_Doldur_Class> tablo_Doldur_Classes = new List<Tablo_Doldur_Class>();

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
                    var Tablo_Doldur_Class_ = new Tablo_Doldur_Class
                    {
                        Doktor_Ad = reader.GetValue(0).ToString(),
                        Tur_Txt = reader.GetValue(1).ToString(),
                        Belge_Tur_Txt = reader.GetValue(2).ToString(),
                        Sirket_Unvanı = reader.GetValue(3).ToString(),
                        Açıklama = reader.GetValue(4).ToString(),

                        Kdv_Tutarı = reader.GetValue(5).ToString(),
                        Kdv_Haric_Tutar = reader.GetValue(6).ToString(),
                        Toplam_Tutar = reader.GetValue(7).ToString(),
                        Tarih = reader.GetDateTime(8).ToString("dd-MM-yyyy"),
                        Kdv_Oranı = "%" + reader.GetValue(9).ToString(),
                        Masraf_Id = reader.GetValue(10).ToString()
                    };
                    tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
                }
            }
            conn.Close();
            return JsonConvert.SerializeObject(tablo_Doldur_Classes);


        }//Masrafı_Kaldır
    }
}