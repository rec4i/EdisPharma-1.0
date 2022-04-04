using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace deneme9
{
    public partial class Doktor_Ekle_Cikar : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //if (Session["kullanici"] != null)
            //{
            //    //Response.Write("Hoşgeldin " + Session["kullanici"]);
            //    SqlC.con.Close();
            //}
            //else
            //{
            //     
            //    SqlC.con.Close();
            //}

        }
        [System.Web.Services.WebMethod]
        public static void Doktoru_Ekle(string Doktor_Ad, string Doktor_Branş, string Doktor_Unite)
        {
            var queryWithForJson1 = "use kasa  " +
       
                "INSERT INTO Doktors(Doktors.Doktor_Ad,Doktors.Doktor_Brans_Id,Doktors.Doktor_Unite_ID) " +
                "values (@Doktor_Ad,@Branş_Id,@Unite_Id) " +

                "if not exists(select * from Unite_Branş_Liste where Unite_Branş_Liste.Unite_Id=@Unite_Id and Unite_Branş_Liste.Branş_Id=@Branş_Id) " +
                "begin;" +
                "insert into Unite_Branş_Liste (Unite_Branş_Liste.Unite_Id,Unite_Branş_Liste.Branş_Id) " +
                "values(@Unite_Id,@Branş_Id) " +
                "end; " +
    
              
                "";

         
            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson1, conn);
            cmd.Parameters.AddWithValue("@Unite_Id", Doktor_Unite);
            cmd.Parameters.AddWithValue("@Branş_Id", Doktor_Branş);
            cmd.Parameters.AddWithValue("@Doktor_Ad", Doktor_Ad);
            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();


           



         







        }
        [System.Web.Services.WebMethod]
        public static void Doktoru_Cıkar(string parametre)
        {
            var queryWithForJson1 = "use kasa " +
                "update Doktor_Liste set Silinmismi=1 where Doktor_ıd= @Doktor_Id " +
                "" +
                "UPDATE Doktors set Silinmismi=1 where Doktor_Id=@Doktor_Id " +
                "" +
                "";
              
            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson1, conn);
            cmd.Parameters.AddWithValue("@Doktor_Id", parametre.Split('-')[0]);
            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();
           

        }




        [System.Web.Services.WebMethod]
        public static string Doktoru_Brans(string parametre)
        {
            try
            {
                var queryWithForJson = "select * from doktors where Doktor_brans_ıd=" + parametre.Split('-')[1] + " and Silinmismi=0 and Doktor_Unite_ID=" + parametre.Split('-')[2];
                var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
                var cmd = new SqlCommand(queryWithForJson, conn);
                conn.Open();

                var reader = cmd.ExecuteReader();

                string a = "";



                if (!reader.HasRows)
                {
                    conn.Close();
                    return "hata-Uniteye Kayıtlı Doktor Bulunamadı-hata";
                }
                else
                {
                    while (reader.Read())
                    {

                        a += reader.GetValue(0).ToString() + "-" + reader.GetValue(1).ToString().Trim() + "!";

                    }
                    conn.Close();
                    return a.Substring(0, a.Length - 1);
                }
            }
            catch (Exception)
            {
                return "hata-Uniteye Kayıtlı Doktor Bulunamadı-hata";

                throw;
            }







        }
        [System.Web.Services.WebMethod]
        public static string OrnekPost(string parametre)
        {


            var queryWithForJson1 = "use kasa select * from Branchs";
            var conn1 = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd1 = new SqlCommand(queryWithForJson1, conn1);

            conn1.Open();

            var reader1 = cmd1.ExecuteReader();


            string b = "";

            while (reader1.Read())
            {
                b += reader1.GetValue(0).ToString() + "-" + reader1.GetValue(1).ToString().Trim() + "!";
                continue;
            }

            reader1.Close();
            conn1.Close();
            return b.Substring(0, b.Length - 1);








        }
    }
}