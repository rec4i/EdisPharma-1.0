using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;

namespace deneme9
{
    class SqlC
    {
        //public static SqlConnection con = new SqlConnection(@"server = " + SqlC.dosyadanOku()[0].ToString() + "; Database = " + dbname + ";User ID = sa; Password=" + SqlC.dosyadanOku()[1].ToString());
        public static SqlConnection con = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
        public static string dbname = "master";
        public static SqlCommand com = new SqlCommand();
        public static SqlDataAdapter daa = new SqlDataAdapter(com);
        public static string StokOnayCssBeklemede = "label label-warning";
        public static string StonOnayTxtBekleme = "Beklemede";
        public static string StokOnayCssOnaylandı = "label label-success";
        public static string StokOnayTxtOnaylandı = "Onaylandı";
        public static string StokOnayCssReddedildi = "label label-danger";
        public static string GecenGun30css = "label label-danger";
        public static string GecenGun15css = "label label-warning";
        public static string GecenGun7css = "label label-info";
       




        public static string[] dosyadanOku()
        {

            string dosya_yolu = @"C:\yeniklasor\settings.txt";

            string[] Settings = System.IO.File.ReadAllLines(dosya_yolu, Encoding.GetEncoding("windows-1254"));


            return Settings;


        }
        
        public static void dosyayaz(string a, string b, string c, string d)
        {
            FileStream fs = new FileStream(@"C:\yeniklasor\settings.txt", FileMode.OpenOrCreate, FileAccess.Write, FileShare.Write);
            StreamWriter sw = new StreamWriter(fs);

            sw.WriteLine(a);
            sw.WriteLine(b);
            sw.WriteLine(c);
            sw.WriteLine(d);

            sw.Close();
            fs.Close();
        }

        public static bool dbkont()
        {
            bool kontrol = false;
            DataSet dataset = new DataSet();
            con.Open();
            com.CommandText = "SELECT name FROM master.dbo.sysdatabases";
            com.Connection = SqlC.con;
            daa.SelectCommand = com;

            daa.Fill(dataset);
            //MessageBox.Show(dataset.Tables[0].Rows[1].ItemArray[0].ToString());
            for (int i = 0; i < dataset.Tables[0].Rows.Count; i++)
            {

                if (dataset.Tables[0].Rows[i].ItemArray[0].ToString() == "DENEME_")
                {

                    kontrol = true;

                }
            }

            con.Close();

            return kontrol;


        }
        public static void dbolustur()
        {
            if (SqlC.dbkont() == false)
            {
                try
                {
                    SqlC.con.Open();
                    SqlC.com.CommandText = "CREATE DATABASE DENEME_ ";
                    SqlC.com.Connection = SqlC.con;
                    SqlC.com.ExecuteNonQuery();
                    SqlC.con.Close();

                    SqlC.con.Open();
                    SqlC.com.CommandText = "use DENEME_ CREATE TABLE Kullanıcılar( ID_ INT IDENTITY(1, 1),Kullanıcı_ID nchar(255), PASS nchar(255) ,CONSTRAINT ID_ PRIMARY KEY(ID_) );CREATE TABLE CARI_( ID__ INT IDENTITY(1, 1),Cari_ID nchar(255), Adres nchar(255) ,VKN_ int,Telefon_ int,CONSTRAINT ID__ PRIMARY KEY(ID__) ); ";
                    SqlC.com.Connection = SqlC.con;
                    SqlC.com.ExecuteNonQuery();
                    SqlC.con.Close();

                }
                catch (Exception ex)
                {



                }

            }

        }
    }
}