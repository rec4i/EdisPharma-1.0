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
    public partial class Tsm_Plan_Onay : System.Web.UI.Page
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
        public static string Talebi_Onayla(string parametre)
        {
            var queryWithForJson = " " +
                "update Ziyaret_Onay set Onay_Durum=1 where Ziyaret_Onay_Id=@1";
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

                return "2";

            }


        }//Numune_Talebi_Kaldır
        public class Ziy_Onay_Tablo
        {
            public string Ad { get; set; }
            public string Soyad { get; set; }
            public string Bas_Tar { get; set; }
            public string Bit_Tar { get; set; }
            public string Ziy_Onay_Id { get; set; }
            public string Ziy_Dok { get; set; }
            public string Ziy_Ecz { get; set; }

        }
        [System.Web.Services.WebMethod]
        public static string Ziy_Onay_Tablo_Doldur(string Şehir_Id)
        {
            var queryWithForJson = "use kasa   " +
                "select AD,Soyad,Bas_Tar,Bit_Tar,Ziyaret_Onay_Id, " +
                "(select COUNT(*) from Ziyaret_Detay  " +
                "inner join Ziyaret_Genel " +
                " on Ziyaret_Detay.Ziy_Gnl_Id=Ziyaret_Genel.ID  " +
                "where Ziyaret_Genel.Kullanıcı_ID=Ziyaret_Onay.Kullanıcı_Id and Ziyaret_Detay.Cins=0 and Ziyaret_Genel.Ziy_Tar between Ziyaret_Onay.Bas_Tar and Ziyaret_Onay.Bit_Tar ) as Ziy_Dok , " +
                " (select COUNT(*) from Ziyaret_Detay  " +
                "inner join Ziyaret_Genel " +
                "on Ziyaret_Detay.Ziy_Gnl_Id=Ziyaret_Genel.ID  " +
                "where Ziyaret_Genel.Kullanıcı_ID=Ziyaret_Onay.Kullanıcı_Id and Ziyaret_Detay.Cins=1 and Ziyaret_Genel.Ziy_Tar between Ziyaret_Onay.Bas_Tar and Ziyaret_Onay.Bit_Tar ) as Ziy_Ecz " +
                "from Ziyaret_Onay  " +
                "inner join Kullanıcı " +
                "on Ziyaret_Onay.Kullanıcı_Id=Kullanıcı.KullanıcıID " +
                "where Talep_Oluşturuldumu=1 and Onay_Durum=0 and Kullanıcı.Kullanıcı_Bogle=(select Kullanıcı_Bogle from Kullanıcı where KullanıcıID=(select KullanıcıID from Kullanıcı Where KullanıcıAD=@Kullanıcı_Ad))" +
                
                
                "";

            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);
            conn.Open();
            cmd.Parameters.AddWithValue("@Kullanıcı_Ad", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());



            List<Ziy_Onay_Tablo> tablo_Doldur_Classes = new List<Ziy_Onay_Tablo>();


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
                    var Tablo_Doldur_Class_ = new Ziy_Onay_Tablo
                    {
                        Ad = reader.GetValue(0).ToString(),
                        Soyad = reader.GetValue(1).ToString(),
                        Bas_Tar = reader.GetDateTime(2).ToString("dd/MM/yyyy"),
                        Bit_Tar = reader.GetDateTime(3).ToString("dd/MM/yyyy"),
                        Ziy_Onay_Id = reader.GetValue(4).ToString(),
                        Ziy_Dok = reader.GetValue(5).ToString(),
                        Ziy_Ecz = reader.GetValue(6).ToString()
                       

                    };
                    tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
                }
            }


           //  IEnumerable < Ziy_Onay_Tablo > tablo_Doldur_Classes_ = from x in tablo_Doldur_Classes where x.Ad == "10" select x;


            conn.Close();
            return JsonConvert.SerializeObject(tablo_Doldur_Classes);


        }


    }
}