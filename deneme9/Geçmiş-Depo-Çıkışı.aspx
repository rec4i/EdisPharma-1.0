<%@ Page Title="" Language="C#" MasterPageFile="~/admin.Master" AutoEventWireup="true" CodeBehind="Geçmiş-Depo-Çıkışı.aspx.cs" Inherits="deneme9.Geçmiş_Depo_Çıkışı" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {

            var TextBox2 = $('input[id*=Bas_Tar]')
            var TextBox3 = $('input[id*=Bit_Tar]')

            var Today = new Date();

            function formatDate(date) {
                var d = new Date(date),
                    month = '' + (d.getMonth() + 1),
                    day = '' + (d.getDate()),
                    year = d.getFullYear();

                if (month.length < 2)
                    month = '0' + month;
                if (day.length < 2)
                    day = '0' + day;

                return [year, month, day].join('-');
            }
            var x = new Date(Today);

            var d = new Date(x.getFullYear(), 12, 0);
            TextBox3.attr('value', formatDate(d));
            var d = new Date(x.getFullYear(), 0, 1);
            TextBox2.attr('value', formatDate(d));

            //#region

            $("select[name=Urun_Adı_Select2]").select2({
                placeholder: "Ürün Adı Seçiniz",
                "language": {
                    "noResults": function () {
                        return "Sonuç Bulunamadı";
                    }
                },
            })

            $("select[name=Şehir_Adı_Select2]").select2({
                placeholder: "Şehir Seçiniz",
                "language": {
                    "noResults": function () {
                        return "Sonuç Bulunamadı";
                    }
                },
            })

            $("select[name=Semt_Adı_Select2]").select2({
                placeholder: "Brick Seçiniz",
                "language": {
                    "noResults": function () {
                        return "Sonuç Bulunamadı";
                    }
                },
            })

            $("select[name=Depo_Adı_Select2]").select2({
                placeholder: "Depo Adı Seçiniz",
                "language": {
                    "noResults": function () {
                        return "Sonuç Bulunamadı";
                    }
                },
            })

            //#endregion

            //#region Filtre Doldurma
            //Ürün Doldurma
            $.ajax({
                url: 'Geçmiş-Depo-Çıkışı.aspx/Geçmiş_Urun_Adı',
                dataType: 'json',
                type: 'POST',
                data: "{'Paramatre':''}",
                async: false,
                contentType: 'application/json; charset=utf-8',
                success: function (data) {
                    Liste_İncele_Düzenle = [];
                    var temp = JSON.parse(data.d);

                    var Urun_Adı_Select2 = $('select[id=Urun_Adı_Select2]')
                    for (var i = 0; i < temp.length; i++) {
                        Urun_Adı_Select2.append('<option value="' + temp[i].Urun_Adı + '">' + temp[i].Urun_Adı + '</option>')
                    }

                },
                error: function () {
                    alert('Talep esnasında sorun oluştu.Yeniden deneyin');
                }
            });
            //Şehir Doldurma
            $.ajax({
                url: 'Geçmiş-Depo-Çıkışı.aspx/Geçmiş_Şehir',
                dataType: 'json',
                type: 'POST',
                data: "{'Paramatre':''}",
                async: false,
                contentType: 'application/json; charset=utf-8',
                success: function (data) {
                    Liste_İncele_Düzenle = [];
                    var temp = JSON.parse(data.d);

                    var Şehir_Adı_Select2 = $('select[id=Şehir_Adı_Select2]')
                    for (var i = 0; i < temp.length; i++) {
                        Şehir_Adı_Select2.append('<option value="' + temp[i].Şehir_Adı + '">' + temp[i].Şehir_Adı + '</option>')
                    }

                },
                error: function () {
                    alert('Talep esnasında sorun oluştu.Yeniden deneyin');
                }
            });

            //Brick Brick
            $.ajax({
                url: 'Geçmiş-Depo-Çıkışı.aspx/Geçmiş_Brick',
                dataType: 'json',
                type: 'POST',
                data: "{'Paramatre':''}",
                async: false,
                contentType: 'application/json; charset=utf-8',
                success: function (data) {
                    Liste_İncele_Düzenle = [];
                    var temp = JSON.parse(data.d);

                    var Semt_Adı_Select2 = $('select[id=Semt_Adı_Select2]')
                    for (var i = 0; i < temp.length; i++) {
                        Semt_Adı_Select2.append('<option value="' + temp[i].Brick_Adı + '">' + temp[i].Brick_Adı + '</option>')
                    }

                },
                error: function () {
                    alert('Talep esnasında sorun oluştu.Yeniden deneyin');
                }
            });

            //Depo Brick
            $.ajax({
                url: 'Geçmiş-Depo-Çıkışı.aspx/Geçmiş_Depo',
                dataType: 'json',
                type: 'POST',
                data: "{'Paramatre':''}",
                async: false,
                contentType: 'application/json; charset=utf-8',
                success: function (data) {
                    Liste_İncele_Düzenle = [];
                    var temp = JSON.parse(data.d);

                    var Depo_Adı_Select2 = $('select[id=Depo_Adı_Select2]')
                    for (var i = 0; i < temp.length; i++) {
                        Depo_Adı_Select2.append('<option value="' + temp[i].Depo_Adı + '">' + temp[i].Depo_Adı + '</option>')
                    }

                },
                error: function () {
                    alert('Talep esnasında sorun oluştu.Yeniden deneyin');
                }
            });

            //#endregion

            //#region

            var Ara_Btn = $('button[id=Ara_Btn]')
            var Liste = [];
            Ara_Btn.click(function () {

                var Urun_Adı_Select2 = $('select[id=Urun_Adı_Select2]')
                var Şehir_Adı_Select2 = $('select[id=Şehir_Adı_Select2]')
                var Semt_Adı_Select2 = $('select[id=Semt_Adı_Select2]')
                var Depo_Adı_Select2 = $('select[id=Depo_Adı_Select2]')

                //#region Urun_Adı


                var Urun_Adı_Liste = [];
                if (Urun_Adı_Select2.val().length > 0) {
                    for (var i = 0; i < Urun_Adı_Select2.val().length; i++) {
                        var Urun_Adı_Class = {
                            Urun_Adı: null
                        }
                        Urun_Adı_Class.Urun_Adı = Urun_Adı_Select2.val()[i];
                        Urun_Adı_Liste.push(Urun_Adı_Class)
                    }
                }
                else {
                    var Urun_Adı_Class = {
                        Urun_Adı: null
                    }
                    Urun_Adı_Class.Urun_Adı = null;
                    Urun_Adı_Liste.push(Urun_Adı_Class)
                }
                //#endregion

                //#region Şehir

                var Şehir_Liste = [];
                if (Şehir_Adı_Select2.val().length > 0) {
                    for (var i = 0; i < Şehir_Adı_Select2.val().length; i++) {
                        var Urun_Adı_Class = {
                            Urun_Adı: null
                        }
                        Urun_Adı_Class.Urun_Adı = Şehir_Adı_Select2.val()[i];
                        Şehir_Liste.push(Urun_Adı_Class)
                    }
                }
                else {
                    var Urun_Adı_Class = {
                        Urun_Adı: null
                    }
                    Urun_Adı_Class.Urun_Adı = null;
                    Şehir_Liste.push(Urun_Adı_Class)
                }

                
                //#endregion

                //#region Semt

                var Semt_Liste = [];
                if (Semt_Adı_Select2.val().length > 0) {
                    for (var i = 0; i < Semt_Adı_Select2.val().length; i++) {
                        var Urun_Adı_Class = {
                            Semt: null
                        }
                        Urun_Adı_Class.Semt = Semt_Adı_Select2.val()[i];
                        Semt_Liste.push(Urun_Adı_Class)
                    }
                }
                else {
                    var Urun_Adı_Class = {
                        Semt: null
                    }
                    Urun_Adı_Class.Semt = null;
                    Semt_Liste.push(Urun_Adı_Class)
                }
                //#endregion

                //#region Depo

                var Depo_Adı_Liste = [];
                if (Depo_Adı_Select2.val().length > 0) {
                    for (var i = 0; i < Depo_Adı_Select2.val().length; i++) {
                        var Urun_Adı_Class = {
                            Depo_Adı_: null
                        }
                        Urun_Adı_Class.Depo_Adı_ = Depo_Adı_Select2.val()[i];
                        Depo_Adı_Liste.push(Urun_Adı_Class)
                    }
                }
                else {
                    var Urun_Adı_Class = {
                        Depo_Adı_: null
                    }
                    Urun_Adı_Class.Depo_Adı_ = null;
                    Depo_Adı_Liste.push(Urun_Adı_Class)
                }
                //#endregion


                //#region Adetler
                var Min_Adet_Reel = 0;
                var Max_Adet_Reel = 0;

                var Min_Mf_Adet_Reel = 0;
                var Max_Mf_Adet_Reel = 0;
                //#endregion

                //form-group has-warning
                //#region Adet
                var Min_Adet = $('input[id=Min_Adet]')
                var Max_Adet = $('input[id=Max_Adet]')
                if (Min_Adet.val() != "") {
                    Min_Adet_Reel = Min_Adet.val();
                }
                if (Max_Adet.val() != "") {
                    Max_Adet_Reel = Min_Adet.val();
                }

                //#endregion

                //#region Mf_Adet
                var Min_Mf_Adet = $('input[id=Min_Mf_Adet]')
                var Max_Mf_Adet = $('input[id=Max_Mf_Adet]')
                if (Min_Mf_Adet.val() != "") {
                    Min_Mf_Adet_Reel = Min_Adet.val();
                }
                if (Max_Mf_Adet.val() != "") {
                    Max_Mf_Adet_Reel = Min_Adet.val();
                }

                //#endregion

             

                var TextBox2 = $('input[id=Bas_Tar]')
                var TextBox3 = $('input[id=Bit_Tar]')
              
               

                $.ajax({
                    url: 'Geçmiş-Depo-Çıkışı.aspx/Geçmiş_Sorgu',
                    dataType: 'json',
                    type: 'POST',
                    async: false,

                    data: "{'Urun_Adı': '{Urun_Adı_Liste:" + JSON.stringify(Urun_Adı_Liste) + "}'," +
                        "'Şehir':'{Şehir_Liste:" + JSON.stringify(Şehir_Liste) + "}'," +
                        "'Semt':'{Semt_Liste:" + JSON.stringify(Semt_Liste) + "}'," +
                        "'Depo':'{Depo_Liste:" + JSON.stringify(Depo_Adı_Liste) + "}'," +

                        "'Max_Adet':'" + Max_Adet_Reel + "'," +
                        "'Min_Adet':'" + Min_Adet_Reel+"'," +
                        "'Max_Mf_Adet':'" + Max_Mf_Adet_Reel+"'," +
                        "'Min_Mf_Adet':'" + Min_Mf_Adet_Reel + "'," +
                        "'Bas_Tar':'" + TextBox2.val() + "'," +
                        "'Bit_Tar':'" + TextBox3.val() + "'" +
                        "}",
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {
                        Liste = [];
                        var temp = JSON.parse(data.d);
                 

                        for (var i = 0; i < temp.length; i++) {
                            var MyClass = {
                                Urun_Adı: null,
                                Adet: null,
                                Mf_Adet: null,
                                Brick: null,
                                Şehir: null,
                                İşlem_Tar: null,
                                Eczane: null,
                            }
                            MyClass.Urun_Adı = temp[i].Ürün_Adı;
                            MyClass.Adet = temp[i].Adet;
                            MyClass.Mf_Adet = temp[i].Mf_Adet;
                            MyClass.Brick = temp[i].Brick;
                            MyClass.Şehir = temp[i].Şehir;
                            MyClass.İşlem_Tar = temp[i].İşlem_Tar;
                            MyClass.Eczane = temp[i].Eczane;

                            Liste.push(MyClass);
                        }

                        Tabloyu_Doldur_İncele_Düzenle(Liste)

                    },// tekrar eklemeyi önlemek için eklenen doktorları tabloya kaydet sonra ona göre listele xd
                    error: function () {
                        alert('Talep esnasında sorun oluştu.Yeniden deneyin');
                    }
                });

            });





            Tabloyu_Doldur_İncele_Düzenle(Liste)
            function Tabloyu_Doldur_İncele_Düzenle(Liste_) {
                $('#Tablo_Div_Veri').empty();

                $('#Tablo_Div_Veri').append('<table id="example_incele" class="display" style="width: 100%">' +
                    '<thead>' +
                    '<tr>' +
                    '<th>Eczane</th>' +
                    
                    '<th>Adet</th>' +
                    '<th>Mf Adet</th>' +
                    '<th>Urun Adı</th>' +
                    '<th>Brick</th>' +
                    '<th>Şehir</th>' +
                    '<th>İşlem Tarihi</th>' +

                    '</tr>' +
                    '</thead>' +
                    '<tbody id="Tbody_İncele">' +
                    '</tbody>' +
                    '<tfoot>' +
                    ' <tr>' +
                    '<th></th>' +
                    '<th></th>' +
                    '<th></th>' +


                    '<th></th>' +
                    '<th></th>' +
                    '<th></th>' +
                    '<th></th>' +
                    '</tr>' +
                    '</tfoot>' +
                    '</table>'
                );


                if (Liste_.length > 0) {
                    var Tbody = $('tbody[id=Tbody_İncele]')



                    for (var i = 0; i < Liste_.length; i++) {
                      
                        Tbody.append(
                            '<tr>' +
                            '<td>' + Liste_[i].Eczane + '</td>' +
                            '<td>' + Liste_[i].Urun_Adı + '</td>' +
                            '<td>' + Liste_[i].Adet + '</td>' +
                            '<td>' + Liste_[i].Mf_Adet + '</td>' +
                        
                            '<td>' + Liste_[i].Brick + '</td>' +
                            '<td>' + Liste_[i].Şehir + '</td>' +
                            '<td>' + Liste_[i].İşlem_Tar + '</td>' +
                            
                            '</tr>'
                        )
                    }


                }



                var Kullanıcı_Adı;
                $.ajax({
                    url: 'Materyal-Talebi.aspx/Kullanıcı_Adı_Soyadı',
                    type: 'POST',
                    data: "{'parametre': ''}",
                    async: false,
                    global: false,
                    dataType: "json",
                    contentType: "application/json; charset=utf-8",
                    success: function (data) {

                        Kullanıcı_Adı = data.d;


                    },// tekrar eklemeyi önlemek için eklenen doktorları tabloya kaydet sonra ona göre listele xd
                    error: function () {

                        alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                    }
                });



                var today = new Date();
                var date = today.getDate() + '/' + (today.getMonth() + 1) + '/' + today.getFullYear();
                var dateTime = date;

                $('#example_incele').dataTable({

                    "lengthMenu": [10, 25, 50, 75, 100, 200, 500, 750, 1000],
                    "language": {
                        "url": "//cdn.datatables.net/plug-ins/1.10.22/i18n/Turkish.json"
                    },

                });

            };
            //#endregion
        })
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row">
        <div class="col-xs-12">
            <div class="box">
                <div class="box-body">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <label>Filtrele</label>
                        </div>
                        <div class="panel-body">
                            <div class="row">
                                <div class="col-xs-3">
                                    <label>Ürün Adı:</label>
                                </div>
                                <div class="col-xs-3">
                                    <label>Şehir :</label>
                                </div>
                                <div class="col-xs-3">
                                    <label>Brick :</label>
                                </div>
                                <div class="col-xs-3">
                                    <label>Depo :</label>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-xs-3">
                                    <select name="Urun_Adı_Select2" class="js-example-placeholder-multiple js-states form-control" id="Urun_Adı_Select2" multiple="multiple"></select>
                                </div>
                                <div class="col-xs-3">
                                    <select name="Şehir_Adı_Select2" class="js-example-placeholder-multiple js-states form-control" id="Şehir_Adı_Select2" multiple="multiple"></select>
                                </div>
                                <div class="col-xs-3">
                                    <select name="Semt_Adı_Select2" class="js-example-placeholder-multiple js-states form-control" id="Semt_Adı_Select2" multiple="multiple"></select>
                                </div>
                                <div class="col-xs-3">
                                    <select name="Depo_Adı_Select2" class="js-example-placeholder-multiple js-states form-control" id="Depo_Adı_Select2" multiple="multiple"></select>
                                </div>
                            </div>
                            <div class="row" style="">
                                <div class="col-xs-4 text-center">
                                    <label></label>
                                </div>
                            </div>
                            <div class="row" style="padding-top: 15px;">
                                <div class="col-xs-3">
                                    <label>Min Adet:</label>
                                </div>
                                <div class="col-xs-3">
                                    <label>Max Adet:</label>
                                </div>
                                <div class="col-xs-3">
                                    <label>Min Mf Adet :</label>
                                </div>
                                <div class="col-xs-3">
                                    <label>Max Mf Adet :</label>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-xs-3">
                                    <div class="form-group">
                                        <input id="Min_Adet" type="number" class="form-control" placeholder="Min Adet" />
                                    </div>
                                </div>
                                <div class="col-xs-3">
                                    <div class="form-group">
                                        <input id="Max_Adet" type="number" class="form-control" placeholder="Max Adet" />
                                    </div>
                                </div>
                                <div class="col-xs-3">
                                    <div class="form-group">
                                        <input id="Min_Mf_Adet" type="number" class="form-control" placeholder="Min Mf Adet" />
                                    </div>
                                </div>
                                <div class="col-xs-3">
                                    <div class="form-group">
                                        <input id="Max_Mf_Adet" type="number" class="form-control" placeholder="Max Mf Adet" />
                                    </div>
                                </div>

                            </div>
                            <div class="row">
                                <div class="col-xs-6">
                                    <label>Bas Tar. :</label>
                                </div>
                                <div class="col-xs-6">
                                    <label>Bit Tar. :</label>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-xs-6">
                                    <div class="form-group">
                                        <input id="Bas_Tar" type="date" class="form-control" placeholder="Max Adet" />
                                    </div>
                                </div>
                                <div class="col-xs-6">
                                    <div class="form-group">
                                        <input id="Bit_Tar" type="date" class="form-control" placeholder="Max Adet" />
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="panel-footer">
                            <button id="Ara_Btn" type="button" class="btn btn-block btn-info">Ara</button>
                        </div>
                    </div>
                </div>
                <div class="box-footer">
                    <div id="Tablo_Div_Veri"></div>
                </div>
            </div>
        </div>

    </div>
</asp:Content>
