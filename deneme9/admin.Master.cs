using deneme9;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data.Sql;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Text;
using Newtonsoft.Json;
using System.Web.Security;

namespace kurumsal.kurumsaluser
{
    public partial class admin : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"] is null)
            {
                Response.Redirect("default.aspx");
                SqlC.con.Close();
            }
            else
            {

                SqlC.con.Close();
            }
            HiddenField1.Value = Profil_Bilgileri();

            var queryWithForJson = "use kasa  select Kullanıcı_Grup from Kullanıcı where KullanıcıAD COLLATE Latin1_general_CS_AS=@1";
            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);
            cmd.Parameters.AddWithValue("@1", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
            conn.Open();

            var reader = cmd.ExecuteReader();

            string a = "";

            while (reader.Read())
            {
                a += reader.GetValue(0).ToString();
            }
            conn.Close();
            //TSM MÜMESSİL
            if (a == "4")
            {

            }
            //Devoloper (dev)
            if (a == "5")
            {

            }

            //Kullanıcının Görecekleri

            /*Anasayfa_Header
             * Anasayfa_Link
             * Ziyaret_Islemler_Header
             * Ziyaret_Takvimi_Link
             * Ziyaret_Planı_Link
             * Doktor_İşlemleri_Header
             * Doktor_Listesi_Olustur_Link
             * Doktor_Ekle_Çıkar_Link
             * Eczane_İşlemleri_Header
             * Eczane_Listesi_Olustur_Link
             * Eczane_Ekle_Çıkar_Link
             * Sipariş_İşlemleri_Header
             * Sipariş_Olustur_Link
             * Sipariş_Durumu_Link
             * Birim_Fiyat_Hesapla_Link
             * Genel_İşlemler_Header
             * Masraf_Girişi_Link
             * Numune_Talebi_Link
             * Materyal_Talebi_Link
             * Sınav_Link
             * 
             * 
             * 
             * 
             * 
             */

            //Admin Görecekleri
            /*
             * Admin_İşlemleri_Hedaer
             * Urun_Ekle_Link
             * Kullanıcı_Olustur_Link
             * Sınav_İşlemleri_Header
             * Soru_Olustur_Link
             * Sınav_Olustur_Link
             */

        }
        public class Numune_Tablo
        {
            public string AD { get; set; }
            public string Soyad { get; set; }
            public string KullanıcıAD { get; set; }
            public string Grup_Tam_Ad { get; set; }
            public string Grup_Kısa_Ad { get; set; }
            public string Bolge_Ad { get; set; }
            public string Kullanıcı_Profil_Photo { get; set; }

        }
        public static string Profil_Bilgileri()
        {
            //select * from listeler where Kullanıcı_Id=(select KullanıcıID from Kullanıcı where KullanıcıAD='recai') and cins = 0
            var queryWithForJson = "use kasa " +
                "select AD,Soyad,KullanıcıAD,Grup_Tam_Ad, Grup_Kısa_Ad,Bolge_Ad,Kullanıcı_Profil_Photo from Kullanıcı " +
                "inner join Bolgeler " +
                "on Kullanıcı_Bogle=Bolgeler.Bolge_Id  " +
                "inner join Gruplar " +
                "on Kullanıcı_Grup=Grup_Id " +
                "where KullanıcıAD COLLATE Latin1_general_CS_AS = @1";
            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);
            cmd.Parameters.AddWithValue("@1", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());


            List<Numune_Tablo> tablo_Doldur_Classes = new List<Numune_Tablo>();

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
                    var Tablo_Doldur_Class_ = new Numune_Tablo
                    {
                        AD = reader.GetValue(0).ToString(),
                        Soyad = reader.GetValue(1).ToString(),
                        KullanıcıAD = reader.GetValue(2).ToString(),
                        Grup_Tam_Ad = reader.GetValue(3).ToString(),
                        Grup_Kısa_Ad = reader.GetValue(4).ToString(),
                        Bolge_Ad = reader.GetValue(5).ToString(),
                        Kullanıcı_Profil_Photo = reader.GetValue(6).ToString()

                    };
                    tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
                }
            }
            conn.Close();
            return JsonConvert.SerializeObject(tablo_Doldur_Classes);



        }//Masrafı_Kaldır


        protected void Cıkıs_Yap_ServerClick(object sender, EventArgs e)
        {
            Response.Cookies.Remove(".ASPXAUTH");
            Response.Redirect("default.aspx");
            System.Web.HttpContext.Current.Session.Abandon();

        }
    }
}