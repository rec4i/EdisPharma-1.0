using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json;

namespace deneme9
{
    public partial class DT_Deneme : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        public class Eczane_Listleri_
        {
            public string Liste_Id { get; set; }
            public string Lİste_Adı { get; set; }
        }
        [System.Web.Services.WebMethod]
        public static string Eczane_Listeleri(string parametre)
        {

            DataTable dt = (DataTable)JsonConvert.DeserializeObject(parametre, (typeof(DataTable)));

            List<Eczane_Listleri_> tablo_Doldur_Classes = new List<Eczane_Listleri_>();
            var Tablo_Doldur_Class_ = new Eczane_Listleri_
            {
                Liste_Id ="asd",
                Lİste_Adı ="asd"

            };
            tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
            var Tablo_Doldur_Class__ = new Eczane_Listleri_
            {
                Liste_Id = "asd",
                Lİste_Adı = "asd"

            };
            tablo_Doldur_Classes.Add(Tablo_Doldur_Class__);
            var Tablo_Doldur_Class___ = new Eczane_Listleri_
            {
                Liste_Id = "asd",
                Lİste_Adı = "asd"

            };
            tablo_Doldur_Classes.Add(Tablo_Doldur_Class___);
           
            return JsonConvert.SerializeObject(tablo_Doldur_Classes);
            //select * from listeler where Kullanıcı_Id=(select KullanıcıID from Kullanıcı where KullanıcıAD='recai') and cins = 0
            //var queryWithForJson = "use kasa select Liste_Id,Liste_Ad from listeler where Kullanıcı_Id=(select KullanıcıID from Kullanıcı where KullanıcıAD='recai') and cins = 1 ";
            //var conn = new SqlConnection(@"server=.;Database=KASA;User ID=sa;Password=likompresto%1");
            //var cmd = new SqlCommand(queryWithForJson, conn);
            //Eczane_Listleri_ bsObj = JsonConvert.DeserializeObject<Eczane_Listleri_>(parametre);

            //List<Eczane_Listleri_> tablo_Doldur_Classes = new List<Eczane_Listleri_>();

            //conn.Open();

            //var jsonResult = new StringBuilder();
            //var reader = cmd.ExecuteReader();
            //if (!reader.HasRows)
            //{
            //    jsonResult.Append("[]");
            //}
            //else
            //{
            //    while (reader.Read())
            //    {
            //        var Tablo_Doldur_Class_ = new Eczane_Listleri_
            //        {
            //            Liste_Id = reader.GetValue(0).ToString(),
            //            Lİste_Adı = reader.GetValue(1).ToString(),

            //        };
            //        tablo_Doldur_Classes.Add(Tablo_Doldur_Class_);
            //    }
            //}
            //return JsonConvert.SerializeObject(tablo_Doldur_Classes);


        }
    }
}