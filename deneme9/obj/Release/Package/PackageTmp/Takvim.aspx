<%@ Page Title="" Language="C#" MasterPageFile="~/admin.Master" AutoEventWireup="true" CodeBehind="Takvim.aspx.cs" Inherits="deneme9.Takvim" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <link href="calendar.css" rel="stylesheet" />
    <style>
        /* FROM HTTP://WWW.GETBOOTSTRAP.COM
     * Glyphicons
     *
     * Special styles for displaying the icons and their classes in the docs.
     */

        a {
            color: inherit;
            text-decoration: none;
        }

            a:hover {
                color: inherit;
                text-decoration: none;
            }

        .gunbs-glyphicons {
            padding-left: 0;
            padding-bottom: 1px;
            margin-bottom: 20px;
            list-style: none;
            overflow: hidden;
        }

            .gunbs-glyphicons li {
                float: left;
                width: 25%;
                height: 35px;
                padding: 10px;
                margin: 0 -1px -1px 0;
                font-size: 12px;
                line-height: 1.4;
                text-align: center;
                border: 1px solid #ddd;
            }

            .gunbs-glyphicons .glyphicon {
                margin-top: 5px;
                margin-bottom: 10px;
                font-size: 24px;
            }

            .gunbs-glyphicons .glyphicon-class {
                display: block;
                text-align: center;
                word-wrap: break-word;
            }

            .gunbs-glyphicons li:hover {
                background-color: rgba(86, 61, 124, .1);
            }

        @media (min-width: 150px) {
            .gunbs-glyphicons li {
                width: 12.5%;
            }
        }

        .bs-glyphicons {
            padding-left: 0;
            padding-bottom: 1px;
            margin-bottom: 20px;
            list-style: none;
            overflow: hidden;
        }


            .bs-glyphicons li {
                float: left;
                width: 25%;
                height: 115px;
                padding: 1px;
                margin: 0 -1px -1px 0;
                font-size: 9px;
                line-height: 1.4;
                text-align: center;
                border: 1px solid #ddd;
            }

            .bs-glyphicons .glyphicon {
                margin-top: 5px;
                margin-bottom: 10px;
                font-size: 24px;
            }

            .bs-glyphicons .glyphicon-class {
                display: block;
                text-align: center;
                word-wrap: break-word; /* Help out IE10+ with class names */
            }

            .bs-glyphicons li:hover {
                background-color: rgba(86, 61, 124, .1);
            }

        @media (min-width: 150px) {
            .bs-glyphicons li {
                height: 115px;
                width: 12.5%;
            }
        }

        .disabled {
            pointer-events: none;
            opacity: 0.6;
        }

        #Gun {
            z-index: 99;
            cursor: pointer;
        }
    </style>

    <script type="text/javascript">




        $(document).ready(function () {
            $('.modal').on("hidden.bs.modal", function (e) {
                if ($('.modal:visible').length) {
                    $('body').addClass('modal-open');
                }
            });

            var mName = ["Ocak", "Subat", "Mart", "Nisan", "Mayis", "Haziran", "Temmuz", "Agustos", "Eylul", "Ekim", "Kasim", "Aralik"];



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
                    if (i == nowMth) { month.val(nowMth + 1) }
                }



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
            //cal_set
            //$('select[id*calmth]')
            //$('select[id*calyr]')
            $('input[id*=cal_set]').click(function () {
                var calyr = $('select[id=calyr]');
                var calmth = $('select[id=calmth]')
                window.location.href = "/Takvim.aspx?x=" + calyr.val() + "-" + calmth.val()

            });
            var tab_div = $('div[id=glyphicons]')
            Tabloyu_Doldur_();


            function Tabloyu_Doldur_() {

                tab_div.find($('ul[id=hafta_' + "0" + ']')).remove()
                tab_div.find($('ul[id=hafta_' + "1" + ']')).remove()
                tab_div.find($('ul[id=hafta_' + "2" + ']')).remove()
                tab_div.find($('ul[id=hafta_' + "3" + ']')).remove()
                tab_div.find($('ul[id=hafta_' + "4" + ']')).remove()
                tab_div.find($('ul[id=hafta_' + "5" + ']')).remove()

                if (window.location.href.split('?').length > 1) {
                    var go_month = window.location.href.split('?')[window.location.href.split('?').length - 1].split('=')[1].split('-')[1]
                    var go_year = window.location.href.split('?')[window.location.href.split('?').length - 1].split('=')[1].split('-')[0]
                    $.ajax({
                        url: 'Takvim.aspx/Haftanın_Gunleri',
                        dataType: 'json',
                        type: 'POST',
                        async: true,
                        data: "{'parametre':'" + parseInt(go_month) + "-" + go_year + "'}",
                        contentType: 'application/json; charset=utf-8',
                        success: function (data) {





                            var sayaç = 0;


                            for (var i = 0; i < 6; i++) {

                                tab_div.append("<ul id='hafta_" + i + "'  class='bs-glyphicons'><a href = '' ><li><span style='font-size: 20px; text-align: center'>" + (i + 1) + ". Hafta</span></li></a></ul>");

                                for (var j = 0; j < 7; j++) {

                                    if (data.d.split('!')[sayaç] == 'empty') {


                                        tab_div.find($('ul[id=hafta_' + i + ']')).append("<li></li>");


                                    }
                                    else {
                                        var yuzde_doktor;
                                        if (parseInt(data.d.split('!')[sayaç].split('-')[8]) == 0) {
                                            yuzde_doktor = 0;
                                        }
                                        else {
                                            yuzde_doktor = (parseInt(data.d.split('!')[sayaç].split('-')[8]) * 100) / parseInt(data.d.split('!')[sayaç].split('-')[7]);


                                        }

                                        var yuzde_eczane;
                                        if (parseInt(data.d.split('!')[sayaç].split('-')[9]) == 0) {
                                            yuzde_eczane = 0;
                                        }
                                        else {
                                            yuzde_eczane = (parseInt(data.d.split('!')[sayaç].split('-')[9]) * 100) / parseInt(data.d.split('!')[sayaç].split('-')[6]);
                                        }




                                        var Doktor_bar_oran = "<span class='progress-number' style='font-size:15px'><b>" + parseInt(data.d.split('!')[sayaç].split('-')[9]) + "</b>/" + parseInt(data.d.split('!')[sayaç].split('-')[6]) + "</span>";

                                        var Doktor_Bar_oran_bar = "<div class='progress-bar progress-bar-aqua' style='width: " + yuzde_eczane + "%'></div>";
                                        var Doktor_Bar_oran_bar_div = "<div class='progress sm'>" + Doktor_Bar_oran_bar + "</div>";
                                        var Doktor_bar_div = "<div class='progress-group'>" + Doktor_bar_oran + Doktor_Bar_oran_bar_div + "</div>";



                                        var Eczane_bar_oran = "<span class='progress-number' style='font-size:15px'><b>" + parseInt(data.d.split('!')[sayaç].split('-')[8]) + "</b>/" + parseInt(data.d.split('!')[sayaç].split('-')[7]) + "</span></br>";

                                        var Eczane_Bar_oran_bar = "<div class='progress-bar progress-bar-green' style='width: " + yuzde_doktor + "%'></div>";
                                        var Eczane_Bar_oran_bar_div = "<div class='progress sm'>" + Eczane_Bar_oran_bar + "</div>";
                                        var Eczane_bar_div = "<div class='progress-group'>" + Eczane_bar_oran + Eczane_Bar_oran_bar_div + "</div>";




                                        var Span_gun = "<span style='font-size: 20px'>" + parseInt(data.d.split('!')[sayaç].split('-')[0].split('.')[0]) + " " + mName[parseInt(data.d.split('!')[sayaç].split('-')[0].split('.')[1] - 1)] + "</span>";
                                        if (sayaç % 7 == 6 || sayaç % 7 == 5) {

                                            var Sutun = "<li class='disabled' id='Gun' ziy_ıd='" + data.d.split('!')[sayaç].split('-')[1] + "' >" + Span_gun + Eczane_bar_div + Doktor_bar_div + "</li>";

                                        }
                                        else {
                                            var Sutun = "<li data-toggle='modal' data-target='#Ziyaret_Modal'  id='Gun' ziy_ıd='" + data.d.split('!')[sayaç].split('-')[1] + "' >" + Span_gun + Eczane_bar_div + Doktor_bar_div + "</li>";

                                        }
                                        tab_div.find($('ul[id=hafta_' + i + ']')).append(Sutun);
                                    }

                                    sayaç++;
                                }

                            }

                        },
                        error: function () {
                            alert('Talep esnasında sorun oluştu.Yeniden deneyin');
                        }

                    });
                }
                else {
                    $.ajax({
                        url: 'Takvim.aspx/Haftanın_Gunleri',
                        dataType: 'json',
                        type: 'POST',
                        async: true,
                        data: "{'parametre':'" + parseInt(nowMth + 1) + "-" + nowYear + "'}",
                        contentType: 'application/json; charset=utf-8',
                        success: function (data) {






                            var sayaç = 0;


                            for (var i = 0; i < 6; i++) {

                                tab_div.append("<ul id='hafta_" + i + "'  class='bs-glyphicons'><a href = '' ><li><span style='font-size: 20px; text-align: center'>" + (i + 1) + ". Hafta</span></li></a></ul>");

                                for (var j = 0; j < 7; j++) {


                                    if (data.d.split('!')[sayaç] == 'empty') {


                                        tab_div.find($('ul[id=hafta_' + i + ']')).append("<li></li>");


                                    }
                                    else {
                                        var yuzde_eczane;
                                        if (parseInt(data.d.split('!')[sayaç].split('-')[8]) == 0) {
                                            yuzde_eczane = 0;
                                        }
                                        else {
                                            yuzde_eczane = (parseInt(data.d.split('!')[sayaç].split('-')[8]) * 100) / parseInt(data.d.split('!')[sayaç].split('-')[7]);

                                        }

                                        var yuzde_doktor;
                                        if (parseInt(data.d.split('!')[sayaç].split('-')[9]) == 0) {
                                            yuzde_doktor = 0;
                                        }
                                        else {
                                            yuzde_doktor = (parseInt(data.d.split('!')[sayaç].split('-')[9]) * 100) / parseInt(data.d.split('!')[sayaç].split('-')[6]);
                                        }


                                        var Doktor_bar_oran = "<span class='progress-number' style='font-size:15px'><b>" + parseInt(data.d.split('!')[sayaç].split('-')[9]) + "</b>/" + parseInt(data.d.split('!')[sayaç].split('-')[6]) + "</span>";
                                        var Doktor_Bar_oran_bar = "<div class='progress-bar progress-bar-aqua' style='width: " + yuzde_doktor + "%'></div>";
                                        var Doktor_Bar_oran_bar_div = "<div class='progress sm'>" + Doktor_Bar_oran_bar + "</div>";
                                        var Doktor_bar_div = "<div class='progress-group'>" + Doktor_bar_oran + Doktor_Bar_oran_bar_div + "</div>";




                                        var Eczane_Bar_oran_bar = "<div class='progress-bar progress-bar-green' style='width: " + yuzde_eczane + "%'></div>";
                                        var Eczane_bar_oran = "<span class='progress-number' style='font-size:15px'><b>" + parseInt(data.d.split('!')[sayaç].split('-')[8]) + "</b>/" + parseInt(data.d.split('!')[sayaç].split('-')[7]) + "</span></br>";
                                        var Eczane_Bar_oran_bar_div = "<div class='progress sm'>" + Eczane_Bar_oran_bar + "</div>";
                                        var Eczane_bar_div = "<div class='progress-group'>" + Eczane_bar_oran + Eczane_Bar_oran_bar_div + "</div>";




                                        var Span_gun = "<span style='font-size: 20px'>" + parseInt(data.d.split('!')[sayaç].split('-')[0].split('.')[0]) + " " + mName[parseInt(data.d.split('!')[sayaç].split('-')[0].split('.')[1] - 1)] + "</span>";
                                        if (sayaç % 7 == 6 || sayaç % 7 == 5) {

                                            var Sutun = "<li class='disabled' id='Gun' ziy_ıd='" + data.d.split('!')[sayaç].split('-')[1] + "' >" + Span_gun + Eczane_bar_div + Doktor_bar_div + "</li>";

                                        }
                                        else {
                                            var Sutun = "<li data-toggle='modal' data-target='#Ziyaret_Modal' id='Gun' ziy_ıd='" + data.d.split('!')[sayaç].split('-')[1] + "' >" + Span_gun + Eczane_bar_div + Doktor_bar_div + "</li>";

                                        }


                                        tab_div.find($('ul[id=hafta_' + i + ']')).append(Sutun);

                                    }

                                    sayaç++;
                                }

                            }

                        },
                        error: function () {
                            alert('Talep esnasında sorun oluştu.Yeniden deneyin');
                        }

                    });
                }
            }




            //$(document).on('click', "li[id=Gun]", function () {
            //    $('button[id=Ziyaret_Modal_kapat]').attr('Gun_ıd', '' + $(this).attr('ziy_ıd') + '')
            //    $('a[id=btn_addtocart_Doktor]').attr('Gun_ıd', '' + $(this).attr('ziy_ıd') + '')



            //    //Eczane_Ziyaret_Tablo
            //    var Doktor_Ziyaret_Tablo = $('tbody[id=Doktor_Ziyaret_Tablo]')
            //    var Eczane_Ziyaret_Tablo = $('tbody[id=Eczane_Ziyaret_Tablo]')


            //    $.ajax({
            //        url: 'Takvim.aspx/Modal_Doldurma_Doktor',
            //        dataType: 'json',
            //        type: 'POST',
            //        data: "{'parametre': '" + $(this).attr('ziy_ıd') + "'}",
            //        contentType: 'application/json; charset=utf-8',
            //        success: function (data) {
            //            var temp = JSON.parse(data.d)

            //            Doktor_Ziyaret_Tablo.empty();
            //            Doktor_Ziyaret_Tablo.append("<tr><th>Doktor Adı</th><th>Unite</th><th>Branş</th><th>Brick</th><th>Ziyaret Durumu</th><th>İncele</th></tr>")

            //            if (data.d == "boş") {

            //                Doktor_Ziyaret_Tablo.append('<tr><td style="text-align: center; background-color:#f9f9f9;" colspan="6"> Tabloda herhangi bir veri mevcut değil </td></tr>')
            //            }

            //            else {

            //                for (var i = 0; i < temp.length; i++) {
            //                    var label_str = ""
            //                    if (temp[i].Ziyaret_Durumu == "0") {

            //                        label_str += '<td><span class="label label-waring">Ziyret Bekleniyor</span></td>'
            //                    }
            //                    else if (temp[i].Ziyaret_Durumu == "1") {
            //                        label_str += '<td><span class="label label-success">Ziyret Edildi</span></td>'
            //                    }
            //                    else if (temp[i].Ziyaret_Durumu == "2") {
            //                        label_str += '<td><span class="label label-danger">Ziyret Edilmedi</span></td>'
            //                    }

            //                    Doktor_Ziyaret_Tablo.append("<tr>" +
            //                        "<td>" + temp[i].Doktor_Ad + "</td>" +
            //                        "<td>" + temp[i].Unite_Txt + "</td>" +
            //                        "<td>" + temp[i].Brans_Txt + "</td>" +
            //                        "<td>" + temp[i].TownName + "</td>" + label_str + "<td>" +
            //                        "<a value='" + temp[i].Ziy_Dty_ID + "' data-toggle='modal' data-dismiss='modal' data-target='#Ziyaret_Detay' id='Ziyareti_Güncelle'><i class='fa fa fa-search'></i></a></td></tr>");

            //                }

            //            }

            //        },// tekrar eklemeyi önlemek için eklenen doktorları tabloya kaydet sonra ona göre listele xd
            //        error: function () {

            //            alert('Talep esnasında sorun oluştu.Yeniden deneyin');

            //        }
            //    });
            //    $.ajax({
            //        url: 'Takvim.aspx/Modal_Doldurma_Eczane',
            //        dataType: 'json',
            //        type: 'POST',
            //        data: "{'parametre': '" + $(this).attr('ziy_ıd') + "'}",
            //        contentType: 'application/json; charset=utf-8',
            //        success: function (data) {

            //            var temp = JSON.parse(data.d)

            //            Eczane_Ziyaret_Tablo.empty();
            //            Eczane_Ziyaret_Tablo.append("<tr><th>Eczane Adı</th><th>Kenar</th><th>Brick</th><th>Ziyaret Durumu</th><th>İncele</th></tr>")

            //            if (data.d == "boş") {

            //                Eczane_Ziyaret_Tablo.append('<tr><td style="text-align: center; background-color:#f9f9f9;" colspan="6"> Tabloda herhangi bir veri mevcut değil </td></tr>')
            //            }
            //            else {
            //                for (var i = 0; i < temp.length; i++) {
            //                    var label_str = ""
            //                    if (temp[i].Ziyaret_Durumu == "0") {

            //                        label_str += '<td><span class="label label-waring">Ziyret Bekleniyor</span></td>'
            //                    }
            //                    else if (temp[i].Ziyaret_Durumu == "1") {
            //                        label_str += '<td><span class="label label-success">Ziyret Edildi</span></td>'
            //                    }
            //                    else if (temp[i].Ziyaret_Durumu == "2") {
            //                        label_str += '<td><span class="label label-danger">Ziyret Edilmedi</span></td>'
            //                    }


            //                    Eczane_Ziyaret_Tablo.append("<tr>" +
            //                        "<td>" + temp[i].Eczane_Adı + "</td>" +
            //                        "<td>" + temp[i].Eczane_Tip + "</td>" +
            //                        "<td>" + temp[i].TownName + "</td>" + label_str + "<td>" +
            //                        "<a value='" + temp[i].Ziy_Dty_ID + "' data-toggle='modal'data-dismiss='modal' data-target='#Ziyaret_Detay' id='Ziyareti_Güncelle'><i class='fa fa fa-search'></i></a></td></tr>");


            //                }


            //            }


            //        },// tekrar eklemeyi önlemek için eklenen doktorları tabloya kaydet sonra ona göre listele xd
            //        error: function () {

            //            alert('Talep esnasında sorun oluştu.Yeniden deneyin');

            //        }
            //    });


            //});


            //$('#Ziyaret_Detay').on('hidden.bs.modal', function () {
            //    // her seferinde ürünleri siliyoruz
            //    var Urunler = $('div[id=Urunler]')
            //    Urunler.empty()

            //    $("#Ziyaret_Durumu option[value='0']").removeAttr('selected')
            //    $("#Ziyaret_Durumu option[value='1']").removeAttr('selected')
            //    $("#Ziyaret_Durumu option[value='2']").removeAttr('selected')

            //    $('#Ziyaret_Modal').modal('show');//Eczane_Ziyaret_Tablo
            //    var Doktor_Ziyaret_Tablo = $('tbody[id=Doktor_Ziyaret_Tablo]')
            //    var Eczane_Ziyaret_Tablo = $('tbody[id=Eczane_Ziyaret_Tablo]')


            //    $.ajax({
            //        url: 'Takvim.aspx/Modal_Doldurma_Doktor',
            //        dataType: 'json',
            //        type: 'POST',
            //        data: "{'parametre': '" + $('button[id=Ziyaret_Modal_kapat]').attr('Gun_ıd') + "'}",
            //        contentType: 'application/json; charset=utf-8',
            //        success: function (data) {

            //            var temp = JSON.parse(data.d)


            //            Doktor_Ziyaret_Tablo.empty();
            //            Doktor_Ziyaret_Tablo.append("<tr><th>Doktor Adı</th><th>Unite</th><th>Branş</th><th>Brick</th><th>Ziyaret Durumu</th><th>İncele</th></tr>")

            //            if (data.d == "boş") {

            //                Doktor_Ziyaret_Tablo.append('<tr><td style="text-align: center; background-color:#f9f9f9;" colspan="6"> Tabloda herhangi bir veri mevcut değil </td></tr>')
            //            }

            //            else {

            //                for (var i = 0; i < temp.length; i++) {
            //                    var label_str = ""
            //                    if (temp[i].Ziyaret_Durumu == "0") {

            //                        label_str += '<td><span class="label label-waring">Ziyret Bekleniyor</span></td>'
            //                    }
            //                    else if (temp[i].Ziyaret_Durumu == "1") {
            //                        label_str += '<td><span class="label label-success">Ziyret Edildi</span></td>'
            //                    }
            //                    else if (temp[i].Ziyaret_Durumu == "2") {
            //                        label_str += '<td><span class="label label-danger">Ziyret Edilmedi</span></td>'
            //                    }


            //                    Doktor_Ziyaret_Tablo.append("<tr>" +
            //                        "<td>" + temp[i].Doktor_Ad + "</td>" +
            //                        "<td>" + temp[i].Unite_Txt + "</td>" +
            //                        "<td>" + temp[i].Brans_Txt + "</td>" +
            //                        "<td>" + temp[i].TownName + "</td>" + label_str + "<td>" +
            //                        "<a value='" + temp[i].Ziy_Dty_ID + "' data-toggle='modal' data-dismiss='modal' data-target='#Ziyaret_Detay' id='Ziyareti_Güncelle'><i class='fa fa fa-search'></i></a></td></tr>");

            //                }

            //            }

            //        },// tekrar eklemeyi önlemek için eklenen doktorları tabloya kaydet sonra ona göre listele xd
            //        error: function () {

            //            alert('Talep esnasında sorun oluştu.Yeniden deneyin');

            //        }
            //    });
            //    $.ajax({
            //        url: 'Takvim.aspx/Modal_Doldurma_Eczane',
            //        dataType: 'json',
            //        type: 'POST',
            //        data: "{'parametre': '" + $('button[id=Ziyaret_Modal_kapat]').attr('Gun_ıd') + "'}",
            //        contentType: 'application/json; charset=utf-8',
            //        success: function (data) {

            //            var temp = JSON.parse(data.d)

            //            Eczane_Ziyaret_Tablo.empty();
            //            Eczane_Ziyaret_Tablo.append("<tr><th>Eczane Adı</th><th>Kenar</th><th>Brick</th><th>Ziyaret Durumu</th><th>İncele</th></tr>")

            //            if (data.d == "boş") {

            //                Eczane_Ziyaret_Tablo.append('<tr><td style="text-align: center; background-color:#f9f9f9;" colspan="6"> Tabloda herhangi bir veri mevcut değil </td></tr>')
            //            }
            //            else {
            //                for (var i = 0; i < temp.length; i++) {
            //                    var label_str = ""
            //                    if (temp[i].Ziyaret_Durumu == "0") {

            //                        label_str += '<td><span class="label label-waring">Ziyret Bekleniyor</span></td>'
            //                    }
            //                    else if (temp[i].Ziyaret_Durumu == "1") {
            //                        label_str += '<td><span class="label label-success">Ziyret Edildi</span></td>'
            //                    }
            //                    else if (temp[i].Ziyaret_Durumu == "2") {
            //                        label_str += '<td><span class="label label-danger">Ziyret Edilmedi</span></td>'
            //                    }


            //                    Eczane_Ziyaret_Tablo.append("<tr>" +
            //                        "<td>" + temp[i].Eczane_Adı + "</td>" +
            //                        "<td>" + temp[i].Eczane_Tip + "</td>" +
            //                        "<td>" + temp[i].TownName + "</td>" + label_str + "<td>" +
            //                        "<a value='" + temp[i].Ziy_Dty_ID + "' data-toggle='modal'data-dismiss='modal' data-target='#Ziyaret_Detay' id='Ziyareti_Güncelle'><i class='fa fa fa-search'></i></a></td></tr>");


            //                }


            //            }



            //        },// tekrar eklemeyi önlemek için eklenen doktorları tabloya kaydet sonra ona göre listele xd
            //        error: function () {

            //            alert('Talep esnasında sorun oluştu.Yeniden deneyin');

            //        }
            //    });

            //})
            //$('#Ziyaret_Modal').on('hidden.bs.modal', function () {

            //    Tabloyu_Doldur_()
            //});

            ////#region Ürün Ekle
            //var Urunler_Listesi = "";
            //$.ajax({
            //    url: 'Takvim.aspx/Urunleri_Getir', //doktorları listelerken tersten listele 
            //    dataType: 'json',
            //    type: 'POST',
            //    async: false,
            //    contentType: 'application/json; charset=utf-8',
            //    success: function (data) {

            //        var temp = JSON.parse(data.d)
            //        for (var i = 0; i < temp.length; i++) {
            //            Urunler_Listesi += '<option value="' + temp[i].Urun_Id + '">' + temp[i].Urun_Adı + '</option>'
            //        }

            //    },
            //    error: function () {

            //        Swal.fire({
            //            title: 'Hata!',
            //            text: 'Talep esnasında sorun oluştu.Yeniden deneyin',
            //            icon: 'error',
            //            confirmButtonText: 'Kapat'
            //        })

            //    }
            //});

            //var Ürün_Ekle = $('button[id=Ürün_Ekle]')
            //Ürün_Ekle.click(function () {
            //    var Urunler = $('div[id=Urunler]')

            //    var myvar = '<div><div class="row">' +
            //        '                            <div class="col-xs-12">' +
            //        '                                <label>Çalışılan Ürün</label>' +
            //        '                            </div>' +
            //        '                        </div>' +
            //        '                        <div class="row">' +
            //        '                            <div class="col-xs-10">' +
            //        '                                <div class="form-group">' +
            //        '                                    <select name="Urun" class="form-control">' +
            //        '                                        <option value="0">Ürünler</option>' + Urunler_Listesi +
            //        '                                    </select>' +
            //        '                                </div>' +
            //        '                            </div>' +
            //        '                            <div class="col-xs-1">' +
            //        '                                <button id="Kaldır" type="button" class="btn btn-info">X</button>' +
            //        '                            </div>' +
            //        '                            </div>' +
            //        '                        </div>';


            //    Urunler.append(myvar)

            //    var Kaldır = $('button[id=Kaldır]')
            //    Kaldır.click(function () {
            //        $(this).parent().parent().parent().remove();
            //    })
            //})



            ////#endregion
            ////#region  
            //var Ziyareti_Guncelle_Btn = $('button[id=Ziyareti_Guncelle_Btn]')
            //Ziyareti_Guncelle_Btn.click(function () {


            //    var Calışılan_Urunler = [];

            //    if ($('select[id=Ziyaret_Durumu_Takvim]').find('option:selected').attr('value') == "2") {



            //        $.ajax({
            //            url: 'Takvim.aspx/Ziyareti_Güncelle_Edilmedi', //doktorları listelerken tersten listele 
            //            dataType: 'json',
            //            type: 'POST',
            //            async: false,
            //            data: "{'Ziyaret_Id':'" + $(this).attr('value') + "','Ziyaret_Notu':'" + $('textarea[id=Ziyaret_notu]').val() + "'}",
            //            contentType: 'application/json; charset=utf-8',
            //            success: function (data) {

            //                if (data.d == "2") {
            //                    Swal.fire({
            //                        title: 'Hata!',
            //                        text: 'Ziyaret Güncelleme İşlemi Saat 08:00 - 21:00 Arasında Yapılabilir',
            //                        icon: 'error',
            //                        confirmButtonText: 'Kapat'
            //                    })

            //                }
            //                if (data.d == "3") {
            //                    Swal.fire({
            //                        title: 'Hata!',
            //                        text: 'Ziyaret Planı Onaylanmadan İşlem Yapılamaz',
            //                        icon: 'error',
            //                        confirmButtonText: 'Kapat'
            //                    })
            //                }

            //            },
            //            error: function () {

            //                Swal.fire({
            //                    title: 'Hata!',
            //                    text: 'Talep esnasında sorun oluştu.Yeniden deneyin',
            //                    icon: 'error',
            //                    confirmButtonText: 'Kapat'
            //                })

            //            }
            //        });

            //    }




            //    if ($('select[id=Ziyaret_Durumu_Takvim]').find('option:selected').attr('value') == "0") {
            //        $('select[id=Ziyaret_Durumu_Takvim]').parent().attr('class', 'form-group has-error')
            //    }
            //    else {
            //        $('select[id=Ziyaret_Durumu_Takvim]').parent().attr('class', 'form-group')
            //    }

            //    if ($('select[id=Ziyaret_Durumu_Takvim]').find('option:selected').attr('value') == "1") {
            //        if ($('select[name=Urun]').each(function () { }).length < 3) {
            //            Swal.fire({
            //                title: 'Hata!',
            //                text: 'Lütfen Çalıştığınız Ürünleri Ekleyiniz',
            //                icon: 'error',
            //                confirmButtonText: 'Kapat'
            //            })
            //        }
            //        else {
            //            var Gönderilsinmi = true
            //            $('select[name=Urun]').each(function () {
            //                console.log(Calışılan_Urunler)
            //                var Çalışılan_Urun_Tablo = {
            //                    Urun_Id_: null,
            //                    Ziyaret_Id_: null
            //                }
            //                if ($(this).find('option:selected').val() == "0") {
            //                    Gönderilsinmi = false;
            //                    Swal.fire({
            //                        title: 'Hata!',
            //                        text: 'Lütfen Çalıştığınız Ürünü Seçiniz',
            //                        icon: 'error',
            //                        confirmButtonText: 'Kapat'
            //                    })
            //                }
            //                Çalışılan_Urun_Tablo.Urun_Id_ = $(this).find('option:selected').val()
            //                Çalışılan_Urun_Tablo.Ziyaret_Id_ = "00"
            //                Calışılan_Urunler.push(Çalışılan_Urun_Tablo)
            //            })

            //            if (Gönderilsinmi == true) {
            //                $.ajax({
            //                    url: 'Takvim.aspx/Ziyareti_Güncelle_Edildi', //doktorları listelerken tersten listele 
            //                    dataType: 'json',
            //                    type: 'POST',
            //                    async: false,
            //                    data: "{'Urun_Listesi': '{Deneme:" + JSON.stringify(Calışılan_Urunler) + "}','Ziyaret_Id':'" + $(this).attr('value') + "','Ziyaret_Notu':'" + $('textarea[id=Ziyaret_notu]').val() + "'}",
            //                    contentType: 'application/json; charset=utf-8',
            //                    success: function (data) {

            //                        if (data.d == "2") {
            //                            Swal.fire({
            //                                title: 'Hata!',
            //                                text: 'Ziyaret Güncelleme İşlemi Saat 08:00 - 21:00 Arasında Yapılabilir',
            //                                icon: 'error',
            //                                confirmButtonText: 'Kapat'
            //                            })

            //                        }
            //                        if (data.d == "3") {
            //                            Swal.fire({
            //                                title: 'Hata!',
            //                                text: 'Ziyaret Planı Onaylanmadan İşlem Yapılamaz',
            //                                icon: 'error',
            //                                confirmButtonText: 'Kapat'
            //                            })
            //                        }

            //                    },
            //                    error: function () {

            //                        Swal.fire({
            //                            title: 'Hata!',
            //                            text: 'Talep esnasında sorun oluştu.Yeniden deneyin',
            //                            icon: 'error',
            //                            confirmButtonText: 'Kapat'
            //                        })

            //                    }
            //                });
            //            }


            //        }

            //    }
            //})

            ////#endregion

            ////#region  ziyaret durumuı change
            //var Ziyaret_Durumu_Takvim = $('select[id=Ziyaret_Durumu_Takvim]')
            //Ziyaret_Durumu_Takvim.change(function () {

            //    console.log($(this).find('option:selected').val())

            //    if ($(this).find('option:selected').val() == "0") {
            //        var Ürün_Ekle = $('button[id=Ürün_Ekle]')
            //        Ürün_Ekle.attr('disabled', 'true')
            //        var Ziyaret_notu = $('textarea[id=Ziyaret_notu]')
            //        Ziyaret_notu.attr('disabled', 'true')
            //        var Urunler = $('div[id=Urunler]')
            //        Urunler.empty()
            //    }
            //    if ($(this).find('option:selected').val() == "1") {
            //        var Ürün_Ekle = $('button[id=Ürün_Ekle]')
            //        Ürün_Ekle.removeAttr('disabled')
            //        var Ziyaret_notu = $('textarea[id=Ziyaret_notu]')
            //        Ziyaret_notu.removeAttr('disabled')
            //        $.ajax({
            //            url: 'Takvim.aspx/Ziyaret_Detayını_Getir', //doktorları listelerken tersten listele 
            //            dataType: 'json',
            //            type: 'POST',
            //            async: false,
            //            global: false,
            //            data: "{'parametre':'" + $('button[id=Ziyareti_Guncelle_Btn]').attr('value') + "'}",
            //            contentType: 'application/json; charset=utf-8',
            //            success: function (data) {

            //                var temp = JSON.parse(data.d)
            //                console.log(temp)
            //                if (temp.length > 0) {

            //                    if (temp[0].Ziyaret_Durumu == "2") {
            //                        var Ziyaret_notu = $('textarea[id=Ziyaret_notu]')
            //                        Ziyaret_notu.val(temp[0].Ziyaret_Notu)
            //                        var Urunler = $('div[id=Urunler]')
            //                        Urunler.empty()
            //                    }
            //                    if (temp[0].Ziyaret_Durumu == "1") {


            //                        var Ziyaret_notu = $('textarea[id=Ziyaret_notu]')
            //                        Ziyaret_notu.val(temp[0].Ziyaret_Notu)
            //                        var Urunler = $('div[id=Urunler]')
            //                        Urunler.empty()
            //                        for (var i = 0; i < temp.length; i++) {

            //                            var myvar = '<div><div class="row">' +
            //                                '                            <div class="col-xs-12">' +
            //                                '                                <label>Çalışılan Ürün</label>' +
            //                                '                            </div>' +
            //                                '                        </div>' +
            //                                '                        <div class="row">' +
            //                                '                            <div class="col-xs-10">' +
            //                                '                                <div class="form-group">' +
            //                                '                                    <select name="Urun" id="Urun_ID_' + i + '" class="form-control">' +
            //                                '                                        <option value="0">Ürünler</option>' + Urunler_Listesi +
            //                                '                                    </select>' +
            //                                '                                </div>' +
            //                                '                            </div>' +
            //                                '                            <div class="col-xs-1">' +
            //                                '                                <button id="Kaldır" type="button" class="btn btn-info">X</button>' +
            //                                '                            </div>' +
            //                                '                            </div>' +
            //                                '                        </div>';

            //                            Urunler.append(myvar)
            //                            var Urun = $('select[id=Urun_ID_' + i + ']')
            //                            Urun.val(temp[i].Calışılan_Urun_Id)
            //                        }



            //                        var Kaldır = $('button[id=Kaldır]')
            //                        Kaldır.click(function () {
            //                            $(this).parent().parent().parent().remove();
            //                        })
            //                    }
            //                }
            //            },
            //            error: function () {

            //                Swal.fire({
            //                    title: 'Hata!',
            //                    text: 'Talep esnasında sorun oluştu.Yeniden deneyin',
            //                    icon: 'error',
            //                    confirmButtonText: 'Kapat'
            //                })
            //            }
            //        });
            //    }
            //    if ($(this).find('option:selected').val() == "2") {
            //        var Ürün_Ekle = $('button[id=Ürün_Ekle]')
            //        Ürün_Ekle.attr('disabled', 'true')
            //        var Ziyaret_notu = $('textarea[id=Ziyaret_notu]')
            //        Ziyaret_notu.removeAttr('disabled')
            //        var Urunler = $('div[id=Urunler]')
            //        Urunler.empty()
            //        $.ajax({
            //            url: 'Takvim.aspx/Ziyaret_Detayını_Getir', //doktorları listelerken tersten listele 
            //            dataType: 'json',
            //            type: 'POST',
            //            async: false,
            //            global: false,
            //            data: "{'parametre':'" + $('button[id=Ziyareti_Guncelle_Btn]').attr('value') + "'}",
            //            contentType: 'application/json; charset=utf-8',
            //            success: function (data) {
            //                var temp = JSON.parse(data.d)
            //                console.log(temp)
            //                if (temp.length > 0) {

            //                    if (temp[0].Ziyaret_Durumu == "2") {
            //                        var Ziyaret_notu = $('textarea[id=Ziyaret_notu]')
            //                        Ziyaret_notu.val(temp[0].Ziyaret_Notu)
            //                        var Urunler = $('div[id=Urunler]')
            //                        Urunler.empty()
            //                    }
            //                }
            //            },
            //            error: function () {

            //                Swal.fire({
            //                    title: 'Hata!',
            //                    text: 'Talep esnasında sorun oluştu.Yeniden deneyin',
            //                    icon: 'error',
            //                    confirmButtonText: 'Kapat'
            //                })

            //            }
            //        });
            //    }

            //})



            ////#endregion
            ////#region  Ziyhareti Doldur
            //$(document).on('click', "a[id=Ziyareti_Güncelle]", function () {

            //    var Ziyareti_Guncelle_Btn = $('button[id=Ziyareti_Guncelle_Btn]')
            //    Ziyareti_Guncelle_Btn.attr('value', $(this).attr('value'))



            //    $.ajax({
            //        url: 'Takvim.aspx/Ziyaret_Detayını_Getir', //doktorları listelerken tersten listele 
            //        dataType: 'json',
            //        type: 'POST',
            //        async: false,
            //        data: "{'parametre':'" + $(this).attr('value') + "'}",
            //        contentType: 'application/json; charset=utf-8',
            //        success: function (data) {

            //            var temp = JSON.parse(data.d)
            //            console.log(temp)
            //            if (temp.length > 0) {
            //                var Ziyaret_Durumu_Takvim = $('select[id=Ziyaret_Durumu_Takvim]')
            //                Ziyaret_Durumu_Takvim.val(temp[0].Ziyaret_Durumu)
            //                if (temp[0].Ziyaret_Durumu == "2") {
            //                    var Ziyaret_notu = $('textarea[id=Ziyaret_notu]')
            //                    Ziyaret_notu.val(temp[0].Ziyaret_Notu)
            //                }
            //                if (temp[0].Ziyaret_Durumu == "1") {


            //                    var Ziyaret_notu = $('textarea[id=Ziyaret_notu]')
            //                    Ziyaret_notu.val(temp[0].Ziyaret_Notu)
            //                    var Urunler = $('div[id=Urunler]')
            //                    for (var i = 0; i < temp.length; i++) {

            //                        var myvar = '<div><div class="row">' +
            //                            '                            <div class="col-xs-12">' +
            //                            '                                <label>Çalışılan Ürün</label>' +
            //                            '                            </div>' +
            //                            '                        </div>' +
            //                            '                        <div class="row">' +
            //                            '                            <div class="col-xs-10">' +
            //                            '                                <div class="form-group">' +
            //                            '                                    <select name="Urun" id="Urun_ID_' + i + '" class="form-control">' +
            //                            '                                        <option value="0">Ürünler</option>' + Urunler_Listesi +
            //                            '                                    </select>' +
            //                            '                                </div>' +
            //                            '                            </div>' +
            //                            '                            <div class="col-xs-1">' +
            //                            '                                <button id="Kaldır" type="button" class="btn btn-info">X</button>' +
            //                            '                            </div>' +
            //                            '                            </div>' +
            //                            '                        </div>';

            //                        Urunler.append(myvar)
            //                        var Urun = $('select[id=Urun_ID_' + i + ']')
            //                        Urun.val(temp[i].Calışılan_Urun_Id)
            //                    }



            //                    var Kaldır = $('button[id=Kaldır]')
            //                    Kaldır.click(function () {
            //                        $(this).parent().parent().parent().remove();
            //                    })


            //                }
            //            }



            //        },
            //        error: function () {

            //            Swal.fire({
            //                title: 'Hata!',
            //                text: 'Talep esnasında sorun oluştu.Yeniden deneyin',
            //                icon: 'error',
            //                confirmButtonText: 'Kapat'
            //            })

            //        }
            //    });



            //});

            ////#endregion
            //Doktor_Modal


            //$("a[id*=btn_addtocart_Doktor]").bind("click", function () {

            //    $('#Ziyaret_Modal').modal('toggle');

            //    var Dktr_Liste = $('select[id=Dktr_Liste]')



            //    $.ajax({
            //        url: 'ddldeneme.aspx/Yeni_Liste_Olustur_Listeler', //doktorları listelerken tersten listele 
            //        dataType: 'json',
            //        type: 'POST',
            //        data: "{'parametre': '" + "" + "-0'}",//liste cinsini de yolla o gördüğün 0 liste cinsi
            //        contentType: 'application/json; charset=utf-8',
            //        success: function (data) {
            //            Dktr_Liste.empty();

            //            var b = 0;
            //            while (data.d.split('!')[b] != null) {

            //                Dktr_Liste.append("<option value='" + data.d.split('!')[b].split("-")[0] + "'>" + data.d.split('!')[b].split("-")[1] + "</option>");
            //                b++;
            //            }
            //        }
            //    });


            //    var Dktr_Modal_Kaydet = $('button[id=Ekle]')
            //    Dktr_Modal_Kaydet.attr('Gun_Id', $(this).attr('gun_ıd'))

            //    Dktr_Modal_Kaydet.on('click', function () {





            //        var Dktr_Ad = $('select[Id=Dktr_Ad]');
            //        var Dktr_Ad_seçili = Dktr_Ad.find('option:selected')




            //        if (Dktr_Ad_seçili.text() == "--&gt;&gt; Lütfen Doktor Adı Seçiniz &lt;&lt;--" || Dktr_Ad_seçili.text() == "undefined" || Dktr_Ad_seçili.text() == "" || Dktr_Ad_seçili.val() == "hata") {
            //            Dktr_Ad.parent().removeAttr('class');
            //            Dktr_Ad.parent().attr('class', 'form-group has-error')
            //        }
            //        else {



            //            if ($('input[id=Doktor_Sadece_Bu_Gun]').is(':checked')) {
            //                var Doktor_Liste = [];

            //                var Doktor_Liste_Tablo = {
            //                    Doktor_Id_: null,
            //                    Ziy_Tar_: null,
            //                }


            //                var Dktr_Ad = $('select[id=Dktr_Ad]')
            //                Doktor_Liste_Tablo.Doktor_Id_ = Dktr_Ad.find('option:selected').attr('value')
            //                Doktor_Liste_Tablo.Ziy_Tar_ = $(this).attr('Gun_Id')
            //                Doktor_Liste.push(Doktor_Liste_Tablo)
            //                $.ajax({
            //                    url: 'Ziyaret-Planı.aspx/Doktor_Ziyaret_Oluştur_Tekli', //doktorları listelerken tersten listele 
            //                    dataType: 'json',
            //                    type: 'POST',
            //                    async: false,
            //                    data: "{'Doktor_Listesi': '{Deneme:" + JSON.stringify(Doktor_Liste) + "}',Ziyaret_Id:'" + $(this).attr('Gun_Id') + "'}",
            //                    contentType: 'application/json; charset=utf-8',
            //                    success: function (data) {
            //                        var temp = JSON.parse(data.d)
            //                        if (temp[0].Durum == 0) {
            //                            Swal.fire({
            //                                title: 'Hata!',
            //                                text: 'Seçilen Tarihlerde Daha Önceden Ekleme Yapılmış Lütfen Kontrol Ediniz',
            //                                icon: 'error',
            //                                confirmButtonText: 'Kapat'
            //                            })
            //                        }
            //                        if (temp[0].Durum == 1) {
            //                            Swal.fire({
            //                                title: 'Başarılı!',
            //                                text: 'İşlem Başarı İle Kaydedildi',
            //                                icon: 'success',
            //                                confirmButtonText: 'Kapat'
            //                            })

            //                        }

            //                    },
            //                    error: function () {

            //                        Swal.fire({
            //                            title: 'Hata!',
            //                            text: 'Talep esnasında sorun oluştu.Yeniden deneyin',
            //                            icon: 'error',
            //                            confirmButtonText: 'Kapat'
            //                        })

            //                    }
            //                });
            //            }

            //            else {
            //                var Doktor_Liste = [];

            //                var Doktor_Liste_Tablo = {
            //                    Doktor_Id_: null,
            //                    Ziy_Tar_: null,
            //                }


            //                var Dktr_Ad = $('select[id=Dktr_Ad]')
            //                Doktor_Liste_Tablo.Doktor_Id_ = Dktr_Ad.find('option:selected').attr('value')
            //                Doktor_Liste_Tablo.Ziy_Tar_ = $(this).attr('Gun_Id')
            //                Doktor_Liste.push(Doktor_Liste_Tablo)


            //                $('select[name=Frekans_Select_Doktor]').each(function () {
            //                    if ($(this).find('option:selected').attr('eklenmesin') != "True" && $(this).find('option:selected').attr('yıl_rkm') != undefined) {
            //                        var Doktor_Liste_Tablo = {
            //                            Doktor_Id_: null,
            //                            Ziy_Tar_: null,
            //                        }
            //                        console.log($(this).find('option:selected').attr('yıl_rkm'))
            //                        console.log($(this).find('option:selected').attr('ay_rkm'))
            //                        console.log($(this).find('option:selected').attr('gun_rkm'))
            //                        Doktor_Liste_Tablo.Doktor_Id_ = Dktr_Ad.find('option:selected').attr('value')
            //                        Doktor_Liste_Tablo.Ziy_Tar_ = $(this).attr('Gun_Id')
            //                        Doktor_Liste.push(Doktor_Liste_Tablo)
            //                    }

            //                })

            //                $.ajax({
            //                    url: 'Ziyaret-Planı.aspx/Doktor_Ziyaret_Oluştur_Tekli', //doktorları listelerken tersten listele 
            //                    dataType: 'json',
            //                    type: 'POST',
            //                    async: false,
            //                    data: "{'Doktor_Listesi': '{Deneme:" + JSON.stringify(Doktor_Liste) + "}',Ziyaret_Id:'" + $(this).attr('Gun_Id') + "'}",
            //                    contentType: 'application/json; charset=utf-8',
            //                    success: function (data) {
            //                        var temp = JSON.parse(data.d)
            //                        if (temp[0].Durum == 0) {
            //                            Swal.fire({
            //                                title: 'Hata!',
            //                                text: 'Seçilen Tarihlerde Daha Önceden Ekleme Yapılmış Lütfen Kontrol Ediniz',
            //                                icon: 'error',
            //                                confirmButtonText: 'Kapat'
            //                            })
            //                        }
            //                        if (temp[0].Durum == 1) {
            //                            Swal.fire({
            //                                title: 'Başarılı!',
            //                                text: 'İşlem Başarı İle Kaydedildi',
            //                                icon: 'success',
            //                                confirmButtonText: 'Kapat'
            //                            })

            //                        }

            //                    },
            //                    error: function () {

            //                        Swal.fire({
            //                            title: 'Hata!',
            //                            text: 'Talep esnasında sorun oluştu.Yeniden deneyin',
            //                            icon: 'error',
            //                            confirmButtonText: 'Kapat'
            //                        })

            //                    }
            //                });

            //            }





            //        }

            //    });



            //    var Dktr_Il = $('select[id=Dktr_Il]')


            //    var Dktr_Ad = $('select[id=Dktr_Ad]')
            //    var Dktr_Brick = $('select[id=Dktr_brick]')
            //    var Dktr_Brans = $('select[id=Dktr_Brans]')
            //    var Dktr_Unite = $('select[id=Dktr_Unite]')
            //    var Dktr_Ad = $('select[id=Dktr_Ad]')



            //    Dktr_Ad.parent().removeAttr("class");
            //    Dktr_Ad.parent().attr("class", "form-group");
            //    Dktr_Brans.parent().removeAttr("class");
            //    Dktr_Brans.parent().attr("class", "form-group");
            //    Dktr_Unite.parent().removeAttr("class");
            //    Dktr_Unite.parent().attr("class", "form-group");
            //    Dktr_Brick.parent().removeAttr("class");
            //    Dktr_Brick.parent().attr("class", "form-group");
            //    Dktr_Il.parent().removeAttr("class");
            //    Dktr_Il.parent().attr("class", "form-group");


            //    $.ajax({
            //        url: 'ddldeneme.aspx/OrnekPost',
            //        dataType: 'json',
            //        type: 'POST',
            //        data: "{'parametre': '0-0'}",
            //        contentType: 'application/json; charset=utf-8',
            //        success: function (data) {
            //            Dktr_Il.empty();
            //            Dktr_Il.append("<option>-->> Lütfen Şehir Seçiniz <<--</option>")
            //            var b = 0;
            //            while (data.d.split('!')[b] != null) {

            //                Dktr_Il.append("<option value='" + data.d.split('!')[b].split("-")[0] + "'>" + data.d.split('!')[b].split("-")[1] + "</option>");
            //                b++;

            //            }

            //        },// tekrar eklemeyi önlemek için eklenen doktorları tabloya kaydet sonra ona göre listele xd
            //        error: function () {

            //            alert('Talep esnasında sorun oluştu.Yeniden deneyin');

            //        }
            //    });

            //    Dktr_Il.change(function () {
            //        Dktr_Il.parent().removeAttr("class");
            //        Dktr_Il.parent().attr("class", "form-group");
            //        $.ajax({
            //            url: 'ddldeneme.aspx/OrnekPost',
            //            dataType: 'json',
            //            type: 'POST',
            //            data: "{'parametre': '1-" + $(this).val() + "'}",
            //            contentType: 'application/json; charset=utf-8',
            //            success: function (data) {
            //                Dktr_Brick.empty();
            //                Dktr_Brick.append("<option>-->> Lütfen Brick Seçiniz <<--</option>");
            //                var b = 0;
            //                while (data.d.split('!')[b] != null) {
            //                    Dktr_Brick.append("<option value='" + data.d.split('!')[b].split("-")[0] + "'>" + data.d.split('!')[b].split("-")[1] + "</option>");
            //                    b++;
            //                }
            //                if (Dktr_Il.parent().children().find($("select option:first-child")).html() == "--&gt;&gt; Lütfen Şehir Seçiniz &lt;&lt;--") {
            //                    Dktr_Il.parent().children().find($("select option:first-child")).remove();
            //                }
            //            }
            //        });
            //        // tekrar eklemeyi önlemek için eklenen doktorları tabloya kaydet sonra ona göre listele xd
            //    });
            //    Dktr_Brick.change(function () {
            //        Dktr_Brick.parent().removeAttr("class");
            //        Dktr_Brick.parent().attr("class", "form-group");
            //        $.ajax({
            //            url: 'ddldeneme.aspx/OrnekPost',
            //            dataType: 'json',
            //            type: 'POST',
            //            data: "{'parametre': '2-" + $(this).val() + "'}",
            //            contentType: 'application/json; charset=utf-8',
            //            success: function (data) {
            //                Dktr_Unite.empty();
            //                Dktr_Unite.append("<option>-->> Lütfen Ünite Seçiniz <<--</option>");
            //                var b = 0;
            //                while (data.d.split('!')[b] != null) {

            //                    Dktr_Unite.append("<option value='" + data.d.split('!')[b].split("-")[0] + "'>" + data.d.split('!')[b].split("-")[1] + "</option>");
            //                    b++;
            //                }
            //                if (Dktr_Brick.parent().children().find($("select option:first-child")).html() == "--&gt;&gt; Lütfen Brick Seçiniz &lt;&lt;--") {
            //                    Dktr_Brick.parent().children().find($("select option:first-child")).remove();
            //                }
            //            },
            //            error: function () {

            //                alert('Talep esnasında sorun oluştu.Yeniden deneyin');

            //            }
            //        });
            //        // tekrar eklemeyi önlemek için eklenen doktorları tabloya kaydet sonra ona göre listele xd
            //    });
            //    Dktr_Unite.change(function () {
            //        Dktr_Unite.parent().removeAttr("class");
            //        Dktr_Unite.parent().attr("class", "form-group");

            //        $.ajax({
            //            url: 'ddldeneme.aspx/OrnekPost',
            //            dataType: 'json',
            //            type: 'POST',
            //            data: "{'parametre': '3-" + $(this).val() + "'}",
            //            contentType: 'application/json; charset=utf-8',
            //            success: function (data) {
            //                Dktr_Brans.empty();
            //                Dktr_Brans.append("<option>-->> Lütfen Branş Seçiniz <<--</option>");
            //                var b = 0;
            //                while (data.d.split('!')[b] != null) {


            //                    Dktr_Brans.append("<option value='" + data.d.split('!')[b].split("-")[0] + "'>" + data.d.split('!')[b].split("-")[1] + "</option>");
            //                    b++;

            //                }
            //                if (Dktr_Unite.parent().children().find($("select option:first-child")).html() == "--&gt;&gt; Lütfen Ünite Seçiniz &lt;&lt;--") {
            //                    Dktr_Unite.parent().children().find($("select option:first-child")).remove();
            //                }
            //            },
            //            error: function () {

            //                alert('Talep esnasında sorun oluştu.Yeniden deneyin');

            //            }
            //        });

            //    });
            //    Dktr_Brans.change(function () {

            //        Dktr_Brans.parent().removeAttr("class");
            //        Dktr_Brans.parent().attr("class", "form-group");

            //        $.ajax({
            //            url: 'ddldeneme.aspx/OrnekPost',
            //            dataType: 'json',
            //            type: 'POST',
            //            data: "{'parametre': '4-" + $(this).val() + "-" + Dktr_Liste.find('option:selected').attr('value') + "'}",
            //            contentType: 'application/json; charset=utf-8',
            //            success: function (data) {
            //                Dktr_Ad.empty();
            //                Dktr_Ad.append(" <option>-->> Lütfen Doktor Adı Seçiniz <<--</option>");

            //                var b = 0;
            //                while (data.d.split('!')[b] != null) {
            //                    Dktr_Ad.append("<option frekans=" + data.d.split('!')[b].split("-")[2] + " value='" + data.d.split('!')[b].split("-")[0] + "'>" + data.d.split('!')[b].split("-")[1] + "</option>");
            //                    b++;
            //                }
            //                if (Dktr_Brans.parent().children().find($("select option:first-child")).html() == "--&gt;&gt; Lütfen Branş Seçiniz &lt;&lt;--") {
            //                    Dktr_Brans.parent().children().find($("select option:first-child")).remove();
            //                }



            //            },
            //            error: function () {

            //                alert('Talep esnasında sorun oluştu.Yeniden deneyin');

            //            }
            //        });// sadece 1 kere silecek şekilde ayarla sikim

            //    })//cal-yr




            //    $('#Doktor_Modal').on('hidden.bs.modal', function () {
            //        Dktr_Modal_Kaydet.unbind('click')
            //        Dktr_Ad.parent().removeAttr('class');
            //        Dktr_Ad.parent().attr('class', 'form-group')
            //        $("input[id=Doktor_Sadece_Bu_Gun]").prop('checked', false);
            //        Dktr_Brick.unbind();
            //        Dktr_Unite.unbind();
            //        Dktr_Brans.unbind();
            //        Dktr_Ad.unbind();
            //        Bilgi_Mesajı_ayrıkGun.attr('style', 'display: none');
            //        Bilgi_Mesajı_Ilk_Tam_Hafta.attr('style', 'display: none');
            //    });




            //    Dktr_Brans.empty();
            //    Dktr_Brick.empty();
            //    Dktr_Unite.empty();
            //    Dktr_Ad.empty();


            //});


        });




    </script>



</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
   

    <div class="row">
        <div class="col-xs-5 ">
            <div class="form-group">
                <select id="calmth" class="form-control"></select>
            </div>
        </div>
        <div class="col-xs-5 ">
            <div class="form-group">
                <select id="calyr" class="form-control"></select>
            </div>
        </div>
        <div class="col-xs-2 ">
            <div class="form-group">
                <input id="cal_set" type="button" class="btn btn-block btn-info" value="SET" />
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-xs-12">
            <div class="nav-tabs-custom">

                <div class="tab-content">
                    <!-- Font Awesome Icons -->

                    <!-- /#fa-icons -->

                    <!-- glyphicons-->
                    <div class="tab-pane active" id="glyphicons">
                        <ul class="gunbs-glyphicons">
                            <li></li>
                            <li>
                                <span class="glyphicon-class">Pazartesi</span>
                            </li>
                            <li>
                                <span class="glyphicon-class">Salı</span>
                            </li>
                            <li>
                                <span class="glyphicon-class">Çarşamba</span>
                            </li>
                            <li>
                                <span class="glyphicon-class">Perşembe</span>
                            </li>
                            <li>
                                <span class="glyphicon-class">Cuma</span>
                            </li>
                            <li>
                                <span class="glyphicon-class">Cumartesi</span>
                            </li>
                            <li>
                                <span class="glyphicon-class">Pazar</span>
                            </li>

                        </ul>

                        <ul class="bs-glyphicons">
                    </div>
                    <!-- /#ion-icons -->

                </div>
                <!-- /.tab-content -->
            </div>
            <!-- /.nav-tabs-custom -->
        </div>
    </div>

</asp:Content>
