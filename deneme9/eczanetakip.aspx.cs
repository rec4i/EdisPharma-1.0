using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;
using deneme9;

namespace kurumsal.kurumsaluser
{
    public partial class makaleler : System.Web.UI.Page
    {
        //esqbaglantisi baglan = new esqbaglantisi();
        //string makaleID = "";
        //string islem = "";
        public List<string> urunıd = new List<string>();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (SqlC.con.State == ConnectionState.Open)
            {
                SqlC.con.Close();
            }

            //RadioButtonList1.Items.Add("Stok Adetine Göre Sırala (En az En başta!)");
            //RadioButtonList1.Items.Add("Son Ziyaret Tarihine Göre Sırala");

            pnl_gdogru.Visible = false;
            pnl_gyanlis.Visible = false;
            if (Session["kullanici"] != null)
            {
                //Response.Write("Hoşgeldin " + Session["kullanici"]);
                SqlC.con.Close();
            }
            else
            {
                 
                SqlC.con.Close();
            }



            // sorgular
            ///use kasa select *  from ECZANE2,EczaneStok where ECZANE2.EczaneID=EczaneStok.EczaneID and Eczane_ADI like '%%' and Şehirtxt like '%%' and ilçetxt like '%%' and semttxt like '%%'  order by MaxDefendC desc ,Sonziyarettar 

            //  use kasa SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'EczaneStok'  and COLUMN_NAME not like 'EczaneStokID' and COLUMN_NAME not like 'EczaneID'
            //makaleID = Request.QueryString["makaleID"];
            //islem = Request.QueryString["islem"];

            //şehir doldurma
            if (!Page.IsPostBack)
            {
                SqlCommand cmd1 = new SqlCommand("use kasa select * from city ", SqlC.con);
                SqlDataAdapter sda1 = new SqlDataAdapter(cmd1);
                DataTable dt1 = new DataTable();
                sda1.Fill(dt1);
                DropDownListmf.DataSource = dt1;
                DropDownListmf.DataBind();
                SqlC.con.Close();
            }
            if (!Page.IsPostBack)
            {
                
                string urunadı = "";
                SqlC.con.Open();
                SqlCommand cmd = new SqlCommand("use kasa SELECT ROW_NUMBER() OVER(ORDER BY COLUMN_NAME) as Sıra ,COLUMN_NAME as İlaçAdı FROM INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'EczaneStok'  and COLUMN_NAME not like 'EczaneStokID' and COLUMN_NAME not like 'EczaneID' and COLUMN_NAME not like 'StokOnayDurum' and COLUMN_NAME not like 'StokOnayCss' and COLUMN_NAME not like 'StokOnaytxt' and COLUMN_NAME not like 'StokOnaytar'", SqlC.con);
                cmd.Connection = SqlC.con;
                SqlDataReader dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    urunıd.Add(dr[1].ToString());
                }
                dr.Close();
                SqlC.con.Close();
                for (int i = 0; i < urunıd.Count(); i++)
                {
                    if (urunıd.Count()-1 == i)
                    {
                        urunadı += " UrunID= " + urunıd[i] + "";
                    }
                    else
                    {
                        urunadı += " UrunId= " + urunıd[i] + " or ";
                    }
                }
                SqlC.con.Open();
                SqlC.com.CommandText = "use kasa select UrunADI, UrunID from Urunler2 where "+urunadı+"";
                SqlDataAdapter sda = new SqlDataAdapter(SqlC.com);
                DataTable dt = new DataTable();
                sda.Fill(dt);
                DropDownList3.DataSource = dt;
                DropDownList3.DataBind();
                SqlC.con.Close();
            }


        }
        public int KullanıcıID()
        {
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
        protected void DropDownListmf_SelectedIndexChanged(object sender, EventArgs e)
        {

            SqlCommand cmd = new SqlCommand("use kasa select * from Town where CityID =" + DropDownListmf.SelectedItem.Value, SqlC.con);

            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            DropDownList1.DataSource = dt;
            DropDownList1.DataBind();
            SqlC.con.Close();



        }
        protected void DropDownList1_SelectedIndexChanged1(object sender, EventArgs e)
        {
            SqlCommand cmd = new SqlCommand("use kasa select * from District where TownID =" + DropDownList1.SelectedItem.Value, SqlC.con);
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            DropDownList2.DataSource = dt;
            DropDownList2.DataBind();
            SqlC.con.Close();
        }

        public int KalanGunHesapla(DateTime Deger)
        {
            DateTime bugun = DateTime.Now;
            TimeSpan KalanGunSayısı = bugun - Deger;
            return Convert.ToInt32(KalanGunSayısı.Days);


        }
        public string KalanGunHesapla(int Deger)
        {
            if (Deger <= 7)
            {
                return SqlC.GecenGun7css;

            }
            else if (Deger>7 &&Deger <= 15)
            {
                return SqlC.GecenGun15css;

            }
            else if (Deger>15 &&Deger <= 30)
            {
                return SqlC.GecenGun30css;

            }
            else
            {
                return SqlC.GecenGun30css;
            }

        }
        public string ModalKontrol(string a)
        {
            if (a== "toggle")
            {
                return "modal";
            }
            if (a== "target")
            {
                return "#myModal";
            }
            else
            {
                return "";
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string bos = null;
            if (DropDownListmf.SelectedIndex == 0)
            {
                DropDownListmf.Items.Clear();
                DropDownListmf.Items.Add(bos);

            }
            if (DropDownList1.SelectedIndex == 0)
            {
                DropDownList1.Items.Clear();
                DropDownList1.Items.Add(bos);
            }
            if (DropDownList2.SelectedIndex == 0)
            {
                DropDownList2.Items.Clear();
                DropDownList2.Items.Add(bos);
            }
            if (DropDownList3.SelectedIndex == 0)
            {
                DropDownList3.Items.Clear();
                DropDownList3.Items.Add(bos);
            }
            if (radioButton1.Checked==false && radioButton2.Checked==false)
            {
                Response.Write("<script language=javascript>alert('Lütfen Bir Sıralama Şekli Seçiniz ')</script>");
            }
            //stok adetine göre sırala
            
            if (radioButton1.Checked==true)
            {
                if (DropDownList3.SelectedIndex==0)
                {

                    Response.Write("<script language=javascript>alert('Lütfen Bir İlaç Seçiniz ')</script>");
                }
                else
                {
                    SqlCommand cmd11 = new SqlCommand("use kasa select *  from ECZANE2,EczaneStok where ECZANE2.silinmismi='0' and ECZANE2.EczaneID=EczaneStok.EczaneID and Eczane_ADI like '%" + txt_mbaslik .Text+ "%' and Şehirtxt like '%" + DropDownListmf.SelectedItem.Text.ToString() + "%' and ilçetxt like '%" + DropDownList1.SelectedItem.Text.ToString() + "%' and semttxt like '%" + DropDownList2.SelectedItem.Text.ToString() + "%' and KullanıcıID='"+KullanıcıID()+"'   order by [" + DropDownList3.SelectedValue.ToString() + "] desc ", SqlC.con);
                    SqlDataAdapter sda11 = new SqlDataAdapter(cmd11);
                    DataTable dt11 = new DataTable();
                    sda11.Fill(dt11);
                    RepeaterSiparisOnayDurum.DataSource = dt11;
                    RepeaterSiparisOnayDurum.DataBind();
                    SqlC.con.Close();
                }
               
            }

            //tarihe göre sırala
            if (radioButton2.Checked==true)
            {
                SqlCommand cmd2 = new SqlCommand("use kasa select *  from ECZANE2,EczaneStok where ECZANE2.silinmismi='0' and  ECZANE2.EczaneID=EczaneStok.EczaneID and Eczane_ADI like '%" + txt_mbaslik.Text + "%' and Şehirtxt like '%" + DropDownListmf.SelectedItem.Text.ToString() + "%' and ilçetxt like '%" + DropDownList1.SelectedItem.Text.ToString() + "%' and semttxt like '%" + DropDownList2.SelectedItem.Text.ToString() + "%' and KullanıcıID='"+KullanıcıID()+"'   order by Sonziyarettar asc ", SqlC.con);
                SqlDataAdapter sda2 = new SqlDataAdapter(cmd2);
                DataTable dt2 = new DataTable();
                sda2.Fill(dt2);
                RepeaterSiparisOnayDurum.DataSource = dt2;
                RepeaterSiparisOnayDurum.DataBind();
                SqlC.con.Close();
            }


           

            DropDownListmf.Items.Clear();
            DropDownListmf.Items.Add("-- Şehir Seç --");

            DropDownList1.Items.Clear();
            DropDownList1.Items.Add("-- İlçe Seç");

            DropDownList2.Items.Clear();
            DropDownList2.Items.Add("-- Semt Seç--");

            DropDownList3.Items.Clear();
            DropDownList3.Items.Add("-- İlaç Seç --");

            SqlCommand cmd1 = new SqlCommand("use kasa select * from city ", SqlC.con);
            SqlDataAdapter sda1 = new SqlDataAdapter(cmd1);
            DataTable dt1 = new DataTable();
            sda1.Fill(dt1);
            DropDownListmf.DataSource = dt1;
            DropDownListmf.DataBind();
            SqlC.con.Close();
            //ilaç ddl doldur
            string urunadı = "";
            SqlC.con.Open();
            SqlCommand cmd = new SqlCommand("use kasa SELECT ROW_NUMBER() OVER(ORDER BY COLUMN_NAME) as Sıra ,COLUMN_NAME as İlaçAdı FROM INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'EczaneStok'  and COLUMN_NAME not like 'EczaneStokID' and COLUMN_NAME not like 'EczaneID' and COLUMN_NAME not like 'StokOnayDurum' and COLUMN_NAME not like 'StokOnayCss' and COLUMN_NAME not like 'StokOnaytxt' and COLUMN_NAME not like 'StokOnaytar'", SqlC.con);
            cmd.Connection = SqlC.con;
            SqlDataReader dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                urunıd.Add(dr[1].ToString());
            }
            dr.Close();
            SqlC.con.Close();
            for (int i = 0; i < urunıd.Count(); i++)
            {
                if (urunıd.Count() - 1 == i)
                {
                    urunadı += " UrunID= " + urunıd[i] + "";
                }
                else
                {
                    urunadı += " UrunId= " + urunıd[i] + " or ";
                }
            }
            SqlC.con.Open();
            SqlC.com.CommandText = "use kasa select UrunADI, UrunID from Urunler2 where " + urunadı + "";
            SqlDataAdapter sda = new SqlDataAdapter(SqlC.com);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            DropDownList3.DataSource = dt;
            DropDownList3.DataBind();
            SqlC.con.Close();

        }


    }
}