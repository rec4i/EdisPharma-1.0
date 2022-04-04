<%@ Page Title="" Language="C#" MasterPageFile="~/admin.Master" AutoEventWireup="true" CodeBehind="Sipariş_Rapor.aspx.cs" Inherits="deneme9.Sipariş_Rapor" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
    <script type="text/javascript">




        $(document).ready(function () {


            var TextBox2 = $('input[id*=TextBox2]')
            var TextBox3 = $('input[id*=TextBox3]')

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

            var d = new Date(x.getFullYear(), x.getMonth() + 1, 0);
            TextBox3.attr('value', formatDate(d));
            var d = new Date(x.getFullYear(), x.getMonth(), 1);
            TextBox2.attr('value', formatDate(d));

            var Tsm_Ad = $('select[id=Tsm_Ad]')


            $.ajax({
                url: 'Sipariş_Rapor.aspx/Kullanıcı_Listesi',
                type: 'POST',
                data: "{'Şehir_Id': ''}",
                async: false,
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                success: function (data) {

                    var parsdata = JSON.parse(data.d)

                    Tsm_Ad.empty();
                    Tsm_Ad.append('<option value="0">Lütfen TSM Seçiniz</option>')
                    for (var i = 0; i < parsdata.length; i++) {
                        Tsm_Ad.append('<option value="' + parsdata[i].Kullanıcı_ID + '">' + parsdata[i].Ad + ' ' + parsdata[i].Soyad + '</option>')
                    }


                },// tekrar eklemeyi önlemek için eklenen doktorları tabloya kaydet sonra ona göre listele xd
                error: function () {
                    //alert('Talep esnasında sorun oluştu.Yeniden deneyin');
                }
            });

            if (window.location.href.split('&').length > 1) {

                var Gün_Div = $('div[id=Gün_Div]')
                Gün_Div.attr('style', "visibility:visible")
                Tsm_Ad.val(window.location.href.split('&')[2].split('=')[1])
                TextBox2.val(window.location.href.split('&')[0].split('=')[1])
                TextBox3.val(window.location.href.split('&')[1].split('=')[1])
            }

            else {
                var Gün_Div = $('div[id=Gün_Div]')
                Gün_Div.attr('style', "visibility:hidden")
            }



            $("select[name=Sipariş_Durumu_Selec2]").select2({
                placeholder: "Lütfen Sipariş Durumu Seçiniz",
                "language": {
                    "noResults": function () {
                        return "Sonuç Bulunamadı";
                    }
                },
                ajax: {
                    url: "Tsm-Sipariş-Raporu.aspx/Sipariş_Durumu_Getir",
                    dataType: 'json',
                    type: 'POST',
                    delay: 250,
                    global: false,
                    contentType: "application/json; charset=utf-8",
                    data: function (params) {
                        return '{"Harf":"' + params.term + '"}'
                    },
                    processResults: function (data, params) {

                        return {
                            results: $.map(JSON.parse(data.d), function (item) {

                                return {
                                    text: item.LastName,
                                    id: item.Id
                                }
                            })
                        };
                    },
                    cache: true
                },
                minimumInputLength: 2


            })


            $("select[name=Ürün_adı_Selec2]").select2({
                placeholder: "Lütfen Ürün Seçiniz",
                "language": {
                    "noResults": function () {
                        return "Sonuç Bulunamadı";
                    }
                },
                ajax: {
                    url: "Tsm-Sipariş-Raporu.aspx/Ürün_adı_Seç",
                    dataType: 'json',
                    type: 'POST',
                    delay: 250,
                    global: false,
                    contentType: "application/json; charset=utf-8",
                    data: function (params) {
                        return '{"Harf":"' + params.term + '"}'
                    },
                    processResults: function (data, params) {
                        return {
                            results: $.map(JSON.parse(data.d), function (item) {

                                return {
                                    text: item.LastName,
                                    id: item.Id
                                }
                            })
                        };
                    },
                    cache: true
                },
                minimumInputLength: 2
            })


            Tsm_Ad.change(function () {//Dktr_Brans.parent().children().find($("select option:first-child"))
                if (Tsm_Ad.parent().children().find($("select option:first-child")).val() == "0") {
                    Tsm_Ad.parent().children().find($("select option:first-child")).remove();
                }

            })


            function Urun_Adı_getir() {

                var Urun_Adı_Select2 = $('select[id=Urun_Adı_Select2]')
                var Urun_Adı_Liste = [];
                var data = Urun_Adı_Select2.select2('data');
                if (data.length > 0) {
                    for (var i = 0; i < data.length; i++) {
                        var Urun_Adı_Class = {
                            Semt: null
                        }
                        Urun_Adı_Class.Semt = data[i].id;
                        Urun_Adı_Liste.push(Urun_Adı_Class)
                    }
                }
                else {
                    var Urun_Adı_Class = {
                        Semt: null
                    }
                    Urun_Adı_Class.Semt = null;
                    Urun_Adı_Liste.push(Urun_Adı_Class)
                }
                return Urun_Adı_Liste;
            }

            function Durum__getir() {

                var Urun_Adı_Select2 = $('select[id=Sipariş_Durumu_Selec2]')
                var Urun_Adı_Liste = [];
                var data = Urun_Adı_Select2.select2('data');
                if (data.length > 0) {
                    for (var i = 0; i < data.length; i++) {
                        var Urun_Adı_Class = {
                            Şehir_: null
                        }
                        Urun_Adı_Class.Şehir_ = data[i].id;
                        Urun_Adı_Liste.push(Urun_Adı_Class)
                    }
                }
                else {
                    var Urun_Adı_Class = {
                        Şehir_: null
                    }
                    Urun_Adı_Class.Şehir_ = null;
                    Urun_Adı_Liste.push(Urun_Adı_Class)
                }
                return Urun_Adı_Liste;
            }


            var cal_set = $('input[id=cal_set]')
            cal_set.on('click', function () {



                if (Tsm_Ad.find('option:selected').val() != 0) {
                    window.location.href = "Sipariş_Rapor.aspx?x=" + TextBox2.val() + "&y=" + TextBox3.val() + "&z=" + Tsm_Ad.find('option:selected').val() +
                        "&u=" + JSON.stringify(Urun_Adı_getir()) + "&d=" + JSON.stringify(Durum__getir())
                }
                else {
                    alert("lütfen tsm seçiniz")
                }


            });

            var Bas_Gun = TextBox2.val();
            var Son_Gun = TextBox3.val();
            var Kullanıcı = ""

            function Kullanıcı_Adı_Düzelt() {
                var temp = decodeURI(window.location.href).split('&')
                console.log(temp)
                if (temp.length > 1) {
                    return JSON.parse(temp[2].split('=')[1]);

                }
                else {
                    return 0;
                }

            }


            var Kullanıcı_Ad = Tsm_Ad.find('option:selected').html()


            var _Durum_listesi = "";


            function _ürün_listesi_getir() {
                var temp = decodeURI(window.location.href).split('&')
                console.log(temp)
                if (temp.length > 1) {
                    return JSON.parse(temp[3].split('=')[1]);

                }
                else {
                    return '{"Urun_Adı":null}';
                }
            }

            function _Durum_Getir() {
                var temp = decodeURI(window.location.href).split('&')
                console.log(temp)
                if (temp.length > 1) {
                    return JSON.parse(temp[4].split('=')[1]);

                }
                else {
                    return '{"Urun_Adı":null}';
                }

            }


            console.log(_Durum_listesi)
            var parsdata;
            $.ajax({
                url: 'Tsm-Sipariş-Raporu.aspx/Tabloları_Doldur',
                dataType: 'json',
                type: 'POST',
                async: false,

                data: "{'parametre': '" + TextBox2.val() + "*" + TextBox3.val() + "*" + Kullanıcı_Adı_Düzelt() + "'," +
                    "'İletim_Durum':'{İletim_Durum__:" + JSON.stringify(_Durum_Getir()) + "}'," +
                    "'Ürün_Listesi':'{Ürün_Listesi__:" + JSON.stringify(_ürün_listesi_getir()) + "}'" +
                    //"'Branş':'{Depo_Liste:" + JSON.stringify(Depo_Adı_Liste) + "}'" +
                    "}",
                //data: "{" +
                //    "'parametre': '" + TextBox2.val() + "*" + TextBox3.val() + "*" + Kullanıcı_Adı_Düzelt() + "'," +
                //    "'İletim_Durum':'{İletim_Durum__:" + JSON.stringify(_Durum_Getir()) + "}'," +
                //    "'Ürün_Listesi':'{'Şehir_Liste':" + JSON.stringify(_ürün_listesi_getir()) + "}'" +
                //    "}",
                contentType: 'application/json; charset=utf-8',
                success: function (data) {
                    var temp = JSON.parse(data.d)

                    console.log(temp)

                    if (temp.length > 0) {
                        for (var i = 0; i < temp.length; i++) {
                            var Onay_Label = '';
                            if (temp[i][0].İletim_Durum == 1) {
                                Onay_Label = '<span class="label label-info">Depoya İletildi</span>'
                            }
                            if (temp[i][0].İletim_Durum == 2) {
                                Onay_Label = '<span class="label label-success">Depo Onayladı</span>'
                            }
                            if (temp[i][0].İletim_Durum == 3) {
                                Onay_Label = '<span class="label label-warning">Sevkiyatta</span>'
                            }
                            if (temp[i][0].İletim_Durum == 4) {
                                Onay_Label = '<span class="label label-success">Eczaneye Ulaştı</span>'
                            }
                            if (temp[i][0].İletim_Durum == 5) {
                                Onay_Label = '<span class="label label-danger">Eczane Onaylamadı</span>'
                            }
                            if (temp[i][0].İletim_Durum == 6) {
                                Onay_Label = '<span class="label label-warning">Güncelleme Bekleniyor</span>'
                            }
                            if (temp[i][0].İletim_Durum == 7) {
                                Onay_Label = '<span class="label label-danger">Sipariş İptal Edildi</span>'
                            }


                            var Doktor_Div = $('div[id = Sipariş_Div_' + temp[i][0].Ziy_Tar + ']');


                            Doktor_Div.append('<table class="table table-striped"><thead><tr><td>' + temp[i][0].Eczane_Adı + '</td><td>' + temp[i][0].TownName + '</td><td>' + temp[i][0].CityName + '</td><td>' + Onay_Label + '</td><td>' + temp[i][0].Ziy_Tar + '</td><tr></thead></table>')
                            Doktor_Div.append(' <div class="box">')
                            var myvar =
                                '<table class="table table-hover" >' +
                                '                                            <thead>' +
                                '                                                <tr>' +
                                '                                                    <th>Urun Adı</th>' +
                                '                                                    <th>Adet</th>' +
                                '                                                    <th>Mf Adet</th>' +
                                '                                                    <th>Toplam</th>' +
                                '                                                    <th style="text-align: right;" >Birim Fiyat</th>' +
                                '                                                    <th style="text-align: right;">Birim Fiyat Toplam</th>' +
                                '                                                    <th style="text-align: right;">Güncel Dsf</th>' +
                                '                                                    <th style="text-align: right;">Güncel İsf</th>' +
                                '                                                    <th style="text-align: right;">ADET * İSF</th>' +
                                '                                                </tr>' +
                                '                                            </thead>' +
                                '                                            <tbody>';


                            for (var j = 0; j < temp[i].length; j++) {


                                myvar +=
                                    '<tr>' +
                                    '<td>' +
                                    temp[i][j].Urun_Adı +
                                    '</td>' +
                                    '<td>' +
                                    temp[i][j].Adet +
                                    '</td>' +
                                    '<td>' +
                                    temp[i][j].Mf_Adet +
                                    '</td>' +
                                    '<td>' +
                                    temp[i][j].Toplam_Adet +
                                    '</td>' +
                                    '<td style="text-align: right;">' +
                                    temp[i][j].Birim_Fiyat +
                                    '</td>' +
                                    '<td style="text-align: right;">' +
                                    temp[i][j].Birim_Fiyat_Toplam +
                                    '</td >' +
                                    '<td style="text-align: right;">' +
                                    temp[i][j].Guncel_DSF +
                                    '</td>' +
                                    '<td style="text-align: right;">' +
                                    temp[i][j].Guncel_ISF +
                                    '</td>' +
                                    '<td style="text-align: right;">' +
                                    temp[i][j].Adet_İSF +
                                    '</td>' +
                                    '</tr>';


                            }
                            Doktor_Div.append(myvar + '</tbody>' +
                                '<tfoot>' +
                                '<tr>' +
                                '<td>' +
                                '</td>' +
                                '<td>' +
                                '</td>' +
                                '<td>' +
                                '</td>' +
                                '<td>' +
                                '</td>' +
                                '<td>' +
                                '</td>' +
                                '<td style="text-align: right;">Toplam: ' +
                                temp[i][0].Genel_Birim_Fiyat_Toplam +
                                '</td style="text-align: right;">' +
                                '<td>' +
                                '</td>' +
                                '<td>' +
                                '</td>' +

                                '<td style="text-align: right;">Toplam: ' +
                                temp[i][0].Toplam_Adet_İSF +
                                '</td style="text-align: right;">' +

                                '<td>' +

                                '</tfootd>' +

                                '</table>')
                            Doktor_Div.append('</div></br></br>')




                        }
                    }



                },
                error: function () {

                    // alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                }
            });

            $.ajax({
                url: 'Tsm-Sipariş-Raporu.aspx/Günlük_Satış_Verisi',
                dataType: 'json',
                type: 'POST',
                async: false,
                data: "{'parametre': '" + TextBox2.val() + "*" + TextBox3.val() + "*" + Kullanıcı_Adı_Düzelt() + "'," +
                    "'İletim_Durum':'{İletim_Durum__:" + JSON.stringify(_Durum_Getir()) + "}'," +
                    "'Ürün_Listesi':'{Ürün_Listesi__:" + JSON.stringify(_ürün_listesi_getir()) + "}'" +
                    //"'Branş':'{Depo_Liste:" + JSON.stringify(Depo_Adı_Liste) + "}'" +
                    "}",
                contentType: 'application/json; charset=utf-8',
                success: function (data) {
                    var temp = JSON.parse(data.d)

                    console.log(temp)

                    if (temp.length > 0) {
                        for (var i = 0; i < temp.length; i++) {

                            var Doktor_Div = $('span[id = Sipariş_Toplam_Div_' + temp[i].Ziy_Tar + ']');

                            Doktor_Div.html('Toplam : ' + temp[i].Tutar + '₺')
                        }
                    }
                },
                error: function () {
                    // alert('Talep esnasında sorun oluştu.Yeniden deneyin');
                }
            });

            $.ajax({
                url: 'Tsm-Sipariş-Raporu.aspx/Günlük_Satış_Verisi_Toplam',
                dataType: 'json',
                type: 'POST',
                async: false,
                data: "{'parametre': '" + TextBox2.val() + "*" + TextBox3.val() + "*" + Kullanıcı_Adı_Düzelt() + "'," +
                    "'İletim_Durum':'{İletim_Durum__:" + JSON.stringify(_Durum_Getir()) + "}'," +
                    "'Ürün_Listesi':'{Ürün_Listesi__:" + JSON.stringify(_ürün_listesi_getir()) + "}'" +
                    //"'Branş':'{Depo_Liste:" + JSON.stringify(Depo_Adı_Liste) + "}'" +
                    "}",
                contentType: 'application/json; charset=utf-8',
                success: function (data) {
                    var temp = JSON.parse(data.d)

                    console.log(temp)

                    if (temp.length > 0) {
                        for (var i = 0; i < temp.length; i++) {

                            $('input[id=Genel_Toplam_Adet_İsf]').val('Toplam : ' + temp[i].Tutar + '₺')
                        }
                    }
                },

            });


            var Seçili_Günleri_Yazdı = $('input[id=Seçili_Günleri_Yazdı]')
            var Hepsini_Yazdır = $('input[id=Hepsini_Yazdır]')
            Hepsini_Yazdır.click(function () {
                var veri = Seçili_Günleri_Yazdı.val();

                var logo = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAL4AAAChCAYAAAB59AXTAAAACXBIWXMAAC4jAAAuIwF4pT92AAAKT2lDQ1BQaG90b3Nob3AgSUNDIHByb2ZpbGUAAHjanVNnVFPpFj333vRCS4iAlEtvUhUIIFJCi4AUkSYqIQkQSoghodkVUcERRUUEG8igiAOOjoCMFVEsDIoK2AfkIaKOg6OIisr74Xuja9a89+bN/rXXPues852zzwfACAyWSDNRNYAMqUIeEeCDx8TG4eQuQIEKJHAAEAizZCFz/SMBAPh+PDwrIsAHvgABeNMLCADATZvAMByH/w/qQplcAYCEAcB0kThLCIAUAEB6jkKmAEBGAYCdmCZTAKAEAGDLY2LjAFAtAGAnf+bTAICd+Jl7AQBblCEVAaCRACATZYhEAGg7AKzPVopFAFgwABRmS8Q5ANgtADBJV2ZIALC3AMDOEAuyAAgMADBRiIUpAAR7AGDIIyN4AISZABRG8lc88SuuEOcqAAB4mbI8uSQ5RYFbCC1xB1dXLh4ozkkXKxQ2YQJhmkAuwnmZGTKBNA/g88wAAKCRFRHgg/P9eM4Ors7ONo62Dl8t6r8G/yJiYuP+5c+rcEAAAOF0ftH+LC+zGoA7BoBt/qIl7gRoXgugdfeLZrIPQLUAoOnaV/Nw+H48PEWhkLnZ2eXk5NhKxEJbYcpXff5nwl/AV/1s+X48/Pf14L7iJIEyXYFHBPjgwsz0TKUcz5IJhGLc5o9H/LcL//wd0yLESWK5WCoU41EScY5EmozzMqUiiUKSKcUl0v9k4t8s+wM+3zUAsGo+AXuRLahdYwP2SycQWHTA4vcAAPK7b8HUKAgDgGiD4c93/+8//UegJQCAZkmScQAAXkQkLlTKsz/HCAAARKCBKrBBG/TBGCzABhzBBdzBC/xgNoRCJMTCQhBCCmSAHHJgKayCQiiGzbAdKmAv1EAdNMBRaIaTcA4uwlW4Dj1wD/phCJ7BKLyBCQRByAgTYSHaiAFiilgjjggXmYX4IcFIBBKLJCDJiBRRIkuRNUgxUopUIFVIHfI9cgI5h1xGupE7yAAygvyGvEcxlIGyUT3UDLVDuag3GoRGogvQZHQxmo8WoJvQcrQaPYw2oefQq2gP2o8+Q8cwwOgYBzPEbDAuxsNCsTgsCZNjy7EirAyrxhqwVqwDu4n1Y8+xdwQSgUXACTYEd0IgYR5BSFhMWE7YSKggHCQ0EdoJNwkDhFHCJyKTqEu0JroR+cQYYjIxh1hILCPWEo8TLxB7iEPENyQSiUMyJ7mQAkmxpFTSEtJG0m5SI+ksqZs0SBojk8naZGuyBzmULCAryIXkneTD5DPkG+Qh8lsKnWJAcaT4U+IoUspqShnlEOU05QZlmDJBVaOaUt2ooVQRNY9aQq2htlKvUYeoEzR1mjnNgxZJS6WtopXTGmgXaPdpr+h0uhHdlR5Ol9BX0svpR+iX6AP0dwwNhhWDx4hnKBmbGAcYZxl3GK+YTKYZ04sZx1QwNzHrmOeZD5lvVVgqtip8FZHKCpVKlSaVGyovVKmqpqreqgtV81XLVI+pXlN9rkZVM1PjqQnUlqtVqp1Q61MbU2epO6iHqmeob1Q/pH5Z/YkGWcNMw09DpFGgsV/jvMYgC2MZs3gsIWsNq4Z1gTXEJrHN2Xx2KruY/R27iz2qqaE5QzNKM1ezUvOUZj8H45hx+Jx0TgnnKKeX836K3hTvKeIpG6Y0TLkxZVxrqpaXllirSKtRq0frvTau7aedpr1Fu1n7gQ5Bx0onXCdHZ4/OBZ3nU9lT3acKpxZNPTr1ri6qa6UbobtEd79up+6Ynr5egJ5Mb6feeb3n+hx9L/1U/W36p/VHDFgGswwkBtsMzhg8xTVxbzwdL8fb8VFDXcNAQ6VhlWGX4YSRudE8o9VGjUYPjGnGXOMk423GbcajJgYmISZLTepN7ppSTbmmKaY7TDtMx83MzaLN1pk1mz0x1zLnm+eb15vft2BaeFostqi2uGVJsuRaplnutrxuhVo5WaVYVVpds0atna0l1rutu6cRp7lOk06rntZnw7Dxtsm2qbcZsOXYBtuutm22fWFnYhdnt8Wuw+6TvZN9un2N/T0HDYfZDqsdWh1+c7RyFDpWOt6azpzuP33F9JbpL2dYzxDP2DPjthPLKcRpnVOb00dnF2e5c4PziIuJS4LLLpc+Lpsbxt3IveRKdPVxXeF60vWdm7Obwu2o26/uNu5p7ofcn8w0nymeWTNz0MPIQ+BR5dE/C5+VMGvfrH5PQ0+BZ7XnIy9jL5FXrdewt6V3qvdh7xc+9j5yn+M+4zw33jLeWV/MN8C3yLfLT8Nvnl+F30N/I/9k/3r/0QCngCUBZwOJgUGBWwL7+Hp8Ib+OPzrbZfay2e1BjKC5QRVBj4KtguXBrSFoyOyQrSH355jOkc5pDoVQfujW0Adh5mGLw34MJ4WHhVeGP45wiFga0TGXNXfR3ENz30T6RJZE3ptnMU85ry1KNSo+qi5qPNo3ujS6P8YuZlnM1VidWElsSxw5LiquNm5svt/87fOH4p3iC+N7F5gvyF1weaHOwvSFpxapLhIsOpZATIhOOJTwQRAqqBaMJfITdyWOCnnCHcJnIi/RNtGI2ENcKh5O8kgqTXqS7JG8NXkkxTOlLOW5hCepkLxMDUzdmzqeFpp2IG0yPTq9MYOSkZBxQqohTZO2Z+pn5mZ2y6xlhbL+xW6Lty8elQfJa7OQrAVZLQq2QqboVFoo1yoHsmdlV2a/zYnKOZarnivN7cyzytuQN5zvn//tEsIS4ZK2pYZLVy0dWOa9rGo5sjxxedsK4xUFK4ZWBqw8uIq2Km3VT6vtV5eufr0mek1rgV7ByoLBtQFr6wtVCuWFfevc1+1dT1gvWd+1YfqGnRs+FYmKrhTbF5cVf9go3HjlG4dvyr+Z3JS0qavEuWTPZtJm6ebeLZ5bDpaql+aXDm4N2dq0Dd9WtO319kXbL5fNKNu7g7ZDuaO/PLi8ZafJzs07P1SkVPRU+lQ27tLdtWHX+G7R7ht7vPY07NXbW7z3/T7JvttVAVVN1WbVZftJ+7P3P66Jqun4lvttXa1ObXHtxwPSA/0HIw6217nU1R3SPVRSj9Yr60cOxx++/p3vdy0NNg1VjZzG4iNwRHnk6fcJ3/ceDTradox7rOEH0x92HWcdL2pCmvKaRptTmvtbYlu6T8w+0dbq3nr8R9sfD5w0PFl5SvNUyWna6YLTk2fyz4ydlZ19fi753GDborZ752PO32oPb++6EHTh0kX/i+c7vDvOXPK4dPKy2+UTV7hXmq86X23qdOo8/pPTT8e7nLuarrlca7nuer21e2b36RueN87d9L158Rb/1tWeOT3dvfN6b/fF9/XfFt1+cif9zsu72Xcn7q28T7xf9EDtQdlD3YfVP1v+3Njv3H9qwHeg89HcR/cGhYPP/pH1jw9DBY+Zj8uGDYbrnjg+OTniP3L96fynQ89kzyaeF/6i/suuFxYvfvjV69fO0ZjRoZfyl5O/bXyl/erA6xmv28bCxh6+yXgzMV70VvvtwXfcdx3vo98PT+R8IH8o/2j5sfVT0Kf7kxmTk/8EA5jz/GMzLdsAAAAgY0hSTQAAeiUAAICDAAD5/wAAgOkAAHUwAADqYAAAOpgAABdvkl/FRgAAJdlJREFUeNrsnXmUFOW5/z9V1fs2PTszgMg2gDco4AIIAiKIQdBo3M3VbN57fok3Lmi8xquY6EmIEXMSNb/8rtlMjAsxaFzZVBBBRJFFQBaHgWGYGWbtmd67a/n9UTMjyCw9PT309HR9z6kDp+et932r6ltPPe/zPougaRp9gSAIpAEWYDJwHjABGAsUtB0eQMLAYMBrwLe++mNfOQtgyqCbcBZwSdsxDSg2eDHoUdRfHQ904ucBNwA3AxcaPMg6+LON+KOAO4Bvt6kuBgwMauKXAj8BfgAIxuPJerT2V8fCAFrc/jfwEGA3nreBNnwBrATMbYJQAPyapj04GIh/PvB7YEqq7pbX62XMmDEUFxdzxhnDcbs92O32dFmgDKQQv//9/6WmprbPDzLdqs5NwN/72sn48eOZPXsWU6dOZdKkyZSVleF0Og2WDEKsWvV2Q6br+A8BP0325JKSEm699Vauv/56Jk2aZDAiSxAOhzN6cfscuomy15g16yK+//3buO6667BarQYTDGQM8dcC83p70vx587j33nuZf+mlxlMzkHHE3wJM7c0J48rK+MWyZVx11VXG0zKQMoincax3e0v6Bx54gH379hmkN5CxEv954OJEG5eVlfHss88ybdo04wkZyFiJ/wRwY6KN77jjDvbu2WOQ3kBGS/wlwF2JNBQEgbffeosFl13WLxPx+Xy0tLQQDoVo9vkIhUKEw2EURSEUCqEoCpIkEQgEiMfjiKLYMS+AhoYGZFlOaKycnBxcTieyonT8pmkagiDgcrkQRRFVVSgsLGLBggUGCwcZ8ccDjyfS0OPxsH79eiZPnpySgSsrK9m69SM++WQbu3btpLz8EMeOHSMYDA6om2+xWIhGo0mfv3Snn+d3tGL2fPkY2/fhPWYBkyCgaqmds4buN+AwQZ82wmMqDpeJF2fn4xAHF/HfSKSRy+Xi008/ZfTo0X0abP++ffzrtdd47bXX2Lx5c0qCFfobJSUlSZ8bUeFnn7ZAQxQCncTdqP08+b72H1HAY0KemQeiMGiIfw+QEJM3b97cJ9K/+eab/P73v+eNN94g09AX36GVR8Lgi0Nhhm7i2UTcLiltLrj9QXwv8KtEGj755JNMnDgxqUEOHNjPHXfcyapVqzJWz7TZkift84dCX+odWgZevABhGfxxDbf59NO/P7SrhEh/1VVXcfvttyc1wCOPPMK4ceMzmvQAdnvyHtg7fHGwiplJ+jZIApjE9IydaolfDHy/p0alpaWsXLmy151XVVVx3bXX8uGWLYPCsqCqySnKlUGFY81txM9UaGCVNJySMCiI/3AijVavXt3rjj/44AMWLVpES0sL2Y5/HA5DSxzyLRl9HTFBRE6Tkp9K4jsSkfb3338/X/va13rV8erVq7msn+z7mYgVlRFdT8hkKBpus4jNlJ7rSOW38paeXqSSIUP4+c9/3qtOP9qyxSD9CaiNqGytjoBTynjij7CKpMsmlUri/2dPDf7y7LO96rChoYHZc+YYbD8Br1S2mTHNYsYTP8+Rvpc3VXdvJDCpuwbnn38+l/bSl37u3Ll92tkcjFhZGT69PrX9trKHMo8p44n/jZ4aPPnkb3vV4YMPPshnn31mMP0EBGSN945FwTEIMiQKMDnPnPHE71aUT5w4kalTE/e2rKys5NFHHzWY/hW8fSyK0hTLbDMmQFwDp4n5pdaMJr4b6FYRf+KJJ3rV4ZVXXmmwvBP8tTyY0RtW7ZKe1jgXj3QwPMN1/AsAW5fK/5lnMm9e4iG2r6xcyY4dO7KCyL1xpAvKGm8djYAzw6W9rIFJ5Ilzc9I6jVTcxXO6++N3vvvdXnX2kwceyBoJ3hsntXdqoqi+OFgyWL8XBaiPcsUkD5Py0pvSKRWjl3X3x2uuuSbhjj7++GP27duXNcS32x0Jt33rWARkNTMzirbPuS6KqdDG76Z60/8OpqCPM7v8w5lnMmHChIQ7+t3vfpdVOnt7lFdCC9vqaOYtagVA1aBVhuMxvjbCwc4bShhqS/91pELidxlN0Ru7vSzL/OMf/8gq4ieq4x9olamsj3bujZnsFyAVi2TthP+ogNb2b1zVdXlFA5tEWbGV/xjvYsnZ7gFz71NB/C6/WzNmJF7LYd26dQMuNLC/cezYscQW/EcjUBcDrxk0+WTiaVov2d/WPlGh21V0VPuw7YdZRDSJOC0iwxwSI10mpheamTPExswhA8+ZLhXE7/I1njLl3IQ7OZ0RVA6HA4/HQ1FREaIkonXpHqw/9GAwiKIonS5GTSYTfr+fQCBwyt/y8/Iwmc0d7seqqmK1WrHbbSiKytSpiaUZWjzcxsSbhxISBfyyiqaBRdQ1iHq5967NJkFgqEXQNZEu2iga2EUBt7nzuF1V07BIAnZJfzlsZpERFpEcm5iWwJJ0EL/T19ntdjNmzJiEO3n33Xf77SLPOuss5s+fz4wZMxg7diwjRozA5XJhNqdm51CW5U6Tmbrdqfm0n+UxcZYnk8qVkRXE71RojBkzBpvNllAH1dXVfP755ym/uHPOOYdHH32ERYsW9+9NNJlSRnIDmUP8TjFs2LCE237UDxFV3/zmN3n55ZeNJ2yg86VLf3U8vBfE37FzZ0rHPvfccw3SG0gP8Z0uV8Jtd+3aldKxV6xYYTxZA+khfm8yCHzxxcGUjTt37lxGjRplPFkD6dHxTabEug4EApSXH0rZuLfeeqvxVL8CTYOqoIIvplIfUwnFNCrDKvVx3QWixCxSbBVwWUTyLCK5FoEhDgmbJBjE7y0STZ1RXl6esrpGAHMGSahiuV8h1yaSl6RN/JBfYV1VmHXVUbY0xKgKKmiKpu+qquiGelXTE2AKbd/+9kQ3JiiwSUwttDB/iJV5Q238WxqDRjKK+Ini6NHKlPVVWFjYK2vSQMaN7zfRElXZf3Vxr8574YsQf/sixNtVYX2HS0B3dTALOslt4pfZXtvfKe2ET4MKKNDQEufN41He3OUHl8T0Ehv/PsbJzWUOPCbBIH5f0dTUnLK+zjhjeK8cvwYq4hp82hhDORxi1TQvl/UQqRTV4KnP/Dy9N0BFTUT/0SVBolK6ncfCCa4MZgnskv63uMaHFUE+PBjkwa0WfnSOm4cme4zFbV+QqL9KQgtqh4PBgFXHIijNccgx8Z2N3QuGJ/cGGPX3au5ZW09FQxRyzTrhU5WFQQNMgu4nVGCmMSiz9J1GxrxUwwvlYYP4yaKhvj5lfVktg6P85/MVYd333mumtjLEfTv9p7TZ61eY8epxfvRWHdW+GBRYwG06WXVJ6Qq57XBJUGim/HiUm/5Vy9ffqudgQDGI31sEg6HUXcwgUHMU4PWj4S8zKeSYeGx9I9uavvTKfLc2xtkvVrP5YPBLwmucnnjc9nFyTJBrYtVeP+Ofr+aZ/UGD+L0jfuC0W5IGMtZVRwnWx8Am6QSzSaBpXL++keqwyk93+bnk5RqUqALF1v6T8Im8AIIARVZUWeU/Xj/OreubjMVtwqpOY2PK+opEIhlP/BWHw7rJUWwjl6pBrpnyxigjX64h1p4e3GYi5XV+kpI2mp7O0Cby14987GyK8e4VxeQNcMtP2omfyuCT7du3M2XKFDRN7XMpIA3QVA2bzYbFYknqa6JpGkOHDu2V39CrVRFdzfnq9E0isZACLpP+UqgDKM+Ihh6wMsTCzkMhzn6hmo3XlDDSLhrE7wrxeDxlfYVCIbZv3z6gbrAkJZ4V4YO6GE11UU6phtYe7dQecztQc+toQJGVY/UxJr1Qzcc3lFLmGJjkT/usBGHwbosDjBgxIuG2Lx8J60XRMtlVQNWgwEKrL87UFdXURFWD+J0hHA5hQMcrVRF9ZzXTs6W1kd/XGGPaP2uJaAbxB6UlJhXY7ZOprB0kCWHbyV9oofJYmLlv1RvEzzZVJ1GsrAxDUM78SicnkR8otPLh7lb+65NWg/gGTsXzFWE9dYI2yC5MAPItPPV+I88eDhvEN/Aldvlk9h+L6O4A/Q1Zg7ACfhla2o6ArJdKV/rhrdPQX2ibyLdfr+OLAeLeYOSsGAhqzpEwhGRwWlIv8QUgqkJQ0XdanRJ5uRbGuky42pw3j0c0jgRl/AH5S1dmp5S6L5Cq6fsP9VG+ub6RnYuKDOJr2uBe3CayeH+tKqx7U6aS9KKgv0xBBcFr4aqJThYOt3FeoYWxOeZT1tB+WeNAi8xHdVFWVUV5vTIMDTF9se2Uus481Rvy51nYtT/IuvOizBtizW7iW632QU18u7373ELVYZXtNdHUVTFsT49WH8XiNXPnRV7+z1kuzuxBjXKbBM7NN3NuvpkfTHBxyK/wzL4AT+72E6yL6e7OJqFvL6eoz+9XewJpJ37adXyLxTKoid9TUq1Xj7ZFSqXCt0UUdF29Kc7iiR723zCUX16Q0yPpO8Mot8Qvzs+h/MZSvnOeV18TBJSuc2kmqu/nmFizN8COE7xNs5L4iqIMauL3pOq8fjSSmpz3AhDWF6m/urSA1y4t4MwUVE8pton8aU4eL145RFfHmmN9I79JgKjCj7e3ZDfxs9mOH1I03q2OQiqcuWIaVpPIq9eWcM/E1KczvH6knV03lpKbY4HGPpBfA7xm1h4IUp5GC0/aid+b/DuDDeuqo8SaYmBNgX6vaghmkSv7sZLgRLfEtutL8HjNX1p/koFZhIDMr/cGspf4gyFqKlm8WZXC8j42kUh9lO991L8qxEi7yIqFRfpegJzkSlfTffj/8kUw6S4ynviyLGct8V+vbnNKSwU0wGPiTx/72OfvXxViQbGFm2fkQVM8eZXHIRE8HuVfRyPZSfz8vLysJP325jg1dW0hhqmCVYKYwnXvNfb7/J+70EtBqQ188eS+WG31sV6sCGUn8V29SC47mPB2VQRCKfa9b9sk+mxfgN8d7H9C/e2SAl3dSSYaTNOl/prqaL94ShiqzgDF3ua4Thi1rUjaiUdXvydyqBrYRH64oZH6fg4CuWyIhUkT3NCc5ELXKtLaFGdLQzz7iD/YsX///k5/39LYRvyoBrGvHNG2Q9b0fCO9Ib6s6RnQaqI8uN3f79f3m/M8+lcrGakv6jb9d2tOv54/AHx1UvedGz58ON/73vcGFPGLizvPffmnGbnEp3m7XRw6Rb1QWzJyW5NVRFP/y7VZhRYuGOdi6z6/nm0tCdH7fm0UTnMp0LQTP9F04olg3LhxLF26NCO+BLOKBo+rxu1lTm7Zm+TXxSqywxdHPc3qR9pVHWuCBeISQbbVyR0oWDjMpufrjCXxbTIJNAQUKoOn10s37cQPGWTNeORbBKYUWXUHud5CEiCqUh6Qs4v4aJrBnEGAafnm5HZyBQFkFV9IyTLiG8HmgwLjcszJPcu2+IHySJapOgYGB8Y4Jb3qSjIfcEWjNaYYxDeQeXBaRV1fT1J1NZ/mCFSD+AZSAlkSQepD3LBgEN9ABkJSVFD74GKtZRnxe5NN2MDARTzWlpcnyQVu/DRnkEs78esbGgzWDAIcCql6ucZkJL0oUGQVs4v4oZCRLXkw4PNWua1gdDKffTjTJmUX8VPpq2Mgffi0KQbJcFfVQBLxnuYCEmlnXbZmWXj88yCrykO9SyQVVyGuIkoiK+bm47UMjHsXlDU+Ph5NLppM0cAhMc5tyi7iD/a8Ol1hXVWYdz5qgnxLb6SEbif3yfzhDBv3nDUwotdeOhwmUheD/CTckmMqY4usFNuyTOIPhkqFyWC0xwReS5I+7AJP7w8OGOL/vy9CySvNMY3JeaffRduw46eL+G5T8jZvl8ThqgjbmuJpv44vAgpbD4XAk7wMnVZgED9rMLfEqmciTibSWhIgpvDTz/xpv44f72jVszInk/tT0cMkZw/JQuJna0KpSblmCvMtepXD3qIt+errn/nZ25q+YP2DQYVXdraC15TczmtEoaDAwpQ8c/YRP5V1bjMN3xhmg3CS2/xmCeIq17/XlLb537y+SS86YUnCmiMAYZVFpba0zD3txI9EwllL/BtGOnTSJBVNrkGumd0HAiz97PTnoHziQJCP9/r1kMNkMiyogFnkhpH27CR+NmdLnjvEQv4Qi64jJ3XzdJXnZ+saeLs2dtrmXR5SWLK6AdxS8gv0kEJOsZUFpdbsJH6249ujHRBKUt3R0DeNzLBwZQ1bTpOV54q3G/Rkt44kdXtBgJDCLaMd6VtbGtRLL34w3gVuk74rmwxUDTx6vOv0FTVsrOs/yR8GZr5ex97DweRVHNCv1WXijgkug/jZilFOidmjnXrZzWTVBlXTN8LiKrP+UcP/7k995ordLTLnvFjDpv0B6IvdXQBa4lwy1slol2QQP5vxs0kePXqpL9lTVQ1yzCDBf75Zx/XvNFIdTk08368+8zPxxWoO1kagqK0kabJTlTUwi/xqiiet99yw4w8AzCo0M2WcC5rjfQvBU9vyZnpNrNjewtgXqnngk1aqQ8m9AC+Vh5iy8jg/XtOgW5HyLH0r+ykArTIXn+Vichps9yci7b46oVAYA/CXaTmcvT+gZyPrS2HltsAOiiyEggo/39DA8t2tXDvSwdeH2ZlZbOGMLlQMX1zjk4YYq45GeOVwiEPVUV005ps78tn3CSoQ01gywZ32+5124kejUYP1wMRcM/fMzufxdfW6OtFXqOjS3yERjag8t62F53a2gttEmdfMcKeEyywiAH5ZxRdV2dciE2yJ6xnRrKK+IyvQN9XmRN2iPs6cyR4uH2o1iG/gBF16spsXy4NUHQ3r7spqCiKwNXQSW9u+IrLKgeoIB2Tty1QggqAT0yLqpYlOLHueiiBw/e0Cj4l/XZI/IO51+pPGWq0G40/AW/MLdCe0kJL6lBsCesVBpwQ5Jt0S5DXr/3eb9JdD7IcNRVmDkMpzCwrxSIJBfACHw26w/USVJ8fEsksLoSWeGomfbghAQ4zrp+dy8xm2ATOttBO/p8rf2Yj7xju5/PxcqIud9kRLqWWXAA0xxo528uLM3IE1NYNmAxOvz81j3GgX1Mf6R/04HaRvimHxWth4RfHAm55BsYGrIWz5RhEFRVZoiGYW+UVBLwNqkdh0zRCKLYJBfEPVSRxek8An15aQm2fNHMnfTnpRYMO1JZyXMzANhwPAqmMzGN4NRthFPr2+hDOKLVAXHdg6vyhAYwwsIhuuL2VWoXngTjX9xDfMmT3hTLvIjhtKOWeUE2qjyWcs60+9DOB4lOI8C9tuGtikHxDEz9a8Or1Frklgx9XF3DI1F5riesjiQFB9RL2GFcdjXFjmYvdNpUzxDPx90bQT32YzVJ3e4Nk5efzv4mLdp72xzdyZDv63j9sUg4jKkjn5bLqyiAJzZizC0/5qGt6Zvcdt45yMzjVz+3uNfF4Z1ndindLpyzEvAEEFggpnjbDz5Kx85g7JrLq9aWddrtdrMDkJzC2ysPf6EpbNL8TjMOmbXUGlf3d7NfR0KPUxXHaJR+YVsOe6kowj/YCQ+E6nM2V9ZWPK8fsmufnev7n43S4/f9wfoNIX13VuSdCdzUx9VD1UTffWjKhgFrA7JL49zcNPL/BSaMncbeW0E9/vT102sGy1EBWYBR4618P/nOvh07oY62qjvFwRZltdVLepq+gvgEXQXwhJ6LxyiarpUWCypscFKIBVZGi+mQXD7HxzhJ3ziywU2jJfPU078Zfccw+XzJtHNBrteAkikQjxeBxJkpBlmVAoeNIKTtM0HA4HZrMZm81Gfn4+I0eOZPLkyVmt/ojAeUUWziuy8N9nuznQIrOpNsqH9TH2+OLsaZVpibZJb1nR76mA7p4sCGAWsNkkirwiX8s1M7XAwsxiK7NLrEiDLAtM2ok/Y8YMZsyYYSjt/YCyHBNlOSa+M05XJwOyRn1Y5VBIIRxViKnteY00nJKA3SoxwSmR7xAZ7NmOjECULILLJOByS4x0GwX3DFuiAYP4BgwYxDdgwCC+AQMG8Q0YMIhvwIBBfAMGDOIbMDBwkfYNrOPHjxMMBsnJySEajeJyufB4ep9Jt6WlhVAwiNVqpdnnw+VyUVx8anR/U2MjsXgcURSRZZnS0tKE+g8Gg7S0tGAy9e2WaZqGzWpFVhRkWUZRFHJycrp01vP7/QT8fiSTCVVVycvLw2JJ3BsyEonQ3Nzc4f7R3VgAra2tBAMBJJMJTdMQgKLi5LMkyLJMbW1tx5xVRSEvP79X1zAoie/z+XjwgQdwOJ04HA7C4TCPPPIIw4YPT7iPikOHePjhh3G73bS0tKDIMj979NFTiF9eXs5DDz5ITk4OkiRRU1PDjTfeyDevuabHMTasX89TTz3FsGHDenV9ZrMZUzuJBAGfz8ekyZMJBYNUHjlCfUMDt912G19fuLDT8994/XX++c9/UlxcTGtrK//z4IOMGzcu4fF37tzJr594gsKCAo5VV3c7FsBzf/sbGzZsoLi4GFVVOV5by9333MP06dOTer5PPfkkW7dupaCgAEVRaG5u5p5772XKlCnZreqMGzeOH95+O81NTcTjcSKRCMuXL0/Yxbi1tZXly5cjyzKBQIBgMMhdd9/NmDFjTmn76iuvEIvGiMfjBAIBvF4vb731Fs1Nqa8cKAAulwu73U4kEkFRFELBINFolNKSEmKxGHFZJh6Pd5tpQlVVZFnuODStd/72HecrSo9jATQ0NCAIAvF4HEVRsFgs/PPll5OqTrljxw42vv8+LpeLWCyGqqrEYrEBkSh4QPjqzJ4zB7/fzzPPPENZWRnl5eU89eST/Pi++3o899dPPMHx48cZOnQoR44c4Sc/+QnnX3DBKe327NnD5s2bGTZsGBaLBUEQiEQiVFVV8eqrr/Kd7363xzlOmjw5YVXHZrMRi8V4/PHHEQBJkqirr2fJkiXMmjWLO++8E5vNht1u77ZPk8mEzWbDarVis9l6HbEmSVLH+T2NFY/HCYfDeDwebDYb0WiU4iFDOHjwIGvXrGHh5Zf3auzn//533B4PVqsVQRCQJAmLxYwsp7/E64BZ3C5avJiZM2dSUVHB6NGj2bRpE2vXru32nHXr1vHxxx8zYsQIKioquOmmmzolPcDqVauwWCw0NjYyecoUbrzxRhoaGigpKWHTpk34fL5ux3I6nZSWllJUVJTQ4fF4+MeKFVRXVWGz2zly5AjXXXcds2bPJhAKIcsyAw2hUKhDGtvtdkaMGEE0GqWoqIi1a9f2Sup/sHEjXxw8iNlsZtiwYYwZM4ZAIICiqESjMYP4J+L2//ovCgsLqa+vZ9jQYfzlz3+mtqamy0XbKytXdkj6GTNncu1113Xa9nBFBZ988gnFxcWEQyEmfm0ik6dMIT9fT1nd1NTI2jVrUnotv/3tb1izZg2FhYUcPnyYRYsXc/O3vqUvWFtbB2Sssc/nIxAIIEkS0WiMiy66iPz8fKxWKxUVFWzYsCHhvt544w28Xi+tra3MnTuXESNGEA6H0TQNOW5I/JNgt9u56+67CQQCiJKIpmk89fTTnbZ95plnaGhoIBKJUFJSwl133dVlv6tWr+pYPwwdNozxE8YDMHz4cHzNzRQVFbN+/XrC4dRUZ/njH/7Au++8y6hRozhUUcGcOXO47bbbTlI/BiIi4TCxWAxRFGltbWHi2Wcz8eyzqa+vJz8/nzWrVye0xvhg40b279+P2WKhtLSU8y+4gFa/H03TEEWRQCBgEP+rKCsr49Zvf5vKykpKS0vZvWsXr7zyykltNm3axHvvvovH7SYej3PfffdhNneewKiuro4tmz+kpKSEuro6Zs6c2dH2/AsuIBKN4HK5qK6u5r333uvz/J//+9957bXXGDVqFIcPH+a888/nzm5eyoGEVr+/YwEtSiJut5uZM2eiaRo5OTkcPHiQjRs3JiTtc3NzaWioZ+ZFFwEQOIH4vpYWg/idYfHixcyYMYPKI0c4Y8QIXnzhBSoqKgBobGjgD888g9frxdfSwh133MHQbkyMa1avxh8IoGkaebm5zJ8/v+Nvs2bNYuTIUfh8PvLz83n3nXf6lODqX6++yksvvcSoUaOoqqpiwoQJ3H///WQKWlpaiLVZfpx2B5FwmJKSEsaPH09zczM5OTmsXrUqIWnvsNvJzc3ruN9WqxXaTLrRSMQgfnf6fl5+PoFAALPZzHPPPYeqabz40kuEw2FaW1pYuHAhU6dN67IPv9/Pxo0bGTJkCDU1NVw4Ywa5eXknqRxz586lsbERr9fLofJyNn3wQVLzfWfdOv7ylz9z5plnUlNTw/AzhvPgQw9lVN6gSDgMmoamaZgtFtQ2tWbW7Nn4fD4KCgrYt28fH330UY/Svqa2lotmzerYjHS73aiahslkIhgMGsTvCg6HgzvuvJPW1la8Xi811dU8tmwZBw8cwGq1UlBYyPU33tij1aeurq4jKP3SBQtOaTPn4ospLS0lEAjg8Xh6tCR1hs2bN/P0008zdOgwGhsbyc/PZ+nShzMu60P7Dq+qqphMpo7d1Ysuuojhw4fj9/sRRZFdO3d2ev7GdmnvcODxeLj8BPOnw+lEVVXMZjN+vz/tWbIHtDiaMGEC/37LLdTW1mKz2Thw4ACRSARZllmyZAkOe9dlhGLRKOvfe4/CwkJqa2tZcNmCTnddHQ4HV199NY2NjeTm5bF37162bduW8By3b9/OE8uXU1xcjN/vx2azsfThh5Nyu0g3AoEAQpsrh8Pp6LD5W61WZs+eTX19HUVFRezYsaPTtDBvv/UWXq+X2tpaZs2aRUFBQcff2tdVkiQNiE2sAf8dvvLKK5k6dSpNTU14PB78fj+33HILY8vKuj1vw/vvU1lZidPpxGq1MrR0KEePHuXw4cMnHUeOHCEvP5/8/HwURcFms7F69aqE5rZ//34eW7aMvLw8YjHdNv3Q0qUUFRWRiQiFw5gkiXg8jtt1ci3aefPnk59fgCAInRoCtm7dyv79+3G5XDgcDhZ+xS3C4dBfJEEQCIfDBNNs2cmILAvjx49n69ateDwezGYzEyZM6La9pmmsW7eO3NxcBEHA6/WyYsUKIpEwnVnjbDYrNpsdQRB0ibZ9B/v27WP8+PFdkyQU4pfLlmFr++qEgkF++sgjnHHGGRlJelVVafH5sFgshEKhU9S0nJwcZs6cyeuvvUZBQQEfvP8+l19+eYdpdu2aNTidTv3rumABxUOGnHS+NycHs9mMJEmEQiH8fj8FhYWGxO9WEoVCJ9m+e8q+tmXLFg4eONAhiWOxGCaTCbvdgcNx6mEymZFluaOdKIqsevvtbsd47Je/JBqNYrPZaG5q4r7776esh6/QQEY0GiUSiSBJEpqm4XK5Tmlz6YIFOJxO7HY7hw4dYuvWrQDs27ePzz77DLfbjd1mY9Hixaeca21ztxAEAVmWicbSu3s7KPPqtEufcDiMqqrcdffdHapMp2+/KBKLxfjtb35DfX09xcXFfPzxxxw9epThnXiJ/nLZMnbv3k1xcTG1NTUsufdeJk2alNH3rLW1lXA4jCRJHa7SX0VJSQnTpk1jw4YNWG02Pty8menTp7N50ybQNOrq6liwYAFDviLt29cJVosFTdWQZZnW1lZDx08l9uzZw65duygqKqKmupopU6ZQVlZGfn5+l341BQUFlJaWMveSudTX12OxWIjFYp1K/Sfb3GyLioqoqqriBz/8IRdeeGHG37dAIEAoFDppQdsZFlx2ma66eL0cO3aM3bt3U1FRgdvtxmqxdCrt282ZdocDRdW9RFOZM9UgPvDPl1/GbrcTjUbJzcvjqquvTvjcuXMv4ayzzupwXtuwYQOHDh0C9Motyx9/nPfbfNUVReFnj/yMS+bN6/UcXS5XUuY8VVU7VUG6fcCimNBYgUCgwwnNYrGQ00X69tGjRzNnzhxafD4UReFPf/wjwWAQn6+FhZdf3qm0BzqMDKqqomka4TRnth5Uqs62bdvY/umnjB4zhoqKCq688sqTTGo93gyTiUWLFrF8+XIKCgqIRCK88847jBw5kieWL2fj++8zZuxYGhsbmXnRRZxzziQaGxt7tdsrCALNzc2YTKYOS1Ci55nNZqqqqrBarT2OqWkaNpsNWZYTcqVuamrqMDGaTeZOVZ12TJ8+nXXr1iGKYoc6mZeXyzeuuqrLcywWCw6Hg/q6OiRJ6tEb1iB+20NUVbXj6Apvv/02doeDaDSKw+Fg3gnuCYli+oUXMvrVV2lsbKSktJQD+/fzi1/8gs/37mX0mDGoqqrv8h4q544f/ajXLg7xeJyioiJcLhc+n69DAvZ07YIg4HK5+Ntf/4ogCD1K8XA4TNm4cUyZPBmn09nRT1djhUMhFEVBVVVESew2NLBs3Djdwc/nw+PxUFFRwc3f+hYOh6PHL137ojbdqk5GED8QCFB3/DiSJNHc3Nzp5scHH3zAO2vXUjp0KHv37uWKK65IOJ72REiSxCWXXMJjjz3GsGHDiEaj7Nmzh7y8PBoaGjpCCI8fP44sy23ZhhNHJBJBFEVEQaCxqYnjx493+9lvv/b24JlYLIaiKD2OGwwG8ebmEgqFaGhowGKxdDvW0aNHO67PZrN1q1I5HA7mzp3LU089hdfrpbCwkIULv97jtcuyTHV1NSaTqUt3c4P4J+CSefMYW1aGvS2qaeSoUae0KSgo4H/a4mn9gQCTzjkn6fHmzZ+vx+W2bbhEo1EsZjNim6mvL1BVFZvNhqZpxKJRwpEIY8eO7fnau9ml7gyKouB2u8nLy6O4uBhRFAmFw12ONefii5kwYQJmsxmLxULeCT5NneHyRYsYPWYMiqK0fcHcPc7pqquvZtq0aYiSlPadbaGvD1IQhFbglKt++OGHWbp0KQYMpBKTJp3TsGPHzj7vfBl5dQxkJQziGzCInyTcxm00kGlIxeJ2Wxv52+1rcWAokGfcXgODmfjndfLb48AS4/YayDYdXzVurYFsJL45k2JNDWQOertheLqJ7+ytM5UBAwnp5iZTStaOqdjA6uznZaNGjfrByJEjjSdlIKX46KOPGv1+f5+J9f8HAD/pmkuPqWgbAAAAAElFTkSuQmCC'



                var dd = {
                    header: function (page, currentPage, pageCount, pageSize) {
                        if (page == 1)
                            return {
                                columns: [
                                    {
                                        image: logo,
                                        width: 90,
                                        margin: [15, 0]
                                    },
                                    {
                                        alignment: 'center',
                                        italics: true,
                                        text: 'Reçete',
                                        fontSize: 18,
                                        absolutePosition: { x: 15, y: 30 }
                                    },

                                ],
                                margin: 20

                            }
                        else
                            return {}
                    },

                    content: [


                    ],
                    styles: {
                        header: {
                            fontSize: 14,
                            bold: true
                        },
                        cell: {
                            color: 'red',
                            fillColor: 'yellow'
                        }
                    },
                    pageMargins: [30, 100, 30, 40]
                }


                for (var i = 0; i < veri.length; i++) {
                    var İlaç_Tablo = [
                        [
                            {
                                text: 'İlaç Adı',
                                fillColor: '#555555',
                                color: '#00FFFF',
                            },

                        ],

                    ];
                    for (var j = 0; j < veri[i].length; j++) {
                        İlaç_Tablo.push(
                            [
                                {
                                    text: veri[i]
                                },

                            ]
                        );
                    }
                    Doktor_Tablo.push(
                        [
                            {
                                text: ""
                            },
                        ]
                    );



                    dd.content.push([


                        {
                            margin: [0, 10, 0, 0],
                            style: 'tableExample',

                            table: {
                                widths: [100, 'auto', '*', '*', '*', '*', '*', '*'],

                                headerRows: 1,


                                body: İlaç_Tablo
                            }

                        }

                    ]);



                }


                console.log(dd)

                pdfMake.createPdf(dd).download();
            })
            var Urun_Adı_Listesi = [];
            var Urun_Adet_Listesi = [];
            $.ajax({
                url: 'Tsm-Sipariş-Raporu.aspx/Çalışılan_Urun_Getir',
                type: 'POST',
                data: "{'parametre': '" + TextBox2.val() + "*" + TextBox3.val() + "*" + Kullanıcı + "'}",
                async: false,
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    var temp = JSON.parse(data.d)

                    console.log(temp)
                    for (var i = 0; i < temp.length; i++) {
                        Urun_Adı_Listesi.push(temp[i].Urun_Adı)
                    }
                    for (var i = 0; i < temp.length; i++) {
                        Urun_Adet_Listesi.push(temp[i].Adet)
                    }


                },
                error: function () {

                    alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                }
            });

            var ctx = document.getElementById('Ziyaret_Edilecek_Doktor');
            var myChart = new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: Urun_Adı_Listesi,
                    datasets: [{
                        height: 10,
                        width: 10,
                        data: Urun_Adet_Listesi,
                        backgroundColor: 'rgba(0, 166, 90, 0.4)',
                        borderColor: 'rgba(0, 166, 90, 1)',
                        borderWidth: 2
                    }]
                },
                options: {
                    legend: {
                        display: false
                    },
                    tooltips: {
                        callbacks: {
                            label: function (tooltipItem) {
                                return tooltipItem.yLabel;
                            }
                        }
                    },

                    scales: {
                        yAxes: [{
                            ticks: {
                                beginAtZero: true,
                            }
                        }]
                    }
                }
            });
            var Urun_Adı_Listesi_Satılan = [];
            var Urun_Adet_Listesi_Satılan = [];
            var Urun_Mf_Adet_Listesi_Satılan = [];
            $.ajax({
                url: 'Tsm-Sipariş-Raporu.aspx/Satılan_Urunler_Adet_Mf_Adet',
                type: 'POST',
                data: "{'parametre': '" + TextBox2.val() + "*" + TextBox3.val() + "*" + Kullanıcı + "'}",
                async: false,
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    var temp = JSON.parse(data.d)

                    console.log(temp)
                    for (var i = 0; i < temp.length; i++) {
                        Urun_Adı_Listesi_Satılan.push(temp[i].Urun_Adı)
                    }
                    for (var i = 0; i < temp.length; i++) {
                        Urun_Adet_Listesi_Satılan.push(temp[i].Adet)
                    }
                    for (var i = 0; i < temp.length; i++) {
                        Urun_Mf_Adet_Listesi_Satılan.push(temp[i].Mf_Adet)
                    }
                    console.log(Urun_Adı_Listesi_Satılan)


                },
                error: function () {

                    alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                }
            });

            var ctx = document.getElementById('Toplam_Satılan_Adet');
            var myChart = new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: Urun_Adı_Listesi_Satılan,
                    datasets: [{
                        label: 'Adet',
                        height: 10,
                        width: 10,
                        data: Urun_Adet_Listesi_Satılan,
                        backgroundColor: 'rgba(0, 166, 90, 0.4)',
                        borderColor: 'rgba(0, 166, 90, 1)',
                        borderWidth: 2
                    },
                    {
                        label: 'Mf Adet',
                        height: 10,
                        width: 10,
                        data: Urun_Mf_Adet_Listesi_Satılan,
                        backgroundColor: 'rgba(182, 84, 109, 0.4)',
                        borderColor: 'rgba(182, 84, 109, 1)',
                        borderWidth: 2
                    }],


                },
                options: {


                    tooltips: {
                        callbacks: {
                            label: function (tooltipItem) {
                                return tooltipItem.yLabel;
                            }
                        }
                    },

                    scales: {
                        yAxes: [{
                            ticks: {
                                beginAtZero: true,
                            }
                        }]
                    }
                }
            });


            $.ajax({
                url: 'Tsm-Sipariş-Raporu.aspx/Farklı_Eczanelerin_Sayısı',
                type: 'POST',
                data: "{'parametre': '" + TextBox2.val() + "*" + TextBox3.val() + "*" + Kullanıcı_Adı_Düzelt() + "'," +
                    "'İletim_Durum':'{İletim_Durum__:" + JSON.stringify(_Durum_Getir()) + "}'," +
                    "'Ürün_Listesi':'{Ürün_Listesi__:" + JSON.stringify(_ürün_listesi_getir()) + "}'" +
                    //"'Branş':'{Depo_Liste:" + JSON.stringify(Depo_Adı_Liste) + "}'" +
                    "}",
                async: false,
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    var temp = JSON.parse(data.d)
                    console.log("assadsda")

                    $('#Farklı_Eczane_Sayısı').val(temp[0].Eczane_Sayısı)


                },
                error: function () {

                    //alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                }
            });

            function Tabloyu_Doldur_Red(Liste_) {
                $('#Farklı_Eczane_Listesi').empty();

                $('#Farklı_Eczane_Listesi').append('<table id="Farklı_Eczane_Listesi_Table" class="display" style="width: 100%">' +
                    '<thead>' +
                    '<tr>' +
                    '<th>Eczane Adı</th>' +
                    '<th>Eczacı Adı</th>' +
                    '<th>İl</th>' +
                    '<th>İlçe</th>' +
                    '<th>Güncel ISF * ADET</th>' +
                    '</tr>' +
                    '</thead>' +
                    '<tbody id="Farklı_Eczane_Listesi_Tbody"> ' +
                    '</tbody>' +
                    '<tfoot>' +
                    ' <tr>' +
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
                    var Tbody = $('tbody[id=Farklı_Eczane_Listesi_Tbody]')

                    console.log(Liste_)
                    for (var i = 0; i < Liste_.length; i++) {
                        console.log(Tbody.html())
                        Tbody.append(
                            '<tr>' +
                            '<td>' + Liste_[i].Eczane_Adı + '</td>' +
                            '<td>' + Liste_[i].Eczane_Tarihi + '</td>' +
                            '<td>' + Liste_[i].İl + '</td>' +
                            '<td>' + Liste_[i].İlçe + '</td>' +
                            '<td>' + Liste_[i].Tutar.replace(',', '.') + '</td>' +
                            '</tr>'
                        )
                    }


                }


                $('#Farklı_Eczane_Listesi_Table').dataTable({

                    "lengthMenu": [10, 25, 50, 75, 100, 200, 500, 750, 1000],
                    "language": {
                        "url": "//cdn.datatables.net/plug-ins/1.10.22/i18n/Turkish.json"
                    },
                    dom: 'Bfrtip',
                    buttons: [
                        {
                            extend: 'excelHtml5',
                            title: $('#Tsm_Ad').find('option:selected').html() + ' ' + $('input[id*=TextBox2]').val() + ' / ' + $('input[id*=TextBox3]').val()
                        }

                    ]
                });


            }
            $('#Farlı_Eczaneleri_Gör').click(function () {
                $('#Farklı_Eczane_modal').modal('show')
                $.ajax({
                    url: 'Tsm-Sipariş-Raporu.aspx/Farklı_Eczanelerin_Sayısı_Ad_Getir',
                    type: 'POST',
                    data: "{'parametre': '" + TextBox2.val() + "*" + TextBox3.val() + "*" + Kullanıcı_Adı_Düzelt() + "'," +
                        "'İletim_Durum':'{İletim_Durum__:" + JSON.stringify(_Durum_Getir()) + "}'," +
                        "'Ürün_Listesi':'{Ürün_Listesi__:" + JSON.stringify(_ürün_listesi_getir()) + "}'" +
                        //"'Branş':'{Depo_Liste:" + JSON.stringify(Depo_Adı_Liste) + "}'" +
                        "}",
                    async: false,
                    dataType: "json",
                    contentType: "application/json; charset=utf-8",
                    success: function (data) {
                        var temp = JSON.parse(data.d)
                        console.log(temp)
                        Tabloyu_Doldur_Red(temp)
                    },
                    error: function () {

                        alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                    }
                });


            })
            //Ürün_adı_Selec2




        })
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="Farklı_Eczane_modal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 id="Farklı_Eczane_modal_Başlık" class="modal-title">Eczaneler</h4>
                </div>
                <div class="modal-body">
                    <div id="Farklı_Eczane_Listesi"></div>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Kapat</button>
                </div>
            </div>

        </div>
    </div>

    <div class="box">
        <div class="box-body">
            <div class="row">
                <div class="col-xs-12">
                    <div class="form-group">
                        <%--// has-error--%>
                        <label>TSM Adı</label>
                        <select id="Tsm_Ad" class="form-control">
                        </select>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-xs-5 ">
                    <div class="form-group">
                        <asp:TextBox ID="TextBox2" class="form-control" TextMode="Date" runat="server"></asp:TextBox>
                    </div>
                </div>
                <div class="col-xs-5 ">
                    <div class="form-group">
                        <asp:TextBox ID="TextBox3" class="form-control" TextMode="Date" runat="server"></asp:TextBox>
                    </div>
                </div>
                <div class="row">
                    <div class="col-xs-2 ">
                        <div class="form-group">
                            <input id="cal_set" type="button" class="btn btn-block btn-info" value="SET" />
                        </div>
                    </div>
                </div>

            </div>
            <div class="row">
                <div class="col-xs-3">
                    <div class="form-group">
                        <select name="Sipariş_Durumu_Selec2" class="js-example-placeholder-multiple js-states form-control" id="Sipariş_Durumu_Selec2" multiple="multiple"></select>
                    </div>
                </div>
                <div class="col-xs-9">
                    <div class="form-group">
                        <select name="Ürün_adı_Selec2" class="js-example-placeholder-multiple js-states form-control" id="Urun_Adı_Select2" multiple="multiple"></select>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="box" id="Gün_Div" style="visibility: hidden">

        <div class="col-xs-12" style="padding-top: 15px">
            <div class="form-group">
                <label>Seçilen Aralıktaki Toplam ADET * ISF:</label>
                <input type="text" style="text-align: center; background-color: yellow" class="form-control" id="Genel_Toplam_Adet_İsf" disabled />
            </div>
        </div>

        <div class="col-xs-12">
            <div class="row">
                <div class="col-xs-9">
                    <label>Seçilen Aralıktaki Farklı Eczane Sayısı:</label>
                </div>
                <div class="col-xs-9">
                    <div class="form-group">
                        <input type="text" style="text-align: center; background-color: yellow" class="form-control" id="Farklı_Eczane_Sayısı" disabled />
                    </div>
                </div>
                <div class="col-xs-3">
                    <button type="button" class="btn btn-block btn-info" id="Farlı_Eczaneleri_Gör"><i class="fa fa-scope"></i>Eczaneleri Gör</button>
                </div>
            </div>
        </div>
        <div class="col-xs-12">
            <div class="box">
                <div class="box-header with-border">
                    <i class="fa fa-bar-chart-o"></i>

                    <h3 class="box-title">ÇALIŞILAN ÜRÜNLER</h3>

                    <div class="box-tools pull-right">
                        <button type="button" class="btn btn-box-tool" data-widget="collapse">
                            <i class="fa fa-minus"></i>
                        </button>
                        <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
                    </div>
                </div>
                <div class="box-body">
                    <div class="card">
                        <div class="card-body">
                            <canvas id="Ziyaret_Edilecek_Doktor"></canvas>
                        </div>
                    </div>
                </div>
                <!-- /.box-body-->
            </div>
        </div>
        <div class="col-xs-12">
            <div class="box">
                <div class="box-header with-border">
                    <i class="fa fa-bar-chart-o"></i>

                    <h3 class="box-title">SATILAN ÜRÜNLER</h3>

                    <div class="box-tools pull-right">
                        <button type="button" class="btn btn-box-tool" data-widget="collapse">
                            <i class="fa fa-minus"></i>
                        </button>
                        <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
                    </div>
                </div>
                <div class="box-body">
                    <div class="card">
                        <div class="card-body">
                            <canvas id="Toplam_Satılan_Adet"></canvas>
                        </div>
                    </div>
                </div>
                <!-- /.box-body-->
            </div>
        </div>
        <div class="row">
            <div class="col-xs-12">
                <div class="form-group">
                    <%--       <input id="Hepsini_Yazdır" type="button" class="btn btn-block btn-info" value="Yazdır" />--%>
                </div>
            </div>
        </div>
        <asp:Repeater ID="Repeater1" runat="server">
            <ItemTemplate>



                <div class="row">
                    <div class="col-lg-12">
                        <div class="box box-default box-solid collapsed-box">
                            <div class="box-header with-border  bg-blue-gradient">

                                <span id="gun" class="col-xs-1" style="font-size: 50px; color: #1e1b1b"><%#Eval("Ziy_Tar","{0:%d}") %></span>
                                <span id="ay_yıl" class="col-xs-1" style="font-size: 22px; color: #1e1b1b"><%#Eval("Ziy_Tar","{0:% MMMM}") %></br><%#Eval("Ziy_Tar","{0:% yyyy}") %></span>
                                <span class="col-xs-1" style="font-size: 30px;"></span>
                                <span class="col-xs-2" style="font-size: 30px;" id="Sipariş_Toplam_Div_<%#Eval("Ziy_Tar","{0:yyyy-MM-dd}") %>">asdasd</span>
                                <span id="Header_Sayac_span_<%#Eval("Ziy_Tar","{0:%d}") %>" class="col-xs-3" style="font-size: 20px;"></span>
                                <span id="Gun_txt_1" class="col-xs-1" style="font-size: 20px"><%#Eval("Ziy_Tar","{0:% dddddd}") %></span>

                                <div class="box-tools ">

                                    <button type="button" class=" btn-primary no-border bg-blue-gradient" data-widget="collapse" style="font-size: 50px">

                                        <i class="fa fa-plus"></i>
                                    </button>
                                </div>
                                <!-- /.box-tools -->
                            </div>
                            <!-- /.box-header -->
                            <div class="box-body table-responsive" style="display: none;" id="Sipariş_Div_<%#Eval("Ziy_Tar","{0:yyyy-MM-dd}") %>">
                            </div>

                        </div>
                    </div>
                </div>

            </ItemTemplate>
        </asp:Repeater>
    </div>
    </div>
</asp:Content>
