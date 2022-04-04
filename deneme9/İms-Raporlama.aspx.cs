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
    public partial class İms_Raporlama : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

      
       
      

        public class Geçmiş_Şehir_Tablo
        {
            public string Şehir_Adı { get; set; }

        }
        [System.Web.Services.WebMethod]
        public static string Geçmiş_Şehir(string Paramatre)
        {
            try
            {


                


                var queryWithForJson =
                       "select " +
                "	Bm " +
                "	from İms_Veri  full join Eczane on Eczane.GLN_No=İms_Veri.GLN " +
                "	full join Brickler on Eczane.GLN_No=Brickler.GLN_No " +
                "	inner join Urunler on İms_Veri.Barkod=Urunler.Barkod  " +
                "" +
                "	group by Bm ";


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
                var queryWithForJson = "use kasa  " +
                    "select " +
                "	TM " +
                "	from İms_Veri  full join Eczane on Eczane.GLN_No=İms_Veri.GLN " +
                "	full join Brickler on Eczane.GLN_No=Brickler.GLN_No " +
                "	inner join Urunler on İms_Veri.Barkod=Urunler.Barkod  " +
                "" +
                "	group by TM ";


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
            public string Barkod { get; set; }

        }
        [System.Web.Services.WebMethod]
        public static string Geçmiş_Depo(string Paramatre)
        {
            try
            {
                var queryWithForJson =

                    "select " +
                "	Urun_Adı,Urunler.Barkod " +
                "	from İms_Veri  full join Eczane on Eczane.GLN_No=İms_Veri.GLN " +
                "	full join Brickler on Eczane.GLN_No=Brickler.GLN_No " +
                "	inner join Urunler on İms_Veri.Barkod=Urunler.Barkod  " +
                "" +
                "	group by Urun_Adı,Urunler.Barkod ";

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
                            Barkod = reader.GetValue(1).ToString(),


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


        public class İms_Veri_Toplam_Tablo
        {
            public string Toplam { get; set; }

        }
        [System.Web.Services.WebMethod]
        public static string İms_Veri_Toplam_Tutar(string Bölge_Müdürü, string Tıbbı_Mümmessil, string İlaç_Adı, string Bas_Tarih, string Bit_Tarih)
        {
            try
            {
                DataSet Şehir_Dataset = JsonConvert.DeserializeObject<DataSet>(Bölge_Müdürü);
                DataTable Şehir_Datatable = Şehir_Dataset.Tables["Urun_Adı_Liste"];


                DataSet Semt_Dataset = JsonConvert.DeserializeObject<DataSet>(Tıbbı_Mümmessil);
                DataTable Semt_Datatable = Semt_Dataset.Tables["Şehir_Liste"];


                DataSet Depo_Dataset = JsonConvert.DeserializeObject<DataSet>(İlaç_Adı);
                DataTable Depo_Datatable = Depo_Dataset.Tables["Depo_Liste"];





                var queryWithForJson = "" +





                "   select Sum(Adet*Guncel_ISF)" +
                   "	from İms_Veri  " +
                " full join Eczane on Eczane.GLN_No=İms_Veri.GLN " +
                "	full join Brickler on Eczane.GLN_No=Brickler.GLN_No " +
                "	inner join Urunler on İms_Veri.Barkod=Urunler.Barkod " +
                "" +








                " inner join @Geçmiş_Sorgu_Şehir_table " +
                " on (select(case when (Şehir_ is  null) then Brickler.Bm  else Şehir_  end))=Brickler.Bm " +

                " inner join @Geçmiş_Sorgu_Semt_table " +
                " on (select(case when (Semt is  null) then Brickler.TM else Semt  end))=Brickler.TM " +

               " inner join @Geçmiş_Sorgu_Depo_Adı_table " +
                " on (select(case when (Depo_Adı_ is  null) then Urunler.Barkod else Depo_Adı_  end))=Urunler.Barkod  " +






                "where Tar between @Bas_Tarih and @Bit_Tarih" +
                "";




                var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
                var cmd = new SqlCommand(queryWithForJson, conn);

                cmd.Parameters.AddWithValue("@Bas_Tarih", Bas_Tarih);
                cmd.Parameters.AddWithValue("@Bit_Tarih", Bit_Tarih);


                string check = FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString();

                SqlParameter tvpParam3 = cmd.Parameters.AddWithValue("@Geçmiş_Sorgu_Depo_Adı_table", Depo_Datatable);
                tvpParam3.SqlDbType = SqlDbType.Structured;
                tvpParam3.TypeName = "dbo.Geçmiş_Depo_Adı";


                SqlParameter tvpParam1 = cmd.Parameters.AddWithValue("@Geçmiş_Sorgu_Şehir_table", Şehir_Datatable);
                tvpParam1.SqlDbType = SqlDbType.Structured;
                tvpParam1.TypeName = "dbo.Geçmiş_Sorgu_Şehir";

                SqlParameter tvpParam2 = cmd.Parameters.AddWithValue("@Geçmiş_Sorgu_Semt_table", Semt_Datatable);
                tvpParam2.SqlDbType = SqlDbType.Structured;
                tvpParam2.TypeName = "dbo.Geçmiş_Sorgu_Semt";


                List<İms_Veri_Toplam_Tablo> tablo_Doldur_Classes = new List<İms_Veri_Toplam_Tablo>();

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
                        var Tablo_Doldur_Class_ = new İms_Veri_Toplam_Tablo
                        {
                            Toplam = reader.GetValue(0).ToString(),
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
        public static string İms_Veri_Mf_Toplam(string Bölge_Müdürü, string Tıbbı_Mümmessil, string İlaç_Adı, string Bas_Tarih, string Bit_Tarih)
        {
            try
            {
                DataSet Şehir_Dataset = JsonConvert.DeserializeObject<DataSet>(Bölge_Müdürü);
                DataTable Şehir_Datatable = Şehir_Dataset.Tables["Urun_Adı_Liste"];


                DataSet Semt_Dataset = JsonConvert.DeserializeObject<DataSet>(Tıbbı_Mümmessil);
                DataTable Semt_Datatable = Semt_Dataset.Tables["Şehir_Liste"];


                DataSet Depo_Dataset = JsonConvert.DeserializeObject<DataSet>(İlaç_Adı);
                DataTable Depo_Datatable = Depo_Dataset.Tables["Depo_Liste"];





                var queryWithForJson = "" +





                "   select Sum(Mf_Adet)" +
                   "	from İms_Veri  " +
                " full join Eczane on Eczane.GLN_No=İms_Veri.GLN " +
                "	full join Brickler on Eczane.GLN_No=Brickler.GLN_No " +
                "	inner join Urunler on İms_Veri.Barkod=Urunler.Barkod " +
                "" +








                " inner join @Geçmiş_Sorgu_Şehir_table " +
                " on (select(case when (Şehir_ is  null) then Brickler.Bm  else Şehir_  end))=Brickler.Bm " +

                " inner join @Geçmiş_Sorgu_Semt_table " +
                " on (select(case when (Semt is  null) then Brickler.TM else Semt  end))=Brickler.TM " +

               " inner join @Geçmiş_Sorgu_Depo_Adı_table " +
                " on (select(case when (Depo_Adı_ is  null) then Urunler.Barkod else Depo_Adı_  end))=Urunler.Barkod  " +






                "where Tar between @Bas_Tarih and @Bit_Tarih" +
                "";




                var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
                var cmd = new SqlCommand(queryWithForJson, conn);

                cmd.Parameters.AddWithValue("@Bas_Tarih", Bas_Tarih);
                cmd.Parameters.AddWithValue("@Bit_Tarih", Bit_Tarih);


                string check = FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString();

                SqlParameter tvpParam3 = cmd.Parameters.AddWithValue("@Geçmiş_Sorgu_Depo_Adı_table", Depo_Datatable);
                tvpParam3.SqlDbType = SqlDbType.Structured;
                tvpParam3.TypeName = "dbo.Geçmiş_Depo_Adı";


                SqlParameter tvpParam1 = cmd.Parameters.AddWithValue("@Geçmiş_Sorgu_Şehir_table", Şehir_Datatable);
                tvpParam1.SqlDbType = SqlDbType.Structured;
                tvpParam1.TypeName = "dbo.Geçmiş_Sorgu_Şehir";

                SqlParameter tvpParam2 = cmd.Parameters.AddWithValue("@Geçmiş_Sorgu_Semt_table", Semt_Datatable);
                tvpParam2.SqlDbType = SqlDbType.Structured;
                tvpParam2.TypeName = "dbo.Geçmiş_Sorgu_Semt";


                List<İms_Veri_Toplam_Tablo> tablo_Doldur_Classes = new List<İms_Veri_Toplam_Tablo>();

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
                        var Tablo_Doldur_Class_ = new İms_Veri_Toplam_Tablo
                        {
                            Toplam = reader.GetValue(0).ToString(),
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
        public static string İms_Veri_Adet_Toplam(string Bölge_Müdürü, string Tıbbı_Mümmessil, string İlaç_Adı, string Bas_Tarih, string Bit_Tarih)
        {
            try
            {
                DataSet Şehir_Dataset = JsonConvert.DeserializeObject<DataSet>(Bölge_Müdürü);
                DataTable Şehir_Datatable = Şehir_Dataset.Tables["Urun_Adı_Liste"];


                DataSet Semt_Dataset = JsonConvert.DeserializeObject<DataSet>(Tıbbı_Mümmessil);
                DataTable Semt_Datatable = Semt_Dataset.Tables["Şehir_Liste"];


                DataSet Depo_Dataset = JsonConvert.DeserializeObject<DataSet>(İlaç_Adı);
                DataTable Depo_Datatable = Depo_Dataset.Tables["Depo_Liste"];





                var queryWithForJson = "" +





                "   select Sum(Adet)" +
                 "	from İms_Veri  " +
                " full join Eczane on Eczane.GLN_No=İms_Veri.GLN " +
                "	full join Brickler on Eczane.GLN_No=Brickler.GLN_No " +
                "	inner join Urunler on İms_Veri.Barkod=Urunler.Barkod " +
                "" +








                " inner join @Geçmiş_Sorgu_Şehir_table " +
                " on (select(case when (Şehir_ is  null) then Brickler.Bm  else Şehir_  end))=Brickler.Bm " +

                " inner join @Geçmiş_Sorgu_Semt_table " +
                " on (select(case when (Semt is  null) then Brickler.TM else Semt  end))=Brickler.TM " +

               " inner join @Geçmiş_Sorgu_Depo_Adı_table " +
                " on (select(case when (Depo_Adı_ is  null) then Urunler.Barkod else Depo_Adı_  end))=Urunler.Barkod  " +






                "where Tar between @Bas_Tarih and @Bit_Tarih" +
                "";




                var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
                var cmd = new SqlCommand(queryWithForJson, conn);

                cmd.Parameters.AddWithValue("@Bas_Tarih", Bas_Tarih);
                cmd.Parameters.AddWithValue("@Bit_Tarih", Bit_Tarih);


                string check = FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString();

                SqlParameter tvpParam3 = cmd.Parameters.AddWithValue("@Geçmiş_Sorgu_Depo_Adı_table", Depo_Datatable);
                tvpParam3.SqlDbType = SqlDbType.Structured;
                tvpParam3.TypeName = "dbo.Geçmiş_Depo_Adı";


                SqlParameter tvpParam1 = cmd.Parameters.AddWithValue("@Geçmiş_Sorgu_Şehir_table", Şehir_Datatable);
                tvpParam1.SqlDbType = SqlDbType.Structured;
                tvpParam1.TypeName = "dbo.Geçmiş_Sorgu_Şehir";

                SqlParameter tvpParam2 = cmd.Parameters.AddWithValue("@Geçmiş_Sorgu_Semt_table", Semt_Datatable);
                tvpParam2.SqlDbType = SqlDbType.Structured;
                tvpParam2.TypeName = "dbo.Geçmiş_Sorgu_Semt";


                List<İms_Veri_Toplam_Tablo> tablo_Doldur_Classes = new List<İms_Veri_Toplam_Tablo>();

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
                        var Tablo_Doldur_Class_ = new İms_Veri_Toplam_Tablo
                        {
                            Toplam = reader.GetValue(0).ToString(),
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
            public string TM { get; set; }
            public string BM { get; set; }
            public string ÜRÜN { get; set; }
            public string Eczane_Adı { get; set; }
            public string Adet { get; set; }
            public string Mf_Adet { get; set; }
            public string Toplam { get; set; }
            public string Güncel_İsf { get; set; }
            public string Güncel_Dsf { get; set; }
            public string Güncel_Psf { get; set; }
            public string Toplam_İsf { get; set; }
            public string Tarih { get; set; }
            public string Toplam_Adet { get; set; }
            public string Toplam_Mf_Adet { get; set; }
            public string Toplam_Tutar { get; set; }
        }

        [System.Web.Services.WebMethod]
        public static string İms_Veri_Getir(string Bölge_Müdürü, string Tıbbı_Mümmessil, string İlaç_Adı, string Bas_Tarih,string Bit_Tarih)
        {




            DataSet Şehir_Dataset = JsonConvert.DeserializeObject<DataSet>(Bölge_Müdürü);
            DataTable Şehir_Datatable = Şehir_Dataset.Tables["Urun_Adı_Liste"];


            DataSet Semt_Dataset = JsonConvert.DeserializeObject<DataSet>(Tıbbı_Mümmessil);
            DataTable Semt_Datatable = Semt_Dataset.Tables["Şehir_Liste"];


            DataSet Depo_Dataset = JsonConvert.DeserializeObject<DataSet>(İlaç_Adı);
            DataTable Depo_Datatable = Depo_Dataset.Tables["Depo_Liste"];


     


            var queryWithForJson = "" +
   




            "   select isnull(TM,'Boş Böle')," +
            "	isnull(Bm,'Boş Bölge')," +
            "	Urunler.Urun_Adı," +
            "	isnull(Eczane_Adı,'İşlenmemiş')," +
            "	Adet,Mf_Adet," +
            "	(Adet+Mf_Adet)as toplam,Guncel_ISF," +
            "	Guncel_DSF,KDV_Guncel_PSF," +
            "	(Adet*Urunler.Guncel_ISF)as Toplam_İsf ," +
            "	İms_Veri.Tar" +
            "	from İms_Veri  " +
            " full join Eczane on Eczane.GLN_No=İms_Veri.GLN " +
            "	full join Brickler on Eczane.GLN_No=Brickler.GLN_No " +
            "	inner join Urunler on İms_Veri.Barkod=Urunler.Barkod " +
            "" +








            " inner join @Geçmiş_Sorgu_Şehir_table " +
            " on (select(case when (Şehir_ is  null) then Brickler.Bm  else Şehir_  end))=Brickler.Bm " +

            " inner join @Geçmiş_Sorgu_Semt_table " +
            " on (select(case when (Semt is  null) then Brickler.TM else Semt  end))=Brickler.TM " +

           " inner join @Geçmiş_Sorgu_Depo_Adı_table " +
            " on (select(case when (Depo_Adı_ is  null) then Urunler.Barkod else Depo_Adı_  end))=Urunler.Barkod  " +






            "where Tar between @Bas_Tarih and @Bit_Tarih" +
            "";




            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);

            cmd.Parameters.AddWithValue("@Bas_Tarih", Bas_Tarih);
            cmd.Parameters.AddWithValue("@Bit_Tarih", Bit_Tarih);


            string check = FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString();

            SqlParameter tvpParam3 = cmd.Parameters.AddWithValue("@Geçmiş_Sorgu_Depo_Adı_table", Depo_Datatable);
            tvpParam3.SqlDbType = SqlDbType.Structured;
            tvpParam3.TypeName = "dbo.Geçmiş_Depo_Adı";


            SqlParameter tvpParam1 = cmd.Parameters.AddWithValue("@Geçmiş_Sorgu_Şehir_table", Şehir_Datatable);
            tvpParam1.SqlDbType = SqlDbType.Structured;
            tvpParam1.TypeName = "dbo.Geçmiş_Sorgu_Şehir";

            SqlParameter tvpParam2 = cmd.Parameters.AddWithValue("@Geçmiş_Sorgu_Semt_table", Semt_Datatable);
            tvpParam2.SqlDbType = SqlDbType.Structured;
            tvpParam2.TypeName = "dbo.Geçmiş_Sorgu_Semt";

        

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
                        //TM = reader.GetValue(0).ToString(),
                        //BM = reader.GetValue(1).ToString(),
                        //ÜRÜN = reader.GetValue(0).ToString(),
                        //Eczane_Adı = reader.GetValue(1).ToString(),
                        //Adet = reader.GetValue(2).ToString(),
                        //Mf_Adet = reader.GetValue(0).ToString(),
                        //Toplam = reader.GetValue(0).ToString(),
                        //Güncel_İsf = reader.GetValue(0).ToString(),
                        //Güncel_Dsf = reader.GetValue(0).ToString(),
                        //Güncel_Psf = reader.GetValue(0).ToString(),
                        //Toplam_İsf = reader.GetValue(0).ToString(),
                        //Tarih = reader.GetValue(0).ToString(),

                        TM = reader.GetValue(0).ToString(),
                        BM = reader.GetValue(1).ToString(),
                        ÜRÜN = reader.GetValue(2).ToString(),
                        Eczane_Adı = reader.GetValue(3).ToString(),
                        Adet = reader.GetValue(4).ToString(),
                        Mf_Adet = reader.GetValue(5).ToString(),
                        Toplam = reader.GetValue(6).ToString(),
                        Güncel_İsf = reader.GetValue(7).ToString(),
                        Güncel_Dsf = reader.GetValue(8).ToString(),
                        Güncel_Psf = reader.GetValue(9).ToString(),
                        Toplam_İsf = reader.GetValue(10).ToString(),
                        Tarih = reader.GetValue(11).ToString(),


                    };
                    tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
                }
            }
            conn.Close();
            return JsonConvert.SerializeObject(tablo_Doldur_Classes);




        }//Masrafı_Kaldır

        



    }
}