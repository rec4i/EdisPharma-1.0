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
    public partial class Profil : System.Web.UI.Page
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
        [System.Web.Services.WebMethod]
        public static string Profil_Bilgileri(string parametre)
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
        [System.Web.Services.WebMethod]
        public static string Şifre_Değiştir(string Eski_Sifre,string Yeni_Sifre, string Yeni_Sifre_Tekrar )
        {
            //select * from listeler where Kullanıcı_Id=(select KullanıcıID from Kullanıcı where KullanıcıAD='recai') and cins = 0
            var queryWithForJson = "use kasa " +
                 "declare @Eski_Şifre nvarchar(50) = (select KullanıcıPass from Kullanıcı where KullanıcıID=(select KullanıcıID from Kullanıcı where KullanıcıAD COLLATE Latin1_general_CS_AS =@kullanıcı_Adı))  " +
                 "if(@Eski_Şifre COLLATE Latin1_general_CS_AS =@Eski_Şifre_Gelen COLLATE Latin1_general_CS_AS ) " +
                 "begin " +
                 "if(@Gelen_Şifre COLLATE Latin1_general_CS_AS = @Gelen_Şifre_Tekrar COLLATE Latin1_general_CS_AS) " +
                 "begin " +
                 "update Kullanıcı set KullanıcıPass=@Gelen_Şifre where KullanıcıID=(select KullanıcıID from Kullanıcı where KullanıcıAD COLLATE Latin1_general_CS_AS =@kullanıcı_Adı) " +
                 "select 1;" +
                 "end " +
                 "end " +
                 "";

            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);
            cmd.Parameters.AddWithValue("@kullanıcı_Adı", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
            cmd.Parameters.AddWithValue("@Gelen_Şifre", Yeni_Sifre);
            cmd.Parameters.AddWithValue("@Gelen_Şifre_Tekrar", Yeni_Sifre_Tekrar);
            cmd.Parameters.AddWithValue("@Eski_Şifre_Gelen", Eski_Sifre);

            conn.Open();

            string a="";

            var reader = cmd.ExecuteReader();
            if (!reader.HasRows)
            {
                while (reader.Read())
                {
                    a += reader.GetValue(0).ToString();
                }
                conn.Close();
                return a;
            }
            else
            {
                conn.Close();
                return "0";
            }

          

            
           


        }//Masrafı_Kaldır
        [System.Web.Services.WebMethod]
        public static string Profil_Resimi_Degistir(string Resim_Base64)
        {
            //select * from listeler where Kullanıcı_Id=(select KullanıcıID from Kullanıcı where KullanıcıAD='recai') and cins = 0
            var queryWithForJson = "use kasa " +
                "update Kullanıcı set Kullanıcı_Profil_Photo = @Resim_Base64 where KullanıcıID=(select KullanıcıID from Kullanıcı where KullanıcıAD COLLATE Latin1_general_CS_AS =@kullanıcı_Adı)" +
              
                 "";

            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);
            cmd.Parameters.AddWithValue("@kullanıcı_Adı", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
            cmd.Parameters.AddWithValue("@Resim_Base64", "data:image/webp;base64,"+ Resim_Base64);
    

            conn.Open();

            string a = "";

            var reader = cmd.ExecuteReader();
            if (!reader.HasRows)
            {
                while (reader.Read())
                {
                    a += reader.GetValue(0).ToString();
                }
                conn.Close();
                return a;
            }
            else
            {
                conn.Close();
                return "0";
            }







        }//Masrafı_Kaldır
    }
}