<%@ Page Title="" Language="C#" MasterPageFile="~/admin.Master" AutoEventWireup="true" CodeBehind="Unite-Bazlı-Sipariş-Raporu.aspx.cs" Inherits="deneme9.Unite_Bazlı_Sipariş_Raporu" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        $(document).ready(function () {
            var TextBox2 = $('input[id=Bas_Tar]')
            var TextBox3 = $('input[id=Bit_Tar]')

            var TextBox4 = $('input[id=Bas_Tar_Düzenlenmiş]')
            var TextBox5 = $('input[id=Bit_Tar_Düzenlenmiş]')

            var Eczane_Bazlı_Tablo = $('div[id=Eczane_Bazlı_Tablo]')
            var Liste = [];

            var İlaç_Bazlı_Liste = [];


            var Doktor_Liste_Il = $('select[id=Doktor_Liste_Il]');
            Doktor_Liste_Il.append("<option value='0'>Lütfen İl Seçiniz</option>");
            var Doktor_Liste_Brick = $('select[id=Doktor_Liste_Brick]');
            var Doktor_Liste_Untie = $('select[id=Doktor_Liste_Untie]');

            //#region

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

            var d = new Date(x.getFullYear(), 12, 0);
            TextBox5.attr('value', formatDate(d));
            var d = new Date(x.getFullYear(), 0, 1);
            TextBox4.attr('value', formatDate(d));

            $.ajax({
                url: 'ddldeneme.aspx/OrnekPost',
                dataType: 'json',
                type: 'POST',
                data: "{'parametre': '0-0'}",
                contentType: 'application/json; charset=utf-8',
                success: function (data) {


                    var b = 0;
                    while (data.d.split('!')[b] != null) {

                        Doktor_Liste_Il.append("<option value='" + data.d.split('!')[b].split("-")[0] + "'>" + data.d.split('!')[b].split("-")[1] + "</option>");
                        b++;

                    }

                },// tekrar eklemeyi önlemek için eklenen doktorları tabloya kaydet sonra ona göre listele xd
                error: function () {

                    alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                }
            });
            Doktor_Liste_Il.change(function () {
                $.ajax({
                    url: 'ddldeneme.aspx/OrnekPost',
                    dataType: 'json',
                    type: 'POST',
                    data: "{'parametre': '1-" + $(this).val() + "'}",
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {

                        Doktor_Liste_Brick.empty();
                        Doktor_Liste_Brick.append("<option value='0'>Lütfen Brick Seçiniz</option>");
                        var b = 0;
                        while (data.d.split('!')[b] != null) {
                            Doktor_Liste_Brick.append("<option value='" + data.d.split('!')[b].split("-")[0] + "'>" + data.d.split('!')[b].split("-")[1] + "</option>");
                            b++;
                        }

                        if (Doktor_Liste_Il.parent().children().find($("select option:first-child")).html() == "Lütfen İl Seçiniz") {
                            Doktor_Liste_Il.parent().children().find($("select option:first-child")).remove();
                        }
                    }
                });
            });
            Doktor_Liste_Brick.change(function () {

                $.ajax({
                    url: 'ddldeneme.aspx/OrnekPost',
                    dataType: 'json',
                    type: 'POST',
                    data: "{'parametre': '2-" + $(this).val() + "'}",
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {
                        Doktor_Liste_Untie.empty();
                        Doktor_Liste_Untie.append("<option value='0'>Lütfen Ünite Seçiniz</option>");
                        var b = 0;
                        while (data.d.split('!')[b] != null) {

                            Doktor_Liste_Untie.append("<option value='" + data.d.split('!')[b].split("-")[0] + "'>" + data.d.split('!')[b].split("-")[1] + "</option>");
                            b++;
                        }
                        if (Doktor_Liste_Brick.parent().children().find($("select option:first-child")).html() == "Lütfen Brick Seçiniz") {
                            Doktor_Liste_Brick.parent().children().find($("select option:first-child")).remove();
                        }
                    },
                    error: function () {

                        alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                    }
                });

            });//Doktor_Liste_Brans

            //#endregion

            var Ara = $('input[id=Ara]')
            Ara.click(function () {

                //#region Çevresindeki Eczaneler

                $.ajax({
                    url: 'Unite-Bazlı-Sipariş-Raporu.aspx/Unite_Cevresindeki_Eczaneler',
                    type: 'POST',
                    data: "{'Unite_Id': '" + Doktor_Liste_Untie.val() + "','Bas_Tar':'" + TextBox2.val() + "','Bit_Tar':'" + TextBox3.val() + "'}",
                    async: false,
                    dataType: "json",
                    contentType: "application/json; charset=utf-8",
                    success: function (data) {

                        Liste = [];
                        var temp = JSON.parse(data.d);
                        console.log(temp)
                        for (var i = 0; i < temp.length; i++) {
                            var MyClass = {
                                Eczane_Adı: null,
                                Brick: null,
                                Şehir: null,
                                Eczane_Adres: null,
                                Eczane_Telefon: null,
                                Adet: null,
                                Mf_Adet: null,
                                Toplam: null,

                            }
                            MyClass.Eczane_Adı = temp[i].Eczane_Adı;
                            MyClass.Brick = temp[i].TownName;
                            MyClass.Şehir = temp[i].CityName;
                            MyClass.Eczane_Adres = temp[i].Eczane_Adres;
                            MyClass.Eczane_Telefon = temp[i].Eczane_Telefon;
                            MyClass.Adet = temp[i].Adet;
                            MyClass.Mf_Adet = temp[i].Mf_Adet;
                            MyClass.Toplam = temp[i].Toplam;

                            Liste.push(MyClass);
                        }

                        Çevresindeki_Eczaneler_Tablo_Doldur(Liste)



                    },// tekrar eklemeyi önlemek için eklenen doktorları tabloya kaydet sonra ona göre listele xd
                    error: function () {

                        alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                    }
                });

                //#endregion

                //#region İlaç Bazlı

                $.ajax({
                    url: 'Unite-Bazlı-Sipariş-Raporu.aspx/Ünite_Çevresi_Eczaneler_İlaç_Bazlı',
                    type: 'POST',
                    data: "{'Unite_Id': '" + Doktor_Liste_Untie.val() + "','Bas_Tar':'" + TextBox2.val() + "','Bit_Tar':'" + TextBox3.val() + "'}",
                    async: false,
                    dataType: "json",
                    contentType: "application/json; charset=utf-8",
                    success: function (data) {

                        İlaç_Bazlı_Liste = [];
                        var temp = JSON.parse(data.d);
                        console.log(temp)
                        for (var i = 0; i < temp.length; i++) {
                            var MyClass = {
                                İlaç_Ad: null,
                                Adet: null,
                                Mf_Adet: null,
                                Toplam: null,
                                Guncel_DSF: null,
                                Birim_Fiyat: null,
                                Satış_Fiyatı_Toplam: null,
                                Birim_Fiyatı_Toplam: null,
                            }
                            MyClass.İlaç_Ad = temp[i].Urun_Adı;
                            MyClass.Adet = temp[i].Adet;
                            MyClass.Mf_Adet = temp[i].Mf_Adet;
                            MyClass.Toplam = temp[i].Toplam;
                            MyClass.Guncel_DSF = temp[i].Güncel_Dsf;
                            MyClass.Birim_Fiyat = temp[i].Birim_Fiyat;
                            MyClass.Satış_Fiyatı_Toplam = temp[i].Satış_Fiyatı_Toplam;
                            MyClass.Birim_Fiyatı_Toplam = temp[i].Birim_Fiyatı_Toplam;
                            İlaç_Bazlı_Liste.push(MyClass);
                        }

                        Çevresindeki_İlaç_Bazlı_Tablo_Doldur(İlaç_Bazlı_Liste)



                    },// tekrar eklemeyi önlemek için eklenen doktorları tabloya kaydet sonra ona göre listele xd
                    error: function () {

                        alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                    }
                });


                //#endregion


                //#region Eczane Bazlı



                //#endregion


            });



            //#region ilaç Bazlı

            Çevresindeki_İlaç_Bazlı_Tablo_Doldur(İlaç_Bazlı_Liste);
            function Çevresindeki_İlaç_Bazlı_Tablo_Doldur(Liste_) {
                $('#Çevresindeki_İlaç_Bazlı_Tablo_Div').empty();

                $('#Çevresindeki_İlaç_Bazlı_Tablo_Div').append('<table id="example_İlaç_Bazlı" class="display" style="width: 100%">' +
                    '<thead>' +
                    '<tr>' +
                    '<th>İlaç Adı</th>' +
                    '<th>Adet</th>' +
                    '<th>Mf Adet</th>' +
                    '<th>Toplam</th>' +
                    '<th>Güncel DSF </th>' +
                    '<th>Birim Fiyat</th>' +
                    '<th>Satış Fiyatı Toplam</th>' +
                    '<th>Birim Fiyatı Toplam</th>' +
                    '</tr>' +
                    '</thead>' +
                    '<tbody id="Tbody_İlaç_Bazlı">' +
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
                    '</tr>' +
                    '</tfoot>' +
                    '</table>'
                );


                if (Liste_.length > 0) {

                    var Tbody = $('tbody[id=Tbody_İlaç_Bazlı]')


                    for (var i = 0; i < Liste_.length; i++) {
                        Tbody.append(
                            '<tr><td>' + Liste_[i].İlaç_Ad + '</td>' +
                            '<td>' + Liste_[i].Adet + '</td>' +
                            '<td>' + Liste_[i].Mf_Adet + '</td>' +
                            '<td>' + Liste_[i].Toplam + '</td>' +
                            '<td>' + Liste_[i].Guncel_DSF.replace(',', '.') + '</td>' +
                            '<td>' + Liste_[i].Birim_Fiyat.replace(',', '.') + '</td>' +
                            '<td>' + Liste_[i].Satış_Fiyatı_Toplam.replace(',', '.') + '</td>' +
                            '<td>' + Liste_[i].Birim_Fiyatı_Toplam.replace(',', '.') + '</td>' +



                            '</tr>'
                        )
                    }


                }





                var Kullanıcı_Adı;
                $.ajax({
                    url: 'Siparis-Olustur.aspx/Kullanıcı_Adı_Soyadı',
                    type: 'POST',
                    data: "{'parametre': ''}",
                    async: false,
                    dataType: "json",
                    global: false,
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

                $('#example_İlaç_Bazlı').dataTable({

                    "lengthMenu": [10, 25, 50, 75, 100, 200, 500, 750, 1000],
                    "language": {
                        "url": "//cdn.datatables.net/plug-ins/1.10.22/i18n/Turkish.json"
                    },


                    "scrollX": true,
                    "footerCallback": function (row, data, start, end, display) {
                        var api = this.api(), data;

                        // Remove the formatting to get integer data for summation
                        var intVal = function (i) {
                            return typeof i === 'string' ?
                                i.replace(/[\$,]/g, '') * 1 :
                                typeof i === 'number' ?
                                    i : 0;
                        };

                        // Total over all pages
                        total = api
                            .column(3)
                            .data()
                            .reduce(function (a, b) {
                                return intVal(a) + intVal(b);
                            }, 0);

                        // Total over this page
                        pageTotal = api
                            .column(3, { page: 'current' })
                            .data()
                            .reduce(function (a, b) {
                                return intVal(a) + intVal(b);
                            }, 0);

                        // Update footer
                        $(api.column(3).footer()).html(
                            "" + pageTotal.toLocaleString("tr") + " Adet"
                        );

                        // Total over all pages

                        total = api
                            .column(6)
                            .data()
                            .reduce(function (a, b) {
                                return intVal(a) + intVal(b);
                            }, 0);

                        // Total over this page
                        pageTotal = api
                            .column(6, { page: 'current' })
                            .data()
                            .reduce(function (a, b) {
                                return intVal(a) + intVal(b);
                            }, 0);

                        // Update footer
                        $(api.column(6).footer()).html(
                            "" + pageTotal.toLocaleString("tr") + "₺"
                        );

                        // Total over all pages

                        total = api
                            .column(7)
                            .data()
                            .reduce(function (a, b) {
                                return intVal(a) + intVal(b);
                            }, 0);

                        // Total over this page
                        pageTotal = api
                            .column(7, { page: 'current' })
                            .data()
                            .reduce(function (a, b) {
                                return intVal(a) + intVal(b);
                            }, 0);

                        // Update footer
                        $(api.column(7).footer()).html(
                            "" + pageTotal.toLocaleString("tr") + "₺"
                        );

                    }






                });
                var Siparişi_Kaldır = $('a[id=Siparişi_Kaldır]')
                Siparişi_Kaldır.click(function () {
                    const array = Liste_

                    array.splice($(this).attr("value"), 1);

                    Tabloyu_Doldur(array)
                })

            }
            //#endregion



            //#region Ziyaret_Edilen_Uniteler_Tablo_Doldur
            var Ziyaret_Edilen_Unite_Liste = [];
            $.ajax({
                url: 'Unite-Bazlı-Sipariş-Raporu.aspx/Ziyaret_Edilen_Üniteler',
                type: 'POST',
                async: false,
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                success: function (data) {

                    Ziyaret_Edilen_Unite_Liste = [];
                    var temp = JSON.parse(data.d);
                  
                    for (var i = 0; i < temp.length; i++) {
                        var MyClass = {
                            Unite_Text: null,
                            Unite_Id: null,
                          
                        }
                        MyClass.Unite_Text = temp[i].Unite_Text;
                        MyClass.Unite_Id = temp[i].Unite_Id;
                   

                        Ziyaret_Edilen_Unite_Liste.push(MyClass);
                    }

                    Ziyaret_Edilen_Uniteler_Tablo_Doldur(Ziyaret_Edilen_Unite_Liste)



                },// tekrar eklemeyi önlemek için eklenen doktorları tabloya kaydet sonra ona göre listele xd
                error: function () {

                    alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                }
            });

            Ziyaret_Edilen_Uniteler_Tablo_Doldur(Ziyaret_Edilen_Unite_Liste)
            function Ziyaret_Edilen_Uniteler_Tablo_Doldur(Liste_) {
                $('#Ziyaret_Edilen_Uniteler').empty();

                $('#Ziyaret_Edilen_Uniteler').append('<table id="example_Ziyaret_Edilen" class="display" style="width: 100%">' +
                    '<thead>' +
                    '<tr>' +
                    '<th>Ünite Adı</th>' +
                    '<th>Ara</th>' +
                    '</tr>' +
                    '</thead>' +
                    '<tbody id="Tbody_Ziyaret_Edilen">' +
                    '</tbody>' +
                    '<tfoot>' +
                    ' <tr>' +
                    '<th></th>' +
                    '<th></th>' +
                    '</tr>' +
                    '</tfoot>' +
                    '</table>'
                );


                if (Liste_.length > 0) {
                    var Tbody = $('tbody[id=Tbody_Ziyaret_Edilen]')



                    for (var i = 0; i < Liste_.length; i++) {

                        Tbody.append(
                            '<tr>' +
                            '<td>' + Liste_[i].Unite_Text + '</td>' +
                            '<td><a style="font-size: 20px; " id="Ünite_Ara" value="' + Liste_[i].Unite_Id + '"><i class="fa fa-search"></i></a></td>' +
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

                $('#example_Ziyaret_Edilen').dataTable({

                    "lengthMenu": [3,10, 25, 50, 75, 100, 200, 500, 750, 1000],
                    "language": {
                        "url": "//cdn.datatables.net/plug-ins/1.10.22/i18n/Turkish.json"
                    },

                });
                var Ünite_Ara = $('a[id=Ünite_Ara]')
                Ünite_Ara.click(function () {
                    
                    //#region Çevresindeki Eczaneler

                    $.ajax({
                        url: 'Unite-Bazlı-Sipariş-Raporu.aspx/Unite_Cevresindeki_Eczaneler',
                        type: 'POST',
                        data: "{'Unite_Id': '" + $(this).attr('value') + "','Bas_Tar':'" + TextBox4.val() + "','Bit_Tar':'" + TextBox5.val() + "'}",
                        async: false,
                        dataType: "json",
                        contentType: "application/json; charset=utf-8",
                        success: function (data) {

                            Liste = [];
                            var temp = JSON.parse(data.d);
                 
                            for (var i = 0; i < temp.length; i++) {
                                var MyClass = {
                                    Eczane_Adı: null,
                                    Brick: null,
                                    Şehir: null,
                                    Eczane_Adres: null,
                                    Eczane_Telefon: null,
                                    Adet: null,
                                    Mf_Adet: null,
                                    Toplam: null,

                                }
                                MyClass.Eczane_Adı = temp[i].Eczane_Adı;
                                MyClass.Brick = temp[i].TownName;
                                MyClass.Şehir = temp[i].CityName;
                                MyClass.Eczane_Adres = temp[i].Eczane_Adres;
                                MyClass.Eczane_Telefon = temp[i].Eczane_Telefon;
                                MyClass.Adet = temp[i].Adet;
                                MyClass.Mf_Adet = temp[i].Mf_Adet;
                                MyClass.Toplam = temp[i].Toplam;

                                Liste.push(MyClass);
                            }

                            Çevresindeki_Eczaneler_Tablo_Doldur(Liste)



                        },// tekrar eklemeyi önlemek için eklenen doktorları tabloya kaydet sonra ona göre listele xd
                        error: function () {

                            alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                        }
                    });

                    //#endregion

                    //#region İlaç Bazlı

                    $.ajax({
                        url: 'Unite-Bazlı-Sipariş-Raporu.aspx/Ünite_Çevresi_Eczaneler_İlaç_Bazlı',
                        type: 'POST',
                        data: "{'Unite_Id': '" + $(this).attr('value') + "','Bas_Tar':'" + TextBox4.val() + "','Bit_Tar':'" + TextBox5.val() + "'}",
                        async: false,
                        dataType: "json",
                        contentType: "application/json; charset=utf-8",
                        success: function (data) {

                            İlaç_Bazlı_Liste = [];
                            var temp = JSON.parse(data.d);
                       
                            for (var i = 0; i < temp.length; i++) {
                                var MyClass = {
                                    İlaç_Ad: null,
                                    Adet: null,
                                    Mf_Adet: null,
                                    Toplam: null,
                                    Guncel_DSF: null,
                                    Birim_Fiyat: null,
                                    Satış_Fiyatı_Toplam: null,
                                    Birim_Fiyatı_Toplam: null,
                                }
                                MyClass.İlaç_Ad = temp[i].Urun_Adı;
                                MyClass.Adet = temp[i].Adet;
                                MyClass.Mf_Adet = temp[i].Mf_Adet;
                                MyClass.Toplam = temp[i].Toplam;
                                MyClass.Guncel_DSF = temp[i].Güncel_Dsf;
                                MyClass.Birim_Fiyat = temp[i].Birim_Fiyat;
                                MyClass.Satış_Fiyatı_Toplam = temp[i].Satış_Fiyatı_Toplam;
                                MyClass.Birim_Fiyatı_Toplam = temp[i].Birim_Fiyatı_Toplam;
                                İlaç_Bazlı_Liste.push(MyClass);
                            }

                            Çevresindeki_İlaç_Bazlı_Tablo_Doldur(İlaç_Bazlı_Liste)



                        },// tekrar eklemeyi önlemek için eklenen doktorları tabloya kaydet sonra ona göre listele xd
                        error: function () {

                            alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                        }
                    });
                })

            };
            //#endregion


            //#region Çevresindeki Eczaneler Tablo 
            Çevresindeki_Eczaneler_Tablo_Doldur(Liste)
            function Çevresindeki_Eczaneler_Tablo_Doldur(Liste_) {
                $('#Çevresindeki_Eczaneler_Tablo_Div').empty();

                $('#Çevresindeki_Eczaneler_Tablo_Div').append('<table id="example_incele" class="display" style="width: 100%">' +
                    '<thead>' +
                    '<tr>' +
                    '<th>Eczane</th>' +
                    '<th>Brick</th>' +
                    '<th>Şehir</th>' +
                    '<th>Adres</th>' +
                    '<th>Telefon</th>' +
                    '<th>Adet</th>' +
                    '<th>Mf Adet</th>' +
                    '<th>Toplam</th>' +

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
                            '<td>' + Liste_[i].Eczane_Adı + '</td>' +
                            '<td>' + Liste_[i].Brick + '</td>' +
                            '<td>' + Liste_[i].Şehir + '</td>' +
                            '<td>' + Liste_[i].Eczane_Adres + '</td>' +
                            '<td>' + Liste_[i].Eczane_Telefon + '</td>' +
                            '<td>' + Liste_[i].Adet + '</td>' +
                            '<td>' + Liste_[i].Mf_Adet + '</td>' +
                            '<td>' + Liste_[i].Toplam + '</td>' +
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
                    <div class="row">
                        <div class="col-xs-6">
                            <div class="panel  panel-default">
                                <div class="panel-body">
                                    <div class="row">
                                        <div class="col-xs-12">
                                            <label>Lütfen İL Seçiniz</label>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-xs-12">
                                            <div class="form-group">
                                                <select name="Select" id="Doktor_Liste_Il" class="form-control"></select>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-xs-12">
                                            <label>Lütfen Brick Seçiniz</label>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-xs-12">
                                            <div class="form-group">
                                                <select name="Select" id="Doktor_Liste_Brick" class="form-control"></select>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-xs-12">
                                            <label>Lütfen Ünite Seçiniz</label>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-xs-12">
                                            <div class="form-group">
                                                <select name="Select" id="Doktor_Liste_Untie" class="form-control"></select>
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
                                    <div class="row">
                                        <div class="col-xs-12">
                                            <div class="form-group">
                                                <input id="Ara" type="button" class="btn btn-block btn-info" value="Ara" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-xs-6">
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <label>Ziyaret Düzenlenmiş Üniteler</label>
                                </div>
                                <div class="panel-body">
                                    <div class="row">
                                        <div class="col-xs-6">
                                            <div class="form-group">
                                                <input id="Bas_Tar_Düzenlenmiş" type="date" class="form-control" placeholder="Max Adet" />
                                            </div>
                                        </div>
                                        <div class="col-xs-6">
                                            <div class="form-group">
                                                <input id="Bit_Tar_Düzenlenmiş" type="date" class="form-control" placeholder="Max Adet" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-xs-12">
                                            <div id="Ziyaret_Edilen_Uniteler"></div>

                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-xs-12">
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <label>İlaç Bazlı.</label>
                                </div>
                                <div class="panel-body">
                                    <div id="Çevresindeki_İlaç_Bazlı_Tablo_Div"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <label>Eczane Bazlı.</label>
                        </div>
                        <div class="panel-body">
                            <div id="Çevresindeki_Eczaneler_Tablo_Div"></div>
                        </div>
                    </div>


                </div>
            </div>
        </div>
    </div>
</asp:Content>
