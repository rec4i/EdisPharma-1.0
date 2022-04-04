<%@ Page Title="" Language="C#" MasterPageFile="~/admin.Master" AutoEventWireup="true" EnableEventValidation="false" EnableViewState="false" CodeBehind="ddldeneme.aspx.cs" Inherits="deneme9.ddldeneme" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <style>
        .vertical-alignment-helper {
            display: table;
            height: 100%;
            width: 100%;
            pointer-events: none;
        }

        .vertical-align-center {
            /* To center vertically */
            display: table-cell;
            vertical-align: middle;
            pointer-events: none;
        }

        .modal-content {
            /* Bootstrap sets the size of the modal in the modal-dialog class, we need to inherit it */
            width: inherit;
            max-width: inherit; /* For Bootstrap 4 - to avoid the modal window stretching full width */
            height: inherit;
            /* To center horizontally */
            margin: 0 auto;
            pointer-events: all;
        }
    </style>

    <script type="text/javascript">





        $(document).ready(function () {
            //ekleneceği gün rakamı /

            var mName = ["Ocak", "Subat", "Mart", "Nisan", "Mayis", "Haziran", "Temmuz", "Agustos", "Eylul", "Ekim", "Kasim", "Aralik"];

            // (G1) DATE NOW
            var now = new Date(),
                nowMth = now.getMonth(),
                nowYear = parseInt(now.getFullYear());


            // (G2) APPEND MONTHS SELECTOR
            var month = $('select[id=calmth]')

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
            var year = $('select[id=calyr]')
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
            $('input[id=cal_set]').click(function () {
                var calyr = $('select[id=calyr]');
                var calmth = $('select[id=calmth]')
                window.location.href = "/ddldeneme.aspx?x=" + calyr.val() + "-" + calmth.val()

            });
            var content = $("section[id=content]");
            var Pazar = content.find($("span[name=Pazar]"));
            var pazardiv = Pazar.parent().parent().parent().parent().append("<div class='overlay'></div>");
            var Cumartesi = content.find($("span[name=Cumartesi]"));
            var cumartesidiv = Cumartesi.parent().parent().parent().parent().append("<div class='overlay'></div>");

            var Yıl_DDL = $('select[id=calyr]')
            var Ay_DDL = $('select[id=calmth]')

            $.ajax({
                url: 'ddldeneme.aspx/OFF_Gunler',
                dataType: 'json',
                type: 'POST',
                async: true,
                data: "{'Ay': '" + Ay_DDL.find('option:selected').val() + "'," +
                    "'Yıl':'" + Yıl_DDL.find('option:selected').val() + "'" +
                    "}",
                contentType: 'application/json; charset=utf-8',
                success: function (data) {
                    var temp = JSON.parse(data.d)
                    for (var i = 0; i < temp.length; i++) {
                        var overlay = $('div[off_gun=' + temp[i].Tarih + ']')
                        if (overlay.find('span[id=gun]').attr('name') != "Pazar" && overlay.find('span[id=gun]').attr('name') != "Cumartesi") {
                            overlay.append('<div class="overlay"></div>')
                        }
                    }
                }
            });




            var options = { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' };
            var today = new Date();

            function Tabloları_Doldur() {

                $.ajax({
                    url: 'ddldeneme.aspx/Ziyaret_Edilecekler',
                    dataType: 'json',
                    type: 'POST',

                    data: "{'parametre': '" + Yıl_DDL.find('option:selected').val() + "-" + Ay_DDL.find('option:selected').val() + "'}",
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {

                        for (var i = 0; i < data.d.split('!').length; i++) {// '<td><span class="label label-waring">Ziyret bekleniyor</span></td>'

                            var Header_Gun_span = $('span[id=Header_Gun_span_' + parseInt(data.d.split('!')[i].split('/')[0]) + ']')
                            Header_Gun_span.empty();
                            Header_Gun_span.append("Doktor:" + data.d.split('!')[i].split('/')[2] + "</br>" + "Eczane:" + data.d.split('!')[i].split('/')[1])
                        }

                    },
                    error: function () {

                        alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                    }
                });

                $.ajax({
                    url: 'ddldeneme.aspx/Tabloları_Doldur',
                    dataType: 'json',
                    type: 'POST',
                    data: "{'parametre': '" + Yıl_DDL.find('option:selected').val() + "-" + Ay_DDL.find('option:selected').val() + "'}",
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {
                        var cont = $('section[id=content]')//Header_Gun_span_



                        for (var i = 0; i < data.d.split('!').length; i++) {//undefined


                            var cont = $('section[id=content]')
                            var Doktor_Div = cont.find($('div[id = doktor_' + parseInt(data.d.split('!')[i].split('/')[6]) + ']'));
                            var Doktor_Tablo = Doktor_Div.children().children().children();


                            Doktor_Tablo.empty();
                            Doktor_Tablo.append('<tr><th> Doktor Adı</th><th>Ünite</th> <th>Branş</th><th>Brick</th> <th>Ziyaret Durumu</th><th>Kaldır</th></tr>')





                        }

                        for (var i = 0; i < data.d.split('!').length; i++) {// '<td><span class="label label-waring">Ziyret bekleniyor</span></td>'


                            var label_str = ""
                            if (data.d.split('!')[i].split('/')[5] == "0") {

                                label_str += '<td><span class="label label-waring">Ziyret Bekleniyor</span></td>'
                            }
                            else if (data.d.split('!')[i].split('/')[5] == "1") {
                                label_str += '<td><span class="label label-success">Ziyret Edildi</span></td>'
                            }
                            else if (data.d.split('!')[i].split('/')[5] == "2") {
                                label_str += '<td><span class="label label-danger">Ziyret Edilmedi</span></td>'
                            }


                            var cont = $('section[id=content]')
                            var Doktor_Div = cont.find($('div[id = doktor_' + parseInt(data.d.split('!')[i].split('/')[6]) + ']'));
                            var Doktor_Tablo = Doktor_Div.children().children().children();




                            Doktor_Tablo.append('<tr><td>' + data.d.split('!')[i].split('/')[0] + '</td><td>' + data.d.split('!')[i].split('/')[2] + '</td><td>' + data.d.split('!')[i].split('/')[3] + '</td><td>' + data.d.split('!')[i].split('/')[4] + '</td>' + label_str + '<td> <a style="font-size: 20px; " id="Doktoru_Kaldır" value="' + data.d.split('!')[i].split('/')[9] + '"><i class="fa fa-trash-o"></i></a>  </td>' + '</tr>')





                        }



                    },
                    error: function () {

                        alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                    }
                });

                $.ajax({
                    url: 'ddldeneme.aspx/Tabloları_Doldur_Eczane',
                    dataType: 'json',
                    type: 'POST',
                    data: "{'parametre': '" + Yıl_DDL.find('option:selected').val() + "-" + Ay_DDL.find('option:selected').val() + "'}",
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {
                        var cont = $('section[id=content]')

                        console.log(data.d)
                        //<th>Eczane Adı</th>
                        //                    <th>İl</th>
                        //                    <th>Brick</th>
                        //                    <th>Ziyaret Durumu</th>
                        for (var i = 0; i < data.d.split('!').length; i++) {// '<td><span class="label label-waring">Ziyret bekleniyor</span></td>'

                            var cont = $('section[id=content]')
                            var Doktor_Div = cont.find($('div[id = eczane_' + parseInt(data.d.split('!')[i].split('/')[5]) + ']'));
                            var Doktor_Tablo = Doktor_Div.find($('div[class=box]')).children().children();

                            Doktor_Tablo.empty();
                            Doktor_Tablo.append('<tbody><tr><th>Eczane Adı</th><th>Kenar</th><th>İl</th> <th>Brick</th><th>Ziyaret Durumu</th><th>Kaldır</th></tr></tbody>')


                        }

                        for (var i = 0; i < data.d.split('!').length; i++) {// '<td><span class="label label-waring">Ziyret bekleniyor</span></td>'

                            var label_str = ""
                            if (data.d.split('!')[i].split('/')[4] == "0") {

                                label_str += '<td><span class="label label-waring">Ziyret Bekleniyor</span></td>'
                            }
                            else if (data.d.split('!')[i].split('/')[4] == "1") {
                                label_str += '<td><span class="label label-success">Ziyret Edildi</span></td>'
                            }
                            else if (data.d.split('!')[i].split('/')[4] == "2") {
                                label_str += '<td><span class="label label-danger">Ziyret Edilmedi</span></td>'
                            }

                            var cont = $('section[id=content]')
                            var Doktor_Div = cont.find($('div[id = eczane_' + parseInt(data.d.split('!')[i].split('/')[5]) + ']'));
                            var Doktor_Tablo = Doktor_Div.find($('div[class=box]')).children().children();
                            var Silinme = ""
                            console.log(data.d.split('!')[i].split('/')[5])
                            if (data.d.split('!')[i].split('/')[10] == "0") {
                                console.log("silinir")
                                Silinme += '<a style="font-size: 20px; " id="Doktoru_Kaldır" value="' + data.d.split('!')[i].split('/')[8] + '"><i class="fa fa-trash-o"></i></a>'
                            }
                            else {
                                console.log("Silinemez")
                                Silinme = "Sipariş Kaynaklı Silinemez";
                            }


                            Doktor_Tablo.append('<tr>' +
                                '<td>' + data.d.split('!')[i].split('/')[0] + '</td>>' +
                                '<td>' + data.d.split('!')[i].split('/')[9] + '</td>' +
                                '<td>' + data.d.split('!')[i].split('/')[3] + '</td>' +
                                '<td>' + data.d.split('!')[i].split('/')[2] + '</td>' + label_str + '<td>' + Silinme +
                                '</td>' + '</tr>'
                            )

                        }




                    },
                    error: function () {

                        alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                    }
                });

            }
            Tabloları_Doldur()

            $(document).on('click', 'a[id=Doktoru_Kaldır]', function () {


                var a = $(this).parent().parent()

                $.ajax({
                    url: 'ddldeneme.aspx/Kaldır__', //doktorları listelerken tersten listele 
                    dataType: 'json',
                    type: 'POST',
                    data: "{'parametre': '" + $(this).attr('value') + "'}",//liste cinsini de yolla o gördüğün 0 liste cinsi
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {

                        if (data.d == "0") {
                            Tabloları_Doldur();
                            a.empty();
                        }
                        if (data.d == "5") {
                            alert("Tablo Onaylandıkltan Sonra Düzenleme Yapılamaz!")

                        }


                    }
                });

            });

            var gun_tam_cizgili = $('span[id=gun]').attr('gun_tam_cizgili')
            var Eczane_Frekans_Sıralama = $('input[id=Eczane_Frekans_Sıralama]');
            var Eczane_Frekans_Kontrol = $('div[Id=Eczane_Frekans_Kontrol]');
            var Eczane_Frekans_Kontrol_Liste = $(Eczane_Frekans_Kontrol).find($('select[Id=Eczane_Frekans_Kontrol_Liste]'));//Doktor_Frekans_input//Doktor_Frekans_Kontrol_Table

            var Eczane_Frekans_Kontrol_Table = $(Eczane_Frekans_Kontrol).find($('table[Id=Eczane_Frekans_Kontrol_Table]'));


            Eczane_Frekans_Sıralama.click(function () {
                $.ajax({
                    url: 'ddldeneme.aspx/Yeni_Liste_Olustur_Listeler_Eczane', //doktorları listelerken tersten listele 
                    dataType: 'json',
                    type: 'POST',
                    data: "{'parametre': '" + "0" + "-0'}",//liste cinsini de yolla o gördüğün 0 liste cinsi
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {


                        Eczane_Frekans_Kontrol_Liste.empty();
                        Eczane_Frekans_Kontrol_Table.children().empty();
                        Eczane_Frekans_Kontrol_Table.children().append('<tr><th>Doktor Adı</th><th>Ünite</th><th>Branş</th><th>Frekans</th></tr>')

                        var b = 0;
                        while (data.d.split('!')[b] != null) {

                            Eczane_Frekans_Kontrol_Liste.append("<option value='" + data.d.split('!')[b].split("-")[0] + "'>" + data.d.split('!')[b].split("-")[1] + "</option>");
                            b++;
                        }

                        $.ajax({
                            url: 'ddldeneme.aspx/Eczane_Frekans_Ara', //doktorları listelerken tersten listele //Doktor_Frekans_Sıralama
                            dataType: 'json',
                            type: 'POST',
                            data: "{'parametre': '" + "/" + Eczane_Frekans_Kontrol_Liste.find('option:selected').val() + "/" + gun_tam_cizgili + "'}",//liste cinsini de yolla o gördüğün 0 liste cinsi
                            contentType: 'application/json; charset=utf-8',
                            success: function (data) {
                                Eczane_Frekans_Kontrol_Table.children().empty();
                                Eczane_Frekans_Kontrol_Table.children().append('<tr><th>Doktor Adı</th><th>Ünite</th><th>Branş</th><th>Frekans</th></tr>')



                                var b = 0;
                                while (data.d.split('!')[b] != null) {

                                    Eczane_Frekans_Kontrol_Table.children().append("<tr><td>" + data.d.split('!')[b].split('-')[0] + "</td><td>" + data.d.split('!')[b].split('-')[1] + "</td><td>" + data.d.split('!')[b].split('-')[2] + "</td><td>" + data.d.split('!')[b].split('-')[3] + "/" + data.d.split('!')[b].split('-')[4] + "</td></tr>")
                                    b++;
                                }
                            }
                        });



                    }
                });


            });
            var Eczane_Frekans_input = $(Eczane_Frekans_Kontrol).find($('input[Id=Eczane_Frekans_input]'));
            Eczane_Frekans_input.keypress(function (event) {

                if (event.keyCode == 13) {
                    event.preventDefault();
                }



                $.ajax({
                    url: 'ddldeneme.aspx/Eczane_Frekans_Ara', //doktorları listelerken tersten listele //Doktor_Frekans_Sıralama
                    dataType: 'json',
                    type: 'POST',
                    data: "{'parametre': '" + Eczane_Frekans_input.val() + "/" + Eczane_Frekans_Kontrol_Liste.find('option:selected').val() + "/" + gun_tam_cizgili + "'}",//liste cinsini de yolla o gördüğün 0 liste cinsi
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {

                        Eczane_Frekans_Kontrol_Table.children().empty();
                        Eczane_Frekans_Kontrol_Table.children().append('<tr><th>Doktor Adı</th><th>Ünite</th><th>Branş</th><th>Frekans</th></tr>')


                        var b = 0;
                        while (data.d.split('!')[b] != null) {

                            Eczane_Frekans_Kontrol_Table.children().append("<tr><td>" + data.d.split('!')[b].split('-')[0] + "</td><td>" + data.d.split('!')[b].split('-')[1] + "</td><td>" + data.d.split('!')[b].split('-')[2] + "</td><td>" + data.d.split('!')[b].split('-')[3] + "/" + data.d.split('!')[b].split('-')[4] + "</td></tr>")
                            b++;
                        }
                    }
                });



            });


            $("a[id=btn_addtocart_Eczane]").bind("click", function () {

                var Eczane_Ekle = $('button[id=Eczane_Ekle]')
                Eczane_Ekle.attr('gun_tam_cizgili', $(this).attr('gun_tam_cizgili'))

                var ayrık = $(this).closest($('div[ayrık=true]'));

                var bilgi = $(this).closest($('div[id=bilgi]'));
                var Gun_Rkm = $(bilgi).find($('[id=gun]')).html().replace(/\&nbsp;/g, ' ');
                var Gun_Txt = $(bilgi).find($('[id=Gun_txt]')).html().replace(/\&nbsp;/g, ' ');
                var Ay_Yıl_Txt = $(bilgi).find($('[id=ay_yıl]')).html().replace(/\&nbsp;/g, ' ').replace('<br>', ' ').split(' ');//1 ay 3 yıl

                //Doktor_Modal
                var Dokor_Modal = $('div[Id=Eczane_Modal]');
                var Doktor_Modal_head = $('div[Id=Eczane_modal_head]');
                var Dktr_modal_bslk = $(Doktor_Modal_head).find($('h4[Id=Eczane_modal_bslk]'));
                Dktr_modal_bslk.empty();
                var Dktr_modal_bslk = $(Doktor_Modal_head).find($('h4[Id=Eczane_modal_bslk]')).append(Gun_Rkm + " " + Ay_Yıl_Txt[1] + " " + Gun_Txt);

                var Dktr_Il = $(Dokor_Modal).find($('select[id=Eczane_Il]'));
                var Dktr_Brick = $(Dokor_Modal).find($('select[id=Eczane_brick]'));
                var Dktr_Ad = $(Dokor_Modal).find($('select[id=Eczane_Ad]'));
                var Dktr_Liste = $(Dokor_Modal).find($('select[id=Eczane_Liste]'));
                var Kullanıcı_Adı = "<%=HttpContext.Current.Session["kullanici"]%>";







                $.ajax({
                    url: 'ddldeneme.aspx/Yeni_Liste_Olustur_Listeler_Eczane', //doktorları listelerken tersten listele 
                    dataType: 'json',
                    type: 'POST',
                    data: "{'parametre': '" + Kullanıcı_Adı + "-0'}",//liste cinsini de yolla o gördüğün 0 liste cinsi
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {
                        Dktr_Liste.empty();

                        var b = 0;
                        while (data.d.split('!')[b] != null) {

                            Dktr_Liste.append("<option value='" + data.d.split('!')[b].split("-")[0] + "'>" + data.d.split('!')[b].split("-")[1] + "</option>");
                            b++;
                        }
                    }
                });



                var Tek_Gun = "False";
                var Dktr_Modal_Kaydet = Dokor_Modal.find($('button[id=Eczane_Ekle]'));

                Dktr_Modal_Kaydet.on('click', function () {
                    var cont = $('section[id=content]')

                    var brick_secili = cont.find($('select[id=Eczane_brick]')).find('option:selected').text()
                    var liste_seçili = Dktr_Liste.find('option:selected').val()

                    var gun_tam_cizgili = $(bilgi).find($('[id=gun]')).attr('gun_tam_cizgili')


                    var Dktr_Ad = $(Dokor_Modal).find($('select[id=Eczane_Ad]'));

                    var Dktr_Ad_seçili = Dktr_Ad.find('option:selected')
                    var Dktr_Ad_seçili_frekans = Dktr_Ad.find('option:selected').attr('frekans')
                    var Dktr_Ad_seçili_Id = Dktr_Ad.find('option:selected').attr('value')

                    var hafta_21_Seçili_gun_rkm = $(Dokor_Modal).find($('select[Id=Eczane_frekans_2_1]')).find('option:selected').attr('gun_rkm');
                    var hafta_21_Seçili_ay_rkm = $(Dokor_Modal).find($('select[Id=Eczane_frekans_2_1]')).find('option:selected').attr('ay_rkm');
                    var hafta_21_Seçili_yıl_rkm = $(Dokor_Modal).find($('select[Id=Eczane_frekans_2_1]')).find('option:selected').attr('yıl_rkm');



                    var hafta_41_gun_rkm = $(Dokor_Modal).find($('select[Id=Eczane_frekans_4_1]')).find('option:selected').attr('gun_rkm');
                    var hafta_41_ay_rkm = $(Dokor_Modal).find($('select[Id=Eczane_frekans_4_1]')).find('option:selected').attr('ay_rkm');
                    var hafta_41_yıl_rkm = $(Dokor_Modal).find($('select[Id=Eczane_frekans_4_1]')).find('option:selected').attr('yıl_rkm');


                    var hafta_42_gun_rkm = $(Dokor_Modal).find($('select[Id=Eczane_frekans_4_2]')).find('option:selected').attr('gun_rkm');
                    var hafta_42_ay_rkm = $(Dokor_Modal).find($('select[Id=Eczane_frekans_4_2]')).find('option:selected').attr('ay_rkm');
                    var hafta_42_yıl_rkm = $(Dokor_Modal).find($('select[Id=Eczane_frekans_4_2]')).find('option:selected').attr('yıl_rkm');


                    var hafta_43_gun_rkm = $(Dokor_Modal).find($('select[Id=Eczane_frekans_4_3]')).find('option:selected').attr('gun_rkm');
                    var hafta_43_ay_rkm = $(Dokor_Modal).find($('select[Id=Eczane_frekans_4_3]')).find('option:selected').attr('ay_rkm');
                    var hafta_43_yıl_rkm = $(Dokor_Modal).find($('select[Id=Eczane_frekans_4_3]')).find('option:selected').attr('yıl_rkm');





                    if (Dktr_Ad_seçili.html() == "--&gt;&gt; Lütfen Eczane Adı Seçiniz &lt;&lt;--" || Dktr_Ad_seçili.html() == "undefined" || Dktr_Ad_seçili.text() == "") {
                        Dktr_Ad.parent().removeAttr('class');
                        Dktr_Ad.parent().attr('class', 'form-group has-error')
                    }
                    else {
                        if ($('input[id=Eczane_Sadece_Bu_Gun]').is(':checked')) {
                            var Eczane_Liste = [];

                            var Eczane_Liste_Tablo = {
                                Eczane_Id_: null,
                                Ziy_Tar_: null,
                            }


                            var Dktr_Ad = $('select[id=Eczane_Ad]')
                            Eczane_Liste_Tablo.Eczane_Id_ = Dktr_Ad.find('option:selected').attr('value')
                            Eczane_Liste_Tablo.Ziy_Tar_ = $(this).attr('gun_tam_cizgili')
                            Eczane_Liste.push(Eczane_Liste_Tablo)
                            $.ajax({
                                url: 'Ziyaret-Planı.aspx/Eczane_Ziyaret_Oluştur', //doktorları listelerken tersten listele 
                                dataType: 'json',
                                type: 'POST',
                                async: false,
                                data: "{'Eczane_Listesi': '{Deneme:" + JSON.stringify(Eczane_Liste) + "}'}",
                                contentType: 'application/json; charset=utf-8',
                                success: function (data) {

                                    var temp = JSON.parse(data.d)
                                    if (temp[0].Durum == 0) {
                                        Swal.fire({
                                            title: 'Hata!',
                                            text: 'Seçilen Tarihlerde Daha Önceden Ekleme Yapılmış Lütfen Kontrol Ediniz',
                                            icon: 'error',
                                            confirmButtonText: 'Kapat'
                                        })
                                    }
                                    if (temp[0].Durum == 1) {
                                        Swal.fire({
                                            title: 'Başarılı!',
                                            text: 'İşlem Başarı İle Kaydedildi',
                                            icon: 'success',
                                            confirmButtonText: 'Kapat'
                                        })
                                        Tabloları_Doldur();
                                    }



                                },
                                error: function () {

                                    Swal.fire({
                                        title: 'Hata!',
                                        text: 'Talep esnasında sorun oluştu.Yeniden deneyin',
                                        icon: 'error',
                                        confirmButtonText: 'Kapat'
                                    })

                                }
                            });
                        }

                        else {
                            var Eczane_Liste = [];

                            var Eczane_Liste_Tablo = {
                                Eczane_Id_: null,
                                Ziy_Tar_: null,
                            }


                            var Dktr_Ad = $('select[id=Eczane_Ad]')
                            Eczane_Liste_Tablo.Eczane_Id_ = Dktr_Ad.find('option:selected').attr('value')
                            Eczane_Liste_Tablo.Ziy_Tar_ = $(this).attr('gun_tam_cizgili')
                            Eczane_Liste.push(Eczane_Liste_Tablo)


                            $('select[name=Frekans_Select_Eczane]').each(function () {
                                if ($(this).find('option:selected').attr('eklenmesin') != "True" && $(this).find('option:selected').attr('yıl_rkm') != undefined) {
                                    var Eczane_Liste_Tablo = {
                                        Eczane_Id_: null,
                                        Ziy_Tar_: null,
                                    }

                                    Eczane_Liste_Tablo.Eczane_Id_ = Dktr_Ad.find('option:selected').attr('value')
                                    Eczane_Liste_Tablo.Ziy_Tar_ = $(this).find('option:selected').attr('yıl_rkm') + '-' + $(this).find('option:selected').attr('ay_rkm') + '-' + $(this).find('option:selected').attr('gun_rkm')
                                    Eczane_Liste.push(Eczane_Liste_Tablo)
                                }

                            })

                            $.ajax({
                                url: 'Ziyaret-Planı.aspx/Eczane_Ziyaret_Oluştur', //doktorları listelerken tersten listele 
                                dataType: 'json',
                                type: 'POST',
                                async: false,
                                data: "{'Eczane_Listesi': '{Deneme:" + JSON.stringify(Eczane_Liste) + "}'}",
                                contentType: 'application/json; charset=utf-8',
                                success: function (data) {

                                    var temp = JSON.parse(data.d)
                                    if (temp[0].Durum == 0) {
                                        Swal.fire({
                                            title: 'Hata!',
                                            text: 'Seçilen Tarihlerde Daha Önceden Ekleme Yapılmış Lütfen Kontrol Ediniz',
                                            icon: 'error',
                                            confirmButtonText: 'Kapat'
                                        })
                                    }
                                    if (temp[0].Durum == 1) {
                                        Swal.fire({
                                            title: 'Başarılı!',
                                            text: 'İşlem Başarı İle Kaydedildi',
                                            icon: 'success',
                                            confirmButtonText: 'Kapat'
                                        })
                                        Tabloları_Doldur();
                                    }



                                },
                                error: function () {

                                    Swal.fire({
                                        title: 'Hata!',
                                        text: 'Talep esnasında sorun oluştu.Yeniden deneyin',
                                        icon: 'error',
                                        confirmButtonText: 'Kapat'
                                    })

                                }
                            });

                        }

                    }

                });









                Dktr_Ad.parent().removeAttr("class");
                Dktr_Ad.parent().attr("class", "form-group");
                Dktr_Brick.parent().removeAttr("class");
                Dktr_Brick.parent().attr("class", "form-group");
                Dktr_Il.parent().removeAttr("class");
                Dktr_Il.parent().attr("class", "form-group");


                $.ajax({
                    url: 'ddldeneme.aspx/Şehir_Getir',
                    dataType: 'json',
                    type: 'POST',
                    data: "{}",
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {

                        var temp = JSON.parse(data.d)

                        Dktr_Il.empty();
                        Dktr_Il.append("<option>-->> Lütfen Şehir Seçiniz <<--</option>")

                        for (var i = 0; i < temp.length; i++) {
                            Dktr_Il.append("<option value='" + temp[i].Şehir_Id + "'>" + temp[i].Şehir_Name + "</option>");
                        }


                    },// tekrar eklemeyi önlemek için eklenen doktorları tabloya kaydet sonra ona göre listele xd
                    error: function () {

                        alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                    }
                });

                Dktr_Il.change(function () {



                    Dktr_Il.parent().removeAttr("class");
                    Dktr_Il.parent().attr("class", "form-group");

                    $.ajax({
                        url: 'ddldeneme.aspx/Brick_Getir',
                        dataType: 'json',
                        type: 'POST',
                        data: "{'Şehir_Id': '" + $(this).find('option:selected').attr('value') + "'}",
                        contentType: 'application/json; charset=utf-8',
                        success: function (data) {

                            var temp = JSON.parse(data.d)


                            Dktr_Brick.empty();
                            Dktr_Brick.append("<option>-->> Lütfen Brick Seçiniz <<--</option>");

                            for (var i = 0; i < temp.length; i++) {
                                Dktr_Brick.append("<option value='" + temp[i].Brick_Id + "'>" + temp[i].Brick_Name + "</option>");
                            }

                            if (Dktr_Il.parent().children().find($("select option:first-child")).html() == "--&gt;&gt; Lütfen Şehir Seçiniz &lt;&lt;--") {
                                Dktr_Il.parent().children().find($("select option:first-child")).remove();
                            }
                        }
                    });
                    // tekrar eklemeyi önlemek için eklenen doktorları tabloya kaydet sonra ona göre listele xd
                })
                Dktr_Brick.change(function () {

                    Dktr_Brick.parent().removeAttr("class");
                    Dktr_Brick.parent().attr("class", "form-group");

                    $.ajax({
                        url: 'ddldeneme.aspx/Eczane_Getir',
                        dataType: 'json',
                        type: 'POST',
                        data: "{'Brick_Id': '" + $(this).val() + "','Liste_Id':'" + Dktr_Liste.find('option:selected').val() + "'}",
                        contentType: 'application/json; charset=utf-8',
                        success: function (data) {
                            var temp = JSON.parse(data.d)

                            Dktr_Ad.empty();
                            Dktr_Ad.append("<option>-->> Lütfen Eczane Adı Seçiniz <<--</option>");


                            for (var i = 0; i < temp.length; i++) {
                                Dktr_Ad.append("<option frekans='" + temp[i].Eczane_Frekans + "' value='" + temp[i].Eczane_Id + "'>" + temp[i].Eczane_Name + "</option>");
                            }



                            if (Dktr_Brick.parent().children().find($("select option:first-child")).html() == "--&gt;&gt; Lütfen Brick Seçiniz &lt;&lt;--") {
                                Dktr_Brick.parent().children().find($("select option:first-child")).remove();
                            }
                            var hafta_21_div = $(Dokor_Modal).find($('div[Id=frekans_2_1_div]'));

                            var hafta_41_div = $(Dokor_Modal).find($('div[Id=frekans_4_1_div]'));

                            var hafta_42_div = $(Dokor_Modal).find($('div[Id=frekans_4_2_div]'));

                            var hafta_43_div = $(Dokor_Modal).find($('div[Id=frekans_4_3_div]'));

                            hafta_21_div.attr('style', 'display: none');
                            hafta_41_div.attr('style', 'display: none');
                            hafta_42_div.attr('style', 'display: none');
                            hafta_43_div.attr('style', 'display: none');
                        },
                        error: function () {

                            alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                        }
                    });
                    // tekrar eklemeyi önlemek için eklenen doktorları tabloya kaydet sonra ona göre listele xd
                })



                var Bilgi_Mesajı = $(Dokor_Modal).find($('div[id=Eczane_Bilgi_Mesajı]'));//Bilgi_Mesajı_ayrıkGun
                Bilgi_Mesajı.attr('style', 'display: none');

                var Bilgi_Mesajı_ayrıkGun = $(Dokor_Modal).find($('div[id=Eczane_Bilgi_Mesajı_ayrıkGun]'));
                Bilgi_Mesajı_ayrıkGun.attr('style', 'display: none');


                var hafta_21_div = $(Dokor_Modal).find($('div[Id=Eczane_frekans_2_1_div]'));
                hafta_21_div.attr('style', 'display: none');
                var hafta_41_div = $(Dokor_Modal).find($('div[Id=Eczane_frekans_4_1_div]'));
                hafta_41_div.attr('style', 'display: none');
                var hafta_42_div = $(Dokor_Modal).find($('div[Id=Eczane_frekans_4_2_div]'));
                hafta_42_div.attr('style', 'display: none');
                var hafta_43_div = $(Dokor_Modal).find($('div[Id=Eczane_frekans_4_3_div]'));
                hafta_43_div.attr('style', 'display: none');
                var hafta_21 = $(Dokor_Modal).find($('select[Id=Eczane_frekans_2_1]'));
                hafta_21.empty();
                var hafta_41 = $(Dokor_Modal).find($('select[Id=Eczane_frekans_4_1]'));
                hafta_41.empty();
                var hafta_42 = $(Dokor_Modal).find($('select[Id=Eczane_frekans_4_2]'));
                hafta_42.empty();
                var hafta_43 = $(Dokor_Modal).find($('select[Id=Eczane_frekans_4_3]'));
                hafta_43.empty();

                var ayrık = $(this).closest($('div[id=row]')).attr('ayrık');



                var gun_tam = $(bilgi).find($('[id=gun]')).attr('gun_tam')//Bilgi_Mesajı_Ilk_Tam_Hafta
                var Bilgi_Mesajı_Ilk_Tam_Hafta = $(Dokor_Modal).find($('div[id=Eczane_Bilgi_Mesajı_Ilk_Tam_Hafta]'))
                Bilgi_Mesajı_Ilk_Tam_Hafta.attr('style', 'display: none');


                Bilgi_Mesajı_ayrıkGun.attr('style', 'display: none');
                Bilgi_Mesajı_Ilk_Tam_Hafta.attr('style', 'display: none');
                hafta_21_div.attr('style', 'display: none');
                hafta_41_div.attr('style', 'display: none');
                hafta_42_div.attr('style', 'display: none');
                hafta_43_div.attr('style', 'display: none');
                $('#Eczane_Modal').on('hidden.bs.modal', function () {
                    Dktr_Modal_Kaydet.unbind('click')

                    $("input[id=Eczane_Sadece_Bu_Gun]").prop('checked', false);

                    Dktr_Brick.unbind();
                    Dktr_Ad.unbind();

                    Bilgi_Mesajı_ayrıkGun.attr('style', 'display: none');
                    Bilgi_Mesajı_Ilk_Tam_Hafta.attr('style', 'display: none');

                })

                var gun_tam_cizgili = $(bilgi).find($('[id=gun]')).attr('gun_tam_cizgili')
                var gun_tam = $(bilgi).find($('[id=gun]')).attr('gun_tam')


                var bilgi = $(this).closest($('div[id=bilgi]'));
                var uc_haftamı = "False";
                var dort_haftamı = "False";
                var Ayrıkmı_kont = "False";
                var Doldur = "0";
                $.ajax({
                    url: 'ddldeneme.aspx/Frekans_modal_Doldurma',
                    dataType: 'json',
                    type: 'POST',
                    data: "{'parametre': '" + gun_tam_cizgili.split('-')[0] + "-" + gun_tam_cizgili.split('-')[1] + "'}",
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {

                        var Sadece_Bu_gun_Eczane = $('div[id=Sadece_Bu_gun_Eczane]')

                        for (var i = 0; i < data.d.split('/')[0].split('*').length; i++) {


                            if (data.d.split('/')[0].split('*')[i].split('-')[0] != gun_tam) {
                                Sadece_Bu_gun_Eczane.attr('style', 'visibility: hidden;')
                                Bilgi_Mesajı_Ilk_Tam_Hafta.removeAttr('style')
                                Bilgi_Mesajı_ayrıkGun.attr('style', 'display: none');

                                Ayrıkmı_kont = "True";
                                Doldur = "0";
                                continue;
                            }
                            else {
                                Sadece_Bu_gun_Eczane.attr('style', 'visibility: visible;')
                                Doldur = "1";
                                Bilgi_Mesajı_Ilk_Tam_Hafta.attr('style', 'display: none');
                                Bilgi_Mesajı_ayrıkGun.attr('style', 'display: none');
                                break;
                            }


                        }


                    },
                    error: function () {

                        alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                    }
                });


                Dktr_Ad.change(function ad() {

                    Bilgi_Mesajı_ayrıkGun.attr('style', 'display: none');
                    Bilgi_Mesajı_Ilk_Tam_Hafta.attr('style', 'display: none');

                    hafta_21_div.attr('style', 'display: none');
                    hafta_41_div.attr('style', 'display: none');
                    hafta_42_div.attr('style', 'display: none');
                    hafta_43_div.attr('style', 'display: none');



                    if (Doldur == "1") {
                        gundoldur();
                    }



                });
                var Eczane_Sadece_Bu_Gun = $('input[id=Eczane_Sadece_Bu_Gun]')


                $(document).on('change', 'input[id=Eczane_Sadece_Bu_Gun]', function () {

                    if (this.checked) {
                        Tek_Gun = "True";
                        var Dokor_Modal = $('div[id=Eczane_Modal]');

                        var hafta_21_div = $(Dokor_Modal).find($('div[Id=Eczane_frekans_2_1_div]'));

                        var hafta_41_div = $(Dokor_Modal).find($('div[Id=Eczane_frekans_4_1_div]'));

                        var hafta_42_div = $(Dokor_Modal).find($('div[Id=Eczane_frekans_4_2_div]'));

                        var hafta_43_div = $(Dokor_Modal).find($('div[Id=Eczane_frekans_4_3_div]'));

                        hafta_21_div.attr('style', 'display: none');
                        hafta_41_div.attr('style', 'display: none');
                        hafta_42_div.attr('style', 'display: none');
                        hafta_43_div.attr('style', 'display: none');

                    }
                    else {
                        Tek_Gun = "False";
                        gundoldur();
                    }

                });

                function gundoldur() {
                    if (ayrık == "False") {

                        $.ajax({
                            url: 'ddldeneme.aspx/Frekans_modal_Doldurma',
                            dataType: 'json',
                            type: 'POST',
                            data: "{'parametre': '" + gun_tam_cizgili.split('-')[0] + "-" + gun_tam_cizgili.split('-')[1] + "'}",
                            contentType: 'application/json; charset=utf-8',
                            success: function (data) {


                                var Dokor_Modal = $('div[id=Eczane_Modal]');
                                var Dktr_Ad = $(Dokor_Modal).find($('select[id=Eczane_Ad]'));
                                var Frekans = Dktr_Ad.find('option:selected').attr('frekans')
                                var Bilgi_Mesajı = $(Dokor_Modal).find($('div[id=Eczane_Bilgi_Mesajı]'))
                                var hafta_21_div = $(Dokor_Modal).find($('div[Id=Eczane_frekans_2_1_div]'));
                                var hafta_41_div = $(Dokor_Modal).find($('div[Id=Eczane_frekans_4_1_div]'));
                                var hafta_42_div = $(Dokor_Modal).find($('div[Id=Eczane_frekans_4_2_div]'));
                                var hafta_43_div = $(Dokor_Modal).find($('div[Id=Eczane_frekans_4_3_div]'));
                                var hafta_21 = $(Dokor_Modal).find($('select[Id=Eczane_frekans_2_1]'));
                                var hafta_41 = $(Dokor_Modal).find($('select[Id=Eczane_frekans_4_1]'));
                                var hafta_42 = $(Dokor_Modal).find($('select[Id=Eczane_frekans_4_2]'));
                                var hafta_43 = $(Dokor_Modal).find($('select[Id=Eczane_frekans_4_3]'));



                                hafta_21.empty();
                                hafta_41.empty();
                                hafta_42.empty();
                                hafta_43.empty();


                                if (Frekans == 2) {
                                    if (data.d.split('/').length == 4) {//style="display: none;"  Bilgi_Mesajı

                                        for (var i = 0; i < data.d.split('/')[3].split('*').length; i++) {
                                            hafta_21.append('<option Gun_Rkm=' + data.d.split('/')[2].split('*')[i].split('-')[0].split(' ')[0] + ' Ay_Rkm=' + data.d.split('/')[2].split('*')[i].split('-')[0].split(' ')[1] + ' Yıl_Rkm=' + data.d.split('/')[2].split('*')[i].split('-')[0].split(' ')[2] + ' >' + data.d.split('/')[2].split('*')[i].split('-')[1] + '</option>')
                                        }
                                        hafta_21_div.removeAttr('style')
                                        hafta_41_div.attr('style', 'display: none');
                                        hafta_42_div.attr('style', 'display: none');
                                        hafta_43_div.attr('style', 'display: none');


                                    }
                                    if (data.d.split('/').length == 3) {//style="display: none;"  Bilgi_Mesajı

                                        for (var i = 0; i < data.d.split('/')[2].split('*').length; i++) {
                                            hafta_21.append('<option Gun_Rkm=' + data.d.split('/')[2].split('*')[i].split('-')[0].split(' ')[0] + ' Ay_Rkm=' + data.d.split('/')[2].split('*')[i].split('-')[0].split(' ')[1] + ' Yıl_Rkm=' + data.d.split('/')[2].split('*')[i].split('-')[0].split(' ')[2] + ' >' + data.d.split('/')[2].split('*')[i].split('-')[1] + '</option>')
                                        }
                                        hafta_21_div.removeAttr('style')
                                        hafta_41_div.attr('style', 'display: none');
                                        hafta_42_div.attr('style', 'display: none');
                                        hafta_43_div.attr('style', 'display: none');


                                    }
                                }

                                if (Frekans == 4) {

                                    if (data.d.split('/').length == 4) {//style="display: none;"  Bilgi_Mesajı
                                        dort_haftamı = "True";
                                        hafta_41.append('<option Eklenmesin="True">Eklenmesin</option>')
                                        for (var i = 0; i < data.d.split('/')[3].split('*').length; i++) {
                                            hafta_41.append('<option Gun_Rkm=' + data.d.split('/')[1].split('*')[i].split('-')[0].split(' ')[0] + ' Ay_Rkm=' + data.d.split('/')[1].split('*')[i].split('-')[0].split(' ')[1] + ' Yıl_Rkm=' + data.d.split('/')[1].split('*')[i].split('-')[0].split(' ')[2] + ' >' + data.d.split('/')[1].split('*')[i].split('-')[1] + '</option>')
                                        }
                                        hafta_41_div.removeAttr('style')
                                        hafta_42.append('<option Eklenmesin="True">Eklenmesin</option>')
                                        for (var i = 0; i < data.d.split('/')[3].split('*').length; i++) {
                                            hafta_42.append('<option Gun_Rkm=' + data.d.split('/')[2].split('*')[i].split('-')[0].split(' ')[0] + ' Ay_Rkm=' + data.d.split('/')[2].split('*')[i].split('-')[0].split(' ')[1] + ' Yıl_Rkm=' + data.d.split('/')[2].split('*')[i].split('-')[0].split(' ')[2] + ' >' + data.d.split('/')[2].split('*')[i].split('-')[1] + '</option>')
                                        }
                                        hafta_42_div.removeAttr('style')
                                        hafta_43.append('<option Eklenmesin="True">Eklenmesin</option>')
                                        for (var i = 0; i < data.d.split('/')[3].split('*').length; i++) {
                                            hafta_43.append('<option Gun_Rkm=' + data.d.split('/')[3].split('*')[i].split('-')[0].split(' ')[0] + ' Ay_Rkm=' + data.d.split('/')[3].split('*')[i].split('-')[0].split(' ')[1] + ' Yıl_Rkm=' + data.d.split('/')[3].split('*')[i].split('-')[0].split(' ')[2] + ' >' + data.d.split('/')[3].split('*')[i].split('-')[1] + '</option>')
                                        }
                                        hafta_43_div.removeAttr('style')
                                        hafta_21_div.attr('style', 'display: none');

                                    }
                                    if (data.d.split('/').length == 3) {//style="display: none;"  Bilgi_Mesajı
                                        uc_haftamı = "True"
                                        Bilgi_Mesajı.removeAttr('style')
                                        hafta_41.append('<option Eklenmesin="True">Eklenmesin</option>')
                                        for (var i = 0; i < data.d.split('/')[1].split('*').length - 1; i++) {
                                            hafta_41.append('<option Gun_Rkm=' + data.d.split('/')[1].split('*')[i].split('-')[0].split(' ')[0] + ' Ay_Rkm=' + data.d.split('/')[1].split('*')[i].split('-')[0].split(' ')[1] + ' Yıl_Rkm=' + data.d.split('/')[1].split('*')[i].split('-')[0].split(' ')[2] + ' >' + data.d.split('/')[1].split('*')[i].split('-')[1] + '</option>')
                                        }
                                        hafta_41_div.removeAttr('style')
                                        hafta_42.append('<option Eklenmesin="True">Eklenmesin</option>')
                                        for (var i = 0; i < data.d.split('/')[2].split('*').length; i++) {
                                            hafta_42.append('<option Gun_Rkm=' + data.d.split('/')[2].split('*')[i].split('-')[0].split(' ')[0] + ' Ay_Rkm=' + data.d.split('/')[2].split('*')[i].split('-')[0].split(' ')[1] + ' Yıl_Rkm=' + data.d.split('/')[2].split('*')[i].split('-')[0].split(' ')[2] + ' >' + data.d.split('/')[2].split('*')[i].split('-')[1] + '</option>')
                                        }
                                        hafta_42_div.removeAttr('style')
                                        hafta_21_div.attr('style', 'display: none');


                                    }
                                }


                            },
                            error: function () {

                                alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                            }
                        });
                    }
                    else {

                        hafta_21_div.attr('style', 'display: none');
                        hafta_41_div.attr('style', 'display: none');
                        hafta_42_div.attr('style', 'display: none');
                        hafta_43_div.attr('style', 'display: none');

                    }

                };







                Dktr_Brick.empty();

                Dktr_Ad.empty();



            });


            var gun_tam_cizgili = $('span[id=gun]').attr('gun_tam_cizgili')








            var Doktor_Frekans_Sıralama = $('input[id=Doktor_Frekans_Sıralama]');
            var Doktor_Frekans_Kontrol = $('div[Id=Doktor_Frekans_Kontrol]');
            var Doktor_Frekans_Kontrol_Liste = $(Doktor_Frekans_Kontrol).find($('select[Id=Doktor_Frekans_Kontrol_Liste]'));//Doktor_Frekans_input//Doktor_Frekans_Kontrol_Table

            var Doktor_Frekans_Kontrol_Table = $(Doktor_Frekans_Kontrol).find($('table[Id=Doktor_Frekans_Kontrol_Table]'));


            Doktor_Frekans_Sıralama.click(function () {
                $.ajax({
                    url: 'ddldeneme.aspx/Yeni_Liste_Olustur_Listeler', //doktorları listelerken tersten listele 
                    dataType: 'json',
                    type: 'POST',
                    data: "{'parametre': '" + "0" + "-0'}",//liste cinsini de yolla o gördüğün 0 liste cinsi
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {


                        Doktor_Frekans_Kontrol_Liste.empty();
                        Doktor_Frekans_Kontrol_Table.children().empty();
                        Doktor_Frekans_Kontrol_Table.children().append('<tr><th>Doktor Adı</th><th>Ünite</th><th>Branş</th><th>Frekans</th></tr>')

                        var b = 0;
                        while (data.d.split('!')[b] != null) {

                            Doktor_Frekans_Kontrol_Liste.append("<option value='" + data.d.split('!')[b].split("-")[0] + "'>" + data.d.split('!')[b].split("-")[1] + "</option>");
                            b++;
                        }

                        $.ajax({
                            url: 'ddldeneme.aspx/Doktor_Frekans_Ara', //doktorları listelerken tersten listele //Doktor_Frekans_Sıralama
                            dataType: 'json',
                            type: 'POST',
                            data: "{'parametre': '" + "/" + Doktor_Frekans_Kontrol_Liste.find('option:selected').val() + "/" + gun_tam_cizgili + "'}",//liste cinsini de yolla o gördüğün 0 liste cinsi
                            contentType: 'application/json; charset=utf-8',
                            success: function (data) {
                                Doktor_Frekans_Kontrol_Table.children().empty();
                                Doktor_Frekans_Kontrol_Table.children().append('<tr><th>Doktor Adı</th><th>Ünite</th><th>Branş</th><th>Frekans</th></tr>')



                                var b = 0;
                                while (data.d.split('!')[b] != null) {

                                    Doktor_Frekans_Kontrol_Table.children().append("<tr><td>" + data.d.split('!')[b].split('-')[0] + "</td><td>" + data.d.split('!')[b].split('-')[1] + "</td><td>" + data.d.split('!')[b].split('-')[2] + "</td><td>" + data.d.split('!')[b].split('-')[3] + "/" + data.d.split('!')[b].split('-')[4] + "</td></tr>")
                                    b++;
                                }
                            }
                        });



                    }
                });

            });

            var Doktor_Frekans_input = $(Doktor_Frekans_Kontrol).find($('input[Id=Doktor_Frekans_input]'));
            Doktor_Frekans_input.keypress(function (event) {

                if (event.keyCode == 13) {
                    event.preventDefault();
                }



                $.ajax({
                    url: 'ddldeneme.aspx/Doktor_Frekans_Ara', //doktorları listelerken tersten listele //Doktor_Frekans_Sıralama
                    dataType: 'json',
                    type: 'POST',
                    data: "{'parametre': '" + Doktor_Frekans_input.val() + "/" + Doktor_Frekans_Kontrol_Liste.find('option:selected').val() + "/" + gun_tam_cizgili + "'}",//liste cinsini de yolla o gördüğün 0 liste cinsi
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {

                        Doktor_Frekans_Kontrol_Table.children().empty();
                        Doktor_Frekans_Kontrol_Table.children().append('<tr><th>Doktor Adı</th><th>Ünite</th><th>Branş</th><th>Frekans</th></tr>')


                        var b = 0;
                        while (data.d.split('!')[b] != null) {

                            Doktor_Frekans_Kontrol_Table.children().append("<tr><td>" + data.d.split('!')[b].split('-')[0] + "</td><td>" + data.d.split('!')[b].split('-')[1] + "</td><td>" + data.d.split('!')[b].split('-')[2] + "</td><td>" + data.d.split('!')[b].split('-')[3] + "/" + data.d.split('!')[b].split('-')[4] + "</td></tr>")
                            b++;
                        }
                    }
                });



            });

            $("a[id=btn_addtocart_Doktor]").bind("click", function () {

                var Ekle = $('button[id=Ekle]')
                Ekle.attr('gun_tam_cizgili', $(this).attr('gun_tam_cizgili'))

                var ayrık = $(this).closest($('div[ayrık=true]'));

                var bilgi = $(this).closest($('div[id=bilgi]'));
                var Gun_Rkm = $(bilgi).find($('[id=gun]')).html().replace(/\&nbsp;/g, ' ');
                var Gun_Txt = $(bilgi).find($('[id=Gun_txt]')).html().replace(/\&nbsp;/g, ' ');
                var Ay_Yıl_Txt = $(bilgi).find($('[id=ay_yıl]')).html().replace(/\&nbsp;/g, ' ').replace('<br>', ' ').split(' ');//1 ay 3 yıl

                //Doktor_Modal
                var Dokor_Modal = $('div[Id=Doktor_Modal]');
                var Doktor_Modal_head = $('div[id=doktor_modal_head]');
                var Dktr_modal_bslk = $(Doktor_Modal_head).find($('h4[id=Dktr_modal_bslk]'));
                Dktr_modal_bslk.empty();
                var Dktr_modal_bslk = $(Doktor_Modal_head).find($('h4[id=Dktr_modal_bslk]')).append(Gun_Rkm + " " + Ay_Yıl_Txt[1] + " " + Gun_Txt);

                var Dktr_Il = $(Dokor_Modal).find($('select[id=Dktr_Il]'));
                var Dktr_Brick = $(Dokor_Modal).find($('select[id=Dktr_brick]'));
                var Dktr_Unite = $(Dokor_Modal).find($('select[id=Dktr_Unite]'));
                var Dktr_Brans = $(Dokor_Modal).find($('select[id=Dktr_Brans]'));
                var Dktr_Ad = $(Dokor_Modal).find($('select[id=Dktr_Ad]'));
                var Dktr_Liste = $(Dokor_Modal).find($('select[Id=Dktr_Liste]'));
                var Kullanıcı_Adı = "<%=HttpContext.Current.Session["kullanici"]%>";







                $.ajax({
                    url: 'ddldeneme.aspx/Yeni_Liste_Olustur_Listeler', //doktorları listelerken tersten listele 
                    dataType: 'json',
                    type: 'POST',
                    data: "{'parametre': '" + Kullanıcı_Adı + "-0'}",//liste cinsini de yolla o gördüğün 0 liste cinsi
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {
                        Dktr_Liste.empty();

                        var b = 0;
                        while (data.d.split('!')[b] != null) {

                            Dktr_Liste.append("<option value='" + data.d.split('!')[b].split("-")[0] + "'>" + data.d.split('!')[b].split("-")[1] + "</option>");
                            b++;
                        }
                    }
                });



                var liste_seçili = Dktr_Liste.find('option:selected').val()
                var Tek_Gun = "False"
                var Dktr_Modal_Kaydet = Dokor_Modal.find($('button[id=Ekle]'))



                Dktr_Modal_Kaydet.on('click', function () {
                    var cont = $('section[id=content]')

                    var brick_secili = cont.find($('select[id=Dktr_brick]')).find('option:selected').text()
                    var unite_secili = cont.find($('select[id=Dktr_Unite]')).find('option:selected').text()
                    var branş_secili = cont.find($('select[id=Dktr_Brans]')).find('option:selected').text()//Dktr_Liste
                    var liste_seçili = Dktr_Liste.find('option:selected').val()

                    var gun_tam_cizgili = $(bilgi).find($('[id=gun]')).attr('gun_tam_cizgili')

                    var Dktr_Ad = $(Dokor_Modal).find($('select[id=Dktr_Ad]'));

                    var Dktr_Ad_seçili = Dktr_Ad.find('option:selected')
                    var Dktr_Ad_seçili_frekans = Dktr_Ad.find('option:selected').attr('frekans')
                    var Dktr_Ad_seçili_Id = Dktr_Ad.find('option:selected').attr('value')

                    var hafta_21_Seçili_gun_rkm = $(Dokor_Modal).find($('select[Id=frekans_2_1]')).find('option:selected').attr('gun_rkm');
                    var hafta_21_Seçili_ay_rkm = $(Dokor_Modal).find($('select[Id=frekans_2_1]')).find('option:selected').attr('ay_rkm');
                    var hafta_21_Seçili_yıl_rkm = $(Dokor_Modal).find($('select[Id=frekans_2_1]')).find('option:selected').attr('yıl_rkm');



                    var hafta_41_gun_rkm = $(Dokor_Modal).find($('select[Id=frekans_4_1]')).find('option:selected').attr('gun_rkm');
                    var hafta_41_ay_rkm = $(Dokor_Modal).find($('select[Id=frekans_4_1]')).find('option:selected').attr('ay_rkm');
                    var hafta_41_yıl_rkm = $(Dokor_Modal).find($('select[Id=frekans_4_1]')).find('option:selected').attr('yıl_rkm');


                    var hafta_42_gun_rkm = $(Dokor_Modal).find($('select[Id=frekans_4_2]')).find('option:selected').attr('gun_rkm');
                    var hafta_42_ay_rkm = $(Dokor_Modal).find($('select[Id=frekans_4_2]')).find('option:selected').attr('ay_rkm');
                    var hafta_42_yıl_rkm = $(Dokor_Modal).find($('select[Id=frekans_4_2]')).find('option:selected').attr('yıl_rkm');


                    var hafta_43_gun_rkm = $(Dokor_Modal).find($('select[Id=frekans_4_3]')).find('option:selected').attr('gun_rkm');
                    var hafta_43_ay_rkm = $(Dokor_Modal).find($('select[Id=frekans_4_3]')).find('option:selected').attr('ay_rkm');
                    var hafta_43_yıl_rkm = $(Dokor_Modal).find($('select[Id=frekans_4_3]')).find('option:selected').attr('yıl_rkm');

                    if (Dktr_Ad_seçili.text() == "--&gt;&gt; Lütfen Doktor Adı Seçiniz &lt;&lt;--" || Dktr_Ad_seçili.text() == "undefined" || Dktr_Ad_seçili.text() == "" || Dktr_Ad_seçili.val() == "hata") {

                        Dktr_Ad.parent().removeAttr('class');
                        Dktr_Ad.parent().attr('class', 'form-group has-error')
                    }
                    else {



                        if ($('input[id=Doktor_Sadece_Bu_Gun]').is(':checked')) {
                            var Doktor_Liste = [];

                            var Doktor_Liste_Tablo = {
                                Doktor_Id_: null,
                                Ziy_Tar_: null,
                            }


                            var Dktr_Ad = $('select[id=Dktr_Ad]')
                            Doktor_Liste_Tablo.Doktor_Id_ = Dktr_Ad.find('option:selected').attr('value')
                            Doktor_Liste_Tablo.Ziy_Tar_ = $(this).attr('gun_tam_cizgili')
                            Doktor_Liste.push(Doktor_Liste_Tablo)
                            $.ajax({
                                url: 'Ziyaret-Planı.aspx/Doktor_Ziyaret_Oluştur', //doktorları listelerken tersten listele 
                                dataType: 'json',
                                type: 'POST',
                                async: false,
                                data: "{'Doktor_Listesi': '{Deneme:" + JSON.stringify(Doktor_Liste) + "}'}",
                                contentType: 'application/json; charset=utf-8',
                                success: function (data) {
                                    var temp = JSON.parse(data.d)
                                    if (temp[0].Durum == 0) {
                                        Swal.fire({
                                            title: 'Hata!',
                                            text: 'Seçilen Tarihlerde Daha Önceden Ekleme Yapılmış Lütfen Kontrol Ediniz',
                                            icon: 'error',
                                            confirmButtonText: 'Kapat'
                                        })
                                    }
                                    if (temp[0].Durum == 1) {
                                        Swal.fire({
                                            title: 'Başarılı!',
                                            text: 'İşlem Başarı İle Kaydedildi',
                                            icon: 'success',
                                            confirmButtonText: 'Kapat'
                                        })
                                        Tabloları_Doldur();
                                    }

                                },
                                error: function () {

                                    Swal.fire({
                                        title: 'Hata!',
                                        text: 'Talep esnasında sorun oluştu.Yeniden deneyin',
                                        icon: 'error',
                                        confirmButtonText: 'Kapat'
                                    })

                                }
                            });
                        }

                        else {
                            var Doktor_Liste = [];

                            var Doktor_Liste_Tablo = {
                                Doktor_Id_: null,
                                Ziy_Tar_: null,
                            }


                            var Dktr_Ad = $('select[id=Dktr_Ad]')
                            Doktor_Liste_Tablo.Doktor_Id_ = Dktr_Ad.find('option:selected').attr('value')
                            Doktor_Liste_Tablo.Ziy_Tar_ = $(this).attr('gun_tam_cizgili')
                            Doktor_Liste.push(Doktor_Liste_Tablo)


                            $('select[name=Frekans_Select_Doktor]').each(function () {
                                if ($(this).find('option:selected').attr('eklenmesin') != "True" && $(this).find('option:selected').attr('yıl_rkm') != undefined) {
                                    var Doktor_Liste_Tablo = {
                                        Doktor_Id_: null,
                                        Ziy_Tar_: null,
                                    }
                                    console.log($(this).find('option:selected').attr('yıl_rkm'))
                                    console.log($(this).find('option:selected').attr('ay_rkm'))
                                    console.log($(this).find('option:selected').attr('gun_rkm'))
                                    Doktor_Liste_Tablo.Doktor_Id_ = Dktr_Ad.find('option:selected').attr('value')
                                    Doktor_Liste_Tablo.Ziy_Tar_ = $(this).find('option:selected').attr('yıl_rkm') + '-' + $(this).find('option:selected').attr('ay_rkm') + '-' + $(this).find('option:selected').attr('gun_rkm')
                                    Doktor_Liste.push(Doktor_Liste_Tablo)
                                }

                            })

                            $.ajax({
                                url: 'Ziyaret-Planı.aspx/Doktor_Ziyaret_Oluştur', //doktorları listelerken tersten listele 
                                dataType: 'json',
                                type: 'POST',
                                async: false,
                                data: "{'Doktor_Listesi': '{Deneme:" + JSON.stringify(Doktor_Liste) + "}'}",
                                contentType: 'application/json; charset=utf-8',
                                success: function (data) {
                                    var temp = JSON.parse(data.d)
                                    if (temp[0].Durum == 0) {
                                        Swal.fire({
                                            title: 'Hata!',
                                            text: 'Seçilen Tarihlerde Daha Önceden Ekleme Yapılmış Lütfen Kontrol Ediniz',
                                            icon: 'error',
                                            confirmButtonText: 'Kapat'
                                        })
                                    }
                                    if (temp[0].Durum == 1) {
                                        Swal.fire({
                                            title: 'Başarılı!',
                                            text: 'İşlem Başarı İle Kaydedildi',
                                            icon: 'success',
                                            confirmButtonText: 'Kapat'
                                        })
                                        Tabloları_Doldur();
                                    }

                                },
                                error: function () {

                                    Swal.fire({
                                        title: 'Hata!',
                                        text: 'Talep esnasında sorun oluştu.Yeniden deneyin',
                                        icon: 'error',
                                        confirmButtonText: 'Kapat'
                                    })

                                }
                            });

                        }





                    }

                });









                Dktr_Ad.parent().removeAttr("class");
                Dktr_Ad.parent().attr("class", "form-group");
                Dktr_Brans.parent().removeAttr("class");
                Dktr_Brans.parent().attr("class", "form-group");
                Dktr_Unite.parent().removeAttr("class");
                Dktr_Unite.parent().attr("class", "form-group");
                Dktr_Brick.parent().removeAttr("class");
                Dktr_Brick.parent().attr("class", "form-group");
                Dktr_Il.parent().removeAttr("class");
                Dktr_Il.parent().attr("class", "form-group");


                $.ajax({
                    url: 'ddldeneme.aspx/Şehir_Getir',
                    dataType: 'json',
                    type: 'POST',
                    data: "{}",
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {

                        var temp = JSON.parse(data.d)

                        Dktr_Il.empty();
                        Dktr_Il.append("<option>-->> Lütfen Şehir Seçiniz <<--</option>")

                        for (var i = 0; i < temp.length; i++) {
                            Dktr_Il.append("<option value='" + temp[i].Şehir_Id + "'>" + temp[i].Şehir_Name + "</option>");
                        }


                    },// tekrar eklemeyi önlemek için eklenen doktorları tabloya kaydet sonra ona göre listele xd
                    error: function () {

                        alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                    }
                });



                Dktr_Il.change(function () {
                    Dktr_Il.parent().removeAttr("class");
                    Dktr_Il.parent().attr("class", "form-group");
                    $.ajax({
                        url: 'ddldeneme.aspx/Brick_Getir',
                        dataType: 'json',
                        type: 'POST',
                        data: "{'Şehir_Id': '" + $(this).find('option:selected').attr('value') + "'}",
                        contentType: 'application/json; charset=utf-8',
                        success: function (data) {

                            var temp = JSON.parse(data.d)


                            Dktr_Brick.empty();
                            Dktr_Brick.append("<option>-->> Lütfen Brick Seçiniz <<--</option>");

                            for (var i = 0; i < temp.length; i++) {
                                Dktr_Brick.append("<option value='" + temp[i].Brick_Id + "'>" + temp[i].Brick_Name + "</option>");
                            }

                            if (Dktr_Il.parent().children().find($("select option:first-child")).html() == "--&gt;&gt; Lütfen Şehir Seçiniz &lt;&lt;--") {
                                Dktr_Il.parent().children().find($("select option:first-child")).remove();
                            }
                        }
                    });
                    // tekrar eklemeyi önlemek için eklenen doktorları tabloya kaydet sonra ona göre listele xd
                });


                Dktr_Brick.change(function () {

                    Dktr_Brick.parent().removeAttr("class");
                    Dktr_Brick.parent().attr("class", "form-group");

                    $.ajax({
                        url: 'ddldeneme.aspx/Unite_Getir',
                        dataType: 'json',
                        type: 'POST',
                        data: "{'Brick_Id': '" + $(this).val() + "'}",
                        contentType: 'application/json; charset=utf-8',
                        success: function (data) {

                            var temp = JSON.parse(data.d)

                            Dktr_Unite.empty();
                            Dktr_Unite.append("<option>-->> Lütfen Ünite Seçiniz <<--</option>");


                            for (var i = 0; i < temp.length; i++) {
                                Dktr_Unite.append("<option value='" + temp[i].Unite_Id + "'>" + temp[i].Unite_Name + "</option>");
                            }


                            if (Dktr_Brick.parent().children().find($("select option:first-child")).html() == "--&gt;&gt; Lütfen Brick Seçiniz &lt;&lt;--") {
                                Dktr_Brick.parent().children().find($("select option:first-child")).remove();
                            }
                        },
                        error: function () {

                            alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                        }
                    });
                    // tekrar eklemeyi önlemek için eklenen doktorları tabloya kaydet sonra ona göre listele xd
                });
                Dktr_Unite.change(function () {
                    Dktr_Unite.parent().removeAttr("class");
                    Dktr_Unite.parent().attr("class", "form-group");

                    $.ajax({
                        url: 'ddldeneme.aspx/Branş_Getir',
                        dataType: 'json',
                        type: 'POST',
                        data: "{'Unite_Id': '" + $(this).val() + "'}",
                        contentType: 'application/json; charset=utf-8',
                        success: function (data) {

                            var temp = JSON.parse(data.d)
                            Dktr_Brans.empty();
                            Dktr_Brans.append("<option>-->> Lütfen Branş Seçiniz <<--</option>");

                            for (var i = 0; i < temp.length; i++) {
                                Dktr_Brans.append("<option value='" + temp[i].Branş_Id + "'>" + temp[i].Branş_Name + "</option>");
                            }



                            if (Dktr_Unite.parent().children().find($("select option:first-child")).html() == "--&gt;&gt; Lütfen Ünite Seçiniz &lt;&lt;--") {
                                Dktr_Unite.parent().children().find($("select option:first-child")).remove();
                            }
                        },
                        error: function () {

                            alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                        }
                    });

                });
                Dktr_Brans.change(function () {

                    Dktr_Brans.parent().removeAttr("class");
                    Dktr_Brans.parent().attr("class", "form-group");

                    $.ajax({
                        url: 'ddldeneme.aspx/Doktor_Getir',
                        dataType: 'json',
                        type: 'POST',
                        data: "{'Branş_Id': '" + $(this).val() + "','Liste_Id':'" + Dktr_Liste.find('option:selected').attr('value') + "','Unite_Id':'" + Dktr_Unite.find('option:selected').attr('value') + "'}",
                        contentType: 'application/json; charset=utf-8',
                        success: function (data) {


                            var temp = JSON.parse(data.d)
                            console.log(temp)
                            Dktr_Ad.empty();
                            Dktr_Ad.append(" <option>-->> Lütfen Doktor Adı Seçiniz <<--</option>");

                            for (var i = 0; i < temp.length; i++) {
                                Dktr_Ad.append("<option frekans=" + temp[i].Doktor_Frekans + " value='" + temp[i].Doktor_Id + "'>" + temp[i].Doktor_Name + "</option>");


                            }


                            if (Dktr_Brans.parent().children().find($("select option:first-child")).html() == "--&gt;&gt; Lütfen Branş Seçiniz &lt;&lt;--") {
                                Dktr_Brans.parent().children().find($("select option:first-child")).remove();
                            }


                            var hafta_21_div = $(Dokor_Modal).find($('div[Id=frekans_2_1_div]'));

                            var hafta_41_div = $(Dokor_Modal).find($('div[Id=frekans_4_1_div]'));

                            var hafta_42_div = $(Dokor_Modal).find($('div[Id=frekans_4_2_div]'));

                            var hafta_43_div = $(Dokor_Modal).find($('div[Id=frekans_4_3_div]'));

                            hafta_21_div.attr('style', 'display: none');
                            hafta_41_div.attr('style', 'display: none');
                            hafta_42_div.attr('style', 'display: none');
                            hafta_43_div.attr('style', 'display: none');
                        },
                        error: function () {

                            alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                        }
                    });// sadece 1 kere silecek şekilde ayarla sikim

                })//cal-yr

                var Bilgi_Mesajı = $(Dokor_Modal).find($('div[id=Bilgi_Mesajı]'));//Bilgi_Mesajı_ayrıkGun
                Bilgi_Mesajı.attr('style', 'display: none');

                var Bilgi_Mesajı_ayrıkGun = $(Dokor_Modal).find($('div[id=Bilgi_Mesajı_ayrıkGun]'));
                Bilgi_Mesajı_ayrıkGun.attr('style', 'display: none');


                var hafta_21_div = $(Dokor_Modal).find($('div[Id=frekans_2_1_div]'));
                hafta_21_div.attr('style', 'display: none');
                var hafta_41_div = $(Dokor_Modal).find($('div[Id=frekans_4_1_div]'));
                hafta_41_div.attr('style', 'display: none');
                var hafta_42_div = $(Dokor_Modal).find($('div[Id=frekans_4_2_div]'));
                hafta_42_div.attr('style', 'display: none');
                var hafta_43_div = $(Dokor_Modal).find($('div[Id=frekans_4_3_div]'));
                hafta_43_div.attr('style', 'display: none');
                var hafta_21 = $(Dokor_Modal).find($('select[Id=frekans_2_1]'));
                hafta_21.empty();
                var hafta_41 = $(Dokor_Modal).find($('select[Id=frekans_4_1]'));
                hafta_41.empty();
                var hafta_42 = $(Dokor_Modal).find($('select[Id=frekans_4_2]'));
                hafta_42.empty();
                var hafta_43 = $(Dokor_Modal).find($('select[Id=frekans_4_3]'));
                hafta_43.empty();

                var ayrık = $(this).closest($('div[id=row]')).attr('ayrık');



                var gun_tam = $(bilgi).find($('[id=gun]')).attr('gun_tam')//Bilgi_Mesajı_Ilk_Tam_Hafta
                var Bilgi_Mesajı_Ilk_Tam_Hafta = $(Dokor_Modal).find($('div[id=Bilgi_Mesajı_Ilk_Tam_Hafta]'))
                Bilgi_Mesajı_Ilk_Tam_Hafta.attr('style', 'display: none');


                Bilgi_Mesajı_ayrıkGun.attr('style', 'display: none');
                Bilgi_Mesajı_Ilk_Tam_Hafta.attr('style', 'display: none');
                hafta_21_div.attr('style', 'display: none');
                hafta_41_div.attr('style', 'display: none');
                hafta_42_div.attr('style', 'display: none');
                hafta_43_div.attr('style', 'display: none');
                $('#Doktor_Modal').on('hidden.bs.modal', function () {
                    Dktr_Modal_Kaydet.unbind('click')
                    Dktr_Ad.parent().removeAttr('class');
                    Dktr_Ad.parent().attr('class', 'form-group')
                    $("input[id=Doktor_Sadece_Bu_Gun]").prop('checked', false);
                    Dktr_Brick.unbind();
                    Dktr_Unite.unbind();
                    Dktr_Brans.unbind();
                    Dktr_Ad.unbind();
                    Bilgi_Mesajı_ayrıkGun.attr('style', 'display: none');
                    Bilgi_Mesajı_Ilk_Tam_Hafta.attr('style', 'display: none');
                });

                var gun_tam_cizgili = $(bilgi).find($('[id=gun]')).attr('gun_tam_cizgili')
                var gun_tam = $(bilgi).find($('[id=gun]')).attr('gun_tam')


                var bilgi = $(this).closest($('div[id=bilgi]'));
                var uc_haftamı = "False";
                var dort_haftamı = "False";
                var Ayrıkmı_kont = "False";
                var Doldur = "0";
                $.ajax({
                    url: 'ddldeneme.aspx/Frekans_modal_Doldurma',
                    dataType: 'json',
                    type: 'POST',
                    data: "{'parametre': '" + gun_tam_cizgili.split('-')[0] + "-" + gun_tam_cizgili.split('-')[1] + "'}",
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {
                        style = "visibility:hidden"
                        var Sadece_Bu_gun_Eczane = $('div[id=Sadece_Bu_gun_Doktor]')
                        for (var i = 0; i < data.d.split('/')[0].split('*').length; i++) {


                            if (data.d.split('/')[0].split('*')[i].split('-')[0] != gun_tam) {
                                Sadece_Bu_gun_Eczane.attr('style', "visibility: hidden")
                                Bilgi_Mesajı_Ilk_Tam_Hafta.removeAttr('style')
                                Bilgi_Mesajı_ayrıkGun.attr('style', 'display: none');

                                Ayrıkmı_kont = "True";
                                Doldur = "0";

                                continue;
                            }
                            else {
                                Sadece_Bu_gun_Eczane.attr('style', "visibility: visible")
                                Doldur = "1";
                                Bilgi_Mesajı_Ilk_Tam_Hafta.attr('style', 'display: none');
                                Bilgi_Mesajı_ayrıkGun.attr('style', 'display: none');
                                break;
                            }


                        }


                    },
                    error: function () {

                        alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                    }
                });


                Dktr_Ad.change(function ad() {

                    Bilgi_Mesajı_ayrıkGun.attr('style', 'display: none');
                    Bilgi_Mesajı_Ilk_Tam_Hafta.attr('style', 'display: none');

                    hafta_21_div.attr('style', 'display: none');
                    hafta_41_div.attr('style', 'display: none');
                    hafta_42_div.attr('style', 'display: none');
                    hafta_43_div.attr('style', 'display: none');

                    if (Doldur == "1") {
                        gundoldur();
                    }







                });//Eczane_Sadece_Bu_Gun
                var Doktor_Sadece_Bu_Gun = $('input[id=Doktor_Sadece_Bu_Gun]');


                $(document).on('change', 'input[id=Doktor_Sadece_Bu_Gun]', function () {



                    if (this.checked) {
                        Tek_Gun = "True";
                        var Dokor_Modal = $('div[id=Doktor_Modal]');
                        var Dktr_Ad = $(Dokor_Modal).find($('select[id=Dktr_Ad]'));

                        var hafta_21_div = $(Dokor_Modal).find($('div[Id=frekans_2_1_div]'));

                        var hafta_41_div = $(Dokor_Modal).find($('div[Id=frekans_4_1_div]'));

                        var hafta_42_div = $(Dokor_Modal).find($('div[Id=frekans_4_2_div]'));

                        var hafta_43_div = $(Dokor_Modal).find($('div[Id=frekans_4_3_div]'));

                        hafta_21_div.attr('style', 'display: none');
                        hafta_41_div.attr('style', 'display: none');
                        hafta_42_div.attr('style', 'display: none');
                        hafta_43_div.attr('style', 'display: none');

                    }
                    else {
                        Tek_Gun = "False";
                        gundoldur();
                    }

                });

                function gundoldur() {


                    if (ayrık == "False") {

                        $.ajax({
                            url: 'ddldeneme.aspx/Frekans_modal_Doldurma',
                            dataType: 'json',
                            type: 'POST',
                            data: "{'parametre': '" + gun_tam_cizgili.split('-')[0] + "-" + gun_tam_cizgili.split('-')[1] + "'}",
                            contentType: 'application/json; charset=utf-8',
                            success: function (data) {


                                var Dokor_Modal = $('div[id=Doktor_Modal]');
                                var Dktr_Ad = $(Dokor_Modal).find($('select[id=Dktr_Ad]'));
                                var Frekans = Dktr_Ad.find('option:selected').attr('frekans')
                                var Bilgi_Mesajı = $(Dokor_Modal).find($('div[id=Bilgi_Mesajı]'))
                                var hafta_21_div = $(Dokor_Modal).find($('div[Id=frekans_2_1_div]'));
                                var hafta_41_div = $(Dokor_Modal).find($('div[Id=frekans_4_1_div]'));
                                var hafta_42_div = $(Dokor_Modal).find($('div[Id=frekans_4_2_div]'));
                                var hafta_43_div = $(Dokor_Modal).find($('div[Id=frekans_4_3_div]'));
                                var hafta_21 = $(Dokor_Modal).find($('select[Id=frekans_2_1]'));
                                var hafta_41 = $(Dokor_Modal).find($('select[Id=frekans_4_1]'));
                                var hafta_42 = $(Dokor_Modal).find($('select[Id=frekans_4_2]'));
                                var hafta_43 = $(Dokor_Modal).find($('select[Id=frekans_4_3]'));

                                hafta_21.empty();
                                hafta_41.empty();
                                hafta_42.empty();
                                hafta_43.empty();


                                if (Frekans == 2) {
                                    if (data.d.split('/').length == 4) {//style="display: none;"  Bilgi_Mesajı

                                        for (var i = 0; i < data.d.split('/')[3].split('*').length; i++) {
                                            hafta_21.append('<option Gun_Rkm=' + data.d.split('/')[2].split('*')[i].split('-')[0].split(' ')[0] + ' Ay_Rkm=' + data.d.split('/')[2].split('*')[i].split('-')[0].split(' ')[1] + ' Yıl_Rkm=' + data.d.split('/')[2].split('*')[i].split('-')[0].split(' ')[2] + ' >' + data.d.split('/')[2].split('*')[i].split('-')[1] + '</option>')
                                        }
                                        hafta_21_div.removeAttr('style')
                                        hafta_41_div.attr('style', 'display: none');
                                        hafta_42_div.attr('style', 'display: none');
                                        hafta_43_div.attr('style', 'display: none');


                                    }
                                    if (data.d.split('/').length == 3) {//style="display: none;"  Bilgi_Mesajı

                                        for (var i = 0; i < data.d.split('/')[2].split('*').length; i++) {
                                            hafta_21.append('<option Gun_Rkm=' + data.d.split('/')[2].split('*')[i].split('-')[0].split(' ')[0] + ' Ay_Rkm=' + data.d.split('/')[2].split('*')[i].split('-')[0].split(' ')[1] + ' Yıl_Rkm=' + data.d.split('/')[2].split('*')[i].split('-')[0].split(' ')[2] + ' >' + data.d.split('/')[2].split('*')[i].split('-')[1] + '</option>')
                                        }
                                        hafta_21_div.removeAttr('style')
                                        hafta_41_div.attr('style', 'display: none');
                                        hafta_42_div.attr('style', 'display: none');
                                        hafta_43_div.attr('style', 'display: none');


                                    }
                                }

                                if (Frekans == 4) {

                                    if (data.d.split('/').length == 4) {//style="display: none;"  Bilgi_Mesajı
                                        dort_haftamı = "True";
                                        hafta_41.append('<option Eklenmesin="True">Eklenmesin</option>')
                                        for (var i = 0; i < data.d.split('/')[3].split('*').length; i++) {
                                            hafta_41.append('<option Gun_Rkm=' + data.d.split('/')[1].split('*')[i].split('-')[0].split(' ')[0] + ' Ay_Rkm=' + data.d.split('/')[1].split('*')[i].split('-')[0].split(' ')[1] + ' Yıl_Rkm=' + data.d.split('/')[1].split('*')[i].split('-')[0].split(' ')[2] + ' >' + data.d.split('/')[1].split('*')[i].split('-')[1] + '</option>')
                                        }
                                        hafta_41_div.removeAttr('style')
                                        hafta_42.append('<option Eklenmesin="True">Eklenmesin</option>')
                                        for (var i = 0; i < data.d.split('/')[3].split('*').length; i++) {
                                            hafta_42.append('<option Gun_Rkm=' + data.d.split('/')[2].split('*')[i].split('-')[0].split(' ')[0] + ' Ay_Rkm=' + data.d.split('/')[2].split('*')[i].split('-')[0].split(' ')[1] + ' Yıl_Rkm=' + data.d.split('/')[2].split('*')[i].split('-')[0].split(' ')[2] + ' >' + data.d.split('/')[2].split('*')[i].split('-')[1] + '</option>')
                                        }
                                        hafta_42_div.removeAttr('style')
                                        hafta_43.append('<option Eklenmesin="True">Eklenmesin</option>')
                                        for (var i = 0; i < data.d.split('/')[3].split('*').length; i++) {
                                            hafta_43.append('<option Gun_Rkm=' + data.d.split('/')[3].split('*')[i].split('-')[0].split(' ')[0] + ' Ay_Rkm=' + data.d.split('/')[3].split('*')[i].split('-')[0].split(' ')[1] + ' Yıl_Rkm=' + data.d.split('/')[3].split('*')[i].split('-')[0].split(' ')[2] + ' >' + data.d.split('/')[3].split('*')[i].split('-')[1] + '</option>')
                                        }
                                        hafta_43_div.removeAttr('style')
                                        hafta_21_div.attr('style', 'display: none');

                                    }
                                    if (data.d.split('/').length == 3) {//style="display: none;"  Bilgi_Mesajı
                                        uc_haftamı = "True"
                                        Bilgi_Mesajı.removeAttr('style')
                                        hafta_41.append('<option Eklenmesin="True">Eklenmesin</option>')
                                        for (var i = 0; i < data.d.split('/')[1].split('*').length - 1; i++) {
                                            hafta_41.append('<option Gun_Rkm=' + data.d.split('/')[1].split('*')[i].split('-')[0].split(' ')[0] + ' Ay_Rkm=' + data.d.split('/')[1].split('*')[i].split('-')[0].split(' ')[1] + ' Yıl_Rkm=' + data.d.split('/')[1].split('*')[i].split('-')[0].split(' ')[2] + ' >' + data.d.split('/')[1].split('*')[i].split('-')[1] + '</option>')
                                        }
                                        hafta_41_div.removeAttr('style')
                                        hafta_42.append('<option Eklenmesin="True">Eklenmesin</option>')
                                        for (var i = 0; i < data.d.split('/')[2].split('*').length; i++) {
                                            hafta_42.append('<option Gun_Rkm=' + data.d.split('/')[2].split('*')[i].split('-')[0].split(' ')[0] + ' Ay_Rkm=' + data.d.split('/')[2].split('*')[i].split('-')[0].split(' ')[1] + ' Yıl_Rkm=' + data.d.split('/')[2].split('*')[i].split('-')[0].split(' ')[2] + ' >' + data.d.split('/')[2].split('*')[i].split('-')[1] + '</option>')
                                        }
                                        hafta_42_div.removeAttr('style')
                                        hafta_21_div.attr('style', 'display: none');


                                    }
                                }


                            },
                            error: function () {

                                alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                            }
                        });
                    }

                    else {

                        hafta_21_div.attr('style', 'display: none');
                        hafta_41_div.attr('style', 'display: none');
                        hafta_42_div.attr('style', 'display: none');
                        hafta_43_div.attr('style', 'display: none');
                        Bilgi_Mesajı_ayrıkGun.removeAttr('style');
                    }

                };



                Dktr_Brans.empty();
                Dktr_Brick.empty();
                Dktr_Unite.empty();
                Dktr_Ad.empty();



            });

            var Onay_Talebi_Gonder = $('input[id=Onay_Talebi_Gonder]')
            var Onay_Talebi_Gonder_Modal = $('button[id=Onay_Talebi_Gonder_Modal]')
            var calyr = $('select[id=calyr]')
            var calmth = $('select[id=calmth]')
            var Seçili_Yıl = calyr.find('option:selected').val();
            var Seçili_Ay = calmth.find('option:selected').val();
            $.ajax({
                url: 'ddldeneme.aspx/Onay_Talep_Id',
                dataType: 'json',
                type: 'POST',
                async: false,
                data: "{'parametre': '" + Seçili_Yıl + "-" + Seçili_Ay + "-01'}",
                contentType: 'application/json; charset=utf-8',
                success: function (data) {
                    Onay_Talebi_Gonder_Modal.attr('Onay_Id', data.d)
                },
                error: function () {

                    alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                }
            });

            Onay_Talebi_Gonder.click(function () {
                $('#myModal').modal('show');
            });
            Onay_Talebi_Gonder_Modal.click(function () {
                $('#myModal').modal('toggle');
                $.ajax({
                    url: 'ddldeneme.aspx/Onay_Talebi_Gönder',
                    dataType: 'json',
                    type: 'POST',
                    async: false,
                    data: "{'parametre': '" + $(this).attr('onay_id') + "'}",
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {
                        var temp = JSON.parse(data.d)
                        console.log(temp)
                        $('#Mesaj').find('p[id=İşlem_Mesajı]').html("İşlem Başarılı")
                        if (temp[0].Durum == "0") {
                            $('#Mesaj').attr('class', 'modal modal-warning  fade')
                            var Mesaj = $('#Mesaj').find('div[id=Modal_Body]')
                            Mesaj.empty();
                            Mesaj.append("   < div class='row' >  <div class='col-xs-12'>  <label id='İşlem_Mesajı'></label> </div>     </div >")
                            $('#Mesaj').find('label[id=İşlem_Mesajı]').html("Talep İşlemi Daha Önceden Gönderilmiş")
                        }

                        if (temp[0].Durum == "1") {
                            $('#Mesaj').attr('class', 'modal fade')
                            var Mesaj = $('#Mesaj').find('div[id=Modal_Body]')
                            Mesaj.empty();
                            Mesaj.append("<div class='row'><div class='col-xs-12'><label id='İşlem_Mesajı'></label> </div></div >")
                            $('#Mesaj').find('label[id=İşlem_Mesajı]').html("Talep Başarı İle İletilmiştir")
                        }
                        if (temp[0].Durum == "2") {
                            $('#Mesaj').attr('class', 'modal modal-danger fade')
                            var Mesaj = $('#Mesaj').find('div[id=Modal_Body]')
                            Mesaj.empty();
                            Mesaj.append("<div class='row'><div class='col-xs-12'><label id='İşlem_Mesajı'></label> </div></div >")
                            $('#Mesaj').find('label[id=İşlem_Mesajı]').html("İşlem Sırasında Bir Hata Oluştu Lütfen Gerekli Yerlere Bildiriniz")
                        }
                        if (temp[0].Durum == "4") {

                            $('#Mesaj').attr('class', 'modal modal-danger fade')
                            var Mesaj = $('#Mesaj').find('div[id=Modal_Body]')
                            Mesaj.empty();
                            Mesaj.append("<div class='row'><div class='col-xs-12'><label id='İşlem_Mesajı'></label> </div></div >")
                            Mesaj.find('label[id=İşlem_Mesajı]').append("Bazı günlerde 20 doktor Ve 10 eczaneden daha az ziyaret bulunmakta;")
                            for (var i = 0; i < temp.length; i++) {
                                Mesaj.append('<div class="row"><div class=col-xs-12><p>' + temp[i].Tarih.replace('.', '/').replace('.', '/') + '</p></div></div>')
                            }
                        }

                        $('#Mesaj').modal('show');
                    },
                    error: function () {

                        alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                    }
                });
            });
            var kopyalanan_Id = "";
            var Yapıştırılacak_Id = "";
            var Kopyala_Yapıştır = $('button[id=Kopyala_Yapıştır]')
            Kopyala_Yapıştır.click(function () {



                if ($(this).attr('seçildimi') == "False") {
                    $('button[id*=Kopyala_Yapıştır]').children().attr('class', 'fa fa-paste')
                    $('button[id*=Kopyala_Yapıştır]').attr('seçildimi', 'True')
                    $(this).attr('seçilen', 'True')
                    $(this).children().attr('class', 'fa fa-times')
                    kopyalanan_Id = $(this).attr('Ziyaret_Id')
                    Yapıştırılacak_Id = "";
                }
                else if ($(this).attr('seçildimi') == "True") {


                    if ($(this).attr('seçilen') == "False") {



                        $('button[id*=Kopyala_Yapıştır]').children().attr('class', 'fa fa-copy')
                        $('button[id*=Kopyala_Yapıştır]').attr('seçildimi', 'False')
                        $(this).attr('seçilen', 'False')
                        Yapıştırılacak_Id = $(this).attr('Ziyaret_Id')
                        console.log(Yapıştırılacak_Id + "Yapış")
                        var calyr = $('select[id=calyr]')
                        var calmth = $('select[id=calmth]')
                        var Seçili_Yıl = calyr.find('option:selected').val();
                        var Seçili_Ay = calmth.find('option:selected').val();



                        $.ajax({
                            url: 'ddldeneme.aspx/Gün_Kopyala',
                            dataType: 'json',
                            type: 'POST',
                            async: false,
                            data: "{'Kopyalanan_Gün_Id': '" + kopyalanan_Id + "','Yapıştırılacak_Gün_Id':'" + Yapıştırılacak_Id + "','Gün':'" + Seçili_Yıl + "-" + Seçili_Ay + "-01'}",
                            contentType: 'application/json; charset=utf-8',
                            success: function (data) {
                                var temp = JSON.parse(data.d)

                                console.log(temp)

                                if (temp.length <= 0) {
                                    Swal.fire({
                                        title: 'Başarılı!',
                                        text: 'İşlem Başarı İle Kaydedildi',
                                        icon: 'success',
                                        confirmButtonText: 'Kapat'
                                    })
                                    kopyalanan_Id = "";
                                    Yapıştırılacak_Id = "";
                                    Tabloları_Doldur();
                                }
                                else {
                                    if (temp[0].Sipariş_Notu == "1") {
                                        Swal.fire({
                                            title: 'Hata!',
                                            text: 'Seçilen Tarihlerde Daha Önceden Ekleme Yapılmış Lütfen Günü Boşaltıp Tekrar Deneyiniz',
                                            icon: 'error',
                                            confirmButtonText: 'Kapat'
                                        })
                                        kopyalanan_Id = "";
                                        Yapıştırılacak_Id = "";

                                    }
                                    if (temp[0].Sipariş_Notu == "0") {
                                        Swal.fire({
                                            title: 'Hata!',
                                            text: 'Tablo Onaylandıktan Sonra İşlem Yapılamaz',
                                            icon: 'error',
                                            confirmButtonText: 'Kapat'
                                        })


                                        kopyalanan_Id = "";
                                        Yapıştırılacak_Id = "";
                                    }
                                }
                                kopyalanan_Id = "";
                                Yapıştırılacak_Id = "";

                            },
                            error: function () {

                                kopyalanan_Id = "";
                                Yapıştırılacak_Id = "";
                                alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                            }
                        });

                    }
                    else {
                        $('button[id*=Kopyala_Yapıştır]').children().attr('class', 'fa fa-copy')
                        $('button[id*=Kopyala_Yapıştır]').attr('seçildimi', 'False')
                        $(this).attr('seçilen', 'False')
                        kopyalanan_Id = "";

                    }
                }

            })

            $('#Sablon_Olustur_Modal').on('show.bs.modal', function (e) {

                setTimeout(function () { $('#Sablon_Eczane_Datatables').DataTable().rows().invalidate().draw() }, 450);
                setTimeout(function () { $('#Sablon_Doktor_Datatables').DataTable().rows().invalidate().draw() }, 450);
            })
            var Eczane_Sablon_Liste = [];
            var Doktor_Sablon_Liste = [];
            $('input[id=Sablon_Olustur]').click(function () {
                $('#Sablon_Olustur_Modal').modal('show')
                Tabloyu_Doldur_Sablon_Doktor(Doktor_Sablon_Liste)
                Tabloyu_Doldur_Sablon_Eczane(Eczane_Sablon_Liste)

            })
            function Tabloyu_Doldur_Sablon_Eczane(Liste_) {

                $('#Sablon_Olustur_Tablo_Eczane').empty();
                $('#Sablon_Olustur_Tablo_Eczane').append('<table id="Sablon_Eczane_Datatables" class="display" style="width: 100%">' +
                    '<thead>' +
                    '<tr>' +
                    '<th>Urun Adı</th>' +
                    '<th>Adet</th>' +
                    '<th>Mf Adet</th>' +
                    '<th>Toplam</th>' +
                    '<th>Birim Fiyat</th>' +
                    '<th>Satış Fiyatı</th>' +
                    '<th>Toplam Birim Fiyatı</th>' +
                    '<th>Toplam Satış Fiyatı</th>' +
                    '</tr>' +
                    '</thead>' +
                    '<tbody id="Sablon_Eczane_Datatables_Tbody">' +
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
                    var Tbody = $('tbody[id=Sablon_Eczane_Datatables_Tbody]')

                    for (var i = 0; i < Liste_.length; i++) {
                        Tbody.append(
                            '<tr>' +
                            '<td>' + Liste_[i].Urun_Adı + '</td>' +
                            '<td>' + Liste_[i].Adet + '</td>' +
                            '<td>' + Liste_[i].Mf_Adet.replace(',', '.') + '</td>' +
                            '<td>' + Liste_[i].Toplam + '</td>' +
                            '<td>' + Liste_[i].Birim_Fiyat.replace(',', '.') + '</td>' +
                            '<td>' + Liste_[i].Satış_Fiyat.replace(',', '.') + '</td>' +

                            '<td>' + Liste_[i].Birim_Fiyat_Toplam.replace(',', '.') + '</td>' +
                            '<td>' + Liste_[i].Normal_Toplam.replace(',', '.') + '</td>' +


                            '</tr>'
                        )
                    }


                }





                var Kullanıcı_Adı;
                $.ajax({
                    url: 'Sipariş-Onay.aspx/Kullanıcı_Adı_Soyadı',
                    type: 'POST',
                    data: "{'parametre': ''}",
                    async: false,
                    dataType: "json",
                    contentType: "application/json; charset=utf-8",
                    success: function (data) {

                        Kullanıcı_Adı = data.d;


                    },
                    error: function () {

                        alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                    }
                });


                var today = new Date();
                var date = today.getDate() + '/' + (today.getMonth() + 1) + '/' + today.getFullYear();
                var dateTime = date;

                $('#Sablon_Eczane_Datatables').dataTable({


                    "lengthMenu": [10, 25, 50, 75, 100, 200, 500, 750, 1000],
                    "language": {
                        "url": "//cdn.datatables.net/plug-ins/1.10.22/i18n/Turkish.json"
                    },


                    "scrollX": true,


                });




            }
            function Tabloyu_Doldur_Sablon_Doktor(Liste_) {

                $('#Sablon_Olustur_Tablo_Doktor').empty();
                $('#Sablon_Olustur_Tablo_Doktor').append('<table id="Sablon_Doktor_Datatables" class="display" style="width: 100%">' +
                    '<thead>' +
                    '<tr>' +
                    '<th>Urun Adı</th>' +
                    '<th>Adet</th>' +
                    '<th>Mf Adet</th>' +
                    '<th>Toplam</th>' +
                    '<th>Birim Fiyat</th>' +
                    '<th>Satış Fiyatı</th>' +
                    '<th>Toplam Birim Fiyatı</th>' +
                    '<th>Toplam Satış Fiyatı</th>' +
                    '</tr>' +
                    '</thead>' +
                    '<tbody id="Sablon_Doktor_Datatables_Tbody">' +
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
                    var Tbody = $('tbody[id=Sablon_Doktor_Datatables_Tbody]')

                    for (var i = 0; i < Liste_.length; i++) {
                        Tbody.append(
                            '<tr>' +
                            '<td>' + Liste_[i].Urun_Adı + '</td>' +
                            '<td>' + Liste_[i].Adet + '</td>' +
                            '<td>' + Liste_[i].Mf_Adet.replace(',', '.') + '</td>' +
                            '<td>' + Liste_[i].Toplam + '</td>' +
                            '<td>' + Liste_[i].Birim_Fiyat.replace(',', '.') + '</td>' +
                            '<td>' + Liste_[i].Satış_Fiyat.replace(',', '.') + '</td>' +

                            '<td>' + Liste_[i].Birim_Fiyat_Toplam.replace(',', '.') + '</td>' +
                            '<td>' + Liste_[i].Normal_Toplam.replace(',', '.') + '</td>' +


                            '</tr>'
                        )
                    }


                }





                var Kullanıcı_Adı;
                $.ajax({
                    url: 'Sipariş-Onay.aspx/Kullanıcı_Adı_Soyadı',
                    type: 'POST',
                    data: "{'parametre': ''}",
                    async: false,
                    dataType: "json",
                    contentType: "application/json; charset=utf-8",
                    success: function (data) {

                        Kullanıcı_Adı = data.d;


                    },
                    error: function () {

                        alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                    }
                });


                var today = new Date();
                var date = today.getDate() + '/' + (today.getMonth() + 1) + '/' + today.getFullYear();
                var dateTime = date;

                $('#Sablon_Doktor_Datatables').dataTable({


                    "lengthMenu": [10, 25, 50, 75, 100, 200, 500, 750, 1000],
                    "language": {
                        "url": "//cdn.datatables.net/plug-ins/1.10.22/i18n/Turkish.json"
                    },
                    "scrollX": true,


                });




            }

            $('a[id=Doktor_Listenin_Tamanını_Ekle]').click(function () {
                $('div[id=Liste_Ayarlar]').modal('show')
                var Liste_Ayarlar_Listeyi_Kaydet = $('button[id=Liste_Ayarlar_Listeyi_Kaydet]')
                Liste_Ayarlar_Listeyi_Kaydet.attr('Gün_Id', $(this).attr('gun_tam_cizgili'))
                Liste_Ayarlar_Listeyi_Kaydet.attr('İşlem_Türü', $(this).attr('button_tipi'))

                if ($(this).attr('button_tipi') == "Doktor") {

                    $('button[id=Liste_Ayarlar_Listeyi_Kaydet]').attr('İşlem_Tipi', "1")

                    var Eczane_Liste_Ayarlar = $('select[id=Eczane_Liste_Ayarlar]')

                    Eczane_Liste_Ayarlar.empty();
                    $.ajax({
                        url: 'Doktor-Listesi-Olustur.aspx/Yeni_Liste_Olustur_Listeler', //doktorları listelerken tersten listele 
                        dataType: 'json',
                        type: 'POST',
                        async: false,
                        data: "{'Liste_Adı': '" + "-0'}",//liste cinsini de yolla o gördüğün 0 liste cinsi
                        contentType: 'application/json; charset=utf-8',
                        success: function (data) {
                            var temp = JSON.parse(data.d)
                            var Eczane_Liste_Ayarlar = $('select[id=Eczane_Liste_Ayarlar]')
                            for (var i = 0; i < temp.length; i++) {
                                Eczane_Liste_Ayarlar.append("<option value='" + temp[i].Liste_Id + "'>" + temp[i].Liste_Ad + "</option>");
                            }
                        },
                        error: function () {

                            alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                        }
                    });
                }
                else {
                    $('button[id=Liste_Ayarlar_Listeyi_Kaydet]').attr('İşlem_Tipi', "0")
                    var Eczane_Liste_Ayarlar = $('select[id=Eczane_Liste_Ayarlar]')
                    Eczane_Liste_Ayarlar.empty();
                    $.ajax({
                        url: 'Eczane-Liste-Olustur.aspx/Yeni_Liste_Olustur_Listeler', //doktorları listelerken tersten listele 
                        dataType: 'json',
                        type: 'POST',
                        async: false,
                        data: "{'Liste_Adı': '" + "-0'}",//liste cinsini de yolla o gördüğün 0 liste cinsi
                        contentType: 'application/json; charset=utf-8',
                        success: function (data) {
                            var temp = JSON.parse(data.d)

                            for (var i = 0; i < temp.length; i++) {
                                Eczane_Liste_Ayarlar.append("<option value='" + temp[i].Liste_Id + "'>" + temp[i].Liste_Ad + "</option>");
                            }
                        },
                        error: function () {

                            alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                        }
                    });
                }

            })


            var Liste_Ayarlar_Listeyi_Kaydet = $('button[id=Liste_Ayarlar_Listeyi_Kaydet]')
            Liste_Ayarlar_Listeyi_Kaydet.click(function () {
                if ($(this).attr('İşlem_Tipi') == "0") {
                    $.ajax({
                        url: 'Ziyaret-Planı.aspx/Eczane_Ziyaret_Oluştur_Liste', //doktorları listelerken tersten listele
                        dataType: 'json',
                        type: 'POST',
                        async: false,
                        data: "{'Liste_Id': '" + $('select[id=Eczane_Liste_Ayarlar]').find('option:selected').attr('value') + "','Tarih':'" + $(this).attr('Gün_Id') + "'}",
                        contentType: 'application/json; charset=utf-8',
                        success: function (data) {

                            var temp = JSON.parse(data.d)
                            if (temp[0].Durum == 0) {
                                Swal.fire({
                                    title: 'Hata!',
                                    text: 'Seçilen Tarihlerde Daha Önceden Ekleme Yapılmış Lütfen Kontrol Ediniz',
                                    icon: 'error',
                                    confirmButtonText: 'Kapat'
                                })
                            }
                            if (temp[0].Durum == 1) {
                                Swal.fire({
                                    title: 'Başarılı!',
                                    text: 'İşlem Başarı İle Kaydedildi',
                                    icon: 'success',
                                    confirmButtonText: 'Kapat'
                                })
                                Tabloları_Doldur();
                            }



                        },
                        error: function () {

                            Swal.fire({
                                title: 'Hata!',
                                text: 'Talep esnasında sorun oluştu.Yeniden deneyin',
                                icon: 'error',
                                confirmButtonText: 'Kapat'
                            })

                        }
                    });
                }
                else {
                    $.ajax({
                        url: 'Ziyaret-Planı.aspx/Doktor_Ziyaret_Oluştur_Liste', //doktorları listelerken tersten listele
                        dataType: 'json',
                        type: 'POST',
                        async: false,
                        data: "{'Liste_Id': '" + $('select[id=Eczane_Liste_Ayarlar]').find('option:selected').attr('value') + "','Tarih':'" + $(this).attr('Gün_Id') + "'}",
                        contentType: 'application/json; charset=utf-8',
                        success: function (data) {

                            var temp = JSON.parse(data.d)
                            if (temp[0].Durum == 0) {
                                Swal.fire({
                                    title: 'Hata!',
                                    text: 'Seçilen Tarihlerde Daha Önceden Ekleme Yapılmış Lütfen Kontrol Ediniz',
                                    icon: 'error',
                                    confirmButtonText: 'Kapat'
                                })
                            }
                            if (temp[0].Durum == 1) {
                                Swal.fire({
                                    title: 'Başarılı!',
                                    text: 'İşlem Başarı İle Kaydedildi',
                                    icon: 'success',
                                    confirmButtonText: 'Kapat'
                                })
                                Tabloları_Doldur();
                            }



                        },
                        error: function () {

                            Swal.fire({
                                title: 'Hata!',
                                text: 'Talep esnasında sorun oluştu.Yeniden deneyin',
                                icon: 'error',
                                confirmButtonText: 'Kapat'
                            })

                        }
                    });
                }



            })

            var Doktor_Günü_Sil = $('a[id=Doktor_Günü_Sil]')
            Doktor_Günü_Sil.click(function () {


             
                





                if ($(this).attr('button_tipi') == "Doktor") {

                    var Doktor_Tablo = '<tr>' +
                        '                                            <th>Doktor Adı</th>' +
                        '                                            <th>Ünite</th>' +
                        '                                            <th>Branş</th>' +
                        '                                            <th>Brick</th>' +
                        '                                            <th>Ziyaret Durumu</th>' +
                        '                                            <th>Kaldır</th>' +
                        '                                        </tr>' +
                        '                                            <tr>' +
                        '                                                <td style="text-align: center; background-color: #f9f9f9;" colspan="6">Tabloda herhangi bir veri mevcut değil </td>' +
                        '                                            </tr>';
                    $(this).parent().parent().parent().parent().find('div[id*=doktor]').find('table').find('tbody').empty()

                    $(this).parent().parent().parent().parent().find('div[id*=doktor]').find('table').find('tbody').append(Doktor_Tablo)
                        $.ajax({
                            url: 'Ziyaret-Planı.aspx/Ziyaret_Sil', //doktorları listelerken tersten listele
                            dataType: 'json',
                            type: 'POST',
                            async: false,
                            data: "{'Tarih': '" + $(this).attr('gun_tam_cizgili')  + "','Cins':'0'}",
                            contentType: 'application/json; charset=utf-8',
                            success: function (data) {

                                var temp = JSON.parse(data.d)

                                if (temp.length < 1) {
                                    Swal.fire({
                                        title: 'Başarılı!',
                                        text: 'İşlem Başarı İle Kaydedildi',
                                        icon: 'success',
                                        confirmButtonText: 'Kapat'
                                    })
                                }



                                Tabloları_Doldur();




                            },
                            error: function () {

                                Swal.fire({
                                    title: 'Hata!',
                                    text: 'Talep esnasında sorun oluştu.Yeniden deneyin',
                                    icon: 'error',
                                    confirmButtonText: 'Kapat'
                                })

                            }
                        });
                    }
                    else {
                        var Eczane_Tablo = '<tr>' +
                            '                                                <th>Eczane Adı</th>' +
                            '                                                <th>İl</th>' +
                            '                                                <th>Brick</th>' +
                            '                                                <th>Kenar</th>' +
                            '                                                <th>Ziyaret Durumu</th>' +
                            '                                            </tr>' +
                            '                                            <tr>' +
                            '                                                <td style="text-align: center; background-color: #f9f9f9;" colspan="6">Tabloda herhangi bir veri mevcut değil </td>' +
                            '                                            </tr>';
                        $(this).parent().parent().parent().parent().parent().find('div[id*=eczane]').find('table').find('tbody').empty()

                        $(this).parent().parent().parent().parent().parent().find('div[id*=eczane]').find('table').find('tbody').append(Eczane_Tablo)
                        $.ajax({
                            url: 'Ziyaret-Planı.aspx/Ziyaret_Sil', //doktorları listelerken tersten listele
                            dataType: 'json',
                            type: 'POST',
                            async: false,
                            data: "{'Tarih': '" + $(this).attr('gun_tam_cizgili') + "','Cins':'1'}",
                            contentType: 'application/json; charset=utf-8',
                            success: function (data) {

                                var temp = JSON.parse(data.d)

                                if (temp.length < 1) {
                                    Swal.fire({
                                        title: 'Başarılı!',
                                        text: 'İşlem Başarı İle Kaydedildi',
                                        icon: 'success',
                                        confirmButtonText: 'Kapat'
                                    })
                                }

                                Tabloları_Doldur();

                          
                            },

                            error: function () {

                                Swal.fire({
                                    title: 'Hata!',
                                    text: 'Talep esnasında sorun oluştu.Yeniden deneyin',
                                    icon: 'error',
                                    confirmButtonText: 'Kapat'
                                })

                            }
                        });
                    }
            })



        });

    </script>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
 

    <div id="Liste_Ayarlar" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Tüm Listeye Ziyaret Düzenle</h4>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <select name="Select" id="Eczane_Liste_Ayarlar" class="form-control"></select>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" data-dismiss="modal" class="btn btn-default" data-dismiss="modal">Kapat</button>
                    <button id="Liste_Ayarlar_Listeyi_Kaydet" type="button" class="btn btn-info">Tüm Listeyi Ekle</button>
                </div>
            </div>
        </div>
    </div>


    <div id="Sablon_Olustur_Modal" class="modal fade" role="dialog">
        <div class="modal-dialog modal-lg">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Şablon Oluştur</h4>
                </div>
                <div class="modal-body">
                    <div class="panel-body panel-primary">
                        <div class="panel-heading">
                            <label>Doktor Ziyaret Şablonları</label>
                        </div>
                        <div class="panel-body">
                            <div class="row">
                                <div class="col-xs-12">
                                    <div class="row">
                                        <div class="col-xs-12">
                                            <div id="Sablon_Olustur_Tablo_Doktor"></div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-xs-12">
                                            <button type="button" id="Doktor_Şablon_Oluştur" class="btn btn-primary pull-right">Doktor Şablonu Oluştur</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>


                    <div class="panel-body panel-primary">
                        <div class="panel-heading">
                            <label>Doktor Ziyaret Şablonları</label>
                        </div>
                        <div class="panel-body">
                            <div class="row">
                                <div class="col-xs-12">
                                    <div class="row">
                                        <div class="col-xs-12">
                                            <div id="Sablon_Olustur_Tablo_Eczane"></div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-xs-12">
                                            <button type="button" id="Eczane_Şablon_Oluştur" class="btn btn-primary pull-right">Doktor Şablonu Oluştur</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>




                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Kapat</button>
                </div>
            </div>

        </div>
    </div>

    <div id="Mesaj" style="overflow-y: auto;" class="modal fade" role="dialog">
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
    <%--  <div class="modal fade" id="Mesaj" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">

        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">
                        <span aria-hidden="true">&times;</span><span class="sr-only">Close</span>

                    </button>
                    <h4 class="modal-title">İşlem Sonucu</h4>

                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-xs-12">
                            <label id="İşlem_Mesajı"></label>
                        </div>
                    </div>


                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Kapat</button>

                </div>

            </div>
        </div>
    </div>--%>
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="vertical-alignment-helper">
            <div class="modal-dialog vertical-align-center">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">
                            <span aria-hidden="true">&times;</span><span class="sr-only">Close</span>

                        </button>
                        <h4 class="modal-title" id="myModalLabel">Talep Gönder</h4>

                    </div>
                    <div class="modal-body">
                        Plan Onaylandıktan Sonra Düzenleme Yapılamaz !

                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Kapat</button>
                        <button type="button" id="Onay_Talebi_Gonder_Modal" class="btn btn-primary">Talebi Gönder</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div id="Eczane_Modal" class="modal fade" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div id="Eczane_modal_head" class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 id="Eczane_modal_bslk" class="modal-title"></h4>
                </div>
                <div id="Eczane_modal_body" class="modal-body">

                    <div class="box-body">
                        <div class="form-group">
                            <%--// has-error--%>
                            <div class="form-group">
                                <%--// has-error--%>
                                <label>Eczane Listesi</label>
                                <select id="Eczane_Liste" class="form-control">
                                </select>
                            </div>

                            <label>İl</label>
                            <select id="Eczane_Il" class="form-control">
                                <option id="Eczane_scnz">--Lütfen Şehir Seçiniz</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label>Brick</label>
                            <select id="Eczane_brick" class="form-control">
                            </select>
                        </div>


                        <div class="form-group">
                            <label>Eczane Adı</label>
                            <select id="Eczane_Ad" class="form-control">
                            </select>
                        </div>
                        <div id="Sadece_Bu_gun_Eczane" class="form-group">
                            <div class="checkbox">
                                <label>
                                    <input id="Eczane_Sadece_Bu_Gun" type="checkbox">
                                    Sadece Bu Güne Eklensin
                                </label>
                            </div>

                        </div>
                        <div id="Eczane_Bilgi_Mesajı" class="alert alert-info alert-dismissible" style="display: none">
                            <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
                            <h4><i class="icon fa fa-info"></i>Bilgi!</h4>
                            İşlem yaptığınız ayda 3 tam hafta olduğundan dolayı 4 frekansı olan doktorların 1 ziyareti eksik kalacaktır lütfen ayrık günleri kontrol ederek kalan ziyaretlerini doldurunuz.(Ayrık Gün; Ayın Tam haftaları dışında kalan günleridir )
                        </div>
                        <div id="Eczane_Bilgi_Mesajı_ayrıkGun" class="alert alert-info alert-dismissible" style="display: none">
                            <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
                            <h4><i class="icon fa fa-info"></i>Bilgi!</h4>
                            İşlem yapmak İstediğiniz gün 'Ayrık Gün' olduğu için çoklu yerleştirme açılmadı  (Ayrık Gün; Ayın Tam haftaları dışında kalan günleridir)
                        </div>
                        <div id="Eczane_Bilgi_Mesajı_Ilk_Tam_Hafta" class="alert alert-info alert-dismissible" style="display: none">
                            <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
                            <h4><i class="icon fa fa-info"></i>Bilgi!</h4>
                            Çoklu Ekleme Yapmak İçin Lütfen İlk Tam Haftadan İşlem Yapınız
                        </div>
                        <div class="form-group" id="Eczane_frekans_2_1_div" style="display: none;">
                            <label>3. Haftanın Kaçıncı Gününe eklensin</label>
                            <select id="Eczane_frekans_2_1" class="form-control">
                            </select>
                        </div>
                        <div class="form-group" id="Eczane_frekans_4_1_div" style="display: none;">
                            <label>2. Haftanın Kaçıncı Gününe eklensin</label>
                            <select name="Frekans_Select_Eczane" id="Eczane_frekans_4_1" class="form-control">
                            </select>
                        </div>
                        <div class="form-group" id="Eczane_frekans_4_2_div" style="display: none;">
                            <label>3. Haftanın Kaçıncı Gününe eklensin</label>
                            <select name="Frekans_Select_Eczane" id="Eczane_frekans_4_2" class="form-control">
                            </select>
                        </div>
                        <div class="form-group" id="Eczane_frekans_4_3_div" style="display: none;">
                            <label>4. Haftanın Kaçıncı Gününe eklensin</label>
                            <select name="Frekans_Select_Eczane" id="Eczane_frekans_4_3" class="form-control">
                            </select>
                        </div>


                    </div>

                </div>
                <div class="modal-footer">
                    <button id="Eczane_Ekle" type="button" class="btn btn-info">Ekle</button>
                </div>
            </div>

        </div>
    </div>

    <div id="Doktor_Modal" class="modal fade" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div id="doktor_modal_head" class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 id="Dktr_modal_bslk" class="modal-title"></h4>
                </div>
                <div id="doktor_modal_body" class="modal-body">

                    <div class="box-body">
                        <div class="form-group">
                            <%--// has-error--%>
                            <label>Doktor Listesi</label>
                            <select id="Dktr_Liste" class="form-control">
                            </select>
                        </div>
                        <div class="form-group">
                            <%--// has-error--%>
                            <label>İl</label>
                            <select id="Dktr_Il" class="form-control">
                                <option id="scnz">--Lütfen Şehir Seçiniz</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label>Brick</label>
                            <select id="Dktr_brick" class="form-control">
                            </select>
                        </div>
                        <div class="form-group">
                            <label>Ünite Adı</label>
                            <select id="Dktr_Unite" class="form-control">
                            </select>
                        </div>
                        <div class="form-group">
                            <label>Branş</label>
                            <select id="Dktr_Brans" class="form-control">
                            </select>
                        </div>
                        <div class="form-group">
                            <label>Doktor Adı</label>
                            <select id="Dktr_Ad" class="form-control">
                            </select>
                        </div>
                        <div id="Sadece_Bu_gun_Doktor" class="form-group">
                            <div class="checkbox">
                                <label>
                                    <input id="Doktor_Sadece_Bu_Gun" type="checkbox">
                                    Sadece Bu Güne Eklensin
                                </label>
                            </div>

                        </div>
                        <div id="Bilgi_Mesajı" class="alert alert-info alert-dismissible" style="display: none">
                            <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
                            <h4><i class="icon fa fa-info"></i>Bilgi!</h4>
                            İşlem yaptığınız ayda 3 tam hafta olduğundan dolayı 4 frekansı olan doktorların 1 ziyareti eksik kalacaktır lütfen ayrık günleri kontrol ederek kalan ziyaretlerini doldurunuz.(Ayrık Gün; Ayın Tam haftaları dışında kalan günleridir )
                        </div>

                        <div id="Bilgi_Mesajı_Ilk_Tam_Hafta" class="alert alert-info alert-dismissible" style="display: none">
                            <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
                            <h4><i class="icon fa fa-info"></i>Bilgi!</h4>
                            Çoklu Ekleme Yapmak İçin Lütfen İlk Tam Haftadan İşlem Yapınız
                        </div>
                        <div class="form-group" id="frekans_2_1_div" style="display: none;">
                            <label>3. Tam Hafta</label>
                            <select id="frekans_2_1" class="form-control">
                            </select>
                        </div>
                        <div class="form-group" id="frekans_4_1_div" style="display: none;">
                            <label>2. Tam Hafta</label>
                            <select name="Frekans_Select_Doktor" id="frekans_4_1" class="form-control">
                            </select>
                        </div>
                        <div class="form-group" id="frekans_4_2_div" style="display: none;">
                            <label>3. Tam Hafta</label>
                            <select name="Frekans_Select_Doktor" id="frekans_4_2" class="form-control">
                            </select>
                        </div>
                        <div class="form-group" id="frekans_4_3_div" style="display: none;">
                            <label>4. Tam Hafta</label>
                            <select name="Frekans_Select_Doktor" id="frekans_4_3" class="form-control">
                            </select>
                        </div>


                    </div>

                </div>
                <div class="modal-footer">
                    <button id="Ekle" type="button" class="btn btn-info">Ekle</button>
                </div>
            </div>

        </div>
    </div>
    <!-- Modal -->
    <div id="Eczane_Frekans_Kontrol" class="modal fade" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Eczane Frekans Kontrolü</h4>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label>Lütfen Liste Seçiniz</label>
                        <select id="Eczane_Frekans_Kontrol_Liste" class="form-control"></select>

                    </div>
                    <div class="form-group">
                        <label>Aramayı Daraltmak için Lütfen Eczane İsimi Giriniz</label>
                        <input id="Eczane_Frekans_input" type="text" class="form-control" placeholder="Enter ..." />
                    </div>

                    <div class="box-body no-padding table-responsive">
                        <div class="box">

                            <table id="Eczane_Frekans_Kontrol_Table" class="table table-condensed">
                                <thead>

                                </thead>
                                <tbody>
                                    <tr>
                                        <th>Eczane Adı</th>
                                        <th>Brick</th>
                                        <th>İl</th>
                                        <th>Frekans</th>
                                    </tr>

                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>


                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Kapat</button>
                </div>
            </div>

        </div>
    </div>
    <div id="Doktor_Frekans_Kontrol" class="modal fade" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Doktor Frekans Kontrolü</h4>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label>Lütfen Liste Seçiniz</label>
                        <select id="Doktor_Frekans_Kontrol_Liste" class="form-control"></select>

                    </div>
                    <div class="form-group">
                        <label>Aramayı Daraltmak için Lütfen Doktor İsimi Giriniz</label>
                        <input id="Doktor_Frekans_input" type="text" class="form-control" placeholder="Enter ..." />
                    </div>

                    <div class="box-body no-padding table-responsive">
                        <div class="box">

                            <table id="Doktor_Frekans_Kontrol_Table" class="table table-condensed">
                                <tbody>
                                    <tr>
                                        <th>Doktor Adı</th>
                                        <th>Ünite</th>
                                        <th>Branş</th>
                                        <th>Frekans</th>
                                    </tr>

                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>


                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Kapat</button>
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
            <div class="form-group">
                <input id="Onay_Talebi_Gonder" type="button" class="btn btn-block btn-info btn-lg" value="Plan Onay Talebi Gönder" />
            </div>
        </div>
        <%-- <div class="col-xs-6">
            <div class="form-group">
                <input id="Sablon_Olustur" type="button" class="btn btn-block btn-info btn-lg" value="Şablon Oluştur" />
            </div>
        </div>--%>
    </div>




    <asp:Repeater ID="Repeater1" runat="server">
        <ItemTemplate>
            <div id="row" ayrık="<%#Ayrıkmı(Eval("Ziy_Tar","{0:d-M-yyyy}").ToString()) %>" class="row">
                <div id="bilgi" class="col-lg-12 ">
                    <div class="box box-default collapsed-box box-solid " off_gun="<%#Eval("Ziy_Tar","{0:yyyy-MM-dd}")%>">

                        <div class="box-header with-border  bg-blue-gradient">
                            <div class="row">
                                <div class="col-xs-2">
                                    <span id="gun" gun_tam_cizgili="<%#Eval("Ziy_Tar","{0:yyyy-M-d}")%>" gun_tam="<%#Eval("Ziy_Tar","{0:d M yyyy}")%>" name="<%#Eval("Ziy_Tar","{0:dddddddd}") %>" style="font-size: 50px; color: #1e1b1b"><%#Eval("Ziy_Tar","{0:%d}") %></span>
                                </div>
                                <div class="col-xs-2">
                                    <span id="ay_yıl" style="font-size: 22px; color: #1e1b1b"><%#Eval("Ziy_Tar","{0:% MMMM}") %></br><%#Eval("Ziy_Tar","{0:% yyyy}") %></span>
                                </div>
                                <div class="col-xs-2">
                                    <span id="Header_Gun_span_<%#Eval("Ziy_Tar","{0:%d}") %>" style="font-size: 20px;"></span>

                                </div>
                                <div class="col-xs-2">
                                    <span id="Gun_txt" style="font-size: 20px;">&nbsp;<%#Eval("Ziy_Tar","{0:dddddddd}") %></span>
                                    <span id="Ay_int" style="font-size: 20px; display: none;"><%#Eval("Ziy_Tar","{0:%M}") %></span>
                                </div>
                            </div>




                            <span style="font-size: 12px;"></span>




                            <div class="box-tools ">
                                <div class="row">
                                    <div class="col-xs-6">
                                        <button type="button" class=" btn-primary no-border bg-blue-gradient" seçilen="False" seçildimi="False" ziyaret_id="<%#Eval("ID") %>" id="Kopyala_Yapıştır" style="font-size: 50px">
                                            <i class="fa fa-copy"></i>
                                        </button>
                                    </div>
                                    <div class="col-xs-6">
                                        <button type="button" class=" btn-primary no-border bg-blue-gradient" data-widget="collapse" style="font-size: 50px">
                                            <i class="fa fa-plus"></i>
                                        </button>
                                    </div>
                                </div>

                            </div>
                            <!-- /.box-tools -->
                        </div>
                        <!-- /.box-header -->

                        <div id="doktor_<%#Eval("Ziy_Tar","{0:%d}") %>" class="box-body">
                            <label>Ziyaret Edilecek Doktor Listesi</label>
                            <div class="box">

                                <table class="table table-hover">
                                    <tbody>
                                        <tr>
                                            <th>Doktor Adı</th>
                                            <th>Ünite</th>
                                            <th>Branş</th>
                                            <th>Brick</th>
                                            <th>Ziyaret Durumu</th>
                                            <th>Kaldır</th>
                                        </tr>


                                        <tr>
                                            <td style="text-align: center; background-color: #f9f9f9;" colspan="6">Tabloda herhangi bir veri mevcut değil </td>
                                        </tr>


                                    </tbody>
                                </table>
                                <a class="btn btn-warning  pull-right" style="margin-left: 10px" gun_tam_cizgili="<%#Eval("Ziy_Tar","{0:yyyy-M-d}")%>" button_tipi="Doktor" id="Doktor_Listenin_Tamanını_Ekle">Liste Ekle</a>
                                <a class="btn btn-danger pull-right" style="margin-left: 10px" gun_tam_cizgili="<%#Eval("Ziy_Tar","{0:yyyy-M-d}")%>" button_tipi="Doktor" id="Doktor_Günü_Sil">Ziyaretleri Kaldır</a>

                                <a class="btn btn-info pull-right" sadece="1"  gun_ıd="<%#Eval("ID")%>" id="btn_addtocart_Doktor_Ziyaret" >Ziyaret Düzenle</a>
                            </div>
                        </div>



                        <div id="eczane_<%#Eval("Ziy_Tar","{0:%d}") %>" class="box-body">
                            <label>Ziyaret Edilecek Eczane Listesi</label>

                            <div class="box">
                                <div class="form-group">
                                    <table class="table table-hover">

                                        <tbody>
                                            <tr>
                                                <th>Eczane Adı</th>
                                                <th>İl</th>
                                                <th>Brick</th>
                                                <th>Kenar</th>
                                                <th>Ziyaret Durumu</th>
                                            </tr>
                                            <tr>
                                                <td style="text-align: center; background-color: #f9f9f9;" colspan="6">Tabloda herhangi bir veri mevcut değil </td>
                                            </tr>
                                        </tbody>
                                    </table>

                                </div>

                            </div>
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="form-group">
                                        <a class="btn btn-warning  pull-right" style="margin-left: 10px" gun_tam_cizgili="<%#Eval("Ziy_Tar","{0:yyyy-M-d}")%>" button_tipi="Eczane" id="Doktor_Listenin_Tamanını_Ekle">Liste Ekle</a>
                                        <a class="btn btn-danger pull-right" style="margin-left: 10px" gun_tam_cizgili="<%#Eval("Ziy_Tar","{0:yyyy-M-d}")%>" button_tipi="Eczane" id="Doktor_Günü_Sil">Ziyaretleri Kaldır</a>
                                        <a class="btn btn-info pull-right" sadece="1" gun_ıd="<%#Eval("ID")%>" id="btn_addtocart_Eczane_Ziyaret" >Ziyaret Düzenle</a>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <%--   <div  class="box-body">
                            
                            <div class="box">--%>
                    </div>
                </div>
            </div>
        </ItemTemplate>

    </asp:Repeater>

</asp:Content>
