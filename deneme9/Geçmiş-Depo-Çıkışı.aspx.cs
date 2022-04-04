using Newtonsoft.Json;
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
    public partial class Geçmiş_Depo_Çıkışı : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        public class Geçmiş_Urun_Adı_Tablo
        {
            public string Urun_Adı { get; set; }

        }
        [System.Web.Services.WebMethod]
        public static string Geçmiş_Urun_Adı(string Paramatre)
        {
            try
            {
                var queryWithForJson = "use kasa " +
               "  SELECT DISTINCT Geçmiş_Depo_Çıkışı.Ürün_Adı " +
               " FROM Geçmiş_Depo_Çıkışı";

                var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
                var cmd = new SqlCommand(queryWithForJson, conn);

                string check = FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString();



                List<Geçmiş_Urun_Adı_Tablo> tablo_Doldur_Classes = new List<Geçmiş_Urun_Adı_Tablo>();

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
                        var Tablo_Doldur_Class_ = new Geçmiş_Urun_Adı_Tablo
                        {
                            Urun_Adı = reader.GetValue(0).ToString(),


                        };
                        tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
                    }
                }
                conn.Close();
                return JsonConvert.SerializeObject(tablo_Doldur_Classes);

            }
            catch (Exception)
            {
           
                throw;
            }
          
           


        }//Masrafı_Kaldır

        public class Geçmiş_Şehir_Tablo
        {
            public string Şehir_Adı { get; set; }

        }
        [System.Web.Services.WebMethod]
        public static string Geçmiş_Şehir(string Paramatre)
        {
            try
            {
                var queryWithForJson = "use kasa " +
               "  SELECT DISTINCT Geçmiş_Depo_Çıkışı.Şehir " +
               " FROM Geçmiş_Depo_Çıkışı";

                var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
                var cmd = new SqlCommand(queryWithForJson, conn);

                string check = FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString();



                List<Geçmiş_Şehir_Tablo> tablo_Doldur_Classes = new List<Geçmiş_Şehir_Tablo>();

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
                        var Tablo_Doldur_Class_ = new Geçmiş_Şehir_Tablo
                        {
                            Şehir_Adı = reader.GetValue(0).ToString(),


                        };
                        tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
                    }
                }
                conn.Close();
                return JsonConvert.SerializeObject(tablo_Doldur_Classes);

            }
            catch (Exception)
            {

                throw;
            }




        }//Masrafı_Kaldır
        public class Geçmiş_Brick_Tablo
        {
            public string Brick_Adı { get; set; }

        }
        [System.Web.Services.WebMethod]
        public static string Geçmiş_Brick(string Paramatre)
        {
            try
            {
                var queryWithForJson = "use kasa " +
               "  SELECT DISTINCT Geçmiş_Depo_Çıkışı.Brick " +
               " FROM Geçmiş_Depo_Çıkışı";

                var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
                var cmd = new SqlCommand(queryWithForJson, conn);

                string check = FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString();



                List<Geçmiş_Brick_Tablo> tablo_Doldur_Classes = new List<Geçmiş_Brick_Tablo>();

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
                        var Tablo_Doldur_Class_ = new Geçmiş_Brick_Tablo
                        {
                            Brick_Adı = reader.GetValue(0).ToString(),


                        };
                        tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
                    }
                }
                conn.Close();
                return JsonConvert.SerializeObject(tablo_Doldur_Classes);

            }
            catch (Exception)
            {

                throw;
            }




        }//Masrafı_Kaldır
        public class Geçmiş_Depo_Tablo
        {
            public string Depo_Adı { get; set; }

        }
        [System.Web.Services.WebMethod]
        public static string Geçmiş_Depo(string Paramatre)
        {
            try
            {
                var queryWithForJson = "use kasa " +
               "  SELECT DISTINCT Geçmiş_Depo_Çıkışı.DEPO " +
               " FROM Geçmiş_Depo_Çıkışı";

                var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
                var cmd = new SqlCommand(queryWithForJson, conn);

                string check = FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString();



                List<Geçmiş_Depo_Tablo> tablo_Doldur_Classes = new List<Geçmiş_Depo_Tablo>();

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
                        var Tablo_Doldur_Class_ = new Geçmiş_Depo_Tablo
                        {
                            Depo_Adı = reader.GetValue(0).ToString(),


                        };
                        tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
                    }
                }
                conn.Close();
                return JsonConvert.SerializeObject(tablo_Doldur_Classes);

            }
            catch (Exception)
            {

                throw;
            }




        }//Masrafı_Kaldır
        public class Geçmiş_Sorgu_Tablo
        {
            public string Ürün_Adı { get; set; }
            public string Eczane { get; set; }
            public string Brick { get; set; }
            public string Şehir { get; set; }
            public string İşlem_Tar { get; set; }
            public string DEPO { get; set; }
            public string Adet { get; set; }
            public string Mf_Adet { get; set; }

        }
      
        

        [System.Web.Services.WebMethod]
        public static string Geçmiş_Sorgu(string Urun_Adı,string Şehir, string Semt,string Depo,string Max_Adet, string Min_Adet, string Max_Mf_Adet, string Min_Mf_Adet,string Bas_Tar, string Bit_Tar)

        {

            DataSet Urun_Adı_Dataset = JsonConvert.DeserializeObject<DataSet>(Urun_Adı);
            DataTable Urun_Adı_Datatable = Urun_Adı_Dataset.Tables["Urun_Adı_Liste"];

            DataSet Şehir_Dataset = JsonConvert.DeserializeObject<DataSet>(Şehir);
            DataTable Şehir_Datatable = Şehir_Dataset.Tables["Şehir_Liste"];


            DataSet Semt_Dataset = JsonConvert.DeserializeObject<DataSet>(Semt);
            DataTable Semt_Datatable = Semt_Dataset.Tables["Semt_Liste"];

            DataSet Depo_Dataset = JsonConvert.DeserializeObject<DataSet>(Depo);
            DataTable Depo_Datatable = Depo_Dataset.Tables["Depo_Liste"];

            var queryWithForJson = "" +
        
            "declare @Max int=2147483647; " +
            "declare @Min int=0; " +
          


            "select  Ürün_Adı,Eczane,Brick,Şehir,İşlem_Tar,DEPO,Adet,Mf_Adet  from Geçmiş_Depo_Çıkışı " +
            "" +

            "" +

            " inner join @Geçmiş_Sorgu_Şehir_table " +
            " on (select(case when (Şehir_ is  null) then Şehir else Şehir_  end))=Geçmiş_Depo_Çıkışı.Şehir " +

            " inner join @Geçmiş_Sorgu_Semt_table " +
            " on (select(case when (Semt is  null) then Brick else Semt  end))=Geçmiş_Depo_Çıkışı.Brick " +

            " inner join @Geçmiş_Sorgu_Depo_Adı_table " +
            " on (select(case when (Depo_Adı_ is  null) then DEPO else Depo_Adı_  end))=Geçmiş_Depo_Çıkışı.DEPO " +

            " " +
            " inner join @Geçmiş_Sorgu_Urun_Adı_table " +
            " on (select(case when (Urun_Adı is  null) then Ürün_Adı else Urun_Adı  end))=Geçmiş_Depo_Çıkışı.Ürün_Adı " +
            "" +
            "" +
            "where " +
            "" +

        
            "" +
            "Adet " +
            "" +
            "" +
            "between (case when @Min_Adet_Gelen = 0 then @Min else @Min_Adet_Gelen  end) " +
            "" +
            "" +
            "and (case when @Max_Adet_Gelen = 0 then @Max else @Max_Adet_Gelen end) " +
            "" +
            "and " +
            "" +
            "Mf_Adet " +
            "" +
            "between (case when @Min_MF_Adet_Gelen = 0 then @Min else @Min_MF_Adet_Gelen  end) " +
            "" +
            "" +
            "and (case when @Max_Mf_Adet_Gelen = 0 then @Max else @Max_Mf_Adet_Gelen end) " +
            "" +
            "And " +
            " İşlem_Tar between @Bas_Tar and @Bit_Tar";



            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);

            cmd.Parameters.AddWithValue("@Min_Adet_Gelen", Min_Adet);
            cmd.Parameters.AddWithValue("@Max_Adet_Gelen", Max_Adet);
            cmd.Parameters.AddWithValue("@Min_MF_Adet_Gelen", Min_Mf_Adet);
            cmd.Parameters.AddWithValue("@Max_Mf_Adet_Gelen", Max_Mf_Adet);

            cmd.Parameters.AddWithValue("@Bas_Tar", Bas_Tar);
            cmd.Parameters.AddWithValue("@Bit_Tar", Bit_Tar);

            string check = FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString();

            SqlParameter tvpParam = cmd.Parameters.AddWithValue("@Geçmiş_Sorgu_Urun_Adı_table", Urun_Adı_Datatable);
            tvpParam.SqlDbType = SqlDbType.Structured;
            tvpParam.TypeName = "dbo.Geçmiş_Sorgu_Urun_Adı";


            SqlParameter tvpParam1 = cmd.Parameters.AddWithValue("@Geçmiş_Sorgu_Şehir_table", Şehir_Datatable);
            tvpParam1.SqlDbType = SqlDbType.Structured;
            tvpParam1.TypeName = "dbo.Geçmiş_Sorgu_Şehir";

            SqlParameter tvpParam2 = cmd.Parameters.AddWithValue("@Geçmiş_Sorgu_Semt_table", Semt_Datatable);
            tvpParam2.SqlDbType = SqlDbType.Structured;
            tvpParam2.TypeName = "dbo.Geçmiş_Sorgu_Semt";


            SqlParameter tvpParam3 = cmd.Parameters.AddWithValue("@Geçmiş_Sorgu_Depo_Adı_table", Depo_Datatable);
            tvpParam3.SqlDbType = SqlDbType.Structured;
            tvpParam3.TypeName = "dbo.Geçmiş_Depo_Adı";

            List<Geçmiş_Sorgu_Tablo> tablo_Doldur_Classes = new List<Geçmiş_Sorgu_Tablo>();

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
                    var Tablo_Doldur_Class_ = new Geçmiş_Sorgu_Tablo
                    {
                        Ürün_Adı = reader.GetValue(0).ToString(),
                        Eczane = reader.GetValue(1).ToString(),
                        Brick = reader.GetValue(2).ToString(),
                        Şehir = reader.GetValue(3).ToString(),
                        İşlem_Tar = reader.GetDateTime(4).ToString("dd-MM-yyyy"),
                        DEPO = reader.GetValue(5).ToString(),
                        Adet = reader.GetValue(6).ToString(),
                        Mf_Adet = reader.GetValue(7).ToString()

                    };
                    tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
                }
            }
            conn.Close();
            return JsonConvert.SerializeObject(tablo_Doldur_Classes);





        }//Masrafı_Kaldır
    }
}