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
    public partial class D_Numune_Talep_Yeni_Onay : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public class Talep_Sil_tablo
        {
            public string Durum { get; set; }

        }

        [System.Web.Services.WebMethod]
        public static string Durum_Güncelle(string Talep_Genel_Id,string Durum, string Merkez_Notu,string Kargo_Takip_No)
        {



            var queryWithForJson = "use kasa" +
                " update NT_Talep_Genel set Durum=@Durum,Merkez_Notu=@Merkez_Notu,Kargo_Takip_No=@Kargo_Takip_No where ID=@Talep_Genel_ID " +
                " ";



            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);

            cmd.Parameters.AddWithValue("@Talep_Genel_ID", Talep_Genel_Id);
            cmd.Parameters.AddWithValue("@Durum", Durum);
            cmd.Parameters.AddWithValue("@Merkez_Notu", Merkez_Notu);
            cmd.Parameters.AddWithValue("@Kargo_Takip_No", Kargo_Takip_No);
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
        public static string Talep_Liste_Doldur(string Bas_Tar,string Bit_Tar)
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
                "where Oluşturulma_Tarihi between @Bas_Tar and @Bit_Tar and Silinmişmi=0 " +
                "" +
                "";





            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);


            cmd.Parameters.AddWithValue("@Bas_Tar",Bas_Tar );
            cmd.Parameters.AddWithValue("@Bit_Tar", Bit_Tar);








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