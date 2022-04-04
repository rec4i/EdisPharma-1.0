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
    public partial class makaleduzenle : System.Web.UI.Page
    {

        string EczaneID = null;
        public string siparislerıdlabell = null;
        public static int Eczane_StokUrunAdet = 0;
      
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
            EczaneID = Request.QueryString["EczaneID"];
            if (EczaneID != null)
            {
                SqlC.con.Open();
                SqlCommand cmd = new SqlCommand("use kasa select  NOTLAR , telefon2 ,telefon ,Eczane_ADI,Eczacı_ADI,Şehirtxt,ilçetxt,semttxt,mahalletxt,OlusturulmaTar,Sonziyarettar,EczaneID from ECZANE2 where EczaneID='" + EczaneID + "'");
                cmd.Connection = SqlC.con;
                SqlDataAdapter sda = new SqlDataAdapter(cmd);


                DataTable dt = new DataTable();
                sda.Fill(dt);
                RepeaterEczaneBilgi.DataSource = dt;
                RepeaterEczaneBilgi.DataBind();
                SqlC.con.Close();

                SqlC.con.Open();
                SqlCommand cmda1 = new SqlCommand("use kasa SELECT  COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'EczaneStok'  and COLUMN_NAME not like 'EczaneStokID' and COLUMN_NAME not like 'EczaneID' and COLUMN_NAME not like 'StokOnayDurum' and COLUMN_NAME not like 'StokOnayCss' and COLUMN_NAME not like 'StokOnaytxt' and COLUMN_NAME not like 'StokOnayTar'");

                cmda1.Connection = SqlC.con;
                SqlDataAdapter sdaa1 = new SqlDataAdapter(cmda1);

                DataTable dta1 = new DataTable();
                sdaa1.Fill(dta1);
                Repeater2.DataSource = dta1;
                Repeater2.DataBind();

                SqlC.con.Close();

                SqlC.con.Open();
                SqlCommand cmda = new SqlCommand("use kasa select *,Eczane_ADI from Siparisler3 ,ECZANE2 where ECZANE2.EczaneID=Siparisler3.EczaneID and Siparisler3.KullanıcıID='"+KullanıcıID()+"' and   Siparisler3.EczaneID='" + EczaneID + "' order by SiparislerID desc;");

                cmda.Connection = SqlC.con;
                SqlDataAdapter sdaa = new SqlDataAdapter(cmda);

                DataTable dta = new DataTable();
                sdaa.Fill(dta);
                Repeater1.DataSource = dta;
                Repeater1.DataBind();

                SqlC.con.Close();

               




            }
            else
            {
                Response.Redirect("eczaneara.aspx");
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
        public  List <string> pAdetSayısı = new List<string>();
        public  List<string> pEczane_StokUrunadları = new List<string>();
        public void Urunadıveadetdoldur()
        {
            string UrunStokSorgusu = null;
            
            // Eczane StokUrunAdet Çekme
            if (SqlC.con.State==ConnectionState.Open)
            {
                SqlC.con.Close();
            }
            SqlC.con.Open();
            SqlC.com.CommandText = "use kasa SELECT  count(COLUMN_NAME) FROM INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'EczaneStok' and COLUMN_NAME not like 'EczaneStokID' and COLUMN_NAME not like 'EczaneID' and COLUMN_NAME not like 'StokOnayDurum' and COLUMN_NAME not like 'StokOnayCss' and COLUMN_NAME not like 'StokOnaytxt' and COLUMN_NAME not like 'StokOnayTar'";
            SqlC.com.Connection = SqlC.con;
            SqlDataReader da2 = SqlC.com.ExecuteReader();
            while (da2.Read())
            {
                Eczane_StokUrunAdet = (int)da2[0];
            }
            SqlC.con.Close();
            string[] Eczane_StokUrunadları = new string[Eczane_StokUrunAdet];
            //EczaneStokUrunadı ÇEKME
            SqlC.con.Open();
            SqlC.com.CommandText = "use kasa SELECT  COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'EczaneStok'  and COLUMN_NAME not like 'EczaneStokID' and COLUMN_NAME not like 'EczaneID' and COLUMN_NAME not like 'StokOnayDurum' and COLUMN_NAME not like 'StokOnayCss' and COLUMN_NAME not like 'StokOnaytxt' and COLUMN_NAME not like 'StokOnayTar'";
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

                if (i == Eczane_StokUrunAdet - 1)
                {
                    UrunStokSorgusu +="["+ Eczane_StokUrunadları[i]+"]";

                }

                else
                {
                    UrunStokSorgusu += "["+Eczane_StokUrunadları[i] +"]"+ ",";
                }

            }
            string[] Adetsayısı = new string[Eczane_StokUrunAdet];
            
            SqlC.con.Open();
            SqlC.com.CommandText = "use kasa select " + UrunStokSorgusu + " from EczaneStok where EczaneID='" + EczaneID + "'";
            SqlC.com.Connection = SqlC.con;
            SqlDataReader dr = SqlC.com.ExecuteReader();
            dr.Read();
           
            for (int i = 0; i <= (Eczane_StokUrunAdet - 1); i++)
            {
                if (dr[i]== DBNull.Value)
                {
                    Adetsayısı[i] = "0";
                }
                else
                {
                    Adetsayısı[i] = dr[i].ToString();
                }
               

            }
            dr.Close();
            for (int i = 0; i < Adetsayısı.Length; i++)
            {
                pAdetSayısı.Add(Adetsayısı[i]);
            }
            for (int i = 0; i < Eczane_StokUrunadları.Length; i++)
            {
                pEczane_StokUrunadları.Add(Eczane_StokUrunadları[i]);
            }

        }
        public string getUrunadı(string a)
        {
            string b = "";
            if (SqlC.con.State==ConnectionState.Open)
            {
                SqlC.con.Close();
            }
            SqlC.con.Open();
            SqlC.com.CommandText = "use kasa select  UrunADI from Urunler2 where UrunID="+a+"";
            SqlDataReader dr = SqlC.com.ExecuteReader();
            while (dr.Read())
            {
                b += dr[0];
            }
            dr.Close();
            SqlC.con.Close();
            return b;
        }
        public string getstokadet(string urunadı)
        {
            Urunadıveadetdoldur();
            for (int i = 0; i < Eczane_StokUrunAdet; i++)
            {
                if (pEczane_StokUrunadları[i]==urunadı)
                {
                    return pAdetSayısı[i];
                }
                
            }
            return "";
        }
        public string getsiparisıd(string a)
        {
            siparislerıdlabell = a;
            return siparislerıdlabell;
        }
        protected void ItemBound(object sender, RepeaterItemEventArgs args)
        {
            if (args.Item.ItemType == ListItemType.Item || args.Item.ItemType == ListItemType.AlternatingItem)
            {
                Repeater RepeaterSiparisBilgi = (Repeater)args.Item.FindControl("RepeaterSiparisBilgi");
                Label siparislerıdlabel = (Label)args.Item.FindControl("myLabel");
                string a = siparislerıdlabel.Text.ToString();
                if (SqlC.con.State == ConnectionState.Open)
                {
                    SqlC.con.Close();
                }
                SqlC.con.Open();
                SqlCommand cmd3 = new SqlCommand("use Kasa select SiparisID,UrunAdı,Adet,MalFazlasıAdet,Toplam,BirimFiyat,SatışFiyat,Siparisler3.SiparisOlusturulmaTar from Siparis,Siparisler3 where Siparis. EczaneID='" + EczaneID + "' and Siparis. SiparislerID='" + siparislerıdlabell + "' and Siparis. SiparislerID=Siparisler3.SiparislerID");
                cmd3.Connection = SqlC.con;
                SqlDataAdapter sda3 = new SqlDataAdapter(cmd3); ;
                DataTable dt3 = new DataTable();
                sda3.Fill(dt3);
                RepeaterSiparisBilgi.DataSource = dt3;
                RepeaterSiparisBilgi.DataBind();
                SqlC.con.Close();
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            Response.Redirect("satis.aspx?EczaneID="+EczaneID);
        }
        public string getonaydurum(int  onayDurum)
        {
            if (onayDurum==0)
            {
                return "Beklemede";
            }
            else if (onayDurum==1)
            {
                return "Onaylandı";
            }
            else if (onayDurum == 2)
            {
                return "Red";
            }
            else
            {
                return "bir hata oluştu";
            }
        }
        public string getonaydurum(string onayDurum)
        {
            if (onayDurum == "0")
            {
                return SqlC.StokOnayCssBeklemede;
            }
            else if (onayDurum == "1")
            {
                return SqlC.StokOnayCssOnaylandı;
            }
            else if (onayDurum == "2")
            {
                return SqlC.StokOnayCssReddedildi;
            }
            else
            {
                return "bir hata oluştu";
            }
        }

        protected void Button4_Click(object sender, EventArgs e)
        {
            // buna birde modal ekle onaylamak için
            SqlC.con.Open();
            SqlC.com.CommandText = "use kasa update ECZANE2 set  silinmismi='1' where EczaneID='"+EczaneID+"'";
            SqlC.com.Connection = SqlC.con;
            SqlC.com.ExecuteNonQuery();
            SqlC.con.Close();
            Response.Redirect("eczaneara.aspx");
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            // yeni eczane sayfasına at ordaki boşlukları db den çekip doldur eğer düzenleme olarak gelirse satış ekle ve satış butonunu sil onun yerine kaydet butonu koy
            Response.Redirect("yenieczane.aspx?islem=duzenle&EczaneID="+EczaneID);
        }

        protected void Button3_Click(object sender, EventArgs e)
        {
            // stok güncelleme  daha halen düşünüyorum
            Response.Redirect("stokguncelle.aspx?EczaneID="+EczaneID);
        }
    }
}