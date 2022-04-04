using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace deneme9
{
    public partial class Ünite_Etrafı_Eczane_Belirle : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        public class Ünite_Bilgileri_Tablo
        {

            public string Unite_Text { get; set; }
            public string Şehir { get; set; }
            public string Brick { get; set; }


        }

        [System.Web.Services.WebMethod]
        public static string Ünite_Bilgileri(string Unite_Id)
        {



            var queryWithForJson = "select Unite_Txt,CityName,TownName from Unite " +
            "" +
            "" +
            "" +
            "inner join City " +
            "on CityID=Unite.İl_Id " +
            "" +
            "inner join Town " +
            "on TownID=Unite.Brick__Id " +

            " where Unite.Unite_ID=@Unite_Id ";








            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);
            cmd.Parameters.AddWithValue("@Unite_Id", Unite_Id);

            conn.Open();



            List<Ünite_Bilgileri_Tablo> tablo_Doldur_Classes = new List<Ünite_Bilgileri_Tablo>();
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


                    var Tablo_Doldur_Class_ = new Ünite_Bilgileri_Tablo
                    {
                        Unite_Text = reader.GetValue(0).ToString(),
                        Şehir = reader.GetValue(1).ToString(),
                        Brick = reader.GetValue(2).ToString(),


                    };
                    tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
                }
            }
            conn.Close();
            return JsonConvert.SerializeObject(tablo_Doldur_Classes);


        }
        public class Ünite_Etrafındaki_Eczaneler_Tablo
        {
            public string Eczane_Adı { get; set; }
            public string Şehir { get; set; }
            public string Brick { get; set; }
            public string Eczane_Id { get; set; }



        }

        [System.Web.Services.WebMethod]
        public static string Ünite_Etrafındaki_Eczaneler(string Unite_Id)
        {



            var queryWithForJson = "select Eczane_Adı,TownName,CityName,Eczane.Eczane_Id from Eczane " +
            "" +
            "inner join Ünite_Etrafı_Eczane " +
            "on Ünite_Etrafı_Eczane.Eczane_Id=Eczane.Eczane_Id " +
            "" +
            "inner join City " +
            "on Eczane.Eczane_Il=City.CityID " +
            "" +
            "inner join Town " +
            "on TownID=Eczane.Eczane_Brick " +
            "" +
            "where Ünite_Etrafı_Eczane.Unite_Id=@Unite_Id ";








            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);
            cmd.Parameters.AddWithValue("@Unite_Id", Unite_Id);

            conn.Open();



            List<Ünite_Etrafındaki_Eczaneler_Tablo> tablo_Doldur_Classes = new List<Ünite_Etrafındaki_Eczaneler_Tablo>();
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


                    var Tablo_Doldur_Class_ = new Ünite_Etrafındaki_Eczaneler_Tablo
                    {

                        Eczane_Adı = reader.GetValue(0).ToString(),
                        Şehir = reader.GetValue(1).ToString(),
                        Brick = reader.GetValue(2).ToString(),
                        Eczane_Id = reader.GetValue(3).ToString(),

                    };
                    tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
                }
            }
            conn.Close();
            return JsonConvert.SerializeObject(tablo_Doldur_Classes);


        }

        [System.Web.Services.WebMethod]
        public static string Ünite_Etrafındaki_Eczaneyi_Kaldır(string Eczane_Id, string Unite_Id)
        {


            var queryWithForJson = "delete from Ünite_Etrafı_Eczane where Eczane_Id=@Eczane_Id and Unite_Id=@Unite_Id";





            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);
            cmd.Parameters.AddWithValue("@Unite_Id", Unite_Id);
            cmd.Parameters.AddWithValue("@Eczane_Id", Eczane_Id);

            conn.Open();

            cmd.ExecuteNonQuery();

            conn.Close();


            return "a";
        }
        [System.Web.Services.WebMethod]
        public static string Seçili_Eczaneye_Üniteye_Ekle(string Eczane_Id, string Unite_Id)
        {


            var queryWithForJson = "if not  exists(select  * from Ünite_Etrafı_Eczane where Unite_Id=@Unite_Id and Eczane_Id=@Eczane_Id) " +
            "begin " +
            "insert into Ünite_Etrafı_Eczane (Unite_Id,Eczane_Id) values(@Unite_Id,@Eczane_Id) " +
            "select 0 " +
            "end " +
            "else " +
            "begin " +
            "select 1 " +
            "end ";





            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);
            cmd.Parameters.AddWithValue("@Unite_Id", Unite_Id);
            cmd.Parameters.AddWithValue("@Eczane_Id", Eczane_Id);
            

            conn.Open();
            var reader = cmd.ExecuteReader();
            string a = "";
            if (!reader.HasRows)
            {
                conn.Close();

                return a;
            }
            else
            {
                while (reader.Read())
                {
                    a += reader.GetValue(0).ToString();
                }
                conn.Close();
                return a;
            }

           


           
        }
    }

}
