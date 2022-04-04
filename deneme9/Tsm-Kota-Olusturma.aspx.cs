using Newtonsoft.Json;
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
    public partial class Tsm_Kota_Olusturma : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        public class Birim_Fiyat__
        {
            public string Toplam { get; set; }
            public string Birim_Fiyat___ { get; set; }
            public string Satış_Fiyat { get; set; }
            public string Birim_Fiyat_Toplam { get; set; }
            public string Satış_Fiyat_Toplam { get; set; }
        }
        public static Birim_Fiyat__ Birim_Fiyat_(string Urun_Kar, string Urun_Fiyat, string Adet, string Mf_Adet)
        {

            double Urun_Fiyat_ = Convert.ToDouble(Urun_Fiyat);
            double Urun_Kar_ = Convert.ToDouble(Urun_Kar);
            double Adet_ = Convert.ToDouble(Adet);
            double Mf_Adet_ = Convert.ToDouble(Mf_Adet);



            double birimfiyat = (Convert.ToDouble(Urun_Fiyat_) / ((Convert.ToDouble(Urun_Kar_) / 100) + 1)) * (Convert.ToDouble(Adet_)) / (Convert.ToDouble(Mf_Adet_) + Convert.ToDouble(Adet_));

            string a = birimfiyat.ToString("#.##");

            var Tablo_Doldur_Class_ = new Birim_Fiyat__
            {
                Toplam = (Adet_ + Mf_Adet_).ToString(),
                Birim_Fiyat___ = a,
                Satış_Fiyat = Urun_Fiyat,
                Birim_Fiyat_Toplam = Convert.ToDouble(Convert.ToDouble(a) * Convert.ToDouble(Adet_ + Mf_Adet_)).ToString("#.#####"),
                Satış_Fiyat_Toplam = Convert.ToDouble(Convert.ToDouble(Urun_Fiyat_) * Convert.ToDouble(Adet_ + Mf_Adet_)).ToString("#.#####")

            };

            return Tablo_Doldur_Class_;



        }
        [System.Web.Services.WebMethod]
        public static string Haftanın_Gunleri(string parametre,string Kullanıcı_Id)
        {

            string gelen_yıl = parametre.Split('-')[1];
            string gelen_ay = parametre.Split('-')[0];

            DateTime tarih = new DateTime(Convert.ToInt32(gelen_yıl), Convert.ToInt32(gelen_ay), 1);
            DateTime tarih_son_gün = new DateTime(Convert.ToInt32(gelen_yıl), Convert.ToInt32(gelen_ay), 1);



            tarih_son_gün = new DateTime(tarih_son_gün.Year, tarih_son_gün.Month, 1);


            DateTime tarih_Öncekiayın_son_gunu = new DateTime(tarih.Year, tarih.Month, 1);
            DateTime tarih_Bu_ayın_ilk_gunu = new DateTime(tarih.Year, tarih.Month, 1);


            SqlCommand cmd11 = new SqlCommand(" " +
                      "use kasa declare @gün  int=1; " +
                      "" +
                      "declare @kullanıcı nvarchar(max) = (select KullanıcıAD from Kullanıcı where KullanıcıID=@Kullanıcı_id)" +
                      "declare @Ayın_Ilk_Gunu_parse date=cast(@Ayın_Ilk_Gunu as date); " +
                      "declare @Ayın_Son_Gunu_parse date=cast(@Ayın_Son_Gunu as date); " +
                      "declare @toplam nvarchar(max)=CAST(@gün as varchar)+'-'+CAST(@ay as varchar)+'-'+CAST(@yıl as varchar); " +
                      "declare @birleşim date= CAST(@toplam as date); " +
                      "declare @İd table (Id int); " +
                      "if exists(select * from Ziyaret_Onay where Kullanıcı_Id= (select KullanıcıID from Kullanıcı where KullanıcıAD COLLATE Latin1_general_CS_AS =@kullanıcı) and Bas_Tar=@Ayın_Ilk_Gunu and Bit_Tar=@Ayın_Son_Gunu) " +
                      "begin " +
                      "select CONVERT (varchar(10), Ziyaret_Genel.Ziy_Tar, 104)as 'ziyaret tar',Ziyaret_Genel.ID ,Kullanıcı_ID,Ziy_ID,Ziy_Edilen_Eczane,Ziy_Edilen_Doktor,(select count(*) from Ziyaret_Detay where Ziy_Gnl_ID=ID and Cins=1)as Ziyaret_Edilecek_Eczane,(select count(*) from Ziyaret_Detay where Ziy_Gnl_ID=ID and Cins=0)as Ziyaret_Edilecek_Doktor,(select COUNT(*) from Ziyaret_Detay  where ID=Ziy_Gnl_Id and Cins=0 and Ziyaret_Durumu=1) as ziyaret_edilen_Eczane,(select COUNT(*) from Ziyaret_Detay  where ID=Ziy_Gnl_Id and Cins=1 and Ziyaret_Durumu=1) as ziyaret_edilen_Doktor  from Ziyaret_Genel where Kullanıcı_ID=(select KullanıcıID from Kullanıcı where KullanıcıAD COLLATE Latin1_general_CS_AS =@kullanıcı) and Ziy_Tar between @Ayın_Ilk_Gunu and @Ayın_Son_Gunu;  " +
                      "end; " +
                      "else " +
                      " begin " +
                      "insert into Ziyaret_Onay (Bas_Tar,Bit_Tar,Kullanıcı_Id) output inserted.Ziyaret_Onay_Id into @İd values (@Ayın_Ilk_Gunu,@Ayın_Son_Gunu,(select KullanıcıID from Kullanıcı where KullanıcıAD COLLATE Latin1_general_CS_AS =@kullanıcı)) " +
                      "WHILE @gün < @Ayın_Son_Günü_tek+1  " +
                      "BEGIN   " +
                      "set @toplam=CAST(@yıl as varchar)+'-'+CAST(@ay as varchar)+'-'+CAST(@gün as varchar);  " +
                      "set @birleşim=CAST(@toplam as date);   " +
                      "INSERT INTO Ziyaret_Genel (Ziy_Tar,Kullanıcı_ID,Ziyaret_Onay_Id) values (@birleşim,(select KullanıcıID from Kullanıcı where   KullanıcıAD COLLATE Latin1_general_CS_AS =@kullanıcı),(select * from @İd));  " +
                      "SET @gün = @gün + 1;  " +
                      "print @toplam; " +
                      "END; " +
                      "select CONVERT (varchar(10), Ziyaret_Genel.Ziy_Tar, 104)as 'ziyaret tar',Ziyaret_Genel.ID ,Kullanıcı_ID,Ziy_ID,Ziy_Edilen_Eczane,Ziy_Edilen_Doktor,(select count(*) from Ziyaret_Detay where Ziy_Gnl_ID=ID and Cins=1)as Ziyaret_Edilecek_Eczane,(select count(*) from Ziyaret_Detay where Ziy_Gnl_ID=ID and Cins=0)as Ziyaret_Edilecek_Doktor,(select COUNT(*) from Ziyaret_Detay  where ID=Ziy_Gnl_Id and Cins=0 and Ziyaret_Durumu=1) as ziyaret_edilen_Eczane,(select COUNT(*) from Ziyaret_Detay  where ID=Ziy_Gnl_Id and Cins=1 and Ziyaret_Durumu=1) as ziyaret_edilen_Doktor  from Ziyaret_Genel where Kullanıcı_ID=(select KullanıcıID from Kullanıcı where KullanıcıAD COLLATE Latin1_general_CS_AS =@kullanıcı) and Ziy_Tar between @Ayın_Ilk_Gunu and @Ayın_Son_Gunu;  " +
                      "end " +

                      "", SqlC.con);


            string a_1 = Convert.ToString(Convert.ToInt32(Convert.ToString(tarih_son_gün.AddMonths(1).AddDays(-1).ToString("dd"))));
            string a_2 = Convert.ToString(Convert.ToInt32(Convert.ToString(gelen_ay)));
            string a_3 = Convert.ToString(Convert.ToInt32(Convert.ToInt32(gelen_yıl)));
            string a_4 = Convert.ToString(tarih_Bu_ayın_ilk_gunu.ToString("yyyy-MM-dd"));
            string a_5 = Convert.ToString(tarih_son_gün.AddMonths(1).AddDays(-1).ToString("yyyy-MM-dd"));


            cmd11.Parameters.AddWithValue("@Ayın_Son_Günü_tek", a_1);
            cmd11.Parameters.AddWithValue("@ay", a_2);
            cmd11.Parameters.AddWithValue("@yıl", a_3);//@kullanıcı
            cmd11.Parameters.AddWithValue("@Ayın_Ilk_Gunu", a_4);
            cmd11.Parameters.AddWithValue("@Ayın_Son_Gunu", a_5);
            cmd11.Parameters.AddWithValue("@Kullanıcı_id", Kullanıcı_Id);

            SqlC.con.Open();

            var reader = cmd11.ExecuteReader();//47 block

            string a = "";
            string b = "";
            while (reader.Read())//0-tar , 1-id , 2-Kullanıcı_ıd , 3-Ziy_Id , 4-Ziy_Edilen_Eczane , 5- Ziy_Edilen_Doktor , 6-Ziy_Edilecek_Eczane , 7- Ziy_Edilecek_Doktor 
            {
                a += reader.GetValue(0).ToString() + "-" + reader.GetValue(1).ToString() + "-" + reader.GetValue(2).ToString() + "-" + reader.GetValue(3).ToString() + "-" + reader.GetValue(4).ToString() + "-" + reader.GetValue(5).ToString() + "-" + reader.GetValue(6).ToString() + "-" + reader.GetValue(7).ToString() + "-" + reader.GetValue(8).ToString() + "-" + reader.GetValue(9).ToString() + "!";
            }

            //a.Split('!')[0].Split('-')[0].Split('.')[1] = birinci günün ayı

            SqlC.con.Close();







            if (tarih_Bu_ayın_ilk_gunu.ToString("dddd") == "Pazartesi")
            {
                for (int i = 0; i < 42; i++)
                {
                    if (i > ((Convert.ToInt32(tarih_son_gün.AddMonths(1).AddDays(-1).ToString("dd"))) - 1))
                    {
                        b += "empty" + "!";
                    }
                    else
                    {
                        b += a.Split('!')[i] + "-" + "1" + "!";

                    }
                }
            }
            else
            {
                //Console.WriteLine(tarih_Öncekiayın_son_gunu.AddDays(-1).ToString("dddd"));// gelen aydan önceki ayın son günü string
                int sayaç = 1;
                int Bu_Ayın_Gün_Sayısı = ((Convert.ToInt32(tarih_son_gün.AddMonths(1).AddDays(-1).ToString("dd"))));
                int Gün_sayaç = 0;
                while (true)
                {
                    if (tarih_Öncekiayın_son_gunu.AddDays(-sayaç).ToString("dddd") != "Pazartesi")
                    {
                        sayaç++;
                    }
                    else
                    {
                        break;
                    }
                }
                for (int i = 0; i < 42; i++)
                {
                    if (i < sayaç)
                    {
                        b += "empty" + "!";

                        continue;
                    }
                    if (i - sayaç > ((Convert.ToInt32(tarih_son_gün.AddMonths(1).AddDays(-1).ToString("dd"))) - 1))
                    {
                        b += "empty" + "!";
                    }
                    else
                    {
                        if (Gün_sayaç < Bu_Ayın_Gün_Sayısı)
                        {
                            b += a.Split('!')[Gün_sayaç] + "-" + "1" + "!";
                            Gün_sayaç++;
                        }


                    }
                }


            }

            return b.Substring(0, b.Length - 1);
        }
        public class Onay_Durum_Tablo
        {
            public string Onay_Durum { get; set; }
         

        }
        [System.Web.Services.WebMethod]
        public static string Kota_Olustur(string Kullanıcı_Id, string Urun_Tablo, string Tarih)
        {
            string Tarih_ = Convert.ToDateTime(Tarih).ToString("MM-yyyy");

            Haftanın_Gunleri(Tarih.Split('-')[1]+"-"+Tarih.Split('-')[0], Kullanıcı_Id);

            DataSet dataSet = JsonConvert.DeserializeObject<DataSet>(Urun_Tablo);

            DataTable dataTable = dataSet.Tables["Deneme"];

            




            var queryWithForJson = " " +
            
                "if not exists ( " +
                "( select * from Kota_Genel where Sipariş_Onay_Id=(select Ziyaret_Onay_Id from Ziyaret_Onay where Kullanıcı_Id=@Kullanıcı_Id and Bas_Tar=@Bas_Tar))" +
                ") " +
                "begin " +
                "  " +
                    " declare @Kota_Genel_Id	table (id int);" +
                " insert into Kota_Genel(Kullanıcı_Id,Sipariş_Onay_Id) output inserted.Kota_Genel_Id into @Kota_Genel_Id values((@Kullanıcı_Id),(select Ziyaret_Onay_Id from Ziyaret_Onay where Kullanıcı_Id=@Kullanıcı_Id and Bas_Tar=@Bas_Tar)) " +
                " insert into Kota_Detay(Kota_Genel_Id,Urun_Id,Adet) select (select top 1 * from @Kota_Genel_Id),ilaç_id,Adet from @Kota_Tablo_Type " +
                "select 0 ; " +
                "end " +
                "else " +
                "begin " +
                "select 1 " +
                "end" +
                "";
               


            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);
            cmd.Parameters.AddWithValue("@Kullanıcı_Id", Kullanıcı_Id);
            cmd.Parameters.AddWithValue("@Bas_Tar", Tarih);
         


            SqlParameter tvpParam = cmd.Parameters.AddWithValue("@Kota_Tablo_Type", dataTable);
            tvpParam.SqlDbType = SqlDbType.Structured;
            tvpParam.TypeName = "dbo.Kota_Tablo_Type";

            conn.Open();

            List<Onay_Durum_Tablo> tablo_Doldur_Classes = new List<Onay_Durum_Tablo>();


            var jsonResult = new StringBuilder();
            var reader = cmd.ExecuteReader();
            if (!reader.HasRows)
            {
                jsonResult.Append("[]");
            }
            else
            {
                while (reader.Read())
                {
                    

                    var Tablo_Doldur_Class_ = new Onay_Durum_Tablo
                    {
                        Onay_Durum = reader.GetValue(0).ToString(),
                    };
                    tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
                }
            }
            conn.Close();
            return JsonConvert.SerializeObject(tablo_Doldur_Classes);

        }

        public class Kota_Kaldır_Tablo
        {
            public string Onay_Durum { get; set; }


        }
        [System.Web.Services.WebMethod]
        public static string Kota_Kaldır(string Kullanıcı_Id, string Tarih)
        {
         

            Haftanın_Gunleri(Tarih.Split('-')[1] + "-" + Tarih.Split('-')[0], Kullanıcı_Id);

          





            var queryWithForJson = " " +
                "delete from Kota_Detay where Kota_Genel_Id=( " +
                "select Kota_Genel_Id from Kota_Genel " +
                "inner join Ziyaret_Onay  " +
                "on Kota_Genel.Sipariş_Onay_Id=Ziyaret_Onay.Ziyaret_Onay_Id " +
                "" +
                "where Kota_Genel.Kullanıcı_Id=@Kullanıcı_Id and Bas_Tar=@Bas_Tar) " +

                "" +
                " delete from Kota_Genel where Kota_Genel_Id=( " +
                "select Kota_Genel_Id from Kota_Genel  " +
                " inner join Ziyaret_Onay " +
                "on Kota_Genel.Sipariş_Onay_Id=Ziyaret_Onay.Ziyaret_Onay_Id " +
                "where Kota_Genel.Kullanıcı_Id=@Kullanıcı_Id and Bas_Tar=@Bas_Tar) " +

                "";



            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);
            cmd.Parameters.AddWithValue("@Kullanıcı_Id", Kullanıcı_Id);
            cmd.Parameters.AddWithValue("@Bas_Tar", Tarih);



     

            conn.Open();

            List<Kota_Kaldır_Tablo> tablo_Doldur_Classes = new List<Kota_Kaldır_Tablo>();


            var jsonResult = new StringBuilder();
            var reader = cmd.ExecuteReader();
            if (!reader.HasRows)
            {
                jsonResult.Append("[]");
            }
            else
            {
                while (reader.Read())
                {


                    var Tablo_Doldur_Class_ = new Kota_Kaldır_Tablo
                    {
                        Onay_Durum = reader.GetValue(0).ToString(),
                    };
                    tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
                }
            }
            conn.Close();
            return JsonConvert.SerializeObject(tablo_Doldur_Classes);

        }

        public class Kota_Detay_Tablo
        {
            public string Urun_Adı { get; set; }
            public string Adet { get; set; }
            public string Hedef { get; set; }
            public string Tamamlanan { get; set; }
            public string Yüzde { get; set; }


        }
        [System.Web.Services.WebMethod]
        public static string Kota_Detay(string Kullanıcı_Id, string Tarih)
        {
           

            Haftanın_Gunleri(Tarih.Split('-')[1] + "-" + Tarih.Split('-')[0], Kullanıcı_Id);





            var queryWithForJson = "select (Urun_Adı),(Adet),(Guncel_DSF*Adet),(cast(ISNULL(( " +
"" +
"select (((SUM(Siparis_Detay.Adet)*Guncel_DSF)/(SUM(Siparis_Detay.Adet)+SUM(Siparis_Detay.Mf_Adet)))*(SUM(Siparis_Detay.Adet)+SUM(Siparis_Detay.Mf_Adet))) from Siparis_Detay " +
"" +
"inner join Sipariş_Genel " +
"on Siparis_Detay.Siparis_Genel_Id=Sipariş_Genel.Siparis_Genel_Id " +
"" +
"where Sipariş_Genel.Olusturan_Kullanıcı=Kota_Genel.Kullanıcı_Id and Siparis_Detay.Urun_Id=Kota_Detay.Urun_Id and Sipariş_Genel.Tar between Ziyaret_Onay.Bas_Tar and Ziyaret_Onay.Bit_Tar " +
"" +
"),0)as decimal(10,2)))as Tamamlanan,(cast(ISNULL(( case when( " +
"" +
"((select (((SUM(Siparis_Detay.Adet)*Guncel_DSF)/(SUM(Siparis_Detay.Adet)+SUM(Siparis_Detay.Mf_Adet)))*(SUM(Siparis_Detay.Adet)+SUM(Siparis_Detay.Mf_Adet))) from Siparis_Detay " +
"" +
"inner join Sipariş_Genel " +
"on Siparis_Detay.Siparis_Genel_Id=Sipariş_Genel.Siparis_Genel_Id " +
"" +
"where Sipariş_Genel.Olusturan_Kullanıcı=Kota_Genel.Kullanıcı_Id and Siparis_Detay.Urun_Id=Kota_Detay.Urun_Id and Sipariş_Genel.Tar between Ziyaret_Onay.Bas_Tar and Ziyaret_Onay.Bit_Tar " +
")*100)/(Guncel_DSF*Adet) )>=100 then 100 else " +
"" +
"((select (((SUM(Siparis_Detay.Adet)*Guncel_DSF)/(SUM(Siparis_Detay.Adet)+SUM(Siparis_Detay.Mf_Adet)))*(SUM(Siparis_Detay.Adet)+SUM(Siparis_Detay.Mf_Adet))) from Siparis_Detay " +
"" +
"inner join Sipariş_Genel " +
"on Siparis_Detay.Siparis_Genel_Id=Sipariş_Genel.Siparis_Genel_Id " +
"" +
"where Sipariş_Genel.Olusturan_Kullanıcı=Kota_Genel.Kullanıcı_Id and Siparis_Detay.Urun_Id=Kota_Detay.Urun_Id and Sipariş_Genel.Tar between Ziyaret_Onay.Bas_Tar and Ziyaret_Onay.Bit_Tar " +
")*100)/(Guncel_DSF*Adet) " +
"" +
"" +
" end " +
"" +
"),0)as decimal(10,2)))as Yuzde " +
"" +
" from Kota_Detay " +
"" +
"inner join Kota_Genel " +
"on Kota_Detay.Kota_Genel_Id=Kota_Genel.Kota_Genel_Id " +
"" +
"inner join Urunler " +
"on Kota_Detay.Urun_Id=Urunler.Urun_Id " +
"" +
"inner join Ziyaret_Onay " +
"on Ziyaret_Onay.Ziyaret_Onay_Id=Kota_Genel.Sipariş_Onay_Id " +
"" +
"" +
"where Ziyaret_Onay.Kullanıcı_Id=@Kullanıcı_Id and  Ziyaret_Onay.Bas_Tar=@Bas_Tar ";



            var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            var cmd = new SqlCommand(queryWithForJson, conn);
            cmd.Parameters.AddWithValue("@Kullanıcı_Id", Kullanıcı_Id);
            cmd.Parameters.AddWithValue("@Bas_Tar", Tarih);


          

            conn.Open();

            List<Kota_Detay_Tablo> tablo_Doldur_Classes = new List<Kota_Detay_Tablo>();


            var jsonResult = new StringBuilder();
            var reader = cmd.ExecuteReader();
            if (!reader.HasRows)
            {
                jsonResult.Append("[]");
            }
            else
            {
                while (reader.Read())
                {


                    var Tablo_Doldur_Class_ = new Kota_Detay_Tablo
                    {
                        Urun_Adı = reader.GetValue(0).ToString(),
                        Adet = reader.GetValue(1).ToString(),
                        Hedef = reader.GetValue(2).ToString(),
                        Tamamlanan = reader.GetValue(3).ToString(),
                        Yüzde = reader.GetValue(4).ToString(),
                    };
                    tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
                }
            }
            conn.Close();
            return JsonConvert.SerializeObject(tablo_Doldur_Classes);





        }
    }
}