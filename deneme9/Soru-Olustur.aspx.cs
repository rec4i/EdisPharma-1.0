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
    public partial class Soru_Olustur : System.Web.UI.Page
    {
        public static string Kullanıcı_Adı = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["kullanici"] != null)
            {
                Kullanıcı_Adı = Session["Kullanici"].ToString();
                //Response.Write("Hoşgeldin " + Session["kullanici"]);
                SqlC.con.Close();
            }
            else
            {
                 
                SqlC.con.Close();
            }
        }
        [System.Web.Services.WebMethod]
        public static string Sorular_Listeleri_Listele(string parametre)
        {
            var queryWithForJson = "use kasa select * from Soru_Liste where Kullanıcı_Id=(select KullanıcıID from Kullanıcı where KullanıcıAD COLLATE Latin1_general_CS_AS ='" + FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString() + "') ";
            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);


            conn.Open();

            var reader = cmd.ExecuteReader();

            string a = "";
            while (reader.Read())
            {
                a += reader.GetValue(0).ToString() + "-" + reader.GetValue(1).ToString() + "!";
            }
            if (a == "")
            {
                return "0-Hiç Liste Bulunamadı Lütfen Yeni Liste Oluşturunuz";
            }
            else
            {
                return a.Substring(0, a.Length - 1);
            }


        }
        [System.Web.Services.WebMethod]
        public static string Sorular_Yeni_Soru_Ekle(string parametre)
        {
            var queryWithForJson = "use kasa insert into Soru_Liste (Soru_Liste_Ad, Kullanıcı_Id) values(@1,(select KullanıcıID from Kullanıcı where KullanıcıAD COLLATE Latin1_general_CS_AS ='" + FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString() + "')); select * from Soru_Liste where Kullanıcı_Id=(select KullanıcıID from Kullanıcı where KullanıcıAD COLLATE Latin1_general_CS_AS ='" + Kullanıcı_Adı + "')";
            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);

            cmd.Parameters.AddWithValue("@1", parametre);
            conn.Open();

            var reader = cmd.ExecuteReader();

            string a = "";
            while (reader.Read())
            {
                a += reader.GetValue(0).ToString() + "-" + reader.GetValue(1).ToString() + "!";
            }
            if (a == "")
            {
                return "0-Hiç Liste Bulunamadı Lütfen Yeni Liste Oluşturunuz";
            }
            else
            {
                return a.Substring(0, a.Length - 1);
            }


        }
        [System.Web.Services.WebMethod]
        public static string Sorular_Yeni_Liste_Ekle(string parametre)
        {
            //select * from listeler where Kullanıcı_Id=(select KullanıcıID from Kullanıcı where KullanıcıAD='recai') and cins = 0
            var queryWithForJson = "use kasa;" +
                "declare @outpuıd_table table (id int); " +
                "declare @outpuıd int ;" +
                "insert into Sorular(Soru_Kendisi,Soru_liste_Id) OUTPUT inserted.Soru_Id into @outpuıd_table   values(@Soru,@Liste_Id); " +
                "set @outpuıd = (select  * from  @outpuıd_table);" +
                "insert into Şıklar(Soru_Id,Dogrumu,Sık_txt) values(@outpuıd,1,@Soru_1);" +
                "insert into Şıklar(Soru_Id,Dogrumu,Sık_txt) values(@outpuıd,0,@Soru_2);" +
                "insert into Şıklar(Soru_Id,Dogrumu,Sık_txt) values(@outpuıd,0,@Soru_3);" +
                "insert into Şıklar(Soru_Id,Dogrumu,Sık_txt) values(@outpuıd,0,@Soru_4);" +
                "insert into Şıklar(Soru_Id,Dogrumu,Sık_txt) values(@outpuıd,0,@Soru_5);" +
                 "select Soru_Kendisi,Sık_txt,Sorular.Soru_Id from Sorular inner join Şıklar on Sorular.Soru_Id=Şıklar.Soru_Id where Soru_liste_Id=@Liste_Id and Dogrumu=1";

            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);
            cmd.Parameters.AddWithValue("@Liste_Id", parametre.Split('-')[0]);
            cmd.Parameters.AddWithValue("@Soru", parametre.Split('-')[1]);
            cmd.Parameters.AddWithValue("@Soru_1", parametre.Split('-')[2]);
            cmd.Parameters.AddWithValue("@Soru_2", parametre.Split('-')[3]);
            cmd.Parameters.AddWithValue("@Soru_3", parametre.Split('-')[4]);
            cmd.Parameters.AddWithValue("@Soru_4", parametre.Split('-')[5]);
            cmd.Parameters.AddWithValue("@Soru_5", parametre.Split('-')[6]);

            conn.Open();

            var reader = cmd.ExecuteReader();

            string a = "";
            while (reader.Read())
            {
                a += reader.GetValue(0).ToString() + "-" + reader.GetValue(1).ToString() +"-"+reader.GetValue(2)+ "!";
            }
            if (a == "")
            {
                return "";
            }
            else
            {
                return a.Substring(0, a.Length - 1);
            }


        }
        [System.Web.Services.WebMethod]
        public static string Soruları_Tabloya_doldur(string parametre)
        {
            //select * from listeler where Kullanıcı_Id=(select KullanıcıID from Kullanıcı where KullanıcıAD='recai') and cins = 0
            var queryWithForJson = "use kasa; " +
                "select Soru_Kendisi,Sık_txt,Sorular.Soru_Id from Sorular inner join Şıklar on Sorular.Soru_Id=Şıklar.Soru_Id where Soru_liste_Id=@Liste_Id and Dogrumu=1";
                

            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);
            cmd.Parameters.AddWithValue("@Liste_Id", parametre.Split('-')[0]);
         

            conn.Open();

            var reader = cmd.ExecuteReader();

            string a = "";
            while (reader.Read())
            {
                a += reader.GetValue(0).ToString() + "-" + reader.GetValue(1).ToString() + "-" + reader.GetValue(2) + "!";
            }
            if (a == "")
            {
                return "";
            }
            else
            {
                return a.Substring(0, a.Length - 1);
            }


        }
        [System.Web.Services.WebMethod]
        public static string Soru_İncele(string parametre)
        {
            //select * from listeler where Kullanıcı_Id=(select KullanıcıID from Kullanıcı where KullanıcıAD='recai') and cins = 0
            var queryWithForJson = "use kasa; " +
                "select  Sorular.Soru_Id,Şıklar.Sık_Id,Soru_Kendisi,Şıklar.Sık_txt from Sorular inner join Şıklar on Sorular.Soru_Id=Şıklar.Soru_Id where Sorular.Soru_Id=@Liste_Id";


            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);
            cmd.Parameters.AddWithValue("@Liste_Id", parametre.Split('-')[0]);


            conn.Open();

            var reader = cmd.ExecuteReader();

            string a = "";
            while (reader.Read())
            {
                a += reader.GetValue(0).ToString() + "-" + reader.GetValue(1).ToString() + "-" + reader.GetValue(2) + "-" + reader.GetValue(3) + "!";
            }
            if (a == "")
            {
                return "";
            }
            else
            {
                return a.Substring(0, a.Length - 1);
            }


        }
        [System.Web.Services.WebMethod]
        public static string Soru_Kaldır(string parametre)
        {
            //select * from listeler where Kullanıcı_Id=(select KullanıcıID from Kullanıcı where KullanıcıAD='recai') and cins = 0
            var queryWithForJson = "use kasa; " +
                "delete from Sorular where Soru_Id=@Soru_Id;" +
                "delete from Şıklar where Soru_Id = @Soru_Id;";



            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);
            cmd.Parameters.AddWithValue("@Soru_Id", parametre.Split('-')[0]);


            conn.Open();

            var reader = cmd.ExecuteReader();

            string a = "";
            while (reader.Read())
            {
                a += reader.GetValue(0).ToString() + "-" + reader.GetValue(1).ToString() + "-" + reader.GetValue(2) + "-" + reader.GetValue(3) + "!";
            }
            if (a == "")
            {
                return "";
            }
            else
            {
                return a.Substring(0, a.Length - 1);
            }


        }

    }
}