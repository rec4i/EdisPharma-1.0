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
    public partial class Takvim : System.Web.UI.Page
    {
      
        public string Reques = null;
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
        public class Eczane_Listleri_
        {
            public string Ziy_Dty_ID { get; set; }
            public string Doktor_Ad { get; set; }
            public string Unite_Txt { get; set; }
            public string Brans_Txt { get; set; }
            public string TownName { get; set; }
            public string Ziyaret_Durumu { get; set; }

        }
        [System.Web.Services.WebMethod]
        public static string Modal_Doldurma_Doktor(string parametre)
        {
            var queryWithForJson = "use kasa select Ziy_Dty_ID,Doktor_Ad,Unite_Txt,Brans_Txt,TownName,Ziyaret_Durumu from Ziyaret_Detay inner join Doktors on Ziyaret_Detay.Doktor_Id=Doktors.Doktor_Id inner join Branchs on Doktors.Doktor_Brans_Id=Branchs.Brans_ID " +
                "inner join Unite on Doktors.Doktor_Unite_ID=Unite.Unite_ID inner join Town on Town.TownID=Unite.Brick__Id inner join City on Town.CityID=City.CityID where Ziy_Gnl_Id=@1";
            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);

            cmd.Parameters.AddWithValue("@1", parametre);

            List<Eczane_Listleri_> tablo_Doldur_Classes = new List<Eczane_Listleri_>();

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
                    var Tablo_Doldur_Class_ = new Eczane_Listleri_
                    {
                        Ziy_Dty_ID = reader.GetValue(0).ToString(),
                        Doktor_Ad = reader.GetValue(1).ToString(),
                        Unite_Txt = reader.GetValue(2).ToString(),
                        Brans_Txt = reader.GetValue(3).ToString(),
                        TownName = reader.GetValue(4).ToString(),
                        Ziyaret_Durumu = reader.GetValue(5).ToString(),

                    };
                    tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
                }
            }
            conn.Close();
            return JsonConvert.SerializeObject(tablo_Doldur_Classes);


        }

        public class Modal_Dolruma_Tablo
        {
            public string Ziy_Dty_ID { get; set; }
            public string Eczane_Adı { get; set; }
            public string TownName { get; set; }
            public string Ziyaret_Durumu { get; set; }

            public string Eczane_Tip { get; set; }

        }
        [System.Web.Services.WebMethod]
        public static string Modal_Doldurma_Eczane(string parametre)
        {
            
            
            var queryWithForJson = "use kasa select Ziy_Dty_ID,Eczane_Adı,TownName,Ziyaret_Durumu,Eczane_Tip.Eczane_Tip from Ziyaret_Detay inner join Eczane on Eczane.Eczane_Id=Ziyaret_Detay.Eczane_Id " +
                "full join Eczane_Tip " +
                "on Eczane.Eczane_Tip=Eczane_Tip.Eczane_Tip_Id " +
                "inner join Town on Eczane.Eczane_Brick=Town.TownID where Ziy_Gnl_Id=@1";
            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);

            cmd.Parameters.AddWithValue("@1", parametre);

            List<Modal_Dolruma_Tablo> tablo_Doldur_Classes = new List<Modal_Dolruma_Tablo>();

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
                    var Tablo_Doldur_Class_ = new Modal_Dolruma_Tablo
                    {
                        Ziy_Dty_ID = reader.GetValue(0).ToString(),
                        Eczane_Adı = reader.GetValue(1).ToString(),
                        TownName = reader.GetValue(2).ToString(),
                        Ziyaret_Durumu = reader.GetValue(3).ToString(),
                        Eczane_Tip = reader.GetValue(4).ToString(),
                       

                    };
                    tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
                }
            }
            conn.Close();
            return JsonConvert.SerializeObject(tablo_Doldur_Classes);


        }

      
        [System.Web.Services.WebMethod]
        public static string Ziyareti_Güncelle_Edilmedi(string Ziyaret_Notu,string Ziyaret_Id)
        {
            //var queryWithForJson = "use kasa " +
            //   "declare @bu_Gun nvarchar(50) =(select Ziy_Tar from Ziyaret_Detay inner join Ziyaret_Genel on Ziyaret_Detay.Ziy_Gnl_Id=Ziyaret_Genel.ID where Ziyaret_Detay.Ziy_Dty_ID=@1) " +
            //   "declare @Bu_Gun_Bas nvarchar(50); " +
            //   "declare @Bu_Gun_Son nvarchar(50); " +
            //   "declare @Bu_Gun_Bas_parse datetime; " +
            //   "declare @Bu_Gun_Son_parse datetime; " +
            //   "set @Bu_Gun_Bas =@bu_Gun+' '+(select cast(Ziyaret_Bas  as nvarchar(11)) from Ziyaret_Zamanı) " +
            //   "set @Bu_Gun_Son =@bu_Gun+' '+(select cast(Ziyaret_Son  as nvarchar(11)) from Ziyaret_Zamanı) " +
            //   "set @Bu_Gun_Bas_parse =CAST(@Bu_Gun_Bas as datetime) " +
            //   "set @Bu_Gun_Son_parse =CAST(@Bu_Gun_Son as datetime) " +
            //   "if((getdate()>@Bu_Gun_Bas)and(getdate()<@Bu_Gun_Son_parse)) " +
            //   "begin " +
            //   "" +
            //   "if (" +
            //   "(" +
            //   "select  Onay_Durum from Ziyaret_Detay " +
            //   "inner join Ziyaret_Genel " +
            //   "on Ziyaret_Genel.ID=Ziyaret_Detay.Ziy_Gnl_Id " +
            //   "inner join Ziyaret_Onay " +
            //   "on Ziyaret_Genel.Ziyaret_Onay_Id=Ziyaret_Onay.Ziyaret_Onay_Id " +
            //   "where   Ziyaret_Detay.Ziy_Dty_ID=@1  " +
            //   ")" +
            //   "= 1" +
            //   ") " +
            //   "begin ;" +
            //   "update Ziyaret_Detay set Ziyaret_Durumu=1,Ziyaret_Notu=@Ziyaret_Notu where Ziy_Dty_ID=@1 " +
            //   "if ((select count(*) from @Urun_Listesi)>0) " +
            //   "begin; " +
            //   " delete from Ziyaret_Calışılan_Urunler where Ziyaret_Detay_Id=@1 " +
            //   "insert into Ziyaret_Calışılan_Urunler (Ziyaret_Detay_Id,Calışılan_Urun_Id) select @1,Urun_Id_ from @Urun_Listesi " +
            //   "end " +
            //   "insert into Son_Yapılan_Islem (İslem_Tipi,Kullanıcı_Id,İslem_Tar) values(2, " +
            //       "(select KullanıcıID from Kullanıcı where KullanıcıAD COLLATE Latin1_general_CS_AS=@1), " +
            //       "GETDATE() " +
            //       ") " +
            //        "end;" +
            //       " else " +
            //       "begin; " +
            //       "select 3 ;" +
            //       "end;" +

            //     "end; " +
            //   "else  " +
            //   "begin " +
            //   "select 2; " +
            //   "end;" +

            //   "";

            var queryWithForJson = "declare @bu_Gun nvarchar(50) =(select Ziy_Tar from Ziyaret_Detay inner join Ziyaret_Genel on Ziyaret_Detay.Ziy_Gnl_Id=Ziyaret_Genel.ID where Ziyaret_Detay.Ziy_Dty_ID=@1) " +
                        "               declare @Bu_Gun_Bas nvarchar(50); " +
                        "               declare @Bu_Gun_Son nvarchar(50); " +
                        "               declare @Bu_Gun_Bas_parse datetime; " +
                        "               declare @Bu_Gun_Son_parse datetime; " +
                        "               set @Bu_Gun_Bas =@bu_Gun+' '+(select cast(Ziyaret_Bas  as nvarchar(11)) from Ziyaret_Zamanı) " +
                        "               set @Bu_Gun_Son =@bu_Gun+' '+(select cast(Ziyaret_Son  as nvarchar(11)) from Ziyaret_Zamanı) " +
                        "               set @Bu_Gun_Bas_parse =CAST(@Bu_Gun_Bas as datetime) " +
                        "               set @Bu_Gun_Son_parse =CAST(@Bu_Gun_Son as datetime) " +
                        "              if(((getdate()>@Bu_Gun_Bas)and(getdate()<@Bu_Gun_Son_parse))or(exists(select * from Ziyaret_Sonradan_Girme where Kullanıcı_Id=(select KullanıcıID from Kullanıcı where KullanıcıAD COLLATE Latin1_general_CS_AS=@Kullanıcı_Ad) and Aktifmi=1 and  Ziy_Tar=( " +
                        "                 select Ziy_Tar from Ziyaret_Detay   " +
                        "                 inner join Ziyaret_Genel on Ziy_Gnl_Id=ID " +
                        "                where Ziy_Dty_ID=@1)  ))) " +
                        "               begin " +
                        "                if ((" +
                        "                (" +
                        "                select  Onay_Durum from Ziyaret_Detay " +
                        "                inner join Ziyaret_Genel " +
                        "                on Ziyaret_Genel.ID=Ziyaret_Detay.Ziy_Gnl_Id " +
                        "                inner join Ziyaret_Onay " +
                        "                on Ziyaret_Genel.Ziyaret_Onay_Id=Ziyaret_Onay.Ziyaret_Onay_Id " +
                        "                where   Ziyaret_Detay.Ziy_Dty_ID=@1  " +
                        "                )" +
                        "                = 1" +
                        "                 )" +
                        "                 )or (exists(select * from Ziyaret_Sonradan_Girme where Kullanıcı_Id=(select KullanıcıID from Kullanıcı where KullanıcıAD COLLATE Latin1_general_CS_AS=@Kullanıcı_Ad) and Aktifmi=1 and  Ziy_Tar=( " +
                        "                 select Ziy_Tar from Ziyaret_Detay  " +
                        "                 inner join Ziyaret_Genel on Ziy_Gnl_Id=ID " +
                        "                where Ziy_Dty_ID=@1) " +
                        "                )) " +
                        "                begin;" +
                        "                " +
                        "                update Ziyaret_Detay set Ziyaret_Durumu=2,Ziyaret_Notu=@Ziyaret_Notu where Ziy_Dty_ID=@1 " +
                        "                  delete from Ziyaret_Calışılan_Urunler where Ziyaret_Detay_Id=@1 " +
                        "                   insert into Son_Yapılan_Islem (İslem_Tipi,Kullanıcı_Id,İslem_Tar) values(2, " +
                        "                    (select KullanıcıID from Kullanıcı where KullanıcıAD COLLATE Latin1_general_CS_AS=@1), " +
                        "                    GETDATE() " +
                        "                    ) " +
                        "                    end;" +
                        "                     else " +
                        "                    begin; " +
                        "                    select 3 ;" +
                        "                    end;" +
                        "             " +
                        "                  end; " +
                        "                else  " +
                        "                begin " +
                        "                select 2; " +
                        "                end;";

            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);
            cmd.Parameters.AddWithValue("@Kullanıcı_Ad", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());

            cmd.Parameters.AddWithValue("@1", Ziyaret_Id);

            cmd.Parameters.AddWithValue("@Ziyaret_Notu", Ziyaret_Notu);


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
                return "Hata";
            }
            else
            {
                conn.Close();
                return a;
            }


        }
        public class Ziyaret_Detayı_Tablo
        {
            public string Ziy_Dty_ID { get; set; }
            public string Ziyaret_Notu { get; set; }
            public string Calışılan_Urun_Id { get; set; }
            public string Ziyaret_Durumu { get; set; }

        }
        [System.Web.Services.WebMethod]
        public static string Ziyaret_Detayını_Getir(string parametre)
        {
            var queryWithForJson = "use kasa select Ziy_Dty_ID,Ziyaret_Notu,Calışılan_Urun_Id,Ziyaret_Durumu from Ziyaret_Detay inner join Ziyaret_Calışılan_Urunler on Ziyaret_Detay_Id=Ziy_Dty_ID where Ziy_Dty_ID=@1";
            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);

            cmd.Parameters.AddWithValue("@1", parametre.Split('-')[0]);

          


            conn.Open();


            List<Ziyaret_Detayı_Tablo> tablo_Doldur_Classes = new List<Ziyaret_Detayı_Tablo>();
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


                    var Tablo_Doldur_Class_ = new Ziyaret_Detayı_Tablo
                    {
                        Ziy_Dty_ID = reader.GetValue(0).ToString(),
                        Ziyaret_Notu = reader.GetValue(1).ToString(),
                        Calışılan_Urun_Id = reader.GetValue(2).ToString(),
                        Ziyaret_Durumu = reader.GetValue(3).ToString(),
                    };
                    tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
                }
            }
            conn.Close();
            return JsonConvert.SerializeObject(tablo_Doldur_Classes);


        }
        [System.Web.Services.WebMethod]
        public static string Ziyareti_Güncelle_Bekleniyor(string parametre)
        {
            var queryWithForJson = "" +
                "declare @bu_Gun nvarchar(50) =(select Ziy_Tar from Ziyaret_Detay inner join Ziyaret_Genel on Ziyaret_Detay.Ziy_Gnl_Id=Ziyaret_Genel.ID where Ziyaret_Detay.Ziy_Dty_ID=@1) " +
                "declare @Bu_Gun_Bas nvarchar(50); " +
                "declare @Bu_Gun_Son nvarchar(50); " +
                "declare @Bu_Gun_Bas_parse datetime; " +
                "declare @Bu_Gun_Son_parse datetime; " +
            "set @Bu_Gun_Bas =@bu_Gun+' '+(select cast(Ziyaret_Bas  as nvarchar(11)) from Ziyaret_Zamanı) " +
                "set @Bu_Gun_Son =@bu_Gun+' '+(select cast(Ziyaret_Son  as nvarchar(11)) from Ziyaret_Zamanı) " +
                "set @Bu_Gun_Bas_parse =CAST(@Bu_Gun_Bas as datetime) " +
                "set @Bu_Gun_Son_parse =CAST(@Bu_Gun_Son as datetime) " +
                "if((getdate()>@Bu_Gun_Bas)and(getdate()<@Bu_Gun_Son_parse)) " +
                "begin " +
                "" +
                "if (" +
                "(" +
                "select  Onay_Durum from Ziyaret_Detay " +
                "inner join Ziyaret_Genel " +
                "on Ziyaret_Genel.ID=Ziyaret_Detay.Ziy_Gnl_Id " +
                "inner join Ziyaret_Onay " +
                "on Ziyaret_Genel.Ziyaret_Onay_Id=Ziyaret_Onay.Ziyaret_Onay_Id " +
                "where   Ziyaret_Detay.Ziy_Dty_ID=@1  " +
                ")" +
                "= 1" +
                ") " +
                "begin ;" +
                "update Ziyaret_Detay set Ziyaret_Durumu=0,Calısılan_Urun_1=0,Calısılan_Urun_2=0,Calısılan_Urun_3=0,Ziyaret_Notu=NULL where Ziy_Dty_ID=@1 " +
                "" +
                  "insert into Son_Yapılan_Islem (İslem_Tipi,Kullanıcı_Id,İslem_Tar) values(2, " +
                    "(select KullanıcıID from Kullanıcı where KullanıcıAD COLLATE Latin1_general_CS_AS=@1), " +
                    "GETDATE() " +
                    ") " +
                    "" +
                      "end;" +
                    "else " +
                    "begin; " +
                    "select 3; " +
                    "end;" +
                 "end; " +
                "else  " +
                "begin " +
                "select 2; " +
                "end;" +
                 
                "";
           
            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);

            cmd.Parameters.AddWithValue("@1", parametre.Split('-')[0]);
          


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
                return "Hata";
            }
            else
            {
                conn.Close();
                return a;
            }


        }
        [System.Web.Services.WebMethod]
        public static string Ziyareti_Güncelle_Edildi(string Urun_Listesi,string Ziyaret_Id,string Ziyaret_Notu)
        {

            DataSet dataSet = JsonConvert.DeserializeObject<DataSet>(Urun_Listesi);

            DataTable dataTable = dataSet.Tables["Deneme"];


            var queryWithForJson = "use kasa " +
                "declare @bu_Gun nvarchar(50) =(select Ziy_Tar from Ziyaret_Detay inner join Ziyaret_Genel on Ziyaret_Detay.Ziy_Gnl_Id=Ziyaret_Genel.ID where Ziyaret_Detay.Ziy_Dty_ID=@1) " +
                "declare @Bu_Gun_Bas nvarchar(50); " +
                "declare @Bu_Gun_Son nvarchar(50); " +
                "declare @Bu_Gun_Bas_parse datetime; " +
                "declare @Bu_Gun_Son_parse datetime; " +
                "set @Bu_Gun_Bas =@bu_Gun+' '+(select cast(Ziyaret_Bas  as nvarchar(11)) from Ziyaret_Zamanı) " +
                "set @Bu_Gun_Son =@bu_Gun+' '+(select cast(Ziyaret_Son  as nvarchar(11)) from Ziyaret_Zamanı) " +
                "set @Bu_Gun_Bas_parse =CAST(@Bu_Gun_Bas as datetime) " +
                "set @Bu_Gun_Son_parse =CAST(@Bu_Gun_Son as datetime) " +
                "if(((getdate()>@Bu_Gun_Bas)and(getdate()<@Bu_Gun_Son_parse))or(exists(select * from Ziyaret_Sonradan_Girme where Kullanıcı_Id=(select KullanıcıID from Kullanıcı where KullanıcıAD COLLATE Latin1_general_CS_AS=@Kullanıcı_Ad) and Aktifmi=1 and  Ziy_Tar=( " +
                " select Ziy_Tar from Ziyaret_Detay   " +
                " inner join Ziyaret_Genel on Ziy_Gnl_Id=ID " +
                "where Ziy_Dty_ID=@1)  ))) " +
                "begin " +
                "" +
                "if (" +
                "((" +
                "select  Onay_Durum from Ziyaret_Detay " +
                "inner join Ziyaret_Genel " +
                "on Ziyaret_Genel.ID=Ziyaret_Detay.Ziy_Gnl_Id " +
                "inner join Ziyaret_Onay " +
                "on Ziyaret_Genel.Ziyaret_Onay_Id=Ziyaret_Onay.Ziyaret_Onay_Id " +
                "where   Ziyaret_Detay.Ziy_Dty_ID=@1  " +
                ")" +
                "= 1" +
                ")or (exists(select * from Ziyaret_Sonradan_Girme where Kullanıcı_Id=(select KullanıcıID from Kullanıcı where KullanıcıAD COLLATE Latin1_general_CS_AS=@Kullanıcı_Ad) and Aktifmi=1 and  Ziy_Tar=( " +
                " select Ziy_Tar from Ziyaret_Detay  " +
                " inner join Ziyaret_Genel on Ziy_Gnl_Id=ID " +
                "where Ziy_Dty_ID=@1) " +
                ")) )" +
                "begin ;" +
                "update Ziyaret_Detay set Ziyaret_Durumu=1,Ziyaret_Notu=@Ziyaret_Notu where Ziy_Dty_ID=@1 " +
                "if ((select count(*) from @Urun_Listesi)>0) " +
                "begin; " +
                " delete from Ziyaret_Calışılan_Urunler where Ziyaret_Detay_Id=@1 " +
                "insert into Ziyaret_Calışılan_Urunler (Ziyaret_Detay_Id,Calışılan_Urun_Id) select @1,Urun_Id_ from @Urun_Listesi " +
                "end " +
                "insert into Son_Yapılan_Islem (İslem_Tipi,Kullanıcı_Id,İslem_Tar) values(2, " +
                    "(select KullanıcıID from Kullanıcı where KullanıcıAD COLLATE Latin1_general_CS_AS=@1), " +
                    "GETDATE() " +
                    ") " +
                     "end;" +
                    " else " +
                    "begin; " +
                    "select 3 ;" +
                    "end;" +

                  "end; " +
                "else  " +
                "begin " +
                "select 2; " +
                "end;" +

                "";
            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);
            cmd.Parameters.AddWithValue("@Kullanıcı_Ad", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
            cmd.Parameters.AddWithValue("@1", Ziyaret_Id);
      
            cmd.Parameters.AddWithValue("@Ziyaret_Notu", Ziyaret_Notu);


            SqlParameter tvpParam = cmd.Parameters.AddWithValue("@Urun_Listesi", dataTable);
            tvpParam.SqlDbType = SqlDbType.Structured;
            tvpParam.TypeName = "dbo.Calısılan_Urun";

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
                return "Hata";
            }
            else
            {
                conn.Close();
                return a;
            }


        }
        public class Bu_Gün_Ziyaret_Id_Getir_Tablo
        {
            public string Ziyaret_Id { get; set; }

        }
        [System.Web.Services.WebMethod]
        public static string Bu_Gün_Ziyaret_Id_Getir()
        {

            var queryWithForJson = "select * from Ziyaret_Genel where Kullanıcı_ID= (select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS   = @Kullanıcı_) and Ziy_Tar= cast( getdate() as date)";
            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);
            cmd.Parameters.AddWithValue("@Kullanıcı_", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());


            conn.Open();

            List<Bu_Gün_Ziyaret_Id_Getir_Tablo> tablo_Doldur_Classes = new List<Bu_Gün_Ziyaret_Id_Getir_Tablo>();
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


                    var Tablo_Doldur_Class_ = new Bu_Gün_Ziyaret_Id_Getir_Tablo
                    {
                        Ziyaret_Id = reader.GetValue(0).ToString(),
                    };
                    tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
                }
            }
            conn.Close();
            return JsonConvert.SerializeObject(tablo_Doldur_Classes);


        }
        public class Urunleri_Getir_Tablo
        {
            public string Urun_Adı { get; set; }
            public string Urun_Id { get; set; }
        
        }
        [System.Web.Services.WebMethod]
        public static string Urunleri_Getir()
        {

            var queryWithForJson = "use kasa select Urun_Id,Urun_Adı from Urunler where Silinmismi=0";
            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);


            conn.Open();

            List<Urunleri_Getir_Tablo> tablo_Doldur_Classes = new List<Urunleri_Getir_Tablo>();
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

                
                    var Tablo_Doldur_Class_ = new Urunleri_Getir_Tablo
                    {
                        Urun_Id = reader.GetValue(0).ToString(),
                        Urun_Adı = reader.GetValue(1).ToString(),
                    };
                    tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
                }
            }
            conn.Close();
            return JsonConvert.SerializeObject(tablo_Doldur_Classes);


        }
        [System.Web.Services.WebMethod]
        public static string Ziyaret_Detay(string parametre)
        {
            var queryWithForJson = "use kasa select Ziyaret_Durumu from Ziyaret_Detay where Ziy_Dty_ID=@1";
            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);

            cmd.Parameters.AddWithValue("@1", parametre);

            conn.Open();

            var reader = cmd.ExecuteReader();

            string a = "";
            while (reader.Read())
            {
                a += reader.GetValue(0).ToString() + "!";
            }
            if (a == "")
            {
                conn.Close();
                return "Hata";
            }
            else
            {
                conn.Close();
                return a.Substring(0, a.Length - 1);
            }


        }
        [System.Web.Services.WebMethod]
        public static string Haftanın_Gunleri(string parametre)
        {

            string gelen_yıl = parametre.Split('-')[1];
            string gelen_ay = parametre.Split('-')[0];

            DateTime tarih = new DateTime(Convert.ToInt32(gelen_yıl), Convert.ToInt32(gelen_ay), 1);
            DateTime tarih_son_gün = new DateTime(Convert.ToInt32(gelen_yıl), Convert.ToInt32(gelen_ay), 1);



            tarih_son_gün = new DateTime(tarih_son_gün.Year, tarih_son_gün.Month, 1);


            DateTime tarih_Öncekiayın_son_gunu = new DateTime(tarih.Year, tarih.Month, 1);
            DateTime tarih_Bu_ayın_ilk_gunu = new DateTime(tarih.Year, tarih.Month, 1);


            SqlCommand cmd11 = new SqlCommand(" " +
                      "use kasa declare @gün  int=1; " +
                      "declare @Ayın_Ilk_Gunu_parse date=cast(@Ayın_Ilk_Gunu as date); " +
                      "declare @Ayın_Son_Gunu_parse date=cast(@Ayın_Son_Gunu as date); " +
                      "declare @toplam nvarchar(max)=CAST(@gün as varchar)+'-'+CAST(@ay as varchar)+'-'+CAST(@yıl as varchar); " +
                      "declare @birleşim date= CAST(@toplam as date); " +
                      "declare @İd table (Id int); " +
                      "if exists(select * from Ziyaret_Onay where Kullanıcı_Id= (select KullanıcıID from Kullanıcı where KullanıcıAD COLLATE Latin1_general_CS_AS =@kullanıcı) and Bas_Tar=@Ayın_Ilk_Gunu and Bit_Tar=@Ayın_Son_Gunu) " +
                      "begin " +
                      "select CONVERT (varchar(10), Ziyaret_Genel.Ziy_Tar, 104)as 'ziyaret tar',Ziyaret_Genel.ID ,Kullanıcı_ID,Ziy_ID,Ziy_Edilen_Eczane,Ziy_Edilen_Doktor,(select count(*) from Ziyaret_Detay where Ziy_Gnl_ID=ID and Cins=1)as Ziyaret_Edilecek_Eczane,(select count(*) from Ziyaret_Detay where Ziy_Gnl_ID=ID and Cins=0)as Ziyaret_Edilecek_Doktor,(select COUNT(*) from Ziyaret_Detay  where ID=Ziy_Gnl_Id and Cins=0 and Ziyaret_Durumu=1) as ziyaret_edilen_Eczane,(select COUNT(*) from Ziyaret_Detay  where ID=Ziy_Gnl_Id and Cins=1 and Ziyaret_Durumu=1) as ziyaret_edilen_Doktor  from Ziyaret_Genel where Kullanıcı_ID=(select KullanıcıID from Kullanıcı where KullanıcıAD COLLATE Latin1_general_CS_AS =@kullanıcı) and Ziy_Tar between @Ayın_Ilk_Gunu and @Ayın_Son_Gunu order by Ziy_Tar asc ;  " +
                      "end; " +
                      "else " +
                      " begin " +
                      "insert into Ziyaret_Onay (Bas_Tar,Bit_Tar,Kullanıcı_Id) output inserted.Ziyaret_Onay_Id into @İd values (@Ayın_Ilk_Gunu,@Ayın_Son_Gunu,(select KullanıcıID from Kullanıcı where KullanıcıAD COLLATE Latin1_general_CS_AS =@kullanıcı)) " +
                      "WHILE @gün < @Ayın_Son_Günü_tek+1  " +
                      "BEGIN   " +
                      "set @toplam=CAST(@yıl as varchar)+'-'+CAST(@ay as varchar)+'-'+CAST(@gün as varchar);  " +
                      "set @birleşim=CAST(@toplam as date);   " +
                      "INSERT INTO Ziyaret_Genel (Ziy_Tar,Kullanıcı_ID,Ziyaret_Onay_Id) values (@birleşim,(select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS =@kullanıcı),(select * from @İd));  " +
                      "SET @gün = @gün + 1;  " +
                      "print @toplam; " +
                      "END; " +
                      "select CONVERT (varchar(10), Ziyaret_Genel.Ziy_Tar, 104)as 'ziyaret tar',Ziyaret_Genel.ID ,Kullanıcı_ID,Ziy_ID,Ziy_Edilen_Eczane,Ziy_Edilen_Doktor,(select count(*) from Ziyaret_Detay where Ziy_Gnl_ID=ID and Cins=1)as Ziyaret_Edilecek_Eczane,(select count(*) from Ziyaret_Detay where Ziy_Gnl_ID=ID and Cins=0)as Ziyaret_Edilecek_Doktor,(select COUNT(*) from Ziyaret_Detay  where ID=Ziy_Gnl_Id and Cins=0 and Ziyaret_Durumu=1) as ziyaret_edilen_Eczane,(select COUNT(*) from Ziyaret_Detay  where ID=Ziy_Gnl_Id and Cins=1 and Ziyaret_Durumu=1) as ziyaret_edilen_Doktor  from Ziyaret_Genel where Kullanıcı_ID=(select KullanıcıID from Kullanıcı where KullanıcıAD COLLATE Latin1_general_CS_AS =@kullanıcı) and Ziy_Tar between @Ayın_Ilk_Gunu and @Ayın_Son_Gunu order by Ziy_Tar asc  ;  " +
                      "end " +

                      "", SqlC.con);


            string a_1 = Convert.ToString(Convert.ToInt32(Convert.ToString(tarih_son_gün.AddMonths(1).AddDays(-1).ToString("dd"))));
            string a_2 = Convert.ToString(Convert.ToInt32(Convert.ToString(gelen_ay)));
            string a_3 = Convert.ToString(Convert.ToInt32(Convert.ToInt32(gelen_yıl)));
            string a_4 = Convert.ToString(tarih_Bu_ayın_ilk_gunu.ToString("yyyy-MM-dd"));
            string a_5 = Convert.ToString(tarih_son_gün.AddMonths(1).AddDays(-1).ToString("yyyy-MM-dd"));


            cmd11.Parameters.AddWithValue("@Ayın_Son_Günü_tek", a_1);
            cmd11.Parameters.AddWithValue("@ay", a_2);
            cmd11.Parameters.AddWithValue("@yıl", a_3);//@kullanıcı
            cmd11.Parameters.AddWithValue("@Ayın_Ilk_Gunu", a_4);
            cmd11.Parameters.AddWithValue("@Ayın_Son_Gunu", a_5);
            cmd11.Parameters.AddWithValue("@kullanıcı", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());

            SqlC.con.Open();

            var reader = cmd11.ExecuteReader();//47 block

            string a = "";
            string b = "";
            while (reader.Read())//0-tar , 1-id , 2-Kullanıcı_ıd , 3-Ziy_Id , 4-Ziy_Edilen_Eczane , 5- Ziy_Edilen_Doktor , 6-Ziy_Edilecek_Eczane , 7- Ziy_Edilecek_Doktor 
            {
                a += reader.GetValue(0).ToString() + "-" + reader.GetValue(1).ToString() + "-" + reader.GetValue(2).ToString() + "-" + reader.GetValue(3).ToString() + "-" + reader.GetValue(4).ToString() + "-" + reader.GetValue(5).ToString() + "-" + reader.GetValue(6).ToString() + "-" + reader.GetValue(7).ToString() + "-" + reader.GetValue(8).ToString() + "-" + reader.GetValue(9).ToString() + "!";
            }

            //a.Split('!')[0].Split('-')[0].Split('.')[1] = birinci günün ayı

            SqlC.con.Close();







            if (tarih_Bu_ayın_ilk_gunu.ToString("dddd") == "Pazartesi")
            {
                for (int i = 0; i < 42; i++)
                {
                    if (i > ((Convert.ToInt32(tarih_son_gün.AddMonths(1).AddDays(-1).ToString("dd"))) - 1))
                    {
                        b += "empty" + "!";
                    }
                    else
                    {
                        b += a.Split('!')[i] + "-" + "1" + "!";

                    }
                }
            }
            else
            {
                //Console.WriteLine(tarih_Öncekiayın_son_gunu.AddDays(-1).ToString("dddd"));// gelen aydan önceki ayın son günü string
                int sayaç = 1;
                int Bu_Ayın_Gün_Sayısı = ((Convert.ToInt32(tarih_son_gün.AddMonths(1).AddDays(-1).ToString("dd"))));
                int Gün_sayaç = 0;
                while (true)
                {
                    if (tarih_Öncekiayın_son_gunu.AddDays(-sayaç).ToString("dddd") != "Pazartesi")
                    {
                        sayaç++;
                    }
                    else
                    {
                        break;
                    }
                }
                for (int i = 0; i < 42; i++)
                {
                    if (i < sayaç)
                    {
                        b += "empty" + "!";
                        
                        continue;
                    }
                    if (i - sayaç > ((Convert.ToInt32(tarih_son_gün.AddMonths(1).AddDays(-1).ToString("dd"))) - 1))
                    {
                        b += "empty" + "!";
                    }
                    else
                    {
                        if (Gün_sayaç < Bu_Ayın_Gün_Sayısı)
                        {
                            b += a.Split('!')[Gün_sayaç] + "-" + "1" + "!";
                            Gün_sayaç++;
                        }
                        

                    }
                }


            }
            
            return b.Substring(0, b.Length - 1);
        }
    }
}