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
using static deneme9.B_Anasayfa;

namespace deneme9
{
    public partial class Sipariş_Rapor_KMY : System.Web.UI.Page
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
            string Reques = null;
            Reques = Request.QueryString["x"];
            Reques = Request.QueryString["y"];
            Reques = Request.QueryString["z"];
            if (Reques != null)
            {
                string Bas_Tar = Request.QueryString["x"];
                string Bit_Tar = Request.QueryString["y"];
                string TSM = Request.QueryString["z"];


                //---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
                SqlCommand cmd11 = new SqlCommand(" " +
                  "use kasa   " +
               
                  "select DISTINCT CAST(tar as date) as Ziy_Tar  from Sipariş_Genel where Olusturan_Kullanıcı =@Kullanıcı_Ad and CAST(tar as date) between @Bas_Tar and @Bit_Tar  " +
                  "", SqlC.con);


                string a = FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString();
                cmd11.Parameters.AddWithValue("@Kullanıcı_Ad", TSM);
                cmd11.Parameters.AddWithValue("@Gonderen_Kullanıcı", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                cmd11.Parameters.AddWithValue("@Bas_Tar", Bas_Tar);
                cmd11.Parameters.AddWithValue("@Bit_Tar", Bit_Tar);

                SqlDataAdapter sda11 = new SqlDataAdapter(cmd11);
                DataTable dt11 = new DataTable();
                sda11.Fill(dt11);
                Repeater1.DataSource = dt11;
                Repeater1.DataBind();
                SqlC.con.Close();

            }

        }
        [System.Web.Services.WebMethod]
        public static string Kullanıcı_Listesi(string Şehir_Id)
        {
            var queryWithForJson = "use kasa  " +
                "select AD,Soyad,KullanıcıID from Kullanıcı where Kullanıcı.Kullanıcı_Grup=4 and   Kullanıcı.Kullanıcı_Bogle!=0 ";

            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);
            conn.Open();
            cmd.Parameters.AddWithValue("@Kullanıcı_Ad", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());



            List<Kullanıcı_Liste> tablo_Doldur_Classes = new List<Kullanıcı_Liste>();


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
                    var Tablo_Doldur_Class_ = new Kullanıcı_Liste
                    {
                        Ad = reader.GetValue(0).ToString(),
                        Soyad = reader.GetValue(1).ToString(),
                        Kullanıcı_ID = reader.GetValue(2).ToString(),



                    };
                    tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
                }
            }
            conn.Close();
            return JsonConvert.SerializeObject(tablo_Doldur_Classes);


        }
    }
}