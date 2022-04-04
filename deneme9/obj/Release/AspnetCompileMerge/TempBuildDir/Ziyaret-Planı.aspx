 <%@ Page Title="" Language="C#" MasterPageFile="~/admin.Master" AutoEventWireup="true" CodeBehind="Ziyaret-Planı.aspx.cs" Inherits="deneme9.Ziyaret_Planı" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        $(document).ready(function () {
            var mName = ["Ocak", "Subat", "Mart", "Nisan", "Mayis", "Haziran", "Temmuz", "Agustos", "Eylul", "Ekim", "Kasim", "Aralik"];

            // (G1) DATE NOW
            var now = new Date(),
                nowMth = now.getMonth(),
                nowYear = parseInt(now.getFullYear());


            // (G2) APPEND MONTHS SELECTOR
            var month = $('select[id=calmth]')


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

            $('input[id*=cal_set]').click(function () {
                var calyr = $('select[id=calyr]');
                var calmth = $('select[id=calmth]')
                window.location.href = "/Ziyaret-Planı.aspx?x=" + calyr.val() + "-" + calmth.val()

            });



            var btn_addtocart_Eczane = $('a[id=btn_addtocart_Eczane]')
            btn_addtocart_Eczane.click(function () {


                var ayrık = $(this).closest($('div[ayrık=true]'));

                var bilgi = $(this).closest($('div[Id*=bilgi]'));
                var Gun_Rkm = $(bilgi).find($('[id*=gun]')).html().replace(/\&nbsp;/g, ' ');
                var Gun_Txt = $(bilgi).find($('[id*=Gun_txt]')).html().replace(/\&nbsp;/g, ' ');
                var Ay_Yıl_Txt = $(bilgi).find($('[id*=ay_yıl]')).html().replace(/\&nbsp;/g, ' ').replace('<br>', ' ').split(' ');//1 ay 3 yıl


                var Dktr_modal_bslk = $('h4[Id=Eczane_modal_bslk]')
                Dktr_modal_bslk.empty();
                Dktr_modal_bslk.append(Gun_Rkm + " " + Ay_Yıl_Txt[1] + " " + Gun_Txt);




                $('button[id=Eczane_Ekle]').attr('Gün', $(this).attr('gun_tam_cizgili'))
                $('#Eczane_Modal').modal('show');



            });


            var btn_addtocart_Doktor = $('a[id=btn_addtocart_Doktor]')
            btn_addtocart_Doktor.click(function () {


                var ayrık = $(this).closest($('div[ayrık=true]'));

                var bilgi = $(this).closest($('div[Id*=bilgi]'));
                var Gun_Rkm = $(bilgi).find($('[id*=gun]')).html().replace(/\&nbsp;/g, ' ');
                var Gun_Txt = $(bilgi).find($('[id*=Gun_txt]')).html().replace(/\&nbsp;/g, ' ');
                var Ay_Yıl_Txt = $(bilgi).find($('[id*=ay_yıl]')).html().replace(/\&nbsp;/g, ' ').replace('<br>', ' ').split(' ');//1 ay 3 yıl
              

                var Dktr_modal_bslk = $('h4[Id=Dktr_modal_bslk]')
                Dktr_modal_bslk.empty();
                Dktr_modal_bslk.append(Gun_Rkm + " " + Ay_Yıl_Txt[1] + " " + Gun_Txt);


                



                $('button[id=Ekle]').attr('Gün', $(this).attr('gun_tam_cizgili'))
                $('#Doktor_Modal').modal('show');


               

            });


            //#region Eczane Arama

            var Dktr_Il = $('select[Id=Eczane_Il]');
            var Dktr_Brick = $('select[Id=Eczane_brick]');
            var Dktr_Brans = $('select[Id=Dktr_Brans]');
            var Dktr_Ad = $('select[Id=Eczane_Ad]');
            var Dktr_Liste = $('select[Id=Eczane_Liste]');


            $.ajax({
                url: 'ddldeneme.aspx/Yeni_Liste_Olustur_Listeler_Eczane', //doktorları listelerken tersten listele 
                dataType: 'json',
                type: 'POST',
                async: true,
                data: "{'parametre': '" + "0" + "-0'}",//liste cinsini de yolla o gördüğün 0 liste cinsi
                contentType: 'application/json; charset=utf-8',
                success: function (data) {
                    var Dktr_Liste = $('select[Id=Eczane_Liste]');
                    Dktr_Liste.empty();

                    var b = 0;
                    while (data.d.split('!')[b] != null) {

                        Dktr_Liste.append("<option value='" + data.d.split('!')[b].split("-")[0] + "'>" + data.d.split('!')[b].split("-")[1] + "</option>");
                        b++;
                    }
                }
            });


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
                    data: "{'parametre': '5-" + $(this).val() + "-" + Dktr_Liste.find('option:selected').val() + "'}",
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {

                        Dktr_Ad.empty();
                        Dktr_Ad.append("<option>-->> Lütfen Eczane Adı Seçiniz <<--</option>");
                        var b = 0;
                        while (data.d.split('!')[b] != null) {

                            Dktr_Ad.append("<option frekans='" + data.d.split('!')[b].split("-")[1] + "' value='" + data.d.split('!')[b].split("-")[0] + "'>" + data.d.split('!')[b].split("-")[2] + "</option>");
                            b++;
                        }
                        if (Dktr_Brick.parent().children().find($("select option:first-child")).html() == "--&gt;&gt; Lütfen Brick Seçiniz &lt;&lt;--") {
                            Dktr_Brick.parent().children().find($("select option:first-child")).remove();
                        }
                        var hafta_21_div = $('div[Id=frekans_2_1_div]');

                        var hafta_41_div = $('div[Id=frekans_4_1_div]');

                        var hafta_42_div = $('div[Id=frekans_4_2_div]');

                        var hafta_43_div = $('div[Id=frekans_4_3_div]');

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


            var Bilgi_Mesajı = $('div[id=Eczane_Bilgi_Mesajı]');//Bilgi_Mesajı_ayrıkGun
            Bilgi_Mesajı.attr('style', 'display: none');

            var Bilgi_Mesajı_ayrıkGun = $('div[id=Eczane_Bilgi_Mesajı_ayrıkGun]');
            Bilgi_Mesajı_ayrıkGun.attr('style', 'display: none');


            var hafta_21_div = $('div[Id=Eczane_frekans_2_1_div]');
            hafta_21_div.attr('style', 'display: none');
            var hafta_41_div = $('div[Id=Eczane_frekans_4_1_div]');
            hafta_41_div.attr('style', 'display: none');
            var hafta_42_div = $('div[Id=Eczane_frekans_4_2_div]');
            hafta_42_div.attr('style', 'display: none');
            var hafta_43_div =$('div[Id=Eczane_frekans_4_3_div]');
            hafta_43_div.attr('style', 'display: none');
            var hafta_21 = $('select[Id=Eczane_frekans_2_1]');
            hafta_21.empty();
            var hafta_41 =$('select[Id=Eczane_frekans_4_1]');
            hafta_41.empty();
            var hafta_42 = $('select[Id=Eczane_frekans_4_2]');
            hafta_42.empty();
            var hafta_43 = $('select[Id=Eczane_frekans_4_3]');
            hafta_43.empty();

            var Ekle = $('button[id=Eczane_Ekle]')

            var ayrık = Ekle.closest($('div[id*=row]')).attr('ayrık');

            var bilgi = $("a[id*=btn_addtocart_Eczane]").closest($('div[Id*=bilgi]'))

            var gun_tam = $(bilgi).find($('[id=gun]')).attr('gun_tam')//Bilgi_Mesajı_Ilk_Tam_Hafta
            var Bilgi_Mesajı_Ilk_Tam_Hafta = $('div[id=Eczane_Bilgi_Mesajı_Ilk_Tam_Hafta]')
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
                    var Dokor_Modal = $('div[Id*=Eczane_Modal]');

                    var hafta_21_div = $('div[Id=Eczane_frekans_2_1_div]');

                    var hafta_41_div = $('div[Id=Eczane_frekans_4_1_div]');

                    var hafta_42_div = $('div[Id=Eczane_frekans_4_2_div]');

                    var hafta_43_div = $('div[Id=Eczane_frekans_4_3_div]');

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

                }

            };






            //#endregion

            //#region Doktor Arama

            var Dktr_Il = $('select[Id=Dktr_Il]');
            var Dktr_Brick = $('select[Id=Dktr_brick]');
            var Dktr_Unite = $('select[Id=Dktr_Unite]');
            var Dktr_Brans = $('select[Id=Dktr_Brans]');
            var Dktr_Ad = $('select[Id=Dktr_Ad]');
            var Dktr_Liste = $('select[Id=Dktr_Liste]');


            $.ajax({
                url: 'ddldeneme.aspx/Yeni_Liste_Olustur_Listeler', //doktorları listelerken tersten listele 
                dataType: 'json',
                type: 'POST',
                async: true,
                data: "{'parametre': '" + "0" + "-0'}",//liste cinsini de yolla o gördüğün 0 liste cinsi
                contentType: 'application/json; charset=utf-8',
                success: function (data) {
                    var Dktr_Liste = $('select[Id=Dktr_Liste]');
                    Dktr_Liste.empty();

                    var b = 0;
                    while (data.d.split('!')[b] != null) {

                        Dktr_Liste.append("<option value='" + data.d.split('!')[b].split("-")[0] + "'>" + data.d.split('!')[b].split("-")[1] + "</option>");
                        b++;
                    }
                }
            });


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
            });
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
            });
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

            });
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


                        var hafta_21_div = $('div[Id=frekans_2_1_div]');

                        var hafta_41_div = $('div[Id=frekans_4_1_div]');

                        var hafta_42_div = $('div[Id=frekans_4_2_div]');

                        var hafta_43_div = $('div[Id=frekans_4_3_div]');

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

            //#endregion


            var gun_tam_cizgili = year.find('option:selected').val() + "-" + month.find('option:selected').val()

            //var x = $('*#example').dataTable({
            //    "bPaginate": false,
            //    "bLengthChange": false,
            //    "bFilter": true,
            //    "bInfo": false,
            //    "bAutoWidth": false,
            //    "language": {
            //        "url": "//cdn.datatables.net/plug-ins/1.10.22/i18n/Turkish.json"
            //    }, 
            //});


            //$.ajax({
            //    url: 'Ziyaret-Planı.aspx/Frekans_modal_Doldurma',
            //    dataType: 'json',
            //    type: 'POST',
            //    async: false,
            //    data: "{'parametre': '" + gun_tam_cizgili.split('-')[0] + "-" + gun_tam_cizgili.split('-')[1] + "'}",
            //    contentType: 'application/json; charset=utf-8',
            //    success: function (data) {
            //        var temp=JSON.parse(data.d)
            //        console.log(temp)

            //    },
            //    error: function () {

            //        alert('Talep esnasında sorun oluştu.Yeniden deneyin');

            //    }
            //});

            var Ekle = $('button[id=Ekle]')
            Ekle.click(function () {
                var Doktor_Liste = [];

                var Doktor_Liste_Tablo = {
                    Doktor_Id_: null,
                    Ziy_Tar_: null,
                }
                Doktor_Liste_Tablo.Doktor_Id_ = '2055';
                Doktor_Liste_Tablo.Ziy_Tar_ = '2021-05-01';
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
            })



            var Eczane_Liste = [];

            var Eczane_Liste_Tablo = {
                Eczane_Id_: null,
                Ziy_Tar_: null,
            }
            Eczane_Liste_Tablo.Eczane_Id_ = '56548';
            Eczane_Liste_Tablo.Ziy_Tar_ = '2021-05-01';
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
                        <div class="form-group">
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
                    <button id="Ekle" type="button" class="btn btn-info">Ekle</button>
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
                            <span id="Header_Gun_span_<%#Eval("Ziy_Tar","{0:%d}") %>" class="col-xs-3" style="font-size: 20px;"></span>
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
                                            <th>Kaldır</th>
                                        </tr>


                                        <tr>
                                            <td style="text-align: center; background-color: #f9f9f9;" colspan="6">Tabloda herhangi bir veri mevcut değil </td>
                                        </tr>


                                    </tbody>
                                </table>
                                <a class="btn btn-info pull-right" id="btn_addtocart_Doktor"  gun_tam_cizgili="<%#Eval("Ziy_Tar","{0:yyyy-M-d}")%>">Ziyaret Düzenle</a>
                            </div>
                        </div>



                        <div id="eczane_<%#Eval("Ziy_Tar","{0:%d}") %>" class="box-body">
                            <label>Ziyaret Edilecek Eczane Listesi</label>

                            <div class="box">
                                <div class="form-group">
                                    <table id="example" class="table table-hover">
                                        <tbody>
                                            <tr>
                                                <th>Eczane Adı</th>
                                                <th>İl</th>
                                                <th>Brick</th>
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
                                        <a class="btn btn-info pull-right" id="btn_addtocart_Eczane"  gun_tam_cizgili="<%#Eval("Ziy_Tar","{0:yyyy-M-d}")%>">Ziyaret Düzenle</a>
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
