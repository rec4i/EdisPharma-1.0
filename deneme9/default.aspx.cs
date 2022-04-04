using deneme9;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Web.Security;

namespace kurumsal.kurumsaluser
{
    public partial class _default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (SqlC.con.State == ConnectionState.Open)
            {
                SqlC.con.Close();
            }
            pnl_ddogru.Visible = false;
            pnl_dyanlis.Visible = false;
            Response.Cookies.Clear();
            System.Web.HttpContext.Current.Request.Cookies.Clear();

        }

        protected void btn_giris_Click(object sender, EventArgs e)
        {
            SqlC.com = new SqlCommand(); //where uname COLLATE Latin1_general_CS_AS = @uname and upass COLLATE Latin1_general_CS_AS = @upass
            SqlC.con.Open();
            SqlC.com.Connection = SqlC.con;
            SqlC.com.CommandText = "USE KASA SELECT * FROM KULLANICI where KULLANICIAD COLLATE Latin1_general_CS_AS =@1  AND KullanıcıPass COLLATE Latin1_general_CS_AS = @2";
            SqlC.com.Parameters.AddWithValue("@1", txt_kullanici.Text);
            SqlC.com.Parameters.AddWithValue("@2", txt_sifre.Text);
            SqlDataReader dr = SqlC.com.ExecuteReader();



            if (dr.Read())
            {

                FormsAuthenticationTicket ticket1 =
                   new FormsAuthenticationTicket(
                        1,                                   // version
                        txt_kullanici.Text,   // get username  from the form
                        DateTime.Now,                        // issue time is now
                        DateTime.Now.AddMinutes(10),         // expires in 10 minutes
                        false,      // cookie is not persistent
                        "U"                              // role assignment is stored
                                                          // in userData
                        );
                HttpCookie cookie1 = new HttpCookie(
                  FormsAuthentication.FormsCookieName,
                  FormsAuthentication.Encrypt(ticket1));
                Response.Cookies.Add(cookie1);
                //Session.Add("kullanici", txt_kullanici.Text);

                
                var queryWithForJson = "use kasa  " +
                    "insert into Son_Yapılan_Islem (İslem_Tipi,Kullanıcı_Id,İslem_Tar) values(1, " +
                    "(select KullanıcıID from Kullanıcı where KullanıcıAD COLLATE Latin1_general_CS_AS=@1), " +
                    "GETDATE() " +
                    ") " +
                    "" +
                    "select Kullanıcı_Grup,KullanıcıID from Kullanıcı where KullanıcıAD COLLATE Latin1_general_CS_AS=@1";
                var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
                var cmd = new SqlCommand(queryWithForJson, conn);
                cmd.Parameters.AddWithValue("@1", FormsAuthentication.Decrypt(System.Web.HttpContext.Current.Request.Cookies[".ASPXAUTH"].Value).Name.ToString());
                conn.Open();

                var reader = cmd.ExecuteReader();

                string a = "";
              
                while (reader.Read())
                {
                    a += reader.GetValue(0).ToString();
                    //Session.Add("Kullanıcı_Id", reader.GetValue(1).ToString());
                }
                conn.Close();

                if (a == "1")
                {
                    Response.Redirect("B-Anasayfa.aspx");
                }
                if (a == "2")
                {
                    Response.Redirect("Bs-Anasayfa.aspx");
                }
                if (a == "4")
                {
                    Response.Redirect("Anasayfa.aspx");
                }
                if (a == "5")
                {
                    Response.Redirect("Anasayfa.aspx");
                }
                if (a == "3")
                {
                    Response.Redirect("Sipariş-Onay.aspx");
                }
                if (a == "6")
                {
                    Response.Redirect("Sipariş_Rapor_KMY.aspx");
                }


                pnl_ddogru.Visible = true;
              

            }
            else
            {
                pnl_dyanlis.Visible = true;
            
            }
            SqlC.con.Close();
        }
    }
}