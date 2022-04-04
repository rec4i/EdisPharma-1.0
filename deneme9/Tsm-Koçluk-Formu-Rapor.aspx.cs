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
    public partial class Tsm_Koçluk_Formu_Rapor : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string Reques = null;
            Reques = Request.QueryString["x"];
            Reques = Request.QueryString["y"];
            Reques = Request.QueryString["z"];
            if (Reques != null)
            {
                try
                {
                    string Bas_Tar = Request.QueryString["x"];
                    string Bit_Tar = Request.QueryString["y"];
                    string TSM = Request.QueryString["z"];


                    //---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
                    SqlCommand cmd11 = new SqlCommand(" " +
                      "use kasa   " +
                      "if((select Kullanıcı_Bogle from Kullanıcı where KullanıcıID=2)=(select Kullanıcı_Bogle from Kullanıcı where KullanıcıAD COLLATE Latin1_general_CS_AS =@Gonderen_Kullanıcı )) " +
                      "begin; " +
                      "select (Olusturma_Tar) as Ziy_Tar,Toplam_Puan,Toplam_Puan_Yüzde,Koçluk_Formu_Genel_Id from Koçluk_Formu_Genel where Olusturma_Tar between @Bas_Tar and @Bit_Tar and Kullanıcı_Id=@Kullanıcı_Ad  order by  Olusturma_Tar desc " +
                      "end;" +
                      "", SqlC.con);



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
                catch (Exception)
                {

                    Response.Redirect("/default.aspx");
                }
                

            }
        }
        public class Tabloları_Doldur_Doktor
        {
            public string Koçluk_Formu_Genel_Id { get; set; }
            public string Koçluk_Formu_Soru_Cins_İd { get; set; }
            public string Soru_Text_Kendisi { get; set; }
            public string Soru_Puan { get; set; }
            public string Soru_Text_Not { get; set; }
            public string Resim { get; set; }
            public string Toplam_Puan { get; set; }
            public string Toplam_Puan_Yüzde { get; set; }
            public string Soru_Id { get; set; }
            
        }
        [System.Web.Services.WebMethod]
        public static string Tabloları_Doldur(string parametre)

        {
            string gelen_yıl = parametre.Split('*')[0];
            string gelen_ay = parametre.Split('*')[1];
            string Kullanıcı = parametre.Split('*')[2];


            var queryWithForJson = "select Koçluk_Formu_Genel.Koçluk_Formu_Genel_Id,Koçluk_Formu_Soru_Cins.Koçluk_Formu_Soru_Cins_İd,Koçluk_Formu_Soru.Soru_Text,Soru_Puan,Koçluk_Formu_Detay.Soru_Text,Resim,Toplam_Puan,Toplam_Puan_Yüzde,Koçluk_Formu_Detay.Soru_Id from Koçluk_Formu_Detay " +
            "" +
            "full join Koçluk_Formu_Resim " +
            "on Koçluk_Formu_Detay.Koçluk_Formu_Detay_Id=Koçluk_Formu_Resim.Koçluk_Formu_Detay_Id " +
            "" +
            "inner join Koçluk_Formu_Genel " +
            "on Koçluk_Formu_Detay.Koçluk_Formu_Genel_Id=Koçluk_Formu_Genel.Koçluk_Formu_Genel_Id " +
            "" +
            "inner join Koçluk_Formu_Soru " +
            "on Koçluk_Formu_Detay.Soru_Id=Koçluk_Formu_Soru.Koçluk_Formu_Soru_Id " +
            "" +
            "inner join Koçluk_Formu_Soru_Cins " +
            "on Koçluk_Formu_Soru.Soru_Cins=Koçluk_Formu_Soru_Cins.Koçluk_Formu_Soru_Cins_İd " +
            "" +
            "where Koçluk_Formu_Genel.Olusturma_Tar between @baslagıc_Tar and @bitis_tar and Koçluk_Formu_Genel.Kullanıcı_Id = @Kullanıcı_Adı ";




            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);
            conn.Open();
            cmd.Parameters.AddWithValue("@Kullanıcı_Adı", Kullanıcı);//@baslagıc_Tar//@bitis_tar
            cmd.Parameters.AddWithValue("@baslagıc_Tar", gelen_yıl);
            cmd.Parameters.AddWithValue("@bitis_tar", gelen_ay);



            List<Tabloları_Doldur_Doktor> tablo_Doldur_Classes = new List<Tabloları_Doldur_Doktor>();


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


                    var Tablo_Doldur_Class_ = new Tabloları_Doldur_Doktor
                    {
                        Koçluk_Formu_Genel_Id = reader.GetValue(0).ToString(),
                        Koçluk_Formu_Soru_Cins_İd = reader.GetValue(1).ToString(),
                        Soru_Text_Kendisi = reader.GetValue(2).ToString(),
                        Soru_Puan = reader.GetValue(3).ToString(),
                        Soru_Text_Not = reader.GetValue(4).ToString(),
                        Resim = reader.GetValue(5).ToString(),
                        Toplam_Puan = reader.GetValue(6).ToString(),
                        Toplam_Puan_Yüzde = reader.GetValue(7).ToString(),
                        Soru_Id = reader.GetValue(8).ToString(),
                        
                    };
                    tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
                }
            }


            //  IEnumerable < Ziy_Onay_Tablo > tablo_Doldur_Classes_ = from x in tablo_Doldur_Classes where x.Ad == "10" select x;


            string a = JsonConvert.SerializeObject(from item in tablo_Doldur_Classes group item by item.Soru_Id);

            conn.Close();
            return a;


        }
    }
}