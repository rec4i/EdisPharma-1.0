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
    public partial class Sınav_Olustur : System.Web.UI.Page
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
        [System.Web.Services.WebMethod]
        public static string Soru_Sayısı(string parametre)
        {
            var queryWithForJson = "use kasa select COUNT(*) from Sorular  where Soru_liste_Id=@1";
            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);
            cmd.Parameters.AddWithValue("@1", parametre);

            conn.Open();

            var reader = cmd.ExecuteReader();

            string a = "";
            while (reader.Read())
            {
                a += reader.GetValue(0).ToString() ;
            }
            if (a == "")
            {
                conn.Close();
                return "0";
            }
            else
            {
                conn.Close();
                return a;
            }


        }
        public class Şehir
        {
            public string Sınav_Adı_ { get; set; }
            public string Soru_Listesi { get; set; }
            public string Soru_Sayısı { get; set; }
            public string Tarih { get; set; }
            public string Sınav_Suresi { get; set; }
            public string Sınav_Id { get; set; }
        }
        [System.Web.Services.WebMethod]
        public static string Sınav_Listesi(string parametre)
        {
            var queryWithForJson = "use kasa select Sınav_Adı,Soru_Listesi,Soru_Sayısı,Sınav_Tar,Sınav_Suresi,Sınav_Id from Sınavlar_  where Silinmismi=0";
            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);
            conn.Open();




            List<Şehir> tablo_Doldur_Classes = new List<Şehir>();


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
                    var Tablo_Doldur_Class_ = new Şehir
                    {
                        Sınav_Adı_ = reader.GetValue(0).ToString(),
                        Soru_Listesi = reader.GetValue(1).ToString(),
                        Soru_Sayısı = reader.GetValue(2).ToString(),
                        Tarih = reader.GetDateTime(3).ToString("dd/MM/yyyy HH:mm"),
                        Sınav_Suresi = reader.GetValue(4).ToString(),
                        Sınav_Id = reader.GetValue(5).ToString()

                    };
                    tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
                }
            }
            conn.Close();
            return JsonConvert.SerializeObject(tablo_Doldur_Classes);


        }//
        [System.Web.Services.WebMethod]
        public static string Sınavı_Sil(string parametre)
        {
            var queryWithForJson = "use kasa " +
                "update Sınavlar_ set Silinmismi=1 where Sınav_Id=@1 " +
               
                " ";
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
                conn.Close();
                return "0-Hiç Liste Bulunamadı Lütfen Yeni Liste Oluşturunuz";
            }
            else
            {
                conn.Close();
                return a.Substring(0, a.Length - 1);
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
                conn.Close();
                return "0-Hiç Liste Bulunamadı Lütfen Yeni Liste Oluşturunuz";
            }
            else
            {
                conn.Close();
                return a.Substring(0, a.Length - 1);
            }


        }
        [System.Web.Services.WebMethod]
        public static string Sınavı_Olustur(string parametre)
        {
            //var queryWithForJson = "use kasa " +
            //    "declare @sınav_bas datetime=@Sınav_Tar " +
            //    "declare @sınav_Son datetime=DATEADD(MINUTE,@Sınav_Suresi,@Sınav_Tar) " +
            //    "if((select COUNT(*) from Sınavlar_ where Sınav_Tar between @sınav_bas and @sınav_Son )<=0) " +
            //    "begin; " +
            //    "" +
            //    "declare @Soru_Id table (id int);" +
            //    "declare @Sınav_Id table (id int);" +
            //    "insert into Sınavlar_ (Sınav_Tar,Sınav_Suresi,Sınav_Adı,Soru_Listesi,Soru_Sayısı) output inserted.Sınav_Id into @Sınav_Id values(@Sınav_Tar,@Sınav_Suresi,@Sınav_Adı,@Soru_Listesi,@Soru_Sayısı)  " +
            //    "Declare @Kullanıcı_Sayısı int ;" +
            //    "set @Kullanıcı_Sayısı = (select count(*) from Kullanıcı);" +
            //    "declare @Sayaç int=0;" +
            //    "declare @deneme table (id int Identity(1,1) , deneme int) " +
            //    "insert into @deneme (deneme) select Kullanıcı.KullanıcıID from Kullanıcı  " +
            //    "insert into Kullanıcının_Girecegi_Sınavlar(Kullanıcının_Girecegi_Sınav,Kullanıcı_Id) select (select top 1 * from @Sınav_Id) , KullanıcıID from Kullanıcı  " +
            //    "while @Sayaç<@Kullanıcı_Sayısı  " +
            //    "begin  " +
            //    "insert into Kullanıcının_Soruları(Kullanıcı_ıd,Soru_ıd,Sınav_Id) output inserted.Kullanıcının_Soruları_Id into @Soru_Id select  KullanıcıID,Soru_Id ,(select top 1 * from @Sınav_Id) from Kullanıcı join (select top (@Soru_Sayısı) * from Sorular order by NEWID()) Sorular on KullanıcıID=(select deneme from @deneme where id= (@Sayaç +1 )) where Soru_liste_Id=@Soru_Listesi order  by KullanıcıID  " +
            //    "update Kullanıcının_Soruları set Bu_Sorudamı=1 where Kullanıcının_Soruları_Id=(select top 1 id from @Soru_Id order by id ) " +
            //    "delete from @Soru_Id " +
            //    "set @Sayaç=@Sayaç+1  " +
            //    "end  " +
            //    "select '1';" +
            //    "end; " +
            //    "else " +
            //    "begin; " +
            //    "select '0' " +
            //    "end; " +
            //    "";

            var queryWithForJson = "use kasa " +
                " declare @sınav_bas datetime=@Sınav_Tar  " +
                " declare @sınav_Son datetime=DATEADD(MINUTE,@Sınav_Suresi,@Sınav_Tar)  " +
                "  if((select COUNT(*) from Sınavlar_ where Sınav_Tar between @sınav_bas and @sınav_Son )<=10)  " +
                " begin;  " +
                "declare @Soru_Id table (id int); " +
                "declare @Sınav_Id table (id int); " +
                "insert into Sınavlar_ (Sınav_Tar,Sınav_Suresi,Sınav_Adı,Soru_Listesi,Soru_Sayısı) output inserted.Sınav_Id into @Sınav_Id values(@Sınav_Tar,@Sınav_Suresi,@Sınav_Adı,@Soru_Listesi,@Soru_Sayısı)   " +
                "Declare @Kullanıcı_Sayısı int ; " +
                " set @Kullanıcı_Sayısı = (select count(*) from Kullanıcı); " +
                "declare @Sayaç int=0; " +
                "declare @deneme table (id int Identity(1,1) , deneme int)  " +
                "declare @Kullanıcının_Gireceği_Sınavlar_ıd_ table (id int Identity(1,1) , Kullanıcının_Gireceği_Sınav_Id int,Kullanıcı_Id_ int)  " +
                "  insert into @deneme (deneme) select Kullanıcı.KullanıcıID from Kullanıcı   " +
                "insert into Kullanıcının_Girecegi_Sınavlar(Kullanıcının_Girecegi_Sınav,Kullanıcı_Id,Kalan_Zaman) output inserted.Kullanıcının_Girecegi_Sınav_Id, inserted.Kullanıcı_Id into @Kullanıcının_Gireceği_Sınavlar_ıd_  select (select top 1 id from @Sınav_Id) , KullanıcıID,(dateadd(SECOND,(@Sınav_Suresi*@Soru_Sayısı),cast('00:00:00.0000000' as time))) from Kullanıcı where Kullanıcı_Bogle=(select Kullanıcı_Bogle from Kullanıcı where KullanıcıAD=@Kullanıcı_Ad ) and Kullanıcı_Grup=4  " +
                "while @Sayaç<@Kullanıcı_Sayısı  " +
                "begin " +
                "insert into Kullanıcının_Soruları(Kullanıcının_Gireceği_Sınavlar_Id,Kullanıcı_ıd,Soru_ıd,Sınav_Id)  " +
                "output inserted.Kullanıcının_Soruları_Id into @Soru_Id  " +
                "select  (select Kullanıcının_Gireceği_Sınav_Id from @Kullanıcının_Gireceği_Sınavlar_ıd_ where Kullanıcı_Id_=KullanıcıID) " +
                ",KullanıcıID,Soru_Id ,(select top 1 * from @Sınav_Id)  " +
                "from Kullanıcı  " +
                "join (select top (@Soru_Sayısı) * from Sorular where Sorular.Soru_liste_Id=@Soru_Listesi order by NEWID()) Sorular " +
                "on KullanıcıID=(select deneme from @deneme where id= (@Sayaç +1 ))  " +
                " where Soru_liste_Id=@Soru_Listesi order  by KullanıcıID  " +
                "update Kullanıcının_Soruları set Bu_Sorudamı=1 where Kullanıcının_Soruları_Id=(select top 1 id from @Soru_Id order by id )  " +
                "delete from @Soru_Id  " +
                "  set @Sayaç=@Sayaç+1   " +
                "     end   " +
                "  select '1'; " +
                "  end;  " +
                "   else  " +
                " begin;  " +
                "select '0'  " +
                "   end;  " +
                "";





            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);
            //cmd.Parameters.AddWithValue("@Sınav_Tar", "2021-02-21 17:10:00");
            //cmd.Parameters.AddWithValue("@Sınav_Suresi", 40);
            //cmd.Parameters.AddWithValue("@Sınav_Adı", "deneme 112");
            //cmd.Parameters.AddWithValue("@Soru_Listesi", 1);
            //cmd.Parameters.AddWithValue("@Soru_Sayısı", 3);
            cmd.Parameters.AddWithValue("@Sınav_Tar", Convert.ToDateTime( parametre.Split('*')[0]));
            cmd.Parameters.AddWithValue("@Sınav_Suresi",Convert.ToInt32(parametre.Split('*')[1]));
            cmd.Parameters.AddWithValue("@Sınav_Adı", parametre.Split('*')[2]);
            cmd.Parameters.AddWithValue("@Soru_Listesi",Convert.ToInt32( parametre.Split('*')[3]));
            cmd.Parameters.AddWithValue("@Soru_Sayısı",Convert.ToInt32( parametre.Split('*')[4]));
            cmd.Parameters.AddWithValue("@Kullanıcı_Ad", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());



            conn.Open();

            var reader = cmd.ExecuteReader();

            string a = "";
            while (reader.Read())
            {
                a += reader.GetValue(0).ToString();
            }
            if (a == "")
            {
                conn.Close();
                return "2";
            }
            else
            {
                conn.Close();
                return a;
            }


        }
    }
}