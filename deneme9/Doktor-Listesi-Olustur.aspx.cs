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
    public partial class Doktor_Ekle_Cıkar1 : System.Web.UI.Page
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
                    "select Unite_Txt from Unite";
             

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
        [System.Web.Services.WebMethod]
        public static string Geçmiş_Urun_Adı_With_List(string Liste_Id)
        {
            try
            {
                var queryWithForJson = "use kasa " +
                    "select Unite_Txt from Doktor_Liste " +
                    "inner join Doktors on Doktors.Doktor_ıd=Doktor_Liste.Doktor_Id  " +
                    "inner join Unite on Unite.Unite_ID=doktors.Doktor_Unite_ID  " +
                    "where Liste_Id=@Liste_Id  group by Unite_Txt " +
                    "" +
                    "";


                var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
                var cmd = new SqlCommand(queryWithForJson, conn);
                cmd.Parameters.AddWithValue("@Liste_Id", Liste_Id);

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
                    " select CityName from City";
             

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

        [System.Web.Services.WebMethod]
        public static string Geçmiş_Şehir_With_List(string Liste_Id)
        {
            try
            {
                var queryWithForJson = "use kasa " +
                    "select CityName,CityID from Doktor_Liste  " +
                    "inner join Doktors on Doktors.Doktor_ıd=Doktor_Liste.Doktor_Id  " +
                    "inner join Unite on Unite.Unite_ID=doktors.Doktor_Unite_ID " +
                    " inner join City on CityID=Unite.İl_Id where Liste_Id=@Liste_Id group by CityName,CityID " +
                    "" +
                    "";


                var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
                var cmd = new SqlCommand(queryWithForJson, conn);
                cmd.Parameters.AddWithValue("@Liste_Id", Liste_Id);




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
        [System.Web.Services.WebMethod]
        public static string Geçmiş_Şehir_With_List_Eczane(string Liste_Id)
        {
            try
            {
                var queryWithForJson = "use kasa " +
                    "select CityName from Eczane_Liste  " +
                    "inner join Eczane on Eczane_Liste.Eczane_Id=Eczane.Eczane_Id  " +
                    "inner join City on Eczane.Eczane_Il=City.CityID " +
                    " where Liste_Id =@Liste_Id group by CityName " +
                    "" +
                    "";


                var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
                var cmd = new SqlCommand(queryWithForJson, conn);
                cmd.Parameters.AddWithValue("@Liste_Id", Liste_Id);




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
                var queryWithForJson = "use kasa  " +
                    "" +
                    "select TownName from Town" +
                    "";
              

                var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
                var cmd = new SqlCommand(queryWithForJson, conn);




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
        [System.Web.Services.WebMethod]
        public static string Geçmiş_Brick_With_List(string Liste_Id)
        {
            try
            {
                var queryWithForJson = "use kasa " +
                     "select TownName from Doktor_Liste   " +
                     "inner join Doktors on Doktors.Doktor_ıd=Doktor_Liste.Doktor_Id  " +
                     "inner join Unite on Unite.Unite_ID=doktors.Doktor_Unite_ID " +
                     " inner join Town on Unite.Brick__Id=TownID where Liste_Id=@Liste_Id group by TownName  " +
                     "" +
                     "";


                var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
                var cmd = new SqlCommand(queryWithForJson, conn);
                cmd.Parameters.AddWithValue("@Liste_Id", Liste_Id);




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
        [System.Web.Services.WebMethod]
        public static string Geçmiş_Brick_With_List_Eczane(string Liste_Id)
        {
            try
            {
                var queryWithForJson = "use kasa " +
                     "select TownName from Eczane_Liste   " +
                     "inner join Eczane on Eczane_Liste.Eczane_Id=Eczane.Eczane_Id " +
                     "inner join Town on Eczane.Eczane_Brick=Town.TownID " +
                     " where Liste_Id =@Liste_Id group by TownName  " +
                     "" +
                     "";


                var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
                var cmd = new SqlCommand(queryWithForJson, conn);
                cmd.Parameters.AddWithValue("@Liste_Id", Liste_Id);




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

               " select Brans_Txt from Branchs";

                var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
                var cmd = new SqlCommand(queryWithForJson, conn);




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

        [System.Web.Services.WebMethod]
        public static string Geçmiş_Depo_With_List(string Liste_Id)
        {
            try
            {
                var queryWithForJson = "use kasa " +
                    "select Branchs.Brans_Txt from Doktor_Liste  " +
                    "inner join Doktors on Doktors.Doktor_ıd=Doktor_Liste.Doktor_Id  " +
                    "inner join Unite on Unite.Unite_ID=doktors.Doktor_Unite_ID " +
                    "inner join Unite_Branş_Liste on Unite.Unite_Id=Unite_Branş_Liste.Unite_Id " +
                    "inner join Branchs on Unite_Branş_Liste.Branş_Id=Branchs.Brans_ID " +
                    "where Liste_Id=@Liste_Id  group by Branchs.Brans_Txt " +
                    "" +
                    "" +
                    "";

                var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
                var cmd = new SqlCommand(queryWithForJson, conn);
                cmd.Parameters.AddWithValue("@Liste_Id", Liste_Id);




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
            public string Doktor_Id { get; set; }
            public string Doktor_Ad { get; set; }
            public string Brans_Txt { get; set; }
            public string Unite_Txt { get; set; }
            public string CityName { get; set; }
            public string TownName { get; set; }

        }



        [System.Web.Services.WebMethod]
        public static string Doktor_Listele(string Unite_Adı, string Şehir, string Semt,string Branş)

        {

            DataSet Urun_Adı_Dataset = JsonConvert.DeserializeObject<DataSet>(Unite_Adı);
            DataTable Urun_Adı_Datatable = Urun_Adı_Dataset.Tables["Urun_Adı_Liste"];

            DataSet Şehir_Dataset = JsonConvert.DeserializeObject<DataSet>(Şehir);
            DataTable Şehir_Datatable = Şehir_Dataset.Tables["Şehir_Liste"];


            DataSet Semt_Dataset = JsonConvert.DeserializeObject<DataSet>(Semt);
            DataTable Semt_Datatable = Semt_Dataset.Tables["Semt_Liste"];

            DataSet Depo_Dataset = JsonConvert.DeserializeObject<DataSet>(Branş);
            DataTable Depo_Datatable = Depo_Dataset.Tables["Depo_Liste"];

            var queryWithForJson = "" +

            "declare @Max int=2147483647; " +
            "declare @Min int=0; " +



            " select top 1000 Doktor_Id,Doktor_Ad,Brans_Txt,Unite_Txt,CityName,TownName from Doktors  " +
            "" +
            " inner join Unite " +
            " on Doktor_Unite_ID=Unite.Unite_ID " +
            " inner join Town  " +
            "  on Unite.Brick__Id=Town.TownID " +
            " inner join City " +
            "  on Unite.İl_Id=City.CityID " +
            "  inner join Branchs " +
            "  on Doktor_Brans_Id=Branchs.Brans_ID " +
            "" +

            "" +

            " inner join @Geçmiş_Sorgu_Şehir_table " +
            " on (select(case when (Şehir_ is  null) then CityName else Şehir_  end))=City.CityName " +

            " inner join @Geçmiş_Sorgu_Semt_table " +
            " on (select(case when (Semt is  null) then TownName else Semt  end))=Town.TownName " +

            " inner join @Geçmiş_Sorgu_Depo_Adı_table " +
            " on (select(case when (Depo_Adı_ is  null) then Brans_Txt else Depo_Adı_  end))=Branchs.Brans_Txt " +

            " " +
            " inner join @Geçmiş_Sorgu_Urun_Adı_table " +
            " on (select(case when (Urun_Adı is  null) then Unite_Txt else Urun_Adı  end))=Unite.Unite_Txt " +
            "" +
            "";
         



            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);

            

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
                        Doktor_Id = reader.GetValue(0).ToString(),
                        Doktor_Ad = reader.GetValue(1).ToString(),
                        Brans_Txt = reader.GetValue(2).ToString(),
                        Unite_Txt = reader.GetValue(3).ToString(),
                        CityName = reader.GetValue(4).ToString(),
                        TownName = reader.GetValue(5).ToString(),

                    };
                    tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
                }
            }
            conn.Close();
            return JsonConvert.SerializeObject(tablo_Doldur_Classes);




        }//Masrafı_Kaldır

        [System.Web.Services.WebMethod]
        public static string Doktor_Listele_With_List(string Unite_Adı, string Şehir, string Semt, string Branş,string Liste_Id)

        {

            DataSet Urun_Adı_Dataset = JsonConvert.DeserializeObject<DataSet>(Unite_Adı);
            DataTable Urun_Adı_Datatable = Urun_Adı_Dataset.Tables["Urun_Adı_Liste"];

            DataSet Şehir_Dataset = JsonConvert.DeserializeObject<DataSet>(Şehir);
            DataTable Şehir_Datatable = Şehir_Dataset.Tables["Şehir_Liste"];


            DataSet Semt_Dataset = JsonConvert.DeserializeObject<DataSet>(Semt);
            DataTable Semt_Datatable = Semt_Dataset.Tables["Semt_Liste"];

            DataSet Depo_Dataset = JsonConvert.DeserializeObject<DataSet>(Branş);
            DataTable Depo_Datatable = Depo_Dataset.Tables["Depo_Liste"];

            var queryWithForJson = "" +

            "declare @Max int=2147483647; " +
            "declare @Min int=0; " +



            " select top 1000 Doktor_Liste.Doktor_Id,Doktor_Ad,Brans_Txt,Unite_Txt,CityName,TownName from Doktor_Liste  " +

            "inner join Doktors on Doktor_Liste.Doktor_ıd=Doktors.Doktor_Id " +

            " inner join Unite " +
            " on Doktor_Unite_ID=Unite.Unite_ID " +
            " inner join Town  " +
            "  on Unite.Brick__Id=Town.TownID " +
            " inner join City " +
            "  on Unite.İl_Id=City.CityID " +
            "  inner join Branchs " +
            "  on Doktor_Brans_Id=Branchs.Brans_ID " +

            "" +

            "" +

            " inner join @Geçmiş_Sorgu_Şehir_table " +
            " on (select(case when (Şehir_ is  null) then CityName else Şehir_  end))=City.CityName " +

            " inner join @Geçmiş_Sorgu_Semt_table " +
            " on (select(case when (Semt is  null) then TownName else Semt  end))=Town.TownName " +

            " inner join @Geçmiş_Sorgu_Depo_Adı_table " +
            " on (select(case when (Depo_Adı_ is  null) then Brans_Txt else Depo_Adı_  end))=Branchs.Brans_Txt " +

            " " +
            " inner join @Geçmiş_Sorgu_Urun_Adı_table " +
            " on (select(case when (Urun_Adı is  null) then Unite_Txt else Urun_Adı  end))=Unite.Unite_Txt " +
            " where Liste_Id=@Liste_Id" +
            "";




            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);
            cmd.Parameters.AddWithValue("@Liste_Id", Liste_Id);


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
                        Doktor_Id = reader.GetValue(0).ToString(),
                        Doktor_Ad = reader.GetValue(1).ToString(),
                        Brans_Txt = reader.GetValue(2).ToString(),
                        Unite_Txt = reader.GetValue(3).ToString(),
                        CityName = reader.GetValue(4).ToString(),
                        TownName = reader.GetValue(5).ToString(),

                    };
                    tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
                }
            }
            conn.Close();
            return JsonConvert.SerializeObject(tablo_Doldur_Classes);




        }//Masrafı_Kaldır




        public class Eczane_Listesi_Class
        {
            public string Doktor_Adı { get; set; }
            public string Doktor_Branş { get; set; }

            public string Doktor_Unite { get; set; }
            public string Doktor_İl { get; set; }
            public string Doktor_Brick { get; set; }
            public string Doktor_Frekans { get; set; }
            public string Doktor_Id { get; set; }
        }

        [System.Web.Services.WebMethod]
        public static string Yeni_Liste_Olustur_Listeler_Tablo(string parametre)
        {



            var queryWithForJson = "SELECT Doktor_Ad ,Branchs.Brans_Txt ,Unite_Txt,TownName,CityName,Doktor_Liste.Frekans ,Doktor_Liste_Id FROM Doktor_Liste " +
                        " INNER JOIN Listeler " +
            " ON Doktor_Liste.Liste_Id=Listeler.Liste_Id " +
                " INNER JOIN Doktors " +
                " ON Doktor_Liste.Doktor_ıd=Doktors.Doktor_Id " +
                " INNER JOIN Unite " +
                            " ON Doktors.Doktor_Unite_ID=Unite_ID " +
                    " INNER JOIN Town " +
                " ON TownID=Unite.Brick__Id" +
                    "  INNER JOIN City " +
                "  ON City.CityID=Town.CityID " +
            "  inner join Branchs " +
            "  on Branchs.Brans_ID=Doktors.Doktor_Brans_Id " +
                "  " +
                    "  Where Listeler.Liste_Id=  @1  and Listeler.cins = 0 and Doktor_Liste.Silinmismi=0";




            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);
            cmd.Parameters.AddWithValue("@1", parametre.Split('-')[0]);
            conn.Open();



            List<Eczane_Listesi_Class> tablo_Doldur_Classes = new List<Eczane_Listesi_Class>();
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
                    var Tablo_Doldur_Class_ = new Eczane_Listesi_Class
                    {
                        Doktor_Adı = reader.GetValue(0).ToString(),
                        Doktor_Branş = reader.GetValue(1).ToString(),
                        Doktor_Unite = reader.GetValue(2).ToString(),
                        Doktor_Brick = reader.GetValue(3).ToString(),
                        Doktor_Id = reader.GetValue(6).ToString(),
                        Doktor_Frekans = reader.GetValue(5).ToString(),
                        Doktor_İl = reader.GetValue(4).ToString(),
                      

                    };
                    tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
                }
            }
            conn.Close();
            return JsonConvert.SerializeObject(tablo_Doldur_Classes);


        }
        [System.Web.Services.WebMethod]
        public static string Doktor_Liste_Ekle_btn(string Doktor_Liste, string Doktor_Ad, string Doktor_Frekans)
        {
            //doktor frekans liste

            var queryWithForJson1 = "use kasa BEGIN IF Not EXISTS( SELECT * FROM Doktor_Liste " +
                "WHERE Liste_Id=@Liste_Id  " +
                "AND Doktor_Id=@Doktor_Id  And Silinmismi=0 )" +
                " BEGIN INSERT INTO Doktor_Liste (Liste_Id, Doktor_ıd, Frekans) " +
                "output Inserted.Doktor_Liste_Id " +
                "VALUES (@Liste_Id,@Doktor_Id,@Frekans) " +
                " END " +
                "END";
            var conn1 = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd1 = new SqlCommand(queryWithForJson1, conn1);
            cmd1.Parameters.AddWithValue("@Liste_Id", Doktor_Liste);
            cmd1.Parameters.AddWithValue("@Doktor_Id", Doktor_Ad);
            cmd1.Parameters.AddWithValue("@Frekans", Doktor_Frekans);
            conn1.Open();
            var reader = cmd1.ExecuteReader();

            string a = "";
            while (reader.Read())
            {
                a += reader.GetValue(0).ToString();
            }
            conn1.Close();
            if (a == "")
            {
                return "0";
            }
            else
            {
                return a;
            }


        }
        public class Alerjen_Liste_Tablo
        {
            public string Id { get; set; }
            public string LastName { get; set; }

        }

        [System.Web.Services.WebMethod]
        public static string Unite_Adı_Getir(string Harf)
        {
            if (FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString() == null)
            {
                return "DONT DO THİS AGAİN";
            }
            else
            {



                var queryWithForJson = "select Unite_ID, Unite_Txt from Unite where Unite_Txt like '%'+@Harf+'%' ";



                var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
                var cmd = new SqlCommand(queryWithForJson, conn);
                cmd.Parameters.AddWithValue("@Harf", Harf);
                conn.Open();



                List<Alerjen_Liste_Tablo> tablo_Doldur_Classes = new List<Alerjen_Liste_Tablo>();


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
                        var Tablo_Doldur_Class_ = new Alerjen_Liste_Tablo
                        {
                            Id = reader.GetValue(0).ToString(),
                            LastName = reader.GetValue(1).ToString(),

                        };
                        tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
                    }
                }
                conn.Close();
                return JsonConvert.SerializeObject(tablo_Doldur_Classes);
            }



        }


        public class Listeler
        {
            public string Liste_Id { get; set; }
            public string Liste_Ad { get; set; }

        }

        [System.Web.Services.WebMethod]
        public static string Yeni_Liste_Olustur_Listeler(string Liste_Adı)
        {



            var queryWithForJson = "use kasa select * from listeler " +
                "where " +
                "Kullanıcı_Id=(select KullanıcıID from Kullanıcı where KullanıcıAD COLLATE Latin1_general_CS_AS =@Kullanıcı_Adı) " +
                "and " +
                "cins = 0 ";




            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);
    
            cmd.Parameters.AddWithValue("@Kullanıcı_Adı", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
            conn.Open();



            List<Listeler> tablo_Doldur_Classes = new List<Listeler>();
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
                    var Tablo_Doldur_Class_ = new Listeler
                    {
                        Liste_Id = reader.GetValue(0).ToString(),
                        Liste_Ad = reader.GetValue(1).ToString(),
                    };
                    tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
                }
            }
            conn.Close();
            return JsonConvert.SerializeObject(tablo_Doldur_Classes);


        }

        public class Doktor_Liste_Tablo
        {
            public string Liste_Id { get; set; }
         
        }

        [System.Web.Services.WebMethod]
        public static string Yeni_Liste_Olustur_Liste_Ekle(string Liste_Adı)
        {



            var queryWithForJson = "" +
                "INSERT INTO  " +
                "Listeler (Liste_Ad, Kullanıcı_Id, cins)  " +
                "OUTPUT INSERTED.Liste_Id  " +
                "VALUES (@Liste_Adı,(select KullanıcıID from Kullanıcı where KullanıcıAD COLLATE Latin1_general_CS_AS =@Kullanıcı_Adı),0) " +
                " ";




            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);
            cmd.Parameters.AddWithValue("@Liste_Adı", Liste_Adı);
            cmd.Parameters.AddWithValue("@Kullanıcı_Adı", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
            conn.Open();



            List<Doktor_Liste_Tablo> tablo_Doldur_Classes = new List<Doktor_Liste_Tablo>();
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
                    var Tablo_Doldur_Class_ = new Doktor_Liste_Tablo
                    {
                        Liste_Id = reader.GetValue(0).ToString(),
                    

                    };
                    tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
                }
            }
            conn.Close();
            return JsonConvert.SerializeObject(tablo_Doldur_Classes);


        }
        [System.Web.Services.WebMethod]
        public static string Doktoru_Listeden_Kaldır(string parametre)
        {
            if (parametre.Split('-')[0] != "undefined")
            {
                var queryWithForJson = "use kasa update Doktor_Liste set Silinmismi=1 where Doktor_Liste_Id = @1" ;

                var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
                var cmd = new SqlCommand(queryWithForJson, conn);
                cmd.Parameters.AddWithValue("@1", parametre.Split('-')[0]);
                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();
                return "1";

            }
            else
            {
                return "0";
            }



        }
    }
}