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
    public partial class Sınav : System.Web.UI.Page
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
        public static string Sınavı_Başlat(string parametre)
        {

            var queryWithForJson = " " +
                "if ((select count(*) from Kullanıcının_Girecegi_Sınavlar inner join Sınavlar_ on Sınav_Id=Kullanıcının_Girecegi_Sınav where Kullanıcı_Id=(select Kullanıcı.KullanıcıID from Kullanıcı where KullanıcıAD COLLATE Latin1_general_CS_AS =@Kullanıcı_Id) and DATEADD(MINUTE,Sınav_Suresi,Sınav_Tar) >=GETDATE() and Sınav_Tar <=GETDATE()  and Kullanıcının_Girecegi_Sınav_Id=@Sınav_Id)>0) " +
                "begin; " +
                "if((select count(*) from Kullanıcının_Girecegi_Sınavlar where Kullanıcı_Id=(select Kullanıcı.KullanıcıID from Kullanıcı where KullanıcıAD COLLATE Latin1_general_CS_AS =@Kullanıcı_Id) and Sınavı_Baslattımı=1)>=1) " +
                "begin; " +
                "if((select Kullanıcının_Girecegi_Sınav_Id from Kullanıcının_Girecegi_Sınavlar where Kullanıcının_Girecegi_Sınav_Id=@Sınav_Id) " +
                "= " +
                "(select Kullanıcının_Girecegi_Sınav_Id from Kullanıcının_Girecegi_Sınavlar where Kullanıcı_Id=(select Kullanıcı.KullanıcıID from Kullanıcı where KullanıcıAD COLLATE Latin1_general_CS_AS =@Kullanıcı_Id) and Sınavı_Baslattımı=1)) " +
                "begin; " +
                "select '2'; " +
                "end; " +
                "else " +
                " begin; " +
                "update Kullanıcının_Girecegi_Sınavlar set Kullanıcının_Girecegi_Sınavlar.Sınavı_Baslattımı=0 where Kullanıcının_Girecegi_Sınav_Id=(select Kullanıcının_Girecegi_Sınav_Id from Kullanıcının_Girecegi_Sınavlar where Kullanıcı_Id=(select Kullanıcı.KullanıcıID from Kullanıcı where KullanıcıAD COLLATE Latin1_general_CS_AS =@Kullanıcı_Id) and Sınavı_Baslattımı=1) " +
                "update Kullanıcının_Girecegi_Sınavlar set Kullanıcının_Girecegi_Sınavlar.Sınavı_Baslattımı=1 where Kullanıcının_Girecegi_Sınav_Id=@Sınav_Id " +
                "Select '2' " +
                "end; " +
                "end; " +
                "else " +
                "begin; " +
                "update Kullanıcının_Girecegi_Sınavlar set Kullanıcının_Girecegi_Sınavlar.Sınavı_Baslattımı=1 where Kullanıcının_Girecegi_Sınav_Id=@Sınav_Id " +
                "select '2'; "+
                "end; " +
                "end; " +
                "Else " +
                " begin; " +
                "select '0'; " +
                 "end; " +
                "";
               
            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);

            cmd.Parameters.AddWithValue("@Kullanıcı_Id", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());//@baslagıc_Tar//@bitis_tar
            cmd.Parameters.AddWithValue("@Sınav_Id",parametre);


            conn.Open();

            var reader = cmd.ExecuteReader();

            string a = "";
            while (reader.Read())
            {
                a += reader.GetValue(0).ToString();
            }


            if (a == "")
            {
                return "hata";
            }
            else
            {
                return a;
            }

        }
        [System.Web.Services.WebMethod]
        public static string Sınav_Listesi(string parametre)
        {

            var queryWithForJson = "select Kullanıcının_Girecegi_Sınav_Id,Kullanıcının_Girecegi_Sınav,Kullanıcı_Id,Sınavı_Baslattımı,Sınavı_Bittimi,Sınav_Id,Sınav_Tar,Sınav_Suresi,Sınav_Adı,Sınavlar_.Soru_Listesi,Soru_Sayısı from Kullanıcının_Girecegi_Sınavlar inner join Sınavlar_ on Sınav_Id=Kullanıcının_Girecegi_Sınav where Silinmismi=0 and Kullanıcı_Id=(select Kullanıcı.KullanıcıID from Kullanıcı where KullanıcıAD COLLATE Latin1_general_CS_AS =@kullanıcı_Adı) and Sınavı_Bittimi=0 and  DATEADD(second,(Sınav_Suresi*Soru_Sayısı),Sınav_Tar) >=GETDATE()";
            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);

            cmd.Parameters.AddWithValue("@kullanıcı_Adı", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());//@baslagıc_Tar//@bitis_tar

            
            conn.Open();

            var reader = cmd.ExecuteReader();

            string a = "";
            a += DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss")+"!";
            while (reader.Read())
            {
                a += reader.GetValue(0).ToString() + "/" + reader.GetValue(1).ToString() + "/" + reader.GetValue(2).ToString() + "/" + reader.GetValue(3).ToString() + "/" + reader.GetDateTime(6).ToString("yyyy-MM-dd HH:mm:ss") + "/" + reader.GetValue(7).ToString() + "/" + reader.GetValue(8).ToString() + "!";
            }


            if (a == DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"))
            {
                return "hata";
            }
            else
            {
                return a.Substring(0, a.Length - 1);
            }

        }
        public class Sınav_Grafik_Tablo
        {
            public string Sınav_Tar { get; set; }
            public string Sınav_Not { get; set; }
          

        }
        [System.Web.Services.WebMethod]
        public static string Sınav_Grafik(string Sınav_Id)
        {
            var queryWithForJson = "use kasa   " +
                "select Sınav_Tar,Sınav_Sonucu from Kullanıcının_Girecegi_Sınavlar  " +
                "inner join Sınavlar_ " +
                "on Kullanıcının_Girecegi_Sınav=Sınav_Id  " +
                "where Açıklandımı=1 and Kullanıcı_Id=(select Kullanıcı.KullanıcıID from Kullanıcı where KullanıcıAD COLLATE Latin1_general_CS_AS =@kullanıcı_Adı) " +
                "" +
              
              
                "";

            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);
            conn.Open();
            cmd.Parameters.AddWithValue("@kullanıcı_Adı", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());



            List<Sınav_Grafik_Tablo> tablo_Doldur_Classes = new List<Sınav_Grafik_Tablo>();


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
                    var Tablo_Doldur_Class_ = new Sınav_Grafik_Tablo
                    {
                        Sınav_Tar = reader.GetDateTime(0).ToString("dd/MM/yyyy"),
                        Sınav_Not = reader.GetValue(1).ToString()
                     
                    };
                    tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
                }
            }





            conn.Close();
            return JsonConvert.SerializeObject(tablo_Doldur_Classes);


        }
    }
}