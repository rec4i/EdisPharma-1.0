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
    public partial class Materyal_Talebi : System.Web.UI.Page
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
        public static string Talebi_Kaydet(string Siparis_Array)
        {


            DataSet dataSet = JsonConvert.DeserializeObject<DataSet>(Siparis_Array);

            DataTable dataTable = dataSet.Tables["Deneme"];

            Console.WriteLine(dataTable.Rows.Count);




            var queryWithForJson = "" +
                "declare @Giren_Id table(id int);" +
                "insert into Materyal_Talep_Genel (Oluşturulma_Tar,Kullanıcı_Id) " +
                "output inserted.Materyal_Talep_Genel_Id into @Giren_Id values(GETDATE(),(select KullanıcıID from Kullanıcı where KullanıcıAD COLLATE Latin1_general_CS_AS =@Kullanıcı_Ad)) " +

                " insert into Materyal_Talep_Detay(Materyal_Talep_Genel_Id,Cins,Urun_Id,Adet)  select (select * from @Giren_Id),Cins,Urun_Id,Adet from @myTableType " +


                "";
            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);
            cmd.Parameters.AddWithValue("@Kullanıcı_Ad", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
         


            SqlParameter tvpParam = cmd.Parameters.AddWithValue("@myTableType", dataTable);
            tvpParam.SqlDbType = SqlDbType.Structured;
            tvpParam.TypeName = "dbo.Materyal_Talebi";

            conn.Open();

            var reader = cmd.ExecuteNonQuery();
            conn.Close();
            return "a";
        }


    
    public class Promosyon_Liste
        {
            public string Promosyon_Id { get; set; }
            public string Promosyon_Txt { get; set; }
           

        }
        [System.Web.Services.WebMethod]
        public static string Promosyon_Getir(string parametre)
        {
            //select * from listeler where Kullanıcı_Id=(select KullanıcıID from Kullanıcı where KullanıcıAD='recai') and cins = 0
            var queryWithForJson = "use kasa  select * from Promosyon";
              
            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);
          

            List<Promosyon_Liste> tablo_Doldur_Classes = new List<Promosyon_Liste>();

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
                    var Tablo_Doldur_Class_ = new Promosyon_Liste
                    {
                        Promosyon_Id = reader.GetValue(0).ToString(),
                        Promosyon_Txt = reader.GetValue(1).ToString()
                    };
                    tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
                }
            }
            return JsonConvert.SerializeObject(tablo_Doldur_Classes);


        }//Masrafı_Kaldır
        [System.Web.Services.WebMethod]
        public static string İlaç_Listesi(string parametre)
        {
            //select * from listeler where Kullanıcı_Id=(select KullanıcıID from Kullanıcı where KullanıcıAD='recai') and cins = 0
            var queryWithForJson = "use kasa select UrunID,UrunADI from Urunler2 ";
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
        public static string Kullanıcı_Adı_Soyadı(string parametre)
        {
            var queryWithForJson = "(select AD,Soyad from Kullanıcı where KullanıcıAD COLLATE Latin1_general_CS_AS ='" + FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString() + "') ";
            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);


            conn.Open();

            var reader = cmd.ExecuteReader();

            string a = "";
            while (reader.Read())
            {
                a += reader.GetValue(0).ToString() + " " + reader.GetValue(1).ToString() + "!";
            }
            if (a == "")
            {
                conn.Close();

                return "0-Hiç Veri Bulunamadı Lütfen";
            }
            else
            {
                conn.Close();

                return a.Substring(0, a.Length - 1);

            }


        }//Numune_Talebi_Kaldır
    }
}