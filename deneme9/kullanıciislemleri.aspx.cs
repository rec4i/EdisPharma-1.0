using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data.Sql;
using System.Data;
using deneme9;

namespace deneme9
{
    public partial class kullanıciislemleri : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (SqlC.con.State == ConnectionState.Open)
            {
                SqlC.con.Close();
            }
            pnl_gdogru.Visible = false;
            pnl_gyanlis.Visible = false;
            DropDownList_yetki.Items.Add("Satış Yetkisi");
            DropDownList_yetki.Items.Add("Tam Yetki");

            SqlC.con.Open();
            SqlCommand cmd11 = new SqlCommand("use kasa select KullanıcıID, AD,Soyad,KullanıcıAD,KullanıcıPass,KullanıcıYetki from Kullanıcı ", SqlC.con);
            SqlDataAdapter sda22 = new SqlDataAdapter(cmd11);
            DataTable dt11 = new DataTable();
            sda22.Fill(dt11);
            RepeaterKullanıcıBilgiÇekme.DataSource = dt11;
            RepeaterKullanıcıBilgiÇekme.DataBind();
            SqlC.con.Close();

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            
            
            if (ADtxt.Text!=null)
            {
                if (Soyadtxt.Text!=null)
                {
                    if (Kullanıcı_Adıtxt.Text!=null)
                    {
                        if (Şifretxt.Text!=null)
                        {
                            if (Şifre_Yenidentxt!=null)
                            {
                                if (DropDownList_yetki.SelectedIndex!=0)
                                {
                                    if (Şifretxt.Text == Şifre_Yenidentxt.Text)
                                    {
                                        if (SqlC.con.State==ConnectionState.Open)
                                        {
                                            SqlC.con.Close();
                                        }
                                        SqlC.con.Open();
                                        SqlC.com.CommandText = "use kasa insert into Kullanıcı (AD,Soyad,KullanıcıAD,KullanıcıPass,KullanıcıYetki) values ('" + ADtxt.Text.ToString() + "','" + Soyadtxt.Text.ToString() + "','" + Kullanıcı_Adıtxt.Text.ToString() + "','" + Şifre_Yenidentxt.Text.ToString() + "','" + DropDownList_yetki.SelectedIndex.ToString() +"');";
                                        SqlC.com.Connection = SqlC.con;
                                        SqlC.com.ExecuteNonQuery();
                                        SqlC.con.Close();


                                        SqlC.con.Open();
                                        SqlCommand cmd11 = new SqlCommand("use kasa select UrunID ,UrunADI,UrunResim_Path,UrunFiyat,UrunKar_Yuzde,UrunID from Urunler2 where Silinmismi='0' ", SqlC.con);
                                        SqlDataAdapter sda22 = new SqlDataAdapter(cmd11);
                                        DataTable dt11 = new DataTable();
                                        sda22.Fill(dt11);
                                        DropDownList_yetki.DataSource = dt11;
                                        DropDownList_yetki.DataBind();
                                        SqlC.con.Close();
                                    }
                                }
                                else
                                {
                                    Response.Write("<script>alert('Lütfen Yetki Kısmını Doldurunuz');</script>");
                                }
                            }
                            else
                            {
                                Response.Write("<script>alert('Lütfen Ad Kısmını Doldurunuz');</script>");
                            }
                        }
                        else
                        {
                            Response.Write("<script>alert('Lütfen Şifre Kısmını Doldurunuz');</script>");
                        }
                    }
                    else
                    {
                        Response.Write("<script>alert('Lütfen Kullanıcı Adı Kısmını Doldurunuz');</script>");
                    }
                }
                else
                {
                    Response.Write("<script>alert('Lütfen soyad Kısmını Doldurunuz');</script>");
                }

            }
            else
            {
                Response.Write("<script>alert('Lütfen Ad Kısmını Doldurunuz');</script>");
            }

        }


    }
}