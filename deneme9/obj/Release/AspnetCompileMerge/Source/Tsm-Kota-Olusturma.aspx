﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Bs.Master" AutoEventWireup="true" CodeBehind="Tsm-Kota-Olusturma.aspx.cs" Inherits="deneme9.Tsm_Kota_Olusturma" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        $(document).ready(function () {
            var Today = new Date();
            function formatDate(date) {
                var mName = ["Ocak", "Subat", "Mart", "Nisan", "Mayis", "Haziran", "Temmuz", "Agustos", "Eylul", "Ekim", "Kasim", "Aralik"];

                // (G1) DATE NOW
                var now = new Date(),
                    nowMth = now.getMonth(),
                    nowYear = parseInt(now.getFullYear());


                // (G2) APPEND MONTHS SELECTOR
                var month = $('select[id*=calmth]')

                //var go_month = window.location.href.split('?')[window.location.href.split('?').length - 1].split('=')[1].split('-')[1]
                //var go_year = window.location.href.split('?')[window.location.href.split('?').length - 1].split('=')[1].split('-')[0]
                for (var i = 0; i < 12; i++) {

                    month.append('<option value=' + parseInt(i + 1) + '>' + mName[i] + '</option>')

                    if (window.location.href.split('?').length > 1) {
                        var go_month = window.location.href.split('?')[window.location.href.split('?').length - 1].split('=')[1].split('-')[1]
                        month.val(go_month)
                    }
                    else {
                        if (i == nowMth) { month.val(nowMth + 1); }
                    }
                }
                //Bu aydan Sonraki Ayaı seçmek için
                for (var i = 0; i < 12; i++) {
                    if (i == nowMth + 1) { month.val(nowMth + 2); }
                }

                // (G3) APPEND YEARS SELECTOR
                // Set to 10 years range. Change this as you like.
                var year = $('select[id*=calyr]')
                for (var i = nowYear - 10; i <= nowYear + 10; i++) {
                    year.append('<option value=' + i + '>' + i + '</option>')

                    if (window.location.href.split('?').length > 1) {
                        var go_year = window.location.href.split('?')[window.location.href.split('?').length - 1].split('=')[1].split('-')[0]
                        year.val(go_year)
                    }
                    else {
                        if (i == nowYear) { year.val(i) }
                    }


                }
                var d = new Date(date),
                    month = '' + (d.getMonth() + 1),
                    day = '' + d.getDate(),
                    year = d.getFullYear();

                if (month.length < 2)
                    month = '0' + month;
                if (day.length < 2)
                    day = '0' + day;

                return [year, month, day].join('-');
            }
            var Bu_Gün__ = formatDate(Today)
            $.ajax({
                url: 'Bs-Anasayfa.aspx/Tablo_Doldur',
                type: 'POST',
                data: "{'parametre':'asd'}",
                async: false,
                dataType: "json",
                contentType: "application/json; charset=utf-8",

                success: function (data) {
                    var Kullanıcılar = $('div[id=Kullanıcılar]')
                    var temp = JSON.parse(data.d)
                    for (var i = 0; i < temp.length; i++) {
                        var Toplam_Doktor_Ziy = parseInt(temp[i].Ziy_Bekeleyen_Dok) + parseInt(temp[i].Ziy_Edilen_Dok) + parseInt(temp[i].Ziy_Edilemeyen_Dok);
                        var Doktor_Bekliyen_Ziy_yüz;
                        var Doktor_Edilen_Ziy_yüz;
                        var Doktor_Edilemeyen_Ziy_yüz;
                        if (Toplam_Doktor_Ziy != 0) {
                            Doktor_Bekliyen_Ziy_yüz = (parseInt(temp[i].Ziy_Bekeleyen_Dok) / Toplam_Doktor_Ziy) * 100;
                            Doktor_Edilen_Ziy_yüz = (parseInt(temp[i].Ziy_Edilen_Dok) / Toplam_Doktor_Ziy) * 100;
                            Doktor_Edilemeyen_Ziy_yüz = (parseInt(temp[i].Ziy_Edilemeyen_Dok) / Toplam_Doktor_Ziy) * 100;
                        }
                        else {
                            Doktor_Bekliyen_Ziy_yüz = 0;
                            Doktor_Edilen_Ziy_yüz = 0;
                            Doktor_Edilemeyen_Ziy_yüz = 100;
                        }


                        var Toplam_Eczane_Ziy = parseInt(temp[i].Ziy_Bekeleyen_Ecz) + parseInt(temp[i].Ziy_Edilen_Ecz) + parseInt(temp[i].Ziy_Edilemeyen_Ecz);
                        var Eczane_Bekliyen_Ziy_yüz;
                        var Eczane_Edilen_Ziy_yüz;
                        var Eczane_Edilemeyen_Ziy_yüz;

                        if (Toplam_Eczane_Ziy != 0) {
                            Eczane_Bekliyen_Ziy_yüz = (parseInt(temp[i].Ziy_Bekeleyen_Ecz) / Toplam_Eczane_Ziy) * 100;
                            Eczane_Edilen_Ziy_yüz = (parseInt(temp[i].Ziy_Edilen_Ecz) / Toplam_Eczane_Ziy) * 100;
                            Eczane_Edilemeyen_Ziy_yüz = (parseInt(temp[i].Ziy_Edilemeyen_Ecz) / Toplam_Eczane_Ziy) * 100;
                        }
                        else {
                            Eczane_Bekliyen_Ziy_yüz = 0;
                            Eczane_Edilen_Ziy_yüz = 0;
                            Eczane_Edilemeyen_Ziy_yüz = 100;
                        }
                        var Performas_;
                        if (temp[i].Performans == "") {
                            Performas_ = 0;
                        }
                        else {
                            Performas_ = temp[i].Performans;
                        }

                        var myvar = '<div class="col-md-6">' +
                            '        <!-- Widget: user widget style 1 -->' +
                            '        <div class="box box-widget widget-user-2">' +
                            '            <!-- Add the bg color to the header using any of the bg-* classes -->' +
                            '            <div class="widget-user-header bg-teal">' +
                            '                <div class="row">' +
                            '                    <div class="col-xs-4">' +
                            '                        <div class="widget-user-image" style="padding: 10px">' +
                            '                            <img class="img-circle" style="width:100px; height:100px; " src="' + temp[i].Kullanıcı_Profil_Photo + '" alt="User Avatar" />' +
                            '                        </div>' +
                            '                    </div>' +
                            '                    <div class="col-xs-8">' +
                            '                        <!-- /.widget-user-image -->' +
                            '                        <h3 class="widget-user-username">' + temp[i].Ad + ' ' + temp[i].Soyad + ' </h3>' +
                            '                        <h5 class="widget-user-desc">' + temp[i].Grup_Tam_Ad + ' (' + temp[i].Grup_Kısa_Ad + ')</h5>' +
                            '                        <h5 class="widget-user-desc">Ziyaret Performansı:   % ' + Performas_ + '</h5>' +
                            '                    </div>' +
                            '                </div>' +
                            '            </div>' +
                            '            <div class="box-footer no-padding">' +
                            '                <ul class="nav nav-stacked">' +
                            '                    <li>' +
                            '                        <a Kullanıcı_Id="' + temp[i].Kullanıcı_Id + '" id="Kota_Olustur">Tsm aylık kotasını oluşturmak için tıklayın</a>' +
                            '                     </li>' +
                            '                    <li>' +
                            '                        <a Kullanıcı_Id="' + temp[i].Kullanıcı_Id + '" id="Kota_İncele_Düzenle">Tsm aylık kotasını incelemek ve düzenlemek  için tıklayın</a>' +
                            '                </ul>' +
                            '            </div>' +
                            '        </div>' +
                            '        <!-- /.widget-user -->' +
                            '    </div>';
                        Kullanıcılar.append(myvar);
                    }

                },
                error: function () {
                    alert('Talep esnasında sorun oluştu.Yeniden deneyin');
                }
            });
            var Kota_Düzenle_Sil = $('button[id=Kota_Düzenle_Sil]')
            var Kotay_Sil_Modal_Btn = $('button[id=Kotay_Sil_Modal_Btn]')
            Kota_Düzenle_Sil.click(function () {
                $('#Kota_Düzenle_İncele').modal('toggle');
                $('#myModal').modal('show');


            })
            Kotay_Sil_Modal_Btn.click(function () {
                var calmth_İncele = $('select[id=calmth_İncele]')
                var calyr_İncele = $('select[id=calyr_İncele]')
                var Yıl = calyr_İncele.val()
                var Ay = calmth_İncele.val()
                $.ajax({
                    url: 'Tsm-Kota-Olusturma.aspx/Kota_Kaldır',
                    dataType: 'json',
                    type: 'POST',
                    async: false,

                    data: "{'Kullanıcı_Id': '" + calmth_İncele.attr('Kullanıcı_Id') + "','Tarih':'" + Yıl + "-" + Ay + "-1" + "'}",
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {
                        $('#myModal').modal('toggle');
                    },// tekrar eklemeyi önlemek için eklenen doktorları tabloya kaydet sonra ona göre listele xd
                    error: function () {
                        alert('Talep esnasında sorun oluştu.Yeniden deneyin');
                    }
                });
            })
           
            var Kota_İncele_Düzenle = $('a[id=Kota_İncele_Düzenle]')
            Kota_İncele_Düzenle.click(function () {
                $('#Kota_Düzenle_İncele').modal('show')
                var calmth_İncele = $('select[id=calmth_İncele]')
                calmth_İncele.attr('Kullanıcı_Id', $(this).attr('Kullanıcı_Id'))
                var calyr_İncele = $('select[id=calyr_İncele]')
                calyr_İncele.attr('Kullanıcı_Id', $(this).attr('Kullanıcı_Id'))
                var Yıl = calyr_İncele.val()
                var Ay = calmth_İncele.val()
                $.ajax({
                    url: 'Tsm-Kota-Olusturma.aspx/Kota_Detay',
                    dataType: 'json',
                    type: 'POST',
                    async: false,

                    data: "{'Kullanıcı_Id': '" + $(this).attr('Kullanıcı_Id') + "','Tarih':'" + Yıl + "-" + Ay + "-1" + "'}",
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {
                        Liste_İncele_Düzenle = [];
                        var temp = JSON.parse(data.d);
                     
                        for (var i = 0; i < temp.length; i++) {
                            var MyClass = {
                                Urun_Adı: null,
                                Adet: null,
                                Hedef: null,
                                Tamamlanan: null,
                                Yüzde: null
                            }
                            MyClass.Urun_Adı = temp[i].Urun_Adı;
                            MyClass.Adet = temp[i].Adet;
                            MyClass.Hedef = temp[i].Hedef;
                            MyClass.Tamamlanan = temp[i].Tamamlanan;
                            MyClass.Yüzde = temp[i].Yüzde;

                            Liste_İncele_Düzenle.push(MyClass);
                        }
                       
                  

                       
                        Tabloyu_Doldur_İncele_Düzenle(Liste_İncele_Düzenle)
                      
                    },// tekrar eklemeyi önlemek için eklenen doktorları tabloya kaydet sonra ona göre listele xd
                    error: function () {
                        alert('Talep esnasında sorun oluştu.Yeniden deneyin');
                    }
                });
                

            });
            var calmth_İncele = $('select[id=calmth_İncele]')
            var calyr_İncele = $('select[id=calyr_İncele]')
            calmth_İncele.change(function () {
                var calmth_İncele = $('select[id=calmth_İncele]')
                var calyr_İncele = $('select[id=calyr_İncele]')
                var Yıl = calyr_İncele.val()
                var Ay = calmth_İncele.val()
                $.ajax({
                    url: 'Tsm-Kota-Olusturma.aspx/Kota_Detay',
                    dataType: 'json',
                    type: 'POST',
                    async: false,

                    data: "{'Kullanıcı_Id': '" + $(this).attr('Kullanıcı_Id') + "','Tarih':'" + Yıl + "-" + Ay + "-1" + "'}",
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {
                        Liste_İncele_Düzenle = [];
                        var temp = JSON.parse(data.d);
                      
                        for (var i = 0; i < temp.length; i++) {
                            var MyClass = {
                                Urun_Adı: null,
                                Adet: null,
                                Hedef: null,
                                Tamamlanan: null,
                                Yüzde: null
                            }
                            MyClass.Urun_Adı = temp[i].Urun_Adı;
                            MyClass.Adet = temp[i].Adet;
                            MyClass.Hedef = temp[i].Hedef;
                            MyClass.Tamamlanan = temp[i].Tamamlanan;
                            MyClass.Yüzde = temp[i].Yüzde;

                            Liste_İncele_Düzenle.push(MyClass);
                        }




                        Tabloyu_Doldur_İncele_Düzenle(Liste_İncele_Düzenle)

                    },// tekrar eklemeyi önlemek için eklenen doktorları tabloya kaydet sonra ona göre listele xd
                    error: function () {
                        alert('Talep esnasında sorun oluştu.Yeniden deneyin');
                    }
                });
            })
            calyr_İncele.change(function () {
                var calmth_İncele = $('select[id=calmth_İncele]')
                var calyr_İncele = $('select[id=calyr_İncele]')
                var Yıl = calyr_İncele.val()
                var Ay = calmth_İncele.val()
                $.ajax({
                    url: 'Tsm-Kota-Olusturma.aspx/Kota_Detay',
                    dataType: 'json',
                    type: 'POST',
                    async: false,

                    data: "{'Kullanıcı_Id': '" + $(this).attr('Kullanıcı_Id') + "','Tarih':'" + Yıl + "-" + Ay + "-1" + "'}",
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {
                        Liste_İncele_Düzenle = [];
                        var temp = JSON.parse(data.d);
                    
                        for (var i = 0; i < temp.length; i++) {
                            var MyClass = {
                                Urun_Adı: null,
                                Adet: null,
                                Hedef: null,
                                Tamamlanan: null,
                                Yüzde: null
                            }
                            MyClass.Urun_Adı = temp[i].Urun_Adı;
                            MyClass.Adet = temp[i].Adet;
                            MyClass.Hedef = temp[i].Hedef;
                            MyClass.Tamamlanan = temp[i].Tamamlanan;
                            MyClass.Yüzde = temp[i].Yüzde;

                            Liste_İncele_Düzenle.push(MyClass);
                        }




                        Tabloyu_Doldur_İncele_Düzenle(Liste_İncele_Düzenle)

                    },// tekrar eklemeyi önlemek için eklenen doktorları tabloya kaydet sonra ona göre listele xd
                    error: function () {
                        alert('Talep esnasında sorun oluştu.Yeniden deneyin');
                    }
                });
            })
            var Liste_İncele_Düzenle = [];
            Tabloyu_Doldur_İncele_Düzenle(Liste_İncele_Düzenle)
            function Tabloyu_Doldur_İncele_Düzenle(Liste_) {
                $('#Tablo_Div_İncele').empty();

                $('#Tablo_Div_İncele').append('<table id="example_incele" class="display" style="width: 100%">' +
                    '<thead>' +
                    '<tr>' +
                    '<th>Urun Adı</th>' +
                    '<th>Adet</th>' +
                    '<th>Hedef Kota</th>' +
                    '<th>Tamamlanan</th>' +
                    '<th>Yüzde Oran</th>' +
                 
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
                    '</tr>' +
                    '</tfoot>' +
                    '</table>'
                );


                if (Liste_.length > 0) {
                    var Tbody = $('tbody[id=Tbody_İncele]')



                    for (var i = 0; i < Liste_.length; i++) {
                        console.log(Liste_[i].Adet)
                        Tbody.append(
                            '<tr>' +
                            '<td>' + Liste_[i].Urun_Adı + '</td>' +
                            '<td>' + Liste_[i].Adet + '</td>' +
                            '<td>' + Liste_[i].Hedef + '₺</td>' +
                            '<td>' + Liste_[i].Tamamlanan + '₺</td>' +
                            '<td>%' + Liste_[i].Yüzde + '</td>' +
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
                    dom: 'Blfrtip',
                    buttons: [

                        {

                            extend: 'pdfHtml5',
                            title: function () {
                                return "Kota_Onlizleme" + "_" + Kullanıcı_Adı + "_" + dateTime;
                            },
                            pageSize: 'LEGAL',
                            titleAttr: 'PDF',
                            exportOptions: {
                                columns: [0, 1, 2]
                            },

                            customize: function (doc) {
                                doc.content[1].table.widths =
                                    Array(doc.content[1].table.body[0].length + 1).join('*').split('');

                                doc.content.splice(0, 1);

                                var now = new Date();
                                var jsDate = now.getDate() + '-' + (now.getMonth() + 1) + '-' + now.getFullYear();

                                var logo = 'data:image/png;base64,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';



                                doc.pageMargins = [20, 150, 20, 30];

                                doc.defaultStyle.fontSize = 7;



                                doc.styles.tableHeader.fontSize = 7;

                                doc['header'] = (function () {
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
                                                text: 'Sipariş Önizleme',
                                                fontSize: 18,
                                                absolutePosition: { x: 15, y: 30 }
                                            },
                                            {
                                                alignment: 'right',
                                                fontSize: 14,
                                                text: Kullanıcı_Adı + " " + dateTime
                                            },

                                        ],
                                        margin: 20
                                    }
                                });
                                // Create a footer object with 2 columns
                                // Left side: report creation date
                                // Right side: current page and total pages
                                doc['footer'] = (function (page, pages) {
                                    return {
                                        columns: [
                                            {
                                                alignment: 'left',
                                                text: ['Created on: ', { text: jsDate.toString() }]
                                            },
                                            {
                                                alignment: 'right',
                                                text: ['page ', { text: page.toString() }, ' of ', { text: pages.toString() }]
                                            }
                                        ],
                                        margin: 20
                                    }
                                });
                                // Change dataTable layout (Table styling)
                                // To use predefined layouts uncomment the line below and comment the custom lines below
                                // doc.content[0].layout = 'lightHorizontalLines'; // noBorders , headerLineOnly
                                var objLayout = {};
                                objLayout['hLineWidth'] = function (i) { return .5; };
                                objLayout['vLineWidth'] = function (i) { return .5; };
                                objLayout['hLineColor'] = function (i) { return '#aaa'; };
                                objLayout['vLineColor'] = function (i) { return '#aaa'; };
                                objLayout['paddingLeft'] = function (i) { return 10; };
                                objLayout['paddingRight'] = function (i) { return 10; };
                                doc.content[0].layout = objLayout;


                            },
                            footer: true
                        }
                    ]

                });
                var Siparişi_Kaldır = $('a[id=Siparişi_Kaldır]')
                Siparişi_Kaldır.click(function () {
                    const array = Liste_
                    array.splice($(this).attr("value"), 1);
                    Tabloyu_Doldur(array)
                    var Urunler = $('select[id=Urunler]').prepend("<option Guncel_DSF='" + $(this).attr('Guncel_DSF') + "' Urun_Id='" + $(this).attr('İlaç_id') + "'>" + $(this).attr('İlaç_ad') + "</option>")
                    Urunler.val($(this).attr('İlaç_ad'))
                })
            }
            $('input[id=Adet_input]').on('input keydown keyup mousedown mouseup select contextmenu drop', function () {
                var Adet_input = $('input[id=Adet_input]')
                var Urunler = $('select[id=Urunler]')
                var Fiyat_İnput = $('input[id=Fiyat_İnput]')
                if ($(this).val()=="") {
                    Fiyat_İnput.val()
                }
                if ($(this).val()!="") {
                    $.ajax({
                        url: 'Siparis-Olustur.aspx/Birim_Fiyat_Hesapla',
                        type: 'POST',
                        data: "{'Guncel_DSF': '" + Urunler.find('option:selected').attr('Guncel_DSF') + "','Adet':'" + Adet_input.val() + "','Mf_Adet':'0'}",
                        async: false,
                        global: false,
                        dataType: "json",
                        contentType: "application/json; charset=utf-8",
                        success: function (data) {

                            var temp = JSON.parse(data.d)
                            Fiyat_İnput.val(temp.Satış_Fiyatı_Toplam)


                        },
                        error: function () {

                            alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                        }
                    });
                }
               
               
            })
            var Liste = [];
            var Ekle = $('button[id=Ekle]')
            Ekle.click(function () {
                var Urunler = $('select[id=Urunler]')
                var Adet_input = $('input[id=Adet_input]')
                var Fiyat_İnput = $('input[id=Fiyat_İnput]')
                var MyClass = {
                    İlaç_Ad: null,
                    ilaç_id: null,
                    Adet: null,
                    Hedef_Kota: null,
                    Guncel_DSF:null
                }
                console.log(Adet_input.val())
                MyClass.ilaç_id = Urunler.find('option:selected').attr('urun_id');
                MyClass.Guncel_DSF = Urunler.find('option:selected').attr('Guncel_DSF')
                MyClass.İlaç_Ad = Urunler.find('option:selected').val();
                MyClass.Adet = Adet_input.val();
                MyClass.Hedef_Kota = Fiyat_İnput.val();

                Liste.push(MyClass);
                Tabloyu_Doldur(Liste)
                Urunler.find('option:selected').remove();
            });
          
            Tabloyu_Doldur(Liste)
            function Tabloyu_Doldur(Liste_) {
                $('#Tablo_Div').empty();

                $('#Tablo_Div').append('<table id="example" class="display" style="width: 100%">' +
                    '<thead>' +
                    '<tr>' +
                    '<th>Urun Adı</th>' +
                    '<th>Adet</th>' +
                    '<th>Hedef Kota</th>' +
                    '<th>Sil</th>' +
                    '</tr>' +
                    '</thead>' +
                    '<tbody id="Tbody">' +
                    '</tbody>' +
                    '<tfoot>' +
                    ' <tr>' +

                    '<th></th>' +
                    '<th></th>' +
                    '<th></th>' +
                    '<th></th>' +
                    '</tr>' +
                    '</tfoot>' +
                    '</table>'
                );



                if (Liste_.length > 0) {
                    var Tbody = $('tbody[id=Tbody]')



                    for (var i = 0; i < Liste_.length; i++) {
                        console.log(Liste_[i].Adet)
                        Tbody.append(
                            '<tr>' +
                            '<td>' + Liste_[i].İlaç_Ad  + '</td>' +
                            '<td>' + Liste_[i].Adet + '</td>' +
                            '<td>' + Liste_[i].Hedef_Kota + '</td>' +

                            '<td><a style="font-size: 20px; " Guncel_DSF="' + Liste_[i].Guncel_DSF+'" İlaç_Ad="' + Liste_[i].İlaç_Ad + '" İlaç_Id="' + Liste_[i].ilaç_id+'" id="Siparişi_Kaldır" value="' + i + '"><i class="fa fa-trash-o"></i></a></td>' +
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
                    global:false,
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

                $('#example').dataTable({

                    "lengthMenu": [10, 25, 50, 75, 100, 200, 500, 750, 1000],
                    "language": {
                        "url": "//cdn.datatables.net/plug-ins/1.10.22/i18n/Turkish.json"
                    },
                    dom: 'Blfrtip',
                    buttons: [

                        {

                            extend: 'pdfHtml5',
                            title: function () {
                                return "Kota_Onlizleme" + "_" + Kullanıcı_Adı + "_" + dateTime;
                            },
                            pageSize: 'LEGAL',
                            titleAttr: 'PDF',
                            exportOptions: {
                                columns: [0, 1, 2]
                            },

                            customize: function (doc) {
                                doc.content[1].table.widths =
                                    Array(doc.content[1].table.body[0].length + 1).join('*').split('');

                                doc.content.splice(0, 1);

                                var now = new Date();
                                var jsDate = now.getDate() + '-' + (now.getMonth() + 1) + '-' + now.getFullYear();

                                var logo = 'data:image/png;base64,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';



                                doc.pageMargins = [20, 150, 20, 30];

                                doc.defaultStyle.fontSize = 7;



                                doc.styles.tableHeader.fontSize = 7;

                                doc['header'] = (function () {
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
                                                text: 'Sipariş Önizleme',
                                                fontSize: 18,
                                                absolutePosition: { x: 15, y: 30 }
                                            },
                                            {
                                                alignment: 'right',
                                                fontSize: 14,
                                                text: Kullanıcı_Adı + " " + dateTime
                                            },

                                        ],
                                        margin: 20
                                    }
                                });
                                // Create a footer object with 2 columns
                                // Left side: report creation date
                                // Right side: current page and total pages
                                doc['footer'] = (function (page, pages) {
                                    return {
                                        columns: [
                                            {
                                                alignment: 'left',
                                                text: ['Created on: ', { text: jsDate.toString() }]
                                            },
                                            {
                                                alignment: 'right',
                                                text: ['page ', { text: page.toString() }, ' of ', { text: pages.toString() }]
                                            }
                                        ],
                                        margin: 20
                                    }
                                });
                                // Change dataTable layout (Table styling)
                                // To use predefined layouts uncomment the line below and comment the custom lines below
                                // doc.content[0].layout = 'lightHorizontalLines'; // noBorders , headerLineOnly
                                var objLayout = {};
                                objLayout['hLineWidth'] = function (i) { return .5; };
                                objLayout['vLineWidth'] = function (i) { return .5; };
                                objLayout['hLineColor'] = function (i) { return '#aaa'; };
                                objLayout['vLineColor'] = function (i) { return '#aaa'; };
                                objLayout['paddingLeft'] = function (i) { return 10; };
                                objLayout['paddingRight'] = function (i) { return 10; };
                                doc.content[0].layout = objLayout;


                            },
                            footer: true
                        }
                    ]

                });
                var Siparişi_Kaldır = $('a[id=Siparişi_Kaldır]')
                Siparişi_Kaldır.click(function () {
                    const array = Liste_
                    array.splice($(this).attr("value"), 1);
                    Tabloyu_Doldur(array)
                    var Urunler = $('select[id=Urunler]').prepend("<option Guncel_DSF='" + $(this).attr('Guncel_DSF') + "' Urun_Id='" + $(this).attr('İlaç_id') + "'>" + $(this).attr('İlaç_ad') + "</option>")
                    Urunler.val($(this).attr('İlaç_ad'))
                })
            }

            var Kota_Olustur = $('a[id=Kota_Olustur]')
            Kota_Olustur.click(function () {

                var Kota_Olustur_Gönder = $('button[id=Kota_Olustur_Gönder]')
                Kota_Olustur_Gönder.attr('Kullanıcı_Id', $(this).attr('Kullanıcı_Id'))

                $.ajax({
                    url: 'Birim-Fiyat.aspx/Urunler',
                    dataType: 'json',
                    type: 'POST',
                    async: false,
                    global: false,
                    data: "{'Şehir_Id': ''}",
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {
                        $('input[id=Adet_input]').val('')
                        $('input[id=Fiyat_İnput]').val('')
                        Liste = [];
                        Tabloyu_Doldur(Liste)
                        var temp = JSON.parse(data.d)
                        var Urunler = $('select[id=Urunler]')
                        Urunler.empty();
                        for (var i = 0; i < temp.length; i++) {
                            Urunler.append("<option Guncel_DSF='" + temp[i].Guncel_DSF + "' Urun_Id='" + temp[i].İlaç_Id + "'>" + temp[i].İlaç_Adı + "</option>")
                        }
                        $('#Kota_Oluştur_Modal').modal('show')
                    },// tekrar eklemeyi önlemek için eklenen doktorları tabloya kaydet sonra ona göre listele xd
                    error: function () {
                        alert('Talep esnasında sorun oluştu.Yeniden deneyin');
                    }
                });

            });
            var Kota_Olustur_Gönder = $('button[id=Kota_Olustur_Gönder]')
            Kota_Olustur_Gönder.click(function () {
                var Ay = $('select[id=calmth]').find('option:selected').attr('value') 
                var Yıl = $('select[id=calyr]').find('option:selected').attr('value') 
                
                $.ajax({
                    url: 'Tsm-Kota-Olusturma.aspx/Kota_Olustur',
                    dataType: 'json',
                    type: 'POST',
                    async: false,
                   
                    data: "{'Kullanıcı_Id': '" + $(this).attr('Kullanıcı_Id') + "','Urun_Tablo':'{Deneme:" + JSON.stringify(Liste) + "}','Tarih':'" + Yıl + "-" + Ay+"-1" + "'}",
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {
                        Liste = [];
                        var temp = JSON.parse(data.d)

                        if (temp[0].Onay_Durum == "") {
                            $('#Mesaj').attr('class', 'modal modal-danger  fade')
                            var Mesaj = $('#Mesaj').find('div[id=Modal_Body]')
                            Mesaj.empty();
                            Mesaj.append("   < div class='row' >  <div class='col-xs-12'>  <label id='İşlem_Mesajı'></label> </div>     </div >")
                            $('#Mesaj').find('label[id=İşlem_Mesajı]').html("İşlem Sırasında Bir Hata Oluştu Lütfen Gerekli Yerlere Bildiriniz")
                        }

                        if (temp[0].Onay_Durum == "0") {
                            $('#Mesaj').attr('class', 'modal fade')
                            var Mesaj = $('#Mesaj').find('div[id=Modal_Body]')
                            Mesaj.empty();
                            Mesaj.append("<div class='row'><div class='col-xs-12'><label id='İşlem_Mesajı'></label> </div></div >")
                            $('#Mesaj').find('label[id=İşlem_Mesajı]').html("Talep Başarı İle İletilmiştir")
                        }
                        if (temp[0].Onay_Durum == "1") {
                            $('#Mesaj').attr('class', 'modal modal-warning fade')
                            var Mesaj = $('#Mesaj').find('div[id=Modal_Body]')
                            Mesaj.empty();
                            Mesaj.append("<div class='row'><div class='col-xs-12'><label id='İşlem_Mesajı'></label> </div></div >")
                            $('#Mesaj').find('label[id=İşlem_Mesajı]').html("Talep Daha Önceden Gönderilmiş")
                           
                        }
                      
                        $('#Kota_Oluştur_Modal').modal('toggle')
                        $('#Mesaj').modal('show')
                    },// tekrar eklemeyi önlemek için eklenen doktorları tabloya kaydet sonra ona göre listele xd
                    error: function () {
                        alert('Talep esnasında sorun oluştu.Yeniden deneyin');
                    }
                });


            })
        })
    </script>

  

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="vertical-alignment-helper">
            <div class="modal-dialog vertical-align-center">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">
                            <span aria-hidden="true">&times;</span><span class="sr-only">Close</span>

                        </button>
                        <h4 class="modal-title" id="myModalLabel">Kotayı Sil</h4>

                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-xs-12">
                                <label>Kotayı silerseniz tüm kota verileri silinecektir!</label>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Kapat</button>
                        <button type="button" id="Kotay_Sil_Modal_Btn" class="btn btn-primary">Kotayı Sil</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div id="Mesaj" style="overflow-y:auto;" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">İşlem Sonucu</h4>
                </div>
                <div class="modal-body" id="Modal_Body">
                    <div class="row">
                        <div class="col-xs-12">
                              <label id="İşlem_Mesajı"></label>
                        </div>
                    </div>
                    
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                </div>
            </div>

        </div>
    </div>
      <div id="Kota_Düzenle_İncele" class="modal fade" role="dialog">
        <div class="modal-dialog modal-lg">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 id="Kota_Düzenle_İncele_Modal_Baslık" class="modal-title">Kota İncele-Düzenle</h4>
                </div>
                <div class=" modal-body" id="Kota_Düzenle_İncele_Modal_Body">
                    <div class="row">
                        <div class="col-xs-6">
                            <label>Ay</label>
                            <div class="form-group">
                                <select id="calmth_İncele" class="form-control"></select>
                            </div>
                        </div>
                        <div class="col-xs-6">
                            <label>Yıl</label>
                            <div class="form-group">
                                <select id="calyr_İncele" class="form-control"></select>
                            </div>
                        </div>
                    </div>
                  
                    <div class="row">
                        <div class="col-xs-12">
                            <div id="Tablo_Div_İncele"></div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" id="Kota_İncele_Düzenle_Modal_Kapat" class="btn btn-default" data-dismiss="modal">Kapat</button>
                        <button type="button" id="Kota_Düzenle_Sil" class="btn btn-warning">Kotayı Sil</button>
                </div>
            </div>
        </div>
    </div>

    <div id="Kota_Oluştur_Modal" class="modal fade" role="dialog">
        <div class="modal-dialog modal-lg">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 id="Koçluk_Formu_Modal_Baslık" class="modal-title">Kota Olustur</h4>
                </div>
                <div class=" modal-body" id="Kota_Olustur_modal_Body">
                    <div class="row">
                        <div class="col-xs-6">
                            <label>Ay</label>
                            <div class="form-group">
                                <select id="calmth" class="form-control"></select>
                            </div>
                        </div>
                        <div class="col-xs-6">
                            <label>Yıl</label>
                            <div class="form-group">
                                <select id="calyr" class="form-control"></select>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-xs-6">
                            <label>Lütfen Ürün Seçiniz</label>
                        </div>
                        <div class="col-xs-2">
                            <label>Adet</label>
                        </div>
                        <div class="col-xs-3">
                            <label>Hedef Kota:</label>
                        </div>

                    </div>
                    <div class="row">
                        <div class="col-xs-6">
                            <div class="form-group">
                                <select class="form-control" id="Urunler"></select>
                            </div>
                        </div>
                        <div class="col-xs-2">
                            <div class="form-group">
                                <input class="form-control" type="number" id="Adet_input" />
                            </div>
                        </div>
                        <div class="col-xs-2">
                            <div class="form-group">
                                <input class="form-control" id="Fiyat_İnput" disabled />
                            </div>
                        </div>
                        <div class="col-xs-2">
                            <div class="form-group">
                                <button class="btn btn-block btn-primary" onclick="return false;" id="Ekle">Ekle</button>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-xs-12">
                            <div id="Tablo_Div"></div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" id="Koçluk_Formu_Modal_Kapat" class="btn btn-default" data-dismiss="modal">Kapat</button>
                    <button type="button" id="Kota_Olustur_Gönder" class="btn btn-primary">Kota Oluştur</button>
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <div id="Kullanıcılar">
        </div>
    </div>


</asp:Content>
