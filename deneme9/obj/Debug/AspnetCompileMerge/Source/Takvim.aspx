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


            if (window.location.href.split('?').length > 1) {
                var go_month = window.location.href.split('?')[window.location.href.split('?').length - 1].split('=')[1].split('-')[1]
                var go_year = window.location.href.split('?')[window.location.href.split('?').length - 1].split('=')[1].split('-')[0]
                $.ajax({
                    url: 'Takvim.aspx/Haftanın_Gunleri',
                    dataType: 'json',
                    type: 'POST',
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
                                    if (parseInt(data.d.split('!')[sayaç].split('-')[4]) == 0) {
                                        yuzde_doktor = 0;
                                    }
                                    else {
                                        yuzde_doktor = (parseInt(data.d.split('!')[sayaç].split('-')[4]) * 100) / parseInt(data.d.split('!')[sayaç].split('-')[6]);
                                    }

                                    var yuzde_eczane;
                                    if (parseInt(data.d.split('!')[sayaç].split('-')[5]) == 0) {
                                        yuzde_eczane = 0;
                                    }
                                    else {
                                        yuzde_eczane = (parseInt(data.d.split('!')[sayaç].split('-')[5]) * 100) / parseInt(data.d.split('!')[sayaç].split('-')[7]);
                                    }




                                    var Doktor_bar_oran = "<span class='progress-number' style='font-size:15px'><b>" + parseInt(data.d.split('!')[sayaç].split('-')[5]) + "</b>/" + parseInt(data.d.split('!')[sayaç].split('-')[7]) + "</span>";

                                    var Doktor_Bar_oran_bar = "<div class='progress-bar progress-bar-aqua' style='width: " + yuzde_doktor + "%'></div>";
                                    var Doktor_Bar_oran_bar_div = "<div class='progress sm'>" + Doktor_Bar_oran_bar + "</div>";
                                    var Doktor_bar_div = "<div class='progress-group'>" + Doktor_bar_oran + Doktor_Bar_oran_bar_div + "</div>";



                                    var Eczane_bar_oran = "<span class='progress-number' style='font-size:15px'><b>" + parseInt(data.d.split('!')[sayaç].split('-')[4]) + "</b>/" + parseInt(data.d.split('!')[sayaç].split('-')[6]) + "</span></br>";

                                    var Eczane_Bar_oran_bar = "<div class='progress-bar progress-bar-green' style='width: " + yuzde_eczane + "%'></div>";
                                    var Eczane_Bar_oran_bar_div = "<div class='progress sm'>" + Eczane_Bar_oran_bar + "</div>";
                                    var Eczane_bar_div = "<div class='progress-group'>" + Eczane_bar_oran + Eczane_Bar_oran_bar_div + "</div>";




                                    var Span_gun = "<span style='font-size: 20px'>" + parseInt(data.d.split('!')[sayaç].split('-')[0].split('.')[0]) + " " + mName[parseInt(data.d.split('!')[sayaç].split('-')[0].split('.')[1] - 1)] + "</span>";
                                    if (sayaç % 7 == 6 || sayaç % 7 == 5) {

                                        var Sutun = "<li class='disabled' id='Gun' ziy_ıd='" + data.d.split('!')[sayaç].split('-')[1] + "' >" + Span_gun + Eczane_bar_div + Doktor_bar_div + "</li>";

                                    }
                                    else {
                                        var Sutun = "<li ontouchstart='Modal_Doldur()'  id='Gun' ziy_ıd='" + data.d.split('!')[sayaç].split('-')[1] + "' >" + Span_gun + Eczane_bar_div + Doktor_bar_div + "</li>";

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
                                    if (parseInt(data.d.split('!')[sayaç].split('-')[5]) == 0) {
                                        yuzde_eczane = 0;
                                    }
                                    else {
                                        yuzde_eczane = (parseInt(data.d.split('!')[sayaç].split('-')[5]) * 100) / parseInt(data.d.split('!')[sayaç].split('-')[7]);
                                    }

                                    var yuzde_doktor;
                                    if (parseInt(data.d.split('!')[sayaç].split('-')[4]) == 0) {
                                        yuzde_doktor = 0;
                                    }
                                    else {
                                        yuzde_doktor = (parseInt(data.d.split('!')[sayaç].split('-')[4]) * 100) / parseInt(data.d.split('!')[sayaç].split('-')[6]);
                                    }


                                    var Doktor_bar_oran = "<span class='progress-number' style='font-size:15px'><b>" + parseInt(data.d.split('!')[sayaç].split('-')[4]) + "</b>/" + parseInt(data.d.split('!')[sayaç].split('-')[6]) + "</span>";
                                    var Doktor_Bar_oran_bar = "<div class='progress-bar progress-bar-aqua' style='width: " + yuzde_doktor + "%'></div>";
                                    var Doktor_Bar_oran_bar_div = "<div class='progress sm'>" + Doktor_Bar_oran_bar + "</div>";
                                    var Doktor_bar_div = "<div class='progress-group'>" + Doktor_bar_oran + Doktor_Bar_oran_bar_div + "</div>";




                                    var Eczane_Bar_oran_bar = "<div class='progress-bar progress-bar-green' style='width: " + yuzde_eczane + "%'></div>";
                                    var Eczane_bar_oran = "<span class='progress-number' style='font-size:15px'><b>" + parseInt(data.d.split('!')[sayaç].split('-')[5]) + "</b>/" + parseInt(data.d.split('!')[sayaç].split('-')[7]) + "</span></br>";
                                    var Eczane_Bar_oran_bar_div = "<div class='progress sm'>" + Eczane_Bar_oran_bar + "</div>";
                                    var Eczane_bar_div = "<div class='progress-group'>" + Eczane_bar_oran + Eczane_Bar_oran_bar_div + "</div>";




                                    var Span_gun = "<span style='font-size: 20px'>" + parseInt(data.d.split('!')[sayaç].split('-')[0].split('.')[0]) + " " + mName[parseInt(data.d.split('!')[sayaç].split('-')[0].split('.')[1] - 1)] + "</span>";
                                    if (sayaç % 7 == 6 || sayaç % 7 == 5) {

                                        var Sutun = "<li class='disabled' id='Gun' ziy_ıd='" + data.d.split('!')[sayaç].split('-')[1] + "' >" + Span_gun + Eczane_bar_div + Doktor_bar_div + "</li>";

                                    }
                                    else {
                                        var Sutun = "<li ontouchstart='Modal_Doldur()' id='Gun' ziy_ıd='" + data.d.split('!')[sayaç].split('-')[1] + "' >" + Span_gun + Eczane_bar_div + Doktor_bar_div + "</li>";

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

           



        });
        //$(document).on('touchstart', "a[id=Ziyareti_Güncelle]", function () {

        //    var Ziyaret_Durumu = $('select[id=Ziyaret_Durumu]')
        //    var Urun_1 = $('select[id=Urun_1]')
        //    var Urun_2 = $('select[id=Urun_2]')
        //    var Urun_3 = $('select[id=Urun_3]')
        //    var Ziyaret_notu = $('textarea[id=Ziyaret_notu]')
        //    var Ziyareti_Guncelle = $('button[id=Ziyareti_Guncelle]')
        //    Urun_1.empty();
        //    Urun_2.empty();
        //    Urun_3.empty();
        //    Ziyaret_notu.empty();

        //    Ziyareti_Guncelle.attr('value', '' + $(this).attr('value') + '')

        //    $.ajax({
        //        url: 'Takvim.aspx/Ziyaret_Detay',
        //        dataType: 'json',
        //        type: 'POST',
        //        data: "{'parametre': '" + $(this).attr('value') + "'}",
        //        contentType: 'application/json; charset=utf-8',
        //        success: function (data) {
        //            Urun_1.removeAttr('disabled')
        //            Urun_2.removeAttr('disabled')
        //            Urun_3.removeAttr('disabled')



        //            if (data.d == "0") {

        //                $("#Ziyaret_Durumu option[value='0']").attr("selected", true);
        //                Urun_1.attr('disabled', 'disabled')
        //                Urun_2.attr('disabled', 'disabled')
        //                Urun_3.attr('disabled', 'disabled')
        //                Ziyaret_notu.attr('disabled', 'disabled')
        //            }
        //            if (data.d == "1") {


        //                $("#Ziyaret_Durumu option[value='1']").attr("selected", true);
        //                Urun_1.removeAttr('disabled')
        //                Urun_2.removeAttr('disabled')
        //                Urun_3.removeAttr('disabled')
        //                Urunleri_Doldur()
        //                $.ajax({
        //                    url: 'Takvim.aspx/Ziyaret_Detayını_Getir',
        //                    dataType: 'json',
        //                    type: 'POST',
        //                    data: "{'parametre': '" + $('button[id=Ziyareti_Guncelle]').attr('value') + "'}",
        //                    contentType: 'application/json; charset=utf-8',
        //                    success: function (data) {
        //                        $("#Urun_1 option[value='" + data.d.split('-')[0] + "']").attr("selected", true);
        //                        $("#Urun_2 option[value='" + data.d.split('-')[1] + "']").attr("selected", true);
        //                        $("#Urun_3 option[value='" + data.d.split('-')[2] + "']").attr("selected", true);
        //                        $("#Ziyaret_notu").html(data.d.split('-')[3])

        //                    },// tekrar eklemeyi önlemek için eklenen doktorları tabloya kaydet sonra ona göre listele xd
        //                    error: function () {

        //                        alert('Talep esnasında sorun oluştu.Yeniden deneyin');

        //                    }
        //                });




        //            }
        //            if (data.d == "2") {

        //                $("#Ziyaret_Durumu option[value='2']").attr("selected", true);
        //                Urun_1.attr('disabled', 'disabled')
        //                Urun_2.attr('disabled', 'disabled')
        //                Urun_3.attr('disabled', 'disabled')
        //            }


        //        },// tekrar eklemeyi önlemek için eklenen doktorları tabloya kaydet sonra ona göre listele xd
        //        error: function () {

        //            alert('Talep esnasında sorun oluştu.Yeniden deneyin');

        //        }
        //    });//data-dismiss="modal"






        //    setTimeout(function () {

        //        $('div[id=Ziyaret_Modal]').modal('hide');
        //        $('div[id=Ziyaret_Detay]').modal('show');



        //    }, 1000);


        //    $('div[id=Ziyaret_Detay]').on('hidden.bs.modal', function () {


        //        $('#Ziyaret_Modal').modal('show');//Eczane_Ziyaret_Tablo
        //        var Doktor_Ziyaret_Tablo = $('tbody[id=Doktor_Ziyaret_Tablo]')
        //        var Eczane_Ziyaret_Tablo = $('tbody[id=Eczane_Ziyaret_Tablo]')


        //        $.ajax({
        //            url: 'Takvim.aspx/Modal_Doldurma_Doktor',
        //            dataType: 'json',
        //            type: 'POST',
        //            data: "{'parametre': '" + $('button[id=Ziyaret_Modal_kapat]').attr('Gun_ıd') + "'}",
        //            contentType: 'application/json; charset=utf-8',
        //            success: function (data) {

        //                Doktor_Ziyaret_Tablo.empty();
        //                Doktor_Ziyaret_Tablo.append("<tr><th>Doktor Adı</th><th>Unite</th><th>Branş</th><th>Brick</th><th>Ziyaret Durumu</th><th>İncele</th></tr>")

        //                var b = 0;
        //                while (data.d.split('!')[b] != null) {
        //                    var label_str = ""
        //                    if (data.d.split('!')[b].split('-')[5] == "0") {

        //                        label_str += '<td><span class="label label-waring">Ziyret Bekleniyor</span></td>'
        //                    }
        //                    else if (data.d.split('!')[b].split('-')[5] == "1") {
        //                        label_str += '<td><span class="label label-success">Ziyret Edildi</span></td>'
        //                    }

        //                    Doktor_Ziyaret_Tablo.append("<tr><td>" + data.d.split('!')[b].split('-')[1] + "</td><td>" + data.d.split('!')[b].split('-')[2] + "</td><td>" + data.d.split('!')[b].split('-')[3] + "</td><td>" + data.d.split('!')[b].split('-')[4] + "</td>" + label_str + "<td><a value='" + data.d.split('!')[b].split('-')[0] + "' data-toggle='modal' data-target='#Ziyaret_Detay' id='Ziyareti_Güncelle'><i class='fa fa fa-search'></i></a></td></tr>");
        //                    b++;

        //                }

        //            },// tekrar eklemeyi önlemek için eklenen doktorları tabloya kaydet sonra ona göre listele xd
        //            error: function () {

        //                alert('Talep esnasında sorun oluştu.Yeniden deneyin');

        //            }
        //        });
        //        $.ajax({
        //            url: 'Takvim.aspx/Modal_Doldurma_Eczane',
        //            dataType: 'json',
        //            type: 'POST',
        //            data: "{'parametre': '" + $('button[id=Ziyaret_Modal_kapat]').attr('Gun_ıd') + "'}",
        //            contentType: 'application/json; charset=utf-8',
        //            success: function (data) {

        //                Eczane_Ziyaret_Tablo.empty();
        //                Eczane_Ziyaret_Tablo.append("<tr><th>Eczane Adı</th><th>Brick</th><th>Ziyaret Durumu</th><th>İncele</th></tr>")

        //                var b = 0;
        //                while (data.d.split('!')[b] != null) {
        //                    var label_str = ""
        //                    if (data.d.split('!')[b].split('-')[3] == "0") {

        //                        label_str += '<td><span class="label label-waring">Ziyret Bekleniyor</span></td>'
        //                    }
        //                    else if (data.d.split('!')[b].split('-')[3] == "1") {
        //                        label_str += '<td><span class="label label-success">Ziyret Edildi</span></td>'
        //                    }

        //                    Eczane_Ziyaret_Tablo.append("<tr><td>" + data.d.split('!')[b].split('-')[1] + "</td><td>" + data.d.split('!')[b].split('-')[2] + "</td>" + label_str + "<td><a value'" + data.d.split('!')[b].split('-')[0] + "' data-toggle='modal' data-target='#Ziyaret_Detay' id='Ziyareti_Güncelle'><i class='fa fa fa-search'></i></a></td></tr>");
        //                    b++;

        //                }

        //            },// tekrar eklemeyi önlemek için eklenen doktorları tabloya kaydet sonra ona göre listele xd
        //            error: function () {

        //                alert('Talep esnasında sorun oluştu.Yeniden deneyin');

        //            }
        //        });

        //        $('div[id=Ziyaret_Modal]').modal('show');
        //    })
          
        //});


        
        function Modal_Doldur() {
            $(document).on('touchstart', "li[id=Gun]", function Modal_Doldur() {
                alert("asd")

                //$('button[id=Ziyaret_Modal_kapat]').attr('Gun_ıd', '' + $(this).attr('ziy_ıd') + '')

                //$('#Ziyaret_Modal').modal('show');//Eczane_Ziyaret_Tablo
                //var Doktor_Ziyaret_Tablo = $('tbody[id=Doktor_Ziyaret_Tablo]')
                //var Eczane_Ziyaret_Tablo = $('tbody[id=Eczane_Ziyaret_Tablo]')


                //$.ajax({
                //    url: 'Takvim.aspx/Modal_Doldurma_Doktor',
                //    dataType: 'json',
                //    type: 'POST',
                //    data: "{'parametre': '" + $(this).attr('ziy_ıd') + "'}",
                //    contentType: 'application/json; charset=utf-8',
                //    success: function (data) {

                //        Doktor_Ziyaret_Tablo.empty();
                //        Doktor_Ziyaret_Tablo.append("<tr><th>Doktor Adı</th><th>Unite</th><th>Branş</th><th>Brick</th><th>Ziyaret Durumu</th><th>İncele</th></tr>")

                //        var b = 0;
                //        while (data.d.split('!')[b] != null) {
                //            var label_str = ""
                //            if (data.d.split('!')[b].split('-')[5] == "0") {

                //                label_str += '<td><span class="label label-waring">Ziyret Bekleniyor</span></td>'
                //            }
                //            else if (data.d.split('!')[b].split('-')[5] == "1") {
                //                label_str += '<td><span class="label label-success">Ziyret Edildi</span></td>'
                //            }

                //            Doktor_Ziyaret_Tablo.append("<tr><td>" + data.d.split('!')[b].split('-')[1] + "</td><td>" + data.d.split('!')[b].split('-')[2] + "</td><td>" + data.d.split('!')[b].split('-')[3] + "</td><td>" + data.d.split('!')[b].split('-')[4] + "</td>" + label_str + "<td><a value='" + data.d.split('!')[b].split('-')[0] + "' data-toggle='modal' data-dismiss='modal' class='close' data-target='#Ziyaret_Detay' id='Ziyareti_Güncelle'><i class='fa fa fa-search'></i></a></td></tr>");
                //            b++;

                //        }

                //    },// tekrar eklemeyi önlemek için eklenen doktorları tabloya kaydet sonra ona göre listele xd
                //    error: function () {

                //        alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                //    }
                //});
                //$.ajax({
                //    url: 'Takvim.aspx/Modal_Doldurma_Eczane',
                //    dataType: 'json',
                //    type: 'POST',
                //    data: "{'parametre': '" + $(this).attr('ziy_ıd') + "'}",
                //    contentType: 'application/json; charset=utf-8',
                //    success: function (data) {

                //        Eczane_Ziyaret_Tablo.empty();
                //        Eczane_Ziyaret_Tablo.append("<tr><th>Eczane Adı</th><th>Brick</th><th>Ziyaret Durumu</th><th>İncele</th></tr>")

                //        var b = 0;
                //        while (data.d.split('!')[b] != null) {
                //            var label_str = ""
                //            if (data.d.split('!')[b].split('-')[3] == "0") {

                //                label_str += '<td><span class="label label-waring">Ziyret Bekleniyor</span></td>'
                //            }
                //            else if (data.d.split('!')[b].split('-')[3] == "1") {
                //                label_str += '<td><span class="label label-success">Ziyret Edildi</span></td>'
                //            }

                //            Eczane_Ziyaret_Tablo.append("<tr><td>" + data.d.split('!')[b].split('-')[1] + "</td><td>" + data.d.split('!')[b].split('-')[2] + "</td>" + label_str + "<td><a value'" + data.d.split('!')[b].split('-')[0] + "' data-toggle='modal' class='close' data-dismiss='modal' data-target='#Ziyaret_Detay' id='Ziyareti_Güncelle'><i class='fa fa fa-search'></i></a></td></tr>");
                //            b++;

                //        }

                //    },// tekrar eklemeyi önlemek için eklenen doktorları tabloya kaydet sonra ona göre listele xd
                //    error: function () {

                //        alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                //    }
                //});


            });



        }
        //$(document).on('touchstart', "li[id=Gun]", function () {

            

        //    //$('#Ziyaret_Modal').modal('show');//Eczane_Ziyaret_Tablo
        //    //var Doktor_Ziyaret_Tablo = $('tbody[id=Doktor_Ziyaret_Tablo]')
        //    //var Eczane_Ziyaret_Tablo = $('tbody[id=Eczane_Ziyaret_Tablo]')

        //    //$('button[id=Ziyaret_Modal_kapat]').attr('Gun_ıd', '' + $(this).attr('ziy_ıd') +'')
        //    //$.ajax({
        //    //    url: 'Takvim.aspx/Modal_Doldurma_Doktor',
        //    //    dataType: 'json',
        //    //    type: 'POST',
        //    //    data: "{'parametre': '" + $(this).attr('ziy_ıd') + "'}",
        //    //    contentType: 'application/json; charset=utf-8',
        //    //    success: function (data) {

        //    //        Doktor_Ziyaret_Tablo.empty();
        //    //        Doktor_Ziyaret_Tablo.append("<tr><th>Doktor Adı</th><th>Unite</th><th>Branş</th><th>Brick</th><th>Ziyaret Durumu</th><th>İncele</th></tr>")

        //    //        var b = 0;
        //    //        while (data.d.split('!')[b] != null) {
        //    //            var label_str = ""
        //    //            if (data.d.split('!')[b].split('-')[5] == "0") {

        //    //                label_str += '<td><span class="label label-waring">Ziyret Bekleniyor</span></td>'
        //    //            }
        //    //            else if (data.d.split('!')[b].split('-')[5] == "1") {
        //    //                label_str += '<td><span class="label label-success">Ziyret Edildi</span></td>'
        //    //            }

        //    //            Doktor_Ziyaret_Tablo.append("<tr><td>" + data.d.split('!')[b].split('-')[1] + "</td><td>" + data.d.split('!')[b].split('-')[2] + "</td><td>" + data.d.split('!')[b].split('-')[3] + "</td><td>" + data.d.split('!')[b].split('-')[4] + "</td>" + label_str + "<td><a value='" + data.d.split('!')[b].split('-')[0] + "' data-toggle='modal' class='close' data-target='#Ziyaret_Detay' data-dismiss='modal' id='Ziyareti_Güncelle'><i class='fa fa fa-search'></i></a></td></tr>");
        //    //            b++;

        //    //        }

        //    //    },// tekrar eklemeyi önlemek için eklenen doktorları tabloya kaydet sonra ona göre listele xd
        //    //    error: function () {

        //    //        alert('Talep esnasında sorun oluştu.Yeniden deneyin');

        //    //    }
        //    //});
        //    //$.ajax({
        //    //    url: 'Takvim.aspx/Modal_Doldurma_Eczane',
        //    //    dataType: 'json',
        //    //    type: 'POST',
        //    //    data: "{'parametre': '" + $(this).attr('ziy_ıd') + "'}",
        //    //    contentType: 'application/json; charset=utf-8',
        //    //    success: function (data) {

        //    //        Eczane_Ziyaret_Tablo.empty();
        //    //        Eczane_Ziyaret_Tablo.append("<tr><th>Eczane Adı</th><th>Brick</th><th>Ziyaret Durumu</th><th>İncele</th></tr>")

        //    //        var b = 0;
        //    //        while (data.d.split('!')[b] != null) {
        //    //            var label_str = ""
        //    //            if (data.d.split('!')[b].split('-')[3] == "0") {

        //    //                label_str += '<td><span class="label label-waring">Ziyret Bekleniyor</span></td>'
        //    //            }
        //    //            else if (data.d.split('!')[b].split('-')[3] == "1") {
        //    //                label_str += '<td><span class="label label-success">Ziyret Edildi</span></td>'
        //    //            }

        //    //            Eczane_Ziyaret_Tablo.append("<tr><td>" + data.d.split('!')[b].split('-')[1] + "</td><td>" + data.d.split('!')[b].split('-')[2] + "</td>" + label_str + "<td><a value'" + data.d.split('!')[b].split('-')[0] + "' data-toggle='modal' data-dismiss='modal' class='close' data-target='#Ziyaret_Detay' id='Ziyareti_Güncelle'><i class='fa fa fa-search'></i></a></td></tr>");
        //    //            b++;

        //    //        }

        //    //    },// tekrar eklemeyi önlemek için eklenen doktorları tabloya kaydet sonra ona göre listele xd
        //    //    error: function () {

        //    //        alert('Talep esnasında sorun oluştu.Yeniden deneyin');

        //    //    }
        //    //});




        //})
        //$(document).on('click', "a[id=Ziyareti_Güncelle]", function () {//button[id=Ziyareti_Guncelle]
        //    //Urun_1
        //    var Ziyaret_Durumu = $('select[id=Ziyaret_Durumu]')
        //    var Urun_1 = $('select[id=Urun_1]')
        //    var Urun_2 = $('select[id=Urun_2]')
        //    var Urun_3 = $('select[id=Urun_3]')
        //    var Ziyaret_notu = $('textarea[id=Ziyaret_notu]')
        //    var Ziyareti_Guncelle = $('button[id=Ziyareti_Guncelle]')
        //    Urun_1.empty();
        //    Urun_2.empty();
        //    Urun_3.empty();
        //    Ziyaret_notu.empty();

        //    Ziyareti_Guncelle.attr('value', '' + $(this).attr('value') + '')

        //    $.ajax({
        //        url: 'Takvim.aspx/Ziyaret_Detay',
        //        dataType: 'json',
        //        type: 'POST',
        //        data: "{'parametre': '" + $(this).attr('value') + "'}",
        //        contentType: 'application/json; charset=utf-8',
        //        success: function (data) {
        //            Urun_1.removeAttr('disabled')
        //            Urun_2.removeAttr('disabled')
        //            Urun_3.removeAttr('disabled')



        //            if (data.d == "0") {

        //                $("#Ziyaret_Durumu option[value='0']").attr("selected", true);
        //                Urun_1.attr('disabled', 'disabled')
        //                Urun_2.attr('disabled', 'disabled')
        //                Urun_3.attr('disabled', 'disabled')
        //                Ziyaret_notu.attr('disabled', 'disabled')
        //            }
        //            if (data.d == "1") {


        //                $("#Ziyaret_Durumu option[value='1']").attr("selected", true);
        //                Urun_1.removeAttr('disabled')
        //                Urun_2.removeAttr('disabled')
        //                Urun_3.removeAttr('disabled')
        //                Urunleri_Doldur()
        //                $.ajax({
        //                    url: 'Takvim.aspx/Ziyaret_Detayını_Getir',
        //                    dataType: 'json',
        //                    type: 'POST',
        //                    data: "{'parametre': '" + $('button[id=Ziyareti_Guncelle]').attr('value') + "'}",
        //                    contentType: 'application/json; charset=utf-8',
        //                    success: function (data) {
        //                        $("#Urun_1 option[value='" + data.d.split('-')[0] + "']").attr("selected", true);
        //                        $("#Urun_2 option[value='" + data.d.split('-')[1] + "']").attr("selected", true);
        //                        $("#Urun_3 option[value='" + data.d.split('-')[2] + "']").attr("selected", true);
        //                        $("#Ziyaret_notu").html(data.d.split('-')[3])

        //                    },// tekrar eklemeyi önlemek için eklenen doktorları tabloya kaydet sonra ona göre listele xd
        //                    error: function () {

        //                        alert('Talep esnasında sorun oluştu.Yeniden deneyin');

        //                    }
        //                });




        //            }
        //            if (data.d == "2") {

        //                $("#Ziyaret_Durumu option[value='2']").attr("selected", true);
        //                Urun_1.attr('disabled', 'disabled')
        //                Urun_2.attr('disabled', 'disabled')
        //                Urun_3.attr('disabled', 'disabled')
        //            }


        //        },// tekrar eklemeyi önlemek için eklenen doktorları tabloya kaydet sonra ona göre listele xd
        //        error: function () {

        //            alert('Talep esnasında sorun oluştu.Yeniden deneyin');

        //        }
        //    });



        //    $('div[id=Ziyaret_Modal]').modal('hide');


        //    $('div[id=Ziyaret_Detay]').on('hidden.bs.modal', function () {
        //        Modal_Doldur();
        //        $('div[id=Ziyaret_Modal]').modal('show');
        //    })


        //});


        function Urunleri_Doldur() {
            var Urun_1 = $('select[id=Urun_1]')
            var Urun_2 = $('select[id=Urun_2]')
            var Urun_3 = $('select[id=Urun_3]')
            $.ajax({
                url: 'Takvim.aspx/Urunleri_Getir',
                dataType: 'json',
                type: 'POST',
                data: "{'parametre': '" + $(this).attr('value') + "'}",
                contentType: 'application/json; charset=utf-8',
                success: function (data) {
                    Urun_1.empty();
                    Urun_2.empty();
                    Urun_3.empty();
                    Urun_1.append('<option value="0" >Urunler</option>')
                    Urun_2.append('<option value="0" >Urunler</option>')
                    Urun_3.append('<option value="0" >Urunler</option>')
                    var b = 0;
                    while (data.d.split('!')[b] != null) {

                        Urun_1.append('<option value="' + data.d.split('!')[b].split('-')[0] + '">' + data.d.split('!')[b].split('-')[1] + '</option >');

                        Urun_2.append('<option value="' + data.d.split('!')[b].split('-')[0] + '">' + data.d.split('!')[b].split('-')[1] + '</option >');

                        Urun_3.append('<option value="' + data.d.split('!')[b].split('-')[0] + '">' + data.d.split('!')[b].split('-')[1] + '</option >');
                        b++;
                    }


                },// tekrar eklemeyi önlemek için eklenen doktorları tabloya kaydet sonra ona göre listele xd
                error: function () {

                    alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                }
            });


        }//Ziyareti_Guncelle
        $(document).on('change', "select[id=Ziyaret_Durumu]", function () {
            var Urun_1 = $('select[id=Urun_1]')
            var Urun_2 = $('select[id=Urun_2]')
            var Urun_3 = $('select[id=Urun_3]')
            var Ziyaret_notu = $('textarea[id=Ziyaret_notu]')
            if ($(this).val() == "0") {
                Urun_1.attr('disabled', 'disabled')
                Urun_2.attr('disabled', 'disabled')
                Urun_3.attr('disabled', 'disabled')

                Ziyaret_notu.attr('disabled', 'disabled')
            }
            if ($(this).val() == "1") {
                Ziyaret_notu.removeAttr('disabled')

                Urun_1.removeAttr('disabled')
                Urun_2.removeAttr('disabled')
                Urun_3.removeAttr('disabled')
                Urunleri_Doldur();
            }
            if ($(this).val() == "2") {
                Ziyaret_notu.removeAttr('disabled')

                Urun_1.attr('disabled', 'disabled')
                Urun_2.attr('disabled', 'disabled')
                Urun_3.attr('disabled', 'disabled')
            }
        });
        $(document).on('click', "button[id=Ziyareti_Guncelle]", function () {


            var Ziyaret_Durumu = $('select[id=Ziyaret_Durumu]')
            var Urun_1 = $('select[id=Urun_1]')
            var Urun_2 = $('select[id=Urun_2]')
            var Urun_3 = $('select[id=Urun_3]')
            var Ziyaret_notu = $('textarea[id=Ziyaret_notu]')
            if (Ziyaret_Durumu.find('option:selected').val() == "1") {
                $.ajax({
                    url: 'Takvim.aspx/Ziyareti_Güncelle_Edildi',
                    dataType: 'json',
                    type: 'POST',
                    data: "{'parametre': '" + $(this).attr('value') + "-" + Urun_1.find('option:selected').val() + "-" + Urun_2.find('option:selected').val() + "-" + Urun_3.find('option:selected').val() + "-" + Ziyaret_notu.val() + "'}",
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {
                        Urun_1.empty();
                        Urun_2.empty();
                        Urun_3.empty();
                        Ziyaret_notu.empty();
                        Urun_1.append('<option value="0" >Urunler</option>')
                        Urun_2.append('<option value="0" >Urunler</option>')
                        Urun_3.append('<option value="0" >Urunler</option>')


                    },// tekrar eklemeyi önlemek için eklenen doktorları tabloya kaydet sonra ona göre listele xd
                    error: function () {

                        alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                    }
                });

            }
            if (Ziyaret_Durumu.find('option:selected').val() == "2") {
                $.ajax({
                    url: 'Takvim.aspx/Ziyareti_Güncelle_Edilmedi',
                    dataType: 'json',
                    type: 'POST',
                    data: "{'parametre': '" + $(this).attr('value') + "-" + Ziyaret_notu.val() + "'}",
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {
                        Urun_1.empty();
                        Urun_2.empty();
                        Urun_3.empty();
                        Ziyaret_notu.empty();
                        Urun_1.append('<option value="0" >Urunler</option>')
                        Urun_2.append('<option value="0" >Urunler</option>')
                        Urun_3.append('<option value="0" >Urunler</option>')


                    },// tekrar eklemeyi önlemek için eklenen doktorları tabloya kaydet sonra ona göre listele xd
                    error: function () {

                        alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                    }
                });

            }
            if (Ziyaret_Durumu.find('option:selected').val() == "0") {
                $.ajax({
                    url: 'Takvim.aspx/Ziyareti_Güncelle_Bekleniyor',
                    dataType: 'json',
                    type: 'POST',
                    data: "{'parametre': '" + $(this).attr('value') + "'}",
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {
                        Urun_1.empty();
                        Urun_2.empty();
                        Urun_3.empty();
                        Ziyaret_notu.empty();
                        Urun_1.append('<option value="0" >Urunler</option>')
                        Urun_2.append('<option value="0" >Urunler</option>')
                        Urun_3.append('<option value="0" >Urunler</option>')


                    },// tekrar eklemeyi önlemek için eklenen doktorları tabloya kaydet sonra ona göre listele xd
                    error: function () {

                        alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                    }
                });

            }

        });
        Modal_Doldur();




    </script>



</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="Ziyaret_Detay" class="modal fade" tabindex="-2" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Modal Header</h4>
                </div>
                <div class="modal-body">

                    <div class="form-group">
                        <label>Ziyaret Durumu</label>
                        <select id="Ziyaret_Durumu" class="form-control">
                            <option value="0">Ziayeret Bekleniyor</option>
                            <option value="1">Ziayeret Edildi</option>
                            <option value="2">Ziyaret Edilmedi</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Çalışılan Ürün 1</label>
                        <select id="Urun_1" class="form-control">
                            <option>Ürünler</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Çalışılan Ürün 2</label>
                        <select id="Urun_2" class="form-control">
                            <option>Ürünler</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Çalışılan Ürün 3</label>
                        <select id="Urun_3" class="form-control">
                            <option>Ürünler</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label>Ziyaret Notu</label>
                        <textarea id="Ziyaret_notu" class="form-control" rows="3" placeholder="Lütfen Bir not bırakınız ..."></textarea>
                    </div>


                </div>
                <div class="modal-footer">
                    <button id="Ziyareti_Guncelle" type="button" class="btn btn-default" data-dismiss="modal">Güncelle</button>
                </div>
            </div>

        </div>
    </div>

    <!-- Modal -->
    <div id="Ziyaret_Modal" class="modal fade" role="dialog">
        <div class="modal-dialog modal-lg">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 id="Modal_başlık" class="modal-title">Modal Header</h4>
                </div>
                <div id="Modal_Body" class="modal-body">
                    <div class="box box-default collapsed-box">
                        <div style="background-color: #d2d6de !important" class="box-header with-border">
                            <h3 class="box-title">Ziyaret Edilecek Doktorlar</h3>

                            <div class="box-tools pull-right">
                                <button type="button" class="btn btn-box-tool" data-widget="collapse">
                                    <i class="fa fa-plus"></i>
                                </button>
                            </div>
                            <!-- /.box-tools -->
                        </div>
                        <!-- /.box-header -->

                        <div id="Doktor_Body" class="box-body" style="display: none;">
                            <div class="box">

                                <div class="box-body table-responsive no-padding">
                                    <table class="table table-hover">
                                        <tbody id="Doktor_Ziyaret_Tablo">
                                            <tr>
                                                <th>Doktor Adı</th>
                                                <th>Unite</th>
                                                <th>Branş</th>
                                                <th>Brick</th>
                                                <th>Ziyaret Durumu</th>
                                                <th>İncele</th>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                        <!-- /.box-body -->
                    </div>
                    <div class="box box-default collapsed-box">
                        <div style="background-color: #d2d6de !important" class="box-header with-border">
                            <h3 class="box-title">Ziyaret Edilecek Eczaneler</h3>

                            <div class="box-tools pull-right">
                                <button type="button" class="btn btn-box-tool" data-widget="collapse">
                                    <i class="fa fa-plus"></i>
                                </button>
                            </div>
                            <!-- /.box-tools -->
                        </div>
                        <!-- /.box-header -->
                        <div id="Eczane_Body" class="box-body" style="display: none;">

                            <div class="box">

                                <div class="box-body table-responsive no-padding">
                                    <table class="table table-hover">
                                        <tbody id="Eczane_Ziyaret_Tablo">
                                            <tr>
                                                <th>Eczane Adı</th>
                                                <th>Brick</th>
                                                <th>Ziyaret Durumu</th>
                                                <th>İncele</th>

                                            </tr>

                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>

                        <!-- /.box-body -->
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" id="Ziyaret_Modal_kapat" class="btn btn-default" data-dismiss="modal">Close</button>
                </div>
            </div>

        </div>
    </div>

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
