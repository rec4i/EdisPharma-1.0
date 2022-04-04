using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace deneme9
{
    public partial class siparisred : System.Web.UI.Page
    {
        public string siparislerIDsi = null;
        public string siparislerıdlabell = null;
        string EczaneID = null;
        protected void Page_Load(object sender, EventArgs e)
        {

            EczaneBilgiDiv.Visible = false;
            EczaneID = Request.QueryString["EczaneID"];
            siparislerIDsi = Request.QueryString["siparisID"];
            if (EczaneID != null)
            {
                if (SqlC.con.State == ConnectionState.Open)
                {
                    SqlC.con.Close();
                }
                string siparislerIDsayısı = null;
                string[] siparislerIDler = new string[Convert.ToInt32(siparislerIDsayısı)];
                //SqlC.con.Open();
                //SqlCommand cmda = new SqlCommand("use kasa select *,Eczane_ADI from Siparisler3 ,ECZANE2 where ECZANE2.EczaneID=Siparisler3.EczaneID and  Siparisler3.EczaneID='"+EczaneID+"';");

                //cmda.Connection = SqlC.con;
                //SqlDataAdapter sdaa = new SqlDataAdapter(cmda);

                //DataTable dta = new DataTable();
                //sdaa.Fill(dta);
                //Repeater1.DataSource = dta;
                //Repeater1.DataBind();


                SqlC.con.Close();

                if (SqlC.con.State == ConnectionState.Open)
                {
                    SqlC.con.Close();
                }
                SqlC.con.Open();
                SqlCommand cmd3a = new SqlCommand("use Kasa select SiparisID,UrunAdı,Adet,MalFazlasıAdet,Toplam,BirimFiyat,SatışFiyat,SiparisOlusturulmaTar from Siparis where EczaneID='" + EczaneID + "' and SiparislerID='" + siparislerIDsi + "'");
                cmd3a.Connection = SqlC.con;
                SqlDataAdapter sda3a = new SqlDataAdapter(cmd3a); ;
                DataTable dt3a = new DataTable();
                sda3a.Fill(dt3a);
                RepeaterSiparisBilgi.DataSource = dt3a;
                RepeaterSiparisBilgi.DataBind();
                SqlC.con.Close();




                if (SqlC.con.State == ConnectionState.Open)
                {
                    SqlC.con.Close();
                }

                SqlC.con.Open();
                SqlCommand cmd = new SqlCommand("use kasa select Eczane_ADI,Eczacı_ADI,Şehirtxt,ilçetxt,semttxt,mahalletxt,OlusturulmaTar,Sonziyarettar,EczaneID from ECZANE2 where EczaneID='" + EczaneID + "'");
                cmd.Connection = SqlC.con;
                SqlDataAdapter sda = new SqlDataAdapter(cmd);


                DataTable dt = new DataTable();
                sda.Fill(dt);
                RepeaterEczaneBilgi.DataSource = dt;
                RepeaterEczaneBilgi.DataBind();
                SqlC.con.Close();

                if (SqlC.con.State == ConnectionState.Open)
                {
                    SqlC.con.Close();
                }
                SqlC.con.Open();
                SqlCommand cmd3 = new SqlCommand("use Kasa select SiparisID,UrunAdı,Adet,MalFazlasıAdet,Toplam,BirimFiyat,SatışFiyat,Siparisler3.SiparisOlusturulmaTar from Siparis,Siparisler3 where Siparis. EczaneID='" + EczaneID + "' and Siparis. SiparislerID='" + siparislerIDsi + "' and Siparis. SiparislerID=Siparisler3.SiparislerID");
                cmd3.Connection = SqlC.con;
                SqlDataAdapter sda3 = new SqlDataAdapter(cmd3);


                DataTable dt3 = new DataTable();
                sda3.Fill(dt3);
                RepeaterSiparisBilgi.DataSource = dt3;
                RepeaterSiparisBilgi.DataBind();
               

               
                SqlC.con.Close();



                EczaneBilgiDiv.Attributes["box box-default collapse-box box-solid"] = "box box-default collapse box-solid";
                EczaneBilgiDiv.Visible = true;


            }


            //onaysız Stok-Sipariş ÇEKME
            if (SqlC.con.State == ConnectionState.Open)
            {
                SqlC.con.Close();
            }
            SqlC.con.Open();
            SqlCommand cmd1 = new SqlCommand(" use kasa select *,Eczane_ADI from Siparisler3 ,ECZANE2 where Siparisler3.OnayDurum=2 and ECZANE2.EczaneID=Siparisler3.EczaneID;");
            cmd1.Connection = SqlC.con;
            SqlDataAdapter sda2 = new SqlDataAdapter(cmd1);


            DataTable dt1 = new DataTable();
            sda2.Fill(dt1);
            RepeaterSiparisOnayDurum.DataSource = dt1;
            RepeaterSiparisOnayDurum.DataBind();
            SqlC.con.Close();

        }
        public string getsiparisıd(string a)
        {
            siparislerıdlabell = a;
            return siparislerıdlabell;
        }

        public string Onaydurum(string a)
        {
            if (a == "0")
            {
                return SqlC.StokOnayCssBeklemede;
            }
            else
            {
                return SqlC.GecenGun30css;
            }
        }
        public string Onaydurum(int a)
        {
            if (a == 0)
            {
                return "Beklemede";
            }
            else
            {
                return "Red";
            }
        }


        //protected void ItemBound(object sender, RepeaterItemEventArgs args)
        //{
        //    if (args.Item.ItemType == ListItemType.Item || args.Item.ItemType == ListItemType.AlternatingItem)
        //    {
        //        Repeater RepeaterSiparisBilgi = (Repeater)args.Item.FindControl("RepeaterSiparisBilgi");
        //        Label siparislerıdlabel = (Label)args.Item.FindControl("myLabel");
        //        string a = siparislerıdlabel.Text.ToString();
        //        if (SqlC.con.State == ConnectionState.Open)
        //        {
        //            SqlC.con.Close();
        //        }
        //        SqlC.con.Open();
        //        SqlCommand cmd3 = new SqlCommand("use Kasa select SiparisID,UrunAdı,Adet,MalFazlasıAdet,Toplam,BirimFiyat,SatışFiyat,Siparisler3.SiparisOlusturulmaTar from Siparis,Siparisler3 where Siparis. EczaneID='" + EczaneID + "' and Siparis. SiparislerID='" + siparislerIDsi + "' and Siparis. SiparislerID=Siparisler3.SiparislerID");
        //        cmd3.Connection = SqlC.con;
        //        SqlDataAdapter sda3 = new SqlDataAdapter(cmd3); ;
        //        DataTable dt3 = new DataTable();
        //        sda3.Fill(dt3);
        //        RepeaterSiparisBilgi.DataSource = dt3;
        //        RepeaterSiparisBilgi.DataBind();
        //        SqlC.con.Close();
        //    }
        //}


        protected void Button1_Click(object sender, EventArgs e)
        {

            //if (txt_hbaslik.Text == string.Empty && txt_hozet.Text == string.Empty && txt_hicerik.Text == string.Empty)
            //{
            //    pnl_gyanlis.Visible = true;
            //}
            //else
            //{
            //    fu_hresim.SaveAs(Server.MapPath("/hizmetr/" + fu_hresim.FileName));
            //    SqlCommand cmdhe = new SqlCommand("insert into Hizmetler(hizmetlerAd,hizmetlerOzet,hizmetlerIcerik,hizmetlerResim) Values('" + txt_hbaslik.Text + "','" + txt_hozet.Text + "','" + txt_hicerik.Text + "','/hizmetr/" + fu_hresim.FileName + "')", baglan.baglan());
            //    cmdhe.ExecuteNonQuery();
            //}
        }


        protected void ButtonSiparisonayla_Click(object sender, EventArgs e)
        {
            if (SqlC.con.State == ConnectionState.Open)
            {
                SqlC.con.Close();
            }
            SqlC.con.Open();
            SqlC.com.CommandText = "use kasa update Siparisler3 set OnayDurum=1 where SiparislerID='" + siparislerIDsi + "';";
            SqlC.com.Connection = SqlC.con;
            SqlC.com.ExecuteNonQuery();
            SqlC.con.Close();
            EczaneStoguna_Ekle();
            Response.Redirect("siparişonay.aspx");
        }
        public void EczaneStoguna_Ekle()
        {
            int StokUrunadet = 1;
            int Eczane_StokUrunAdet = 1;



            if (SqlC.con.State == ConnectionState.Open)
            {
                SqlC.con.Close();
            }

            // STOK URUN ADET ÇEKME
            SqlC.con.Open();
            SqlC.com.CommandText = " use kasa select count(UrunADI) as UrunAdıSayısı  from siparis where EczaneID='" + EczaneID + "' and SiparislerID='" + siparislerIDsi + "'";
            SqlDataReader da = SqlC.com.ExecuteReader();
            while (da.Read())
            {
                StokUrunadet = (int)da[0];
            }
            SqlC.con.Close();
            string[] StokUrunadları = new string[StokUrunadet];
            //STOK URUN ADETİ ÇEKME
            string[] StokUrunAdetSayısı = new string[StokUrunadet];
            if (SqlC.con.State == ConnectionState.Open)
            {
                SqlC.con.Close();
            }
            SqlC.con.Open();
            SqlC.com.CommandText = " use kasa select Toplam as UrunAdıSayısı  from siparis where EczaneID='" + EczaneID + "' and SiparislerID='" + siparislerIDsi + "'";
            SqlDataReader da4 = SqlC.com.ExecuteReader();
            for (int i = 0; i < StokUrunadet; i++)
            {
                if (da4.Read())
                {
                    StokUrunAdetSayısı[i] = (string)da4[0];
                }
                else
                {
                    break;
                }
            }
            SqlC.con.Close();

            //StokUrunadı ÇEKME

            if (SqlC.con.State == ConnectionState.Open)
            {
                SqlC.con.Close();
            }
            SqlC.con.Open();
            SqlC.com.CommandText = " use kasa select UrunADI as UrunAdıSayısı  from siparis where EczaneID='" + EczaneID + "' and SiparislerID='" + siparislerIDsi + "'";
            SqlDataReader da1 = SqlC.com.ExecuteReader();
            for (int i = 0; i < StokUrunadet; i++)
            {
                if (da1.Read())
                {
                    StokUrunadları[i] = (string)da1[0];
                }
                else
                {
                    break;
                }
            }
            SqlC.con.Close();





            // Eczane StokUrunAdet Çekme
            if (SqlC.con.State == ConnectionState.Open)
            {
                SqlC.con.Close();
            }
            SqlC.con.Open();
            SqlC.com.CommandText = "use kasa SELECT  count(COLUMN_NAME) FROM INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'EczaneStok'  and COLUMN_NAME not like 'EczaneStokID' and COLUMN_NAME not like 'EczaneID'";
            SqlDataReader da2 = SqlC.com.ExecuteReader();
            while (da2.Read())
            {
                Eczane_StokUrunAdet = (int)da2[0];
            }
            SqlC.con.Close();
            string[] Eczane_StokUrunadları = new string[Eczane_StokUrunAdet];
            //EczaneStokUrunadı ÇEKME
            if (SqlC.con.State == ConnectionState.Open)
            {
                SqlC.con.Close();
            }
            SqlC.con.Open();
            SqlC.com.CommandText = "use kasa SELECT  COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'EczaneStok'  and COLUMN_NAME not like 'EczaneStokID' and COLUMN_NAME not like 'EczaneID'";
            SqlDataReader da3 = SqlC.com.ExecuteReader();
            for (int i = 0; i < Eczane_StokUrunAdet; i++)
            {
                if (da3.Read())
                {
                    Eczane_StokUrunadları[i] = (string)da3[0];
                }
                else
                {
                    break;
                }
            }
            SqlC.con.Close();

            for (int i = 0; i < Eczane_StokUrunAdet; i++)
            {
                for (int j = 0; j < (StokUrunadet); j++)
                {
                    if (Eczane_StokUrunadları[i] == StokUrunadları[j])
                    {
                        if (SqlC.con.State == ConnectionState.Open)
                        {
                            SqlC.con.Close();
                        }
                        SqlC.con.Open();
                        SqlC.com.CommandText = "use kasa UPDATE EczaneStok SET " + Eczane_StokUrunadları[i] + "=" + Eczane_StokUrunadları[i] + "+" + StokUrunAdetSayısı[j] + "  WHERE EczaneID='" + EczaneID + "'";


                        SqlC.com.Connection = SqlC.con;
                        SqlC.com.ExecuteNonQuery();
                        SqlC.con.Close();


                    }

                }
            }







        }

        protected void ButtonSiparisReddet_Click(object sender, EventArgs e)
        {
            if (SqlC.con.State == ConnectionState.Open)
            {
                SqlC.con.Close();
            }
            SqlC.con.Open();
            SqlC.com.CommandText = "use kasa update Siparisler3 set OnayDurum=2 where SiparislerID='" + siparislerIDsi + "';";
            SqlC.com.Connection = SqlC.con;
            SqlC.com.ExecuteNonQuery();
            SqlC.con.Close();
            EczaneStoguna_Ekle();
            Response.Redirect("siparişonay.aspx");
        }
    }
}
