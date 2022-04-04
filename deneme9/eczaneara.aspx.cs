using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;
using deneme9;

namespace kurumsal.kurumsaluser
{
    public partial class haberler : System.Web.UI.Page
    {
        
      
        protected void Page_Load(object sender, EventArgs e)
        {
            if (SqlC.con.State == ConnectionState.Open)
            {
                SqlC.con.Close();
            }
            if (Session["kullanici"] != null)
            {
                //Response.Write("Hoşgeldin " + Session["kullanici"]);
                SqlC.con.Close();
            }
            else
            {
                 
                SqlC.con.Close();
            }
            if (Session["kullanici"] != null)
            {
                if (SqlC.con.State == ConnectionState.Open)
                {
                    SqlC.con.Close();
                }
                SqlC.con.Open();
                SqlCommand cmd1 = new SqlCommand("use kasa select TOP 10 EczaneID,Eczane_ADI, Eczacı_ADI, Şehirtxt,ilçetxt,semttxt,mahalletxt,Sonziyarettar FROM ECZANE2 where KullanıcıID='"+KullanıcıID()+"' and eczane_adı like '%" + txt_eczaneadı.Text + "%' and silinmismi='0' ", SqlC.con);
                cmd1.Connection = SqlC.con;
                SqlDataAdapter sda2 = new SqlDataAdapter(cmd1);
                DataTable dt1 = new DataTable();
                sda2.Fill(dt1);
                Repeater1.DataSource = dt1;
                Repeater1.DataBind();
                SqlC.con.Close();
            }
            if (!this.IsPostBack)
            {
                if (SqlC.con.State == ConnectionState.Open)
                {
                    SqlC.con.Close();
                }

                SqlC.con.Open();
                //SqlC.com.CommandText = "use kasa DELETE FROM SiparişTemP3 WHERE KullanıcıID='1';";
                SqlC.com.CommandText = "use kasa DELETE FROM SiparişTemP3 WHERE KullanıcıID='" + KullanıcıID() + "';"; // tamamlandığında bunu aç 
                SqlC.com.Connection = SqlC.con;
                SqlC.com.ExecuteNonQuery();
                SqlC.con.Close();


            }



        }
        public int KullanıcıID()
        {
            if (SqlC.con.State == ConnectionState.Open)
            {
                SqlC.con.Close();
            }
            SqlC.con.Close();

            int KullanıcıID = 0;

            SqlC.con.Open();
            SqlCommand com = new SqlCommand("use kasa select Kullanıcı.KullanıcıID from Kullanıcı where KullanıcıAD='" + Session["kullanici"] + "'", SqlC.con);
            com.Connection = SqlC.con;
            var reader = com.ExecuteReader();

            if (reader.Read())
            {
                KullanıcıID = Convert.ToInt32(reader[0]);

            }



            SqlC.con.Close();
            SqlC.con.Open();
            return Convert.ToInt32(KullanıcıID);
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            if (SqlC.con.State == ConnectionState.Open)
            {
                SqlC.con.Close();
            }
            SqlC.con.Open();
            SqlCommand cmd1 = new SqlCommand("use kasa select EczaneID,Eczane_ADI, Eczacı_ADI, Şehirtxt,ilçetxt,semttxt,mahalletxt,Sonziyarettar FROM ECZANE2 where KullanıcıID='"+KullanıcıID()+"' and eczane_adı like '%" + txt_eczaneadı.Text + "%' and silinmismi='0'", SqlC.con);
            cmd1.Connection = SqlC.con;
            SqlDataAdapter sda2 = new SqlDataAdapter(cmd1);
            DataTable dt1 = new DataTable();
            sda2.Fill(dt1);
            Repeater1.DataSource = dt1;
            Repeater1.DataBind();
            SqlC.con.Close();
        }
    }
}