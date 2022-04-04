<%@ Page Title="" Language="C#" MasterPageFile="~/b.Master" AutoEventWireup="true" CodeBehind="İms-Raporlama.aspx.cs" Inherits="deneme9.İms_Raporlama" %>

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

            var d = new Date(x.getFullYear(), x.getMonth() - 1, 0);
            TextBox3.attr('value', formatDate(d));
            var d = new Date(x.getFullYear(), x.getMonth() - 2, 1);
            TextBox2.attr('value', formatDate(d));

            $("select[name=Bölge_Müdürü_Adı_Select2]").select2({
                placeholder: "Bölge Müdürü Seçiniz",
                "language": {
                    "noResults": function () {
                        return "Sonuç Bulunamadı";
                    }
                },
            })
            $("select[name=Tıbbi_Mümessil_Adı_Select2]").select2({
                placeholder: "Tıbbi Mümessil Seçiniz",
                "language": {
                    "noResults": function () {
                        return "Sonuç Bulunamadı";
                    }
                },
            })
            $("select[name=İlaç_Adı_Select2]").select2({
                placeholder: "İlaç Adı Seçiniz",
                "language": {
                    "noResults": function () {
                        return "Sonuç Bulunamadı";
                    }
                },
            })


            $.ajax({
                url: 'İms-Raporlama.aspx/Geçmiş_Şehir',
                dataType: 'json',
                type: 'POST',
                data: "{'Paramatre':''}",
                async: false,
                contentType: 'application/json; charset=utf-8',
                success: function (data) {
                    Liste_İncele_Düzenle = [];
                    var temp = JSON.parse(data.d);

                    var Şehir_Adı_Select2 = $('select[id=Bölge_Müdürü_Adı_Select2]')
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
                url: 'İms-Raporlama.aspx/Geçmiş_Brick',
                dataType: 'json',
                type: 'POST',
                data: "{'Paramatre':''}",
                async: false,
                contentType: 'application/json; charset=utf-8',
                success: function (data) {
                    Liste_İncele_Düzenle = [];
                    var temp = JSON.parse(data.d);

                    var Semt_Adı_Select2 = $('select[id=Tıbbi_Mümessil_Adı_Select2]')
                    for (var i = 0; i < temp.length; i++) {
                        Semt_Adı_Select2.append('<option value="' + temp[i].Brick_Adı + '">' + temp[i].Brick_Adı + '</option>')
                    }

                },
                error: function () {
                    alert('Talep esnasında sorun oluştu.Yeniden deneyin');
                }
            });


            $.ajax({
                url: 'İms-Raporlama.aspx/Geçmiş_Depo',
                dataType: 'json',
                type: 'POST',
                data: "{'Paramatre':''}",
                async: false,
                contentType: 'application/json; charset=utf-8',
                success: function (data) {
                    Liste_İncele_Düzenle = [];
                    var temp = JSON.parse(data.d);

                    var Depo_Adı_Select2 = $('select[id=İlaç_Adı_Select2]')
                    for (var i = 0; i < temp.length; i++) {
                        Depo_Adı_Select2.append('<option value="' + temp[i].Barkod + '">' + temp[i].Depo_Adı + '</option>')
                    }

                },
                error: function () {
                    alert('Talep esnasında sorun oluştu.Yeniden deneyin');
                }
            });



            $('button[id=Ara_Btn]').click(function () {
                var Urun_Adı_Select2 = $('select[id=Bölge_Müdürü_Adı_Select2]')
                var Şehir_Adı_Select2 = $('select[id=Tıbbi_Mümessil_Adı_Select2]')
                var Depo_Adı_Select2 = $('select[id=İlaç_Adı_Select2]')
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
                            Şehir_: null
                        }
                        Urun_Adı_Class.Şehir_ = Şehir_Adı_Select2.val()[i];
                        Şehir_Liste.push(Urun_Adı_Class)
                    }
                }
                else {
                    var Urun_Adı_Class = {
                        Şehir_: null
                    }
                    Urun_Adı_Class.Şehir_ = null;
                    Şehir_Liste.push(Urun_Adı_Class)
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

                var TextBox2 = $('input[id*=Bas_Tar]')
                var TextBox3 = $('input[id*=Bit_Tar]')
                $.ajax({
                    url: 'İms-Raporlama.aspx/İms_Veri_Toplam_Tutar',
                    dataType: 'json',
                    type: 'POST',
                    async: false,
                    data: "{'Bölge_Müdürü': '{Urun_Adı_Liste:" + JSON.stringify(Urun_Adı_Liste) + "}'," +
                        "'Tıbbı_Mümmessil':'{Şehir_Liste:" + JSON.stringify(Şehir_Liste) + "}'," +
                        "'İlaç_Adı':'{Depo_Liste:" + JSON.stringify(Depo_Adı_Liste) + "}'," +
                        "'Bas_Tarih':'" + TextBox2.val() + "'," +
                        "'Bit_Tarih':'" + TextBox3.val() + "'" +
                        "}",
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {
                        Liste = [];
                        var temp = JSON.parse(data.d);
                        $('input[id=Toplam_Tutar]').val(temp[0].Toplam)


                    },// tekrar eklemeyi önlemek için eklenen doktorları tabloya kaydet sonra ona göre listele xd
                    error: function () {
                        alert('Talep esnasında sorun oluştu.Yeniden deneyin');
                    }
                });
                $.ajax({

                    url: 'İms-Raporlama.aspx/İms_Veri_Mf_Toplam',
                    dataType: 'json',
                    type: 'POST',
                    async: false,

                    data: "{'Bölge_Müdürü': '{Urun_Adı_Liste:" + JSON.stringify(Urun_Adı_Liste) + "}'," +
                        "'Tıbbı_Mümmessil':'{Şehir_Liste:" + JSON.stringify(Şehir_Liste) + "}'," +
                        "'İlaç_Adı':'{Depo_Liste:" + JSON.stringify(Depo_Adı_Liste) + "}'," +
                        "'Bas_Tarih':'" + TextBox2.val() + "'," +
                        "'Bit_Tarih':'" + TextBox3.val() + "'" +
                        "}",
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {
                        Liste = [];
                        var temp = JSON.parse(data.d);
                        $('input[id=Toplam_Mf_Adet]').val(temp[0].Toplam)


                    },// tekrar eklemeyi önlemek için eklenen doktorları tabloya kaydet sonra ona göre listele xd
                    error: function () {
                        alert('Talep esnasında sorun oluştu.Yeniden deneyin');
                    }
                });
                $.ajax({

                    url: 'İms-Raporlama.aspx/İms_Veri_Adet_Toplam',
                    dataType: 'json',
                    type: 'POST',
                    async: false,

                    data: "{'Bölge_Müdürü': '{Urun_Adı_Liste:" + JSON.stringify(Urun_Adı_Liste) + "}'," +
                        "'Tıbbı_Mümmessil':'{Şehir_Liste:" + JSON.stringify(Şehir_Liste) + "}'," +
                        "'İlaç_Adı':'{Depo_Liste:" + JSON.stringify(Depo_Adı_Liste) + "}'," +
                        "'Bas_Tarih':'" + TextBox2.val() + "'," +
                        "'Bit_Tarih':'" + TextBox3.val() + "'" +
                        "}",
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {
                        Liste = [];
                        var temp = JSON.parse(data.d);
                        $('input[id=Toplam_Adet]').val(temp[0].Toplam)
                     

                    },// tekrar eklemeyi önlemek için eklenen doktorları tabloya kaydet sonra ona göre listele xd
                    error: function () {
                        alert('Talep esnasında sorun oluştu.Yeniden deneyin');
                    }
                });
                $.ajax({

                    url: 'İms-Raporlama.aspx/İms_Veri_Getir',
                    dataType: 'json',
                    type: 'POST',
                    async: false,

                    data: "{'Bölge_Müdürü': '{Urun_Adı_Liste:" + JSON.stringify(Urun_Adı_Liste) + "}'," +
                        "'Tıbbı_Mümmessil':'{Şehir_Liste:" + JSON.stringify(Şehir_Liste) + "}'," +
                        "'İlaç_Adı':'{Depo_Liste:" + JSON.stringify(Depo_Adı_Liste) + "}'," +
                        "'Bas_Tarih':'" + TextBox2.val() + "'," +
                        "'Bit_Tarih':'" + TextBox3.val() + "'" +
                        "}",
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {
                        Liste = [];
                        var temp = JSON.parse(data.d);
                       
                        for (var i = 0; i < temp.length; i++) {
                            var MyClass = {
                                TM: null,
                                BM: null,
                                ÜRÜN: null,
                                Eczane_Adı: null,
                                Adet: null,
                                Mf_Adet: null,
                                Toplam: null,
                                Güncel_İsf: null,
                                Güncel_Dsf: null,
                                Güncel_Psf: null,
                                Toplam_İsf: null,
                                Tarih: null,
                            }
                            MyClass.TM = temp[i].TM;
                            MyClass.BM = temp[i].BM;
                            MyClass.ÜRÜN = temp[i].ÜRÜN;
                            MyClass.Eczane_Adı = temp[i].Eczane_Adı;
                            MyClass.Adet = temp[i].Adet;
                            MyClass.Mf_Adet = temp[i].Mf_Adet;
                            MyClass.Toplam = temp[i].Toplam;
                            MyClass.Güncel_İsf = temp[i].Güncel_İsf;
                            MyClass.Güncel_Dsf = temp[i].Güncel_Dsf;
                            MyClass.Güncel_Psf = temp[i].Güncel_Psf;
                            MyClass.Toplam_İsf = temp[i].Toplam_İsf;
                            MyClass.Tarih = temp[i].Tarih;

                            Liste.push(MyClass);
                        }
                        Listeyi_Doldur_Arama(Liste);

                    },// tekrar eklemeyi önlemek için eklenen doktorları tabloya kaydet sonra ona göre listele xd
                    error: function () {
                        alert('Talep esnasında sorun oluştu.Yeniden deneyin');
                    }
                });
            })





            var Liste_ = []
            Listeyi_Doldur_Arama(Liste_);
            function Listeyi_Doldur_Arama(Liste_) {

                $('#Tablo_Arama_Div').empty();

                $('#Tablo_Arama_Div').append('<table id="Arama_Table" class="display" style="width: 100%">' +
                    '<thead>' +
                    '<tr>' +
                    '                                            <th>Eczane Adı</th>' +
                    '                                            <th>TM</th>' +
                    '                                            <th>BM</th>' +
                    '                                            <th>ÜRÜN</th>' +
                    '                                            <th>Adet</th>' +
                    '                                            <th>Mf Adet</th>' +
                    '                                            <th>Toplam</th>' +
                    '                                            <th>Güncel İsf</th>' +
                    '                                            <th>Güncel Dsf</th>' +
                    '                                            <th>Güncel Psf</th>' +
                    '                                            <th>Toplam İsf</th>' +
                    '                                            <th>Tarih</th>' +
                    '</tr>' +
                    '</thead>' +
                    '<tbody id="Arama_Body">' +
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
                    var Tbody = $('tbody[id=Arama_Body]')

                    for (var i = 0; i < Liste_.length; i++) {

                        Tbody.append(
                            '<tr>' +
                            '<td>' + Liste_[i].Eczane_Adı + '</td>' +
                            '<td>' + Liste_[i].TM + '</td>' +
                            '<td>' + Liste_[i].BM + '</td>' +
                            '<td>' + Liste_[i].ÜRÜN + '</td>' +
                            '<td>' + Liste_[i].Adet + '</td>' +
                            '<td>' + Liste_[i].Mf_Adet + '</td>' +
                            '<td>' + Liste_[i].Toplam + '</td>' +
                            '<td>' + Liste_[i].Güncel_İsf + '</td>' +
                            '<td>' + Liste_[i].Güncel_Dsf + '</td>' +
                            '<td>' + Liste_[i].Güncel_Psf + '</td>' +
                            '<td>' + Liste_[i].Toplam_İsf + '</td>' +
                            '<td>' + Liste_[i].Tarih + '</td>' +


                            '</tr>'
                        )
                    }


                }



                $('#Arama_Table').dataTable({
                    "lengthMenu": [5, 25, 50, 75, 100, 200, 500, 750, 1000],
                    "language": {
                        "url": "//cdn.datatables.net/plug-ins/1.10.22/i18n/Turkish.json"
                    }
                });


            }





        })

    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="row">
        <div class="col-md-12">
            <div class="box">
                <div class="box-body">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <label>Filtrele</label>
                        </div>
                        <div class="panel-body">
                            <div class="row">
                                <div class="col-xs-4">
                                    <label>Bölge Müdürü :</label>
                                </div>
                                <div class="col-xs-4">
                                    <label>Tıbbi Mümessil :</label>
                                </div>
                                <div class="col-xs-4">
                                    <label>İlaç Adı:</label>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-xs-4">
                                    <select name="Bölge_Müdürü_Adı_Select2" class="js-example-placeholder-multiple js-states form-control" id="Bölge_Müdürü_Adı_Select2" multiple="multiple"></select>
                                </div>
                                <div class="col-xs-4">
                                    <select name="Tıbbi_Mümessil_Adı_Select2" class="js-example-placeholder-multiple js-states form-control" id="Tıbbi_Mümessil_Adı_Select2" multiple="multiple"></select>
                                </div>
                                <div class="col-xs-4">
                                    <select name="İlaç_Adı_Select2" class="js-example-placeholder-multiple js-states form-control" id="İlaç_Adı_Select2" multiple="multiple"></select>
                                </div>
                            </div>
                            <div class="row" style="padding-top: 25px">
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
                    <div class="row">
                        <div class="col-xs-12">
                            <div id="Tablo_Arama_Div"></div>
                        </div>
                    </div>
                    <div class="row" style="padding-top:25px">
                        <div class="col-xs-4">
                            <div class="form-group">
                                <label>Toplam Adet:</label>
                            </div>
                        </div>
                         <div class="col-xs-4">
                            <div class="form-group">
                                <label>Toplam Mf Adet:</label>
                            </div>
                        </div>
                           <div class="col-xs-4">
                            <div class="form-group">
                                <label>Toplam Tutar(Adet*İsf):</label>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-xs-4">
                            <div class="form-group">
                                <input id="Toplam_Adet" type="text" class="form-control" disabled />
                            </div>
                        </div>
                         <div class="col-xs-4">
                            <div class="form-group">
                                <input id="Toplam_Mf_Adet" type="text" class="form-control" disabled />
                            </div>
                        </div>
                         <div class="col-xs-4">
                            <div class="form-group">
                                <input id="Toplam_Tutar" type="text" class="form-control" disabled />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
