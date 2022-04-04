using deneme9;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.Services;

namespace kurumsal.kurumsaluser
{
    public partial class anasayfa : System.Web.UI.Page
    {

        //eklenen ürünü kullanıcıya göre listele
        public static string asd = "";
        public static string KullanıcıADI = "";
        string EczaneID = null;
        public string islem = null;
        string siparisıd = null;
        public List<int> items = new List<int>();
        public List<int> itemsmf = new List<int>();





        protected void Page_Load(object sender, EventArgs e)
        {



            for (int i = 1; i <= 1000; i++)
            {
                items.Add(i);
            }
            for (int i = 1; i <= 500; i++)
            {
                itemsmf.Add(i);
            }

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



            siparisıd = Request.QueryString["SiparişID"];
            islem = Request.QueryString["islem"];
            EczaneID = Request.QueryString["EczaneID"];



            //if (islem == "Ekle")
            //{

            //    usesavedata();
            //    SqlC.con.Open();
            //    SqlCommand cmd12 = new SqlCommand("use kasa select SiparisID,EczaneID, UrunADI, Adet, MalfazlasıAdet,Toplam,BirimFiyat,SatışFiyat from SiparişTemP3 where KullanıcıID = '" + KullanıcıID() + "'");
            //    cmd12.Connection = SqlC.con;
            //    SqlDataAdapter sda21 = new SqlDataAdapter(cmd12);
            //    DataTable dt112 = new DataTable();
            //    sda21.Fill(dt112);
            //    Repeater2.DataSource = dt112;
            //    Repeater2.DataBind();
            //    SqlC.con.Close();
            //}



            //if (EczaneID==null)
            //{
            //     
            //}
            if (islem == "sil")
            {
                SqlC.con.Open();
                SqlC.com.CommandText = "use kasa  delete from SiparişTemP3 where SiparisID = " + siparisıd;
                SqlC.com.Connection = SqlC.con;
                SqlC.com.ExecuteNonQuery();
                SqlC.con.Close();

            }

            //ürün doldurma
            if (SqlC.con.State == ConnectionState.Open)
            {
                SqlC.con.Close();
            }
            SqlC.con.Open();
            SqlCommand cmd11 = new SqlCommand("use kasa select UrunID ,UrunADI,UrunResim_Path,UrunFiyat,UrunKar_Yuzde,UrunID from Urunler2 where Silinmismi='0' ", SqlC.con);
            SqlDataAdapter sda22 = new SqlDataAdapter(cmd11);
            DataTable dt11 = new DataTable();
            sda22.Fill(dt11);
            Repeater1.DataSource = dt11;
            Repeater1.DataBind();
            SqlC.con.Close();

            //kullanıcı nın seçtiği eczane yi çekme
            if (!this.IsPostBack)
            {
                SqlC.con.Open();
                SqlC.com.CommandText = "use kasa select Eczane_ADI,Sonziyarettar from ECZANE2 where EczaneID='" + EczaneID + "'";
                SqlC.com.Connection = SqlC.con;

                SqlDataReader sda1 = SqlC.com.ExecuteReader();
                while (sda1.Read())
                {
                    Label3.Text += sda1["Eczane_ADI"];
                    Label4.Text += sda1["Sonziyarettar"];

                }

                SqlC.con.Close();
            }
            SqlC.con.Open();
            SqlCommand cmd1 = new SqlCommand("use kasa select SiparisID,EczaneID, UrunADI, Adet, MalfazlasıAdet,Toplam,BirimFiyat,SatışFiyat from SiparişTemP3 where KullanıcıID = '" + KullanıcıID() + "'");
            cmd1.Connection = SqlC.con;
            SqlDataAdapter sda2 = new SqlDataAdapter(cmd1);
            DataTable dt1 = new DataTable();
            sda2.Fill(dt1);
            Repeater2.DataSource = dt1;
            Repeater2.DataBind();
            SqlC.con.Close();



            SqlC.con.Open();
            SqlCommand cmd = new SqlCommand("use kasa select Eczane_ADI,Eczacı_ADI,Şehirtxt,ilçetxt,semttxt,mahalletxt,OlusturulmaTar,Sonziyarettar,EczaneID from ECZANE2 where EczaneID='" + EczaneID + "'");
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
            Repeater3.DataSource = dta1;
            Repeater3.DataBind();

            SqlC.con.Close();

            //sipartiş tempi silme

            //SqlC.con.Open();
            //SqlCommand cmd1 = new SqlCommand("use kasa select UrunADI, Adet, MalfazlasıAdet,Toplam,BirimFiyat,SatışFiyat from SiparişTemP3 where KullanıcıID = '1'");
            //cmd1.Connection = SqlC.con;
            //SqlDataAdapter sda2 = new SqlDataAdapter(cmd1);
            //DataTable dt1 = new DataTable();
            //sda2.Fill(dt1);
            //Repeater2.DataSource = dt1;
            //Repeater2.DataBind();
            //SqlC.con.Close();




            SqlC.con.Close();
        }

        public string getUrunadı(string a)
        {
            string b = "";
            if (SqlC.con.State == ConnectionState.Open)
            {
                SqlC.con.Close();
            }
            SqlC.con.Open();
            SqlC.com.CommandText = "use kasa select  UrunADI from Urunler2 where UrunID=" + a + "";
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
                if (pEczane_StokUrunadları[i] == urunadı)
                {
                    return pAdetSayısı[i];
                }

            }
            return "";
        }
        public string siparislerıdlabell = null;
        public static int Eczane_StokUrunAdet = 0;
        public List<string> pAdetSayısı = new List<string>();
        public List<string> pEczane_StokUrunadları = new List<string>();
        public void Urunadıveadetdoldur()
        {
            string UrunStokSorgusu = null;

            // Eczane StokUrunAdet Çekme
            if (SqlC.con.State == ConnectionState.Open)
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
                    UrunStokSorgusu += "[" + Eczane_StokUrunadları[i] + "]";

                }

                else
                {
                    UrunStokSorgusu += "[" + Eczane_StokUrunadları[i] + "]" + ",";
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

                if (DBNull.Value.Equals(dr[i]))
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


        //kullanıcı ıd çekme
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




        //ekle butonu
       

        protected void SaveData()
        {



            foreach (RepeaterItem ri in Repeater1.Items)
            {

                if (ri.ItemType == ListItemType.Item || ri.ItemType == ListItemType.AlternatingItem)
                {
                    Panel pnl = ri.FindControl("pnl_gdogru") as Panel;

                    DropDownList ddladet = ri.FindControl("DropDownListadet") as DropDownList;
                    DropDownList ddlmf = ri.FindControl("DropDownListmf") as DropDownList;
                    Label lblfiyat = ri.FindControl("Labelfiyat") as Label;
                    DropDownList yourDropDown = (DropDownList)ri.FindControl("DropDownListadet");
                    Label ıd = ri.FindControl("LabelID") as Label;



                    Label Labelkar = ri.FindControl("Labelkar") as Label;
                    Label Labeladı = ri.FindControl("Labeladı") as Label;
                    Label LabelID = ri.FindControl("LabelID") as Label;
                    string a = ıd.Text;
                    string b = ddladet.SelectedItem.Text;
                    string c = ddlmf.SelectedItem.Text;
                    string d = ddladet.SelectedIndex.ToString();
                    string e = ddladet.SelectedValue.ToString();
                    string f = yourDropDown.SelectedIndex.ToString();

                    double birimfiyat = ((Convert.ToDouble(lblfiyat.Text)) / ((Convert.ToDouble(Labelkar.Text) / 100) + 1)) * (Convert.ToDouble(ddladet.SelectedValue)) / (Convert.ToDouble(ddlmf.SelectedValue) + Convert.ToDouble(ddladet.SelectedValue));
                    birimfiyat = Math.Round(birimfiyat, 3);




                    SqlC.con.Open();
                    SqlC.com.CommandText = "use kasa insert into SiparişTemP3( tip, UrunAdıID, UrunADI, Adet, MalfazlasıAdet, Toplam, BirimFiyat, SatışFiyat, KullanıcıID,EczaneID) values( '0',  " + LabelID.Text + "   , '" + Labeladı.Text + "', '" + ddladet.SelectedValue.ToString() + "', '" + ddlmf.SelectedValue.ToString() + "', '" + (Convert.ToInt32(ddladet.SelectedValue) + Convert.ToInt32(ddlmf.SelectedValue) + "', " + birimfiyat.ToString().Replace(",", ".") + ", " + lblfiyat.Text.Replace(",", ".") + ", '" + KullanıcıID() + "','" + EczaneID + "')");
                    SqlC.com.Connection = SqlC.con;
                    SqlC.com.ExecuteNonQuery();
                    SqlC.con.Close();



                }



            }
        }

        protected void Button2_Click1(object sender, EventArgs e)
        {
            foreach (RepeaterItem itemEquipment in Repeater1.Items)
            {
                //to get the dropdown of each line
                DropDownList yourDropDown = (DropDownList)itemEquipment.FindControl("DropDownListadet");

                //to get the selected value of your dropdownlist
                string value = yourDropDown.SelectedValue;
            }

            foreach (RepeaterItem itemEquipment in Repeater1.Items)
            {
                //to get the dropdown of each line
                DropDownList yourDropDown = (DropDownList)itemEquipment.FindControl("DropDownListadet");

                //to get the selected value of your dropdownlist
                string value = yourDropDown.SelectedValue;
            }


            foreach (RepeaterItem ri in Repeater1.Items)
            {
                RepeaterItem item = (sender as Button).NamingContainer as RepeaterItem;
                if (ri.ItemType == ListItemType.Item || ri.ItemType == ListItemType.AlternatingItem)
                {
                    Panel pnl = ri.FindControl("pnl_gdogru") as Panel;

                    DropDownList ddladet = ri.FindControl("DropDownListadet") as DropDownList;
                    DropDownList ddlmf = ri.FindControl("DropDownListmf") as DropDownList;
                    Label lblfiyat = ri.FindControl("Labelfiyat") as Label;
                    DropDownList yourDropDown = (DropDownList)ri.FindControl("DropDownListadet");
                    Label ıd = ri.FindControl("LabelID") as Label;



                    Label Labelkar = ri.FindControl("Labelkar") as Label;
                    Label Labeladı = ri.FindControl("Labeladı") as Label;
                    Label LabelID = ri.FindControl("LabelID") as Label;
                    string a = ıd.Text;
                    string b = ddladet.SelectedItem.Text;
                    string c = ddlmf.SelectedItem.Text;
                    string d = ddladet.SelectedIndex.ToString();

                    string f = yourDropDown.SelectedIndex.ToString();

                    double birimfiyat = ((Convert.ToDouble(lblfiyat.Text)) / ((Convert.ToDouble(Labelkar.Text) / 100) + 1)) * (Convert.ToDouble(ddladet.SelectedValue)) / (Convert.ToDouble(ddlmf.SelectedValue) + Convert.ToDouble(ddladet.SelectedValue));
                    birimfiyat = Math.Round(birimfiyat, 3);




                    SqlC.con.Open();
                    SqlC.com.CommandText = "use kasa insert into SiparişTemP3( tip, UrunAdıID, UrunADI, Adet, MalfazlasıAdet, Toplam, BirimFiyat, SatışFiyat, KullanıcıID,EczaneID) values( '0',  " + LabelID.Text + "   , '" + Labeladı.Text + "', '" + ddladet.SelectedValue.ToString() + "', '" + ddlmf.SelectedValue.ToString() + "', '" + (Convert.ToInt32(ddladet.SelectedValue) + Convert.ToInt32(ddlmf.SelectedValue) + "', " + birimfiyat.ToString().Replace(",", ".") + ", " + lblfiyat.Text.Replace(",", ".") + ", '" + KullanıcıID() + "','" + EczaneID + "')");
                    SqlC.com.Connection = SqlC.con;
                    SqlC.com.ExecuteNonQuery();
                    SqlC.con.Close();



                }



            }

            SqlC.con.Open();
            SqlCommand cmd12 = new SqlCommand("use kasa select SiparisID,EczaneID, UrunADI, Adet, MalfazlasıAdet,Toplam,BirimFiyat,SatışFiyat from SiparişTemP3 where KullanıcıID = '" + KullanıcıID() + "'");
            cmd12.Connection = SqlC.con;
            SqlDataAdapter sda21 = new SqlDataAdapter(cmd12);
            DataTable dt112 = new DataTable();
            sda21.Fill(dt112);
            Repeater2.DataSource = dt112;
            Repeater2.DataBind();
            SqlC.con.Close();


        }

        //sipariş ver butonu

        protected void Button2_Click(object sender, EventArgs e)
        {
            ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('');", true);
        }

        //ddl doldurma
        protected void Repeater1_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {


            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                DropDownList ddlItem = (DropDownList)e.Item.FindControl("DropDownListmf");

                //if (SqlC.con.State == ConnectionState.Closed)
                //{
                //    SqlC.con.Open();
                //}
                //SqlCommand cmd1 = new SqlCommand("use kasa select MalFazlasıTXT,MalFazlasıINT from MalFazlası1 ", SqlC.con);
                //SqlDataAdapter sda2 = new SqlDataAdapter(cmd1);
                //DataTable dt1 = new DataTable();
                //sda2.Fill(dt1);

                //SqlC.con.Close();
                //ddlItem.DataSource = dt1;
                //ddlItem.DataTextField = "MalFazlasıTXT";
                //ddlItem.DataValueField = "MalFazlasıINT";
                itemsmf.Sort();
                ddlItem.DataSource = itemsmf;
                ddlItem.DataBind();
                //SqlC.con.Close();
            }
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {

                DropDownList ddlItem = (DropDownList)e.Item.FindControl("DropDownListadet");

                //if (SqlC.con.State == ConnectionState.Closed)
                //{
                //    SqlC.con.Open();
                //}
                //SqlCommand cmd1 = new SqlCommand("use kasa select sayılar,sayılartxt from sayılar ", SqlC.con);
                //SqlDataAdapter sda2 = new SqlDataAdapter(cmd1);
                //DataTable dt1 = new DataTable();
                //sda2.Fill(dt1);

                //SqlC.con.Close();
                //ddlItem.DataSource = dt1;
                //ddlItem.DataTextField = "sayılartxt";
                //ddlItem.DataValueField = "sayılar";
                //ddlItem.DataBind();
                //SqlC.con.Close();
                items.Sort();
                ddlItem.DataSource = items;
                ddlItem.DataBind();
            }




        }

        protected void btn_siparisver_Click(object sender, EventArgs e)
        {

            try
            {


                string siparisID1 = null;
                string siparislerID = null;

                string a = null;


                SqlC.con.Open();
                SqlC.com.CommandText = "use kasa  select KullanıcıID from SiparişTemP3 where KullanıcıID='" + KullanıcıID() + "'";
                SqlC.com.Connection = SqlC.con;
                SqlDataReader dr = SqlC.com.ExecuteReader();
                while (dr.Read())
                {

                    a = Convert.ToString(dr[0]);

                }
                SqlC.con.Close();


                if (a != null)
                {
                    //2
                    SqlC.con.Open();
                    SqlC.com.CommandText = " use kasa insert into Siparisler3 (tip, SiparisOlusturulmaTar,EczaneID,KullanıcıID) OUTPUT Inserted.SiparislerID as SiparislerID values ('0', getdate(),'" + EczaneID + "','" + KullanıcıID() + "');";
                    SqlDataReader da = SqlC.com.ExecuteReader();
                    while (da.Read())
                    {
                        siparislerID = Convert.ToString(da[0]);
                    }

                    SqlC.con.Close();

                    //1
                    SqlC.con.Open();
                    SqlC.com.CommandText = " use kasa INSERT INTO Siparis ( tip, UrunAdıID, UrunAdı, Adet, MalFazlasıAdet,Toplam,BirimFiyat,SatışFiyat,KullanıcıID,EczaneID) output Inserted.SiparisID SELECT tip, UrunAdıID, UrunAdı, Adet, MalFazlasıAdet,Toplam,BirimFiyat,SatışFiyat,KullanıcıID,EczaneID FROM SiparişTemP3 WHERE KullanıcıID='" + KullanıcıID() + "' ";
                    SqlDataReader da1 = SqlC.com.ExecuteReader();
                    while (da1.Read())
                    {
                        siparisID1 += "-" + Convert.ToString(da1[0]);
                    }

                    SqlC.con.Close();



                    //3
                    SqlC.con.Open();
                    SqlC.com.CommandText = "USE KASA UPDATE Siparisler3 set OnayDurum=0 ,SiparisIDleri='" + siparisID1 + "' Where SiparislerID=" + siparislerID;
                    SqlC.com.ExecuteNonQuery();
                    SqlC.con.Close();

                    SqlC.con.Open();

                    string[] x = siparisID1.Split('-');
                    string b = null;
                    for (int i = 1; i < x.Length; i++)
                    {
                        if (i == x.Length - 1)
                        {
                            x[i] = " SiparisID=" + x[i];
                        }
                        else
                        {
                            x[i] = " SiparisID=" + x[i] + " or";
                        }

                    }
                    for (int i = 1; i < x.Length; i++)
                    {
                        b += x[i];
                    }



                    SqlC.con.Close();


                    //4


                    SqlC.con.Open();
                    SqlC.com.CommandText = "USE KASA UPDATE Siparis set  SiparislerID=" + siparislerID + " Where " + b;
                    SqlC.com.ExecuteNonQuery();
                    SqlC.con.Close();

                    SqlC.con.Open();
                    SqlC.con.Close();

                    SqlC.con.Open();
                    SqlC.com.CommandText = "USE KASA UPDATE Eczane2 set  Sonziyarettar=GetDate() Where EczaneID='" + EczaneID + "'";
                    SqlC.com.ExecuteNonQuery();
                    SqlC.con.Close();

                    SqlC.con.Open();
                    SqlC.con.Close();
                    Response.Redirect("eczaneara.aspx");


                }


            }
            catch (Exception)
            {

                Response.Write("<script>alert('Bir Hata oluştu Lütfen Tekrar Deneyin');</script>");
                Response.Redirect("eczaneara.aspx");
            }



            //eczane sotoğuna siparişten  onaylandıktan sonra eklenecek

        }
        protected void ButtonComand(object sender, CommandEventArgs e)
        {




            RepeaterItem item = (sender as Button).NamingContainer as RepeaterItem;

            Panel pnl = item.FindControl("pnl_gdogru") as Panel;

            DropDownList ddladet = item.FindControl("DropDownListadet") as DropDownList;
            DropDownList ddlmf = item.FindControl("DropDownListmf") as DropDownList;
            Label lblfiyat = item.FindControl("Labelfiyat") as Label;

            Label Labelkar = item.FindControl("Labelkar") as Label;
            Label Labeladı = item.FindControl("Labeladı") as Label;
            Label LabelID = item.FindControl("LabelID") as Label;

            string a = ddladet.SelectedValue.ToString();

            double birimfiyat = ((Convert.ToDouble(lblfiyat.Text)) / ((Convert.ToDouble(Labelkar.Text) / 100) + 1)) * (Convert.ToDouble(ddladet.SelectedValue)) / (Convert.ToDouble(ddlmf.SelectedValue) + Convert.ToDouble(ddladet.SelectedValue));
            birimfiyat = Math.Round(birimfiyat, 3);



            if (ddladet.SelectedItem.Text == "-- ADET SEÇ --")
            {
                Response.Write("<script>alert('Lütfen Adet Seç');</script>");
            }
            else
            {

                SqlC.con.Open();
                SqlC.com.CommandText = "use kasa insert into SiparişTemP3( tip, UrunAdıID, UrunADI, Adet, MalfazlasıAdet, Toplam, BirimFiyat, SatışFiyat, KullanıcıID,EczaneID) values( '0',  " + LabelID.Text + "   , '" + Labeladı.Text + "', '" + ddladet.SelectedValue.ToString() + "', '" + ddlmf.SelectedValue.ToString() + "', '" + (Convert.ToInt32(ddladet.SelectedValue) + Convert.ToInt32(ddlmf.SelectedValue) + "', " + birimfiyat.ToString().Replace(",", ".") + ", " + lblfiyat.Text.Replace(",", ".") + ", '" + KullanıcıID() + "','" + EczaneID + "')");
                SqlC.com.Connection = SqlC.con;
                SqlC.com.ExecuteNonQuery();
                SqlC.con.Close();

                SqlC.con.Open();
                SqlCommand cmd1 = new SqlCommand("use kasa select SiparisID,EczaneID, UrunADI, Adet, MalfazlasıAdet,Toplam,BirimFiyat,SatışFiyat from SiparişTemP3 where KullanıcıID = '" + KullanıcıID() + "'");
                cmd1.Connection = SqlC.con;
                SqlDataAdapter sda2 = new SqlDataAdapter(cmd1);
                DataTable dt1 = new DataTable();
                sda2.Fill(dt1);
                Repeater2.DataSource = dt1;
                Repeater2.DataBind();
                SqlC.con.Close();

            }
            pnl.Visible = true;

        }

        [System.Web.Services.WebMethod]
        public static string OrnekPost(string parametre)
        {
            return parametre + " değeriyle post işlemi gerçekleştirildi.";
        }


    }


    //public void EczaneStoguna_Ekle()
    //{
    //    int StokUrunadet = 1;
    //    int Eczane_StokUrunAdet = 1;





    //    // STOK URUN ADET ÇEKME
    //    SqlC.con.Open();
    //    SqlC.com.CommandText = " use kasa select COUNT(UrunADI) as UrunAdıSayısı  from siparis where EczaneID='"+EczaneID+"'";
    //    SqlDataReader da = SqlC.com.ExecuteReader();
    //    while (da.Read())
    //    {
    //        StokUrunadet = (int)da[0];
    //    }
    //    SqlC.con.Close();
    //    string[] StokUrunadları = new string[StokUrunadet];
    //    //STOK URUN ADETİ ÇEKME
    //    string[] StokUrunAdetSayısı = new string[StokUrunadet];
    //    SqlC.con.Open();
    //    SqlC.com.CommandText = " use kasa select Toplam as UrunAdıSayısı  from siparis where EczaneID='" + EczaneID + "'";
    //    SqlDataReader da4 = SqlC.com.ExecuteReader();
    //    for (int i = 0; i < StokUrunadet; i++)
    //    {
    //        if (da4.Read())
    //        {
    //            StokUrunAdetSayısı[i] = (string)da4[0];
    //        }
    //        else
    //        {
    //            break;
    //        }
    //    }
    //    SqlC.con.Close();

    //    //StokUrunadı ÇEKME
    //    SqlC.con.Open();
    //    SqlC.com.CommandText = " use kasa select UrunADI as UrunAdıSayısı  from siparis where EczaneID='" + EczaneID + "'";
    //    SqlDataReader da1 = SqlC.com.ExecuteReader();
    //    for (int i = 0; i < StokUrunadet; i++)
    //    {
    //        if (da1.Read())
    //        {
    //            StokUrunadları[i] = (string)da1[0];
    //        }
    //        else
    //        {
    //            break;
    //        }
    //    }
    //    SqlC.con.Close();





    //    // Eczane StokUrunAdet Çekme
    //    SqlC.con.Open();
    //    SqlC.com.CommandText = "use kasa SELECT  count(COLUMN_NAME) FROM INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'EczaneStok'  and COLUMN_NAME not like 'EczaneStokID' and COLUMN_NAME not like 'EczaneID'";
    //    SqlDataReader da2 = SqlC.com.ExecuteReader();
    //    while (da2.Read())
    //    {
    //        Eczane_StokUrunAdet = (int)da2[0];
    //    }
    //    SqlC.con.Close();
    //    string[] Eczane_StokUrunadları = new string[Eczane_StokUrunAdet];
    //    //EczaneStokUrunadı ÇEKME
    //    SqlC.con.Open();
    //    SqlC.com.CommandText = "use kasa SELECT  COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'EczaneStok'  and COLUMN_NAME not like 'EczaneStokID' and COLUMN_NAME not like 'EczaneID'";
    //    SqlDataReader da3 = SqlC.com.ExecuteReader();
    //    for (int i = 0; i < Eczane_StokUrunAdet; i++)
    //    {
    //        if (da3.Read())
    //        {
    //            Eczane_StokUrunadları[i] = (string)da3[0];
    //        }
    //        else
    //        {
    //            break;
    //        }
    //    }
    //    SqlC.con.Close();

    //    for (int i = 0; i < Eczane_StokUrunAdet; i++)
    //    {
    //        for (int j = 0; j < (StokUrunadet); j++)
    //        {
    //            if (Eczane_StokUrunadları[i]==StokUrunadları[j])
    //            {
    //                SqlC.con.Open();
    //                SqlC.com.CommandText = "use kasa UPDATE EczaneStok SET " + Eczane_StokUrunadları[i] + "=" + StokUrunAdetSayısı[j] + "  WHERE EczaneID='" + EczaneID + "'";


    //                SqlC.com.Connection = SqlC.con;
    //                SqlC.com.ExecuteNonQuery();
    //                SqlC.con.Close();


    //            }

    //        }
    //    }

    //    //SqlC.con.Open();
    //    //SqlC.com.CommandText = "use kasa UPDATE EczaneStok SET StokOnayDurumu=0 ,StonOnayCss=" + SqlC.StokOnayCssBeklemede + ",StokOnayText=" + SqlC.StonOnayTxtBekleme + " WHERE EczaneID='" + EczaneID + "'";
    //    //SqlC.com.Connection = SqlC.con;
    //    //SqlC.com.ExecuteNonQuery();
    //    //SqlC.con.Close();





    //}


}


