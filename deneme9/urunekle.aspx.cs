using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;
using deneme9;
using System.IO;

namespace kurumsal.kurumsaluser
{
    public partial class hizmetduzenle : System.Web.UI.Page
    {
        public static string UrunResimPath = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (SqlC.con.State == ConnectionState.Open)
            {
                SqlC.con.Close();
            }
            pnl_gdogru.Visible = false;
            pnl_gyanlis.Visible = false;
            if (SqlC.con.State == ConnectionState.Open)
            {
                SqlC.con.Close();
            }

            SqlC.con.Open();
            SqlCommand cmd1 = new SqlCommand("use kasa select UrunID,UrunADI,UrunFiyat,UrunKar_Yuzde,UrunResim_Path FROM Urunler2", SqlC.con);
            cmd1.Connection = SqlC.con;
            SqlDataAdapter sda2 = new SqlDataAdapter(cmd1);
            DataTable dt1 = new DataTable();
            sda2.Fill(dt1);
            Repeater1.DataSource = dt1;
            Repeater1.DataBind();
            SqlC.con.Close();

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            float a;
            string Fiyatstr = txt_Fiyat.Text;
            string karstr = txt_Kar.Text;
            if (txt_UrunAdı.Text != "")
            {

                if (txt_Fiyat.Text != "")
                {
                    if (txt_Kar.Text != "")
                    {
                        
                        if (Single.TryParse(Fiyatstr, out a))
                        {

                            if (Single.TryParse(karstr, out a))
                            {


                                string folderPath = Server.MapPath("~/Urunler/");
                                if (!Directory.Exists(folderPath))
                                {
                                    Directory.CreateDirectory(folderPath);
                                    UrunResimPath = "~/Urunler/" + Path.GetFileName(FileUpload1.FileName);
                                }
                                FileUpload1.SaveAs(folderPath + Path.GetFileName(FileUpload1.FileName));

                                img1.ImageUrl = "~/Urunler/" + Path.GetFileName(FileUpload1.FileName);

                                UrunResimPath = img1.ImageUrl;



                                string urunıd = "";
                                SqlC.con.Open();

                                SqlC.com.CommandText = "USE KASA insert into Urunler2 (UrunADI,UrunResim_Path,UrunFiyat,UrunKar_Yuzde,Silinmismi) output INSERTED.UrunID values ('" + txt_UrunAdı.Text + "','" + UrunResimPath + "','" + txt_Fiyat.Text + "','" + txt_Kar.Text + "','0')";
                                SqlC.com.Connection = SqlC.con;
                                SqlDataReader dr = SqlC.com.ExecuteReader();
                                while (dr.Read())
                                {
                                    urunıd += dr[0];
                                }
                                dr.Close();
                                SqlC.con.Close();
                                SqlC.con.Open();
                                SqlC.com.CommandText = "use kasa  ALTER TABLE EczaneStok ADD ["+urunıd+"] int  CONSTRAINT ["+urunıd+"] DEFAULT '0' WITH VALUES";
                                SqlC.com.Connection = SqlC.con;
                                SqlC.com.ExecuteNonQuery();
                                SqlC.con.Close();





                                SqlC.con.Close();


                                //!!!!!!!!!!!! ANASAYFAYA YÖNLENDİR
                                SqlC.con.Close();
                            }
                            else
                                Response.Write("<script>alert('Lütfen İstenilen Şekilde Kar Girişi yapınız');</script>");
                            //!!!!!!!!!!!! ANASAYFAYA YÖNLENDİR
                            SqlC.con.Close();
                        }
                        else
                            Response.Write("<script>alert('Lütfen İstenilen Şekilde Fiyat Girişi yapınız');</script>");
                        //!!!!!!!!!!!! ANASAYFAYA YÖNLENDİR
                        SqlC.con.Close();
                    }
                    else
                        Response.Write("<script>alert('Kar BOŞ BIRAKILAMAZ ');</script>");

                    //!!!!!!!!!!!! ANASAYFAYA YÖNLENDİR
                    SqlC.con.Close();

                }
                else
                    Response.Write("<script>alert('Fiyat BOŞ BIRAKILAMAZ ');</script>");
                //!!!!!!!!!!!! ANASAYFAYA YÖNLENDİR
                SqlC.con.Close();
            }
            else
                Response.Write("<script>alert('Ürün Adı BOŞ BIRAKILAMAZ');</script>");

            SqlC.con.Open();
            SqlCommand cmd1 = new SqlCommand("use kasa select UrunID,UrunADI,UrunFiyat,UrunKar_Yuzde,UrunResim_Path FROM Urunler2", SqlC.con);
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