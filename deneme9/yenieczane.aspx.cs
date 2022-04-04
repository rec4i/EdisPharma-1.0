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
    public partial class haberduzenle : System.Web.UI.Page
    {
        public string EczaneIDGelen = null;
        public string Islem = null;
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

            EczaneIDGelen = Request.QueryString["EczaneID"];
            Islem = Request.QueryString["islem"];
            pnl_gdogru.Visible = false;
            pnl_gyanlis.Visible = false;
            
            if (!Page.IsPostBack)
            {
                SqlCommand cmd = new SqlCommand("use kasa select * from city ", SqlC.con);
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                sda.Fill(dt);
                DropDownListmf.DataSource = dt;
                DropDownListmf.DataBind();
                SqlC.con.Close();
            }
            if (!Page.IsPostBack)
            {
                if (Islem == "duzenle")
                {

                    buttonguncelle.Visible = true;
                    Button1.Visible = false;
                    Button2.Visible = false;
                    boxtitle.InnerText = "Eczane Düzenle";
                    SqlC.con.Open();
                    SqlC.com.CommandText = "use kasa select * from ECZANE2 where EczaneID='" + EczaneIDGelen + "' and KullanıcıID='" + KullanıcıID() + "'";
                    SqlC.com.Connection = SqlC.con;
                    SqlDataReader dr = SqlC.com.ExecuteReader();
                    DataTable dtable = new DataTable("bilgi");
                    dtable.Load(dr);
                    DataRow row = dtable.Rows[0];
                    SqlC.con.Close();
                    txt_EczaneAdı.Text = row["Eczane_ADI"].ToString();
                    txt_EczacıAdı.Text = row["Eczacı_ADI"].ToString();
                    txt_Telefon1.Text = row["telefon"].ToString();
                    txt_Telefon2.Text = row["telefon2"].ToString();
                    txt_Notlar.Text = row["NOTLAR"].ToString();
                    DropDownListmf.SelectedIndex = DropDownListmf.Items.IndexOf(DropDownListmf.Items.FindByText(row["Şehirtxt"].ToString()));


                    if (SqlC.con.State == ConnectionState.Open)
                    {
                        SqlC.con.Close();
                    }
                    SqlC.con.Open();
                    SqlCommand cmd = new SqlCommand("use kasa select * from Town where CityID =" + DropDownListmf.SelectedItem.Value, SqlC.con);

                    SqlDataAdapter sda = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    sda.Fill(dt);
                    DropDownList1.DataSource = dt;
                    DropDownList1.DataBind();
                    SqlC.con.Close();
                    DropDownList1.SelectedIndex = DropDownList1.Items.IndexOf(DropDownList1.Items.FindByText(row["ilçetxt"].ToString()));

                    if (SqlC.con.State == ConnectionState.Open)
                    {
                        SqlC.con.Close();
                    }
                    SqlC.con.Open();
                    SqlCommand cmd1 = new SqlCommand("use kasa select * from District where TownID =" + DropDownList1.SelectedItem.Value, SqlC.con);
                    SqlDataAdapter sda1 = new SqlDataAdapter(cmd1);
                    DataTable dt1 = new DataTable();
                    sda1.Fill(dt1);
                    DropDownList2.DataSource = dt1;
                    DropDownList2.DataBind();
                    SqlC.con.Close();
                    DropDownList2.SelectedIndex = DropDownList2.Items.IndexOf(DropDownList2.Items.FindByText(row["semttxt"].ToString()));



                    if (SqlC.con.State == ConnectionState.Open)
                    {
                        SqlC.con.Close();
                    }
                    SqlC.con.Open();
                    SqlCommand cmd2 = new SqlCommand("use kasa select * from Neighborhood where DistrictID =" + DropDownList2.SelectedItem.Value, SqlC.con);
                    SqlDataAdapter sda2 = new SqlDataAdapter(cmd2);
                    DataTable dt2 = new DataTable();
                    sda2.Fill(dt2);
                    DropDownList3.DataSource = dt2;
                    DropDownList3.DataBind();
                    SqlC.con.Close();
                    DropDownList3.SelectedIndex = DropDownList3.Items.IndexOf(DropDownList3.Items.FindByText(row["mahalletxt"].ToString()));

                    Button3.Visible = true;




                }
                else
                {
                    buttonguncelle.Visible = false;
                }

            }


        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            // bittiğinde kullanıcı ıd ye göre gir eczaneyi
            if (SqlC.con.State == ConnectionState.Open)
            {
                SqlC.con.Close();
            }
            SqlC.con.Open();
            SqlC.com.Connection = SqlC.con;
            SqlC.com.CommandText = "USE KASA INSERT INTO KASA.dbo.ECZANE2 (telefon2,Eczane_ADI,Eczacı_ADI,Şehir,ilçe,semt,mahalle,telefon,NOTLAR,KullanıcıID,OlusturulmaTar,Şehirtxt,ilçetxt,semttxt,mahalletxt,Sonziyarettar) values('" + txt_Telefon2.Text + "','" + txt_EczaneAdı.Text + "','" + txt_EczacıAdı.Text + "','" + DropDownListmf.SelectedItem.Value + "','" + DropDownList1.SelectedItem.Value + "','" + DropDownList2.SelectedItem.Value + "','" + DropDownList3.SelectedItem.Value + "','" + txt_Telefon1.Text + "','" + txt_Notlar.Text + "','" + KullanıcıID() + "',GETDATE(),'" + DropDownListmf.SelectedItem.ToString() + "','" + DropDownList1.SelectedItem.ToString() + "','" + DropDownList2.SelectedItem.ToString() + "','" + DropDownList3.SelectedItem.ToString() + "" + "',GETDATE())";

            SqlC.com.ExecuteNonQuery();
            SqlC.con.Close();
            SqlC.con.Open();
            SqlC.com.Connection = SqlC.con;
            SqlC.com.CommandText = "use kasa insert  into EczaneStok (EczaneID) values ('" + EczaneID() + "')";
            if (SqlC.con.State == ConnectionState.Open)
            {
                SqlC.con.Close();
            }
            if (SqlC.con.State == ConnectionState.Closed)
            {
                SqlC.con.Open();
            }
            SqlC.com.ExecuteNonQuery();
            SqlC.con.Close();
            Response.Redirect("eczaneara.aspx");



        }
        public int KullanıcıID()
        {
            if (SqlC.con.State == ConnectionState.Open)
            {
                SqlC.con.Close();
            }


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
            if (SqlC.con.State == ConnectionState.Open)
            {
                SqlC.con.Close();
            }
            DropDownList1.Items.Clear();
            DropDownList1.Items.Add("-- İlçe Seç --");
            SqlC.con.Open();
            SqlCommand cmd = new SqlCommand("use kasa select * from Town where CityID =" + DropDownListmf.SelectedItem.Value, SqlC.con);

            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            DropDownList1.DataSource = dt;
            DropDownList1.DataBind();
            SqlC.con.Close();



        }

        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (SqlC.con.State == ConnectionState.Open)
            {
                SqlC.con.Close();
            }
            DropDownList2.Items.Clear();
            DropDownList2.Items.Add("-- Semt Seç --");
            SqlC.con.Open();
            SqlCommand cmd = new SqlCommand("use kasa select * from District where TownID = " + DropDownList1.SelectedItem.Value, SqlC.con);
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            DropDownList2.DataSource = dt;
            DropDownList2.DataBind();
            SqlC.con.Close();



        }

        protected void DropDownList2_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (SqlC.con.State == ConnectionState.Open)
            {
                SqlC.con.Close();
            }
            DropDownList3.Items.Clear();
            DropDownList3.Items.Add("-- Mahalle Seç --");
            SqlC.con.Open();
            SqlCommand cmd = new SqlCommand("use kasa select * from Neighborhood where DistrictID =" + DropDownList2.SelectedItem.Value, SqlC.con);
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            DropDownList3.DataSource = dt;
            DropDownList3.DataBind();
            SqlC.con.Close();

        }
        public int EczaneID()
        {
            int EczaneID = 0;
            if (SqlC.con.State == ConnectionState.Open)
            {
                SqlC.con.Close();
            }
            SqlC.con.Open();
            SqlC.com.CommandText = " use kasa  select max(EczaneID) from ECZANE2 where kullanıcııd='" + KullanıcıID() + "'";
            SqlDataReader da = SqlC.com.ExecuteReader();
            while (da.Read())
            {
                EczaneID = (int)da[0];
            }
            SqlC.con.Close();
            return EczaneID;
        }

        protected void Button2_Click(object sender, EventArgs e)
        {

            // bittiğinde kullanıcı ıd ye göre gir eczaneyi
            //try
            //{
            if (SqlC.con.State == ConnectionState.Open)
            {
                SqlC.con.Close();
            }
            SqlC.con.Open();
            SqlC.com.Connection = SqlC.con;
            SqlC.com.CommandText = "USE KASA INSERT INTO KASA.dbo.ECZANE2 (Eczane_ADI,Eczacı_ADI,Şehir,ilçe,semt,mahalle,telefon,NOTLAR,KullanıcıID,OlusturulmaTar,Şehirtxt,ilçetxt,semttxt,mahalletxt,Sonziyarettar) values('" + txt_EczaneAdı.Text + "','" + txt_EczacıAdı.Text + "','" + DropDownListmf.SelectedItem.Value + "','" + DropDownList1.SelectedItem.Value + "','" + DropDownList2.SelectedItem.Value + "','" + DropDownList3.SelectedItem.Value + "','" + txt_Telefon1.Text + "','" + txt_Notlar.Text + "','" + KullanıcıID() + "',GETDATE(),'" + DropDownListmf.SelectedItem.ToString() + "','" + DropDownList1.SelectedItem.ToString() + "','" + DropDownList2.SelectedItem.ToString() + "','" + DropDownList3.SelectedItem.ToString() + "" + "',GETDATE())";

            SqlC.com.ExecuteNonQuery();
            SqlC.com.CommandText = "use kasa declare @EczaneID nvarchar(50) set @EczaneID = ( select max(EczaneID) from ECZANE2 where kullanıcııd='" + KullanıcıID() + "') update Kullanıcı set KullanıcıTEMP=@EczaneID where KullanıcıID='" + KullanıcıID() + "'";

            SqlC.com.ExecuteNonQuery();

            SqlC.com.CommandText = "use kasa insert  into EczaneStok (EczaneID) values (" + EczaneID() + ")";
            if (SqlC.con.State == ConnectionState.Closed)
            {
                SqlC.con.Open();
            }

            SqlC.com.ExecuteNonQuery();

            SqlC.con.Close();


            Response.Redirect("satis.aspx?" + "EczaneID=" + Convert.ToString(EczaneID()));


            //}
            //catch (Exception)
            //{

            //    pnl_gyanlis.Visible = true;
            //}
        }

        protected void Button3_Click(object sender, EventArgs e)
        {
            SqlC.con.Open();
            SqlC.com.CommandText = "use kasa update ECZANE2 set Eczane_Adı='" + txt_EczaneAdı.Text + "',Eczacı_ADI='" + txt_EczacıAdı.Text + "',Şehir='" + DropDownListmf.SelectedItem.Value + "',ilçe='" + DropDownList1.SelectedItem.Value + "',semt='" + DropDownList2.SelectedItem.Value + "',mahalle='" + DropDownList3.SelectedItem.Value + "',telefon='" + txt_Telefon1.Text + "',telefon2='" + txt_Telefon2.Text + "',Şehirtxt='" + DropDownListmf.SelectedItem.ToString() + "',ilçetxt='" + DropDownList1.SelectedItem.ToString() + "',semttxt='" + DropDownList2.SelectedItem.ToString() + "',mahalletxt='" + DropDownList3.SelectedItem.ToString() + "' , NOTLAR='" + txt_Notlar.Text + "' where EczaneID='" + EczaneIDGelen + "' and KullanıcıID='" + KullanıcıID() + "'";
            SqlC.com.Connection = SqlC.con;
            SqlC.com.ExecuteNonQuery();
            SqlC.con.Close();
            Response.Redirect("eczanedetay.aspx?EczaneID=" + EczaneIDGelen);
        }
    }
}