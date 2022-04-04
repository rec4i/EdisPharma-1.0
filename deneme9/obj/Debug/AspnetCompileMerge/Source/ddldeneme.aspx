<%@ Page Title="" Language="C#" MasterPageFile="~/admin.Master" AutoEventWireup="true" EnableEventValidation="false" EnableViewState="false" CodeBehind="ddldeneme.aspx.cs" Inherits="deneme9.ddldeneme" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">



    <script type="text/javascript">











        $(document).ready(function () {
            //ekleneceği gün rakamı /

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
                window.location.href = "/ddldeneme.aspx?x=" + calyr.val() + "-" + calmth.val()

            });




            var content = $("section[id=content]");
            var Pazar = content.find($("span[name=Pazar]"));//find($('span[id=ay_yıl]')).append('<h1>asddasasd</h1>');
            var pazardiv = Pazar.parent().parent().append("<div class='overlay'></div >");
            var Cumartesi = content.find($("span[name=Cumartesi]"));
            var cumartesidiv = Cumartesi.parent().parent().append("<div class='overlay'></div >");

            var options = { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' };
            var today = new Date();

            var Yıl_DDL = $('select[id=calyr]')
            var Ay_DDL = $('select[id=calmth]')



            $.ajax({
                url: 'ddldeneme.aspx/Tabloları_Doldur',
                dataType: 'json',
                type: 'POST',
                data: "{'parametre': '" + Yıl_DDL.find('option:selected').val() + "-" + Ay_DDL.find('option:selected').val() + "'}",
                contentType: 'application/json; charset=utf-8',
                success: function (data) {
                    var cont = $('section[id=content]')





                    for (var i = 0; i < data.d.split('!').length; i++) {// '<td><span class="label label-waring">Ziyret bekleniyor</span></td>'

                        var label_str = ""
                        if (data.d.split('!')[i].split('/')[5] == "0") {

                            label_str += '<td><span class="label label-waring">Ziyret Bekleniyor</span></td>'
                        }
                        if (data.d.split('!')[i].split('/')[5] == "1") {
                            '<td><span class="label label-waring">Ziyret Edildi</span></td>'
                        }

                        var cont = $('section[id=content]')
                        var Doktor_Div = cont.find($('div[id = doktor_' + parseInt(data.d.split('!')[i].split('/')[6]) + ']'));
                        var Doktor_Tablo = Doktor_Div.children().children().children();
                        Doktor_Tablo.append('<tr><td>' + data.d.split('!')[i].split('/')[0] + '</td><td>' + data.d.split('!')[i].split('/')[2] + '</td><td>' + data.d.split('!')[i].split('/')[3] + '</td><td>' + data.d.split('!')[i].split('/')[4] + '</td>' + label_str + '</tr>')

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





                    for (var i = 0; i < data.d.split('!').length; i++) {// '<td><span class="label label-waring">Ziyret bekleniyor</span></td>'

                        var label_str = ""
                        if (data.d.split('!')[i].split('/')[4] == "0") {

                            label_str += '<td><span class="label label-waring">Ziyret Bekleniyor</span></td>'
                        }
                        if (data.d.split('!')[i].split('/')[4] == "1") {
                            label_str += '<td><span class="label label-waring">Ziyret Edildi</span></td>'
                        }

                        var cont = $('section[id=content]')
                        var Doktor_Div = cont.find($('div[id = eczane_' + parseInt(data.d.split('!')[i].split('/')[5]) + ']'));
                        var Doktor_Tablo = Doktor_Div.find($('div[class=box]')).children().children();
                        Doktor_Tablo.append('<tr><td>' + data.d.split('!')[i].split('/')[0] + '</td><td>' + data.d.split('!')[i].split('/')[3] + '</td><td>' + data.d.split('!')[i].split('/')[2] + '</td>' + label_str + '</tr>')

                    }




                },
                error: function () {

                    alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                }
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
                            data: "{'parametre': '" + "/" + Eczane_Frekans_Kontrol_Liste.find('option:selected').val() + "/" + gun_tam_cizgili+ "'}",//liste cinsini de yolla o gördüğün 0 liste cinsi
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
                    data: "{'parametre': '" + Eczane_Frekans_input.val() + "/" + Eczane_Frekans_Kontrol_Liste.find('option:selected').val() + "/" + gun_tam_cizgili+ "'}",//liste cinsini de yolla o gördüğün 0 liste cinsi
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


            $("a[id*=btn_addtocart_Eczane]").bind("click", function () {

                var ayrık = $(this).closest($('div[ayrık=true]'));

                var bilgi = $(this).closest($('div[Id*=bilgi]'));
                var Gun_Rkm = $(bilgi).find($('[id*=gun]')).html().replace(/\&nbsp;/g, ' ');
                var Gun_Txt = $(bilgi).find($('[id*=Gun_txt]')).html().replace(/\&nbsp;/g, ' ');
                var Ay_Yıl_Txt = $(bilgi).find($('[id*=ay_yıl]')).html().replace(/\&nbsp;/g, ' ').replace('<br>', ' ').split(' ');//1 ay 3 yıl

                //Doktor_Modal
                var Dokor_Modal = $('div[Id*=Eczane_Modal]');
                var Doktor_Modal_head = $('div[Id*=Eczane_modal_head]');
                var Dktr_modal_bslk = $(Doktor_Modal_head).find($('h4[Id*=Eczane_modal_bslk]'));
                Dktr_modal_bslk.empty();
                var Dktr_modal_bslk = $(Doktor_Modal_head).find($('h4[Id*=Eczane_modal_bslk]')).append(Gun_Rkm + " " + Ay_Yıl_Txt[1] + " " + Gun_Txt);

                var Dktr_Il = $(Dokor_Modal).find($('select[Id*=Eczane_Il]'));
                var Dktr_Brick = $(Dokor_Modal).find($('select[Id*=Eczane_brick]'));
                var Dktr_Ad = $(Dokor_Modal).find($('select[Id*=Eczane_Ad]'));
                var Dktr_Liste = $(Dokor_Modal).find($('select[Id*=Eczane_Liste]'));
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





                var Dktr_Modal_Kaydet = Dokor_Modal.find($('button[id=Eczane_Ekle]'))

                Dktr_Modal_Kaydet.click(function () {

                    var cont = $('section[id=content]')

                    var brick_secili = cont.find($('select[id=Eczane_brick]')).find('option:selected').text()
                    var liste_seçili = Dktr_Liste.find('option:selected').val()

                    var gun_tam_cizgili = $(bilgi).find($('[id=gun]')).attr('gun_tam_cizgili')

                    var Dktr_Ad = $(Dokor_Modal).find($('select[Id*=Eczane_Ad]'));

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







                    if (Dktr_Ad_seçili_frekans == "2") {


                        if (Ayrıkmı_kont == "True") {

                            var Doktor_Div = cont.find($('div[id=eczane_' + Gun_Rkm + '],div[id=eczane_' + hafta_21_Seçili_gun_rkm + ']'));
                            var Doktor_Tablo = Doktor_Div.children().children().children();

                            $.ajax({
                                url: 'ddldeneme.aspx/Eczane_Db_Yaz_2_hafta',
                                dataType: 'json',
                                type: 'POST',
                                data: "{'parametre': '" + gun_tam_cizgili + "/" + Dktr_Ad_seçili_Id + "/" + liste_seçili + "'}",
                                contentType: 'application/json; charset=utf-8',
                                success: function (data) {

                                    if (data.d == "1") {
                                        alert("Başarılı!")
                                        Doktor_Tablo.append('<tr><td>' + Dktr_Ad_seçili.text() + '</td><td>' + unite_secili + '</td><td>' + branş_secili + '</td><td>' + brick_secili + '</td><td><span class="label label-waring">Ziyret bekleniyor</span></td></tr>')

                                    }
                                    if (data.d == "") {
                                        alert("Hata Lütfen Frekanslara Dikkat Ediniz!")
                                    }
                                    if (data.d == "0") {
                                        alert("Hata Lütfen Frekanslara Dikkat Ediniz!")
                                    }

                                },
                                error: function () {

                                    alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                                }
                            });


                        }

                        else {
                            var Doktor_Div = cont.find($('div[id=eczane_' + Gun_Rkm + '],div[id=eczane_' + hafta_21_Seçili_gun_rkm + ']'));
                            var Doktor_Tablo = Doktor_Div.children().children().children();

                            $.ajax({
                                url: 'ddldeneme.aspx/Eczane_Db_Yaz_2_hafta',
                                dataType: 'json',
                                type: 'POST',
                                data: "{'parametre': '" + hafta_21_Seçili_yıl_rkm + "-" + hafta_21_Seçili_ay_rkm + "-" + hafta_21_Seçili_gun_rkm + "/" + gun_tam_cizgili + "/" + Dktr_Ad_seçili_Id + "/" + liste_seçili + "'}",
                                contentType: 'application/json; charset=utf-8',
                                success: function (data) {

                                    if (data.d == "1") {
                                        alert("Başarılı!")

                                        Doktor_Tablo.append('<tr><td>' + Dktr_Ad_seçili.text() + '</td><td>' + unite_secili + '</td><td>' + branş_secili + '</td><td>' + brick_secili + '</td><td><span class="label label-waring">Ziyret bekleniyor</span></td></tr>')

                                        Doktor_Div = cont.find($('div[id=doktor_' + hafta_21_gun_rkm + ']'));
                                        Doktor_Tablo = Doktor_Div.children().children().children();
                                        Doktor_Tablo.append('<tr><td>' + Dktr_Ad_seçili.text() + '</td><td>' + unite_secili + '</td><td>' + branş_secili + '</td><td>' + brick_secili + '</td><td><span class="label label-waring">Ziyret bekleniyor</span></td></tr>')

                                    }
                                    if (data.d == "") {
                                        alert("Hata Lütfen Frekanslara Dikkat Ediniz!")
                                    }
                                    if (data.d == "0") {
                                        alert("Hata Lütfen Frekanslara Dikkat Ediniz!")
                                    }

                                },
                                error: function () {

                                    alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                                }
                            });

                        }





                        //Doktor_Tablo.append('<tr><td>' + Dktr_Ad_seçili.text() + '</td><td>' + unite_secili + '</td><td>' + branş_secili + '</td><td>' + brick_secili + '</td><td><span class="labellabel-waring">Ziyret bekleniyor</span></td></tr>')


                    }

                    if (Dktr_Ad_seçili_frekans == "4") {
                        if (Ayrıkmı_kont == "True") {
                            var Doktor_Div = cont.find($('div[id=doktor_' + Gun_Rkm + ']'));
                            var Doktor_Tablo = Doktor_Div.children().children().children();

                            $.ajax({
                                url: 'ddldeneme.aspx/Eczane_Db_Yaz_4_hafta',
                                dataType: 'json',
                                type: 'POST',
                                data: "{'parametre': '" + gun_tam_cizgili + "/" + Dktr_Ad_seçili_Id + "/" + liste_seçili + "'}",
                                contentType: 'application/json; charset=utf-8',
                                success: function (data) {


                                    if (data.d == "1") {
                                        alert("İşlem Başarılı!")
                                        Doktor_Tablo.append('<tr><td>' + Dktr_Ad_seçili.text() + '</td><td>' + unite_secili + '</td><td>' + branş_secili + '</td><td>' + brick_secili + '</td><td><span class="label label-waring">Ziyret bekleniyor</span></td></tr>')

                                    }
                                    if (data.d == "") {
                                        alert("Hata Lütfen Frekanslara Dikkat Ediniz!")
                                    }
                                    if (data.d == "0") {
                                        alert("Hata Lütfen Frekanslara Dikkat Ediniz!")
                                    }

                                },
                                error: function () {

                                    alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                                }
                            });
                        }
                        else if (uc_haftamı == "True") {

                            var Doktor_Div = cont.find($('div[id=doktor_' + Gun_Rkm + ']'));
                            var Doktor_Tablo = Doktor_Div.children().children().children();

                            $.ajax({
                                url: 'ddldeneme.aspx/Eczane_Db_Yaz_4_hafta',
                                dataType: 'json',
                                type: 'POST',
                                data: "{'parametre': '" + hafta_41_yıl_rkm + "-" + hafta_41_ay_rkm + "-" + hafta_41_gun_rkm + "/" + hafta_42_yıl_rkm + "-" + hafta_42_ay_rkm + "-" + hafta_42_gun_rkm + "/" + gun_tam_cizgili + "/" + Dktr_Ad_seçili_Id + "/" + liste_seçili + "'}",
                                contentType: 'application/json; charset=utf-8',
                                success: function (data) {


                                    if (data.d == "1") {
                                        alert("İşlem Başarılı!")
                                        Doktor_Tablo.append('<tr><td>' + Dktr_Ad_seçili.text() + '</td><td>' + unite_secili + '</td><td>' + branş_secili + '</td><td>' + brick_secili + '</td><td><span class="label label-waring">Ziyret bekleniyor</span></td></tr>')

                                        Doktor_Div = cont.find($('div[id=doktor_' + hafta_41_gun_rkm + ']'));
                                        Doktor_Tablo = Doktor_Div.children().children().children();
                                        Doktor_Tablo.append('<tr><td>' + Dktr_Ad_seçili.text() + '</td><td>' + unite_secili + '</td><td>' + branş_secili + '</td><td>' + brick_secili + '</td><td><span class="label label-waring">Ziyret bekleniyor</span></td></tr>')
                                        Doktor_Div = cont.find($('div[id=doktor_' + hafta_42_gun_rkm + ']'));
                                        Doktor_Tablo = Doktor_Div.children().children().children();
                                        Doktor_Tablo.append('<tr><td>' + Dktr_Ad_seçili.text() + '</td><td>' + unite_secili + '</td><td>' + branş_secili + '</td><td>' + brick_secili + '</td><td><span class="label label-waring">Ziyret bekleniyor</span></td></tr>')

                                    }
                                    if (data.d == "") {
                                        alert("Hata Lütfen Frekanslara Dikkat Ediniz!")
                                    }
                                    if (data.d == "0") {
                                        alert("Hata Lütfen Frekanslara Dikkat Ediniz!")
                                    }

                                },
                                error: function () {

                                    alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                                }
                            });
                        }
                        else if (dort_haftamı == "True") {

                            var Doktor_Div = cont.find($('div[id=doktor_' + Gun_Rkm + ']'));
                            var Doktor_Tablo = Doktor_Div.children().children().children();

                            $.ajax({
                                url: 'ddldeneme.aspx/Eczane_Db_Yaz_4_hafta',
                                dataType: 'json',
                                type: 'POST',
                                data: "{'parametre': '" + hafta_41_yıl_rkm + "-" + hafta_41_ay_rkm + "-" + hafta_41_gun_rkm + "/" + hafta_42_yıl_rkm + "-" + hafta_42_ay_rkm + "-" + hafta_42_gun_rkm + "/" + hafta_43_yıl_rkm + "-" + hafta_43_ay_rkm + "-" + hafta_43_gun_rkm + "/" + gun_tam_cizgili + "/" + Dktr_Ad_seçili_Id + "/" + liste_seçili + "'}",
                                contentType: 'application/json; charset=utf-8',
                                success: function (data) {


                                    if (data.d == "1") {
                                        alert("İşlem Başarılı!")
                                        Doktor_Tablo.append('<tr><td>' + Dktr_Ad_seçili.text() + '</td><td>' + unite_secili + '</td><td>' + branş_secili + '</td><td>' + brick_secili + '</td><td><span class="label label-waring">Ziyret bekleniyor</span></td></tr>')

                                        Doktor_Div = cont.find($('div[id=doktor_' + hafta_41_gun_rkm + ']'));
                                        Doktor_Tablo = Doktor_Div.children().children().children();
                                        Doktor_Tablo.append('<tr><td>' + Dktr_Ad_seçili.text() + '</td><td>' + unite_secili + '</td><td>' + branş_secili + '</td><td>' + brick_secili + '</td><td><span class="label label-waring">Ziyret bekleniyor</span></td></tr>')
                                        Doktor_Div = cont.find($('div[id=doktor_' + hafta_42_gun_rkm + ']'));
                                        Doktor_Tablo = Doktor_Div.children().children().children();
                                        Doktor_Tablo.append('<tr><td>' + Dktr_Ad_seçili.text() + '</td><td>' + unite_secili + '</td><td>' + branş_secili + '</td><td>' + brick_secili + '</td><td><span class="label label-waring">Ziyret bekleniyor</span></td></tr>')
                                        Doktor_Div = cont.find($('div[id=doktor_' + hafta_43_gun_rkm + ']'));
                                        Doktor_Tablo = Doktor_Div.children().children().children();
                                        Doktor_Tablo.append('<tr><td>' + Dktr_Ad_seçili.text() + '</td><td>' + unite_secili + '</td><td>' + branş_secili + '</td><td>' + brick_secili + '</td><td><span class="label label-waring">Ziyret bekleniyor</span></td></tr>')

                                    }
                                    if (data.d == "") {
                                        alert("Hata Lütfen Frekanslara Dikkat Ediniz!")
                                    }
                                    if (data.d == "0") {
                                        alert("Hata Lütfen Frekanslara Dikkat Ediniz!")
                                    }

                                },
                                error: function () {

                                    alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                                }
                            });
                        }












                    }




                    Dktr_Modal_Kaydet.unbind('click');
                });






                Dktr_Ad.parent().removeAttr("class");
                Dktr_Ad.parent().attr("class", "form-group");
                Dktr_Brick.parent().removeAttr("class");
                Dktr_Brick.parent().attr("class", "form-group");
                Dktr_Il.parent().removeAttr("class");
                Dktr_Il.parent().attr("class", "form-group");


                $.ajax({
                    url: 'ddldeneme.aspx/OrnekPost',
                    dataType: 'json',
                    type: 'POST',
                    data: "{'parametre': '0-0'}",
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {

                        Dktr_Il.empty();
                        Dktr_Il.append("<option>-->> Lütfen Şehir Seçiniz <<--</option>")
                        var b = 0;
                        while (data.d.split('!')[b] != null) {

                            Dktr_Il.append("<option value='" + data.d.split('!')[b].split("-")[0] + "'>" + data.d.split('!')[b].split("-")[1] + "</option>");
                            b++;

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
                        url: 'ddldeneme.aspx/OrnekPost',
                        dataType: 'json',
                        type: 'POST',
                        data: "{'parametre': '1-" + $(this).val() + "'}",
                        contentType: 'application/json; charset=utf-8',
                        success: function (data) {
                            Dktr_Brick.empty();
                            Dktr_Brick.append("<option>-->> Lütfen Brick Seçiniz <<--</option>");
                            var b = 0;
                            while (data.d.split('!')[b] != null) {
                                Dktr_Brick.append("<option value='" + data.d.split('!')[b].split("-")[0] + "'>" + data.d.split('!')[b].split("-")[1] + "</option>");
                                b++;
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
                        url: 'ddldeneme.aspx/OrnekPost',
                        dataType: 'json',
                        type: 'POST',
                        data: "{'parametre': '5-" + $(this).val() + "'}",
                        contentType: 'application/json; charset=utf-8',
                        success: function (data) {

                            Dktr_Ad.empty();
                            Dktr_Ad.append("<option>-->> Lütfen Ünite Seçiniz <<--</option>");
                            var b = 0;
                            while (data.d.split('!')[b] != null) {

                                Dktr_Ad.append("<option frekans='" + data.d.split('!')[b].split("-")[1] + "' value='" + data.d.split('!')[b].split("-")[0] + "'>" + data.d.split('!')[b].split("-")[2] + "</option>");
                                b++;
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

                var ayrık = $(this).closest($('div[id*=row]')).attr('ayrık');



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

                    Dktr_Brick.unbind();
                    Dktr_Ad.unbind();

                    Bilgi_Mesajı_ayrıkGun.attr('style', 'display: none');
                    Bilgi_Mesajı_Ilk_Tam_Hafta.attr('style', 'display: none');

                })

                var gun_tam_cizgili = $(bilgi).find($('[id=gun]')).attr('gun_tam_cizgili')
                var gun_tam = $(bilgi).find($('[id=gun]')).attr('gun_tam')


                var bilgi = $(this).closest($('div[Id*=bilgi]'));
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

                        for (var i = 0; i < data.d.split('/')[0].split('*').length; i++) {


                            if (data.d.split('/')[0].split('*')[i].split('-')[0] != gun_tam) {

                                Bilgi_Mesajı_Ilk_Tam_Hafta.removeAttr('style')
                                Bilgi_Mesajı_ayrıkGun.attr('style', 'display: none');

                                Ayrıkmı_kont = "True";
                                Doldur = "0";
                                continue;
                            }
                            else {

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

                function gundoldur() {
                    if (ayrık == "False") {

                        $.ajax({
                            url: 'ddldeneme.aspx/Frekans_modal_Doldurma',
                            dataType: 'json',
                            type: 'POST',
                            data: "{'parametre': '" + gun_tam_cizgili.split('-')[0] + "-" + gun_tam_cizgili.split('-')[1] + "'}",
                            contentType: 'application/json; charset=utf-8',
                            success: function (data) {


                                var Dokor_Modal = $('div[Id*=Eczane_Modal]');
                                var Dktr_Ad = $(Dokor_Modal).find($('select[Id*=Eczane_Ad]'));
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

                                        for (var i = 0; i < data.d.split('/')[3].split('*').length; i++) {
                                            hafta_41.append('<option Gun_Rkm=' + data.d.split('/')[1].split('*')[i].split('-')[0].split(' ')[0] + ' Ay_Rkm=' + data.d.split('/')[1].split('*')[i].split('-')[0].split(' ')[1] + ' Yıl_Rkm=' + data.d.split('/')[1].split('*')[i].split('-')[0].split(' ')[2] + ' >' + data.d.split('/')[1].split('*')[i].split('-')[1] + '</option>')
                                        }
                                        hafta_41_div.removeAttr('style')

                                        for (var i = 0; i < data.d.split('/')[3].split('*').length; i++) {
                                            hafta_42.append('<option Gun_Rkm=' + data.d.split('/')[2].split('*')[i].split('-')[0].split(' ')[0] + ' Ay_Rkm=' + data.d.split('/')[2].split('*')[i].split('-')[0].split(' ')[1] + ' Yıl_Rkm=' + data.d.split('/')[2].split('*')[i].split('-')[0].split(' ')[2] + ' >' + data.d.split('/')[2].split('*')[i].split('-')[1] + '</option>')
                                        }
                                        hafta_42_div.removeAttr('style')

                                        for (var i = 0; i < data.d.split('/')[3].split('*').length; i++) {
                                            hafta_43.append('<option Gun_Rkm=' + data.d.split('/')[3].split('*')[i].split('-')[0].split(' ')[0] + ' Ay_Rkm=' + data.d.split('/')[3].split('*')[i].split('-')[0].split(' ')[1] + ' Yıl_Rkm=' + data.d.split('/')[3].split('*')[i].split('-')[0].split(' ')[2] + ' >' + data.d.split('/')[3].split('*')[i].split('-')[1] + '</option>')
                                        }
                                        hafta_43_div.removeAttr('style')
                                        hafta_21_div.attr('style', 'display: none');

                                    }
                                    if (data.d.split('/').length == 3) {//style="display: none;"  Bilgi_Mesajı
                                        uc_haftamı = "True"
                                        Bilgi_Mesajı.removeAttr('style')

                                        for (var i = 0; i < data.d.split('/')[1].split('*').length - 1; i++) {
                                            hafta_41.append('<option Gun_Rkm=' + data.d.split('/')[1].split('*')[i].split('-')[0].split(' ')[0] + ' Ay_Rkm=' + data.d.split('/')[1].split('*')[i].split('-')[0].split(' ')[1] + ' Yıl_Rkm=' + data.d.split('/')[1].split('*')[i].split('-')[0].split(' ')[2] + ' >' + data.d.split('/')[1].split('*')[i].split('-')[1] + '</option>')
                                        }
                                        hafta_41_div.removeAttr('style')

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
                            data: "{'parametre': '" + "/" + Doktor_Frekans_Kontrol_Liste.find('option:selected').val() + "/" + gun_tam_cizgili+"'}",//liste cinsini de yolla o gördüğün 0 liste cinsi
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
                    data: "{'parametre': '" + Doktor_Frekans_input.val() + "/" + Doktor_Frekans_Kontrol_Liste.find('option:selected').val() + "/" + gun_tam_cizgili+"'}",//liste cinsini de yolla o gördüğün 0 liste cinsi
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

            $("a[id*=btn_addtocart_Doktor]").bind("click", function () {

                var ayrık = $(this).closest($('div[ayrık=true]'));

                var bilgi = $(this).closest($('div[Id*=bilgi]'));
                var Gun_Rkm = $(bilgi).find($('[id*=gun]')).html().replace(/\&nbsp;/g, ' ');
                var Gun_Txt = $(bilgi).find($('[id*=Gun_txt]')).html().replace(/\&nbsp;/g, ' ');
                var Ay_Yıl_Txt = $(bilgi).find($('[id*=ay_yıl]')).html().replace(/\&nbsp;/g, ' ').replace('<br>', ' ').split(' ');//1 ay 3 yıl

                //Doktor_Modal
                var Dokor_Modal = $('div[Id=Doktor_Modal]');
                var Doktor_Modal_head = $('div[Id*=doktor_modal_head]');
                var Dktr_modal_bslk = $(Doktor_Modal_head).find($('h4[Id*=Dktr_modal_bslk]'));
                Dktr_modal_bslk.empty();
                var Dktr_modal_bslk = $(Doktor_Modal_head).find($('h4[Id*=Dktr_modal_bslk]')).append(Gun_Rkm + " " + Ay_Yıl_Txt[1] + " " + Gun_Txt);

                var Dktr_Il = $(Dokor_Modal).find($('select[Id*=Dktr_Il]'));
                var Dktr_Brick = $(Dokor_Modal).find($('select[Id*=Dktr_brick]'));
                var Dktr_Unite = $(Dokor_Modal).find($('select[Id*=Dktr_Unite]'));
                var Dktr_Brans = $(Dokor_Modal).find($('select[Id*=Dktr_Brans]'));
                var Dktr_Ad = $(Dokor_Modal).find($('select[Id*=Dktr_Ad]'));
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



                var Dktr_Modal_Kaydet = Dokor_Modal.find($('button[id=Ekle]'))
                Dktr_Modal_Kaydet.click(function () {

                    var cont = $('section[id=content]')

                    var brick_secili = cont.find($('select[id=Dktr_brick]')).find('option:selected').text()
                    var unite_secili = cont.find($('select[id=Dktr_Unite]')).find('option:selected').text()
                    var branş_secili = cont.find($('select[id=Dktr_Brans]')).find('option:selected').text()//Dktr_Liste
                    var liste_seçili = Dktr_Liste.find('option:selected').val()

                    var gun_tam_cizgili = $(bilgi).find($('[id=gun]')).attr('gun_tam_cizgili')

                    var Dktr_Ad = $(Dokor_Modal).find($('select[Id*=Dktr_Ad]'));

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







                    if (Dktr_Ad_seçili_frekans == "2") {


                        if (Ayrıkmı_kont == "True") {

                            var Doktor_Div = cont.find($('div[id=doktor_' + Gun_Rkm + '],div[id=doktor_' + hafta_21_Seçili_gun_rkm + ']'));
                            var Doktor_Tablo = Doktor_Div.children().children().children();

                            $.ajax({
                                url: 'ddldeneme.aspx/Doktor_Db_Yaz_2_hafta',
                                dataType: 'json',
                                type: 'POST',
                                data: "{'parametre': '" + gun_tam_cizgili + "/" + Dktr_Ad_seçili_Id + "/" + liste_seçili + "'}",
                                contentType: 'application/json; charset=utf-8',
                                success: function (data) {

                                    if (data.d == "1") {
                                        alert("Başarılı!")
                                        Doktor_Tablo.append('<tr><td>' + Dktr_Ad_seçili.text() + '</td><td>' + unite_secili + '</td><td>' + branş_secili + '</td><td>' + brick_secili + '</td><td><span class="label label-waring">Ziyret bekleniyor</span></td></tr>')

                                    }
                                    if (data.d == "") {
                                        alert("Hata Lütfen Frekanslara Dikkat Ediniz!")
                                    }
                                    if (data.d == "0") {
                                        alert("Hata Lütfen Frekanslara Dikkat Ediniz!")
                                    }

                                },
                                error: function () {

                                    alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                                }
                            });


                        }

                        else {
                            var Doktor_Div = cont.find($('div[id=doktor_' + Gun_Rkm + '],div[id=doktor_' + hafta_21_Seçili_gun_rkm + ']'));
                            var Doktor_Tablo = Doktor_Div.children().children().children();

                            $.ajax({
                                url: 'ddldeneme.aspx/Doktor_Db_Yaz_2_hafta',
                                dataType: 'json',
                                type: 'POST',
                                data: "{'parametre': '" + hafta_21_Seçili_yıl_rkm + "-" + hafta_21_Seçili_ay_rkm + "-" + hafta_21_Seçili_gun_rkm + "/" + gun_tam_cizgili + "/" + Dktr_Ad_seçili_Id + "/" + liste_seçili + "'}",
                                contentType: 'application/json; charset=utf-8',
                                success: function (data) {

                                    if (data.d == "1") {
                                        alert("Başarılı!")

                                        Doktor_Tablo.append('<tr><td>' + Dktr_Ad_seçili.text() + '</td><td>' + unite_secili + '</td><td>' + branş_secili + '</td><td>' + brick_secili + '</td><td><span class="label label-waring">Ziyret bekleniyor</span></td></tr>')

                                        Doktor_Div = cont.find($('div[id=doktor_' + hafta_21_gun_rkm + ']'));
                                        Doktor_Tablo = Doktor_Div.children().children().children();
                                        Doktor_Tablo.append('<tr><td>' + Dktr_Ad_seçili.text() + '</td><td>' + unite_secili + '</td><td>' + branş_secili + '</td><td>' + brick_secili + '</td><td><span class="label label-waring">Ziyret bekleniyor</span></td></tr>')

                                    }
                                    if (data.d == "") {
                                        alert("Hata Lütfen Frekanslara Dikkat Ediniz!")
                                    }
                                    if (data.d == "0") {
                                        alert("Hata Lütfen Frekanslara Dikkat Ediniz!")
                                    }

                                },
                                error: function () {

                                    alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                                }
                            });

                        }





                        //Doktor_Tablo.append('<tr><td>' + Dktr_Ad_seçili.text() + '</td><td>' + unite_secili + '</td><td>' + branş_secili + '</td><td>' + brick_secili + '</td><td><span class="labellabel-waring">Ziyret bekleniyor</span></td></tr>')


                    }

                    if (Dktr_Ad_seçili_frekans == "4") {
                        if (Ayrıkmı_kont == "True") {
                            var Doktor_Div = cont.find($('div[id=doktor_' + Gun_Rkm + ']'));
                            var Doktor_Tablo = Doktor_Div.children().children().children();

                            $.ajax({
                                url: 'ddldeneme.aspx/Doktor_Db_Yaz_4_hafta',
                                dataType: 'json',
                                type: 'POST',
                                data: "{'parametre': '" + gun_tam_cizgili + "/" + Dktr_Ad_seçili_Id + "/" + liste_seçili + "'}",
                                contentType: 'application/json; charset=utf-8',
                                success: function (data) {


                                    if (data.d == "1") {
                                        alert("İşlem Başarılı!")
                                        Doktor_Tablo.append('<tr><td>' + Dktr_Ad_seçili.text() + '</td><td>' + unite_secili + '</td><td>' + branş_secili + '</td><td>' + brick_secili + '</td><td><span class="label label-waring">Ziyret bekleniyor</span></td></tr>')

                                    }
                                    if (data.d == "") {
                                        alert("Hata Lütfen Frekanslara Dikkat Ediniz!")
                                    }
                                    if (data.d == "0") {
                                        alert("Hata Lütfen Frekanslara Dikkat Ediniz!")
                                    }

                                },
                                error: function () {

                                    alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                                }
                            });
                        }
                        else if (uc_haftamı == "True") {

                            var Doktor_Div = cont.find($('div[id=doktor_' + Gun_Rkm + ']'));
                            var Doktor_Tablo = Doktor_Div.children().children().children();

                            $.ajax({
                                url: 'ddldeneme.aspx/Doktor_Db_Yaz_4_hafta',
                                dataType: 'json',
                                type: 'POST',
                                data: "{'parametre': '" + hafta_41_yıl_rkm + "-" + hafta_41_ay_rkm + "-" + hafta_41_gun_rkm + "/" + hafta_42_yıl_rkm + "-" + hafta_42_ay_rkm + "-" + hafta_42_gun_rkm + "/" + gun_tam_cizgili + "/" + Dktr_Ad_seçili_Id + "/" + liste_seçili + "'}",
                                contentType: 'application/json; charset=utf-8',
                                success: function (data) {


                                    if (data.d == "1") {
                                        alert("İşlem Başarılı!")
                                        Doktor_Tablo.append('<tr><td>' + Dktr_Ad_seçili.text() + '</td><td>' + unite_secili + '</td><td>' + branş_secili + '</td><td>' + brick_secili + '</td><td><span class="label label-waring">Ziyret bekleniyor</span></td></tr>')

                                        Doktor_Div = cont.find($('div[id=doktor_' + hafta_41_gun_rkm + ']'));
                                        Doktor_Tablo = Doktor_Div.children().children().children();
                                        Doktor_Tablo.append('<tr><td>' + Dktr_Ad_seçili.text() + '</td><td>' + unite_secili + '</td><td>' + branş_secili + '</td><td>' + brick_secili + '</td><td><span class="label label-waring">Ziyret bekleniyor</span></td></tr>')
                                        Doktor_Div = cont.find($('div[id=doktor_' + hafta_42_gun_rkm + ']'));
                                        Doktor_Tablo = Doktor_Div.children().children().children();
                                        Doktor_Tablo.append('<tr><td>' + Dktr_Ad_seçili.text() + '</td><td>' + unite_secili + '</td><td>' + branş_secili + '</td><td>' + brick_secili + '</td><td><span class="label label-waring">Ziyret bekleniyor</span></td></tr>')

                                    }
                                    if (data.d == "") {
                                        alert("Hata Lütfen Frekanslara Dikkat Ediniz!")
                                    }
                                    if (data.d == "0") {
                                        alert("Hata Lütfen Frekanslara Dikkat Ediniz!")
                                    }

                                },
                                error: function () {

                                    alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                                }
                            });
                        }
                        else if (dort_haftamı == "True") {

                            var Doktor_Div = cont.find($('div[id=doktor_' + Gun_Rkm + ']'));
                            var Doktor_Tablo = Doktor_Div.children().children().children();

                            $.ajax({
                                url: 'ddldeneme.aspx/Doktor_Db_Yaz_4_hafta',
                                dataType: 'json',
                                type: 'POST',
                                data: "{'parametre': '" + hafta_41_yıl_rkm + "-" + hafta_41_ay_rkm + "-" + hafta_41_gun_rkm + "/" + hafta_42_yıl_rkm + "-" + hafta_42_ay_rkm + "-" + hafta_42_gun_rkm + "/" + hafta_43_yıl_rkm + "-" + hafta_43_ay_rkm + "-" + hafta_43_gun_rkm + "/" + gun_tam_cizgili + "/" + Dktr_Ad_seçili_Id + "/" + liste_seçili + "'}",
                                contentType: 'application/json; charset=utf-8',
                                success: function (data) {


                                    if (data.d == "1") {
                                        alert("İşlem Başarılı!")
                                        Doktor_Tablo.append('<tr><td>' + Dktr_Ad_seçili.text() + '</td><td>' + unite_secili + '</td><td>' + branş_secili + '</td><td>' + brick_secili + '</td><td><span class="label label-waring">Ziyret bekleniyor</span></td></tr>')

                                        Doktor_Div = cont.find($('div[id=doktor_' + hafta_41_gun_rkm + ']'));
                                        Doktor_Tablo = Doktor_Div.children().children().children();
                                        Doktor_Tablo.append('<tr><td>' + Dktr_Ad_seçili.text() + '</td><td>' + unite_secili + '</td><td>' + branş_secili + '</td><td>' + brick_secili + '</td><td><span class="label label-waring">Ziyret bekleniyor</span></td></tr>')
                                        Doktor_Div = cont.find($('div[id=doktor_' + hafta_42_gun_rkm + ']'));
                                        Doktor_Tablo = Doktor_Div.children().children().children();
                                        Doktor_Tablo.append('<tr><td>' + Dktr_Ad_seçili.text() + '</td><td>' + unite_secili + '</td><td>' + branş_secili + '</td><td>' + brick_secili + '</td><td><span class="label label-waring">Ziyret bekleniyor</span></td></tr>')
                                        Doktor_Div = cont.find($('div[id=doktor_' + hafta_43_gun_rkm + ']'));
                                        Doktor_Tablo = Doktor_Div.children().children().children();
                                        Doktor_Tablo.append('<tr><td>' + Dktr_Ad_seçili.text() + '</td><td>' + unite_secili + '</td><td>' + branş_secili + '</td><td>' + brick_secili + '</td><td><span class="label label-waring">Ziyret bekleniyor</span></td></tr>')

                                    }
                                    if (data.d == "") {
                                        alert("Hata Lütfen Frekanslara Dikkat Ediniz!")
                                    }
                                    if (data.d == "0") {
                                        alert("Hata Lütfen Frekanslara Dikkat Ediniz!")
                                    }

                                },
                                error: function () {

                                    alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                                }
                            });
                        }












                    }




                    Dktr_Modal_Kaydet.unbind('click');
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
                    url: 'ddldeneme.aspx/OrnekPost',
                    dataType: 'json',
                    type: 'POST',
                    data: "{'parametre': '0-0'}",
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {
                        Dktr_Il.empty();
                        Dktr_Il.append("<option>-->> Lütfen Şehir Seçiniz <<--</option>")
                        var b = 0;
                        while (data.d.split('!')[b] != null) {

                            Dktr_Il.append("<option value='" + data.d.split('!')[b].split("-")[0] + "'>" + data.d.split('!')[b].split("-")[1] + "</option>");
                            b++;

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
                        url: 'ddldeneme.aspx/OrnekPost',
                        dataType: 'json',
                        type: 'POST',
                        data: "{'parametre': '1-" + $(this).val() + "'}",
                        contentType: 'application/json; charset=utf-8',
                        success: function (data) {
                            Dktr_Brick.empty();
                            Dktr_Brick.append("<option>-->> Lütfen Brick Seçiniz <<--</option>");
                            var b = 0;
                            while (data.d.split('!')[b] != null) {
                                Dktr_Brick.append("<option value='" + data.d.split('!')[b].split("-")[0] + "'>" + data.d.split('!')[b].split("-")[1] + "</option>");
                                b++;
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
                        url: 'ddldeneme.aspx/OrnekPost',
                        dataType: 'json',
                        type: 'POST',
                        data: "{'parametre': '2-" + $(this).val() + "'}",
                        contentType: 'application/json; charset=utf-8',
                        success: function (data) {
                            Dktr_Unite.empty();
                            Dktr_Unite.append("<option>-->> Lütfen Ünite Seçiniz <<--</option>");
                            var b = 0;
                            while (data.d.split('!')[b] != null) {

                                Dktr_Unite.append("<option value='" + data.d.split('!')[b].split("-")[0] + "'>" + data.d.split('!')[b].split("-")[1] + "</option>");
                                b++;
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
                })
                Dktr_Unite.change(function () {
                    Dktr_Unite.parent().removeAttr("class");
                    Dktr_Unite.parent().attr("class", "form-group");

                    $.ajax({
                        url: 'ddldeneme.aspx/OrnekPost',
                        dataType: 'json',
                        type: 'POST',
                        data: "{'parametre': '3-" + $(this).val() + "'}",
                        contentType: 'application/json; charset=utf-8',
                        success: function (data) {
                            Dktr_Brans.empty();
                            Dktr_Brans.append("<option>-->> Lütfen Branş Seçiniz <<--</option>");
                            var b = 0;
                            while (data.d.split('!')[b] != null) {


                                Dktr_Brans.append("<option value='" + data.d.split('!')[b].split("-")[0] + "'>" + data.d.split('!')[b].split("-")[1] + "</option>");
                                b++;

                            }
                            if (Dktr_Unite.parent().children().find($("select option:first-child")).html() == "--&gt;&gt; Lütfen Ünite Seçiniz &lt;&lt;--") {
                                Dktr_Unite.parent().children().find($("select option:first-child")).remove();
                            }
                        },
                        error: function () {

                            alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                        }
                    });

                })
                Dktr_Brans.change(function () {
                    Dktr_Brans.parent().removeAttr("class");
                    Dktr_Brans.parent().attr("class", "form-group");

                    $.ajax({
                        url: 'ddldeneme.aspx/OrnekPost',
                        dataType: 'json',
                        type: 'POST',
                        data: "{'parametre': '4-" + $(this).val() + "-" + Dktr_Liste.find('option:selected').attr('value') + "'}",
                        contentType: 'application/json; charset=utf-8',
                        success: function (data) {
                            Dktr_Ad.empty();
                            Dktr_Ad.append(" <option>-->> Lütfen Doktor Adı Seçiniz <<--</option>");

                            var b = 0;
                            while (data.d.split('!')[b] != null) {
                                Dktr_Ad.append("<option frekans=" + data.d.split('!')[b].split("-")[2] + " value='" + data.d.split('!')[b].split("-")[0] + "'>" + data.d.split('!')[b].split("-")[1] + "</option>");
                                b++;
                            }
                            if (Dktr_Brans.parent().children().find($("select option:first-child")).html() == "--&gt;&gt; Lütfen Branş Seçiniz &lt;&lt;--") {
                                Dktr_Brans.parent().children().find($("select option:first-child")).remove();
                            }
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

                var ayrık = $(this).closest($('div[id*=row]')).attr('ayrık');



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

                    Dktr_Brick.unbind();
                    Dktr_Unite.unbind();
                    Dktr_Brans.unbind();
                    Dktr_Ad.unbind();
                    Bilgi_Mesajı_ayrıkGun.attr('style', 'display: none');
                    Bilgi_Mesajı_Ilk_Tam_Hafta.attr('style', 'display: none');

                })

                var gun_tam_cizgili = $(bilgi).find($('[id=gun]')).attr('gun_tam_cizgili')
                var gun_tam = $(bilgi).find($('[id=gun]')).attr('gun_tam')


                var bilgi = $(this).closest($('div[Id*=bilgi]'));
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

                        for (var i = 0; i < data.d.split('/')[0].split('*').length; i++) {


                            if (data.d.split('/')[0].split('*')[i].split('-')[0] != gun_tam) {

                                Bilgi_Mesajı_Ilk_Tam_Hafta.removeAttr('style')
                                Bilgi_Mesajı_ayrıkGun.attr('style', 'display: none');

                                Ayrıkmı_kont = "True";
                                Doldur = "0";

                                continue;
                            }
                            else {

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

                function gundoldur() {
                    if (ayrık == "False") {

                        $.ajax({
                            url: 'ddldeneme.aspx/Frekans_modal_Doldurma',
                            dataType: 'json',
                            type: 'POST',
                            data: "{'parametre': '" + gun_tam_cizgili.split('-')[0] + "-" + gun_tam_cizgili.split('-')[1] + "'}",
                            contentType: 'application/json; charset=utf-8',
                            success: function (data) {


                                var Dokor_Modal = $('div[Id*=Doktor_Modal]');
                                var Dktr_Ad = $(Dokor_Modal).find($('select[Id*=Dktr_Ad]'));
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

                                        for (var i = 0; i < data.d.split('/')[3].split('*').length; i++) {
                                            hafta_41.append('<option Gun_Rkm=' + data.d.split('/')[1].split('*')[i].split('-')[0].split(' ')[0] + ' Ay_Rkm=' + data.d.split('/')[1].split('*')[i].split('-')[0].split(' ')[1] + ' Yıl_Rkm=' + data.d.split('/')[1].split('*')[i].split('-')[0].split(' ')[2] + ' >' + data.d.split('/')[1].split('*')[i].split('-')[1] + '</option>')
                                        }
                                        hafta_41_div.removeAttr('style')

                                        for (var i = 0; i < data.d.split('/')[3].split('*').length; i++) {
                                            hafta_42.append('<option Gun_Rkm=' + data.d.split('/')[2].split('*')[i].split('-')[0].split(' ')[0] + ' Ay_Rkm=' + data.d.split('/')[2].split('*')[i].split('-')[0].split(' ')[1] + ' Yıl_Rkm=' + data.d.split('/')[2].split('*')[i].split('-')[0].split(' ')[2] + ' >' + data.d.split('/')[2].split('*')[i].split('-')[1] + '</option>')
                                        }
                                        hafta_42_div.removeAttr('style')

                                        for (var i = 0; i < data.d.split('/')[3].split('*').length; i++) {
                                            hafta_43.append('<option Gun_Rkm=' + data.d.split('/')[3].split('*')[i].split('-')[0].split(' ')[0] + ' Ay_Rkm=' + data.d.split('/')[3].split('*')[i].split('-')[0].split(' ')[1] + ' Yıl_Rkm=' + data.d.split('/')[3].split('*')[i].split('-')[0].split(' ')[2] + ' >' + data.d.split('/')[3].split('*')[i].split('-')[1] + '</option>')
                                        }
                                        hafta_43_div.removeAttr('style')
                                        hafta_21_div.attr('style', 'display: none');

                                    }
                                    if (data.d.split('/').length == 3) {//style="display: none;"  Bilgi_Mesajı
                                        uc_haftamı = "True"
                                        Bilgi_Mesajı.removeAttr('style')

                                        for (var i = 0; i < data.d.split('/')[1].split('*').length - 1; i++) {
                                            hafta_41.append('<option Gun_Rkm=' + data.d.split('/')[1].split('*')[i].split('-')[0].split(' ')[0] + ' Ay_Rkm=' + data.d.split('/')[1].split('*')[i].split('-')[0].split(' ')[1] + ' Yıl_Rkm=' + data.d.split('/')[1].split('*')[i].split('-')[0].split(' ')[2] + ' >' + data.d.split('/')[1].split('*')[i].split('-')[1] + '</option>')
                                        }
                                        hafta_41_div.removeAttr('style')

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

        });

    </script>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
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
                            <select id="Eczane_frekans_4_1" class="form-control">
                            </select>
                        </div>
                        <div class="form-group" id="Eczane_frekans_4_2_div" style="display: none;">
                            <label>3. Haftanın Kaçıncı Gününe eklensin</label>
                            <select id="Eczane_frekans_4_2" class="form-control">
                            </select>
                        </div>
                        <div class="form-group" id="Eczane_frekans_4_3_div" style="display: none;">
                            <label>4. Haftanın Kaçıncı Gününe eklensin</label>
                            <select id="Eczane_frekans_4_3" class="form-control">
                            </select>
                        </div>


                    </div>

                </div>
                <div class="modal-footer">
                    <button id="Eczane_Ekle" type="button" class="btn btn-info" data-dismiss="modal">Ekle</button>
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
                        <div id="Bilgi_Mesajı" class="alert alert-info alert-dismissible" style="display: none">
                            <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
                            <h4><i class="icon fa fa-info"></i>Bilgi!</h4>
                            İşlem yaptığınız ayda 3 tam hafta olduğundan dolayı 4 frekansı olan doktorların 1 ziyareti eksik kalacaktır lütfen ayrık günleri kontrol ederek kalan ziyaretlerini doldurunuz.(Ayrık Gün; Ayın Tam haftaları dışında kalan günleridir )
                        </div>
                        <div id="Bilgi_Mesajı_ayrıkGun" class="alert alert-info alert-dismissible" style="display: none">
                            <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
                            <h4><i class="icon fa fa-info"></i>Bilgi!</h4>
                            İşlem yapmak İstediğiniz gün 'Ayrık Gün' olduğu için çoklu yerleştirme açılmadı  (Ayrık Gün; Ayın Tam haftaları dışında kalan günleridir)
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
                            <select id="frekans_4_1" class="form-control">
                            </select>
                        </div>
                        <div class="form-group" id="frekans_4_2_div" style="display: none;">
                            <label>3. Tam Hafta</label>
                            <select id="frekans_4_2" class="form-control">
                            </select>
                        </div>
                        <div class="form-group" id="frekans_4_3_div" style="display: none;">
                            <label>4. Tam Hafta</label>
                            <select id="frekans_4_3" class="form-control">
                            </select>
                        </div>


                    </div>

                </div>
                <div class="modal-footer">
                    <button id="Ekle" type="button" class="btn btn-info" data-dismiss="modal">Ekle</button>
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

        <div class="col-xs-6 ">
            <div class="form-group">
                <input id="Doktor_Frekans_Sıralama" data-toggle="modal" data-target="#Doktor_Frekans_Kontrol" type="button" class="btn btn-block btn-info btn-lg" value="Doktor Frekans Kontrolü" />
            </div>
        </div>
        <div class="col-xs-6 ">
            <div class="form-group">
                <input id="Eczane_Frekans_Sıralama" data-toggle="modal" data-target="#Eczane_Frekans_Kontrol" type="button" class="btn btn-block btn-info btn-lg" value="Eczane Frekans Kontrolü" />
            </div>
        </div>


    </div>



    <asp:Repeater ID="Repeater1" runat="server">
        <ItemTemplate>
            <div id="row" ayrık="<%#Ayrıkmı(Eval("Ziy_Tar","{0:d-M-yyyy}").ToString()) %>" class="row">
                <div id="bilgi" class="col-lg-12 ">
                    <div class="box box-default collapsed-box box-solid ">
                        <div class="box-header with-border  bg-blue-gradient">

                            <span id="gun" gun_tam_cizgili="<%#Eval("Ziy_Tar","{0:yyyy-M-d}")%>" gun_tam="<%#Eval("Ziy_Tar","{0:d M yyyy}")%>" name="<%#Eval("Ziy_Tar","{0:dddddddd}") %>" class="col-xs-1" style="font-size: 50px; color: #1e1b1b"><%#Eval("Ziy_Tar","{0:%d}") %></span>
                            <span id="ay_yıl" class="col-xs-1" style="font-size: 22px; color: #1e1b1b"><%#Eval("Ziy_Tar","{0:% MMMM}") %></br><%#Eval("Ziy_Tar","{0:% yyyy}") %></span>
                            <span class="col-xs-3" style="font-size: 12px;"></span>
                            <span class="col-xs-3" style="font-size: 20px;">Eczane: <%#Eval("Ziy_Edilecek_Eczane") %>
                                <br />
                                Doktor: <%#Eval("Ziy_Edilecek_Doktor") %>
                                <br />
                                <br />


                            </span>
                            <span id="Gun_txt" class="col-xs-1" style="font-size: 20px">&nbsp;<%#Eval("Ziy_Tar","{0:dddddddd}") %></span>
                            <span id="Ay_int" class="col-xs-1" style="font-size: 20px; display: none;"><%#Eval("Ziy_Tar","{0:%M}") %></span>

                            <div class="box-tools ">

                                <button type="button" class=" btn-primary no-border bg-blue-gradient" data-widget="collapse" style="font-size: 50px">

                                    <i class="fa fa-plus"></i>
                                </button>
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
                                        </tr>




                                    </tbody>
                                </table>
                                <a class="btn btn-info pull-right" id="btn_addtocart_Doktor" data-toggle="modal" data-target="#Doktor_Modal">Ziyaret Düzenle</a>
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
                                                <th>Ziyaret Durumu</th>
                                            </tr>

                                        </tbody>
                                    </table>

                                </div>

                            </div>
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="form-group">
                                        <a class="btn btn-info pull-right" id="btn_addtocart_Eczane" data-toggle="modal" data-target="#Eczane_Modal">Ziyaret Düzenle</a>
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
